Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWAHRP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWAHRP4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 12:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752642AbWAHRPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 12:15:55 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:44946 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1752639AbWAHRPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 12:15:53 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 1/2] swsusp: low level interface (rev. 2)
Date: Sun, 8 Jan 2006 18:13:40 +0100
User-Agent: KMail/1.9
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
References: <200601081807.22740.rjw@sisk.pl>
In-Reply-To: <200601081807.22740.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200601081813.41256.rjw@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the low level interface that can be used for handling
the snapshot of the system memory by the in-kernel swap-writing/reading
code of swsusp and the userland interface code (to be introduced shortly).

It also changes the way in which swsusp records the allocated swap pages
and, consequently, simplifies the in-kernel swap-writing/reading code
(this is necessary for the userland interface too).  To this end, it introduces
two helper functions in mm/swapfile.c, so that the swsusp code does not
refer directly to the swap internals.


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 include/linux/swap.h    |    4 
 kernel/power/disk.c     |   12 
 kernel/power/power.h    |   25 +
 kernel/power/snapshot.c |  324 +++++++++++++++++++++
 kernel/power/swsusp.c   |  719 ++++++++++++++++--------------------------------
 mm/swapfile.c           |   53 +++
 6 files changed, 652 insertions(+), 485 deletions(-)

Index: linux-2.6.15-mm2/kernel/power/disk.c
===================================================================
--- linux-2.6.15-mm2.orig/kernel/power/disk.c	2006-01-08 12:52:20.000000000 +0100
+++ linux-2.6.15-mm2/kernel/power/disk.c	2006-01-08 12:52:45.000000000 +0100
@@ -27,9 +27,9 @@ extern suspend_disk_method_t pm_disk_mod
 
 extern int swsusp_shrink_memory(void);
 extern int swsusp_suspend(void);
-extern int swsusp_write(struct pbe *pblist, unsigned int nr_pages);
+extern int swsusp_write(void);
 extern int swsusp_check(void);
-extern int swsusp_read(struct pbe **pblist_ptr);
+extern int swsusp_read(void);
 extern void swsusp_close(void);
 extern int swsusp_resume(void);
 
@@ -71,10 +71,6 @@ static void power_down(suspend_disk_meth
 	while(1);
 }
 
