Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbUL1Ia6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbUL1Ia6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 03:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUL1Ia6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 03:30:58 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:57488 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261769AbUL1I1n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 03:27:43 -0500
Date: Tue, 28 Dec 2004 09:26:08 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] s390: Network device driver patches
Message-ID: <20041228082608.GD7988@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 3/8] s390: network drivers.

From: Ursula Braun-Krahl <braunu@de.ibm.com>
From: Peter Tiedemann <ptiedem@de.ibm.com>
From: Thomas Spatzier <tspat@de.ibm.com>
From: Frank Pavlic <pavlic@de.ibm.com>

 - ctc: make sysfs attribute buffer early available.
 - ctc: remove memory leak for channel ccw struct.
 - qeth: remove redundant info card->info.ifname.
 - qeth: enable recovery with retries in qeth_hardsetup_card after unit check.
 - qeth: do not allow to set layer2 attribute on IQD devices.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

diffstat:
 drivers/s390/net/ctcmain.c   |   16 +++--
 drivers/s390/net/qeth.h      |   10 ++-
 drivers/s390/net/qeth_main.c |  128 +++++++++++++++++++++++--------------------
 drivers/s390/net/qeth_proc.c |    8 +-
 drivers/s390/net/qeth_sys.c  |   23 +++++--
 5 files changed, 106 insertions(+), 79 deletions(-)

diff -urN linux-2.6/drivers/s390/net/ctcmain.c linux-2.6-patched/drivers/s390/net/ctcmain.c
--- linux-2.6/drivers/s390/net/ctcmain.c	2004-12-24 22:35:50.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/ctcmain.c	2004-12-28 08:50:48.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: ctcmain.c,v 1.65 2004/10/27 09:12:48 mschwide Exp $
+ * $Id: ctcmain.c,v 1.68 2004/12/27 09:25:27 heicarst Exp $
  *
  * CTC / ESCON network driver
  *
@@ -36,7 +36,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.65 $
+ * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.68 $
  *
  */
 
@@ -320,7 +320,7 @@
 print_banner(void)
 {
 	static int printed = 0;
-	char vbuf[] = "$Revision: 1.65 $";
+	char vbuf[] = "$Revision: 1.68 $";
 	char *version = vbuf;
 
 	if (printed)
@@ -1939,6 +1939,7 @@
 			   ch_fsm, CH_FSM_LEN, GFP_KERNEL);
 	if (ch->fsm == NULL) {
 		ctc_pr_warn("ctc: Could not create FSM in add_channel\n");
+		kfree(ch->ccw);
 		kfree(ch);
 		return -1;
 	}
@@ -1947,6 +1948,7 @@
 					      GFP_KERNEL)) == NULL) {
 		ctc_pr_warn("ctc: Out of memory in add_channel\n");
 		kfree_fsm(ch->fsm);
+		kfree(ch->ccw);
 		kfree(ch);
 		return -1;
 	}
@@ -1959,6 +1961,7 @@
 			"using old entry\n", (*c)->id);
 		kfree(ch->irb);
 		kfree_fsm(ch->fsm);
+		kfree(ch->ccw);
 		kfree(ch);
 		return 0;
 	}
@@ -2710,7 +2713,7 @@
 	struct net_device *ndev;
 	int bs1;
 
-	DBF_TEXT(trace, 5, __FUNCTION__);
+	DBF_TEXT(trace, 3, __FUNCTION__);
 	priv = dev->driver_data;
 	if (!priv)
 		return -ENODEV;
