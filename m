Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264221AbTIIQHj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 12:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264220AbTIIQHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 12:07:39 -0400
Received: from [217.129.131.20] ([217.129.131.20]:4 "HELO kore.nara.homeip.net")
	by vger.kernel.org with SMTP id S264221AbTIIQHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 12:07:35 -0400
From: Ricardo Bugalho <ricardo.b@zmail.pt>
Subject: Re: Scaling noise
Date: Tue, 09 Sep 2003 17:07:30 +0100
User-Agent: Pan/0.14.0 (I'm Being Nibbled to Death by Cats!)
Message-Id: <pan.2003.09.09.16.07.28.847940@zmail.pt>
References: <20030903040327.GA10257@work.bitmover.com> <20030906150817.GB3944@openzaurus.ucw.cz> <1063028321.21050.28.camel@dhcp23.swansea.linux.org.uk> <200309090211.16136.rob@landley.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Sep 2003 02:11:15 -0400, Rob Landley wrote:


> Modern processors (Athlon and P4 both, I believe) have three execution
> cores, and so are trying to dispatch three instructions per clock.  With

Neither of these CPUs are multi-core. They're just superscalar cores, that
is, they can dispatch multiple instructions in parallel. An example of a
multi-core CPU is the POWER4: there are two complete cores in the same
sillicon die, sharing some cache levels and memory bus.

BTW, Pentium [Pro,II,III] and Athlon are three way in the sense they have
three-way decoders that decode up to three x86 instructions into µOPs.
Pentium4 has a one-way decoder and the trace cache that stores decodes
µOPs.
As a curiosity, AMD's K5 and K6 were 4 way.

> four cores bus would be a nightmare.  (All the VLIW guys keep trying to
> unload this on the compiler.  Don't ask me how a compiler is supposed to
> do branch prediction and speculative execution.  I suppose having to
> recompile your binaries for more cores isn't TOO big a problem these
> days, but the boxed mainstream desktop apps people wouldn't like it at
> all.)

In normal instructions sets, whatever CPUs do, from the software
perspective, it MUST look like the CPU is executing one instruction at a
time. In VLIW, some forms of parallelism are exposed. For example, before
executing two instructions in parallel, non-VLIW CPUs have to check for
data dependencies. If they exist, those two instructions can't be executed
in parallel. VLIW instruction sets just define that instructions MUST be
grouped in sets of N instructions that can be executed in parallel and
that if they don't the CPU, the CPU will yield an exception or undefined
behaviour.
In a similar manner, there is the issue of avaliable execution units and
exeptions.
The net result is that in-order VLIW CPUs are simpler to design that
in-order superscalar RISC CPUs, but I think it won't make much of a
difference for out-of-order CPUs. I've never seen a VLIW out-of-ordem
implementation.
VLIW ISAs are no different from others regarding branch prediction --
which is a problem for ALL pipelined implementations, superscalar or not.
Speculative execution is a feature of out-of-order implementation.


> Transistor budgets keep going up as manufacturing die sizes shrink, and
> the engineers keep wanting to throw transistors at the problem.  The
> first really easy way to turn transistors into performance are a bigger
> L1 cache, but somewhere between 256k and one megabyte per running
> process you hit some serious diminishing returns since your working set
> is in cache and your far accesses to big datasets (or streaming data)
> just aren't going to be helped by more L1 cache.

L1 caches are kept small so they can be fast.

> Hyperthreading is just a neat hack to keep multiple cores busy.  Having

SMT (Simultaneous Multi-Threading, aka Hyperthreading in Intel's marketing
term) is a neat hack to keep execution units within the same core busy.
And its a cheap hack when the CPUs are alread out-of-order. CMP
(Concurrent Multi-Processing) is a neat hack to keep expensive resources
like big L2/L3 caches and memory interfaces busy by placing multiple cores
on the same die.
CMP is simpler, but is only usefull for multi-thread performance. With
SMT, it makes sense to add more execution units that now, so it can also
help single-thread performance.


> Intel's been desperate for a way to make use of its transistor budget
> for a while; manufacturing is what it does better than AMD< not clever
> processor design.  The original Itanic, case in point, had more than 3
> instruction execution cores in each chip: 3 VLIW, a HP-PA Risc, and a
> brain-damaged Pentium (which itself had a couple execution cores)... The
> long list of reasons Itanic sucked started with the fact that it had 3
> different modes and whichever one you were in circuitry for the other 2
> wouldn't contribute a darn thing to your performance (although it did
> not stop there, and in fact didn't even slow down...)

Itanium doesn't have hardware support for PA-RISC emulation. The IA-64 ISA
has some similarities with PA-RISC to ease dynamic translation though.
But you're right: the IA-32 hardware emulation layer is not a Good Thing™.

-- 
	Ricardo