-
-static int in_suspend __nosavedata = 0;
-
-
 static inline void platform_finish(void)
 {
 	if (pm_disk_mode == PM_DISK_PLATFORM) {
@@ -146,7 +142,7 @@ int pm_suspend_disk(void)
 	if (in_suspend) {
 		device_resume();
 		pr_debug("PM: writing image.\n");
-		error = swsusp_write(pagedir_nosave, nr_copy_pages);
+		error = swsusp_write();
 		if (!error)
 			power_down(pm_disk_mode);
 		else {
@@ -217,7 +213,7 @@ static int software_resume(void)
 
 	pr_debug("PM: Reading swsusp image.\n");
 
-	if ((error = swsusp_read(&pagedir_nosave))) {
+	if ((error = swsusp_read())) {
 		swsusp_free();
 		goto Thaw;
 	}
Index: linux-2.6.15-mm2/kernel/power/power.h
===================================================================
--- linux-2.6.15-mm2.orig/kernel/power/power.h	2006-01-08 12:52:20.000000000 +0100
+++ linux-2.6.15-mm2/kernel/power/power.h	2006-01-08 12:52:45.000000000 +0100
@@ -54,15 +54,26 @@ extern struct pbe *pagedir_nosave;
 /* Preferred image size in MB (default 500) */
 extern unsigned int image_size;
 
+extern int in_suspend;
+
 extern asmlinkage int swsusp_arch_suspend(void);
 extern asmlinkage int swsusp_arch_resume(void);
 
 extern unsigned int count_data_pages(void);
-extern void free_pagedir(struct pbe *pblist);
-extern void release_eaten_pages(void);
-extern struct pbe *alloc_pagedir(unsigned nr_pages, gfp_t gfp_mask, int safe_needed);
 extern void swsusp_free(void);
-extern int alloc_data_pages(struct pbe *pblist, gfp_t gfp_mask, int safe_needed);
-extern unsigned int snapshot_nr_pages(void);
-extern struct pbe *snapshot_pblist(void);
-extern void snapshot_pblist_set(struct pbe *pblist);
+
+struct snapshot_handle {
+	loff_t		offset;
+	unsigned int	page;
+	unsigned int	page_offset;
+	unsigned int	prev;
+	struct pbe	*pbe;
+	void		*buffer;
+	unsigned int	buf_offset;
+};
+
+#define data_of(handle)	((handle).buffer + (handle).buf_offset)
+
+extern int snapshot_read_next(struct snapshot_handle *handle, size_t count);
+extern int snapshot_write_next(struct snapshot_handle *handle, size_t count);
+int snapshot_image_loaded(struct snapshot_handle *handle);
Index: linux-2.6.15-mm2/kernel/power/swsusp.c
===================================================================
--- linux-2.6.15-mm2.orig/kernel/power/swsusp.c	2006-01-08 12:52:20.000000000 +0100
+++ linux-2.6.15-mm2/kernel/power/swsusp.c	2006-01-08 12:52:45.000000000 +0100
@@ -77,6 +77,8 @@
  */
 unsigned int image_size = 500;
 
+int in_suspend __nosavedata = 0;
+
 #ifdef CONFIG_HIGHMEM
 unsigned int count_highmem_pages(void);
 int save_highmem(void);
@@ -98,8 +100,6 @@ static struct swsusp_header {
 	char	sig[10];
 } __attribute__((packed, aligned(PAGE_SIZE))) swsusp_header;
 
-static struct swsusp_info swsusp_info;
-
 /*
  * Saving part...
  */
@@ -129,255 +129,261 @@ static int mark_swapfiles(swp_entry_t st
 	return error;
 }
 
-/*
- * Check whether the swap device is the specified resume
- * device, irrespective of whether they are specified by
- * identical names.
- *
- * (Thus, device inode aliasing is allowed.  You can say /dev/hda4
- * instead of /dev/ide/host0/bus0/target0/lun0/part4 [if using devfs]
- * and they'll be considered the same device.  This is *necessary* for
- * devfs, since the resume code can only recognize the form /dev/hda4,
- * but the suspend code would see the long name.)
+/**
+ *	swsusp_swap_check - check if the resume device is a swap device
+ *	and get its index (if so)
  */
-static inline int is_resume_device(const struct swap_info_struct *swap_info)
-{
-	struct file *file = swap_info->swap_file;
-	struct inode *inode = file->f_dentry->d_inode;
-
-	return S_ISBLK(inode->i_mode) &&
-		swsusp_resume_device == MKDEV(imajor(inode), iminor(inode));
-}
 
 static int swsusp_swap_check(void) /* This is called before saving image */
 {
-	int i;
+	int res = swap_type_of(swsusp_resume_device);
 
-	if (!swsusp_resume_device)
-		return -ENODEV;
-	spin_lock(&swap_lock);
-	for (i = 0; i < MAX_SWAPFILES; i++) {
-		if (!(swap_info[i].flags & SWP_WRITEOK))
-			continue;
-		if (is_resume_device(swap_info + i)) {
-			spin_unlock(&swap_lock);
-			root_swap = i;
-			return 0;
-		}
+	if (res >= 0) {
+		root_swap = res;
+		return 0;
 	}
-	spin_unlock(&swap_lock);
-	return -ENODEV;
+	return res;
 }
 
 /**
- *	write_page - Write one page to a fresh swap location.
- *	@addr:	Address we're writing.
- *	@loc:	Place to store the entry we used.
+ *	The bitmap is used for tracing allocated swap pages
  *
- *	Allocate a new swap entry and 'sync' it. Note we discard -EIO
- *	errors. That is an artifact left over from swsusp. It did not
- *	check the return of rw_swap_page_sync() at all, since most pages
- *	written back to swap would return -EIO.
- *	This is a partial improvement, since we will at least return other
- *	errors, though we need to eventually fix the damn code.
+ *	The entire bitmap consists of a number of bitmap_page
+ *	structures linked with the help of the .next member.
+ *	Thus each page can be allocated individually, so we only
+ *	need to make 0-order memory allocations to create
+ *	the bitmap.
  */
-static int write_page(unsigned long addr, swp_entry_t *loc)
-{
-	swp_entry_t entry;
-	int error = -ENOSPC;
 
-	entry = get_swap_page_of_type(root_swap);
-	if (swp_offset(entry)) {
-		error = rw_swap_page_sync(WRITE, entry, virt_to_page(addr));
-		if (!error || error == -EIO)
-			*loc = entry;
-	}
-	return error;
-}
+#define BITMAP_PAGE_SIZE	(PAGE_SIZE - sizeof(void *))
+#define BITMAP_PAGE_CHUNKS	(BITMAP_PAGE_SIZE / sizeof(long))
+#define BITS_PER_CHUNK		(sizeof(long) * 8)
+#define BITMAP_PAGE_BITS	(BITMAP_PAGE_CHUNKS * BITS_PER_CHUNK)
+
+struct bitmap_page {
+	unsigned long		chunks[BITMAP_PAGE_CHUNKS];
+	struct bitmap_page	*next;
+};
 
 /**
- *	Swap map-handling functions
- *
- *	The swap map is a data structure used for keeping track of each page
- *	written to the swap.  It consists of many swap_map_page structures
- *	that contain each an array of MAP_PAGE_SIZE swap entries.
- *	These structures are linked together with the help of either the
- *	.next (in memory) or the .next_swap (in swap) member.
- *
- *	The swap map is created during suspend.  At that time we need to keep
- *	it in memory, because we have to free all of the allocated swap
- *	entries if an error occurs.  The memory needed is preallocated
- *	so that we know in advance if there's enough of it.
- *
- *	The first swap_map_page structure is filled with the swap entries that
- *	correspond to the first MAP_PAGE_SIZE data pages written to swap and
- *	so on.  After the all of the data pages have been written, the order
- *	of the swap_map_page structures in the map is reversed so that they
- *	can be read from swap in the original order.  This causes the data
- *	pages to be loaded in exactly the same order in which they have been
- *	saved.
+ *	The following functions are used for tracing the allocated
+ *	swap pages, so that they can be freed in case of an error.
  *
- *	During resume we only need to use one swap_map_page structure
- *	at a time, which means that we only need to use two memory pages for
- *	reading the image - one for reading the swap_map_page structures
- *	and the second for reading the data pages from swap.
+ *	The functions operate on a linked bitmap structure defined
+ *	above
  */
 
-#define MAP_PAGE_SIZE	((PAGE_SIZE - sizeof(swp_entry_t) - sizeof(void *)) \
-			/ sizeof(swp_entry_t))
-
-struct swap_map_page {
-	swp_entry_t		entries[MAP_PAGE_SIZE];
-	swp_entry_t		next_swap;
-	struct swap_map_page	*next;
-};
-
-static inline void free_swap_map(struct swap_map_page *swap_map)
+static void free_bitmap(struct bitmap_page *bitmap)
 {
-	struct swap_map_page *swp;
+	struct bitmap_page *bp;
 
-	while (swap_map) {
-		swp = swap_map->next;
-		free_page((unsigned long)swap_map);
-		swap_map = swp;
+	while (bitmap) {
+		bp = bitmap->next;
+		free_page((unsigned long)bitmap);
+		bitmap = bp;
 	}
 }
 
-static struct swap_map_page *alloc_swap_map(unsigned int nr_pages)
+static struct bitmap_page *alloc_bitmap(unsigned int nr_bits)
 {
-	struct swap_map_page *swap_map, *swp;
-	unsigned n = 0;
+	struct bitmap_page *bitmap, *bp;
+	unsigned int n;
 
-	if (!nr_pages)
+	if (!nr_bits)
 		return NULL;
 
-	pr_debug("alloc_swap_map(): nr_pages = %d\n", nr_pages);
-	swap_map = (struct swap_map_page *)get_zeroed_page(GFP_ATOMIC);
-	swp = swap_map;
-	for (n = MAP_PAGE_SIZE; n < nr_pages; n += MAP_PAGE_SIZE) {
-		swp->next = (struct swap_map_page *)get_zeroed_page(GFP_ATOMIC);
-		swp = swp->next;
-		if (!swp) {
-			free_swap_map(swap_map);
+	bitmap = (struct bitmap_page *)get_zeroed_page(GFP_KERNEL);
+	bp = bitmap;
+	for (n = BITMAP_PAGE_BITS; n < nr_bits; n += BITMAP_PAGE_BITS) {
+		bp->next = (struct bitmap_page *)get_zeroed_page(GFP_KERNEL);
+		bp = bp->next;
+		if (!bp) {
+			free_bitmap(bitmap);
 			return NULL;
 		}
 	}
-	return swap_map;
+	return bitmap;
 }
 
-/**
- *	reverse_swap_map - reverse the order of pages in the swap map
- *	@swap_map
- */
-
-static inline struct swap_map_page *reverse_swap_map(struct swap_map_page *swap_map)
+static int bitmap_set(struct bitmap_page *bitmap, unsigned long bit)
 {
-	struct swap_map_page *prev, *next;
+	unsigned int n;
 
-	prev = NULL;
-	while (swap_map) {
-		next = swap_map->next;
-		swap_map->next = prev;
-		prev = swap_map;
-		swap_map = next;
+	n = BITMAP_PAGE_BITS;
+	while (bitmap && n <= bit) {
+		n += BITMAP_PAGE_BITS;
+		bitmap = bitmap->next;
+	}
+	if (!bitmap)
+		return -EINVAL;
+	n -= BITMAP_PAGE_BITS;
+	bit -= n;
+	n = 0;
+	while (bit >= BITS_PER_CHUNK) {
+		bit -= BITS_PER_CHUNK;
+		n++;
 	}
-	return prev;
+	bitmap->chunks[n] |= (1UL << bit);
+	return 0;
 }
 
-/**
- *	free_swap_map_entries - free the swap entries allocated to store
- *	the swap map @swap_map (this is only called in case of an error)
- */
-static inline void free_swap_map_entries(struct swap_map_page *swap_map)
+static unsigned long alloc_swap_page(int swap, struct bitmap_page *bitmap)
 {
-	while (swap_map) {
-		if (swap_map->next_swap.val)
-			swap_free(swap_map->next_swap);
-		swap_map = swap_map->next;
+	unsigned long offset;
+
+	offset = swp_offset(get_swap_page_of_type(swap));
+	if (offset) {
+		if (bitmap_set(bitmap, offset)) {
+			swap_free(swp_entry(swap, offset));
+			offset = 0;
+		}
 	}
+	return offset;
 }
 
-/**
- *	save_swap_map - save the swap map used for tracing the data pages
- *	stored in the swap
- */
-
-static int save_swap_map(struct swap_map_page *swap_map, swp_entry_t *start)
+static void free_all_swap_pages(int swap, struct bitmap_page *bitmap)
 {
-	swp_entry_t entry = (swp_entry_t){0};
-	int error;
+	unsigned int bit, n;
+	unsigned long test;
 
-	while (swap_map) {
-		swap_map->next_swap = entry;
-		if ((error = write_page((unsigned long)swap_map, &entry)))
-			return error;
-		swap_map = swap_map->next;
+	bit = 0;
+	while (bitmap) {
+		for (n = 0; n < BITMAP_PAGE_CHUNKS; n++)
+			for (test = 1UL; test; test <<= 1) {
+				if (bitmap->chunks[n] & test)
+					swap_free(swp_entry(swap, bit));
+				bit++;
+			}
+		bitmap = bitmap->next;
 	}
-	*start = entry;
-	return 0;
 }
 
 /**
- *	free_image_entries - free the swap entries allocated to store
- *	the image data pages (this is only called in case of an error)
+ *	write_page - Write one page to given swap location.
+ *	@buf:		Address we're writing.
+ *	@offset:	Offset of the swap page we're writing to.
  */
 
-static inline void free_image_entries(struct swap_map_page *swp)
+static int write_page(void *buf, unsigned long offset)
 {
-	unsigned k;
+	swp_entry_t entry;
+	int error = -ENOSPC;
 
-	while (swp) {
-		for (k = 0; k < MAP_PAGE_SIZE; k++)
-			if (swp->entries[k].val)
-				swap_free(swp->entries[k]);
-		swp = swp->next;
+	if (offset) {
+		entry = swp_entry(root_swap, offset);
+		error = rw_swap_page_sync(WRITE, entry, virt_to_page(buf));
 	}
+	return error;
 }
 
+/*
+ *	The swap map is a data structure used for keeping track of each page
+ *	written to a swap partition.  It consists of many swap_map_page
+ *	structures that contain each an array of MAP_PAGE_SIZE swap entries.
+ *	These structures are stored on the swap and linked together with the
+ *	help of the .next_swap member.
+ *
+ *	The swap map is created during suspend.  The swap map pages are
+ *	allocated and populated one at a time, so we only need one memory
+ *	page to set up the entire structure.
+ *
+ *	During resume we also only need to use one swap_map_page structure
+ *	at a time.
+ */
+
+#define MAP_PAGE_ENTRIES	(PAGE_SIZE / sizeof(long) - 1)
+
+struct swap_map_page {
+	unsigned long		entries[MAP_PAGE_ENTRIES];
+	unsigned long		next_swap;
+};
+
 /**
- *	The swap_map_handle structure is used for handling the swap map in
+ *	The swap_map_handle structure is used for handling swap in
  *	a file-alike way
  */
 
 struct swap_map_handle {
 	struct swap_map_page *cur;
+	unsigned long cur_swap;
+	struct bitmap_page *bitmap;
 	unsigned int k;
 };
 
-static inline void init_swap_map_handle(struct swap_map_handle *handle,
-                                        struct swap_map_page *map)
+static void release_swap_writer(struct swap_map_handle *handle)
 {
-	handle->cur = map;
+	if (handle->cur)
+		free_page((unsigned long)handle->cur);
+	handle->cur = NULL;
+	if (handle->bitmap)
+		free_bitmap(handle->bitmap);
+	handle->bitmap = NULL;
+}
+
+static int get_swap_writer(struct swap_map_handle *handle)
+{
+	handle->cur = (struct swap_map_page *)get_zeroed_page(GFP_KERNEL);
+	if (!handle->cur)
+		return -ENOMEM;
+	handle->bitmap = alloc_bitmap(count_swap_pages(root_swap, 0));
+	if (!handle->bitmap) {
+		release_swap_writer(handle);
+		return -ENOMEM;
+	}
+	handle->cur_swap = alloc_swap_page(root_swap, handle->bitmap);
+	if (!handle->cur_swap) {
+		release_swap_writer(handle);
+		return -ENOSPC;
+	}
 	handle->k = 0;
+	return 0;
 }
 
-static inline int swap_map_write_page(struct swap_map_handle *handle,
-                                      unsigned long addr)
+static int swap_write_page(struct swap_map_handle *handle, void *buf)
 {
 	int error;
+	unsigned long offset;
 
-	error = write_page(addr, handle->cur->entries + handle->k);
+	if (!handle->cur)
+		return -EINVAL;
+	offset = alloc_swap_page(root_swap, handle->bitmap);
+	error = write_page(buf, offset);
 	if (error)
 		return error;
-	if (++handle->k >= MAP_PAGE_SIZE) {
-		handle->cur = handle->cur->next;
+	handle->cur->entries[handle->k++] = offset;
+	if (handle->k >= MAP_PAGE_ENTRIES) {
+		offset = alloc_swap_page(root_swap, handle->bitmap);
+		if (!offset)
+			return -ENOSPC;
+		handle->cur->next_swap = offset;
+		error = write_page(handle->cur, handle->cur_swap);
+		if (error)
+			return error;
+		memset(handle->cur, 0, PAGE_SIZE);
+		handle->cur_swap = offset;
 		handle->k = 0;
 	}
 	return 0;
 }
 
+static int flush_swap_writer(struct swap_map_handle *handle)
+{
+	if (handle->cur && handle->cur_swap)
+		return write_page(handle->cur, handle->cur_swap);
+	else
+		return -EINVAL;
+}
+
 /**
- *	save_image_data - save the data pages pointed to by the PBEs
- *	from the list @pblist using the swap map handle @handle
- *	(assume there are @nr_pages data pages to save)
+ *	save_image - save the suspend image data
  */
 
-static int save_image_data(struct pbe *pblist,
-                           struct swap_map_handle *handle,
-                           unsigned int nr_pages)
+static int save_image(struct swap_map_handle *handle,
+                      struct snapshot_handle *snapshot,
+                      unsigned int nr_pages)
 {
 	unsigned int m;
-	struct pbe *p;
+	int ret;
 	int error = 0;
 
 	printk("Saving image data pages (%u pages) ...     ", nr_pages);
@@ -385,98 +391,22 @@ static int save_image_data(struct pbe *p
 	if (!m)
 		m = 1;
 	nr_pages = 0;
-	for_each_pbe (p, pblist) {
-		error = swap_map_write_page(handle, p->address);
-		if (error)
-			break;
-		if (!(nr_pages % m))
-			printk("\b\b\b\b%3d%%", nr_pages / m);
-		nr_pages++;
-	}
+	do {
+		ret = snapshot_read_next(snapshot, PAGE_SIZE);
+		if (ret > 0) {
+			error = swap_write_page(handle, data_of(*snapshot));
+			if (error)
+				break;
+			if (!(nr_pages % m))
+				printk("\b\b\b\b%3d%%", nr_pages / m);
+			nr_pages++;
+		}
+	} while (ret > 0);
 	if (!error)
 		printk("\b\b\b\bdone\n");
 	return error;
 }
 
-static void dump_info(void)
-{
-	pr_debug(" swsusp: Version: %u\n",swsusp_info.version_code);
-	pr_debug(" swsusp: Num Pages: %ld\n",swsusp_info.num_physpages);
-	pr_debug(" swsusp: UTS Sys: %s\n",swsusp_info.uts.sysname);
-	pr_debug(" swsusp: UTS Node: %s\n",swsusp_info.uts.nodename);
-	pr_debug(" swsusp: UTS Release: %s\n",swsusp_info.uts.release);
-	pr_debug(" swsusp: UTS Version: %s\n",swsusp_info.uts.version);
-	pr_debug(" swsusp: UTS Machine: %s\n",swsusp_info.uts.machine);
-	pr_debug(" swsusp: UTS Domain: %s\n",swsusp_info.uts.domainname);
-	pr_debug(" swsusp: CPUs: %d\n",swsusp_info.cpus);
-	pr_debug(" swsusp: Image: %ld Pages\n",swsusp_info.image_pages);
-	pr_debug(" swsusp: Total: %ld Pages\n", swsusp_info.pages);
-}
-
-static void init_header(unsigned int nr_pages)
-{
-	memset(&swsusp_info, 0, sizeof(swsusp_info));
-	swsusp_info.version_code = LINUX_VERSION_CODE;
-	swsusp_info.num_physpages = num_physpages;
-	memcpy(&swsusp_info.uts, &system_utsname, sizeof(system_utsname));
-
-	swsusp_info.cpus = num_online_cpus();
-	swsusp_info.image_pages = nr_pages;
-	swsusp_info.pages = nr_pages +
-		((nr_pages * sizeof(long) + PAGE_SIZE - 1) >> PAGE_SHIFT) + 1;
-}
-
-/**
- *	pack_orig_addresses - the .orig_address fields of the PBEs from the
- *	list starting at @pbe are stored in the array @buf[] (1 page)
- */
-
-static inline struct pbe *pack_orig_addresses(unsigned long *buf,
-                                              struct pbe *pbe)
-{
-	int j;
-
-	for (j = 0; j < PAGE_SIZE / sizeof(long) && pbe; j++) {
-		buf[j] = pbe->orig_address;
-		pbe = pbe->next;
-	}
-	if (!pbe)
-		for (; j < PAGE_SIZE / sizeof(long); j++)
-			buf[j] = 0;
-	return pbe;
-}
-
-/**
- *	save_image_metadata - save the .orig_address fields of the PBEs
- *	from the list @pblist using the swap map handle @handle
- */
-
-static int save_image_metadata(struct pbe *pblist,
-                               struct swap_map_handle *handle)
-{
-	unsigned long *buf;
-	unsigned int n = 0;
-	struct pbe *p;
-	int error = 0;
-
-	printk("Saving image metadata ... ");
-	buf = (unsigned long *)get_zeroed_page(GFP_ATOMIC);
-	if (!buf)
-		return -ENOMEM;
-	p = pblist;
-	while (p) {
-		p = pack_orig_addresses(buf, p);
-		error = swap_map_write_page(handle, (unsigned long)buf);
-		if (error)
-			break;
-		n++;
-	}
-	free_page((unsigned long)buf);
-	if (!error)
-		printk("done (%u pages saved)\n", n);
-	return error;
-}
-
 /**
  *	enough_swap - Make sure we have enough swap to save the image.
  *
@@ -486,8 +416,7 @@ static int save_image_metadata(struct pb
 
 static int enough_swap(unsigned int nr_pages)
 {
-	unsigned int free_swap = swap_info[root_swap].pages -
-		swap_info[root_swap].inuse_pages;
+	unsigned int free_swap = count_swap_pages(root_swap, 1);
 
 	pr_debug("swsusp: free swap pages: %u\n", free_swap);
 	return free_swap > (nr_pages + PAGES_FOR_IO +
@@ -503,57 +432,44 @@ static int enough_swap(unsigned int nr_p
  *	correctly, we'll mark system clean, anyway.)
  */
 
-int swsusp_write(struct pbe *pblist, unsigned int nr_pages)
+int swsusp_write(void)
 {
-	struct swap_map_page *swap_map;
 	struct swap_map_handle handle;
-	swp_entry_t start;
+	struct snapshot_handle snapshot;
+	struct swsusp_info *header;
+	unsigned long start;
 	int error;
 
 	if ((error = swsusp_swap_check())) {
 		printk(KERN_ERR "swsusp: Cannot find swap device, try swapon -a.\n");
 		return error;
 	}
-	if (!enough_swap(nr_pages)) {
+	memset(&snapshot, 0, sizeof(struct snapshot_handle));
+	error = snapshot_read_next(&snapshot, PAGE_SIZE);
+	if (error < PAGE_SIZE)
+		return error < 0 ? error : -EFAULT;
+	header = (struct swsusp_info *)data_of(snapshot);
+	if (!enough_swap(header->pages)) {
 		printk(KERN_ERR "swsusp: Not enough free swap\n");
 		return -ENOSPC;
 	}
-
-	init_header(nr_pages);
-	swap_map = alloc_swap_map(swsusp_info.pages);
-	if (!swap_map)
-		return -ENOMEM;
-	init_swap_map_handle(&handle, swap_map);
-
-	error = swap_map_write_page(&handle, (unsigned long)&swsusp_info);
-	if (!error)
-		error = save_image_metadata(pblist, &handle);
+	error = get_swap_writer(&handle);
+	if (!error) {
+		start = handle.cur_swap;
+		error = swap_write_page(&handle, header);
+	}
 	if (!error)
-		error = save_image_data(pblist, &handle, nr_pages);
-	if (error)
-		goto Free_image_entries;
-
-	swap_map = reverse_swap_map(swap_map);
-	error = save_swap_map(swap_map, &start);
-	if (error)
-		goto Free_map_entries;
-
-	dump_info();
-	printk( "S" );
-	error = mark_swapfiles(start);
-	printk( "|\n" );
+		error = save_image(&handle, &snapshot, header->pages - 1);
+	if (!error) {
+		flush_swap_writer(&handle);
+		printk("S");
+		error = mark_swapfiles(swp_entry(root_swap, start));
+		printk("|\n");
+	}
 	if (error)
-		goto Free_map_entries;
-
-Free_swap_map:
-	free_swap_map(swap_map);
+		free_all_swap_pages(root_swap, handle.bitmap);
+	release_swap_writer(&handle);
 	return error;
-
-Free_map_entries:
-	free_swap_map_entries(swap_map);
-Free_image_entries:
-	free_image_entries(swap_map);
-	goto Free_swap_map;
 }
 
 /**
@@ -663,45 +579,6 @@ int swsusp_resume(void)
 	return error;
 }
 
-/**
- *	mark_unsafe_pages - mark the pages that cannot be used for storing
- *	the image during resume, because they conflict with the pages that
- *	had been used before suspend
- */
-
-static void mark_unsafe_pages(struct pbe *pblist)
-{
-	struct zone *zone;
-	unsigned long zone_pfn;
-	struct pbe *p;
-
-	if (!pblist) /* a sanity check */
-		return;
-
-	/* Clear page flags */
-	for_each_zone (zone) {
-		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
-			if (pfn_valid(zone_pfn + zone->zone_start_pfn))
-				ClearPageNosaveFree(pfn_to_page(zone_pfn +
-					zone->zone_start_pfn));
-	}
-
-	/* Mark orig addresses */
-	for_each_pbe (p, pblist)
-		SetPageNosaveFree(virt_to_page(p->orig_address));
-
-}
-
-static void copy_page_backup_list(struct pbe *dst, struct pbe *src)
-{
-	/* We assume both lists contain the same number of elements */
-	while (src) {
-		dst->orig_address = src->orig_address;
-		dst = dst->next;
-		src = src->next;
-	}
-}
-
 /*
  *	Using bio to read from swap.
  *	This code requires a bit more work than just using buffer heads
@@ -781,14 +658,14 @@ static int bio_write_page(pgoff_t page_o
  *	in a file-alike way
  */
 
-static inline void release_swap_map_reader(struct swap_map_handle *handle)
+static void release_swap_reader(struct swap_map_handle *handle)
 {
 	if (handle->cur)
 		free_page((unsigned long)handle->cur);
 	handle->cur = NULL;
 }
 
-static inline int get_swap_map_reader(struct swap_map_handle *handle,
+static int get_swap_reader(struct swap_map_handle *handle,
                                       swp_entry_t start)
 {
 	int error;
@@ -800,149 +677,80 @@ static inline int get_swap_map_reader(st
 		return -ENOMEM;
 	error = bio_read_page(swp_offset(start), handle->cur);
 	if (error) {
-		release_swap_map_reader(handle);
+		release_swap_reader(handle);
 		return error;
 	}
 	handle->k = 0;
 	return 0;
 }
 
-static inline int swap_map_read_page(struct swap_map_handle *handle, void *buf)
+static int swap_read_page(struct swap_map_handle *handle, void *buf)
 {
 	unsigned long offset;
 	int error;
 
 	if (!handle->cur)
 		return -EINVAL;
-	offset = swp_offset(handle->cur->entries[handle->k]);
+	offset = handle->cur->entries[handle->k];
 	if (!offset)
-		return -EINVAL;
+		return -EFAULT;
 	error = bio_read_page(offset, buf);
 	if (error)
 		return error;
-	if (++handle->k >= MAP_PAGE_SIZE) {
+	if (++handle->k >= MAP_PAGE_ENTRIES) {
 		handle->k = 0;
-		offset = swp_offset(handle->cur->next_swap);
+		offset = handle->cur->next_swap;
 		if (!offset)
-			release_swap_map_reader(handle);
+			release_swap_reader(handle);
 		else
 			error = bio_read_page(offset, handle->cur);
 	}
 	return error;
 }
 
-static int check_header(void)
-{
-	char *reason = NULL;
-
-	dump_info();
-	if (swsusp_info.version_code != LINUX_VERSION_CODE)
-		reason = "kernel version";
-	if (swsusp_info.num_physpages != num_physpages)
-		reason = "memory size";
-	if (strcmp(swsusp_info.uts.sysname,system_utsname.sysname))
-		reason = "system type";
-	if (strcmp(swsusp_info.uts.release,system_utsname.release))
-		reason = "kernel release";
-	if (strcmp(swsusp_info.uts.version,system_utsname.version))
-		reason = "version";
-	if (strcmp(swsusp_info.uts.machine,system_utsname.machine))
-		reason = "machine";
-	if (reason) {
-		printk(KERN_ERR "swsusp: Resume mismatch: %s\n", reason);
-		return -EPERM;
-	}
-	return 0;
-}
-
 /**
- *	load_image_data - load the image data using the swap map handle
- *	@handle and store them using the page backup list @pblist
+ *	load_image - load the image using the swap map handle
+ *	@handle and the snapshot handle @snapshot
  *	(assume there are @nr_pages pages to load)
  */
 
-static int load_image_data(struct pbe *pblist,
-                           struct swap_map_handle *handle,
-                           unsigned int nr_pages)
+static int load_image(struct swap_map_handle *handle,
+                      struct snapshot_handle *snapshot,
+                      unsigned int nr_pages)
 {
-	int error;
 	unsigned int m;
-	struct pbe *p;
+	int ret;
+	int error = 0;
 
-	if (!pblist)
-		return -EINVAL;
 	printk("Loading image data pages (%u pages) ...     ", nr_pages);
 	m = nr_pages / 100;
 	if (!m)
 		m = 1;
 	nr_pages = 0;
-	p = pblist;
-	while (p) {
-		error = swap_map_read_page(handle, (void *)p->address);
-		if (error)
-			break;
-		p = p->next;
-		if (!(nr_pages % m))
-			printk("\b\b\b\b%3d%%", nr_pages / m);
-		nr_pages++;
-	}
+	do {
+		ret = snapshot_write_next(snapshot, PAGE_SIZE);
+		if (ret > 0) {
+			error = swap_read_page(handle, data_of(*snapshot));
+			if (error)
+				break;
+			if (!(nr_pages % m))
+				printk("\b\b\b\b%3d%%", nr_pages / m);
+			nr_pages++;
+		}
+	} while (ret > 0);
 	if (!error)
 		printk("\b\b\b\bdone\n");
+	if (!snapshot_image_loaded(snapshot))
+		error = -ENODATA;
 	return error;
 }
 
-/**
- *	unpack_orig_addresses - copy the elements of @buf[] (1 page) to
- *	the PBEs in the list starting at @pbe
- */
-
-static inline struct pbe *unpack_orig_addresses(unsigned long *buf,
-                                                struct pbe *pbe)
-{
-	int j;
-
-	for (j = 0; j < PAGE_SIZE / sizeof(long) && pbe; j++) {
-		pbe->orig_address = buf[j];
-		pbe = pbe->next;
-	}
-	return pbe;
-}
-
-/**
- *	load_image_metadata - load the image metadata using the swap map
- *	handle @handle and put them into the PBEs in the list @pblist
- */
-
-static int load_image_metadata(struct pbe *pblist, struct swap_map_handle *handle)
-{
-	struct pbe *p;
-	unsigned long *buf;
-	unsigned int n = 0;
-	int error = 0;
-
-	printk("Loading image metadata ... ");
-	buf = (unsigned long *)get_zeroed_page(GFP_ATOMIC);
-	if (!buf)
-		return -ENOMEM;
-	p = pblist;
-	while (p) {
-		error = swap_map_read_page(handle, buf);
-		if (error)
-			break;
-		p = unpack_orig_addresses(buf, p);
-		n++;
-	}
-	free_page((unsigned long)buf);
-	if (!error)
-		printk("done (%u pages loaded)\n", n);
-	return error;
-}
-
-int swsusp_read(struct pbe **pblist_ptr)
+int swsusp_read(void)
 {
 	int error;
-	struct pbe *p, *pblist;
 	struct swap_map_handle handle;
+	struct snapshot_handle snapshot;
+	struct swsusp_info *header;
 	unsigned int nr_pages;
 
 	if (IS_ERR(resume_bdev)) {
@@ -950,38 +758,19 @@ int swsusp_read(struct pbe **pblist_ptr)
 		return PTR_ERR(resume_bdev);
 	}
 
-	error = get_swap_map_reader(&handle, swsusp_header.image);
+	memset(&snapshot, 0, sizeof(struct snapshot_handle));
+	error = snapshot_write_next(&snapshot, PAGE_SIZE);
+	if (error < PAGE_SIZE)
+		return error < 0 ? error : -EFAULT;
+	header = (struct swsusp_info *)data_of(snapshot);
+	error = get_swap_reader(&handle, swsusp_header.image);
 	if (!error)
-		error = swap_map_read_page(&handle, &swsusp_info);
-	if (!error)
-		error = check_header();
-	if (error)
-		return error;
-	nr_pages = swsusp_info.image_pages;
-	p = alloc_pagedir(nr_pages, GFP_ATOMIC, 0);
-	if (!p)
-		return -ENOMEM;
-	error = load_image_metadata(p, &handle);
+		error = swap_read_page(&handle, header);
 	if (!error) {
-		mark_unsafe_pages(p);
-		pblist = alloc_pagedir(nr_pages, GFP_ATOMIC, 1);
-		if (pblist)
-			copy_page_backup_list(pblist, p);
-		free_pagedir(p);
-		if (!pblist)
-			error = -ENOMEM;
-
-		/* Allocate memory for the image and read the data from swap */
-		if (!error)
-			error = alloc_data_pages(pblist, GFP_ATOMIC, 1);
-		if (!error) {
-			release_eaten_pages();
-			error = load_image_data(pblist, &handle, nr_pages);
-		}
-		if (!error)
-			*pblist_ptr = pblist;
+		nr_pages = header->image_pages;
+		error = load_image(&handle, &snapshot, nr_pages);
 	}
-	release_swap_map_reader(&handle);
+	release_swap_reader(&handle);
 
 	blkdev_put(resume_bdev);
 
Index: linux-2.6.15-mm2/kernel/power/snapshot.c
===================================================================
--- linux-2.6.15-mm2.orig/kernel/power/snapshot.c	2006-01-08 12:52:20.000000000 +0100
+++ linux-2.6.15-mm2/kernel/power/snapshot.c	2006-01-08 12:52:45.000000000 +0100
@@ -10,6 +10,7 @@
  */
 
 
+#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/suspend.h>
@@ -35,6 +36,7 @@
 
 struct pbe *pagedir_nosave;
 unsigned int nr_copy_pages;
+unsigned int nr_meta_pages;
 
 #ifdef CONFIG_HIGHMEM
 unsigned int count_highmem_pages(void)
@@ -237,7 +239,7 @@ static void copy_data_pages(struct pbe *
  *	free_pagedir - free pages allocated with alloc_pagedir()
  */
 
-void free_pagedir(struct pbe *pblist)
+static void free_pagedir(struct pbe *pblist)
 {
 	struct pbe *pbe;
 
@@ -303,7 +305,7 @@ struct eaten_page {
 
 static struct eaten_page *eaten_pages = NULL;
 
-void release_eaten_pages(void)
+static void release_eaten_pages(void)
 {
 	struct eaten_page *p, *q;
 
@@ -378,7 +380,6 @@ struct pbe *alloc_pagedir(unsigned int n
 	if (!nr_pages)
 		return NULL;
 
-	pr_debug("alloc_pagedir(): nr_pages = %d\n", nr_pages);
 	pblist = alloc_image_page(gfp_mask, safe_needed);
 	/* FIXME: rewrite this ugly loop */
 	for (pbe = pblist, num = PBES_PER_PAGE; pbe && num < nr_pages;
@@ -416,6 +417,9 @@ void swsusp_free(void)
 				}
 			}
 	}
+	nr_copy_pages = 0;
+	nr_meta_pages = 0;
+	pagedir_nosave = NULL;
 }
 
 
@@ -439,7 +443,7 @@ static int enough_free_mem(unsigned int 
 		(nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE);
 }
 
-int alloc_data_pages(struct pbe *pblist, gfp_t gfp_mask, int safe_needed)
+static int alloc_data_pages(struct pbe *pblist, gfp_t gfp_mask, int safe_needed)
 {
 	struct pbe *p;
 
@@ -506,7 +510,319 @@ asmlinkage int swsusp_save(void)
 	 */
 
 	nr_copy_pages = nr_pages;
+	nr_meta_pages = (nr_pages * sizeof(long) + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
 	printk("swsusp: critical section/: done (%d pages copied)\n", nr_pages);
 	return 0;
 }
+
+static void init_header(struct swsusp_info *info)
+{
+	memset(info, 0, sizeof(struct swsusp_info));
+	info->version_code = LINUX_VERSION_CODE;
+	info->num_physpages = num_physpages;
+	memcpy(&info->uts, &system_utsname, sizeof(system_utsname));
+	info->cpus = num_online_cpus();
+	info->image_pages = nr_copy_pages;
+	info->pages = nr_copy_pages + nr_meta_pages + 1;
+}
+
+/**
+ *	pack_orig_addresses - the .orig_address fields of the PBEs from the
+ *	list starting at @pbe are stored in the array @buf[] (1 page)
+ */
+
+static inline struct pbe *pack_orig_addresses(unsigned long *buf, struct pbe *pbe)
+{
+	int j;
+
+	for (j = 0; j < PAGE_SIZE / sizeof(long) && pbe; j++) {
+		buf[j] = pbe->orig_address;
+		pbe = pbe->next;
+	}
+	if (!pbe)
+		for (; j < PAGE_SIZE / sizeof(long); j++)
+			buf[j] = 0;
+	return pbe;
+}
+
+/**
+ *	snapshot_read_next - used for reading the system memory snapshot.
+ *
+ *	On the first call to it @handle should point to a zeroed
+ *	snapshot_handle structure.  The structure gets updated and a pointer
+ *	to it should be passed to this function every next time.
+ *
+ *	The @count parameter should contain the number of bytes the caller
+ *	wants to read from the snapshot.  It must not be zero.
+ *
+ *	On success the function returns a positive number.  Then, the caller
+ *	is allowed to read up to the returned number of bytes from the memory
+ *	location computed by the data_of() macro.  The number returned
+ *	may be smaller than @count, but this only happens if the read would
+ *	cross a page boundary otherwise.
+ *
+ *	The function returns 0 to indicate the end of data stream condition,
+ *	and a negative number is returned on error.  In such cases the
+ *	structure pointed to by @handle is not updated and should not be used
+ *	any more.
+ */
+
+int snapshot_read_next(struct snapshot_handle *handle, size_t count)
+{
+	static unsigned long *buffer;
+
+	if (handle->page > nr_meta_pages + nr_copy_pages)
+		return 0;
+	if (!buffer) {
+		/* This makes the buffer be freed by swsusp_free() */
+		buffer = alloc_image_page(GFP_ATOMIC, 0);
+		if (!buffer)
+			return -ENOMEM;
+	}
+	if (!handle->offset) {
+		init_header((struct swsusp_info *)buffer);
+		handle->buffer = buffer;
+		handle->pbe = pagedir_nosave;
+	}
+	if (handle->prev < handle->page) {
+		if (handle->page <= nr_meta_pages) {
+			handle->pbe = pack_orig_addresses(buffer, handle->pbe);
+			if (!handle->pbe)
+				handle->pbe = pagedir_nosave;
+		} else {
+			handle->buffer = (void *)handle->pbe->address;
+			handle->pbe = handle->pbe->next;
+		}
+		handle->prev = handle->page;
+	}
+	handle->buf_offset = handle->page_offset;
+	if (handle->page_offset + count >= PAGE_SIZE) {
+		count = PAGE_SIZE - handle->page_offset;
+		handle->page_offset = 0;
+		handle->page++;
+	} else {
+		handle->page_offset += count;
+	}
+	handle->offset += count;
+	return count;
+}
+
+/**
+ *	mark_unsafe_pages - mark the pages that cannot be used for storing
+ *	the image during resume, because they conflict with the pages that
+ *	had been used before suspend
+ */
+
+static int mark_unsafe_pages(struct pbe *pblist)
+{
+	struct zone *zone;
+	unsigned long zone_pfn;
+	struct pbe *p;
+
+	if (!pblist) /* a sanity check */
+		return -EINVAL;
+
+	/* Clear page flags */
+	for_each_zone (zone) {
+		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
+			if (pfn_valid(zone_pfn + zone->zone_start_pfn))
+				ClearPageNosaveFree(pfn_to_page(zone_pfn +
+					zone->zone_start_pfn));
+	}
+
+	/* Mark orig addresses */
+	for_each_pbe (p, pblist) {
+		if (virt_addr_valid(p->orig_address))
+			SetPageNosaveFree(virt_to_page(p->orig_address));
+		else
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+static void copy_page_backup_list(struct pbe *dst, struct pbe *src)
+{
+	/* We assume both lists contain the same number of elements */
+	while (src) {
+		dst->orig_address = src->orig_address;
+		dst = dst->next;
+		src = src->next;
+	}
+}
+
+static int check_header(struct swsusp_info *info)
+{
+	char *reason = NULL;
+
+	if (info->version_code != LINUX_VERSION_CODE)
+		reason = "kernel version";
+	if (info->num_physpages != num_physpages)
+		reason = "memory size";
+	if (strcmp(info->uts.sysname,system_utsname.sysname))
+		reason = "system type";
+	if (strcmp(info->uts.release,system_utsname.release))
+		reason = "kernel release";
+	if (strcmp(info->uts.version,system_utsname.version))
+		reason = "version";
+	if (strcmp(info->uts.machine,system_utsname.machine))
+		reason = "machine";
+	if (reason) {
+		printk(KERN_ERR "swsusp: Resume mismatch: %s\n", reason);
+		return -EPERM;
+	}
+	return 0;
+}
+
+/**
+ *	load header - check the image header and copy data from it
+ */
+
+static int load_header(struct snapshot_handle *handle,
+                              struct swsusp_info *info)
+{
+	int error;
+	struct pbe *pblist;
+
+	error = check_header(info);
+	if (!error) {
+		pblist = alloc_pagedir(info->image_pages, GFP_ATOMIC, 0);
+		if (!pblist)
+			return -ENOMEM;
+		pagedir_nosave = pblist;
+		handle->pbe = pblist;
+		nr_copy_pages = info->image_pages;
+		nr_meta_pages = info->pages - info->image_pages - 1;
+	}
+	return error;
+}
+
+/**
+ *	unpack_orig_addresses - copy the elements of @buf[] (1 page) to
+ *	the PBEs in the list starting at @pbe
+ */
+
+static inline struct pbe *unpack_orig_addresses(unsigned long *buf,
+                                                struct pbe *pbe)
+{
+	int j;
+
+	for (j = 0; j < PAGE_SIZE / sizeof(long) && pbe; j++) {
+		pbe->orig_address = buf[j];
+		pbe = pbe->next;
+	}
+	return pbe;
+}
+
+/**
+ *	create_image - use metadata contained in the PBE list
+ *	pointed to by pagedir_nosave to mark the pages that will
+ *	be overwritten in the process of restoring the system
+ *	memory state from the image and allocate memory for
+ *	the image avoiding these pages
+ */
+
+static int create_image(struct snapshot_handle *handle)
+{
+	int error = 0;
+	struct pbe *p, *pblist;
+
+	p = pagedir_nosave;
+	error = mark_unsafe_pages(p);
+	if (!error) {
+		pblist = alloc_pagedir(nr_copy_pages, GFP_ATOMIC, 1);
+		if (pblist)
+			copy_page_backup_list(pblist, p);
+		free_pagedir(p);
+		if (!pblist)
+			error = -ENOMEM;
+	}
+	if (!error)
+		error = alloc_data_pages(pblist, GFP_ATOMIC, 1);
+	if (!error) {
+		release_eaten_pages();
+		pagedir_nosave = pblist;
+	} else {
+		pagedir_nosave = NULL;
+		handle->pbe = NULL;
+		nr_copy_pages = 0;
+		nr_meta_pages = 0;
+	}
+	return error;
+}
+
+/**
+ *	snapshot_write_next - used for writing the system memory snapshot.
+ *
+ *	On the first call to it @handle should point to a zeroed
+ *	snapshot_handle structure.  The structure gets updated and a pointer
+ *	to it should be passed to this function every next time.
+ *
+ *	The @count parameter should contain the number of bytes the caller
+ *	wants to write to the image.  It must not be zero.
+ *
+ *	On success the function returns a positive number.  Then, the caller
+ *	is allowed to write up to the returned number of bytes to the memory
+ *	location computed by the data_of() macro.  The number returned
+ *	may be smaller than @count, but this only happens if the write would
+ *	cross a page boundary otherwise.
+ *
+ *	The function returns 0 to indicate the "end of file" condition,
+ *	and a negative number is returned on error.  In such cases the
+ *	structure pointed to by @handle is not updated and should not be used
+ *	any more.
+ */
+
+int snapshot_write_next(struct snapshot_handle *handle, size_t count)
+{
+	static unsigned long *buffer;
+	int error = 0;
+
+	if (handle->prev && handle->page > nr_meta_pages + nr_copy_pages)
+		return 0;
+	if (!buffer) {
+		/* This makes the buffer be freed by swsusp_free() */
+		buffer = alloc_image_page(GFP_ATOMIC, 0);
+		if (!buffer)
+			return -ENOMEM;
+	}
+	if (!handle->offset)
+		handle->buffer = buffer;
+	if (handle->prev < handle->page) {
+		if (!handle->prev) {
+			error = load_header(handle, (struct swsusp_info *)buffer);
+			if (error)
+				return error;
+		} else if (handle->prev <= nr_meta_pages) {
+			handle->pbe = unpack_orig_addresses(buffer, handle->pbe);
+			if (!handle->pbe) {
+				error = create_image(handle);
+				if (error)
+					return error;
+				handle->pbe = pagedir_nosave;
+				handle->buffer = (void *)handle->pbe->address;
+			}
+		} else {
+			handle->pbe = handle->pbe->next;
+			handle->buffer = (void *)handle->pbe->address;
+		}
+		handle->prev = handle->page;
+	}
+	handle->buf_offset = handle->page_offset;
+	if (handle->page_offset + count >= PAGE_SIZE) {
+		count = PAGE_SIZE - handle->page_offset;
+		handle->page_offset = 0;
+		handle->page++;
+	} else {
+		handle->page_offset += count;
+	}
+	handle->offset += count;
+	return count;
+}
+
+int snapshot_image_loaded(struct snapshot_handle *handle)
+{
+	return !(!handle->pbe || handle->pbe->next || !nr_copy_pages ||
+		handle->page <= nr_meta_pages + nr_copy_pages);
+}
Index: linux-2.6.15-mm2/include/linux/swap.h
===================================================================
--- linux-2.6.15-mm2.orig/include/linux/swap.h	2006-01-08 12:52:20.000000000 +0100
+++ linux-2.6.15-mm2/include/linux/swap.h	2006-01-08 12:52:45.000000000 +0100
@@ -216,11 +216,13 @@ extern unsigned int nr_swapfiles;
 extern struct swap_info_struct swap_info[];
 extern void si_swapinfo(struct sysinfo *);
 extern swp_entry_t get_swap_page(void);
-extern swp_entry_t get_swap_page_of_type(int type);
+extern swp_entry_t get_swap_page_of_type(int);
 extern int swap_duplicate(swp_entry_t);
 extern int valid_swaphandles(swp_entry_t, unsigned long *);
 extern void swap_free(swp_entry_t);
 extern void free_swap_and_cache(swp_entry_t);
+extern int swap_type_of(dev_t);
+extern unsigned int count_swap_pages(int, int);
 extern sector_t map_swap_page(struct swap_info_struct *, pgoff_t);
 extern struct swap_info_struct *get_swap_info_struct(unsigned);
 extern int can_share_swap_page(struct page *);
Index: linux-2.6.15-mm2/mm/swapfile.c
===================================================================
--- linux-2.6.15-mm2.orig/mm/swapfile.c	2006-01-08 12:52:20.000000000 +0100
+++ linux-2.6.15-mm2/mm/swapfile.c	2006-01-08 12:54:24.000000000 +0100
@@ -415,6 +415,59 @@ void free_swap_and_cache(swp_entry_t ent
 	}
 }
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+/*
+ * Find the swap type that corresponds to given device (if any)
+ *
+ * This is needed for software suspend and is done in such a way that inode
+ * aliasing is allowed.
+ */
+int swap_type_of(dev_t device)
+{
+	int i;
+
+	if (!device)
+		return -EINVAL;
+	spin_lock(&swap_lock);
+	for (i = 0; i < nr_swapfiles; i++) {
+		struct inode *inode;
+
+		if (!(swap_info[i].flags & SWP_WRITEOK))
+			continue;
+		inode = swap_info->swap_file->f_dentry->d_inode;
+		if (S_ISBLK(inode->i_mode) &&
+		    device == MKDEV(imajor(inode), iminor(inode))) {
+			spin_unlock(&swap_lock);
+			return i;
+		}
+	}
+	spin_unlock(&swap_lock);
+	return -ENODEV;
+}
+
+/*
+ * Return either the total number of swap pages of given type, or the number
+ * of free pages of that type (depending on @free)
+ *
+ * This is needed for software suspend
+ */
+unsigned int count_swap_pages(int type, int free)
+{
+	unsigned int n = 0;
+
+	if (type < nr_swapfiles) {
+		spin_lock(&swap_lock);
+		if (swap_info[type].flags & SWP_WRITEOK) {
+			n = swap_info[type].pages;
+			if (free)
+				n -= swap_info[type].inuse_pages;
+		}
+		spin_unlock(&swap_lock);
+	}
+	return n;
+}
+#endif
+
 /*
  * No need to decide whether this PTE shares the swap entry with others,
  * just let do_wp_page work it out if a write is requested later - to

