Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280002AbRKDOOd>; Sun, 4 Nov 2001 09:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280000AbRKDOOY>; Sun, 4 Nov 2001 09:14:24 -0500
Received: from colorfullife.com ([216.156.138.34]:31758 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S279999AbRKDOOM>;
	Sun, 4 Nov 2001 09:14:12 -0500
Message-ID: <3BE54D24.A4F4848D@colorfullife.com>
Date: Sun, 04 Nov 2001 15:13:56 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.14-pre7 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Tom Winkler <tiger@tserver.2y.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Vaio IRQ routing / USB problem
In-Reply-To: <3BE5201F.78A6B811@colorfullife.com> <008e01c16531$87ee0350$0200a8c0@piii450>
Content-Type: multipart/mixed;
 boundary="------------80DA9F316B2C68C8FA27AA36"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------80DA9F316B2C68C8FA27AA36
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

[cc to linux-kernel added]

Tom Winkler wrote:
> 
> usb-uhci.c: High bandwidth mode enabled
> IRQ for 00:1f.2:3 -> PIRQ 63, mask 0200, excl 0000 -> newirq=9 -> got IRQ
> 10
> PCI: Found IRQ 10 for device 00:1f.2
> IRQ routing conflict for 00:1f.2, have irq 9, want irq 10
> PCI: Setting latency timer of device 00:1f.2 to 64

That's interesting. It's obivously a bios bug:
The USB controller only supports interrupt 9 (mask==0x200 -->bit 9), is
right now running on irq 9 according to the bios data.
But according to the piix irq router, it's connected to irq 10.

First we must figure out where the bios lies. Could you try the attached
patches?
The patches are alternatives, first try option 1, then option 2.


--
--------------80DA9F316B2C68C8FA27AA36
Content-Type: text/plain; charset=us-ascii;
 name="patch-vaio-option-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-vaio-option-1"

--- 2.4/arch/i386/kernel/pci-irq.c	Sat Nov  3 19:51:08 2001
+++ build-2.4/arch/i386/kernel/pci-irq.c	Sun Nov  4 14:48:58 2001
@@ -626,7 +626,7 @@
 			continue;
 		if (info->irq[pin].link == pirq) {
 			/* We refuse to override the dev->irq information. Give a warning! */
-		    	if (dev2->irq && dev2->irq != irq) {
+		    	if (dev2->irq && dev2->irq != irq && 0) {
 		    		printk(KERN_INFO "IRQ routing conflict for %s, have irq %d, want irq %d\n",
 				       dev2->slot_name, dev2->irq, irq);
 		    		continue;



--------------80DA9F316B2C68C8FA27AA36
Content-Type: text/plain; charset=us-ascii;
 name="patch-vaio-option-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-vaio-option-2"

--- 2.4/arch/i386/kernel/pci-irq.c	Sat Nov  3 19:51:08 2001
+++ build-2.4/arch/i386/kernel/pci-irq.c	Sun Nov  4 15:09:40 2001
@@ -629,6 +629,18 @@
 		    	if (dev2->irq && dev2->irq != irq) {
 		    		printk(KERN_INFO "IRQ routing conflict for %s, have irq %d, want irq %d\n",
 				       dev2->slot_name, dev2->irq, irq);
+				if (!strcmp(msg, "Found")) {
+					/* ok, the bios lied. Try to recover */
+					if (r->set && (dev->class >> 8) != PCI_CLASS_DISPLAY_VGA) {
+						printk(KERN_ERR "trying set.\n");
+						if (r->set(pirq_router_dev, dev2, pirq, dev2->irq)) {
+							printk(KERN_ERR "set succedded.\n");
+							eisa_set_level_irq(dev2->irq);
+						} else {
+							printk(KERN_ERR "set failed.\n");
+						}
+					}
+				}
 		    		continue;
 		    	}
 			dev2->irq = irq;


--------------80DA9F316B2C68C8FA27AA36--


