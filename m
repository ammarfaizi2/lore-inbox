Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbTDVMdt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 08:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbTDVMdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 08:33:49 -0400
Received: from hera.cwi.nl ([192.16.191.8]:51399 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262657AbTDVMdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 08:33:47 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 22 Apr 2003 14:45:51 +0200 (MEST)
Message-Id: <UTC200304221245.h3MCjp122735.aeb@smtp.cwi.nl>
To: jgarzik@pobox.com
Subject: boot messages
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comparing my net sources with the vanilla sources showed
a series of differences of which I sent most to you
a moment ago. We still have one point of discussion.

>> I suppose these can be removed altogether.
>> For now #if 0 ... #endif.

> would it not be preferable to mark these as KERN_DEBUG instead?

I don't think so, but am willing to be convinced by Alan
in the case of lba48 messages. In the other cases these
messages just have to go.

Boot messages must tell us what hardware is detected.
We must not have debugging messages stating how
much memory is allocated for slab cache or so.
One can ask /proc after booting, and unless there are
serious bugs in the code such things do not affect booting.

When disk hardware is detected, I want to see manufacturer,
model, serial number and capacity.
When ethernet hardware is detected, I want to see manufacturer,
model and MAC address. (Possibly also IRQ and ioport.)

You never reacted, so I keep saying this until you either
take this patch or explain why in case of this particular driver
it is a bad idea to reveal the MAC address in the boot messages.

[I have also more general patches making sure that the MAC address
is printed in a uniform way by all drivers, but that comes later.]

Some more or less unrelated stuff below the patch.

Andries

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/net/3c59x.c b/drivers/net/3c59x.c
--- a/drivers/net/3c59x.c	Sun Apr 20 12:59:32 2003
+++ b/drivers/net/3c59x.c	Sun Apr 20 19:07:00 2003
@@ -1456,15 +1456,20 @@
  		acpi_set_WOL(dev);
 	}
 	retval = register_netdev(dev);
-	if (retval == 0)
+	if (retval == 0) {
+		int i;
+		printk("%s: 3c59x, address", dev->name);
+		for (i = 0; i < 6; i++)
+			printk("%c%2.2x", i ? ':' : ' ', dev->dev_addr[i]);
+		printk("\n");
 		return 0;
+	}
 
 free_ring:
 	pci_free_consistent(pdev,
-						sizeof(struct boom_rx_desc) * RX_RING_SIZE
-							+ sizeof(struct boom_tx_desc) * TX_RING_SIZE,
-						vp->rx_ring,
-						vp->rx_ring_dma);
+			    sizeof(struct boom_rx_desc) * RX_RING_SIZE
+			    + sizeof(struct boom_tx_desc) * TX_RING_SIZE,
+			    vp->rx_ring, vp->rx_ring_dma);
 free_region:
 	if (vp->must_free_region)
 		release_region(ioaddr, vci->io_size);


A separate discussion:
Ethernet cards are numbered differently by different kernels.
A bit annoying, and I have tried to fix this a few times,
but probably one just should accept it.
The previous time this came up people answered and said:
use "nameif". OK. So I do, and I explained some SuSE people
my setup - perhaps they will try to make it standard.
But things are really kludgy.
With built-in ethernet cards I cannot use nameif to reshuffle
numbers. The only thing that works is to use entirely fresh
numbers. So if different kernels detect eth0 .. eth3 in
different orders then I can have "nameif eth4 $ADDR0" etc
in a boot script, and use eth4 .. eth7.
I don't know whether this was intended, or should be regarded a bug.
