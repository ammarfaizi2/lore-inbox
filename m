Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316223AbSHBQUH>; Fri, 2 Aug 2002 12:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316258AbSHBQUH>; Fri, 2 Aug 2002 12:20:07 -0400
Received: from NAT.office.mind.be ([62.166.230.82]:15493 "HELO
	portablue.intern.mind.be") by vger.kernel.org with SMTP
	id <S316223AbSHBQUF>; Fri, 2 Aug 2002 12:20:05 -0400
Date: Fri, 2 Aug 2002 18:23:26 +0200
To: jgarzik@mandrakesoft.com
Cc: linux-kernel@vger.kernel.org
Subject: patches for tulip driver
Message-ID: <20020802162326.GD23428@mind.be>
Mail-Followup-To: p2@mind.be, jgarzik@mandrakesoft.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="iVCmgExH7+hIHJ1A"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Answer: 42
X-Operating-system: Debian GNU/Linux
X-Message-Flag: Get yourself a real email client. http://www.mutt.org/
From: p2@mind.be (Peter 'p2' De Schrijver)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jeff,

I don't know if you received my previous mail, but I didn't see any
reply. That's why I'm resending my patches to the tulip driver. The
first patch makes this driver work on the Apple 100BaseTX card. The
second patch makes it work on MIPS boards and the NEC DDB5074 board.

Comments welcome,

Peter.
-- 

--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch.ans100basetx"

--- linux/drivers/net/tulip/tulip_core.c	Sun Jun 23 23:28:58 2002
+++ linux-2.4-benh/drivers/net/tulip/tulip_core.c	Sun Jun 23 23:23:31 2002
@@ -463,6 +463,18 @@
 	} else
 		tulip_select_media(dev, 1);
 
+	/* check for Apple 100BaseTX card and disable loops */
+
+	if ((dev->dev_addr[0] == 0x00) &&
+	    (dev->dev_addr[1] == 0x05) &&
+	    (dev->dev_addr[2] == 0x02) &&
+	    (tp->chip_id == DC21140)) {
+		outl(0x10f, ioaddr + CSR12);
+		iobarrier_rw();
+		outl(0x03, ioaddr + CSR12);
+		iobarrier_rw();
+	}
+
 	/* Start the chip's Tx to process setup frame. */
 	tulip_stop_rxtx(tp);
 	barrier();
--- linux/drivers/net/tulip/media.c	Mon Jun 17 15:20:00 2002
+++ linux-2.4-benh/drivers/net/tulip/media.c	Sat Jun 22 13:15:26 2002
@@ -389,9 +389,9 @@
 		if (tulip_media_cap[dev->if_port] & MediaIsMII) {
 			new_csr6 = 0x020E0000;
 		} else if (tulip_media_cap[dev->if_port] & MediaIsFx) {
-			new_csr6 = 0x028600000;
+			new_csr6 = 0x02860000;
 		} else
-			new_csr6 = 0x038600000;
+			new_csr6 = 0x03860000;
 		if (tulip_debug > 1)
 			printk(KERN_DEBUG "%s: No media description table, assuming "
 				   "%s transceiver, CSR12 %2.2x.\n",

--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-tulip-mips

diff -r -N -u -w oss-2.4/linux/drivers/net/tulip/interrupt.c oss-2.4-ddb5074/linux/drivers/net//tulip/interrupt.c
--- oss-2.4/linux/drivers/net/tulip/interrupt.c	Sun Dec  2 12:34:45 2001
+++ oss-2.4-ddb5074/linux/drivers/net//tulip/interrupt.c	Tue Jul  9 13:18:13 2002
@@ -186,6 +186,10 @@
 				       tp->rx_buffers[entry].skb->tail,
 				       pkt_len);
 #endif
+#if defined(__mips__)
+                dma_cache_inv((unsigned long)bus_to_virt(tp->rx_ring[entry].buffer1),pkt_len);
+#endif
+
 			} else { 	/* Pass up the skb already on the Rx ring. */
 				char *temp = skb_put(skb = tp->rx_buffers[entry].skb,
 						     pkt_len);
diff -r -N -u -w oss-2.4/linux/drivers/net/tulip/tulip_core.c oss-2.4-ddb5074/linux/drivers/net//tulip/tulip_core.c
--- oss-2.4/linux/drivers/net/tulip/tulip_core.c	Thu Jun 27 00:36:01 2002
+++ oss-2.4-ddb5074/linux/drivers/net//tulip/tulip_core.c	Tue Jul  9 13:31:04 2002
@@ -339,6 +339,11 @@
 		tp->tx_buffers[tp->cur_tx].skb = NULL;
 		tp->tx_buffers[tp->cur_tx].mapping = mapping;
 
+#if defined(__mips__)
+        dma_cache_wback_inv((unsigned long)tp->setup_frame,
+                            sizeof(tp->setup_frame));
+#endif
+
 		/* Put the setup frame on the Tx list. */
 		tp->tx_ring[tp->cur_tx].length = cpu_to_le32(0x08000000 | 192);
 		tp->tx_ring[tp->cur_tx].buffer1 = cpu_to_le32(mapping);
@@ -683,6 +688,11 @@
 					 PKT_BUF_SZ, PCI_DMA_FROMDEVICE);
 		tp->rx_buffers[i].mapping = mapping;
 		skb->dev = dev;			/* Mark as being used by this device. */
+#if defined(__mips__)
+        /* Kick out any matching lines in the cache. */
+        dma_cache_inv((unsigned long)skb->tail, PKT_BUF_SZ);
+#endif
+
 		tp->rx_ring[i].status = cpu_to_le32(DescOwned);	/* Owned by Tulip chip */
 		tp->rx_ring[i].buffer1 = cpu_to_le32(mapping);
 	}
@@ -736,6 +746,9 @@
 	/* if we were using Transmit Automatic Polling, we would need a
 	 * wmb() here. */
 	tp->tx_ring[entry].status = cpu_to_le32(DescOwned);
+#if defined(__mips__)
+	dma_cache_wback_inv((unsigned long)skb->data, skb->len);
+#endif
 	wmb();
 
 	tp->cur_tx++;
@@ -1568,6 +1581,15 @@
                        tp->flags &= ~HAS_MEDIA_TABLE;
                }
 #endif
+#ifdef CONFIG_DDB5074
+               if ((pdev->bus->number == 0) && (PCI_SLOT(pdev->devfn) == 1)) {
+                       /* DDB5477 MAC address in first EEPROM locations. */
+                       sa_offset = 0;
+					   /* No media table either */
+					   tp->flags &= ~HAS_MEDIA_TABLE;
+				}
+#endif
+
 #ifdef CONFIG_MIPS_COBALT
                if ((pdev->bus->number == 0) && 
                    ((PCI_SLOT(pdev->devfn) == 7) ||

--iVCmgExH7+hIHJ1A--
