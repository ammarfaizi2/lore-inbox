Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317022AbSEWVws>; Thu, 23 May 2002 17:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317023AbSEWVwr>; Thu, 23 May 2002 17:52:47 -0400
Received: from [195.39.17.254] ([195.39.17.254]:30875 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317022AbSEWVwl>;
	Thu, 23 May 2002 17:52:41 -0400
Date: Thu, 23 May 2002 23:45:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: swsusp cleanups
Message-ID: <20020523214543.GA695@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

These are cleanups. They do not change any code, except killing
printk's. Please apply.
								Pavel

--- linux-swsusp.linus/Documentation/swsusp.txt	Wed May 22 21:12:16 2002
+++ linux-swsusp/Documentation/swsusp.txt	Wed May 22 10:49:32 2002
@@ -138,7 +138,6 @@
 Not so important ideas for implementing
 
 - If a real time process is running then don't suspend the machine.
-- Is there any sense in compressing the outwritten pages?
 - Support for power.conf file as in Solaris, autoshutdown, special
   devicetypes support, maybe in sysctl.
 - Introduce timeout for SMP locking. But first locking ought to work :O
--- linux-swsusp.linus/arch/i386/kernel/acpi_wakeup.S	Wed May 22 21:12:16 2002
+++ linux-swsusp/arch/i386/kernel/acpi_wakeup.S	Wed May 22 23:22:53 2002
@@ -17,11 +17,6 @@
 	cli
 	cld
 	  
-# setup video mode
-#	movw	$0x4117, %bx		# 0x4000 for linear framebuffer
-#	movw	$0x4f02, %ax
-#	int	$0x10
-
 	# setup data segment
 	movw	%cs, %ax
 
--- linux-swsusp.linus/drivers/acpi/acpi_system.c	Wed May 22 21:12:16 2002
+++ linux-swsusp/drivers/acpi/acpi_system.c	Wed May 22 21:16:32 2002
@@ -271,11 +272,9 @@
 		break;
 	}
 
-	printk("acpi_restore_register_state...");
 	acpi_restore_register_state();
 	restore_flags(flags);
 
-	printk("acpi returning...");
 	return status;
 }
 
@@ -322,9 +321,7 @@
 	 * no matter what.
 	 */
 	acpi_system_restore_state(state);
-	printk("acpi_leave_sleep_state...");
 	acpi_leave_sleep_state(state);
-	printk("ook\n");
 
 	/* make sure interrupts are enabled */
 	ACPI_ENABLE_IRQS();
--- linux-swsusp.linus/drivers/pci/power.c	Wed May 22 21:12:16 2002
+++ linux-swsusp/drivers/pci/power.c	Wed May 22 21:19:46 2002
@@ -110,7 +110,7 @@
 	return error;
 }
 
-int pci_pm_suspend(u32 state)
+static int pci_pm_suspend(u32 state)
 {
 	struct list_head *list;
 	struct pci_bus *bus;
@@ -123,7 +123,7 @@
 	return 0;
 }
 
