Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267238AbSK3NUU>; Sat, 30 Nov 2002 08:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267239AbSK3NUU>; Sat, 30 Nov 2002 08:20:20 -0500
Received: from [195.39.17.254] ([195.39.17.254]:8708 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267238AbSK3NUO>;
	Sat, 30 Nov 2002 08:20:14 -0500
Date: Sat, 30 Nov 2002 14:26:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp for 2.5.50
Message-ID: <20021130132642.GA126@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This adds support for 64-bit machines, moves config option where it
belongs and fixes compile problems, adds minimal support for md, and
cleans stuff up. Please apply,

								Pavel


--- clean/arch/i386/Kconfig	2002-11-29 21:16:30.000000000 +0100
+++ linux-swsusp/arch/i386/Kconfig	2002-11-29 21:29:34.000000000 +0100
@@ -789,8 +789,6 @@
 
 menu "Power management options (ACPI, APM)"
 
-source "drivers/acpi/Kconfig"
-
 config PM
 	bool "Power Management support"
 	---help---
@@ -811,6 +809,37 @@
 	  will issue the hlt instruction if nothing is to be done, thereby
 	  sending the processor to sleep and saving power.
 
+config SOFTWARE_SUSPEND
+	bool "Software Suspend (EXPERIMENTAL)"
+	depends on EXPERIMENTAL && PM
+	---help---
+	  Enable the possibilty of suspendig machine. It doesn't need APM.
+	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
+	  (patch for sysvinit needed). 
+
+	  It creates an image which is saved in your active swaps. By the next
+	  booting the, pass 'resume=/path/to/your/swap/file' and kernel will 
+	  detect the saved image, restore the memory from
+	  it and then it continues to run as before you've suspended.
+	  If you don't want the previous state to continue use the 'noresume'
+	  kernel option. However note that your partitions will be fsck'd and
+	  you must re-mkswap your swap partitions/files.
+
+	  Right now you may boot without resuming and then later resume but
+	  in meantime you cannot use those swap partitions/files which were
+	  involved in suspending. Also in this case there is a risk that buffers
+	  on disk won't match with saved ones.
+
+	  SMP is supported ``as-is''. There's a code for it but doesn't work.
+	  There have been problems reported relating SCSI.
+
+	  This option is about getting stable. However there is still some
+	  absence of features.
+
+	  For more information take a look at Documentation/swsusp.txt.
+
+source "drivers/acpi/Kconfig"
+
 config APM
 	tristate "Advanced Power Management BIOS support"
 	depends on PM
@@ -1516,35 +1545,6 @@
 
 menu "Kernel hacking"
 
-config SOFTWARE_SUSPEND
-	bool "Software Suspend (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && PM
-	---help---
-	  Enable the possibilty of suspendig machine. It doesn't need APM.
-	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
-	  (patch for sysvinit needed). 
-
-	  It creates an image which is saved in your active swaps. By the next
-	  booting the, pass 'resume=/path/to/your/swap/file' and kernel will 
-	  detect the saved image, restore the memory from
-	  it and then it continues to run as before you've suspended.
-	  If you don't want the previous state to continue use the 'noresume'
-	  kernel option. However note that your partitions will be fsck'd and
-	  you must re-mkswap your swap partitions/files.
-
-	  Right now you may boot without resuming and then later resume but
-	  in meantime you cannot use those swap partitions/files which were
-	  involved in suspending. Also in this case there is a risk that buffers
-	  on disk won't match with saved ones.
-
-	  SMP is supported ``as-is''. There's a code for it but doesn't work.
-	  There have been problems reported relating SCSI.
-
-	  This option is about getting stable. However there is still some
-	  absence of features.
-
-	  For more information take a look at Documentation/swsusp.txt.
-
 config DEBUG_KERNEL
 	bool "Kernel debugging"
 	help
--- clean/drivers/acpi/Kconfig	2002-11-01 00:37:09.000000000 +0100
+++ linux-swsusp/drivers/acpi/Kconfig	2002-11-23 21:16:32.000000000 +0100
@@ -58,8 +58,7 @@
 
 config ACPI_SLEEP
 	bool "Sleep States"
-	depends on X86 && ACPI && !ACPI_HT_ONLY
-	default SOFTWARE_SUSPEND
+	depends on X86 && ACPI && !ACPI_HT_ONLY && SOFTWARE_SUSPEND
 	---help---
 	  This option adds support for ACPI suspend states. 
 
--- clean/drivers/md/md.c	2002-11-23 19:55:20.000000000 +0100
+++ linux-swsusp/drivers/md/md.c	2002-11-23 19:57:55.000000000 +0100
@@ -36,6 +36,7 @@
 #include <linux/bio.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/buffer_head.h> /* for invalidate_bdev */
+#include <linux/suspend.h>
 
 #include <linux/init.h>
 
@@ -2466,6 +2467,8 @@
 
 		wait_event_interruptible(thread->wqueue,
 					 test_bit(THREAD_WAKEUP, &thread->flags));
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_IOTHREAD);
 
 		clear_bit(THREAD_WAKEUP, &thread->flags);
 
