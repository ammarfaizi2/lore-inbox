Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbULGLDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbULGLDU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 06:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbULGLDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 06:03:20 -0500
Received: from gprs214-197.eurotel.cz ([160.218.214.197]:384 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261783AbULGLCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 06:02:44 -0500
Date: Tue, 7 Dec 2004 12:02:08 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>
Subject: [please test] 2.6.10-rc3 swsusp speedups
Message-ID: <20041207110208.GA1227@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This should fix O(n^2) behaviour in current swsusp, making "it thinks
for 2 minutes before saving image" go away. It should not break
anything. I'd like as many people as possible test it, because I'll
try to push this into 2.6.11....

Apply with -p0, sorry. [How do I generate nicer patch with CVS?]
								Pavel

--- arch/i386/kernel/signal.c	22 Nov 2004 17:47:28 -0000	1.50
+++ arch/i386/kernel/signal.c	6 Dec 2004 15:19:35 -0000
@@ -602,7 +602,8 @@
 
 	if (current->flags & PF_FREEZE) {
 		refrigerator(0);
-		goto no_signal;
+		if (!signal_pending(current))
+			goto no_signal;
 	}
 
 	if (!oldset)
--- arch/i386/kernel/acpi/wakeup.S	19 Oct 2004 06:03:51 -0000	1.8
+++ arch/i386/kernel/acpi/wakeup.S	20 Oct 2004 18:01:03 -0000
@@ -278,7 +278,7 @@
 	movl %edi, saved_context_edi
 	pushfl ; popl saved_context_eflags
 
-	movl $ret_point,saved_eip
+	movl $ret_point, saved_eip
 	ret
 
 
@@ -295,7 +295,7 @@
 	call	save_registers
 	pushl	$3
 	call	acpi_enter_sleep_state
-	addl	$4,%esp
+	addl	$4, %esp
 	ret
 	.p2align 4,,7
 ret_point:
--- include/linux/page-flags.h	24 Aug 2004 18:26:54 -0000	1.58
+++ include/linux/page-flags.h	20 Oct 2004 17:53:42 -0000
@@ -74,7 +74,7 @@
 #define PG_swapcache		16	/* Swap page: swp_entry_t in private */
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
-
+#define PG_nosave_free		19	/* Page is free and should not be written */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -277,6 +277,10 @@
 #define ClearPageNosave(page)		clear_bit(PG_nosave, &(page)->flags)
 #define TestClearPageNosave(page)	test_and_clear_bit(PG_nosave, &(page)->flags)
 
+#define PageNosaveFree(page)	test_bit(PG_nosave_free, &(page)->flags)
+#define SetPageNosaveFree(page)	set_bit(PG_nosave_free, &(page)->flags)
+#define ClearPageNosaveFree(page)		clear_bit(PG_nosave_free, &(page)->flags)
+
 #define PageMappedToDisk(page)	test_bit(PG_mappedtodisk, &(page)->flags)
 #define SetPageMappedToDisk(page) set_bit(PG_mappedtodisk, &(page)->flags)
 #define ClearPageMappedToDisk(page) clear_bit(PG_mappedtodisk, &(page)->flags)
--- include/linux/suspend.h	29 Sep 2004 20:04:50 -0000	1.26
+++ include/linux/suspend.h	20 Oct 2004 17:53:42 -0000
@@ -31,6 +31,7 @@
 
 /* mm/page_alloc.c */
 extern void drain_local_pages(void);
+extern void mark_free_pages(struct zone *zone);
 
 /* kernel/power/swsusp.c */
 extern int software_suspend(void);
@@ -54,6 +55,8 @@
 
 #else
 static inline void refrigerator(unsigned long flag) {}
+static inline int freeze_processes(void) { BUG(); }
+static inline void thaw_processes(void) {}
 #endif	/* CONFIG_PM */
 
 #ifdef CONFIG_SMP
--- kernel/signal.c	29 Oct 2004 21:53:12 -0000	1.148
+++ kernel/signal.c	4 Nov 2004 00:04:04 -0000
@@ -1442,8 +1442,7 @@
 	unsigned long flags;
 	struct sighand_struct *psig;
 
-	if (sig == -1)
-		BUG();
+	BUG_ON(sig == -1);
 
  	/* do_notify_parent_cldstop should have been called instead.  */
  	BUG_ON(tsk->state & (TASK_STOPPED|TASK_TRACED));
--- kernel/sys.c	3 Dec 2004 15:46:44 -0000	1.100
+++ kernel/sys.c	7 Dec 2004 10:41:13 -0000
@@ -401,6 +401,7 @@
 	case LINUX_REBOOT_CMD_HALT:
 		notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
 		system_state = SYSTEM_HALT;
+		device_suspend(3);
 		device_shutdown();
 		printk(KERN_EMERG "System halted.\n");
 		machine_halt();
@@ -411,6 +412,7 @@
 	case LINUX_REBOOT_CMD_POWER_OFF:
 		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
 		system_state = SYSTEM_POWER_OFF;
+		device_suspend(3);
 		device_shutdown();
 		printk(KERN_EMERG "Power down.\n");
 		machine_power_off();
@@ -427,6 +429,7 @@
 
 		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, buffer);
 		system_state = SYSTEM_RESTART;
