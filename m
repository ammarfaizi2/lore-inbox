Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268148AbTBNAF2>; Thu, 13 Feb 2003 19:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268149AbTBNAF2>; Thu, 13 Feb 2003 19:05:28 -0500
Received: from jazz-1.trumpet.com.au ([203.5.119.62]:37897 "EHLO
	jazz-1.trumpet.com.au") by vger.kernel.org with ESMTP
	id <S268148AbTBNAFR>; Thu, 13 Feb 2003 19:05:17 -0500
Date: Fri, 14 Feb 2003 11:14:59 +1100 (EST)
From: Peter Tattam <peter@jazz-1.trumpet.com.au>
To: Andi Kleen <ak@suse.de>
cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [discuss] Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
In-Reply-To: <20030213180705.GB27560@wotan.suse.de>
Message-ID: <Pine.BSF.3.96.1030214103845.369E-100000@jazz-1.trumpet.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2003, Andi Kleen wrote:

> [Hmm, this is becomming a FAQ]
> 
> > Switching in and out of long mode is evil enough that I don't think it
> > is worth it.  And encouraging people to write good JIT compiling
> 
> Forget it. It is completely undefined in the architecture what happens
> then. You'll lose interrupts and everything. Nothing for an operating
> system intended to be stable.
> 
> I have no plans at all to even think about it for Linux/x86-64.

I have given this some thought even though the accepted wisdom is to avoid it.

As far as I can tell, there are only two critical structures which need to be
warped.  You would need to have a legacy set of page tables ready to go, and a
new IDT which is used only for legacy mode.  If an IRQ or execption happens in
legacy mode, you warp the CPU back to long mode to handle it and then warp
back.  

The concept of warping the CPU is being formalized in the plex86 project anyway
and is likely to become more common as time goes on.  (warping is replacing
GDT/IDT/LDT/CR3 etc by stubs which then warp back to the host when anything
"interesting" happens) 

So as far as I can tell, a switch to v86 mode requires reloading page tables
(this would happen on a typical task context switch anyway), and switching the
IDT. GDT,LDT and TR can stay as is since these should trap to #GP which is
handled by the IDT change. I can't see why you would want to touch the PIC or
APIC at all, and this is usually what causes the loss of interrupts when
handling this kind of thing.

The only other unknown quantity is the time it takes for the CPU to
enable/disable long mode, but with modern CPU speeds, the interrupt latency may
only be mildy affect by such a process, unless the CPU is broken in some way. 
I see no discussion in the AMD manuals regarding the cost of the mode switch,
only what AMD engineers have hinted at.

> 
> > emulators sounds much better, especially in the long run.  But it can
> > be written.
> 
> For DOS even a slow emulator should be good enough. After all most
> DOS Programs are written for slow machines. Bochs running on a K8
> will be hopefully fast enough. If not an JIT can be written, perhaps
> you can extend valgrind for it.
> 
> Or if you really rely on a DOS program executing fast you can
> always boot a 32bit kernel which of course still supports vm86
> in legacy mode.

While an emulator sounds like a good idea, it is baggage that needs to be
included.  JIT is probably overkill if the hardware can already do it.

If the use for running v86 code is infrequent, the cost in CPU cycles to change
modes may be neglible anyway.  

If it's for regular use (e.g. an MSDOS box), I am sure the scheduler could take
into account that a v86 context switch is more expensive than a normal one and
steps could be taken to avoid it.

I contend that if the thunking code is reasonably well defined and thought out,
jumping in & out of long mode might not be as big a hassle as originally
thought.

I have a need to run v86 code from ring 0, so I'm not keen to slip other
people's code in there.  This would mean I'd need to write a v86 emulator from
scratch which I think is more time than writing the warping code that I've
suggested.

I am going have a go at doing it anyway and I'll let you know my results when I
get some real hardware. 

> 
> -Andi
> 


Peter

--
Peter R. Tattam                            peter@trumpet.com
Managing Director,    Trumpet Software International Pty Ltd
Hobart, Australia,  Ph. +61-3-6245-0220,  Fax +61-3-62450210

