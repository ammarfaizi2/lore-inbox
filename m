Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbVKJMrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbVKJMrQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 07:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750794AbVKJMrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 07:47:15 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:5851 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750738AbVKJMrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 07:47:12 -0500
Date: Thu, 10 Nov 2005 13:49:28 +0100
From: Frank Pavlic <fpavlic@de.ibm.com>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 3/7] s390: qeth multicast address registration fixed
Message-ID: <20051110124928.GC7936@pavlic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 3/7] s390: qeth multicast address registration fixed  

From: Klaus Dieter Wacker <kdwacker@de.ibm.com>
	- when running in Layer2 mode we don't have to register
	  the multicast IP address but only group mac address.
	  Therefore for Layer 2 devices it is enough to go
	  through dev->mc_list list and register these entries.
	
Signed-off-by: Frank Pavlic <fpavlic@de.ibm.com>

diffstat:
 qeth_main.c |  106 +++++++++++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 80 insertions(+), 26 deletions(-)

diff -Naupr orig/drivers/s390/net/qeth_main.c patched-linux/drivers/s390/net/qeth_main.c
--- orig/drivers/s390/net/qeth_main.c	2005-11-09 20:27:37.000000000 +0100
+++ patched-linux/drivers/s390/net/qeth_main.c	2005-11-09 20:30:44.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.235 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.236 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.235 $	 $Date: 2005/05/04 20:19:18 $
+ *    $Revision: 1.236 $	 $Date: 2005/05/04 20:19:18 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -72,7 +72,7 @@
 #include "qeth_eddp.h"
 #include "qeth_tso.h"
 
-#define VERSION_QETH_C "$Revision: 1.235 $"
+#define VERSION_QETH_C "$Revision: 1.236 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -602,11 +602,20 @@ __qeth_ref_ip_on_card(struct qeth_card *
 	int found = 0;
 
 	list_for_each_entry(addr, &card->ip_list, entry) {
+		if (card->options.layer2) {
+			if ((addr->type == todo->type) &&
+			    (memcmp(&addr->mac, &todo->mac, 
+				    OSA_ADDR_LEN) == 0)) {
+				found = 1;
+				break;
+			}
+			continue;
+		} 
 		if ((addr->proto     == QETH_PROT_IPV4)  &&
 		    (todo->proto     == QETH_PROT_IPV4)  &&
 		    (addr->type      == todo->type)      &&
 		    (addr->u.a4.addr == todo->u.a4.addr) &&
-		    (addr->u.a4.mask == todo->u.a4.mask)   ){
+		    (addr->u.a4.mask == todo->u.a4.mask)) {
 			found = 1;
 			break;
 		}
@@ -615,12 +624,12 @@ __qeth_ref_ip_on_card(struct qeth_card *
 		    (addr->type        == todo->type)         &&
 		    (addr->u.a6.pfxlen == todo->u.a6.pfxlen)  &&
 		    (memcmp(&addr->u.a6.addr, &todo->u.a6.addr,
-			    sizeof(struct in6_addr)) == 0))     {
+			    sizeof(struct in6_addr)) == 0)) {
 			found = 1;
 			break;
 		}
 	}
