Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262457AbSI2MfC>; Sun, 29 Sep 2002 08:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262458AbSI2MfC>; Sun, 29 Sep 2002 08:35:02 -0400
Received: from mx1.elte.hu ([157.181.1.137]:9914 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262457AbSI2Meo>;
	Sun, 29 Sep 2002 08:34:44 -0400
Date: Sun, 29 Sep 2002 14:47:55 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Roland McGrath <roland@redhat.com>, Axel <Axel.Zeuner@gmx.de>,
       NPT library mailing list <phil-list@redhat.com>,
       <linux-kernel@vger.kernel.org>, Ulrich Drepper <drepper@redhat.com>
Subject: [patch] atomic-thread-signals-2.5.39-B5
In-Reply-To: <200209291047.g8TAlbp03653@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.44.0209291438590.18433-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 29 Sep 2002, Roland McGrath wrote:

> > we still have one more problem left in the signal handling area: atomicity
> > of signal delivery. Eg. right now it's possible to have a signal 'in
> > flight' for one specific thread, which manages to block it before handling
> > the signal. What should the behavior be in that case? Does POSIX say
> > anything about this?
> 
> Assuming you are talking about a process-global signal (not
> pthread_kill), then POSIX does not permit this race condition. [...]

okay, the attached patch fixes this bug.

the method to do this is to eliminate the per-thread sigmask_lock, and use
the per-group (per 'process') siglock for all signal related activities.  
This immensely simplified some of the locking interactions within
signal.c, and enabled the fixing of the above category of signal delivery
races.

this became possible due to the former thread-signal patch, which made
siglock an irq-safe thing. (it used to be a process-context-only
spinlock.) And this is even a speedup for non-threaded applications: only
one lock is used.

i fixed all places within the kernel except the non-x86 arch sections. 
Even for them the transition is very straightforward, in almost every case 
the following is sufficient in arch/*/kernel/signal.c:

		:1,$s/->sigmask_lock/->sig->siglock/g

the patch removes code due to the simplified locking:

 41 files changed, 233 insertions, 258 deletions

not having per-thread sigmask locks is not a scalability problem, because
thread groups need to have a per-'process' signal state, and every other
threading abstraction (and the process abstraction) can have per-thread
signal state via not using the CLONE_SIGHAND flag, which will cause
perfectly localized spinlocking.

the patch is against BK-curr plus my signal patches from today, i've
tested it on x86-SMP, with various signal loads, it works fine so far.

	Ingo

--- linux/drivers/net/8139too.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/drivers/net/8139too.c	Sun Sep 29 14:13:53 2002
@@ -1583,10 +1583,10 @@
 	unsigned long timeout;
 
 	daemonize();
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	sigemptyset(&current->blocked);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	strncpy (current->comm, dev->name, sizeof(current->comm) - 1);
 	current->comm[sizeof(current->comm) - 1] = '\0';
@@ -1598,9 +1598,9 @@
 		} while (!signal_pending (current) && (timeout > 0));
 
 		if (signal_pending (current)) {
-			spin_lock_irq(&current->sigmask_lock);
+			spin_lock_irq(&current->sig->siglock);
 			flush_signals(current);
-			spin_unlock_irq(&current->sigmask_lock);
+			spin_unlock_irq(&current->sig->siglock);
 		}
 
 		if (tp->time_to_die)
--- linux/drivers/media/video/saa5249.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/drivers/media/video/saa5249.c	Sun Sep 29 14:14:01 2002
@@ -280,17 +280,17 @@
 {
 	sigset_t oldblocked = current->blocked;
 
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	sigfillset(&current->blocked);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 	current->state = TASK_INTERRUPTIBLE;
 	schedule_timeout(delay);
 
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	current->blocked = oldblocked;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 }
 
 
--- linux/drivers/char/ftape/lowlevel/fdc-io.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/drivers/char/ftape/lowlevel/fdc-io.c	Sun Sep 29 14:14:06 2002
@@ -404,11 +404,11 @@
 	/* timeout time will be up to USPT microseconds too long ! */
 	timeout = (1000 * time + FT_USPT - 1) / FT_USPT;
 
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	old_sigmask = current->blocked;
 	sigfillset(&current->blocked);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	current->state = TASK_INTERRUPTIBLE;
 	add_wait_queue(&ftape_wait_intr, &wait);
@@ -416,10 +416,10 @@
 		timeout = schedule_timeout(timeout);
         }
 
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	current->blocked = old_sigmask;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 	
 	remove_wait_queue(&ftape_wait_intr, &wait);
 	/*  the following IS necessary. True: as well
--- linux/drivers/mtd/devices/blkmtd.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/drivers/mtd/devices/blkmtd.c	Sun Sep 29 14:14:11 2002
@@ -304,10 +304,10 @@
   DEBUG(1, "blkmtd: writetask: starting (pid = %d)\n", tsk->pid);
   daemonize();
   strcpy(tsk->comm, "blkmtdd");
-  spin_lock_irq(&tsk->sigmask_lock);
+  spin_lock_irq(&tsk->sig->siglock);
   sigfillset(&tsk->blocked);
   recalc_sigpending();
-  spin_unlock_irq(&tsk->sigmask_lock);
+  spin_unlock_irq(&tsk->sig->siglock);
 
   if(alloc_kiovec(1, &iobuf)) {
     printk("blkmtd: write_queue_task cant allocate kiobuf\n");
--- linux/drivers/mtd/mtdblock.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/drivers/mtd/mtdblock.c	Sun Sep 29 14:14:15 2002
@@ -468,10 +468,10 @@
 	/* we might get involved when memory gets low, so use PF_MEMALLOC */
 	tsk->flags |= PF_MEMALLOC;
 	strcpy(tsk->comm, "mtdblockd");
-	spin_lock_irq(&tsk->sigmask_lock);
+	spin_lock_irq(&tsk->sig->siglock);
 	sigfillset(&tsk->blocked);
 	recalc_sigpending();
