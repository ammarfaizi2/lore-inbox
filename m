Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268568AbUILJeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268568AbUILJeP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 05:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268650AbUILJeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 05:34:15 -0400
Received: from [211.58.254.17] ([211.58.254.17]:7149 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S268568AbUILJdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 05:33:05 -0400
Date: Sun, 12 Sep 2004 18:33:02 +0900
To: linux-kernel@vger.kernel.org
Subject: [PATCH] via-velocity fixes
Message-ID: <20040912093301.GC13359@home-tj.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="JgQwtEuHJzHdouWu"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: Tejun Heo <tj@home-tj.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

 Hello,

 First of all, many thanks for the driver.  I've encountered problems
with recent updates to the driver and fixed them and some others.  I'm
also interested in improving this driver, and having the programming
manual would be very helpful.  Does anybody know how to obtain the
programming manual for this chip?  Is it available online somewhere?
Or should I contact VIA?

 Thanks.

----------------------
 Recent receive ring related updates to via-velocity broke the driver.
My box lost packets, recevied duplicate truncated packets and soon
locked into infinite error interrupt handling.  This patch fixes
receive ring handling and some other parts of the driver.  List of
fixes follow.

Using cpu_to_le32 on OWNED_BY_NIC is wrong.  It will produce
0x10000000 on big endian machines while owner bitfield would still
evaluate to 0 or 1.

In velocity_give_rx_desc(), there should be a wmb() between resetting
the first four bytes of rdesc0 and setting owner.  As resetting the
first four bytes isn't necessary, I just removed the function and
directly set owner.

In velocity_init_registers(), init_cam_filter() clears mCAMmask
which might have been set by set_multy() (not sure if this can ever
occur).  Modified to invoke init_cam_filter() first.  Also,
clear_isr() is called twice.  Removed the first invocation.

velocity_nics wasn't managed properly, fixed.

Removed unused velocity_info.xmit_lock.

In velocity_give_many_rx_descs(), index calculation was incorrect.
This and bugs in velocity_rx_srv() described in the following
paragraph caused packet loss, truncation and infinite error
interrupt generation.  Fixed.

In velocity_rx_srv(), velocity_rx_refill() could be called without
any dirty slot.  With proper timing, This can result in refilling
yet unreceived packets and pushing dirty pointer ahead of the current
pointer.  Also, vptr->rd_curr which is used by velocity_rx_refill()
was updated after calling velocity_rx_refill() thus screwing
receive descriptor ring.  Fixed.

Other obivous fixes.

-- 
tejun


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="velocity.patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/12 18:01:40+09:00 tj@htj.dyndns.org 
#   via-velocity fixes.  This should remove packet loss, truncated
#   duplicate packets and infinite error interrupt generation.
# 
# drivers/net/via-velocity.h
#   2004/09/12 18:01:35+09:00 tj@htj.dyndns.org +3 -4
#   Fixed comments
#   
#   velocity_info.xmit_lock is never used, removed.
# 
# drivers/net/via-velocity.c
#   2004/09/12 18:01:35+09:00 tj@htj.dyndns.org +30 -30
#   Fixed comments
#   
#   Using cpu_to_le32 on OWNED_BY_NIC is wrong.  It will produce
#   0x10000000 on big endian machines while owner bitfield would still
#   evaluate to 0 or 1.
#   
#   In velocity_give_rx_desc(), there should be a wmb() between resetting
#   the first four bytes of rdesc0 and setting owner.  As resetting the
#   first four bytes isn't necessary, I just removed the function and
#   directly set owner.
#   
#   In velocity_init_registers(), init_cam_filter() clears mCAMmask
#   which might have been set by set_multy() (not sure if this can ever
#   occur).  Modified to invoke init_cam_filter() first.  Also,
#   clear_isr() is called twice.  Removed the first invocation.
#   
#   velocity_nics wasn't managed properly, fixed.
#   
#   Removed unused velocity_info.xmit_lock.
#   
#   In velocity_give_many_rx_descs(), index calculation was incorrect.
#   This and bugs in velocity_rx_srv() described in the following
#   paragraph caused packet loss, truncation and infinite error
#   interrupt generation.  Fixed.
#   
#   In velocity_rx_srv(), velocity_rx_refill() could be called without
#   any dirty slot.  With proper timing, This can result in refilling
#   yet unreceived packets and pushing dirty pointer ahead of the current
#   pointer.  Also, vptr->rd_curr which is used by velocity_rx_refill()
#   was updated after calling velocity_rx_refill() thus screwing
#   receive descriptor ring.  Fixed.
#   
#   Other obivous fixes.
# 
diff -Nru a/drivers/net/via-velocity.c b/drivers/net/via-velocity.c
--- a/drivers/net/via-velocity.c	2004-09-12 18:05:28 +09:00
+++ b/drivers/net/via-velocity.c	2004-09-12 18:05:28 +09:00
@@ -359,6 +359,8 @@
 	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
 	free_netdev(dev);
+
+	velocity_nics--;
 }
 
 /**
@@ -462,7 +464,7 @@
 {
 	struct mac_regs * regs = vptr->mac_regs;
 
-	/* T urn on MCFG_PQEN, turn off MCFG_RTGOPT */
+	/* Turn on MCFG_PQEN, turn off MCFG_RTGOPT */
 	WORD_REG_BITS_SET(MCFG_PQEN, MCFG_RTGOPT, &regs->MCFG);
 	WORD_REG_BITS_ON(MCFG_VIDFR, &regs->MCFG);
 
