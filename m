Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbTGARw4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 13:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbTGARw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 13:52:56 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:22162 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263199AbTGARww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 13:52:52 -0400
Date: Tue, 01 Jul 2003 10:54:56 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrea Arcangeli <andrea@suse.de>, Joel.Becker@oracle.com,
       Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <437540000.1057082096@flay>
In-Reply-To: <20030701162204.GV29000@holomorphy.com>
References: <Pine.LNX.4.53.0307010238210.22576@skynet> <20030701022516.GL3040@dualathlon.random> <20030701032531.GC20413@holomorphy.com> <20030701043902.GP3040@dualathlon.random> <20030701063317.GF20413@holomorphy.com> <20030701074915.GQ3040@dualathlon.random> <20030701085939.GG20413@holomorphy.com> <7950000.1057069435@[10.10.2.4]> <20030701162204.GV29000@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, July 01, 2003 09:22:04 -0700 William Lee Irwin III <wli@holomorphy.com> wrote:

> At some point in the past, I wrote:
>>> First I ask, "What is this exercising?" That answer is largely process
>>> creation and destruction and SMP scheduling latency when there are very
>>> rapidly fluctuating imbalances.
>>> After observing that, the benchmark is flawed because
>>> (a) it doesn't run long enough to produce stable numbers
>>> (b) the results are apparently measured with gettimeofday(), which is
>>> 	wildly inaccurate for such short-lived phenomena
> 
> On Tue, Jul 01, 2003 at 07:24:03AM -0700, Martin J. Bligh wrote:
>> Bullshit. Use a maximal config file, and run it multiple times. I have
>> sub 0.5% variance. 
> 
> My thought here had more to do with the measurements becoming dominated
> by ramp-up and ramp-down and than the thing literally producing unreliable
> timings. "Instability" was almost certainly the wrong word.
> 
> I'm also skeptical of its usefulness for scalability comparisons with a
> single-threaded phase like the linking phase and the otherwise large
> variations in concurrency. It seems much more like a binary test of
> "does it get slower when I add more cpus?" than a measure of scalability.
> 
> For instance, if you were to devise some throughput measure say per
> gigacycle based on this and compare efficiencies on various systems
> with it so as to measure scaling factors, what would it be? Would you
> feel comfortable using it for scalability comparisons given the
> concurrency limitations for a single compile as a benchmark?

I'm not convinced it's that limited. I'm getting about 1460% cpu out
of 16 processors - that's pretty well parallelized in my mind.

> On Tue, Jul 01, 2003 at 07:24:03AM -0700, Martin J. Bligh wrote:
>> So use the same frigging gcc each time. Why you want to screw with
>> userspace at the same time as the kernel is a mystery to me. If you
>> change gcc, you're also changing what's compiling your kernel, so you'll
>> get different binaries - ergo the whole argument is fallacious anyway,
>> and *any* benchmarking you're doing is completely innacurrate.
> 
> This is all true. Yet how many of those who conduct the tests are so
> careful?

Anyone who's not that careful should find something else to do in life
than run benchmarks. Crap data is worse than no data. At the very least,
it takes some pretty active stupidity to not have numbers that are 
consistent against themselves. 

Again, I don't see this demonstrates anything wrong with the test ;-)
In fact, it's better, since the variances are more obvious if you 
screw it up.

> On Tue, Jul 01, 2003 at 07:24:03AM -0700, Martin J. Bligh wrote:
>> If we just lock the damned things in memory, OR flag them at create
>> time (or at least before use), none of this is an issue anyway - we
>> get rid of all the conversion stuff. Seeing as this is mainly for big 
>> DBs, I still don't see why mem locking it is a problem - no reason 
>> for it to fuck up the rest of the VM.
> 
> Partially disabling it is a workable solution. I'm moderately skeptical
> about page_convert_anon(), though. Not so much as to whether it works
> or not, but basically whether it's the right approach. It would seem
> incrementally chaining ptes mismatching the file offset would do better
> than trying to perform numerous allocations at once, especially since
> the cached pte_chains are already at hand with the various points that
> were arranged to do pte_chain_alloc() safely around the VM. I suspect
> part of the trouble there is that the mapcount needed to rapidly
> determine whether a page is mapped shares the space with the chain,
> but unsharing it can be avoided by shoving the counter into one of the
> chain's blocks in the chained filebacked page case a la anobjrmap.

I don't think anyone is desperately fond of the conversion stuff, it
just seems to be the most pragmatic solution. However, I think the 
main problem is more that people seem to think that nonlinear VMAs
are somehow sacred, and cannot be touched in this process - I'm not
convinced by that, as long as we continue to fulfill their original
goal. 

For one, I'm not convinced that keeping the VMAs (or equiv data for 
non-linear dereference) around is a worse problem than the PTE-chains themselves.  Call it a "per linear subsegment pte-chain equivalent"
if that makes you feel better about it. Better per linear area than
per page, IMHO.

Of course, if we can agree to just lock the damned things in memory,
all this goes away.

> I suppose there's also an aesthetic question of whether to choose an
> approach that integrates it smoothly as opposed to one that turns it
> into a Frankensteinian bolt poking out of the VM's proverbial neck.
> As it stands now it's somewhat more useful and prettier than DSHM etc.
> equivalents elsewhere, at least API-wise. I actually thought the
> resource scalability issues were getting addressed without disfiguring
> it for some reason.

I'd like it to be elegant. But I'd settle for it working ;-)

M.
