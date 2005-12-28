Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbVL1AlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbVL1AlP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 19:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVL1AlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 19:41:14 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:31677 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932421AbVL1AlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 19:41:13 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Linux PM <linux-pm@osdl.org>
Subject: [RFC/RFT][PATCH -mm 1/4] swsusp: low level interface
Date: Wed, 28 Dec 2005 01:17:55 +0100
User-Agent: KMail/1.9
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
References: <200512280108.47253.rjw@sisk.pl>
In-Reply-To: <200512280108.47253.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200512280117.56239.rjw@sisk.pl>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the low level interface that can be used for handling
the snapshot of the system memory by both the in-kernel swap-writing
and reading code of swsusp and the userland interface code introduced
by the next patch.


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 kernel/power/disk.c     |   12 -
 kernel/power/power.h    |   25 ++-
 kernel/power/snapshot.c |  324 +++++++++++++++++++++++++++++++++++++++++
 kernel/power/swsusp.c   |  372 ++++++++++++------------------------------------
 4 files changed, 439 insertions(+), 294 deletions(-)

Index: linux-2.6.15-rc5-mm3/kernel/power/disk.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/kernel/power/disk.c	2005-12-27 21:49:58.000000000 +0100
+++ linux-2.6.15-rc5-mm3/kernel/power/disk.c	2005-12-27 21:53:03.000000000 +0100
@@ -26,9 +26,9 @@ extern suspend_disk_method_t pm_disk_mod
 
 extern int swsusp_shrink_memory(void);
 extern int swsusp_suspend(void);
-extern int swsusp_write(struct pbe *pblist, unsigned int nr_pages);
+extern int swsusp_write(void);
 extern int swsusp_check(void);
-extern int swsusp_read(struct pbe **pblist_ptr);
+extern int swsusp_read(void);
 extern void swsusp_close(void);
 extern int swsusp_resume(void);
 
@@ -70,10 +70,6 @@ static void power_down(suspend_disk_meth
 	while(1);
 }
 
