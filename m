Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVAaSC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVAaSC7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 13:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVAaSC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 13:02:59 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:16615 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261299AbVAaR6w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 12:58:52 -0500
Date: Mon, 31 Jan 2005 18:58:43 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 7/8] s390: qeth network driver.
Message-ID: <20050131175843.GG7940@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 7/8] s390: qeth network driver.

From: Steffen Thoss <thoss@de.ibm.com>
From: Frank Pavlic <pavlic@de.ibm.com>

qeth network driver changes:
 - Improve performance by omitting svs.
 - Use function callback mechanism to set layer 2 parameters when getting
   a reply for a Layer 2 command.
 - dev->hard_header must not be NULL when fake_ll is no set since
   IPv6 and Layer2 needs the default function set by network stack.
 - ping6 works now when running in layer 2 mode.
 - Save original dev->hard_header to restore it when the user doesn't
   want to use fake_ll anymore.
 - Fake ethernet header in outgoing packets. This currently works
   only if qeth is compiled without ipv6 support.
 - Add more debug information in case of failures in qeth_set_offline.
 - Using fake_ll with HiperSockets devices results in misaligned
   ip packets and thus no traffic over HiperSockets.
 - Start qeth_remove_device only after the qeth recovery completed.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/net/qeth.h      |   19 +-
 drivers/s390/net/qeth_main.c |  351 ++++++++++++++++++++++++++++---------------
 drivers/s390/net/qeth_sys.c  |   16 -
 3 files changed, 252 insertions(+), 134 deletions(-)

diff -urN linux-2.6/drivers/s390/net/qeth.h linux-2.6-patched/drivers/s390/net/qeth.h
--- linux-2.6/drivers/s390/net/qeth.h	2005-01-31 18:51:07.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth.h	2005-01-31 18:51:24.000000000 +0100
@@ -24,7 +24,7 @@
 
 #include "qeth_mpc.h"
 
-#define VERSION_QETH_H 		"$Revision: 1.129 $"
+#define VERSION_QETH_H 		"$Revision: 1.132 $"
 
 #ifdef CONFIG_QETH_IPV6
 #define QETH_VERSION_IPV6 	":IPv6"
@@ -754,6 +754,8 @@
 	struct qeth_perf_stats perf_stats;
 #endif /* CONFIG_QETH_PERF_STATS */
 	int use_hard_stop;
+	int (*orig_hard_header)(struct sk_buff *,struct net_device *,
+				unsigned short,void *,void *,unsigned);
 };
 
 struct qeth_card_list_struct {
@@ -828,6 +830,17 @@
 #endif
 	}
 }
+static inline struct sk_buff *
+qeth_pskb_unshare(struct sk_buff *skb, int pri)
+{
+        struct sk_buff *nskb;
+        if (!skb_cloned(skb))
+                return skb;
+        nskb = skb_copy(skb, pri);
+        kfree_skb(skb); /* free our shared copy */
+        return nskb;
+}
+
 
 inline static int
 qeth_get_initial_mtu_for_card(struct qeth_card * card)
@@ -1071,8 +1084,4 @@
 extern int
 qeth_realloc_buffer_pool(struct qeth_card *, int);
 
-extern int
-qeth_fake_header(struct sk_buff *skb, struct net_device *dev,
-                 unsigned short type, void *daddr, void *saddr,
-		 unsigned len);
 #endif /* __QETH_H__ */
diff -urN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-patched/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	2005-01-31 18:51:07.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth_main.c	2005-01-31 18:51:24.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.181 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.191 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.181 $	 $Date: 2004/12/27 07:36:40 $
+ *    $Revision: 1.191 $	 $Date: 2005/01/31 13:13:57 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -41,16 +41,9 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/mm.h>
-
-#include <asm/io.h>
-#include <asm/ebcdic.h>
-#include <linux/ctype.h>
-#include <asm/semaphore.h>
-#include <asm/timex.h>
 #include <linux/ip.h>
 #include <linux/inetdevice.h>
 #include <linux/netdevice.h>
