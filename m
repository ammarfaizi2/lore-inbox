Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263086AbTDVLnA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 07:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263096AbTDVLnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 07:43:00 -0400
Received: from holomorphy.com ([66.224.33.161]:45209 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263086AbTDVLm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 07:42:56 -0400
Date: Tue, 22 Apr 2003 04:54:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       mbligh@aracnet.com, mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030422115421.GC8931@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@digeo.com>,
	Andrea Arcangeli <andrea@suse.de>, mbligh@aracnet.com,
	mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030405143138.27003289.akpm@digeo.com> <Pine.LNX.4.44.0304220618190.24063-100000@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304220618190.24063-100000@devserv.devel.redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Apr 2003, Andrew Morton wrote:
>> And treating the nonlinear mappings as being mlocked is a great
>> simplification - I'd be interested in Ingo's views on that.

On Tue, Apr 22, 2003 at 07:00:05AM -0400, Ingo Molnar wrote:
> i believe the right direction is the one that is currently happening: to
> make nonlinear mappings more generic. sys_remap_file_pages() started off
> as a special hack mostly usable for locked down pages. Now it's directly
> encoded in the pte and thus swappable, and uses up a fraction of the vma
> cost for finegrained mappings.
> (i believe the next step should be to encode permission bits into the pte
> as well, and thus enable eg. mprotect() to work without splitting up vmas.  
> On 32-bit ptes this is not relistic due to the file size limit imposed,
> but once 64-bit ptes become commonplace it's a step worth taking i
> believe.)

Are the reserved bits in PAE kernel-usable at all or do they raise
exceptions when set? This may be cpu revision -dependent, but if things
are usable in some majority of models it could be ihteresting.


On Tue, Apr 22, 2003 at 07:00:05AM -0400, Ingo Molnar wrote:
> the O(N^2) property of objrmap where N is the 'inode sharing factor' is a
> serious design problem i believe. 100 mappings in 100 contexts on the same
> inode is not uncommon at all - still it totally DoS-es the VM's scanning
> code, if it uses objrmap. Sure, rmap is O(N) - after all we do have 100
> users of that mapping.
> If the O(N^2) can be optimized away then i'm all for it. If not, then i
> dont really understand how the same people who call sys_remap_file_pages()
> a 'hack' [i believe they are not understanding the current state of the
> API] can argue for objrmap in the same paragraph.
> i believe the main problem wrt. rmap is the pte_chain lowmem overhead on
> 32-bit systems. (it also causes some fork() runtime overhead, but i doubt
> anyone these days should argue that fork() latency is a commanding
> parameter to optimize the VM for. We have vfork() and good threading, and
> any fork()-sensitive app uses preforking anyway.)

pte_chain lowmem overhead is relatively serious. It seems to be the
main motivator of objrmap. OTOH I tend to fall on the other side of the
fence from the "pagetables are sacred relics" or whatever camp and
would prefer to keep things less pte-based, but am not terribly
religious about it.


On Tue, Apr 22, 2003 at 07:00:05AM -0400, Ingo Molnar wrote:
> to solve this problem i believe the pte chains should be made
> double-linked lists, and should be organized in a completely different
> (and much simpler) way: in a 'companion page' to the actual pte page. The
> companion page stores the pte-chain links, corresponding directly to the
> pte in the pagetable. Ie. if we have pte #100 in the pagetable, then we
> look at entry #100 in the companion page. [the size of the page is
> platform-dependent, eg. on PAE x86 it's a single page, on 64-platforms
> it's two pages most of the time.] That entry then points to the 'next' and
> 'previous' pte in the pte chain. [the pte pagetable page itself has
> pointers towards the companion page(s) in the struct page itself, existing
> fields can be reused for this.]
> This simpler pte chain construct also makes it easy to high-map the pte
> chains: whenever we high-map the pte page, we can high-map the pte chain
> page(s) as well. No more lowmem overhead for pte chains.

Getting the things out of lowmem sounds very interesting, although I
vaguely continue to wonder about the total RAM overhead. ISTR an old
2.4 benchmark run on PAE x86 where 90+% of physical RAM was consumed by
pagetables _after_ pte_highmem (where before the kernel dropped dead).

I've thought about just reaping pagetables (and hence pte_chains) many
times but haven't carried it through. It sounds mostly orthogonal to
everything else, and after it, all the "workload feasibility patches"
are just optimizations we can think about merging whenever we're ready.
I like it no no small part b/c the PAE-specific damage is entirely nil.
I wonder if that might be a better in-tree solution and if various
other PAE-specific lowmem consumption optimizations are really necessary
for a mainline tree, or if they could sit out-of-tree for 5-10 years
until ppc64 or ia64 (anything but that opcode prefix hack) takes over.
OTOH if everyone uses it, it begs the question of "why not merge it?"

Also, my general measurements of PTE utilization on i386 are somewhere
around 20%, which is an absurd amount of waste.

But anyway, companion pages are doable. The real metric is what the
code looks like and how it performs and what workloads it supports.


On Tue, Apr 22, 2003 at 07:00:05AM -0400, Ingo Molnar wrote:
> It also makes it easy to calculate the overhead of the pte chains: twice
> the amount of pagetable overhead. Ie. with 32-bit pte's it's +8 bytes
> overhead, or +0.2% of RAM overhead per mapped page, using a 4K page. With
> 64-bit ptes on 32-bit platforms (PAE), the overhead is still 8 bytes. On
> 64-bit platforms using 8K pages the overhead is still +0.2% of RAM, in
> additionl to the 0.1% of RAM overhead for the pte itself. The worst-case
> is 64-bit platforms with a 4K pagesize, there the overhead is +0.4% of
> RAM, in addition to the 0.2% overhead caused by the pte itself.

I would not say 0.4% of RAM. I would say 0.4% of aggregate virtualspace.
So someone needs to factor virtual:physical ratio for the important
workloads into that analysis.


On Tue, Apr 22, 2003 at 07:00:05AM -0400, Ingo Molnar wrote:
> (as a comparison, for finegrained mappings, if a single page is mapped by
> a single vma, the 64-byte overhead of the vma causes a +1.5% overhead.)
> so i think it's doable, and it solves many of the hairy allocation
> deadlock issues wrt. pte-chains - the 'companion pages' hosting the pte
> chain back and forward pointers can be allocated at the same time a
> pagetable page is allocated. I believe this approach also greatly reduces
> the complexity of pte chains, plus it makes unmap-time O(1) unlinking of
> pte chains possible. If we can live with the RAM overhead.  (which would
> scale linearly with the already existing pagetable overhead.)

Well, the already-existing pagetable overhead is not insignificant.
It's somewhere around 3MB on lightly-loaded 768MB x86-32 UP, which is
very close to beginning to swap.


-- wli

$ uname -a
Linux megeira 2.5.68 #1 SMP Mon Apr 21 22:01:35 PDT 2003 i686 unknown unknown GNU/Linux
$ cat /proc/meminfo
MemTotal:     65949952 kB
MemFree:      65840448 kB
Buffers:          5472 kB
Cached:          15328 kB
SwapCached:          0 kB
Active:          37536 kB
Inactive:        12864 kB
HighTotal:    65198080 kB
HighFree:     65131968 kB
LowTotal:       751872 kB
LowFree:        708480 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:          24320 kB
Slab:            13216 kB
Committed_AS:     7164 kB
PageTables:       2304 kB
VmallocTotal:   131080 kB
VmallocUsed:      4552 kB
VmallocChunk:   126528 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB
$ 

(yep, that's pgcl-2.5.68-1A)
