Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266678AbTAOQXd>; Wed, 15 Jan 2003 11:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266682AbTAOQXd>; Wed, 15 Jan 2003 11:23:33 -0500
Received: from adsl-173-18.barak.net.il ([62.90.173.18]:19328 "EHLO
	laptop.slamail.org") by vger.kernel.org with ESMTP
	id <S266678AbTAOQXb>; Wed, 15 Jan 2003 11:23:31 -0500
Message-ID: <3E258BBC.7010902@slamail.org>
Date: Wed, 15 Jan 2003 18:26:36 +0200
From: Yaacov Akiba Slama <ya@slamail.org>
Reply-To: Yaacov Akiba Slama <ya@slamail.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en, fr, he
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Mikael Pettersson <mikpe@csd.uu.se>,
       Jens Taprogge <taprogge@idg.rwth-aachen.de>, zwane@holomorphy.com,
       bvermeul@blackstar.nl
Subject: [PATCH] Re: [BUG] cardbus/hotplugging still broken in 2.5.56
References: <20030115081109.GA3839@valsheda.taprogge.wh> <15909.9796.157927.447889@harpo.it.uu.se>
In-Reply-To: <15909.9796.157927.447889@harpo.it.uu.se>
Content-Type: multipart/mixed;
 boundary="------------090801000808020102010903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090801000808020102010903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Can you test the enclosed patch. It seems to be both simple and to 
resolve the resource collisions and the "No IRQ known" problem.
I added a smal comment (and modified another) so future janitors won't 
move pci_enable above pci_assign_resource again.
If everyone is ok, I can send it to Linus for inclusion in BK (I have 
the green light of Dave Jones).

Thanks,
Yaacov Akiba Slama

Mikael Pettersson wrote:

>Jens Taprogge writes:
> > The cardbus problems are caused by 
> > 
> > ChangeSet@1.797.145.6  2002-11-25 18:31:10-08:00 davej@codemonkey.org.uk
> > 
> > as far as I can tell. 
> > 
> > pci_enable_device() will fail at least on i386 (see
> > arch/i386/pci/i386.c: pcibios_enable_resource (line 260)) if the
> > resources have not been assigned previously. Hence the ostensible
> > resource collisions.
> > 
> > The attached patch should fix the problem.
> > 
> > I have send the patch to Dave Jones some time ago but did not hear from
> > him yet.
> > 
> > I am not subscribed to the list so please cc me on replys. 
>
>Thanks. Your patch fixed the cardbus hotplug issue perfectly on my laptop.
>It survives multiple insert/eject cycles without any problems.
>
>The patch posted by Yaacov Akiba Slama today also fixed cardbus hotplug
>for me, but with his patch the kernel still prints "PCI: No IRQ known for
>interrupt pin A of device xx:xx.x. Please try using pci=biosirq" when the
>cardbus NIC is inserted; Jens Taprogge's patch silenced that warning.
>
>/Mikael
>
>  
>

--------------090801000808020102010903
Content-Type: text/plain;
 name="cardbus-rom.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cardbus-rom.patch"

--- drivers/pcmcia/cardbus.c.original	2003-01-14 19:38:49.000000000 +0200
+++ drivers/pcmcia/cardbus.c	2003-01-15 18:21:40.000000000 +0200
@@ -285,25 +285,29 @@
 		dev->dev.dma_mask = &dev->dma_mask;
 
 		pci_setup_device(dev);
-		if (pci_enable_device(dev))
-			continue;
 
 		strcpy(dev->dev.bus_id, dev->slot_name);
 
-		/* FIXME: Do we need to enable the expansion ROM? */
+		/* We need to assign resources for expansion ROM. */
 		for (r = 0; r < 7; r++) {
 			struct resource *res = dev->resource + r;
-			if (res->flags)
+			if (!res->start && res->end)
 				pci_assign_resource(dev, r);
 		}
 
 		/* Does this function have an interrupt at all? */
 		pci_readb(dev, PCI_INTERRUPT_PIN, &irq_pin);
-		if (irq_pin) {
+		if (irq_pin)
 			dev->irq = irq;
-			pci_writeb(dev, PCI_INTERRUPT_LINE, irq);
-		}
+		
+		/* pci_enable_device needs to be called after pci_assign_resource */
+		/* because it returns an error if (!res->start && res->end).      */
+		if (pci_enable_device(dev))
+			continue;
 
+		if (irq_pin)
+			pci_writeb(dev, PCI_INTERRUPT_LINE, irq);
+		
 		device_register(&dev->dev);
 		pci_insert_device(dev, bus);
 	}

--------------090801000808020102010903--

