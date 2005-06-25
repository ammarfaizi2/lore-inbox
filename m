Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263362AbVFYHbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263362AbVFYHbt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 03:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263359AbVFYHbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 03:31:48 -0400
Received: from 7ka-campus-gw.mipt.ru ([194.85.83.97]:21973 "EHLO
	7ka-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id S263362AbVFYHbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 03:31:40 -0400
Date: Sat, 25 Jun 2005 11:35:34 +0400
From: Kirill Korotaev <dev@sw.ru>
Reply-To: Kirill Korotaev <dev@sw.ru>
Organization: SW Soft
X-Priority: 3 (Normal)
Message-ID: <1104805430.20050625113534@sw.ru>
To: Christoph Lameter <christoph@lameter.com>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org, raybry@engr.sgi.com,
       pavel@suse.cz, <torvalds@osdl.org>
Subject: Re: [RFC] Fix SMP brokenness for PF_FREEZE and make freezing usable for other purposes
In-Reply-To: <Pine.LNX.4.62.0506241316370.30503@graphe.net>
References: <Pine.LNX.4.62.0506241316370.30503@graphe.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=Windows-1251
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CL> The process freezing used by software suspend currently relies on modifying
current->>flags from outside of the processes context. This makes freezing and
CL> unfreezing SMP unsafe since a process may change the flags at any time without
CL> locking. The following patch introduces a new atomic_t field in task_struct
CL> to allow SMP safe freezing and unfreezing.

CL> It provides a simple API for process freezing:

CL> frozen(process)             Check for frozen process
CL> freezing(process)   Check if a process is being frozen
CL> freeze(process)             Tell a process to freeze (go to refrigerator)
CL> thaw_process(process)       Restart process

CL> I only know that this boots correctly since I have no system that can do
CL> suspend. But Ray needs an effective means of process suspension for
CL> his process migration patches.
Just out of curiosity what patches are you talking about?
Is it possible to take a glance at it if it is what I think of?

comments below...

[skip]
CL>  /* Refrigerator is place where frozen processes are stored :-). */
CL> -void refrigerator(unsigned long flag)
CL> +void refrigerator(void)
CL>  {
CL>  	/* Hmm, should we be allowed to suspend when there are realtime
CL>  	   processes around? */
CL> @@ -40,15 +40,13 @@ void refrigerator(unsigned long flag)
CL>  	save = current->state;
CL>  	current->state = TASK_UNINTERRUPTIBLE;
CL>  	pr_debug("%s entered refrigerator\n", current->comm);
CL> -	printk("=");
-	current->>flags &= ~PF_FREEZE;
 
CL>  	spin_lock_irq(&current->sighand->siglock);
CL>  	recalc_sigpending(); /* We sent fake signal, clean it up */
CL>  	spin_unlock_irq(&current->sighand->siglock);
 
-	current->>flags |= PF_FROZEN;
-	while (current->>flags & PF_FROZEN)
CL> +	atomic_set(&current->freeze_status, FROZEN);
<<<< this looks unsafe... what if thaw_process() was called exactly
before this atomic_set()? then you won't wake up anymore...
CL> +	while (frozen(current))
CL>  		schedule();
CL>  	pr_debug("%s left refrigerator\n", current->comm);
CL>  	current->state = save;
CL> @@ -57,10 +55,10 @@ void refrigerator(unsigned long flag)
CL>  /* 0 = success, else # of processes that we failed to stop */
CL>  int freeze_processes(void)
CL>  {
CL> -       int todo;
CL> -       unsigned long start_time;
CL> +	int todo;
CL> +	unsigned long start_time;
CL>  	struct task_struct *g, *p;
CL> -	
CL> +
CL>  	printk( "Stopping tasks: " );
CL>  	start_time = jiffies;
CL>  	do {
CL> @@ -70,14 +68,12 @@ int freeze_processes(void)
CL>  			unsigned long flags;
CL>  			if (!freezeable(p))
CL>  				continue;
-			if ((p->>flags & PF_FROZEN) ||
CL> +			if ((frozen(p)) ||
<<<< this looks unsafe also... i think you have to check freezing()
instead of frozen(). otherwise you will be constantly incrementing
freezing counter and it can potentially overflow... Though this is
unlikely I see no reason to call freeze() if we are freezing
already... But we can call signal_wake_up() to speed up the process...
CL>  			    (p->state == TASK_TRACED) ||
CL>  			    (p->state == TASK_STOPPED))
CL>  				continue;
 
CL> -			/* FIXME: smp problem here: we may not access other process' flags
CL> -			   without locking */
-			p->>flags |= PF_FREEZE;
CL> +			freeze(p);
CL>  			spin_lock_irqsave(&p->sighand->siglock, flags);
CL>  			signal_wake_up(p, 0);
CL>  			spin_unlock_irqrestore(&p->sighand->siglock, flags);
CL> @@ -91,7 +87,7 @@ int freeze_processes(void)
CL>  			return todo;
CL>  		}
CL>  	} while(todo);
CL> -	
CL> +
CL>  	printk( "|\n" );
CL>  	BUG_ON(in_atomic());
CL>  	return 0;
CL> @@ -106,10 +102,7 @@ void thaw_processes(void)
CL>  	do_each_thread(g, p) {
CL>  		if (!freezeable(p))
CL>  			continue;
-		if (p->>flags & PF_FROZEN) {
-			p->>flags &= ~PF_FROZEN;
CL> -			wake_up_process(p);
CL> -		} else
CL> +		if (!thaw_process(p))
CL>  			printk(KERN_INFO " Strange, %s not stopped\n", p->comm );
CL>  	} while_each_thread(g, p);
 
[skip]

CL> Index: linux-2.6.12/arch/i386/kernel/signal.c
CL> ===================================================================
CL> --- linux-2.6.12.orig/arch/i386/kernel/signal.c	2005-06-24 20:03:23.000000000 +0000
CL> +++ linux-2.6.12/arch/i386/kernel/signal.c	2005-06-24 20:03:25.000000000 +0000
CL> @@ -608,10 +608,8 @@ int fastcall do_signal(struct pt_regs *r
CL>  	if (!user_mode(regs))
CL>  		return 1;
 
-	if (current->>flags & PF_FREEZE) {
CL> -		refrigerator(0);
CL> +	if (try_to_freeze)
<<<< missed ()?
CL>  		goto no_signal;

Kirill

