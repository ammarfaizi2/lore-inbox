Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263876AbUDVIu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263876AbUDVIu7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 04:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbUDVIu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 04:50:59 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:506 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id S263877AbUDVIuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 04:50:52 -0400
Date: Thu, 22 Apr 2004 10:50:13 +0200 (METDST)
From: Arjen Verweij <A.Verweij2@ewi.tudelft.nl>
Reply-To: a.verweij@student.tudelft.nl
To: Len Brown <len.brown@intel.com>
cc: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, <ross@datscreative.com.au>,
       <christian.kroener@tu-harburg.de>, <linux-kernel@vger.kernel.org>,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       Allen Martin <AMartin@nvidia.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
 for idle=C1halt, 2.6.5
In-Reply-To: <1082587298.16336.138.camel@dhcppc4>
Message-ID: <Pine.GHP.4.44.0404221045470.26294-100000@elektron.its.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len,

Please bear in mind that the people from Shuttle are the only ones that
have seemingly fixed it, alledgedly, late in December. I only have data
for one Shuttle board, but that if they (Shuttle) would fix it, they would
fix it for all boards. For Shuttle AN35N rev 1.1 there is a BIOS update
from 05-Dec-2003 that has probably addressed this issue.

So if you are looking to reproduce this hang, don't update your BIOS :)

Regards,

Arjen

On 21 Apr 2004, Len Brown wrote:

> > Please send me the output from dmidecode, available in /usr/sbin/, or
> > > here:
> > > http://www.nongnu.org/dmidecode/
> > > or
> > > http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/
>
> On Wed, 2004-04-21 at 17:28, Prakash K. Cheemplavam wrote:
>
> > this is the output for Abit NF7-S Rev20 using bios d23. I have NOT
> > activated APIC for this. Is it needed?
>
> Yes, you need to enable ACPI and IOAPIC.  The goal of this patch
> is to address the XT-PIC timer issue in IOAPIC mode.
>
> Here's the latest (vs 2.6.5).
>
> I've got 1 Abit, 2 Asus, and 1 Shuttle DMI entry.  Let me know if the
> product names (1st line of dmidecode entry) are correct,
> these are not from DMI, but are supposed to be human-readable titles.
>
> I'm interested only in the latest BIOS -- if it is still broken.
> The assumption is that if a fixed BIOS is available, the users
> should upgrade.
>
> thanks,
> -Len
>
> ps. latest BIOS on my shuttle has a C1 disconnect enable setting,
> (curiously, it is disabled by default) so I'll try to reproduce the hang
> on it...
>
> ===== Documentation/kernel-parameters.txt 1.44 vs edited =====
> --- 1.44/Documentation/kernel-parameters.txt	Mon Mar 22 16:03:22 2004
> +++ edited/Documentation/kernel-parameters.txt	Wed Apr 21 15:28:12 2004
> @@ -122,6 +122,10 @@
>
>  	acpi_serialize	[HW,ACPI] force serialization of AML methods
>
> +	acpi_skip_timer_override [HW,ACPI]
> +			Recognize and ignore IRQ0/pin2 Interrupt Override.
> +			For broken nForce2 BIOS resulting in XT-PIC timer.
> +
>  	ad1816=		[HW,OSS]
>  			Format: <io>,<irq>,<dma>,<dma2>
>  			See also Documentation/sound/oss/AD1816.
> ===== arch/i386/kernel/dmi_scan.c 1.57 vs edited =====
> --- 1.57/arch/i386/kernel/dmi_scan.c	Fri Apr 16 22:03:06 2004
> +++ edited/arch/i386/kernel/dmi_scan.c	Wed Apr 21 18:29:35 2004
> @@ -540,6 +540,19 @@
>  #endif
>
>  /*
> + * early nForce2 reference BIOS shipped with a
> + * bogus ACPI IRQ0 -> pin2 interrupt override -- ignore it
> + */
> +static __init int ignore_timer_override(struct dmi_blacklist *d)
> +{
> +	extern int acpi_skip_timer_override;
> +	printk(KERN_NOTICE "%s detected: BIOS IRQ0 pin2 override"
> +		" will be ignored\n", d->ident);
> +
> +	acpi_skip_timer_override = 1;
> +	return 0;
> +}
> +/*
>   *	Process the DMI blacklists
>   */
>
> @@ -944,6 +957,37 @@
>  			MATCH(DMI_BOARD_VENDOR, "IBM"),
>  			MATCH(DMI_PRODUCT_NAME, "eserver xSeries 440"),
>  			NO_MATCH, NO_MATCH }},
> +
> +/*
> + * Systems with nForce2 BIOS timer override bug
> + * add Albatron KM18G Pro
> + * add DFI NFII 400-AL
> + * add Epox 8RGA+
> + * add Shuttle AN35N
> + */
> +	{ ignore_timer_override, "Abit NF7-S v2", {
> +			MATCH(DMI_BOARD_VENDOR, "http://www.abit.com.tw/"),
> +			MATCH(DMI_BOARD_NAME, "NF7-S/NF7,NF7-V (nVidia-nForce2)"),
> +			MATCH(DMI_BIOS_VERSION, "6.00 PG"),
> +			MATCH(DMI_BIOS_DATE, "03/24/2004") }},
> +
> +	{ ignore_timer_override, "Asus A7N8X v2", {
> +			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
> +			MATCH(DMI_BOARD_NAME, "A7N8X2.0"),
> +			MATCH(DMI_BIOS_VERSION, "ASUS A7N8X2.0 Deluxe ACPI BIOS Rev 1007"),
> +			MATCH(DMI_BIOS_DATE, "10/06/2003") }},
> +
> +	{ ignore_timer_override, "Asus A7N8X-X", {
> +			MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
> +			MATCH(DMI_BOARD_NAME, "A7N8X-X"),
> +			MATCH(DMI_BIOS_VERSION, "ASUS A7N8X-X ACPI BIOS Rev 1007"),
> +			MATCH(DMI_BIOS_DATE, "10/07/2003") }},
> +
> +	{ ignore_timer_override, "Shuttle SN41G2", {
> +			MATCH(DMI_BOARD_VENDOR, "Shuttle Inc"),
> +			MATCH(DMI_BOARD_NAME, "FN41"),
> +			MATCH(DMI_BIOS_VERSION, "6.00 PG"),
> +			MATCH(DMI_BIOS_DATE, "01/14/2004") }},
>  #endif	// CONFIG_ACPI_BOOT
>
>  #ifdef	CONFIG_ACPI_PCI
> ===== arch/i386/kernel/setup.c 1.115 vs edited =====
> --- 1.115/arch/i386/kernel/setup.c	Fri Apr  2 07:21:43 2004
> +++ edited/arch/i386/kernel/setup.c	Wed Apr 21 15:28:12 2004
> @@ -614,6 +614,9 @@
>  		else if (!memcmp(from, "acpi_sci=low", 12))
>  			acpi_sci_flags.polarity = 3;
>
> +		else if (!memcmp(from, "acpi_skip_timer_override", 24))
> +			acpi_skip_timer_override = 1;
> +
>  #ifdef CONFIG_X86_LOCAL_APIC
>  		/* disable IO-APIC */
>  		else if (!memcmp(from, "noapic", 6))
> ===== arch/i386/kernel/acpi/boot.c 1.58 vs edited =====
> --- 1.58/arch/i386/kernel/acpi/boot.c	Tue Apr 20 20:54:03 2004
> +++ edited/arch/i386/kernel/acpi/boot.c	Wed Apr 21 15:28:13 2004
> @@ -62,6 +62,7 @@
>
>  acpi_interrupt_flags acpi_sci_flags __initdata;
>  int acpi_sci_override_gsi __initdata;
> +int acpi_skip_timer_override __initdata;
>
>  #ifdef CONFIG_X86_LOCAL_APIC
>  static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
> @@ -327,6 +328,12 @@
>  		acpi_sci_ioapic_setup(intsrc->global_irq,
>  			intsrc->flags.polarity, intsrc->flags.trigger);
>  		return 0;
> +	}
> +
> +	if (acpi_skip_timer_override &&
> +		intsrc->bus_irq == 0 && intsrc->global_irq == 2) {
> +			printk(PREFIX "BIOS IRQ0 pin2 override ignored.\n");
> +			return 0;
>  	}
>
>  	mp_override_legacy_irq (
> ===== include/asm-i386/acpi.h 1.18 vs edited =====
> --- 1.18/include/asm-i386/acpi.h	Tue Mar 30 17:05:19 2004
> +++ edited/include/asm-i386/acpi.h	Wed Apr 21 15:28:14 2004
> @@ -118,6 +118,7 @@
>  #ifdef CONFIG_X86_IO_APIC
>  extern int skip_ioapic_setup;
>  extern int acpi_irq_to_vector(u32 irq);	/* deprecated in favor of
> acpi_gsi_to_irq */
> +extern int acpi_skip_timer_override;
>
>  static inline void disable_ioapic_setup(void)
>  {
>
>
>

