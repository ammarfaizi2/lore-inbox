Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318882AbSHMAGH>; Mon, 12 Aug 2002 20:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318883AbSHMAGH>; Mon, 12 Aug 2002 20:06:07 -0400
Received: from monster.nni.com ([216.107.0.51]:49933 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S318882AbSHMAGG>;
	Mon, 12 Aug 2002 20:06:06 -0400
Date: Mon, 12 Aug 2002 20:09:08 -0400
From: Andrew Rodland <arodland@noln.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.31: modules don't work at all
Message-Id: <20020812200908.7e5331df.arodland@noln.com>
In-Reply-To: <3D574972.DD878928@zip.com.au>
References: <200208120233.TAA16322@adam.yggdrasil.com>
	<200208120307.g7C37AuF000184@pool-141-150-241-241.delv.east.verizon.net>
	<3D574972.DD878928@zip.com.au>
X-Mailer: Sylpheed version 0.8.1claws38 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Aug 2002 22:36:50 -0700
Andrew Morton <akpm@zip.com.au> wrote:
> Skip Ford wrote:
> > If I back out this change to arch/i386/mm/fault.c then modules
> > successfully load.  I have no idea if backing it out causes other
> > problems though.
> > 
> > diff -Nru a/arch/i386/mm/fault.c b/arch/i386/mm/fault.c
> > --- a/arch/i386/mm/fault.c      Sat Aug 10 18:42:20 2002
> > +++ b/arch/i386/mm/fault.c      Sat Aug 10 18:42:20 2002
> > @@ -181,10 +181,10 @@
> >         info.si_code = SEGV_MAPERR;
> > 
> >         /*
> > -        * If we're in an interrupt or have no user
> > -        * context, we must not take the fault..
> > +        * If we're in an interrupt, have no user context or are
> > running in an
> > +        * atomic region then we must not take the
> > fault..
> >          */
> > -       if (in_interrupt() || !mm)
> > +       if (preempt_count() || !mm)
> >                 goto no_context;
> > 
> >         down_read(&mm->mmap_sem);
> > 
> 
> Yes, that's the problem.   qm_symbols() is performing copy_to_user()
> inside lock_kernel() and that's an "atomic copy_to_user()" in 2.5.31.
> But only if preempt is selected.  The copy_to_user() doesn't work.
> 
> There's nothing illegal about copy_to_user() inside lock_kernel().

Does that mean that the above fix is a legal quick-fix and won't cause
things to fall apart, or does it mean that I shouldn't bother until the
next version?
