Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270207AbRHRPLa>; Sat, 18 Aug 2001 11:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270218AbRHRPLV>; Sat, 18 Aug 2001 11:11:21 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:7265 "EHLO
	alloc.wat.veritas.com") by vger.kernel.org with ESMTP
	id <S270207AbRHRPLO>; Sat, 18 Aug 2001 11:11:14 -0400
Date: Sat, 18 Aug 2001 16:15:21 +0100 (BST)
From: Mark Hemment <markhe@veritas.com>
X-X-Sender: <markhe@alloc.wat.veritas.com>
To: <linux-kernel@vger.kernel.org>
Subject: kswap spinning
Message-ID: <Pine.LNX.4.33.0108181538040.6247-100000@alloc.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  Jumping from 2.4.7 to 2.4.9 has shown up a problem with the VM balancing
code.
  Under load, I've seen kswapd become a CPU hog (on a 5GB box).  Now that
I've got a theory, I cannot reproduce the problem for confirmation, but
here is the theory anyway.

  The tests in free_shortage() and inactive_shortage() assume that the
memory state for a zone can be improved by calling refill_inactive_scan(),
page_launder(), the inode/dcache shrinking functions, and the general
slab-cache reaping func.  Usually, some combination of the reaping
functions will improve a zone's state - but not always.

  The problem is the DMA zone.  As it is (relatively) small on some archs
(IA-32 for example), it is possible that almost all pages from this zone
are being used by a sub-systems which simply won't give them up.  Examples
of use are; vmalloc()ed page for modules, pre-allocated socket buffs
for NICs, task-structs/kernel-stack - you get the idea.

  In the case I believe I'm seeing, both free_shortage() and
inactive_shortage() are returning a shortage for the DMA zone which
triggers all the work in do_try_to_free_pages().  But as there aren't any
DMA pages left in the page-cache, being used as anonymous pages, or being
used in the other places the code looks, do_try_to_free_pages() returns
non-zero to kswapd() and off we go again.  This also causes callers of
try_to_free_pages() (from __alloc_pages()) to suck CPU cycles as well.

  On HIGHMEM boxes, it is possible for the NORMAL zone to get into the
same state (although v unlikely).

  I'd rather not get into having specialist code in mm/vmscan.c (or arch
specific code) to handle a small DMA zone - so what are the other
solutions?  (Assuming the above theory holds true.)

  One possible solution is not to give DMA memory out, except for;
	o explicit DMA allocations
	o page-cache, anonymous page, allocations
assuming explicit DMA allocations are low, we'll at least know the
remaining DMA pages are somewhere we can get at them - would need to be
trigger by an arch specific flag for those that don't have a "tiny" zone.
However, I don't like this, feels like fixing the wrong problem. :(

Mark

