Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbUDBKO3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 05:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUDBKO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 05:14:29 -0500
Received: from holomorphy.com ([207.189.100.168]:42162 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263573AbUDBKOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 05:14:14 -0500
Date: Fri, 2 Apr 2004 02:14:07 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Antony Suter <sutera@internode.on.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc3-as1 patchset, cks5.2, cfq, aa1, and some wli
Message-ID: <20040402101407.GR791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Antony Suter <sutera@internode.on.net>,
	linux-kernel@vger.kernel.org
References: <1080894085.22675.0.camel@hikaru.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080894085.22675.0.camel@hikaru.lan>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2004 at 06:21:25PM +1000, Antony Suter wrote:
> Here is an update to my tidy set of patches. I was a fan of WLI's
> patchset until he discontinued it in the 2.6.0-test era. They were a
> small set of patches with performance improvements for laptops and NUMA
> machines amongst others... (wish I had a laptop NUMA machine *cough*).
> Some of those patches are now in the kernel proper. Some others have
> been updated and are found elsewhere, like the objrmap series can be
> found in Andrea Archangeli's -aa series. I'm starting to add some of the
> other patches from WLI's last release, depending on my abolity to
> resolve rejections. The numbers relate directly to those from
> linux-2.6.0-test11-wli-1.tar.bz2

Ouch! Please, use either Hugh's or Andrea's up-to-date patches.
anobjrmap (and actually the vast majority of this material) was not
original. You're also unlikely to find highpmd and a number of others
useful without highmem and/or ia32 NUMA.

I'm honestly not sure how you managed to merge anything with all the
highpmd/O(1) proc_pid_statm()/anobjrmap bits in there. Heck, I lost
the stamina to keep it going myself.


On Fri, Apr 02, 2004 at 06:21:25PM +1000, Antony Suter wrote:
> Patches were applied in the following order:
> - Con Kolivas' new starcase cpu scheduler patch 5.2
> - Jens Axboe's cfq io scheduler
> - Andrea Archangeli's 2.6.5-rc3-aa2.bz2

Phew, aa's bits should be maintained/updated/bugfixed.


On Fri, Apr 02, 2004 at 06:21:25PM +1000, Antony Suter wrote:
> < from linux-2.6.0-test11-wli-1 >
> - #17 convert copy_strings() to use kmap_atomic() instead of kmap()
> - #19 node-local i386 per_cpu areas

These two are completely useless unless you're running on bigfathighmem.


On Fri, Apr 02, 2004 at 06:21:25PM +1000, Antony Suter wrote:
> - #22 increase static vfs hashtable and VM array sizes
> - #24 /proc/ BKL gunk plus page wait hashtable sizing adjustment
> - #25 invalidate_inodes() speedup

#25 is in -mm and may have bugfixes/updates relative to whatever I had.
#22 and #24 don't have very definite impacts; I only saw any difference
with truly massive amounts of IO in-flight (e.g. 25GB/48GB), and while
it wasn't a clear win, it moved around the blocking points surrounding
IO submission to places where I'd rather it go. This is a rather foggy
issue you probably shouldn't be concerned with. If you do see it make a
difference, I'll be surprised, but happy to see the benchmark numbers
demonstrating it.

To understand what was really going on with all this, it helps to know
why this thing was put together. That was to optimize a benchmark I can't
name without having problems with respect to publication rules and so on.
This was actually done in somewhat of a hurry as it was meant more as a
demonstration of benchmarking methodology than producing important
results in and of themselves, but then the results were maintained for
far longer than the actual optimization effort lasted, as they appeared
to be valuable. I believed the results of this to be potentially useful
to end users because the benchmark was a simulation of interactive
workloads where people interacted with shells and spawned short-running
jobs meant to be typical for shellservers in university- like
environments, though the age of the benchmark hurt its relevance quite
a bit. Active development was pursued on other things while the -wli
patches were maintained. As it aged, most of the highly experimental
parts were backed out instead of debugged to address stability issues,
and eventually the entire patch coctail imploded as the series of 10-15
patches in a row that stomped over every line modifying a user pte
developed poor interactions I didn't have the bandwidth to address in
addition to my regular duties.

While the optimization effort was ongoing, my general approach was to
hunt for patches to forward port or "combine" as opposed to producing
anything original. Many of these things were motivated by a combination
of a priori reasoning about what was going on with various profile-based
hints. For instance, on ia32 NUMA, all lowmem is on node 0. I observed
that pagetable _teardown_ was expensive, and this in the loops over
pmd's to remove pagetable pages. My attack was to hoist the pmd's into
node-local memory by shoving it into highmem, where Andrea's pte-highmem
and Arjan and Ingo's highpte were both strong precedents. I combined the
two approaches, as Andrea placed pmd's in highmem, while Arjan and Ingo
used kmap_atomic() and the like to avoid kmap_lock overhead and so on.
All that was, in fact, after some abortive attempts to punt pagetable
teardown to keventd, which while mechanically successful (i.e. the code
worked) was not effective as a performance improvement.

Many of the other patches were even more direct equivalents of some
predecessor. For instance, this unnameable benchmark spawns ps(1) very
frequently to simulate users monitoring their own workloads. This then
very heavily stresses the /proc/ VM reporting code and the /proc/ vfs
code. To address this, I ported whatever vfs RCU code I could that
maneesh and dipankar had written, and _also_ ported bcrl's O(1)
proc_pid_statm() from RH's 2.4.9, which resolved semaphore contention
issues and more general algorithmic efficiency issues in /proc/
reporting. With that and various BKL-related /proc/ adjustments, the
/proc/ -stressing components were speeded up greatly. This differs a
lot from other attacks on this benchmark, where the benchmark is
altered so the parts stressing /proc/ are removed. I also had in the
back of my mind the notion that /proc/ performance improvements would
be appreciated by end users with limited cpu power to devote to the
monitoring of their workloads and machines' performance, which is part
of what motivated me to do it "the hard way" instead of modifying the
benchmark or replacing the userspace procps utilities with /dev/kmem
-diving utilities.

The general points this is all meant to illustrate are that some of the
cherrypicking going on doesn't really make sense, and to give the
background on where all this stuff came from so you can understand
which parts are going to be useful to you if you do choose to cherrypick
them. I very much regret not arranging relative benchmark results to
post, as they are very impressive for not having exploited the extreme
NUMA characteristics of the test machines. In the very strict sense of
the slope of the curve as the number of processors increases, the
original patch set was measured to literally double the kernel's
scalability in this benchmark, which is something I'm rather proud of.
There were other approaches which exploited the NUMA hardware aspects
to achieve more drastic results with less code, but had more limited
applicability as non-NUMA machines didn't benefit from them at all.

Also, there will be new -wli's. They will be vastly different in nature
from the prior -wli's. I don't like repeating myself. I already
acknowledged the precedents available to me in the 2.5.74 era. The new
-wli's won't be as heavily influenced by precedents and will be of a
substantially different character from the prior releases. I'm taking my
time to do this and for a good reason. I don't want to do it half-assed.

It may not be VM. It may not be any one thing. What it _will_ be (unlike
some of the prior -wli code) is up to my own personal coding standards,
which you may rest assured are rather high.

And finally, even with all this longwinded harangue, congratulations on
your tree. There are very definite feelings of importance and
satisfaction of having done service from producing releases others rely
upon. And these are real, as real users do benefit from what you've
assembled. I'm more than happy to help if you have bugreports in any
code I maintained or other need to call on me. And whatever precedent I
may have provided, you do own this, and this is your own original work.


-- wli
