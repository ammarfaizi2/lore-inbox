Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUIINqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUIINqZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 09:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUIINqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 09:46:25 -0400
Received: from checkpoint-out.gate.uni-erlangen.de ([131.188.28.69]:60103 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263818AbUIINpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 09:45:16 -0400
Date: Thu, 9 Sep 2004 15:44:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: FYI: my current bigdiff
Message-ID: <20040909134421.GA12204@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is my bigdiff. It is not for inclusion (I'll have to split it),
but it contains some usefull code (I believe :-).

Oh, it speeds up swsusp quite a lot.

								Pavel
-- 
When do you have heart between your knees?



--- clean-mm/Documentation/power/swsusp.txt	2004-08-24 09:01:50.000000000 +0200
+++ linux-mm/Documentation/power/swsusp.txt	2004-09-07 21:15:17.000000000 +0200
@@ -20,26 +20,6 @@
 You need to append resume=/dev/your_swap_partition to kernel command
 line. Then you suspend by echo 4 > /proc/acpi/sleep.
 
-Pavel's unreliable guide to swsusp mess
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-There are currently two versions of swap suspend in the kernel, the old
-"Pavel's" version in kernel/power/swsusp.c and the new "Patrick's"
-version in kernel/power/pmdisk.c. They provide the same functionality;
-the old version looks ugly but was tested, while the new version looks
-nicer but did not receive so much testing. echo 4 > /proc/acpi/sleep
-calls the old version, echo disk > /sys/power/state calls the new one.
-
-[In the future, when the new version is stable enough, two things can
-happen:
-
-* the new version is moved into swsusp.c, and swsusp is renamed to swap
-  suspend (Pavel prefers this)
-
-* pmdisk is kept as is and swsusp.c is removed from the kernel]
-
-
-
 Article about goals and implementation of Software Suspend for Linux
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Author: G‚ábor Kuti
@@ -75,10 +55,6 @@
 About the code
 
 Things to implement
-- SMP support. I've done an SMP support but since I don't have access to a kind
-  of this one I cannot test it. Please SMP people test it.  .. Tested it,
-  doesn't work. Had no time to figure out why. There is some mess with
-  interrupts AFAIK..
 - We should only make a copy of data related to kernel segment, since any
   process data won't be changed.
 - Should make more sanity checks. Or are these enough?
@@ -90,11 +66,6 @@
 - We should not free pages at the beginning so aggressively, most of them
   go there anyway..
 
-Drivers that need support
-- pc_keyb -- perhaps we can wait for vojtech's input patches
-- do IDE cdroms need some kind of support?
-- IDE CD-RW -- how to deal with that?
-
 Sleep states summary (thanx, Ducrot)
 ====================================
 
@@ -109,7 +80,8 @@
 echo 4b > /proc/acpi/sleep      # for suspend to disk via s4bios
 
 
-FAQ:
+Frequently Asked Questions
+==========================
 
 Q: well, suspending a server is IMHO a really stupid thing,
 but... (Diego Zuccato):
--- clean-mm/arch/i386/kernel/acpi/wakeup.S	2004-08-24 09:02:23.000000000 +0200
+++ linux-mm/arch/i386/kernel/acpi/wakeup.S	2004-09-07 21:15:17.000000000 +0200
@@ -11,8 +11,23 @@
 #
 # If physical address of wakeup_code is 0x12345, BIOS should call us with
 # cs = 0x1234, eip = 0x05
-# 
+#
 
+#define BEEP \
+	inb	$97, %al; 	\
+	outb	%al, $0x80; 	\
+	movb	$3, %al; 	\
+	outb	%al, $97; 	\
+	outb	%al, $0x80; 	\
+	movb	$-74, %al; 	\
+	outb	%al, $67; 	\
+	outb	%al, $0x80; 	\
+	movb	$-119, %al; 	\
+	outb	%al, $66; 	\
+	outb	%al, $0x80; 	\
+	movb	$15, %al; 	\
+	outb	%al, $66; 
+	
 ALIGN
 	.align	4096
 ENTRY(wakeup_start)
@@ -20,6 +35,7 @@
 	wakeup_code_start = .
 	.code16
 
+	BEEP
  	movw	$0xb800, %ax
 	movw	%ax,%fs
 	movw	$0x0e00 + 'L', %fs:(0x10)
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
--- clean-mm/drivers/acpi/fan.c	2004-08-24 09:01:53.000000000 +0200
+++ linux-mm/drivers/acpi/fan.c	2004-09-07 21:15:19.000000000 +0200
@@ -94,10 +94,10 @@
 		goto end;
 
 	if (acpi_bus_get_power(fan->handle, &state))
-		goto end;
-
-	p += sprintf(p, "status:                  %s\n",
-		!state?"on":"off");
+		p += sprintf(p, "status:                  ERROR\n");
+	else
+		p += sprintf(p, "status:                  %s\n",
+			     !state?"on":"off");
 
 end:
 	len = (p - page);
--- clean-mm/drivers/acpi/sleep/proc.c	2004-08-24 09:03:14.000000000 +0200
+++ linux-mm/drivers/acpi/sleep/proc.c	2004-09-07 21:15:19.000000000 +0200
@@ -57,7 +57,8 @@
 	int	error = 0;
 
 	if (count > sizeof(str) - 1)
-		goto Done;
+		return -EIO;
+
 	memset(str,0,sizeof(str));
 	if (copy_from_user(str, buffer, count))
 		return -EFAULT;
@@ -65,17 +66,16 @@
 	/* Check for S4 bios request */
 	if (!strcmp(str,"4b")) {
 		error = acpi_suspend(4);
-		goto Done;
+		return error ? error : count;
 	}
 	state = simple_strtoul(str, NULL, 0);
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	if (state == 4) {
-		software_suspend();
-		goto Done;
+		error = software_suspend();
+		return error ? error : count;
 	}
 #endif
 	error = acpi_suspend(state);
- Done:
 	return error ? error : count;
 }
 
--- clean-mm/drivers/base/power/power.h	2004-08-24 09:01:51.000000000 +0200
+++ linux-mm/drivers/base/power/power.h	2004-09-07 21:15:19.000000000 +0200
@@ -1,5 +1,4 @@
-
-
+/* FIXME: This needs explanation... */
 enum {
 	DEVICE_PM_ON,
 	DEVICE_PM1,
--- clean-mm/drivers/char/keyboard.c	2004-09-07 21:12:22.000000000 +0200
+++ linux-mm/drivers/char/keyboard.c	2004-09-07 21:15:19.000000000 +0200
@@ -1076,6 +1076,23 @@
 		sysrq_down = down;
 		return;
 	}
+	if (test_bit(KEY_LEFTALT, key_down) &&
+	    test_bit(KEY_RIGHTALT, key_down) &&
+	    test_bit(KEY_LEFTSHIFT, key_down) &&
+	    test_bit(KEY_RIGHTSHIFT, key_down) &&
+		down && !rep) {
+		handle_sysrq(kbd_sysrq_xlate[keycode], regs, tty);
+#ifdef CONFIG_KGDB_SYSRQ
+                sysrq_down = 0;        /* in case we miss the "up" event */
+#endif
+		return;
+	}
+
+	if (down)
+		set_bit(keycode, key_down);
+	else
+		clear_bit(keycode, key_down);
+
 	if (sysrq_down && down && !rep) {
 		handle_sysrq(kbd_sysrq_xlate[keycode], regs, tty);
 #ifdef CONFIG_KGDB_SYSRQ
@@ -1111,11 +1128,6 @@
 		raw_mode = 1;
 	}
 
-	if (down)
-		set_bit(keycode, key_down);
-	else
-		clear_bit(keycode, key_down);
-
 	if (rep && (!vc_kbd_mode(kbd, VC_REPEAT) || (tty && 
 		(!L_ECHO(tty) && tty->driver->chars_in_buffer(tty))))) {
 		/*
--- clean-mm/drivers/video/aty/radeon_pm.c	2004-08-24 09:03:18.000000000 +0200
+++ linux-mm/drivers/video/aty/radeon_pm.c	2004-09-07 21:15:20.000000000 +0200
@@ -871,7 +871,8 @@
 	agp_enable(0);
 #endif
 
-	fb_set_suspend(info, 1);
+	if (system_state != SYSTEM_SNAPSHOT)
+		fb_set_suspend(info, 1);
 
 	if (!(info->flags & FBINFO_HWACCEL_DISABLED)) {
 		/* Make sure engine is reset */
@@ -880,12 +881,14 @@
 		radeon_engine_idle();
 	}
 
-	/* Blank display and LCD */
-	radeonfb_blank(VESA_POWERDOWN, info);
-
-	/* Sleep */
-	rinfo->asleep = 1;
-	rinfo->lock_blank = 1;
+	if (system_state != SYSTEM_SNAPSHOT) {
+		/* Blank display and LCD */
+		radeonfb_blank(VESA_POWERDOWN, info);
+
+		/* Sleep */
+		rinfo->asleep = 1;
+		rinfo->lock_blank = 1;
+	}
 
 	/* Suspend the chip to D2 state when supported
 	 */
--- clean-mm/fs/bio.c	2004-09-07 21:12:30.000000000 +0200
+++ linux-mm/fs/bio.c	2004-09-07 21:15:20.000000000 +0200
@@ -143,7 +143,7 @@
 
 	bio = mempool_alloc(bio_pool, gfp_mask);
 	if (unlikely(!bio))
-		goto out;
+		return NULL;
 
 	bio_init(bio);
 
@@ -157,13 +157,11 @@
 noiovec:
 		bio->bi_io_vec = bvl;
 		bio->bi_destructor = bio_destructor;
-out:
 		return bio;
 	}
 
 	mempool_free(bio, bio_pool);