-
-static int in_suspend __nosavedata = 0;
-
-
 static inline void platform_finish(void)
 {
 	if (pm_disk_mode == PM_DISK_PLATFORM) {
@@ -152,7 +148,7 @@ int pm_suspend_disk(void)
 	if (in_suspend) {
 		device_resume();
 		pr_debug("PM: writing image.\n");
-		error = swsusp_write(pagedir_nosave, nr_copy_pages);
+		error = swsusp_write();
 		if (!error)
 			power_down(pm_disk_mode);
 		else {
@@ -223,7 +219,7 @@ static int software_resume(void)
 
 	pr_debug("PM: Reading swsusp image.\n");
 
-	if ((error = swsusp_read(&pagedir_nosave))) {
+	if ((error = swsusp_read())) {
 		swsusp_free();
 		goto Thaw;
 	}
Index: linux-2.6.15-rc5-mm3/kernel/power/power.h
===================================================================
--- linux-2.6.15-rc5-mm3.orig/kernel/power/power.h	2005-12-27 21:49:58.000000000 +0100
+++ linux-2.6.15-rc5-mm3/kernel/power/power.h	2005-12-28 01:17:06.000000000 +0100
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
+int snapshot_image_ready(struct snapshot_handle *handle);
Index: linux-2.6.15-rc5-mm3/kernel/power/swsusp.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/kernel/power/swsusp.c	2005-12-27 21:49:58.000000000 +0100
+++ linux-2.6.15-rc5-mm3/kernel/power/swsusp.c	2005-12-28 01:16:44.000000000 +0100
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
@@ -149,7 +149,7 @@ static inline int is_resume_device(const
 		swsusp_resume_device == MKDEV(imajor(inode), iminor(inode));
 }
 
-static int swsusp_swap_check(void) /* This is called before saving image */
+int swsusp_get_swap_index(void)
 {
 	int i;
 
@@ -161,36 +161,42 @@ static int swsusp_swap_check(void) /* Th
 			continue;
 		if (is_resume_device(swap_info + i)) {
 			spin_unlock(&swap_lock);
-			root_swap = i;
-			return 0;
+			return i;
 		}
 	}
 	spin_unlock(&swap_lock);
 	return -ENODEV;
 }
 
+static int swsusp_swap_check(void) /* This is called before saving image */
+{
+	int res = swsusp_get_swap_index();
+
+	if (res >= 0) {
+		root_swap = res;
+		return 0;
+	}
+	return res;
+}
+
 /**
  *	write_page - Write one page to a fresh swap location.
- *	@addr:	Address we're writing.
+ *	@buf:	Address we're writing.
  *	@loc:	Place to store the entry we used.
- *
- *	Allocate a new swap entry and 'sync' it. Note we discard -EIO
- *	errors. That is an artifact left over from swsusp. It did not
- *	check the return of rw_swap_page_sync() at all, since most pages
- *	written back to swap would return -EIO.
- *	This is a partial improvement, since we will at least return other
- *	errors, though we need to eventually fix the damn code.
  */
-static int write_page(unsigned long addr, swp_entry_t *loc)
+
+static int write_page(void *buf, swp_entry_t *loc)
 {
 	swp_entry_t entry;
 	int error = -ENOSPC;
 
 	entry = get_swap_page_of_type(root_swap);
 	if (swp_offset(entry)) {
-		error = rw_swap_page_sync(WRITE, entry, virt_to_page(addr));
-		if (!error || error == -EIO)
+		error = rw_swap_page_sync(WRITE, entry, virt_to_page(buf));
+		if (!error)
 			*loc = entry;
+		else
+			swap_free(entry);
 	}
 	return error;
 }
@@ -309,7 +315,7 @@ static int save_swap_map(struct swap_map
 
 	while (swap_map) {
 		swap_map->next_swap = entry;
-		if ((error = write_page((unsigned long)swap_map, &entry)))
+		if ((error = write_page(swap_map, &entry)))
 			return error;
 		swap_map = swap_map->next;
 	}
@@ -351,12 +357,11 @@ static inline void init_swap_map_handle(
 	handle->k = 0;
 }
 
-static inline int swap_map_write_page(struct swap_map_handle *handle,
-                                      unsigned long addr)
+static inline int swap_map_write_page(struct swap_map_handle *handle, void *buf)
 {
 	int error;
 
-	error = write_page(addr, handle->cur->entries + handle->k);
+	error = write_page(buf, handle->cur->entries + handle->k);
 	if (error)
 		return error;
 	if (++handle->k >= MAP_PAGE_SIZE) {
@@ -367,17 +372,15 @@ static inline int swap_map_write_page(st
 }
 
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
@@ -385,96 +388,39 @@ static int save_image_data(struct pbe *p
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
+			error = swap_map_write_page(handle, data_of(*snapshot));
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
 /**
- *	pack_orig_addresses - the .orig_address fields of the PBEs from the
- *	list starting at @pbe are stored in the array @buf[] (1 page)
+ *	swsusp_available_swap - check the total amount of swap
+ *	space avaiable from given swap partition/file
  */
 
-static inline struct pbe *pack_orig_addresses(unsigned long *buf,
-                                              struct pbe *pbe)
+unsigned int swsusp_available_swap(unsigned int swap)
 {
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
 	unsigned int n = 0;
-	struct pbe *p;
-	int error = 0;
 
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
+	if (swap < MAX_SWAPFILES) {
+		spin_lock(&swap_lock);
+		if (swap_info[swap].flags & SWP_WRITEOK)
+			n = swap_info[swap].pages -
+				swap_info[swap].inuse_pages;
+		spin_unlock(&swap_lock);
 	}
-	free_page((unsigned long)buf);
-	if (!error)
-		printk("done (%u pages saved)\n", n);
-	return error;
+	return n;
 }
 
 /**
@@ -486,8 +432,7 @@ static int save_image_metadata(struct pb
 
 static int enough_swap(unsigned int nr_pages)
 {
-	unsigned int free_swap = swap_info[root_swap].pages -
-		swap_info[root_swap].inuse_pages;
+	unsigned int free_swap = swsusp_available_swap(root_swap);
 
 	pr_debug("swsusp: free swap pages: %u\n", free_swap);
 	return free_swap > (nr_pages + PAGES_FOR_IO +
@@ -503,10 +448,13 @@ static int enough_swap(unsigned int nr_p
  *	correctly, we'll mark system clean, anyway.)
  */
 
-int swsusp_write(struct pbe *pblist, unsigned int nr_pages)
+int swsusp_write(void)
 {
 	struct swap_map_page *swap_map;
 	struct swap_map_handle handle;
+	struct snapshot_handle snapshot;
+	struct swsusp_info *header;
+	unsigned int nr_pages;
 	swp_entry_t start;
 	int error;
 
@@ -514,22 +462,24 @@ int swsusp_write(struct pbe *pblist, uns
 		printk(KERN_ERR "swsusp: Cannot find swap device, try swapon -a.\n");
 		return error;
 	}
+	memset(&snapshot, 0, sizeof(struct snapshot_handle));
+	error = snapshot_read_next(&snapshot, PAGE_SIZE);
+	if (error < PAGE_SIZE)
+		return error < 0 ? error : -EFAULT;
+	header = (struct swsusp_info *)data_of(snapshot);
+	nr_pages = header->image_pages;
 	if (!enough_swap(nr_pages)) {
 		printk(KERN_ERR "swsusp: Not enough free swap\n");
 		return -ENOSPC;
 	}
-
-	init_header(nr_pages);
-	swap_map = alloc_swap_map(swsusp_info.pages);
+	swap_map = alloc_swap_map(header->pages);
 	if (!swap_map)
 		return -ENOMEM;
 	init_swap_map_handle(&handle, swap_map);
 
-	error = swap_map_write_page(&handle, (unsigned long)&swsusp_info);
+	error = swap_map_write_page(&handle, header);
 	if (!error)
-		error = save_image_metadata(pblist, &handle);
-	if (!error)
-		error = save_image_data(pblist, &handle, nr_pages);
+		error = save_image(&handle, &snapshot, nr_pages);
 	if (error)
 		goto Free_image_entries;
 
@@ -538,7 +488,6 @@ int swsusp_write(struct pbe *pblist, uns
 	if (error)
 		goto Free_map_entries;
 
-	dump_info();
 	printk( "S" );
 	error = mark_swapfiles(start);
 	printk( "|\n" );
@@ -663,45 +612,6 @@ int swsusp_resume(void)
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
@@ -816,7 +726,7 @@ static inline int swap_map_read_page(str
 		return -EINVAL;
 	offset = swp_offset(handle->cur->entries[handle->k]);
 	if (!offset)
-		return -EINVAL;
+		return -EFAULT;
 	error = bio_read_page(offset, buf);
 	if (error)
 		return error;
@@ -831,118 +741,49 @@ static inline int swap_map_read_page(str
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
+			error = swap_map_read_page(handle, data_of(*snapshot));
+			if (error)
+				break;
+			if (!(nr_pages % m))
+				printk("\b\b\b\b%3d%%", nr_pages / m);
+			nr_pages++;
+		}
+	} while (ret > 0);
 	if (!error)
 		printk("\b\b\b\bdone\n");
+	if (!snapshot_image_ready(snapshot))
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
@@ -950,36 +791,17 @@ int swsusp_read(struct pbe **pblist_ptr)
 		return PTR_ERR(resume_bdev);
 	}
 
+	memset(&snapshot, 0, sizeof(struct snapshot_handle));
+	error = snapshot_write_next(&snapshot, PAGE_SIZE);
+	if (error < PAGE_SIZE)
+		return error < 0 ? error : -EFAULT;
+	header = (struct swsusp_info *)data_of(snapshot);
 	error = get_swap_map_reader(&handle, swsusp_header.image);
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
+		error = swap_map_read_page(&handle, header);
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
 	release_swap_map_reader(&handle);
 
Index: linux-2.6.15-rc5-mm3/kernel/power/snapshot.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/kernel/power/snapshot.c	2005-12-27 21:49:58.000000000 +0100
+++ linux-2.6.15-rc5-mm3/kernel/power/snapshot.c	2005-12-28 01:16:43.000000000 +0100
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
+static inline void release_eaten_pages(void)
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
+static inline void init_header(struct swsusp_info *info)
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
+static inline int mark_unsafe_pages(struct pbe *pblist)
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
+static inline void copy_page_backup_list(struct pbe *dst, struct pbe *src)
+{
+	/* We assume both lists contain the same number of elements */
+	while (src) {
+		dst->orig_address = src->orig_address;
+		dst = dst->next;
+		src = src->next;
+	}
+}
+
+static inline int check_header(struct swsusp_info *info)
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
+static inline int load_header(struct snapshot_handle *handle,
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
+static inline int create_image(struct snapshot_handle *handle)
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
+int snapshot_image_ready(struct snapshot_handle *handle)
+{
+	return !(!handle->pbe || handle->pbe->next ||
+		handle->page <= nr_meta_pages + nr_copy_pages);
+}

