Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbTGAQIH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 12:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTGAQIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 12:08:07 -0400
Received: from holomorphy.com ([66.224.33.161]:57519 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262710AbTGAQH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 12:07:57 -0400
Date: Tue, 1 Jul 2003 09:22:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Joel.Becker@oracle.com,
       Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030701162204.GV29000@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrea Arcangeli <andrea@suse.de>, Joel.Becker@oracle.com,
	Mel Gorman <mel@csn.ul.ie>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53.0307010238210.22576@skynet> <20030701022516.GL3040@dualathlon.random> <20030701032531.GC20413@holomorphy.com> <20030701043902.GP3040@dualathlon.random> <20030701063317.GF20413@holomorphy.com> <20030701074915.GQ3040@dualathlon.random> <20030701085939.GG20413@holomorphy.com> <7950000.1057069435@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7950000.1057069435@[10.10.2.4]>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> First I ask, "What is this exercising?" That answer is largely process
>> creation and destruction and SMP scheduling latency when there are very
>> rapidly fluctuating imbalances.
>> After observing that, the benchmark is flawed because
>> (a) it doesn't run long enough to produce stable numbers
>> (b) the results are apparently measured with gettimeofday(), which is
>> 	wildly inaccurate for such short-lived phenomena

On Tue, Jul 01, 2003 at 07:24:03AM -0700, Martin J. Bligh wrote:
> Bullshit. Use a maximal config file, and run it multiple times. I have
> sub 0.5% variance. 

My thought here had more to do with the measurements becoming dominated
by ramp-up and ramp-down and than the thing literally producing unreliable
timings. "Instability" was almost certainly the wrong word.

I'm also skeptical of its usefulness for scalability comparisons with a
single-threaded phase like the linking phase and the otherwise large
variations in concurrency. It seems much more like a binary test of
"does it get slower when I add more cpus?" than a measure of scalability.

For instance, if you were to devise some throughput measure say per
gigacycle based on this and compare efficiencies on various systems
with it so as to measure scaling factors, what would it be? Would you
feel comfortable using it for scalability comparisons given the
concurrency limitations for a single compile as a benchmark?

Well, at the very least I don't.


At some point in the past, I wrote:
>> (c) large differences in performance appear to come about as a result
>> 	of differing versions of common programs (i.e. gcc)

On Tue, Jul 01, 2003 at 07:24:03AM -0700, Martin J. Bligh wrote:
> So use the same frigging gcc each time. Why you want to screw with
> userspace at the same time as the kernel is a mystery to me. If you
> change gcc, you're also changing what's compiling your kernel, so you'll
> get different binaries - ergo the whole argument is fallacious anyway,
> and *any* benchmarking you're doing is completely innacurrate.

This is all true. Yet how many of those who conduct the tests are so
careful?


At some point in the past, I wrote:
>> Well, the thing is it's closer to the primitive. You're suggesting
>> making remap_file_pages() both locked and unaligned with the vma, where
>> it seems to me the real underlying mechanism is using the semantics of
>> locked memory to avoid creating pte_chains. Bypassing vma's doesn't
>> seem to be that exciting. There are only a couple of places where an
>> assumption remap_file_pages() breaks matters, i.e. vmtruncate() and
>> try_to_unmap_one_obj(), and that can be dodged with exhaustive search
>> in the non-anobjrmap VM's and is naturally handled by chaining the
>> distinct virtual addresses where pages are mapped against the page by
>> the anobjrmap VM's.

On Tue, Jul 01, 2003 at 07:24:03AM -0700, Martin J. Bligh wrote:
> If we just lock the damned things in memory, OR flag them at create
> time (or at least before use), none of this is an issue anyway - we
> get rid of all the conversion stuff. Seeing as this is mainly for big 
> DBs, I still don't see why mem locking it is a problem - no reason 
> for it to fuck up the rest of the VM.

Partially disabling it is a workable solution. I'm moderately skeptical
about page_convert_anon(), though. Not so much as to whether it works
or not, but basically whether it's the right approach. It would seem
incrementally chaining ptes mismatching the file offset would do better
than trying to perform numerous allocations at once, especially since
the cached pte_chains are already at hand with the various points that
were arranged to do pte_chain_alloc() safely around the VM. I suspect
part of the trouble there is that the mapcount needed to rapidly
determine whether a page is mapped shares the space with the chain,
but unsharing it can be avoided by shoving the counter into one of the
chain's blocks in the chained filebacked page case a la anobjrmap.

I suppose there's also an aesthetic question of whether to choose an
approach that integrates it smoothly as opposed to one that turns it
into a Frankensteinian bolt poking out of the VM's proverbial neck.
As it stands now it's somewhat more useful and prettier than DSHM etc.
equivalents elsewhere, at least API-wise. I actually thought the
resource scalability issues were getting addressed without disfiguring
it for some reason.

Also, have you checked with the big DB's about whether they can
tolerate privilege requirements for using it?


-- wli
