Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbUDHSww (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 14:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbUDHSww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 14:52:52 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:21360 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262224AbUDHSwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 14:52:11 -0400
Date: Thu, 8 Apr 2004 11:50:50 -0700
From: Paul Jackson <pj@sgi.com>
To: Matthew Dobson <colpatch@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Patch 0/23 - Bitmaps, Cpumasks and Nodemasks
Message-Id: <20040408115050.2c67311a.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

					Paul Jackson
					pj@sgi.com
					8 April 2004

	  Bitmaps, Cpumasks and Nodemasks
	  
  [ Status: Certainly not ready to apply yet - needs
            testing, arch-maintainer reviews, ...
	    And I'm vacation these next seven days. ]

This is my third cut at cleaning up cpumasks and providing a common
basis for both cpumasks and Matthew Dobson's nodemask patch series.

A primary goal of this patch set is to simplify the code for cpumask_t
and nodemask_t, making them easier to understand and use, and reducing
code duplication.

Several flavors of cpumask have been reduced to one, with some local
special handling to optimize for normal size systems of less than 32
CPUs.

The other primary goal of this patch set, in particular of Matthew's
nodemask_t patches, which are included here, was to provide a standard
nodemask_t and operations.  This is done to avoid "open" coding of node
masks using ad hoc code.

This cut differs from the second "mask v2" of a week ago
as follows:

 1) The "mask" ADT is gone.  Cpumasks and nodemasks now
    sit directly on top of bitmaps/bitops.  Thanks, Rusty.
 
 2) The patch based migrated from 2.6.4 to 2.6.5 (a couple
    of ia64 files required some hand merging).
 
 3) On ia64, find_first_bit and find_first_zero_bit are
    uninlined - saving quite a bit of kernel text space.
    The architectures: alpha, parisc, ppc, sh, sparc, sparc64
    have this same shift code, and might also want to uninline.

 4) The bitmap.h file got some work:
    - comment listing available ops for ease of browsing
    - MASK_ALL on multiword bitmaps zeros out unused bits
    - compile-time inline logic for optimum small (< 32 cpu) code
 
 5) This patch includes Bill Irwin's very recent rewrite
    of the bitmap_shift operators to avoid assuming some
    fixed upper bound on bitmap sizes.

See significantly more description in my posting last
week of "mask v2", including some of the remaining risk
factors, on my lkml posting:

    Date:      Thu, 1 Apr 2004 12:28:02 -0800
    Subject:   [Patch 0/23] mask v2 - Second version of mask,
                           cpumask and nodemask consolidation
    http://groups.google.com/groups?selm=1Gh90-5aj-51%40gated-at.bofh.it

I've built this for i386 and ia64, and booted ia64.
But it has not received anything resembling real testing.

I need to seek out feedback and approval/disapproval
from the arch maintainers.

I will be on vacation for the next week (until the day
after April 15 ... my fellow Americans can guess why ;).

The actual patches in this set will follow in an hour or
so, as replies to this initial post.


================ Patch Details ================

Here's what each patch does:

P1.bitmap_comment - Document bitmap.c bit model.
        Document the bitmap bit model, including handling of unused bits,
        and operation preconditions and postconditions.

P2.bitmap_complement - Dont generate nonzero unused bits in bitmap
        Tighten up bitmap so it does not generate nonzero bits
        in the unused tail if it is not given any on input.

P3.bitmap_newops - New bitmap operators and two op complement
        Add intersects, subset, xor and andnot operators.
        Change bitmap_complement to take two operands.

P4.bitmap_const - two missing 'const' qualifiers in bitops/bitmap
        Add a couple of missing 'const' qualifiers on
        bitops test_bit and bitmap_equal args.

