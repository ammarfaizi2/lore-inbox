Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277054AbRJHSLa>; Mon, 8 Oct 2001 14:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277059AbRJHSLZ>; Mon, 8 Oct 2001 14:11:25 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:21755 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S277054AbRJHSLM>; Mon, 8 Oct 2001 14:11:12 -0400
Message-ID: <3BC1EC40.9B1BF68E@mvista.com>
Date: Mon, 08 Oct 2001 11:11:12 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederman@uswest.net>
CC: Victor Yodaiken <yodaiken@fsmlabs.com>,
        BALBIR SINGH <balbir.singh@wipro.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] I still see people using cli()
In-Reply-To: <20011008084950.B16204@hq2> <m1itdqw4hu.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> Victor Yodaiken <yodaiken@fsmlabs.com> writes:
> 
> > On Mon, Oct 08, 2001 at 07:59:05PM +0530, BALBIR SINGH wrote:
> > > BTW, that brings me to another issue, once the kernel becomes preemptibel,
> > what
> >
> > > are the locking issues? how are semaphores and spin-locks affected? Has
> > anybody
> >
> > > defined or come up with the rules/document yet?
> >
> > IF the kernel becomes preemptible it will be so slow, so buggy, and so painful
> > to maintain, that those issues won't matter.
> 
> The preemptible kernel work just takes the current SMP code, and
> allows it to work on a single processor.  You are not interruptted if
> you have a lock held.  This makes the number of cases in the kernel
> simpler, and should improve maintenance as more people will be
> affected by the SMP issues.
> 
> Right now there is a preemptible kernel patch being maintained
> somewhere.  I haven't had a chance to look recently.  But the recent
> threads on low latency mentioned it.
> 
> As for rules.  They are the usual SMP rules.  In earlier version there
> was a requirement or that you used balanced constructs.
> 
> i.e.
> spin_lock_irqsave
> ...
> spin_unlock_irqrestore
> 
> and not.
> 
> spin_lock_irqsave
> ...
> spin_unlock
> ..
> restore_flags.
> 
This rule is not there any more, but there are a few more:

SMP code that uses the cpu number (i.e. cpu data structures, etc.) and
thus depends on staying on that cpu, should be protected to prevent
preemption, which, MAY move the task to another cpu.  Currently there is
code in the preemption patch to prevent this movement, however, it would
be faster to allow it and protect the areas that care.

Also, areas that use hareware resources that are not saved on preemption
must be protected.  In the x86 this includes some of the MMX code which
uses the fp registers.  

We also had some problems with the page info register on page faults,
however this proved to be a hazard in systems without preemption and
thus was fixed.

George
