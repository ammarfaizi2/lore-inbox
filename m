Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbTDEVLh (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 16:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbTDEVLh (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 16:11:37 -0500
Received: from [12.47.58.55] ([12.47.58.55]:65420 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262655AbTDEVLg (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 16:11:36 -0500
Date: Sat, 5 Apr 2003 13:24:06 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: mbligh@aracnet.com, mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-Id: <20030405132406.437b27d7.akpm@digeo.com>
In-Reply-To: <20030405163003.GD1326@dualathlon.random>
References: <20030404163154.77f19d9e.akpm@digeo.com>
	<12880000.1049508832@flay>
	<20030405024414.GP16293@dualathlon.random>
	<20030404192401.03292293.akpm@digeo.com>
	<20030405040614.66511e1e.akpm@digeo.com>
	<20030405163003.GD1326@dualathlon.random>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Apr 2003 21:23:00.0998 (UTC) FILETIME=[893FDA60:01C2FBB9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Sat, Apr 05, 2003 at 04:06:14AM -0800, Andrew Morton wrote:
> > Andrew Morton <akpm@digeo.com> wrote:
> > >
> > > Nobody has written an "exploit" for this yet, but it's there.
> > 
> > Here we go.  The test app is called `rmap-test'.  It is in ext3 CVS.  See
> > 
> > 	http://www.zip.com.au/~akpm/linux/ext3/
> > 
> > It sets up N MAP_SHARED VMA's and N tasks touching them in various access
> > patterns.
> 
> I'm not questioning during paging rmap is more efficient than objrmap,
> but your argument about rmap having lower complexity of objrmap and that
> rmap is needed is wrong. The fact is that with your 100 mappings per
> each of the 100 tasks case, both algorithms works in O(N) where N is
> the number of the pagetables mapping the page.

Nope.  To unmap a page, full rmap has to scan 100 pte_chain slots, which is 3
cachelines worth.  objrmap has to scan 10,000 vma's, 9,900 of which do not map
that page at all.

(Actually, there's a recent optimisation in objrmap which will on average
halve these figures).

> And objrmap can't avoided, it's needed for the truncate semantics
> against mmap.

What do you mean by this?  vmtruncate continues to use the 2.4 algorithm for
that.

> Check all other important benchmarks not testing the paging load like
> page faults, kernel compile from Martin, fork, AIM etc... Those are IMHO
> an order of magnitude of more interest than your rmap-test paging load
> with some hundred thousand of vmas.

Andrea, I whine about rmap as much as anyone ;) I'm the guy who halved both
its speed and space overhead shortly after it was merged.

But the fact is that it is not completely useless overhead.  It provides a
very robust VM which is stable and predictable under extreme and unusual
loads.  That is valuable.

Yes, rmap adds a few% speed overhead - up to 10% for things which are
admittedly already very inefficient.

objrmap will reclaim a lot of that common-case overhead.  But the cost of
that is apparently unviability for certain workloads on certain machines. 
Once you hit 100k VMA's it's time to find a new operating system.

Maybe that is a tradeoff we want to make.  I'm adding some balance here.

The space consumption of rmap is a much more serious problem than the speed
overhead.  It makes some workloads on huge ia32 machines unviable.


Me, I have never seen any evidence that we need any of it.  I have never seen
a demonstration of the alleged failure modes of 2.4's virtual scan.  But then
I haven't tried very hard.

The extreme stability and scalability of full rmap is good.  The space
consumption on highmem is bad.  The CPU cost is much less important than
these things.

