Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbTI1SAM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 14:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbTI1SAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 14:00:12 -0400
Received: from gprs147-229.eurotel.cz ([160.218.147.229]:37505 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262670AbTI1R7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 13:59:38 -0400
Date: Sun, 28 Sep 2003 19:58:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: pm: Revert swsusp to 2.6.0-test3 
Message-ID: <20030928175853.GF359@elf.ucw.cz>
References: <20030928100620.5FAA63450F@smtp-out2.iol.cz> <Pine.LNX.4.44.0309281038270.6307-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309281038270.6307-100000@home.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI!

> > This should not be warring patch. Pat
> > already has variant in his tree,
> > feel free to pull from him - but it
> > would be nice to have working swsusp
> > in -test6. --p
> 
> Ok. In that case, can we remove the '#if 0' blocks entirely, or at least 
> add a big comment on why they are there but disabled?

Like this?

> I'd also like to have some kind of readme or similar on the different 
> suspend/resume issues, and why we have two different
> approaches. Hmm?

I do not yet have details "how is patricks pmdisk different from
swsusp", so this documentation is hard to write at this point.
								Pavel

Index: include/linux/suspend.h
===================================================================
RCS file: /home/pavel/sf/bitbucket/bkcvs/linux-2.5/include/linux/suspend.h,v
retrieving revision 1.18
diff -u -u -r1.18 suspend.h
--- include/linux/suspend.h	21 Aug 2003 23:44:53 -0000	1.18
+++ include/linux/suspend.h	26 Sep 2003 10:53:27 -0000
@@ -8,7 +8,11 @@
 #include <linux/notifier.h>
 #include <linux/config.h>
 #include <linux/init.h>
-#include <linux/pm.h>
+
+extern unsigned char software_suspend_enabled;
+
+#define NORESUME	 1
+#define RESUME_SPECIFIED 2
 
 #ifdef CONFIG_SOFTWARE_SUSPEND
 /* page backup entry */
@@ -45,30 +49,61 @@
 /* mm/page_alloc.c */
 extern void drain_local_pages(void);
 
+/* kernel/suspend.c */
+extern void software_suspend(void);
+extern void software_resume(void);
+
+extern int register_suspend_notifier(struct notifier_block *);
+extern int unregister_suspend_notifier(struct notifier_block *);
+
 extern unsigned int nr_copy_pages __nosavedata;
 extern suspend_pagedir_t *pagedir_nosave __nosavedata;
 
+/* Communication between kernel/suspend.c and arch/i386/suspend.c */
+
+extern void do_magic_resume_1(void);
+extern void do_magic_resume_2(void);
+extern void do_magic_suspend_1(void);
+extern void do_magic_suspend_2(void);
+
 /* Communication between acpi and arch/i386/suspend.c */
 
 extern void do_suspend_lowlevel(int resume);
 extern void do_suspend_lowlevel_s4bios(int resume);
 
 #else	/* CONFIG_SOFTWARE_SUSPEND */
-static inline int software_suspend(void)
+static inline void software_suspend(void)
 {
+	printk("Warning: fake suspend called\n");
 	return -EPERM;
 }
+#define software_resume()		do { } while(0)
+#define register_suspend_notifier(a)	do { } while(0)
+#define unregister_suspend_notifier(a)	do { } while(0)
 #endif	/* CONFIG_SOFTWARE_SUSPEND */
 
 
 #ifdef CONFIG_PM
 extern void refrigerator(unsigned long);
+extern int freeze_processes(void);
+extern void thaw_processes(void);
+
+extern int pm_prepare_console(void);
+extern void pm_restore_console(void);
 
 #else
 static inline void refrigerator(unsigned long flag)
 {
 
 }
+static inline int freeze_processes(void)
+{
+	return 0;
+}
+static inline void thaw_processes(void)
+{
+
+}
 #endif	/* CONFIG_PM */
 
 #endif /* _LINUX_SWSUSP_H */
Index: kernel/sys.c
===================================================================
RCS file: /home/pavel/sf/bitbucket/bkcvs/linux-2.5/kernel/sys.c,v
retrieving revision 1.60
diff -u -u -r1.60 sys.c
--- kernel/sys.c	21 Sep 2003 22:37:10 -0000	1.60
+++ kernel/sys.c	26 Sep 2003 10:53:27 -0000
@@ -456,8 +456,11 @@
 
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	case LINUX_REBOOT_CMD_SW_SUSPEND:
-		if (!pm_suspend(PM_SUSPEND_DISK))
-			break;
+		if (!software_suspend_enabled) {
+			unlock_kernel();
+			return -EAGAIN;
+		}
+		software_suspend();
 		do_exit(0);
 		break;
 #endif
Index: kernel/power/main.c
===================================================================
RCS file: /home/pavel/sf/bitbucket/bkcvs/linux-2.5/kernel/power/main.c,v
retrieving revision 1.3
diff -u -u -r1.3 main.c
--- kernel/power/main.c	21 Aug 2003 23:44:53 -0000	1.3
+++ kernel/power/main.c	28 Sep 2003 17:50:10 -0000
@@ -172,7 +172,7 @@
 
 static int pm_suspend_disk(void)
 {
-	int error;
+	int error = -EPERM;
 
 	pr_debug("PM: Attempting to suspend to disk.\n");
 	if (pm_disk_mode == PM_DISK_FIRMWARE)
@@ -183,6 +183,9 @@
 
 	pr_debug("PM: snapshotting memory.\n");
 	in_suspend = 1;
+#if 0
+	/* Patrick is likely to s/swsusp_/pmdisk_/ in next release,
+	   but #if 0 is needed so that this compiles. */
 	if ((error = swsusp_save()))
 		goto Done;
 
@@ -195,6 +198,7 @@
 	} else
 		pr_debug("PM: Image restored successfully.\n");
 	swsusp_free();
+#endif
  Done:
 	return error;
 }
