Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSGINJA>; Tue, 9 Jul 2002 09:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315218AbSGINI7>; Tue, 9 Jul 2002 09:08:59 -0400
Received: from mail.clsp.jhu.edu ([128.220.34.27]:23275 "EHLO
	mail.clsp.jhu.edu") by vger.kernel.org with ESMTP
	id <S315214AbSGINIj>; Tue, 9 Jul 2002 09:08:39 -0400
Date: Tue, 9 Jul 2002 05:25:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: suspend-to-disk: cleanup printks(), rearrange reading
Message-ID: <20020709032507.GA8090@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'd like Florent credited -- he is maintaining 2.4.X version and
helping with development. Kill warnings by rearranging code / adding
prototypes. Enable using separate console (so user sees progress and X
suspend/resume works properly), forward-port of updates from Florent
and stop using own PRINTK stuff (mostly). Reading now primarily uses
block_device(), this should enable more cleanups. Fixed double free on
error path. Please apply,
								Pavel

--- clean/CREDITS	Mon Jun 10 17:17:36 2002
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
--- clean/arch/i386/kernel/suspend.c	Wed Jun 26 20:18:53 2002
+++ linux-swsusp/arch/i386/kernel/suspend.c	Wed Jun 12 08:39:31 2002
@@ -97,6 +97,14 @@
 	asm volatile ("pushfl ; popl (%0)" : "=m" (saved_context.eflags));
 }
 
+static void
+do_fpu_end(void)
+{
+        /* restore FPU regs if necessary */
+	/* Do it out of line so that gcc does not move cr0 load to some stupid place */
+        kernel_fpu_end();
+}
+
 /*
  * restore_processor_context
  * 
@@ -220,13 +228,6 @@
 
 }
 
-static void
-do_fpu_end(void)
-{
-        /* restore FPU regs if necessary */
-	/* Do it out of line so that gcc does not move cr0 load to some stupid place */
-        kernel_fpu_end();
-}
 
 #ifdef CONFIG_SOFTWARE_SUSPEND
 /* Local variables for do_magic */
--- clean/include/asm-i386/suspend.h	Mon Jun 10 17:17:48 2002
+++ linux-swsusp/include/asm-i386/suspend.h	Wed Jun 12 08:42:43 2002
@@ -38,7 +38,6 @@
                        : /* no output */ \
                        :"r" ((thread)->debugreg[register]))
 
-extern void do_fpu_end(void);
 extern void fix_processor_context(void);
 extern void do_magic(int resume);
 
--- clean/include/linux/suspend.h	Wed Jun 26 20:19:08 2002
+++ linux-swsusp/include/linux/suspend.h	Wed Jun 12 08:43:51 2002
@@ -56,9 +56,22 @@
 extern int unregister_suspend_notifier(struct notifier_block *);
 extern void refrigerator(unsigned long);
 
+extern int freeze_processes(void);
+extern void thaw_processes(void);
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
+/* Communication between acpi and arch/i386/suspend.c */
+
+extern void do_suspend_lowlevel(int resume);
 
 #else
 #define software_suspend()		do { } while(0)
--- clean/kernel/suspend.c	Tue Jul  9 04:54:08 2002
+++ linux-swsusp/kernel/suspend.c	Tue Jul  9 04:54:23 2002
@@ -69,7 +69,7 @@
 
 unsigned char software_suspend_enabled = 0;
 
-/* #define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1) */
+#define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1)
 /* With SUSPEND_CONSOLE defined, it suspend looks *really* cool, but
    we probably do not take enough locks for switching consoles, etc,
    so bad things might happen.
@@ -97,7 +97,7 @@
 /* Variables to be preserved over suspend */
 static int new_loglevel = 7;
 static int orig_loglevel = 0;
-static int orig_fgconsole;
+static int orig_fgconsole, orig_kmsg;
 static int pagedir_order_check;
 static int nr_copy_pages_check;
 
@@ -139,32 +139,23 @@
  */
 #define PAGES_FOR_IO	512
 
-static const char *name_suspend = "Suspend Machine: ";
-static const char *name_resume = "Resume Machine: ";
+static const char name_suspend[] = "Suspend Machine: ";
+static const char name_resume[] = "Resume Machine: ";
 
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
@@ -239,13 +228,13 @@
 		read_unlock(&tasklist_lock);
 		yield();
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
 
