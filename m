Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265943AbUIIPh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265943AbUIIPh0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 11:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265970AbUIIPhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 11:37:25 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:27869 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265943AbUIIPd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 11:33:58 -0400
Date: Thu, 9 Sep 2004 17:33:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Small cleanups for swsusp
Message-ID: <20040909153358.GA11742@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here are some small cleanups: whitespace fixes, added severity level,
shuffle messages and kill unneccessary strings, add some statics and
fixed misleading comments. Please apply.

								Pavel

(What is the issue with Linus merge, btw?)


--- clean-mm/arch/i386/power/swsusp.S	2004-09-07 21:12:20.000000000 +0200
+++ linux-mm/arch/i386/power/swsusp.S	2004-09-09 01:28:28.000000000 +0200
@@ -31,7 +31,7 @@
 	movl $swsusp_pg_dir-__PAGE_OFFSET,%ecx
 	movl %ecx,%cr3
 
-	movl	pagedir_nosave,%ebx
+	movl	pagedir_nosave, %ebx
 	xorl	%eax, %eax
 	xorl	%edx, %edx
 	.p2align 4,,7
--- clean-mm/kernel/power/disk.c	2004-09-07 21:12:33.000000000 +0200
+++ linux-mm/kernel/power/disk.c	2004-09-08 22:47:41.000000000 +0200
@@ -71,7 +71,7 @@
 	machine_halt();
 	/* Valid image is on the disk, if we continue we risk serious data corruption
 	   after resume. */
-	printk("Please power me down manually\n");
+	printk(KERN_CRIT "Please power me down manually\n");
 	while(1);
 	return 0;
 }
--- clean-mm/kernel/power/swsusp.c	2004-09-07 21:12:33.000000000 +0200
+++ linux-mm/kernel/power/swsusp.c	2004-09-09 08:56:20.000000000 +0200
@@ -99,8 +97,8 @@
    MMU hardware.
  */
 suspend_pagedir_t *pagedir_nosave __nosavedata = NULL;
-suspend_pagedir_t *pagedir_save;
-int pagedir_order __nosavedata = 0;
+static suspend_pagedir_t *pagedir_save;
+static int pagedir_order __nosavedata = 0;
 
 #define SWSUSP_SIG	"S1SUSPEND"
 
@@ -119,9 +117,6 @@
  */
 #define PAGES_FOR_IO	512
 
-static const char name_suspend[] = "Suspend Machine: ";
-static const char name_resume[] = "Resume Machine: ";
-
 /*
  * Saving part...
  */
@@ -141,10 +136,10 @@
 	rw_swap_page_sync(READ, 
 			  swp_entry(root_swap, 0),
 			  virt_to_page((unsigned long)&swsusp_header));