@@ -2835,7 +2838,7 @@
 static int
 ctc_add_attributes(struct device *dev)
 {
-	device_create_file(dev, &dev_attr_buffer);
+//	device_create_file(dev, &dev_attr_buffer);
 	device_create_file(dev, &dev_attr_loglevel);
 	device_create_file(dev, &dev_attr_stats);
 	return 0;
@@ -2846,7 +2849,7 @@
 {
 	device_remove_file(dev, &dev_attr_stats);
 	device_remove_file(dev, &dev_attr_loglevel);
-	device_remove_file(dev, &dev_attr_buffer);
+//	device_remove_file(dev, &dev_attr_buffer);
 }
 
 
@@ -2988,6 +2991,7 @@
 static struct attribute *ctc_attr[] = {
 	&dev_attr_protocol.attr,
 	&dev_attr_type.attr,
+	&dev_attr_buffer.attr,
 	NULL,
 };
 
diff -urN linux-2.6/drivers/s390/net/qeth.h linux-2.6-patched/drivers/s390/net/qeth.h
--- linux-2.6/drivers/s390/net/qeth.h	2004-12-24 22:33:49.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth.h	2004-12-28 08:50:48.000000000 +0100
@@ -24,7 +24,7 @@
 
 #include "qeth_mpc.h"
 
-#define VERSION_QETH_H 		"$Revision: 1.124 $"
+#define VERSION_QETH_H 		"$Revision: 1.129 $"
 
 #ifdef CONFIG_QETH_IPV6
 #define QETH_VERSION_IPV6 	":IPv6"
@@ -669,7 +669,6 @@
 #define QETH_BROADCAST_WITHOUT_ECHO 2
 
 struct qeth_card_info {
-	char if_name[IF_NAME_LEN];
 	unsigned short unit_addr2;
 	unsigned short cula;
 	unsigned short chpid;
@@ -775,6 +774,8 @@
 
 /*some helper functions*/
 
+#define QETH_CARD_IFNAME(card) (((card)->dev)? (card)->dev->name : "")
+
 inline static __u8
 qeth_get_ipa_adp_type(enum qeth_link_types link_type)
 {
@@ -1069,4 +1070,9 @@
 
 extern int
 qeth_realloc_buffer_pool(struct qeth_card *, int);
+
+extern int
+qeth_fake_header(struct sk_buff *skb, struct net_device *dev,
+                 unsigned short type, void *daddr, void *saddr,
+		 unsigned len);
 #endif /* __QETH_H__ */
diff -urN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-patched/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	2004-12-24 22:35:50.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth_main.c	2004-12-28 08:50:48.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.170 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.181 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.170 $	 $Date: 2004/11/17 09:54:06 $
+ *    $Revision: 1.181 $	 $Date: 2004/12/27 07:36:40 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -78,7 +78,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-#define VERSION_QETH_C "$Revision: 1.170 $"
+#define VERSION_QETH_C "$Revision: 1.181 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -1311,6 +1311,7 @@
 	if (channel->state != CH_STATE_UP){
 		rc = -ETIME;
 		QETH_DBF_TEXT_(setup, 2, "3err%d", rc);
+		qeth_clear_cmd_buffers(channel);
 	} else
 		rc = 0;
 	return rc;
@@ -1377,6 +1378,7 @@
 	if (channel->state != CH_STATE_ACTIVATING) {
 		PRINT_WARN("qeth: IDX activate timed out!\n");
 		QETH_DBF_TEXT_(setup, 2, "2err%d", -ETIME);
+		qeth_clear_cmd_buffers(channel);
 		return -ETIME;
 	}
 	return qeth_idx_activate_get_answer(channel,idx_reply_cb);
@@ -1601,7 +1603,7 @@
 					   "there is a network problem or "
 					   "someone pulled the cable or "
 					   "disabled the port.\n",
-					   card->info.if_name,
+					   QETH_CARD_IFNAME(card),
 					   card->info.chpid);
 				card->lan_online = 0;
 				netif_carrier_off(card->dev);
@@ -1610,7 +1612,7 @@
 				PRINT_INFO("Link reestablished on %s "
 					   "(CHPID 0x%X). Scheduling "
 					   "IP address reset.\n",
-					   card->info.if_name,
+					   QETH_CARD_IFNAME(card),
 					   card->info.chpid);
 				card->lan_online = 1;
 				netif_carrier_on(card->dev);
@@ -1622,7 +1624,7 @@
 			case IPA_CMD_UNREGISTER_LOCAL_ADDR:
 				PRINT_WARN("probably problem on %s: "
 					   "received IPA command 0x%X\n",
-					   card->info.if_name,
+					   QETH_CARD_IFNAME(card),
 					   cmd->hdr.command);
 				break;
 			default:
@@ -2139,7 +2141,7 @@
 no_mem:
 	if (net_ratelimit()){
 		PRINT_WARN("No memory for packet received on %s.\n",
-			   card->info.if_name);
+			   QETH_CARD_IFNAME(card));
 		QETH_DBF_TEXT(trace,2,"noskbmem");
 		QETH_DBF_TEXT_(trace,2,"%s",CARD_BUS_ID(card));
 	}
@@ -3641,7 +3643,7 @@
 		if (!new_skb) {
 			PRINT_ERR("qeth_prepare_skb: could "
 				  "not realloc headroom for qeth_hdr "
-				  "on interface %s", card->info.if_name);
+				  "on interface %s", QETH_CARD_IFNAME(card));
 			return -ENOMEM;
 		}
 		*skb = new_skb;
