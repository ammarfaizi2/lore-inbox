Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWJWEOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWJWEOZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 00:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWJWEOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 00:14:24 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:44418 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1751449AbWJWEOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 00:14:23 -0400
Subject: [PATCH] Use extents for recording what swap is allocated.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 14:14:17 +1000
Message-Id: <1161576857.3466.9.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Switch from bitmaps to using extents to record what swap is allocated;
they make more efficient use of memory, particularly where the allocated
storage is small and the swap space is large.
    
This is also part of the ground work for implementing support for
supporting multiple swap devices.
    
Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

diff --git a/kernel/power/Makefile b/kernel/power/Makefile
index 38725f5..d772521 100644
--- a/kernel/power/Makefile
+++ b/kernel/power/Makefile
@@ -5,6 +5,6 @@ endif
 
 obj-y				:= main.o process.o console.o
 obj-$(CONFIG_PM_LEGACY)		+= pm.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o snapshot.o swap.o user.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o snapshot.o swap.o user.o extent.o
 
 obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
diff --git a/kernel/power/extent.c b/kernel/power/extent.c
new file mode 100644
index 0000000..b769956
--- /dev/null
+++ b/kernel/power/extent.c
@@ -0,0 +1,119 @@
+/* 
+ * kernel/power/extent.c
+ * 
+ * Copyright (C) 2003-2006 Nigel Cunningham <nigel@suspend2.net>
+ * Copyright (C) 2006 Red Hat, inc.
+ *
+ * Distributed under GPLv2.
+ * 
+ * These functions encapsulate the manipulation of storage metadata.
+ */
+
+#include <linux/suspend.h>
+#include "extent.h"
+
+/* suspend_get_extent
+ *
+ * Returns a free extent. May fail, returning NULL instead.
+ */
+static struct extent *suspend_get_extent(void)
+{
+	struct extent *result;
+	
+	if (!(result = kmalloc(sizeof(struct extent), GFP_ATOMIC)))
+		return NULL;
+
+	result->minimum = result->maximum = 0;
+	result->next = NULL;
+
+	return result;
+}
+
+/* suspend_put_extent_chain.
+ *
+ * Frees a whole chain of extents.
+ */
+void suspend_put_extent_chain(struct extent_chain *chain)
+{
+	struct extent *this;
+
+	this = chain->first;
+
+	while(this) {
+		struct extent *next = this->next;
+		kfree(this);
+		chain->num_extents--;
+		this = next;
+	}
+	
+	BUG_ON(chain->num_extents);
+	chain->first = chain->last_touched = NULL;
+	chain->size = 0;
+}
+
+/* 
+ * suspend_add_to_extent_chain
+ *
+ * Add an extent to an existing chain.
+ */
+int suspend_add_to_extent_chain(struct extent_chain *chain, 
+		unsigned long minimum, unsigned long maximum)
+{
+	struct extent *new_extent = NULL, *start_at;
+
+	/* Find the right place in the chain */
+	start_at = (chain->last_touched && 
+		    (chain->last_touched->minimum < minimum)) ?
+		chain->last_touched : NULL;
+
+	if (!start_at && chain->first && chain->first->minimum < minimum)
+		start_at = chain->first;
+
+	while (start_at && start_at->next && start_at->next->minimum < minimum)
+		start_at = start_at->next;
+
+	if (start_at && start_at->maximum == (minimum - 1)) {
+		start_at->maximum = maximum;
+
+		/* Merge with the following one? */
+		if (start_at->next &&
+		    start_at->maximum + 1 == start_at->next->minimum) {
+			struct extent *to_free = start_at->next;
+			start_at->maximum = start_at->next->maximum;
+			start_at->next = start_at->next->next;
+			chain->num_extents--;
+			kfree(to_free);
+		}
+
+		chain->last_touched = start_at;
+		chain->size+= (maximum - minimum + 1);
+
+		return 0;
+	}
+
+	new_extent = suspend_get_extent();
+	if (!new_extent) {
+		printk("Error unable to append a new extent to the chain.\n");
+		return 2;
+	}
+
+	chain->num_extents++;
+	chain->size+= (maximum - minimum + 1);
+	new_extent->minimum = minimum;
+	new_extent->maximum = maximum;
+	new_extent->next = NULL;
+
+	chain->last_touched = new_extent;
+
+	if (start_at) {
+		struct extent *next = start_at->next;
+		start_at->next = new_extent;
+		new_extent->next = next;
+	} else {
+		if (chain->first)
+			new_extent->next = chain->first;
+		chain->first = new_extent;
+	}
+
+	return 0;
+}
diff --git a/kernel/power/extent.h b/kernel/power/extent.h
new file mode 100644
index 0000000..062b4c1
--- /dev/null
+++ b/kernel/power/extent.h
@@ -0,0 +1,50 @@
+/*
+ * kernel/power/extent.h
+ *
+ * Copyright (C) 2004-2006 Nigel Cunningham <nigel@suspend2.net>
+ * Copyright (C) 2006 Red Hat, inc.
+ *
+ * This file is released under the GPLv2.
+ *
+ * It contains declarations related to extents. Extents are
+ * suspend's method of storing some of the metadata for the image.
+ * See extent.c for more info.
+ *
+ */
+
+#ifndef EXTENT_H
+#define EXTENT_H
+
+struct extent {
+	unsigned long minimum, maximum;
+	struct extent *next;
+};
+
+struct extent_chain {
+	int size; /* size of the chain ie sum (max-min+1) */
+	int num_extents;
+	struct extent *first, *last_touched;
+};
+
+/* Simplify iterating through all the values in an extent chain */
+#define suspend_extent_for_each(extent_chain, extentpointer, value) \
+if ((extent_chain)->first) \
+	for ((extentpointer) = (extent_chain)->first, (value) = \
+			(extentpointer)->minimum; \
+	     ((extentpointer) && ((extentpointer)->next || (value) <= \
+				 (extentpointer)->maximum)); \
+	     (((value) == (extentpointer)->maximum) ? \
+		((extentpointer) = (extentpointer)->next, (value) = \
+		 ((extentpointer) ? (extentpointer)->minimum : 0)) : \
+			(value)++))
+
+void suspend_put_extent_chain(struct extent_chain *chain);
+int suspend_add_to_extent_chain(struct extent_chain *chain, 
+		unsigned long minimum, unsigned long maximum);
+
+/* swap_entry_to_extent_val & extent_val_to_swap_entry: 
+ * We are putting offset in the low bits so consecutive swap entries
+ * make consecutive extent values */
+#define swap_entry_to_extent_val(swp_entry) (swp_entry.val)
+#define extent_val_to_swap_entry(val) (swp_entry_t) { (val) }
+#endif
diff --git a/kernel/power/power.h b/kernel/power/power.h
index bfe999f..a78c391 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -1,6 +1,8 @@
 #include <linux/suspend.h>
 #include <linux/utsname.h>
 
