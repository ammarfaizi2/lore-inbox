Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbVJ2Uzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbVJ2Uzf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 16:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbVJ2UzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 16:55:07 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:1711 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932191AbVJ2Uya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 16:54:30 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: [RFC][PATCH 3/6] swsusp: introduce the swap map structure and interface functions
Date: Sat, 29 Oct 2005 22:32:34 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@osdl.org
References: <200510292158.11089.rjw@sisk.pl>
In-Reply-To: <200510292158.11089.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200510292232.35403.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the main part.  It introduces a new data structure for the
swap-handling part of swsusp (the swap map structure, described in a comment)
and new functions for writing the image data to and reading them from swap.
It also introduces the interface functions allowing the snapshot-handling part
to communicate with the swap-handling part and modifies the struct pbe
structure (the swap_address member of it is no longer needed as the
swap-handling part uses its own independent data structures).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 include/linux/suspend.h |    6 
 kernel/power/power.h    |   25 +-
 kernel/power/snapshot.c |  174 +++++++++++++----
 kernel/power/swsusp.c   |  475 ++++++++++++++++++++++++++----------------------
 4 files changed, 404 insertions(+), 276 deletions(-)

Index: linux-2.6.14-rc5-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/kernel/power/swsusp.c	2005-10-29 13:24:56.000000000 +0200
+++ linux-2.6.14-rc5-mm1/kernel/power/swsusp.c	2005-10-29 14:01:42.000000000 +0200
@@ -33,6 +33,9 @@
  * Andreas Steinmetz <ast@domdv.de>:
  * Added encrypted suspend option
  *
+ * Rafael J. Wysocki <rjw@sisk.pl>
+ * Added the swap map data structure and reworked the handling of swap
+ *
  * More state savers are welcome. Especially for the scsi layer...
  *
  * For TODOs,FIXMEs also look in Documentation/power/swsusp.txt
@@ -79,24 +82,6 @@
 
 extern char resume_file[];
 
-/* Local variables that should not be affected by save */
-unsigned int nr_copy_pages __nosavedata = 0;
-
-/* Suspend pagedir is allocated before final copy, therefore it
-   must be freed after resume
-
-   Warning: this is evil. There are actually two pagedirs at time of
-   resume. One is "pagedir_save", which is empty frame allocated at
-   time of suspend, that must be freed. Second is "pagedir_nosave",
-   allocated at time of resume, that travels through memory not to
-   collide with anything.
-
-   Warning: this is even more evil than it seems. Pagedirs this file
-   talks about are completely different from page directories used by
-   MMU hardware.
- */
-suspend_pagedir_t *pagedir_nosave __nosavedata = NULL;
-suspend_pagedir_t *pagedir_save;
 
 #define SWSUSP_SIG	"S1SUSPEND"
 
@@ -187,12 +172,12 @@
 	crypto_free_tfm((struct crypto_tfm *)mem);
 }
 
-static __inline__ int crypto_write(struct pbe *p, void *mem)
+static __inline__ int crypto_write(unsigned long addr, swp_entry_t *entry, void *mem)
 {
 	int error = 0;
 	struct scatterlist src, dst;
 
-	src.page   = virt_to_page(p->address);
+	src.page   = virt_to_page((void *)addr);
 	src.offset = 0;
 	src.length = PAGE_SIZE;
 	dst.page   = virt_to_page((void *)&swsusp_header);
@@ -203,23 +188,22 @@
 					PAGE_SIZE);
 
 	if (!error)
-		error = write_page((unsigned long)&swsusp_header,
-				&(p->swap_address));
+		error = write_page((unsigned long)&swsusp_header, entry);
 	return error;
 }
 