@@ -3678,7 +3680,7 @@
 	      QETH_IP_HEADER_SIZE) & (~(PAGE_SIZE - 1)))) {
 		PRINT_ERR("qeth_prepare_skb: misaligned "
 			  "packet on interface %s. Discarded.",
-			  card->info.if_name);
+			  QETH_CARD_IFNAME(card));
 		return -EINVAL;
 	}
 	return 0;
@@ -4185,7 +4187,7 @@
 		return -EOPNOTSUPP;
 	if (!qeth_is_supported(card,IPA_ARP_PROCESSING)) {
 		PRINT_WARN("ARP processing not supported "
-			   "on %s!\n", card->info.if_name);
+			   "on %s!\n", QETH_CARD_IFNAME(card));
 		return -EOPNOTSUPP;
 	}
 	rc = qeth_send_simple_setassparms(card, IPA_ARP_PROCESSING,
@@ -4195,7 +4197,7 @@
 		tmp = rc;
 		PRINT_WARN("Could not set number of ARP entries on %s: "
 			   "%s (0x%x/%d)\n",
-			   card->info.if_name, qeth_arp_get_error_cause(&rc),
+			   QETH_CARD_IFNAME(card), qeth_arp_get_error_cause(&rc),
 			   tmp, tmp);
 	}
 	return rc;
@@ -4368,7 +4370,7 @@
 	if (!qeth_is_supported(card,/*IPA_QUERY_ARP_ADDR_INFO*/
 			       IPA_ARP_PROCESSING)) {
 		PRINT_WARN("ARP processing not supported "
-			   "on %s!\n", card->info.if_name);
+			   "on %s!\n", QETH_CARD_IFNAME(card));
 		return -EOPNOTSUPP;
 	}
 	/* get size of userspace buffer and mask_bits -> 6 bytes */
@@ -4389,7 +4391,7 @@
 		tmp = rc;
 		PRINT_WARN("Error while querying ARP cache on %s: %s "
 			   "(0x%x/%d)\n",
-			   card->info.if_name, qeth_arp_get_error_cause(&rc),
+			   QETH_CARD_IFNAME(card), qeth_arp_get_error_cause(&rc),
 			   tmp, tmp);
 		copy_to_user(udata, qinfo.udata, 4);
 	} else {
@@ -4503,9 +4505,11 @@
 
 	if (card->info.guestlan)
 		return -EOPNOTSUPP;
-	if (!qeth_adp_supported(card,IPA_SETADP_SET_SNMP_CONTROL)) {
+
+	if ((!qeth_adp_supported(card,IPA_SETADP_SET_SNMP_CONTROL)) &&
+	    (!card->options.layer2) ) {
 		PRINT_WARN("SNMP Query MIBS not supported "
-			   "on %s!\n", card->info.if_name);
+			   "on %s!\n", QETH_CARD_IFNAME(card));
 		return -EOPNOTSUPP;
 	}
 	/* skip 4 bytes (data_len struct member) to get req_len */
@@ -4537,7 +4541,7 @@
 				    qeth_snmp_command_cb, (void *)&qinfo);
 	if (rc)
 		PRINT_WARN("SNMP command failed on %s: (0x%x)\n",
-			   card->info.if_name, rc);
+			   QETH_CARD_IFNAME(card), rc);
 	 else
 		copy_to_user(udata, qinfo.udata, qinfo.udata_len);
 
