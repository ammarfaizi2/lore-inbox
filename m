Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbWAYUVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWAYUVf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 15:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbWAYUVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 15:21:35 -0500
Received: from mx.pathscale.com ([64.160.42.68]:64748 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751201AbWAYUVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 15:21:34 -0500
Subject: Re: [PATCH 1/6] 2.6.16-rc1 perfmon2 patch for review
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: eranian@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060123142316.GC5317@frankl.hpl.hp.com>
References: <200601201520.k0KFKCdY023112@frankl.hpl.hp.com>
	 <1137773148.28944.29.camel@serpentine.pathscale.com>
	 <20060123142316.GC5317@frankl.hpl.hp.com>
Content-Type: text/plain
Date: Wed, 25 Jan 2006 12:21:31 -0800
Message-Id: <1138220491.15295.23.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-23 at 06:23 -0800, Stephane Eranian wrote:

> The Carta algorithm is very simple and provides good enough
> randomization.

Fair enough.

> I did some search and could not find the message thread you are referring
> to. Could you provide some URL?

http://marc.theaimsgroup.com/?l=linux-kernel&m=113709100114894&w=2

> The data structure is indeed shared with user space. I do not reuse
> the same perfmon.h for user applications. Instead, I have a "user"
> perfmon.h (that would eventually migrate to libc). It defines the field
> using the uint32_t, uint64_t notation instead.

It would probably be helpful to annotate those types with the __u32 and
so on forms, to make it clear that userspace will be using them.

> We had a long discussion with David Gibson about the bitmask reg_*pmds[]
> in the context of ABI issues on platforms running a 64-bit OS but with
> both a 32-bit and 64-bit  ABIs. The number of bits in the bitmask is fixed.
> When using unsigned long the number of elements in the reg_*_pmds[] array
> differ between 32-bit and 64-bit but it does work.

How does it work?  Is the value of PFM_PMD_BV different depending on
whether it's a 32-bit or 64-bit arch?  That makes me pretty
uncomfortable.

Also, you should drop the typedef of pfarg_pmd_t and use "struct
pfarg_pmd" instead.  Likewise for all structs that are not intended to
be opaque.

> I must admit I don't quite follow the arguments about/sys vs. /proc if
> that is what you are asking for. I'd like to understand better why 
> put entries in one vs. the other.

Please see my prior message.

> > > +/* use for IA-64 only */
> > > +#ifdef __ia64__
> > > +#define pfm_release_dbregs(_t) 		do { } while (0)
> > > +#define pfm_use_dbregs(_t)     		(0)
> > > +#endif
> > 
> > Please move this to asm-ia64/perfmon.h, then.

> Well the issue is that this part is used whenever CONFIG_PERFMON is not
> selected. perfmon.h includes <asm/perfmon.h> but only when CONFIG_PERFMON
> is selected. I would have to move asm/perfmon.h at the top of perfmon.h
> but it depends on some definitions in perfmon.h.

Ugh.

> But perfmon2 also provides kernel level sampling buffer
> for per-thread sampling. There the buffer is attached to the thread not the processor
> it is running on. That's where this becomes very complicated with relayfs.

I don't see the difficulty.  Sure, you end up having to look at each
relayfs buffer in userspace instead of a single one, but can't libpfm
hide that from its consumers?  Surely having a finer granularity of data
like this ("I spent 75% of my time on this CPU") ends up being more
useful, no?

	<b

