Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbUCLNX4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 08:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbUCLNX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 08:23:56 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:56333
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261969AbUCLNXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 08:23:54 -0500
Date: Fri, 12 Mar 2004 14:24:36 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Rik van Riel <riel@redhat.com>,
       Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: anon_vma RFC2
Message-ID: <20040312132436.GT30940@dualathlon.random>
References: <20040311135608.GI30940@dualathlon.random> <Pine.LNX.4.44.0403112226581.21139-100000@chimarrao.boston.redhat.com> <20040312122127.GQ30940@dualathlon.random> <20040312124638.GR655@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040312124638.GR655@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 04:46:38AM -0800, William Lee Irwin III wrote:
> On Fri, Mar 12, 2004 at 01:21:27PM +0100, Andrea Arcangeli wrote:
> > you missed the fact mremap doesn't work, that's the fundamental reason
> > for the vma tracking, so you can use vm_pgoff.
> > if you take Hugh's anonmm, mremap will be attaching a persistent dynamic
> > overhead to the vma it touches. Currently it does in form of pte_chains,
> > that can be converted to other means of overhead, but I simply don't
> > like it.
> > I like all vmas to be symmetric to each other, without special hacks to
> > handle mremap right.
> > We have the vm_pgoff to handle mremap and I simply use that.
> 
> Absolute guarantees are nice but this characterization is too extreme.
> The case where mremap() creates rmap_chains is so rare I never ever saw
> it happen in 6 months of regular practical use and testing. Their
> creation could be triggered only by remap_file_pages().

did you try specweb with apache? that's super heavy mremap as far as I
know (and it maybe using anon memory, and if not I certainly cannot
exclude other apps are using mremap on significant amounts of anymous
ram). To a point that the kmap_lock for the persistent kmaps I used
originally in mremap (at least it has never been racy) was a showstopper
bottleneck spending most of system time there (profiling was horrible in
the kmap_lock) and I had to fixup the 2.6 way with the per-cpu atomic
kmaps to avoid being an order of magnitude slower than in the small
boxes w/o highmem.

the single reason I'm doing this work is to avoid allocating the
pte_chains and to always use the vma instead. If I've to use the
pte_chains again for mremap (hoping that no application is using mremap)
then I'm not at all happy since people could still fall in the pte_chain
trap with some app.

Amittedly the pte_chains makes perfect sense only for nonlinear vmas,
since the vma is meaningless for the nonlinear vmas and really a
per-page cost makes sense there, but I'm not going to add 8 bytes
per-page to swapout the nonlinear vmas efficiently, and I'll let the cpu
pay for that if you really need to swap the nonlinear mappings (i.e. the
pagetable walk). An alternate way would been to dynamically allocate the
per-pte pointer, but that will throw a whole lot of memory at the
problem too, and one of the main points for using nonlinear maps is to
avoid the allocation of the vmas, so I doubt people really want to
allocate lots of ram to handle nonlinear efficiently, so I believe
saving all ram at the expense of cpu cost during swapping will be ok.
