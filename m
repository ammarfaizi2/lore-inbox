Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310577AbSCUU1M>; Thu, 21 Mar 2002 15:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312476AbSCUU1E>; Thu, 21 Mar 2002 15:27:04 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:55826 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S310577AbSCUU04>; Thu, 21 Mar 2002 15:26:56 -0500
Date: Thu, 21 Mar 2002 21:25:06 +0100
From: Pavel Machek <pavel@suse.cz>
To: Mark Gross <mgross@unix-os.sc.intel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Daniel Jacobowitz <dan@debian.org>,
        "Vamsi Krishna S ." <vamsi@in.ibm.com>, Pavel Machek <pavel@suse.cz>,
        linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
        tachino@jp.fujitsu.com, jefreyr@pacbell.net, vamsi_krishna@in.ibm.com,
        richardj_moore@uk.ibm.com, hanharat@us.ibm.com, bsuparna@in.ibm.com,
        bharata@in.ibm.com, asit.k.mallick@intel.com, david.p.howell@intel.com,
        tony.luck@intel.com, sunil.saxena@intel.com
Subject: Re: [PATCH] multithreaded coredumps for elf exeecutables
Message-ID: <20020321202506.GB25794@atrey.karlin.mff.cuni.cz>
In-Reply-To: <E16o5o5-0005gM-00@the-village.bc.nu> <200203211707.g2LH7XW10116@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You need interrupts to handle this, even if you don't wrap it in the top
> > layer of signals it will be able to use much of the code I agree. The nasty
> > case is the "currently running on another cpu" one. Especially since you
> > can't just "trap it" - if you IPI that processor it might have moved by the
> > time the IPI arrives 8)
> 
> This why I grabbed all those locks, and did the two sets of IPI's in the 
> tcore patch.  Once the runqueue lock is grabbed, even if that process on the 
> other CPU tries to migrate, it won't get swapped in or looked at by the 
> scheduler until its cpus_allowed member has been marked.   After cpus_allowed 
> has been marked it won't run. 

BTW it would be very nice to put "task freezing" in some generic
place. I have my own version of task freezing (with refrigerator), and
it would be good to be able to share that...

> The only risk with this type of code is if other code or drivers attempt 
> similar maneuvers at the same time.  Having a standard mechanism or API for 
> this in the scheduler would be a "good thing".

Ahha, so you know it, too.

> I've just started considering how to do this with the 2.5 O(1) scheduler, and 
> I'm not sure yet how I can accomplish this process "pausing" behavior just 
> yet.

I'm doing this in my freezer, and it should be safe even on
2.5.X. Most interesting is the part in suspend.c...
								Pavel

--- clean.2.4/arch/i386/kernel/apm.c	Thu Feb 28 11:18:05 2002
+++ linux-swsusp.24/arch/i386/kernel/apm.c	Fri Mar  1 12:44:18 2002
@@ -1664,6 +1664,7 @@
 	daemonize();
 
 	strcpy(current->comm, "kapmd");
+	current->flags |= PF_IOTHREAD;
 	sigfillset(&current->blocked);
 
 	if (apm_info.connection_version == 0) {
--- clean.2.4/arch/i386/kernel/signal.c	Thu Feb 28 11:18:05 2002
+++ linux-swsusp.24/arch/i386/kernel/signal.c	Thu Mar  7 23:17:18 2002
@@ -20,6 +20,7 @@
 #include <linux/stddef.h>
 #include <linux/tty.h>
 #include <linux/personality.h>
+#include <linux/suspend.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/i387.h>
@@ -595,6 +596,11 @@
 	if ((regs->xcs & 3) != 3)
 		return 1;
 
+	if (current->flags & PF_FREEZE) {
+		refrigerator(0);
+		goto no_signal;
+	}
+
 	if (!oldset)
 		oldset = &current->blocked;
 
@@ -705,6 +711,7 @@
 		return 1;
 	}
 