@@ -4577,7 +4581,7 @@
 		return -EOPNOTSUPP;
 	if (!qeth_is_supported(card,IPA_ARP_PROCESSING)) {
 		PRINT_WARN("ARP processing not supported "
-			   "on %s!\n", card->info.if_name);
+			   "on %s!\n", QETH_CARD_IFNAME(card));
 		return -EOPNOTSUPP;
 	}
 
@@ -4594,7 +4598,7 @@
 		qeth_ipaddr4_to_string((u8 *)entry->ipaddr, buf);
 		PRINT_WARN("Could not add ARP entry for address %s on %s: "
 			   "%s (0x%x/%d)\n",
-			   buf, card->info.if_name,
+			   buf, QETH_CARD_IFNAME(card),
 			   qeth_arp_get_error_cause(&rc), tmp, tmp);
 	}
 	return rc;
@@ -4620,7 +4624,7 @@
 		return -EOPNOTSUPP;
 	if (!qeth_is_supported(card,IPA_ARP_PROCESSING)) {
 		PRINT_WARN("ARP processing not supported "
-			   "on %s!\n", card->info.if_name);
+			   "on %s!\n", QETH_CARD_IFNAME(card));
 		return -EOPNOTSUPP;
 	}
 	memcpy(buf, entry, 12);
@@ -4637,7 +4641,7 @@
 		qeth_ipaddr4_to_string((u8 *)entry->ipaddr, buf);
 		PRINT_WARN("Could not delete ARP entry for address %s on %s: "
 			   "%s (0x%x/%d)\n",
-			   buf, card->info.if_name,
+			   buf, QETH_CARD_IFNAME(card),
 			   qeth_arp_get_error_cause(&rc), tmp, tmp);
 	}
 	return rc;
@@ -4661,7 +4665,7 @@
 		return -EOPNOTSUPP;
 	if (!qeth_is_supported(card,IPA_ARP_PROCESSING)) {
 		PRINT_WARN("ARP processing not supported "
-			   "on %s!\n", card->info.if_name);
+			   "on %s!\n", QETH_CARD_IFNAME(card));
 		return -EOPNOTSUPP;
 	}
 	rc = qeth_send_simple_setassparms(card, IPA_ARP_PROCESSING,
@@ -4669,7 +4673,7 @@
 	if (rc){
 		tmp = rc;
 		PRINT_WARN("Could not flush ARP cache on %s: %s (0x%x/%d)\n",
-			   card->info.if_name, qeth_arp_get_error_cause(&rc),
+			   QETH_CARD_IFNAME(card), qeth_arp_get_error_cause(&rc),
 			   tmp, tmp);
 	}
 	return rc;
@@ -4940,7 +4944,7 @@
 	rc = qeth_send_ipa_cmd(card, iob, NULL, NULL);
         if (rc) {
                 PRINT_ERR("Error in processing VLAN %i on %s: 0x%x. "
-			  "Continuing\n",i, card->info.if_name, rc);
+			  "Continuing\n",i, QETH_CARD_IFNAME(card), rc);
 		QETH_DBF_TEXT_(trace, 2, "L2VL%4x", ipacmd);
 		QETH_DBF_TEXT_(trace, 2, "L2%s", CARD_BUS_ID(card));
 		QETH_DBF_TEXT_(trace, 2, "err%d", rc);
@@ -5423,7 +5427,7 @@
 			  "%02x:%02x:%02x:%02x:%02x:%02x on %s: %x\n",
 			  addr->mac[0],addr->mac[1],addr->mac[2],
 			  addr->mac[3],addr->mac[4],addr->mac[5],
-			  card->info.if_name,rc);
+			  QETH_CARD_IFNAME(card),rc);
 	return rc;
 }
 
