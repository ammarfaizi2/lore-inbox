Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266490AbUHUPWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266490AbUHUPWc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 11:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266686AbUHUPWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 11:22:32 -0400
Received: from holomorphy.com ([207.189.100.168]:10192 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266490AbUHUPW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 11:22:26 -0400
Date: Sat, 21 Aug 2004 08:22:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm3
Message-ID: <20040821152218.GZ11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>,
	Jesse Barnes <jbarnes@engr.sgi.com>, linux-kernel@vger.kernel.org
References: <20040820031919.413d0a95.akpm@osdl.org> <200408201144.49522.jbarnes@engr.sgi.com> <200408201257.42064.jbarnes@engr.sgi.com> <20040820115541.3e68c5be.akpm@osdl.org> <20040820200248.GJ11200@holomorphy.com> <20040820233126.GJ1945@krispykreme> <20040821000343.GR11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040821000343.GR11200@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>>> Parallel compilation is an extremely poor benchmark in general, as the
>>> workload is incapable of being effectively scaled to system sizes, the
>>> linking phase is inherently unparallelizable and the compilation phase
>>> too parallelizable to actually stress anything. There is also precisely
>>> zero relevance the benchmark has to anything real users would do.

The manner in which the load is too parallelizable is that literally
the only shared data accessed are the directories and process creation
related structures. By and large the dcache is useless to beat on as
it's long been known what needs to happen there: the hashtable has to
die in favor of a data structure that interoperates properly with
lockless synchronization and with some remote hint of cache locality.
Real workloads run by real users perform nontrivial communication
between processes, not wait4(), access more devices than merely disk,
and furthermore, don't fork() and exit() all day in preference to doing
real work.


On Fri, Aug 20, 2004 at 05:03:43PM -0700, William Lee Irwin III wrote:
> Kernel hacking is not an end in itself, regardless of the fact there
> are some, such as myself, who use computers for no other purpose. A
> real user generally has some purpose to their activity beyond working
> on the software or hardware they are "using". e.g. various real users
> use their systems for entertainment: playing games, music, and movies.
> Others may use their systems to make money somehow, e.g. archiving
> information about customers so they can look up what they've bought
> and paid for or have yet to pay for.
> Regardless of the social issue, the rather serious technical deficits
> of compilation of any software as a benchmark are showstopping issues.
> Frankly, even the issues I've dredged up are nowhere near comprehensive.
> There are further issues such as that stable (i.e. not varying across
> the benchmarks being done on various systems at various times) versions
> of the software being compiled and the toolchain being used to compile
> it are lacking as components of any "kernel compile benchmarking suite"
> and worse still the variance in target architecture of the toolchain
> also defeats any attempt at meaningful benchmarking.

To be useful at all, benchmarks have to be useful to evaluate different
machines as well. For instance, to evaluate the scalability of the
kernel to different sizes of machines, different machines must be
comparable. Likewise, to evaluate how well utilizing a particular
hardware feature of an architecture improves kernel performance
relative to an architecture without the hardware feature, different
machines must be compared. The relative performance of the machines
before the kernel feature is utilized must be compared to the relative
performance of the machines after the feature is utilized.

Proper benchmarks are furthermore explicitly used to evaluate hardware.
Individual users posting results from their own frozen-at-gcc-versions-
of-their-choice userspace are worthless for this.

If there were to be an attempt at a proper kernel and system benchmark
using kernel compiles, which is unlikely ever to happen, one would do
the following:

(a) Bundle a toolchain and all supporting userspace required for it
	into the benchmark so that the gcc, make, etc. are identical
	for all users of the benchmark.
(b) Run O(num_cpus_online()) kernel compiles in parallel instead of
	a single make -j so the workload can be sized appropriately
	for the system. The fact is that 32x+ systems can't even be
	kept loaded by the "benchmark" because there is just not enough
	work to distribute, so this has to be done.
(c) Measure throughput in terms of kernel compiles per minute, and
	explicitly measure the variance during the runs.
(d) This still doesn't fix the fact that there are no nontrivial
	shared resources amongst the processes. It still doesn't benchmark
	anything useful, as it's not modeled on any real end user workload
	and not targeted at any specific kernel functionality. It will
	merely produce self-consistent results with these fixes.

i.e. the methodology now used for "kernel compile benchmarks" is poor
and all of the "results" obtained from it are highly questionable and
should be ignored.


On Fri, Aug 20, 2004 at 05:03:43PM -0700, William Lee Irwin III wrote:
> If you're truly concerned about compilation speed, userspace is going
> to be the most productive area to work on anyway, as the vast majority
> of time during compilation is spent in userspace. AIUI the userspace
> algorithms in gcc are not particularly cognizant of cache locality and
> in various instances have suboptimal time and space behavior, so it's
> not as if there isn't work to be done there. Improving the compactness
> and cache locality of data structures is important in userspace also,
> and most (perhaps all) userspace programs are grossly ignorant of this.
> FWIW, there are notable kernel hackers known to use very downrev gcc
> versions due to regressions in compilation speed in subsequent versions,
> so there are already large known differences in compilation speed that
> can be obtained just by choosing a different compiler version.

The point here is what to do if you are literally trying to improve
compilation speed.

If you are trying to benchmark the kernel, you should do a vaguely
realistic simulation of something a user might do to stress the kernel
or a real microbenchmark instead of repeating mistakes with poor
methodology.  The results are so bad they have to be thrown away after
every post, as the relative results' baselines are effectively
untraceable. It's also needlessly complex. It does too many different
things at once, and to no useful effect, as it's not a meaningful
macrobenchmark either, and so its results are even misleading. As it
has been used it is logically impossible for it to have properly
motivated any improvement of the kernel, or ever to do so in the future.

If you care about fork(), then use a fork() microbenchmark; every
meaningful improvement of fork() has been measured by such.

If you care about the parallelism of the vfs, then use a vfs
microbenchmark; every meaningful improvement of the vfs has been
measured by such.

Kernel compiles should not be used as benchmarks as they are now, and
their results should not be taken into consideration as performance
metrics. I highly encourage those concerned about performance to use
other benchmarks, e.g. reaim and the like, which are multiuser
simulations to measure interactive response and the like, or another
properly-constructed benchmark targeted at their performance concerns.
I encourage readers of kernel compile performance results to disregard them.

The only real point of interest regarding this kind of affair on
supercomputers is as a stress test to verify that the kernel doesn't
livelock or deadlock due to the extreme performance characteristics
of such large systems, and I encourage other readers likewise to limit
their interest and involvement in this thread to stress testing results.


-- wli
