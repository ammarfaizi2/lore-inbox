Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbUJWS5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbUJWS5B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 14:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbUJWS5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 14:57:01 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:46859 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S261273AbUJWS4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 14:56:40 -0400
Date: Sat, 23 Oct 2004 11:51:32 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-U10.2
Message-ID: <20041023185132.GA1268@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022175633.GA1864@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 07:56:33PM +0200, Ingo Molnar wrote:
> 
> i have released the -U10.2 Real-Time Preemption patch, which can be
> downloaded from:
> 
>   http://redhat.com/~mingo/realtime-preempt/

On realtime-preempt-2.6.9-mm1-U10.3:

o	In rcupdate.h, I believe that the:

	+# define rcu_read_unlock_nort()                rcu_read_lock_nort()

	should instead be:

	+# define rcu_read_unlock_nort()                rcu_read_unlock()

	It looks to me like the current definition would cause
	preemption to be permanently disabled in a kernel with
	CONFIG_PREEMPT but without CONFIG_PREEMPT_REALTIME,
	at least if one used SysV IPC.

o	The rcu_read_lock_spin(), rcu_read_lock_read(),
	rcu_read_lock_bh_read(), rcu_read_lock_sem(), and
	rcu_read_lock_bh_spin() APIs cannot be called recursively.
	But you probably already knew that.  ;-)

	I don't understand why the rcu_read_lock_sem() API gets its
	own #ifdef.

o	Some recent RCU patches acquire the update-side lock
	under rcu_read_lock(), which I believe will deadlock here.
	Since the same CPU/task is acquiring the same lock twice, I don't
	believe that the mutex mods help, but could easily be mistaken.
	Then again, this may well be why there are all the emails on
	this thread advising that SELinux be disabled.

							Thanx, Paul

> this is a fixes-only release.
> 
> Changes since -U10:
> 
>  - fixed a big bug present ever since: the BKL got dropped when a
>    spinlock-mutex was acquired and it scheduled away. This reduced the
>    locking efficiency of the BKL. A number of outstanding problems could
>    be affected, in particular this should fix the tty locking breakage
>    reported by Alexander Batyrshin and Adam Heath. UP and SMP systems 
>    are affected too, with SMP systems having a higher chance to trigger
>    this condition.
> 
>  - tulip.c breakage fix from Thomas Gleixner
> 
>  - tg3 and 3c59x fixes.
> 
>  - made the hardirq threads SCHED_FIFO by default. They get priorities 
>    between 25 and 50, depending on the irq #. (this is pretty random but 
>    i found no better scheme.) Made the softirq thread SCHED_FIFO by 
>    default as well, albeit this probably will have to change. These 
>    changes should make it easier to debug a hung system.
> 
> to create a -U10.2 tree from scratch, the patching order is:
> 
>    http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
>  + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9/2.6.9-mm1/2.6.9-mm1.bz2
>  + http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-mm1-U10.2
> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