@@ -62,23 +55,29 @@
 #include <linux/tcp.h>
 #include <linux/icmp.h>
 #include <linux/skbuff.h>
-#include <net/route.h>
-#include <net/arp.h>
 #include <linux/in.h>
 #include <linux/igmp.h>
-#include <net/ip.h>
-#include <asm/uaccess.h>
 #include <linux/init.h>
 #include <linux/reboot.h>
-#include <asm/qeth.h>
 #include <linux/mii.h>
 #include <linux/rcupdate.h>
 
+#include <net/arp.h>
+#include <net/ip.h>
+#include <net/route.h>
+
+#include <asm/ebcdic.h>
+#include <asm/io.h>
+#include <asm/qeth.h>
+#include <asm/timex.h>
+#include <asm/semaphore.h>
+#include <asm/uaccess.h>
+
 #include "qeth.h"
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-#define VERSION_QETH_C "$Revision: 1.181 $"
+#define VERSION_QETH_C "$Revision: 1.191 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -514,6 +513,7 @@
 qeth_set_offline(struct ccwgroup_device *cgdev)
 {
 	struct qeth_card *card = (struct qeth_card *) cgdev->dev.driver_data;
+	int rc = 0;
 	enum qeth_card_states recover_flag;
 
 	QETH_DBF_TEXT(setup, 3, "setoffl");
@@ -525,15 +525,21 @@
 			   CARD_BUS_ID(card));
 		return -ERESTARTSYS;
 	}
-	ccw_device_set_offline(CARD_DDEV(card));
-	ccw_device_set_offline(CARD_WDEV(card));
-	ccw_device_set_offline(CARD_RDEV(card));
+	if ((rc = ccw_device_set_offline(CARD_DDEV(card))) ||
+	    (rc = ccw_device_set_offline(CARD_WDEV(card))) ||
+	    (rc = ccw_device_set_offline(CARD_RDEV(card)))) {
+		QETH_DBF_TEXT_(setup, 2, "1err%d", rc);
+	}
 	if (recover_flag == CARD_STATE_UP)
 		card->state = CARD_STATE_RECOVER;
 	qeth_notify_processes();
 	return 0;
 }
 
+static int
+qeth_wait_for_threads(struct qeth_card *card, unsigned long threads);
+
+
 static void
 qeth_remove_device(struct ccwgroup_device *cgdev)
 {
@@ -546,6 +552,9 @@
 	if (!card)
 		return;
 
+	if (qeth_wait_for_threads(card, 0xffffffff))
+		return;
+
 	if (cgdev->state == CCWGROUP_ONLINE){
 		card->use_hard_stop = 1;
 		qeth_set_offline(cgdev);
@@ -621,7 +630,7 @@
 	if (todo->users > 0){
 		/* for VIPA and RXIP limit refcount to 1 */
 		if (todo->type != QETH_IP_TYPE_NORMAL)
-			addr->users = 1;
+			todo->users = 1;
 		return 1;
 	} else
 		return 0;
@@ -2262,8 +2271,8 @@
 		skb->ip_summed = CHECKSUM_NONE;
 #ifdef CONFIG_QETH_VLAN
 	if (hdr->hdr.l2.flags[2] & (QETH_LAYER2_FLAG_VLAN)) {
-		skb_pull(skb, VLAN_HLEN);
 		vlan_id = hdr->hdr.l2.vlan_id;
+		skb_pull(skb, VLAN_HLEN);
 	}
 #endif
 	skb->protocol = qeth_type_trans(skb, skb->dev);
@@ -3262,13 +3271,15 @@
 
 	QETH_DBF_TEXT(trace,3,"qdioclr");
 	if (card->qdio.state == QETH_QDIO_ESTABLISHED){
-		qdio_cleanup(CARD_DDEV(card),
+		if ((rc = qdio_cleanup(CARD_DDEV(card),
 			     (card->info.type == QETH_CARD_TYPE_IQD) ?
 			     QDIO_FLAG_CLEANUP_USING_HALT :
-			     QDIO_FLAG_CLEANUP_USING_CLEAR);
+			     QDIO_FLAG_CLEANUP_USING_CLEAR)))
+			QETH_DBF_TEXT_(trace, 3, "1err%d", rc);
 		card->qdio.state = QETH_QDIO_ALLOCATED;
 	}
-	rc = qeth_clear_halt_card(card, use_halt);
+	if ((rc = qeth_clear_halt_card(card, use_halt)))
+		QETH_DBF_TEXT_(trace, 3, "2err%d", rc);
 	card->state = CARD_STATE_DOWN;
 	return rc;
 }
@@ -3370,6 +3381,26 @@
 	return dev;
 }
 
