Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWBJPjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWBJPjT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 10:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWBJPjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 10:39:18 -0500
Received: from palrel12.hp.com ([156.153.255.237]:62941 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S932140AbWBJPjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 10:39:17 -0500
Date: Fri, 10 Feb 2006 07:36:08 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Cc: perfmon@napali.hpl.hp.com, perfctr-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org
Subject: perfmon2 code review: 32-bit ABI on 64-bit OS
Message-ID: <20060210153608.GC28311@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <3C87FFF91369A242B9C9147F8BD0908A02C6955C@cacexc04.americas.cpqcorp.net> <1138221212.15295.35.camel@serpentine.pathscale.com> <20060125222844.GB10451@frankl.hpl.hp.com> <1138649612.4077.50.camel@localhost.localdomain> <1138651545.4487.13.camel@camp4.serpentine.com> <1139155731.4279.0.camel@localhost.localdomain> <1139245253.27739.8.camel@camp4.serpentine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139245253.27739.8.camel@camp4.serpentine.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heelo,

Here is another topic of the interface I'd like to see discussed on this list
because it was raised in the past and I am not necessarily satisfied with
the current solution.

Tools can program the PMU by passing structures to read/write the PMC/PMD
registers. Some of those structures contain bitmasks. For instance, 
When sampling, one can load a PMD (counter) value and indicate which 
other PMD registers must be included in the samples using the bitmask.

The interface supports the same fixed number of PMD registers on
all platforms. As such the number of bits in the bitmask is fixed
and we have arrange for it to be multiple of 4 and 8. The structure
looks as follows:

typedef struct {
        u16 reg_num;            /* which register */
        u16 reg_set;            /* event set for this register */
        pfm_flags_t reg_flags;  /* input: flags, return: reg error */
        u64 reg_value;          /* initial pmc/pmd value */
        u64 reg_long_reset;     /* value to reload after notification */
        u64 reg_short_reset;    /* reset after counter overflow */
        u64 reg_last_reset_val; /* return: PMD last reset value */
        u64 reg_ovfl_switch_cnt;/* #overflows before switch */
        unsigned long reg_reset_pmds[PFM_PMD_BV]; /* reset on overflow */
        unsigned long reg_smpl_pmds[PFM_PMD_BV];  /* record in sample */
        u64 reg_smpl_eventid;   /* opaque event identifier */
        u64 reg_random_mask;    /* bitmask used to limit random value */
        u32 reg_random_seed;    /* seed for randomization */
        u32 reg_reserved2[7];   /* for future use */
} pfarg_pmd_t;

We use unsigned long for bitmask because we can leverage the
kernel bitmap.h interface which is nice. All the others fields
in the struct have fixed size. If it was not for the bitmask
the structure would be identical in 32-bit or 64-bit mode. 

Why does it matter?

Many 64-bit Linux kernel do support running 32-bit native applications.
That is the case on PPC64, MIPS64K, X86-64, for instance. One could well
write a 32-bit monitoring tool on top of a 64-bit OS. If we want to avoid
the emulation trampoline in the kernel, we need to ensure that the 32-bit
applications use the same structure layout as the 64-bit OS.

In our particular case we rely on the fact that the number of bits is fixed.
We use 320 bits, which is either 10x32 bits or 5x64 bits. Either way,
the sizeof() is the same. As such the struct is identical. Internally,
the kernel will take the bitmask as u64. The only issue would be the
alignment of the bitmasks. The 32-bit version must be aligned on 64-bit
boundary. Structures are aligned on the size of their largest member, 
here 64-bit. The layout is such that the bitmask are always aligned.
We have verified that this does indeed work on MIPS with Phil Mucci.

The alternative approach would be to hardcode bitmask to be u64.
But that would require extra casting in the kernel to get to the
bitmap interface and may cause extra overhead in the 32-bit user programs.
Yet I don't anticipate that programming those bitmask be in the critical
path of monitoring tools.

The second alternative looks cleaner and safer in a sense and I am certainly
willing to make the change but I would like to get everybody else's opinion
as well.

Note that there are similar issues with the remapped sampling buffer.
There, you need to explicitly compile your tool with a special option
to force certain types to be 64-bit (size_t, void *). Unless someone
tell me how to tell the compiler we're compiling 32-bit to execute
on an 64-bit OS ABI.

Thanks.