-	bio = NULL;
-	goto out;
+	return NULL;
 }
 
 /**
--- clean-mm/include/linux/page-flags.h	2004-09-07 21:12:33.000000000 +0200
+++ linux-mm/include/linux/page-flags.h	2004-09-07 21:15:21.000000000 +0200
@@ -75,7 +75,7 @@
 #define PG_swapcache		16	/* Swap page: swp_entry_t in private */
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
-
+#define PG_nosave_free		19	/* Page is free and should not be written */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -278,6 +278,10 @@
 #define ClearPageNosave(page)		clear_bit(PG_nosave, &(page)->flags)
 #define TestClearPageNosave(page)	test_and_clear_bit(PG_nosave, &(page)->flags)
 
+#define PageNosaveFree(page)	test_bit(PG_nosave_free, &(page)->flags)
+#define SetPageNosaveFree(page)	set_bit(PG_nosave_free, &(page)->flags)
+#define ClearPageNosaveFree(page)		clear_bit(PG_nosave_free, &(page)->flags)
+
 #define PageMappedToDisk(page)	test_bit(PG_mappedtodisk, &(page)->flags)
 #define SetPageMappedToDisk(page) set_bit(PG_mappedtodisk, &(page)->flags)
 #define ClearPageMappedToDisk(page) clear_bit(PG_mappedtodisk, &(page)->flags)