@@ -5445,7 +5449,7 @@
 			  "%02x:%02x:%02x:%02x:%02x:%02x on %s: %x\n",
 			  addr->mac[0],addr->mac[1],addr->mac[2],
 			  addr->mac[3],addr->mac[4],addr->mac[5],
-			  card->info.if_name,rc);
+			  QETH_CARD_IFNAME(card),rc);
 	return rc;
 
 }
@@ -5543,6 +5547,14 @@
 	return qeth_layer3_deregister_addr_entry(card, addr);
 }
 
+int
+qeth_fake_header(struct sk_buff *skb, struct net_device *dev,
+		     unsigned short type, void *daddr, void *saddr,
+		     unsigned len)
+{
+	return QETH_FAKE_LL_LEN;
+}
+
 static int
 qeth_netdev_init(struct net_device *dev)
 {
@@ -5584,6 +5596,10 @@
 	dev->hard_header_parse = NULL;
 	dev->set_mac_address = qeth_layer2_set_mac_address;
 	dev->flags |= qeth_get_netdev_flags(card);
+	if (card->options.fake_ll)
+		dev->hard_header = qeth_fake_header;
+	else
+		dev->hard_header = NULL;
 	if ((card->options.fake_broadcast) ||
 	    (card->info.broadcast_capable))
 		dev->flags |= IFF_BROADCAST;
@@ -6094,7 +6110,7 @@
 
 	if (!qeth_is_supported(card,IPA_ARP_PROCESSING)) {
 		PRINT_WARN("ARP processing not supported "
-			   "on %s!\n", card->info.if_name);
+			   "on %s!\n", QETH_CARD_IFNAME(card));
 		return 0;
 	}
 	rc = qeth_send_simple_setassparms(card,IPA_ARP_PROCESSING,
@@ -6102,7 +6118,7 @@
 	if (rc) {
 		PRINT_WARN("Could not start ARP processing "
 			   "assist on %s: 0x%x\n",
-			   card->info.if_name, rc);
+			   QETH_CARD_IFNAME(card), rc);
 	}
 	return rc;
 }
@@ -6116,7 +6132,7 @@
 
 	if (!qeth_is_supported(card, IPA_IP_FRAGMENTATION)) {
 		PRINT_INFO("Hardware IP fragmentation not supported on %s\n",
-			   card->info.if_name);
+			   QETH_CARD_IFNAME(card));
 		return  -EOPNOTSUPP;
 	}
 
@@ -6125,7 +6141,7 @@
 	if (rc) {
 		PRINT_WARN("Could not start Hardware IP fragmentation "
 			   "assist on %s: 0x%x\n",
-			   card->info.if_name, rc);
+			   QETH_CARD_IFNAME(card), rc);
 	} else
 		PRINT_INFO("Hardware IP fragmentation enabled \n");
 	return rc;
@@ -6143,7 +6159,7 @@
 
 	if (!qeth_is_supported(card, IPA_SOURCE_MAC)) {
 		PRINT_INFO("Inbound source address not "
-			   "supported on %s\n", card->info.if_name);
+			   "supported on %s\n", QETH_CARD_IFNAME(card));
 		return -EOPNOTSUPP;
 	}
 
@@ -6152,7 +6168,7 @@
 	if (rc)
 		PRINT_WARN("Could not start inbound source "
 			   "assist on %s: 0x%x\n",
-			   card->info.if_name, rc);
+			   QETH_CARD_IFNAME(card), rc);
 	return rc;
 }
 
@@ -6165,7 +6181,7 @@
 
 #ifdef CONFIG_QETH_VLAN
 	if (!qeth_is_supported(card, IPA_FULL_VLAN)) {
-		PRINT_WARN("VLAN not supported on %s\n", card->info.if_name);
+		PRINT_WARN("VLAN not supported on %s\n", QETH_CARD_IFNAME(card));
 		return -EOPNOTSUPP;
 	}
 
