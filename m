Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263485AbRFFFez>; Wed, 6 Jun 2001 01:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263487AbRFFFep>; Wed, 6 Jun 2001 01:34:45 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:39438 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S263485AbRFFFed>; Wed, 6 Jun 2001 01:34:33 -0400
Date: Tue, 5 Jun 2001 22:34:05 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Proper perfect filter setup for xircom_tulip_cb.c
Message-ID: <Pine.LNX.4.33.0106052225290.22593-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

The reason some CardBus Xircom cards need to be put in promisc mode in 
order to receive packets is because the driver doesn't initialize the 
perfect filter correctly. Although it uses a single Tx descriptor to send 
the initialization data to the card, it doesn't set either of the 
first_segment or last_segment bits in the descriptor. No wonder the 
chipset gets confused...

The attached patch fixed this error by setting both bits, and it also gets
rid of the unnecessary special case for the Xircom -- the chip really does
have a 16-slot perfect filter, like the other tulip clones.

Please apply.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
----------------------
--- /src/vanilla/linux-2.4.5-ac9/drivers/net/pcmcia/xircom_tulip_cb.c	Sun Mar 25 18:24:31 2001
+++ linux-2.4/drivers/net/pcmcia/xircom_tulip_cb.c	Tue Jun  5 22:16:07 2001
@@ -1272,7 +1273,7 @@
 		*setup_frm++ = eaddrs[1]; *setup_frm++ = eaddrs[1];
 		*setup_frm++ = eaddrs[2]; *setup_frm++ = eaddrs[2];
 		/* Put the setup frame on the Tx list. */
-		tp->tx_ring[0].length = 0x08000000 | 192;
+		tp->tx_ring[0].length = 0x68000000 | 192;
 		tp->tx_ring[0].buffer1 = virt_to_bus(tp->setup_frame);
 		tp->tx_ring[0].status = DescOwned;
 
@@ -1291,7 +1292,7 @@
 		}
 
 		/* Put the setup frame on the Tx list. */
-		tp->tx_ring[tp->cur_tx].length = 0x08000000 | 192;
+		tp->tx_ring[tp->cur_tx].length = 0x68000000 | 192;
 		/* Lie about the address of our setup frame to make the */
 		/* chip happy */
 		tp->tx_ring[tp->cur_tx].buffer1 = virt_to_bus(tp->setup_frame);
@@ -2887,14 +2888,14 @@
 	} else {
 		u16 *eaddrs, *setup_frm = tp->setup_frame;
 		struct dev_mc_list *mclist;
-		u32 tx_flags = 0x08000000 | 192;
+		u32 tx_flags = 0x68000000 | 192;
 		int i;
 
 		/* Note that only the low-address shortword of setup_frame is valid!
 		   The values are doubled for big-endian architectures. */
-		if ((dev->mc_count > 14) || ((dev->mc_count > 6) && (tp->chip_id == X3201_3))) { /* Must use a multicast hash table. */
+		if (dev->mc_count > 14) { /* Must use a multicast hash table. */
 			u16 hash_table[32];
-			tx_flags = 0x08400000 | 192;		/* Use hash filter. */
+			tx_flags = 0x68400000 | 192;		/* Use hash filter. */
 			memset(hash_table, 0, sizeof(hash_table));
 			set_bit(255, hash_table); 			/* Broadcast entry */
 			/* This should work on big-endian machines as well. */
@@ -2907,7 +2908,7 @@
 				*setup_frm++ = hash_table[i];
 			}
 			setup_frm = &tp->setup_frame[13*6];
-		} else if(tp->chip_id != X3201_3) {
+		} else {
 			/* We have <= 14 addresses so we can use the wonderful
 			   16 address perfect filtering of the Tulip. */
 			for (i = 0, mclist = dev->mc_list; i < dev->mc_count;
@@ -2917,30 +2918,6 @@
 				*setup_frm++ = eaddrs[1]; *setup_frm++ = eaddrs[1];
 				*setup_frm++ = eaddrs[2]; *setup_frm++ = eaddrs[2];
 			}
-			/* Fill the unused entries with the broadcast address. */
-			memset(setup_frm, 0xff, (15-i)*12);
-			setup_frm = &tp->setup_frame[15*6];
-		} else {
-			/* fill the first two table entries with our address */
-			eaddrs = (u16 *)dev->dev_addr;
-			for(i=0; i<2; i++) {
-				*setup_frm++ = eaddrs[0]; *setup_frm++ = eaddrs[0];
-				*setup_frm++ = eaddrs[1]; *setup_frm++ = eaddrs[1];
-				*setup_frm++ = eaddrs[2]; *setup_frm++ = eaddrs[2];
-			}
-			/* Double fill each entry to accomodate chips that */
-			/* don't like to parse these correctly */
-			for (i=0, mclist=dev->mc_list; i<dev->mc_count;
-				 i++, mclist=mclist->next) {
-				eaddrs = (u16 *)mclist->dmi_addr;
-				*setup_frm++ = eaddrs[0]; *setup_frm++ = eaddrs[0];
-				*setup_frm++ = eaddrs[1]; *setup_frm++ = eaddrs[1];
-				*setup_frm++ = eaddrs[2]; *setup_frm++ = eaddrs[2];
-				*setup_frm++ = eaddrs[0]; *setup_frm++ = eaddrs[0];
-				*setup_frm++ = eaddrs[1]; *setup_frm++ = eaddrs[1];
-				*setup_frm++ = eaddrs[2]; *setup_frm++ = eaddrs[2];
-			}
-			i=((i+1)*2);
 			/* Fill the unused entries with the broadcast address. */
 			memset(setup_frm, 0xff, (15-i)*12);
 			setup_frm = &tp->setup_frame[15*6];

