Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbUDAUbR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 15:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbUDAUbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 15:31:17 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:25827 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261952AbUDAU2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 15:28:55 -0500
Date: Thu, 1 Apr 2004 12:28:02 -0800
From: Paul Jackson <pj@sgi.com>
To: Matthew Dobson <colpatch@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Patch 0/23] mask v2 - Second version of mask, cpumask and nodemask
 consolidation
Message-Id: <20040401122802.23521599.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


						Paul Jackson
						pj@sgi.com
						1 April 2004

		Masks, Cpumasks and Nodemasks

This set of 23 patches, to be sent as followups to this message
momentarily, provides a common 'mask' ADT from which both
cpumask_t and nodemask_t are defined.  This set of patches
incorporates Matthew Dobson's [PATCH]_nodemask_t patch series.

This is the second version of this mask patch set.  The first
version was posted on March 29, 2004.  This version builds and
boots on arch=ia64 using the sn2_defconfig with NR_CPUS=512.
As with the first mask patch set, this one is against 2.6.4.

A primary goal of this patch set was to simplify the support
for cpumask_t and nodemask_t, making them easier to use, and
reducing code duplication.

Several flavors of mask have been reduced to one, with some
local special handling to optimize for normal size systems of
less than 32 CPUs.

The other primary goal of this patch set, in particular of
Matthew's nodemask_t patches, which are included here, was to
provide a standard nodemask_t and operations.  This is done
to avoid "open" coding of node masks using ad hoc code.

================ Description of Risks ================

    This patch set makes changes in mask handling code in
    several architectures.  We could have broken something.

    This patch set removes several more optimized variants
    of mask, which were targeted for optimum performance on
    various architectures, and replaces that with essentially
    a single variant.  Preliminary analysis on the one
    architecture I cared most about shows no noticeable
    difference in the quality of the code generated for mask
    operations, but other architectures or more demanding
    uses may require further optimization work.

    This patch set might have dependencies on specific gcc
    or toolchain versions.  Portions have worked with both
    gcc 2.95.3 and 3.3.2 inside a user level scaffolding
    on i386.  Kernels have been built and booted on ia64
    using gcc 3.2.3 and built on i386 using gcc 3.3.2.
    But non-trivial use is made of gcc extensions, so certain
    archs or toolchains might not build, or might not produce
    sufficiently optimal code, or might not even work.

    This patch set changes the semantics of cpumasks
    slightly.  If all mask operations are performed with
    correct parameters, and no bits are intentionally
    set outside the range of bits covered by such a mask
    (typically this means outside the range [0 ... NR_CPUS-1]
    for cpumask_t), then there should be no noticable
    difference.  Code that (improperly) sets bits outside
    that valid range may notice differences in when such
    bits affect the results of other mask operations.

    Patches 19 through 22 (see list of patches, below) in
    particular attempt to "cleanup" some cpumask manipulation
    code in various sparc and intel arch's.  These patches
    are not essential - if they get in the way of other work,
    or are too much distraction, or break something, any of
    them can be dropped.  At a minimum, they require review
    and approval from the affected arch's.

    Similarly, Patches 14 through 18 attempt to "cleanup"
    some nodemask manipulations in several arch's.  Once
    again, they aren't tested, need review, could break
    something, or could intrude on other work.


================ Original mask writeup ================

    The following writeup describing masks, from the first
    version posted March 29, is still (with minor edits)
    useful, so reposted and updated here:

The following sequence of 23 patches replaces cpumask_t and Matthew
Dobson's recent nodemask_t with ones based on a new mask ADT.

The following patches apply against a 2.6.4 vanilla kernel,
and result in nodemask code that is (with a couple of details)
the same as Matthew's.

All the various include/asm-*/*mask.h files are gone.  The const
macros are gone.  The promote and coerce macros are replaced
with a single mask_addr() macro, that simply returns the address
of the first unsigned long in the mask, to do with as you will.

There are now only 3 mask header files:
  include/linux/mask.h - the underlying ADT
  include/linux/cpumask.h - cpumasks, implemented using mask.h
  include/linux/nodemask.h - nodemasks, implemented using mask.h

Excluding block comments, the old cpumask code, with Matthew's
nodemask patch, consumed (in files matching include/*/*mask*.h):

	34 files, 683 lines of code

This new cpumask and nodemask code, and its common mask ADT base,
consumes a comparable:

	3 files, 418 lines of code

If you want to write code using the cpumask or nodemask API,
then everything you need is easily available in the cpumask.h
or nodemask.h header file, respectively.

A few more mask macros have been added, to make it easier to
code mask manipulations correctly and easily.  They provide
xor, andnot, intersects and subset operators.

A few places in the kernel that use cpumasks were recoded to
make better use of these cpumask macros.