+		device_suspend(3);
 		device_shutdown();
 		printk(KERN_EMERG "Restarting system with command '%s'.\n", buffer);
 		machine_restart(buffer);
--- kernel/power/disk.c	29 Oct 2004 20:20:47 -0000	1.10
+++ kernel/power/disk.c	16 Nov 2004 12:39:00 -0000
@@ -43,7 +43,7 @@
  *	there ain't no turning back.
  */
 
-static void power_down(u32 mode)
+static void power_down(suspend_disk_method_t mode)
 {
 	unsigned long flags;
 	int error = 0;
--- kernel/power/main.c	29 Oct 2004 20:20:47 -0000	1.7
+++ kernel/power/main.c	16 Nov 2004 12:47:53 -0000
@@ -65,7 +65,11 @@
 			goto Thaw;
 	}
 
-	if ((error = device_suspend(state)))
+	/* FIXME: this is suspend confusion biting us. If we pass
+	   state, we'll pass 2 in suspend-to-RAM case; EHCI will
+	   actually break suspend, because it interprets 2 as PCI_D2
+	   state. Oops. */
+	if ((error = device_suspend(3)))
 		goto Finish;
 	return 0;
  Finish:
@@ -78,13 +82,14 @@
 }
 
 
-static int suspend_enter(u32 state)
+static int suspend_enter(suspend_state_t state)
 {
 	int error = 0;
 	unsigned long flags;
 
 	local_irq_save(flags);
-	if ((error = device_power_down(state)))
+	/* FIXME: see suspend_prepare */
+	if ((error = device_power_down(3)))
 		goto Done;
 	error = pm_ops->enter(state);
 	device_power_up();
@@ -230,8 +235,8 @@
 	p = memchr(buf, '\n', n);
 	len = p ? p - buf : n;
 
-	for (s = &pm_states[state]; state < PM_SUSPEND_MAX; s++, state++) {
-		if (*s && !strncmp(buf, *s, len))
+	for (s = &pm_states[state]; *s; s++, state++) {
+		if (!strncmp(buf, *s, len))
 			break;
 	}
 	if (*s)
--- kernel/power/swsusp.c	28 Oct 2004 15:21:34 -0000	1.29
+++ kernel/power/swsusp.c	4 Nov 2004 00:04:06 -0000
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
@@ -426,12 +424,12 @@
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
@@ -448,11 +446,9 @@
 			printk("highmem reserved page?!\n");
 			continue;
 		}
-		if ((chunk_size = is_head_of_free_region(page))) {
-			pfn += chunk_size - 1;
-			zone_pfn += chunk_size - 1;
+		BUG_ON(PageNosave(page));
+		if (PageNosaveFree(page))
 			continue;
-		}
 		save = kmalloc(sizeof(struct highmem_page), GFP_ATOMIC);
 		if (!save)
 			return -ENOMEM;
@@ -524,21 +520,16 @@
  *	We save a page if it's Reserved, and not in the range of pages
  *	statically defined as 'unsaveable', or if it isn't reserved, and
  *	isn't part of a free chunk of pages.
- *	If it is part of a free chunk, we update @pfn to point to the last 
- *	page of the chunk.
  */
 
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
@@ -547,10 +538,8 @@
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
@@ -563,10 +552,11 @@
 	nr_copy_pages = 0;
 
 	for_each_zone(zone) {
-		if (!is_highmem(zone)) {
-			for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
-				nr_copy_pages += saveable(zone, &zone_pfn);
-		}
+		if (is_highmem(zone))
+			continue;
+		mark_free_pages(zone);
+		for (zone_pfn = 0; zone_pfn < zone->spanned_pages; ++zone_pfn)
+			nr_copy_pages += saveable(zone, &zone_pfn);
 	}
 }
 
