Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbTERTc7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 15:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTERTc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 15:32:59 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:32385 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262175AbTERTc4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 15:32:56 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 18 May 2003 12:44:59 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Martin Diehl <lists@mdiehl.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SIS-650+CPQ Presario 3045US+USB ...
In-Reply-To: <Pine.LNX.4.44.0305181052210.14825-100000@notebook.home.mdiehl.de>
Message-ID: <Pine.LNX.4.55.0305181236340.3568@bigblue.dev.mcafeelabs.com>
References: <Pine.LNX.4.44.0305181052210.14825-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 May 2003, Martin Diehl wrote:

> On Sat, 17 May 2003, Davide Libenzi wrote:
>
> > I've spent a few horrible hours terrified by the idea of a possible XP
> > install on my new laptop. It's a Compaq Presario 3045US with SIS-650
> > chipset and there was no way to have USB bits work with it because of a
> > IRQ routing issue.
>
> What are the device/revision id's of the pci irq router function?

I don't have the laptop under my nose now and honestly I do not remember
the whole output of pcitweak -l ;)


> > The PCI routing table of that machine issues requests
> > for 0x60, 0x61 and 0x63 that, to have everything to work out, must be
> > handled like the 0x4* cases.
>
> This sounds different wrt. what we have documented for the older 85C503
> ISA bridge which is used in the 5595 chipset family.
>
> > Now, while 0x60 and 0x63 were ot documented
> > at all, 0x61 was documented as IDEIRQ and I was a bit worried about that.
>
> 0x61=IDEIRQ / 0x62=USBIRQ is definitely correct for the 5595/85C503 rev 01
> - according to the data sheet and playing with setpci ;-)
>
> > But this is not the case since the machine issue 0x60..0x63 for the four
> > OHCI devices. Now USB is working great with keyboard, mouse and drives. I
> > still have to say bye to the Broadcom 54g wireless interface though ...
>
> Looks like your chipset uses a different irq routing register layout. When
> the existing sis pci-irq routing stuff was added, the primary concern was
> to handle the ambigous link values (0x40-43 vs. 0x00-03) used by different
> BIOS's. The IDEIRQ case was merely added for documentation, it's unused.
>
> I think this might need some special treatment in pirq_sis_[sg]et(),
> either checking for the revision id or a different pci device id.

This made it for me, but it could break other configurations though :

--- pci-irq.c.orig	2003-05-18 12:34:03.000000000 -0700
+++ pci-irq.c	2003-05-18 12:35:14.000000000 -0700
@@ -306,14 +306,16 @@
 		case 0x42:
 		case 0x43:
 		case 0x44:
+		case 0x60:
+		case 0x61:
 		case 0x62:
+		case 0x63:
 			pci_read_config_byte(router, reg, &x);
-			if (reg != 0x62)
+			if (reg < 0x60)
 				break;
 			if (!(x & 0x40))
 				return 0;
 			break;
-		case 0x61:
 		case 0x6a:
 		case 0x7e:
 			printk(KERN_INFO "SiS pirq: advanced IDE/ACPI/DAQ mapping not yet implemented\n");
@@ -340,14 +342,16 @@
 		case 0x42:
 		case 0x43:
 		case 0x44:
+		case 0x60:
+		case 0x61:
 		case 0x62:
+		case 0x63:
 			x = (irq&0x0f) ? (irq&0x0f) : 0x80;
-			if (reg != 0x62)
+			if (reg < 0x60)
 				break;
 			/* always mark OHCI enabled, as nothing else knows about this */
 			x |= 0x40;
 			break;
-		case 0x61:
 		case 0x6a:
 		case 0x7e:
 			printk(KERN_INFO "advanced SiS pirq mapping not yet implemented\n");



> Btw, have you tried with acpi interrupt routing enabled?

Nope, since last time I checked ACPI was not in wonderful shape. I'll try
though to see if it fixes the thing or if it'll add more issues.



- Davide

