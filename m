Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316723AbSFVChN>; Fri, 21 Jun 2002 22:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316755AbSFVChM>; Fri, 21 Jun 2002 22:37:12 -0400
Received: from pimout5-ext.prodigy.net ([207.115.63.98]:4094 "EHLO
	pimout5-int.prodigy.net") by vger.kernel.org with ESMTP
	id <S316723AbSFVChK>; Fri, 21 Jun 2002 22:37:10 -0400
Message-Id: <200206220236.g5M2awK131382@pimout5-int.prodigy.net>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Rob Landley <landley@trommello.org>
To: Martin Dalecki <dalecki@evision-ventures.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: latest linus-2.5 BK broken
Date: Fri, 21 Jun 2002 16:38:37 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Cort Dougan <cort@fsmlabs.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0206201344080.8225-100000@home.transmeta.com> <3D1248BB.6070007@evision-ventures.com>
In-Reply-To: <3D1248BB.6070007@evision-ventures.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 20 June 2002 05:27 pm, Martin Dalecki wrote:
> U¿ytkownik Linus Torvalds napisa³:
> > On Thu, 20 Jun 2002, Martin Dalecki wrote:
> >>2. See 1. even dual CPU machines are a rarity even *now*.
> >
> > With stuff like HT, you may well not be able to _buy_ an intel desktop
> > machine with just "one" CPU.
>
> Linus you forget one simple fact - a HT CPU is *not* two CPUs.
> It is one CPU with a slightly better utilization of the
> super scalar pipelines. And it's only slightly better.
> Just another way of increasind the fill reate of the pipelines
> for some specific tasks.

Wrong.

RISC let you have two execution cores dispatching instructions in parallel.  
(Two instructions per clock).  AMD expanded this to three execution cores in 
the Athlon with clever and insanely complex cisc->risc translation and 
pipeline organizing circuitry.  Intel couldn't match that (at first) and went 
to VLIW, hence itanic.

VLIW/EPIC was an attempt to figure out how to keep more execution cores busy 
without having each one know what the other ones are doing, and searchign for 
paralellism in a single instruction stream.  Unload the parallelism finding 
work on the compiler, batch the resulting instructions together in groups, 
and explicitly feed an instruction to each execution core, each clock cycle.  
If there's nothing for it to do, feed it a NOP.  That way you can have three 
execution cores (getting three instructions per clock), and you can even do 
four or five or six cores receiving big batches of paralell instructions and 
executing the whole mess each clock cycle in parallel.

Of course the real bottleneck in a processor that's clock multiplied by a 
factor of 20 relative to the motherboard it sits in is the memory bus speed, 
and L1 cache size (since it's up to 20x slower when it hits the edge of the 
cache), and VLIW makes the memory bus MORE of a bottleneck, so resulting 
preformance sucks tremendously.  Oops.  Back to the drawing board.  (R.I.P. 
itanium, modulo intel's marketing budget...)

Hyper-threading is another way to keep extra execution cores busy: teach the 
chip about processes and dole the execution cores out to each process 
depending on how many they can use.  (One, two, or three, depending on how 
parallel the next few instructions in the thread are.)

Of course each thread needs its own register profile, but register renaming 
for speculative execution is way more complicated than that.  And you need to 
teach the MMU how to look at more than one set of page tables at a time, but 
that's doable too.

Putting full-blown SMP on a chip means you're duplicating all sorts of 
circuitry: your L1 cache, your bus interface logic, etc.  SMT is basically 
SMP on a chip that shares the L1 cache, AND gives you an excuse to EXPAND it 
(they've got the transistor budge: Xeons hae a megabyte or more of L1 cache, 
there's just a case of diminishing returns.  Now, they get to spend the 
transistors for a larger cache and actually have it MEAN something.)

And yes, you could go beyond three execution cores with SMT.  You could go to 
five or six execution cores, and have three threads of execution if you 
really wanted to.  The design gets a little more complicated, but not really 
all that much, since the purpose is to SEPARATE what the threads are doing, 
as opposed to the traditional "is core #2 going to interfere with what core 
#2 is doing"?  You may wind up designing a full blown instruction scheduler, 
but if that's too complex you could always put it in software and call it 
code morphing II. :)

We've had a variant of multiprocessing on a chip since the original pentium, 
we just called it pipelining.  Saying SMT is not "true SMP" is splitting 
hairs, and an attempt to win an argument by redefining the words used in the 
original statement.  (I wasn't wrong: that color's not blue!)

> > Get with the flow. The old Windows codebase is dead as far as new
> > machines are concerned, which means that there is no reason to hold back
> > any more: all OS's support SMP.
> >
> >>3. Nobody needs them for the usual tasks they are a *waste*
> >>of resources and economics still applies.
> >
> > That's a load of bull.
>
> Did I mention that ARMs are the most sold CPUs out there?

So they finally passed the enormous installed base of Z80's in traffic 
lights, elevators, and microwaves?  Bully for them.

What USE this information is remains an open question.

> For the usual task of controlling just the fuel level of the motor
> or therlike one CPU makes fine. For the other usual
> tasks - well dissect a PCMCIA WLAN card or some reasonable fast
> ethernet card or some hard disk. You will find tons of
> independant CPUs in your system... but they are hardly SMP
> connected. For the other usual task my single Athlon is
> just fine.

And the Z80 hooked up to an S100  bus running CP/M shall always rule forever 
and ever alelujiah amen.  Case dismissed.

> > The number of people doing things like mp3 ripping is apparently quite
> > high. And it's definitely CPU-intensive.
> >
> > Now, I suspect that past two CPU's you won't find much added oomph, but
>
> Well on intel two CPU give you about 1.5 horse power of
> a single CPU. On Good SPM systems it's about 1.7.

Intel's traditional way of doing SMP sucks (the memory bus is STILL the main 
bottleneck to performance: let's share it!), and most PC OSes have 
traditionally had mondo lock contention doing even simple things.  Okay.  So?

> > Intel made SMP cheap by putting all the glue logic on-chip and in the
> > standard chipsets.
>
> Not if I look out to buy a real SMP board.

Again with the "the PC isn't a real computer" line of argument...

> They are still
> very expensive in comparision to normal boards. However
> indeed they are nowadays affordable.

A year and a half ago I worked at the company that prototyped the first dual 
Athlon board (Boxxtech: tyan owed them a favor).  Intel was never interested 
in bringing out a dual celeron motherboard (the first celerons were so 
cache-crippled trying to SMP them was just painful).  The ONLY wanted to do 
SMP at the high end, and as processors came down in price they yanked the SMP 
support circuitry.

Add in the fact the Intel SMP bus still sucks tremendously and the dominant 
OS through windows 98 couldn't even understand two graphics cards (and often 
got confused by two NETWORK cards) we're not talking a recipe for widespread 
adoption here...

