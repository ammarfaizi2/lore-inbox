Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbUDWAFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUDWAFt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 20:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbUDWAFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 20:05:48 -0400
Received: from smtp07.auna.com ([62.81.186.17]:12672 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S261181AbUDWAFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 20:05:46 -0400
Message-ID: <40885DCE.1090903@latinsud.com>
Date: Fri, 23 Apr 2004 02:05:34 +0200
From: "SuD (Alex)" <sud@latinsud.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fealnx. Mac address and other issues
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently was given a surecom 10/100 ethernet card and found that i 
could not change Mac address for it as other driver/devices allow.
I tried to implement the missing feature and noticed that the device is 
quite peculiar (or either my system is broken), when trying to fill mac 
address registers (no matter whether io_ops is set):
- If I write a byte (writeb) to an even i/o address it seems like 
actually a word was written (the next byte is set to 0).
- If I write a byte to an odd i/o address my pc gets bad freezed.

That made think of writing 16bit words (writew) for the memory address, 
as opposed to what most driver examples do. It works for me (I hope i 
set the lines at the right place in device_open function after the 
device is reset). I hope the code is clean enough and does not mess with 
byte ordering. This is the patch (this time against 2.6.5):


--- linux-2.6.5.orig/drivers/net/fealnx.c       2004-04-09 
05:04:20.000000000 +0200
+++ linux/drivers/net/fealnx.c  2004-04-23 01:47:38.000000000 +0200
@@ -882,12 +882,17 @@
 {
        struct netdev_private *np = dev->priv;
        long ioaddr = dev->base_addr;
-
+       int i;
+
        writel(0x00000001, ioaddr + BCR);       /* Reset */

        if (request_irq(dev->irq, &intr_handler, SA_SHIRQ, dev->name, dev))
                return -EAGAIN;

+       for (i = 0; i < 3; i++) {
+               writew(((unsigned short*)dev->dev_addr)[i], ioaddr + 
PAR0 + i*2);
+       }
+
        init_ring(dev);

        writel(np->rx_ring_dma, ioaddr + RXLBA);


----
By the way, i get some Watchdog Timeouts while transmitting every 10 
minutes or so (also with 2.4 and original drivers).
This is what i get:
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 00000000, resetting...
 Rx ring cf674000:  80000000 80000000 80000000 80000000 80000000 
80000000 80000000 80000000 80000000 80000000 80000000 80000000
 Tx ring cf675000:  80000000 80000000 80000000 80000000 80000000 0000

I have also recently experienced problems with my cablemodem Motorola 
SB5100e. It has registered this mac address:
    D4:62:00:02:44:1F
which does not exist but is a mixture of my surecom card (fealnx) 
00:02:44:1F:5F:59 and the network gateway 00:05:00:E2:D4:62.
I am not sure who's fault this is (i would not trust my cablemodem much 
anyway).

Thank you for reading.
