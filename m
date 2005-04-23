Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbVDWVx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbVDWVx6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 17:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVDWVxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 17:53:03 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:48031 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262068AbVDWVsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 17:48:18 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] swsusp: misc cleanups [4/4]
Date: Sat, 23 Apr 2005 23:38:43 +0200
User-Agent: KMail/1.7.1
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200504232320.54477.rjw@sisk.pl>
In-Reply-To: <200504232320.54477.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504232338.43297.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch makes some comments and printk()s in swsusp.c up to date.
In particular it adds the string "swsusp" before every message that is printed by
the code in swsusp.c.

Please consider for applying.


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

diff -Nurp b/kernel/power/swsusp.c c/kernel/power/swsusp.c
--- b/kernel/power/swsusp.c	2005-04-23 22:41:57.000000000 +0200
+++ c/kernel/power/swsusp.c	2005-04-23 22:42:38.000000000 +0200
@@ -289,7 +289,7 @@ static int data_write(void)
 	if (!mod)
 		mod = 1;
 
-	printk( "Writing data to swap (%d pages)...     ", nr_copy_pages );
+	printk( "swsusp: Writing data to swap (%d pages)...     ", nr_copy_pages );
 	for_each_pbe (p, pagedir_nosave) {
 		if (!(i%mod))
 			printk( "\b\b\b\b%3d%%", i / mod );
@@ -369,7 +369,7 @@ static int write_pagedir(void)
 	unsigned n = 0;
 	struct pbe * pbe;
 
-	printk( "Writing pagedir...");
+	printk( "swsusp: Writing pagedir ... ");
 	for_each_pb_page (pbe, pagedir_nosave) {
 		if ((error = write_page((unsigned long)pbe, &swsusp_info.pagedir[n++])))
 			return error;
@@ -563,7 +563,7 @@ static void copy_data_pages(void)
 	unsigned long zone_pfn;
 	struct pbe * pbe = pagedir_nosave;
 
-	pr_debug("copy_data_pages(): pages to copy: %d\n", nr_copy_pages);
+	pr_debug("swsusp: pages to copy: %d\n", nr_copy_pages);
 	for_each_zone (zone) {
 		if (is_highmem(zone))
 			continue;
@@ -656,14 +656,11 @@ static void create_pbe_list(struct pbe *
 			p->next = p + 1;
 		p->next = NULL;
 	}
-	pr_debug("create_pbe_list(): initialized %d PBEs\n", num);
+	pr_debug("swsusp: initialized %d PBEs\n", num);
 }
 
 /**
- *	alloc_pagedir - Allocate the page directory.
- *
- *	First, determine exactly how many pages we need and
- *	allocate them.
+ *	alloc_pagedir - Allocate the list of page backup entries.
  *
  *	We arrange the pages in a chain: each page is an array of PBES_PER_PAGE
  *	struct pbe elements (pbes) and the last element in the page points
@@ -680,7 +677,6 @@ static struct pbe * alloc_pagedir(unsign
 	if (!nr_pages)
 		return NULL;
 
-	pr_debug("alloc_pagedir(): nr_pages = %d\n", nr_pages);
 	pblist = (struct pbe *)get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
 	for (pbe = pblist, num = PBES_PER_PAGE; pbe && num < nr_pages;
         		pbe = pbe->next, num += PBES_PER_PAGE) {
@@ -784,7 +780,7 @@ static int swsusp_alloc(void)
 	pagedir_nosave = NULL;
 	nr_copy_pages = calc_nr(nr_copy_pages);
 
-	pr_debug("suspend: (pages needed: %d + %d free: %d)\n",
+	pr_debug("swsusp: (pages needed: %d + %d free: %d)\n",
 		 nr_copy_pages, PAGES_FOR_IO, nr_free_pages());
 
 	if (!enough_free_mem())
@@ -794,13 +790,13 @@ static int swsusp_alloc(void)
 		return -ENOSPC;
 
 	if (!(pagedir_save = alloc_pagedir(nr_copy_pages))) {
-		printk(KERN_ERR "suspend: Allocating pagedir failed.\n");
+		printk(KERN_ERR "swsusp: Allocating pagedir failed.\n");
 		return -ENOMEM;
 	}
 	create_pbe_list(pagedir_save, nr_copy_pages);
 	pagedir_nosave = pagedir_save;
 	if ((error = alloc_image_pages())) {
-		printk(KERN_ERR "suspend: Allocating image pages failed.\n");
+		printk(KERN_ERR "swsusp: Allocating image pages failed.\n");
 		swsusp_free();
 		return error;
 	}
@@ -815,7 +811,7 @@ static int suspend_prepare_image(void)
 
 	pr_debug("swsusp: critical section: \n");
 	if (save_highmem()) {
-		printk(KERN_CRIT "Suspend machine: Not enough free pages for highmem\n");
+		printk(KERN_CRIT "swsusp: Not enough free pages for highmem\n");
 		restore_highmem();
 		return -ENOMEM;
 	}
@@ -892,7 +888,7 @@ int swsusp_suspend(void)
 	 * at resume time, and evil weirdness ensues.
 	 */
 	if ((error = device_power_down(PMSG_FREEZE))) {
-		printk(KERN_ERR "Some devices failed to power down, aborting suspend\n");
+		printk(KERN_ERR "swsusp: Some devices failed to power down, aborting suspend\n");
 		local_irq_enable();
 		swsusp_free();
 		return error;
@@ -914,7 +910,7 @@ int swsusp_resume(void)
 	int error;
 	local_irq_disable();
 	if (device_power_down(PMSG_FREEZE))
-		printk(KERN_ERR "Some devices failed to power down, very bad\n");
+		printk(KERN_ERR "swsusp: Some devices failed to power down, very bad\n");
 	/* We'll ignore saved state, but this gets preempt count (etc) right */
 	save_processor_state();
 	error = swsusp_arch_resume();
@@ -1226,9 +1222,6 @@ static int check_sig(void)
 
 /**
  *	data_read - Read image pages from swap.
- *
- *	You do not need to check for overlaps, check_pagedir()
- *	already did that.
  */
 
 static int data_read(struct pbe *pblist)

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
