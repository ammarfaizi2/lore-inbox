Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292418AbSBUPBw>; Thu, 21 Feb 2002 10:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292419AbSBUPBn>; Thu, 21 Feb 2002 10:01:43 -0500
Received: from mx2.elte.hu ([157.181.151.9]:20642 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S292418AbSBUPB3>;
	Thu, 21 Feb 2002 10:01:29 -0500
Date: Thu, 21 Feb 2002 17:59:37 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Erich Focht <focht@ess.nec.de>
Cc: Paul Jackson <pj@engr.sgi.com>, Robert Love <rml@tech9.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Dobson <colpatch@us.ibm.com>,
        lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [PATCH] O(1) scheduler set_cpus_allowed for non-current tasks
In-Reply-To: <Pine.LNX.4.21.0202211154190.12765-100000@sx6.ess.nec.de>
Message-ID: <Pine.LNX.4.33.0202211748410.15388-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Feb 2002, Erich Focht wrote:

> well I whished this kind of feedback came at my first attempt to have
> a discussion on this subject. Would have saved me lots of reboots :-)

i did not find out about the most fundamental problem until today, when i
tried to merge your patch. Much of Linux's development is trial & err, i
do that all the time as well.

> The reaction those days was:
>
> Ingo> your patch does not solve the problem, the situation is more
> Ingo> complex. What happens if the target task is not 'current' and is
> Ingo> running on some other CPU? If we send the migration interrupt then
> Ingo> nothing guarantees that the task will reschedule anytime soon, so
> Ingo> the target CPU will keep spinning indefinitely. There are other
> Ingo> problems too, like crossing calls to set_cpus_allowed(), etc. Right
> Ingo> now set_cpus_allowed() can only be used for
> Ingo> the current task, and must be used by kernel code that knows what it
> Ingo> does.
>
> and later:
>
> Ingo> well, there is a way, by fixing the current mechanizm. But since
> Ingo> nothing uses it currently it wont get much testing. I only pointed
> Ingo> out that the patch does not solve some of the races.
>
> So I kept Ingo's design idea of sending IPIs. And I made it survive
> crossing calls and avoid spinning around for long time, specially in
> interrupt.

the fundamental problem is with wait_task_inactive() called from IRQ
contexts - it can spin indefinitely. The above comments list some of the
other problems, and those can indeed be solved by extending the IPI
delivery mechanism, which you did.

migration threads are a variation of the current scheduler as well -the
schedule()/wakeup() hotpath did not have to be touched.

	Ingo

