Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUGQWtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUGQWtz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 18:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUGQWtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 18:49:25 -0400
Received: from digitalimplant.org ([64.62.235.95]:21993 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262329AbUGQWfD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 18:35:03 -0400
Date: Sat, 17 Jul 2004 15:34:56 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: pavel@ucw.cz
Subject: [5/25] Merge pmdisk and swsusp
Message-ID: <Pine.LNX.4.50.0407171528100.22290-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.1847, 2004/07/17 09:47:13-07:00, mochel@digitalimplant.org

[Power Mgmt] Merge first part of image writing code.

- Introduce helpers to swsusp - swsusp_write_page(), swsusp_data_write() and
  swsusp_data_free().
- Delete duplicate copies from pmdisk and fixup names in calls.
- Clean up write_suspend_image() in swsusp and use the helpers.


 kernel/power/pmdisk.c |   94 ++-----------------------------
 kernel/power/swsusp.c |  148 ++++++++++++++++++++++++++++++++------------------
 2 files changed, 103 insertions(+), 139 deletions(-)


diff -Nru a/kernel/power/pmdisk.c b/kernel/power/pmdisk.c
--- a/kernel/power/pmdisk.c	2004-07-17 14:51:40 -07:00
+++ b/kernel/power/pmdisk.c	2004-07-17 14:51:40 -07:00
@@ -138,85 +138,9 @@
 	return error;
 }

