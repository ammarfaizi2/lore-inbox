Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbTERVXh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 17:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbTERVXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 17:23:37 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:23563 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S262206AbTERVXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 17:23:35 -0400
Date: Sun, 18 May 2003 23:43:22 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Davide Libenzi <davidel@xmailserver.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SIS-650+CPQ Presario 3045US+USB ...
In-Reply-To: <Pine.LNX.4.55.0305181236340.3568@bigblue.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.44.0305182309430.14825-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 May 2003, Davide Libenzi wrote:

> I don't have the laptop under my nose now and honestly I do not remember
> the whole output of pcitweak -l ;)

Well, "lspci -vxxx -d 1039:0008" should be sufficient. If possible 
combined with the pci routing table (from dump_pirq for example).

> > 0x61=IDEIRQ / 0x62=USBIRQ is definitely correct for the 5595/85C503 rev 01
> > - according to the data sheet and playing with setpci ;-)
> >
> > > But this is not the case since the machine issue 0x60..0x63 for the four
> > > OHCI devices. Now USB is working great with keyboard, mouse and drives. I
> > > still have to say bye to the Broadcom 54g wireless interface though ...
> >
> > Looks like your chipset uses a different irq routing register layout. When
> > the existing sis pci-irq routing stuff was added, the primary concern was
> > to handle the ambigous link values (0x40-43 vs. 0x00-03) used by different
> > BIOS's. The IDEIRQ case was merely added for documentation, it's unused.
> >
> > I think this might need some special treatment in pirq_sis_[sg]et(),
> > either checking for the revision id or a different pci device id.
> 
> This made it for me, but it could break other configurations though :

It would, sure. There are BIOSes in the field which have the 0x62 (USB) 
link included in the routing table for the old register layout. Maybe same 
for 0x61(IDE).

> --- pci-irq.c.orig	2003-05-18 12:34:03.000000000 -0700
> +++ pci-irq.c	2003-05-18 12:35:14.000000000 -0700
> @@ -306,14 +306,16 @@
>  		case 0x42:
>  		case 0x43:
>  		case 0x44:
> +		case 0x60:
> +		case 0x61:
>  		case 0x62:
> +		case 0x63:

Ok, looks like they have moved the location of the PCI INTA-INTD routing 
registers from 0x41-0x44 to 0x60-0x63. Since this works for you it means 
the vendor/device-id is still 1039:0008. We really need to check the 
revision id here.

>  			pci_read_config_byte(router, reg, &x);
> -			if (reg != 0x62)
> +			if (reg < 0x60)
>  				break;
>  			if (!(x & 0x40))
>  				return 0;

[...]

>  			x = (irq&0x0f) ? (irq&0x0f) : 0x80;
> -			if (reg != 0x62)
> +			if (reg < 0x60)
>  				break;
>  			/* always mark OHCI enabled, as nothing else knows about this */
>  			x |= 0x40;

Do you really need this bit 6 tweaking? In the current code it's only 
effective for the 0x62 link where it is used to enable the OHCI in the 
southbridge. For most other routing registers it's reserved according to 
the docs - for IDEIRQ (0x61) however it has some different meaning. 
Writing to it for older router revisions might probably make IDE 
unuseable or hang the box in irq storm.

Therefore, for your new 0x60-0x63 register layout I wouldn't suggest 
writing this bit - unless we have some insight there.

So, for your patch I'd suggest to check the PCI_REVISION_ID from the 
config space and apply your new layout for this revision only.

> > Btw, have you tried with acpi interrupt routing enabled?
> 
> Nope, since last time I checked ACPI was not in wonderful shape. I'll try
> though to see if it fixes the thing or if it'll add more issues.

Ok, lets see. IIRC recent MS OSes don't require pci routing table anymore. 
Furthermore we have seen too many broken routing tables. So it's probably 
a big win, if it would work with ACPI...

Martin