+/*hard_header fake function; used in case fake_ll is set */
+static int
+qeth_fake_header(struct sk_buff *skb, struct net_device *dev,
+		     unsigned short type, void *daddr, void *saddr,
+		     unsigned len)
+{
+	struct ethhdr *hdr;
+	struct qeth_card *card;
+
+	card = (struct qeth_card *)dev->priv;
+        hdr = (struct ethhdr *)skb_push(skb, QETH_FAKE_LL_LEN);
+	memcpy(hdr->h_source, card->dev->dev_addr, ETH_ALEN);
+        memcpy(hdr->h_dest, "FAKELL", ETH_ALEN);
+        if (type != ETH_P_802_3)
+                hdr->h_proto = htons(type);
+        else
+                hdr->h_proto = htons(len);
+	return QETH_FAKE_LL_LEN;
+}
+
 static inline int
 qeth_send_packet(struct qeth_card *, struct sk_buff *);
 
@@ -3399,6 +3430,14 @@
 	card->perf_stats.outbound_cnt++;
 	card->perf_stats.outbound_start_time = qeth_get_micros();
 #endif
+	if (dev->hard_header == qeth_fake_header) {
+               if ((skb = qeth_pskb_unshare(skb, GFP_ATOMIC)) == NULL) {
+                        card->stats.tx_dropped++;
+                        dev_kfree_skb_irq(skb);
+                        return 0;
+                }
+                skb_pull(skb, QETH_FAKE_LL_LEN);
+	}
 	/*
 	 * We only call netif_stop_queue in case of errors. Since we've
 	 * got our own synchronization on queues we can keep the stack's
@@ -5219,7 +5258,10 @@
 
 static int
 qeth_layer2_send_setdelmac(struct qeth_card *card, __u8 *mac,
-			   enum qeth_ipa_cmds ipacmd)
+			   enum qeth_ipa_cmds ipacmd,
+			   int (*reply_cb) (struct qeth_card *,
+					    struct qeth_reply*,
+					    unsigned long))
 {
 	struct qeth_ipa_cmd *cmd;
 	struct qeth_cmd_buffer *iob;
@@ -5229,9 +5271,139 @@
 	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
         cmd->data.setdelmac.mac_length = OSA_ADDR_LEN;
         memcpy(&cmd->data.setdelmac.mac, mac, OSA_ADDR_LEN);
-	return qeth_send_ipa_cmd(card, iob, NULL, NULL);
+	return qeth_send_ipa_cmd(card, iob, reply_cb, NULL);
+}
+
+static int
+qeth_layer2_send_setgroupmac_cb(struct qeth_card *card,
+				struct qeth_reply *reply,
+				unsigned long data)
+{
+	struct qeth_ipa_cmd *cmd;
+	__u8 *mac;
+
+	QETH_DBF_TEXT(trace, 2, "L2Sgmacb");
+	cmd = (struct qeth_ipa_cmd *) data;
+	mac = &cmd->data.setdelmac.mac[0];
+	/* MAC already registered, needed in couple/uncouple case */
+	if (cmd->hdr.return_code == 0x2005) {
+		PRINT_WARN("Group MAC %02x:%02x:%02x:%02x:%02x:%02x " \
+			  "already existing on %s \n",
+			  mac[0], mac[1], mac[2], mac[3], mac[4], mac[5],
+			  QETH_CARD_IFNAME(card));
+		cmd->hdr.return_code = 0;
+	}
+	if (cmd->hdr.return_code)
+		PRINT_ERR("Could not set group MAC " \
+			  "%02x:%02x:%02x:%02x:%02x:%02x on %s: %x\n",
+			  mac[0], mac[1], mac[2], mac[3], mac[4], mac[5],
+			  QETH_CARD_IFNAME(card),cmd->hdr.return_code);
+	return 0;
+}
+
+static int
+qeth_layer2_send_setgroupmac(struct qeth_card *card, __u8 *mac)
+{
+	QETH_DBF_TEXT(trace, 2, "L2Sgmac");
+	return qeth_layer2_send_setdelmac(card, mac, IPA_CMD_SETGMAC,
+					  qeth_layer2_send_setgroupmac_cb);
+}
+
+static int
+qeth_layer2_send_delgroupmac_cb(struct qeth_card *card,
+				struct qeth_reply *reply,
+				unsigned long data)
+{
+	struct qeth_ipa_cmd *cmd;
+	__u8 *mac;
+
+	QETH_DBF_TEXT(trace, 2, "L2Dgmacb");
+	cmd = (struct qeth_ipa_cmd *) data;
+	mac = &cmd->data.setdelmac.mac[0];
+	if (cmd->hdr.return_code)
+		PRINT_ERR("Could not delete group MAC " \
+			  "%02x:%02x:%02x:%02x:%02x:%02x on %s: %x\n",
+			  mac[0], mac[1], mac[2], mac[3], mac[4], mac[5],
+			  QETH_CARD_IFNAME(card), cmd->hdr.return_code);
+	return 0;
+}
+
+static int
+qeth_layer2_send_delgroupmac(struct qeth_card *card, __u8 *mac)
+{
+	QETH_DBF_TEXT(trace, 2, "L2Dgmac");
+	return qeth_layer2_send_setdelmac(card, mac, IPA_CMD_DELGMAC,
+					  qeth_layer2_send_delgroupmac_cb);
+}
+
+static int
+qeth_layer2_send_setmac_cb(struct qeth_card *card,
+			   struct qeth_reply *reply,
+			   unsigned long data)
+{
+	struct qeth_ipa_cmd *cmd;
+
+	QETH_DBF_TEXT(trace, 2, "L2Smaccb");
+	cmd = (struct qeth_ipa_cmd *) data;
+	if (cmd->hdr.return_code) {
+		QETH_DBF_TEXT_(trace, 2, "L2er%x", cmd->hdr.return_code);
+		PRINT_WARN("Error in registering MAC address on " \
+			   "device %s: x%x\n", CARD_BUS_ID(card),
+			   cmd->hdr.return_code);
+		card->info.layer2_mac_registered = 0;
+		cmd->hdr.return_code = -EIO;
+	} else {
+		card->info.layer2_mac_registered = 1;
+		memcpy(card->dev->dev_addr,cmd->data.setdelmac.mac,
+		       OSA_ADDR_LEN);
+		PRINT_INFO("MAC address %2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x "
+			   "successfully registered on device %s\n",
+			   card->dev->dev_addr[0], card->dev->dev_addr[1],
+			   card->dev->dev_addr[2], card->dev->dev_addr[3],
+			   card->dev->dev_addr[4], card->dev->dev_addr[5],
+			   card->dev->name);
+	}
+	return 0;
+}
+
+static int
+qeth_layer2_send_setmac(struct qeth_card *card, __u8 *mac)
+{
+	QETH_DBF_TEXT(trace, 2, "L2Setmac");
+	return qeth_layer2_send_setdelmac(card, mac, IPA_CMD_SETVMAC,
+					  qeth_layer2_send_setmac_cb);
 }
 