+ no_signal:
 	/* Did we come from a system call? */
 	if (regs->orig_eax >= 0) {
 		/* Restart the system call - no handlers present */
--- clean.2.4/drivers/usb/storage/usb.c	Thu Feb 28 11:18:20 2002
+++ linux-swsusp.24/drivers/usb/storage/usb.c	Fri Mar  1 12:43:11 2002
@@ -316,6 +316,7 @@
 	 */
 	exit_files(current);
 	current->files = init_task.files;
+	current->flags |= PF_IOTHREAD;
 	atomic_inc(&current->files->count);
 	daemonize();
 
--- clean.2.4/fs/buffer.c	Thu Feb 28 11:18:21 2002
+++ linux-swsusp.24/fs/buffer.c	Thu Mar  7 22:51:11 2002
@@ -129,6 +129,8 @@
 		wake_up(&bh->b_wait);
 }
 
+DECLARE_TASK_QUEUE(tq_bdflush);
+
 /*
  * Rewrote the wait-routines to use the "new" wait-queue functionality,
  * and getting rid of the cli-sti pairs. The wait-queue routines still
@@ -2981,12 +2986,14 @@
 	spin_unlock_irq(&tsk->sigmask_lock);
 
 	complete((struct completion *)startup);
-
+	current->flags |= PF_KERNTHREAD;
 	for (;;) {
 		wait_for_some_buffers(NODEV);
 
 		/* update interval */
 		interval = bdf_prm.b_un.interval;
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_IOTHREAD);
 		if (interval) {
 			tsk->state = TASK_INTERRUPTIBLE;
 			schedule_timeout(interval);
--- clean.2.4/fs/jbd/journal.c	Thu Feb 28 11:18:22 2002
+++ linux-swsusp.24/fs/jbd/journal.c	Thu Mar  7 23:13:25 2002
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
@@ -246,7 +248,15 @@
 		}
 
 		wake_up(&journal->j_wait_done_commit);
-		interruptible_sleep_on(&journal->j_wait_commit);
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
 
--- clean.2.4/include/linux/sched.h	Tue Dec 25 22:39:30 2001
+++ linux-swsusp.24/include/linux/sched.h	Thu Mar  7 23:09:25 2002
@@ -427,6 +427,10 @@
 #define PF_MEMDIE	0x00001000	/* Killed for out-of-memory */
 #define PF_FREE_PAGES	0x00002000	/* per process page freeing */
 #define PF_NOIO		0x00004000	/* avoid generating further I/O */
+#define PF_FROZEN	0x00008000	/* frozen for system suspend */
+#define PF_FREEZE	0x00010000	/* this task should be frozen for suspend */
+#define PF_IOTHREAD	0x00020000	/* this thread is needed for doing I/O to swap */
+#define PF_KERNTHREAD	0x00040000	/* this thread is a kernel thread that cannot be sent signals to */
 
 #define PF_USEDFPU	0x00100000	/* task used FPU this quantum (SMP) */
 
--- clean.2.4/kernel/context.c	Thu Oct 11 20:17:22 2001
+++ linux-swsusp.24/kernel/context.c	Tue Feb 19 20:33:23 2002
@@ -72,6 +72,7 @@
 
 	daemonize();
 	strcpy(curtask->comm, "keventd");
+	current->flags |= PF_IOTHREAD;
 	keventd_running = 1;
 	keventd_task = curtask;
 
--- clean.2.4/kernel/signal.c	Wed Dec  5 23:46:07 2001
+++ linux-swsusp.24/kernel/signal.c	Tue Feb 19 20:33:23 2002
@@ -463,7 +463,7 @@
  * No need to set need_resched since signal event passing
  * goes through ->blocked
  */
