Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129531AbQJaWuC>; Tue, 31 Oct 2000 17:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129766AbQJaWtx>; Tue, 31 Oct 2000 17:49:53 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:23307 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129673AbQJaWtd>; Tue, 31 Oct 2000 17:49:33 -0500
Message-ID: <39FF4B99.1746E06E@timpanogas.org>
Date: Tue, 31 Oct 2000 15:45:45 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>, mingo@elte.hu, Pavel Machek <pavel@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <Pine.LNX.4.21.0010312231490.15159-100000@elte.hu> <39FF3F0B.81A1EE13@timpanogas.org> <20001031230538.A9048@gruyere.muc.suse.de> <39FF465F.4EEB811A@timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



One more optimization it has.  NetWare never "calls" functions in the
kernel.  There's a template of register assignments in between kernel
modules that's very strict (esi contains a WTD head, edi has the target
thread, etc.) and all function calls are jumps in a linear space. 
layout of all functions are 16 bytes aligned for speed, and all
arguments in kernel are passed via registers.  It's a level of
optimization no C compiler does -- all of it was done by hand, and most
function s in fast paths are layed out in 512 byte chunks to increases
speed.  Stack memory activity in the NetWare kernel is almost
non-existent in almost all of the "fast paths"

Jeff

"Jeff V. Merkey" wrote:
> 
> A "context" is usually assued to be a "stack".  The simplest of all
> context switches
> is:
> 
>    mov    x, esp
>    mov    esp, y
> 
> A context switch can be as short as two instructions, or as big as a TSS
> with CR3 hardware switching,
> 
> i.e.
> 
>    ltr    ax
>    jmp    task_gate
> 
> (500 clocks later)
> 
>    ts->eip gets exec'd
> 
> you can also have a context switch that does an int X where X is a gate
> or TSS.
> 
> you can also have a context switch (like linux) that does
> 
>     mov    x, esp
>     mov    esp, y
>     mov    z, CR3
>     mov    CR3, w
> 
> etc.
> 
> In NetWare, a context switch is an in-line assembly language macro that
> is 2 instructions long for a stack switch and 4 instructions for a CR3
> reload -- this is a lot shorter than Linux.
> Only EBX, EBP, ESI, and EDI are saved and this is never done in the
> kernel, but is a natural
> affect of the Watcom C compiler.  There's also strict rules about
> register assignments that re enforced between assembler modules in
> NetWare to reduce the overhead of a context switch.  The code path is
> very complex in NetWare, and priorities and all this stuff exists, but
> these code paths are segragated so these types of checks only happen
> once in a while and check a pre-calc'd "scoreboard" that is read only
> across processors and updated and recal'd by a timer every 18 ticks.
> 
> Jeff
> 
> 
> 
> Andi Kleen wrote:
> >
> > On Tue, Oct 31, 2000 at 02:52:11PM -0700, Jeff V. Merkey wrote:
> > > The numbers don't lie.  You know where the code is.  You notice that
> > > there is a version of
> > > the kernel hand coded in assembly language.  You'l also noticed that
> > > it's SMP and takes ZERO LOCKS during context switching, in fact, most of
> > > the design is completely lockless.
> >
> > I suspect most of the confusion in this thread comes because you seem to
> > use a different definition of context switch than Ingo and others. Could
> > you explain what you exactly mean with a context switch ?
> >
> > -Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
