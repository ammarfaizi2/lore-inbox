Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932344AbWBUXrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbWBUXrU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWBUXrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:47:20 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:51869 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S932344AbWBUXrT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:47:19 -0500
Date: Wed, 22 Feb 2006 10:39:50 +1100
From: David Gibson <dwg@au1.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: William Lee Irwin <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Block reservation for hugetlbfs
Message-ID: <20060221233950.GB20872@localhost.localdomain>
Mail-Followup-To: David Gibson <dwg@au1.ibm.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	William Lee Irwin <wli@holomorphy.com>, linux-kernel@vger.kernel.org
References: <20060221022124.GA18535@localhost.localdomain> <43FA94B3.4040904@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FA94B3.4040904@yahoo.com.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 03:18:59PM +1100, Nick Piggin wrote:
> David Gibson wrote:
> >These days, hugepages are demand-allocated at first fault time.
> >There's a somewhat dubious (and racy) heuristic when making a new
> >mmap() to check if there are enough available hugepages to fully
> >satisfy that mapping.
> >
> >A particularly obvious case where the heuristic breaks down is where a
> >process maps its hugepages not as a single chunk, but as a bunch of
> >individually mmap()ed (or shmat()ed) blocks without touching and
> >instantiating the blocks in between allocations.  In this case the
> >size of each block is compared against the total number of available
> >hugepages.  It's thus easy for the process to become overcommitted,
> >because each block mapping will succeed, although the total number of
> >hugepages required by all blocks exceeds the number available.  In
> >particular, this defeats such a program which will detect a mapping
> >failure and adjust its hugepage usage downward accordingly.
> >
> >The patch below is a draft attempt to address this problem, by
> >strictly reserving a number of physical hugepages for hugepages inodes
> >which have been mapped, but not instatiated.  MAP_SHARED mappings are
> >thus "safe" - they will fail on mmap(), not later with a SIGBUS.
> >MAP_PRIVATE mappings can still SIGBUS.
> >
> >This patch appears to address the problem at hand - it allows DB2 to
> >start correctly, for instance, which previously suffered the failure
> >described above.  I'm almost certain I'm missing some locking or other
> >synchronization - I am entirely bewildered as to what I need to hold
> >to safely update i_blocks as below.  Corrections for my ignorance
> >solicited...
> >
> >Signed-off-by: David Gibson <dwg@au1.ibm.com>
> >
> 
> This introduces
> tree_lock(r) -> hugetlb_lock
> 
> And we already have
> hugetlb_lock -> lru_lock
> 
> So we now have tree_lock(r) -> lru_lock, which would deadlock
> against lru_lock -> tree_lock(w), right?
> 
> From a quick glance it looks safe, but I'd _really_ rather not
> introduce something like this.

Urg.. good point.  I hadn't even thought of that consequence - I was
more worried about whether I need i_lock or i_mutex to protect my
updates to i_blocks.

Would hugetlb_lock -> tree_lock(r) be any preferable (I think that's a
possible alternative).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