@@ -490,12 +492,6 @@
 	}
 }
 
-static inline void velocity_give_rx_desc(struct rx_desc *rd)
-{
-	*(u32 *)&rd->rdesc0 = 0;
-	rd->rdesc0.owner = cpu_to_le32(OWNED_BY_NIC);
-}
-
 /**
  *	velocity_rx_reset	-	handle a receive reset
  *	@vptr: velocity we are resetting
@@ -516,7 +512,7 @@
 	 *	Init state, all RD entries belong to the NIC
 	 */
 	for (i = 0; i < vptr->options.numrx; ++i)
-		velocity_give_rx_desc(vptr->rd_ring + i);
+		vptr->rd_ring[i].rdesc0.owner = OWNED_BY_NIC;
 
 	writew(vptr->options.numrx, &regs->RBRDU);
 	writel(vptr->rd_pool_dma, &regs->RDBaseLo);
@@ -591,11 +587,16 @@
 
 		writeb(WOLCFG_SAM | WOLCFG_SAB, &regs->WOLCFGSet);
 		/*
-		 *	Bback off algorithm use original IEEE standard
+		 *	back off algorithm use original IEEE standard
 		 */
 		BYTE_REG_BITS_SET(CFGB_OFSET, (CFGB_CRANDOM | CFGB_CAP | CFGB_MBA | CFGB_BAKOPT), &regs->CFGB);
 
 		/*
+		 *	Init CAM filter
+		 */
+		velocity_init_cam_filter(vptr);
+
+		/*
 		 *	Set packet filter: Receive directed and broadcast address
 		 */
 		velocity_set_multi(vptr->dev);
@@ -619,8 +620,6 @@
 			mac_tx_queue_run(regs, i);
 		}
 
-		velocity_init_cam_filter(vptr);
-
 		init_flow_control_register(vptr);
 
 		writel(CR0_STOP, &regs->CR0Clr);
@@ -628,7 +627,6 @@
 
 		mii_status = velocity_get_opt_media_mode(vptr);
 		netif_stop_queue(vptr->dev);
-		mac_clear_isr(regs);
 
 		mii_init(vptr, mii_status);
 
@@ -695,7 +693,7 @@
 	struct mac_regs * regs;
 	int ret = -ENOMEM;
 