@@ -253,7 +242,7 @@
 {
 	struct task_struct *p;
 
-	PRINTR( "Restarting tasks..." );
+	printk( "Restarting tasks..." );
 	read_lock(&tasklist_lock);
 	for_each_task(p) {
 		INTERESTING(p);
@@ -264,7 +253,7 @@
 		wake_up_process(p);
 	}
 	read_unlock(&tasklist_lock);
-	PRINTK( " done\n" );
+	printk( " done\n" );
 	MDELAY(500);
 }
 
@@ -284,8 +273,7 @@
 	sh->num_cpus = num_online_cpus();
 	sh->page_size = PAGE_SIZE;
 	sh->suspend_pagedir = pagedir_nosave;
-	if (pagedir_save != pagedir_nosave)
-		panic("Must not happen");
+	BUG_ON (pagedir_save != pagedir_nosave);
 	sh->num_pbes = nr_copy_pages;
 	/* TODO: needed? mounted fs' last mounted date comparison
 	 * [so they haven't been mounted since last suspend.
@@ -376,7 +364,7 @@
 					root_swap = i;
 				} else {
 #if 0
-					PRINTS( "device %s (%x != %x) ignored\n", swap_info[i].swap_file->d_name.name, swap_info[i].swap_device, resume_device );				  
+					printk( "Resume: device %s (%x != %x) ignored\n", swap_info[i].swap_file->d_name.name, swap_info[i].swap_device, resume_device );				  
 #endif
 				  	swapfile_used[i] = SWAPFILE_IGNORED;
 				}
@@ -409,14 +397,14 @@
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
 		
-		if(swapfile_used[swp_type(entry)] != SWAPFILE_SUSPEND)
+		if (swapfile_used[swp_type(entry)] != SWAPFILE_SUSPEND)
 			panic("\nPage %d: not enough swapspace on suspend device", i );
 	    
 		address = (pagedir_nosave+i)->address;
@@ -424,13 +412,12 @@
 		rw_swap_page_sync(WRITE, entry, page);
 		(pagedir_nosave+i)->swap_address = entry;
 	}
-	PRINTK(" done\n");
-	PRINTS( "Writing pagedir (%d pages): ", nr_pgdir_pages);
+	printk( "|\n" );
+	printk( "Writing pagedir (%d pages): ", nr_pgdir_pages);
 	for (i=0; i<nr_pgdir_pages; i++) {
 		cur = (union diskpage *)((char *) pagedir_nosave)+i;
-		if ((char *) cur != (((char *) pagedir_nosave) + i*PAGE_SIZE))
-			panic("Something is of wrong size");
-		PRINTK( "." );
+		BUG_ON ((char *) cur != (((char *) pagedir_nosave) + i*PAGE_SIZE));
+		printk( "." );
 		if (!(entry = get_swap_page()).val) {
 			printk(KERN_CRIT "Not enough swapspace when writing pgdir\n" );
 			panic("Don't know how to recover");
@@ -439,30 +426,26 @@
 		}
 
 		if(swapfile_used[swp_type(entry)] != SWAPFILE_SUSPEND)
-		  panic("\nNot enough swapspace for pagedir on suspend device" );
+			panic("\nNot enough swapspace for pagedir on suspend device" );
+
+		BUG_ON (sizeof(swp_entry_t) != sizeof(long));
+		BUG_ON (PAGE_SIZE % sizeof(struct pbe));
 
-		if (sizeof(swp_entry_t) != sizeof(long))
-			panic("I need swp_entry_t to be sizeof long, otherwise next assignment could damage pagedir");
-		if (PAGE_SIZE % sizeof(struct pbe))
-			panic("I need PAGE_SIZE to be integer multiple of struct pbe, otherwise next assignment could damage pagedir");
 		cur->link.next = prev;				
 		page = virt_to_page((unsigned long)cur);
 		rw_swap_page_sync(WRITE, entry, page);
 		prev = entry;
 	}
-	PRINTK(", header");
-	if (sizeof(struct suspend_header) > PAGE_SIZE-sizeof(swp_entry_t))
-		panic("sizeof(struct suspend_header) too big: %d",
-				sizeof(struct suspend_header));
-	if (sizeof(union diskpage) != PAGE_SIZE)
-		panic("union diskpage has bad size");
+	printk("H");
+	BUG_ON (sizeof(struct suspend_header) > PAGE_SIZE-sizeof(swp_entry_t));
+	BUG_ON (sizeof(union diskpage) != PAGE_SIZE);
 	if (!(entry = get_swap_page()).val)
 		panic( "\nNot enough swapspace when writing header" );
-	if(swapfile_used[swp_type(entry)] != SWAPFILE_SUSPEND)
-	  panic("\nNot enough swapspace for header on suspend device" );
+	if (swapfile_used[swp_type(entry)] != SWAPFILE_SUSPEND)
+		panic("\nNot enough swapspace for header on suspend device" );
 
 	cur = (void *) buffer;
-	if(fill_suspend_header(&cur->sh))
+	if (fill_suspend_header(&cur->sh))
 		panic("\nOut of memory while writing header");
 		
 	cur->link.next = prev;
@@ -471,13 +454,9 @@
 	rw_swap_page_sync(WRITE, entry, page);
 	prev = entry;
 
-	PRINTK( ", signature" );
-#if 0
-	if (swp_type(entry) != 0)
-		panic("Need just one swapfile");
-#endif
+	printk( "S" );
 	mark_swapfiles(prev, MARK_SWAP_SUSPEND);
-	PRINTK( ", done\n" );
+	printk( "|\n" );
 
 	MDELAY(1000);
 	free_page((unsigned long) buffer);
@@ -493,20 +472,19 @@
 	
 	if (max_mapnr != num_physpages)
 		panic("mapnr is not expected");
-	for(loop = 0; loop < max_mapnr; loop++) {
-		if(PageHighMem(mem_map+loop))
-			panic("No highmem for me, sorry.");
-		if(!PageReserved(mem_map+loop)) {
-			if(PageNosave(mem_map+loop))
+	for (loop = 0; loop < max_mapnr; loop++) {
+		if (PageHighMem(mem_map+loop))
+			panic("Swsusp not supported on highmem boxes. Send 1GB of RAM to <pavel@ucw.cz> and try again ;-).");
+		if (!PageReserved(mem_map+loop)) {
+			if (PageNosave(mem_map+loop))
 				continue;
 
-			if((chunk_size=is_head_of_free_region(mem_map+loop))!=0) {
+			if ((chunk_size=is_head_of_free_region(mem_map+loop))!=0) {
 				loop += chunk_size - 1;
 				continue;
 			}
-		} else if(PageReserved(mem_map+loop)) {
-			if(PageNosave(mem_map+loop))
-				panic("What?");
+		} else if (PageReserved(mem_map+loop)) {
+			BUG_ON (PageNosave(mem_map+loop));
 
 			/*
 			 * Just copy whole code segment. Hopefully it is not that big.
@@ -514,15 +492,15 @@
 			if (ADDRESS(loop) >= (unsigned long)
 				&__nosave_begin && ADDRESS(loop) < 
 				(unsigned long)&__nosave_end) {
-				printk("[nosave]");
+				PRINTK("[nosave %x]", ADDRESS(loop));
 				continue;
 			}
 			/* Hmm, perhaps copying all reserved pages is not too healthy as they may contain 
 			   critical bios data? */
