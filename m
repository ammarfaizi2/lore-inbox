Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268238AbTBNISv>; Fri, 14 Feb 2003 03:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268240AbTBNISv>; Fri, 14 Feb 2003 03:18:51 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62760 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S268238AbTBNISt>; Fri, 14 Feb 2003 03:18:49 -0500
To: Peter Tattam <peter@jazz-1.trumpet.com.au>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [discuss] Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
References: <Pine.BSF.3.96.1030214103845.369E-100000@jazz-1.trumpet.com.au>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Feb 2003 01:27:37 -0700
In-Reply-To: <Pine.BSF.3.96.1030214103845.369E-100000@jazz-1.trumpet.com.au>
Message-ID: <m1el6b8dxi.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Tattam <peter@jazz-1.trumpet.com.au> writes:

> On Thu, 13 Feb 2003, Andi Kleen wrote:
>
> > For DOS even a slow emulator should be good enough. After all most
> > DOS Programs are written for slow machines. Bochs running on a K8
> > will be hopefully fast enough. If not an JIT can be written, perhaps
> > you can extend valgrind for it.

valgrind certainly sounds interesting.

> > Or if you really rely on a DOS program executing fast you can
> > always boot a 32bit kernel which of course still supports vm86
> > in legacy mode.
> 
> While an emulator sounds like a good idea, it is baggage that needs to be
> included.  JIT is probably overkill if the hardware can already do it.

A good JIT supporting infrastructure is a requirement of a high quality
implementation otherwise someone will complain.  But at the same time
only the inner loops really need to be optimized.  The rest of the code
will be much less noticable.

> If the use for running v86 code is infrequent, the cost in CPU cycles to change
> modes may be neglible anyway.  
> 
> If it's for regular use (e.g. an MSDOS box), I am sure the scheduler could take
> into account that a v86 context switch is more expensive than a normal one and
> steps could be taken to avoid it.

Nope that doesn't help.  The trap rate is ruled by the number of instructions
that must be emulated.  Not by the timer.  I haven't profiled this closely but
it matches with my experience with dosemu.  Given the increasing cost of traps,
and the relative fixed frequency of instructions that require traps to
be emulated, I believe it can be shown that using the native cpu is an
increasing bad idea.

The worst case is using an ega 4 plane mode, and emulating it.  Which
is actually faster to emulate all of the instructions in than to take
traps when there are instructions you must emulate.

> I contend that if the thunking code is reasonably well defined and thought out,
> jumping in & out of long mode might not be as big a hassle as originally
> thought.

I contend that v86 mode has stunted the growth of more powerful techniques on
Linux because v86 mode is so trivial to use.  Not implementing v86 mode in
the kernel of x86-64 should encourage all of the nice techniques that need to
be built.

For most JIT recompilation all that needs to be written is a fast loop
scanning for instructions that must be emulated.  If those instructions
are not present on a page the page is good to go.  For questionable pages
you can do something else.

> I have a need to run v86 code from ring 0, so I'm not keen to slip other
> people's code in there.  This would mean I'd need to write a v86 emulator from
> scratch which I think is more time than writing the warping code that I've
> suggested.
> 
> I am going have a go at doing it anyway and I'll let you know my results when I
> get some real hardware. 

You don't want to try it in the simulator?  Is it to slow for you?

I have gone as far as testing switching in and out of long mode, and it is not
to difficult.   But I have not setup exception handlers to reflect
things from 32bit mode to 64bit mode etc.

Eric
