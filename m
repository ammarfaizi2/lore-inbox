Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbTIAXj1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 19:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbTIAXj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 19:39:27 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:64216 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S263325AbTIAXjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 19:39:07 -0400
Date: Tue, 2 Sep 2003 01:38:33 +0200
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix up power managment in 2.6
Message-ID: <20030901233833.GD470@elf.ucw.cz>
References: <20030901211220.GD342@elf.ucw.cz> <Pine.LNX.4.44.0309011509450.5614-100000@cherise>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309011509450.5614-100000@cherise>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > He just thinks he can fix his code, and I want that code to be
> > reverted, reviewed, tested, and than merged back. There's no way
> > current mess can be fixed in reasonable time.
> 
> I realize that posting it before merging it would have resulted in a
> better outcome, as least thus far. However, it's been 11 days since I've
> merged the orgininal code, and 2 since I posted the last patch. While
> you've been ranting and raving, you've squandered a lot of valuable time
> that could have been spent reviewing the code. 

I've been reviewing your code, see your mailbox. Unfortunately due to
you renaming functions and moving files around, it is very hard to review.

> > I've seen no discussion about that code, and certainly have not seen
> > that code before it was merged, which is strange since I'm listed as
> > software suspend maintainer.
> 
> BFD. swsusp is one piece of the puzzle, and I've not touched any of the 
> core functionality. What I have done is: 

[Attached is patch "not changing core functionality". How did you
expect me to verify that? And it was you who protested on killing 3
printks.]

> Secondly, look at what I've done to it: 
> 
> - Compartmentalized portions that are useful to more general 
>   suspend/resume sequences. 
> 
> - Removed duplicate code between different PM mechanisms.
> 
> - Made it possible to use it with ACPI, instead of in lieu of it. 
> 
> - Cleaned up several functions, streamlined a few, added comments, and 
>   made the names easier to swallow than the 'magic' variety. 
> 
> - Removed 5 calls to panic() and 8 instances of BUG(). 

And managed to call sleeping functions with interrupts disabled and
break x86-64 somewhere in the process. Hmm, and because you killed
BUG_ON(in_atomic()), you did not realize that you were breaking
that. And I do not think you actually tested those "panic" codepaths
to make sure you are not corrupting data, right?

> In all actuality, I don't need swsusp. I have a better suspend-to-disk
> implementation that is faster, smaller, and cleaner. I've hesitated
> merging it because I thought swsusp improvements would be more welcome.
> Obviously they're not; or you haven't actually taken the time to read the
> code.

Swsusp improvements *would* be welcome, but I prefer to get them via
email, not via ftp from Linus.

> I will also restore swsusp to whatever state you like - either -test1,
> -test3 or -test4 state, or keep it the way it currently is in my patches.  
> But note that doing so will result in a large amount of duplicated code
> which you will be responsible for either merging or removing.

Good, please return it to -test3 state. If you can leave your split-up
patches on some public ftp site, that would be good; when dm is back
working so I can actually test it, I'll do some cherry-picking.

> Also, continuing to flame me without a rebuttal is not very polite, and
> indicates that you don't want to have an actual conversation. Please
> remove me and any public mailing lists from the cc list if you're going to
> continue to do this. I'll eventually filter you out, but please save
> everyone else from the drivel..

...while this surely contributes to actual conversation.
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=delme

diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	Fri Aug 22 17:05:42 2003
+++ b/kernel/power/swsusp.c	Fri Aug 22 17:05:42 2003
@@ -65,9 +65,7 @@
 
 #include "power.h"
 
-extern long sys_sync(void);
-
-unsigned char software_suspend_enabled = 0;
+unsigned char software_suspend_enabled = 1;
 
 #define __ADDRESS(x)  ((unsigned long) phys_to_virt(x))
 #define ADDRESS(x) __ADDRESS((x) << PAGE_SHIFT)
@@ -85,14 +83,11 @@
 static int pagedir_order_check;
 static int nr_copy_pages_check;
 
