Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbVKNXKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbVKNXKV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 18:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbVKNXJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 18:09:50 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:22686 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932235AbVKNXJo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 18:09:44 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/3] swsusp: introduce the swap map structure
Date: Mon, 14 Nov 2005 23:52:16 +0100
User-Agent: KMail/1.8.3
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
References: <200511142347.58233.rjw@sisk.pl>
In-Reply-To: <200511142347.58233.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511142352.16970.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the swap map structure that can be used by swsusp for
keeping tracks of data pages written to the swap.  The structure itself is
described in a comment within the patch.

The overall idea is to reduce the amount of metadata written to the swap
and to write and read the image pages sequentially, in a file-alike way.
This makes the swap-handling part of swsusp fairly independent of its
snapshot-handling part and will hopefully allow us to completely
separate these two parts in the future.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 include/linux/suspend.h |    6 
 kernel/power/disk.c     |    8 
 kernel/power/power.h    |   13 -
 kernel/power/snapshot.c |   14 -
 kernel/power/swsusp.c   |  558 ++++++++++++++++++++++++++++++++++--------------
 5 files changed, 418 insertions(+), 181 deletions(-)

Index: linux-2.6.14-mm2/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-mm2.orig/kernel/power/swsusp.c	2005-11-14 22:39:26.000000000 +0100
+++ linux-2.6.14-mm2/kernel/power/swsusp.c	2005-11-14 22:43:14.000000000 +0100
@@ -30,6 +30,9 @@
  * Alex Badea <vampire@go.ro>:
  * Fixed runaway init
  *
+ * Rafael J. Wysocki <rjw@sisk.pl>
+ * Added the swap map data structure and reworked the handling of swap
+ *
  * More state savers are welcome. Especially for the scsi layer...
  *
  * For TODOs,FIXMEs also look in Documentation/power/swsusp.txt
@@ -76,18 +79,6 @@
 
 extern char resume_file[];
 
-/* Local variables that should not be affected by save */
-unsigned int nr_copy_pages __nosavedata = 0;
-
-/* Suspend pagedir is allocated before final copy, therefore it
-   must be freed after resume
-
-   Warning: this is even more evil than it seems. Pagedirs this file
-   talks about are completely different from page directories used by
-   MMU hardware.
- */
-suspend_pagedir_t *pagedir_nosave __nosavedata = NULL;
-
 #define SWSUSP_SIG	"S1SUSPEND"
 
 static struct swsusp_header {
@@ -238,48 +229,205 @@
 }
 
 /**
- *	data_free - Free the swap entries used by the saved image.
+ *	Swap map-handling functions
+ *
+ *	The swap map is a data structure used for keeping track of each page
+ *	written to the swap.  It consists of many swap_map_page structures
+ *	that contain each an array of MAP_PAGE_SIZE swap entries.
+ *	These structures are linked together with the help of either the
+ *	.next (in memory) or the .next_swap (in swap) member.
  *
- *	Walk the list of used swap entries and free each one.
- *	This is only used for cleanup when suspend fails.
+ *	The swap map is created during suspend.  At that time we need to keep
+ *	it in memory, because we have to free all of the allocated swap
+ *	entries if an error occurs.  The memory needed is preallocated
+ *	so that we know in advance if there's enough of it.
+ *
+ *	The first swap_map_page structure is filled with the swap entries that
+ *	correspond to the first MAP_PAGE_SIZE data pages written to swap and
+ *	so on.  After the all of the data pages have been written, the order
+ *	of the swap_map_page structures in the map is reversed so that they
+ *	can be read from swap in the original order.  This causes the data
+ *	pages to be loaded in exactly the same order in which they have been
+ *	saved.
+ *
+ *	During resume we only need to use one swap_map_page structure
+ *	at a time, which means that we only need to use two memory pages for
+ *	reading the image - one for reading the swap_map_page structures
+ *	and the second for reading the data pages from swap.
  */
