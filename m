Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293381AbSCARF2>; Fri, 1 Mar 2002 12:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293393AbSCARFT>; Fri, 1 Mar 2002 12:05:19 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:43515 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S293381AbSCARFK>; Fri, 1 Mar 2002 12:05:10 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.33.0203010838360.3798-100000@home.transmeta.com> 
In-Reply-To: <Pine.LNX.4.33.0203010838360.3798-100000@home.transmeta.com> 
To: Linus Torvalds <torvalds@transmeta.com>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: recalc_sigpending() / recalc_sigpending_tsk() ? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Mar 2002 17:05:06 +0000
Message-ID: <792.1015002306@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


torvalds@transmeta.com said:
>  So the basic rule should be: drivers etc should not ever have to
> touch "sigmask_lock", because they simply should never even _know_
> about things like that. Agreed? 

Absolutely.

>  So I would suggest solving this problem by just adding something like
> 	/* Block all signals except for mask */
> 	void sigallow(unsigned long mask)
> 	{
> 		spin_lock_irq(&current->sigmask_lock);
> 		siginitsetinv(current->blocked, mask);
> 		recalc_sigpending();
> 		spin_unlock_irq(&current->sigmask_lock);
> 	} 

Now that I like. Especially if coupled with the equivalent for dequeuing a
signal with implicit locking too, so I really can drop all references to 
current->sigmask_lock -- the JFFS2 garbage collection thread dequeues 
signals and deals as you might expect with SIGSTOP/SIGKILL:

	for (;;) {
		spin_lock_irq(&current->sigmask_lock);
		siginitsetinv (&current->blocked, sigmask(SIGHUP) | sigmask(SIGKILL) | sigmask(SIGSTOP) | sigmask(SIGCONT));
		recalc_sigpending();
		spin_unlock_irq(&current->sigmask_lock);

		if (!thread_should_wake(c)) {
                        set_current_state (TASK_INTERRUPTIBLE);
			D1(printk(KERN_DEBUG "jffs2_garbage_collect_thread sleeping...\n"));
			/* Yes, there's a race here; we checked thread_should_wake() before
			   setting current->state to TASK_INTERRUPTIBLE. But it doesn't
			   matter - We don't care if we miss a wakeup, because the GC thread
			   is only an optimisation anyway. */
			schedule();
		}
                
		cond_resched();

                /* Put_super will send a SIGKILL and then wait on the sem. 
                 */
                while (signal_pending(current)) {
                        siginfo_t info;
                        unsigned long signr;

                        spin_lock_irq(&current->sigmask_lock);
                        signr = dequeue_signal(&current->blocked, &info);
                        spin_unlock_irq(&current->sigmask_lock);

                        switch(signr) {
                        case SIGSTOP:
                                D1(printk(KERN_DEBUG "jffs2_garbage_collect_thread(): SIGSTOP received.\n"));
                                set_current_state(TASK_STOPPED);
                                schedule();
                                break;

                        case SIGKILL:
                                D1(printk(KERN_DEBUG "jffs2_garbage_collect_thread(): SIGKILL received.\n"));
				spin_lock_bh(&c->erase_completion_lock);
                                c->gc_task = NULL;
				spin_unlock_bh(&c->erase_completion_lock);
				complete_and_exit(&c->gc_thread_exit, 0);

			case SIGHUP:
				D1(printk(KERN_DEBUG "jffs2_garbage_collect_thread(): SIGHUP received.\n"));
				break;
			default:
				D1(printk(KERN_DEBUG "jffs2_garbage_collect_thread(): signal %ld received\n", signr));

                        }
                }
		/* We don't want SIGHUP to interrupt us. STOP and KILL are OK though. */
		spin_lock_irq(&current->sigmask_lock);
		siginitsetinv (&current->blocked, sigmask(SIGKILL) | sigmask(SIGSTOP) | sigmask(SIGCONT));
		recalc_sigpending();
		spin_unlock_irq(&current->sigmask_lock);

		D1(printk(KERN_DEBUG "jffs2_garbage_collect_thread(): pass\n"));
		jffs2_garbage_collect_pass(c);
	}

--
dwmw2