-static int resume_status;
-static char resume_file[256] = "";			/* For resume= kernel option */
+static char resume_file[256];			/* For resume= kernel option */
 static dev_t resume_device;
 /* Local variables that should not be affected by save */
 unsigned int nr_copy_pages __nosavedata = 0;
 
-static int pm_suspend_state;
-
 /* Suspend pagedir is allocated before final copy, therefore it
    must be freed after resume 
 
@@ -352,15 +347,10 @@
 	int pfn;
 	struct page *page;
 	
-#ifdef CONFIG_DISCONTIGMEM
-	panic("Discontingmem not supported");
-#else
 	BUG_ON (max_pfn != num_physpages);
-#endif
+
 	for (pfn = 0; pfn < max_pfn; pfn++) {
 		page = pfn_to_page(pfn);
-		if (PageHighMem(page))
-			panic("Swsusp not supported on highmem boxes. Send 1GB of RAM to <pavel@ucw.cz> and try again ;-).");
 
 		if (!PageReserved(page)) {
 			if (PageNosave(page))
@@ -445,77 +435,6 @@
 	return pagedir;
 }
 
-static int prepare_suspend_processes(void)
-{
-	sys_sync();	/* Syncing needs pdflushd, so do it before stopping processes */
-	if (freeze_processes()) {
-		printk( KERN_ERR "Suspend failed: Not all processes stopped!\n" );
-		thaw_processes();
-		return 1;
-	}
-	return 0;
-}
-
-/*
- * Try to free as much memory as possible, but do not OOM-kill anyone
- *
- * Notice: all userland should be stopped at this point, or livelock is possible.
- */
-static void free_some_memory(void)
-{
-	printk("Freeing memory: ");
-	while (shrink_all_memory(10000))
-		printk(".");
-	printk("|\n");
-}
-
-/* Make disk drivers accept operations, again */
-static void drivers_unsuspend(void)
-{
-	device_resume(RESUME_RESTORE_STATE);
-	device_resume(RESUME_ENABLE);
-}
-
-/* Called from process context */
-static int drivers_suspend(void)
-{
-	device_suspend(4, SUSPEND_NOTIFY);
-	device_suspend(4, SUSPEND_SAVE_STATE);
-	device_suspend(4, SUSPEND_DISABLE);
-	if(!pm_suspend_state) {
-		if(pm_send_all(PM_SUSPEND,(void *)3)) {
-			printk(KERN_WARNING "Problem while sending suspend event\n");
-			return(1);
-		}
-		pm_suspend_state=1;
-	} else
-		printk(KERN_WARNING "PM suspend state already raised\n");
-	  
-	return(0);
-}
-
-#define RESUME_PHASE1 1 /* Called from interrupts disabled */
-#define RESUME_PHASE2 2 /* Called with interrupts enabled */
-#define RESUME_ALL_PHASES (RESUME_PHASE1 | RESUME_PHASE2)
-static void drivers_resume(int flags)
-{
-	if (flags & RESUME_PHASE1) {
-		device_resume(RESUME_RESTORE_STATE);
-		device_resume(RESUME_ENABLE);
-	}
-  	if (flags & RESUME_PHASE2) {
-		if(pm_suspend_state) {
-			if(pm_send_all(PM_RESUME,(void *)0))
-				printk(KERN_WARNING "Problem while sending resume event\n");
-			pm_suspend_state=0;
-		} else
-			printk(KERN_WARNING "PM suspend state wasn't raised\n");
-
-#ifdef SUSPEND_CONSOLE
-		update_screen(fg_console);	/* Hmm, is this the problem? */
-#endif
-	}
-}
 
 static int suspend_prepare_image(void)
 {
@@ -569,12 +488,14 @@
 	return 0;
 }
 