+static int
+qeth_layer2_send_delmac_cb(struct qeth_card *card,
+			   struct qeth_reply *reply,
+			   unsigned long data)
+{
+	struct qeth_ipa_cmd *cmd;
+
+	QETH_DBF_TEXT(trace, 2, "L2Dmaccb");
+	cmd = (struct qeth_ipa_cmd *) data;
+	if (cmd->hdr.return_code) {
+		PRINT_WARN("Error in deregistering MAC address on " \
+			   "device %s: x%x\n", CARD_BUS_ID(card),
+			   cmd->hdr.return_code);
+		QETH_DBF_TEXT_(trace, 2, "err%d", cmd->hdr.return_code);
+		cmd->hdr.return_code = -EIO;
+		return 0;
+	}
+	card->info.layer2_mac_registered = 0;
+
+	return 0;
+}
+static int
+qeth_layer2_send_delmac(struct qeth_card *card, __u8 *mac)
+{
+	QETH_DBF_TEXT(trace, 2, "L2Delmac");
+	if (!card->info.layer2_mac_registered)
+		return 0;
+	return qeth_layer2_send_setdelmac(card, mac, IPA_CMD_DELVMAC,
+					  qeth_layer2_send_delmac_cb);
+}
 
 static int
 qeth_layer2_set_mac_address(struct net_device *dev, void *p)
