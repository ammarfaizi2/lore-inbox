Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313611AbSDPGHt>; Tue, 16 Apr 2002 02:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313613AbSDPGHs>; Tue, 16 Apr 2002 02:07:48 -0400
Received: from gold.muskoka.com ([216.123.107.5]:8199 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S313611AbSDPGHs>;
	Tue, 16 Apr 2002 02:07:48 -0400
Message-ID: <3CBBBBE4.42B32ED6@yahoo.com>
Date: Tue, 16 Apr 2002 01:51:32 -0400
From: Paul Gortmaker <p_gortmaker@yahoo.com>
MIME-Version: 1.0
To: Simon Kirby <sim@netnation.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.4.16] Clock locking bugs?
In-Reply-To: <20020114180215.GA20200@netnation.com> <20020413192105.GA853@netnation.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You've just given another example of why set_rtc_mmss should die (or at a 
minimum, not be enabled by default) - the timer died, and it wants to push 
its incorrect time onto the rtc as well.  I've posted patches to this effect 
several times before; now that we are into 2.5, I'll push them again...

I doubt that such a change would influence your timer problem, but feel 
free to #if 0  out the set_rtc_mmss routine, and the cruft that calls
it from the timer interrupt - i.e. if (time_status & STA_UNSYNC) 
in arch/i386/kernel/time.c  - you can then make the *policy* decision
in userspace as to whether you want to sync the rtc with the kernel time.

[At a minimum, I guarantee the annoying set_rtc_mmss messages go away :) ]

Paul.

Simon Kirby wrote:
> 
> Hrm...Just had this happen on my dual celeron desktop, exactly the same
> problem.  Kernel 2.5.7.  Everything I typed in an rxvt was one character
> lagged. :)
> 
> Simon-
> 
> On Mon, Jan 14, 2002 at 10:02:15AM -0800, Simon Kirby wrote:
> 
> > Just had a server's clock stop at 9:02:30am.  Very interesting
> > results:
> >
> > [sroot@pro:/]# cat /proc/interrupts
> >            CPU0       CPU1
> >   0:  172839353  172896882    IO-APIC-edge  timer
...
> > [sroot@pro:/]# cat /proc/interrupts
> >            CPU0       CPU1
> >   0:  172839353  172896882    IO-APIC-edge  timer
> >
> > Alan says this is due to locking problems with the timer I/O code.
> >
> > On the console were a lot of "set_rtc_mmss: can't update from 79 to 32"
> > type messages that have always happened on SMP kernels with ntpd.
> >
> > Has anybody created any patches for this?