-	spin_unlock_irq(&tsk->sigmask_lock);
+	spin_unlock_irq(&tsk->sig->siglock);
 	daemonize();
 
 	while (!leaving) {
--- linux/drivers/usb/storage/usb.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/drivers/usb/storage/usb.c	Sun Sep 29 14:14:19 2002
@@ -311,12 +311,12 @@
 	daemonize();
 
 	/* avoid getting signals */
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	flush_signals(current);
 	current->flags |= PF_IOTHREAD;
 	sigfillset(&current->blocked);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	/* set our name for identification purposes */
 	sprintf(current->comm, "usb-storage-%d", us->host_number);
--- linux/drivers/block/nbd.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/drivers/block/nbd.c	Sun Sep 29 14:14:23 2002
@@ -101,11 +101,11 @@
 	oldfs = get_fs();
 	set_fs(get_ds());
 
-	spin_lock_irqsave(&current->sigmask_lock, flags);
+	spin_lock_irqsave(&current->sig->siglock, flags);
 	oldset = current->blocked;
 	sigfillset(&current->blocked);
 	recalc_sigpending();
-	spin_unlock_irqrestore(&current->sigmask_lock, flags);
+	spin_unlock_irqrestore(&current->sig->siglock, flags);
 
 
 	do {
@@ -137,10 +137,10 @@
 		buf += result;
 	} while (size > 0);
 
-	spin_lock_irqsave(&current->sigmask_lock, flags);
+	spin_lock_irqsave(&current->sig->siglock, flags);
 	current->blocked = oldset;
 	recalc_sigpending();
-	spin_unlock_irqrestore(&current->sigmask_lock, flags);
+	spin_unlock_irqrestore(&current->sig->siglock, flags);
 
 	set_fs(oldfs);
 	return result;
--- linux/drivers/block/loop.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/drivers/block/loop.c	Sun Sep 29 14:14:28 2002
@@ -598,10 +598,10 @@
 					   hence, it mustn't be stopped at all because it could
 					   be indirectly used during suspension */
 
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	sigfillset(&current->blocked);
 	flush_signals(current);
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	set_user_nice(current, -20);
 
--- linux/drivers/md/md.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/drivers/md/md.c	Sun Sep 29 14:14:32 2002
@@ -2417,9 +2417,9 @@
 
 static inline void flush_curr_signals(void)
 {
-	spin_lock(&current->sigmask_lock);
+	spin_lock(&current->sig->siglock);
 	flush_signals(current);
-	spin_unlock(&current->sigmask_lock);
+	spin_unlock(&current->sig->siglock);
 }
 
 int md_thread(void * arg)
--- linux/drivers/bluetooth/hci_usb.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/drivers/bluetooth/hci_usb.c	Sun Sep 29 14:14:37 2002
@@ -633,19 +633,19 @@
 	}
 
 	/* Block signals, everything but SIGKILL/SIGSTOP */
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	tmpsig = current->blocked;
 	siginitsetinv(&current->blocked, sigmask(SIGKILL) | sigmask(SIGSTOP));
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	result = waitpid(pid, NULL, __WCLONE);
 
 	/* Allow signals again */
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	current->blocked = tmpsig;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	if (result != pid) {
 		BT_ERR("waitpid failed pid %d errno %d\n", pid, -result);
--- linux/drivers/bluetooth/bt3c_cs.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/drivers/bluetooth/bt3c_cs.c	Sun Sep 29 14:14:42 2002
@@ -528,19 +528,19 @@
 	}
 
 	/* Block signals, everything but SIGKILL/SIGSTOP */
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	tmpsig = current->blocked;
 	siginitsetinv(&current->blocked, sigmask(SIGKILL) | sigmask(SIGSTOP));
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	result = waitpid(pid, NULL, __WCLONE);
 
 	/* Allow signals again */
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	current->blocked = tmpsig;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	if (result != pid) {
 		printk(KERN_WARNING "bt3c_cs: Waiting for pid %d failed (errno=%d).\n", pid, -result);
--- linux/drivers/macintosh/adb.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/drivers/macintosh/adb.c	Sun Sep 29 14:14:46 2002
@@ -233,10 +233,10 @@
 {
 	strcpy(current->comm, "kadbprobe");
 	
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	sigfillset(&current->blocked);
 	flush_signals(current);
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	printk(KERN_INFO "adb: starting probe task...\n");
 	do_adb_reset_bus();
--- linux/arch/i386/kernel/signal.c.orig	Sun Sep 29 13:57:23 2002
+++ linux/arch/i386/kernel/signal.c	Sun Sep 29 13:57:38 2002
@@ -37,11 +37,11 @@
 	sigset_t saveset;
 
 	mask &= _BLOCKABLE;
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	saveset = current->blocked;
 	siginitset(&current->blocked, mask);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	regs->eax = -EINTR;
 	while (1) {
@@ -66,11 +66,11 @@
 		return -EFAULT;
 	sigdelsetmask(&newset, ~_BLOCKABLE);
 
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	saveset = current->blocked;
 	current->blocked = newset;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	regs->eax = -EINTR;
 	while (1) {
@@ -224,10 +224,10 @@
 		goto badframe;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 	
 	if (restore_sigcontext(regs, &frame->sc, &eax))
 		goto badframe;
@@ -252,10 +252,10 @@
 		goto badframe;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 	
 	if (restore_sigcontext(regs, &frame->uc.uc_mcontext, &eax))
 		goto badframe;
@@ -532,11 +532,11 @@
 		ka->sa.sa_handler = SIG_DFL;
 
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sigmask_lock);
+		spin_lock_irq(&current->sig->siglock);
 		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
 		sigaddset(&current->blocked,sig);
 		recalc_sigpending();
-		spin_unlock_irq(&current->sigmask_lock);
+		spin_unlock_irq(&current->sig->siglock);
 	}
 }
 
--- linux/arch/i386/kernel/vm86.c.orig	Sun Sep 29 13:57:43 2002
+++ linux/arch/i386/kernel/vm86.c	Sun Sep 29 14:04:03 2002
@@ -440,10 +440,10 @@
 		return 1; /* we let this handle by the calling routine */
 	if (current->ptrace & PT_PTRACED) {
 		unsigned long flags;
-		spin_lock_irqsave(&current->sigmask_lock, flags);
+		spin_lock_irqsave(&current->sig->siglock, flags);
 		sigdelset(&current->blocked, SIGTRAP);
 		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sigmask_lock, flags);
+		spin_unlock_irqrestore(&current->sig->siglock, flags);
 	}
 	send_sig(SIGTRAP, current, 1);
 	current->thread.trap_no = trapno;
--- linux/fs/xfs/pagebuf/page_buf.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/fs/xfs/pagebuf/page_buf.c	Sun Sep 29 14:14:51 2002
@@ -1684,10 +1684,10 @@
 	daemonize();
 
 	/* Avoid signals */
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	sigfillset(&current->blocked);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	/* Migrate to the right CPU */
 	set_cpus_allowed(current, 1UL << cpu);
@@ -1752,10 +1752,10 @@
 	daemonize();
 
 	/* Avoid signals */
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	sigfillset(&current->blocked);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	strcpy(current->comm, "pagebufd");
 	current->flags |= PF_MEMALLOC;
--- linux/fs/jfs/jfs_logmgr.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/fs/jfs/jfs_logmgr.c	Sun Sep 29 14:14:56 2002
@@ -2134,10 +2134,10 @@
 
 	unlock_kernel();
 
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	sigfillset(&current->blocked);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	complete(&jfsIOwait);
 
--- linux/fs/jfs/jfs_txnmgr.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/fs/jfs/jfs_txnmgr.c	Sun Sep 29 14:14:58 2002
@@ -2779,10 +2779,10 @@
 
 	jfsCommitTask = current;
 
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	sigfillset(&current->blocked);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	LAZY_LOCK_INIT();
 	TxAnchor.unlock_queue = TxAnchor.unlock_tail = 0;
@@ -2979,10 +2979,10 @@
 
 	unlock_kernel();
 
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	sigfillset(&current->blocked);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	complete(&jfsIOwait);
 
