Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbTERWan (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 18:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbTERWan
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 18:30:43 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:47234 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262237AbTERWal
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 18:30:41 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 18 May 2003 15:42:43 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Martin Diehl <lists@mdiehl.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SIS-650+CPQ Presario 3045US+USB ...
In-Reply-To: <Pine.LNX.4.44.0305182309430.14825-100000@notebook.home.mdiehl.de>
Message-ID: <Pine.LNX.4.55.0305181533280.3568@bigblue.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0305182309430.14825-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 May 2003, Martin Diehl wrote:

> On Sun, 18 May 2003, Davide Libenzi wrote:
>
> > I don't have the laptop under my nose now and honestly I do not remember
> > the whole output of pcitweak -l ;)
>
> Well, "lspci -vxxx -d 1039:0008" should be sufficient. If possible
> combined with the pci routing table (from dump_pirq for example).

I know, but even that one is hard to do w/out the machine under your nose ;)


> > This made it for me, but it could break other configurations though :
>
> It would, sure. There are BIOSes in the field which have the 0x62 (USB)
> link included in the routing table for the old register layout. Maybe same
> for 0x61(IDE).

I had no doubt about that either.


> > --- pci-irq.c.orig	2003-05-18 12:34:03.000000000 -0700
> > +++ pci-irq.c	2003-05-18 12:35:14.000000000 -0700
> > @@ -306,14 +306,16 @@
> >  		case 0x42:
> >  		case 0x43:
> >  		case 0x44:
> > +		case 0x60:
> > +		case 0x61:
> >  		case 0x62:
> > +		case 0x63:
>
> Ok, looks like they have moved the location of the PCI INTA-INTD routing
> registers from 0x41-0x44 to 0x60-0x63. Since this works for you it means
> the vendor/device-id is still 1039:0008. We really need to check the
> revision id here.

Nope, I still see 0x4* commands for all devices != from USB. So more then
a "move" is an extension.



> >  			x = (irq&0x0f) ? (irq&0x0f) : 0x80;
> > -			if (reg != 0x62)
> > +			if (reg < 0x60)
> >  				break;
> >  			/* always mark OHCI enabled, as nothing else knows about this */
> >  			x |= 0x40;
>
> Do you really need this bit 6 tweaking? In the current code it's only
> effective for the 0x62 link where it is used to enable the OHCI in the
> southbridge. For most other routing registers it's reserved according to
> the docs - for IDEIRQ (0x61) however it has some different meaning.
> Writing to it for older router revisions might probably make IDE
> unuseable or hang the box in irq storm.
>
> Therefore, for your new 0x60-0x63 register layout I wouldn't suggest
> writing this bit - unless we have some insight there.
>
> So, for your patch I'd suggest to check the PCI_REVISION_ID from the
> config space and apply your new layout for this revision only.

Instead of just trolling, isn't there a documentation about this chipset ?
The SIS web site is pretty/very weak about docs.



> > > Btw, have you tried with acpi interrupt routing enabled?
> >
> > Nope, since last time I checked ACPI was not in wonderful shape. I'll try
> > though to see if it fixes the thing or if it'll add more issues.
>
> Ok, lets see. IIRC recent MS OSes don't require pci routing table anymore.
> Furthermore we have seen too many broken routing tables. So it's probably
> a big win, if it would work with ACPI...

BTW, according to the Compaq documentation, the vanilla XP fails on this
configuration either. You need their tweaked XP to have it working.



- Davide