--- clean-mm/include/linux/suspend.h	2004-09-07 21:12:33.000000000 +0200
+++ linux-mm/include/linux/suspend.h	2004-09-07 21:15:22.000000000 +0200
@@ -31,6 +31,7 @@
 
 /* mm/page_alloc.c */
 extern void drain_local_pages(void);
+extern void mark_free_pages(struct zone *zone);
 
 /* kernel/power/swsusp.c */
 extern int software_suspend(void);
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
@@ -91,10 +91,20 @@
 
 static void free_some_memory(void)
 {
-	printk("Freeing memory: ");
-	while (shrink_all_memory(10000))
-		printk(".");
-	printk("|\n");
+	unsigned int i = 0;
+	unsigned int tmp;
+	unsigned long pages = 0;
+	char *p = "-\\|/";
+	
+	printk("Freeing memory...  ");
+	while ((tmp = shrink_all_memory(10000))) {
+		pages += tmp;
+		printk("\b%c", p[i]);
+		i++;
+		if (i > 3)
+			i = 0;
+	}
+	printk("\bdone (%li pages freed)\n", pages);
 }
 
 
@@ -167,6 +177,7 @@
 {
 	int error;
 
+	system_state = SYSTEM_SNAPSHOT;
 	if ((error = prepare()))
 		return error;
 
--- clean-mm/kernel/power/swsusp.c	2004-09-07 21:12:33.000000000 +0200
+++ linux-mm/kernel/power/swsusp.c	2004-09-09 08:56:20.000000000 +0200
@@ -74,11 +74,9 @@
 /* References to section boundaries */
 extern char __nosave_begin, __nosave_end;
 
-extern int is_head_of_free_region(struct page *);
-
 /* Variables to be preserved over suspend */
-int pagedir_order_check;
-int nr_copy_pages_check;
+static int pagedir_order_check;
+static int nr_copy_pages_check;
 
 extern char resume_file[];
 static dev_t resume_device;
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
@@ -296,15 +292,19 @@
 {
 	int error = 0;
 	int i;
-
-	printk( "Writing data to swap (%d pages): ", nr_copy_pages );
+	unsigned int mod = nr_copy_pages / 100;
+	
+	if (!mod)
+		mod = 1;
+	
+	printk( "Writing data to swap (%d pages)...     ", nr_copy_pages );
 	for (i = 0; i < nr_copy_pages && !error; i++) {
-		if (!(i%100))
-			printk( "." );
+		if (!(i%mod))
+			printk( "\b\b\b\b%3d%%", i / mod );
 		error = write_page((pagedir_nosave+i)->address,
 					  &((pagedir_nosave+i)->swap_address));
 	}
-	printk(" %d Pages done.\n",i);
+	printk("\b\b\b\bdone\n");
 	return error;
 }
 
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
 
@@ -423,12 +424,12 @@
 static int save_highmem_zone(struct zone *zone)
 {
 	unsigned long zone_pfn;
+	mark_free_pages(zone);
 	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
 		struct page *page;
 		struct highmem_page *save;
 		void *kaddr;
 		unsigned long pfn = zone_pfn + zone->zone_start_pfn;
-		int chunk_size;
 
 		if (!(pfn%1000))
 			printk(".");
@@ -445,11 +446,8 @@
 			printk("highmem reserved page?!\n");
 			continue;
 		}
-		if ((chunk_size = is_head_of_free_region(page))) {
-			pfn += chunk_size - 1;
-			zone_pfn += chunk_size - 1;
+		if (PageNosaveFree(page))
 			continue;
-		}
 		save = kmalloc(sizeof(struct highmem_page), GFP_ATOMIC);
 		if (!save)
 			return -ENOMEM;
@@ -528,14 +526,11 @@
 static int saveable(struct zone * zone, unsigned long * zone_pfn)
 {
 	unsigned long pfn = *zone_pfn + zone->zone_start_pfn;
-	unsigned long chunk_size;
 	struct page * page;
 
 	if (!pfn_valid(pfn))
 		return 0;
 
-	if (!(pfn%1000))
-		printk(".");
 	page = pfn_to_page(pfn);
 	BUG_ON(PageReserved(page) && PageNosave(page));
 	if (PageNosave(page))
@@ -544,10 +539,8 @@
 		pr_debug("[nosave pfn 0x%lx]", pfn);
 		return 0;
 	}
-	if ((chunk_size = is_head_of_free_region(page))) {
-		*zone_pfn += chunk_size - 1;
+	if (PageNosaveFree(page))
 		return 0;
-	}
 
 	return 1;
 }
