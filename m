Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273254AbRINCAw>; Thu, 13 Sep 2001 22:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273255AbRINCAo>; Thu, 13 Sep 2001 22:00:44 -0400
Received: from mailhost.nmt.edu ([129.138.4.52]:29964 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S273254AbRINCAb>;
	Thu, 13 Sep 2001 22:00:31 -0400
Date: Thu, 13 Sep 2001 19:51:41 -0600
From: Val Henson <val@nmt.edu>
To: jgarzik@mandrakesoft.com, becker@scyld.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Endian-ness bugs in yellowfin.c
Message-ID: <20010913195141.B799@boardwalk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch applies to the 2.4.10-pre8 yellowfin driver.  What it does:

* Fixes three bugs on big-endian architecture
* Changes flags to support at least one SYM53C885E card
* Replaces ncr885e driver with yellowfin

I ran into a couple of design decisions people won't like:

This driver is both a 1000 Mbit driver and 100 Mbit driver.  My
solution was to list the driver once under each category with the
appropriate name.

The flag IsGigabit seems misnamed, since it doesn't seem to control
anything related to gigabit-ness.  I turned it on for the SYMBIOS card
since, at least on my card, it uses the correct code.

#ifdef __powerpc__ probably should be changed to some form of #ifdef
BIG_ENDIAN but I didn't include that in this patch.

And finally, I'd like to remove ncr885e.c entirely since it's
redundant and extremely buggy.  Any objections?

-VAL

diff -Nru a/Documentation/Configure.help b/Documentation/Configure.help
--- a/Documentation/Configure.help	Thu Sep 13 19:20:29 2001
+++ b/Documentation/Configure.help	Thu Sep 13 19:20:29 2001
@@ -8824,10 +8824,10 @@
 Packet Engines Yellowfin Gigabit-NIC support
 CONFIG_YELLOWFIN
   Say Y here if you have a Packet Engines G-NIC PCI Gigabit Ethernet
-  adapter. This adapter is used by the Beowulf Linux cluster project.
-  See http://cesdis.gsfc.nasa.gov/linux/drivers/yellowfin.html for
-  more information about this driver in particular and Beowulf in
-  general.
+  adapter or the SYM53C885 Ethernet controller. The Gigabit adapter is
+  used by the Beowulf Linux cluster project.  See
+  http://cesdis.gsfc.nasa.gov/linux/drivers/yellowfin.html for more
+  information about this driver in particular and Beowulf in general.
 
   If you want to compile this driver as a module ( = code which can be
   inserted in and removed from the running kernel whenever you want),
diff -Nru a/drivers/net/Config.in b/drivers/net/Config.in
--- a/drivers/net/Config.in	Thu Sep 13 19:20:29 2001
+++ b/drivers/net/Config.in	Thu Sep 13 19:20:29 2001
@@ -39,7 +39,7 @@
       fi
       dep_tristate '  BMAC (G3 ethernet) support' CONFIG_BMAC $CONFIG_ALL_PPC
       dep_tristate '  GMAC (G4/iBook ethernet) support' CONFIG_GMAC $CONFIG_ALL_PPC
-      tristate '  Symbios 53c885 (Synergy ethernet) support' CONFIG_NCR885E
+      tristate '  Symbios 53c885 (Synergy ethernet) support' CONFIG_YELLOWFIN
       tristate '  National DP83902AV (Oak ethernet) support' CONFIG_OAKNET
       dep_bool '  PowerPC 405 on-chip ethernet' CONFIG_PPC405_ENET $CONFIG_405GP
       if [ "$CONFIG_PPC405_ENET" = "y" ]; then
diff -Nru a/drivers/net/yellowfin.c b/drivers/net/yellowfin.c
--- a/drivers/net/yellowfin.c	Thu Sep 13 19:20:29 2001
+++ b/drivers/net/yellowfin.c	Thu Sep 13 19:20:29 2001
@@ -276,7 +276,7 @@
 	 PCI_IOTYPE, YELLOWFIN_SIZE,
 	 FullTxStatus | IsGigabit | HasMulticastBug | HasMACAddrBug},
 	{"Symbios SYM83C885", { 0x07011000, 0xffffffff},
-	 PCI_IOTYPE, YELLOWFIN_SIZE, HasMII },
+	 PCI_IOTYPE, YELLOWFIN_SIZE, HasMII | IsGigabit | FullTxStatus },
 	{0,},
 };
 
@@ -785,8 +785,8 @@
 			break;
 		skb->dev = dev;		/* Mark as being used by this device. */
 		skb_reserve(skb, 2);	/* 16 byte align the IP header. */
-		yp->rx_ring[i].addr = pci_map_single(yp->pci_dev, skb->tail,
-			yp->rx_buf_sz, PCI_DMA_FROMDEVICE);
+		yp->rx_ring[i].addr = cpu_to_le32(pci_map_single(yp->pci_dev,
+			skb->tail, yp->rx_buf_sz, PCI_DMA_FROMDEVICE));
 	}
 	yp->rx_ring[i-1].dbdma_cmd = cpu_to_le32(CMD_STOP);
 	yp->dirty_rx = (unsigned int)(i - RX_RING_SIZE);
@@ -1109,7 +1109,7 @@
 		buf_addr = rx_skb->tail;
 		data_size = (le32_to_cpu(desc->dbdma_cmd) - 
 			le32_to_cpu(desc->result_status)) & 0xffff;
-		frame_status = get_unaligned((s16*)&(buf_addr[data_size - 2]));
+		frame_status = le16_to_cpu(get_unaligned((s16*)&(buf_addr[data_size - 2])));
 		if (yellowfin_debug > 4)
 			printk(KERN_DEBUG "  yellowfin_rx() status was %4.4x.\n",
 				   frame_status);
@@ -1206,8 +1206,8 @@
 			yp->rx_skbuff[entry] = skb;
 			skb->dev = dev;	/* Mark as being used by this device. */
 			skb_reserve(skb, 2);	/* Align IP on 16 byte boundaries */
-			yp->rx_ring[entry].addr = pci_map_single(yp->pci_dev,
-				skb->tail, yp->rx_buf_sz, PCI_DMA_FROMDEVICE);
+			yp->rx_ring[entry].addr = cpu_to_le32(pci_map_single(yp->pci_dev,
+				skb->tail, yp->rx_buf_sz, PCI_DMA_FROMDEVICE));
 		}
 		yp->rx_ring[entry].dbdma_cmd = cpu_to_le32(CMD_STOP);
 		yp->rx_ring[entry].result_status = 0;	/* Clear complete bit. */