-static void data_free(void)
+
+#define MAP_PAGE_SIZE	((PAGE_SIZE - sizeof(swp_entry_t) - sizeof(void *)) \
+			/ sizeof(swp_entry_t))
+
+struct swap_map_page {
+	swp_entry_t		entries[MAP_PAGE_SIZE];
+	swp_entry_t		next_swap;
+	struct swap_map_page	*next;
+};
+
+static inline void free_swap_map(struct swap_map_page *swap_map)
 {
-	swp_entry_t entry;
-	struct pbe *p;
+	struct swap_map_page *swp;
 
-	for_each_pbe (p, pagedir_nosave) {
-		entry = p->swap_address;
-		if (entry.val)
-			swap_free(entry);
-		else
-			break;
+	while (swap_map) {
+		swp = swap_map->next;
+		free_page((unsigned long)swap_map);
+		swap_map = swp;
+	}
+}
+
+static struct swap_map_page *alloc_swap_map(unsigned int nr_pages)
+{
+	struct swap_map_page *swap_map, *swp;
+	unsigned n = 0;
+
+	if (!nr_pages)
+		return NULL;
+
+	pr_debug("alloc_swap_map(): nr_pages = %d\n", nr_pages);
+	swap_map = (struct swap_map_page *)get_zeroed_page(GFP_ATOMIC);
+	swp = swap_map;
+	for (n = MAP_PAGE_SIZE; n < nr_pages; n += MAP_PAGE_SIZE) {
+		swp->next = (struct swap_map_page *)get_zeroed_page(GFP_ATOMIC);
+		swp = swp->next;
+		if (!swp) {
+			free_swap_map(swap_map);
+			return NULL;
+		}
 	}
+	return swap_map;
 }
 
 /**
- *	data_write - Write saved image to swap.
- *
- *	Walk the list of pages in the image and sync each one to swap.
+ *	reverse_swap_map - reverse the order of pages in the swap map
+ *	@swap_map
  */
-static int data_write(void)
+
+static inline struct swap_map_page *reverse_swap_map(struct swap_map_page *swap_map)
 {
-	int error = 0, i = 0;
-	unsigned int mod = nr_copy_pages / 100;
-	struct pbe *p;
+	struct swap_map_page *prev, *next;
 
-	if (!mod)
-		mod = 1;
+	prev = NULL;
+	while (swap_map) {
+		next = swap_map->next;
+		swap_map->next = prev;
+		prev = swap_map;
+		swap_map = next;
+	}
+	return prev;
+}
 
-	printk( "Writing data to swap (%d pages)...     ", nr_copy_pages );
-	for_each_pbe (p, pagedir_nosave) {
-		if (!(i%mod))
-			printk( "\b\b\b\b%3d%%", i / mod );
-		if ((error = write_page(p->address, &p->swap_address)))
+/**
+ *	free_swap_map_entries - free the swap entries allocated to store
+ *	the swap map @swap_map (this is only called in case of an error)
+ */
+static inline void free_swap_map_entries(struct swap_map_page *swap_map)
+{
+	while (swap_map) {
+		if (swap_map->next_swap.val)
+			swap_free(swap_map->next_swap);
+		swap_map = swap_map->next;
+	}
+}
+
+/**
+ *	save_swap_map - save the swap map used for tracing the data pages
+ *	stored in the swap
+ */
+
+static int save_swap_map(struct swap_map_page *swap_map, swp_entry_t *start)
+{
+	swp_entry_t entry = (swp_entry_t){0};
+	int error;
+
+	while (swap_map) {
+		swap_map->next_swap = entry;
+		if ((error = write_page((unsigned long)swap_map, &entry)))
 			return error;
-		i++;
+		swap_map = swap_map->next;
+	}
+	*start = entry;
+	return 0;
+}
+
+/**
+ *	free_image_entries - free the swap entries allocated to store
+ *	the image data pages (this is only called in case of an error)
+ */
+
+static inline void free_image_entries(struct swap_map_page *swp)
+{
+	unsigned k;
+
+	while (swp) {
+		for (k = 0; k < MAP_PAGE_SIZE; k++)
+			if (swp->entries[k].val)
+				swap_free(swp->entries[k]);
+		swp = swp->next;
+	}
+}
+
+/**
+ *	The swap_map_handle structure is used for handling the swap map in
+ *	a file-alike way
+ */
+
+struct swap_map_handle {
+	struct swap_map_page *cur;
+	unsigned int k;
+};
+
+static inline void init_swap_map_handle(struct swap_map_handle *handle,
+                                        struct swap_map_page *map)
+{
+	handle->cur = map;
+	handle->k = 0;
+}
+
+static inline int swap_map_write_page(struct swap_map_handle *handle,
+                                      unsigned long addr)
+{
+	int error;
+
+	error = write_page(addr, handle->cur->entries + handle->k);
+	if (error)
+		return error;
+	if (++handle->k >= MAP_PAGE_SIZE) {
+		handle->cur = handle->cur->next;
+		handle->k = 0;
+	}
+	return 0;
+}
+
+/**
+ *	save_image_data - save the data pages pointed to by the PBEs
+ *	from the list @pblist using the swap map handle @handle
+ *	(assume there are @nr_pages data pages to save)
+ */
+
+static int save_image_data(struct pbe *pblist,
+                           struct swap_map_handle *handle,
+                           unsigned int nr_pages)
+{
+	unsigned int m;
+	struct pbe *p;
+	int error = 0;
+
+	printk("Saving image data pages (%u pages) ...     ", nr_pages);
+	m = nr_pages / 100;
+	if (!m)
+		m = 1;
+	nr_pages = 0;
+	for_each_pbe (p, pblist) {
+		error = swap_map_write_page(handle, p->address);
+		if (error)
+			break;
+		if (!(nr_pages % m))
+			printk("\b\b\b\b%3d%%", nr_pages / m);
+		nr_pages++;
 	}
-	printk("\b\b\b\bdone\n");
+	if (!error)
+		printk("\b\b\b\bdone\n");
 	return error;
 }
 
@@ -295,19 +443,20 @@
 	pr_debug(" swsusp: UTS Domain: %s\n",swsusp_info.uts.domainname);
 	pr_debug(" swsusp: CPUs: %d\n",swsusp_info.cpus);
 	pr_debug(" swsusp: Image: %ld Pages\n",swsusp_info.image_pages);
-	pr_debug(" swsusp: Pagedir: %ld Pages\n",swsusp_info.pagedir_pages);
+	pr_debug(" swsusp: Total: %ld Pages\n", swsusp_info.pages);
 }
 
-static void init_header(void)
+static void init_header(unsigned int nr_pages)
 {
 	memset(&swsusp_info, 0, sizeof(swsusp_info));
 	swsusp_info.version_code = LINUX_VERSION_CODE;
 	swsusp_info.num_physpages = num_physpages;
 	memcpy(&swsusp_info.uts, &system_utsname, sizeof(system_utsname));
 
-	swsusp_info.suspend_pagedir = pagedir_nosave;
 	swsusp_info.cpus = num_online_cpus();
-	swsusp_info.image_pages = nr_copy_pages;
+	swsusp_info.image_pages = nr_pages;
+	swsusp_info.pages = nr_pages +
+		((nr_pages * sizeof(long) + PAGE_SIZE - 1) >> PAGE_SHIFT);
 }
 
 static int close_swap(void)
@@ -326,39 +475,53 @@
 }
 
 /**
- *	free_pagedir_entries - Free pages used by the page directory.
- *
- *	This is used during suspend for error recovery.
+ *	pack_orig_addresses - the .orig_address fields of the PBEs from the
+ *	list starting at @pbe are stored in the array @buf[] (1 page)
  */
 
