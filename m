Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262733AbTDEXOe (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 18:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbTDEXOe (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 18:14:34 -0500
Received: from holomorphy.com ([66.224.33.161]:27544 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262733AbTDEXOb (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 18:14:31 -0500
Date: Sat, 5 Apr 2003 15:25:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: andrea@suse.de, mbligh@aracnet.com, mingo@elte.hu, hugh@veritas.com,
       dmccr@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030405232524.GD1828@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, andrea@suse.de, mbligh@aracnet.com,
	mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030404163154.77f19d9e.akpm@digeo.com> <12880000.1049508832@flay> <20030405024414.GP16293@dualathlon.random> <20030404192401.03292293.akpm@digeo.com> <20030405040614.66511e1e.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030405040614.66511e1e.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> wrote:
>> Nobody has written an "exploit" for this yet, but it's there.

On Sat, Apr 05, 2003 at 04:06:14AM -0800, Andrew Morton wrote:
> Here we go.  The test app is called `rmap-test'.  It is in ext3 CVS.  See
> 	http://www.zip.com.au/~akpm/linux/ext3/
> It sets up N MAP_SHARED VMA's and N tasks touching them in various access
> patterns.

I apparently erred when I claimed this kind of test would not provide
useful figures of merit for page replacement algorithms. There appears
to be more to life than picking the right pages.


On Sat, Apr 05, 2003 at 04:06:14AM -0800, Andrew Morton wrote:
> The first test has 100 tasks, each of which has 100 vma's.  The 100 processes
> modify their 100 vma's in a linear walk.  Total working set is 240MB
> (slightly more than is available).
> 	./rmap-test -l -i 10 -n 100 -s 600 -t 100 foo
> 2.5.66-mm4:
> 	15.76s user 86.91s system 33% cpu 5:05.07 total
> 2.5.66-mm4+objrmap:
> 	23.07s user 1143.26s system 87% cpu 22:09.81 total
> 2.4.21-pre5aa2:
> 	14.91s user 75.30s system 24% cpu 6:15.84 total

This seems ominous; I hope that methods of reducing "external
interference" as I called it are able to salvage the space conservation
benefits. IMHO this is the most important of the tests posted.


On Sat, Apr 05, 2003 at 04:06:14AM -0800, Andrew Morton wrote:
> In the second test we again have 100 tasks, each with 100 vma's but the
> access pattern is random:
> 	./rmap-test -vv -V 2 -r -i 1 -n 100 -s 600 -t 100 foo
> 2.5.66-mm4:
> 	0.12s user 6.05s system 2% cpu 3:59.68 total
> 2.5.66-mm4+objrmap:
> 	0.12s user 2.10s system 0% cpu 4:01.15 total
> 2.4.21-pre5aa2:
> 	0.07s user 2.03s system 0% cpu 4:12.69 total
> The -aa VM failed in this test.
> 	__alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> 	VM: killing process rmap-test
> I'd have to call this a bug - the machine was full of reclaimable memory.
> I also saw the 2.4 kernel do 705,000 context switches in a single second,
> which was odd.  It only happened once.

I'm actually somewhat surprised that any (much less all) of the three
behaved so well with a random access pattern. AIUI workloads without
locality of reference are not really very well served by LRU replacement;
perhaps this understanding should be revised.


On Sat, Apr 05, 2003 at 04:06:14AM -0800, Andrew Morton wrote:
> In the third test a single task owns 10000 VMA's and walks across them in a
> linear pattern:
> 	./rmap-test -v -l -i 10 -n 10000 -s 7 -t 1 foo
> 2.5.66-mm4:
> 	0.25s user 3.75s system 1% cpu 4:38.44 total
> 2.5.66-mm4+objrmap:
> 	0.28s user 146.45s system 16% cpu 15:14.59 total
> 2.4.21-pre5aa2:
> 	0.32s user 4.83s system 0% cpu 18:25.90 total

This doesn't appear to be the kind of issue that would be addressed by
the more advanced search structure to replace ->i_mmap and ->i_mmap_shared.
I'm somewhat surprised the virtualscan does so poorly; from an a priori
POV with low sharing and linear access there's no obvious reason in my
mind why it would do as poorly as or worse than the objrmap here.

I'm not sure why objrmap is chewing so much cpu here. There doesn't
appear to be any sharing happening. It sounds implausible at first
but it could be checking ->i_mmap and ->i_mmap_shared then walking
all 3 levels of the pagetables once over for each pte to edit. This
would also seem to reflect the case for file-backed pages, where large
amounts of file data are accessed and page replacement is needed, but
actual sharing levels are low, as MAP_SHARED implies the creation of
a different anonymous file object and different memory for each vma.


On Sat, Apr 05, 2003 at 04:06:14AM -0800, Andrew Morton wrote:
> These are not ridiculous workloads, especially the third one.  And 10k VMA's
> is by no means inconceivable.
> The objrmap code will be show-stoppingly expensive at 100k vmas per file.
> And as expected, the full rmap implementation gives the most stable,
> predictable and highest performance result under heavy load.  That's why
> we're using it.
> When it comes to the VM, there is a lot of value in sturdiness under unusual
> and heavy loads.
> Tomorrow I'll change the test app to do nonlinear mappings too.

Hmm, thing is, it can be fixed for 100K mostly disjoint vma's per file
by going to an O(lg(vmas)) ->i_mmap/->i_mmap_shared structure, but it
can't be fixed that way for 10K vma's all pointing to different files
or 100K vma's covering identical ranges. It might be possible to do a
one-off that uses ->pte.direct (or something) for when pages aren't
really shared to avoid walking up and down pagetables, but that's
defeated by a small-but-reasonable constellation of sharers, which is
probably the real typical usage case for large vma counts.

But I don't see a lack of directions to move in; it may well be
possible to mix some pagetable walking in a "related" area to amortize
the pointwise top-down pagetable walking cost, and other things I
haven't thought of yet may also be possible. IMHO it's worthwhile to
pursue the space conservation benefits even at the price of some
complexity, but of course what you want to merge is (unfortunately for
some, possibly even me) another matter.


-- wli
