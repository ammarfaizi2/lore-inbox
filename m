Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbUDNE7O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 00:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263881AbUDNE7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 00:59:14 -0400
Received: from gizmo02ps.bigpond.com ([144.140.71.12]:2973 "HELO
	gizmo02ps.bigpond.com") by vger.kernel.org with SMTP
	id S263875AbUDNE67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 00:58:59 -0400
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: Len Brown <len.brown@intel.com>
Subject: Re: IO-APIC on nforce2 [PATCH]
Date: Wed, 14 Apr 2004 15:02:13 +1000
User-Agent: KMail/1.5.1
Cc: christian.kroener@tu-harburg.de, linux-kernel@vger.kernel.org,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
References: <200404131117.31306.ross@datscreative.com.au> <200404131703.09572.ross@datscreative.com.au> <1081893978.2251.653.camel@dhcppc4>
In-Reply-To: <1081893978.2251.653.camel@dhcppc4>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404141502.14023.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 April 2004 11:02, Len Brown wrote:
> Re: IRQ0 XT-PIC timer issue
> 
> Since the hardware is connected to APIC pin0, it is a BIOS bug
> that an ACPI interrupt source override from pin2 to IRQ0 exists.
> 
> With this simple 2.6.5 patch you can specify "acpi_skip_timer_override"
> to ignore that bogus BIOS directive.  The result is with your
> ACPI-enabled APIC-enabled kernel, you'll get IRQ0 IO-APIC-edge timer.
> 
> Probably there is a more clever way to trigger this workaround
> automatcially instead of via boot parameter.
> 
> cheers,
> -Len

Many thanks Len,
I cannot try it just yet (rebuilding car engine,-greasy mess
 - hopefully get to it tonight).

Just would like to add that if we cannot get Maciej's 8259 ack patch
back into the distro then we need an if statement in the check_timer()
to turn off timer_ack for nforce2 or Christian might get his hi-load back
and certainly nmi_debug=1 won't work.

e.g. for 2.4.26-rc2 io_apic.c line 1613 or 2.6.5 line 2180 
	if (pin1 != -1) {
		/*
		 * Ok, does IRQ0 through the IOAPIC work?
		 */
+		if(acpi_skip_timer_override)
+			timer_ack=0;
		unmask_IO_APIC_irq(0);

I might also grab the pci quirk source from the old nforce2 disconnect bit
patch and try it as a means of detection for automatic trigger. i.e. instead
of writing the pci config bit, set acpi_skip_timer_override instead - but then
if someone gets clock skew we would need the kern arg to turn it off - 
unless the potential for clock skew is fixed.
 
The clock skew is an interesting one, I think the clock uses tsc if available
to interpolate between timer ints and if so should it not also be used to 
validate the timer ints in case of noise? Apparently the clock speeds up not
slows down in those cases?

Regards
Ross.

> 
> ===== Documentation/kernel-parameters.txt 1.44 vs edited =====
> --- 1.44/Documentation/kernel-parameters.txt	Mon Mar 22 16:03:22 2004
> +++ edited/Documentation/kernel-parameters.txt	Tue Apr 13 17:47:11 2004
> @@ -122,6 +122,10 @@
>  
>  	acpi_serialize	[HW,ACPI] force serialization of AML methods
>  
> +	acpi_skip_timer_override [HW,ACPI]]
> +			Recognize IRQ0/pin2 Interrupt Source Override
> +			and ignore it -- for broken nForce2 BIOS.
> +
>  	ad1816=		[HW,OSS]
>  			Format: <io>,<irq>,<dma>,<dma2>
>  			See also Documentation/sound/oss/AD1816.
> ===== arch/i386/kernel/setup.c 1.115 vs edited =====
> --- 1.115/arch/i386/kernel/setup.c	Fri Apr  2 07:21:43 2004
> +++ edited/arch/i386/kernel/setup.c	Tue Apr 13 17:41:31 2004
> @@ -614,6 +614,12 @@
>  		else if (!memcmp(from, "acpi_sci=low", 12))
>  			acpi_sci_flags.polarity = 3;
>  
> +		else if (!memcmp(from, "acpi_skip_timer_override", 24)) {
> +			extern int acpi_skip_timer_override;
> +
> +			acpi_skip_timer_override = 1;
> +		}
> +
>  #ifdef CONFIG_X86_LOCAL_APIC
>  		/* disable IO-APIC */
>  		else if (!memcmp(from, "noapic", 6))
> ===== arch/i386/kernel/acpi/boot.c 1.57 vs edited =====
> --- 1.57/arch/i386/kernel/acpi/boot.c	Tue Mar 30 17:05:19 2004
> +++ edited/arch/i386/kernel/acpi/boot.c	Tue Apr 13 17:50:14 2004
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
> 
> 
> 

