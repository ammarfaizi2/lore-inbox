Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264582AbTIJFXQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 01:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264626AbTIJFXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 01:23:16 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:23175
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S264582AbTIJFXL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 01:23:11 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Ricardo Bugalho <ricardo.b@zmail.pt>, linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Date: Wed, 10 Sep 2003 01:14:37 -0400
User-Agent: KMail/1.5
References: <20030903040327.GA10257@work.bitmover.com> <200309090211.16136.rob@landley.net> <pan.2003.09.09.16.07.28.847940@zmail.pt>
In-Reply-To: <pan.2003.09.09.16.07.28.847940@zmail.pt>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200309100114.37867.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 September 2003 12:07, Ricardo Bugalho wrote:
> On Tue, 09 Sep 2003 02:11:15 -0400, Rob Landley wrote:
> > Modern processors (Athlon and P4 both, I believe) have three execution
> > cores, and so are trying to dispatch three instructions per clock.  With
>
> Neither of these CPUs are multi-core. They're just superscalar cores, that
> is, they can dispatch multiple instructions in parallel. An example of a
> multi-core CPU is the POWER4: there are two complete cores in the same
> sillicon die, sharing some cache levels and memory bus.

Sorry, wrong terminology.  (I'm a software dude.)

"Instruction execution thingy".  (Well you didn't give it a name either. :)

> BTW, Pentium [Pro,II,III] and Athlon are three way in the sense they have
> three-way decoders that decode up to three x86 instructions into µOPs.
> Pentium4 has a one-way decoder and the trace cache that stores decodes
> µOPs.
> As a curiosity, AMD's K5 and K6 were 4 way.

I hadn't known that.  (I had known that the AMD guys I talked to around Austin 
had proven to themselves that 4 way was not a good idea in the real world, 
but I didn't know it had actually made it outside of the labs...)

> > four cores bus would be a nightmare.  (All the VLIW guys keep trying to
> > unload this on the compiler.  Don't ask me how a compiler is supposed to
> > do branch prediction and speculative execution.  I suppose having to
> > recompile your binaries for more cores isn't TOO big a problem these
> > days, but the boxed mainstream desktop apps people wouldn't like it at
> > all.)
>
> In normal instructions sets, whatever CPUs do, from the software
> perspective, it MUST look like the CPU is executing one instruction at a
> time.

Yup.

> In VLIW, some forms of parallelism are exposed.

I tend to think of it as "unloaded upon the compiler"...

> For example, before
> executing two instructions in parallel, non-VLIW CPUs have to check for
> data dependencies. If they exist, those two instructions can't be executed
> in parallel. VLIW instruction sets just define that instructions MUST be
> grouped in sets of N instructions that can be executed in parallel and
> that if they don't the CPU, the CPU will yield an exception or undefined
> behaviour.

Presumably this is the compiler's job, and the CPU can just have "undefined 
behavior" if fed impossible instruction mixes.  But yeah, throwing an 
exception would be the conscientious thing to do. :)

> In a similar manner, there is the issue of avaliable execution units and
> exeptions.
> The net result is that in-order VLIW CPUs are simpler to design that
> in-order superscalar RISC CPUs, but I think it won't make much of a
> difference for out-of-order CPUs. I've never seen a VLIW out-of-ordem
> implementation.

I'm not sure what the point of out-of-order VLIW would be.  You just put extra 
pressure on the memory bus by tagging your instructions with grouping info, 
just to give you even LESS leeway about shuffling the groups at run-time...

> VLIW ISAs are no different from others regarding branch prediction --
> which is a problem for ALL pipelined implementations, superscalar or not.
> Speculative execution is a feature of out-of-order implementation.

Ah yes, predication.  Rather than having instruction execution thingies be 
idle, have them follow both branches and do work with a 100% chance of being 
thrown away.  And you wonder why the chips have heat problems... :)

> > Transistor budgets keep going up as manufacturing die sizes shrink, and
> > the engineers keep wanting to throw transistors at the problem.  The
> > first really easy way to turn transistors into performance are a bigger
> > L1 cache, but somewhere between 256k and one megabyte per running
> > process you hit some serious diminishing returns since your working set
> > is in cache and your far accesses to big datasets (or streaming data)
> > just aren't going to be helped by more L1 cache.
>
> L1 caches are kept small so they can be fast.

Sorry, I still refer to on-die L2 caches as L1.  Bad habit.  (As I said, I get 
the names wrong...)  "On die cache."  Right.

The point was, you can spend your transistor budget with big caches on the 
die, but there are diminishing returns.

> > Intel's been desperate for a way to make use of its transistor budget
> > for a while; manufacturing is what it does better than AMD< not clever
> > processor design.  The original Itanic, case in point, had more than 3
> > instruction execution cores in each chip: 3 VLIW, a HP-PA Risc, and a
> > brain-damaged Pentium (which itself had a couple execution cores)... The
> > long list of reasons Itanic sucked started with the fact that it had 3
> > different modes and whichever one you were in circuitry for the other 2
> > wouldn't contribute a darn thing to your performance (although it did
> > not stop there, and in fact didn't even slow down...)
>
> Itanium doesn't have hardware support for PA-RISC emulation.

I'm under the impression it used to be part of the design, circa 1997.  But I 
must admit: when discussing Itanium I'm not really prepared; I stopped paying 
too much attention a year or so after the sucker had taped out but still had 
no silicon to play with, especially after HP and SGI revived their own chip 
designs due to the delay...)

I only actually got to play with the original Itanium hardware once, and never 
got it out of the darn monitor that substituted for a bios.  The people who 
did benchmarked it at about Pentium III 300 mhz levels, and it became a 
doorstop.  (These days, I've got a friend who's got an Itanium II evaluation 
system, but it's another doorstop and I'm not going to make him hook it up 
again just so I can go "yeah, I agree with you, it sucks"...)

> The IA-64 ISA
> has some similarities with PA-RISC to ease dynamic translation though.
> But you're right: the IA-32 hardware emulation layer is not a Good Thing™.

It's apparently going away.

http://news.com.com/2100-1006-997936.html?tag=nl

Rob
