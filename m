Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313167AbSDDNyi>; Thu, 4 Apr 2002 08:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313168AbSDDNy3>; Thu, 4 Apr 2002 08:54:29 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:1704 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S313167AbSDDNyR>; Thu, 4 Apr 2002 08:54:17 -0500
Date: Thu, 4 Apr 2002 15:54:12 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: jgarzik@mandrakesoft.com, p_gortmaker@yahoo.com
Subject: [PATCH 2.5.8-pre1] pcnet_cs compile fixes
Message-ID: <20020404135411.GF9820@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	jgarzik@mandrakesoft.com, p_gortmaker@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes pcnet_cs compile again (removal of dev->rmem_start
and dev->rmem_end).

It compiles and works for me as intended, but maybe there is a cleaner
fix by someone who understands better the netdevice internals...


===== drivers/net/pcmcia/pcnet_cs.c 1.7 vs edited =====
--- 1.7/drivers/net/pcmcia/pcnet_cs.c	Tue Feb  5 08:55:16 2002
+++ edited/drivers/net/pcmcia/pcnet_cs.c	Thu Apr  4 11:27:47 2002
@@ -1460,7 +1460,8 @@
 			       struct e8390_pkt_hdr *hdr,
 			       int ring_page)
 {
-    void *xfer_start = (void *)(dev->rmem_start + (ring_page << 8)
+    void *xfer_start = (void *)(dev->mem_start + (TX_PAGES<<8) 
+		    		+ (ring_page << 8) 
 				- (ei_status.rx_start_page << 8));
     
     copyin((void *)hdr, xfer_start, sizeof(struct e8390_pkt_hdr));
@@ -1473,17 +1474,18 @@
 static void shmem_block_input(struct net_device *dev, int count,
 			      struct sk_buff *skb, int ring_offset)
 {
-    void *xfer_start = (void *)(dev->rmem_start + ring_offset
+    void *xfer_start = (void *)(dev->mem_start + (TX_PAGES<<8) 
+		    		+ ring_offset 
 				- (ei_status.rx_start_page << 8));
     char *buf = skb->data;
     
-    if (xfer_start + count > (void *)dev->rmem_end) {
+    if (xfer_start + count > (void *)dev->mem_end) {
 	/* We must wrap the input move. */
-	int semi_count = (void*)dev->rmem_end - xfer_start;
+	int semi_count = (void*)dev->mem_end - xfer_start;
 	copyin(buf, xfer_start, semi_count);
 	buf += semi_count;
 	ring_offset = ei_status.rx_start_page << 8;
-	xfer_start = (void *)dev->rmem_start;
+	xfer_start = (void *)dev->mem_start + (TX_PAGES<<8);
 	count -= semi_count;
     }
     copyin(buf, xfer_start, count);
@@ -1548,8 +1550,7 @@
     }
     
     dev->mem_start = (u_long)info->base + offset;
-    dev->rmem_start = dev->mem_start + (TX_PAGES<<8);
-    dev->mem_end = dev->rmem_end = (u_long)info->base + req.Size;
+    dev->mem_end = (u_long)info->base + req.Size;
 
     ei_status.tx_start_page = start_pg;
     ei_status.rx_start_page = start_pg + TX_PAGES;
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
