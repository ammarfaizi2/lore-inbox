Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbTDEXpL (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 18:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbTDEXpL (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 18:45:11 -0500
Received: from [12.47.58.55] ([12.47.58.55]:2196 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262722AbTDEXpJ (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 18:45:09 -0500
Date: Sat, 5 Apr 2003 15:57:40 -0800
From: Andrew Morton <akpm@digeo.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: andrea@suse.de, mbligh@aracnet.com, mingo@elte.hu, hugh@veritas.com,
       dmccr@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-Id: <20030405155740.3da6a5bf.akpm@digeo.com>
In-Reply-To: <20030405232524.GD1828@holomorphy.com>
References: <20030404163154.77f19d9e.akpm@digeo.com>
	<12880000.1049508832@flay>
	<20030405024414.GP16293@dualathlon.random>
	<20030404192401.03292293.akpm@digeo.com>
	<20030405040614.66511e1e.akpm@digeo.com>
	<20030405232524.GD1828@holomorphy.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Apr 2003 23:56:34.0033 (UTC) FILETIME=[FCA56E10:01C2FBCE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Sat, Apr 05, 2003 at 04:06:14AM -0800, Andrew Morton wrote:
> > The first test has 100 tasks, each of which has 100 vma's.  The 100 processes
> > modify their 100 vma's in a linear walk.  Total working set is 240MB
> > (slightly more than is available).
> > 	./rmap-test -l -i 10 -n 100 -s 600 -t 100 foo
> > 2.5.66-mm4:
> > 	15.76s user 86.91s system 33% cpu 5:05.07 total
> > 2.5.66-mm4+objrmap:
> > 	23.07s user 1143.26s system 87% cpu 22:09.81 total
> > 2.4.21-pre5aa2:
> > 	14.91s user 75.30s system 24% cpu 6:15.84 total
> 
> This seems ominous; I hope that methods of reducing "external
> interference" as I called it are able to salvage the space conservation
> benefits. IMHO this is the most important of the tests posted.

Well the third test (one task, 10k windows into a large file) does not seem
like an unreasonable design for an application.

> 
> On Sat, Apr 05, 2003 at 04:06:14AM -0800, Andrew Morton wrote:
> > In the second test we again have 100 tasks, each with 100 vma's but the
> > access pattern is random:
> > 	./rmap-test -vv -V 2 -r -i 1 -n 100 -s 600 -t 100 foo
> > 2.5.66-mm4:
> > 	0.12s user 6.05s system 2% cpu 3:59.68 total
> > 2.5.66-mm4+objrmap:
> > 	0.12s user 2.10s system 0% cpu 4:01.15 total
> > 2.4.21-pre5aa2:
> > 	0.07s user 2.03s system 0% cpu 4:12.69 total
> > The -aa VM failed in this test.
> > 	__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > 	VM: killing process rmap-test
> > I'd have to call this a bug - the machine was full of reclaimable memory.
> > I also saw the 2.4 kernel do 705,000 context switches in a single second,
> > which was odd.  It only happened once.
> 
> I'm actually somewhat surprised that any (much less all) of the three
> behaved so well with a random access pattern. AIUI workloads without
> locality of reference are not really very well served by LRU replacement;
> perhaps this understanding should be revised.

Note the "-i 1".  That's one iteration, as opposed to ten.

Given that we managed to achieve 100 milliseconds of user CPU time in four
minutes, this isn't really interesting.  It is completely IO-bound and the
machine is underprovisioned for the load which it is running.

> 
> On Sat, Apr 05, 2003 at 04:06:14AM -0800, Andrew Morton wrote:
> > In the third test a single task owns 10000 VMA's and walks across them in a
> > linear pattern:
> > 	./rmap-test -v -l -i 10 -n 10000 -s 7 -t 1 foo
> > 2.5.66-mm4:
> > 	0.25s user 3.75s system 1% cpu 4:38.44 total
> > 2.5.66-mm4+objrmap:
> > 	0.28s user 146.45s system 16% cpu 15:14.59 total
> > 2.4.21-pre5aa2:
> > 	0.32s user 4.83s system 0% cpu 18:25.90 total
> 
> This doesn't appear to be the kind of issue that would be addressed by
> the more advanced search structure to replace ->i_mmap and ->i_mmap_shared.

We have 10000 disjoint VMA's and we want to find the one which maps this
page.  If we cannot solve this then we have a problem.

> I'm somewhat surprised the virtualscan does so poorly; from an a priori
> POV with low sharing and linear access there's no obvious reason in my
> mind why it would do as poorly as or worse than the objrmap here.

The virtual scan did well in all tests I _think_.  What happened in this test
is that the IO scheduling was crap - the disk sounded like a dentist's drill.

Could be that this is due to the elevator changes which Andrea has made, or
perhaps fault-time readaround is broken or something else.  The file layout
was effectivey identical in both kernels.  I don't know, but I think it's
unrelated to the scanning design.

> I'm not sure why objrmap is chewing so much cpu here. There doesn't
> appear to be any sharing happening.

The file has 10k vma's attached to it.  The VM has to scan 50% of those for
each page_referenced() and try_to_unmap() attempt against each page.

It shouldn't be too hard to locate the first VMA which covers file offset N
with a tree or whatever.

> Hmm, thing is, it can be fixed for 100K mostly disjoint vma's per file
> by going to an O(lg(vmas)) ->i_mmap/->i_mmap_shared structure, but it
> can't be fixed that way for 10K vma's all pointing to different files

We don't have to solve the "all pointing to different files" problem do we?

> or 100K vma's covering identical ranges.

100k vma's covering identical ranges is not too bad.  Because we know that
they all cover the page we're interested in.  (assuming they're all the same
length..)

Yes, there is the secondary inefficeincy that not all of the vma's pagetables
are necessarily actively mapping the page, but at least the main problem of
searching completely irrelevant vma's isn't there.

> IMHO it's worthwhile to
> pursue the space conservation benefits even at the price of some
> complexity, but of course what you want to merge is (unfortunately for
> some, possibly even me) another matter.

Well I haven't seen anything yet, alas.

Is the pte_chain space saving which page clustering gives not sufficient?


