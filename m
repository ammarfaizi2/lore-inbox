Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310254AbSCGKBL>; Thu, 7 Mar 2002 05:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310257AbSCGKA4>; Thu, 7 Mar 2002 05:00:56 -0500
Received: from postfix1-2.free.fr ([213.228.0.130]:57547 "EHLO
	postfix1-2.free.fr") by vger.kernel.org with ESMTP
	id <S310254AbSCGKAv>; Thu, 7 Mar 2002 05:00:51 -0500
Message-Id: <200203070954.g279sPl16112@colombe.home.perso>
Date: Thu, 7 Mar 2002 10:54:22 +0100 (CET)
From: fchabaud@free.fr
Reply-To: fchabaud@free.fr
Subject: Re: swsusp is at it... again
To: pavel@suse.cz
Cc: linux-kernel@vger.kernel.org, swsusp@lister.fornax.hu
In-Reply-To: <20020305205940.GE318@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: MULTIPART/mixed; BOUNDARY="-1463810814-846930886-1015494872=:7647"
Content-Transfer-Encoding: BINARY
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---1463810814-846930886-1015494872=:7647
Content-Type: TEXT/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Le  5 Mar, Pavel Machek a écrit :
> Hi!
> 
>> > After about 20 resume cycles (compiled kernel with swsusp making
>> > machine suspend/resume) I got that nasty FS corruption, again.
>> > 
>> > So... 
>> > 
>> > 1) Maybe your ext3 patches are not at fault.
>> 
>> I suspect all this come from suspension failure and immediate resume. I
>> have reenabled your panic ! I believe that if a task isn't stopped
> 
> Okay, I think I can try that. [Do you think you can send me your diffs
> to ext3?]

I attach my diff with your patch that I applied on 2.4.18.

> 
>> I also made a modification in stopping task to stop normal task and then
>> kernel threads (I had to add a new PF_KERNTHREAD flag). Perhaps the bug
>> has to do with the *order* of stopping processes (I think of that
>> because kernel messages are written to log files: what happens if
>> kjournald thread is stopped and a task still writes ?)
> 
> Nothing that bad should happen... kjournald is only _delayed_ right?
> And it could be delayed by scheduling as well.

Actually, I'm not sure that so simple. I have passed hours trying to
figure out exactly what's happening but I'm not confident with that
assumption. All transactions in journal have an expiration time based on
jiffies and I'm not sure jiffies are correctly resumed, are they ? Maybe
this expiration of transaction is handled in a way that is not
inocuitous in our context.

> 
>> > 2) Be carefull using swsusp patch. Real carefull.
>> > 
>> > 3) Don't trust fsck. At this kind of corruption, e2fsck 1.19 will
>> > report "clean" but will not repair it, putting your fs into
>> > self-destruct mode. Bad bad. Its fixed on new versions. Always run
>> > fsck twice, second time with -f.
>> 
>> tune2fs -e panic 
>> is also a good precaution at least for ext3 filesystems because all my
>> root inode crashes were preceded by ext3-error messages and these
>> messages were sometimes several hours before effective crash. 
> 
> Yes.

Unfortunately not sufficient at least in my last crash. The good point
is that this time, I had to reinstall, so the filesystem should now be
clean: no trace of ancient crashes should remain ;-)

