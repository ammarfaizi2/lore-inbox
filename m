Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbTDVOpV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 10:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263180AbTDVOpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 10:45:21 -0400
Received: from holomorphy.com ([66.224.33.161]:53914 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263178AbTDVOpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 10:45:19 -0400
Date: Tue, 22 Apr 2003 07:56:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       mbligh@aracnet.com, mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030422145644.GG8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@digeo.com>,
	Andrea Arcangeli <andrea@suse.de>, mbligh@aracnet.com,
	mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030422115421.GC8931@holomorphy.com> <Pine.LNX.4.44.0304221017200.10400-100000@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304221017200.10400-100000@devserv.devel.redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Apr 2003, William Lee Irwin III wrote:
>> Are the reserved bits in PAE kernel-usable at all or do they raise
>> exceptions when set? This may be cpu revision -dependent, but if things
>> are usable in some majority of models it could be ihteresting.

On Tue, Apr 22, 2003 at 10:31:49AM -0400, Ingo Molnar wrote:
> if the present bit is clear then the remaining 63 bits are documented by
> Intel as being software-available, so this all works just fine.

Sorry; I should have caught that from the standard docs; I was over-
anticipating something involving valid PTE's.


On Tue, 22 Apr 2003, William Lee Irwin III wrote:
>> Getting the things out of lowmem sounds very interesting, although I
>> vaguely continue to wonder about the total RAM overhead. ISTR an old 2.4
>> benchmark run on PAE x86 where 90+% of physical RAM was consumed by
>> pagetables _after_ pte_highmem (where before the kernel dropped dead).

On Tue, Apr 22, 2003 at 10:31:49AM -0400, Ingo Molnar wrote:
> just create a sparse enough memory layout (one page mapped every 2MB) and
> pagetable overhead will dominate. Is it a problem in practice? I doubt it,
> and you get what you asked for, and you can always offset it with RAM.

Actually it wasn't from sparse memory, it was from massive sharing.
Basically 10000 processes whose virtualspace was dominated by shmem
shared across all of them.

On some reflection I suspect a variety of techniques are needed here.


On Tue, 22 Apr 2003, William Lee Irwin III wrote:
>> Well, the already-existing pagetable overhead is not insignificant. It's
>> somewhere around 3MB on lightly-loaded 768MB x86-32 UP, which is very
>> close to beginning to swap.

On Tue, Apr 22, 2003 at 10:31:49AM -0400, Ingo Molnar wrote:
> 3MB might sound alot. Companion pagetables will make that 9MB on non-PAE.
> (current pte chains should make that roughly 6MB on average) 9MB is 1.1%
> of all RAM. 4K granular mem_map[] is 1.5% cost, and even there it's not
> mainly the RAM overhead that hurts us, but the lowmem overhead.
> (btw., the size of companion pagetables is likely reduced via pgcl as well
> - they need to track the VM units of pages, not the MMU units of pages.)

Well, the thing is pte_chains are O(utilized_ptes) so it ends up being
around 3MB + 3/5MB == 3.6MB. I've gone and applied the objrmap and
anobjrmap patches (despite the worst case behavior) and the space
savings are very noticeable and very beneficial, though still not as
good as with shpte which cut the sum of the two to well under 2MB.

Also, I'd be _very_ careful when claiming pgcl can offer space
reductions here. Page clustering involves the core VM understanding
that pieces of pages can be scattered about, with anonymous pages in
particularly arbitrary scatter/gather relationships. This breaks the
very assumption people are making when assuming page clustering can
save pte_chain space: that physical contiguity within an anonymous
software page can be exploited to infer small scanning regions to
recover multiple pte's from a single pointer. This is not the case.

For anonymous memory alone (which has been the sole usage of pte_chains
in -mm kernels for some time) the pte_chain space is 5MB except under
the heaviest of memory pressure, where things are temporarily reaped
down to under 100KB. The arbitrary relationship of anonymous pages to
virtual offsets in the presence of page clustering means that most (not
all, but high unpredictability) pte_chains must be retained for them.

At the very least I'd like to have the public opinion on the impact of
page clustering on pte_chain space downgraded from "improvement" to
"no effect whatsoever". My own experience shows:

HighTotal:    65198080 kB
HighFree:     60631808 kB
LowTotal:       751872 kB
LowFree:         25152 kB

dentry_cache               295889K        390350K      75.80%   
ext2_inode_cache           260442K        268617K      96.96%   
buffer_head                   799K          1868K      42.79%   
size-8192                    1760K          1856K      94.83%   
size-1024                    1737K          1767K      98.30%   
pae_pmd                       604K          1152K      52.43%   
biovec-BIO_MAX_PAGES          768K           780K      98.46%   
size-2048                     612K           690K      88.70%   
size-512                      503K           535K      93.93%   
size-64                       270K           450K      59.93%   
task_struct                   310K           428K      72.50%   
biovec-128                    384K           409K      93.77%   
blkdev_requests               396K           404K      98.02%   
inode_cache                   352K           375K      93.96%   
size-4096                     168K           256K      65.62%   
mm_struct                      19K           250K       7.95%   
pte_chain                      75K           227K      33.25%   
proc_inode_cache               72K           220K      32.65%   
biovec-64                     192K           220K      87.07%   
size-256                      162K           218K      74.40%   
radix_tree_node               121K           218K      55.63%   
sighand_cache                 160K           215K      74.40%   
filp                           38K           186K      20.60%   

under light load. I don't trust this to mean much.

Basically, I have _very_ good reasons to believe even after the
discussed potential pte_chain space optimizations page clustering
enables are implemented they will not be highly effective and won't
provide a generally applicable solution to the pte_chain space problem.


-- wli