-static inline void signal_wake_up(struct task_struct *t)
+inline void signal_wake_up(struct task_struct *t)
 {
 	t->sigpending = 1;
 
--- clean.2.4/kernel/softirq.c	Wed Oct 31 19:26:02 2001
+++ linux-swsusp.24/kernel/softirq.c	Tue Feb 19 20:33:23 2002
@@ -366,6 +366,7 @@
 
 	daemonize();
 	current->nice = 19;
+	current->flags |= PF_IOTHREAD;
 	sigfillset(&current->blocked);
 
 	/* Migrate to the right CPU */
--- clean.2.4/kernel/suspend.c	Sun Nov 11 20:26:28 2001
+++ linux-swsusp.24/kernel/suspend.c	Tue Mar 19 13:22:14 2002
@@ -0,0 +1,1373 @@
...
+/*
+ * Refrigerator and related stuff
+ */
+
+#define INTERESTING(p) \
+			/* We don't want to touch kernel_threads..*/ \
+			if (p->flags & PF_IOTHREAD) \
+				continue; \
+			if (p == current) \
+				continue; \
+			if (p->state == TASK_ZOMBIE) \
+				continue;
+
+/* Refrigerator is place where frozen processes are stored :-). */
+void refrigerator(unsigned long flag)
+{
+	/* You need correct to work with real-time processes.
+	   OTOH, this way one process may see (via /proc/) some other
+	   process in stopped state (and thereby discovered we were
+	   suspended. We probably do not care. 
+	 */
+	long save;
+	save = current->state;
+	current->state = TASK_STOPPED;
+//	PRINTK("%s entered refrigerator\n", current->comm);
+	printk(":");
+	current->flags &= ~PF_FREEZE;
+	if (flag)
+		flush_signals(current); /* We have signaled a kernel thread, which isn't normal behaviour
+					   and that may lead to 100%CPU sucking because those threads
+					   just don't manage signals. */
+	current->flags |= PF_FROZEN;
+	while (current->flags & PF_FROZEN)
+		schedule();
+//	PRINTK("%s left refrigerator\n", current->comm);
+	printk(":");
+	current->state = save;
+}
+
+/* 0 = success, else # of processes that we failed to stop */
+static int freeze_processes(void)
+{
+	int todo, start_time;
+	struct task_struct *p;
+	
+	PRINTS( "Waiting for tasks to stop... " );
+	
+	start_time = jiffies;
+	do {
+		todo = 0;
+		read_lock(&tasklist_lock);
+		for_each_task(p) {
+			unsigned long flags;
+			INTERESTING(p);
+			if (p->flags & PF_FROZEN)
+				continue;
+
+			/* FIXME: smp problem here: we may not access other process' flags
+			   without locking */
+			p->flags |= PF_FREEZE;
+			spin_lock_irqsave(&p->sigmask_lock, flags);
+			signal_wake_up(p);
+			spin_unlock_irqrestore(&p->sigmask_lock, flags);
+			todo++;
+		}
+		read_unlock(&tasklist_lock);
+		sys_sched_yield();
+		schedule();
+		if (time_after(jiffies, start_time + TIMEOUT)) {
+			PRINTK( "\n" );
+			printk(KERN_ERR " stopping tasks failed (%d tasks remaining)\n", todo );
+			return todo;
+		}
+	} while(todo);
+	
+	PRINTK( " ok\n" );
+	return 0;
+}
+
+static void thaw_processes(void)
+{
+	struct task_struct *p;
+
+	PRINTR( "Restarting tasks..." );
+	read_lock(&tasklist_lock);
+	for_each_task(p) {
+		INTERESTING(p);
+		
+		if (p->flags & PF_FROZEN) p->flags &= ~PF_FROZEN;
+		else
+			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
+		wake_up_process(p);
+	}
+	read_unlock(&tasklist_lock);
+	PRINTK( " done\n" );
+	MDELAY(500);
+}
--- clean.2.4/mm/vmscan.c	Thu Feb 28 11:18:26 2002
+++ linux-swsusp.24/mm/vmscan.c	Thu Mar  7 22:55:49 2002
@@ -723,18 +723,22 @@
 	 * us from recursively trying to free more memory as we're
 	 * trying to free the first piece of memory in the first place).
 	 */
-	tsk->flags |= PF_MEMALLOC;
+	tsk->flags |= PF_MEMALLOC | PF_KERNTHREAD;
 
 	/*
 	 * Kswapd main loop.
 	 */
 	for (;;) {
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_IOTHREAD);
 		__set_current_state(TASK_INTERRUPTIBLE);
 		add_wait_queue(&kswapd_wait, &wait);
 
 		mb();
-		if (kswapd_can_sleep())
+		if (kswapd_can_sleep()) {
 			schedule();
+		}
+		
 
 		__set_current_state(TASK_RUNNING);
 		remove_wait_queue(&kswapd_wait, &wait);
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