-static void suspend_save_image(void)
+static int suspend_save_image(void)
 {
-	drivers_unsuspend();
+	int error;
+
+	device_resume();
 
 	lock_swapdevices();
-	write_suspend_image();
+	error = write_suspend_image();
 	lock_swapdevices();	/* This will unlock ignored swap devices since writing is finished */
 
 	/* It is important _NOT_ to umount filesystems at this point. We want
@@ -582,29 +503,7 @@
 	 * filesystem clean: it is not. (And it does not matter, if we resume
 	 * correctly, we'll mark system clean, anyway.)
 	 */
-}
-
-static void suspend_power_down(void)
-{
-	extern int C_A_D;
-	C_A_D = 0;
-	printk(KERN_EMERG "%s%s Trying to power down.\n", name_suspend, TEST_SWSUSP ? "Disable TEST_SWSUSP. NOT ": "");
-#ifdef CONFIG_VT
-	PRINTK(KERN_EMERG "shift_state: %04x\n", shift_state);
-	mdelay(1000);
-	if (TEST_SWSUSP ^ (!!(shift_state & (1 << KG_CTRL))))
-		machine_restart(NULL);
-	else
-#endif
-	{
-		device_shutdown();
-		machine_power_off();
-	}
-
-	printk(KERN_EMERG "%sProbably not capable for powerdown. System halted.\n", name_suspend);
-	machine_halt();
-	while (1);
-	/* NOTREACHED */
+	return error;
 }
 
 /*
@@ -616,32 +515,21 @@
 	barrier();
 	mb();
 	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
-
 	PRINTK( "Waiting for DMAs to settle down...\n");
-	mdelay(1000);	/* We do not want some readahead with DMA to corrupt our memory, right?
-			   Do it with disabled interrupts for best effect. That way, if some
-			   driver scheduled DMA, we have good chance for DMA to finish ;-). */
+	/* We do not want some readahead with DMA to corrupt our memory, right?
+	   Do it with disabled interrupts for best effect. That way, if some
+	   driver scheduled DMA, we have good chance for DMA to finish ;-). */
+	mdelay(1000);
 }
 
 void do_magic_resume_2(void)
 {
 	BUG_ON (nr_copy_pages_check != nr_copy_pages);
 	BUG_ON (pagedir_order_check != pagedir_order);
-
-	__flush_tlb_global();		/* Even mappings of "global" things (vmalloc) need to be fixed */
-
-	PRINTK( "Freeing prev allocated pagedir\n" );
-	free_suspend_pagedir((unsigned long) pagedir_save);
+	
+	/* Even mappings of "global" things (vmalloc) need to be fixed */
+	__flush_tlb_global();
 	spin_unlock_irq(&suspend_pagedir_lock);
-	drivers_resume(RESUME_ALL_PHASES);
-
-	PRINTK( "Fixing swap signatures... " );
-	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
-	PRINTK( "ok\n" );
-
-#ifdef SUSPEND_CONSOLE
-	update_screen(fg_console);	/* Hmm, is this the problem? */
-#endif
 }
 
 /* do_magic() is implemented in arch/?/kernel/suspend_asm.S, and basically does:
@@ -666,91 +554,28 @@
 {
 	mb();
 	barrier();
-	BUG_ON(in_atomic());
 	spin_lock_irq(&suspend_pagedir_lock);
 }
 
-void do_magic_suspend_2(void)
+int do_magic_suspend_2(void)
 {
 	int is_problem;
 	read_swapfiles();
 	is_problem = suspend_prepare_image();
 	spin_unlock_irq(&suspend_pagedir_lock);
-	if (!is_problem) {
-		kernel_fpu_end();	/* save_processor_state() does kernel_fpu_begin, and we need to revert it in order to pass in_atomic() checks */
-		BUG_ON(in_atomic());
-		suspend_save_image();
-		suspend_power_down();	/* FIXME: if suspend_power_down is commented out, console is lost after few suspends ?! */
-	}
-
+	if (!is_problem)
+		return suspend_save_image();
 	printk(KERN_EMERG "%sSuspend failed, trying to recover...\n", name_suspend);
-	MDELAY(1000); /* So user can wait and report us messages if armageddon comes :-) */
-
 	barrier();
 	mb();
-	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
 	mdelay(1000);
