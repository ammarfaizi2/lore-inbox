Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbTFOKJq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 06:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbTFOKJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 06:09:46 -0400
Received: from holomorphy.com ([66.224.33.161]:31886 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262095AbTFOKJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 06:09:44 -0400
Date: Sun, 15 Jun 2003 03:23:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.71-wli-1
Message-ID: <20030615102332.GP20413@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I pounded out a few patches to make my boxen run a little smoother.
This runs great on my big fat PAE boxen and on my craptop. It may
very well prove useful to others as well.

This will compile for i386 only, though I'm interested in merging the
fixes so other arches compile and so on.

To preemptively answer the question, I suspect a couple of these are
more than -mm cares to absorb at the moment. Of course, if that turns
out not to be the case, I'll send things in promptly.

Against virgin 2.5.71.

Available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/kernels/2.5.71/linux-2.5.71-wli-1.bz2

1: O(1) rmqueue_bulk()
	rmqueue_bulk() currently does list walking and various kinds of
	iteration every time in what's obviously a fast path. This
	batches up prepped groups of pages in internal buddy allocator
	lists so rmqueue_bulk() has O(1) expected time. free_pages_bulk()
	is likewise trimmed down from O(group) to O(1) expected time.

2: trivial flow.c compilefix
	The same thing everyone else has posted a dozen times.

3: lowmem_page_address() micro-optimization
	Use page_to_pfn() instead of open-coding page_zone() etc.
	so micro-optimized arch implementations of page_to_pfn()
	can micro-optimize lowmem_page_address() in turn.

4: highpmd
	Shove i386 pmd's into highmem, brute-force. make -j bzImage now
	incurs near-negligible lowmem pressure on my NUMA-Q. A very
	comfortable feeling indeed. This was really a very mechanical
	job, and it fits very smoothly into the core. This is the patch
	that breaks non-i386 arches' compiles, though it's obvious how
	to fix it, i.e. pmd_offset_map() etc. and pgd_page() changes.

5: trivial /proc/ BKL removals
	Relatively unimportant, apart from the fact the BKL is annoying
	and obscuring what's being locked in and around /proc/ due to
	the BKL's inherent "wtf did they just lock" nature. There isn't
	anything significant to audit around the specific codepaths
	invoved, as one wrapped a call to a function that wrapped its
	entire body in the BKL and the other wrapped a variable
	(nr_threads) actually protected by the tasklist_lock, but
	considered valid to access with no locking for reporting.

6: i386 pagetable cache
	Use the tlb.h hooks to properly cache pre-zeroed pagetable and
	pmd pages as well as to function properly with highpte/highpmd.
	Slick implementation techniques make this O(1) in all cases,
	with no list iterations, and no nonsense in general. One might
	say this removes some nonsense, as they're trivially cacheable.

7: pgd_ctor()
	Use slab ctors to cache preconstructed pgd's. This is worth
	more on non-PAE machines, as significant amounts of bitblitting
	are incurred when the things are a whole page in size. A form
	of this is already in -mm, but this version works with highpmd.


-- wli
