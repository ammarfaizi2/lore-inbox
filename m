Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUGQWmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUGQWmN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 18:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUGQWlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 18:41:50 -0400
Received: from digitalimplant.org ([64.62.235.95]:48617 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262768AbUGQWfx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 18:35:53 -0400
Date: Sat, 17 Jul 2004 15:35:45 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: pavel@ucw.cz
Subject: [17/25] Merge pmdisk and swsusp
Message-ID: <Pine.LNX.4.50.0407171531210.22290-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.1859, 2004/07/17 13:08:46-07:00, mochel@digitalimplant.org

[Power Mgmt] Merge pmdisk and swsusp pagedir handling.

This embodies the core of the swsusp->pmdisk cleanups. Instead of using the
->dummy variable at the end of each pagedir for a linked list of the page
dirs, this uses a static array, which is kept in the empty space of the
swsusp header.

There are 768 entries, and could be scaled up based on the size of the page
and the amount of room remaining. 768 should be enough anyway, since each
entry is a swp_entry_t to a page-length array of pages. With larger systems
and more memory come larger pages, so each page-sized array will
automatically scale up.

This replaces the read_suspend_image() and write_suspend_image() in swsusp
with the much more concise pmdisk versions (not that big of change at this
point) and fixes up the callers so software_resume() gets it right.

Also, mark the helpers only used in swsusp as static again.


 kernel/power/pmdisk.c |  159 ----------------------------------------
 kernel/power/swsusp.c |  195 ++++++++++++++++++++++++--------------------------
 2 files changed, 99 insertions(+), 255 deletions(-)


diff -Nru a/kernel/power/pmdisk.c b/kernel/power/pmdisk.c
--- a/kernel/power/pmdisk.c	2004-07-17 14:50:53 -07:00
+++ b/kernel/power/pmdisk.c	2004-07-17 14:50:53 -07:00
@@ -33,129 +33,20 @@

 #include "power.h"

-
-extern asmlinkage int pmdisk_arch_suspend(int resume);
-
-/* Variables to be preserved over suspend */
-extern int pagedir_order_check;
-extern int nr_copy_pages_check;
-
 /* For resume= kernel option */
 static char resume_file[256] = CONFIG_PM_DISK_PARTITION;

 static dev_t resume_device;
-/* Local variables that should not be affected by save */
-extern unsigned int nr_copy_pages;
-
-/* Suspend pagedir is allocated before final copy, therefore it
-   must be freed after resume

-   Warning: this is evil. There are actually two pagedirs at time of
-   resume. One is "pagedir_save", which is empty frame allocated at
-   time of suspend, that must be freed. Second is "pagedir_nosave",
-   allocated at time of resume, that travels through memory not to
-   collide with anything.
- */
-extern suspend_pagedir_t *pagedir_nosave;
 extern suspend_pagedir_t *pagedir_save;
-extern int pagedir_order;
-
-extern struct swsusp_info swsusp_info;
-
-
-/*
- * XXX: We try to keep some more pages free so that I/O operations succeed
- * without paging. Might this be more?
- */
-#define PAGES_FOR_IO	512
-

 /*
  * Saving part...
  */


-/* We memorize in swapfile_used what swap devices are used for suspension */
-#define SWAPFILE_UNUSED    0
-#define SWAPFILE_SUSPEND   1	/* This is the suspending device */
-#define SWAPFILE_IGNORED   2	/* Those are other swap devices ignored for suspension */
-
-extern int swsusp_swap_check(void);
 extern void swsusp_swap_lock(void);

-
-extern int swsusp_write_page(unsigned long addr, swp_entry_t * entry);
-extern int swsusp_data_write(void);
-extern void swsusp_data_free(void);
-
-/**
- *	free_pagedir - Free pages used by the page directory.
- */
-
-static void free_pagedir_entries(void)
-{
-	int num = swsusp_info.pagedir_pages;
-	int i;
-
-	for (i = 0; i < num; i++)
-		swap_free(swsusp_info.pagedir[i]);
-}
-
-
-/**
- *	write_pagedir - Write the array of pages holding the page directory.
- *	@last:	Last swap entry we write (needed for header).
- */
-
-static int write_pagedir(void)
-{
-	unsigned long addr = (unsigned long)pagedir_nosave;
-	int error = 0;
-	int n = SUSPEND_PD_PAGES(nr_copy_pages);
-	int i;
-
-	swsusp_info.pagedir_pages = n;
-	printk( "Writing pagedir (%d pages)\n", n);
-	for (i = 0; i < n && !error; i++, addr += PAGE_SIZE)
-		error = swsusp_write_page(addr,&swsusp_info.pagedir[i]);
-	return error;
-}
-
-extern void swsusp_init_header(void);
-extern int swsusp_close_swap(void);
-
-/**
- *	write_suspend_image - Write entire image and metadata.
- *
- */
-
-static int write_suspend_image(void)
-{
-	int error;
-
-	swsusp_init_header();
-	if ((error = swsusp_data_write()))
-		goto FreeData;
-
-	if ((error = write_pagedir()))
-		goto FreePagedir;
-
-	if ((error = swsusp_close_swap()))
-		goto FreePagedir;
- Done:
-	return error;
- FreePagedir:
-	free_pagedir_entries();
- FreeData:
-	swsusp_data_free();
-	goto Done;
-}
-
-
-extern void free_suspend_pagedir(unsigned long);
-
-
-
 /**
  *	suspend_save_image - Prepare and write saved image to swap.
  *
@@ -172,6 +63,7 @@

 static int suspend_save_image(void)
 {
+	extern int write_suspend_image(void);
 	int error;
 	device_resume();
 	swsusp_swap_lock();
@@ -184,57 +76,10 @@
 /* More restore stuff */

 extern struct block_device * resume_bdev;
-extern int bio_read_page(pgoff_t page_off, void * page);
-extern int bio_write_page(pgoff_t page_off, void * page);

 extern dev_t __init name_to_dev_t(const char *line);


-static int __init read_pagedir(void)
-{
-	unsigned long addr;
-	int i, n = swsusp_info.pagedir_pages;
-	int error = 0;
-
-	pagedir_order = get_bitmask_order(n);
-
-	addr =__get_free_pages(GFP_ATOMIC, pagedir_order);
-	if (!addr)
-		return -ENOMEM;
-	pagedir_nosave = (struct pbe *)addr;
-
-	pr_debug("pmdisk: Reading pagedir (%d Pages)\n",n);
-
-	for (i = 0; i < n && !error; i++, addr += PAGE_SIZE) {
-		unsigned long offset = swp_offset(swsusp_info.pagedir[i]);
-		if (offset)
-			error = bio_read_page(offset, (void *)addr);
-		else
-			error = -EFAULT;
-	}
-	if (error)
-		free_pages((unsigned long)pagedir_nosave,pagedir_order);
-	return error;
-}
-
-
-static int __init read_suspend_image(void)
-{
-	extern int swsusp_data_read(void);
-	extern int swsusp_verify(void);
-
-	int error = 0;
-
-	if ((error = swsusp_verify()))
-		return error;
-	if ((error = read_pagedir()))
-		return error;
-	if ((error = swsusp_data_read())) {
-		free_pages((unsigned long)pagedir_nosave,pagedir_order);
-	}
-	return error;
-}
-

 /**
  *	pmdisk_write - Write saved memory image to swap.
@@ -258,6 +103,7 @@

 int __init pmdisk_read(void)
 {
+	extern int read_suspend_image(void);
 	int error;

 	if (!strlen(resume_file))
@@ -288,6 +134,7 @@

 int pmdisk_free(void)
 {
+	extern void free_suspend_pagedir(unsigned long this_pagedir);
 	pr_debug( "Freeing prev allocated pagedir\n" );
 	free_suspend_pagedir((unsigned long)pagedir_save);
 	return 0;
diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2004-07-17 14:50:53 -07:00
+++ b/kernel/power/swsusp.c	2004-07-17 14:50:53 -07:00
@@ -122,16 +122,6 @@

 struct swsusp_info swsusp_info;

-struct link {
-	char dummy[PAGE_SIZE - sizeof(swp_entry_t)];
-	swp_entry_t next;
-};
-
-union diskpage {
-	union swap_header swh;
-	struct link link;
-};
-
 /*
  * XXX: We try to keep some more pages free so that I/O operations succeed
  * without paging. Might this be more?
@@ -283,7 +273,7 @@
  *	errors, though we need to eventually fix the damn code.
  */

-int swsusp_write_page(unsigned long addr, swp_entry_t * loc)
+static int write_page(unsigned long addr, swp_entry_t * loc)
 {
 	swp_entry_t entry;
 	int error = 0;
@@ -309,7 +299,7 @@
  *	Walk the list of used swap entries and free each one.
  */

-void swsusp_data_free(void)
+static void data_free(void)
 {
 	swp_entry_t entry;
 	int i;
@@ -331,7 +321,7 @@
  *	Walk the list of pages in the image and sync each one to swap.
  */

-int swsusp_data_write(void)
+static int data_write(void)
 {
 	int error = 0;
 	int i;
@@ -340,7 +330,7 @@
 	for (i = 0; i < nr_copy_pages && !error; i++) {
 		if (!(i%100))
 			printk( "." );
-		error = swsusp_write_page((pagedir_nosave+i)->address,
+		error = write_page((pagedir_nosave+i)->address,
 					  &((pagedir_nosave+i)->swap_address));
 	}
 	printk(" %d Pages done.\n",i);
@@ -369,7 +359,7 @@
 }
 #endif

-void swsusp_init_header(void)
+static void init_header(void)
 {
 	memset(&swsusp_info,0,sizeof(swsusp_info));
 	swsusp_info.version_code = LINUX_VERSION_CODE;
@@ -394,11 +384,11 @@

 static int write_header(swp_entry_t * entry)
 {
-	return swsusp_write_page((unsigned long)&swsusp_info,entry);
+	return write_page((unsigned long)&swsusp_info,entry);
 }


-int swsusp_close_swap(void)
+static int close_swap(void)
 {
 	swp_entry_t entry;
 	int error;
@@ -412,50 +402,66 @@
 }

 /**
- *    write_suspend_image - Write entire image to disk.
- *
- *    After writing suspend signature to the disk, suspend may no
- *    longer fail: we have ready-to-run image in swap, and rollback
- *    would happen on next reboot -- corrupting data.
- *
- *    Note: The buffer we allocate to use to write the suspend header is
- *    not freed; its not needed since the system is going down anyway
- *    (plus it causes an oops and I'm lazy^H^H^H^Htoo busy).
+ *	free_pagedir - Free pages used by the page directory.
  */
-static int write_suspend_image(void)
+
+static void free_pagedir_entries(void)
 {
+	int num = swsusp_info.pagedir_pages;
 	int i;
+
+	for (i = 0; i < num; i++)
+		swap_free(swsusp_info.pagedir[i]);
+}
+
+
+/**
+ *	write_pagedir - Write the array of pages holding the page directory.
+ *	@last:	Last swap entry we write (needed for header).
+ */
+
+static int write_pagedir(void)
+{
+	unsigned long addr = (unsigned long)pagedir_nosave;
 	int error = 0;
-	swp_entry_t entry = { 0 };
-	int nr_pgdir_pages = SUSPEND_PD_PAGES(nr_copy_pages);
-	union diskpage *cur,  *buffer = (union diskpage *)get_zeroed_page(GFP_ATOMIC);
-	unsigned long addr;
+	int n = SUSPEND_PD_PAGES(nr_copy_pages);
+	int i;

-	if (!buffer)
-		return -ENOMEM;
+	swsusp_info.pagedir_pages = n;
+	printk( "Writing pagedir (%d pages)\n", n);
+	for (i = 0; i < n && !error; i++, addr += PAGE_SIZE)
+		error = write_page(addr,&swsusp_info.pagedir[i]);
+	return error;
+}
+
+/**
+ *	write_suspend_image - Write entire image and metadata.
+ *
+ */

-	swsusp_data_write();
-	swsusp_init_header();
+int write_suspend_image(void)
+{
+	int error;

-	printk( "Writing pagedir (%d pages): ", nr_pgdir_pages);
-	addr = (unsigned long)pagedir_nosave;
-	for (i=0; i<nr_pgdir_pages && !error; i++, addr += PAGE_SIZE) {
-		cur = (union diskpage *)addr;
-		cur->link.next = entry;
-		printk( "." );
-		error = swsusp_write_page(addr,&entry);
-	}
-	printk("H");
-	BUG_ON (sizeof(union diskpage) != PAGE_SIZE);
-	BUG_ON (sizeof(struct link) != PAGE_SIZE);
+	init_header();
+	if ((error = data_write()))
+		goto FreeData;

-	swsusp_info.pagedir[0] = entry;
-	swsusp_close_swap();
+	if ((error = write_pagedir()))
+		goto FreePagedir;

-	MDELAY(1000);
-	return 0;
+	if ((error = close_swap()))
+		goto FreePagedir;
+ Done:
+	return error;
+ FreePagedir:
+	free_pagedir_entries();
+ FreeData:
+	data_free();
+	goto Done;
 }

+
 #ifdef CONFIG_HIGHMEM
 struct highmem_page {
 	char *data;
@@ -1258,7 +1264,7 @@
 }


-int __init swsusp_verify(void)
+int __init verify(void)
 {
 	int error;

@@ -1275,7 +1281,7 @@
  *	already did that.
  */

-int __init swsusp_data_read(void)
+static int __init data_read(void)
 {
 	struct pbe * p;
 	int error;
@@ -1298,58 +1304,48 @@

 extern dev_t __init name_to_dev_t(const char *line);

-static int __init __read_suspend_image(int noresume)
+static int __init read_pagedir(void)
 {
-	union diskpage *cur;
-	swp_entry_t next;
-	int i, nr_pgdir_pages;
-	int error;
-
-	if ((error = swsusp_verify()))
-		return error;
-
-	cur = (union diskpage *)get_zeroed_page(GFP_ATOMIC);
-	if (!cur)
-		return -ENOMEM;
-
-#define PREPARENEXT \
-	{	next = cur->link.next; \
-		next.val = swp_offset(next); \
-        }
-
-	if (noresume)
-		return 0;
-
-	next = swsusp_info.pagedir[0];
-	next.val = swp_offset(next);
+	unsigned long addr;
+	int i, n = swsusp_info.pagedir_pages;
+	int error = 0;

-	pagedir_save = swsusp_info.suspend_pagedir;
-	nr_copy_pages = swsusp_info.image_pages;
-	nr_pgdir_pages = SUSPEND_PD_PAGES(nr_copy_pages);
-	pagedir_order = get_bitmask_order(nr_pgdir_pages);
+	pagedir_order = get_bitmask_order(n);

-	pagedir_nosave = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC, pagedir_order);
-	if (!pagedir_nosave)
+	addr =__get_free_pages(GFP_ATOMIC, pagedir_order);
+	if (!addr)
 		return -ENOMEM;
+	pagedir_nosave = (struct pbe *)addr;

-	PRINTK( "%sReading pagedir, ", name_resume );
+	pr_debug("pmdisk: Reading pagedir (%d Pages)\n",n);

-	/* We get pages in reverse order of saving! */
-	for (i=nr_pgdir_pages-1; i>=0; i--) {
-		BUG_ON (!next.val);
-		cur = (union diskpage *)((char *) pagedir_nosave)+i;
-		if (bio_read_page(next.val, cur)) return -EIO;
-		PREPARENEXT;
+	for (i = 0; i < n && !error; i++, addr += PAGE_SIZE) {
+		unsigned long offset = swp_offset(swsusp_info.pagedir[i]);
+		if (offset)
+			error = bio_read_page(offset, (void *)addr);
+		else
+			error = -EFAULT;
 	}
-	BUG_ON (next.val);
+	if (error)
+		free_pages((unsigned long)pagedir_nosave,pagedir_order);
+	return error;
+}

-	error = swsusp_data_read();
-	if (!error)
-		printk( "|\n" );
-	return 0;
+int __init read_suspend_image(void)
+{
+	int error = 0;
+
+	if ((error = verify()))
+		return error;
+	if ((error = read_pagedir()))
+		return error;
+	if ((error = data_read())) {
+		free_pages((unsigned long)pagedir_nosave,pagedir_order);
+	}
+	return error;
 }

-static int __init read_suspend_image(const char * specialfile, int noresume)
+static int __init __read_suspend_image(const char * specialfile)
 {
 	int error;
 	char b[BDEVNAME_SIZE];
@@ -1359,7 +1355,7 @@
 	resume_bdev = open_by_devnum(resume_device, FMODE_READ);
 	if (!IS_ERR(resume_bdev)) {
 		set_blocksize(resume_bdev, PAGE_SIZE);
-		error = __read_suspend_image(noresume);
+		error = read_suspend_image();
 		blkdev_put(resume_bdev);
 	} else
 		error = PTR_ERR(resume_bdev);
@@ -1391,9 +1387,10 @@

 	printk( "%s", name_resume );
 	if (resume_status == NORESUME) {
-		if(resume_file[0])
-			read_suspend_image(resume_file, 1);
-		printk( "disabled\n" );
+		/*
+		 * FIXME: If noresume is specified, we need to handle by finding
+		 * the right partition and resettting the signature.
+		 */
 		return 0;
 	}
 	MDELAY(1000);
@@ -1407,7 +1404,7 @@
 	}

 	printk( "resuming from %s\n", resume_file);
-	if (read_suspend_image(resume_file, 0))
+	if (__read_suspend_image(resume_file))
 		goto read_failure;
 	/* FIXME: Should we stop processes here, just to be safer? */
 	disable_nonboot_cpus();
