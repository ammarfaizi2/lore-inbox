Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316210AbSGASt2>; Mon, 1 Jul 2002 14:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316204AbSGASt1>; Mon, 1 Jul 2002 14:49:27 -0400
Received: from dingo.clsp.jhu.edu ([128.220.34.67]:43527 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S316210AbSGAStU>;
	Mon, 1 Jul 2002 14:49:20 -0400
Date: Mon, 1 Jul 2002 01:20:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Cc: florent.chabaud@polytechnique.org
Subject: suspend: Clean up messages being printed
Message-ID: <20020630232005.GA482@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is originally by florent for 2.4. It cleans up the mess on
screen, frees page when it should and updates CREDITS. Please apply,
									Pavel

--- linux-swsusp.test/CREDITS	Mon Jun 10 17:17:36 2002
+++ linux-swsusp/CREDITS	Sun Jun 30 23:48:20 2002
@@ -502,6 +502,14 @@
 S: Fremont, California 94539
 S: USA
 
+N: Florent Chabaud
+E: florent.chabaud@polytechnique.org
+D: software suspend
+S: SGDN/DCSSI/SDS/LTI
+S: 58, Bd Latour-Maubourg
+S: 75700 Paris 07 SP
+S: France
+
 N: Gordon Chaffee
 E: chaffee@cs.berkeley.edu
 W: http://bmrc.berkeley.edu/people/chaffee/
@@ -1708,7 +1716,7 @@
 N: Gabor Kuti
 M: seasons@falcon.sch.bme.hu
 M: seasons@makosteszta.sote.hu
-D: Software suspend
+D: Original author of software suspend
 
 N: Jaroslav Kysela
 E: perex@suse.cz
--- linux-swsusp.test/kernel/suspend.c	Thu Jun 27 23:53:13 2002
+++ linux-swsusp/kernel/suspend.c	Mon Jul  1 00:55:29 2002
@@ -97,7 +97,7 @@
 /* Variables to be preserved over suspend */
 static int new_loglevel = 7;
 static int orig_loglevel = 0;
-static int orig_fgconsole;
+static int orig_fgconsole, orig_kmsg;
 static int pagedir_order_check;
 static int nr_copy_pages_check;
 
@@ -145,26 +145,17 @@
 /*
  * Debug
  */
-#define	DEBUG_DEFAULT	1
+#undef	DEBUG_DEFAULT
 #undef	DEBUG_PROCESS
 #undef	DEBUG_SLOW
 #define TEST_SWSUSP 1		/* Set to 1 to reboot instead of halt machine after suspension */
 
 #ifdef DEBUG_DEFAULT
-#define PRINTD(func, f, a...)	\
-	do { \
-		printk("%s", func); \
-		printk(f, ## a); \
-	} while(0)
-#define PRINTS(f, a...)	PRINTD(name_suspend, f, ## a)
-#define PRINTR(f, a...)	PRINTD(name_resume, f, ## a)
-#define PRINTK(f, a...)	printk(f, ## a)
+# define PRINTK(f, a...)       printk(f, ## a)
 #else
-#define PRINTD(func, f, a...)
-#define PRINTS(f, a...)
-#define PRINTR(f, a...)
-#define PRINTK(f, a...)
+# define PRINTK(f, a...)
 #endif
+
 #ifdef DEBUG_SLOW
 #define MDELAY(a) mdelay(a)
 #else
@@ -195,8 +186,8 @@
 	long save;
 	save = current->state;
 	current->state = TASK_STOPPED;
-//	PRINTK("%s entered refrigerator\n", current->comm);
-	printk(":");
+	PRINTK("%s entered refrigerator\n", current->comm);
+	printk("=");
 	current->flags &= ~PF_FREEZE;
 	if (flag)
 		flush_signals(current); /* We have signaled a kernel thread, which isn't normal behaviour
@@ -205,8 +196,7 @@
 	current->flags |= PF_FROZEN;
 	while (current->flags & PF_FROZEN)
 		schedule();
-//	PRINTK("%s left refrigerator\n", current->comm);
-	printk(":");
+	PRINTK("%s left refrigerator\n", current->comm);
 	current->state = save;
 }
 
@@ -216,8 +206,7 @@
 	int todo, start_time;
 	struct task_struct *p;
 	
-	PRINTS( "Waiting for tasks to stop... " );
-	
+	printk( "Stopping tasks: " );
 	start_time = jiffies;
 	do {
 		todo = 0;
@@ -240,13 +229,13 @@
 		sys_sched_yield();
 		schedule();
 		if (time_after(jiffies, start_time + TIMEOUT)) {
-			PRINTK( "\n" );
+			printk( "\n" );
 			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
 			return todo;
 		}
 	} while(todo);
 	
-	PRINTK( " ok\n" );
+	printk( "|\n" );
 	return 0;
 }
 
@@ -254,7 +243,7 @@
 {
 	struct task_struct *p;
 
-	PRINTR( "Restarting tasks..." );
+	printk( "Restarting tasks..." );
 	read_lock(&tasklist_lock);
 	for_each_task(p) {
 		INTERESTING(p);
@@ -265,7 +254,7 @@
 		wake_up_process(p);
 	}
 	read_unlock(&tasklist_lock);
-	PRINTK( " done\n" );
+	printk( " done\n" );
 	MDELAY(500);
 }
 
@@ -376,7 +365,7 @@
 					root_swap = i;
 				} else {
 #if 0
-					PRINTS( "device %s (%x != %x) ignored\n", swap_info[i].swap_file->d_name.name, swap_info[i].swap_device, resume_device );				  
+					printk( "Resume: device %s (%x != %x) ignored\n", swap_info[i].swap_file->d_name.name, swap_info[i].swap_device, resume_device );				  
 #endif
 				  	swapfile_used[i] = SWAPFILE_IGNORED;
 				}
@@ -409,10 +398,10 @@
 	unsigned long address;
 	struct page *page;
 
-	PRINTS( "Writing data to swap (%d pages): ", nr_copy_pages );
+	printk( "Writing data to swap (%d pages): ", nr_copy_pages );
 	for (i=0; i<nr_copy_pages; i++) {
 		if (!(i%100))
-			PRINTK( "." );
+			printk( "." );
 		if (!(entry = get_swap_page()).val)
 			panic("\nNot enough swapspace when writing data" );
 		
@@ -424,12 +413,12 @@
 		rw_swap_page_sync(WRITE, entry, page);
 		(pagedir_nosave+i)->swap_address = entry;
 	}
-	PRINTK(" done\n");
-	PRINTS( "Writing pagedir (%d pages): ", nr_pgdir_pages);
+	printk( "|\n" );
+	printk( "Writing pagedir (%d pages): ", nr_pgdir_pages);
 	for (i=0; i<nr_pgdir_pages; i++) {
 		cur = (union diskpage *)((char *) pagedir_nosave)+i;
 		BUG_ON ((char *) cur != (((char *) pagedir_nosave) + i*PAGE_SIZE));
-		PRINTK( "." );
+		printk( "." );
 		if (!(entry = get_swap_page()).val) {
 			printk(KERN_CRIT "Not enough swapspace when writing pgdir\n" );
 			panic("Don't know how to recover");
@@ -448,7 +437,7 @@
 		rw_swap_page_sync(WRITE, entry, page);
 		prev = entry;
 	}
-	PRINTK(", header");
+	printk("H");
 	BUG_ON (sizeof(struct suspend_header) > PAGE_SIZE-sizeof(swp_entry_t));
 	BUG_ON (sizeof(union diskpage) != PAGE_SIZE);
 	if (!(entry = get_swap_page()).val)
@@ -466,9 +455,9 @@
 	rw_swap_page_sync(WRITE, entry, page);
 	prev = entry;
 
-	PRINTK( ", signature" );
+	printk( "S" );
 	mark_swapfiles(prev, MARK_SWAP_SUSPEND);
-	PRINTK( ", done\n" );
+	printk( "|\n" );
 
 	MDELAY(1000);
 	free_page((unsigned long) buffer);
@@ -504,7 +493,7 @@
 			if (ADDRESS(loop) >= (unsigned long)
 				&__nosave_begin && ADDRESS(loop) < 
 				(unsigned long)&__nosave_end) {
-				printk("[nosave]");
+				PRINTK("[nosave %x]", ADDRESS(loop));
 				continue;
 			}
 			/* Hmm, perhaps copying all reserved pages is not too healthy as they may contain 
@@ -585,9 +574,11 @@
 
 	set_console (SUSPEND_CONSOLE);
 	if(vt_waitactive(SUSPEND_CONSOLE)) {
-		PRINTS("Bummer. Can't switch VCs.");
+		PRINTK("Bummer. Can't switch VCs.");
 		return 1;
 	}
+	orig_kmsg = kmsg_redirect;
+	kmsg_redirect = SUSPEND_CONSOLE;
 #endif
 #endif
 	return 0;
@@ -604,13 +595,12 @@
 
 static int prepare_suspend_processes(void)
 {
-	PRINTS( "Stopping processes\n" );
-	MDELAY(1000);
 	if (freeze_processes()) {
-		PRINTS( "Not all processes stopped!\n" );
+		printk( KERN_ERR "Suspend failed: Not all processes stopped!\n" );
 		thaw_processes();
 		return 1;
 	}
+	MDELAY(1000);
 	do_suspend_sync();
 	return 0;
 }
@@ -622,10 +612,10 @@
  */
 static void free_some_memory(void)
 {
-	PRINTS("Freeing memory: ");
+	printk("Freeing memory: ");
 	while (try_to_free_pages(&contig_page_data.node_zones[ZONE_HIGHMEM], GFP_KSWAPD, 0))
 		printk(".");
-	printk("\n");
+	printk("|\n");
 }
 
 /* Make disk drivers accept operations, again */
@@ -682,11 +672,11 @@
 	unsigned int nr_needed_pages = 0;
 
 	pagedir_nosave = NULL;
-	PRINTS( "/critical section: Counting pages to copy" );
+	printk( "/critical section: Counting pages to copy" );
 	nr_copy_pages = count_and_copy_data_pages(NULL);
 	nr_needed_pages = nr_copy_pages + PAGES_FOR_IO;
 	
-	PRINTK(" (pages needed: %d+%d=%d free: %d)\n",nr_copy_pages,PAGES_FOR_IO,nr_needed_pages,nr_free_pages());
+	printk(" (pages needed: %d+%d=%d free: %d)\n",nr_copy_pages,PAGES_FOR_IO,nr_needed_pages,nr_free_pages());
 	if(nr_free_pages() < nr_needed_pages) {
 		printk(KERN_CRIT "%sCouldn't get enough free pages, on %d pages short\n",
 		       name_suspend, nr_needed_pages-nr_free_pages());
@@ -726,14 +716,12 @@
 	 */
 	drivers_unsuspend();
 	spin_unlock_irq(&suspend_pagedir_lock);
-	PRINTS( "critical section/: done (%d pages copied)\n", nr_copy_pages );
+	printk( "critical section/: done (%d pages copied)\n", nr_copy_pages );
 
 	lock_swapdevices();
 	write_suspend_image();
 	lock_swapdevices();	/* This will unlock ignored swap devices since writing is finished */
 
-	/* Image is saved, call sync & restart machine */
-	PRINTS( "Syncing disks\n" );
 	/* It is important _NOT_ to umount filesystems at this point. We want
 	 * them synced (in case something goes wrong) but we DO not want to mark
 	 * filesystem clean: it is not. (And it does not matter, if we resume
@@ -745,9 +733,9 @@
 void suspend_power_down(void)
 {
 	C_A_D = 0;
-	printk(KERN_EMERG "%sTrying to power down.\n", name_suspend);
+	printk(KERN_EMERG "%s%s Trying to power down.\n", name_suspend, TEST_SWSUSP ? "Disable TEST_SWSUSP. NOT ": "");
 #ifdef CONFIG_VT
-	printk(KERN_EMERG "shift_state: %04x\n", shift_state);
+	PRINTK(KERN_EMERG "shift_state: %04x\n", shift_state);
 	mdelay(1000);
 	if (TEST_SWSUSP ^ (!!(shift_state & (1 << KG_CTRL))))
 		machine_restart(NULL);
@@ -774,7 +762,7 @@
 	mb();
 	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
 
-	printk( "Waiting for DMAs to settle down...\n");
+	PRINTK( "Waiting for DMAs to settle down...\n");
 	mdelay(1000);	/* We do not want some readahead with DMA to corrupt our memory, right?
 			   Do it with disabled interrupts for best effect. That way, if some
 			   driver scheduled DMA, we have good chance for DMA to finish ;-). */
@@ -785,7 +773,7 @@
 	BUG_ON (nr_copy_pages_check != nr_copy_pages);
 	BUG_ON (pagedir_order_check != pagedir_order);
 
-	PRINTR( "Freeing prev allocated pagedir\n" );
+	PRINTK( "Freeing prev allocated pagedir\n" );
 	free_suspend_pagedir((unsigned long) pagedir_save);
 	__flush_tlb_global();		/* Even mappings of "global" things (vmalloc) need to be fixed */
 	drivers_resume(RESUME_ALL_PHASES);
@@ -813,7 +801,7 @@
 	if (!suspend_save_image())
 		suspend_power_down();	/* FIXME: if suspend_power_down is commented out, console is lost after few suspends ?! */
 
-	printk(KERN_WARNING "%sSuspend failed, trying to recover...\n", name_suspend);
+	printk(KERN_EMERG "%sSuspend failed, trying to recover...\n", name_suspend);
 	MDELAY(1000); /* So user can wait and report us messages if armageddon comes :-) */
 
 	barrier();
@@ -826,7 +814,7 @@
 	drivers_resume(RESUME_PHASE1);
 	spin_unlock_irq(&suspend_pagedir_lock);
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
-	printk(KERN_WARNING "%sLeaving do_magic_suspend_2...\n", name_suspend);	
+	PRINTK(KERN_WARNING "%sLeaving do_magic_suspend_2...\n", name_suspend);	
 }
 
 /*
@@ -838,7 +826,7 @@
 {
 	arch_prepare_suspend();
 	if (prepare_suspend_console())
-		printk( "Can't allocate a console... proceeding\n");
+		printk( "%sCan't allocate a console... proceeding\n", name_suspend);
 	if (!prepare_suspend_processes()) {
 		free_some_memory();
 		
@@ -847,11 +835,11 @@
 		 * We sync here -- so you have consistent filesystem state when things go wrong.
 		 * -- so that noone writes to disk after we do atomic copy of data.
 		 */
-		PRINTS("Syncing disks before copy\n");
+		PRINTK("Syncing disks before copy\n");
 		do_suspend_sync();
 		if(drivers_suspend()==0)
 			do_magic(0);			/* This function returns after machine woken up from resume */
-		PRINTR("Restarting processes...\n");
+		PRINTK("Restarting processes...\n");
 		thaw_processes();
 	}
 	software_suspend_enabled = 1;
@@ -939,6 +927,8 @@
 	void **eaten_memory = NULL;
 	void **c = eaten_memory, *m, *f;
 
+	printk("Relocating pagedir");
+
 	if(!does_collide_order(old_pagedir, (unsigned long)old_pagedir, pagedir_order)) {
 		printk("not neccessary\n");
 		return 0;
@@ -968,7 +958,7 @@
 		if (f)
 			free_pages((unsigned long)f, pagedir_order);
 	}
-	printk("okay\n");
+	printk("|\n");
 	return 0;
 }
 