The *_complement macros were recoded to take separate source
and dest arguments, following a suggestion of Bill Irwin.

It should be easy to add other mask-based types.  One candidate
for this conversion would be physid_mask.  Just make a copy of
cpumask.h (or nodemask.h) and do a few global substitutions in
the editor, and you'll be close.

I believe that this version of masks is easier to understand
and use, while providing the same performance as before.  The
fairly rich extensions of gcc for compile time macros and
optimizations allow for writing code that produces optimum
results on various architectures and system sizes without
the complexity of multiple nested include files and ifdefs.

Bug fixes include:
 1) *_complement macros don't leave unused high bits set
 2) MASK_ALL for sizes > 1 word, but not exact word multiple,
    doesn't have unused high bits set
 3) Explicit, documented semantics for handling these unused high bits.
 4) A few missing const attributes in bitmap & bitops added.
 5) The (Hamming) cpumask weight macros were using the bitops hweight*()
    macros, which don't mask high unused bits - fixed to use the bitmap
    weight macro which does this masking.

Do to the rather limited use so far of these cpumask and nodemask
macros, I am not aware of anything that these bugs would actually
break in current mm or linus kernels.

Also, the assymetry that nodemasks had with cpumasks, whereby the
cpumasks had include/asm-<arch> specific redirecting headers for
every arch, but nodemasks didn't, has been fixed.  Now neither
one has arch-specific redirect headers.  They aren't needed in
my view.  Arch specific code belongs in the underlying bitops.h
header files, and the individual mask macros can be elaborated
as need be to take advantage of such.

================ Patch Details ================

Here's what each patch does:

Patch_1_of_23 - Document bitmap.c bit model.
	Document the bitmap bit model, including handling of unused bits,
	and operation preconditions and postconditions.

Patch_2_of_23 - Dont generate nonzero unused bits in bitmap
	Tighten up bitmap so it does not generate nonzero bits
	in the unused tail if it is not given any on input.

Patch_3_of_23 - New bitmap operators and two op complement
	Add intersects, subset, xor and andnot operators.
	Change bitmap_complement to take two operands.

Patch_4_of_23 - two missing 'const' qualifiers in bitops/bitmap
	Add a couple of missing 'const' qualifiers on
	bitops test_bit and bitmap_equal args.

Patch_5_of_23 - New mask ADT
	Adds new include/linux/mask.h header file

	==> See this mask.h header for more extensive mask documentation <==

Patch_6_of_23 - Rework cpumasks to use new mask ADT
	Removes many old include/asm-<arch> and asm-generic cpumask files
	Add intersects, subset, xor and andnot operators.
	Provides temporary emulators for obsolete const, promote, coerce
	Presents entire cpumask API clearly in single cpumask.h file

Patch_7_of_23 - Remove/recode obsolete cpumask macros from arch i386
	Remove by recoding all uses of the obsolete cpumask const,
	coerce and promote macros.

Patch_8_of_23 - Remove/recode obsolete cpumask macros from arch ppc64
        Remove by recoding all uses of the obsolete cpumask const,
        coerce and promote macros.

Patch_9_of_23 - Remove/recode obsolete cpumask macros from arch x86_64
        Remove by recoding all uses of the obsolete cpumask const,
        coerce and promote macros.

Patch_10_of_23 - Remove obsolete cpumask emulation from cpumask.h
	Now that the emulation of the obsolete cpumask macros is no
	longer needed, remove it from cpumask.h

Patch_11_of_23 - Add new nodemasks.h file.
	Provide a nodemasks_t type, using the mask.h ADT.

Patch_12_of_23 - the mmzone.h changes from Matthew's Patch [1/7]
	Just the mmzone.h changes taken from this patch: removing
	extistant definition of node_online_map and helper functions,
	added a #include <nodemask.h>.

Patch_13_of_23 - Matthew Dobson's [PATCH] nodemask_t core changes [2/7]
	nodemask_t-02-core.patch - Changes to arch-independent code.
	Surprisingly few references to numnodes, open-coded node loops,
	etc. in generic code.  Most important result of this patch is
	that no generic code assumes anything about node numbering.
	This allows individual arches to use sparse numbering if they
	care to.

Patch_14_of_23 - Matthew Dobson's [PATCH]_nodemask_t_i386_changes_[3_7]
	Changes to i386 specific code.  As with most arch changes,
	it involves close-coding loops (ie: for_each_online_node(nid)
	rather than for(nid=0;nid<numnodes;nid++)) and replacing the
	use of numnodes with num_online_nodes() and node_set_online(nid).

Patch_15_of_23 - Matthew Dobson's [PATCH]_nodemask_t_pp64_changes_[4_7]
        Changes to ppc64 specific code.  Untested.
        Code review & testing requested.

