Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262975AbVFXW3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262975AbVFXW3y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 18:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVFXW3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 18:29:53 -0400
Received: from [203.171.93.254] ([203.171.93.254]:59067 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S263300AbVFXWY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 18:24:57 -0400
Subject: Re: [RFC] Fix SMP brokenness for PF_FREEZE and make freezing
	usable for other purposes
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Christoph Lameter <christoph@lameter.com>
Cc: Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       raybry@engr.sgi.com, pavel@suse.cz, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0506241316370.30503@graphe.net>
References: <Pine.LNX.4.62.0506241316370.30503@graphe.net>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1119651955.9441.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 25 Jun 2005 08:25:55 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

try_to_freeze used to have a flag indicating whether we should clear the
sigpending. It stopped some threads going into infinite cpu-sucking
loops thinking they had a signal to process. It looks to me like Pavel
(or someone else) has made the recalc_sigpending unconditional and
you've cleaned up the left overs. Is that right, and is it the right
thing to do? I think so, but want to be sure.

Apart from that query, looks great to me. Will apply in Suspend2 and get
it tested there if you like. (Not sure if it will happen today though as
it's Saturday now).

Regards,

Nigel

On Sat, 2005-06-25 at 06:20, Christoph Lameter wrote:
> The process freezing used by software suspend currently relies on modifying
> current->flags from outside of the processes context. This makes freezing and
> unfreezing SMP unsafe since a process may change the flags at any time without
> locking. The following patch introduces a new atomic_t field in task_struct
> to allow SMP safe freezing and unfreezing.
> 
> It provides a simple API for process freezing:
> 
> frozen(process)		Check for frozen process
> freezing(process)	Check if a process is being frozen
> freeze(process)		Tell a process to freeze (go to refrigerator)
> thaw_process(process)	Restart process
> 
> I only know that this boots correctly since I have no system that can do 
> suspend. But Ray needs an effective means of process suspension for 
> his process migration patches.
> 
> Some of the code may still need to be moved around from kernel/power/* to 
> kernel/*.
> 
> But is this the correct way to fix this?
> 
> Signed-off-by: Christoph Lameter <christoph@lameter.com>
> 
> Index: linux-2.6.12/include/linux/sched.h
> ===================================================================
> --- linux-2.6.12.orig/include/linux/sched.h	2005-06-24 20:03:24.000000000 +0000
> +++ linux-2.6.12/include/linux/sched.h	2005-06-24 20:03:25.000000000 +0000
> @@ -720,6 +720,7 @@ struct task_struct {
>  
>  	unsigned long ptrace_message;
>  	siginfo_t *last_siginfo; /* For ptrace use.  */
> +	atomic_t freeze_status;
>  /*
>   * current io wait handle: wait queue entry to use for io waits
>   * If this thread is processing aio, this points at the waitqueue
> @@ -784,9 +785,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
>  #define PF_MEMALLOC	0x00000800	/* Allocating memory */
>  #define PF_FLUSHER	0x00001000	/* responsible for disk writeback */
>  #define PF_USED_MATH	0x00002000	/* if unset the fpu must be initialized before use */
> -#define PF_FREEZE	0x00004000	/* this task is being frozen for suspend now */
>  #define PF_NOFREEZE	0x00008000	/* this thread should not be frozen */
> -#define PF_FROZEN	0x00010000	/* frozen for system suspend */
>  #define PF_FSTRANS	0x00020000	/* inside a filesystem transaction */
>  #define PF_KSWAPD	0x00040000	/* I am kswapd */
>  #define PF_SWAPOFF	0x00080000	/* I am in swapoff */
> @@ -1250,29 +1249,36 @@ extern void normalize_rt_tasks(void);
>   * Checks whether we need to enter the refrigerator
>   * and returns 1 if we did so.
>   */
> -#ifdef CONFIG_PM
> -extern void refrigerator(unsigned long);
> +#define FROZEN 0x1000000
> +
> +#define frozen(__process) (atomic_read(&(__process)->freeze_status) >= FROZEN)
> +#define freezing(__process) atomic_read(&(__process)->freeze_status)
> +#define freeze(__process) atomic_inc(&(__process)->freeze_status)
> +/*
> + * Must hold read_lock(&tasklist_lock) when calling thaw_process
> + */
> +static inline int thaw_process(struct task_struct *p)
> +{
> +	if (frozen(p)) {
> +		atomic_set(&p->freeze_status, 0);
> +		wake_up_process(p);
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +extern void refrigerator(void);
>  extern int freeze_processes(void);
>  extern void thaw_processes(void);
>  
> -static inline int try_to_freeze(unsigned long refrigerator_flags)
> +static inline int try_to_freeze(void)
>  {
> -	if (unlikely(current->flags & PF_FREEZE)) {
> -		refrigerator(refrigerator_flags);
> +	if (freezing(current)) {
> +		refrigerator();
>  		return 1;
>  	} else
>  		return 0;
>  }
> -#else
> -static inline void refrigerator(unsigned long flag) {}
> -static inline int freeze_processes(void) { BUG(); return 0; }
> -static inline void thaw_processes(void) {}
> -
> -static inline int try_to_freeze(unsigned long refrigerator_flags)
> -{
> -	return 0;
> -}
> -#endif /* CONFIG_PM */
>  #endif /* __KERNEL__ */
>  
>  #endif
> Index: linux-2.6.12/drivers/block/pktcdvd.c
> ===================================================================
> --- linux-2.6.12.orig/drivers/block/pktcdvd.c	2005-06-24 20:03:23.000000000 +0000
> +++ linux-2.6.12/drivers/block/pktcdvd.c	2005-06-24 20:03:25.000000000 +0000
> @@ -1251,8 +1251,7 @@ static int kcdrwd(void *foobar)
>  			VPRINTK("kcdrwd: wake up\n");
>  
>  			/* make swsusp happy with our thread */
> -			if (current->flags & PF_FREEZE)
> -				refrigerator(PF_FREEZE);
> +			try_to_freeze();
>  
>  			list_for_each_entry(pkt, &pd->cdrw.pkt_active_list, list) {
>  				if (!pkt->sleep_time)
> Index: linux-2.6.12/kernel/power/process.c
> ===================================================================
> --- linux-2.6.12.orig/kernel/power/process.c	2005-06-17 19:48:29.000000000 +0000
> +++ linux-2.6.12/kernel/power/process.c	2005-06-24 20:03:25.000000000 +0000
> @@ -32,7 +32,7 @@ static inline int freezeable(struct task
>  }
>  
>  /* Refrigerator is place where frozen processes are stored :-). */
> -void refrigerator(unsigned long flag)
> +void refrigerator(void)
>  {
>  	/* Hmm, should we be allowed to suspend when there are realtime
>  	   processes around? */
> @@ -40,15 +40,13 @@ void refrigerator(unsigned long flag)
>  	save = current->state;
>  	current->state = TASK_UNINTERRUPTIBLE;
>  	pr_debug("%s entered refrigerator\n", current->comm);
> -	printk("=");
> -	current->flags &= ~PF_FREEZE;
>  
>  	spin_lock_irq(&current->sighand->siglock);
>  	recalc_sigpending(); /* We sent fake signal, clean it up */
>  	spin_unlock_irq(&current->sighand->siglock);
>  
> -	current->flags |= PF_FROZEN;
> -	while (current->flags & PF_FROZEN)
> +	atomic_set(&current->freeze_status, FROZEN);
> +	while (frozen(current))
>  		schedule();
>  	pr_debug("%s left refrigerator\n", current->comm);
>  	current->state = save;
> @@ -57,10 +55,10 @@ void refrigerator(unsigned long flag)
>  /* 0 = success, else # of processes that we failed to stop */
>  int freeze_processes(void)
>  {
> -       int todo;
> -       unsigned long start_time;
> +	int todo;
> +	unsigned long start_time;
>  	struct task_struct *g, *p;
> -	
> +
>  	printk( "Stopping tasks: " );
>  	start_time = jiffies;
>  	do {
> @@ -70,14 +68,12 @@ int freeze_processes(void)
>  			unsigned long flags;
>  			if (!freezeable(p))
>  				continue;
> -			if ((p->flags & PF_FROZEN) ||
> +			if ((frozen(p)) ||
>  			    (p->state == TASK_TRACED) ||
>  			    (p->state == TASK_STOPPED))
>  				continue;
>  
> -			/* FIXME: smp problem here: we may not access other process' flags
> -			   without locking */
> -			p->flags |= PF_FREEZE;
> +			freeze(p);
>  			spin_lock_irqsave(&p->sighand->siglock, flags);
>  			signal_wake_up(p, 0);
>  			spin_unlock_irqrestore(&p->sighand->siglock, flags);
> @@ -91,7 +87,7 @@ int freeze_processes(void)
>  			return todo;
>  		}
>  	} while(todo);
> -	
> +
>  	printk( "|\n" );
>  	BUG_ON(in_atomic());
>  	return 0;
> @@ -106,10 +102,7 @@ void thaw_processes(void)
>  	do_each_thread(g, p) {
>  		if (!freezeable(p))
>  			continue;
> -		if (p->flags & PF_FROZEN) {
> -			p->flags &= ~PF_FROZEN;
> -			wake_up_process(p);
> -		} else
> +		if (!thaw_process(p))
>  			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
>  	} while_each_thread(g, p);
>  
> Index: linux-2.6.12/mm/vmscan.c
> ===================================================================
> --- linux-2.6.12.orig/mm/vmscan.c	2005-06-24 20:03:25.000000000 +0000
> +++ linux-2.6.12/mm/vmscan.c	2005-06-24 20:03:25.000000000 +0000
> @@ -1216,8 +1216,8 @@ static int kswapd(void *p)
>  	order = 0;
>  	for ( ; ; ) {
>  		unsigned long new_order;
> -		if (current->flags & PF_FREEZE)
> -			refrigerator(PF_FREEZE);
> +
> +		try_to_freeze();
>  
>  		prepare_to_wait(&pgdat->kswapd_wait, &wait, TASK_INTERRUPTIBLE);
>  		new_order = pgdat->kswapd_max_order;
> Index: linux-2.6.12/kernel/signal.c
> ===================================================================
> --- linux-2.6.12.orig/kernel/signal.c	2005-06-24 20:03:25.000000000 +0000
> +++ linux-2.6.12/kernel/signal.c	2005-06-24 20:03:25.000000000 +0000
> @@ -213,7 +213,7 @@ static inline int has_pending_signals(si
>  fastcall void recalc_sigpending_tsk(struct task_struct *t)
>  {
>  	if (t->signal->group_stop_count > 0 ||
> -	    (t->flags & PF_FREEZE) ||
> +	    (freezing(t)) ||
>  	    PENDING(&t->pending, &t->blocked) ||
>  	    PENDING(&t->signal->shared_pending, &t->blocked))
>  		set_tsk_thread_flag(t, TIF_SIGPENDING);
> @@ -2231,8 +2231,7 @@ sys_rt_sigtimedwait(const sigset_t __use
>  			current->state = TASK_INTERRUPTIBLE;
>  			timeout = schedule_timeout(timeout);
>  
> -			if (current->flags & PF_FREEZE)
> -				refrigerator(PF_FREEZE);
> +			try_to_freeze();
>  			spin_lock_irq(&current->sighand->siglock);
>  			sig = dequeue_signal(current, &these, &info);
>  			current->blocked = current->real_blocked;
> Index: linux-2.6.12/mm/pdflush.c
> ===================================================================
> --- linux-2.6.12.orig/mm/pdflush.c	2005-06-17 19:48:29.000000000 +0000
> +++ linux-2.6.12/mm/pdflush.c	2005-06-24 20:03:25.000000000 +0000
> @@ -105,7 +105,7 @@ static int __pdflush(struct pdflush_work
>  		spin_unlock_irq(&pdflush_lock);
>  
>  		schedule();
> -		if (try_to_freeze(PF_FREEZE)) {
> +		if (try_to_freeze()) {
>  			spin_lock_irq(&pdflush_lock);
>  			continue;
>  		}
> Index: linux-2.6.12/kernel/sched.c
> ===================================================================
> --- linux-2.6.12.orig/kernel/sched.c	2005-06-24 20:03:25.000000000 +0000
> +++ linux-2.6.12/kernel/sched.c	2005-06-24 20:03:25.000000000 +0000
> @@ -4174,8 +4174,7 @@ static int migration_thread(void * data)
>  		struct list_head *head;
>  		migration_req_t *req;
>  
> -		if (current->flags & PF_FREEZE)
> -			refrigerator(PF_FREEZE);
> +		try_to_freeze();
>  
>  		spin_lock_irq(&rq->lock);
>  
> Index: linux-2.6.12/drivers/pcmcia/cs.c
> ===================================================================
> --- linux-2.6.12.orig/drivers/pcmcia/cs.c	2005-06-24 20:03:24.000000000 +0000
> +++ linux-2.6.12/drivers/pcmcia/cs.c	2005-06-24 20:03:25.000000000 +0000
> @@ -718,7 +718,7 @@ static int pccardd(void *__skt)
>  		}
>  
>  		schedule();
> -		try_to_freeze(PF_FREEZE);
> +		try_to_freeze();
>  
>  		if (!skt->thread)
>  			break;
> Index: linux-2.6.12/drivers/usb/core/hub.c
> ===================================================================
> --- linux-2.6.12.orig/drivers/usb/core/hub.c	2005-06-17 19:48:29.000000000 +0000
> +++ linux-2.6.12/drivers/usb/core/hub.c	2005-06-24 20:03:25.000000000 +0000
> @@ -2808,7 +2808,7 @@ static int hub_thread(void *__unused)
>  	do {
>  		hub_events();
>  		wait_event_interruptible(khubd_wait, !list_empty(&hub_event_list)); 
> -		try_to_freeze(PF_FREEZE);
> +		try_to_freeze();
>  	} while (!signal_pending(current));
>  
>  	pr_debug ("%s: khubd exiting\n", usbcore_name);
> Index: linux-2.6.12/drivers/input/serio/serio.c
> ===================================================================
> --- linux-2.6.12.orig/drivers/input/serio/serio.c	2005-06-24 20:03:24.000000000 +0000
> +++ linux-2.6.12/drivers/input/serio/serio.c	2005-06-24 20:03:25.000000000 +0000
> @@ -344,7 +344,7 @@ static int serio_thread(void *nothing)
>  	do {
>  		serio_handle_events();
>  		wait_event_interruptible(serio_wait, !list_empty(&serio_event_list));
> -		try_to_freeze(PF_FREEZE);
> +		try_to_freeze();
>  	} while (!signal_pending(current));
>  
>  	printk(KERN_DEBUG "serio: kseriod exiting\n");
> Index: linux-2.6.12/fs/jbd/journal.c
> ===================================================================
> --- linux-2.6.12.orig/fs/jbd/journal.c	2005-06-17 19:48:29.000000000 +0000
> +++ linux-2.6.12/fs/jbd/journal.c	2005-06-24 20:03:25.000000000 +0000
> @@ -167,7 +167,7 @@ loop:
>  	}
>  
>  	wake_up(&journal->j_wait_done_commit);
> -	if (current->flags & PF_FREEZE) {
> +	if (freezing(current)) {
>  		/*
>  		 * The simpler the better. Flushing journal isn't a
>  		 * good idea, because that depends on threads that may
> @@ -175,7 +175,7 @@ loop:
>  		 */
>  		jbd_debug(1, "Now suspending kjournald\n");
>  		spin_unlock(&journal->j_state_lock);
> -		refrigerator(PF_FREEZE);
> +		refrigerator();
>  		spin_lock(&journal->j_state_lock);
>  	} else {
>  		/*
> Index: linux-2.6.12/drivers/usb/storage/usb.c
> ===================================================================
> --- linux-2.6.12.orig/drivers/usb/storage/usb.c	2005-06-17 19:48:29.000000000 +0000
> +++ linux-2.6.12/drivers/usb/storage/usb.c	2005-06-24 20:03:25.000000000 +0000
> @@ -847,10 +847,8 @@ retry:
>  		wait_event_interruptible_timeout(us->delay_wait,
>  				test_bit(US_FLIDX_DISCONNECTING, &us->flags),
>  				delay_use * HZ);
> -		if (current->flags & PF_FREEZE) {
> -			refrigerator(PF_FREEZE);
> +		if (try_to_freeze())
>  			goto retry;
> -		}
>  	}
>  
>  	/* If the device is still connected, perform the scanning */
> Index: linux-2.6.12/drivers/ieee1394/ieee1394_core.c
> ===================================================================
> --- linux-2.6.12.orig/drivers/ieee1394/ieee1394_core.c	2005-06-24 20:03:24.000000000 +0000
> +++ linux-2.6.12/drivers/ieee1394/ieee1394_core.c	2005-06-24 20:03:25.000000000 +0000
> @@ -1041,10 +1041,8 @@ static int hpsbpkt_thread(void *__hi)
>  
>  	while (1) {
>  		if (down_interruptible(&khpsbpkt_sig)) {
> -			if (current->flags & PF_FREEZE) {
> -				refrigerator(0);
> +			if (try_to_freeze())
>  				continue;
> -			}
>  			printk("khpsbpkt: received unexpected signal?!\n" );
>  			break;
>  		}
> Index: linux-2.6.12/arch/i386/kernel/io_apic.c
> ===================================================================
> --- linux-2.6.12.orig/arch/i386/kernel/io_apic.c	2005-06-24 20:03:23.000000000 +0000
> +++ linux-2.6.12/arch/i386/kernel/io_apic.c	2005-06-24 20:03:25.000000000 +0000
> @@ -573,7 +573,7 @@ static int balanced_irq(void *unused)
>  	for ( ; ; ) {
>  		set_current_state(TASK_INTERRUPTIBLE);
>  		time_remaining = schedule_timeout(time_remaining);
> -		try_to_freeze(PF_FREEZE);
> +		try_to_freeze();
>  		if (time_after(jiffies,
>  				prev_balance_time+balanced_irq_interval)) {
>  			do_irq_balance();
> Index: linux-2.6.12/net/sunrpc/svcsock.c
> ===================================================================
> --- linux-2.6.12.orig/net/sunrpc/svcsock.c	2005-06-17 19:48:29.000000000 +0000
> +++ linux-2.6.12/net/sunrpc/svcsock.c	2005-06-24 20:03:25.000000000 +0000
> @@ -1185,8 +1185,8 @@ svc_recv(struct svc_serv *serv, struct s
>  	arg->page_len = (pages-2)*PAGE_SIZE;
>  	arg->len = (pages-1)*PAGE_SIZE;
>  	arg->tail[0].iov_len = 0;
> -	
> -	try_to_freeze(PF_FREEZE);
> +
> +	try_to_freeze();
>  	if (signalled())
>  		return -EINTR;
>  
> @@ -1227,7 +1227,7 @@ svc_recv(struct svc_serv *serv, struct s
>  
>  		schedule_timeout(timeout);
>  
> -		try_to_freeze(PF_FREEZE);
> +		try_to_freeze();
>  
>  		spin_lock_bh(&serv->sv_lock);
>  		remove_wait_queue(&rqstp->rq_wait, &wait);
> Index: linux-2.6.12/drivers/ieee1394/nodemgr.c
> ===================================================================
> --- linux-2.6.12.orig/drivers/ieee1394/nodemgr.c	2005-06-24 20:03:24.000000000 +0000
> +++ linux-2.6.12/drivers/ieee1394/nodemgr.c	2005-06-24 20:03:25.000000000 +0000
> @@ -1510,7 +1510,7 @@ static int nodemgr_host_thread(void *__h
>  
>  		if (down_interruptible(&hi->reset_sem) ||
>  		    down_interruptible(&nodemgr_serialize)) {
> -			if (try_to_freeze(PF_FREEZE))
> +			if (try_to_freeze())
>  				continue;
>  			printk("NodeMgr: received unexpected signal?!\n" );
>  			break;
> Index: linux-2.6.12/drivers/md/md.c
> ===================================================================
> --- linux-2.6.12.orig/drivers/md/md.c	2005-06-24 20:03:24.000000000 +0000
> +++ linux-2.6.12/drivers/md/md.c	2005-06-24 20:03:25.000000000 +0000
> @@ -2976,8 +2976,7 @@ static int md_thread(void * arg)
>  		wait_event_interruptible_timeout(thread->wqueue,
>  						 test_bit(THREAD_WAKEUP, &thread->flags),
>  						 thread->timeout);
> -		if (current->flags & PF_FREEZE)
> -			refrigerator(PF_FREEZE);
> +		try_to_freeze();
>  
>  		clear_bit(THREAD_WAKEUP, &thread->flags);
>  
> Index: linux-2.6.12/fs/jfs/jfs_logmgr.c
> ===================================================================
> --- linux-2.6.12.orig/fs/jfs/jfs_logmgr.c	2005-06-24 20:03:24.000000000 +0000
> +++ linux-2.6.12/fs/jfs/jfs_logmgr.c	2005-06-24 20:03:25.000000000 +0000
> @@ -2359,9 +2359,9 @@ int jfsIOWait(void *arg)
>  			lbmStartIO(bp);
>  			spin_lock_irq(&log_redrive_lock);
>  		}
> -		if (current->flags & PF_FREEZE) {
> +		if (freezing(current)) {
>  			spin_unlock_irq(&log_redrive_lock);
> -			refrigerator(PF_FREEZE);
> +			refrigerator();
>  		} else {
>  			add_wait_queue(&jfs_IO_thread_wait, &wq);
>  			set_current_state(TASK_INTERRUPTIBLE);
> Index: linux-2.6.12/fs/jfs/jfs_txnmgr.c
> ===================================================================
> --- linux-2.6.12.orig/fs/jfs/jfs_txnmgr.c	2005-06-24 20:03:24.000000000 +0000
> +++ linux-2.6.12/fs/jfs/jfs_txnmgr.c	2005-06-24 20:03:25.000000000 +0000
> @@ -2788,9 +2788,9 @@ int jfs_lazycommit(void *arg)
>  		/* In case a wakeup came while all threads were active */
>  		jfs_commit_thread_waking = 0;
>  
> -		if (current->flags & PF_FREEZE) {
> +		if (freezing(current)) {
>  			LAZY_UNLOCK(flags);
> -			refrigerator(PF_FREEZE);
> +			refrigerator();
>  		} else {
>  			DECLARE_WAITQUEUE(wq, current);
>  
> @@ -2987,9 +2987,9 @@ int jfs_sync(void *arg)
>  		/* Add anon_list2 back to anon_list */
>  		list_splice_init(&TxAnchor.anon_list2, &TxAnchor.anon_list);
>  
> -		if (current->flags & PF_FREEZE) {
> +		if (freezing(current)) {
>  			TXN_UNLOCK();
> -			refrigerator(PF_FREEZE);
> +			refrigerator();
>  		} else {
>  			DECLARE_WAITQUEUE(wq, current);
>  
> Index: linux-2.6.12/arch/i386/kernel/signal.c
> ===================================================================
> --- linux-2.6.12.orig/arch/i386/kernel/signal.c	2005-06-24 20:03:23.000000000 +0000
> +++ linux-2.6.12/arch/i386/kernel/signal.c	2005-06-24 20:03:25.000000000 +0000
> @@ -608,10 +608,8 @@ int fastcall do_signal(struct pt_regs *r
>  	if (!user_mode(regs))
>  		return 1;
>  
> -	if (current->flags & PF_FREEZE) {
> -		refrigerator(0);
> +	if (try_to_freeze)
>  		goto no_signal;
> -	}
>  
>  	if (!oldset)
>  		oldset = &current->blocked;
> Index: linux-2.6.12/fs/lockd/clntproc.c
> ===================================================================
> --- linux-2.6.12.orig/fs/lockd/clntproc.c	2005-06-24 20:03:24.000000000 +0000
> +++ linux-2.6.12/fs/lockd/clntproc.c	2005-06-24 20:03:25.000000000 +0000
> @@ -313,7 +313,7 @@ static int nlm_wait_on_grace(wait_queue_
>  	prepare_to_wait(queue, &wait, TASK_INTERRUPTIBLE);
>  	if (!signalled ()) {
>  		schedule_timeout(NLMCLNT_GRACE_WAIT);
> -		try_to_freeze(PF_FREEZE);
> +		try_to_freeze();
>  		if (!signalled ())
>  			status = 0;
>  	}
> Index: linux-2.6.12/fs/xfs/linux-2.6/xfs_buf.c
> ===================================================================
> --- linux-2.6.12.orig/fs/xfs/linux-2.6/xfs_buf.c	2005-06-24 20:03:24.000000000 +0000
> +++ linux-2.6.12/fs/xfs/linux-2.6/xfs_buf.c	2005-06-24 20:03:25.000000000 +0000
> @@ -1771,9 +1771,9 @@ xfsbufd(
>  
>  	INIT_LIST_HEAD(&tmp);
>  	do {
> -		if (unlikely(current->flags & PF_FREEZE)) {
> +		if (unlikely(freezing(current))) {
>  			xfsbufd_force_sleep = 1;
> -			refrigerator(PF_FREEZE);
> +			refrigerator();
>  		} else {
>  			xfsbufd_force_sleep = 0;
>  		}
> Index: linux-2.6.12/arch/x86_64/kernel/signal.c
> ===================================================================
> --- linux-2.6.12.orig/arch/x86_64/kernel/signal.c	2005-06-24 20:03:23.000000000 +0000
> +++ linux-2.6.12/arch/x86_64/kernel/signal.c	2005-06-24 20:03:25.000000000 +0000
> @@ -425,7 +425,7 @@ int do_signal(struct pt_regs *regs, sigs
>  	if (!user_mode(regs))
>  		return 1;
>  
> -	if (try_to_freeze(0))
> +	if (try_to_freeze())
>  		goto no_signal;
>  
>  	if (!oldset)
> Index: linux-2.6.12/fs/xfs/linux-2.6/xfs_super.c
> ===================================================================
> --- linux-2.6.12.orig/fs/xfs/linux-2.6/xfs_super.c	2005-06-24 20:03:24.000000000 +0000
> +++ linux-2.6.12/fs/xfs/linux-2.6/xfs_super.c	2005-06-24 20:03:25.000000000 +0000
> @@ -483,7 +483,7 @@ xfssyncd(
>  		set_current_state(TASK_INTERRUPTIBLE);
>  		timeleft = schedule_timeout(timeleft);
>  		/* swsusp */
> -		try_to_freeze(PF_FREEZE);
> +		try_to_freeze();
>  		if (vfsp->vfs_flag & VFS_UMOUNT)
>  			break;
>  
> Index: linux-2.6.12/arch/ppc/kernel/signal.c
> ===================================================================
> --- linux-2.6.12.orig/arch/ppc/kernel/signal.c	2005-06-17 19:48:29.000000000 +0000
> +++ linux-2.6.12/arch/ppc/kernel/signal.c	2005-06-24 20:07:44.000000000 +0000
> @@ -705,8 +705,7 @@ int do_signal(sigset_t *oldset, struct p
>  	unsigned long frame, newsp;
>  	int signr, ret;
>  
> -	if (current->flags & PF_FREEZE) {
> -		refrigerator(PF_FREEZE);
> +	if (try_to_freeze()) {
>  		signr = 0;
>  		if (!signal_pending(current))
>  			goto no_signal;
> Index: linux-2.6.12/Documentation/power/kernel_threads.txt
> ===================================================================
> --- linux-2.6.12.orig/Documentation/power/kernel_threads.txt	2005-06-17 19:48:29.000000000 +0000
> +++ linux-2.6.12/Documentation/power/kernel_threads.txt	2005-06-24 20:05:14.000000000 +0000
> @@ -12,8 +12,7 @@ refrigerator. Code to do this looks like
>  	do {
>  		hub_events();
>  		wait_event_interruptible(khubd_wait, !list_empty(&hub_event_list));
> -		if (current->flags & PF_FREEZE)
> -			refrigerator(PF_FREEZE);
> +		try_to_freeze();
>  	} while (!signal_pending(current));
>  
>  from drivers/usb/core/hub.c::hub_thread()
> Index: linux-2.6.12/arch/h8300/kernel/signal.c
> ===================================================================
> --- linux-2.6.12.orig/arch/h8300/kernel/signal.c	2005-06-17 19:48:29.000000000 +0000
> +++ linux-2.6.12/arch/h8300/kernel/signal.c	2005-06-24 20:07:44.000000000 +0000
> @@ -517,10 +517,8 @@ asmlinkage int do_signal(struct pt_regs 
>  	if ((regs->ccr & 0x10))
>  		return 1;
>  
> -	if (current->flags & PF_FREEZE) {
> -		refrigerator(0);
> +	if (try_to_freeze())
>  		goto no_signal;
> -	}
>  
>  	current->thread.esp0 = (unsigned long) regs;
>  
> Index: linux-2.6.12/arch/m32r/kernel/signal.c
> ===================================================================
> --- linux-2.6.12.orig/arch/m32r/kernel/signal.c	2005-06-17 19:48:29.000000000 +0000
> +++ linux-2.6.12/arch/m32r/kernel/signal.c	2005-06-24 20:07:44.000000000 +0000
> @@ -371,10 +371,8 @@ int do_signal(struct pt_regs *regs, sigs
>  	if (!user_mode(regs))
>  		return 1;
>  
> -	if (current->flags & PF_FREEZE) {
> -		refrigerator(0);
> +	if (try_to_freeze()) 
>  		goto no_signal;
> -	}
>  
>  	if (!oldset)
>  		oldset = &current->blocked;
> Index: linux-2.6.12/fs/afs/kafsasyncd.c
> ===================================================================
> --- linux-2.6.12.orig/fs/afs/kafsasyncd.c	2005-06-17 19:48:29.000000000 +0000
> +++ linux-2.6.12/fs/afs/kafsasyncd.c	2005-06-24 20:07:18.000000000 +0000
> @@ -116,7 +116,7 @@ static int kafsasyncd(void *arg)
>  		remove_wait_queue(&kafsasyncd_sleepq, &myself);
>  		set_current_state(TASK_RUNNING);
>  
> -		try_to_freeze(PF_FREEZE);
> +		try_to_freeze();
>  
>  		/* discard pending signals */
>  		afs_discard_my_signals();
> Index: linux-2.6.12/fs/afs/kafstimod.c
> ===================================================================
> --- linux-2.6.12.orig/fs/afs/kafstimod.c	2005-06-17 19:48:29.000000000 +0000
> +++ linux-2.6.12/fs/afs/kafstimod.c	2005-06-24 20:07:18.000000000 +0000
> @@ -91,7 +91,7 @@ static int kafstimod(void *arg)
>  			complete_and_exit(&kafstimod_dead, 0);
>  		}
>  
> -		try_to_freeze(PF_FREEZE);
> +		try_to_freeze();
>  
>  		/* discard pending signals */
>  		afs_discard_my_signals();
> Index: linux-2.6.12/Documentation/power/swsusp.txt
> ===================================================================
> --- linux-2.6.12.orig/Documentation/power/swsusp.txt	2005-06-17 19:48:29.000000000 +0000
> +++ linux-2.6.12/Documentation/power/swsusp.txt	2005-06-24 20:05:53.000000000 +0000
> @@ -164,8 +164,7 @@ place where the thread is safe to be fro
>  should be held at that point and it must be safe to sleep there), and
>  add:
>  
> -            if (current->flags & PF_FREEZE)
> -                    refrigerator(PF_FREEZE);
> +            try_to_freeze();
>  
>  If the thread is needed for writing the image to storage, you should
>  instead set the PF_NOFREEZE process flag when creating the thread.
> Index: linux-2.6.12/arch/frv/kernel/signal.c
> ===================================================================
> --- linux-2.6.12.orig/arch/frv/kernel/signal.c	2005-06-17 19:48:29.000000000 +0000
> +++ linux-2.6.12/arch/frv/kernel/signal.c	2005-06-24 20:07:44.000000000 +0000
> @@ -536,10 +536,8 @@ int do_signal(struct pt_regs *regs, sigs
>  	if (!user_mode(regs))
>  		return 1;
>  
> -	if (current->flags & PF_FREEZE) {
> -		refrigerator(0);
> +	if (try_to_freeze())
>  		goto no_signal;
> -	}
>  
>  	if (!oldset)
>  		oldset = &current->blocked;
> Index: linux-2.6.12/net/rxrpc/krxtimod.c
> ===================================================================
> --- linux-2.6.12.orig/net/rxrpc/krxtimod.c	2005-06-17 19:48:29.000000000 +0000
> +++ linux-2.6.12/net/rxrpc/krxtimod.c	2005-06-24 20:09:14.000000000 +0000
> @@ -90,7 +90,7 @@ static int krxtimod(void *arg)
>  			complete_and_exit(&krxtimod_dead, 0);
>  		}
>  
> -		try_to_freeze(PF_FREEZE);
> +		try_to_freeze();
>  
>  		/* discard pending signals */
>  		rxrpc_discard_my_signals();
> Index: linux-2.6.12/net/rxrpc/krxiod.c
> ===================================================================
> --- linux-2.6.12.orig/net/rxrpc/krxiod.c	2005-06-17 19:48:29.000000000 +0000
> +++ linux-2.6.12/net/rxrpc/krxiod.c	2005-06-24 20:09:14.000000000 +0000
> @@ -138,7 +138,7 @@ static int rxrpc_krxiod(void *arg)
>  
>  		_debug("### End Work");
>  
> -		try_to_freeze(PF_FREEZE);
> +		try_to_freeze();
>  
>                  /* discard pending signals */
>  		rxrpc_discard_my_signals();
> Index: linux-2.6.12/net/rxrpc/krxsecd.c
> ===================================================================
> --- linux-2.6.12.orig/net/rxrpc/krxsecd.c	2005-06-17 19:48:29.000000000 +0000
> +++ linux-2.6.12/net/rxrpc/krxsecd.c	2005-06-24 20:09:14.000000000 +0000
> @@ -107,7 +107,7 @@ static int rxrpc_krxsecd(void *arg)
>  
>  		_debug("### End Inbound Calls");
>  
> -		try_to_freeze(PF_FREEZE);
> +		try_to_freeze();
>  
>                  /* discard pending signals */
>  		rxrpc_discard_my_signals();
> Index: linux-2.6.12/drivers/media/dvb/dvb-core/dvb_frontend.c
> ===================================================================
> --- linux-2.6.12.orig/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-06-24 20:03:24.000000000 +0000
> +++ linux-2.6.12/drivers/media/dvb/dvb-core/dvb_frontend.c	2005-06-24 20:13:56.000000000 +0000
> @@ -391,8 +391,7 @@ static int dvb_frontend_thread(void *dat
>  			break;
>  		}
>  
> -		if (current->flags & PF_FREEZE)
> -			refrigerator(PF_FREEZE);
> +		try_to_freeze();
>  
>  		if (down_interruptible(&fepriv->sem))
>  			break;
> Index: linux-2.6.12/drivers/media/video/msp3400.c
> ===================================================================
> --- linux-2.6.12.orig/drivers/media/video/msp3400.c	2005-06-24 20:03:24.000000000 +0000
> +++ linux-2.6.12/drivers/media/video/msp3400.c	2005-06-24 20:14:47.000000000 +0000
> @@ -750,8 +750,7 @@ static int msp34xx_sleep(struct msp3400c
>  #endif
>  		}
>  	}
> -	if (current->flags & PF_FREEZE)
> -		refrigerator(PF_FREEZE);
> +	try_to_freeze();
>  	remove_wait_queue(&msp->wq, &wait);
>  	return msp->restart;
>  }
> Index: linux-2.6.12/drivers/net/irda/stir4200.c
> ===================================================================
> --- linux-2.6.12.orig/drivers/net/irda/stir4200.c	2005-06-17 19:48:29.000000000 +0000
> +++ linux-2.6.12/drivers/net/irda/stir4200.c	2005-06-24 20:11:27.000000000 +0000
> @@ -763,7 +763,7 @@ static int stir_transmit_thread(void *ar
>  	{
>  #ifdef CONFIG_PM
>  		/* if suspending, then power off and wait */
> -		if (unlikely(current->flags & PF_FREEZE)) {
> +		if (unlikely(freezing(current))) {
>  			if (stir->receiving)
>  				receive_stop(stir);
>  			else
> @@ -771,7 +771,7 @@ static int stir_transmit_thread(void *ar
>  
>  			write_reg(stir, REG_CTRL1, CTRL1_TXPWD|CTRL1_RXPWD);
>  
> -			refrigerator(PF_FREEZE);
> +			refrigerator();
>  
>  			if (change_speed(stir, stir->speed))
>  				break;
> Index: linux-2.6.12/drivers/input/gameport/gameport.c
> ===================================================================
> --- linux-2.6.12.orig/drivers/input/gameport/gameport.c	2005-06-24 20:03:24.000000000 +0000
> +++ linux-2.6.12/drivers/input/gameport/gameport.c	2005-06-24 20:13:09.000000000 +0000
> @@ -439,7 +439,7 @@ static int gameport_thread(void *nothing
>  	do {
>  		gameport_handle_events();
>  		wait_event_interruptible(gameport_wait, !list_empty(&gameport_event_list));
> -		try_to_freeze(PF_FREEZE);
> +		try_to_freeze();
>  	} while (!signal_pending(current));
>  
>  	printk(KERN_DEBUG "gameport: kgameportd exiting\n");
> Index: linux-2.6.12/drivers/usb/gadget/file_storage.c
> ===================================================================
> --- linux-2.6.12.orig/drivers/usb/gadget/file_storage.c	2005-06-24 20:03:24.000000000 +0000
> +++ linux-2.6.12/drivers/usb/gadget/file_storage.c	2005-06-24 20:12:46.000000000 +0000
> @@ -1554,8 +1554,7 @@ static int sleep_thread(struct fsg_dev *
>  	rc = wait_event_interruptible(fsg->thread_wqh,
>  			fsg->thread_wakeup_needed);
>  	fsg->thread_wakeup_needed = 0;
> -	if (current->flags & PF_FREEZE)
> -		refrigerator(PF_FREEZE);
> +	try_to_freeze();
>  	return (rc ? -EINTR : 0);
>  }
>  
> Index: linux-2.6.12/drivers/pnp/pnpbios/core.c
> ===================================================================
> --- linux-2.6.12.orig/drivers/pnp/pnpbios/core.c	2005-06-17 19:48:29.000000000 +0000
> +++ linux-2.6.12/drivers/pnp/pnpbios/core.c	2005-06-24 20:12:24.000000000 +0000
> @@ -182,7 +182,7 @@ static int pnp_dock_thread(void * unused
>  		msleep_interruptible(2000);
>  
>  		if(signal_pending(current)) {
> -			if (try_to_freeze(PF_FREEZE))
> +			if (try_to_freeze())
>  				continue;
>  			break;
>  		}
> Index: linux-2.6.12/drivers/net/wireless/airo.c
> ===================================================================
> --- linux-2.6.12.orig/drivers/net/wireless/airo.c	2005-06-17 19:48:29.000000000 +0000
> +++ linux-2.6.12/drivers/net/wireless/airo.c	2005-06-24 20:12:06.000000000 +0000
> @@ -2918,7 +2918,7 @@ static int airo_thread(void *data) {
>  			flush_signals(current);
>  
>  		/* make swsusp happy with our thread */
> -		try_to_freeze(PF_FREEZE);
> +		try_to_freeze();
>  
>  		if (test_bit(JOB_DIE, &ai->flags))
>  			break;
> Index: linux-2.6.12/drivers/macintosh/therm_adt746x.c
> ===================================================================
> --- linux-2.6.12.orig/drivers/macintosh/therm_adt746x.c	2005-06-24 20:03:24.000000000 +0000
> +++ linux-2.6.12/drivers/macintosh/therm_adt746x.c	2005-06-24 20:15:14.000000000 +0000
> @@ -328,9 +328,7 @@ static int monitor_task(void *arg)
>  	struct thermostat* th = arg;
>  
>  	while(!kthread_should_stop()) {
> -		if (current->flags & PF_FREEZE)
> -			refrigerator(PF_FREEZE);
> -
> +		try_to_freeze();
>  		msleep_interruptible(2000);
>  
>  #ifndef DEBUG
> Index: linux-2.6.12/drivers/net/irda/sir_kthread.c
> ===================================================================
> --- linux-2.6.12.orig/drivers/net/irda/sir_kthread.c	2005-06-17 19:48:29.000000000 +0000
> +++ linux-2.6.12/drivers/net/irda/sir_kthread.c	2005-06-24 20:11:51.000000000 +0000
> @@ -135,8 +135,7 @@ static int irda_thread(void *startup)
>  		remove_wait_queue(&irda_rq_queue.kick, &wait);
>  
>  		/* make swsusp happy with our thread */
> -		if (current->flags & PF_FREEZE)
> -			refrigerator(PF_FREEZE);
> +		try_to_freeze();
>  
>  		run_irda_queue();
>  	}
> Index: linux-2.6.12/drivers/media/video/video-buf-dvb.c
> ===================================================================
> --- linux-2.6.12.orig/drivers/media/video/video-buf-dvb.c	2005-06-17 19:48:29.000000000 +0000
> +++ linux-2.6.12/drivers/media/video/video-buf-dvb.c	2005-06-24 20:14:26.000000000 +0000
> @@ -62,8 +62,7 @@ static int videobuf_dvb_thread(void *dat
>  			break;
>  		if (kthread_should_stop())
>  			break;
> -		if (current->flags & PF_FREEZE)
> -			refrigerator(PF_FREEZE);
> +		try_to_freeze();
>  
>  		/* feed buffer data to demux */
>  		if (buf->state == STATE_DONE)
> Index: linux-2.6.12/drivers/net/8139too.c
> ===================================================================
> --- linux-2.6.12.orig/drivers/net/8139too.c	2005-06-24 20:03:24.000000000 +0000
> +++ linux-2.6.12/drivers/net/8139too.c	2005-06-24 20:10:54.000000000 +0000
> @@ -1606,7 +1606,7 @@ static int rtl8139_thread (void *data)
>  		do {
>  			timeout = interruptible_sleep_on_timeout (&tp->thr_wait, timeout);
>  			/* make swsusp happy with our thread */
> -			try_to_freeze(PF_FREEZE);
> +			try_to_freeze();
>  		} while (!signal_pending (current) && (timeout > 0));
>  
>  		if (signal_pending (current)) {
> Index: linux-2.6.12/drivers/w1/w1.c
> ===================================================================
> --- linux-2.6.12.orig/drivers/w1/w1.c	2005-06-24 20:03:24.000000000 +0000
> +++ linux-2.6.12/drivers/w1/w1.c	2005-06-24 20:15:38.000000000 +0000
> @@ -646,7 +646,7 @@ static int w1_control(void *data)
>  	while (!control_needs_exit || have_to_wait) {
>  		have_to_wait = 0;
>  
> -		try_to_freeze(PF_FREEZE);
> +		try_to_freeze();
>  		msleep_interruptible(w1_timeout * 1000);
>  
>  		if (signal_pending(current))
> @@ -725,7 +725,7 @@ int w1_process(void *data)
>  	allow_signal(SIGTERM);
>  
>  	while (!test_bit(W1_MASTER_NEED_EXIT, &dev->flags)) {
> -		try_to_freeze(PF_FREEZE);
> +		try_to_freeze();
>  		msleep_interruptible(w1_timeout * 1000);
>  
>  		if (signal_pending(current))
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 