-int pci_pm_resume(void)
+static int pci_pm_resume(void)
 {
 	struct list_head *list;
 	struct pci_bus *bus;
--- linux-swsusp.linus/include/asm-i386/suspend.h	Wed May 22 21:12:17 2002
+++ linux-swsusp/include/asm-i386/suspend.h	Wed May 22 23:26:51 2002
@@ -209,15 +209,12 @@
 
 	/*
 	 * now restore the descriptor tables to their proper values
+	 * ltr is done i fix_processor_context().
 	 */
 	asm volatile ("lgdt (%0)" :: "m" (saved_context.gdt_limit));
 	asm volatile ("lidt (%0)" :: "m" (saved_context.idt_limit));
 	asm volatile ("lldt (%0)" :: "m" (saved_context.ldt));
 
-#if 0
-	asm volatile ("ltr (%0)"  :: "m" (saved_context.tr));
-#endif
-
 	fix_processor_context();
 
 	/*
@@ -230,7 +227,6 @@
 
 #endif
 #ifdef SUSPEND_C
-#if 1
 /* Local variables for do_magic */
 static int loop __nosavedata = 0;
 static int loop2 __nosavedata = 0;
@@ -269,36 +265,38 @@
 /*
  * Final function for resuming: after copying the pages to their original
  * position, it restores the register state.
+ *
+ * What about page tables? Writing data pages may toggle
+ * accessed/dirty bits in our page tables. That should be no problems
+ * with 4MB page tables. That's why we require have_pse.  
+ *
+ * This loops destroys stack from under itself, so it better should
+ * not use any stack space, itself. When this function is entered at
+ * resume time, we move stack to _old_ place.  This is means that this
+ * function must use no stack and no local variables in registers,
+ * until calling restore_processor_context();
+ *
+ * Critical section here: noone should touch saved memory after
+ * do_magic_resume_1; copying works, because nr_copy_pages,
+ * pagedir_nosave, loop and loop2 are nosavedata.
  */
-
 	do_magic_resume_1();
 
-	/* Critical section here: noone should touch memory from now */
-	/* This works, because nr_copy_pages, pagedir_nosave, loop and loop2 are nosavedata */
 	for (loop=0; loop < nr_copy_pages; loop++) {
-		/* You may not call something (like copy_page) here:
-		   We may absolutely not use stack at this point */
+		/* You may not call something (like copy_page) here: see above */
 		for (loop2=0; loop2 < PAGE_SIZE; loop2++) {
 			*(((char *)((pagedir_nosave+loop)->orig_address))+loop2) =
 				*(((char *)((pagedir_nosave+loop)->address))+loop2);
 			__flush_tlb();
 		}
 	}
-/* FIXME: What about page tables? Writing data pages may toggle
-   accessed/dirty bits in our page tables. That should be no problems
-   with 4MB page tables. That's why we require have_pse. */
-
-/* Danger: previous loop probably destroyed our current stack. Better hope it did not use
-   any stack space, itself.
-
-   When this function is entered at resume time, we move stack to _old_ place.
-   This is means that this function must use no stack and no local variables in registers.
-*/
+
 	restore_processor_context();
-/* Ahah, we now run with our old stack, and with registers copied from suspend time */
+
+/* Ahah, we now run with our old stack, and with registers copied from
+   suspend time */
 
 	do_magic_resume_2();
 }
-#endif
 #endif 
 
--- linux-swsusp.linus/kernel/suspend.c	Wed May 22 21:12:17 2002
+++ linux-swsusp/kernel/suspend.c	Wed May 22 22:05:48 2002
@@ -11,7 +11,7 @@
  * 
  * Pavel Machek <pavel@ucw.cz>:
  * Modifications, defectiveness pointing, being with me at the very beginning,
- * suspend to swap space, stop all tasks.
+ * suspend to swap space, stop all tasks. Port to 2.4.18-ac and 2.5.17.
  *
  * Steve Doddi <dirk@loth.demon.co.uk>: 
  * Support the possibility of hardware state restoring.
@@ -41,8 +41,6 @@
  * bdflush from this task. (check apm.c for something similar).
  */
 
-/* FIXME: try to poison to memory */
-
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/swapctl.h>
@@ -122,7 +120,7 @@
    Warning: this is evil. There are actually two pagedirs at time of
    resume. One is "pagedir_save", which is empty frame allocated at
    time of suspend, that must be freed. Second is "pagedir_nosave", 
-   allocated at time of resume, that travells through memory not to
+   allocated at time of resume, that travels through memory not to
    collide with anything.
  */
 static suspend_pagedir_t *pagedir_nosave __nosavedata = NULL;
@@ -143,8 +141,6 @@
 /*
  * XXX: We try to keep some more pages free so that I/O operations succeed
  * without paging. Might this be more?
- *
- * [If this is not enough, might it corrupt our data silently?]
  */
 #define PAGES_FOR_IO	512
 