--- linux/fs/nfsd/nfssvc.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/fs/nfsd/nfssvc.c	Sun Sep 29 14:15:01 2002
@@ -186,10 +186,10 @@
 	 */
 	for (;;) {
 		/* Block all but the shutdown signals */
-		spin_lock_irq(&current->sigmask_lock);
+		spin_lock_irq(&current->sig->siglock);
 		siginitsetinv(&current->blocked, SHUTDOWN_SIGS);
 		recalc_sigpending();
-		spin_unlock_irq(&current->sigmask_lock);
+		spin_unlock_irq(&current->sig->siglock);
 
 		/*
 		 * Find a socket with data available and call its
@@ -211,10 +211,10 @@
 		 */
 		rqstp->rq_client = exp_getclient(&rqstp->rq_addr);
 		/* Process request with signals blocked.  */
-		spin_lock_irq(&current->sigmask_lock);
+		spin_lock_irq(&current->sig->siglock);
 		siginitsetinv(&current->blocked, ALLOWED_SIGS);
 		recalc_sigpending();
-		spin_unlock_irq(&current->sigmask_lock);
+		spin_unlock_irq(&current->sig->siglock);
 
 		svc_process(serv, rqstp);
 
--- linux/fs/jffs2/background.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/fs/jffs2/background.c	Sun Sep 29 14:15:03 2002
@@ -91,10 +91,10 @@
 	set_user_nice(current, 10);
 
 	for (;;) {
-		spin_lock_irq(&current->sigmask_lock);
+		spin_lock_irq(&current->sig->siglock);
 		siginitsetinv (&current->blocked, sigmask(SIGHUP) | sigmask(SIGKILL) | sigmask(SIGSTOP) | sigmask(SIGCONT));
 		recalc_sigpending();
-		spin_unlock_irq(&current->sigmask_lock);
+		spin_unlock_irq(&current->sig->siglock);
 
 		if (!thread_should_wake(c)) {
                         set_current_state (TASK_INTERRUPTIBLE);
@@ -114,9 +114,9 @@
                         siginfo_t info;
                         unsigned long signr;
 
-                        spin_lock_irq(&current->sigmask_lock);
+                        spin_lock_irq(&current->sig->siglock);
                         signr = dequeue_signal(&current->blocked, &info);
-                        spin_unlock_irq(&current->sigmask_lock);
+                        spin_unlock_irq(&current->sig->siglock);
 
                         switch(signr) {
                         case SIGSTOP:
@@ -141,10 +141,10 @@
                         }
                 }
 		/* We don't want SIGHUP to interrupt us. STOP and KILL are OK though. */
-		spin_lock_irq(&current->sigmask_lock);
+		spin_lock_irq(&current->sig->siglock);
 		siginitsetinv (&current->blocked, sigmask(SIGKILL) | sigmask(SIGSTOP) | sigmask(SIGCONT));
 		recalc_sigpending();
-		spin_unlock_irq(&current->sigmask_lock);
+		spin_unlock_irq(&current->sig->siglock);
 
 		D1(printk(KERN_DEBUG "jffs2_garbage_collect_thread(): pass\n"));
 		jffs2_garbage_collect_pass(c);
--- linux/fs/proc/array.c.orig	Sun Sep 29 14:03:11 2002
+++ linux/fs/proc/array.c	Sun Sep 29 14:03:40 2002
@@ -228,7 +228,7 @@
 	sigemptyset(ign);
 	sigemptyset(catch);
 
-	spin_lock_irq(&p->sigmask_lock);
+	spin_lock_irq(&p->sig->siglock);
 	if (p->sig) {
 		k = p->sig->action;
 		for (i = 1; i <= _NSIG; ++i, ++k) {
@@ -238,7 +238,7 @@
 				sigaddset(catch, i);
 		}
 	}
-	spin_unlock_irq(&p->sigmask_lock);
+	spin_unlock_irq(&p->sig->siglock);
 }
 
 static inline char * task_sig(struct task_struct *p, char *buffer)
--- linux/fs/reiserfs/journal.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/fs/reiserfs/journal.c	Sun Sep 29 14:15:05 2002
@@ -1875,10 +1875,10 @@
 
   daemonize() ;
 
-  spin_lock_irq(&current->sigmask_lock);
+  spin_lock_irq(&current->sig->siglock);
   sigfillset(&current->blocked);
   recalc_sigpending();
-  spin_unlock_irq(&current->sigmask_lock);
+  spin_unlock_irq(&current->sig->siglock);
 
   sprintf(current->comm, "kreiserfsd") ;
   lock_kernel() ;
--- linux/fs/ncpfs/sock.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/fs/ncpfs/sock.c	Sun Sep 29 14:15:08 2002
@@ -743,7 +743,7 @@
 		sigset_t old_set;
 		unsigned long mask, flags;
 
-		spin_lock_irqsave(&current->sigmask_lock, flags);
+		spin_lock_irqsave(&current->sig->siglock, flags);
 		old_set = current->blocked;
 		if (current->flags & PF_EXITING)
 			mask = 0;
@@ -762,7 +762,7 @@
 		}
 		siginitsetinv(&current->blocked, mask);
 		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sigmask_lock, flags);
+		spin_unlock_irqrestore(&current->sig->siglock, flags);
 		
 		fs = get_fs();
 		set_fs(get_ds());
@@ -771,10 +771,10 @@
 
 		set_fs(fs);
 
-		spin_lock_irqsave(&current->sigmask_lock, flags);
+		spin_lock_irqsave(&current->sig->siglock, flags);
 		current->blocked = old_set;
 		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sigmask_lock, flags);
+		spin_unlock_irqrestore(&current->sig->siglock, flags);
 	}
 
 	DDPRINTK("do_ncp_rpc_call returned %d\n", result);
--- linux/fs/autofs4/waitq.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/fs/autofs4/waitq.c	Sun Sep 29 14:15:11 2002
@@ -74,10 +74,10 @@
 	/* Keep the currently executing process from receiving a
 	   SIGPIPE unless it was already supposed to get one */
 	if (wr == -EPIPE && !sigpipe) {
-		spin_lock_irqsave(&current->sigmask_lock, flags);
+		spin_lock_irqsave(&current->sig->siglock, flags);
 		sigdelset(&current->pending.signal, SIGPIPE);
 		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sigmask_lock, flags);
+		spin_unlock_irqrestore(&current->sig->siglock, flags);
 	}
 
 	return (bytes > 0);
@@ -198,18 +198,18 @@
 		sigset_t oldset;
 		unsigned long irqflags;
 
-		spin_lock_irqsave(&current->sigmask_lock, irqflags);
+		spin_lock_irqsave(&current->sig->siglock, irqflags);
 		oldset = current->blocked;
 		siginitsetinv(&current->blocked, SHUTDOWN_SIGS & ~oldset.sig[0]);
 		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sigmask_lock, irqflags);
+		spin_unlock_irqrestore(&current->sig->siglock, irqflags);
 
 		interruptible_sleep_on(&wq->queue);
 
-		spin_lock_irqsave(&current->sigmask_lock, irqflags);
+		spin_lock_irqsave(&current->sig->siglock, irqflags);
 		current->blocked = oldset;
 		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sigmask_lock, irqflags);
+		spin_unlock_irqrestore(&current->sig->siglock, irqflags);
 	} else {
 		DPRINTK(("autofs_wait: skipped sleeping\n"));
 	}