+#include "extent.h"
+
 struct swsusp_info {
 	struct new_utsname	uts;
 	u32			version_code;
@@ -119,30 +121,8 @@ #define SNAPSHOT_SET_SWAP_FILE		_IOW(SNA
 #define SNAPSHOT_S2RAM			_IO(SNAPSHOT_IOC_MAGIC, 11)
 #define SNAPSHOT_IOC_MAXNR	11
 
-/**
- *	The bitmap is used for tracing allocated swap pages
- *
- *	The entire bitmap consists of a number of bitmap_page
- *	structures linked with the help of the .next member.
- *	Thus each page can be allocated individually, so we only
- *	need to make 0-order memory allocations to create
- *	the bitmap.
- */
-
-#define BITMAP_PAGE_SIZE	(PAGE_SIZE - sizeof(void *))
-#define BITMAP_PAGE_CHUNKS	(BITMAP_PAGE_SIZE / sizeof(long))
-#define BITS_PER_CHUNK		(sizeof(long) * 8)
-#define BITMAP_PAGE_BITS	(BITMAP_PAGE_CHUNKS * BITS_PER_CHUNK)
-
-struct bitmap_page {
-	unsigned long		chunks[BITMAP_PAGE_CHUNKS];
-	struct bitmap_page	*next;
-};
-
-extern void free_bitmap(struct bitmap_page *bitmap);
-extern struct bitmap_page *alloc_bitmap(unsigned int nr_bits);
-extern unsigned long alloc_swap_page(int swap, struct bitmap_page *bitmap);
-extern void free_all_swap_pages(int swap, struct bitmap_page *bitmap);
+extern unsigned long alloc_swap_page(int swap, struct extent_chain *extents);
+extern void free_all_swap_pages(int swap, struct extent_chain *extents);
 
 extern int swsusp_check(void);
 extern int swsusp_shrink_memory(void);
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 1a3b0dd..fc713d5 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -152,7 +152,7 @@ struct swap_map_page {
 struct swap_map_handle {
 	struct swap_map_page *cur;
 	unsigned long cur_swap;
-	struct bitmap_page *bitmap;
+	struct extent_chain extents;
 	unsigned int k;
 };
 
@@ -161,9 +161,6 @@ static void release_swap_writer(struct s
 	if (handle->cur)
 		free_page((unsigned long)handle->cur);
 	handle->cur = NULL;
-	if (handle->bitmap)
-		free_bitmap(handle->bitmap);
-	handle->bitmap = NULL;
 }
 
 static void show_speed(struct timeval *start, struct timeval *stop,
@@ -191,12 +188,8 @@ static int get_swap_writer(struct swap_m
 	handle->cur = (struct swap_map_page *)get_zeroed_page(GFP_KERNEL);
 	if (!handle->cur)
 		return -ENOMEM;
-	handle->bitmap = alloc_bitmap(count_swap_pages(root_swap, 0));
-	if (!handle->bitmap) {
-		release_swap_writer(handle);
-		return -ENOMEM;
-	}
-	handle->cur_swap = alloc_swap_page(root_swap, handle->bitmap);
+	memset(&handle->extents, 0, sizeof(struct extent_chain));
+	handle->cur_swap = alloc_swap_page(root_swap, &handle->extents);
 	if (!handle->cur_swap) {
 		release_swap_writer(handle);
 		return -ENOSPC;
@@ -241,7 +234,7 @@ static int swap_write_page(struct swap_m
 
 	if (!handle->cur)
 		return -EINVAL;
-	offset = alloc_swap_page(root_swap, handle->bitmap);
+	offset = alloc_swap_page(root_swap, &handle->extents);
 	error = write_page(buf, offset, bio_chain);
 	if (error)
 		return error;
@@ -250,7 +243,7 @@ static int swap_write_page(struct swap_m
 		error = wait_on_bio_chain(bio_chain);
 		if (error)
 			goto out;
-		offset = alloc_swap_page(root_swap, handle->bitmap);
+		offset = alloc_swap_page(root_swap, &handle->extents);
 		if (!offset)
 			return -ENOSPC;
 		handle->cur->next_swap = offset;
@@ -379,7 +372,7 @@ int swsusp_write(void)
 		}
 	}
 	if (error)
-		free_all_swap_pages(root_swap, handle.bitmap);
+		free_all_swap_pages(root_swap, &handle.extents);
 	release_swap_writer(&handle);
 	return error;
 }
diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
index 0b66659..aa8205c 100644
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -51,6 +51,7 @@ #include <linux/syscalls.h>
 #include <linux/highmem.h>
 
 #include "power.h"
+#include "extent.h"
 
 /*
  * Preferred image size in bytes (tunable via /sys/power/image_size).
@@ -72,96 +73,30 @@ static inline int restore_highmem(void) 
 static inline unsigned int count_highmem_pages(void) { return 0; }
 #endif
 
-/**
- *	The following functions are used for tracing the allocated
- *	swap pages, so that they can be freed in case of an error.
- *
- *	The functions operate on a linked bitmap structure defined
- *	in power.h
- */
-
-void free_bitmap(struct bitmap_page *bitmap)
+unsigned long alloc_swap_page(int swap, struct extent_chain *extents)
 {
-	struct bitmap_page *bp;
-
-	while (bitmap) {
-		bp = bitmap->next;
-		free_page((unsigned long)bitmap);
-		bitmap = bp;
+	swp_entry_t entry = get_swap_page_of_type(swap);
+	if (entry.val) {
+		unsigned long new_value = swap_entry_to_extent_val(entry);
+		suspend_add_to_extent_chain(extents, new_value, new_value);
 	}
+	return swp_offset(entry);
 }
 
-struct bitmap_page *alloc_bitmap(unsigned int nr_bits)
+void free_all_swap_pages(int swap, struct extent_chain *extents)
 {
-	struct bitmap_page *bitmap, *bp;
-	unsigned int n;
-
-	if (!nr_bits)
-		return NULL;
-
-	bitmap = (struct bitmap_page *)get_zeroed_page(GFP_KERNEL);
-	bp = bitmap;
-	for (n = BITMAP_PAGE_BITS; n < nr_bits; n += BITMAP_PAGE_BITS) {
-		bp->next = (struct bitmap_page *)get_zeroed_page(GFP_KERNEL);
-		bp = bp->next;
-		if (!bp) {
-			free_bitmap(bitmap);
-			return NULL;
+	if (extents->first) {
+		/* Free swap entries */
+		struct extent *extentpointer;
+		unsigned long extentvalue;
+		swp_entry_t entry;
+		suspend_extent_for_each(extents, extentpointer, 
+				extentvalue) {
+			entry = extent_val_to_swap_entry(extentvalue);
+			swap_free(entry);
 		}
-	}
-	return bitmap;
-}
-
-static int bitmap_set(struct bitmap_page *bitmap, unsigned long bit)
-{
-	unsigned int n;
 
-	n = BITMAP_PAGE_BITS;
-	while (bitmap && n <= bit) {
-		n += BITMAP_PAGE_BITS;
-		bitmap = bitmap->next;
-	}
-	if (!bitmap)
-		return -EINVAL;
-	n -= BITMAP_PAGE_BITS;
-	bit -= n;
-	n = 0;
-	while (bit >= BITS_PER_CHUNK) {
-		bit -= BITS_PER_CHUNK;
-		n++;
-	}
-	bitmap->chunks[n] |= (1UL << bit);
-	return 0;
-}
-
-unsigned long alloc_swap_page(int swap, struct bitmap_page *bitmap)
-{
-	unsigned long offset;
-
-	offset = swp_offset(get_swap_page_of_type(swap));
-	if (offset) {
-		if (bitmap_set(bitmap, offset)) {
-			swap_free(swp_entry(swap, offset));
-			offset = 0;
-		}
-	}
-	return offset;
-}
-
-void free_all_swap_pages(int swap, struct bitmap_page *bitmap)
-{
-	unsigned int bit, n;
-	unsigned long test;
-
-	bit = 0;
-	while (bitmap) {
-		for (n = 0; n < BITMAP_PAGE_CHUNKS; n++)
-			for (test = 1UL; test; test <<= 1) {
-				if (bitmap->chunks[n] & test)
-					swap_free(swp_entry(swap, bit));
-				bit++;
-			}
-		bitmap = bitmap->next;
+		suspend_put_extent_chain(extents);
 	}
 }
 
diff --git a/kernel/power/user.c b/kernel/power/user.c
index 3653b22..79aa849 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -32,7 +32,7 @@ #define SNAPSHOT_MINOR	231
 static struct snapshot_data {
 	struct snapshot_handle handle;
 	int swap;
-	struct bitmap_page *bitmap;
+	struct extent_chain extents;
 	int mode;
 	char frozen;
 	char ready;
@@ -61,7 +61,7 @@ static int snapshot_open(struct inode *i
 		data->swap = -1;
 		data->mode = O_WRONLY;
 	}
-	data->bitmap = NULL;
+	memset(&data->extents, 0, sizeof(struct extent_chain));
 	data->frozen = 0;
 	data->ready = 0;
 
@@ -74,8 +74,7 @@ static int snapshot_release(struct inode
 
 	swsusp_free();
 	data = filp->private_data;
-	free_all_swap_pages(data->swap, data->bitmap);
-	free_bitmap(data->bitmap);
+	free_all_swap_pages(data->swap, &data->extents);
 	if (data->frozen) {
 		down(&pm_sem);
 		thaw_processes();
@@ -232,14 +231,7 @@ static int snapshot_ioctl(struct inode *
 			error = -ENODEV;
 			break;
 		}
-		if (!data->bitmap) {
-			data->bitmap = alloc_bitmap(count_swap_pages(data->swap, 0));
-			if (!data->bitmap) {
-				error = -ENOMEM;
-				break;
-			}
-		}
-		offset = alloc_swap_page(data->swap, data->bitmap);
+		offset = alloc_swap_page(data->swap, &data->extents);
 		if (offset) {
 			offset <<= PAGE_SHIFT;
 			error = put_user(offset, (loff_t __user *)arg);
@@ -253,13 +245,11 @@ static int snapshot_ioctl(struct inode *
 			error = -ENODEV;
 			break;
 		}
-		free_all_swap_pages(data->swap, data->bitmap);
-		free_bitmap(data->bitmap);
-		data->bitmap = NULL;
+		free_all_swap_pages(data->swap, &data->extents);
 		break;
 
 	case SNAPSHOT_SET_SWAP_FILE:
-		if (!data->bitmap) {
+		if (!data->extents.size) {
 			/*
 			 * User space encodes device types as two-byte values,
 			 * so we need to recode them