@@ -5256,32 +5428,9 @@
 	}
 	QETH_DBF_TEXT_(trace, 3, "%s", CARD_BUS_ID(card));
 	QETH_DBF_HEX(trace, 3, addr->sa_data, OSA_ADDR_LEN);
-	if (card->info.layer2_mac_registered)
-		rc = qeth_layer2_send_setdelmac(card, &card->dev->dev_addr[0],
-						IPA_CMD_DELVMAC);
-	if (rc) {
-		PRINT_WARN("Error in deregistering MAC address on " \
-			   "device %s: x%x\n", CARD_BUS_ID(card), rc);
-		QETH_DBF_TEXT_(trace, 2, "err%d", rc);
-		return -EIO;
-	}
-	card->info.layer2_mac_registered = 0;
-
-	rc = qeth_layer2_send_setdelmac(card, addr->sa_data, IPA_CMD_SETVMAC);
-	if (rc) {
-		PRINT_WARN("Error in registering MAC address on " \
-			   "device %s: x%x\n", CARD_BUS_ID(card), rc);
-		QETH_DBF_TEXT_(trace, 2, "2err%d", rc);
-		return -EIO;
-	}
-	card->info.layer2_mac_registered = 1;
-	memcpy(dev->dev_addr, addr->sa_data, OSA_ADDR_LEN);
-	PRINT_INFO("MAC address %2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x "
-		   "successfully registered on device %s\n",
-		   dev->dev_addr[0],dev->dev_addr[1],dev->dev_addr[2],
-		   dev->dev_addr[3],dev->dev_addr[4],dev->dev_addr[5],
-		   dev->name);
-
+	rc = qeth_layer2_send_delmac(card, &card->dev->dev_addr[0]);
+	if (!rc)
+		rc = qeth_layer2_send_setmac(card, addr->sa_data);
 	return rc;
 }
 
@@ -5392,45 +5541,22 @@
 qeth_layer2_register_addr_entry(struct qeth_card *card,
 				struct qeth_ipaddr *addr)
 {
-	int rc = 0;
-
 	if (!addr->is_multicast)
 		return 0;
-
 	QETH_DBF_TEXT(trace, 2, "setgmac");
 	QETH_DBF_HEX(trace,3,&addr->mac[0],OSA_ADDR_LEN);
-	rc = qeth_layer2_send_setdelmac(card, &addr->mac[0],
-					IPA_CMD_SETGMAC);
-	if (rc)
-		PRINT_ERR("Could not set group MAC " \
-			  "%02x:%02x:%02x:%02x:%02x:%02x on %s: %x\n",
-			  addr->mac[0],addr->mac[1],addr->mac[2],
-			  addr->mac[3],addr->mac[4],addr->mac[5],
-			  QETH_CARD_IFNAME(card),rc);
-	return rc;
+	return qeth_layer2_send_setgroupmac(card, &addr->mac[0]);
 }
 
 static int
 qeth_layer2_deregister_addr_entry(struct qeth_card *card,
 				  struct qeth_ipaddr *addr)
 {
-	int rc = 0;
-
 	if (!addr->is_multicast)
 		return 0;
-
 	QETH_DBF_TEXT(trace, 2, "delgmac");
 	QETH_DBF_HEX(trace,3,&addr->mac[0],OSA_ADDR_LEN);
-	rc = qeth_layer2_send_setdelmac(card, &addr->mac[0],
-					IPA_CMD_DELGMAC);
-	if (rc)
-		PRINT_ERR("Could not delete group MAC " \
-			  "%02x:%02x:%02x:%02x:%02x:%02x on %s: %x\n",
-			  addr->mac[0],addr->mac[1],addr->mac[2],
-			  addr->mac[3],addr->mac[4],addr->mac[5],
-			  QETH_CARD_IFNAME(card),rc);
-	return rc;
-
+	return qeth_layer2_send_delgroupmac(card, &addr->mac[0]);
 }
 
 static int