--- linux/fs/lockd/clntproc.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/fs/lockd/clntproc.c	Sun Sep 29 14:15:13 2002
@@ -139,7 +139,7 @@
 	}
 
 	/* Keep the old signal mask */
-	spin_lock_irqsave(&current->sigmask_lock, flags);
+	spin_lock_irqsave(&current->sig->siglock, flags);
 	oldset = current->blocked;
 
 	/* If we're cleaning up locks because the process is exiting,
@@ -149,7 +149,7 @@
 	    && (current->flags & PF_EXITING)) {
 		sigfillset(&current->blocked);	/* Mask all signals */
 		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sigmask_lock, flags);
+		spin_unlock_irqrestore(&current->sig->siglock, flags);
 
 		call = nlmclnt_alloc_call();
 		if (!call) {
@@ -158,7 +158,7 @@
 		}
 		call->a_flags = RPC_TASK_ASYNC;
 	} else {
-		spin_unlock_irqrestore(&current->sigmask_lock, flags);
+		spin_unlock_irqrestore(&current->sig->siglock, flags);
 		memset(call, 0, sizeof(*call));
 		locks_init_lock(&call->a_args.lock.fl);
 		locks_init_lock(&call->a_res.lock.fl);
@@ -183,10 +183,10 @@
 		kfree(call);
 
  out_restore:
-	spin_lock_irqsave(&current->sigmask_lock, flags);
+	spin_lock_irqsave(&current->sig->siglock, flags);
 	current->blocked = oldset;
 	recalc_sigpending();
-	spin_unlock_irqrestore(&current->sigmask_lock, flags);
+	spin_unlock_irqrestore(&current->sig->siglock, flags);
 
 done:
 	dprintk("lockd: clnt proc returns %d\n", status);
@@ -592,11 +592,11 @@
 	int		status;
 
 	/* Block all signals while setting up call */
-	spin_lock_irqsave(&current->sigmask_lock, flags);
+	spin_lock_irqsave(&current->sig->siglock, flags);
 	oldset = current->blocked;
 	sigfillset(&current->blocked);
 	recalc_sigpending();
-	spin_unlock_irqrestore(&current->sigmask_lock, flags);
+	spin_unlock_irqrestore(&current->sig->siglock, flags);
 
 	req = nlmclnt_alloc_call();
 	if (!req)
@@ -611,10 +611,10 @@
 	if (status < 0)
 		kfree(req);
 
-	spin_lock_irqsave(&current->sigmask_lock, flags);
+	spin_lock_irqsave(&current->sig->siglock, flags);
 	current->blocked = oldset;
 	recalc_sigpending();
-	spin_unlock_irqrestore(&current->sigmask_lock, flags);
+	spin_unlock_irqrestore(&current->sig->siglock, flags);
 
 	return status;
 }
--- linux/fs/lockd/svc.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/fs/lockd/svc.c	Sun Sep 29 14:15:17 2002
@@ -101,10 +101,10 @@
 	sprintf(current->comm, "lockd");
 
 	/* Process request with signals blocked.  */
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	siginitsetinv(&current->blocked, sigmask(SIGKILL));
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	/* kick rpciod */
 	rpciod_up();
@@ -126,9 +126,9 @@
 	{
 		long timeout = MAX_SCHEDULE_TIMEOUT;
 		if (signalled()) {
-			spin_lock_irq(&current->sigmask_lock);
+			spin_lock_irq(&current->sig->siglock);
 			flush_signals(current);
-			spin_unlock_irq(&current->sigmask_lock);
+			spin_unlock_irq(&current->sig->siglock);
 			if (nlmsvc_ops) {
 				nlmsvc_invalidate_all();
 				grace_period_expire = set_grace_period();
@@ -297,9 +297,9 @@
 			"lockd_down: lockd failed to exit, clearing pid\n");
 		nlmsvc_pid = 0;
 	}
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 out:
 	up(&nlmsvc_sema);
 }
--- linux/fs/jffs/intrep.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/fs/jffs/intrep.c	Sun Sep 29 14:15:20 2002
@@ -3347,10 +3347,10 @@
 	current->session = 1;
 	current->pgrp = 1;
 	init_completion(&c->gc_thread_comp); /* barrier */ 
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	siginitsetinv (&current->blocked, sigmask(SIGHUP) | sigmask(SIGKILL) | sigmask(SIGSTOP) | sigmask(SIGCONT));
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 	strcpy(current->comm, "jffs_gcd");
 
 	D1(printk (KERN_NOTICE "jffs_garbage_collect_thread(): Starting infinite loop.\n"));
@@ -3378,9 +3378,9 @@
 			siginfo_t info;
 			unsigned long signr;
 
-			spin_lock_irq(&current->sigmask_lock);
+			spin_lock_irq(&current->sig->siglock);
 			signr = dequeue_signal(&current->blocked, &info);
-			spin_unlock_irq(&current->sigmask_lock);
+			spin_unlock_irq(&current->sig->siglock);
 
 			switch(signr) {
 			case SIGSTOP:
--- linux/fs/smbfs/smbiod.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/fs/smbfs/smbiod.c	Sun Sep 29 14:15:23 2002
@@ -279,10 +279,10 @@
 {
 	daemonize();
 
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	siginitsetinv(&current->blocked, sigmask(SIGKILL));
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	strcpy(current->comm, "smbiod");
 
--- linux/fs/autofs/waitq.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/fs/autofs/waitq.c	Sun Sep 29 14:15:25 2002
@@ -70,10 +70,10 @@
 	/* Keep the currently executing process from receiving a
 	   SIGPIPE unless it was already supposed to get one */
 	if (wr == -EPIPE && !sigpipe) {
-		spin_lock_irqsave(&current->sigmask_lock, flags);
+		spin_lock_irqsave(&current->sig->siglock, flags);
 		sigdelset(&current->pending.signal, SIGPIPE);
 		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sigmask_lock, flags);
+		spin_unlock_irqrestore(&current->sig->siglock, flags);
 	}
 
 	return (bytes > 0);
@@ -161,18 +161,18 @@
 		sigset_t oldset;
 		unsigned long irqflags;
 
-		spin_lock_irqsave(&current->sigmask_lock, irqflags);
+		spin_lock_irqsave(&current->sig->siglock, irqflags);
 		oldset = current->blocked;
 		siginitsetinv(&current->blocked, SHUTDOWN_SIGS & ~oldset.sig[0]);
 		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sigmask_lock, irqflags);
+		spin_unlock_irqrestore(&current->sig->siglock, irqflags);
 
 		interruptible_sleep_on(&wq->queue);
 
-		spin_lock_irqsave(&current->sigmask_lock, irqflags);
+		spin_lock_irqsave(&current->sig->siglock, irqflags);
 		current->blocked = oldset;
 		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sigmask_lock, irqflags);
+		spin_unlock_irqrestore(&current->sig->siglock, irqflags);
 	} else {
 		DPRINTK(("autofs_wait: skipped sleeping\n"));
 	}
--- linux/fs/jbd/journal.c.orig	Sun Sep 29 14:02:24 2002
+++ linux/fs/jbd/journal.c	Sun Sep 29 14:02:36 2002
@@ -205,10 +205,10 @@
 
 	lock_kernel();
 	daemonize();
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	sigfillset(&current->blocked);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	sprintf(current->comm, "kjournald");
 
