Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263207AbTDVPOd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 11:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263209AbTDVPOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 11:14:33 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:21961 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263207AbTDVPO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 11:14:29 -0400
Date: Tue, 22 Apr 2003 11:26:21 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       <mbligh@aracnet.com>, <mingo@elte.hu>, <hugh@veritas.com>,
       <dmccr@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: objrmap and vmtruncate
In-Reply-To: <20030422145644.GG8978@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0304221110560.10400-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Apr 2003, William Lee Irwin III wrote:

> > just create a sparse enough memory layout (one page mapped every 2MB) and
> > pagetable overhead will dominate. Is it a problem in practice? I doubt it,
> > and you get what you asked for, and you can always offset it with RAM.
> 
> Actually it wasn't from sparse memory, it was from massive sharing.
> Basically 10000 processes whose virtualspace was dominated by shmem
> shared across all of them.
> 
> On some reflection I suspect a variety of techniques are needed here.

there are two main techniques to reduce per-context pagetable-alike
overhead: 1) the use of pagetable sharing via CLONE_VM 2) the use of
bigger MMU units with a much smaller pagetable hw cost [hugetlbs].

all of this is true, and still remains valid. None of this changes the
fact that objrmap, as proposed, introduces a quadratic component to a
central piece of code. If then we should simply abort any mmap() attempt
that increases the sharing factor above a certain level, or something like
that.

using nonlinear mappings adds the overhead of pte chains, which roughly
doubles the pagetable overhead. (or companion pagetables, which triple the
pagetable overhead) Purely RAM-wise the break-even point is at around 8
pages, 8 pte chain entries make up for 64 bytes of vma overhead.

the biggest problem i can see is that we (well, the kernel) has to make a
judgement of RAM footprint vs. algorithmic overhead, which is apples to
oranges. Nonlinear vmas [or just linear vmas with pte chains installed],
while being only O(N), double/triple the pagetable overhead. objrmap
linear vmas, while having only the pagetable overhead, are O(N^2). [well,
it's O(N*M)]

RAM-footprint wise the boundary is clear: above 8 pages of granularity,
vmas with objrmap cost less RAM than nonlinear mappings.

CPU-time-wise the nonlinear mappings with pte chains always beat objrmap.

	Ingo

