Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264584AbUFVO7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264584AbUFVO7P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 10:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUFVO63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 10:58:29 -0400
Received: from [203.199.60.6] ([203.199.60.6]:21011 "EHLO Mailout.ltindia.com")
	by vger.kernel.org with ESMTP id S264444AbUFVOuj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 10:50:39 -0400
Message-Id: <s0d894d5.036@EMAIL>
X-Mailer: Novell GroupWise Internet Agent 6.0.3
Date: Tue, 22 Jun 2004 20:21:24 +0530
From: "Kishore A K" <kishoreak@myw.ltindia.com>
To: <shemminger@osdl.org>
Cc: <bridge@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [Patch] [2.6.7] Bridge - Fix BPDU message_age
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Mailout/ltindia(Release 6.5|September 26, 2003) at
 06/22/2004 08:21:24 PM,
	Serialize by Router on Mailout/ltindia(Release 6.5|September 26, 2003) at
 06/22/2004 08:21:48 PM,
	Serialize complete at 06/22/2004 08:21:48 PM
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes message_age field update in config BPDUs. Also checks whether the BPDU 
message age has exceeded bridge max age before transmitting config BPDUs.

Signed-off-by: Kishore A K <KishoreAK@myw.ltindia.com>

Index: linux-2.6.7/net/bridge/br_stp.c
=============================================================

--- linux-2.6.7/net/bridge/br_stp.c.orig	2004-06-17 20:17:27.000000000 +0530
+++ linux-2.6.7/net/bridge/br_stp.c	2004-06-22 19:32:49.015908632 +0530
@@ -161,20 +161,19 @@ void br_transmit_config(struct net_bridg
 	if (!br_is_root_bridge(br)) {
 		struct net_bridge_port *root
 			= br_get_port(br, br->root_port);
-		bpdu.max_age = root->message_age_timer.expires - jiffies;
-
-		if (bpdu.max_age <= 0) bpdu.max_age = 1;
+		bpdu.message_age = br->max_age - 
+			(root->message_age_timer.expires - jiffies) + 1;
 	}
 	bpdu.max_age = br->max_age;
 	bpdu.hello_time = br->hello_time;
 	bpdu.forward_delay = br->forward_delay;
 
-	br_send_config_bpdu(p, &bpdu);
-
-	p->topology_change_ack = 0;
-	p->config_pending = 0;
-	
-	mod_timer(&p->hold_timer, jiffies + BR_HOLD_TIME);
+	if (bpdu.message_age < br->max_age) {
+		br_send_config_bpdu(p, &bpdu);
+		p->topology_change_ack = 0;
+		p->config_pending = 0;
+		mod_timer(&p->hold_timer, jiffies + BR_HOLD_TIME);
+	}
 }
 
 /* called under bridge lock */