-	if (velocity_nics++ >= MAX_UNITS) {
+	if (velocity_nics >= MAX_UNITS) {
 		printk(KERN_NOTICE VELOCITY_NAME ": already found %d NICs.\n", 
 				velocity_nics);
 		return -ENODEV;
@@ -727,7 +725,6 @@
 
 	vptr->dev = dev;
 
-	dev->priv = vptr;
 	dev->irq = pdev->irq;
 
 	ret = pci_enable_device(pdev);
@@ -762,7 +759,7 @@
 		dev->dev_addr[i] = readb(&regs->PAR[i]);
 
 
-	velocity_get_options(&vptr->options, velocity_nics - 1, dev->name);
+	velocity_get_options(&vptr->options, velocity_nics, dev->name);
 
 	/* 
 	 *	Mask out the options cannot be set to the chip
@@ -817,6 +814,7 @@
 		spin_unlock_irqrestore(&velocity_dev_list_lock, flags);
 	}
 #endif
+	velocity_nics++;
 out:
 	return ret;
 
@@ -869,10 +867,7 @@
 	vptr->io_size = info->io_size;
 	vptr->num_txq = info->txqueue;
 	vptr->multicast_limit = MCAM_SIZE;
-
 	spin_lock_init(&vptr->lock);
-	spin_lock_init(&vptr->xmit_lock);
-
 	INIT_LIST_HEAD(&vptr->list);
 }
 
@@ -1024,11 +1019,11 @@
 
 	wmb();
 
-	unusable = vptr->rd_filled | 0x0003;
-	dirty = vptr->rd_dirty - unusable + 1;
+	unusable = vptr->rd_filled & 0x0003;
+	dirty = vptr->rd_dirty - unusable;
 	for (avail = vptr->rd_filled & 0xfffc; avail; avail--) {
 		dirty = (dirty > 0) ? dirty - 1 : vptr->options.numrx - 1;
-		velocity_give_rx_desc(vptr->rd_ring + dirty);
+		vptr->rd_ring[dirty].rdesc0.owner = OWNED_BY_NIC;
 	}
 
 	writew(vptr->rd_filled & 0xfffc, &regs->RBRDU);
@@ -1043,7 +1038,7 @@
 		struct rx_desc *rd = vptr->rd_ring + dirty;
 
 		/* Fine for an all zero Rx desc at init time as well */
-		if (rd->rdesc0.owner == cpu_to_le32(OWNED_BY_NIC))
+		if (rd->rdesc0.owner == OWNED_BY_NIC)
 			break;
 
 		if (!vptr->rd_info[dirty].skb) {
@@ -1096,7 +1091,7 @@
 }
 
 /**
- *	velocity_free_rd_ring	-	set up receive ring
+ *	velocity_free_rd_ring	-	free receive ring
  *	@vptr: velocity to clean up
  *
  *	Free the receive buffers for each ring slot and any
@@ -1161,8 +1156,10 @@
 		for (i = 0; i < vptr->options.numtx; i++, curr += sizeof(struct tx_desc)) {
 			td = &(vptr->td_rings[j][i]);
 			td_info = &(vptr->td_infos[j][i]);
-			td_info->buf = vptr->tx_bufs + (i + j) * PKT_BUF_SZ;
-			td_info->buf_dma = vptr->tx_bufs_dma + (i + j) * PKT_BUF_SZ;
+			td_info->buf = vptr->tx_bufs +
+				(j * vptr->options.numtx + i) * PKT_BUF_SZ;
+			td_info->buf_dma = vptr->tx_bufs_dma +
+				(j * vptr->options.numtx + i) * PKT_BUF_SZ;
 		}
 		vptr->td_tail[j] = vptr->td_curr[j] = vptr->td_used[j] = 0;
 	}
@@ -1238,15 +1235,17 @@
 	int rd_curr = vptr->rd_curr;
 	int works = 0;
 
-	while (1) {
+	do {
 		struct rx_desc *rd = vptr->rd_ring + rd_curr;
 
-		if (!vptr->rd_info[rd_curr].skb || (works++ > 15))
+		if (!vptr->rd_info[rd_curr].skb)
 			break;
 
 		if (rd->rdesc0.owner == OWNED_BY_NIC)
 			break;
 
+		rmb();
+
 		/*
 		 *	Don't drop CE or RL error frame although RXOK is off
 		 */
@@ -1269,14 +1268,15 @@
 		rd_curr++;
 		if (rd_curr >= vptr->options.numrx)
 			rd_curr = 0;
-	}
+	} while (++works <= 15);
+	
+	vptr->rd_curr = rd_curr;
 
-	if (velocity_rx_refill(vptr) < 0) {
+	if (works > 0 && velocity_rx_refill(vptr) < 0) {
 		VELOCITY_PRT(MSG_LEVEL_ERR, KERN_ERR
 			"%s: rx buf allocation failure\n", vptr->dev->name);
 	}
 
-	vptr->rd_curr = rd_curr;
 	VAR_USED(stats);
 	return works;
 }
diff -Nru a/drivers/net/via-velocity.h b/drivers/net/via-velocity.h
--- a/drivers/net/via-velocity.h	2004-09-12 18:05:28 +09:00
+++ b/drivers/net/via-velocity.h	2004-09-12 18:05:28 +09:00
@@ -1319,7 +1319,7 @@
 	/* disable CAMEN */
 	writeb(0, &regs->CAMADDR);
 
-	/* Select CAM mask */
+	/* Select mar */
 	BYTE_REG_BITS_SET(CAMCR_PS_MAR, CAMCR_PS1 | CAMCR_PS0, &regs->CAMCR);
 }
 
@@ -1360,7 +1360,7 @@
 
 	writeb(0, &regs->CAMADDR);
 
-	/* Select CAM mask */
+	/* Select mar */
 	BYTE_REG_BITS_SET(CAMCR_PS_MAR, CAMCR_PS1 | CAMCR_PS0, &regs->CAMCR);
 }
 
@@ -1401,7 +1401,7 @@
 
 	writeb(0, &regs->CAMADDR);
 
-	/* Select CAM mask */
+	/* Select mar */
 	BYTE_REG_BITS_SET(CAMCR_PS_MAR, CAMCR_PS1 | CAMCR_PS0, &regs->CAMCR);
 }
 
@@ -1792,7 +1792,6 @@
 	u8 mCAMmask[(MCAM_SIZE / 8)];
 
 	spinlock_t lock;
-	spinlock_t xmit_lock;
 
 	int wol_opts;
 	u8 wol_passwd[6];

--JgQwtEuHJzHdouWu--
