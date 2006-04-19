Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbWDSRCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWDSRCU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWDSRCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:02:20 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:29667 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750942AbWDSRCT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:02:19 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm] swsusp: use less memory during resume
Date: Wed, 19 Apr 2006 19:01:25 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604191901.25485.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make swsusp allocate only as much memory as needed to store the image data
and metadata during resume.

Without this patch swsusp additionally allocates many page frames that will
conflict with the "original" locations of the image data and are considered
as "unsafe", treating them as "eaten" pages (ie. allocated but unusable).

The patch makes swsusp allocate as many pages as it'll need to store the
data read from the image in one shot, creating a list of allocated "safe"
pages, and use the observation that all pages allocated by it are marked with
the PG_nosave and PG_nosave_free flags set.  Namely, when it's about to load
an image page, swsusp can check whether the page frame corresponding to the
"original" location of this page has been allocated (ie. if the page frame has
the PG_nosave and PG_nosave_free flags set) and if so, it can load the page
directly into this page frame.  Otherwise it uses an allocated "safe" page
from the list to store the data that will be copied to their "original"
location later on.

This allows us to save many page copyings and page allocations during
resume and in the future it may allow us to load images greater than 50%
of the normal zone.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/power.h    |    2 
 kernel/power/snapshot.c |  141 ++++++++++++++++++++++++++++--------------------
 2 files changed, 85 insertions(+), 58 deletions(-)

Index: linux-2.6.17-rc1-mm3/kernel/power/power.h
===================================================================
--- linux-2.6.17-rc1-mm3.orig/kernel/power/power.h
+++ linux-2.6.17-rc1-mm3/kernel/power/power.h
@@ -55,7 +55,7 @@ struct snapshot_handle {
 	unsigned int	page;
 	unsigned int	page_offset;
 	unsigned int	prev;
-	struct pbe	*pbe;
+	struct pbe	*pbe, *last_pbe;
 	void		*buffer;
 	unsigned int	buf_offset;
 };
Index: linux-2.6.17-rc1-mm3/kernel/power/snapshot.c
===================================================================
--- linux-2.6.17-rc1-mm3.orig/kernel/power/snapshot.c
+++ linux-2.6.17-rc1-mm3/kernel/power/snapshot.c
@@ -391,62 +391,29 @@ static inline void create_pbe_list(struc
 	}
 }
 
-/**
- *	On resume it is necessary to trace and eventually free the unsafe
- *	pages that have been allocated, because they are needed for I/O
- *	(on x86-64 we likely will "eat" these pages once again while
- *	creating the temporary page translation tables)
- */
-
-struct eaten_page {
-	struct eaten_page *next;
-	char padding[PAGE_SIZE - sizeof(void *)];
-};
-
-static struct eaten_page *eaten_pages = NULL;
-
-static void release_eaten_pages(void)
-{
-	struct eaten_page *p, *q;
-
-	p = eaten_pages;
-	while (p) {
-		q = p->next;
-		/* We don't want swsusp_free() to free this page again */
-		ClearPageNosave(virt_to_page(p));
-		free_page((unsigned long)p);
-		p = q;
-	}
-	eaten_pages = NULL;
-}
+static unsigned int unsafe_pages;
 
 /**
  *	@safe_needed - on resume, for storing the PBE list and the image,
  *	we can only use memory pages that do not conflict with the pages
- *	which had been used before suspend.
+ *	used before suspend.
  *
  *	The unsafe pages are marked with the PG_nosave_free flag
- *
- *	Allocated but unusable (ie eaten) memory pages should be marked
- *	so that swsusp_free() can release them
+ *	and we count them using unsafe_pages
  */
 
 static inline void *alloc_image_page(gfp_t gfp_mask, int safe_needed)
 {
 	void *res;
 
+	res = (void *)get_zeroed_page(gfp_mask);
 	if (safe_needed)
-		do {
+		while (res && PageNosaveFree(virt_to_page(res))) {
+			/* The page is unsafe, mark it for swsusp_free() */
+			SetPageNosave(virt_to_page(res));
+			unsafe_pages++;
 			res = (void *)get_zeroed_page(gfp_mask);
-			if (res && PageNosaveFree(virt_to_page(res))) {
-				/* This is for swsusp_free() */
-				SetPageNosave(virt_to_page(res));
-				((struct eaten_page *)res)->next = eaten_pages;
-				eaten_pages = res;
-			}
-		} while (res && PageNosaveFree(virt_to_page(res)));
-	else
-		res = (void *)get_zeroed_page(gfp_mask);
+		}
 	if (res) {
 		SetPageNosave(virt_to_page(res));
 		SetPageNosaveFree(virt_to_page(res));
@@ -740,6 +707,8 @@ static int mark_unsafe_pages(struct pbe 
 			return -EFAULT;
 	}
 
+	unsafe_pages = 0;
+
 	return 0;
 }
 
@@ -817,42 +786,99 @@ static inline struct pbe *unpack_orig_ad
 }
 
 /**
- *	create_image - use metadata contained in the PBE list
+ *	prepare_image - use metadata contained in the PBE list
  *	pointed to by pagedir_nosave to mark the pages that will
  *	be overwritten in the process of restoring the system
- *	memory state from the image and allocate memory for
- *	the image avoiding these pages
+ *	memory state from the image ("unsafe" pages) and allocate
+ *	memory for the image
+ *
+ *	The idea is to allocate the PBE list first and then
+ *	allocate as many pages as it's needed for the image data,
+ *	but not to assign these pages to the PBEs initially.
+ *	Instead, we just mark them as allocated and create a list
+ *	of "safe" which will be used later
  */
 
