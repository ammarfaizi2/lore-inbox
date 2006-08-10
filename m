Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161315AbWHJN2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161315AbWHJN2v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 09:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161312AbWHJN2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 09:28:51 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:60906 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161314AbWHJN1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 09:27:31 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 2/5] Change the name of pagedir_nosave
Date: Thu, 10 Aug 2006 15:16:06 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <200608101510.40544.rjw@sisk.pl>
In-Reply-To: <200608101510.40544.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608101516.06195.rjw@sisk.pl>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The name of the pagedir_nosave variable does not make sense any more, so it
seems reasonable to change it to something more meaningful.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 arch/i386/power/swsusp.S         |    2 +-
 arch/powerpc/kernel/swsusp_32.S  |    4 ++--
 arch/x86_64/kernel/suspend_asm.S |    2 +-
 kernel/power/power.h             |    2 --
 kernel/power/snapshot.c          |   26 ++++++++++++++------------
 5 files changed, 18 insertions(+), 18 deletions(-)

Index: linux-2.6.18-rc3-mm2/arch/i386/power/swsusp.S
===================================================================
--- linux-2.6.18-rc3-mm2.orig/arch/i386/power/swsusp.S	2006-08-10 08:17:13.000000000 +0200
+++ linux-2.6.18-rc3-mm2/arch/i386/power/swsusp.S	2006-08-10 08:17:31.000000000 +0200
@@ -32,7 +32,7 @@ ENTRY(swsusp_arch_resume)
 	movl	$swsusp_pg_dir-__PAGE_OFFSET, %ecx
 	movl	%ecx, %cr3
 
-	movl	pagedir_nosave, %edx
+	movl	restore_pblist, %edx
 	.p2align 4,,7
 
 copy_loop:
Index: linux-2.6.18-rc3-mm2/arch/powerpc/kernel/swsusp_32.S
===================================================================
--- linux-2.6.18-rc3-mm2.orig/arch/powerpc/kernel/swsusp_32.S	2006-08-10 08:17:13.000000000 +0200
+++ linux-2.6.18-rc3-mm2/arch/powerpc/kernel/swsusp_32.S	2006-08-10 08:17:31.000000000 +0200
@@ -159,8 +159,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	isync
 
 	/* Load ptr the list of pages to copy in r3 */
-	lis	r11,(pagedir_nosave - KERNELBASE)@h
-	ori	r11,r11,pagedir_nosave@l
+	lis	r11,(restore_pblist - KERNELBASE)@h
+	ori	r11,r11,restore_pblist@l
 	lwz	r10,0(r11)
 
 	/* Copy the pages. This is a very basic implementation, to
Index: linux-2.6.18-rc3-mm2/arch/x86_64/kernel/suspend_asm.S
===================================================================
--- linux-2.6.18-rc3-mm2.orig/arch/x86_64/kernel/suspend_asm.S	2006-08-10 08:17:13.000000000 +0200
+++ linux-2.6.18-rc3-mm2/arch/x86_64/kernel/suspend_asm.S	2006-08-10 08:17:31.000000000 +0200
@@ -54,7 +54,7 @@ ENTRY(restore_image)
 	movq	%rcx, %cr3;
 	movq	%rax, %cr4;  # turn PGE back on
 
-	movq	pagedir_nosave(%rip), %rdx
+	movq	restore_pblist(%rip), %rdx
 loop:
 	testq	%rdx, %rdx
 	jz	done
Index: linux-2.6.18-rc3-mm2/kernel/power/power.h
===================================================================
--- linux-2.6.18-rc3-mm2.orig/kernel/power/power.h	2006-08-10 08:17:13.000000000 +0200
+++ linux-2.6.18-rc3-mm2/kernel/power/power.h	2006-08-10 08:17:31.000000000 +0200
@@ -38,8 +38,6 @@ extern struct subsystem power_subsys;
 /* References to section boundaries */
 extern const void __nosave_begin, __nosave_end;
 
-extern struct pbe *pagedir_nosave;
-
 /* Preferred image size in bytes (default 500 MB) */
 extern unsigned long image_size;
 extern int in_suspend;