--- clean/kernel/suspend.c	2002-11-19 16:46:15.000000000 +0100
+++ linux-swsusp/kernel/suspend.c	2002-11-19 15:38:28.000000000 +0100
@@ -80,9 +80,9 @@
 #endif
 
 #define TIMEOUT	(6 * HZ)			/* Timeout for stopping processes */
-#define ADDRESS(x) ((unsigned long) phys_to_virt(((x) << PAGE_SHIFT)))
-
-extern int C_A_D;
+#define __ADDRESS(x)  ((unsigned long) phys_to_virt(x))
+#define ADDRESS(x) __ADDRESS((x) << PAGE_SHIFT)
+#define ADDRESS2(x) __ADDRESS(__pa(x))		/* Needed for x86-64 where some pages are in memory twice */
 
 /* References to section boundaries */
 extern char _text, _etext, _edata, __bss_start, _end;
@@ -145,10 +145,10 @@
 /*
  * Debug
  */
-#undef	DEBUG_DEFAULT
+#define	DEBUG_DEFAULT
 #undef	DEBUG_PROCESS
 #undef	DEBUG_SLOW
-#define TEST_SWSUSP 1		/* Set to 1 to reboot instead of halt machine after suspension */
+#define TEST_SWSUSP 0		/* Set to 1 to reboot instead of halt machine after suspension */
 
 #ifdef DEBUG_DEFAULT
 # define PRINTK(f, a...)       printk(f, ## a)
@@ -235,6 +235,7 @@
 	} while(todo);
 	
 	printk( "|\n" );
+	BUG_ON(in_atomic());
 	return 0;
 }
 
@@ -322,20 +323,20 @@
 	rw_swap_page_sync(READ, entry, page);
 
 	if (mode == MARK_SWAP_RESUME) {
-	  	if (!memcmp("SUSP1R",cur->swh.magic.magic,6))
+	  	if (!memcmp("S1",cur->swh.magic.magic,2))
 		  	memcpy(cur->swh.magic.magic,"SWAP-SPACE",10);
-		else if (!memcmp("SUSP2R",cur->swh.magic.magic,6))
+		else if (!memcmp("S2",cur->swh.magic.magic,2))
 			memcpy(cur->swh.magic.magic,"SWAPSPACE2",10);
 		else printk("%sUnable to find suspended-data signature (%.10s - misspelled?\n", 
 		      	name_resume, cur->swh.magic.magic);
 	} else {
 	  	if ((!memcmp("SWAP-SPACE",cur->swh.magic.magic,10)))
-		  	memcpy(cur->swh.magic.magic,"SUSP1R....",10);
+		  	memcpy(cur->swh.magic.magic,"S1SUSP....",10);
 		else if ((!memcmp("SWAPSPACE2",cur->swh.magic.magic,10)))
-			memcpy(cur->swh.magic.magic,"SUSP2R....",10);
+			memcpy(cur->swh.magic.magic,"S2SUSP....",10);
 		else panic("\nSwapspace is not swapspace (%.10s)\n", cur->swh.magic.magic);
 		cur->link.next = prev; /* prev is the first/last swap page of the resume area */
-		/* link.next lies *no more* in last 4 bytes of magic */
+		/* link.next lies *no more* in last 4/8 bytes of magic */
 	}
 	rw_swap_page_sync(WRITE, entry, page);
 	__free_page(page);
@@ -489,7 +490,6 @@
 			if (PageNosave(page))
 				continue;
 