--- linux/fs/exec.c.orig	Sun Sep 29 13:45:47 2002
+++ linux/fs/exec.c	Sun Sep 29 14:22:38 2002
@@ -649,12 +649,19 @@
 	memcpy(newsig->action, current->sig->action, sizeof(newsig->action));
 	init_sigpending(&newsig->shared_pending);
 
-	remove_thread_group(current, current->sig);
-	spin_lock_irq(&current->sigmask_lock);
+	write_lock_irq(&tasklist_lock);
+	spin_lock(&oldsig->siglock);
+	spin_lock(&newsig->siglock);
+
+	if (current == oldsig->curr_target)
+		oldsig->curr_target = next_thread(current);
 	current->sig = newsig;
 	init_sigpending(&current->pending);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+
+	spin_unlock(&newsig->siglock);
+	spin_unlock(&oldsig->siglock);
+	write_unlock_irq(&tasklist_lock);
 
 	if (atomic_dec_and_test(&oldsig->count))
 		kmem_cache_free(sigact_cachep, oldsig);
@@ -753,12 +760,12 @@
 
 mmap_failed:
 flush_failed:
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	if (current->sig != oldsig) {
 		kmem_cache_free(sigact_cachep, current->sig);
 		current->sig = oldsig;
 	}
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 	return retval;
 }
 
--- linux/include/linux/sched.h.orig	Sun Sep 29 13:43:56 2002
+++ linux/include/linux/sched.h	Sun Sep 29 14:21:01 2002
@@ -380,7 +380,6 @@
 /* namespace */
 	struct namespace *namespace;
 /* signal handlers */
-	spinlock_t sigmask_lock;	/* Protects signal and blocked */
 	struct signal_struct *sig;
 
 	sigset_t blocked, real_blocked, shared_unblocked;
@@ -657,7 +656,6 @@
 extern void exit_files(struct task_struct *);
 extern void exit_sighand(struct task_struct *);
 extern void __exit_sighand(struct task_struct *);
-extern void remove_thread_group(struct task_struct *tsk, struct signal_struct *sig);
 
 extern void reparent_to_init(void);
 extern void daemonize(void);
@@ -955,7 +953,7 @@
 
 /* Reevaluate whether the task has signals pending delivery.
    This is required every time the blocked sigset_t changes.
-   Athread cathreaders should have t->sigmask_lock.  */
+   callers must hold sig->siglock.  */
 
 extern FASTCALL(void recalc_sigpending_tsk(struct task_struct *t));
 extern void recalc_sigpending(void);
--- linux/include/linux/init_task.h.orig	Sun Sep 29 14:02:51 2002
+++ linux/include/linux/init_task.h	Sun Sep 29 14:02:55 2002
@@ -90,7 +90,6 @@
 	.thread		= INIT_THREAD,					\
 	.fs		= &init_fs,					\
 	.files		= &init_files,					\
-	.sigmask_lock	= SPIN_LOCK_UNLOCKED,				\
 	.sig		= &init_signals,				\
 	.pending	= { NULL, &tsk.pending.head, {{0}}},		\
 	.blocked	= {{0}},					\
--- linux/net/sunrpc/clnt.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/net/sunrpc/clnt.c	Sun Sep 29 14:15:28 2002
@@ -226,21 +226,21 @@
 		if (action[SIGQUIT-1].sa.sa_handler == SIG_DFL)
 			sigallow |= sigmask(SIGQUIT);
 	}
-	spin_lock_irqsave(&current->sigmask_lock, irqflags);
+	spin_lock_irqsave(&current->sig->siglock, irqflags);
 	*oldset = current->blocked;
 	siginitsetinv(&current->blocked, sigallow & ~oldset->sig[0]);
 	recalc_sigpending();
-	spin_unlock_irqrestore(&current->sigmask_lock, irqflags);
+	spin_unlock_irqrestore(&current->sig->siglock, irqflags);
 }
 
 void rpc_clnt_sigunmask(struct rpc_clnt *clnt, sigset_t *oldset)
 {
 	unsigned long	irqflags;
 	
-	spin_lock_irqsave(&current->sigmask_lock, irqflags);
+	spin_lock_irqsave(&current->sig->siglock, irqflags);
 	current->blocked = *oldset;
 	recalc_sigpending();
-	spin_unlock_irqrestore(&current->sigmask_lock, irqflags);
+	spin_unlock_irqrestore(&current->sig->siglock, irqflags);
 }
 
 /*
--- linux/net/sunrpc/sched.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/net/sunrpc/sched.c	Sun Sep 29 14:15:30 2002
@@ -992,10 +992,10 @@
 
 	daemonize();
 
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	siginitsetinv(&current->blocked, sigmask(SIGKILL));
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	strcpy(current->comm, "rpciod");
 
@@ -1050,9 +1050,9 @@
 		}
 	}
 
-	spin_lock_irqsave(&current->sigmask_lock, flags);
+	spin_lock_irqsave(&current->sig->siglock, flags);
 	recalc_sigpending();
-	spin_unlock_irqrestore(&current->sigmask_lock, flags);
+	spin_unlock_irqrestore(&current->sig->siglock, flags);
 }
 
 /*
@@ -1128,9 +1128,9 @@
 		}
 		interruptible_sleep_on(&rpciod_killer);
 	}
-	spin_lock_irqsave(&current->sigmask_lock, flags);
+	spin_lock_irqsave(&current->sig->siglock, flags);
 	recalc_sigpending();
-	spin_unlock_irqrestore(&current->sigmask_lock, flags);
+	spin_unlock_irqrestore(&current->sig->siglock, flags);
 out:
 	up(&rpciod_sema);
 	MOD_DEC_USE_COUNT;
--- linux/net/sunrpc/svc.c.orig	Sun Sep 29 14:13:34 2002
+++ linux/net/sunrpc/svc.c	Sun Sep 29 14:15:33 2002
@@ -213,9 +213,9 @@
 	}
 
 	if (!port) {
-		spin_lock_irqsave(&current->sigmask_lock, flags);
+		spin_lock_irqsave(&current->sig->siglock, flags);
 		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sigmask_lock, flags);
+		spin_unlock_irqrestore(&current->sig->siglock, flags);
 	}
 
 	return error;
--- linux/kernel/context.c.orig	Sun Sep 29 13:46:45 2002
+++ linux/kernel/context.c	Sun Sep 29 13:47:13 2002
@@ -77,10 +77,10 @@
 	keventd_running = 1;
 	keventd_task = curtask;
 
-	spin_lock_irq(&curtask->sigmask_lock);
+	spin_lock_irq(&curtask->sig->siglock);
 	siginitsetinv(&curtask->blocked, sigmask(SIGCHLD));
 	recalc_sigpending();
-	spin_unlock_irq(&curtask->sigmask_lock);
+	spin_unlock_irq(&curtask->sig->siglock);
 
 	complete((struct completion *)startup);
 
@@ -106,10 +106,10 @@
 		if (signal_pending(curtask)) {
 			while (waitpid(-1, (unsigned int *)0, __WALL|WNOHANG) > 0)
 				;
-			spin_lock_irq(&curtask->sigmask_lock);
+			spin_lock_irq(&curtask->sig->siglock);
 			flush_signals(curtask);
 			recalc_sigpending();
-			spin_unlock_irq(&curtask->sigmask_lock);
+			spin_unlock_irq(&curtask->sig->siglock);
 		}
 	}
 }
--- linux/kernel/fork.c.orig	Sun Sep 29 13:47:21 2002
+++ linux/kernel/fork.c	Sun Sep 29 13:47:56 2002
@@ -756,7 +756,6 @@
 		/* ?? should we just memset this ?? */
 		for(i = 0; i < NR_CPUS; i++)
 			p->per_cpu_utime[i] = p->per_cpu_stime[i] = 0;
