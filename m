Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUEFSUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUEFSUj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 14:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUEFSUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 14:20:39 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:51193 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261857AbUEFSU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 14:20:26 -0400
Date: Thu, 6 May 2004 11:18:14 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Matthew Dobson <colpatch@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Joe Korty <joe.korty@ccur.com>,
       Jesse Barnes <jbarnes@sgi.com>
Subject: [PATCH mask 0/15] bitmap and cpumask cleanup
Message-Id: <20040506111814.62d1f537.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

					Paul Jackson
					pj@sgi.com
					6 May 2004

	  	Bitmap and Cpumask Cleanup

Andrew,

  Please consider the following patch set for your *-mm patches.

  It removes some 27 kernel source files, simplifies cpumasks,
  and in the colorful language of Rusty, it gets rid of such
  headers as:
  
    asm-generic/cpumask_optimized_for_large_smp_with_sparse_array_and_small_stack.h

  It also forms the basis for a nodemask_t patch, that is
  awaiting in the wings, from Matthew Dobson.

  Each patch is described below, in "Patch Details."

===

This is the fifth version of my cleanup of bitmaps and cpumasks.

This set of nine patches applies against 2.6.6-rc3-mm2 plus six
optional fixup patches, also included.

The actual patches will be posted in another hour or two, as
followups to this initial post.

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

There is no significant difference between this fifth version
and the fourth version of April 21, 2004.  The basis for the
patch has been moved forward to 2.6.6-rc3-mm2.  And a few
of the more trivial patches in the set have been collapsed,
reducing the patchset to 9 patches.

What's new (comparing 2.6.6-rc3-mm2 to this patch set):
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
  Kernel text size has been compared and found to typically
  get a little smaller.  Correct function of bit operations
  has been tested for a variety of NR_CPUS values in a user
  level framework, using gcc compiler versions 2.95.3, 3.2.3 and
  3.3.2.  Joe Korty has built and booted on Opteron.

Reviews and feedback:
  This code has been sent to the arch maintainers, and has been
  reviewed in some form or other by several, including:
    - William Lee Irwin III <wli@holomorphy.com>
    - Jesse Barnes <jbarnes@sgi.com>
    - Joe Korty <joe.korty@ccur.com>
    - Matthew Dobson <colpatch@us.ibm.com>
    - Rusty Russell <rusty@rustcorp.com.au>
  So far as I know, no outstanding issues remain open.

================ Patch Details ================

Here's what each patch does.  First are 5 fixup patches
and one minor rework of the cpu_present_map fixup.

pj-fix-1-unifix
pj-fix-2-ashoks-updated-cpuhotplug-6-7
pj-fix-3-ashoks-updated-cpuhotplug-7-7
pj-fix-4-include-mempolicy
pj-fix-5-syscall-return-semicolon
	Patches pj-fix-* should match fixes that you (Andrew)
	have already picked up.  You should ignore these
	if what you already have is just as good.  They are
	here so that I can be precise as to what source I
	am using for the basis of the following patches.

nonsmp-cpu-present-map
	You (Andrew) worked around a non-SMP build problem
	in Ashok's cpuhotplog patches in init/main.c routine
	fixup_cpu_present_map().

	==> Instead of whatever you did (an ifdef or whatever),
	==> Andrew, please take this patch instead.

	This patch makes cpu_present_map a real map for all
	configurations, instead of a constant for non-SMP.
	It also moves the definition of cpu_present_map out of
	kernel/cpu.c into kernel/sched.c, because cpu.c isn't
	compiled into non-SMP kernels.

==============================================================
The nine main bitmap and cpumask cleanup patches follow.
==============================================================

mask1-bitmap-cleanup-prep
        Document the bitmap bit model and handling of unused bits.

        Tighten up bitmap so it does not generate nonzero bits
        in the unused tail if it is not given any on input.

        Add intersects, subset, xor and andnot operators.
        Change bitmap_complement to take two operands.

        Add a couple of missing 'const' qualifiers on
        bitops test_bit and bitmap_equal args.

mask2-bitmap-extensions
        This bitmap improvements make it a suitable basis for
        fully supporting cpumask_t and nodemask_t.  Inline macros
        with compile-time checks enable generating tight code on
        both small and large systems (large meaning cpumask_t
        requires more than one unsigned long's worth of bits).

        The existing bitmap_<op> macros in lib/bitmap.c
        are renamed to __bitmap_<op>, and wrappers for each
        bitmap_<op> are exposed in include/linux/bitmap.h

	This patch _includes_ Bill Irwins recent rewrite of the
	bitmap_shift operators to not require a fixed length
	intermediate bitmap.

	Improved comments list each available operator for easy
	browsing.

mask3-unline-find-next-bit-ia64
	Move the page of code (~700 bytes of instructions)
	for find_next_bit and find_next_zero_bit from inline
	in include/asm-ia64/bitops.h to a real function in
	arch/ia64/lib/bitops.c, leaving a declaration and
	macro wrapper behind.

	The other arch's with almost this same code might want to
	also uninline it: alpha, parisc, ppc, sh, sparc, sparc64.

	These are too big to inline.

mask4-new-cpumask-h
	Major rewrite of cpumask to use a single implementation,
	as a struct-wrapped bitmap.

	This patch leaves some 26 include/asm-*/cpumask*.h
	header files orphaned - to be removed next patch.

	Some nine cpumask macros for const variants and to
	coerce and promote between an unsigned long and a
	cpumask are obsolete.  Simple emulation wrappers are
	provided in this patch, which can be removed once each
	of the 3 archs (i386, ppc64, x86_64) using them are
	recoded in follow-on patches to not need them.

	The CPU_MASK_ALL macro now avoids leaving possible
	garbage one bits in any unused portion of the high word.

	An inproved comment lists all available operators, for
	convenient browsing.

mask5-remove-old-cpumask-files
	With the cpumask rewrite in the previous patch, these
	various include/asm-*/cpumask*.h headers are no longer used.

mask6-cpumask-i386-fixup
	Remove by recoding i386 uses of the obsolete cpumask const,
	coerce and promote macros.

mask7-cpumask-etc-fixup
	Remove by recoding other uses of the obsolete cpumask const,
	coerce and promote macros.

mask8-rm-old-cpumask-emul
        Now that the emulation of the obsolete cpumask macros is no
        longer needed, remove it from cpumask.h

mask9-post-cleanup-tweaks
        Make use of for_each_cpu_mask() macro to simplify and optimize
        a couple of sparc64 per-CPU loops.

        Optimize a bit of cpumask code for asm-i386/mach-es7000

        Convert physids_complement() to use both args

        Remove cpumask hack from asm-x86_64/topology.h routine
	pcibus_to_cpumask().

        Clarify and slightly optimize set_cpus_allowed() cpumask check
	in kernel/sched.c




-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