-static int create_image(struct snapshot_handle *handle)
+struct safe_page {
+	struct safe_page *next;
+	char padding[PAGE_SIZE - sizeof(void *)];
+};
+
+static struct safe_page *safe_pages;
+
+static int prepare_image(struct snapshot_handle *handle)
 {
 	int error = 0;
-	struct pbe *p, *pblist;
+	unsigned int nr_pages = nr_copy_pages;
+	struct pbe *p, *pblist = NULL;
 
 	p = pagedir_nosave;
 	error = mark_unsafe_pages(p);
 	if (!error) {
-		pblist = alloc_pagedir(nr_copy_pages, GFP_ATOMIC, 1);
+		pblist = alloc_pagedir(nr_pages, GFP_ATOMIC, 1);
 		if (pblist)
 			copy_page_backup_list(pblist, p);
 		free_pagedir(p, 0);
 		if (!pblist)
 			error = -ENOMEM;
 	}
-	if (!error)
-		error = alloc_data_pages(pblist, GFP_ATOMIC, 1);
+	safe_pages = NULL;
+	if (!error && nr_pages > unsafe_pages) {
+		nr_pages -= unsafe_pages;
+		while (nr_pages--) {
+			struct safe_page *ptr;
+
+			ptr = (struct safe_page *)get_zeroed_page(GFP_ATOMIC);
+			if (!ptr) {
+				error = -ENOMEM;
+				break;
+			}
+			if (!PageNosaveFree(virt_to_page(ptr))) {
+				/* The page is "safe", add it to the list */
+				ptr->next = safe_pages;
+				safe_pages = ptr;
+			}
+			/* Mark the page as allocated */
+			SetPageNosave(virt_to_page(ptr));
+			SetPageNosaveFree(virt_to_page(ptr));
+		}
+	}
 	if (!error) {
-		release_eaten_pages();
 		pagedir_nosave = pblist;
 	} else {
-		pagedir_nosave = NULL;
 		handle->pbe = NULL;
-		nr_copy_pages = 0;
-		nr_meta_pages = 0;
+		swsusp_free();
 	}
 	return error;
 }
 
+static void *get_buffer(struct snapshot_handle *handle)
+{
+	struct pbe *pbe = handle->pbe, *last = handle->last_pbe;
+	struct page *page = virt_to_page(pbe->orig_address);
+
+	if (PageNosave(page) && PageNosaveFree(page)) {
+		/*
+		 * We have allocated the "original" page frame and we can
+		 * use it directly to store the read page
+		 */
+		pbe->address = 0;
+		if (last && last->next)
+			last->next = NULL;
+		return (void *)pbe->orig_address;
+	}
+	/*
+	 * The "original" page frame has not been allocated and we have to
+	 * use a "safe" page frame to store the read page
+	 */
+	pbe->address = (unsigned long)safe_pages;
+	safe_pages = safe_pages->next;
+	if (last)
+		last->next = pbe;
+	handle->last_pbe = pbe;
+	return (void *)pbe->address;
+}
+
 /**
  *	snapshot_write_next - used for writing the system memory snapshot.
  *
@@ -897,15 +923,16 @@ int snapshot_write_next(struct snapshot_
 		} else if (handle->prev <= nr_meta_pages) {
 			handle->pbe = unpack_orig_addresses(buffer, handle->pbe);
 			if (!handle->pbe) {
-				error = create_image(handle);
+				error = prepare_image(handle);
 				if (error)
 					return error;
 				handle->pbe = pagedir_nosave;
-				handle->buffer = (void *)handle->pbe->address;
+				handle->last_pbe = NULL;
+				handle->buffer = get_buffer(handle);
 			}
 		} else {
 			handle->pbe = handle->pbe->next;
-			handle->buffer = (void *)handle->pbe->address;
+			handle->buffer = get_buffer(handle);
 		}
 		handle->prev = handle->page;
 	}
