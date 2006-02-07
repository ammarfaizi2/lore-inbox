Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965149AbWBGQCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbWBGQCS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 11:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbWBGQCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 11:02:18 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:63953 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S965149AbWBGQCL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 11:02:11 -0500
Date: Tue, 7 Feb 2006 17:04:38 +0100
From: Frank Pavlic <fpavlic@de.ibm.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: [patch 2/2] s390: some qeth driver fixes
Message-ID: <20060207170438.57197373@localhost.localdomain>
Organization: IBM
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 2/2] s390: some qeth driver fixes 

From: Frank Pavlic <fpavlic@de.ibm.com>
	- fixed kernel panic when using EDDP support in Layer 2 mode
	- NULL pointer exception in qeth_set_offline fixed.
	- setting EDDP in Layer 2 mode did not set NETIF_F_(SG/TSO)
	  flags when device became online.
	- use sscanf for parsing and converting IPv4 addresses
	  from string to __u8 values.
	- qeth_string_to_ipaddr6 fixed. in case of double colon
	  the converted IPv6 address out from the string was not correct
	  in previous implementation.
	
Signed-off-by: Frank Pavlic <fpavlic@de.ibm.com>

diffstat:
 qeth.h      |  112 +++++++++++++++++++++++++-----------------------------------
 qeth_eddp.c |   11 ++++-
 qeth_main.c |   17 +++------
 3 files changed, 63 insertions(+), 77 deletions(-)

diff -Naupr git-orig/drivers/s390/net/qeth_eddp.c git-patched/drivers/s390/net/qeth_eddp.c
--- git-orig/drivers/s390/net/qeth_eddp.c	2006-02-07 10:55:28.000000000 +0100
+++ git-patched/drivers/s390/net/qeth_eddp.c	2006-02-07 11:17:11.000000000 +0100
@@ -59,8 +59,7 @@ qeth_eddp_free_context(struct qeth_eddp_
 	for (i = 0; i < ctx->num_pages; ++i)
 		free_page((unsigned long)ctx->pages[i]);
 	kfree(ctx->pages);
-	if (ctx->elements != NULL)
-		kfree(ctx->elements);
+	kfree(ctx->elements);
 	kfree(ctx);
 }
 