@@ -561,6 +554,7 @@
 
 	for_each_zone(zone) {
 		if (!is_highmem(zone)) {
+			mark_free_pages(zone);
 			for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
 				nr_copy_pages += saveable(zone, &zone_pfn);
 		}
@@ -575,50 +569,20 @@
 	struct pbe * pbe = pagedir_nosave;
 	
 	for_each_zone(zone) {
-		if (!is_highmem(zone))
-			for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
-				if (saveable(zone, &zone_pfn)) {
-					struct page * page;
-					page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
-					pbe->orig_address = (long) page_address(page);
-					/* copy_page is no usable for copying task structs. */
-					memcpy((void *)pbe->address, (void *)pbe->orig_address, PAGE_SIZE);
-					pbe++;
-				}
-			}
-	}
-}
-
-
-static void free_suspend_pagedir_zone(struct zone *zone, unsigned long pagedir)
-{
-	unsigned long zone_pfn, pagedir_end, pagedir_pfn, pagedir_end_pfn;
-	pagedir_end = pagedir + (PAGE_SIZE << pagedir_order);
-	pagedir_pfn = __pa(pagedir) >> PAGE_SHIFT;
-	pagedir_end_pfn = __pa(pagedir_end) >> PAGE_SHIFT;
-	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
-		struct page *page;
-		unsigned long pfn = zone_pfn + zone->zone_start_pfn;
-		if (!pfn_valid(pfn))
-			continue;
-		page = pfn_to_page(pfn);
-		if (!TestClearPageNosave(page))
-			continue;
-		else if (pfn >= pagedir_pfn && pfn < pagedir_end_pfn)
+		if (is_highmem(zone))
 			continue;
-		__free_page(page);
-	}
-}
-
-void swsusp_free(void)
-{
-	unsigned long p = (unsigned long)pagedir_save;
-	struct zone *zone;
-	for_each_zone(zone) {
-		if (!is_highmem(zone))
-			free_suspend_pagedir_zone(zone, p);
+		mark_free_pages(zone);
+		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn) {
+			if (saveable(zone, &zone_pfn)) {
+				struct page * page;
+				page = pfn_to_page(zone_pfn + zone->zone_start_pfn);
+				pbe->orig_address = (long) page_address(page);
+				/* copy_page is not usable for copying task structs. */
+				memcpy((void *)pbe->address, (void *)pbe->orig_address, PAGE_SIZE);
+				pbe++;
+			}
+		}
 	}
