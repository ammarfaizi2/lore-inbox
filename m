Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbUFCQsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUFCQsV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 12:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUFCQsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 12:48:21 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:34176 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261631AbUFCQrv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 12:47:51 -0400
Date: Thu, 3 Jun 2004 09:43:39 -0700
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, Ashok Raj <ashok.raj@intel.com>,
       Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@sgi.com>,
       Joe Korty <joe.korty@ccur.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Paul Jackson <pj@sgi.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Simon Derr <Simon.Derr@bull.net>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH] Bitmap and Cpumask Cleanup - Overview
Message-Id: <20040603094339.03ddfd42.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	  	Bitmap and Cpumask Cleanup

Andrew,

  Please consider the following 10 patches for your *-mm patch set,
  to be sent shortly in follow-on email messages.

  This patch set removes some 27 kernel source files, simplifies
  cpumasks, and in the colorful language of Rusty, it gets rid of:
  
    asm-generic/cpumask_optimized_for_large_smp_with_sparse_array_and_small_stack.h

  It also forms the basis for a nodemask_t patch, that is
  awaiting in the wings, from Matthew Dobson.

===

This is the sixth version of my cleanup of bitmaps and cpumasks.
It has changed very little from the fifth version of a month ago.

This set of 10 patches applies against 2.6.7-rc2-mm2.

Primay goals:

  The primary goal of this patch set is to simplify the code for
  cpumask_t and (later) nodemask_t, make them easier to use, and
  reduce code duplication.

  Several flavors of cpumask have been reduced to one, with some
  local special handling to optimize for that vast majority of
  systems which have less than 32 (or 64) CPUs.

  The bitmap operations upon which cpumasks depend have been
  optimized a bit more, with a more careful mix of inline and
  outofline code.

  By simplifying masks to a single file, it should also be
  easier to add other such mask types, such as the nodemask
  that Matthew Dobson has waiting in the wings, just by
  copying cpumask.h and making a few global edits.

This patch set provides (compared to 2.6.7-rc2-mm2):

  1) Some 27 files matching the pattern include/*/*mask*.h
     are replaced with the single file include/linux/cpumask.h
     The variety of arch-specific redirect headers for various
     cpumask implementation flavors is gone.
  2) The bitmap operations (bitmap.h, bitmap.c) are optimized
     for systems of less than 32 (or 64) CPUs.
  3) The cpumask operations are now just a thin layer on top
     of the bitmask and a few other operations.  A cpumask is a
     bitmask of exactly NR_CPUS bits, wrapped in a structure.
  4) bitmap_complement and cpumask_complement now take two args,
     source and target, instead of working in place.
  5) Some uses of these macros elsewhere in the kernel were fine
     tuned.
  6) On ia64, find_first_bit and find_first_zero_bit are
     uninlined - saving quite a bit of kernel text space.
     The architectures: alpha, parisc, ppc, sh, sparc, sparc64
     have this same bit find code, and might also want to uninline. 
  7) Comments in bitmap.h and cpumask.h list available ops for ease
     of browsing.
  8) The MASK_ALL macro zeros out unused bits on multiword bitmaps.
  9) This patch includes Bill Irwin's recent rewrite of the
     bitmap_shift operators to avoid assuming some fixed upper
     bound on bitmap sizes.
 10) A few more mask macros have been added, to make it easier to
     code mask manipulations correctly and easily.  They provide
     xor, andnot, intersects and subset operators.

Bug fixes:
  1) *_complement macros don't leave unused high bits set
  2) MASK_ALL for sizes > 1 word, but not exact word multiple,
     doesn't have unused high bits set
  3) Explicit, documented semantics for handling these unused high bits.
  4) A few missing const attributes in bitmap & bitops added.
  5) The (Hamming) cpumask weight macros were using the bitops hweight*()
     macros, which don't mask high unused bits - fixed to use the bitmap
     weight macro which does this masking.

  Do to the rather limited use so far of cpumask macros, I am
  not aware of anything that these bugs would actually break in
  current mm or linus kernels.

Testing so far:
  Kernels have been built for i386 (SMP and not), sparc64 and
  ia64 (sn2_defconfig), and booted and minimally tested on SN2.
  Kernel text size has been compared and found to be similar or
  smaller.  Correct function of bit operations has been tested
  for a variety of NR_CPUS values in a user level framework,
  using gcc compiler versions 2.95.3, 3.2.3 and 3.3.2.  Joe Korty
  has built and booted Version 5 on Opteron.

Reviews and feedback:
  This code has been sent to the arch maintainers, and has been
  reviewed in some form or other by several, including:
    - William Lee Irwin III <wli@holomorphy.com>
    - Jesse Barnes <jbarnes@sgi.com>
    - Joe Korty <joe.korty@ccur.com>
    - Matthew Dobson <colpatch@us.ibm.com>
    - Rusty Russell <rusty@rustcorp.com.au>
  So far as I know, no outstanding issues remain open.


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