-static __inline__ int crypto_read(struct pbe *p, void *mem)
+static __inline__ int crypto_read(unsigned long offset, void *buf, void *mem)
 {
 	int error = 0;
 	struct scatterlist src, dst;
 
-	error = bio_read_page(swp_offset(p->swap_address), (void *)p->address);
+	error = bio_read_page(offset, buf);
 	if (!error) {
 		src.offset = 0;
 		src.length = PAGE_SIZE;
 		dst.offset = 0;
 		dst.length = PAGE_SIZE;
-		src.page = dst.page = virt_to_page((void *)p->address);
+		src.page = dst.page = virt_to_page(buf);
 
 		error = crypto_cipher_decrypt((struct crypto_tfm *)mem, &dst,
 						&src, PAGE_SIZE);
@@ -236,14 +220,14 @@
 {
 }
 
-static __inline__ int crypto_write(struct pbe *p, void *mem)
+static __inline__ int crypto_write(unsigned long addr, swp_entry_t *entry, void *mem)
 {
-	return write_page(p->address, &(p->swap_address));
+	return write_page(addr, entry);
 }
 
-static __inline__ int crypto_read(struct pbe *p, void *mem)
+static __inline__ int crypto_read(unsigned long offset, void *buf, void *mem)
 {
-	return bio_read_page(swp_offset(p->swap_address), (void *)p->address);
+	return bio_read_page(offset, buf);
 }
 #endif
 
@@ -374,59 +358,6 @@
 	return error;
 }
 
-/**
- *	data_free - Free the swap entries used by the saved image.
- *
- *	Walk the list of used swap entries and free each one.
- *	This is only used for cleanup when suspend fails.
- */
-static void data_free(void)
-{
-	swp_entry_t entry;
-	struct pbe * p;
-
-	for_each_pbe(p, pagedir_nosave) {
-		entry = p->swap_address;
-		if (entry.val)
-			swap_free(entry);
-		else
-			break;
-	}
-}
-
-/**
- *	data_write - Write saved image to swap.
- *
- *	Walk the list of pages in the image and sync each one to swap.
- */
-static int data_write(void)
-{
-	int error = 0, i = 0;
-	unsigned int mod = nr_copy_pages / 100;
-	struct pbe *p;
-	void *tfm;
-
-	if ((error = crypto_init(1, &tfm)))
-		return error;
-
-	if (!mod)
-		mod = 1;
-
-	printk( "Writing data to swap (%d pages)...     ", nr_copy_pages );
-	for_each_pbe (p, pagedir_nosave) {
-		if (!(i%mod))
-			printk( "\b\b\b\b%3d%%", i / mod );
-		if ((error = crypto_write(p, tfm))) {
-			crypto_exit(tfm);
-			return error;
-		}
-		i++;
-	}
-	printk("\b\b\b\bdone\n");
-	crypto_exit(tfm);
-	return error;
-}
-
 static void dump_info(void)
 {
 	pr_debug(" swsusp: Version: %u\n",swsusp_info.version_code);
@@ -439,19 +370,19 @@
 	pr_debug(" swsusp: UTS Domain: %s\n",swsusp_info.uts.domainname);
 	pr_debug(" swsusp: CPUs: %d\n",swsusp_info.cpus);
 	pr_debug(" swsusp: Image: %ld Pages\n",swsusp_info.image_pages);
-	pr_debug(" swsusp: Pagedir: %ld Pages\n",swsusp_info.pagedir_pages);
+	pr_debug(" swsusp: Total: %ld Pages\n", swsusp_info.pages);
 }
 
-static void init_header(void)
+static void init_header(unsigned nr_pages, unsigned img_pages)
 {
 	memset(&swsusp_info, 0, sizeof(swsusp_info));
 	swsusp_info.version_code = LINUX_VERSION_CODE;
 	swsusp_info.num_physpages = num_physpages;
 	memcpy(&swsusp_info.uts, &system_utsname, sizeof(system_utsname));
 
-	swsusp_info.suspend_pagedir = pagedir_nosave;
 	swsusp_info.cpus = num_online_cpus();
-	swsusp_info.image_pages = nr_copy_pages;
+	swsusp_info.image_pages = img_pages;
+	swsusp_info.pages = nr_pages;
 }
 
 static int close_swap(void)
@@ -470,40 +401,167 @@
 }
 
 /**
- *	free_pagedir_entries - Free pages used by the page directory.
+ *	Swap map handling functions
  *
- *	This is used during suspend for error recovery.
+ *	The swap map is a data structure used for keeping track of each page
+ *	written to the swap.  It consists of many swp_map_page structures
+ *	that contain each an array of MAP_PAGE_SIZE swap entries.
+ *	These structures are linked together with the help of either the
+ *	.next (in memory) or the .next_swp (in swap) member.
+ *
+ *	The swap map is created during suspend.  At that time we need to keep
+ *	it in memory, because we have to free all of the allocated swap
+ *	entries if an error occurs.  The memory needed is preallocated
+ *	so that we know in advance if there's enough of it.
+ *
+ *	The first swp_map_page structure is filled with the swap entries that
+ *	correspond to the first MAP_PAGE_SIZE data pages written to swap and
+ *	so on.  After the all of the data pages have been written, the order
+ *	of the swp_map_page structures in the map is reversed so that they
+ *	can be read from swap in the original order.  This causes the data
+ *	pages to be loaded in exactly the same order in which they have been
+ *	saved.
+ *
+ *	During resume we only need to use one swp_map_page structure
+ *	at a time, which means that we only need to use two memory pages for
+ *	reading the image - one for reading the swp_map_page structures
+ *	and the second for reading the data pages from swap.
  */
 