-static void free_pagedir_entries(void)
+static inline struct pbe *pack_orig_addresses(unsigned long *buf,
+                                              struct pbe *pbe)
 {
-	int i;
+	int j;
 
-	for (i = 0; i < swsusp_info.pagedir_pages; i++)
-		swap_free(swsusp_info.pagedir[i]);
+	for (j = 0; j < PAGE_SIZE / sizeof(long) && pbe; j++) {
+		buf[j] = pbe->orig_address;
+		pbe = pbe->next;
+	}
+	if (!pbe)
+		for (; j < PAGE_SIZE / sizeof(long); j++)
+			buf[j] = 0;
+	return pbe;
 }
 
-
 /**
- *	write_pagedir - Write the array of pages holding the page directory.
- *	@last:	Last swap entry we write (needed for header).
+ *	save_image_metadata - save the .orig_address fields of the PBEs
+ *	from the list @pblist using the swap map handle @handle
  */
 
-static int write_pagedir(void)
+static int save_image_metadata(struct pbe *pblist,
+                               struct swap_map_handle *handle)
 {
-	int error = 0;
+	unsigned long *buf;
 	unsigned int n = 0;
-	struct pbe *pbe;
+	struct pbe *p;
+	int error = 0;
 
-	printk( "Writing pagedir...");
-	for_each_pb_page (pbe, pagedir_nosave) {
-		if ((error = write_page((unsigned long)pbe, &swsusp_info.pagedir[n++])))
-			return error;
+	printk("Saving image metadata ... ");
+	buf = (unsigned long *)get_zeroed_page(GFP_ATOMIC);
+	if (!buf)
+		return -ENOMEM;
+	p = pblist;
+	while (p) {
+		p = pack_orig_addresses(buf, p);
+		error = swap_map_write_page(handle, (unsigned long)buf);
+		if (error)
+			break;
+		n++;
 	}
-
-	swsusp_info.pagedir_pages = n;
-	printk("done (%u pages)\n", n);
+	free_page((unsigned long)buf);
+	if (!error)
+		printk("done (%u pages saved)\n", n);
 	return error;
 }
 
@@ -384,33 +547,48 @@
 
 /**
  *	write_suspend_image - Write entire image and metadata.
- *
  */
-static int write_suspend_image(void)
+static int write_suspend_image(struct pbe *pblist, unsigned int nr_pages)
 {
+	struct swap_map_page *swap_map;
+	struct swap_map_handle handle;
 	int error;
 
-	if (!enough_swap(nr_copy_pages)) {
+	if (!enough_swap(nr_pages)) {
 		printk(KERN_ERR "swsusp: Not enough free swap\n");
 		return -ENOSPC;
 	}
 
-	init_header();
-	if ((error = data_write()))
-		goto FreeData;
+	init_header(nr_pages);
+	swap_map = alloc_swap_map(swsusp_info.pages);
+	if (!swap_map)
+		return -ENOMEM;
+	init_swap_map_handle(&handle, swap_map);
 
-	if ((error = write_pagedir()))
-		goto FreePagedir;
+	error = save_image_metadata(pblist, &handle);
+	if (!error)
+		error = save_image_data(pblist, &handle, nr_pages);
+	if (error)
+		goto Free_image_entries;
+
+	swap_map = reverse_swap_map(swap_map);
+	error = save_swap_map(swap_map, &swsusp_info.start);
+	if (error)
+		goto Free_map_entries;
+
+	error = close_swap();
+	if (error)
+		goto Free_map_entries;
 
-	if ((error = close_swap()))
-		goto FreePagedir;
- Done:
+Free_swap_map:
+	free_swap_map(swap_map);
 	return error;
- FreePagedir:
-	free_pagedir_entries();
- FreeData:
-	data_free();
-	goto Done;
+
+Free_map_entries:
+	free_swap_map_entries(swap_map);
+Free_image_entries:
+	free_image_entries(swap_map);
+	goto Free_swap_map;
 }
 
 /* It is important _NOT_ to umount filesystems at this point. We want
@@ -418,7 +596,7 @@
  * filesystem clean: it is not. (And it does not matter, if we resume
  * correctly, we'll mark system clean, anyway.)
  */
-int swsusp_write(void)
+int swsusp_write(struct pbe *pblist, unsigned int nr_pages)
 {
 	int error;
 
@@ -427,14 +605,12 @@
 		return error;
 	}
 	lock_swapdevices();
-	error = write_suspend_image();
+	error = write_suspend_image(pblist, nr_pages);
 	/* This will unlock ignored swap devices since writing is finished */
 	lock_swapdevices();
 	return error;
 }
 
-
-
 int swsusp_suspend(void)
 {
 	int error;
@@ -531,7 +707,6 @@
 	/* We assume both lists contain the same number of elements */
 	while (src) {
 		dst->orig_address = src->orig_address;
-		dst->swap_address = src->swap_address;
 		dst = dst->next;
 		src = src->next;
 	}
@@ -611,6 +786,61 @@
 	return submit(WRITE, page_off, page);
 }
 
+/**
+ *	The following functions allow us to read data using a swap map
+ *	in a file-alike way
+ */
+
+static inline void release_swap_map_reader(struct swap_map_handle *handle)
+{
+	if (handle->cur)
+		free_page((unsigned long)handle->cur);
+	handle->cur = NULL;
+}
+
+static inline int get_swap_map_reader(struct swap_map_handle *handle,
+                                      swp_entry_t start)
+{
+	int error;
+
+	if (!swp_offset(start))
+		return -EINVAL;
+	handle->cur = (struct swap_map_page *)get_zeroed_page(GFP_ATOMIC);
+	if (!handle->cur)
+		return -ENOMEM;
+	error = bio_read_page(swp_offset(start), handle->cur);
+	if (error) {
+		release_swap_map_reader(handle);
+		return error;
+	}
+	handle->k = 0;
+	return 0;
+}
+
+static inline int swap_map_read_page(struct swap_map_handle *handle, void *buf)
+{
+	unsigned long offset;
+	int error;
+
+	if (!handle->cur)
+		return -EINVAL;
+	offset = swp_offset(handle->cur->entries[handle->k]);
+	if (!offset)
+		return -EINVAL;
+	error = bio_read_page(offset, buf);
+	if (error)
+		return error;
+	if (++handle->k >= MAP_PAGE_SIZE) {
+		handle->k = 0;
+		offset = swp_offset(handle->cur->next_swap);
+		if (!offset)
+			release_swap_map_reader(handle);
+		else
+			error = bio_read_page(offset, handle->cur);
+	}
+	return error;
+}
+
 /*
  * Sanity check if this image makes sense with this kernel/swap context
  * I really don't think that it's foolproof but more than nothing..
@@ -639,7 +869,6 @@
 	return NULL;
 }
 
-
 static int check_header(void)
 {
 	const char *reason = NULL;
@@ -653,7 +882,6 @@
 		printk(KERN_ERR "swsusp: Resume mismatch: %s\n",reason);
 		return -EPERM;
 	}
-	nr_copy_pages = swsusp_info.image_pages;
 	return error;
 }
 
@@ -680,75 +908,88 @@
 }
 
 /**
- *	data_read - Read image pages from swap.
- *
- *	You do not need to check for overlaps, check_pagedir()
- *	already did that.
+ *	load_image_data - load the image data using the swap map handle
+ *	@handle and store them using the page backup list @pblist
+ *	(assume there are @nr_pages pages to load)
  */
 
-static int data_read(struct pbe *pblist)
+static int load_image_data(struct pbe *pblist,
+                           struct swap_map_handle *handle,
+                           unsigned int nr_pages)
 {
+	int error;
+	unsigned int m;
 	struct pbe *p;
-	int error = 0;
-	int i = 0;
-	int mod = swsusp_info.image_pages / 100;
-
-	if (!mod)
-		mod = 1;
-
-	printk("swsusp: Reading image data (%lu pages):     ",
-			swsusp_info.image_pages);
-
-	for_each_pbe (p, pblist) {
-		if (!(i % mod))
-			printk("\b\b\b\b%3d%%", i / mod);
 
-		if ((error = bio_read_page(swp_offset(p->swap_address),
-						(void *)p->address)))
-			return error;
-
-		i++;
+	if (!pblist)
+		return -EINVAL;
+	printk("Loading image data pages (%u pages) ...     ", nr_pages);
+	m = nr_pages / 100;
+	if (!m)
+		m = 1;
+	nr_pages = 0;
+	p = pblist;
+	while (p) {
+		error = swap_map_read_page(handle, (void *)p->address);
+		if (error)
+			break;
+		p = p->next;
+		if (!(nr_pages % m))
+			printk("\b\b\b\b%3d%%", nr_pages / m);
+		nr_pages++;
 	}
-	printk("\b\b\b\bdone\n");
+	if (!error)
+		printk("\b\b\b\bdone\n");
 	return error;
 }
 
 /**
- *	read_pagedir - Read page backup list pages from swap
+ *	unpack_orig_addresses - copy the elements of @buf[] (1 page) to
+ *	the PBEs in the list starting at @pbe
  */
 
-static int read_pagedir(struct pbe *pblist)
+static inline struct pbe *unpack_orig_addresses(unsigned long *buf,
+                                                struct pbe *pbe)
 {
-	struct pbe *pbpage, *p;
-	unsigned int i = 0;
-	int error;
+	int j;
 
-	if (!pblist)
-		return -EFAULT;
+	for (j = 0; j < PAGE_SIZE / sizeof(long) && pbe; j++) {
+		pbe->orig_address = buf[j];
+		pbe = pbe->next;
+	}
+	return pbe;
+}
 
-	printk("swsusp: Reading pagedir (%lu pages)\n",
-			swsusp_info.pagedir_pages);
+/**
+ *	load_image_metadata - load the image metadata using the swap map
+ *	handle @handle and put them into the PBEs in the list @pblist
+ */
 
-	for_each_pb_page (pbpage, pblist) {
-		unsigned long offset = swp_offset(swsusp_info.pagedir[i++]);
+static int load_image_metadata(struct pbe *pblist, struct swap_map_handle *handle)
+{
+	struct pbe *p;
+	unsigned long *buf;
+	unsigned int n = 0;
+	int error = 0;
 
-		error = -EFAULT;
-		if (offset) {
-			p = (pbpage + PB_PAGE_SKIP)->next;
-			error = bio_read_page(offset, (void *)pbpage);
-			(pbpage + PB_PAGE_SKIP)->next = p;
-		}
+	printk("Loading image metadata ... ");
+	buf = (unsigned long *)get_zeroed_page(GFP_ATOMIC);
+	if (!buf)
+		return -ENOMEM;
+	p = pblist;
+	while (p) {
+		error = swap_map_read_page(handle, buf);
 		if (error)
 			break;
+		p = unpack_orig_addresses(buf, p);
+		n++;
 	}
-
+	free_page((unsigned long)buf);
 	if (!error)
-		BUG_ON(i != swsusp_info.pagedir_pages);
-
+		printk("done (%u pages loaded)\n", n);
 	return error;
 }
 
-
 static int check_suspend_image(void)
 {
 	int error = 0;
@@ -762,34 +1003,39 @@
 	return 0;
 }
 
-static int read_suspend_image(void)
+static int read_suspend_image(struct pbe **pblist_ptr)
 {
 	int error = 0;
-	struct pbe *p;
+	struct pbe *p, *pblist;
+	struct swap_map_handle handle;
+	unsigned int nr_pages = swsusp_info.image_pages;
 
-	if (!(p = alloc_pagedir(nr_copy_pages, GFP_ATOMIC, 0)))
+	p = alloc_pagedir(nr_pages, GFP_ATOMIC, 0);
+	if (!p)
 		return -ENOMEM;
-
-	if ((error = read_pagedir(p)))
+	error = get_swap_map_reader(&handle, swsusp_info.start);
+	if (error)
+		/* The PBE list at p will be released by swsusp_free() */
 		return error;
-	create_pbe_list(p, nr_copy_pages);
-	mark_unsafe_pages(p);
-	pagedir_nosave = alloc_pagedir(nr_copy_pages, GFP_ATOMIC, 1);
-	if (pagedir_nosave) {
-		create_pbe_list(pagedir_nosave, nr_copy_pages);
-		copy_page_backup_list(pagedir_nosave, p);
-	}
-	free_pagedir(p);
-	if (!pagedir_nosave)
-		return -ENOMEM;
-
-	/* Allocate memory for the image and read the data from swap */
-
-	error = alloc_data_pages(pagedir_nosave, GFP_ATOMIC, 1);
-
-	if (!error)
-		error = data_read(pagedir_nosave);
+	error = load_image_metadata(p, &handle);
+	if (!error) {
+		mark_unsafe_pages(p);
+		pblist = alloc_pagedir(nr_pages, GFP_ATOMIC, 1);
+		if (pblist)
+			copy_page_backup_list(pblist, p);
+		free_pagedir(p);
+		if (!pblist)
+			error = -ENOMEM;
 
+		/* Allocate memory for the image and read the data from swap */
+		if (!error)
+			error = alloc_data_pages(pblist, GFP_ATOMIC, 1);
+		if (!error)
+			error = load_image_data(pblist, &handle, nr_pages);
+		if (!error)
+			*pblist_ptr = pblist;
+	}
+	release_swap_map_reader(&handle);
 	return error;
 }
 
@@ -821,7 +1067,7 @@
  *	swsusp_read - Read saved image from swap.
  */
 
-int swsusp_read(void)
+int swsusp_read(struct pbe **pblist_ptr)
 {
 	int error;
 
@@ -830,7 +1076,7 @@
 		return PTR_ERR(resume_bdev);
 	}
 
-	error = read_suspend_image();
+	error = read_suspend_image(pblist_ptr);
 	blkdev_put(resume_bdev);
 
 	if (!error)
Index: linux-2.6.14-mm2/kernel/power/power.h
===================================================================
--- linux-2.6.14-mm2.orig/kernel/power/power.h	2005-11-14 22:39:03.000000000 +0100
+++ linux-2.6.14-mm2/kernel/power/power.h	2005-11-14 22:42:16.000000000 +0100
@@ -9,19 +9,14 @@
 #define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1)
 #endif
 
-#define MAX_PBES	((PAGE_SIZE - sizeof(struct new_utsname) \
-			- 4 - 3*sizeof(unsigned long) - sizeof(int) \
-			- sizeof(void *)) / sizeof(swp_entry_t))
-
 struct swsusp_info {
 	struct new_utsname	uts;
 	u32			version_code;
 	unsigned long		num_physpages;
 	int			cpus;
 	unsigned long		image_pages;
-	unsigned long		pagedir_pages;
-	suspend_pagedir_t	* suspend_pagedir;
-	swp_entry_t		pagedir[MAX_PBES];
+	unsigned long		pages;
+	swp_entry_t		start;
 } __attribute__((aligned(PAGE_SIZE)));
 
 
@@ -67,6 +62,8 @@
 
 extern void free_pagedir(struct pbe *pblist);
 extern struct pbe *alloc_pagedir(unsigned nr_pages, gfp_t gfp_mask, int safe_needed);
-extern void create_pbe_list(struct pbe *pblist, unsigned nr_pages);
 extern void swsusp_free(void);
 extern int alloc_data_pages(struct pbe *pblist, gfp_t gfp_mask, int safe_needed);
+extern unsigned int snapshot_nr_pages(void);
+extern struct pbe *snapshot_pblist(void);
+extern void snapshot_pblist_set(struct pbe *pblist);
Index: linux-2.6.14-mm2/kernel/power/snapshot.c
===================================================================
--- linux-2.6.14-mm2.orig/kernel/power/snapshot.c	2005-11-14 22:39:03.000000000 +0100
+++ linux-2.6.14-mm2/kernel/power/snapshot.c	2005-11-14 22:42:56.000000000 +0100
@@ -33,6 +33,9 @@
 
 #include "power.h"
 
+struct pbe *pagedir_nosave;
+unsigned int nr_copy_pages;
+
 #ifdef CONFIG_HIGHMEM
 struct highmem_page {
 	char *data;
@@ -244,7 +247,7 @@
  *	of memory pages allocated with alloc_pagedir()
  */
 
-void create_pbe_list(struct pbe *pblist, unsigned int nr_pages)
+static inline void create_pbe_list(struct pbe *pblist, unsigned int nr_pages)
 {
 	struct pbe *pbpage, *p;
 	unsigned int num = PBES_PER_PAGE;
@@ -261,7 +264,6 @@
 			p->next = p + 1;
 		p->next = NULL;
 	}
-	pr_debug("create_pbe_list(): initialized %d PBEs\n", num);
 }
 
 /**
@@ -332,7 +334,8 @@
 	if (!pbe) { /* get_zeroed_page() failed */
 		free_pagedir(pblist);
 		pblist = NULL;
-        }
+        } else
+        	create_pbe_list(pblist, nr_pages);
 	return pblist;
 }
 