@@ -356,6 +360,9 @@
 
 	pr_debug("PM: Reading swsusp image.\n");
 
+#if 0
+	/* Patrick is likely to s/swsusp_/pmdisk_/ in next release,
+	   but #if 0 is needed so that this compiles. */
 	if ((error = swsusp_read()))
 		goto Done;
 
@@ -371,6 +378,7 @@
 	suspend_finish(PM_SUSPEND_DISK);
  Free:
 	swsusp_free();
+#endif
  Done:
 	pr_debug("PM: Resume from disk failed.\n");
 	return 0;
Index: kernel/power/swsusp.c
===================================================================
RCS file: /home/pavel/sf/bitbucket/bkcvs/linux-2.5/kernel/power/swsusp.c,v
retrieving revision 1.4
diff -u -u -r1.4 swsusp.c
--- kernel/power/swsusp.c	21 Aug 2003 23:44:53 -0000	1.4
+++ kernel/power/swsusp.c	27 Sep 2003 20:52:00 -0000
@@ -5,7 +5,8 @@
  * machine suspend feature using pretty near only high-level routines
  *
  * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
- * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 1998,2001-2003 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 2003 Patrick Mochel <mochel@osdl.org>
  *
  * I'd like to thank the following people for their work:
  * 
@@ -65,7 +66,9 @@
 
 #include "power.h"
 
-unsigned char software_suspend_enabled = 1;
+extern long sys_sync(void);
+
+unsigned char software_suspend_enabled = 0;
 
 #define __ADDRESS(x)  ((unsigned long) phys_to_virt(x))
 #define ADDRESS(x) __ADDRESS((x) << PAGE_SHIFT)
@@ -83,11 +86,14 @@
 static int pagedir_order_check;
 static int nr_copy_pages_check;
 
-static char resume_file[256];			/* For resume= kernel option */
+static int resume_status;
+static char resume_file[256] = "";			/* For resume= kernel option */
 static dev_t resume_device;
 /* Local variables that should not be affected by save */
 unsigned int nr_copy_pages __nosavedata = 0;
 