-static void free_pagedir_entries(void)
+#define MAP_PAGE_SIZE	((PAGE_SIZE - sizeof(swp_entry_t) - sizeof(void *)) \
+			/ sizeof(swp_entry_t))
+
+struct swp_map_page {
+	swp_entry_t		entries[MAP_PAGE_SIZE];
+	swp_entry_t		next_swp;
+	struct swp_map_page	*next;
+};
+
+typedef struct swp_map_page swp_map_t;
+
+static inline void free_swp_map(swp_map_t *swp_map)
 {
-	int i;
+	swp_map_t *swp;
+
+	while (swp_map) {
+		swp = swp_map->next;
+		free_page((unsigned long)swp_map);
+		swp_map = swp;
+	}
+}
 
-	for (i = 0; i < swsusp_info.pagedir_pages; i++)
-		swap_free(swsusp_info.pagedir[i]);
+static swp_map_t *alloc_swp_map(unsigned nr_pages)
+{
+	swp_map_t *swp_map, *swp;
+	unsigned n = 0;
+
+	if (!nr_pages)
+		return NULL;
+
+	pr_debug("alloc_swp_map(): nr_pages = %d\n", nr_pages);
+	swp_map = (swp_map_t *)get_zeroed_page(GFP_ATOMIC);
+	swp = swp_map;
+	for (n = MAP_PAGE_SIZE; n < nr_pages; n += MAP_PAGE_SIZE) {
+		swp->next = (swp_map_t *)get_zeroed_page(GFP_ATOMIC);
+		swp = swp->next;
+		if (!swp) {
+			free_swp_map(swp_map);
+			return NULL;
+		}
+	}
+	return swp_map;
 }
 
+static inline swp_map_t *reverse_swp_map(swp_map_t *swp_map)
+{
+	swp_map_t *prev, *next;
+
+	prev = NULL;
+	while (swp_map) {
+		next = swp_map->next;
+		swp_map->next = prev;
+		prev = swp_map;
+		swp_map = next;
+	}
+	return prev;
+}
 
 /**
- *	write_pagedir - Write the array of pages holding the page directory.
- *	@last:	Last swap entry we write (needed for header).
+ *	save_swp_map - save the swap map used for tracing the data pages
+ *	stored in swap
  */
 
