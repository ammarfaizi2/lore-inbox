Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264529AbSIVUrK>; Sun, 22 Sep 2002 16:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264538AbSIVUrK>; Sun, 22 Sep 2002 16:47:10 -0400
Received: from [195.39.17.254] ([195.39.17.254]:7552 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S264529AbSIVUrH>;
	Sun, 22 Sep 2002 16:47:07 -0400
Date: Sat, 21 Sep 2002 23:12:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp updates
Message-ID: <20020921211251.GA31803@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Small updates to documentation, sanity checks turned into BUG_ONs to
save space, fix recovery on resume error. Please apply,

							Pavel


--- clean/Documentation/swsusp.txt	2002-07-09 04:54:06.000000000 +0200
+++ linux-swsusp/Documentation/swsusp.txt	2002-09-13 19:12:59.000000000 +0200
@@ -148,7 +148,7 @@
   corrupts the virtual console of X.. (Maybe this has been fixed AFAIK).
 
 Drivers we support
-- IDE disks are okay
+- IDE disks are okay... Were okay before Andre's ide came back.
 - vesafb
 
 Drivers that need support
@@ -156,6 +156,23 @@
 - do IDE cdroms need some kind of support?
 - IDE CD-RW -- how to deal with that?
 
+FAQ:
+
+Q: well, suspending a server is IMHO a really stupid thing,
+but... (Diego Zuccato):
+
+A: You bought new UPS for your server. How do you install it without
+bringing machine down? Suspend to disk, rearrange power cables,
+resume.
+
+You have your server on UPS. Power died, and UPS is indicating 30
+seconds to failure. What do you do? Suspend to disk.
+
+Ethernet card in your server died. You want to replace it. Your
+server is not hotplug capable. What do you do? Suspend to disk,
+replace ethernet card, resume. If you are fast your users will not
+even see broken connections.
+
 Any other idea you might have tell me!
 
 Contacting the author
--- clean/kernel/suspend.c	2002-09-21 13:20:46.000000000 +0200
+++ linux-swsusp/kernel/suspend.c	2002-09-21 13:25:41.000000000 +0200
@@ -472,16 +472,17 @@
 	int pfn;
 	struct page *page;
 	
-	if (max_mapnr != num_physpages)
-		panic("mapnr is not expected");
+	BUG_ON (max_mapnr != num_physpages);
 	for (pfn = 0; pfn < max_mapnr; pfn++) {
 		page = pfn_to_page(pfn);
 		if (PageHighMem(page))
 			panic("Swsusp not supported on highmem boxes. Send 1GB of RAM to <pavel@ucw.cz> and try again ;-).");
+
 		if (!PageReserved(page)) {
 			if (PageNosave(page))
 				continue;
 
+
 			if ((chunk_size=is_head_of_free_region(page))!=0) {
 				pfn += chunk_size - 1;
 				continue;
@@ -774,9 +785,10 @@
 	BUG_ON (nr_copy_pages_check != nr_copy_pages);
 	BUG_ON (pagedir_order_check != pagedir_order);
 
+	__flush_tlb_global();		/* Even mappings of "global" things (vmalloc) need to be fixed */
+
 	PRINTK( "Freeing prev allocated pagedir\n" );
 	free_suspend_pagedir((unsigned long) pagedir_save);
-	__flush_tlb_global();		/* Even mappings of "global" things (vmalloc) need to be fixed */
 	drivers_resume(RESUME_ALL_PHASES);
 	spin_unlock_irq(&suspend_pagedir_lock);
 
@@ -807,12 +819,10 @@
 
 	barrier();
 	mb();
-	drivers_resume(RESUME_PHASE2);
 	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
 	mdelay(1000);
 
 	free_pages((unsigned long) pagedir_nosave, pagedir_order);
-	drivers_resume(RESUME_PHASE1);
 	spin_unlock_irq(&suspend_pagedir_lock);
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
 	PRINTK(KERN_WARNING "%sLeaving do_magic_suspend_2...\n", name_suspend);	
@@ -1035,6 +1045,7 @@
 	return 0;
 #endif
 	printk(KERN_CRIT "%sWarning %s: Fixing swap signatures unimplemented...\n", name_resume, resume_file);
+	return 0;
 }
 
 extern kdev_t __init name_to_kdev_t(const char *line);

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