-		spin_lock_init(&p->sigmask_lock);
 	}
 #endif
 	p->array = NULL;
--- linux/kernel/kmod.c.orig	Sun Sep 29 13:47:25 2002
+++ linux/kernel/kmod.c	Sun Sep 29 13:48:06 2002
@@ -110,12 +110,12 @@
 	   as the super user right after the execve fails if you time
 	   the signal just right.
 	*/
-	spin_lock_irq(&curtask->sigmask_lock);
+	spin_lock_irq(&curtask->sig->siglock);
 	sigemptyset(&curtask->blocked);
 	flush_signals(curtask);
 	flush_signal_handlers(curtask);
 	recalc_sigpending();
-	spin_unlock_irq(&curtask->sigmask_lock);
+	spin_unlock_irq(&curtask->sig->siglock);
 
 	for (i = 0; i < curtask->files->max_fds; i++ ) {
 		if (curtask->files->fd[i]) close(i);
@@ -238,20 +238,20 @@
 	}
 
 	/* Block everything but SIGKILL/SIGSTOP */
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	tmpsig = current->blocked;
 	siginitsetinv(&current->blocked, sigmask(SIGKILL) | sigmask(SIGSTOP));
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	waitpid_result = waitpid(pid, NULL, __WCLONE);
 	atomic_dec(&kmod_concurrent);
 
 	/* Allow signals again.. */
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	current->blocked = tmpsig;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	if (waitpid_result != pid) {
 		printk(KERN_ERR "request_module[%s]: waitpid(%d,...) failed, errno %d\n",
--- linux/kernel/signal.c.orig	Sun Sep 29 13:47:28 2002
+++ linux/kernel/signal.c	Sun Sep 29 14:35:51 2002
@@ -155,16 +155,8 @@
 	(((sig) != SIGCHLD) && \
 		((t)->sig->action[(sig)-1].sa.sa_handler == SIG_IGN))
 
-void __init signals_init(void)
-{
-	sigqueue_cachep =
-		kmem_cache_create("sigqueue",
-				  sizeof(struct sigqueue),
-				  __alignof__(struct sigqueue),
-				  0, NULL, NULL);
-	if (!sigqueue_cachep)
-		panic("signals_init(): cannot create sigqueue SLAB cache");
-}
+static int
+__send_sig_info(int sig, struct siginfo *info, struct task_struct *p);
 
 #define PENDING(p,b) has_pending_signals(&(p)->signal, (b))
 
@@ -250,23 +242,6 @@
 	flush_sigqueue(&t->pending);
 }
 
-static inline void __remove_thread_group(struct task_struct *tsk, struct signal_struct *sig)
-{
-	if (tsk == sig->curr_target)
-		sig->curr_target = next_thread(tsk);
-}
-
-void remove_thread_group(struct task_struct *tsk, struct signal_struct *sig)
-{
-	write_lock_irq(&tasklist_lock);
-	spin_lock(&tsk->sig->siglock);
-
-	__remove_thread_group(tsk, sig);
-
-	spin_unlock(&tsk->sig->siglock);
-	write_unlock_irq(&tasklist_lock);
-}
-
 /*
  * This function expects the tasklist_lock write-locked.
  */
@@ -279,9 +254,9 @@
 	if (!atomic_read(&sig->count))
 		BUG();
 	spin_lock(&sig->siglock);
-	spin_lock(&tsk->sigmask_lock);
 	if (atomic_dec_and_test(&sig->count)) {
-		__remove_thread_group(tsk, sig);
+		if (tsk == sig->curr_target)
+			sig->curr_target = next_thread(tsk);
 		tsk->sig = NULL;
 		spin_unlock(&sig->siglock);
 		flush_sigqueue(&sig->shared_pending);
@@ -295,14 +270,13 @@
 			wake_up_process(sig->group_exit_task);
 			sig->group_exit_task = NULL;
 		}
-		__remove_thread_group(tsk, sig);
+		if (tsk == sig->curr_target)
+			sig->curr_target = next_thread(tsk);
 		tsk->sig = NULL;
 		spin_unlock(&sig->siglock);
 	}
 	clear_tsk_thread_flag(tsk,TIF_SIGPENDING);
 	flush_sigqueue(&tsk->pending);
-
-	spin_unlock(&tsk->sigmask_lock);
 }
 
 void exit_sighand(struct task_struct *tsk)
@@ -361,11 +335,11 @@
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&current->sigmask_lock, flags);
+	spin_lock_irqsave(&current->sig->siglock, flags);
 	current->notifier_mask = mask;
 	current->notifier_data = priv;
 	current->notifier = notifier;
-	spin_unlock_irqrestore(&current->sigmask_lock, flags);
+	spin_unlock_irqrestore(&current->sig->siglock, flags);
 }
 
 /* Notify the system that blocking has ended. */
@@ -375,11 +349,11 @@
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&current->sigmask_lock, flags);
+	spin_lock_irqsave(&current->sig->siglock, flags);
 	current->notifier = NULL;
 	current->notifier_data = NULL;
 	recalc_sigpending();
-	spin_unlock_irqrestore(&current->sigmask_lock, flags);
+	spin_unlock_irqrestore(&current->sig->siglock, flags);
 }
 
 static inline int collect_signal(int sig, struct sigpending *list, siginfo_t *info)
@@ -435,7 +409,7 @@
  * Dequeue a signal and return the element to the caller, which is 
  * expected to free it.
  *
- * All callers have to hold the siglock and the sigmask_lock.
+ * All callers have to hold the siglock.
  */
 
 int dequeue_signal(struct sigpending *pending, sigset_t *mask, siginfo_t *info)
@@ -492,7 +466,7 @@
  * Remove signal sig from t->pending.
  * Returns 1 if sig was found.
  *
- * All callers must be holding t->sigmask_lock.
+ * All callers must be holding the siglock.
  */
 static int rm_sig_from_queue(int sig, struct task_struct *t)
 {
@@ -661,7 +635,7 @@
  *
  * NOTE! we rely on the previous spin_lock to
  * lock interrupts for us! We can only be called with
- * "sigmask_lock" held, and the local interrupt must
+ * "siglock" held, and the local interrupt must
  * have been disabled when that got acquired!
  *
  * No need to set need_resched since signal event passing
@@ -700,7 +674,7 @@
 }
 
 static int
