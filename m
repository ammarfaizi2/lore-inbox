Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262896AbUEOOiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbUEOOiX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 10:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbUEOOiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 10:38:23 -0400
Received: from aun.it.uu.se ([130.238.12.36]:65225 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262744AbUEOOiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 10:38:04 -0400
Date: Sat, 15 May 2004 16:37:55 +0200 (MEST)
Message-Id: <200405151437.i4FEbtWM001341@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: trini@kernel.crashing.org
Subject: Re: PATCH][4/7] perfctr-2.7.2 for 2.6.6-mm2: PowerPC
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2004 11:07:06 -0700, Tom Rini wrote:
>> perfctr-2.7.2 for 2.6.6-mm2, part 4/7:
>[snip]
>> --- linux-2.6.6-mm2/drivers/perfctr/ppc.c	1970-01-01 01:00:00.000000000 +0100
>[snip]
>> +#define SPRN_MMCR0	0x3B8	/* 604 and up */
>[snip]
>> +#define MMCR2_RESERVED		(MMCR2_SMCNTEN | MMCR2_SMINTEN | MMCR2__RESERVED)
>
>All of these belong in <asm-ppc/reg.h>.

Will do. The _RESERVED masks are sometimes more related to the driver
than the hardware, so I think I'll keep those in the driver. But all
the hardware-related defines can be moved.

>[snip]
> +static int __init generic_init(void)
>> +{
>> +	static char generic_name[] __initdata = "PowerPC 60x/7xx/74xx";
>> +	unsigned int features;
>> +	enum pll_type pll_type;
>> +	unsigned int pvr;
>> +
>> +	features = PERFCTR_FEATURE_RDTSC | PERFCTR_FEATURE_RDPMC;
>> +	pvr = mfspr(SPRN_PVR);
>> +	switch( PVR_VER(pvr) ) {
>> +	case 0x0004: /* 604 */
>> +		pm_type = PM_604;
>> +		pll_type = PLL_NONE;
>> +		features = PERFCTR_FEATURE_RDTSC;
>> +		break;
>
>This should all be done with cputable bits I would think.
>arch/ppc/kernel/cputable.c and include/asm-ppc/cputable.h
>(CPU_FTR_PERFCTR_PLL_{NONE,604e,...) and then
>if (cur_cpu_spec[i]->cpu_features & CPU_FTR_PERFCTL_PLL_NONE)
>  pll_type = PLL_NONE
>
>Or might that be bigger, code wise, in the end?

For the cputable framework I would need at least 11 feature bits
(5 for pm_type, 6 for pll_type), with more later if/when G5 docs
ever become public. <asm-ppc/cputable.h> currently has 14 free
feature bits.

Encoding these as enumeration subfields in the high end of
cpu_features instead would require 3+3 bits (preferably 4+4
for future expansion).

So I can:
1. steal a big chunk of the remaining cpu_features bits, or
2. add pm_type and pll_type fields to struct cpu_spec, or
3. continue to keep this in the driver

Which would you prefer?

/Mikael
