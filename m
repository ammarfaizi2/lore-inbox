Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265175AbUGZVDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265175AbUGZVDc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 17:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266121AbUGZVBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 17:01:34 -0400
Received: from mx2.elte.hu ([157.181.151.9]:42148 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266131AbUGZUsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 16:48:23 -0400
Date: Mon, 26 Jul 2004 22:36:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: rlrevell@joe-job.com, wli@holomorphy.com, lenar@vision.ee,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-J3
Message-ID: <20040726203634.GA26096@elte.hu>
References: <20040713122805.GZ21066@holomorphy.com> <40F3F0A0.9080100@vision.ee> <20040713143947.GG21066@holomorphy.com> <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <20040726125750.5e467cfd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040726125750.5e467cfd.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-1.524, required 5.9,
	autolearn=not spam, BAYES_01 -1.52
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> The bigger this thing gets, the more worried I get.  Sometime this is
> going to need to be split up into individual fixes, and they need to
> be based upon an overall approach which we haven't yet settled on.

i will do that splitup. Right now i'm simply mapping how widespread the
problem is and what type of fixes we need. The situation isnt all that
bad but we might need (an optional) mechanism to make softirqs
synchronous. All of this stuff is nicely modular and i'll do a splitup
post 2.6.8 (i dont think we want to disturb 2.6.8 with any of this).

> In particular your whole approach (with voluntary_need_resched())
> doesn't work on SMP.

(for the record, voluntary_need_resched() == need_resched() - i'm only
keeping a distinction between the two to be able to track progress and
regressions between the vanilla and modified kernels.)

need_resched() indeed doesnt do a lock-break for SMP purposes.

> The approach I'm using is to unconditionally drop locks on every Nth pass
> around the loop to allow another CPU to grab the lock, do some work, drop
> the lock, then be preempted.  eg:
> 
> @@ -773,6 +774,12 @@ int get_user_pages(struct task_struct *t
>  			struct page *map = NULL;
>  			int lookup_write = write;
>  
> +			if ((++nr_pages & 63) == 0) {
> +				spin_unlock(&mm->page_table_lock);
> +				cpu_relax();
> +				spin_lock(&mm->page_table_lock);
> +			}
> +

guaranteeing latencies on SMP is hard, because the latency of a CPU
might depend on the latency of a task on another CPU - which CPU isnt
notified of the rescheduling request.

one alternative technique to yours would be to notify _all_ CPUs that a
high-prio RT task is ready to run (via a broadcast need-resched). That
way the UP latency-break techniques map to SMP in a 1:1 way.

non-RT tasks dont get this benefit, which is a difference to the UP
situation, but i dont think it would be appropriate to use the UP
behavior, due to the overhead of broadcasting.

a combination of the two techniques could be used too: a global 'break
locks from now on' flag which gets set if a (RT?) task wants to
reschedule. Normally this flag would be zero and the cacheline would be
clean and shared between all CPUs, causing no overhead. Once a task
wants to reschedule it would increase by 1 until that task has been
scheduled. This would remove the ugliness factor too, your sample code
would look:

> +			if (need_lock_break()) {
> +				spin_unlock(&mm->page_table_lock);
> +				cpu_relax();
> +				spin_lock(&mm->page_table_lock);
> +			}
> +

or a shortcut:

> +			cond_lock_break(&mm->page_table_lock);

there are two problems with the unconditional lock-break:

 - i'm not sure cpu_relax() guarantees that another CPU can grab this 
   lock. It all depends on whether the lock cacheline can bounce over 
   to the other CPU faster than cpu_relax() finishes and this CPU
   re-acquires the lock.

 - the latencies will still be higher than on UP, in a hard to predict
   way. Every time the codepath encounters a spinlock it has to take in
   order to exit for a reschedule, the latency gets re-added. Also, the 
   now scheduled high-prio task will encounter the latency every time it
   acquires a spinlock - while on UP it has the CPU for itself with no
   interaction from other CPUs.

	Ingo