-__send_sig_info(int sig, struct siginfo *info, struct task_struct *t, int shared)
+specific_send_sig_info(int sig, struct siginfo *info, struct task_struct *t, int shared)
 {
 	int ret;
 
@@ -712,22 +686,21 @@
 #endif
 	ret = -EINVAL;
 	if (sig < 0 || sig > _NSIG)
-		goto out_nolock;
+		goto out;
 	/* The somewhat baroque permissions check... */
 	ret = -EPERM;
 	if (bad_signal(sig, info, t))
-		goto out_nolock;
+		goto out;
 	ret = security_ops->task_kill(t, info, sig);
 	if (ret)
-		goto out_nolock;
+		goto out;
 
 	/* The null signal is a permissions and process existence probe.
 	   No signal is actually delivered.  Same goes for zombies. */
 	ret = 0;
 	if (!sig || !t->sig)
-		goto out_nolock;
+		goto out;
 
-	spin_lock(&t->sigmask_lock);
 	handle_stop_signal(sig, t);
 
 	/* Optimize away the signal, if it's a signal that can be
@@ -754,8 +727,6 @@
 		ret = send_signal(sig, info, &t->sig->shared_pending);
 	}
 out:
-	spin_unlock(&t->sigmask_lock);
-out_nolock:
 	return ret;
 }
 
@@ -768,40 +739,31 @@
 force_sig_info(int sig, struct siginfo *info, struct task_struct *t)
 {
 	unsigned long int flags;
+	int ret;
 
-	spin_lock_irqsave(&t->sigmask_lock, flags);
-	if (t->sig == NULL) {
-		spin_unlock_irqrestore(&t->sigmask_lock, flags);
-		return -ESRCH;
-	}
-
+	spin_lock_irqsave(&t->sig->siglock, flags);
 	if (t->sig->action[sig-1].sa.sa_handler == SIG_IGN)
 		t->sig->action[sig-1].sa.sa_handler = SIG_DFL;
 	sigdelset(&t->blocked, sig);
 	recalc_sigpending_tsk(t);
-	spin_unlock_irqrestore(&t->sigmask_lock, flags);
+	ret = __send_sig_info(sig, info, t);
+	spin_unlock_irqrestore(&t->sig->siglock, flags);
 
-	return send_sig_info(sig, info, t);
+	return ret;
 }
 
 static int
-__force_sig_info(int sig, struct task_struct *t)
+specific_force_sig_info(int sig, struct task_struct *t)
 {
-	unsigned long int flags;
-
-	spin_lock_irqsave(&t->sigmask_lock, flags);
-	if (t->sig == NULL) {
-		spin_unlock_irqrestore(&t->sigmask_lock, flags);
+	if (!t->sig)
 		return -ESRCH;
-	}
 
 	if (t->sig->action[sig-1].sa.sa_handler == SIG_IGN)
 		t->sig->action[sig-1].sa.sa_handler = SIG_DFL;
 	sigdelset(&t->blocked, sig);
 	recalc_sigpending_tsk(t);
-	spin_unlock_irqrestore(&t->sigmask_lock, flags);
 
-	return __send_sig_info(sig, (void *)2, t, 0);
+	return specific_send_sig_info(sig, (void *)2, t, 0);
 }
 
 #define can_take_signal(p, sig)	\
@@ -820,7 +782,7 @@
 	 * then deliver it.
 	 */
 	if (can_take_signal(p, sig))
-		return __send_sig_info(sig, info, p, 0);
+		return specific_send_sig_info(sig, info, p, 0);
 
 	/*
 	 * Otherwise try to find a suitable thread.
@@ -851,14 +813,14 @@
 				break;
 			continue;
 		}
-		ret = __send_sig_info(sig, info, tmp, 0);
+		ret = specific_send_sig_info(sig, info, tmp, 0);
 		return ret;
 	}
 	/*
 	 * No suitable thread was found - put the signal
 	 * into the shared-pending queue.
 	 */
-	return __send_sig_info(sig, info, p, 1);
+	return specific_send_sig_info(sig, info, p, 1);
 }
 
 int __broadcast_thread_group(struct task_struct *p, int sig)
@@ -869,7 +831,7 @@
 	int err = 0;
 
 	for_each_task_pid(p->tgid, PIDTYPE_TGID, tmp, l, pid)
-		err = __force_sig_info(sig, tmp);
+		err = specific_force_sig_info(sig, tmp);
 
 	return err;
 }
@@ -887,19 +849,16 @@
 	return NULL;
 }
 
-int
-send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
+static int
+__send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
 {
 	struct task_struct *t;
-	unsigned long flags;
 	int ret = 0;
 
-	if (!p)
-		BUG();
-	if (!p->sig)
+#if CONFIG_SMP
+	if (!spin_is_locked(&p->sig->siglock))
 		BUG();
-	spin_lock_irqsave(&p->sig->siglock, flags);
-
+#endif
 	/* not a thread group - normal signal behavior */
 	if (thread_group_empty(p) || !sig)
 		goto out_send;
@@ -925,7 +884,7 @@
 	/* Does any of the threads unblock the signal? */
 	t = find_unblocked_thread(p, sig);
 	if (!t) {
-		ret = __send_sig_info(sig, info, p, 1);
+		ret = specific_send_sig_info(sig, info, p, 1);
 		goto out_unlock;
 	}
 	if (sig_kernel_broadcast(sig) || sig_kernel_coredump(sig)) {
@@ -936,9 +895,21 @@
 	/* must not happen */
 	BUG();
 out_send:
-	ret = __send_sig_info(sig, info, p, 0);
+	ret = specific_send_sig_info(sig, info, p, 0);
 out_unlock:
+	return ret;
+}
+
+int
+send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&p->sig->siglock, flags);
+	ret = __send_sig_info(sig, info, p);
 	spin_unlock_irqrestore(&p->sig->siglock, flags);
+
 	return ret;
 }
 
@@ -1096,9 +1067,8 @@
  * Joy. Or not. Pthread wants us to wake up every thread
  * in our parent group.
  */