Last but not least I won't be able to work on swsusp for a while due to
other priorities :-(


--
Florent Chabaud
http://www.ssi.gouv.fr | http://fchabaud.free.fr

---1463810814-846930886-1015494872=:7647
Content-Type: TEXT/plain; name=pavel
Content-Disposition: attachment; filename=pavel

Index: linux/arch/i386/kernel/apm.c
diff -u linux/arch/i386/kernel/apm.c:1.1.1.3 linux/arch/i386/kernel/apm.c:1.1.1.1.2.1.2.2
--- linux/arch/i386/kernel/apm.c:1.1.1.3	Thu Mar  7 10:27:07 2002
+++ linux/arch/i386/kernel/apm.c	Thu Mar  7 10:10:22 2002
@@ -221,6 +221,7 @@
 #include <asm/desc.h>
 
 #include <linux/sysrq.h>
+#include <linux/suspend.h>
 
 extern unsigned long get_cmos_time(void);
 extern void machine_real_restart(unsigned char *, int);
@@ -1229,11 +1230,25 @@
 {
 	int	err;
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	/* If swsusp isn't enabled for some reason, may as well
+	 * fall back to standard APM method */
+	if (!software_suspend_enabled) {
+#endif
 	/* If needed, notify drivers here */
 	get_time_diff();
 	err = apm_set_power_state(APM_STATE_STANDBY);
 	if ((err != APM_SUCCESS) && (err != APM_NO_ERROR))
 		apm_error("standby", err);
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	} else {
+		/* XXX Is this safe? What if it's due to a user-suspend?
+		XXX Well it seems to work for me -- jsh */
+		if (apm_info.connection_version > 0x100)
+			apm_set_power_state(APM_STATE_REJECT);
+		software_suspend ();
+	}
+#endif
 }
 
 static apm_event_t get_event(void)
@@ -1579,7 +1594,9 @@
 	int		percentage     = -1;
 	int             time_units     = -1;
 	char            *units         = "?";
-
+	static int 	oldpercentage  = -1;
+	static unsigned short old_ac_status = 0xff;
+ 
 	p = buf;
 
 	if ((smp_num_cpus == 1) &&
@@ -1635,6 +1652,51 @@
 	      -1: Unknown
 	   8) min = minutes; sec = seconds */
 
+	/* old_ac_status is the state of a control automata. If the state is the same as the returned
+	   status ac_line_status, we check if the percentage value behaves in a coherent way. If not
+	   we warn by a message and change the state. If the state is not the same, we check if the
+	   percentage value is still coherent. If so, we correct the buggy values that were returned.
+	   If the BIOS is not buggy, this automata will change its state only after a change of the
+	   read percentage value. */
+	if(ac_line_status) {	/* we should be charging */
+	  	if(old_ac_status && (oldpercentage > percentage)) {
+	  		printk(KERN_INFO "apm: Buggy BIOS : battery is discharging, assuming AC off line\n");
+			old_ac_status = 0xf00; /* I want a non zero value because 
+						  there is a change in state */
+		}
+		if((!(old_ac_status & 0xff)) && (oldpercentage >= percentage)) { /* still discharging */
+			ac_line_status = 0x00;
+			if(battery_status == 0x03) /* if charging */
+			  battery_status = 0x00; /* assuming high */
+			battery_flag &= ~0x08; /* !charging */
+		}
+	} else {		/* we should be discharging */
+	  	if((!old_ac_status) && (oldpercentage < percentage)) {
+	  		printk(KERN_INFO "apm: Buggy BIOS : battery is charging, assuming AC on line\n");
+			old_ac_status = 0xff; /* I want a non 0x01 value because there is a change in state */
+		}
+		if(old_ac_status && (oldpercentage <= percentage)) { /* still charging */
+			ac_line_status = 0x01;
+			battery_flag |=  0x08; /* !charging */
+		}
+	}
+	if(ac_line_status != old_ac_status) {
+	  queue_event(APM_POWER_STATUS_CHANGE, NULL);
+	}
+	old_ac_status = ac_line_status;
+
+	/* Some BIOSes send a low battery event below 60% and nothing else at 5% nor before blackout !
+	   For those BIOSes creating events here may help. But we don't want to send too many events so 
+	   we send them only when percentage changes */
+	if((!ac_line_status)
+	   &&(oldpercentage > percentage)
+	   &&(battery_flag & 0x04)
+	   &&(battery_status == 0x02)) {
+	  queue_event(APM_LOW_BATTERY, NULL);
+	}
+	oldpercentage = percentage;
+
+
 	p += sprintf(p, "%s %d.%d 0x%02x 0x%02x 0x%02x 0x%02x %d%% %d %s\n",
 		     driver_version,
 		     (apm_info.bios.version >> 8) & 0xff,
@@ -1665,7 +1727,7 @@
 
 	strcpy(current->comm, "kapmd");
 	current->flags |= PF_IOTHREAD;
-  	sigfillset(&current->blocked);
+	sigfillset(&current->blocked);
 
 	if (apm_info.connection_version == 0) {
 		apm_info.connection_version = apm_info.bios.version;
Index: linux/drivers/char/agp/agpgart_be.c
diff -u linux/drivers/char/agp/agpgart_be.c:1.1.1.2 linux/drivers/char/agp/agpgart_be.c:1.1.1.1.4.1
--- linux/drivers/char/agp/agpgart_be.c:1.1.1.2	Mon Mar  4 20:17:17 2002
+++ linux/drivers/char/agp/agpgart_be.c	Thu Mar  7 10:10:42 2002
@@ -650,11 +650,13 @@
 
 static int agp_generic_suspend(void)
 {
+  	printk(KERN_WARNING "Suspending agp\n");
 	return 0;
 }
 
 static void agp_generic_resume(void)
 {
+  	printk(KERN_WARNING "Resuming agp\n");
 	return;
 }
 
@@ -1091,6 +1093,8 @@
 	return addr | agp_bridge.masks[type].mask;
 }
 
+static void intel_resume(void);
+
 static int __init intel_i810_setup(struct pci_dev *i810_dev)
 {
 	intel_i810_private.i810_dev = i810_dev;
@@ -1118,7 +1122,7 @@
 	agp_bridge.agp_alloc_page = agp_generic_alloc_page;
 	agp_bridge.agp_destroy_page = agp_generic_destroy_page;
 	agp_bridge.suspend = agp_generic_suspend;
-	agp_bridge.resume = agp_generic_resume;
+	agp_bridge.resume = intel_resume;
 	agp_bridge.cant_use_aperture = 0;
 
 	return 0;
@@ -1749,7 +1753,6 @@
 	return 0;
 }
 
-
 static unsigned long intel_mask_memory(unsigned long addr, int type)
 {
 	/* Memory type is ignored */
@@ -4219,8 +4222,10 @@
 	switch(rq)
 	{
 		case PM_SUSPEND:
+		    	printk(KERN_WARNING "Suspending power agp\n");
 			return agp_bridge.suspend();
 		case PM_RESUME:
+		    	printk(KERN_WARNING "Resuming power agp\n");
 			agp_bridge.resume();
 			return 0;
 	}		
Index: linux/fs/buffer.c
diff -u linux/fs/buffer.c:1.1.1.3 linux/fs/buffer.c:1.1.1.1.2.1.2.2
--- linux/fs/buffer.c:1.1.1.3	Thu Mar  7 10:29:46 2002
+++ linux/fs/buffer.c	Thu Mar  7 10:11:23 2002
@@ -2986,14 +2986,14 @@
 	spin_unlock_irq(&tsk->sigmask_lock);
 
 	complete((struct completion *)startup);
-
+	current->flags |= PF_KERNTHREAD;
 	for (;;) {
 		wait_for_some_buffers(NODEV);
 
 		/* update interval */
 		interval = bdf_prm.b_un.interval;
 		if (current->flags & PF_FREEZE)
-			refrigerator();
+			refrigerator(PF_IOTHREAD);
 		if (interval) {
 			tsk->state = TASK_INTERRUPTIBLE;
 			schedule_timeout(interval);
Index: linux/fs/jbd/journal.c
diff -u linux/fs/jbd/journal.c:1.1.1.2 linux/fs/jbd/journal.c:1.1.1.1.4.2
--- linux/fs/jbd/journal.c:1.1.1.2	Mon Mar  4 20:18:55 2002
+++ linux/fs/jbd/journal.c	Thu Mar  7 10:11:28 2002
@@ -34,6 +34,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 #include <asm/uaccess.h>
 #include <linux/proc_fs.h>
 
@@ -226,6 +227,7 @@
 			journal->j_commit_interval / HZ);
 	list_add(&journal->j_all_journals, &all_journals);
 
+	current->flags |= PF_KERNTHREAD;
 	/* And now, wait forever for commit wakeup events. */
 	while (1) {
 		if (journal->j_flags & JFS_UNMOUNT)
@@ -246,7 +248,16 @@
 		}
 
 		wake_up(&journal->j_wait_done_commit);
-		interruptible_sleep_on(&journal->j_wait_commit);
+
+		if (current->flags & PF_FREEZE) { /* The simpler the better. Flushing journal isn't a
+						     good idea, because that depends on threads that
+						     may be already stopped. */
+			jbd_debug(1, "Now suspending kjournald\n");
+			refrigerator(PF_IOTHREAD);
+			jbd_debug(1, "Resuming kjournald\n");						
+		} else		/* we assume on resume that commits are already there,
+				   so we don't sleep */
+			interruptible_sleep_on(&journal->j_wait_commit);
 
 		jbd_debug(1, "kjournald wakes\n");
 
Index: linux/fs/jbd/transaction.c
diff -u linux/fs/jbd/transaction.c:1.1.1.2 linux/fs/jbd/transaction.c:1.1.1.1.4.1
--- linux/fs/jbd/transaction.c:1.1.1.2	Mon Mar  4 20:18:55 2002
+++ linux/fs/jbd/transaction.c	Thu Mar  7 10:11:28 2002
@@ -1408,8 +1408,8 @@
 		 * anything to disk. */
 		tid_t tid = transaction->t_tid;
 		
-		jbd_debug(2, "transaction too old, requesting commit for "
-					"handle %p\n", handle);
+		jbd_debug(2, "transaction %d too old, requesting commit for "
+					"handle %p\n", tid, handle);
 		/* This is non-blocking */
 		log_start_commit(journal, transaction);
 		
Index: linux/fs/reiserfs/journal.c
diff -u linux/fs/reiserfs/journal.c:1.1.1.2 linux/fs/reiserfs/journal.c:1.1.1.1.4.2
--- linux/fs/reiserfs/journal.c:1.1.1.2	Mon Mar  4 20:19:04 2002
+++ linux/fs/reiserfs/journal.c	Thu Mar  7 10:11:30 2002
@@ -58,6 +58,7 @@
 #include <linux/stat.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
+#include <linux/suspend.h>
 
 /* the number of mounted filesystems.  This is used to decide when to
 ** start and kill the commit thread
@@ -1835,6 +1836,7 @@
   spin_unlock_irq(&current->sigmask_lock);
 
   sprintf(current->comm, "kreiserfsd") ;
+  current->flags |= PF_KERNTHREAD;
   lock_kernel() ;
   while(1) {
 
@@ -1847,6 +1849,8 @@
       run_task_queue(&reiserfs_commit_thread_tq) ;
       break ;
     }
+    if (current->flags & PF_FREEZE)
+      refrigerator(PF_IOTHREAD);
     wake_up(&reiserfs_commit_thread_done) ;
     interruptible_sleep_on_timeout(&reiserfs_commit_thread_wait, 5 * HZ) ;
   }
Index: linux/include/asm-i386/suspend.h
diff -u linux/include/asm-i386/suspend.h:1.1.1.1 linux/include/asm-i386/suspend.h:1.1.2.1.2.1
--- linux/include/asm-i386/suspend.h:1.1.1.1	Thu Mar  7 10:30:43 2002
+++ linux/include/asm-i386/suspend.h	Thu Mar  7 10:11:34 2002
@@ -260,9 +260,9 @@
 	if (!resume) {
 		do_magic_suspend_1();
 		save_processor_context();	/* We need to capture registers and memory at "same time" */
-		do_magic_suspend_2();
-		restore_processor_context();
-		return;
+		do_magic_suspend_2(); /* We should never return from here except when suspension fails */
+		/*restore_processor_context();
+		return;*/
 	}
 
 	/* We want to run from swapper_pg_dir, since swapper_pg_dir is stored in constant
Index: linux/include/linux/sched.h
diff -u linux/include/linux/sched.h:1.1.1.2 linux/include/linux/sched.h:1.1.1.1.2.1.2.1
--- linux/include/linux/sched.h:1.1.1.2	Thu Mar  7 10:31:59 2002
+++ linux/include/linux/sched.h	Thu Mar  7 10:11:43 2002
@@ -430,6 +430,7 @@
 #define PF_FROZEN	0x00008000	/* frozen for system suspend */
 #define PF_FREEZE	0x00010000	/* this task should be frozen for suspend */
 #define PF_IOTHREAD	0x00020000	/* this thread is needed for doing I/O to swap */
+#define PF_KERNTHREAD	0x00040000	/* this thread is a kernel thread that cannot be sent signals to */
 
 #define PF_USEDFPU	0x00100000	/* task used FPU this quantum (SMP) */
 
Index: linux/include/linux/suspend.h
diff -u linux/include/linux/suspend.h:1.1.1.1 linux/include/linux/suspend.h:1.1.2.1.2.2
--- linux/include/linux/suspend.h:1.1.1.1	Thu Mar  7 10:32:05 2002
+++ linux/include/linux/suspend.h	Thu Mar  7 10:11:44 2002
@@ -45,20 +45,21 @@
 /* mm/vmscan.c */
 extern int shrink_mem(void);
 
-/* kernel/swsusp.c */
+/* kernel/suspend.c */
 extern void software_suspend(void);
 extern void software_resume(void);
 extern int resume_setup(char *str);
 
 extern int register_suspend_notifier(struct notifier_block *);
 extern int unregister_suspend_notifier(struct notifier_block *);
-extern void refrigerator(void);
+extern void refrigerator(unsigned long);
+
 #else
 #define software_suspend()		do { } while(0)
 #define software_resume()		do { } while(0)
 #define register_suspend_notifier(a)	do { } while(0)
 #define unregister_suspend_notifier(a)	do { } while(0)
-#define refrigerator()			do { BUG(); } while(0)
+#define refrigerator(a)			do { BUG(); } while(0)
 #endif
 
 #endif /* _LINUX_SWSUSP_H */
Index: linux/kernel/suspend.c
diff -u linux/kernel/suspend.c:1.1.1.1 linux/kernel/suspend.c:1.1.2.1.2.2
--- linux/kernel/suspend.c:1.1.1.1	Thu Mar  7 10:32:18 2002
+++ linux/kernel/suspend.c	Thu Mar  7 10:11:46 2002
@@ -78,7 +78,10 @@
 #include <linux/major.h>
 #include <linux/blk.h>
 #include <linux/swap.h>
-
+#include <linux/pm.h>
+#ifdef CONFIG_APM
+# include <linux/apm_bios.h>
+#endif
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
@@ -95,7 +98,8 @@
 #undef SUSPEND_CONSOLE
 #endif
 
-#define TIMEOUT	(6 * HZ)			/* Timeout for stopping processes */
+#define TIMEOUT	(12 * HZ)			/* Timeout for stopping processes (flushing ext3 journal
+						   may take a while */
 #define ADDRESS(x) ((unsigned long) phys_to_virt(((x) << PAGE_SHIFT)))
 
 extern void wakeup_bdflush(void);
@@ -129,6 +133,8 @@
 /* Local variables that should not be affected by save */
 static unsigned int nr_copy_pages __nosavedata = 0;
 
+static int pm_suspend_state = 0;
+
 /* Suspend pagedir is allocated before final copy, therefore it
    must be freed after resume 
 
@@ -167,7 +173,8 @@
 /*
  * Debug
  */
-#define	DEBUG_DEFAULT	1
+/*#define	DEBUG_DEFAULT	1*/
+#undef  DEBUG_DEFAULT
 #undef	DEBUG_PROCESS
 #undef	DEBUG_SLOW
 
@@ -197,16 +204,28 @@
  */
 
 #define INTERESTING(p) \
-			/* We don't want to touch kernel_threads..*/ \
 			if (p->flags & PF_IOTHREAD) \
 				continue; \
+			/* We don't want to touch kernel_threads on first pass...*/ \
+			if (p->flags & PF_KERNTHREAD) \
+				continue; \
 			if (p == current) \
 				continue; \
 			if (p->state == TASK_ZOMBIE) \
 				continue;
+#define INTERESTING_FORCE(p) \
+			if (p->flags & PF_IOTHREAD) \
+				continue; \
+			/* We want to touch *only* kernel_threads on second pass...*/ \
+			if (!(p->flags & PF_KERNTHREAD)) \
+				continue; \
+			if (p == current) \
+				continue; \
+			if (p->state == TASK_ZOMBIE) \
+				continue;
 
 /* Refrigerator is place where frozen processes are stored :-). */
-void refrigerator(void)
+void refrigerator(unsigned long flag)
 {
 	/* You need correct to work with real-time processes.
 	   OTOH, this way one process may see (via /proc/) some other
@@ -216,32 +235,44 @@
 	long save;
 	save = current->state;
 	current->state = TASK_STOPPED;
-//	PRINTK("%s entered refrigerator\n", current->comm);
+	//PRINTK("%s entered refrigerator (%x)\n", current->comm, flag);
 	printk(":");
 	current->flags &= ~PF_FREEZE;
+				/* kernel threads like journal, swap or update
+				   must not be wake up on resume */
+	if(flag)
+		flush_signals(current); /* We have signaled a kernel thread, which isn't normal behaviour
+					   and that may lead to 100%CPU sucking because those threads
+					   just don't manage signals. */
+
 	current->flags |= PF_FROZEN;
 	while (current->flags & PF_FROZEN)
 		schedule();
-//	PRINTK("%s left refrigerator\n", current->comm);
+	//PRINTK("%s left refrigerator (%x)\n", current->comm, flag);
 	printk(":");
 	current->state = save;
 }
 
 /* 0 = success, else # of processes that we failed to stop */
-static int freeze_processes(void)
+static int freeze_processes(int force)
 {
 	int todo, start_time;
 	struct task_struct *p;
-	
-	PRINTS( "Waiting for tasks to stop... " );
-	
+	if(force)
+	  PRINTS( "Waiting for kernel threads to stop... " );
+	else
+	  PRINTS( "Waiting for tasks to stop... " );
 	start_time = jiffies;
 	do {
 		todo = 0;
 		read_lock(&tasklist_lock);
 		for_each_task(p) {
 			unsigned long flags;
-			INTERESTING(p);
+			if(force) { /* we now deal with kernel threads */
+				INTERESTING_FORCE(p);
+			} else {
+				INTERESTING(p);
+			}
 			if (p->flags & PF_FROZEN)
 				continue;
 
@@ -267,19 +298,34 @@
 	return 0;
 }
 
-static void thaw_processes(void)
+static void thaw_processes(int force)
 {
 	struct task_struct *p;
 
-	PRINTR( "Restarting tasks..." );
+	if(force)
+	  PRINTR( "Restarting kernel threads..." );
+	else
+	  PRINTR( "Restarting tasks..." );
 	read_lock(&tasklist_lock);
 	for_each_task(p) {
-		INTERESTING(p);
+		if(force) { /* we first deal with kernel threads */
+			INTERESTING_FORCE(p);			
+		} else {
+			INTERESTING(p);
+		}		
 		
 		if (p->flags & PF_FROZEN) p->flags &= ~PF_FROZEN;
 		else
 			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
-		wake_up_process(p);
+		
+				/* Those are kernel threads like kswapd,
+				   kjournald, kupdated. They are forced into
+				   refrigerator with a specific flag.
+				   All special stuff can be done here if necessary. */
+		if (p->flags & PF_KERNTHREAD) {	/* first the kernell threads */
+		  wake_up_process(p);
+		} else if(!force) /* second the other tasks */
+		  wake_up_process(p);
 	}
 	read_unlock(&tasklist_lock);
 	PRINTK( " done\n" );
@@ -613,10 +659,21 @@
 {
 	PRINTS( "Stopping processes\n" );
 	MDELAY(1000);
-	if (freeze_processes()) {
+	if (freeze_processes(0)) {
 		PRINTS( "Not all processes stopped!\n" );
-//		panic("Some processes survived?\n");
-		thaw_processes();
+#if 0
+		panic("Some processes survived?\n");
+#endif
+		thaw_processes(0);
+		return 1;
+	}
+	if (freeze_processes(1)) {
+		PRINTS( "Not all kernel threads stopped!\n" );
+#if 0 && CONFIG_JBD		/* ext3 doesn't like *at all* to be resumed from an unsuspended state */
+		panic("Some kernel threads survived?\n");
+#endif
+		thaw_processes(1);
+		thaw_processes(0);
 		return 1;
 	}
 	do_suspend_sync();
@@ -639,15 +696,19 @@
 		memset(m, 0, PAGE_SIZE);
 		eaten_memory = m;
 		if (!(i%100))
-			printk( ".(%d)", i ); 
+#if DEBUG_DEFAULT
+			printk( "(%d)", i );
+#else
+			printk( ".", i );
+#endif
 		*eaten_memory = c;
 		c = eaten_memory;
 		i++; 
-#if 1
+#if 0
 	/* 40000 == 160MB */
 	/* 10000 for 64MB */
 	/* 2500 for  16MB */
-		if (i > 40000)
+		if (i > 5000)
 			break;
 #endif
 	}
@@ -678,7 +739,7 @@
  */
 static void free_some_memory(void)
 {
-#if 1
+#if 0
 	PRINTS("Freeing memory: ");
 	while (try_to_free_pages(&contig_page_data.node_zones[ZONE_HIGHMEM], GFP_KSWAPD, 0))
 		printk(".");
@@ -690,6 +751,64 @@
 #endif
 }
 
+/* Make disk drivers accept operations, again */
+static void drivers_unsuspend(void)
+{
+#ifdef CONFIG_BLK_DEV_IDE
+	ide_disk_unsuspend();
+#endif
+}
+
+/* Called from process context */
+static int drivers_suspend(void)
+{
+#ifdef CONFIG_BLK_DEV_IDE
+	ide_disk_suspend();
+#else
+#error Are you sure your disk driver supports suspend?
+#endif
+	if(!pm_suspend_state) {
+		if(pm_send_all(PM_SUSPEND,(void *)3)) {
+			printk(KERN_WARNING "Problem while sending suspend event\n");
+			return(1);
+		}
+		pm_suspend_state=1;
+	} else
+		printk(KERN_WARNING "PM suspend state already raised\n");
+	  
+	return(0);
+}
+
+/* Called from interrupts disabled */
+#define RESUME_PHASE1 1
+#define RESUME_PHASE2 2
+#define RESUME_ALL_PHASES (RESUME_PHASE1 | RESUME_PHASE2)
+static void drivers_resume(int flags)
+{
+  	if(flags & RESUME_PHASE2) {
+#ifdef CONFIG_BLK_DEV_HD
+		do_reset_hd();			/* Kill all controller state */
+#endif
+	}
+  	if(flags & RESUME_PHASE1) {
+#ifdef CONFIG_BLK_DEV_IDE
+		ide_disk_resume();
+#endif
+	}
+  	if(flags & RESUME_PHASE2) {
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
+
 static int suspend_save_image(void)
 {
 	struct sysinfo i;
@@ -704,7 +823,6 @@
 	if(nr_free_pages() < nr_needed_pages) {
 		printk(KERN_CRIT "%sCouldn't get enough free pages, on %d pages short\n",
 		       name_suspend, nr_needed_pages-nr_free_pages());
-		panic("Not enough free pages");
 		spin_unlock_irq(&suspend_pagedir_lock);
 		return 1;
 	}
@@ -712,7 +830,6 @@
 	if (i.freeswap < nr_needed_pages)  {
 		printk(KERN_CRIT "%sThere's not enough swap space available, on %ld pages short\n",
 		       name_suspend, nr_needed_pages-i.freeswap);
-		panic("Not enough swap space");
 		spin_unlock_irq(&suspend_pagedir_lock);
 		return 1;
 	}
@@ -740,9 +857,7 @@
 	 * Following line enforces not writing to disk until we choose.
 	 */
 	suspend_device = -1;					/* We do not want any writes, thanx */
-#ifdef CONFIG_BLK_DEV_IDE
-	ide_disk_unsuspend();
-#endif
+	drivers_unsuspend();
 	spin_unlock_irq(&suspend_pagedir_lock);
 	PRINTS( "critical section/: done (%d pages copied)\n", nr_copy_pages );
 
@@ -822,12 +937,7 @@
 	PRINTR( "Freeing prev allocated pagedir\n" );
 	free_suspend_pagedir(pagedir_save);
 	__flush_tlb_global();		/* Even mappings of "global" things (vmalloc) need to be fixed */
-#ifdef CONFIG_BLK_DEV_HD
-	do_reset_hd();			/* Kill all controller state */
-#endif
-#ifdef CONFIG_BLK_DEV_IDE
-	ide_disk_resume();
-#endif
+	drivers_resume(RESUME_ALL_PHASES);
 	spin_unlock_irq(&suspend_pagedir_lock);
 
 	PRINTK( "Fixing swap signatures... " );
@@ -862,27 +972,24 @@
 	}
 
 	suspend_device = 0;
-	printk(KERN_WARNING "%sSuspend failed, trying to continue recover\n", name_suspend);
+	printk(KERN_WARNING "%sSuspend failed, trying to recover...\n", name_suspend);
 	MDELAY(1000); /* So user can wait and report us messages if armageddon comes :-) */
 
-	panic("Suspend failed");
 	barrier();
 	mb();
 	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
 	mdelay(1000);
 
 	free_pages((unsigned long) pagedir_nosave, pagedir_order);
+	drivers_resume(RESUME_PHASE2); /* already unsuspended (equivalent to PHASE1) */
 	spin_unlock_irq(&suspend_pagedir_lock);
 	swapfile_used[0] = 1;		/* FIXME: Of course, swapfile_used can not survive suspend: It is initialized *after*
 					   copy :-( */
 	/* FIXME: this means that you have to do _just one_ swapon */
 	mark_swapfiles(((swp_entry_t) {0}), 2, 0);
 
-#ifdef SUSPEND_CONSOLE
-	update_screen(fg_console);	/* Hmm, is this the problem? */
-#endif
 	suspend_tq.routine = (void *)do_software_suspend;
-
+	printk(KERN_WARNING "%sLeaving do_magic_suspend_2...\n", name_suspend);	
 }
 
 #define SUSPEND_C
@@ -911,14 +1018,11 @@
 #if 0
 			schedule_timeout(1*HZ);	/* Is this needed to get data properly to disk? */
 #endif
-#ifdef CONFIG_BLK_DEV_IDE
-			ide_disk_suspend();
-#else
-#error Are you sure your disk driver supports suspend?
-#endif
-			do_magic(0);			/* This function returns after machine woken up from resume */
+			if(drivers_suspend()==0)
+			  do_magic(0);			/* This function returns after machine woken up from resume */
 			PRINTR("Restarting processes...\n");
-			thaw_processes();
+			thaw_processes(1);
+			thaw_processes(0);
 		}
 	}
 	software_suspend_enabled = 1;
@@ -1260,7 +1364,6 @@
 	printk( "resuming from %s\n", resume_file);
 	if(resume_try_to_read(resume_file))
 		goto read_failure;
-
 	do_magic(1);
 	panic("This never returns");
 
@@ -1284,7 +1387,8 @@
 static int __init software_noresume(char *str)
 {
 	if(!resume_status)
-		resume_status = NORESUME;
+	  printk(KERN_WARNING "noresume option has overridden a resume= option\n");
+	resume_status = NORESUME;
 	
 	return 1;
 }
Index: linux/mm/page_alloc.c
diff -u linux/mm/page_alloc.c:1.1.1.3 linux/mm/page_alloc.c:1.1.1.1.2.1.2.1
--- linux/mm/page_alloc.c:1.1.1.3	Thu Mar  7 10:32:21 2002
+++ linux/mm/page_alloc.c	Thu Mar  7 10:11:46 2002
@@ -355,7 +355,9 @@
 	zone_t **zone, * classzone;
 	struct page * page;
 	int freed;
-
+#if CONFIG_SOFTWARE_SUSPEND
+	static unsigned int loopcount;
+#endif	
 	zone = zonelist->zones;
 	classzone = *zone;
 	min = 1UL << order;
@@ -397,8 +399,20 @@
 	}
 
 	/* here we're in the low on memory slow path */
-
+#if CONFIG_SOFTWARE_SUSPEND
+	loopcount=0;
+#endif
 rebalance:
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	loopcount++;		/* when using memeat, we ask for all pages that are really free.
+				   1000 calls to reschedule should be sufficient to recall all of them since
+				   when a page can be found, it is after only one reschedule.
+				   Actually I consider this as a bug of alloc_pages, since allocating a
+				   page should not hang in an endless loop when it is clear that no
+				   memory is available (cbd) */
+	if((order == 0)&&(loopcount > 1000))
+	  return NULL;
+#endif
 	if (current->flags & (PF_MEMALLOC | PF_MEMDIE)) {
 		zone = zonelist->zones;
 		for (;;) {
Index: linux/mm/vmscan.c
diff -u linux/mm/vmscan.c:1.1.1.3 linux/mm/vmscan.c:1.1.1.1.2.1.2.2
--- linux/mm/vmscan.c:1.1.1.3	Thu Mar  7 10:32:21 2002
+++ linux/mm/vmscan.c	Thu Mar  7 10:11:46 2002
@@ -724,18 +724,19 @@
 	 * trying to free the first piece of memory in the first place).
 	 */
 	tsk->flags |= PF_MEMALLOC;
+	tsk->flags |= PF_KERNTHREAD;
 
 	/*
 	 * Kswapd main loop.
 	 */
 	for (;;) {
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_IOTHREAD);
 		__set_current_state(TASK_INTERRUPTIBLE);
 		add_wait_queue(&kswapd_wait, &wait);
 
 		mb();
 		if (kswapd_can_sleep()) {
-			if (current->flags & PF_FREEZE)
-				refrigerator();
 			schedule();
 		}
 		

---1463810814-846930886-1015494872=:7647--
