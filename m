Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318721AbSHLFXP>; Mon, 12 Aug 2002 01:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318723AbSHLFXP>; Mon, 12 Aug 2002 01:23:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47369 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318721AbSHLFXI>;
	Mon, 12 Aug 2002 01:23:08 -0400
Message-ID: <3D574972.DD878928@zip.com.au>
Date: Sun, 11 Aug 2002 22:36:50 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Skip Ford <skip.ford@verizon.net>
CC: "Adam J. Richter" <adam@yggdrasil.com>, ryan.flanigan@intel.com,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.5.31: modules don't work at all
References: <200208120233.TAA16322@adam.yggdrasil.com> <200208120307.g7C37AuF000184@pool-141-150-241-241.delv.east.verizon.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Skip Ford wrote:
> 
> ...
> >       I already know that the error that trips insmod occurs at
> > in modules.c, line 831, when qm_symbols gets an error from copy_to_user():
> >
> >         for (; i < mod->nsyms ; ++i, ++s, vals += 2) {
> >                 len = strlen(s->name)+1;
> >                 if (len > bufsize)
> >                         goto calc_space_needed;
> >
> > here------>     if (copy_to_user(strings, s->name, len)
> >                     || __put_user(s->value, vals+0)
> >                     || __put_user(space, vals+1))
> >                         return -EFAULT;
> >
> >                 strings += len;
> >                 bufsize -= len;
> >                 space += len;
> >         }
> >
> >       The values of strings and s->name are similar in 2.5.30+preempt
> > (works) and 2.5.31+preempt (does not work).  strings is 0x08______, and
> > s->name is 0xc0______.
> 
> If I back out this change to arch/i386/mm/fault.c then modules
> successfully load.  I have no idea if backing it out causes other
> problems though.
> 
> diff -Nru a/arch/i386/mm/fault.c b/arch/i386/mm/fault.c
> --- a/arch/i386/mm/fault.c      Sat Aug 10 18:42:20 2002
> +++ b/arch/i386/mm/fault.c      Sat Aug 10 18:42:20 2002
> @@ -181,10 +181,10 @@
>         info.si_code = SEGV_MAPERR;
> 
>         /*
> -        * If we're in an interrupt or have no user
> -        * context, we must not take the fault..
> +        * If we're in an interrupt, have no user context or are running in an
> +        * atomic region then we must not take the fault..
>          */
> -       if (in_interrupt() || !mm)
> +       if (preempt_count() || !mm)
>                 goto no_context;
> 
>         down_read(&mm->mmap_sem);
> 

Yes, that's the problem.   qm_symbols() is performing copy_to_user()
inside lock_kernel() and that's an "atomic copy_to_user()" in 2.5.31.
But only if preempt is selected.  The copy_to_user() doesn't work.

There's nothing illegal about copy_to_user() inside lock_kernel().

Linus, we can back out the preempt_count() test in there and
perform the atomic copy_*_user via a current->flags bit, or
we can do something else?