Index: linux-2.6.18-rc3-mm2/kernel/power/snapshot.c
===================================================================
--- linux-2.6.18-rc3-mm2.orig/kernel/power/snapshot.c	2006-08-10 08:17:21.000000000 +0200
+++ linux-2.6.18-rc3-mm2/kernel/power/snapshot.c	2006-08-10 08:17:44.000000000 +0200
@@ -34,7 +34,9 @@
 
 #include "power.h"
 
-struct pbe *pagedir_nosave;
+/* List of PBEs used for creating and restoring the suspend image */
+struct pbe *restore_pblist;
+
 static unsigned int nr_copy_pages;
 static unsigned int nr_meta_pages;
 static unsigned long *buffer;
@@ -415,7 +417,7 @@ void swsusp_free(void)
 	}
 	nr_copy_pages = 0;
 	nr_meta_pages = 0;
-	pagedir_nosave = NULL;
+	restore_pblist = NULL;
 	buffer = NULL;
 }
 
@@ -490,15 +492,15 @@ asmlinkage int swsusp_save(void)
 		return -ENOMEM;
 	}
 
-	pagedir_nosave = swsusp_alloc(nr_pages);
-	if (!pagedir_nosave)
+	restore_pblist = swsusp_alloc(nr_pages);
+	if (!restore_pblist)
 		return -ENOMEM;
 
 	/* During allocating of suspend pagedir, new cold pages may appear.
 	 * Kill them.
 	 */
 	drain_local_pages();
-	copy_data_pages(pagedir_nosave);
+	copy_data_pages(restore_pblist);
 
 	/*
 	 * End of critical section. From now on, we can write to memory,
@@ -580,13 +582,13 @@ int snapshot_read_next(struct snapshot_h
 	if (!handle->offset) {
 		init_header((struct swsusp_info *)buffer);
 		handle->buffer = buffer;
-		handle->pbe = pagedir_nosave;
+		handle->pbe = restore_pblist;
 	}
 	if (handle->prev < handle->cur) {
 		if (handle->cur <= nr_meta_pages) {
 			handle->pbe = pack_orig_addresses(buffer, handle->pbe);
 			if (!handle->pbe)
-				handle->pbe = pagedir_nosave;
+				handle->pbe = restore_pblist;
 		} else {
 			handle->buffer = (void *)handle->pbe->address;
 			handle->pbe = handle->pbe->next;
@@ -689,7 +691,7 @@ static int load_header(struct snapshot_h
 		pblist = alloc_pagedir(info->image_pages, GFP_ATOMIC, 0);
 		if (!pblist)
 			return -ENOMEM;
-		pagedir_nosave = pblist;
+		restore_pblist = pblist;
 		handle->pbe = pblist;
 		nr_copy_pages = info->image_pages;
 		nr_meta_pages = info->pages - info->image_pages - 1;
@@ -716,7 +718,7 @@ static inline struct pbe *unpack_orig_ad
 
 /**
  *	prepare_image - use metadata contained in the PBE list
- *	pointed to by pagedir_nosave to mark the pages that will
+ *	pointed to by restore_pblist to mark the pages that will
  *	be overwritten in the process of restoring the system
  *	memory state from the image ("unsafe" pages) and allocate
  *	memory for the image
@@ -741,7 +743,7 @@ static int prepare_image(struct snapshot
 	unsigned int nr_pages = nr_copy_pages;
 	struct pbe *p, *pblist = NULL;
 
-	p = pagedir_nosave;
+	p = restore_pblist;
 	error = mark_unsafe_pages(p);
 	if (!error) {
 		pblist = alloc_pagedir(nr_pages, GFP_ATOMIC, 1);
@@ -773,7 +775,7 @@ static int prepare_image(struct snapshot
 		}
 	}
 	if (!error) {
-		pagedir_nosave = pblist;
+		restore_pblist = pblist;
 	} else {
 		handle->pbe = NULL;
 		swsusp_free();
@@ -858,7 +860,7 @@ int snapshot_write_next(struct snapshot_
 				error = prepare_image(handle);
 				if (error)
 					return error;
-				handle->pbe = pagedir_nosave;
+				handle->pbe = restore_pblist;
 				handle->last_pbe = NULL;
 				handle->buffer = get_buffer(handle);
 				handle->sync_read = 0;

