Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbVHMA2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVHMA2o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 20:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbVHMA2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 20:28:44 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:54168 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750734AbVHMA2o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 20:28:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QUO2mSM9V8uM+huUqf427v5LCHudy+GUgH55+w/mQQxFMxh4E7/mLEQ6MMTC0llUJ+0R9FdEB8PQQYQul9P1wKEHz1i1j+i0ffwInuP0KU2l03H0WT2AI/zfx6cW0r3sDJ1vY3pyL3jjxvB+s78igDMIStwZugP9VMIO8HVWBhg=
Message-ID: <1c1c8636050812172817b14384@mail.gmail.com>
Date: Sat, 13 Aug 2005 12:28:43 +1200
From: Ryan Brown <some.nzguy@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.53-01, High Resolution Timers & RCU-tasklist features
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       george anzinger <george@mvista.com>
In-Reply-To: <20050811110051.GA20872@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050811110051.GA20872@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

is there a patch available for -rc6?

On 8/11/05, Ingo Molnar <mingo@elte.hu> wrote:
> 
> i have released the -53-01 Real-Time Preemption patch, which can be
> downloaded from:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 
> there are two new features in this release, which justified the jump
> from .52 to .53:
> 
>  - the inclusion of the High Resolution Timers patch, written by
>    George Anzinger, and ported/improved/cleaned-up by Thomas Gleixner.
> 
>  - the inclusion of the RCU tasklist_lock patch from Paul McKenney.
> 
> the HRT patch from George Anzinger is a crutial piece of real-time
> infrastructure. The version included in the -RT tree supports both PIT
> and local APIC timer driven variable-rate timer interrupts.
> 
> Thomas Glexiner, besides porting it to PREEMPT_RT, cleaning it up,
> adding the local APIC timer support has also added the
> CONFIG_HIGH_RES_TIMERS_DYN_PRIO feature, which pushes priority
> inheritance into the high-res timer space. Furthermore, Thomas has
> extended nanosleep to use HR timers, if the task is RT. This makes it
> easier to test HRT functionality.
> 
> NOTE: there's a new softirq, softirq-hrtimer (PID 8 on UP x86), which
> should be chrt-ed to higher than SCHED_FIFO-50 if HR timer interrupts
> are the most important latencies in the system. E.g.:
> 
>   chrt -f 90 -p 8
> 
> the RCU tasklist-lock patch is a small but important feature from Paul
> McKenney which enables good HRT latencies: the HRT patch, when using
> POSIX timers, would use a signal-sending codepath that depends on the
> tasklist_lock, and thus the (quite high) tasklist_lock latencies
> controlled the latency of HR timers - defeating much of the benefits of
> HR timers. With the RCU tasklist-lock the signal sending path is now
> RCU-read locked, with no locking dependency, and thus excellent
> worst-case latencies.
> 
> given these changes, some (mostly build-related) regressions are to be
> expected. Only the x86 architecture is expected to work for now.
> 
> to build a -V0.7.53-01 tree, the following patches should to be applied:
> 
>    http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.12.tar.bz2
>    http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.13-rc4.bz2
>    http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.13-rc4-RT-V0.7.53-01
> 
> patches, bugreports and any other feedback welcome,
> 
>         Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