-static int write_pagedir(void)
+static int save_swp_map(swp_map_t *swp_map, swp_entry_t *start)
 {
-	int error = 0;
-	unsigned n = 0;
-	struct pbe * pbe;
+	swp_entry_t entry = (swp_entry_t){0};
+	int error;
 
-	printk( "Writing pagedir...");
-	for_each_pb_page (pbe, pagedir_nosave) {
-		if ((error = write_page((unsigned long)pbe, &swsusp_info.pagedir[n++])))
+	while (swp_map) {
+		swp_map->next_swp = entry;
+		if ((error = write_page((unsigned long)swp_map, &entry)))
 			return error;
+		swp_map = swp_map->next;
 	}
+	*start = entry;
+	return 0;
+}
 
-	swsusp_info.pagedir_pages = n;
-	printk("done (%u pages)\n", n);
-	return error;
+static inline void free_swp_map_entries(swp_map_t *swp_map)
+{
+	while (swp_map) {
+		if (swp_map->next_swp.val)
+			swap_free(swp_map->next_swp);
+		swp_map = swp_map->next;
+	}
+}
+
+/**
+ *	save_image - save the image data provided by the snapshot-handling
+ *	part to swap.  The swap map is used for keeping track of the
+ *	saved pages
+ */
+
+static int save_image(swp_map_t *swp, unsigned nr_pages, void *buf)
+{
+	unsigned n, k;
+	int error;
+	unsigned mod = nr_pages / 100;
+	void *tfm;
+
+	if ((error = crypto_init(1, &tfm)))
+		return error;
+	printk("Writing data to swap (%d pages) ...     ", nr_pages);
+	n = 0;
+	while (swp) {
+		for (k = 0; k < MAP_PAGE_SIZE && n < nr_pages; k++, n++) {
+			error = snapshot_send_page(buf);
+			if (!error)
+				error = crypto_write((unsigned long)buf,
+						swp->entries + k, tfm);
+			if (error) {
+				crypto_exit(tfm);
+				return error;
+			}
+			if (!(n % mod))
+				printk("\b\b\b\b%3d%%", n / mod);
+		}
+		swp = swp->next;
+	}
+	printk("\b\b\b\bdone\n");
+	crypto_exit(tfm);
+	return 0;
+}
+
+static inline void free_pages_entries(swp_map_t *swp)
+{
+	unsigned k;
+
+	while (swp) {
+		for (k = 0; k < MAP_PAGE_SIZE; k++)
+			if (swp->entries[k].val)
+				swap_free(swp->entries[k]);
+		swp = swp->next;
+	}
 }
 
 /**
@@ -532,30 +590,49 @@
  */
 static int write_suspend_image(void)
 {
+	unsigned nr_pages;
 	int error;
+	swp_map_t *swp_map;
+	void *buffer;
 
-	if (!enough_swap(nr_copy_pages)) {
+	nr_pages = snapshot_pages_to_save();
+	if (!enough_swap(nr_pages)) {
 		printk(KERN_ERR "swsusp: Not enough free swap\n");
 		return -ENOSPC;
 	}
 
-	init_header();
-	if ((error = data_write()))
-		goto FreeData;
-
-	if ((error = write_pagedir()))
-		goto FreePagedir;
+	init_header(nr_pages, snapshot_image_pages());
+	buffer = (void *)get_zeroed_page(GFP_ATOMIC);
+	if (!buffer)
+		return -ENOMEM;
 
+	swp_map = alloc_swp_map(nr_pages);
+	if (!swp_map) {
+		free_page((unsigned long)buffer);
+		return -ENOMEM;
+	}
+	snapshot_send_init();
+	if ((error = save_image(swp_map, nr_pages, buffer)))
+		goto Free_pages_entries;
+	if ((error = snapshot_finish()))
+		goto Free_pages_entries;
+	swp_map = reverse_swp_map(swp_map);
+	if ((error = save_swp_map(swp_map, &swsusp_info.start)))
+		goto Free_map_entries;
 	if ((error = close_swap()))
-		goto FreePagedir;
- Done:
+		goto Free_map_entries;
+
+Free_mem:
+	free_swp_map(swp_map);
+	free_page((unsigned long)buffer);
 	memset(key_iv, 0, MAXKEY+MAXIV);
 	return error;
- FreePagedir:
-	free_pagedir_entries();
- FreeData:
-	data_free();
-	goto Done;
+
+Free_map_entries:
+	free_swp_map_entries(swp_map);
+Free_pages_entries:
+	free_pages_entries(swp_map);
+	goto Free_mem;
 }
 
 /* It is important _NOT_ to umount filesystems at this point. We want
@@ -719,6 +796,65 @@
 	return submit(WRITE, page_off, page);
 }
 
+/**
+ *	load_image - Load the image and metadata from swap, using the
+ *	snapshot_recv_page() function provided by the snapshot-handling code
+ *
+ *	We assume that the data has been saved using the swap map handling
+ *	functions above
+ */
+static int load_image(unsigned nr_pages, swp_entry_t start)
+{
+	swp_map_t *swp;
+	void *buf;
+	unsigned n, k;
+	unsigned long offset = swp_offset(start);
+	int error;
+	unsigned mod = nr_pages / 100;
+	void *tfm;
+
+	if (!nr_pages || !offset)
+		return -EINVAL;
+
+	if ((error = crypto_init(0, &tfm)))
+		return error;
+
+	buf = (void *)get_zeroed_page(GFP_ATOMIC);
+	if (!buf) {
+		error = -ENOMEM;
+		goto Crypto_exit;
+	}
+	swp = (swp_map_t *)get_zeroed_page(GFP_ATOMIC);
+	if (!swp) {
+		error = -ENOMEM;
+		goto Free_buf;
+	}
+	printk("Loading data from swap (%d pages) ...     ", nr_pages);
+	n = 0;
+	while (n < nr_pages) {
+		if ((error = crypto_read(offset, (void *)swp, tfm)))
+			goto Free;
+		for (k = 0; k < MAP_PAGE_SIZE && n < nr_pages; k++, n++) {
+			error = bio_read_page(swp_offset(swp->entries[k]), buf);
+			if (!error)
+				error = snapshot_recv_page(buf);
+			if (error)
+				goto Free;
+			if (!(n % mod))
+				printk("\b\b\b\b%3d%%", n / mod);
+		}
+		offset = swp_offset(swp->next_swp);
+	}
+	printk("\b\b\b\bdone\n");
+Free:
+	free_page((unsigned long)swp);
+Free_buf:
+	free_page((unsigned long)buf);
+Crypto_exit:
+	crypto_exit(tfm);
+	return error;
+}
+
 /*
  * Sanity check if this image makes sense with this kernel/swap context
  * I really don't think that it's foolproof but more than nothing..
@@ -761,7 +897,6 @@
 		printk(KERN_ERR "swsusp: Resume mismatch: %s\n",reason);
 		return -EPERM;
 	}
-	nr_copy_pages = swsusp_info.image_pages;
 	return error;
 }
 
@@ -789,82 +924,6 @@
 	return error;
 }
 
-/**
- *	data_read - Read image pages from swap.
- *
- *	You do not need to check for overlaps, check_pagedir()
- *	already did that.
- */
-
-static int data_read(struct pbe *pblist)
-{
-	struct pbe * p;
-	int error = 0;
-	int i = 0;
-	int mod = swsusp_info.image_pages / 100;
-	void *tfm;
-
-	if ((error = crypto_init(0, &tfm)))
-		return error;
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
-
-		if ((error = crypto_read(p, tfm))) {
-			crypto_exit(tfm);
-			return error;
-		}
-
-		i++;
-	}
-	printk("\b\b\b\bdone\n");
-	crypto_exit(tfm);
-	return error;
-}
-
-/**
- *	read_pagedir - Read page backup list pages from swap
- */
-
-static int read_pagedir(struct pbe *pblist)
-{
-	struct pbe *pbpage, *p;
-	unsigned i = 0;
-	int error;
-
-	if (!pblist)
-		return -EFAULT;
-
-	printk("swsusp: Reading pagedir (%lu pages)\n",
-			swsusp_info.pagedir_pages);
-
-	for_each_pb_page (pbpage, pblist) {
-		unsigned long offset = swp_offset(swsusp_info.pagedir[i++]);
-
-		error = -EFAULT;
-		if (offset) {
-			p = (pbpage + PB_PAGE_SKIP)->next;
-			error = bio_read_page(offset, (void *)pbpage);
-			(pbpage + PB_PAGE_SKIP)->next = p;
-		}
-		if (error)
-			break;
-	}
-
-	if (!error)
-		BUG_ON(i != swsusp_info.pagedir_pages);
-
-	return error;
-}
-
-
 static int check_suspend_image(void)
 {
 	int error = 0;
@@ -880,29 +939,13 @@
 
 static int read_suspend_image(void)
 {
-	int error = 0;
-	struct pbe *p;
-
-	if (!(p = alloc_pagedir(nr_copy_pages)))
-		return -ENOMEM;
-
-	if ((error = read_pagedir(p)))
-		return error;
-
-	create_pbe_list(p, nr_copy_pages);
-
-	pr_debug("swsusp: Relocating pagedir (%lu pages to check)\n",
-			swsusp_info.pagedir_pages);
-	if (!(pagedir_nosave = swsusp_pagedir_relocate(p)))
-		return -ENOMEM;
-
-	/* Allocate memory for the image and read the data from swap */
-
-	error = check_pagedir(pagedir_nosave);
+	int error;
 
+	error = snapshot_recv_init(swsusp_info.pages, swsusp_info.image_pages);
 	if (!error)
-		error = data_read(pagedir_nosave);
-
+		error = load_image(swsusp_info.pages, swsusp_info.start);
+	if (!error)
+		error = snapshot_finish();
 	return error;
 }
 
Index: linux-2.6.14-rc5-mm1/kernel/power/power.h
===================================================================
--- linux-2.6.14-rc5-mm1.orig/kernel/power/power.h	2005-10-29 13:24:56.000000000 +0200
+++ linux-2.6.14-rc5-mm1/kernel/power/power.h	2005-10-29 14:01:41.000000000 +0200
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
 
 
@@ -58,17 +53,19 @@
 /* References to section boundaries */
 extern const void __nosave_begin, __nosave_end;
 
-extern unsigned int nr_copy_pages;
-extern suspend_pagedir_t *pagedir_nosave;
-extern suspend_pagedir_t *pagedir_save;
+extern struct pbe *pagedir_nosave;
 
 extern asmlinkage int swsusp_arch_suspend(void);
 extern asmlinkage int swsusp_arch_resume(void);
 
 extern int save_highmem(void);
 extern int restore_highmem(void);
-extern struct pbe * alloc_pagedir(unsigned nr_pages);
-extern void create_pbe_list(struct pbe *pblist, unsigned nr_pages);
-extern int check_pagedir(struct pbe *pblist);
-extern struct pbe * swsusp_pagedir_relocate(struct pbe *pblist);
 extern void swsusp_free(void);
+
+extern unsigned snapshot_pages_to_save(void);
+extern unsigned snapshot_image_pages(void);
+extern void snapshot_send_init(void);
+extern int snapshot_send_page(void *buf);
+extern int snapshot_recv_init(unsigned nr_pages, unsigned img_pages);
+extern int snapshot_recv_page(void *buf);
+extern int snapshot_finish(void);
Index: linux-2.6.14-rc5-mm1/kernel/power/snapshot.c
===================================================================
--- linux-2.6.14-rc5-mm1.orig/kernel/power/snapshot.c	2005-10-29 13:24:56.000000000 +0200
+++ linux-2.6.14-rc5-mm1/kernel/power/snapshot.c	2005-10-29 14:11:17.000000000 +0200
@@ -4,6 +4,7 @@
  * This file provide system snapshot/restore functionality.
  *
  * Copyright (C) 1998-2005 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 2005 Rafael J. Wysocki <rjw@sisk.pl>
  *
  * This file is released under the GPLv2, and is based on swsusp.c.
  *
@@ -33,6 +34,11 @@
 
 #include "power.h"
 
+struct pbe *pagedir_nosave = NULL;
+
+static unsigned nr_copy_pages;
+static unsigned nr_pb_pages;
+
 #ifdef CONFIG_HIGHMEM
 struct highmem_page {
 	char *data;
@@ -250,7 +256,7 @@
  *	of memory pages allocated with alloc_pagedir()
  */
 
-void create_pbe_list(struct pbe *pblist, unsigned nr_pages)
+static void create_pbe_list(struct pbe *pblist, unsigned nr_pages)
 {
 	struct pbe *pbpage, *p;
 	unsigned num = PBES_PER_PAGE;
@@ -293,7 +299,7 @@
  *	On each page we set up a list of struct_pbe elements.
  */
 
-struct pbe *alloc_pagedir(unsigned nr_pages)
+static struct pbe *alloc_pagedir(unsigned nr_pages)
 {
 	unsigned num;
 	struct pbe *pblist, *pbe;
@@ -393,10 +399,6 @@
 		 (nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE,
 		 PAGES_FOR_IO, nr_free_pages());
 
-	/* This is needed because of the fixed size of swsusp_info */
-	if (MAX_PBES < (nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE)
-		return -ENOSPC;
-
 	if (!enough_free_mem(nr_pages)) {
 		printk(KERN_ERR "swsusp: Not enough free memory\n");
 		return -ENOMEM;
@@ -419,6 +421,7 @@
 	 */
 
 	nr_copy_pages = nr_pages;
+	nr_pb_pages = (nr_pages * sizeof(long) + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
 	printk("swsusp: critical section/: done (%d pages copied)\n", nr_pages);
 	return 0;
@@ -454,48 +457,22 @@
 }
 
 /**
- *	check_pagedir - We ensure here that pages that the PBEs point to
- *	won't collide with pages where we're going to restore from the loaded
- *	pages later
- */
-
-int check_pagedir(struct pbe *pblist)
-{
-	struct pbe *p;
-
-	/* This is necessary, so that we can free allocated pages
-	 * in case of failure
-	 */
-	for_each_pbe (p, pblist)
-		p->address = 0UL;
-
-	for_each_pbe (p, pblist) {
-		p->address = get_safe_page(GFP_ATOMIC);
-		if (!p->address)
-			return -ENOMEM;
-	}
-	return 0;
-}
-
-/**
- *	swsusp_pagedir_relocate - It is possible, that some memory pages
+ *	relocate_pbe_list - It is possible, that some memory pages
  *	occupied by the list of PBEs collide with pages where we're going to
  *	restore from the loaded pages later.  We relocate them here.
  */
 
-struct pbe * swsusp_pagedir_relocate(struct pbe *pblist)
+static struct pbe *relocate_pbe_list(struct pbe *pblist)
 {
 	struct zone *zone;
 	unsigned long zone_pfn;
 	struct pbe *pbpage, *tail, *p;
 	void *m;
-	int rel = 0;
 
 	if (!pblist) /* a sanity check */
 		return NULL;
 
 	/* Clear page flags */
-
 	for_each_zone (zone) {
         	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
         		if (pfn_valid(zone_pfn + zone->zone_start_pfn))
@@ -504,13 +481,11 @@
 	}
 
 	/* Mark orig addresses */
-
 	for_each_pbe (p, pblist)
 		SetPageNosaveFree(virt_to_page(p->orig_address));
 
-	tail = pblist + PB_PAGE_SKIP;
-
 	/* Relocate colliding pages */
+	tail = pblist + PB_PAGE_SKIP;
 
 	for_each_pb_page (pbpage, pblist) {
 		if (PageNosaveFree(virt_to_page((unsigned long)pbpage))) {
@@ -528,8 +503,6 @@
 			for (p = pbpage; p < pbpage + PB_PAGE_SKIP; p++)
 				if (p->next) /* needed to save the end */
 					p->next = p + 1;
-
-			rel++;
 		}
 		tail = pbpage + PB_PAGE_SKIP;
 	}
@@ -540,7 +513,126 @@
 		SetPageNosaveFree(virt_to_page(pbpage));
 	}
 
-	printk("swsusp: Relocated %d pages\n", rel);
-
 	return pblist;
 }
+
+unsigned snapshot_pages_to_save(void)
+{
+	return nr_copy_pages + nr_pb_pages;
+}
+
+unsigned snapshot_image_pages(void)
+{
+	return nr_copy_pages;
+}
+
+static unsigned current_page = 0;
+static struct pbe *current_pbe;
+static struct pbe *current_pblist;
+
+void snapshot_send_init(void)
+{
+	current_page = 0;
+	current_pbe = pagedir_nosave;
+	current_pblist = NULL;
+}
+
+static void prepare_next_pb_page(unsigned long *buf)
+{
+	struct pbe *p;
+	unsigned n;
+
+	p  = current_pbe;
+	for (n = 0; n < PAGE_SIZE/sizeof(long) && p; n++) {
+		buf[n] = p->orig_address;
+		p = p->next;
+	}
+	current_pbe = p;
+}
+
+int snapshot_send_page(void *buf)
+{
+	if (current_page >= nr_copy_pages + nr_pb_pages)
+		return -EINVAL;
+	if (current_page < nr_pb_pages) {
+		prepare_next_pb_page(buf);
+		if (!current_pbe)
+			current_pbe = pagedir_nosave;
+	} else {
+		memcpy(buf, (void *)current_pbe->address, PAGE_SIZE);
+		current_pbe = current_pbe->next;
+	}
+	current_page++;
+	return 0;
+}
+
+int snapshot_recv_init(unsigned nr_pages, unsigned img_pages)
+{
+	struct pbe *pblist;
+
+	if (nr_pages <= img_pages)
+		return -EINVAL;
+	/* We have to create a PBE list here */
+	pblist = alloc_pagedir(img_pages);
+	if (!pblist)
+		return -ENOMEM;
+	create_pbe_list(pblist, img_pages);
+	current_pblist = pblist;
+	current_pbe = pblist;
+	current_page = 0;
+	nr_copy_pages = img_pages;
+	nr_pb_pages = nr_pages - img_pages;
+	return 0;
+}
+
+static void load_next_pb_page(unsigned long *buf)
+{
+	struct pbe *p;
+	unsigned n;
+
+	p  = current_pbe;
+	for (n = 0; n < PAGE_SIZE/sizeof(long) && p; n++) {
+		p->orig_address = buf[n];
+		p = p->next;
+	}
+	current_pbe = p;
+}
+
+int snapshot_recv_page(void *buf)
+{
+	if (!current_pblist ||
+	    current_page >= nr_copy_pages + nr_pb_pages)
+		return -EINVAL;
+	if (current_page < nr_pb_pages) {
+		load_next_pb_page(buf);
+		if (!current_pbe) {
+			current_pblist = relocate_pbe_list(current_pblist);
+			if (!current_pblist) {
+				printk(KERN_ERR "\nswsusp: Not enough memory for relocating PBEs\n");
+				return -ENOMEM;
+			}
+			current_pbe = current_pblist;
+		}
+	} else {
+		current_pbe->address = get_safe_page(GFP_ATOMIC);
+		if (!current_pbe->address) {
+			printk(KERN_ERR "\nswsusp: Not enough memory for the image\n");
+			return -ENOMEM;
+		}
+		memcpy((void *)current_pbe->address, buf, PAGE_SIZE);
+		current_pbe = current_pbe->next;
+	}
+	current_page++;
+	return 0;
+}
+
+int snapshot_finish(void)
+{
+	if (current_pbe)
+		return -EINVAL;
+	current_page = 0;
+	if (current_pblist)
+		pagedir_nosave = current_pblist;
+	current_pblist = NULL;
+	return 0;
+}
Index: linux-2.6.14-rc5-mm1/include/linux/suspend.h
===================================================================
--- linux-2.6.14-rc5-mm1.orig/include/linux/suspend.h	2005-10-29 13:24:56.000000000 +0200
+++ linux-2.6.14-rc5-mm1/include/linux/suspend.h	2005-10-29 14:01:27.000000000 +0200
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

