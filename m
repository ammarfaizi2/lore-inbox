Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbUEQRYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUEQRYw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 13:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUEQRYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 13:24:51 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:38619 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261925AbUEQRX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 13:23:59 -0400
Date: Mon, 17 May 2004 10:23:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: PATCH][4/7] perfctr-2.7.2 for 2.6.6-mm2: PowerPC
Message-ID: <20040517172344.GI6763@smtp.west.cox.net>
References: <20040514180706.GR2196@smtp.west.cox.net> <200405151437.i4FEbtWM001341@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405151437.i4FEbtWM001341@harpo.it.uu.se>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2004 at 04:37:55PM +0200, Mikael Pettersson wrote:

> On Fri, 14 May 2004 11:07:06 -0700, Tom Rini wrote:
> >> perfctr-2.7.2 for 2.6.6-mm2, part 4/7:
> >[snip]
> >> --- linux-2.6.6-mm2/drivers/perfctr/ppc.c	1970-01-01 01:00:00.000000000 +0100
> >[snip]
> >> +#define SPRN_MMCR0	0x3B8	/* 604 and up */
> >[snip]
> >> +#define MMCR2_RESERVED		(MMCR2_SMCNTEN | MMCR2_SMINTEN | MMCR2__RESERVED)
> >
> >All of these belong in <asm-ppc/reg.h>.
> 
> Will do. The _RESERVED masks are sometimes more related to the driver
> than the hardware, so I think I'll keep those in the driver. But all
> the hardware-related defines can be moved.

OK, thanks.

> >[snip]
> > +static int __init generic_init(void)
> >> +{
> >> +	static char generic_name[] __initdata = "PowerPC 60x/7xx/74xx";
> >> +	unsigned int features;
> >> +	enum pll_type pll_type;
> >> +	unsigned int pvr;
> >> +
> >> +	features = PERFCTR_FEATURE_RDTSC | PERFCTR_FEATURE_RDPMC;
> >> +	pvr = mfspr(SPRN_PVR);
> >> +	switch( PVR_VER(pvr) ) {
> >> +	case 0x0004: /* 604 */
> >> +		pm_type = PM_604;
> >> +		pll_type = PLL_NONE;
> >> +		features = PERFCTR_FEATURE_RDTSC;
> >> +		break;
> >
> >This should all be done with cputable bits I would think.
> >arch/ppc/kernel/cputable.c and include/asm-ppc/cputable.h
> >(CPU_FTR_PERFCTR_PLL_{NONE,604e,...) and then
> >if (cur_cpu_spec[i]->cpu_features & CPU_FTR_PERFCTL_PLL_NONE)
> >  pll_type = PLL_NONE
> >
> >Or might that be bigger, code wise, in the end?
> 
> For the cputable framework I would need at least 11 feature bits
> (5 for pm_type, 6 for pll_type), with more later if/when G5 docs
> ever become public. <asm-ppc/cputable.h> currently has 14 free
> feature bits.
> 
> Encoding these as enumeration subfields in the high end of
> cpu_features instead would require 3+3 bits (preferably 4+4
> for future expansion).
> 
> So I can:
> 1. steal a big chunk of the remaining cpu_features bits, or
> 2. add pm_type and pll_type fields to struct cpu_spec, or
> 3. continue to keep this in the driver
> 
> Which would you prefer?

Hmm.  I guess 3.  Thanks for looking into it!

-- 
Tom Rini
http://gate.crashing.org/~trini/