+static int pm_suspend_state;
+
 /* Suspend pagedir is allocated before final copy, therefore it
    must be freed after resume 
 
@@ -347,10 +353,15 @@
 	int pfn;
 	struct page *page;
 	
+#ifdef CONFIG_DISCONTIGMEM
+	panic("Discontingmem not supported");
+#else
 	BUG_ON (max_pfn != num_physpages);
-
+#endif
 	for (pfn = 0; pfn < max_pfn; pfn++) {
 		page = pfn_to_page(pfn);
+		if (PageHighMem(page))
+			panic("Swsusp not supported on highmem boxes. Send 1GB of RAM to <pavel@ucw.cz> and try again ;-).");
 
 		if (!PageReserved(page)) {
 			if (PageNosave(page))
@@ -435,6 +446,74 @@
 	return pagedir;
 }
 
+static int prepare_suspend_processes(void)
+{
+	sys_sync();	/* Syncing needs pdflushd, so do it before stopping processes */
+	if (freeze_processes()) {
+		printk( KERN_ERR "Suspend failed: Not all processes stopped!\n" );
+		thaw_processes();
+		return 1;
+	}
+	return 0;
+}
+
+/*
+ * Try to free as much memory as possible, but do not OOM-kill anyone
+ *
+ * Notice: all userland should be stopped at this point, or livelock is possible.
+ */
+static void free_some_memory(void)
+{
+	printk("Freeing memory: ");
+	while (shrink_all_memory(10000))
+		printk(".");
+	printk("|\n");
+}
+
+/* Make disk drivers accept operations, again */
+static void drivers_unsuspend(void)
+{
+	device_resume();
+}
+
+/* Called from process context */
+static int drivers_suspend(void)
+{
+	device_suspend(4);
+	if(!pm_suspend_state) {
+		if(pm_send_all(PM_SUSPEND,(void *)3)) {
+			printk(KERN_WARNING "Problem while sending suspend event\n");
+			return(1);
+		}
+		pm_suspend_state=1;
+	} else
+		printk(KERN_WARNING "PM suspend state already raised\n");
+	device_power_down(4);
+	return(0);
+}
+
+#define RESUME_PHASE1 1 /* Called from interrupts disabled */
+#define RESUME_PHASE2 2 /* Called with interrupts enabled */
+#define RESUME_ALL_PHASES (RESUME_PHASE1 | RESUME_PHASE2)
+static void drivers_resume(int flags)
+{
+	if (flags & RESUME_PHASE1) {
+		dpm_power_up();
+	}
+  	if (flags & RESUME_PHASE2) {
+		device_resume();
+		if(pm_suspend_state) {
+			if(pm_send_all(PM_RESUME,(void *)0))
+				printk(KERN_WARNING "Problem while sending resume event\n");
+			pm_suspend_state=0;
+		} else
+			printk(KERN_WARNING "PM suspend state wasn't raised\n");
+
+#ifdef SUSPEND_CONSOLE
+		update_screen(fg_console);	/* Hmm, is this the problem? */
+#endif
+	}
+}
 
 static int suspend_prepare_image(void)
 {
@@ -488,14 +567,13 @@
 	return 0;
 }
 
