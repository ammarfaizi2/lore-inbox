Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbTDVQqy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 12:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263225AbTDVQqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 12:46:54 -0400
Received: from franka.aracnet.com ([216.99.193.44]:20700 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263219AbTDVQqu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 12:46:50 -0400
Date: Tue, 22 Apr 2003 09:58:42 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@redhat.com>
cc: Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <1040000.1051030721@[10.10.2.4]>
In-Reply-To: <20030422162055.GJ8978@holomorphy.com>
References: <20030422145644.GG8978@holomorphy.com>
 <Pine.LNX.4.44.0304221110560.10400-100000@devserv.devel.redhat.com>
 <20030422162055.GJ8978@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> using nonlinear mappings adds the overhead of pte chains, which roughly
>> doubles the pagetable overhead. (or companion pagetables, which triple
>> the pagetable overhead) Purely RAM-wise the break-even point is at
>> around 8 pages, 8 pte chain entries make up for 64 bytes of vma overhead.
>> the biggest problem i can see is that we (well, the kernel) has to make a
>> judgement of RAM footprint vs. algorithmic overhead, which is apples to
>> oranges. Nonlinear vmas [or just linear vmas with pte chains installed],
>> while being only O(N), double/triple the pagetable overhead. objrmap
>> linear vmas, while having only the pagetable overhead, are O(N^2). [well,
>> it's O(N*M)]
>> RAM-footprint wise the boundary is clear: above 8 pages of granularity,
>> vmas with objrmap cost less RAM than nonlinear mappings.
>> CPU-time-wise the nonlinear mappings with pte chains always beat objrmap.
> 
> There's definitely an argument brewing here. Large 32-bit is very space
> conscious; the rest of the world is largely oblivious to these specific
> forms of space consumption aside from those tight on space in general.

However, the time consumption affects everybody. The overhead of pte-chains
is very significant ... people seem to be conveniently forgetting that for
some reason. Ingo's rmap_pages thing solves the lowmem space problem, but
the time problem is still there, if not worse.

Please don't create the impression that rmap methodologies are only an
issue for large 32 bit machines - that's not true at all.

People seem to be focused on one corner case of performance for objrmap ...
If you want a countercase for pte-chain based rmap, try creating 1000
processes in a machine with a decent amount of RAM. Make them share
libraries (libc, etc), and then fork and exit in a FIFO rolling fashion.
Just forking off a bunch of stuff (regular programs / shell scripts) that
do similar amounts of work will presumably approximate this. Kernel
compiles see large benefits here, for instance. Things that were less
dominated by userspace calculations would see even bigger changes.

I've not seen anything but a focused microbenchmark deliberately written
for the job do better on pte-chain based rmap that partial objrmap yet. If
we had something more realistic, it would become rather more interesting.

M.