-
-
-/**
- *	write_swap_page - Write one page to a fresh swap location.
- *	@addr:	Address we're writing.
- *	@loc:	Place to store the entry we used.
- *
- *	Allocate a new swap entry and 'sync' it. Note we discard -EIO
- *	errors. That is an artifact left over from swsusp. It did not
- *	check the return of rw_swap_page_sync() at all, since most pages
- *	written back to swap would return -EIO.
- *	This is a partial improvement, since we will at least return other
- *	errors, though we need to eventually fix the damn code.
- */
-
-static int write_swap_page(unsigned long addr, swp_entry_t * loc)
-{
-	swp_entry_t entry;
-	int error = 0;
-
-	entry = get_swap_page();
-	if (swp_offset(entry) &&
-	    swapfile_used[swp_type(entry)] == SWAPFILE_SUSPEND) {
-		error = rw_swap_page_sync(WRITE, entry,
-					  virt_to_page(addr));
-		if (error == -EIO)
-			error = 0;
-		if (!error)
-			*loc = entry;
-	} else
-		error = -ENOSPC;
-	return error;
-}
-
-
-/**
- *	free_data - Free the swap entries used by the saved image.
- *
- *	Walk the list of used swap entries and free each one.
- */
-
-static void free_data(void)
-{
-	swp_entry_t entry;
-	int i;
-
-	for (i = 0; i < nr_copy_pages; i++) {
-		entry = (pagedir_nosave + i)->swap_address;
-		if (entry.val)
-			swap_free(entry);
-		else
-			break;
-		(pagedir_nosave + i)->swap_address = (swp_entry_t){0};
-	}
-}
-
-
-/**
- *	write_data - Write saved image to swap.
- *
- *	Walk the list of pages in the image and sync each one to swap.
- */
-
-static int write_data(void)
-{
-	int error = 0;
-	int i;
-
-	printk( "Writing data to swap (%d pages): ", nr_copy_pages );
-	for (i = 0; i < nr_copy_pages && !error; i++) {
-		if (!(i%100))
-			printk( "." );
-		error = write_swap_page((pagedir_nosave+i)->address,
-					&((pagedir_nosave+i)->swap_address));
-	}
-	printk(" %d Pages done.\n",i);
-	return error;
-}
-
+extern int swsusp_write_page(unsigned long addr, swp_entry_t * entry);
+extern int swsusp_data_write(void);
+extern void swsusp_data_free(void);

 /**
  *	free_pagedir - Free pages used by the page directory.
@@ -247,7 +171,7 @@
 	pmdisk_info.pagedir_pages = n;
 	printk( "Writing pagedir (%d pages)\n", n);
 	for (i = 0; i < n && !error; i++, addr += PAGE_SIZE)
-		error = write_swap_page(addr,&pmdisk_info.pagedir[i]);
+		error = swsusp_write_page(addr,&pmdisk_info.pagedir[i]);
 	return error;
 }

@@ -283,6 +207,7 @@

 	pmdisk_info.cpus = num_online_cpus();
 	pmdisk_info.image_pages = nr_copy_pages;
+	dump_pmdisk_info();
 }

 /**
@@ -297,8 +222,7 @@

 static int write_header(swp_entry_t * entry)
 {
-	dump_pmdisk_info();
-	return write_swap_page((unsigned long)&pmdisk_info,entry);
+	return swsusp_write_page((unsigned long)&pmdisk_info,entry);
 }


@@ -313,9 +237,7 @@
 	int error;
 	swp_entry_t prev = { 0 };

-	init_header();
-
-	if ((error = write_data()))
+	if ((error = swsusp_data_write()))
 		goto FreeData;

 	if ((error = write_pagedir()))
@@ -330,7 +252,7 @@
  FreePagedir:
 	free_pagedir_entries();
  FreeData:
-	free_data();
+	swsusp_data_free();
 	goto Done;
 }

diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2004-07-17 14:51:40 -07:00
+++ b/kernel/power/swsusp.c	2004-07-17 14:51:40 -07:00
@@ -295,6 +295,87 @@
 	swap_list_unlock();
 }

+
+
+/**
+ *	write_swap_page - Write one page to a fresh swap location.
+ *	@addr:	Address we're writing.
+ *	@loc:	Place to store the entry we used.
+ *
+ *	Allocate a new swap entry and 'sync' it. Note we discard -EIO
+ *	errors. That is an artifact left over from swsusp. It did not
+ *	check the return of rw_swap_page_sync() at all, since most pages
+ *	written back to swap would return -EIO.
+ *	This is a partial improvement, since we will at least return other
+ *	errors, though we need to eventually fix the damn code.
+ */
+
+int swsusp_write_page(unsigned long addr, swp_entry_t * loc)
+{
+	swp_entry_t entry;
+	int error = 0;
+
+	entry = get_swap_page();
+	if (swp_offset(entry) &&
+	    swapfile_used[swp_type(entry)] == SWAPFILE_SUSPEND) {
+		error = rw_swap_page_sync(WRITE, entry,
+					  virt_to_page(addr));
+		if (error == -EIO)
+			error = 0;
+		if (!error)
+			*loc = entry;
+	} else
+		error = -ENOSPC;
+	return error;
+}
+
+
+/**
+ *	free_data - Free the swap entries used by the saved image.
+ *
+ *	Walk the list of used swap entries and free each one.
+ */
+
+void swsusp_data_free(void)
+{
+	swp_entry_t entry;
+	int i;
+
+	for (i = 0; i < nr_copy_pages; i++) {
+		entry = (pagedir_nosave + i)->swap_address;
+		if (entry.val)
+			swap_free(entry);
+		else
+			break;
+		(pagedir_nosave + i)->swap_address = (swp_entry_t){0};
+	}
+}
+
+
+/**
+ *	write_data - Write saved image to swap.
+ *
+ *	Walk the list of pages in the image and sync each one to swap.
+ */
+
+int swsusp_data_write(void)
+{
+	int error = 0;
+	int i;
+
+	printk( "Writing data to swap (%d pages): ", nr_copy_pages );
+	for (i = 0; i < nr_copy_pages && !error; i++) {
+		if (!(i%100))
+			printk( "." );
+		error = swsusp_write_page((pagedir_nosave+i)->address,
+					  &((pagedir_nosave+i)->swap_address));
+	}
+	printk(" %d Pages done.\n",i);
+	return error;
+}
+
+
+
 /**
  *    write_suspend_image - Write entire image to disk.
  *
@@ -309,78 +390,39 @@
 static int write_suspend_image(void)
 {
 	int i;
-	swp_entry_t entry, prev = { 0 };
+	int error = 0;
+	swp_entry_t entry = { 0 };
 	int nr_pgdir_pages = SUSPEND_PD_PAGES(nr_copy_pages);
 	union diskpage *cur,  *buffer = (union diskpage *)get_zeroed_page(GFP_ATOMIC);
-	unsigned long address;
-	struct page *page;
+	unsigned long addr;

 	if (!buffer)
 		return -ENOMEM;

-	printk( "Writing data to swap (%d pages): ", nr_copy_pages );
-	for (i=0; i<nr_copy_pages; i++) {
-		if (!(i%100))
-			printk( "." );
-		entry = get_swap_page();
-		if (!entry.val)
-			panic("\nNot enough swapspace when writing data" );
-
-		if (swapfile_used[swp_type(entry)] != SWAPFILE_SUSPEND)
-			panic("\nPage %d: not enough swapspace on suspend device", i );
-
-		address = (pagedir_nosave+i)->address;
-		page = virt_to_page(address);
-		rw_swap_page_sync(WRITE, entry, page);
-		(pagedir_nosave+i)->swap_address = entry;
-	}
-	printk( "|\n" );
+	swsusp_data_write();
+
 	printk( "Writing pagedir (%d pages): ", nr_pgdir_pages);
-	for (i=0; i<nr_pgdir_pages; i++) {
-		cur = (union diskpage *)((char *) pagedir_nosave)+i;
-		BUG_ON ((char *) cur != (((char *) pagedir_nosave) + i*PAGE_SIZE));
+	addr = (unsigned long)pagedir_nosave;
+	for (i=0; i<nr_pgdir_pages && !error; i++, addr += PAGE_SIZE) {
+		cur = (union diskpage *)addr;
+		cur->link.next = entry;
 		printk( "." );
-		entry = get_swap_page();
-		if (!entry.val) {
-			printk(KERN_CRIT "Not enough swapspace when writing pgdir\n" );
-			panic("Don't know how to recover");
-			free_page((unsigned long) buffer);
-			return -ENOSPC;
-		}
-
-		if(swapfile_used[swp_type(entry)] != SWAPFILE_SUSPEND)
-			panic("\nNot enough swapspace for pagedir on suspend device" );
-
-		BUG_ON (sizeof(swp_entry_t) != sizeof(long));
-		BUG_ON (PAGE_SIZE % sizeof(struct pbe));
-
-		cur->link.next = prev;
-		page = virt_to_page((unsigned long)cur);
-		rw_swap_page_sync(WRITE, entry, page);
-		prev = entry;
+		error = swsusp_write_page(addr,&entry);
 	}
 	printk("H");
 	BUG_ON (sizeof(struct suspend_header) > PAGE_SIZE-sizeof(swp_entry_t));
 	BUG_ON (sizeof(union diskpage) != PAGE_SIZE);
 	BUG_ON (sizeof(struct link) != PAGE_SIZE);
-	entry = get_swap_page();
-	if (!entry.val)
-		panic( "\nNot enough swapspace when writing header" );
-	if (swapfile_used[swp_type(entry)] != SWAPFILE_SUSPEND)
-		panic("\nNot enough swapspace for header on suspend device" );

 	cur = (void *) buffer;
 	if (fill_suspend_header(&cur->sh))
 		BUG();		/* Not a BUG_ON(): we want fill_suspend_header to be called, always */

-	cur->link.next = prev;
-
-	page = virt_to_page((unsigned long)cur);
-	rw_swap_page_sync(WRITE, entry, page);
-	prev = entry;
-
+	cur->link.next = entry;
+	if ((error = swsusp_write_page((unsigned long)cur,&entry)))
+		return error;
 	printk( "S" );
-	mark_swapfiles(prev, MARK_SWAP_SUSPEND);
+	mark_swapfiles(entry, MARK_SWAP_SUSPEND);
 	printk( "|\n" );

 	MDELAY(1000);
