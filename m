Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265093AbTAJOhS>; Fri, 10 Jan 2003 09:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbTAJOhS>; Fri, 10 Jan 2003 09:37:18 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:39556 "EHLO
	beast.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S265093AbTAJOhQ>; Fri, 10 Jan 2003 09:37:16 -0500
Date: Sat, 11 Jan 2003 00:52:34 +1000
From: David McCullough <davidm@snapgear.com>
To: linux-kernel@vger.kernel.org
Cc: becker@scyld.com, jgarzik@mandrakesoft.com
Subject: [PATCH] ne.c 8139too.c to fix CERT VU#412115, 2.4.20
Message-ID: <20030111005234.A4803@beast.internal.moreton.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

Here's a patch for the ne2000 driver (ne.c) and the RealTek driver
(8139too.c) in the 2.4.20 kernel to fix the CERT vulnerability VU#412115:

	http://www.kb.cert.org/vuls/id/412115

For interest,  the smc9194 and FEC ethernet drivers appear to be ok.
Please CC me on any replies,

Cheers,
Davidm

--- linux-2.4.20/drivers/net/ne.c.orig	Sat Aug  3 10:39:44 2002
+++ linux-2.4.20/drivers/net/ne.c	Sat Jan 11 00:29:36 2003
@@ -623,6 +623,7 @@
 		const unsigned char *buf, const int start_page)
 {
 	int nic_base = NE_BASE;
+	int pad_count = count >= ETH_ZLEN ? count : ETH_ZLEN;
 	unsigned long dma_start;
 #ifdef NE_SANITY_CHECK
 	int retries = 0;
@@ -669,16 +670,22 @@
 	outb_p(ENISR_RDC, nic_base + EN0_ISR);
 
 	/* Now the normal output. */
-	outb_p(count & 0xff, nic_base + EN0_RCNTLO);
-	outb_p(count >> 8,   nic_base + EN0_RCNTHI);
+	outb_p(pad_count & 0xff, nic_base + EN0_RCNTLO);
+	outb_p(pad_count >> 8,   nic_base + EN0_RCNTHI);
 	outb_p(0x00, nic_base + EN0_RSARLO);
 	outb_p(start_page, nic_base + EN0_RSARHI);
 
 	outb_p(E8390_RWRITE+E8390_START, nic_base + NE_CMD);
 	if (ei_status.word16) {
 		outsw(NE_BASE + NE_DATAPORT, buf, count>>1);
+		while (count < pad_count) {
+			outw_p(0x00, NE_BASE + NE_DATAPORT);
+			count += 2;
+		}
 	} else {
 		outsb(NE_BASE + NE_DATAPORT, buf, count);
+		while (count++ < pad_count)
+			outb_p(0x00, NE_BASE + NE_DATAPORT);
 	}
 
 	dma_start = jiffies;


--- linux-2.4.20/drivers/net/8139too.c.orig	Fri Nov 29 09:53:13 2002
+++ linux-2.4.20/drivers/net/8139too.c	Sat Jan 11 00:29:36 2003
@@ -1683,6 +1683,9 @@
 
 	if (likely(len < TX_BUF_SIZE)) {
 		skb_copy_and_csum_dev(skb, tp->tx_buf[entry]);
+		/* PAD the frame out with zeroes */
+		if (len < (unsigned int) ETH_ZLEN)
+			memset(tp->tx_buf[entry] + len, 0, ETH_ZLEN - len);
 		dev_kfree_skb(skb);
 	} else {
 		dev_kfree_skb(skb);

-- 
David McCullough:    Ph: +61 7 3435 2815  http://www.SnapGear.com
davidm@snapgear.com  Fx: +61 7 3891 3630  Custom Embedded Solutions + Security
