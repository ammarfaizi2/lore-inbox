Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263871AbUCZAcq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263855AbUCZAcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:32:35 -0500
Received: from fmr10.intel.com ([192.55.52.30]:5010 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S263871AbUCZAQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 19:16:01 -0500
Subject: Re: [PATCH] x86_64 VIA chipset IOAPIC fix
From: Len Brown <len.brown@intel.com>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel-request@lists.sourceforge.net,
       patches@x86-64.org, Andi Kleen <ak@suse.de>, pavel@ucw.cz,
       ccheney@debian.org
In-Reply-To: <20040325033434.GB8139@atomide.com>
References: <20040325033434.GB8139@atomide.com>
Content-Type: text/plain
Organization: 
Message-Id: <1080260113.757.67.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 25 Mar 2004 19:15:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony,
At one point we nearly deleted disabled links on parsing them
http://bugme.osdl.org/show_bug.cgi?id=1581
But testing that "fix" suggested that some systems we'd considered
"broken" before required the opposite -- pretending that the the links
are not disabled at all.

Looks like that is what your VIA box needs.

I think we need to tread carefully in this area.
Ignoring the result of _CRS means that we really don't
know if the IRQ is programmed or not.  We could attach
a device to the wrong IRQ and not know it.
Unclear if that risk is a better policy than pretending
we confirmed that the IRQ was successfully programmed
when it may not have been.

perhaps you can attach this patch to 1581 and we can work there
to come up with a "disabled links patch" that makes sense
for all systems.  We might find that we need only a small
VIA-specific tweak to an otherwise robust policy.

If your dmesg and acpidmp are different from 2090, it would
be good to attach them also.

thanks,
-Len


On Wed, 2004-03-24 at 22:34, Tony Lindgren wrote:
> Hi Andi & Len,
> 
> Sorry for cross posting all over the place, I tried to CC some people who have
> been bugged by this bug.
> 
> I finally got the IOAPIC working on my eMachines m6805 amd64 laptop with the
> following patch. I have not tried it on any other machines, so can you guys
> please check the sanity and make the necessary changes if needed?
> 
> This fixes at least ACPI bug 2090:
> 
> http://bugme.osdl.org/show_bug.cgi?id=2090
> 
> Might fix some other x86 VIA bugs too?
> 
> To turn it on, apic still needs to be specified in the kernel cmdline:
> 
> root=/dev/hda3 ro psmouse.proto=imps apic console=tty0
> 
> Now cat /proc/interrupts shows:
> 
>  0:      70843    IO-APIC-edge  timer
>  1:          9    IO-APIC-edge  i8042
>  2:          0          XT-PIC  cascade
>  8:          0    IO-APIC-edge  rtc
> 10:          0   IO-APIC-level  acpi
> 12:         44    IO-APIC-edge  i8042
> 14:       2734    IO-APIC-edge  ide0
> 15:         19    IO-APIC-edge  ide1
> 17:          0   IO-APIC-level  yenta
> 18:          0   IO-APIC-level  eth0
> 21:        565   IO-APIC-level  ehci_hcd, uhci_hcd, uhci_hcd, uhci_hcd
> 22:          0   IO-APIC-level  VIA8233
> 23:          6   IO-APIC-level  eth1
> NMI:         12 
> LOC:      70752 
> ERR:          0
> MIS:          0
> 
> And things are just working :)
> 
> Regards,
> 
> Tony
> 
> And here's the patch, it's against 2.6.5-rc2:
> 
> 
> ______________________________________________________________________
> 
> diff -Nru a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> --- a/drivers/acpi/pci_link.c	Wed Feb 25 21:11:46 2004
> +++ b/drivers/acpi/pci_link.c	Wed Mar 24 18:47:48 2004
> @@ -402,10 +402,8 @@
>  		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unable to read status\n"));
>  		return_VALUE(result);
>  	}
> -	if (!link->device->status.enabled) {
> -		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Link disabled\n"));
> -		return_VALUE(-ENODEV);
> -	}
> +	if (!link->device->status.enabled)
> +		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Link disabled: VIA chipset? Trying to continue\n"));
>  
>  	/* Make sure the active IRQ is the one we requested. */
>  	result = acpi_pci_link_try_get_current(link, irq);
> @@ -415,11 +413,9 @@
>     
>  	if (link->irq.active != irq) {
>  		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, 
> -			"Attempt to enable at IRQ %d resulted in IRQ %d\n", 
> -			irq, link->irq.active));
> -		link->irq.active = 0;
> -		acpi_ut_evaluate_object (link->handle, "_DIS", 0, NULL);	   
> -		return_VALUE(-ENODEV);
> +			"Attempt to enable at IRQ %d resulted in IRQ %d: VIA chipset? Using irq %d\n", 
> +			irq, link->irq.active, irq));
> +		link->irq.active = irq;
>  	}
>  
>  	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Set IRQ %d\n", link->irq.active));

