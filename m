Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbWFBUJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWFBUJn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 16:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWFBUJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 16:09:43 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:53969 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750892AbWFBUJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 16:09:43 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 2 Jun 2006 22:08:14 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc5-mm2 08/18] ieee1394: save RAM by using a single
 tlabel for broadcast transactions
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>,
       Ben Collins <bcollins@ubuntu.com>
In-Reply-To: <tkrat.df7a29e56d67dd0a@s5r6.in-berlin.de>
Message-ID: <tkrat.29d9bcd5406eb937@s5r6.in-berlin.de>
References: <tkrat.10011841414bfa88@s5r6.in-berlin.de>
 <tkrat.31172d1c0b7ae8e8@s5r6.in-berlin.de>
 <tkrat.51c50df7e692bbfa@s5r6.in-berlin.de>
 <tkrat.f22d0694697e6d7a@s5r6.in-berlin.de>
 <tkrat.ecb0be3f1632e232@s5r6.in-berlin.de>
 <tkrat.687a0a2c67fa40c6@s5r6.in-berlin.de>
 <tkrat.f35772c971022262@s5r6.in-berlin.de>
 <tkrat.df7a29e56d67dd0a@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.035) AWL,BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since broadcast transactions are already complete when the request has
been sent, the same transaction label can be reused all over again, see
IEEE 1394 7.3.2.5 and 6.2.4.3.  Therefore we can reduce the footprint
of struct hpsb_host by the size of one struct hpsb_tlabel_pool.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/hosts.h                 |   18 +++++++++---------
 drivers/ieee1394/ieee1394_transactions.c |   10 ++++++++--
 2 files changed, 17 insertions(+), 11 deletions(-)

Index: linux-2.6.17-rc5-mm2/drivers/ieee1394/hosts.h
===================================================================
--- linux-2.6.17-rc5-mm2.orig/drivers/ieee1394/hosts.h	2006-06-01 20:55:42.000000000 +0200
+++ linux-2.6.17-rc5-mm2/drivers/ieee1394/hosts.h	2006-06-01 20:55:43.000000000 +0200
@@ -30,14 +30,14 @@ struct hpsb_host {
 
 	unsigned char iso_listen_count[64];
 
-	int node_count;     /* number of identified nodes on this bus */
-	int selfid_count;   /* total number of SelfIDs received */
-	int nodes_active;   /* number of nodes with active link layer */
-	u8 speed[63];       /* speed between each node and local node */
-
-	nodeid_t node_id;   /* node ID of this host */
-	nodeid_t irm_id;    /* ID of this bus' isochronous resource manager */
-	nodeid_t busmgr_id; /* ID of this bus' bus manager */
+	int node_count;      /* number of identified nodes on this bus */
+	int selfid_count;    /* total number of SelfIDs received */
+	int nodes_active;    /* number of nodes with active link layer */
+	u8 speed[ALL_NODES]; /* speed between each node and local node */
+
+	nodeid_t node_id;    /* node ID of this host */
+	nodeid_t irm_id;     /* ID of this bus' isochronous resource manager */
+	nodeid_t busmgr_id;  /* ID of this bus' bus manager */
 
 	/* this nodes state */
 	unsigned in_bus_reset:1;
@@ -56,7 +56,7 @@ struct hpsb_host {
 	struct csr_control csr;
 
 	/* Per node tlabel pool allocation */
-	struct hpsb_tlabel_pool tpool[64];
+	struct hpsb_tlabel_pool tpool[ALL_NODES];
 
 	struct hpsb_host_driver *driver;
 
Index: linux-2.6.17-rc5-mm2/drivers/ieee1394/ieee1394_transactions.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/drivers/ieee1394/ieee1394_transactions.c	2006-06-01 20:55:04.000000000 +0200
+++ linux-2.6.17-rc5-mm2/drivers/ieee1394/ieee1394_transactions.c	2006-06-01 20:55:43.000000000 +0200
@@ -136,8 +136,11 @@ int hpsb_get_tlabel(struct hpsb_packet *
 {
 	unsigned long flags;
 	struct hpsb_tlabel_pool *tp;
+	int n = NODEID_TO_NODE(packet->node_id);
 
-	tp = &packet->host->tpool[packet->node_id & NODE_MASK];
+	if (unlikely(n == ALL_NODES))
+		return 0;
+	tp = &packet->host->tpool[n];
 
 	if (irqs_disabled() || in_atomic()) {
 		if (down_trylock(&tp->count))
@@ -175,8 +178,11 @@ void hpsb_free_tlabel(struct hpsb_packet
 {
 	unsigned long flags;
 	struct hpsb_tlabel_pool *tp;
+	int n = NODEID_TO_NODE(packet->node_id);
 
-	tp = &packet->host->tpool[packet->node_id & NODE_MASK];
+	if (unlikely(n == ALL_NODES))
+		return;
+	tp = &packet->host->tpool[n];
 
 	BUG_ON(packet->tlabel > 63 || packet->tlabel < 0);
 