P5.bitmap_extensions - Optimize and extend bitmap.

        This bitmap improvements make it a suitable basis for
        fully supporting cpumask_t and nodemask_t.  Inline macros
        with compile-time checks enable generating tight code on
        both small and large systems (large meaning cpumask_t
        requires more than one unsigned long's worth of bits).

        The existing bitmap_<op> macros in lib/bitmap.c
        are renamed to __bitmap_<op>, and wrappers for each
        bitmap_<op> are exposed in include/linux/bitmap.h

        This patch _includes_ Bill Irwins rewrite of the
        bitmap_shift operators to not require a fixed length
        intermediate bitmap.

        Improved comments list each available operator for easy
        browsing.

P6a.unline_find_next_bit_ia64 - Uninline find_next_bit on ia64

        Move the page of code (~700 bytes of instructions)
        for find_next_bit and find_next_zero_bit from inline
        in include/asm-ia64/bitops.h to a real function in
        arch/ia64/lib/bitops.c, leaving a declaration and
        macro wrapper behind.

        The other arch's with almost this same code might want to
        also uninline it: alpha, parisc, ppc, sh, sparc, sparc64.

        These are too big to inline.

P6b.new_cpumask.h - Rewrite cpumask.h to use bitmap directly.

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

P6c.remove_old_cpumask_files - Remove 26 no longer used cpumask headers.
        With the cpumask rewrite in the previous patch, these
        various include/asm-*/cpumask*.h headers are no longer used.

P7.cpumask_i386_fixup - Remove/recode obsolete cpumask macros from arch i386
        Remove by recoding all uses of the obsolete cpumask const,
        coerce and promote macros.

P8.cpumask_ppc64_fixup - Remove/recode obsolete cpumask macros from arch ppc64
        Remove by recoding all uses of the obsolete cpumask const,
        coerce and promote macros.

P9.cpumask_x86_64_fixup - Remove/recode obsolete cpumask macros from arch x86_64
        Remove by recoding all uses of the obsolete cpumask const,
        coerce and promote macros.

P10.rm_old_cpumask_emul - Remove obsolete cpumask emulation from cpumask.h
        Now that the emulation of the obsolete cpumask macros is no
        longer needed, remove it from cpumask.h

P11.cpumask_sparc_simplify - Simplify some sparc64 cpumask loop code
        Make use of for_each_cpu_mask() macro to simplify and optimize
        a couple of sparc64 per-CPU loops.  This code change has _not_
        been tested or reviewed.  Feedback welcome.  There is non-trivial
        risk that I still don't understand the logic here.

P12.cpumask_i386_simplify - Optimize i386 cpumask macro usage.
        Optimize a bit of cpumask code for asm-i386/mach-es7000
        Code untested, unreviewed.  Feedback welcome.

P13.cpumask_physids_complement - Convert physids_complement() to use both args
        Provide for specifying distinct source and dest args to the
        physids_complement().  No one actually uses this macro yet.
        The physid_mask type would be a good candidate to convert to
        using this new mask ADT as a base.

P14.cpumask_x86_64_online - Remove cpumask hack from asm-x86_64/topology.h
        This file had the cpumask cpu_online_map as type
        unsigned long, instead of type cpumask_t, for no good
        reason that I could see.  So I changed it.  Everywhere
        else, cpu_online_map is already of type cpumask_t.

P15.cpumask_sched_refine- Cpumask code clarification in kernel/sched.c
        Clarify and slightly optimize set_cpus_allowed() cpumask check

P16.new_nodemask.h - New nodemask_t, based on bitmap.
        New nodemask_t type, based on bitmap/bitop,
        suitable for use with Matthew Dobson's nodemask
        patch series.  Closely resembles cpumask.h.

P17.nodemask_mmzone - the mmzone.h changes from Matthew's Patch [1/7]
        Just the mmzone.h changes taken from this patch: removing
        extistant definition of node_online_map and helper functions,
        added a #include <nodemask.h>.

P18.nodemask_core - Matthew Dobson's [PATCH] nodemask_t core changes [2/7]
        nodemask_t-02-core.patch - Changes to arch-independent code.
        Surprisingly few references to numnodes, open-coded node loops,
        etc. in generic code.  Most important result of this patch is
        that no generic code assumes anything about node numbering.
        This allows individual arches to use sparse numbering if they
        care to.

P19.nodemask_i386 - Matthew Dobson's [PATCH]_nodemask_t_i386_changes_[3_7]
        Changes to i386 specific code.  As with most arch changes,
        it involves close-coding loops (ie: for_each_online_node(nid)
        rather than for(nid=0;nid<numnodes;nid++)) and replacing the
        use of numnodes with num_online_nodes() and node_set_online(nid).

P20.nodemask_pp64 - Matthew Dobson's [PATCH]_nodemask_t_pp64_changes_[4_7]
        Changes to ppc64 specific code.  Untested.
        Code review & testing requested.

P21.nodemask_x86_64 - Matthew Dobson's [PATCH]_nodemask_t_x86_64_changes_[5_7]
        Changes to x86_64 specific code.
        Untested.  Code review & testing requested.

P22.nodemask_ia64 - Matthew Dobson's [PATCH]_nodemask_t_ia64_changes_[6_7]
        Changes to ia64 specific code.

P23.nodemask_other_archs - Matthew Dobson's [PATCH]_nodemask_t_other_arch [7_7]
        Changes to other arch-specific code (alpha, arm, mips,
        sparc64 & sh).  Untested.  Code review & testing requested.