-static inline void wake_up_parent(struct task_struct *p)
+static inline void __wake_up_parent(struct task_struct *p)
 {
-	unsigned long flags;
 	struct task_struct *parent = p->parent, *tsk = parent;
 
 	/*
@@ -1108,14 +1078,13 @@
 		wake_up_interruptible(&tsk->wait_chldexit);
 		return;
 	}
-	spin_lock_irqsave(&parent->sig->siglock, flags);
+
 	do {
 		wake_up_interruptible(&tsk->wait_chldexit);
 		tsk = next_thread(tsk);
 		if (tsk->sig != parent->sig)
 			BUG();
 	} while (tsk != parent);
-	spin_unlock_irqrestore(&parent->sig->siglock, flags);
 }
 
 /*
@@ -1125,6 +1094,7 @@
 void do_notify_parent(struct task_struct *tsk, int sig)
 {
 	struct siginfo info;
+	unsigned long flags;
 	int why, status;
 
 	if (sig == -1)
@@ -1164,8 +1134,10 @@
 	info.si_code = why;
 	info.si_status = status;
 
-	send_sig_info(sig, &info, tsk->parent);
-	wake_up_parent(tsk);
+	spin_lock_irqsave(&tsk->parent->sig->siglock, flags);
+	__send_sig_info(sig, &info, tsk->parent);
+	__wake_up_parent(tsk);
+	spin_unlock_irqrestore(&tsk->parent->sig->siglock, flags);
 }
 
 
@@ -1196,18 +1168,12 @@
 		unsigned long signr = 0;
 		struct k_sigaction *ka;
 
-		local_irq_disable();
-		if (current->sig->shared_pending.head) {
-			spin_lock(&current->sig->siglock);
+		spin_lock_irq(&current->sig->siglock);
+		if (current->sig->shared_pending.head)
 			signr = dequeue_signal(&current->sig->shared_pending, mask, info);
-			spin_unlock(&current->sig->siglock);
-		}
-		if (!signr) {
-			spin_lock(&current->sigmask_lock);
+		if (!signr)
 			signr = dequeue_signal(&current->pending, mask, info);
-			spin_unlock(&current->sigmask_lock);
-		}
-		local_irq_enable();
+		spin_unlock_irq(&current->sig->siglock);
 
 		if (!signr)
 			break;
@@ -1345,7 +1311,7 @@
 			goto out;
 		sigdelsetmask(&new_set, sigmask(SIGKILL)|sigmask(SIGSTOP));
 
-		spin_lock_irq(&current->sigmask_lock);
+		spin_lock_irq(&current->sig->siglock);
 		old_set = current->blocked;
 
 		error = 0;
@@ -1365,15 +1331,15 @@
 
 		current->blocked = new_set;
 		recalc_sigpending();
-		spin_unlock_irq(&current->sigmask_lock);
+		spin_unlock_irq(&current->sig->siglock);
 		if (error)
 			goto out;
 		if (oset)
 			goto set_old;
 	} else if (oset) {
-		spin_lock_irq(&current->sigmask_lock);
+		spin_lock_irq(&current->sig->siglock);
 		old_set = current->blocked;
-		spin_unlock_irq(&current->sigmask_lock);
+		spin_unlock_irq(&current->sig->siglock);
 
 	set_old:
 		error = -EFAULT;
@@ -1393,9 +1359,9 @@
 	if (sigsetsize > sizeof(sigset_t))
 		goto out;
 
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	sigandsets(&pending, &current->blocked, &current->pending.signal);
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	error = -EFAULT;
 	if (!copy_to_user(set, &pending, sigsetsize))
@@ -1503,7 +1469,6 @@
 	}
 
 	spin_lock_irq(&current->sig->siglock);
-	spin_lock(&current->sigmask_lock);
 	sig = dequeue_signal(&current->sig->shared_pending, &these, &info);
 	if (!sig)
 		sig = dequeue_signal(&current->pending, &these, &info);
@@ -1520,14 +1485,12 @@
 			current->real_blocked = current->blocked;
 			sigandsets(&current->blocked, &current->blocked, &these);
 			recalc_sigpending();
-			spin_unlock(&current->sigmask_lock);
 			spin_unlock_irq(&current->sig->siglock);
 
 			current->state = TASK_INTERRUPTIBLE;
 			timeout = schedule_timeout(timeout);
 
 			spin_lock_irq(&current->sig->siglock);
-			spin_lock(&current->sigmask_lock);
 			sig = dequeue_signal(&current->sig->shared_pending, &these, &info);
 			if (!sig)
 				sig = dequeue_signal(&current->pending, &these, &info);
@@ -1536,7 +1499,6 @@
 			recalc_sigpending();
 		}
 	}
-	spin_unlock(&current->sigmask_lock);
 	spin_unlock_irq(&current->sig->siglock);
 
 	if (sig) {
@@ -1593,7 +1555,7 @@
 	error = -ESRCH;
 	if (p) {
 		spin_lock_irq(&p->sig->siglock);
-		error = __send_sig_info(sig, &info, p, 0);
+		error = specific_send_sig_info(sig, &info, p, 0);
 		spin_unlock_irq(&p->sig->siglock);
 	}
 	read_unlock(&tasklist_lock);
@@ -1660,10 +1622,8 @@
 			    sig == SIGCHLD ||
 			    sig == SIGWINCH ||
 			    sig == SIGURG))) {
-			spin_lock_irq(&current->sigmask_lock);
 			if (rm_sig_from_queue(sig, current))
 				recalc_sigpending();
-			spin_unlock_irq(&current->sigmask_lock);
 		}
 	}
 
@@ -1756,7 +1716,7 @@
 			goto out;
 		new_set &= ~(sigmask(SIGKILL)|sigmask(SIGSTOP));
 
-		spin_lock_irq(&current->sigmask_lock);
+		spin_lock_irq(&current->sig->siglock);
 		old_set = current->blocked.sig[0];
 
 		error = 0;
@@ -1776,7 +1736,7 @@
 		}
 
 		recalc_sigpending();
-		spin_unlock_irq(&current->sigmask_lock);
+		spin_unlock_irq(&current->sig->siglock);
 		if (error)
 			goto out;
 		if (oset)
@@ -1838,13 +1798,13 @@
 {
 	int old;
 
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	old = current->blocked.sig[0];
 
 	siginitset(&current->blocked, newmask & ~(sigmask(SIGKILL)|
 						  sigmask(SIGSTOP)));
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	return old;
 }
@@ -1881,3 +1841,15 @@
 }
 
 #endif /* HAVE_ARCH_SYS_PAUSE */
+
+void __init signals_init(void)
+{
+	sigqueue_cachep =
+		kmem_cache_create("sigqueue",
+				  sizeof(struct sigqueue),
+				  __alignof__(struct sigqueue),
+				  0, NULL, NULL);
+	if (!sigqueue_cachep)
+		panic("signals_init(): cannot create sigqueue SLAB cache");
+}
+
--- linux/kernel/suspend.c.orig	Sun Sep 29 13:47:32 2002
+++ linux/kernel/suspend.c	Sun Sep 29 13:48:39 2002
@@ -219,9 +219,9 @@
 			/* FIXME: smp problem here: we may not access other process' flags
 			   without locking */
 			p->flags |= PF_FREEZE;
-			spin_lock_irqsave(&p->sigmask_lock, flags);
+			spin_lock_irqsave(&p->sig->siglock, flags);
 			signal_wake_up(p);
-			spin_unlock_irqrestore(&p->sigmask_lock, flags);
+			spin_unlock_irqrestore(&p->sig->siglock, flags);
 			todo++;
 		} while_each_thread(g, p);
 		read_unlock(&tasklist_lock);
--- linux/mm/pdflush.c.orig	Sun Sep 29 13:48:55 2002
+++ linux/mm/pdflush.c	Sun Sep 29 13:49:02 2002
@@ -91,10 +91,10 @@
 	strcpy(current->comm, "pdflush");
 
 	/* interruptible sleep, so block all signals */
-	spin_lock_irq(&current->sigmask_lock);
+	spin_lock_irq(&current->sig->siglock);
 	siginitsetinv(&current->blocked, 0);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sigmask_lock);
+	spin_unlock_irq(&current->sig->siglock);
 
 	current->flags |= PF_FLUSHER;
 	my_work->fn = NULL;