@@ -413,6 +412,13 @@ __qeth_eddp_fill_context_tcp(struct qeth
 	
 	QETH_DBF_TEXT(trace, 5, "eddpftcp");
 	eddp->skb_offset = sizeof(struct qeth_hdr) + eddp->nhl + eddp->thl;
+       if (eddp->qh.hdr.l2.id == QETH_HEADER_TYPE_LAYER2) {
+               eddp->skb_offset += sizeof(struct ethhdr);
+#ifdef CONFIG_QETH_VLAN
+               if (eddp->mac.h_proto == __constant_htons(ETH_P_8021Q))
+                       eddp->skb_offset += VLAN_HLEN;
+#endif /* CONFIG_QETH_VLAN */
+       }
 	tcph = eddp->skb->h.th;
 	while (eddp->skb_offset < eddp->skb->len) {
 		data_len = min((int)skb_shinfo(eddp->skb)->tso_size,
@@ -483,6 +489,7 @@ qeth_eddp_fill_context_tcp(struct qeth_e
 		return -ENOMEM;
 	}
 	if (qhdr->hdr.l2.id == QETH_HEADER_TYPE_LAYER2) {
+		skb->mac.raw = (skb->data) + sizeof(struct qeth_hdr);
 		memcpy(&eddp->mac, eth_hdr(skb), ETH_HLEN);
 #ifdef CONFIG_QETH_VLAN
 		if (eddp->mac.h_proto == __constant_htons(ETH_P_8021Q)) {
diff -Naupr git-orig/drivers/s390/net/qeth.h git-patched/drivers/s390/net/qeth.h
--- git-orig/drivers/s390/net/qeth.h	2006-02-07 10:55:28.000000000 +0100
+++ git-patched/drivers/s390/net/qeth.h	2006-02-07 11:17:11.000000000 +0100
@@ -1076,16 +1076,6 @@ qeth_get_qdio_q_format(struct qeth_card 
 }
 
 static inline int
-qeth_isdigit(char * buf)
-{
-	while (*buf) {
-		if (!isdigit(*buf++))
-			return 0;
-	}
-	return 1;
-}
-
-static inline int
 qeth_isxdigit(char * buf)
 {
 	while (*buf) {
@@ -1104,33 +1094,17 @@ qeth_ipaddr4_to_string(const __u8 *addr,
 static inline int
 qeth_string_to_ipaddr4(const char *buf, __u8 *addr)
 {
-	const char *start, *end;
-	char abuf[4];
-	char *tmp;
-	int len;
-	int i;
-
-	start = buf;
-	for (i = 0; i < 4; i++) {
-		if (i == 3) {
-			end = strchr(start,0xa);
-			if (end)
-				len = end - start;
-			else		
-				len = strlen(start);
-		}
-		else {
-			end = strchr(start, '.');
-			len = end - start;
-		}
-		if ((len <= 0) || (len > 3))
-			return -EINVAL;
-		memset(abuf, 0, 4);
-		strncpy(abuf, start, len);
-		if (!qeth_isdigit(abuf))
+	int count = 0, rc = 0;
+	int in[4];
+
+	rc = sscanf(buf, "%d.%d.%d.%d%n", 
+		    &in[0], &in[1], &in[2], &in[3], &count);
+	if (rc != 4  || count) 
+		return -EINVAL;
+	for (count = 0; count < 4; count++) {
+		if (in[count] > 255)
 			return -EINVAL;
-		addr[i] = simple_strtoul(abuf, &tmp, 10);
-		start = end + 1;
+		addr[count] = in[count];
 	}
 	return 0;
 }
@@ -1149,36 +1123,44 @@ qeth_ipaddr6_to_string(const __u8 *addr,
 static inline int
 qeth_string_to_ipaddr6(const char *buf, __u8 *addr)
 {
-	const char *start, *end;
-	u16 *tmp_addr;
-	char abuf[5];
-	char *tmp;
-	int len;
-	int i;
-
-	tmp_addr = (u16 *)addr;
-	start = buf;
-	for (i = 0; i < 8; i++) {
-		if (i == 7) {
-			end = strchr(start,0xa);
-			if (end)
-				len = end - start;
-			else
-				len = strlen(start);
+	char *end, *start;
+	__u16 *in;
+        char num[5];
+        int num2, cnt, out, found, save_cnt;
+        unsigned short in_tmp[8] = {0, };
+
+	cnt = out = found = save_cnt = num2 = 0;
+        end = start = (char *) buf;
+	in = (__u16 *) addr;	
+	memset(in, 0, 16);
+        while (end) {
+                end = strchr(end,':');
+                if (end == NULL) {
+                        end = (char *)buf + (strlen(buf));
+                        out = 1;
+                }
+                if ((end - start)) { 
+                        memset(num, 0, 5);
+                        memcpy(num, start, end - start);
+			if (!qeth_isxdigit(num))
+				return -EINVAL;
+                        sscanf(start, "%x", &num2);
+                        if (found)
+                                in_tmp[save_cnt++] = num2;
+                        else
+                                in[cnt++] = num2;
+                        if (out)
+                                break;
+                } else {
+			if (found)
+				return -EINVAL;
+                        found = 1;
 		}
-		else {
-			end = strchr(start, ':');
-			len = end - start;
-		}
-		if ((len <= 0) || (len > 4))
-			return -EINVAL;
-		memset(abuf, 0, 5);
-		strncpy(abuf, start, len);
-		if (!qeth_isxdigit(abuf))
-			return -EINVAL;
-		tmp_addr[i] = simple_strtoul(abuf, &tmp, 16);
-		start = end + 1;
-	}
+		start = ++end;
+        }
+        cnt = 7;
+	while (save_cnt)
+                in[cnt--] = in_tmp[--save_cnt];
 	return 0;
 }
 
diff -Naupr git-orig/drivers/s390/net/qeth_main.c git-patched/drivers/s390/net/qeth_main.c
--- git-orig/drivers/s390/net/qeth_main.c	2006-02-07 10:55:28.000000000 +0100
+++ git-patched/drivers/s390/net/qeth_main.c	2006-02-07 11:22:00.000000000 +0100
@@ -516,7 +516,8 @@ __qeth_set_offline(struct ccwgroup_devic
 	QETH_DBF_TEXT(setup, 3, "setoffl");
 	QETH_DBF_HEX(setup, 3, &card, sizeof(void *));
 	
-	netif_carrier_off(card->dev);
+	if (card->dev && netif_carrier_ok(card->dev))
+		netif_carrier_off(card->dev);
 	recover_flag = card->state;
 	if (qeth_stop_card(card, recovery_mode) == -ERESTARTSYS){
 		PRINT_WARN("Stopping card %s interrupted by user!\n",
@@ -1679,6 +1680,7 @@ qeth_cmd_timeout(unsigned long data)
 	spin_unlock_irqrestore(&reply->card->lock, flags);
 }
 
+
 static struct qeth_ipa_cmd *
 qeth_check_ipa_data(struct qeth_card *card, struct qeth_cmd_buffer *iob)
 {
@@ -1699,7 +1701,8 @@ qeth_check_ipa_data(struct qeth_card *ca
 					   QETH_CARD_IFNAME(card),
 					   card->info.chpid);
 				card->lan_online = 0;
-				netif_carrier_off(card->dev);
+				if (card->dev && netif_carrier_ok(card->dev))
+					netif_carrier_off(card->dev);
 				return NULL;
 			case IPA_CMD_STARTLAN:
 				PRINT_INFO("Link reestablished on %s "
@@ -5562,7 +5565,7 @@ qeth_set_multicast_list(struct net_devic
 	if (card->info.type == QETH_CARD_TYPE_OSN)
 		return ;
 	 
-	QETH_DBF_TEXT(trace,3,"setmulti");
+	QETH_DBF_TEXT(trace, 3, "setmulti");
 	qeth_delete_mc_addresses(card);
 	if (card->options.layer2) {
 		qeth_layer2_add_multicast(card);
@@ -5579,7 +5582,6 @@ out:
 		return;
 	if (qeth_set_thread_start_bit(card, QETH_SET_PROMISC_MODE_THREAD)==0)
 		schedule_work(&card->kernel_thread_starter);
-
 }
 
 static int
@@ -7452,6 +7454,7 @@ qeth_softsetup_card(struct qeth_card *ca
 		card->lan_online = 1;
 	if (card->info.type==QETH_CARD_TYPE_OSN)
 		goto out;
+	qeth_set_large_send(card, card->options.large_send);
 	if (card->options.layer2) {
 		card->dev->features |=
 			NETIF_F_HW_VLAN_FILTER |
@@ -7468,12 +7471,6 @@ qeth_softsetup_card(struct qeth_card *ca
 #endif
 		goto out;
 	}
-	if ((card->options.large_send == QETH_LARGE_SEND_EDDP) ||
-	    (card->options.large_send == QETH_LARGE_SEND_TSO))
-		card->dev->features |= NETIF_F_TSO | NETIF_F_SG;
-	else
-		card->dev->features &= ~(NETIF_F_TSO | NETIF_F_SG);
-
 	if ((rc = qeth_setadapter_parms(card)))
 		QETH_DBF_TEXT_(setup, 2, "2err%d", rc);
 	if ((rc = qeth_start_ipassists(card)))