> > And besides, you don't actually need to _scale_ well, if the actual
> > incremental costs are low. That's the whole point with the P4-HT, of
> > course. Intel claims 5% die area addition for a 30% scaling. They may be
>
> The 30% - I never saw it in the intel paper. I remember they talk
> about 20% + something. And 30% is a *peak* value.

Sure.  Keeping that third execution core busy 24/7.  On the rare instances 
their pipeline organizer can devote that third execution core to advancing 
the first process, preventing it from doing so is slowing that first process 
down by repurposing a resource that would NOT otherwise have been wasted.  
(Minus 3% performance penalty for extra cache trashing and memory bus 
contention.)

Now add a FOURTH execution core to the chip, bump the L1 cache size a bit, 
and watch performance go up 25%...

I am REALLY waiting for AMD to start doing this.  We've been waiting for "smp 
on a chip" (outside of PPC) for years, without ever explaining what the 
advantage was of giving each one its own bus interface unit and L1 cache...

> The paper in question talks about 12% on average. Awfoul much for
> 5% die area (2.4 factor win) in esp. if you look at the constant
> increase of die area of CPUs in comparision to the speed factoring out
> the scaling of the production process. If once factors out
> the production process scale modern CPU are wasting transistors like
> no good in comparision to they older silbings. (Remember 8088 was
> just about 22t transistors and not 140M!).
> But it's not much in absolute numbers...

Yeah.  It's called "a good idea" instead of brute force throwing transistors 
at the problem.  Even Intel's allowed to have the occasional good idea.  
(After itanium they're certainly due for one!)

> > full of sh*t, of course, and it may be that the added complexity in the
> > control logic hurts them in other areas (longer pipeline, whatever), but
> > the point is that if it's cheap, the second CPU doesn't have to "scale".
>
> The main hurting point is the quadruple of the correctness testing
> effort. Longer pipelines - I hardly think so. The synchronization
> infrastructure for out of order execution was already there in the last CPU
> generation. This is the reaons why it's so cheap in terms of die estate to
> add it now.

In theory they might even be able to get rid of some of it, as long as they 
can keep all their execution cores busy 99% of the time without it.  (Picking 
three simultaneously runnable instructions from two different threads of 
execution is a fundamentally easier problem than consistently picking even 
two instructions from one thread.)

And it's a far cry from the itanium's way of handling branch preditiction to 
keep the cores busy.  (Execute BOTH forks and throw the one we don't take 
away!  Yeah, that'll guarantee we waste work so we LOOK busy, but don't 
actually run noticeably faster!  Brilliant!  (What, is the goal to make the 
chip run hot?  95% prediction rate isn't enough for you, and you're STILL 
going to stall the pipeline when you hit the edge of the L1 cache anyway...))

> BTW. Them pulling this trick shows nicely that we are now at a point
> where there will be hardly any increase in the deployment of micro scale
> paralellity in CPU design nowadays...

Famous last words...

> And not just on behalf of
> the CPU - even more importantly you could read it as public admit to the
> fact that we are near the end of static optimizations by improvements in
> compiler technology as well. Oh the compiler people promise miracles
> constantly since the first days of pipeline of course...

Trust me: GCC 3.x can still be seriously improved upon.

> In view of this I would  love to see how they intend
> to HT the VLSI design of the Itanic :-).

Well, the rumors are that Intel is going to bury iTanic in a sea trench and 
license x86-64.  AMD has confirmed that intel licensed the rights to the 
x86-64 instruction set, and intel's prototype is apparently called yamhill:

http://www.matrixlist.com/pipermail/pc_support/2002-May/001416.html

Whether or not AMD got a license to the inevitable hyper-threading patents in 
return, I have no idea.  (If AMD would just buy transmeta and be done with 
it, I'd feel more comfortable predicting them.  I have friends who work 
there, that rumor mill's bandwidth is full of the trouble they're having with 
absolutely sucky motherboard chipsets and nvidia writing out of spec graphics 
cards that the chipsets are actually designed to compensate for, and as such 
wind up screwing up other things by being out of spec.  Or something like 
that, that's the trouble with rumors, details get mangled...)

Rob
