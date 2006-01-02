Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbWABSUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWABSUy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 13:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbWABSUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 13:20:54 -0500
Received: from p54889FD5.dip0.t-ipconnect.de ([84.136.159.213]:58850 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id S1750882AbWABSUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 13:20:54 -0500
Date: Mon, 2 Jan 2006 18:20:19 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: macro@mips.com
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: unable to mount root device in 2.6.14.5  (was: Re: [PATCH] PCI patches for 2.6.10)
Message-ID: <20060102182018.GA25971@ds20.borg.net>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>, macro@mips.com,
	greg@kroah.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I just upgraded from Kernel 2.6.10 to 2.6.14.5 and got this message:

PCI: Unable to reserve I/O region #1:100@10000 for device 0000:00:06.0

instead of the usual initialisation messages of my scsi controller. As
a consequence no scsi device and thus no root device is found. 
I tracked this down to this patch (to be precise, the PCI_CLASS_NOT_DEFINED 
part of it). Removing the 'class == PCI_CLASS_NOT_DEFINED ||' clause makes
it boot again.

> List:       linux-kernel
> Subject:    Re: [PATCH] PCI patches for 2.6.10
> From:       Greg KH <greg () kroah ! com>
> Date:       2005-01-10 17:20:57
> Message-ID: 11053776574174 () kroah ! com
> [Download message RAW]
> 
> ChangeSet 1.1938.447.8, 2004/12/17 13:44:31-08:00, macro@mips.com
> 
> [PATCH] PCI: Don't touch BARs of host bridges
> 
>  BARs of host bridges often have special meaning and AFAIK are best left
> to be setup by the firmware or system-specific startup code and kept
> intact by the generic resource handler.  For example a couple of host
> bridges used for MIPS processors interpret BARs as target-mode decoders
> for accessing host memory by PCI masters (which is quite reasonable).
> For them it's desirable to keep their decoded address range overlapping
> with the host RAM for simplicity if nothing else (I can imagine running
> out of address space with lots of memory and 32-bit PCI with no DAC
> support in the participating devices).
> 
>  This is already the case with the i386 and ppc platform-specific PCI
> resource allocators.  Please consider the following change for the generic
> allocator.  Currently we have a pile of hacks implemented for host bridges
> to be left untouched and I'd be pleased to remove them.
> 
> From: "Maciej W. Rozycki" <macro@mips.com>
> Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>
> 
> 
>  drivers/pci/setup-bus.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> 
> diff -Nru a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> --- a/drivers/pci/setup-bus.c	2005-01-10 09:02:52 -08:00
> +++ b/drivers/pci/setup-bus.c	2005-01-10 09:02:52 -08:00
> @@ -57,8 +57,13 @@
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		u16 class = dev->class >> 8;
>  
> -		if (class == PCI_CLASS_DISPLAY_VGA
> -				|| class == PCI_CLASS_NOT_DEFINED_VGA)
> +		/* Don't touch classless devices and host bridges.  */
> +		if (class == PCI_CLASS_NOT_DEFINED ||
> +		    class == PCI_CLASS_BRIDGE_HOST)
> +			continue;
> +
> +		if (class == PCI_CLASS_DISPLAY_VGA ||
> +		    class == PCI_CLASS_NOT_DEFINED_VGA)
>  			bus->bridge_ctl |= PCI_BRIDGE_CTL_VGA;
>  
>  		pdev_sort_resources(dev, &head);
> 


This is a DEC alpha AXPpci33 (aka 'noname') board with an sym810 onboard scsi-
controller:

[Marvin:~#] lspci -v
00:06.0 Non-VGA unclassified device: Symbios Logic Inc. (formerly NCR) 53c810 (rev 01)
        Flags: bus master, medium devsel, latency 255, IRQ 11
        I/O ports at 8000 [size=256]
        Memory at 0000000001230000 (32-bit, non-prefetchable) [size=256]

00:07.0 Non-VGA unclassified device: Intel Corporation 82378IB [SIO ISA Bridge] (rev 03)
        Flags: bus master, medium devsel, latency 0

00:08.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
        Subsystem: 3Com Corporation: Unknown device 9055
        Flags: bus master, medium devsel, latency 248, IRQ 14
        I/O ports at 8400 [size=128]
        Memory at 0000000001231000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at 0000000001200000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1

00:0b.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH A1 ISDN [Fritz] (rev 02)
        Subsystem: AVM Audiovisuelles MKTG & Computer System GmbH: Unknown device 0a00
        Flags: medium devsel, IRQ 14
        Memory at 0000000001232000 (32-bit, non-prefetchable) [size=32]
        I/O ports at 8480 [size=32]

00:0c.0 VGA compatible controller: ATI Technologies Inc 215CT [Mach64 CT] (rev 41) (prog-if 00 [VGA])
        Flags: stepping, medium devsel, IRQ 14
        Memory at 0000000002000000 (32-bit, non-prefetchable) [size=16M]
        Expansion ROM at 0000000001220000 [disabled] [size=64K]


Your patch description suggests that a platform specific solution might be
better. So can you point me tho the right place under arch/alpha to implement
this? Or would a patch to remove the comparison be acceptable?

Thanks,
Thorsten


-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Kiebitzstr. 14, 49324 Melle, Germany  |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
