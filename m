Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135648AbRALXMK>; Fri, 12 Jan 2001 18:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135691AbRALXMA>; Fri, 12 Jan 2001 18:12:00 -0500
Received: from mailgw.prontomail.com ([216.163.180.10]:13033 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S135648AbRALXLs>; Fri, 12 Jan 2001 18:11:48 -0500
Message-ID: <3A5F8E50.6720DF5E@mvista.com>
Date: Fri, 12 Jan 2001 15:08:00 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: nigel@nrg.org, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
In-Reply-To: <200101110519.VAA02784@pizda.ninka.net> <Pine.LNX.4.05.10101111233241.5936-100000@cosmic.nrg.org> <3A5F0706.6A8A8141@uow.edu.au>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> Nigel Gamble wrote:
> >
> > Spinlocks should not be held for lots of time.  This adversely affects
> > SMP scalability as well as latency.  That's why MontaVista's kernel
> > preemption patch uses sleeping mutex locks instead of spinlocks for the
> > long held locks.
> 
> Nigel,
> 
> what worries me about this is the Apache-flock-serialisation saga.
> 
> Back in -test8, kumon@fujitsu demonstrated that changing this:
> 
>         lock_kernel()
>         down(sem)
>         <stuff>
>         up(sem)
>         unlock_kernel()
> 
> into this:
> 
>         down(sem)
>         <stuff>
>         up(sem)
> 
> had the effect of *decreasing* Apache's maximum connection rate
> on an 8-way from ~5,000 connections/sec to ~2,000 conn/sec.
> 
> That's downright scary.
> 
> Obviously, <stuff> was very quick, and the CPUs were passing through
> this section at a great rate.

If <stuff> was that fast, maybe the down/up should have been a spinlock
too.  But what if it is changed to:

      BKL_enter_mutx()
      down(sem)
      <stuff>
      up(sem)
      BKL_exit_mutex()
> 
> How can we be sure that converting spinlocks to semaphores
> won't do the same thing?  Perhaps for workloads which we
> aren't testing?

The key is to keep the fast stuff on the spinlock and the slow stuff on
the mutex.  Otherwise you WILL eat up the cpu with the overhead.
> 
> So this needs to be done with caution.
> 
> As davem points out, now we know where the problems are
> occurring, a good next step is to redesign some of those
> parts of the VM and buffercache.  I don't think this will
> be too hard, but they have to *want* to change :)

They will *want* to change if they pop up due to other work :)
> 
> Some of those algorithms are approximately O(N^2), for huge
> values of N.
> 
> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