-
-	free_pages((unsigned long) pagedir_nosave, pagedir_order);
-	spin_unlock_irq(&suspend_pagedir_lock);
-	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
-}
-
-static void do_software_suspend(void)
-{
-	arch_prepare_suspend();
-	if (pm_prepare_console())
-		printk( "%sCan't allocate a console... proceeding\n", name_suspend);
-	if (!prepare_suspend_processes()) {
-
-		/* At this point, all user processes and "dangerous"
-                   kernel threads are stopped. Free some memory, as we
-                   need half of memory free. */
-
-		free_some_memory();
-		
-		/* No need to invalidate any vfsmnt list -- 
-		 * they will be valid after resume, anyway.
-		 */
-		blk_run_queues();
-
-		/* Save state of all device drivers, and stop them. */		   
-		if(drivers_suspend()==0)
-			/* If stopping device drivers worked, we proceed basically into
-			 * suspend_save_image.
-			 *
-			 * do_magic(0) returns after system is resumed.
-			 *
-			 * do_magic() copies all "used" memory to "free" memory, then
-			 * unsuspends all device drivers, and writes memory to disk
-			 * using normal kernel mechanism.
-			 */
-			do_magic(0);
-		thaw_processes();
-	}
-	software_suspend_enabled = 1;
-	MDELAY(1000);
-	pm_restore_console();
-}
-
-/*
- * This is main interface to the outside world. It needs to be
- * called from process context.
- */
-void software_suspend(void)
-{
-	if(!software_suspend_enabled)
-		return;
-
-	software_suspend_enabled = 0;
-	might_sleep();
-	do_software_suspend();
+	return -EFAULT;
 }
 
 /* More restore stuff */
 
 /* FIXME: Why not memcpy(to, from, 1<<pagedir_order*PAGE_SIZE)? */