-
 			if ((chunk_size=is_head_of_free_region(page))!=0) {
 				pfn += chunk_size - 1;
 				continue;
@@ -500,10 +500,9 @@
 			/*
 			 * Just copy whole code segment. Hopefully it is not that big.
 			 */
-			if (ADDRESS(pfn) >= (unsigned long)
-				&__nosave_begin && ADDRESS(pfn) < 
-				(unsigned long)&__nosave_end) {
-				PRINTK("[nosave %x]", ADDRESS(pfn));
+			if ((ADDRESS(pfn) >= (unsigned long) ADDRESS2(&__nosave_begin)) && 
+			    (ADDRESS(pfn) <  (unsigned long) ADDRESS2(&__nosave_end))) {
+				PRINTK("[nosave %lx]", ADDRESS(pfn));
 				continue;
 			}
 			/* Hmm, perhaps copying all reserved pages is not too healthy as they may contain 
@@ -513,7 +512,7 @@
 		nr_copy_pages++;
 		if (pagedir_p) {
 			pagedir_p->orig_address = ADDRESS(pfn);
-			copy_page(pagedir_p->address, pagedir_p->orig_address);
+			copy_page((void *) pagedir_p->address, (void *) pagedir_p->orig_address);
 			pagedir_p++;
 		}
 	}
@@ -549,7 +548,7 @@
 
 	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
 
-	p = pagedir = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC, pagedir_order);
+	p = pagedir = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD, pagedir_order);
 	if(!pagedir)
 		return NULL;
 
@@ -558,11 +557,12 @@
 		SetPageNosave(page++);
 		
 	while(nr_copy_pages--) {
-		p->address = get_zeroed_page(GFP_ATOMIC);
+		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
 		if(!p->address) {
 			free_suspend_pagedir((unsigned long) pagedir);
 			return NULL;
 		}
+		printk(".");
 		SetPageNosave(virt_to_page(p->address));
 		p->orig_address = 0;
 		p++;
@@ -623,7 +623,7 @@
 static void free_some_memory(void)
 {
 	printk("Freeing memory: ");
-	while (try_to_free_pages(&contig_page_data.node_zones[ZONE_HIGHMEM], GFP_KSWAPD, 0))
+	while (shrink_all_memory(10000))
 		printk(".");
 	printk("|\n");
 }
@@ -676,7 +676,7 @@
 	}
 }
 
-static int suspend_save_image(void)
+static int suspend_prepare_image(void)
 {
 	struct sysinfo i;
 	unsigned int nr_needed_pages = 0;
@@ -725,9 +725,15 @@
 	 *
 	 * Following line enforces not writing to disk until we choose.
 	 */
-	drivers_unsuspend();
-	spin_unlock_irq(&suspend_pagedir_lock);
+
 	printk( "critical section/: done (%d pages copied)\n", nr_copy_pages );
+	spin_unlock_irq(&suspend_pagedir_lock);
+	return 0;
+}
+
+static void suspend_save_image(void)
+{
+	drivers_unsuspend();
 
 	lock_swapdevices();
 	write_suspend_image();
@@ -738,11 +744,11 @@
 	 * filesystem clean: it is not. (And it does not matter, if we resume
 	 * correctly, we'll mark system clean, anyway.)
 	 */
-	return 0;
 }
 
-void suspend_power_down(void)
+static void suspend_power_down(void)
 {
+	extern int C_A_D;
 	C_A_D = 0;
 	printk(KERN_EMERG "%s%s Trying to power down.\n", name_suspend, TEST_SWSUSP ? "Disable TEST_SWSUSP. NOT ": "");
 #ifdef CONFIG_VT
@@ -788,8 +794,8 @@
 
 	PRINTK( "Freeing prev allocated pagedir\n" );
 	free_suspend_pagedir((unsigned long) pagedir_save);
-	drivers_resume(RESUME_ALL_PHASES);
 	spin_unlock_irq(&suspend_pagedir_lock);
+	drivers_resume(RESUME_ALL_PHASES);
 
 	PRINTK( "Fixing swap signatures... " );
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
@@ -804,14 +810,17 @@
 {
 	mb();
 	barrier();
+	BUG_ON(in_atomic());
 	spin_lock_irq(&suspend_pagedir_lock);
 }
 
 void do_magic_suspend_2(void)
 {
 	read_swapfiles();
-	if (!suspend_save_image())
+	if (!suspend_prepare_image()) {	/* suspend_save_image realeses suspend_pagedir_lock */
+		suspend_save_image();
 		suspend_power_down();	/* FIXME: if suspend_power_down is commented out, console is lost after few suspends ?! */
+	}
 
 	printk(KERN_EMERG "%sSuspend failed, trying to recover...\n", name_suspend);
 	MDELAY(1000); /* So user can wait and report us messages if armageddon comes :-) */
@@ -827,7 +836,7 @@
 	PRINTK(KERN_WARNING "%sLeaving do_magic_suspend_2...\n", name_suspend);	
 }
 
-void do_software_suspend(void)
+static void do_software_suspend(void)
 {
 	arch_prepare_suspend();
 	if (prepare_suspend_console())
@@ -1069,9 +1078,9 @@
 
 	PREPARENEXT; /* We have to read next position before we overwrite it */
 
-	if (!memcmp("SUSP1R",cur->swh.magic.magic,6))
+	if (!memcmp("S1",cur->swh.magic.magic,2))
 		memcpy(cur->swh.magic.magic,"SWAP-SPACE",10);
-	else if (!memcmp("SUSP2R",cur->swh.magic.magic,6))
+	else if (!memcmp("S2",cur->swh.magic.magic,2))
 		memcpy(cur->swh.magic.magic,"SWAPSPACE2",10);
 	else {
 		panic("%sUnable to find suspended-data signature (%.10s - misspelled?\n", 

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
