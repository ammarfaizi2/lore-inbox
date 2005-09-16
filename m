Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161111AbVIPHiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161111AbVIPHiY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 03:38:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161108AbVIPHiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 03:38:24 -0400
Received: from havoc.gtf.org ([69.61.125.42]:11755 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932433AbVIPHiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 03:38:22 -0400
Date: Fri, 16 Sep 2005 03:38:18 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [git patches] net driver fixes
Message-ID: <20050916073818.GA15990@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to obtain the following fixes:


 drivers/net/8139cp.c            |   46 ++++++-------
 drivers/net/bonding/bond_main.c |    3 
 drivers/net/spider_net.c        |    4 +
 drivers/s390/net/qeth.h         |    4 -
 drivers/s390/net/qeth_main.c    |  133 ++++++++++++++++++----------------------
 drivers/s390/net/qeth_sys.c     |   17 ++---
 6 files changed, 103 insertions(+), 104 deletions(-)



Frank Pavlic:
  s390: TSO related fixes in qeth driver
  s390: qeth driver fixes

Jay Vosburgh:
  bonding: plug reference count leak

Jens Osterkamp:
  net: fix spider_net media detection

Stephen Hemminger:
  8139cp: allocate statistics space only when needed
  [fixes crash -jg]


diff --git a/drivers/net/8139cp.c b/drivers/net/8139cp.c
--- a/drivers/net/8139cp.c
+++ b/drivers/net/8139cp.c
@@ -353,8 +353,6 @@ struct cp_private {
 
 	struct net_device_stats net_stats;
 	struct cp_extra_stats	cp_stats;
-	struct cp_dma_stats	*nic_stats;
-	dma_addr_t		nic_stats_dma;
 
 	unsigned		rx_tail		____cacheline_aligned;
 	struct cp_desc		*rx_ring;
@@ -1143,10 +1141,6 @@ static int cp_alloc_rings (struct cp_pri
 	cp->rx_ring = mem;
 	cp->tx_ring = &cp->rx_ring[CP_RX_RING_SIZE];
 
-	mem += (CP_RING_BYTES - CP_STATS_SIZE);
-	cp->nic_stats = mem;
-	cp->nic_stats_dma = cp->ring_dma + (CP_RING_BYTES - CP_STATS_SIZE);
-
 	return cp_init_rings(cp);
 }
 
@@ -1187,7 +1181,6 @@ static void cp_free_rings (struct cp_pri
 	pci_free_consistent(cp->pdev, CP_RING_BYTES, cp->rx_ring, cp->ring_dma);
 	cp->rx_ring = NULL;
 	cp->tx_ring = NULL;
-	cp->nic_stats = NULL;
 }
 
 static int cp_open (struct net_device *dev)
@@ -1516,13 +1509,17 @@ static void cp_get_ethtool_stats (struct
 				  struct ethtool_stats *estats, u64 *tmp_stats)
 {
 	struct cp_private *cp = netdev_priv(dev);
+	struct cp_dma_stats *nic_stats;
+	dma_addr_t dma;
 	int i;
 
-	memset(cp->nic_stats, 0, sizeof(struct cp_dma_stats));
+	nic_stats = pci_alloc_consistent(cp->pdev, sizeof(*nic_stats), &dma);
+	if (!nic_stats)
+		return;
 
 	/* begin NIC statistics dump */
-	cpw32(StatsAddr + 4, (cp->nic_stats_dma >> 16) >> 16);
-	cpw32(StatsAddr, (cp->nic_stats_dma & 0xffffffff) | DumpStats);
+	cpw32(StatsAddr + 4, (u64)dma >> 32);
+	cpw32(StatsAddr, ((u64)dma & DMA_32BIT_MASK) | DumpStats);
 	cpr32(StatsAddr);
 
 	for (i = 0; i < 1000; i++) {
@@ -1532,24 +1529,27 @@ static void cp_get_ethtool_stats (struct
 	}
 	cpw32(StatsAddr, 0);
 	cpw32(StatsAddr + 4, 0);
+	cpr32(StatsAddr);
 
 	i = 0;
-	tmp_stats[i++] = le64_to_cpu(cp->nic_stats->tx_ok);
-	tmp_stats[i++] = le64_to_cpu(cp->nic_stats->rx_ok);
-	tmp_stats[i++] = le64_to_cpu(cp->nic_stats->tx_err);
-	tmp_stats[i++] = le32_to_cpu(cp->nic_stats->rx_err);
-	tmp_stats[i++] = le16_to_cpu(cp->nic_stats->rx_fifo);
-	tmp_stats[i++] = le16_to_cpu(cp->nic_stats->frame_align);
-	tmp_stats[i++] = le32_to_cpu(cp->nic_stats->tx_ok_1col);
-	tmp_stats[i++] = le32_to_cpu(cp->nic_stats->tx_ok_mcol);
-	tmp_stats[i++] = le64_to_cpu(cp->nic_stats->rx_ok_phys);
-	tmp_stats[i++] = le64_to_cpu(cp->nic_stats->rx_ok_bcast);
-	tmp_stats[i++] = le32_to_cpu(cp->nic_stats->rx_ok_mcast);
-	tmp_stats[i++] = le16_to_cpu(cp->nic_stats->tx_abort);
-	tmp_stats[i++] = le16_to_cpu(cp->nic_stats->tx_underrun);
+	tmp_stats[i++] = le64_to_cpu(nic_stats->tx_ok);
+	tmp_stats[i++] = le64_to_cpu(nic_stats->rx_ok);
+	tmp_stats[i++] = le64_to_cpu(nic_stats->tx_err);
+	tmp_stats[i++] = le32_to_cpu(nic_stats->rx_err);
+	tmp_stats[i++] = le16_to_cpu(nic_stats->rx_fifo);
+	tmp_stats[i++] = le16_to_cpu(nic_stats->frame_align);
+	tmp_stats[i++] = le32_to_cpu(nic_stats->tx_ok_1col);
+	tmp_stats[i++] = le32_to_cpu(nic_stats->tx_ok_mcol);
+	tmp_stats[i++] = le64_to_cpu(nic_stats->rx_ok_phys);
+	tmp_stats[i++] = le64_to_cpu(nic_stats->rx_ok_bcast);
+	tmp_stats[i++] = le32_to_cpu(nic_stats->rx_ok_mcast);
+	tmp_stats[i++] = le16_to_cpu(nic_stats->tx_abort);
+	tmp_stats[i++] = le16_to_cpu(nic_stats->tx_underrun);
 	tmp_stats[i++] = cp->cp_stats.rx_frags;
 	if (i != CP_NUM_STATS)
 		BUG();
+
+	pci_free_consistent(cp->pdev, sizeof(*nic_stats), nic_stats, dma);
 }
 
 static struct ethtool_ops cp_ethtool_ops = {
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2879,6 +2879,7 @@ static void bond_arp_send_all(struct bon
 		 * This target is not on a VLAN
 		 */
 		if (rt->u.dst.dev == bond->dev) {
+			ip_rt_put(rt);
 			dprintk("basa: rtdev == bond->dev: arp_send\n");
 			bond_arp_send(slave->dev, ARPOP_REQUEST, targets[i],
 				      bond->master_ip, 0);
@@ -2898,6 +2899,7 @@ static void bond_arp_send_all(struct bon
 		}
 
 		if (vlan_id) {
+			ip_rt_put(rt);
 			bond_arp_send(slave->dev, ARPOP_REQUEST, targets[i],
 				      vlan->vlan_ip, vlan_id);
 			continue;
@@ -2909,6 +2911,7 @@ static void bond_arp_send_all(struct bon
 			       bond->dev->name, NIPQUAD(fl.fl4_dst),
 			       rt->u.dst.dev ? rt->u.dst.dev->name : "NULL");
 		}
+		ip_rt_put(rt);
 	}
 }
 
diff --git a/drivers/net/spider_net.c b/drivers/net/spider_net.c
--- a/drivers/net/spider_net.c
+++ b/drivers/net/spider_net.c
@@ -1817,6 +1817,10 @@ spider_net_setup_phy(struct spider_net_c
 	/* LEDs active in both modes, autosense prio = fiber */
 	spider_net_write_phy(card->netdev, 1, MII_NCONFIG, 0x945f);
 
+	/* switch off fibre autoneg */
+	spider_net_write_phy(card->netdev, 1, MII_NCONFIG, 0xfc01);
+	spider_net_write_phy(card->netdev, 1, 0x0b, 0x0004);
+
 	phy->def->ops->read_link(phy);
 	pr_info("Found %s with %i Mbps, %s-duplex.\n", phy->def->name,
 		phy->speed, phy->duplex==1 ? "Full" : "Half");
diff --git a/drivers/s390/net/qeth.h b/drivers/s390/net/qeth.h
--- a/drivers/s390/net/qeth.h
+++ b/drivers/s390/net/qeth.h
@@ -24,7 +24,7 @@
 
 #include "qeth_mpc.h"
 
-#define VERSION_QETH_H 		"$Revision: 1.139 $"
+#define VERSION_QETH_H 		"$Revision: 1.142 $"
 
 #ifdef CONFIG_QETH_IPV6
 #define QETH_VERSION_IPV6 	":IPv6"
@@ -1172,7 +1172,7 @@ extern int
 qeth_realloc_buffer_pool(struct qeth_card *, int);
 
 extern int
-qeth_set_large_send(struct qeth_card *);
+qeth_set_large_send(struct qeth_card *, enum qeth_large_send_types);
 
 extern void
 qeth_fill_header(struct qeth_card *, struct qeth_hdr *,
diff --git a/drivers/s390/net/qeth_main.c b/drivers/s390/net/qeth_main.c
--- a/drivers/s390/net/qeth_main.c
+++ b/drivers/s390/net/qeth_main.c
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.214 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.224 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.214 $	 $Date: 2005/05/04 20:19:18 $
+ *    $Revision: 1.224 $	 $Date: 2005/05/04 20:19:18 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -29,14 +29,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-/***
- * eye catcher; just for debugging purposes
- */
-void volatile
-qeth_eyecatcher(void)
-{
-	return;
-}
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -80,7 +72,7 @@ qeth_eyecatcher(void)
 #include "qeth_eddp.h"
 #include "qeth_tso.h"
 
-#define VERSION_QETH_C "$Revision: 1.214 $"
+#define VERSION_QETH_C "$Revision: 1.224 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -2759,11 +2751,9 @@ qeth_flush_buffers(struct qeth_qdio_out_
 		queue->card->perf_stats.outbound_do_qdio_start_time;
 #endif
 	if (rc){
-		QETH_DBF_SPRINTF(trace, 0, "qeth_flush_buffers: do_QDIO "
-				 "returned error (%i) on device %s.",
-				 rc, CARD_DDEV_ID(queue->card));
 		QETH_DBF_TEXT(trace, 2, "flushbuf");
 		QETH_DBF_TEXT_(trace, 2, " err%d", rc);
+		QETH_DBF_TEXT_(trace, 2, "%s", CARD_DDEV_ID(queue->card));
 		queue->card->stats.tx_errors += count;
 		/* this must not happen under normal circumstances. if it
 		 * happens something is really wrong -> recover */
@@ -2909,11 +2899,8 @@ qeth_qdio_output_handler(struct ccw_devi
 	QETH_DBF_TEXT(trace, 6, "qdouhdl");
 	if (status & QDIO_STATUS_LOOK_FOR_ERROR) {
 		if (status & QDIO_STATUS_ACTIVATE_CHECK_CONDITION){
-			QETH_DBF_SPRINTF(trace, 2, "On device %s: "
-					 "received active check "
-				         "condition (0x%08x).",
-					 CARD_BUS_ID(card), status);
-			QETH_DBF_TEXT(trace, 2, "chkcond");
+			QETH_DBF_TEXT(trace, 2, "achkcond");
+			QETH_DBF_TEXT_(trace, 2, "%s", CARD_BUS_ID(card));
 			QETH_DBF_TEXT_(trace, 2, "%08x", status);
 			netif_stop_queue(card->dev);
 			qeth_schedule_recovery(card);
@@ -3356,26 +3343,32 @@ qeth_halt_channel(struct qeth_channel *c
 static int
 qeth_halt_channels(struct qeth_card *card)
 {
-	int rc = 0;
+	int rc1 = 0, rc2=0, rc3 = 0;
 
 	QETH_DBF_TEXT(trace,3,"haltchs");
-	if ((rc = qeth_halt_channel(&card->read)))
-		return rc;
-	if ((rc = qeth_halt_channel(&card->write)))
-		return rc;
-	return  qeth_halt_channel(&card->data);
+	rc1 = qeth_halt_channel(&card->read);
+	rc2 = qeth_halt_channel(&card->write);
+	rc3 = qeth_halt_channel(&card->data);
+	if (rc1)
+		return rc1;
+	if (rc2) 
+		return rc2;
+	return rc3;
 }
 static int
 qeth_clear_channels(struct qeth_card *card)
 {
-	int rc = 0;
+	int rc1 = 0, rc2=0, rc3 = 0;
 
 	QETH_DBF_TEXT(trace,3,"clearchs");
-	if ((rc = qeth_clear_channel(&card->read)))
-		return rc;
-	if ((rc = qeth_clear_channel(&card->write)))
-		return rc;
-	return  qeth_clear_channel(&card->data);
+	rc1 = qeth_clear_channel(&card->read);
+	rc2 = qeth_clear_channel(&card->write);
+	rc3 = qeth_clear_channel(&card->data);
+	if (rc1)
+		return rc1;
+	if (rc2) 
+		return rc2;
+	return rc3;
 }
 
 static int
@@ -3445,23 +3438,23 @@ qeth_mpc_initialize(struct qeth_card *ca
 	}
 	if ((rc = qeth_cm_enable(card))){
 		QETH_DBF_TEXT_(setup, 2, "2err%d", rc);
-		return rc;
+		goto out_qdio;
 	}
 	if ((rc = qeth_cm_setup(card))){
 		QETH_DBF_TEXT_(setup, 2, "3err%d", rc);
-		return rc;
+		goto out_qdio;
 	}
 	if ((rc = qeth_ulp_enable(card))){
 		QETH_DBF_TEXT_(setup, 2, "4err%d", rc);
-		return rc;
+		goto out_qdio;
 	}
 	if ((rc = qeth_ulp_setup(card))){
 		QETH_DBF_TEXT_(setup, 2, "5err%d", rc);
-		return rc;
+		goto out_qdio;
 	}
 	if ((rc = qeth_alloc_qdio_buffers(card))){
 		QETH_DBF_TEXT_(setup, 2, "5err%d", rc);
-		return rc;
+		goto out_qdio;
 	}
 	if ((rc = qeth_qdio_establish(card))){
 		QETH_DBF_TEXT_(setup, 2, "6err%d", rc);
@@ -3795,12 +3788,16 @@ static inline int
 qeth_prepare_skb(struct qeth_card *card, struct sk_buff **skb,
 		 struct qeth_hdr **hdr, int ipv)
 {
+	int rc;
 #ifdef CONFIG_QETH_VLAN
 	u16 *tag;
 #endif
 
 	QETH_DBF_TEXT(trace, 6, "prepskb");
 
+        rc = qeth_realloc_headroom(card, skb, sizeof(struct qeth_hdr));
+        if (rc)
+                return rc;
 #ifdef CONFIG_QETH_VLAN
 	if (card->vlangrp && vlan_tx_tag_present(*skb) &&
 	    ((ipv == 6) || card->options.layer2) ) {
@@ -4251,7 +4248,8 @@ out:
 }
 
 static inline int
-qeth_get_elements_no(struct qeth_card *card, void *hdr, struct sk_buff *skb)
+qeth_get_elements_no(struct qeth_card *card, void *hdr, 
+		     struct sk_buff *skb, int elems)
 {
 	int elements_needed = 0;
 
@@ -4261,9 +4259,10 @@ qeth_get_elements_no(struct qeth_card *c
         if (elements_needed == 0 )
                 elements_needed = 1 + (((((unsigned long) hdr) % PAGE_SIZE)
                                         + skb->len) >> PAGE_SHIFT);
-        if (elements_needed > QETH_MAX_BUFFER_ELEMENTS(card)){
+	if ((elements_needed + elems) > QETH_MAX_BUFFER_ELEMENTS(card)){
                 PRINT_ERR("qeth_do_send_packet: invalid size of "
-                          "IP packet. Discarded.");
+                          "IP packet (Number=%d / Length=%d). Discarded.\n",
+                          (elements_needed+elems), skb->len);
                 return 0;
         }
         return elements_needed;
@@ -4275,7 +4274,7 @@ qeth_send_packet(struct qeth_card *card,
 	int ipv = 0;
 	int cast_type;
 	struct qeth_qdio_out_q *queue;
-	struct qeth_hdr *hdr;
+	struct qeth_hdr *hdr = NULL;
 	int elements_needed = 0;
 	enum qeth_large_send_types large_send = QETH_LARGE_SEND_NO;
 	struct qeth_eddp_context *ctx = NULL;
@@ -4337,9 +4336,11 @@ qeth_send_packet(struct qeth_card *card,
 			return -EINVAL;
 		}
 	} else {
-		elements_needed += qeth_get_elements_no(card,(void*) hdr, skb);
-		if (!elements_needed)
+		int elems = qeth_get_elements_no(card,(void*) hdr, skb,
+						 elements_needed);
+		if (!elems)
 			return -EINVAL;
+		elements_needed += elems;
 	}
 
 	if (card->info.type != QETH_CARD_TYPE_IQD)
@@ -4504,7 +4505,11 @@ qeth_arp_set_no_entries(struct qeth_card
 
 	QETH_DBF_TEXT(trace,3,"arpstnoe");
 
-	/* TODO: really not supported by GuestLAN? */
+	/*
+	 * currently GuestLAN only supports the ARP assist function
+	 * IPA_CMD_ASS_ARP_QUERY_INFO, but not IPA_CMD_ASS_ARP_SET_NO_ENTRIES;
+	 * thus we say EOPNOTSUPP for this ARP function
+	 */
 	if (card->info.guestlan)
 		return -EOPNOTSUPP;
 	if (!qeth_is_supported(card,IPA_ARP_PROCESSING)) {
@@ -4681,14 +4686,6 @@ qeth_arp_query(struct qeth_card *card, c
 
 	QETH_DBF_TEXT(trace,3,"arpquery");
 
-	/*
-	 * currently GuestLAN  does only deliver all zeros on query arp,
-	 * even though arp processing is supported (according to IPA supp.
-	 * funcs flags); since all zeros is no valueable information,
-	 * we say EOPNOTSUPP for all ARP functions
-	 */
-	/*if (card->info.guestlan)
-		return -EOPNOTSUPP; */
 	if (!qeth_is_supported(card,/*IPA_QUERY_ARP_ADDR_INFO*/
 			       IPA_ARP_PROCESSING)) {
 		PRINT_WARN("ARP processing not supported "
@@ -4894,10 +4891,9 @@ qeth_arp_add_entry(struct qeth_card *car
 	QETH_DBF_TEXT(trace,3,"arpadent");
 
 	/*
-	 * currently GuestLAN  does only deliver all zeros on query arp,
-	 * even though arp processing is supported (according to IPA supp.
-	 * funcs flags); since all zeros is no valueable information,
-	 * we say EOPNOTSUPP for all ARP functions
+	 * currently GuestLAN only supports the ARP assist function
+	 * IPA_CMD_ASS_ARP_QUERY_INFO, but not IPA_CMD_ASS_ARP_ADD_ENTRY;
+	 * thus we say EOPNOTSUPP for this ARP function
 	 */
 	if (card->info.guestlan)
 		return -EOPNOTSUPP;
@@ -4937,10 +4933,9 @@ qeth_arp_remove_entry(struct qeth_card *
 	QETH_DBF_TEXT(trace,3,"arprment");
 
 	/*
-	 * currently GuestLAN  does only deliver all zeros on query arp,
-	 * even though arp processing is supported (according to IPA supp.
-	 * funcs flags); since all zeros is no valueable information,
-	 * we say EOPNOTSUPP for all ARP functions
+	 * currently GuestLAN only supports the ARP assist function
+	 * IPA_CMD_ASS_ARP_QUERY_INFO, but not IPA_CMD_ASS_ARP_REMOVE_ENTRY;
+	 * thus we say EOPNOTSUPP for this ARP function
 	 */
 	if (card->info.guestlan)
 		return -EOPNOTSUPP;
@@ -4978,11 +4973,10 @@ qeth_arp_flush_cache(struct qeth_card *c
 	QETH_DBF_TEXT(trace,3,"arpflush");
 
 	/*
-	 * currently GuestLAN  does only deliver all zeros on query arp,
-	 * even though arp processing is supported (according to IPA supp.
-	 * funcs flags); since all zeros is no valueable information,
-	 * we say EOPNOTSUPP for all ARP functions
-	 */
+	 * currently GuestLAN only supports the ARP assist function
+	 * IPA_CMD_ASS_ARP_QUERY_INFO, but not IPA_CMD_ASS_ARP_FLUSH_CACHE;
+	 * thus we say EOPNOTSUPP for this ARP function
+	*/
 	if (card->info.guestlan || (card->info.type == QETH_CARD_TYPE_IQD))
 		return -EOPNOTSUPP;
 	if (!qeth_is_supported(card,IPA_ARP_PROCESSING)) {
@@ -7038,14 +7032,16 @@ qeth_setrouting_v6(struct qeth_card *car
 }
 
 int
-qeth_set_large_send(struct qeth_card *card)
+qeth_set_large_send(struct qeth_card *card, enum qeth_large_send_types type)
 {
 	int rc = 0;
 
-	if (card->dev == NULL)
+	if (card->dev == NULL) {
+		card->options.large_send = type;
 		return 0;
-
+	}
 	netif_stop_queue(card->dev);
+	card->options.large_send = type;
 	switch (card->options.large_send) {
 	case QETH_LARGE_SEND_EDDP:
 		card->dev->features |= NETIF_F_TSO | NETIF_F_SG;
@@ -7066,7 +7062,6 @@ qeth_set_large_send(struct qeth_card *ca
 		card->dev->features &= ~(NETIF_F_TSO | NETIF_F_SG);
 		break;
 	}
-
 	netif_wake_queue(card->dev);
 	return rc;
 }
@@ -8257,7 +8252,6 @@ qeth_init(void)
 {
 	int rc=0;
 
-	qeth_eyecatcher();
 	PRINT_INFO("loading %s (%s/%s/%s/%s/%s/%s/%s %s %s)\n",
 		   version, VERSION_QETH_C, VERSION_QETH_H,
 		   VERSION_QETH_MPC_H, VERSION_QETH_MPC_C,
@@ -8338,7 +8332,6 @@ again:
 	printk("qeth: removed\n");
 }
 
-EXPORT_SYMBOL(qeth_eyecatcher);
 module_init(qeth_init);
 module_exit(qeth_exit);
 MODULE_AUTHOR("Frank Pavlic <pavlic@de.ibm.com>");
diff --git a/drivers/s390/net/qeth_sys.c b/drivers/s390/net/qeth_sys.c
--- a/drivers/s390/net/qeth_sys.c
+++ b/drivers/s390/net/qeth_sys.c
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.51 $)
+ * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.54 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  * This file contains code related to sysfs.
@@ -20,7 +20,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-const char *VERSION_QETH_SYS_C = "$Revision: 1.51 $";
+const char *VERSION_QETH_SYS_C = "$Revision: 1.54 $";
 
 /*****************************************************************************/
 /*                                                                           */
@@ -722,10 +722,13 @@ qeth_dev_layer2_store(struct device *dev
 
 	if (!card)
 		return -EINVAL;
+	if (card->info.type == QETH_CARD_TYPE_IQD) {
+                PRINT_WARN("Layer2 on Hipersockets is not supported! \n");
+                return -EPERM;
+        }
 
 	if (((card->state != CARD_STATE_DOWN) &&
-	     (card->state != CARD_STATE_RECOVER)) ||
-	    (card->info.type != QETH_CARD_TYPE_OSAE))
+	     (card->state != CARD_STATE_RECOVER)))
 		return -EPERM;
 
 	i = simple_strtoul(buf, &tmp, 16);
@@ -771,9 +774,7 @@ qeth_dev_large_send_store(struct device 
 
 	if (!card)
 		return -EINVAL;
-
 	tmp = strsep((char **) &buf, "\n");
-
 	if (!strcmp(tmp, "no")){
 		type = QETH_LARGE_SEND_NO;
 	} else if (!strcmp(tmp, "EDDP")) {
@@ -786,10 +787,8 @@ qeth_dev_large_send_store(struct device 
 	}
 	if (card->options.large_send == type)
 		return count;
-	card->options.large_send = type;
-	if ((rc = qeth_set_large_send(card)))
+	if ((rc = qeth_set_large_send(card, type)))	
 		return rc;
-
 	return count;
 }
 