@@ -5526,14 +5652,6 @@
 	return qeth_layer3_deregister_addr_entry(card, addr);
 }
 
-int
-qeth_fake_header(struct sk_buff *skb, struct net_device *dev,
-		     unsigned short type, void *daddr, void *saddr,
-		     unsigned len)
-{
-	return QETH_FAKE_LL_LEN;
-}
-
 static int
 qeth_netdev_init(struct net_device *dev)
 {
@@ -5558,9 +5676,12 @@
 	dev->vlan_rx_kill_vid = qeth_vlan_rx_kill_vid;
 	dev->vlan_rx_add_vid = qeth_vlan_rx_add_vid;
 #endif
+	dev->hard_header = card->orig_hard_header;
 	if (qeth_get_netdev_flags(card) & IFF_NOARP) {
 		dev->rebuild_header = NULL;
 		dev->hard_header = NULL;
+		if (card->options.fake_ll)
+			dev->hard_header = qeth_fake_header;
 		dev->header_cache_update = NULL;
 		dev->hard_header_cache = NULL;
 	}
@@ -5572,10 +5693,6 @@
 	dev->hard_header_parse = NULL;
 	dev->set_mac_address = qeth_layer2_set_mac_address;
 	dev->flags |= qeth_get_netdev_flags(card);
-	if (card->options.fake_ll)
-		dev->hard_header = qeth_fake_header;
-	else
-		dev->hard_header = NULL;
 	if ((card->options.fake_broadcast) ||
 	    (card->info.broadcast_capable))
 		dev->flags |= IFF_BROADCAST;
@@ -5672,22 +5789,26 @@
 		QETH_DBF_TEXT_(setup, 2, "5err%d", rc);
 		goto out;
 	}
+	/*network device will be recovered*/
+	if (card->dev) {
+		card->dev->hard_header = card->orig_hard_header;
+		return 0;
+	}
 	/* at first set_online allocate netdev */
+	card->dev = qeth_get_netdevice(card->info.type,
+				       card->info.link_type);
 	if (!card->dev){
-		card->dev = qeth_get_netdevice(card->info.type,
-					       card->info.link_type);
-		if (!card->dev){
-			qeth_qdio_clear_card(card, card->info.type ==
-					     QETH_CARD_TYPE_OSAE);
-			rc = -ENODEV;
-			QETH_DBF_TEXT_(setup, 2, "6err%d", rc);
-			goto out;
-		}
-		card->dev->priv = card;
-		card->dev->type = qeth_get_arphdr_type(card->info.type,
-						       card->info.link_type);
-		card->dev->init = qeth_netdev_init;
+		qeth_qdio_clear_card(card, card->info.type ==
+				     QETH_CARD_TYPE_OSAE);
+		rc = -ENODEV;
+		QETH_DBF_TEXT_(setup, 2, "6err%d", rc);
+		goto out;
 	}
+	card->dev->priv = card;
+	card->orig_hard_header = card->dev->hard_header;
+	card->dev->type = qeth_get_arphdr_type(card->info.type,
+					       card->info.link_type);
+	card->dev->init = qeth_netdev_init;
 	return 0;
 out:
 	PRINT_ERR("Initialization in hardsetup failed! rc=%d\n", rc);
@@ -5906,15 +6027,9 @@
         }
 	QETH_DBF_HEX(setup,2, card->dev->dev_addr, OSA_ADDR_LEN);
 