@@ -6174,7 +6190,7 @@
 	if (rc) {
 		PRINT_WARN("Could not start vlan "
 			   "assist on %s: 0x%x\n",
-			   card->info.if_name, rc);
+			   QETH_CARD_IFNAME(card), rc);
 	} else {
 		PRINT_INFO("VLAN enabled \n");
 		card->dev->features |=
@@ -6195,7 +6211,7 @@
 
 	if (!qeth_is_supported(card, IPA_MULTICASTING)) {
 		PRINT_WARN("Multicast not supported on %s\n",
-			   card->info.if_name);
+			   QETH_CARD_IFNAME(card));
 		return -EOPNOTSUPP;
 	}
 
@@ -6204,7 +6220,7 @@
 	if (rc) {
 		PRINT_WARN("Could not start multicast "
 			   "assist on %s: rc=%i\n",
-			   card->info.if_name, rc);
+			   QETH_CARD_IFNAME(card), rc);
 	} else {
 		PRINT_INFO("Multicast enabled\n");
 		card->dev->flags |= IFF_MULTICAST;
@@ -6224,14 +6240,14 @@
 	rc = qeth_send_startlan(card, QETH_PROT_IPV6);
 	if (rc) {
 		PRINT_ERR("IPv6 startlan failed on %s\n",
-			  card->info.if_name);
+			  QETH_CARD_IFNAME(card));
 		return rc;
 	}
 	netif_wake_queue(card->dev);
 	rc = qeth_query_ipassists(card,QETH_PROT_IPV6);
 	if (rc) {
 		PRINT_ERR("IPv6 query ipassist failed on %s\n",
-			  card->info.if_name);
+			  QETH_CARD_IFNAME(card));
 		return rc;
 	}
 	rc = qeth_send_simple_setassparms(card, IPA_IPV6,
@@ -6239,7 +6255,7 @@
 	if (rc) {
 		PRINT_WARN("IPv6 start assist (version 4) failed "
 			   "on %s: 0x%x\n",
-			   card->info.if_name, rc);
+			   QETH_CARD_IFNAME(card), rc);
 		return rc;
 	}
 	rc = qeth_send_simple_setassparms_ipv6(card, IPA_IPV6,
@@ -6247,7 +6263,7 @@
 	if (rc) {
 		PRINT_WARN("IPV6 start assist (version 6) failed  "
 			   "on %s: 0x%x\n",
-			   card->info.if_name, rc);
+			   QETH_CARD_IFNAME(card), rc);
 		return rc;
 	}
 	rc = qeth_send_simple_setassparms_ipv6(card, IPA_PASSTHRU,
@@ -6255,7 +6271,7 @@
 	if (rc) {
 		PRINT_WARN("Could not enable passthrough "
 			   "on %s: 0x%x\n",
-			   card->info.if_name, rc);
+			   QETH_CARD_IFNAME(card), rc);
 		return rc;
 	}
 	PRINT_INFO("IPV6 enabled \n");
@@ -6273,7 +6289,7 @@
 
 	if (!qeth_is_supported(card, IPA_IPV6)) {
 		PRINT_WARN("IPv6 not supported on %s\n",
-			   card->info.if_name);
+			   QETH_CARD_IFNAME(card));
 		return 0;
 	}
 	rc = qeth_softsetup_ipv6(card);
@@ -6290,7 +6306,7 @@
 	card->info.broadcast_capable = 0;
 	if (!qeth_is_supported(card, IPA_FILTERING)) {
 		PRINT_WARN("Broadcast not supported on %s\n",
-			   card->info.if_name);
+			   QETH_CARD_IFNAME(card));
 		rc = -EOPNOTSUPP;
 		goto out;
 	}
@@ -6299,7 +6315,7 @@
 	if (rc) {
 		PRINT_WARN("Could not enable broadcasting filtering "
 			   "on %s: 0x%x\n",
-			   card->info.if_name, rc);
+			   QETH_CARD_IFNAME(card), rc);
 		goto out;
 	}
 