@@ -395,7 +398,6 @@
 		printk(KERN_ERR "suspend: Allocating pagedir failed.\n");
 		return NULL;
 	}
-	create_pbe_list(pblist, nr_pages);
 
 	if (alloc_data_pages(pblist, GFP_ATOMIC | __GFP_COLD, 0)) {
 		printk(KERN_ERR "suspend: Allocating image pages failed.\n");
@@ -421,10 +423,6 @@
 		 (nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE,
 		 PAGES_FOR_IO, nr_free_pages());
 
-	/* This is needed because of the fixed size of swsusp_info */
-	if (MAX_PBES < (nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE)
-		return -ENOSPC;
-
 	if (!enough_free_mem(nr_pages)) {
 		printk(KERN_ERR "swsusp: Not enough free memory\n");
 		return -ENOMEM;
Index: linux-2.6.14-mm2/include/linux/suspend.h
===================================================================
--- linux-2.6.14-mm2.orig/include/linux/suspend.h	2005-11-14 22:39:03.000000000 +0100
+++ linux-2.6.14-mm2/include/linux/suspend.h	2005-11-14 22:42:16.000000000 +0100
@@ -14,11 +14,7 @@
 typedef struct pbe {
 	unsigned long address;		/* address of the copy */
 	unsigned long orig_address;	/* original address of page */
-	swp_entry_t swap_address;	
-
-	struct pbe *next;	/* also used as scratch space at
-				 * end of page (see link, diskpage)
-				 */
+	struct pbe *next;
 } suspend_pagedir_t;
 
 #define for_each_pbe(pbe, pblist) \
Index: linux-2.6.14-mm2/kernel/power/disk.c
===================================================================
--- linux-2.6.14-mm2.orig/kernel/power/disk.c	2005-11-14 22:39:03.000000000 +0100
+++ linux-2.6.14-mm2/kernel/power/disk.c	2005-11-14 22:42:16.000000000 +0100
@@ -25,9 +25,9 @@
 extern suspend_disk_method_t pm_disk_mode;
 
 extern int swsusp_suspend(void);
-extern int swsusp_write(void);
+extern int swsusp_write(struct pbe *pblist, unsigned int nr_pages);
 extern int swsusp_check(void);
-extern int swsusp_read(void);
+extern int swsusp_read(struct pbe **pblist_ptr);
 extern void swsusp_close(void);
 extern int swsusp_resume(void);
 
@@ -176,7 +176,7 @@
 	if (in_suspend) {
 		device_resume();
 		pr_debug("PM: writing image.\n");
-		error = swsusp_write();
+		error = swsusp_write(pagedir_nosave, nr_copy_pages);
 		if (!error)
 			power_down(pm_disk_mode);
 		else {
@@ -247,7 +247,7 @@
 
 	pr_debug("PM: Reading swsusp image.\n");
 
-	if ((error = swsusp_read())) {
+	if ((error = swsusp_read(&pagedir_nosave))) {
 		swsusp_free();
 		goto Thaw;
 	}

