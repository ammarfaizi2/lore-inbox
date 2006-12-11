Return-Path: <linux-kernel-owner+w=401wt.eu-S1762533AbWLKFwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762533AbWLKFwt (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 00:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762549AbWLKFwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 00:52:49 -0500
Received: from hera.kernel.org ([140.211.167.34]:49759 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762532AbWLKFws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 00:52:48 -0500
From: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: SuD <sud@latinsud.com>
Subject: Re: Hostap_cs shared irq oops
Date: Mon, 11 Dec 2006 00:55:21 -0500
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, hostap@shmoo.com, linux-acpi@vger.kernel.org
References: <457B9020.1040101@latinsud.com>
In-Reply-To: <457B9020.1040101@latinsud.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612110055.22416.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 December 2006 23:42, SuD wrote:
> Hi, I recently upgraded to kernel 2.6.18.2 and noticed these problems:
>  - I realized that having CONFIG_ISA=y makes it always crash when i 
> insert the card (complains about unexpected LVT TMR interrupt). So i 
> disabled Isa.
>  - Hostap_cs gets a shared Irq (this didn't happen with kernel 
> 2.6.15.6). It crashes if the interrupt is triggered while the device is 
> not fully initialized (Error is: "Divide error 0000 [#1]"). I can 
> workaround that by using a flag and inserting a "if (!my_init_flag) { 
> return IRQ_HANDLED }" at the begining of the irq handler.

hostap_cs is hard-coded to request IRQ_TYPE_EXCLUSIVE

I think it was Bjorn Helgaas who observed that a device doing such
a request is not seen, and thus not honored by ACPI when the
physical IRQs are handed out.

The immediate question is why this fragile creature broke after 2.6.15.
By default, we avoid re-programming interrupts in PIC mode.
Is CONFIG_PNPACPI enabled in both kernels?

Need the dmesg -s64000 and /proc/interrupts output for last working
and first broken kernels.  Maybe best to file these in a bugzilla entry.

http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI

thanks,
-Len


> - I don't know much about irq allocation. Can i try something to get my 
> separate irq back?
> - Should i try different configuration or 2.6.19?
> - Should hostap_cs be enhanced to support shared irq?
> 
> I use debian etch. Laptop is a G200N 1.7GHz Centrino.
> 
> My /proc/interrupts in 2.6.18.2:
>            CPU0
>   0:     756865          XT-PIC  timer
>   1:      11062          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>   5:      30453          XT-PIC  uhci_hcd:usb3, eth0
>   9:     306542          XT-PIC  acpi
>  10:      40192          XT-PIC  ohci1394, yenta, ipw2200, 
> ehci_hcd:usb1, uhci_hcd:usb4, Intel 82801DB-ICH4, pcmcia0.0
>  11:     167128          XT-PIC  uhci_hcd:usb2, i915@pci:0000:00:02.0
>  12:     226854          XT-PIC  i8042
>  14:      48281          XT-PIC  ide0
>  15:      24932          XT-PIC  ide1
> 
> Some acpi boot messages:
> PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
> PCI quirk: region 1180-11bf claimed by ICH4 GPIO
> PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
> PCI: Transparent bridge - 0000:00:1e.0
> PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#02) (try 
> 'pci=assign-busses')
> Please report the result to linux-kernel to fix this permanently
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
> ACPI: PCI Interrupt Link [LNKA] (IRQs *11)
> ACPI: PCI Interrupt Link [LNKB] (IRQs *10)
> ACPI: PCI Interrupt Link [LNKC] (IRQs *10)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 5) *11
> ACPI: PCI Interrupt Link [LNKE] (IRQs 10) *11
> ACPI: PCI Interrupt Link [LNKF] (IRQs 10) *0, disabled.
> ACPI: PCI Interrupt Link [LNKG] (IRQs 11) *0, disabled.
> ACPI: PCI Interrupt Link [LNKH] (IRQs *10)
> ACPI: Embedded Controller [EC0] (gpe 29) interrupt mode.
> ACPI: Power Resource [PFN0] (off)
> ACPI: Power Resource [PFN1] (off)
> 
> Thanks, please CC me if you can (works both with or without the "_nospam").
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
