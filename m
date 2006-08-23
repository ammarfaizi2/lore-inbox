Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWHWKjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWHWKjo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 06:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWHWKjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 06:39:43 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:37835 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S964835AbWHWKjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 06:39:42 -0400
Date: Wed, 23 Aug 2006 03:29:32 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/18] 2.6.17.9 perfmon2 patch for review: new x86_64 files
Message-ID: <20060823102932.GA697@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200608230806.k7N869KD000552@frankl.hpl.hp.com> <p73fyfn7nzz.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73fyfn7nzz.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Wed, Aug 23, 2006 at 12:19:44PM +0200, Andi Kleen wrote:
> > +
> > +config X86_64_PERFMON_EM64T
> > +	tristate "Support Intel EM64T hardware performance counters"
> > +	depends on PERFMON
> > +	default m
> > +	help
> > +	Enables support for the Intel EM64T hardware performance
> > +	counters. Does not work with AMD64 processors.
> > +	If unsure, say m.
> 
> Does that include the Core 2 support that you had in the i386 patch? 
> 
This overs P4 in 64-bit mode only!

What you have in i386 is the architectural perfmon support as documented
by Intel for Core Duo/Core Solo and possibly others. Core 2 is something
different but hopfully backward compatible with this.

> In general I would prefer to call it P4, not EM64T which is just
> a generic architecture name and at least on P4 performance counters
> are not really architected yet.
> 
Agreed.

> 
> > + *
> > + * This file implements the PEBS sampling format for Intel
> > + * EM64T Intel Pentium 4/Xeon processors. It does not work
> > + * with Intel 32-bit P4/Xeon processors.
> 
> Why not anyways? The registers are basically the same. What's so different
> in 64bit? oprofile shares that code too.
> 
Well, no. the PEBS record format is differnet between 32 and 64-bit mode.
In 64-bit they add r8-r15 in each sample. The rest of the logic is
exactly the same. Until now, I have kept the 32 and 64 bit format
completely separate. But I will merge them in my next patch to cut
down on the amount of code. 

> The file seems a bit underdocumented. At least some brief description
> what PEBS is and maybe at least one sentence for each function?
> 
> > + */
> > +#ifndef __PERFMON_EM64T_PEBS_SMPL_H__
> > +#define __PERFMON_EM64T_PEBS_SMPL_H__ 1
> > +
> > +#define PFM_EM64T_PEBS_SMPL_UUID { \
> > +	0x36, 0xbe, 0x97, 0x94, 0x1f, 0xbf, 0x41, 0xdf,\
> > +	0xb4, 0x63, 0x10, 0x62, 0xeb, 0x72, 0x9b, 0xad}
> 
> What does it need the UUID for?
> 
Every sampling format is identified by a UUID. This  is how an
application can identify the format it wants to use when it
creates a context.


> > +
> > +/*
> > + * format specific parameters (passed at context creation)
> > + *
> > + * intr_thres: index from start of buffer of entry where the
> > + * PMU interrupt must be triggered. It must be several samples
> > + * short of the end of the buffer.
> > + */
> > +struct pfm_em64t_pebs_smpl_arg {
> > +	size_t	buf_size;	/* size of the buffer in bytes */
> > +	size_t	intr_thres;	/* index of interrupt threshold entry */
> > +	u32	flags;		/* buffer specific flags */
> > +	u64	cnt_reset;	/* counter reset value */
> > +	u32	res1;		/* for future use */
> > +	u64	reserved[2];	/* for future use */
> 
> I hope you double checked the alignment comes up everywhere correctly.
> u64 alignment is different on the 32bit and 64bit ABIs. That can screw
> 
> Normally it's safer to use aligned_u64 on files that can be used on 
> 32bit too, because that avoids that problem.

As of now this file (perfmon_em64t_pebs_smpl.c) is only compiled in
64-bit mode. Once I merge with 32-bit I will force types to avoid
alignment problems.

> Where is the actual code that implements the code that you hooked 
> into arch/x86_64/*? I must have missed that.
> 
It is in the patch I call modified x86_64 files.

Thanks for you quick and valuable feedback.

I will make the change you suggested on this part.

-- 
-Stephane
