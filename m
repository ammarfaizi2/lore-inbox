Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267436AbUHXKno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267436AbUHXKno (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 06:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267470AbUHXKno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 06:43:44 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:29866 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267436AbUHXKn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 06:43:29 -0400
Date: Tue, 24 Aug 2004 11:43:25 +0100
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] I2C: automatic VRM detection part1
Message-ID: <20040824104325.GA28237@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200408232328.i7NNSSkW027208@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408232328.i7NNSSkW027208@hera.kernel.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 11:38:57PM +0000, Linux Kernel wrote:
 
 > diff -Nru a/drivers/i2c/i2c-sensor-vid.c b/drivers/i2c/i2c-sensor-vid.c
 > --- /dev/null	Wed Dec 31 16:00:00 196900
 > +++ b/drivers/i2c/i2c-sensor-vid.c	2004-08-23 16:28:37 -07:00
 > @@ -0,0 +1,99 @@

....
 
 > +#ifdef CONFIG_X86
 > +
 > +static struct vrm_model vrm_models[] = {
 > +	{X86_VENDOR_AMD, 0x6, ANY, 90},		/* Athlon Duron etc */

This is insufficient afaics. Mobile Athlon's/Durons will have
a different VRM to the desktop parts.

 > +	{X86_VENDOR_AMD, 0xF, 0x4, 90},		/* Athlon 64 */

possible the same here.

 > +	{X86_VENDOR_INTEL, 0x6, 0xB, 85},	/* 0xB Tualatin */

again, mobile parts may match this.

 > +	{X86_VENDOR_INTEL, 0x6, ANY, 82},	/* any P6 */

definitly here.

 > +	{X86_VENDOR_INTEL, 0x7, ANY, 0},	/* Itanium */

huh? Under ifdef CONFIG_X86 ?

 > +	{X86_VENDOR_INTEL, 0x10,ANY, 0},	/* Itanium 2 */

ditto.


 > +
 > +int i2c_which_vrm(void)
 > +{
 > +	struct cpuinfo_x86 *c = cpu_data;
 > +	u32 eax;
 > +	u8 eff_family, eff_model;
 > +	int vrm_ret;
 > +
 > +	if (c->x86 < 6) return 0;	/* any CPU with familly lower than 6
 > +				 	dont have VID and/or CPUID */

1. CodingStyle dictates
		if (c->x86 < 6)
			return 0;
2. Typo in 'familly'
 
 > +	eax = cpuid_eax(1);
 > +	eff_family = ((eax & 0x00000F00)>>8);
 > +	eff_model  = ((eax & 0x000000F0)>>4);
 > +	if (eff_family == 0xF) {	/* use extended model & family */
 > +		eff_family += ((eax & 0x00F00000)>>20);
 > +		eff_model += ((eax & 0x000F0000)>>16)<<4;
 > +	}

Is this guaranteed safe on all vendors ?

 > +/* and now something completely different for Non-x86 world*/
 > +#else
 > +int i2c_which_vrm(void)
 > +{
 > +	printk(KERN_INFO "i2c-sensor.o: Unknown VRM version of your CPU\n");
 > +	return 0;
 > +}
 > +#endif

why build this at all on non-x86 if its useless ?


		Dave