-	if (!memcmp("SWAP-SPACE",swsusp_header.sig,10) ||
-	    !memcmp("SWAPSPACE2",swsusp_header.sig,10)) {
-		memcpy(swsusp_header.orig_sig,swsusp_header.sig,10);
-		memcpy(swsusp_header.sig,SWSUSP_SIG,10);
+	if (!memcmp("SWAP-SPACE",swsusp_header.sig, 10) ||
+	    !memcmp("SWAPSPACE2",swsusp_header.sig, 10)) {
+		memcpy(swsusp_header.orig_sig,swsusp_header.sig, 10);
+		memcpy(swsusp_header.sig,SWSUSP_SIG, 10);
 		swsusp_header.swsusp_info = prev;
 		error = rw_swap_page_sync(WRITE, 
 					  swp_entry(root_swap, 0),
@@ -265,9 +260,10 @@
 
 
 /**
- *	free_data - Free the swap entries used by the saved image.
+ *	data_free - Free the swap entries used by the saved image.
  *
  *	Walk the list of used swap entries and free each one. 
+ *	This is only used for cleanup when suspend fails.
  */
 
 static void data_free(void)
@@ -287,7 +283,7 @@
 
 
 /**
- *	write_data - Write saved image to swap.
+ *	data_write - Write saved image to swap.
  *
  *	Walk the list of pages in the image and sync each one to swap.
  */
@@ -351,15 +351,16 @@
 }
 
 /**
- *	free_pagedir - Free pages used by the page directory.
+ *	free_pagedir_entries - Free pages used by the page directory.
+ *
+ *	This is used during suspend for error recovery.
  */
 
 static void free_pagedir_entries(void)
 {
-	int num = swsusp_info.pagedir_pages;
 	int i;
 
-	for (i = 0; i < num; i++)
+	for (i = 0; i < swsusp_info.pagedir_pages; i++)
 		swap_free(swsusp_info.pagedir[i]);
 }
 
@@ -379,7 +380,7 @@
 	swsusp_info.pagedir_pages = n;
 	printk( "Writing pagedir (%d pages)\n", n);
 	for (i = 0; i < n && !error; i++, addr += PAGE_SIZE)
-		error = write_page(addr,&swsusp_info.pagedir[i]);
+		error = write_page(addr, &swsusp_info.pagedir[i]);
 	return error;
 }
 
@@ -668,8 +632,8 @@
 /**
  *	alloc_pagedir - Allocate the page directory.
  *
- *	First, determine exactly how many contiguous pages we need, 
- *	allocate them, then mark each 'unsavable'.
+ *	First, determine exactly how many contiguous pages we need and
+ *	allocate them.
  */
 
 static int alloc_pagedir(void)
@@ -721,7 +704,7 @@
 
 static int enough_free_mem(void)
 {
-	if(nr_free_pages() < (nr_copy_pages + PAGES_FOR_IO)) {
+	if (nr_free_pages() < (nr_copy_pages + PAGES_FOR_IO)) {
 		pr_debug("swsusp: Not enough free pages: Have %d\n",
 			 nr_free_pages());
 		return 0;
@@ -757,7 +740,7 @@
 	int error;
 
 	pr_debug("suspend: (pages needed: %d + %d free: %d)\n",
-		 nr_copy_pages,PAGES_FOR_IO,nr_free_pages());
+		 nr_copy_pages, PAGES_FOR_IO, nr_free_pages());
 
 	pagedir_nosave = NULL;
 	if (!enough_free_mem())
@@ -788,7 +771,7 @@
 
 	pr_debug("swsusp: critical section: \n");
 	if (save_highmem()) {
-		printk(KERN_CRIT "%sNot enough free pages for highmem\n", name_suspend);
+		printk(KERN_CRIT "Suspend machine: Not enough free pages for highmem\n");
 		return -ENOMEM;
 	}
 
@@ -907,8 +891,8 @@
 	int i;
 	unsigned long addre = addr + (PAGE_SIZE<<order);
 	
-	for(i=0; i < nr_copy_pages; i++)
-		if((pagedir+i)->orig_address >= addr &&
+	for (i=0; i < nr_copy_pages; i++)
+		if ((pagedir+i)->orig_address >= addr &&
 			(pagedir+i)->orig_address < addre)
 			return 1;
 
@@ -1030,7 +1004,7 @@
 	int error = 0;
 	struct bio * bio;
 
-	bio = bio_alloc(GFP_ATOMIC,1);
+	bio = bio_alloc(GFP_ATOMIC, 1);
 	if (!bio)
 		return -ENOMEM;
 	bio->bi_sector = page_off * (PAGE_SIZE >> 9);
@@ -1056,12 +1033,12 @@
 
 int bio_read_page(pgoff_t page_off, void * page)
 {
-	return submit(READ,page_off,page);
+	return submit(READ, page_off, page);
 }
 
 int bio_write_page(pgoff_t page_off, void * page)
 {
-	return submit(WRITE,page_off,page);
+	return submit(WRITE, page_off, page);
 }
 
 /*
@@ -1111,16 +1089,16 @@
 {
 	int error;
 
-	memset(&swsusp_header,0,sizeof(swsusp_header));
-	if ((error = bio_read_page(0,&swsusp_header)))
+	memset(&swsusp_header, 0, sizeof(swsusp_header));
+	if ((error = bio_read_page(0, &swsusp_header)))
 		return error;
-	if (!memcmp(SWSUSP_SIG,swsusp_header.sig,10)) {
-		memcpy(swsusp_header.sig,swsusp_header.orig_sig,10);
+	if (!memcmp(SWSUSP_SIG, swsusp_header.sig, 10)) {
+		memcpy(swsusp_header.sig, swsusp_header.orig_sig, 10);
 
 		/*
 		 * Reset swap signature now.
 		 */
-		error = bio_write_page(0,&swsusp_header);
+		error = bio_write_page(0, &swsusp_header);
 	} else { 
 		pr_debug(KERN_ERR "swsusp: Suspend partition has wrong signature?\n");
 		return -EINVAL;
@@ -1194,7 +1163,7 @@
 			error = -EFAULT;
 	}
 	if (error)
-		free_pages((unsigned long)pagedir_nosave,pagedir_order);
+		free_pages((unsigned long)pagedir_nosave, pagedir_order);
 	return error;
 }
 
