Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbTKFX0u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 18:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263897AbTKFX0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 18:26:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:14542 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263902AbTKFXVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 18:21:02 -0500
Date: Thu, 6 Nov 2003 15:20:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mark Gross <mgross@linux.co.intel.com>, Ingo Molnar <mingo@elte.hu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMP signal latency fix up.
In-Reply-To: <1068158989.3555.43.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0311061510440.1842-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 6 Nov 2003, Mark Gross wrote:
>
> Running on SMP and the 2.6.0-test9 kernel, it takes about 10000 * 1/HZ seconds.  Running this 
> command with maxcpus=1 the command finishes in fraction of a second.  Under SMP the 
> signal delivery isn't kicking the task if its in the run state on the other CPU.

It looks like the "wake_up_process_kick()" interface is just broken. As it 
stands now, it's literally _designed_ to kick the process only when it 
wakes it up, which is silly and wrong. It makes no sense to kick a process 
that we just woke up, because it _will_ react immediately anyway.

We literally want to kick only processes that didn't need waking up, and 
the current interface is totally unsuitable for that.

> The following patch has been tested and seems to fix the problem.  
> I'm confident about the change to sched.c actualy fixes a cut and paste bug.

Naah, it's a thinko, the code shouldn't be like that at all.

There's only one user of the "wake_up_process_kick()" thing, and that one 
user really wants to kick the process totally independently of waking it 
up. Which just implies that we should just have a _regular_ 
"wake_up_process()" there, and a _separate_ "kick_process()" thing.

So I've got a feeling that 
 - we should remove the "kick" argument from "try_to_wake_up()"
 - the signal wakeup case should instead do a _regular_ wakeup.
 - we should kick the process if the wakeup _fails_.

Ie signal wakeup should most likely look something like


	inline void signal_wake_up(struct task_struct *t, int resume)
	{
		int woken;
		unsigned int mask;

		set_tsk_thread_flag(t,TIF_SIGPENDING);
		mask = TASK_INTERRUPTIBLE;
		if (resume)
			mask |= TASK_STOPPED;
		woken = 0;
		if (t->state & mask)
			woken = wake_up_state(p, mask);
		if (!woken)
			kick_process(p);
	}

where the "kick_process()" thing does the "is the task running on some 
other CPU and if so send it a reschedule event to make it react" thing.

Ingo?

		Linus

> diff -urN -X dontdiff linux-2.6.0-test9/kernel/sched.c /opt/linux-2.6.0-test9/kernel/sched.c
> --- linux-2.6.0-test9/kernel/sched.c    2003-10-25 11:44:29.000000000 -0700
> +++ /opt/linux-2.6.0-test9/kernel/sched.c       2003-11-06 13:04:03.628116240 -0800
> @@ -626,13 +626,13 @@
>                         }
>                         success = 1;
>                 }
> -#ifdef CONFIG_SMP
> -               else
> -                       if (unlikely(kick) && task_running(rq, p) && (task_cpu(p) != smp_processor_id()))
> -                               smp_send_reschedule(task_cpu(p));
> -#endif
>                 p->state = TASK_RUNNING;
>         }
> +#ifdef CONFIG_SMP
> +               else
> +               if (unlikely(kick) && task_running(rq, p) && (task_cpu(p) != smp_processor_id()))
> +                       smp_send_reschedule(task_cpu(p));
> +#endif
>         task_rq_unlock(rq, &flags);
> 
>         return success;
> diff -urN -X dontdiff linux-2.6.0-test9/kernel/signal.c /opt/linux-2.6.0-test9/kernel/signal.c
> --- linux-2.6.0-test9/kernel/signal.c   2003-10-25 11:43:27.000000000 -0700
> +++ /opt/linux-2.6.0-test9/kernel/signal.c      2003-11-06 12:18:22.000000000 -0800
> @@ -555,6 +555,9 @@
>                 wake_up_process_kick(t);
>                 return;
>         }
> +       if (t->state == TASK_RUNNING ) 
> +               wake_up_process_kick(t);
> +       
>  }
> 
>  /*
> 

