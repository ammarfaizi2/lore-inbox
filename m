Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318264AbSGXHsd>; Wed, 24 Jul 2002 03:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318260AbSGXHsd>; Wed, 24 Jul 2002 03:48:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23823 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318264AbSGXHsc>;
	Wed, 24 Jul 2002 03:48:32 -0400
Message-ID: <3D3E5E80.EA769517@zip.com.au>
Date: Wed, 24 Jul 2002 01:00:00 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Robert Love <rml@tech9.net>, george anzinger <george@mvista.com>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] irqlock patch -G3. [was Re: odd memory corruptionin2.5.27?]
References: <3D3E1B66.F17D8B9E@zip.com.au> <Pine.LNX.4.44.0207240932430.2193-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> On Tue, 23 Jul 2002, Andrew Morton wrote:
> 
> > Robert and George's patch doesn't seem to be optimal though - if we're
> > not going to preempt at spin_unlock() time, we need to preempt at
> > local_irq_restore() time.  It'll be untrivial to fix all this, but this
> > very subtle change to the locking semantics with CONFIG_PREEMPT is quite
> > nasty.
> 
> this is precisely the reason why we cannot pretend these bugs do not exist
> and just work this around in preempt_schedule().

But there is no bug in slab.  The bug is that spin_unlock() is
scheduling inside local_irq_disable().

> Code that relies on
> cli/sti for atomicity should be pretty rare and limited, there's 1 known
> case so far where it leads to bugs.

Are you implying that all code which does spin_unlock() inside
local_irq_disable() needs to be converted to use _raw_spin_unlock()?
If so then, umm, ugh.  I hope that the debug check is working
for CONFIG_PREEMPT=n.

BTW, what is the situation with spin_unlock_irq[restore]()?  Seems
that these will schedule inside local_irq_disable() quite a lot?

-
