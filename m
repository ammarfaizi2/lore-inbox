Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267260AbTBDNb3>; Tue, 4 Feb 2003 08:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267261AbTBDNb3>; Tue, 4 Feb 2003 08:31:29 -0500
Received: from chaos.analogic.com ([204.178.40.224]:47257 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267260AbTBDNb0>; Tue, 4 Feb 2003 08:31:26 -0500
Date: Tue, 4 Feb 2003 08:42:18 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "J.A. Magallon" <jamagallon@able.es>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: gcc 2.95 vs 3.21 performance
In-Reply-To: <20030204004321.GA12038@werewolf.able.es>
Message-ID: <Pine.LNX.3.95.1030204083627.10035B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Feb 2003, J.A. Magallon wrote:

> 
> On 2003.02.04 Richard B. Johnson wrote:
> > On Mon, 3 Feb 2003, Martin J. Bligh wrote:
> > 
> > > People keep extolling the virtues of gcc 3.2 to me, which I'm
> > > reluctant to switch to, since it compiles so much slower. But
> > > it supposedly generates better code, so I thought I'd compile
> > > the kernel with both and compare the results. This is gcc 2.95
> > > and 3.2.1 from debian unstable on a 16-way NUMA-Q. The kernbench
> > > tests still use 2.95 for the compile-time stuff.
> > >
> > [SNIPPED tests...]
> > 
> > Don't let this get out, but egcs-2.91.66 compiled FFT code
> > works about 50 percent of the speed of whatever M$ uses for
> > Visual C++ Version 6.0  I was awfully disheartened when I
> > found that identical code executed twice as fast on M$ than
> > it does on Linux. I tried to isolate what was causing the
> > difference. So I replaced 'hypot()' with some 'C' code that
> > does sqrt(x^2 + y^2) just to see if it was the 'C' library.
> > It didn't help. When I find out what type (section) of code
> > is running slower, I'll report. In the meantime, it's fast
> > enough, but I don't like being beat by M$.
> > 
> 
> I face a simliar problem. As everybody says that SSE is so marvelous,
> we are trying to put some SSE code in our render engine, to speed up this.
> But look at the results of the code below (box is a P4@1.8, Xeon with ht):

[SNIPPED good demo code]

I'm going to answer all the comments on this topic with just
one observation. Sorry that I don't have the time to answer
all who responded personally, but I have to take a "work break"
today and tommorrow (design review).

gcc is a marvelous compiler because it was designed
to be readily ported to different architectures. However,
is not an optimum compiler for ix86 machines and probably
is not optimum for any one kind of machine.

I often hear complaints about the ix86 processors as being
"register starved", etc. This could not be further from
fact. There are enough registers. However, various registers
were designed to do various things. Once you decide that
you know more than the processor developers, and start
using registers for things they were not designed for,
you start to have excellent test benchmarks, but awful
overall performance.

For example, the ECX register was designed to be used as
a counter. It can be told to decrement and perform a
conditional jump with the 'loop' instruction. The loop
instruction comes in various flavors, also, like loopz,
loopnz. Somebody decided that 'dec ecx; jnz' was faster.
They measured this to "prove" that it's faster. In the
meantime, other code suffers (stumbles) because there
was really no spare time to be grabbed. Data needs to
be fetched to and from memory. The instruction unit
ends up being starved while data are acquired. This
would not normally hurt anything because the RAM bandwidth
ends up being the dominant pole in the transfer function,
but you end up with something I call the "accordion problem".

I will first demonstrate the accordion problem and then
explain where it comes from. Note a smooth slow of traffic
on a highway. All the cars are traveling at the same speed.
Their speed increases until they don't dare go any faster.
They are now "bandwidth limited". Somebody sees a traffic
cop. Somebody slows down, it takes a few hundred milliseconds
for the next car to slow down, this transient moves backwards
though the line of cars until cars several miles back actually
have to perform emergency braking to stay off the bumper
ahead. Then, the cars start accelerating again. This acceleration,
deceleration ripple moves through the line of cars like the
bellows of an accordion. The average speed of the line of
traffic is now reduced even though there are oscillatory
accelerations above the speed-limit.

Now, visualize a CPU and RAM combination running in lock-step.
The speed of the execution unit is matched to the speed of the
processor I/O so the instructions are fetched and executed in
a more-or-less synchronized manner. This is like the high-speed
line of cars before somebody sees the traffic cop. Now, perturb
this execution by throwing in some faster-than-normal program
sequences. You may start the accordion effect. The problem is
that both instructions and data come through the same hole-in-
the wall, regardless of caching. When the prefetch unit needs
more data (instructions) it must contend with the data I/O.
This may cause an oscillatory condition, actually reducing
throughput.

Anybody who uses CPUs in laboratories with sensitive receiving
equipment knows that, regardless of the FCC rules, these
machines generate great gobs of radio frequency interference.
That's why they need to be in shielded boxes. If you want
to "hear" the stumble I'm talking about, just listen to
the AM audio output using a field-intensity meter. When you
have a fast smoothly-running machine, the interference sounds
like noise. When you have the accordion effect, the interference
has a repetitive pattern to it, a tone, usually low-frequency.
If you capture enough data in a logic analyzer, you will see
the pattern and can see actual pauses in bus I/O where the
CPU just isn't doing a damn thing at all!

FYI, there is a difference in power supply current required
to write 0xffffffff to RAM than 0x00000000 (honest!). If you
are doing a memory-test, writing such a pattern that the
load on the power supply changes at a rate that will disturb
the power supply servo-loop, you can make the voltage bounce!
This has nothing to do with slow CPU execution speed, but
just demonstrates that there are a lot of interactions that
should be considered when designing or proving-out a system.
It's not just a local bench-mark that counts.

The Intel Compiler(s) I have used generate code that uses
the registers just like Intel specified. It uses EBX, ESI, EDI
as index registers just like the 16-bit BX, SI, DI. I have
never seen code output from an Intel 'C' compiler that uses
EAX as in index register, even though it's available and
"faster". They seem to stick with the "un-optimized" string
instructions like rep movsb, repnz cmpsb, etc., and they
use 'loop'. Maybe, just maybe, Intel knows something about
their processor that shouldn't be second-guessed by clever
programmers.
 

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


