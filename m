Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262834AbUC2MMs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 07:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUC2MMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:12:48 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:17077 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262834AbUC2MMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:12:40 -0500
Date: Mon, 29 Mar 2004 04:11:40 -0800
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: mbligh@aracnet.com, akpm@osdl.org, wli@holomorphy.com, haveblue@us.ibm.com,
       colpatch@us.ibm.com
Subject: [PATCH] Introduce mask ADT, rebuild cpumask_t and nodemask_t [0/22]
Message-Id: <20040329041140.77ce66d2.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following sequence of 22 patches replaces cpumask_t and Matthew
Dobson's recent nodemask_t with ones based on a new mask ADT.

==> This code is untested.  Never even booted yet.
    Code review and testing requested.  I will test
    on ia64.

    It has been built, for a default i386 arch only.
    But it seems far enough along to me to be worth
    seeking feedback from others.

The following patches apply against a 2.6.4 vanilla kernel,
and result in nodemask code that is (with a couple of details)
the same as Matthew's.

All the various include/asm-*/*mask.h files are gone.  The const
macros are gone.  The promote and coerce macros are replaced
with a single mask_raw() macro, that simply returns the address
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
 4) Fixed a nodes_complement() call in Matthew's patches.
 5) A few missing const attributes in bitmap & bitops added.
 6) The (Hamming) cpumask weight macros were using the bitops hweight*()
    macros, which don't mask high unused bits - fixed to use the bitmap
    weight macro which does this masking.

Do to the rather limited use so far of these cpumask and nodemask
macros, I am not aware of anything that these bugs would actually
break in current mm or linus kernels.

Also, the assymetry that Matthew's nodemasks had with cpumasks,
whereby the cpumasks had include/asm-<arch> specific redirecting
headers for every arch, but nodemasks didn't, has been fixed.
Now neither one has arch-specific redirect headers.  They aren't
needed in my view.  Arch specific code belongs in the underlying
bitops.h header files, and the individual mask macros can be
elaborated as need be to take advantage of such.

===

Here's what each patch does:

Patch_1_of_22 - Underlying bitmap/bitop details, added ops
	Add a couple of 'const' qualifiers
	Add intersects, subset, xor and andnot operators.
	Fix some unused bits in bitmap_complement
	Change bitmap_complement to take two operands.

Patch_2_of_22 - New mask ADT
	Adds new include/linux/mask.h header file

	==> See this mask.h header for more extensive mask documentation <==

Patch_3_of_22 - Rework cpumasks to use new mask ADT
	Removes many old include/asm-<arch> and asm-generic cpumask files
	Add intersects, subset, xor and andnot operators.
	Provides temporary emulators for obsolete const, promote, coerce
	Presents entire cpumask API clearly in single cpumask.h file

Patch_4_of_22 - Remove/recode obsolete cpumask macros from arch i386
Patch_5_of_22 - Remove/recode obsolete cpumask macros from arch ppc64
Patch_6_of_22 - Remove/recode obsolete cpumask macros from arch x86_64
	The above three patches remove by recoding all uses of the
	obsolete cpumask const, coerce and promote macros, from each
	specified architecture.

Patch_7_of_22 - Remove obsolete cpumask emulation from cpumask.h
	Now that the emulation of the obsolete cpumask macros is no
	longer needed, remove it from cpumask.h

Patch_8_of_22 - Simplify a couple of cpumask checks using cpus_subset
	Simplify a couple of code fragements using cpus_subset.

Patch_9_of_22 - Add new nodemasks.h file.
	Provide a nodemasks_t type, using the mask.h ADT.

Patch_10_of_22 - the mmzone.h changes from Matthew's Patch [1/7]
	Just the mmzone.h changes taken from this patch: removing
	extistant definition of node_online_map and helper functions,
	added a #include <nodemask.h>.

Patch_11_of_22 - Matthew Dobson's [PATCH] nodemask_t core changes [2/7]
	nodemask_t-02-core.patch - Changes to arch-independent code.
	Surprisingly few references to numnodes, open-coded node loops,
	etc. in generic code.  Most important result of this patch is
	that no generic code assumes anything about node numbering.
	This allows individual arches to use sparse numbering if they
	care to.

Patch_12_of_22 - Matthew Dobson's [PATCH]_nodemask_t_i386_changes_[3_7]
	Changes to i386 specific code.  As with most arch changes,
	it involves close-coding loops (ie: for_each_online_node(nid)
	rather than for(nid=0;nid<numnodes;nid++)) and replacing the
	use of numnodes with num_online_nodes() and node_set_online(nid).

Patch_13_of_22 - Matthew Dobson's [PATCH]_nodemask_t_pp64_changes_[4_7]
	Changes to ppc64 specific code.  Untested.
	Code review & testing requested.

Patch_14_of_22 - Matthew Dobson's [PATCH]_nodemask_t_x86_64_changes_[5_7]
	Changes to x86_64 specific code.
	Untested.  Code review & testing requested.
	Note Patch 22 of 22 below - needed to fix complement in this patch.

Patch_15_of_22 - Matthew Dobson's [PATCH]_nodemask_t_ia64_changes_[6_7]
	Changes to ia64 specific code.  Untested.
	Code review & testing requested.

Patch_16_of_22 - Matthew Dobson's [PATCH]_nodemask_t_other_arch_changes_[7_7]
	Changes to other arch-specific code (alpha, arm, mips,
	sparc64 & sh).  Untested.  Code review & testing requested.

Patch_17_of_22 - Simplify some sparc64 cpumask loop code
	Make use of for_each_cpu_mask() macro to simplify and optimize
	a couple of sparc64 per-CPU loops.  This code change has _not_
	been tested or reviewed.  Feedback welcome.  There is non-trivial
	risk that I still don't understand the logic here.

Patch_18_of_22 - Optimize i386 cpumask macro usage.
	Optimize a bit of cpumask code for asm-i386/mach-es7000
	Code untested, unreviewed.  Feedback welcome.

Patch_19_of_22 - Convert physids_complement() to really use both args
	Provide for specifying distinct source and dest args to the
	physids_complement().  No one actually uses this macro yet.
	The physid_mask type would be a good candidate to convert to
	using this new mask ADT as a base.

Patch_20_of_22 - Remove cpumask hack from asm-x86_64/topology.h
	This file had the cpumask cpu_online_map as type
	unsigned long, instead of type cpumask_t, for no good
	reason that I could see.  So I changed it.  Everywhere
	else, cpu_online_map is already of type cpumask_t.

Patch_21_of_22 - Cpumask code clarification in kernel/sched.c
	Clarify and slightly optimize set_cpus_allowed() cpumask check

Patch_22_of_22 - Fix nodes_complement call - it's a dyadic macro.
	One bit of code in Matthew's Patch 5 of 7 also had a
	nodes_complement call - convert it to two arg form.



-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