-	free_pages(p, pagedir_order);
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
@@ -684,6 +648,24 @@
 	return 0;
 }
 
+/**
+ *	free_image_pages - Free pages allocated for snapshot
+ */
+
+static void free_image_pages(void)
+{
+	struct pbe * p;
+	int i;
+
+	p = pagedir_save;
+	for (i = 0, p = pagedir_save; i < nr_copy_pages; i++, p++) {
+		if (p->address) {
+			ClearPageNosave(virt_to_page(p->address));
+			free_page(p->address);
+			p->address = 0;
+		}
+	}
+}
 
 /**
  *	alloc_image_pages - Allocate pages for the snapshot.
@@ -697,18 +679,19 @@
 
 	for (i = 0, p = pagedir_save; i < nr_copy_pages; i++, p++) {
 		p->address = get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
-		if(!p->address)
-			goto Error;
+		if (!p->address)
+			return -ENOMEM;
 		SetPageNosave(virt_to_page(p->address));
 	}
 	return 0;
- Error:
-	do { 
-		if (p->address)
-			free_page(p->address);
-		p->address = 0;
-	} while (p-- > pagedir_save);
-	return -ENOMEM;
+}
+
+void swsusp_free(void)
+{
+	BUG_ON(PageNosave(virt_to_page(pagedir_save)));
+	BUG_ON(PageNosaveFree(virt_to_page(pagedir_save)));
+	free_image_pages();
+	free_pages((unsigned long) pagedir_save, pagedir_order);
 }
 
 
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
 
@@ -872,6 +855,7 @@
 	
 	/* Even mappings of "global" things (vmalloc) need to be fixed */
 	__flush_tlb_global();
+	wbinvd();	/* Nigel says wbinvd here is good idea... */
 	return 0;
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
 
@@ -950,9 +934,9 @@
 
 	printk("Relocating pagedir ");
 
