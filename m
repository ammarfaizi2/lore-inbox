Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263172AbTDVO0u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 10:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbTDVO0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 10:26:50 -0400
Received: from franka.aracnet.com ([216.99.193.44]:62701 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263172AbTDVO0t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 10:26:49 -0400
Date: Tue, 22 Apr 2003 07:38:37 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Andrea Arcangeli <andrea@suse.de>
cc: Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@digeo.com>,
       mingo@elte.hu, hugh@veritas.com, dmccr@us.ibm.com,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <171790000.1051022316@[10.10.2.4]>
In-Reply-To: <20030422132013.GF8931@holomorphy.com>
References: <20030405143138.27003289.akpm@digeo.com>
 <Pine.LNX.4.44.0304220618190.24063-100000@devserv.devel.redhat.com>
 <20030422123719.GH23320@dualathlon.random>
 <20030422132013.GF8931@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, AFAICT the question wrt. sys_remap_file_pages() is not speed, but
> space. Speeding up mmap() is of course worthy of merging given the
> usual mergeability criteria.
> 
> On this point I must make a concession: k-d trees as formulated by
> Bentley et al have space consumption issues that may well render them
> inappropriate for kernel usage. I still believe it's worth an empirical
> investigation once descriptions of on-line algorithms for their
> maintenance are recovered, as well as other 2D+ spatial algorithms, esp.
> those with better space behavior.
> 
> Specifically, k-d trees require internal nodes to partition spaces that
> are not related to leaf nodes (i.e. data points), and not all
> rebalancing policies are guaranteed to recover space.

We can still do the simple sorted list of lists thing (I have preliminary
non-functional code). But I don't see that it's really worth the overhead
in the common case to fix a corner case that has already been fixed in a
different way.

/*
 * s = address_space, r = address_range, v = vma
 *
 * s - r - r - r - r - r
 *     |   |   |   |   |
 *     v   v   v   v   v
 *     |   |           |
 *     v   v           v
 *         |
 *         v
 */

struct address_range {
       unsigned long           start;
       unsigned long           end;
       struct list_head        ranges;
       struct list_head        vmas;
};

where the list of address_ranges is sorted by start address. This is
intended to make use of the real-world case that many things (like shared
libs) map the same exact address ranges over and over again (ie something
like 3 ranges, but hundreds or thousands of mappings).

M.
