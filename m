Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274688AbRITW5N>; Thu, 20 Sep 2001 18:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274689AbRITW5D>; Thu, 20 Sep 2001 18:57:03 -0400
Received: from tisch.mail.mindspring.net ([207.69.200.157]:23062 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274688AbRITW47>; Thu, 20 Sep 2001 18:56:59 -0400
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems
From: Robert Love <rml@tech9.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Andrew Morton <akpm@zip.com.au>, Chris Mason <mason@suse.com>,
        Beau Kuiper <kuib-kl@ljbc.wa.edu.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <20010921003742.I729@athlon.random>
In-Reply-To: <20010920170812.CCCACE641B@ns1.suse.com>
	<3BAA29C2.A9718F49@zip.com.au> <1001019170.6090.134.camel@phantasy>
	<200109202112.f8KLCXG16849@zero.tech9.net>
	<1001024694.6048.246.camel@phantasy>  <20010921003742.I729@athlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.19.21.54 (Preview Release)
Date: 20 Sep 2001 18:56:04 -0400
Message-Id: <1001026597.6048.278.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-09-20 at 18:37, Andrea Arcangeli wrote:
> On Thu, Sep 20, 2001 at 06:24:48PM -0400, Robert Love wrote:
> >
> > if (current->need_resched && current->lock_depth == 0) {
> > 	unlock_kernel();
> > 	lock_kernel();
> > }

> nitpicking: the above is fine but it isn't complete, it may work for
> most cases but for a generic function it would be better implemented
> similarly to release_kernel_lock_save/restore so you take care of
> lock_depth > 0 too:

Let me explain a little about the patch, and then I am interested in if
your opinion changes.

When unlock_kernel() is called, the preemption code will be enabled and
check if the preemption count is non-zero -- its handled just like a
recursive lock.  If there are other locks held, preemption won't
happen.  Thus, we return to the caller code patch and lock_kernel() is
called and everyone is happy.

If unlock_kernel() is called, and the preemption code (which hangs off
the bottom of the locking code) sees that the lock depth is now 0, it
will call preempt_schedule (if needed) and allow a new process to run.
Then we return to the original code patch, call lock_kernel, and
continue.

Or am I missing something?

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