-	if(!does_collide_order(old_pagedir, (unsigned long)old_pagedir, pagedir_order)) {
+	if (!does_collide_order(old_pagedir, (unsigned long)old_pagedir, pagedir_order)) {
 		printk("not necessary\n");
-		return 0;
+		return check_pagedir();
 	}
 
 	while ((m = (void *) __get_free_pages(GFP_ATOMIC, pagedir_order)) != NULL) {
@@ -994,24 +978,14 @@
 
 static atomic_t io_done = ATOMIC_INIT(0);
 
-static void start_io(void)
-{
-	atomic_set(&io_done,1);
-}
-
 static int end_io(struct bio * bio, unsigned int num, int err)
 {
-	atomic_set(&io_done,0);
+	if (!test_bit(BIO_UPTODATE, &bio->bi_flags))
+		panic("I/O error reading memory image");
+	atomic_set(&io_done, 0);
 	return 0;
 }
 
-static void wait_io(void)
-{
-	while(atomic_read(&io_done))
-		io_schedule();
-}
-
-
 static struct block_device * resume_bdev;
 
 /**
@@ -1030,7 +1004,7 @@
 	int error = 0;
 	struct bio * bio;
 
-	bio = bio_alloc(GFP_ATOMIC,1);
+	bio = bio_alloc(GFP_ATOMIC, 1);
 	if (!bio)
 		return -ENOMEM;
 	bio->bi_sector = page_off * (PAGE_SIZE >> 9);
@@ -1046,9 +1020,12 @@
 
 	if (rw == WRITE)
 		bio_set_pages_dirty(bio);
-	start_io();
+
+	atomic_set(&io_done, 1);
 	submit_bio(rw | (1 << BIO_RW_SYNC), bio);
-	wait_io();
+	while (atomic_read(&io_done))
+		yield();
+
  Done:
 	bio_put(bio);
 	return error;
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
@@ -1104,6 +1081,7 @@
 		return -EPERM;
 	}
 	nr_copy_pages = swsusp_info.image_pages;
+	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
 	return error;
 }
 
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
@@ -1130,17 +1108,6 @@
 	return error;
 }
 
-
-int __init verify(void)
-{
-	int error;
-
-	if (!(error = check_sig()))
-		error = check_header();
-	return error;
-}
-
-
 /**
  *	swsusp_read_data - Read image pages from swap.
  *
@@ -1153,14 +1120,18 @@
 	struct pbe * p;
 	int error;
 	int i;
-
+	int mod = nr_copy_pages / 100;
+	
+	if (!mod)
+		mod = 1;
+	
 	if ((error = swsusp_pagedir_relocate()))
 		return error;
 
-	printk( "Reading image data (%d pages): ", nr_copy_pages );
+	printk( "Reading image data (%d pages):     ", nr_copy_pages );
 	for(i = 0, p = pagedir_nosave; i < nr_copy_pages && !error; i++, p++) {
-		if (!(i%100))
-			printk( "." );
+		if (!(i%mod))
+			printk( "\b\b\b\b%3d%%", i / mod );
 		error = bio_read_page(swp_offset(p->swap_address),
 				  (void *)p->address);
 	}
@@ -1177,9 +1148,7 @@
 	int i, n = swsusp_info.pagedir_pages;
 	int error = 0;
 
-	pagedir_order = get_bitmask_order(n);
-
-	addr =__get_free_pages(GFP_ATOMIC, pagedir_order);
+	addr = __get_free_pages(GFP_ATOMIC, pagedir_order);
 	if (!addr)
 		return -ENOMEM;
 	pagedir_nosave = (struct pbe *)addr;
@@ -1194,7 +1163,7 @@
 			error = -EFAULT;
 	}
 	if (error)
-		free_pages((unsigned long)pagedir_nosave,pagedir_order);
+		free_pages((unsigned long)pagedir_nosave, pagedir_order);
 	return error;
 }
 
@@ -1202,13 +1171,14 @@
 {
 	int error = 0;
 
-	if ((error = verify()))
+	if ((error = check_sig()))
+		return error;
+	if ((error = check_header()))
 		return error;
 	if ((error = read_pagedir()))
 		return error;
-	if ((error = data_read())) {
-		free_pages((unsigned long)pagedir_nosave,pagedir_order);
-	}
+	if ((error = data_read()))
+		free_pages((unsigned long)pagedir_nosave, pagedir_order);
 	return error;
 }
 
--- clean-mm/mm/page_alloc.c	2004-09-07 21:12:33.000000000 +0200
+++ linux-mm/mm/page_alloc.c	2004-09-07 21:15:23.000000000 +0200
@@ -437,26 +437,30 @@
 #endif /* CONFIG_PM || CONFIG_HOTPLUG_CPU */
 
 #ifdef CONFIG_PM
-int is_head_of_free_region(struct page *page)
+
+void mark_free_pages(struct zone *zone)
 {
-        struct zone *zone = page_zone(page);
-        unsigned long flags;
+	unsigned long zone_pfn, flags;
 	int order;
 	struct list_head *curr;
 
-	/*
-	 * Should not matter as we need quiescent system for
-	 * suspend anyway, but...
-	 */
+	if (!zone->spanned_pages)
+		return;
+
 	spin_lock_irqsave(&zone->lock, flags);
+	for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
+		ClearPageNosaveFree(pfn_to_page(zone_pfn + zone->zone_start_pfn));
+
 	for (order = MAX_ORDER - 1; order >= 0; --order)
-		list_for_each(curr, &zone->free_area[order].free_list)
-			if (page == list_entry(curr, struct page, lru)) {
-				spin_unlock_irqrestore(&zone->lock, flags);
-				return 1 << order;
-			}
+		list_for_each(curr, &zone->free_area[order].free_list) {
+			unsigned long start_pfn, i;
+
+			start_pfn = page_to_pfn(list_entry(curr, struct page, lru));
+
+			for (i=0; i < (1<<order); i++)
+				SetPageNosaveFree(pfn_to_page(start_pfn+i));
+	}
 	spin_unlock_irqrestore(&zone->lock, flags);
-        return 0;
 }
 
 /*