@@ -6307,7 +6323,7 @@
 					  IPA_CMD_ASS_CONFIGURE, 1);
 	if (rc) {
 		PRINT_WARN("Could not set up broadcast filtering on %s: 0x%x\n",
-			   card->info.if_name, rc);
+			   QETH_CARD_IFNAME(card), rc);
 		goto out;
 	}
 	card->info.broadcast_capable = QETH_BROADCAST_WITH_ECHO;
@@ -6316,7 +6332,7 @@
 					  IPA_CMD_ASS_ENABLE, 1);
 	if (rc) {
 		PRINT_WARN("Could not set up broadcast echo filtering on "
-			   "%s: 0x%x\n", card->info.if_name, rc);
+			   "%s: 0x%x\n", QETH_CARD_IFNAME(card), rc);
 		goto out;
 	}
 	card->info.broadcast_capable = QETH_BROADCAST_WITHOUT_ECHO;
@@ -6338,7 +6354,7 @@
 	if (rc) {
 		PRINT_WARN("Starting Inbound HW Checksumming failed on %s: "
 			   "0x%x,\ncontinuing using Inbound SW Checksumming\n",
-			   card->info.if_name, rc);
+			   QETH_CARD_IFNAME(card), rc);
 		return rc;
 	}
 	rc = qeth_send_simple_setassparms(card, IPA_INBOUND_CHECKSUM,
@@ -6347,7 +6363,7 @@
 	if (rc) {
 		PRINT_WARN("Enabling Inbound HW Checksumming failed on %s: "
 			   "0x%x,\ncontinuing using Inbound SW Checksumming\n",
-			   card->info.if_name, rc);
+			   QETH_CARD_IFNAME(card), rc);
 		return rc;
 	}
 	return 0;
@@ -6362,19 +6378,19 @@
 
 	if (card->options.checksum_type == NO_CHECKSUMMING) {
 		PRINT_WARN("Using no checksumming on %s.\n",
-			   card->info.if_name);
+			   QETH_CARD_IFNAME(card));
 		return 0;
 	}
 	if (card->options.checksum_type == SW_CHECKSUMMING) {
 		PRINT_WARN("Using SW checksumming on %s.\n",
-			   card->info.if_name);
+			   QETH_CARD_IFNAME(card));
 		return 0;
 	}
 	if (!qeth_is_supported(card, IPA_INBOUND_CHECKSUM)) {
 		PRINT_WARN("Inbound HW Checksumming not "
 			   "supported on %s,\ncontinuing "
 			   "using Inbound SW Checksumming\n",
-			   card->info.if_name);
+			   QETH_CARD_IFNAME(card));
 		card->options.checksum_type = SW_CHECKSUMMING;
 		return 0;
 	}
@@ -6496,7 +6512,7 @@
  		card->options.route4.type = NO_ROUTER;
 		PRINT_WARN("Error (0x%04x) while setting routing type on %s. "
 			   "Type set to 'no router'.\n",
-			   rc, card->info.if_name);
+			   rc, QETH_CARD_IFNAME(card));
 	}
 	return rc;
 }
@@ -6523,7 +6539,7 @@
 	 	card->options.route6.type = NO_ROUTER;
 		PRINT_WARN("Error (0x%04x) while setting routing type on %s. "
 			   "Type set to 'no router'.\n",
-			   rc, card->info.if_name);
+			   rc, QETH_CARD_IFNAME(card));
 	}
 #endif
 	return rc;
@@ -6879,18 +6895,12 @@
 static int
 qeth_register_netdev(struct qeth_card *card)
 {
-	int rc;
-
 	QETH_DBF_TEXT(setup, 3, "regnetd");
 	if (card->dev->reg_state != NETREG_UNINITIALIZED)
 		return 0;
 	/* sysfs magic */
 	SET_NETDEV_DEV(card->dev, &card->gdev->dev);
-	rc = register_netdev(card->dev);
-	if (!rc)
-		strcpy(card->info.if_name, card->dev->name);
-
-	return rc;
+	return register_netdev(card->dev);
 }
 
 static void
