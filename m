Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbTDFCCJ (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 21:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262778AbTDFCCJ (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 21:02:09 -0500
Received: from holomorphy.com ([66.224.33.161]:52120 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262776AbTDFCCG (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 21:02:06 -0500
Date: Sat, 5 Apr 2003 18:13:00 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: andrea@suse.de, mbligh@aracnet.com, mingo@elte.hu, hugh@veritas.com,
       dmccr@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030406021300.GI993@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, andrea@suse.de, mbligh@aracnet.com,
	mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030404163154.77f19d9e.akpm@digeo.com> <12880000.1049508832@flay> <20030405024414.GP16293@dualathlon.random> <20030404192401.03292293.akpm@digeo.com> <20030405040614.66511e1e.akpm@digeo.com> <20030405232524.GD1828@holomorphy.com> <20030405155740.3da6a5bf.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030405155740.3da6a5bf.akpm@digeo.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> This seems ominous; I hope that methods of reducing "external
>> interference" as I called it are able to salvage the space conservation
>> benefits. IMHO this is the most important of the tests posted.

On Sat, Apr 05, 2003 at 03:57:40PM -0800, Andrew Morton wrote:
> Well the third test (one task, 10k windows into a large file) does not seem
> like an unreasonable design for an application.

They're all useful, but I thought this was the "most typical" usage case.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> I'm actually somewhat surprised that any (much less all) of the three
>> behaved so well with a random access pattern. AIUI workloads without
>> locality of reference are not really very well served by LRU replacement;
>> perhaps this understanding should be revised.

On Sat, Apr 05, 2003 at 03:57:40PM -0800, Andrew Morton wrote:
> Note the "-i 1".  That's one iteration, as opposed to ten.
> Given that we managed to achieve 100 milliseconds of user CPU time in four
> minutes, this isn't really interesting.  It is completely IO-bound and the
> machine is underprovisioned for the load which it is running.

Point, a large buffering arena is needed for this kind of load to be
effective in order to coalesce io.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> This doesn't appear to be the kind of issue that would be addressed by
>> the more advanced search structure to replace ->i_mmap and ->i_mmap_shared.

On Sat, Apr 05, 2003 at 03:57:40PM -0800, Andrew Morton wrote:
> We have 10000 disjoint VMA's and we want to find the one which maps this
> page.  If we cannot solve this then we have a problem.

It's a matter of programming stuff described in various textbooks and
papers, so aside from lacking an implementation and/or being behind
schedule implementing it, I think we're fine.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> I'm somewhat surprised the virtualscan does so poorly; from an a priori
>> POV with low sharing and linear access there's no obvious reason in my
>> mind why it would do as poorly as or worse than the objrmap here.

On Sat, Apr 05, 2003 at 03:57:40PM -0800, Andrew Morton wrote:
> The virtual scan did well in all tests I _think_.  What happened in this test
> is that the IO scheduling was crap - the disk sounded like a dentist's drill.
> Could be that this is due to the elevator changes which Andrea has made, or
> perhaps fault-time readaround is broken or something else.  The file layout
> was effectivey identical in both kernels.  I don't know, but I think it's
> unrelated to the scanning design.

Bad seeking behavior could easily explain it; I was at a loss to
explain what on earth things could be blocked on, as I've gotten
perhaps too used to large buffering arenas being readily available.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> I'm not sure why objrmap is chewing so much cpu here. There doesn't
>> appear to be any sharing happening.

On Sat, Apr 05, 2003 at 03:57:40PM -0800, Andrew Morton wrote:
> The file has 10k vma's attached to it.  The VM has to scan 50% of those for
> each page_referenced() and try_to_unmap() attempt against each page.
> It shouldn't be too hard to locate the first VMA which covers file offset N
> with a tree or whatever.

Sorry, I misunderstood this part of the test. I thought each vma had a
different file when I wrote the post.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> Hmm, thing is, it can be fixed for 100K mostly disjoint vma's per file
>> by going to an O(lg(vmas)) ->i_mmap/->i_mmap_shared structure, but it
>> can't be fixed that way for 10K vma's all pointing to different files

On Sat, Apr 05, 2003 at 03:57:40PM -0800, Andrew Morton wrote:
> We don't have to solve the "all pointing to different files" problem do we?

I sure hope not, because I don't see a way to fix it at all.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> or 100K vma's covering identical ranges.

On Sat, Apr 05, 2003 at 03:57:40PM -0800, Andrew Morton wrote:
> 100k vma's covering identical ranges is not too bad.  Because we know
> that they all cover the page we're interested in.  (assuming they're
> all the same length..)
> Yes, there is the secondary inefficeincy that not all of the vma's
> pagetables are necessarily actively mapping the page, but at least
> the main problem of searching completely irrelevant vma's isn't there.

>From your test it does seem like the thinning the search space by
filtering out irrelevant vma's is more important than avoiding the
top-down pagetable walk.

That secondary inefficiency is what I called "internal interference";
I suspect its importance was overestimated.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> IMHO it's worthwhile to
>> pursue the space conservation benefits even at the price of some
>> complexity, but of course what you want to merge is (unfortunately for
>> some, possibly even me) another matter.

On Sat, Apr 05, 2003 at 03:57:40PM -0800, Andrew Morton wrote:
> Well I haven't seen anything yet, alas.
> Is the pte_chain space saving which page clustering gives not sufficient?

Well, there are caveats. Don't look at the code yet, the fault handler
bits are really disgusting at the moment and in general it isn't doing
all of what it's supposed to. I really had to sort of burst out with
the announcement in advance of my 2.5 code being ready to display for
reasons of timing of hardware availability. Some time in the future
arrangements will be made for infrequent but regular testing of it.

First, the MMUPAGE_SIZE-sized pieces of a truly anonymous (not
MAP_SHARED) page are intentionally scattered, so no one PTE is truly
representative of the which one maps the page. So only truly file-
backed pages can have the linear space reduction applied if/when it is
reducing the space savings below a factor of PAGE_MMUCOUNT. This also
means the optimization requires special-casing of file-backed pages vs.
anonymous pages while creating and scanning pte_chains (codesize hit).
This also means a pte_chain allocation is required for a fully utilized
anonymous page, as several PTE's would map it, where before PG_direct
is almost universally usable for truly anonymous pages.

Second, it's only a linear reduction in the number of PTE's per process
address space required to be chained, the number of sharers still
causes the same space consumption pattern, albeit with a (maximum of a)
something below PAGE_MMUCOUNT factor decrease in growth rate.

Third, this doesn't account for pagecache fragmentation, so partial
mappings of a page require a pte_chain and the net reduction of
PAGE_MMUCOUNT is reduced further by the aggregate proportion of
utilization of file-backed pages.

The sum of these three effects is that I expect the space reduction
page clustering can achieve for pte_chains is nondeterministic and
something less than the "natural" factor would suggest. It may actually
solve it for everyone, but I'm very uncertain of whether it would.

There is another reason I favor the object-based methods, which is
that the pointwise methods are (codewise) more complex when combined
with it. It might really be too early to evaluate this, as not only am
I lacking required functionality and bugfixes that might otherwise make
the interactions more apparent, but I'm also missing a demonstration of
how page clustering and the object-based methods act in combination.
Better motives for page clustering would be larger fs blocksize support
and mem_map[] size reduction, as those effects are known a priori.

(Whether it's desirable for everyone to use larger fs blocksizes is an
open question, as you mentioned earlier in a private message.)


-- wli
