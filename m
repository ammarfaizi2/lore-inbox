Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268304AbUHQPXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268304AbUHQPXt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 11:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268302AbUHQPWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 11:22:51 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:4317 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S268290AbUHQPP3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 11:15:29 -0400
Message-ID: <412220DD.7030802@ttnet.net.tr>
Date: Tue, 17 Aug 2004 18:14:37 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com
Subject: [PATCH] [2.4.28-pre1] more gcc3.4 inline fixes [3/10]
Content-Type: multipart/mixed;
	boundary="------------060904000601000508060303"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060904000601000508060303
Content-Type: text/plain;
	charset=ISO-8859-9;
	format=flowed
Content-Transfer-Encoding: 7bit


--------------060904000601000508060303
Content-Type: text/plain;
	name="gcc34_inline_03.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="gcc34_inline_03.diff"

--- 28p1/drivers/ieee1394/eth1394.c~	2003-11-28 20:26:20.000000000 +0200
+++ 28p1/drivers/ieee1394/eth1394.c	2004-08-16 21:51:42.000000000 +0300
@@ -149,6 +149,20 @@
 		 "(default = 25).");
 static int max_partial_datagrams = 25;
 
+static inline void purge_partial_datagram(struct list_head *old)
+{
+	struct partial_datagram *pd = list_entry(old, struct partial_datagram, list);
+	struct list_head *lh, *n;
+
+	list_for_each_safe(lh, n, &pd->frag_info) {
+		struct fragment_info *fi = list_entry(lh, struct fragment_info, list);
+		list_del(lh);
+		kfree(fi);
+	}
+	list_del(old);
+	kfree_skb(pd->skb);
+	kfree(pd);
+}
 
 static int ether1394_header(struct sk_buff *skb, struct net_device *dev,
 			    unsigned short type, void *daddr, void *saddr,
@@ -885,21 +899,6 @@
 	return 0;
 }
 
-static inline void purge_partial_datagram(struct list_head *old)
-{
-	struct partial_datagram *pd = list_entry(old, struct partial_datagram, list);
-	struct list_head *lh, *n;
-
-	list_for_each_safe(lh, n, &pd->frag_info) {
-		struct fragment_info *fi = list_entry(lh, struct fragment_info, list);
-		list_del(lh);
-		kfree(fi);
-	}
-	list_del(old);
-	kfree_skb(pd->skb);
-	kfree(pd);
-}
-
 static inline int is_datagram_complete(struct list_head *lh, int dg_size)
 {
 	struct partial_datagram *pd = list_entry(lh, struct partial_datagram, list);
--- 28p1/drivers/isdn/hisax/isar.c~	2003-06-13 17:51:34.000000000 +0300
+++ 28p1/drivers/isdn/hisax/isar.c	2004-08-16 22:02:53.000000000 +0300
@@ -428,6 +428,21 @@
 	return(ret);
 }
 
+static inline void
+ll_deliver_faxstat(struct BCState *bcs, u_char status)
+{
+        isdn_ctrl ic;
+	struct Channel *chanp = (struct Channel *) bcs->st->lli.userdata;
+ 
+	if (bcs->cs->debug & L1_DEB_HSCX)
+		debugl1(bcs->cs, "HL->LL FAXIND %x", status);
+	ic.driver = bcs->cs->myid;
+	ic.command = ISDN_STAT_FAXIND;
+	ic.arg = chanp->chan;
+	ic.parm.aux.cmd = status;
+	bcs->cs->iif.statcallb(&ic);
+}
+
 extern void BChannel_bh(struct BCState *);
 #define B_LL_NOCARRIER	8
 #define B_LL_CONNECT	9
@@ -962,21 +977,6 @@
 	}
 }
 
-static inline void
-ll_deliver_faxstat(struct BCState *bcs, u_char status)
-{
-        isdn_ctrl ic;
-	struct Channel *chanp = (struct Channel *) bcs->st->lli.userdata;
- 
-	if (bcs->cs->debug & L1_DEB_HSCX)
-		debugl1(bcs->cs, "HL->LL FAXIND %x", status);
-	ic.driver = bcs->cs->myid;
-	ic.command = ISDN_STAT_FAXIND;
-	ic.arg = chanp->chan;
-	ic.parm.aux.cmd = status;
-	bcs->cs->iif.statcallb(&ic);
-}
-
 static void
 isar_pump_statev_fax(struct BCState *bcs, u_char devt) {
 	struct IsdnCardState *cs = bcs->cs;

--------------060904000601000508060303--
