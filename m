Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbVJNTlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVJNTlE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 15:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbVJNTlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 15:41:04 -0400
Received: from xproxy.gmail.com ([66.249.82.192]:51981 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750772AbVJNTlC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 15:41:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=co0h7nFRNFSURTpa4yRc11HoXKk52osfvGnxJMEI21ohthJMaAckPqaXHpU5QfZ5wPR+2BxbEluRG50VmvvbFjcwnheqn6igCDbStNKQN5fvlSz65vnK8g/MheH3WbDTPrlinwBcymcTSbJsiUZGcnevQEVIITa+abdva4HLrRY=
Message-ID: <5bdc1c8b0510141240r2c90094bx96835c84e49049ce@mail.gmail.com>
Date: Fri, 14 Oct 2005 12:40:59 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rc4-rt1 - enable IRQ-off tracing causes kernel to fault at boot
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
In-Reply-To: <5bdc1c8b0510140756u1b006de9td552539421666bec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510121000i5db112f2p642f66686fb46c57@mail.gmail.com>
	 <20051013073029.GA12801@elte.hu>
	 <5bdc1c8b0510130526k6064c640pecded9ccb0ef7dde@mail.gmail.com>
	 <Pine.LNX.4.58.0510130844070.13098@localhost.localdomain>
	 <5bdc1c8b0510131210i64f7f289q557368b056e59e18@mail.gmail.com>
	 <20051014035230.GB6513@elte.hu>
	 <5bdc1c8b0510140756u1b006de9td552539421666bec@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/05, Mark Knecht <markknecht@gmail.com> wrote:
> On 10/13/05, Ingo Molnar <mingo@elte.hu> wrote:
> >
> > * Mark Knecht <markknecht@gmail.com> wrote:
> >
> > > Ingo & Steve,
> > >    Thank you for your great instructions that even a guitar player
> > > could basically follow. After about an hour of messing around I did
> > > manage to capture the crash. The console file is attached.
> > >
> > > NOTE: The first time I booted the kernel it got to the crash point and
> > > the machine rebooted. The second time it booted I got the trace. Both
> > > boots are in the capture file.
> >
> > thanks, this log is much more informative. No smoking gun though, but it
> > seems something fundamental (probably lowlevel x64 code) has been broken
> > by -rt1.
> >
> > Do the crashes go away if you take the -rc3-rt13 version of
> > arch/x86_64/kernel/entry.S and copy it over into the -rc4-rt1 tree?
> > [this undoes a particular set of CONFIG_CRITICAL_IRQSOFF_TIMING fixes
> > from the x64 code, which i did during -rc3-rt13 => -rc4-rt1]
>
> Indeed it is fixed by doing this. Options are on but the modified
> kernel does boot:

Ingo,
   Good news and strange news:

GOOD NEWS: This problem may or may not be fixed in 2.6.14-rc4-rt5. The
kernel now boots for me with IRQoff tracing enabled, but once again
I'm seeing times that appear to be the timer frequency:

( softirq-timer/0-3    |#0): new 998 us maximum-latency critical section.
 => started at timestamp 403325647: <acpi_processor_idle+0x20/0x379>
 =>   ended at timestamp 403326645: <thread_return+0xb5/0x11a>

Call Trace:<ffffffff8014e58c>{check_critical_timing+492}
<ffffffff8014e9e5>{sub_preempt_count_ti+133}
       <ffffffff803edaec>{thread_return+70}
<ffffffff803edb5b>{thread_return+181}
       <ffffffff803edcc5>{schedule+261} <ffffffff8013723a>{ksoftirqd+138}
       <ffffffff801371b0>{ksoftirqd+0} <ffffffff8014757d>{kthread+205}
       <ffffffff8010e70e>{child_rip+8} <ffffffff801474b0>{kthread+0}
       <ffffffff8010e706>{child_rip+0}
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<ffffffff803ed5b8>] .... __schedule+0xb8/0x5a6
.....[<00000000>] ..   ( <= _stext+0x7feff0e8/0xe8)

 =>   dump-end timestamp 403326728

lightning ~ #

STRANGE NEWS: It now takes between 1-2 minutes for Gnome to log out.

I think possibly something is not exactly right about the timers yet.

- Mark