diff -urN linux-2.6/drivers/s390/net/qeth_proc.c linux-2.6-patched/drivers/s390/net/qeth_proc.c
--- linux-2.6/drivers/s390/net/qeth_proc.c	2004-12-24 22:34:58.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth_proc.c	2004-12-28 08:50:48.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_fs.c ($Revision: 1.10 $)
+ * linux/drivers/s390/net/qeth_fs.c ($Revision: 1.13 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  * This file contains code related to procfs.
@@ -21,7 +21,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-const char *VERSION_QETH_PROC_C = "$Revision: 1.10 $";
+const char *VERSION_QETH_PROC_C = "$Revision: 1.13 $";
 
 /***** /proc/qeth *****/
 #define QETH_PROCFILE_NAME "qeth"
@@ -133,7 +133,7 @@
 				CARD_WDEV_ID(card),
 				CARD_DDEV_ID(card),
 				card->info.chpid,
-				card->info.if_name,
+				QETH_CARD_IFNAME(card),
 				qeth_get_cardname_short(card),
 				card->info.portno);
 		if (card->lan_online)
@@ -222,7 +222,7 @@
 			CARD_RDEV_ID(card),
 			CARD_WDEV_ID(card),
 			CARD_DDEV_ID(card),
-			card->info.if_name
+			QETH_CARD_IFNAME(card)
 		  );
 	seq_printf(s, "  Skb's/buffers received                 : %li/%i\n"
 		      "  Skb's/buffers sent                     : %li/%i\n\n",
diff -urN linux-2.6/drivers/s390/net/qeth_sys.c linux-2.6-patched/drivers/s390/net/qeth_sys.c
--- linux-2.6/drivers/s390/net/qeth_sys.c	2004-12-24 22:34:58.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth_sys.c	2004-12-28 08:50:48.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.40 $)
+ * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.48 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  * This file contains code related to sysfs.
@@ -20,7 +20,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-const char *VERSION_QETH_SYS_C = "$Revision: 1.40 $";
+const char *VERSION_QETH_SYS_C = "$Revision: 1.48 $";
 
 /*****************************************************************************/
 /*                                                                           */
@@ -75,8 +75,7 @@
 	struct qeth_card *card = dev->driver_data;
 	if (!card)
 		return -EINVAL;
-
-	return sprintf(buf, "%s\n", card->info.if_name);
+	return sprintf(buf, "%s\n", QETH_CARD_IFNAME(card));
 }
 
 static DEVICE_ATTR(if_name, 0444, qeth_dev_if_name_show, NULL);
@@ -440,7 +439,7 @@
 	if (!qeth_is_supported(card, IPA_IPV6)){
 		PRINT_WARN("IPv6 not supported for interface %s.\n"
 			   "Routing status no changed.\n",
-			   card->info.if_name);
+			   QETH_CARD_IFNAME(card));
 		return -ENOTSUPP;
 	}
 
@@ -515,8 +514,15 @@
 		return -EPERM;
 
 	i = simple_strtoul(buf, &tmp, 16);
-	if ((i == 0) || (i == 1))
+	if ((i == 0) || (i == 1)) {
 		card->options.fake_ll = i;
+		if (card->dev) {
+			if (i)
+  				card->dev->hard_header = qeth_fake_header;
+			else
+				card->dev->hard_header = NULL;
+		}
+	}
 	else {
 		PRINT_WARN("fake_ll: write 0 or 1 to this file!\n");
 		return -EINVAL;
@@ -715,8 +721,9 @@
 	if (!card)
 		return -EINVAL;
 
-	if ((card->state != CARD_STATE_DOWN) &&
-	    (card->state != CARD_STATE_RECOVER))
+	if (((card->state != CARD_STATE_DOWN) &&
+	     (card->state != CARD_STATE_RECOVER)) ||
+	    (card->info.type != QETH_CARD_TYPE_OSAE))
 		return -EPERM;
 
 	i = simple_strtoul(buf, &tmp, 16);