-static int suspend_save_image(void)
+static void suspend_save_image(void)
 {
-	int error;
-
-	device_resume();
+	drivers_unsuspend();
 
 	lock_swapdevices();
-	error = write_suspend_image();
+	write_suspend_image();
+printk("locking_swapdevices\n");
 	lock_swapdevices();	/* This will unlock ignored swap devices since writing is finished */
 
 	/* It is important _NOT_ to umount filesystems at this point. We want
@@ -503,7 +581,30 @@
 	 * filesystem clean: it is not. (And it does not matter, if we resume
 	 * correctly, we'll mark system clean, anyway.)
 	 */
-	return error;
+printk("exiting function\n");
+}
+
+static void suspend_power_down(void)
+{
+	extern int C_A_D;
+	C_A_D = 0;
+	printk(KERN_EMERG "%s%s Trying to power down.\n", name_suspend, TEST_SWSUSP ? "Disable TEST_SWSUSP. NOT ": "");
+#ifdef CONFIG_VT
+	PRINTK(KERN_EMERG "shift_state: %04x\n", shift_state);
+	mdelay(1000);
+	if (TEST_SWSUSP ^ (!!(shift_state & (1 << KG_CTRL))))
+		machine_restart(NULL);
+	else
+#endif
+	{
+		device_shutdown();
+		machine_power_off();
+	}
+
+	printk(KERN_EMERG "%sProbably not capable for powerdown. System halted.\n", name_suspend);
+	machine_halt();
+	while (1);
+	/* NOTREACHED */
 }
 
 /*
@@ -515,21 +616,32 @@
 	barrier();
 	mb();
 	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
+
 	PRINTK( "Waiting for DMAs to settle down...\n");
-	/* We do not want some readahead with DMA to corrupt our memory, right?
-	   Do it with disabled interrupts for best effect. That way, if some
-	   driver scheduled DMA, we have good chance for DMA to finish ;-). */
-	mdelay(1000);
+	mdelay(1000);	/* We do not want some readahead with DMA to corrupt our memory, right?
+			   Do it with disabled interrupts for best effect. That way, if some
+			   driver scheduled DMA, we have good chance for DMA to finish ;-). */
 }
 
 void do_magic_resume_2(void)
 {
 	BUG_ON (nr_copy_pages_check != nr_copy_pages);
 	BUG_ON (pagedir_order_check != pagedir_order);
-	
-	/* Even mappings of "global" things (vmalloc) need to be fixed */
-	__flush_tlb_global();
+
+	__flush_tlb_global();		/* Even mappings of "global" things (vmalloc) need to be fixed */
+
+	PRINTK( "Freeing prev allocated pagedir\n" );
+	free_suspend_pagedir((unsigned long) pagedir_save);
 	spin_unlock_irq(&suspend_pagedir_lock);
+	drivers_resume(RESUME_ALL_PHASES);
+
+	PRINTK( "Fixing swap signatures... " );
+	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
+	PRINTK( "ok\n" );
+
+#ifdef SUSPEND_CONSOLE
+	update_screen(fg_console);	/* Hmm, is this the problem? */
+#endif
 }
 
 /* do_magic() is implemented in arch/?/kernel/suspend_asm.S, and basically does:
@@ -554,28 +666,93 @@
 {
 	mb();
 	barrier();
+	BUG_ON(in_atomic());
 	spin_lock_irq(&suspend_pagedir_lock);
 }
 
-int do_magic_suspend_2(void)
+void do_magic_suspend_2(void)
 {
 	int is_problem;
 	read_swapfiles();
 	is_problem = suspend_prepare_image();
 	spin_unlock_irq(&suspend_pagedir_lock);
-	if (!is_problem)
-		return suspend_save_image();
+	if (!is_problem) {
+		kernel_fpu_end();	/* save_processor_state() does kernel_fpu_begin, and we need to revert it in order to pass in_atomic() checks */
+		BUG_ON(in_atomic());
+		suspend_save_image();
+printk("leaving suspend_2\n");
+		suspend_power_down();	/* FIXME: if suspend_power_down is commented out, console is lost after few suspends ?! */
+	}
+
 	printk(KERN_EMERG "%sSuspend failed, trying to recover...\n", name_suspend);
+	MDELAY(1000); /* So user can wait and report us messages if armageddon comes :-) */
+
 	barrier();
 	mb();
+	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
 	mdelay(1000);