Patch_16_of_23 - Matthew Dobson's [PATCH]_nodemask_t_x86_64_changes_[5_7]
        Changes to x86_64 specific code.
        Untested.  Code review & testing requested.

Patch_17_of_23 - Matthew Dobson's [PATCH]_nodemask_t_ia64_changes_[6_7]
        Changes to ia64 specific code.

Patch_18_of_23 - Matthew Dobson's [PATCH]_nodemask_t_other_arch_changes_[7_7]
	Changes to other arch-specific code (alpha, arm, mips,
	sparc64 & sh).  Untested.  Code review & testing requested.

Patch_19_of_23 - Simplify some sparc64 cpumask loop code
	Make use of for_each_cpu_mask() macro to simplify and optimize
	a couple of sparc64 per-CPU loops.  This code change has _not_
	been tested or reviewed.  Feedback welcome.  There is non-trivial
	risk that I still don't understand the logic here.

Patch_20_of_23 - Optimize i386 cpumask macro usage.
	Optimize a bit of cpumask code for asm-i386/mach-es7000
	Code untested, unreviewed.  Feedback welcome.

Patch_21_of_23 - Convert physids_complement() to really use both args
	Provide for specifying distinct source and dest args to the
	physids_complement().  No one actually uses this macro yet.
	The physid_mask type would be a good candidate to convert to
	using this new mask ADT as a base.

Patch_22_of_23 - Remove cpumask hack from asm-x86_64/topology.h
	This file had the cpumask cpu_online_map as type
	unsigned long, instead of type cpumask_t, for no good
	reason that I could see.  So I changed it.  Everywhere
	else, cpu_online_map is already of type cpumask_t.

Patch_23_of_23 - Cpumask code clarification in kernel/sched.c
	Clarify and slightly optimize set_cpus_allowed() cpumask check


================ Changes in 2nd version mask patches ================


I have incorporated the following changes, since posting
the first "mask ADT" set of 22 patches, on March 29, thanks
primarily to the work of Matthew and Bill Irwin.  I have included
Matthew's comments for the nodemask changes that he provided,
ver batim, without attribution.  See his earlier lkml posts
for the full detail.


1. The brackets {{ ... }} on MASK ALL and NONE should have been
   { { ... } }, not ({ ... }).  I needed to add a space separator,
   not change curlies to parens.


2. Renamed cpus_raw to cpus_addr, the name that function
   has had all along.


3. Dropped patch 8/22 to arch/i386/kernel/smp.c and arch/x86_64/kernel/smp.c,
   to avoid colliding with parallel work by Hari.


4. Changed mask api for 9 operators:

       and or xor andnot equal intersects subset empty clearall

   to take a final argument of the number of bits, which it passes
   through to the corresponding bitmap_* operator.  Previously,
   these operators had used the size in bytes of the mask to compute
   the number of bits.  Less code, more accurate, to just pass through
   the actual bit count.


5. Incorporated various formatting and related changed from Matthew,
   including numerous missing parentheses in preprocessor expansions.

   
6. Matthew removed a few gratuitous differences between the
   choice of macros available for cpumasks versus nodemasks .


7. Documented the semantics of the bit model supported by
   bitmap and bitops.

   
8. Made a distinct patch out of the change, with comment, to
   lib/bitmap.c to honor the stronger postcondition: there
   will be no one bits in the unused tail in the results of
   operations if no such one bits are set in input masks.


9. ppc64 changes from Matthew's nodemask_t Patch 4/7 [13/22]

   Here's the updated version of the PPC64 patch.  The
   differences are the complete removal of all references to max_domain in
   parse_numa_properties() in arch/ppc64/mm/numa.c.  Upon closer
   inspection, this variable and associated code isn't needed.  I also
   removed the
	   for(i = 0; i <= max_domain; i++)
		   node_set_online(i);
   loop because the nodes are onlined as we loop over the CPUs that are in
   them.


10 x86_64 changes from Matthew's nodemask_t Patch 5/7 [14/22]

   This one has been updated as well.  I chose a slightly different fix for
   the nodes_complement() bug I introduced.  I just inserted:

   for_each_node(i) {
	   if (node_online(i))
		   continue;
	   ...
   }

   rather than doing any nodes_complement() at all.  Either solution will
   work


11 ia64 changes from Matthew's nodemask_t Patch 6/7 [15/22]

   Yet another updated patch.  Changes are very small, but I've attatched
   the whole patch, rather than an incremental diff.  In
   include/asm-ia64/sn/sn2/sn_private.h, we can safely drop the externs of
   replicate_kernel_text() & setup_replication_mask() as they are unused on
   ia64.


12 asm-ia64/sn/sn2

   Removed unused replicate_kernel_text(), setup_replication_mask()
   declarations


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