-		} else panic("No third thing should be possible");
+		} else	BUG();
 
 		nr_copy_pages++;
-		if(pagedir_p) {
+		if (pagedir_p) {
 			pagedir_p->orig_address = ADDRESS(loop);
 			copy_page(pagedir_p->address, pagedir_p->orig_address);
 			pagedir_p++;
@@ -539,10 +517,10 @@
 		(PAGE_SIZE << pagedir_order);
 
 	for(i=0; i < num_physpages; i++, page++) {
-		if(!TestClearPageNosave(page))
+		if (!TestClearPageNosave(page))
 			continue;
 
-		if(ADDRESS(i) >= this_pagedir && ADDRESS(i) < this_pagedir_end)
+		if (ADDRESS(i) >= this_pagedir && ADDRESS(i) < this_pagedir_end)
 			continue; /* old pagedir gets freed in one */
 		
 		free_page(ADDRESS(i));
@@ -570,7 +548,6 @@
 	while(nr_copy_pages--) {
 		p->address = get_free_page(GFP_ATOMIC);
 		if(!p->address) {
-			panic("oom");
 			free_suspend_pagedir((unsigned long) pagedir);
 			return NULL;
 		}
@@ -596,9 +573,11 @@
 
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
@@ -615,14 +594,12 @@
 
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
-	do_suspend_sync();
+	sys_sync();
 	return 0;
 }
 
@@ -633,10 +610,10 @@
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
@@ -669,9 +646,11 @@
 #define RESUME_ALL_PHASES (RESUME_PHASE1 | RESUME_PHASE2)
 static void drivers_resume(int flags)
 {
-	device_resume(RESUME_ENABLE);
-	device_resume(RESUME_RESTORE_STATE);
-  	if(flags & RESUME_PHASE2) {
+	if (flags & RESUME_PHASE1) {
+		device_resume(RESUME_ENABLE);
+		device_resume(RESUME_RESTORE_STATE);
+	}
+  	if (flags & RESUME_PHASE2) {
 		if(pm_suspend_state) {
 			if(pm_send_all(PM_RESUME,(void *)0))
 				printk(KERN_WARNING "Problem while sending resume event\n");
@@ -691,11 +670,11 @@
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
@@ -724,7 +703,7 @@
 	pagedir_order_check = pagedir_order;
 
 	if (nr_copy_pages != count_and_copy_data_pages(pagedir_nosave))	/* copy */
-		panic("Count and copy returned another count than when counting?\n");
+		BUG();
 
 	/*
 	 * End of critical section. From now on, we can write to memory,
@@ -735,14 +714,12 @@
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
@@ -754,9 +731,9 @@
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
@@ -783,7 +760,7 @@
 	mb();
 	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
 
-	printk( "Waiting for DMAs to settle down...\n");
+	PRINTK( "Waiting for DMAs to settle down...\n");
 	mdelay(1000);	/* We do not want some readahead with DMA to corrupt our memory, right?
 			   Do it with disabled interrupts for best effect. That way, if some
 			   driver scheduled DMA, we have good chance for DMA to finish ;-). */
@@ -791,12 +768,10 @@
 
 void do_magic_resume_2(void)
 {
-	if (nr_copy_pages_check != nr_copy_pages)
-		panic("nr_copy_pages changed?!");
-	if (pagedir_order_check != pagedir_order)
-		panic("pagedir_order changed?!");
+	BUG_ON (nr_copy_pages_check != nr_copy_pages);
+	BUG_ON (pagedir_order_check != pagedir_order);
 
-	PRINTR( "Freeing prev allocated pagedir\n" );
+	PRINTK( "Freeing prev allocated pagedir\n" );
 	free_suspend_pagedir((unsigned long) pagedir_save);
 	__flush_tlb_global();		/* Even mappings of "global" things (vmalloc) need to be fixed */
 	drivers_resume(RESUME_ALL_PHASES);
@@ -824,7 +799,7 @@
 	if (!suspend_save_image())
 		suspend_power_down();	/* FIXME: if suspend_power_down is commented out, console is lost after few suspends ?! */
 
-	printk(KERN_WARNING "%sSuspend failed, trying to recover...\n", name_suspend);
+	printk(KERN_EMERG "%sSuspend failed, trying to recover...\n", name_suspend);
 	MDELAY(1000); /* So user can wait and report us messages if armageddon comes :-) */
 
 	barrier();
@@ -837,7 +812,7 @@
 	drivers_resume(RESUME_PHASE1);
 	spin_unlock_irq(&suspend_pagedir_lock);
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
-	printk(KERN_WARNING "%sLeaving do_magic_suspend_2...\n", name_suspend);	
+	PRINTK(KERN_WARNING "%sLeaving do_magic_suspend_2...\n", name_suspend);	
 }
 
 /*
@@ -849,7 +824,7 @@
 {
 	arch_prepare_suspend();
 	if (prepare_suspend_console())
-		printk( "Can't allocate a console... proceeding\n");
+		printk( "%sCan't allocate a console... proceeding\n", name_suspend);
 	if (!prepare_suspend_processes()) {
 		free_some_memory();
 		
@@ -858,11 +833,11 @@
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
@@ -950,6 +925,8 @@
 	void **eaten_memory = NULL;
 	void **c = eaten_memory, *m, *f;
 
+	printk("Relocating pagedir");
+
 	if(!does_collide_order(old_pagedir, (unsigned long)old_pagedir, pagedir_order)) {
 		printk("not neccessary\n");
 		return 0;
@@ -979,7 +956,7 @@
 		if (f)
 			free_pages((unsigned long)f, pagedir_order);
 	}
-	printk("okay\n");
+	printk("|\n");
 	return 0;
 }
 
@@ -1011,19 +988,10 @@
 	return 0;
 }
 
-static int bdev_read_page(kdev_t dev, long pos, void *buf)
+static int bdev_read_page(struct block_device *bdev, long pos, void *buf)
 {
 	struct buffer_head *bh;
-	struct block_device *bdev;
-
-	if (pos%PAGE_SIZE) panic("Sorry, dave, I can't let you do that!\n");
-	bdev = bdget(kdev_t_to_nr(dev));
-	blkdev_get(bdev, FMODE_READ, O_RDONLY, BDEV_RAW);
-	if (!bdev) {
-		printk("No block device for %s\n", __bdevname(dev));
-		BUG();
-	}
-	set_blocksize(bdev, PAGE_SIZE);
+	BUG_ON (pos%PAGE_SIZE);
 	bh = __bread(bdev, pos/PAGE_SIZE, PAGE_SIZE);
 	if (!bh || (!bh->b_data)) {
 		return -1;
@@ -1031,44 +999,48 @@
 	memcpy(buf, bh->b_data, PAGE_SIZE);	/* FIXME: may need kmap() */
 	BUG_ON(!buffer_uptodate(bh));
 	brelse(bh);
-	blkdev_put(bdev, BDEV_RAW);
 	return 0;
 } 
 
+static int bdev_write_page(struct block_device *bdev, long pos, void *buf)
+{
+	struct buffer_head *bh;
+#if 0
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
+}
+
 extern kdev_t __init name_to_kdev_t(const char *line);
 
-static int resume_try_to_read(const char * specialfile, int noresume)
+static int __read_suspend_image(struct block_device *bdev, union diskpage *cur, int noresume)
 {
-	union diskpage *cur;
 	swp_entry_t next;
-	int i, nr_pgdir_pages, error;
-	int blksize = 0;
-
-	resume_device = name_to_kdev_t(specialfile);
-	cur = (void *) get_free_page(GFP_ATOMIC);
-	if (!cur) {
-		printk( "%sNot enough memory?\n", name_resume );
-		error = -ENOMEM;
-		goto resume_read_error;
-	}
-
-	printk("Resuming from device %x\n", kdev_t_to_nr(resume_device));
+	int i, nr_pgdir_pages;
 
-#define READTO(pos, ptr) \
-	if (bdev_read_page(resume_device, pos, ptr)) { error = -EIO; goto resume_read_error; }
 #define PREPARENEXT \
 	{	next = cur->link.next; \
 		next.val = swp_offset(next) * PAGE_SIZE; \
         }
 
-	error = -EIO;
-	READTO(0, cur);
+	if (bdev_read_page(bdev, 0, cur)) return -EIO;
 
 	if ((!memcmp("SWAP-SPACE",cur->swh.magic.magic,10)) ||
 	    (!memcmp("SWAPSPACE2",cur->swh.magic.magic,10))) {
 		printk(KERN_ERR "%sThis is normal swap space\n", name_resume );
-		error = -EINVAL;
-		goto resume_read_error;
+		return -EINVAL;
 	}
 
 	PREPARENEXT; /* We have to read next position before we overwrite it */
@@ -1080,18 +1052,26 @@
 	else {
 		panic("%sUnable to find suspended-data signature (%.10s - misspelled?\n", 
 			name_resume, cur->swh.magic.magic);
+		/* We want to panic even with noresume -- we certainly don't want to add
+		   out signature into your ext2 filesystem ;-) */
 	}
+	if(noresume) {
+		/* We don't do a sanity check here: we want to restore the swap
+		   whatever version of kernel made the suspend image;
+		   We need to write swap, but swap is *not* enabled so
+		   we must write the device directly */
+		printk("%s: Fixing swap signatures %s...\n", name_resume, resume_file);
+		bdev_write_page(bdev, 0, cur);
+	}
+
+	if (prepare_suspend_console())
+		printk("%sCan't allocate a console... proceeding\n", name_resume);
 	printk( "%sSignature found, resuming\n", name_resume );
 	MDELAY(1000);
 
-	READTO(next.val, cur);
-
-	error = -EPERM;
-	if (sanity_check(&cur->sh))
-		goto resume_read_error;
-
-	/* Probably this is the same machine */	
-
+	if (bdev_read_page(bdev, next.val, cur)) return -EIO;
+	if (sanity_check(&cur->sh)) 	/* Is this same machine? */	
+		return -EPERM;
 	PREPARENEXT;
 
 	pagedir_save = cur->sh.suspend_pagedir;
@@ -1099,64 +1079,82 @@
 	nr_pgdir_pages = SUSPEND_PD_PAGES(nr_copy_pages);
 	pagedir_order = get_bitmask_order(nr_pgdir_pages);
 
-	error = -ENOMEM;
-	free_page((unsigned long) cur);
 	pagedir_nosave = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC, pagedir_order);
-	if(!pagedir_nosave)
-		goto resume_read_error;
+	if (!pagedir_nosave)
+		return -ENOMEM;
 
-	PRINTR( "%sReading pagedir, ", name_resume );
+	PRINTK( "%sReading pagedir, ", name_resume );
 
 	/* We get pages in reverse order of saving! */
-	error=-EIO;
 	for (i=nr_pgdir_pages-1; i>=0; i--) {
-		if (!next.val)
-			panic( "Preliminary end of suspended data?" );
+		BUG_ON (!next.val);
 		cur = (union diskpage *)((char *) pagedir_nosave)+i;
-		READTO(next.val, cur);
+		if (bdev_read_page(bdev, next.val, cur)) return -EIO;
 		PREPARENEXT;
 	}
-	if (next.val)
-		panic( "Suspended data too long?" );
+	BUG_ON (next.val);
 
-	printk("Relocating pagedir");
-	if((error=relocate_pagedir())!=0)
-		goto resume_read_error;
-	if((error=check_pagedir())!=0)
-		goto resume_read_error;
+	if (relocate_pagedir())
+		return -ENOMEM;
+	if (check_pagedir())
+		return -ENOMEM;
 
-	PRINTK( "image data (%d pages): ", nr_copy_pages );
-	error = -EIO;
+	printk( "Reading image data (%d pages): ", nr_copy_pages );
 	for(i=0; i < nr_copy_pages; i++) {
 		swp_entry_t swap_address = (pagedir_nosave+i)->swap_address;
 		if (!(i%100))
-			PRINTK( "." );
-		next.val = swp_offset(swap_address) * PAGE_SIZE;
+			printk( "." );
 		/* You do not need to check for overlaps...
 		   ... check_pagedir already did this work */
-		READTO(next.val, (char *)((pagedir_nosave+i)->address));
+		if (bdev_read_page(bdev, swp_offset(swap_address) * PAGE_SIZE, (char *)((pagedir_nosave+i)->address)))
+			return -EIO;
 	}
-	PRINTK( " done\n" );
-	error = 0;
+	printk( "|\n" );
+	return 0;
+}
 
-resume_read_error:
+static int read_suspend_image(const char * specialfile, int noresume)
+{
+	union diskpage *cur;
+	unsigned long scratch_page = 0;
+	int error;
+
+	resume_device = name_to_kdev_t(specialfile);
+	scratch_page = get_free_page(GFP_ATOMIC);
+	cur = (void *) scratch_page;
+	if (cur) {
+		struct block_device *bdev;
+		printk("Resuming from device %s\n", __bdevname(resume_device));
+		bdev = bdget(kdev_t_to_nr(resume_device));
+		if (!bdev) {
+			printk("No such block device ?!\n");
+			BUG();
+		}
+		blkdev_get(bdev, FMODE_READ, O_RDONLY, BDEV_RAW);
+		set_blocksize(bdev, PAGE_SIZE);
+		error = __read_suspend_image(bdev, cur, noresume);
+		blkdev_put(bdev, BDEV_RAW);
+	} else error = -ENOMEM;
+
+	if (scratch_page)
+		free_page(scratch_page);
 	switch (error) {
 		case 0:
-			PRINTR("Reading resume file was successful\n");
+			PRINTK("Reading resume file was successful\n");
 			break;
 		case -EINVAL:
 			break;
 		case -EIO:
 			printk( "%sI/O error\n", name_resume);
-			panic("Wanted to resume but it did not work\n");
 			break;
 		case -ENOENT:
 			printk( "%s%s: No such file or directory\n", name_resume, specialfile);
-			panic("Wanted to resume but it did not work\n");
+			break;
+		case -ENOMEM:
+			printk( "%sNot enough memory\n", name_resume);
 			break;
 		default:
 			printk( "%sError %d resuming\n", name_resume, error );
-			panic("Wanted to resume but it did not work\n");
 	}
 	MDELAY(1000);
 	return error;
@@ -1180,7 +1178,8 @@
 
 	printk( "%s", name_resume );
 	if(resume_status == NORESUME) {
-		/* FIXME: Signature should be restored here */
+		if(resume_file[0])
+			read_suspend_image(resume_file, 1);
 		printk( "disabled\n" );
 		return;
 	}
@@ -1190,12 +1189,12 @@
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
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