-	return -EFAULT;
+
+	free_pages((unsigned long) pagedir_nosave, pagedir_order);
+	spin_unlock_irq(&suspend_pagedir_lock);
+	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
+}
+
+static void do_software_suspend(void)
+{
+	printk("Doing software_suspend()\n");
+	arch_prepare_suspend();
+	if (pm_prepare_console())
+		printk( "%sCan't allocate a console... proceeding\n", name_suspend);
+	if (!prepare_suspend_processes()) {
+
+		/* At this point, all user processes and "dangerous"
+                   kernel threads are stopped. Free some memory, as we
+                   need half of memory free. */
+
+		free_some_memory();
+		
+		/* No need to invalidate any vfsmnt list -- 
+		 * they will be valid after resume, anyway.
+		 */
+		blk_run_queues();
+
+		/* Save state of all device drivers, and stop them. */		   
+		if(drivers_suspend()==0)
+			/* If stopping device drivers worked, we proceed basically into
+			 * suspend_save_image.
+			 *
+			 * do_magic(0) returns after system is resumed.
+			 *
+			 * do_magic() copies all "used" memory to "free" memory, then
+			 * unsuspends all device drivers, and writes memory to disk
+			 * using normal kernel mechanism.
+			 */
+			do_magic(0);
+		thaw_processes();
+	}
+	software_suspend_enabled = 1;
+	MDELAY(1000);
+	pm_restore_console();
+}
+
+/*
+ * This is main interface to the outside world. It needs to be
+ * called from process context.
+ */
+void software_suspend(void)
+{
+	if(!software_suspend_enabled)
+		return;
+
+	software_suspend_enabled = 0;
+	might_sleep();
+	do_software_suspend();
 }
 
 /* More restore stuff */
 
 /* FIXME: Why not memcpy(to, from, 1<<pagedir_order*PAGE_SIZE)? */