@@ -310,7 +306,6 @@
 
 static void do_suspend_sync(void)
 {
-//	sync_dev(0); FIXME
 	while (1) {
 		run_task_queue(&tq_disk);
 		if (!TQ_ACTIVE(tq_disk))
@@ -640,7 +633,6 @@
 	MDELAY(1000);
 	if (freeze_processes()) {
 		PRINTS( "Not all processes stopped!\n" );
-//		panic("Some processes survived?\n");
 		thaw_processes();
 		return 1;
 	}
@@ -649,70 +641,16 @@
 }
 
 /*
- *	Free as much memory as possible
- */
-
-static void **eaten_memory;
-
-static void eat_memory(void)
-{
-	int i = 0;
-	void **c= eaten_memory, *m;
-
-	printk("Eating pages ");
-	while ((m = (void *) get_free_page(GFP_HIGHUSER))) {
-		memset(m, 0, PAGE_SIZE);
-		eaten_memory = m;
-		if (!(i%100))
-			printk( ".(%d)", i ); 
-		*eaten_memory = c;
-		c = eaten_memory;
-		i++; 
-#if 1
-	/* 40000 == 160MB */
-	/* 10000 for 64MB */
-	/* 2500 for  16MB */
-		if (i > 40000)
-			break;
-#endif
-	}
-	printk("(%dK)\n", i*4);
-}
-
-static void free_memory(void)
-{
-	int i = 0;
-	void **c = eaten_memory, *f;
-	
-	printk( "Freeing pages " );
-	while (c) {
-		if (!(i%5000))
-		printk( "." ); 
-		f = *c;
-		c = *c;
-		if (f) { free_page( (long) f ); i++; }
-	}
-	printk( "(%dK)\n", i*4 );
-	eaten_memory = NULL;
-}
-
-/*
  * Try to free as much memory as possible, but do not OOM-kill anyone
  *
  * Notice: all userland should be stopped at this point, or livelock is possible.
  */
 static void free_some_memory(void)
 {
-#if 1
 	PRINTS("Freeing memory: ");
 	while (try_to_free_pages(&contig_page_data.node_zones[ZONE_HIGHMEM], GFP_KSWAPD, 0))
 		printk(".");
 	printk("\n");
-#else
-	printk("Using memeat\n");
-	eat_memory();
-	free_memory();
-#endif
 }
 
 /* Make disk drivers accept operations, again */
@@ -809,7 +747,6 @@
 	 *
 	 * Following line enforces not writing to disk until we choose.
 	 */
-	suspend_device = NODEV;					/* We do not want any writes, thanx */
 	drivers_unsuspend();
 	spin_unlock_irq(&suspend_pagedir_lock);
 	PRINTS( "critical section/: done (%d pages copied)\n", nr_copy_pages );
@@ -991,8 +923,7 @@
 	}
 }
 
-#define does_collide(addr)	\
-		does_collide_order(pagedir_nosave, addr, 0)
+#define does_collide(addr) does_collide_order(pagedir_nosave, addr, 0)
 
 /*
  * Returns true if given address/order collides with any orig_address 
@@ -1015,7 +946,6 @@
  * We check here that pagedir & pages it points to won't collide with pages
  * where we're going to restore from the loaded pages later
  */
-
 static int check_pagedir(void)
 {
 	int i;
@@ -1036,14 +966,13 @@
 
 static int relocate_pagedir(void)
 {
-	/* This is deep magic
-	   We have to avoid recursion (not to overflow kernel stack), and that's why
-	   code looks pretty cryptic
-	*/
+	/*
+	 * We have to avoid recursion (not to overflow kernel stack),
+	 * and that's why code looks pretty cryptic 
+	 */
 	suspend_pagedir_t *new_pagedir, *old_pagedir = pagedir_nosave;
 	void **eaten_memory = NULL;
 	void **c = eaten_memory, *m, *f;
-
 
 	if(!does_collide_order(old_pagedir, (unsigned long)old_pagedir, pagedir_order)) {
 		printk("not neccessary\n");

									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