@@ -576,52 +566,25 @@
 	struct zone *zone;
 	unsigned long zone_pfn;
 	struct pbe * pbe = pagedir_nosave;
+	int to_copy = nr_copy_pages;
 	
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
+				to_copy--;
+			}
+		}
 	}
-	free_pages(p, pagedir_order);
+	BUG_ON(to_copy);
 }
 
 
@@ -687,6 +650,24 @@
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
@@ -700,18 +681,19 @@
 
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
 
 
@@ -786,12 +768,13 @@
 
 int suspend_prepare_image(void)
 {
-	unsigned int nr_needed_pages = 0;
+	unsigned int nr_needed_pages;
 	int error;
 
 	pr_debug("swsusp: critical section: \n");
 	if (save_highmem()) {
 		printk(KERN_CRIT "Suspend machine: Not enough free pages for highmem\n");
+		restore_highmem();
 		return -ENOMEM;
 	}
 
@@ -878,6 +861,7 @@
 	
 	/* Even mappings of "global" things (vmalloc) need to be fixed */
 	__flush_tlb_global();
+	wbinvd();	/* Nigel says wbinvd here is good idea... */
 	return 0;
 }
 
@@ -985,6 +969,8 @@
 		c = *c;
 		free_pages((unsigned long)f, pagedir_order);
 	}
+	if (ret)
+		return ret;
 	printk("|\n");
 	return check_pagedir();
 }
@@ -1000,24 +986,14 @@
 
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
@@ -1052,9 +1028,12 @@
 
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
@@ -1110,6 +1089,7 @@
 		return -EPERM;
 	}
 	nr_copy_pages = swsusp_info.image_pages;
+	pagedir_order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
 	return error;
 }
 
@@ -1128,7 +1108,7 @@
 		 */
 		error = bio_write_page(0, &swsusp_header);
 	} else { 
-		pr_debug(KERN_ERR "swsusp: Invalid partition type.\n");
+		pr_debug(KERN_ERR "swsusp: Suspend partition has wrong signature?\n");
 		return -EINVAL;
 	}
 	if (!error)
@@ -1176,9 +1156,7 @@
 	int i, n = swsusp_info.pagedir_pages;
 	int error = 0;
 
-	pagedir_order = get_bitmask_order(n);
-
-	addr =__get_free_pages(GFP_ATOMIC, pagedir_order);
+	addr = __get_free_pages(GFP_ATOMIC, pagedir_order);
 	if (!addr)
 		return -ENOMEM;
 	pagedir_nosave = (struct pbe *)addr;
--- mm/page_alloc.c	16 Nov 2004 03:53:53 -0000	1.236
+++ mm/page_alloc.c	6 Dec 2004 15:23:18 -0000
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
@@ -1581,7 +1585,7 @@
 		zone->zone_start_pfn = zone_start_pfn;
 
 		if ((zone_start_pfn) & (zone_required_alignment-1))
-			printk("BUG: wrong zone alignment, it will crash\n");
+			printk(KERN_CRIT "BUG: wrong zone alignment, it will crash\n");
 
 		memmap_init(size, nid, j, zone_start_pfn);
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