-static void __init copy_pagedir(suspend_pagedir_t *to, suspend_pagedir_t *from)
+static void copy_pagedir(suspend_pagedir_t *to, suspend_pagedir_t *from)
 {
 	int i;
 	char *topointer=(char *)to, *frompointer=(char *)from;
@@ -592,8 +769,8 @@
 /*
  * Returns true if given address/order collides with any orig_address 
  */
-static int __init does_collide_order(suspend_pagedir_t *pagedir, 
-				     unsigned long addr, int order)
+static int does_collide_order(suspend_pagedir_t *pagedir, unsigned long addr,
+		int order)
 {
 	int i;
 	unsigned long addre = addr + (PAGE_SIZE<<order);
@@ -610,7 +787,7 @@
  * We check here that pagedir & pages it points to won't collide with pages
  * where we're going to restore from the loaded pages later
  */
-static int __init check_pagedir(void)
+static int check_pagedir(void)
 {
 	int i;
 
@@ -628,7 +805,7 @@
 	return 0;
 }
 
-static int __init relocate_pagedir(void)
+static int relocate_pagedir(void)
 {
 	/*
 	 * We have to avoid recursion (not to overflow kernel stack),
@@ -678,13 +855,13 @@
  * I really don't think that it's foolproof but more than nothing..
  */
 
-static int __init sanity_check_failed(char *reason)
+static int sanity_check_failed(char *reason)
 {
 	printk(KERN_ERR "%s%s\n",name_resume,reason);
 	return -EPERM;
 }
 
-static int __init sanity_check(struct suspend_header *sh)
+static int sanity_check(struct suspend_header *sh)
 {
 	if(sh->version_code != LINUX_VERSION_CODE)
 		return sanity_check_failed("Incorrect kernel version");
@@ -701,8 +878,7 @@
 	return 0;
 }
 
-static int __init bdev_read_page(struct block_device *bdev, 
-				 long pos, void *buf)
+static int bdev_read_page(struct block_device *bdev, long pos, void *buf)
 {
 	struct buffer_head *bh;
 	BUG_ON (pos%PAGE_SIZE);
@@ -716,10 +892,31 @@
 	return 0;
 } 
 
+static int bdev_write_page(struct block_device *bdev, long pos, void *buf)
+{
+#if 0
+	struct buffer_head *bh;
+	BUG_ON (pos%PAGE_SIZE);
+	bh = __bread(bdev, pos/PAGE_SIZE, PAGE_SIZE);
+	if (!bh || (!bh->b_data)) {
+		return -1;
+	}
+	memcpy(bh->b_data, buf, PAGE_SIZE);	/* FIXME: may need kmap() */
+	BUG_ON(!buffer_uptodate(bh));
+	generic_make_request(WRITE, bh);
+	if (!buffer_uptodate(bh))
+		printk(KERN_CRIT "%sWarning %s: Fixing swap signatures unsuccessful...\n", name_resume, resume_file);
+	wait_on_buffer(bh);
+	brelse(bh);
+	return 0;
+#endif
+	printk(KERN_CRIT "%sWarning %s: Fixing swap signatures unimplemented...\n", name_resume, resume_file);
+	return 0;
+}
+
 extern dev_t __init name_to_dev_t(const char *line);
 
-static int __init read_suspend_image(struct block_device *bdev, 
-				     union diskpage *cur)
+static int __read_suspend_image(struct block_device *bdev, union diskpage *cur, int noresume)
 {
 	swp_entry_t next;
 	int i, nr_pgdir_pages;
@@ -744,9 +941,18 @@
 	else if (!memcmp("S2",cur->swh.magic.magic,2))
 		memcpy(cur->swh.magic.magic,"SWAPSPACE2",10);
 	else {
-		printk("swsusp: %s: Unable to find suspended-data signature (%.10s - misspelled?\n", 
+		if (noresume)
+			return -EINVAL;
+		panic("%sUnable to find suspended-data signature (%.10s - misspelled?\n", 
 			name_resume, cur->swh.magic.magic);
-		return -EFAULT;
+	}
+	if (noresume) {
+		/* We don't do a sanity check here: we want to restore the swap
+		   whatever version of kernel made the suspend image;
+		   We need to write swap, but swap is *not* enabled so
+		   we must write the device directly */
+		printk("%s: Fixing swap signatures %s...\n", name_resume, resume_file);
+		bdev_write_page(bdev, 0, cur);
 	}
 
 	printk( "%sSignature found, resuming\n", name_resume );
@@ -796,115 +1002,125 @@
 	return 0;
 }
 
-/**
- *	swsusp_save - Snapshot memory
- */
-
-int swsusp_save(void) 
-{
-#if defined (CONFIG_HIGHMEM) || defined (COFNIG_DISCONTIGMEM)
-	printk("swsusp is not supported with high- or discontig-mem.\n");
-	return -EPERM;
-#endif
-	return 0;
-}
-
-
-/**
- *	swsusp_write - Write saved memory image to swap.
- *
- *	do_magic(0) returns after system is resumed.
- *
- *	do_magic() copies all "used" memory to "free" memory, then
- *	unsuspends all device drivers, and writes memory to disk
- *	using normal kernel mechanism.
- */
-
-int swsusp_write(void)
-{
-	arch_prepare_suspend();
-	return do_magic(0);
-}
-
-
-/**
- *	swsusp_read - Read saved image from swap.
- */
-
-int __init swsusp_read(void)
+static int read_suspend_image(const char * specialfile, int noresume)
 {
 	union diskpage *cur;
+	unsigned long scratch_page = 0;
 	int error;
 	char b[BDEVNAME_SIZE];
 
-	if (!strlen(resume_file))
-		return -ENOENT;
-
-	resume_device = name_to_dev_t(resume_file);
-	printk("swsusp: Resume From Partition: %s, Device: %s\n", 
-	       resume_file, __bdevname(resume_device, b));
-
-	cur = (union diskpage *)get_zeroed_page(GFP_ATOMIC);
+	resume_device = name_to_dev_t(specialfile);
+	scratch_page = get_zeroed_page(GFP_ATOMIC);
+	cur = (void *) scratch_page;
 	if (cur) {
 		struct block_device *bdev;
+		printk("Resuming from device %s\n",
+				__bdevname(resume_device, b));
 		bdev = open_by_devnum(resume_device, FMODE_READ, BDEV_RAW);
-		if (!IS_ERR(bdev)) {
+		if (IS_ERR(bdev)) {
+			error = PTR_ERR(bdev);
+		} else {
 			set_blocksize(bdev, PAGE_SIZE);
-			error = read_suspend_image(bdev, cur);
+			error = __read_suspend_image(bdev, cur, noresume);
 			blkdev_put(bdev, BDEV_RAW);
-		} else
-			error = PTR_ERR(bdev);
-		free_page((unsigned long)cur);
-	} else
-		error = -ENOMEM;
+		}
+	} else error = -ENOMEM;
 
-	if (!error)
-		PRINTK("Reading resume file was successful\n");
-	else
-		printk( "%sError %d resuming\n", name_resume, error );
+	if (scratch_page)
+		free_page(scratch_page);
+	switch (error) {
+		case 0:
+			PRINTK("Reading resume file was successful\n");
+			break;
+		case -EINVAL:
+			break;
+		case -EIO:
+			printk( "%sI/O error\n", name_resume);
+			break;
+		case -ENOENT:
+			printk( "%s%s: No such file or directory\n", name_resume, specialfile);
+			break;
+		case -ENOMEM:
+			printk( "%sNot enough memory\n", name_resume);
+			break;
+		default:
+			printk( "%sError %d resuming\n", name_resume, error );
+	}
 	MDELAY(1000);
 	return error;
 }
 
-
 /**
- *	swsusp_restore - Replace running kernel with saved image.
+ *	software_resume - Resume from a saved image.
+ *
+ *	Called as a late_initcall (so all devices are discovered and 
+ *	initialized), we call swsusp to see if we have a saved image or not.
+ *	If so, we quiesce devices, the restore the saved image. We will 
+ *	return above (in pm_suspend_disk() ) if everything goes well. 
+ *	Otherwise, we fail gracefully and return to the normally 
+ *	scheduled program.
+ *
  */
-
-int __init swsusp_restore(void)
+static void software_resume(void)
 {
-	return do_magic(1);
-}
+	if (num_online_cpus() > 1) {
+		printk(KERN_WARNING "Software Suspend has malfunctioning SMP support. Disabled :(\n");	
+		return;
+	}
+	/* We enable the possibility of machine suspend */
+	software_suspend_enabled = 1;
+	if (!resume_status)
+		return;
 
+	printk( "%s", name_resume );
+	if (resume_status == NORESUME) {
+		if(resume_file[0])
+			read_suspend_image(resume_file, 1);
+		printk( "disabled\n" );
+		return;
+	}
+	MDELAY(1000);
 
-/**
- *	swsusp_free - Free memory allocated to hold snapshot.
- */
+	if (pm_prepare_console())
+		printk("swsusp: Can't allocate a console... proceeding\n");
 
-int swsusp_free(void)
-{
-	PRINTK( "Freeing prev allocated pagedir\n" );
-	free_suspend_pagedir((unsigned long) pagedir_save);
+	if (!resume_file[0] && resume_status == RESUME_SPECIFIED) {
+		printk( "suspension device unspecified\n" );
+		return;
+	}
 
-	PRINTK( "Fixing swap signatures... " );
-	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
-	PRINTK( "ok\n" );
-	return 0;
+	printk( "resuming from %s\n", resume_file);
+	if (read_suspend_image(resume_file, 0))
+		goto read_failure;
+	do_magic(1);
+	panic("This never returns");
+
+read_failure:
+	pm_restore_console();
+	return;
 }
 
+late_initcall(software_resume);
+
 static int __init resume_setup(char *str)
 {
-	if (strlen(str))
-		strncpy(resume_file, str, 255);
+	if (resume_status == NORESUME)
+		return 1;
+
+	strncpy( resume_file, str, 255 );
+	resume_status = RESUME_SPECIFIED;
+
 	return 1;
 }
 
 static int __init noresume_setup(char *str)
 {
-	resume_file[0] = '\0';
+	resume_status = NORESUME;
 	return 1;
 }
 
 __setup("noresume", noresume_setup);
 __setup("resume=", resume_setup);
 
+EXPORT_SYMBOL(software_suspend);
+EXPORT_SYMBOL(software_suspend_enabled);




-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