-	if (found){
+	if (found) {
 		addr->users += todo->users;
 		if (addr->users <= 0){
 			*__addr = addr;
@@ -632,7 +641,7 @@ __qeth_ref_ip_on_card(struct qeth_card *
 			return 0;
 		}
 	}
-	if (todo->users > 0){
+	if (todo->users > 0) {
 		/* for VIPA and RXIP limit refcount to 1 */
 		if (todo->type != QETH_IP_TYPE_NORMAL)
 			todo->users = 1;
@@ -682,12 +691,22 @@ __qeth_insert_ip_todo(struct qeth_card *
 		if ((addr->type == QETH_IP_TYPE_DEL_ALL_MC) &&
 		    (tmp->type == QETH_IP_TYPE_DEL_ALL_MC))
 			return 0;
+		if (card->options.layer2) {
+			if ((tmp->type	== addr->type)	&&
+			    (tmp->is_multicast == addr->is_multicast) &&
+			    (memcmp(&tmp->mac, &addr->mac, 
+				    OSA_ADDR_LEN) == 0)) {
+				found = 1;
+				break;
+			}
+			continue;
+		} 	 
 		if ((tmp->proto        == QETH_PROT_IPV4)     &&
 		    (addr->proto       == QETH_PROT_IPV4)     &&
 		    (tmp->type         == addr->type)         &&
 		    (tmp->is_multicast == addr->is_multicast) &&
 		    (tmp->u.a4.addr    == addr->u.a4.addr)    &&
-		    (tmp->u.a4.mask    == addr->u.a4.mask)      ){
+		    (tmp->u.a4.mask    == addr->u.a4.mask)) {
 			found = 1;
 			break;
 		}
@@ -697,7 +716,7 @@ __qeth_insert_ip_todo(struct qeth_card *
 		    (tmp->is_multicast == addr->is_multicast)  &&
 		    (tmp->u.a6.pfxlen  == addr->u.a6.pfxlen)   &&
 		    (memcmp(&tmp->u.a6.addr, &addr->u.a6.addr,
-			    sizeof(struct in6_addr)) == 0)        ){
+			    sizeof(struct in6_addr)) == 0)) {
 			found = 1;
 			break;
 		}
@@ -707,7 +726,7 @@ __qeth_insert_ip_todo(struct qeth_card *
 			tmp->users += addr->users;
 		else
 			tmp->users += add? 1:-1;
-		if (tmp->users == 0){
+		if (tmp->users == 0) {
 			list_del(&tmp->entry);
 			kfree(tmp);
 		}
@@ -738,12 +757,15 @@ qeth_delete_ip(struct qeth_card *card, s
 	unsigned long flags;
 	int rc = 0;
 
-	QETH_DBF_TEXT(trace,4,"delip");
-	if (addr->proto == QETH_PROT_IPV4)
-		QETH_DBF_HEX(trace,4,&addr->u.a4.addr,4);
+	QETH_DBF_TEXT(trace, 4, "delip");
+
+	if (card->options.layer2)
+		QETH_DBF_HEX(trace, 4, &addr->mac, 6);
+	else if (addr->proto == QETH_PROT_IPV4)
+		QETH_DBF_HEX(trace, 4, &addr->u.a4.addr, 4);
 	else {
-		QETH_DBF_HEX(trace,4,&addr->u.a6.addr,8);
-		QETH_DBF_HEX(trace,4,((char *)&addr->u.a6.addr)+8,8);
+		QETH_DBF_HEX(trace, 4, &addr->u.a6.addr, 8);
+		QETH_DBF_HEX(trace, 4, ((char *)&addr->u.a6.addr) + 8, 8);
 	}
 	spin_lock_irqsave(&card->ip_lock, flags);
 	rc = __qeth_insert_ip_todo(card, addr, 0);
@@ -757,12 +779,14 @@ qeth_add_ip(struct qeth_card *card, stru
 	unsigned long flags;
 	int rc = 0;
 
-	QETH_DBF_TEXT(trace,4,"addip");
-	if (addr->proto == QETH_PROT_IPV4)
-		QETH_DBF_HEX(trace,4,&addr->u.a4.addr,4);
+	QETH_DBF_TEXT(trace, 4, "addip");
+	if (card->options.layer2)
+		QETH_DBF_HEX(trace, 4, &addr->mac, 6);
+	else if (addr->proto == QETH_PROT_IPV4)
+		QETH_DBF_HEX(trace, 4, &addr->u.a4.addr, 4);
 	else {
-		QETH_DBF_HEX(trace,4,&addr->u.a6.addr,8);
-		QETH_DBF_HEX(trace,4,((char *)&addr->u.a6.addr)+8,8);
+		QETH_DBF_HEX(trace, 4, &addr->u.a6.addr, 8);
+		QETH_DBF_HEX(trace, 4, ((char *)&addr->u.a6.addr) + 8, 8);
 	}
 	spin_lock_irqsave(&card->ip_lock, flags);
 	rc = __qeth_insert_ip_todo(card, addr, 1);
@@ -851,6 +875,7 @@ qeth_set_ip_addr_list(struct qeth_card *
 
 static void qeth_delete_mc_addresses(struct qeth_card *);
 static void qeth_add_multicast_ipv4(struct qeth_card *);
+static void qeth_layer2_add_multicast(struct qeth_card *);
 #ifdef CONFIG_QETH_IPV6
 static void qeth_add_multicast_ipv6(struct qeth_card *);
 #endif
@@ -5301,8 +5326,7 @@ qeth_free_vlan_addresses4(struct qeth_ca
 	struct qeth_ipaddr *addr;
 
 	QETH_DBF_TEXT(trace, 4, "frvaddr4");
-	if (!card->vlangrp)
-		return;
+
 	rcu_read_lock();
 	in_dev = __in_dev_get_rcu(card->vlangrp->vlan_devices[vid]);
 	if (!in_dev)
@@ -5330,8 +5354,7 @@ qeth_free_vlan_addresses6(struct qeth_ca
 	struct qeth_ipaddr *addr;
 
 	QETH_DBF_TEXT(trace, 4, "frvaddr6");
-	if (!card->vlangrp)
-		return;
+
 	in6_dev = in6_dev_get(card->vlangrp->vlan_devices[vid]);
 	if (!in6_dev)
 		return;
@@ -5350,6 +5373,15 @@ qeth_free_vlan_addresses6(struct qeth_ca
 #endif /* CONFIG_QETH_IPV6 */
 }
 
+static void
+qeth_free_vlan_addresses(struct qeth_card *card, unsigned short vid)
+{
+	if (card->options.layer2 || !card->vlangrp)
+		return;
+	qeth_free_vlan_addresses4(card, vid);
+	qeth_free_vlan_addresses6(card, vid);
+}
+
 static int
 qeth_layer2_send_setdelvlan_cb(struct qeth_card *card,
                                struct qeth_reply *reply,
@@ -5432,8 +5464,7 @@ qeth_vlan_rx_kill_vid(struct net_device 
 	qeth_free_vlan_skbs(card, vid);
 	spin_lock_irqsave(&card->vlanlock, flags);
 	/* unregister IP addresses of vlan device */
-	qeth_free_vlan_addresses4(card, vid);
-	qeth_free_vlan_addresses6(card, vid);
+	qeth_free_vlan_addresses(card, vid);
 	if (card->vlangrp)
 		card->vlangrp->vlan_devices[vid] = NULL;
 	spin_unlock_irqrestore(&card->vlanlock, flags);
@@ -5456,10 +5487,15 @@ qeth_set_multicast_list(struct net_devic
 	 
 	QETH_DBF_TEXT(trace,3,"setmulti");
 	qeth_delete_mc_addresses(card);
+	if (card->options.layer2) {
+		qeth_layer2_add_multicast(card);
+		goto out;
+	}
 	qeth_add_multicast_ipv4(card);
 #ifdef CONFIG_QETH_IPV6
 	qeth_add_multicast_ipv6(card);
 #endif
+out:
  	if (qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD) == 0)
 		schedule_work(&card->kernel_thread_starter);
 }
@@ -5669,6 +5705,24 @@ qeth_add_multicast_ipv4(struct qeth_card
 	in_dev_put(in4_dev);
 }
 
+static void
+qeth_layer2_add_multicast(struct qeth_card *card)
+{
+	struct qeth_ipaddr *ipm;
+	struct dev_mc_list *dm;
+
+	QETH_DBF_TEXT(trace,4,"L2addmc");
+	for (dm = card->dev->mc_list; dm; dm = dm->next) {
+		ipm = qeth_get_addr_buffer(QETH_PROT_IPV4);
+		if (!ipm)
+			continue;
+		memcpy(ipm->mac,dm->dmi_addr,MAX_ADDR_LEN);
+		ipm->is_multicast = 1;
+		if (!qeth_add_ip(card, ipm))
+			kfree(ipm);
+	}
+}
+
 #ifdef CONFIG_QETH_IPV6
 static inline void
 qeth_add_mc6(struct qeth_card *card, struct inet6_dev *in6_dev)
