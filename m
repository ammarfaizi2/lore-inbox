Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274706AbRITXmJ>; Thu, 20 Sep 2001 19:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274713AbRITXmB>; Thu, 20 Sep 2001 19:42:01 -0400
Received: from barry.mail.mindspring.net ([207.69.200.25]:49702 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274706AbRITXlu>; Thu, 20 Sep 2001 19:41:50 -0400
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems
From: Robert Love <rml@tech9.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Andrew Morton <akpm@zip.com.au>, Chris Mason <mason@suse.com>,
        Beau Kuiper <kuib-kl@ljbc.wa.edu.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <20010921011514.M729@athlon.random>
In-Reply-To: <20010920170812.CCCACE641B@ns1.suse.com>
	<3BAA29C2.A9718F49@zip.com.au> <1001019170.6090.134.camel@phantasy>
	<200109202112.f8KLCXG16849@zero.tech9.net>
	<1001024694.6048.246.camel@phantasy> <20010921003742.I729@athlon.random>
	<1001026597.6048.278.camel@phantasy>  <20010921011514.M729@athlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.19.21.54 (Preview Release)
Date: 20 Sep 2001 19:41:45 -0400
Message-Id: <1001029314.6941.19.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-09-20 at 19:15, Andrea Arcangeli wrote:
> All I'm saying is that you should check for >= 0, not == 0.

And I am saying we already keep track of that, we have a preemption
counter.

> But anwyays it's pretty depressing to see such a costly check needed to
> get latency right with the preemptive kernel approch, with
> non-preemptive kernel we'd need to just check need_resched and a call
> schedule in the unlikely case so it would be even lighter :) and no
> fixed costs in UP spinlocks, per-cpu datastrctures etc... The point of
> preemptive kernel would be just to prevent us to put such kind of
> explicit (costly) checks in the code. My theory was that the cpu-costly
> loops are mostly protected by some lock anyways and the fact you're
> writing such horrid (but helpful) code is a kind of proof.

Well, with the preemptive kernel we already account for 90% of the high
latency areas.

Doing the "horrid" solution may solve some other issues, but agreeably
you are right its not the prettiest solution.

I don't agree, however, that its that much more costly, and maybe I am
missing something.  Assuming we are SMP (and thus have locks), where is
there a lot more overhead?  We check current->need_resched (which we
dont _have_ to), call unlock_kernel() and then call lock_kernel(), with
preemption happening automatically in between.  The preemption code
merely checks a counter and calls preempt_schedule() if needed.

Now, yes, this is not ideal.  Ideally we don't need any of this muck. 
Ideally preemption provides everything we need.  So, towards the future,
we can work towards that.  For very short locks, we could just disable
interrupts (a lot less overhead).  For long-held locks, we can replace
them with a more efficient lock -- spin-then-sleep or a
priority-inheriting mutex lock, for example.

I don't want to confuse the above, which is perhaps an ideal system for
inclusion in 2.5, with trying to lower latency further for those who
care via conditional scheduling and the such.

We already have average latency of <1ms with peaks 10-50ms.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

