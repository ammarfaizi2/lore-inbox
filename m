Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbVGZQGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVGZQGG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 12:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVGZQEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 12:04:08 -0400
Received: from ns1.suse.de ([195.135.220.2]:13273 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261929AbVGZQDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 12:03:20 -0400
Date: Tue, 26 Jul 2005 18:03:19 +0200
From: Andi Kleen <ak@suse.de>
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Subject: Re: [RFC][2.6.13-rc3-mm1] IRQ compression/sharing patch
Message-ID: <20050726160319.GB5353@wotan.suse.de>
References: <200507260012.41968.jamesclv@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507260012.41968.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 12:12:41AM -0700, James Cleverdon wrote:
> Here's a patch that builds on Natalie Protasevich's IRQ compression 
> patch and tries to work for MPS boots as well as ACPI.  It is meant for 
> a 4-node IBM x460 NUMA box, which was dying because it had interrupt 
> pins with GSI numbers > NR_IRQS and thus overflowed irq_desc.
> 
> The problem is that this system has 270 GSIs (which are 1:1 mapped with 
> I/O APIC RTEs) and an 8-node box would have 540.  This is much bigger 
> than NR_IRQS (224 for both i386 and x86_64).  Also, there aren't enough 
> vectors to go around.  There are about 190 usable vectors, not counting 
> the reserved ones and the unused vectors at 0x20 to 0x2F.  So, my patch 
> attempts to compress the GSI range and share vectors by sharing IRQs.
> 
> Important safety note:  While the SLES 9 version of this patch works, I 
> haven't been able to test the -rc3-mm1 patch enclosed.  I keep getting 
> errors from the adp94xx driver.  8-(
> 
> (Sorry about doing an attachment, but KMail is steadfastly word wrapping 
> inserted files.  I need to upgrade....)

The patch seems to have lots of unrelated stuff. Can you please 
split it out? 

BTW I plan to implement per CPU IDT vectors similar to Zwane's i386 patch
for x86-64 soon, hopefully with that things will be easier too.

Andrew: this is not 2.6.13 material.

> @@ -276,13 +276,13 @@ config HAVE_DEC_LOCK
>  	default y
>  
>  config NR_CPUS
> -	int "Maximum number of CPUs (2-256)"
> -	range 2 256
> +	int "Maximum number of CPUs (2-255)"
> +	range 2 255
>  	depends on SMP
> -	default "8"
> +	default "64"

Please don't change that,

> +/*
> + * Check the APIC IDs in MADT table header and choose the APIC mode.
> + */
> +void acpi_madt_oem_check(char *oem_id, char *oem_table_id)
> +{
> +	/* May need to check OEM strings in the future. */
> +}
> +
> +/*
> + * Check the IDs in MPS header and choose the APIC mode.
> + */
> +void mps_oem_check(struct mp_config_table *mpc, char *oem, char *productid)
> +{
> +	/* May need to check OEM strings in the future. */
> +}

Can you perhaps add it then later, not now? 

> +static u8 gsi_2_irq[NR_IRQ_VECTORS] = { [0 ... NR_IRQ_VECTORS-1] = 0xFF };

With the per cpu IDTs we'll likely need more than 8 bits here.

> -	char str[16];
> +	char oem[9], str[16];
>  	int count=sizeof(*mpc);
>  	unsigned char *mpt=((unsigned char *)mpc)+count;
> +	extern void mps_oem_check(struct mp_config_table *mpc, char *oem, char *productid);

That would belong in some header if it was needed.

But please just remove it for now.

The rest looks ok.

-Andi
