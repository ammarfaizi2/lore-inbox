Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUAHRkn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 12:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265820AbUAHRkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 12:40:43 -0500
Received: from speedy.tutby.com ([195.209.41.194]:33422 "EHLO tut.by")
	by vger.kernel.org with ESMTP id S265800AbUAHRjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 12:39:55 -0500
Date: Thu, 8 Jan 2004 19:39:20 +0200
From: X-Stranger <x@linux.by>
To: linux-kernel@vger.kernel.org
Subject: Kernel bug with BIOS
Message-Id: <20040108193920.12284fbb.x@linux.by>
Organization: Linux.by
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi to all!

I'm user of ALTLinux Sisyphus. I have kernel 2.4.22 installed on. And I have
PCMCIA Network Card installed on Acer TravelMate 723TXV. My friend gave me USB
Flash Disk (PQI Travelling Disk, 32Mb).

When I try to plug it, my system halts. Ok, then I unplug my PCMCIA NetCard and
reboots. Then I retry to plug it. And... my system don't see this FlashDisk! I
looking at "dmesg | more":

---------------------------------------------------------------------
hub.c: new USB device 00:04.2-1, assigned address 2
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=2 (error -110)
hub.c: new USB device 00:04.2-1, assigned address 3
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=3 (error -110)
---------------------------------------------------------------------


After I booting my system a new I see at "dmesg | more" again:

---------------------------------------------------------------------
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 22:00:15 Nov 29 2003
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 11 for device 00:04.2
IRQ routing conflict for 00:04.2, have irq 9, want irq 11
usb-uhci.c: USB UHCI at I/O 0xfce0, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
---------------------------------------------------------------------

 
I tryed to search info about this problem - there are many letter with this question
but no more answers in the Web. I find only one letter from <manfred@colorfullife.com>
to linux-kernel@vger.kernel.org, dated by Sun, 04 Nov 2001 15:13:56 +0100:


---------------------------------------------------------------------
<skipped>
That's interesting. It's obivously a bios bug:
The USB controller only supports interrupt 9 (mask==0x200 -->bit 9), is
right now running on irq 9 according to the bios data.
But according to the piix irq router, it's connected to irq 10.

First we must figure out where the bios lies. Could you try the attached
patches?
The patches are alternatives, first try option 1, then option 2.


--

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
---------------------------------------------------------------------

I tryed to use patch No 2 with kernel-2.4.21 and it really works: no conflicts, all works and Linux
work with Travelling Disk on my Acer TravelMate. But why this patch is not applied to kernel?
I think, this is not only my problem, but some peoples too.

X-Stranger,
http://Linux.by Administrator

P.S. Sorry, my English isn't well. ;))