-	rc = qeth_layer2_send_setdelmac(card, &card->dev->dev_addr[0],
-					IPA_CMD_SETVMAC);
-        if (rc) {
-		card->info.layer2_mac_registered = 0;
-                PRINT_WARN("Error in processing MAC address on " \
-                           "device %s: x%x\n",CARD_BUS_ID(card),rc);
+	rc = qeth_layer2_send_setmac(card, &card->dev->dev_addr[0]);
+        if (rc)
 		QETH_DBF_TEXT_(setup, 2,"2err%d",rc);
-        } else
-		card->info.layer2_mac_registered = 1;
         return 0;
 }
 
@@ -6712,9 +6827,8 @@
 		rtnl_unlock();
 		if (!card->use_hard_stop) {
 			__u8 *mac = &card->dev->dev_addr[0];
-			if ((rc = qeth_layer2_send_setdelmac(card, mac,
-							    IPA_CMD_DELVMAC)));
-				QETH_DBF_TEXT_(setup, 2, "Lerr%d", rc);
+			rc = qeth_layer2_send_delmac(card, mac);
+			QETH_DBF_TEXT_(setup, 2, "Lerr%d", rc);
 			if ((rc = qeth_send_stoplan(card)))
 				QETH_DBF_TEXT_(setup, 2, "1err%d", rc);
 		}
@@ -6872,8 +6986,10 @@
 qeth_register_netdev(struct qeth_card *card)
 {
 	QETH_DBF_TEXT(setup, 3, "regnetd");
-	if (card->dev->reg_state != NETREG_UNINITIALIZED)
+	if (card->dev->reg_state != NETREG_UNINITIALIZED) {
+		qeth_netdev_init(card->dev);
 		return 0;
+	}
 	/* sysfs magic */
 	SET_NETDEV_DEV(card->dev, &card->gdev->dev);
 	return register_netdev(card->dev);
@@ -6961,9 +7077,9 @@
 	}
 
 	recover_flag = card->state;
-	if (ccw_device_set_online(CARD_RDEV(card)) ||
-	    ccw_device_set_online(CARD_WDEV(card)) ||
-	    ccw_device_set_online(CARD_DDEV(card))){
+	if ((rc = ccw_device_set_online(CARD_RDEV(card))) ||
+	    (rc = ccw_device_set_online(CARD_WDEV(card))) ||
+	    (rc = ccw_device_set_online(CARD_DDEV(card)))){
 		QETH_DBF_TEXT_(setup, 2, "1err%d", rc);
 		return -EIO;
 	}
@@ -7157,7 +7273,8 @@
 	card = qeth_get_card_from_dev(dev);
 	if (card == NULL)
 		goto out;
-	if(card->options.layer2)
+	if((card->options.layer2) ||
+	   (card->dev->hard_header == qeth_fake_header))
 		goto out;
 
 	rcu_read_lock();
diff -urN linux-2.6/drivers/s390/net/qeth_sys.c linux-2.6-patched/drivers/s390/net/qeth_sys.c
--- linux-2.6/drivers/s390/net/qeth_sys.c	2005-01-31 18:51:07.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth_sys.c	2005-01-31 18:51:24.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.48 $)
+ * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.49 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  * This file contains code related to sysfs.
@@ -20,7 +20,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-const char *VERSION_QETH_SYS_C = "$Revision: 1.48 $";
+const char *VERSION_QETH_SYS_C = "$Revision: 1.49 $";
 
 /*****************************************************************************/
 /*                                                                           */
@@ -514,19 +514,11 @@
 		return -EPERM;
 
 	i = simple_strtoul(buf, &tmp, 16);
-	if ((i == 0) || (i == 1)) {
-		card->options.fake_ll = i;
-		if (card->dev) {
-			if (i)
-  				card->dev->hard_header = qeth_fake_header;
-			else
-				card->dev->hard_header = NULL;
-		}
-	}
-	else {
+	if ((i != 0) && (i != 1)) {
 		PRINT_WARN("fake_ll: write 0 or 1 to this file!\n");
 		return -EINVAL;
 	}
+	card->options.fake_ll = i;
 	return count;
 }
 