@@ -1007,11 +997,11 @@
 
 	BUG_ON (pos%PAGE_SIZE);
 	bdev = bdget(kdev_t_to_nr(dev));
-	blkdev_get(bdev, FMODE_READ, O_RDONLY, BDEV_RAW);
 	if (!bdev) {
 		printk("No block device for %s\n", __bdevname(dev));
 		BUG();
 	}
+	blkdev_get(bdev, FMODE_READ, O_RDONLY, BDEV_RAW);
 	set_blocksize(bdev, PAGE_SIZE);
 	bh = __bread(bdev, pos/PAGE_SIZE, PAGE_SIZE);
 	if (!bh || (!bh->b_data)) {
@@ -1026,14 +1016,16 @@
 
 extern kdev_t __init name_to_kdev_t(const char *line);
 
-static int resume_try_to_read(const char * specialfile, int noresume)
+static int read_suspend_image(const char * specialfile, int noresume)
 {
 	union diskpage *cur;
+	unsigned long scratch_page = 0;
 	swp_entry_t next;
 	int i, nr_pgdir_pages, error;
 
 	resume_device = name_to_kdev_t(specialfile);
-	cur = (void *) get_free_page(GFP_ATOMIC);
+	scratch_page = get_free_page(GFP_ATOMIC);
+	cur = (void *) scratch_page;
 	if (!cur) {
 		printk( "%sNot enough memory?\n", name_resume );
 		error = -ENOMEM;
@@ -1093,7 +1120,7 @@
 	if(!pagedir_nosave)
 		goto resume_read_error;
 
-	PRINTR( "%sReading pagedir, ", name_resume );
+	PRINTK( "%sReading pagedir, ", name_resume );
 
 	/* We get pages in reverse order of saving! */
 	error=-EIO;
@@ -1105,30 +1132,31 @@
 	}
 	BUG_ON (next.val);
 
-	printk("Relocating pagedir");
 	if((error=relocate_pagedir())!=0)
 		goto resume_read_error;
 	if((error=check_pagedir())!=0)
 		goto resume_read_error;
 
-	PRINTK( "image data (%d pages): ", nr_copy_pages );
+	printk( "Reading image data (%d pages): ", nr_copy_pages );
 	error = -EIO;
 	for(i=0; i < nr_copy_pages; i++) {
 		swp_entry_t swap_address = (pagedir_nosave+i)->swap_address;
 		if (!(i%100))
-			PRINTK( "." );
+			printk( "." );
 		next.val = swp_offset(swap_address) * PAGE_SIZE;
 		/* You do not need to check for overlaps...
 		   ... check_pagedir already did this work */
 		READTO(next.val, (char *)((pagedir_nosave+i)->address));
 	}
-	PRINTK( " done\n" );
+	printk( "|\n" );
 	error = 0;
 
 resume_read_error:
+	if (scratch_page)
+		free_page(scratch_page);
 	switch (error) {
 		case 0:
-			PRINTR("Reading resume file was successful\n");
+			PRINTK("Reading resume file was successful\n");
 			break;
 		case -EINVAL:
 			break;
@@ -1163,7 +1191,8 @@
 
 	printk( "%s", name_resume );
 	if(resume_status == NORESUME) {
-		/* FIXME: Signature should be restored here */
+		if(resume_file[0])
+			read_suspend_image(resume_file,1);
 		printk( "disabled\n" );
 		return;
 	}
@@ -1173,12 +1202,12 @@
 	console_loglevel = new_loglevel;
 
 	if(!resume_file[0] && resume_status == RESUME_SPECIFIED) {
-		printk( "nowhere to resume from\n" );
+		printk( "suspension device unspecified\n" );
 		return;
 	}
 
 	printk( "resuming from %s\n", resume_file);
-	if(resume_try_to_read(resume_file, 0))
+	if(read_suspend_image(resume_file, 0))
 		goto read_failure;
 	do_magic(1);
 	panic("This never returns");

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
