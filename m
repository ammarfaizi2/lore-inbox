Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319377AbSH2VDl>; Thu, 29 Aug 2002 17:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319378AbSH2VDl>; Thu, 29 Aug 2002 17:03:41 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:36847 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S319377AbSH2VDk>;
	Thu, 29 Aug 2002 17:03:40 -0400
Message-ID: <3D6E8CF9.D07253A2@mvista.com>
Date: Thu, 29 Aug 2002 14:07:05 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Andrew Morton <akpm@zip.com.au>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc. kernel preemption bits
References: <1030635181.978.2559.camel@phantasy> 
		<3D6E66D5.A97E5CF3@zip.com.au> <1030648286.979.2597.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Thu, 2002-08-29 at 14:24, Andrew Morton wrote:
> 
> > Robert Love wrote:
> > >
> > > ...
> > >         - we have a debug check in preempt_schedule that, even
> > >           on detecting a schedule with irqs disabled, still goes
> > >           ahead and reschedules.  We should return. (me)
> > >
> >
> > OK, but that warning will still come out of the mess in mm/slab.c.
> 
> Yah I saw your previous post.  There is also a report or two re oops on
> poisoned memory with SLAB_DEBUG and preempt enabled - which should be
> fixed by the above return but one report says it does not.
> 
> Anyhow, your new methods are fine... if they work, they work.
> 
> I am starting to get concerned over the number of routines we are having
> to define.  It is getting complicated (i.e. the
> inc_preempt_non_preempt() stuff).
> 
> Maybe keep these local to mm/slab.c ?

Robert, I think what is needed is the changes I sent you for
spinlock.h and system.h.  Could you convert to 2.5 and post?

All, I defined:
local_irq_restore_preempt(x)
local_irq_enable_preempt() 
local_irq_restore_ck_preempt(x)
local_irq_enable_ck_preempt()

The preempt versions are to be used in the spin_unlock_*
macros.  The ck_preempt versions in open code where we do
need to check preemption.  I also redefined:
local_irq_enable()
local_irq_restore(x)
to call _local_irq_* and then test_preempt(x). 
test_preempt() then, if CONFIG_ enables, prints warning
message the first time a test AFTER the irq restore finds a
preemptable condition AND if restore, the interrupt system
is now on.

The net result is that all the code is the same, but we can
now turn on a test to see if there are some preemptions we
are missing.  Usually this would come from turning off
interrupts while wake-up is called.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
