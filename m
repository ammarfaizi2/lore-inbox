Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267702AbUJLTzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267702AbUJLTzX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 15:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267720AbUJLTzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 15:55:23 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:40864
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S267702AbUJLTyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 15:54:24 -0400
Subject: Re: [Ext-rt-dev] Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: dwalker@mvista.com
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       amakarov@ru.mvista.com, ext-rt-dev@mvista.com,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1097607049.9548.108.camel@dhcp153.mvista.com>
References: <41677E4D.1030403@mvista.com> <20041010084633.GA13391@elte.hu>
	 <1097437314.17309.136.camel@dhcp153.mvista.com>
	 <20041010142000.667ec673.akpm@osdl.org> <20041010215906.GA19497@elte.hu>
	 <1097517191.28173.1.camel@dhcp153.mvista.com>
	 <20041011204959.GB16366@elte.hu>
	 <1097607049.9548.108.camel@dhcp153.mvista.com>
Content-Type: text/plain
Organization: linutronix
Message-Id: <1097610393.19549.69.camel@thomas>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 12 Oct 2004 21:46:34 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-12 at 20:50, Daniel Walker wrote:
> > what do you think about the PREEMPT_REALTIME stuff in -T4? Ideally, if
> > you agree with the generic approach, the next step would be to add your
> > priority inheritance handling code to Linux semaphores and
> > rw-semaphores. The sched.c bits for that looked pretty straightforward.
> > The list walking is a bit ugly but probably unavoidable - the only other
> > option would be 100 priority queues per semaphore -> yuck.
>
> I think patch size is an issue, but I also think that , eventually, we
> should change all spin_lock calls that actually lock a mutex to be more
> distinct so it's obvious what is going on. Sven and I both agree that
> this should be addressed. Is this a non-issue for you? What does the
> community want? I don't find your code or ours acceptable in it's
> current form , due to this issue.
> 
> With the addition of PREEMPT_REALTIME it looks like you more than
> doubled the size of voluntary preempt. I really feel that it should
> remain as two distinct patches. They are dependent , but the scope of
> the changes are too vast to lump it all together. 
> 

Both patches (MV & Ingos) have their good bits, but both share the same
ugliness and are hard to compare and harder to combine. The conversion
of spin_lock to _spin_lock and substitution of spin_lock by mutexes,
semaphores or what ever makes it more than hard to keep the code in a
readable form.

If there is the tendency to touch the concurrency controls in general
all over the kernel, then I would suggest a script driven overhaul of
all concurrency controls like spin_locks, mutexes and semaphores to
general macros like 

enter_critical_section(TYPE, &var, &flags, whatever);
leave_critical_section(TYPE, &var, flags, whatever);

where TYPE might be SPIN_LOCK, SPIN_LOCK_IRQ, MUTEX, PMUTEX or whatever
we have and come up with in the future.

This could be done in a first step and then it is clearly identifiable
and it gives us more flexibility to wrap different implementations and
lets us change particular points in a more clear way.

I would be willing to provide some scripted conversion aid, if there is
enough interest to that. I started with some test files and the results
are quite encouraging.

Any thoughts ?

tglx






 

