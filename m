Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965228AbVKPDw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965228AbVKPDw3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 22:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965225AbVKPDw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 22:52:26 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:29598 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965228AbVKPDur
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 22:50:47 -0500
To: torvalds@osdl.org
Subject: [PATCH 6/8] isaectomy: hp100
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Message-Id: <E1EcEJr-0007eA-98@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 16 Nov 2005 03:50:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1132110592 -0500

hp100 has ->mem_ptr_virt set for all memory-mapped cases; removed
rudiment of old version that used ioremap() only when physical
address wasn't an ISA one.  These days it's simply a dead code.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 drivers/net/hp100.c |   30 ++++++++----------------------
 1 files changed, 8 insertions(+), 22 deletions(-)

c9a2c709fa782a0dd7b1bbb0160b325e446ae523
diff --git a/drivers/net/hp100.c b/drivers/net/hp100.c
--- a/drivers/net/hp100.c
+++ b/drivers/net/hp100.c
@@ -1718,17 +1718,10 @@ static int hp100_start_xmit(struct sk_bu
 	hp100_outw(i, FRAGMENT_LEN);	/* and first/only fragment length    */
 
 	if (lp->mode == 2) {	/* memory mapped */
-		if (lp->mem_ptr_virt) {	/* high pci memory was remapped */
-			/* Note: The J2585B needs alignment to 32bits here!  */
-			memcpy_toio(lp->mem_ptr_virt, skb->data, (skb->len + 3) & ~3);
-			if (!ok_flag)
-				memset_io(lp->mem_ptr_virt, 0, HP100_MIN_PACKET_SIZE - skb->len);
-		} else {
-			/* Note: The J2585B needs alignment to 32bits here!  */
-			isa_memcpy_toio(lp->mem_ptr_phys, skb->data, (skb->len + 3) & ~3);
-			if (!ok_flag)
-				isa_memset_io(lp->mem_ptr_phys, 0, HP100_MIN_PACKET_SIZE - skb->len);
-		}
+		/* Note: The J2585B needs alignment to 32bits here!  */
+		memcpy_toio(lp->mem_ptr_virt, skb->data, (skb->len + 3) & ~3);
+		if (!ok_flag)
+			memset_io(lp->mem_ptr_virt, 0, HP100_MIN_PACKET_SIZE - skb->len);
 	} else {		/* programmed i/o */
 		outsl(ioaddr + HP100_REG_DATA32, skb->data,
 		      (skb->len + 3) >> 2);
@@ -1798,10 +1791,7 @@ static void hp100_rx(struct net_device *
 		/* First we get the header, which contains information about the */
 		/* actual length of the received packet. */
 		if (lp->mode == 2) {	/* memory mapped mode */
-			if (lp->mem_ptr_virt)	/* if memory was remapped */
-				header = readl(lp->mem_ptr_virt);
-			else
-				header = isa_readl(lp->mem_ptr_phys);
+			header = readl(lp->mem_ptr_virt);
 		} else		/* programmed i/o */
 			header = hp100_inl(DATA32);
 
@@ -1833,13 +1823,9 @@ static void hp100_rx(struct net_device *
 			ptr = skb->data;
 
 			/* Now transfer the data from the card into that area */
-			if (lp->mode == 2) {
-				if (lp->mem_ptr_virt)
-					memcpy_fromio(ptr, lp->mem_ptr_virt,pkt_len);
-				/* Note alignment to 32bit transfers */
-				else
-					isa_memcpy_fromio(ptr, lp->mem_ptr_phys, pkt_len);
-			} else	/* io mapped */
+			if (lp->mode == 2)
+				memcpy_fromio(ptr, lp->mem_ptr_virt,pkt_len);
+			else	/* io mapped */
 				insl(ioaddr + HP100_REG_DATA32, ptr, pkt_len >> 2);
 
 			skb->protocol = eth_type_trans(skb, dev);