-static void copy_pagedir(suspend_pagedir_t *to, suspend_pagedir_t *from)
+static void __init copy_pagedir(suspend_pagedir_t *to, suspend_pagedir_t *from)
 {
 	int i;
 	char *topointer=(char *)to, *frompointer=(char *)from;
@@ -767,8 +592,8 @@
 /*
  * Returns true if given address/order collides with any orig_address 
  */
-static int does_collide_order(suspend_pagedir_t *pagedir, unsigned long addr,
-		int order)
+static int __init does_collide_order(suspend_pagedir_t *pagedir, 
+				     unsigned long addr, int order)
 {
 	int i;
 	unsigned long addre = addr + (PAGE_SIZE<<order);
@@ -785,7 +610,7 @@
  * We check here that pagedir & pages it points to won't collide with pages
  * where we're going to restore from the loaded pages later
  */
-static int check_pagedir(void)
+static int __init check_pagedir(void)
 {
 	int i;
 
@@ -803,7 +628,7 @@
 	return 0;
 }
 
-static int relocate_pagedir(void)
+static int __init relocate_pagedir(void)
 {
 	/*
 	 * We have to avoid recursion (not to overflow kernel stack),
@@ -853,13 +678,13 @@
  * I really don't think that it's foolproof but more than nothing..
  */
 
-static int sanity_check_failed(char *reason)
+static int __init sanity_check_failed(char *reason)
 {
 	printk(KERN_ERR "%s%s\n",name_resume,reason);
 	return -EPERM;
 }
 
-static int sanity_check(struct suspend_header *sh)
+static int __init sanity_check(struct suspend_header *sh)
 {
 	if(sh->version_code != LINUX_VERSION_CODE)
 		return sanity_check_failed("Incorrect kernel version");
@@ -876,7 +701,8 @@
 	return 0;
 }
 
-static int bdev_read_page(struct block_device *bdev, long pos, void *buf)
+static int __init bdev_read_page(struct block_device *bdev, 
+				 long pos, void *buf)
 {
 	struct buffer_head *bh;
 	BUG_ON (pos%PAGE_SIZE);
@@ -890,31 +716,10 @@
 	return 0;
 } 
 
-static int bdev_write_page(struct block_device *bdev, long pos, void *buf)
-{
-#if 0
-	struct buffer_head *bh;
-	BUG_ON (pos%PAGE_SIZE);
-	bh = __bread(bdev, pos/PAGE_SIZE, PAGE_SIZE);
-	if (!bh || (!bh->b_data)) {
-		return -1;
-	}
-	memcpy(bh->b_data, buf, PAGE_SIZE);	/* FIXME: may need kmap() */
-	BUG_ON(!buffer_uptodate(bh));
-	generic_make_request(WRITE, bh);
-	if (!buffer_uptodate(bh))
-		printk(KERN_CRIT "%sWarning %s: Fixing swap signatures unsuccessful...\n", name_resume, resume_file);
-	wait_on_buffer(bh);
-	brelse(bh);
-	return 0;
-#endif
-	printk(KERN_CRIT "%sWarning %s: Fixing swap signatures unimplemented...\n", name_resume, resume_file);
-	return 0;
-}
-
 extern dev_t __init name_to_dev_t(const char *line);
 
-static int __read_suspend_image(struct block_device *bdev, union diskpage *cur, int noresume)
+static int __init read_suspend_image(struct block_device *bdev, 
+				     union diskpage *cur)
 {
 	swp_entry_t next;
 	int i, nr_pgdir_pages;
@@ -939,18 +744,9 @@
 	else if (!memcmp("S2",cur->swh.magic.magic,2))
 		memcpy(cur->swh.magic.magic,"SWAPSPACE2",10);
 	else {
-		if (noresume)
-			return -EINVAL;
-		panic("%sUnable to find suspended-data signature (%.10s - misspelled?\n", 
+		printk("swsusp: %s: Unable to find suspended-data signature (%.10s - misspelled?\n", 
 			name_resume, cur->swh.magic.magic);
-	}
-	if (noresume) {
-		/* We don't do a sanity check here: we want to restore the swap
-		   whatever version of kernel made the suspend image;
-		   We need to write swap, but swap is *not* enabled so
-		   we must write the device directly */
-		printk("%s: Fixing swap signatures %s...\n", name_resume, resume_file);
-		bdev_write_page(bdev, 0, cur);
+		return -EFAULT;
 	}
 
 	printk( "%sSignature found, resuming\n", name_resume );
@@ -1000,117 +796,115 @@
 	return 0;
 }
 
-static int read_suspend_image(const char * specialfile, int noresume)
+/**
+ *	swsusp_save - Snapshot memory
+ */
+
+int swsusp_save(void) 
+{
+#if defined (CONFIG_HIGHMEM) || defined (COFNIG_DISCONTIGMEM)
+	printk("swsusp is not supported with high- or discontig-mem.\n");
+	return -EPERM;
+#endif
+	return 0;
+}
+
+
+/**
+ *	swsusp_write - Write saved memory image to swap.
+ *
+ *	do_magic(0) returns after system is resumed.
+ *
+ *	do_magic() copies all "used" memory to "free" memory, then
+ *	unsuspends all device drivers, and writes memory to disk
+ *	using normal kernel mechanism.
+ */
+
+int swsusp_write(void)
+{
+	arch_prepare_suspend();
+	return do_magic(0);
+}
+
+
+/**
+ *	swsusp_read - Read saved image from swap.
+ */
+
+int __init swsusp_read(void)
 {
 	union diskpage *cur;
-	unsigned long scratch_page = 0;
 	int error;
 	char b[BDEVNAME_SIZE];
 
-	resume_device = name_to_dev_t(specialfile);
-	scratch_page = get_zeroed_page(GFP_ATOMIC);
-	cur = (void *) scratch_page;
+	if (!strlen(resume_file))
+		return -ENOENT;
+
+	resume_device = name_to_dev_t(resume_file);
+	printk("swsusp: Resume From Partition: %s, Device: %s\n", 
+	       resume_file, __bdevname(resume_device, b));
+
+	cur = (union diskpage *)get_zeroed_page(GFP_ATOMIC);
 	if (cur) {
 		struct block_device *bdev;
-		printk("Resuming from device %s\n",
-				__bdevname(resume_device, b));
 		bdev = open_by_devnum(resume_device, FMODE_READ, BDEV_RAW);
-		if (IS_ERR(bdev)) {
-			error = PTR_ERR(bdev);
-		} else {
+		if (!IS_ERR(bdev)) {
 			set_blocksize(bdev, PAGE_SIZE);
-			error = __read_suspend_image(bdev, cur, noresume);
+			error = read_suspend_image(bdev, cur);
 			blkdev_put(bdev, BDEV_RAW);
-		}
-	} else error = -ENOMEM;
+		} else
+			error = PTR_ERR(bdev);
+		free_page((unsigned long)cur);
+	} else
+		error = -ENOMEM;
 
-	if (scratch_page)
-		free_page(scratch_page);
-	switch (error) {
-		case 0:
-			PRINTK("Reading resume file was successful\n");
-			break;
-		case -EINVAL:
-			break;
-		case -EIO:
-			printk( "%sI/O error\n", name_resume);
-			break;
-		case -ENOENT:
-			printk( "%s%s: No such file or directory\n", name_resume, specialfile);
-			break;
-		case -ENOMEM:
-			printk( "%sNot enough memory\n", name_resume);
-			break;
-		default:
-			printk( "%sError %d resuming\n", name_resume, error );
-	}
+	if (!error)
+		PRINTK("Reading resume file was successful\n");
+	else
+		printk( "%sError %d resuming\n", name_resume, error );
 	MDELAY(1000);
 	return error;
 }
 
-/*
- * Called from init kernel_thread.
- * We check if we have an image and if so we try to resume
+
+/**
+ *	swsusp_restore - Replace running kernel with saved image.
  */
 
-void software_resume(void)
+int __init swsusp_restore(void)
 {
-	if (num_online_cpus() > 1) {
-		printk(KERN_WARNING "Software Suspend has malfunctioning SMP support. Disabled :(\n");	
-		return;
-	}
-	/* We enable the possibility of machine suspend */
-	software_suspend_enabled = 1;
-	if (!resume_status)
-		return;
+	return do_magic(1);
+}
 
-	printk( "%s", name_resume );
-	if (resume_status == NORESUME) {
-		if(resume_file[0])
-			read_suspend_image(resume_file, 1);
-		printk( "disabled\n" );
-		return;
-	}
-	MDELAY(1000);
 
-	if (pm_prepare_console())
-		printk("swsusp: Can't allocate a console... proceeding\n");
+/**
+ *	swsusp_free - Free memory allocated to hold snapshot.
+ */
 
-	if (!resume_file[0] && resume_status == RESUME_SPECIFIED) {
-		printk( "suspension device unspecified\n" );
-		return;
-	}
+int swsusp_free(void)
+{
+	PRINTK( "Freeing prev allocated pagedir\n" );
+	free_suspend_pagedir((unsigned long) pagedir_save);
 
-	printk( "resuming from %s\n", resume_file);
-	if (read_suspend_image(resume_file, 0))
-		goto read_failure;
-	do_magic(1);
-	panic("This never returns");
-
-read_failure:
-	pm_restore_console();
-	return;
+	PRINTK( "Fixing swap signatures... " );
+	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
+	PRINTK( "ok\n" );
+	return 0;
 }
 
 static int __init resume_setup(char *str)
 {
-	if (resume_status == NORESUME)
-		return 1;
-
-	strncpy( resume_file, str, 255 );
-	resume_status = RESUME_SPECIFIED;
-
+	if (strlen(str))
+		strncpy(resume_file, str, 255);
 	return 1;
 }
 
 static int __init noresume_setup(char *str)
 {
-	resume_status = NORESUME;
+	resume_file[0] = '\0';
 	return 1;
 }
 
 __setup("noresume", noresume_setup);
 __setup("resume=", resume_setup);
 
-EXPORT_SYMBOL(software_suspend);
-EXPORT_SYMBOL(software_suspend_enabled);

--Qxx1br4bt0+wmkIi--
