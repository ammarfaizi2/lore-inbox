Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWGBW6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWGBW6T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 18:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWGBW6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 18:58:19 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:32469 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751066AbWGBW6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 18:58:19 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 3 Jul 2006 00:58:01 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 03/19] ieee1394: fix cosmetic problem in speed probe
To: Ben Collins <bcollins@ubuntu.com>
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
Message-ID: <tkrat.e00aa2fc2df8d106@s5r6.in-berlin.de>
References: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.016) AWL,BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If ieee1394.h::IEEE1394_SPEED_MAX is bigger than the actual speed of an
1394b host adapter and the speed to another 1394b node was probed, a
bigger speed than actually used was kept in host->speed[n].  The only
resulting problem so far was sbp2 displaying bogus values in the syslog,
e.g. S3200 for actual S800 connections if IEEE1394_SPEED_MAX was S3200.
But other high-level drivers which access this field could get into more
trouble.  (Eth1394 is the only other in-tree driver which does so.  It
seems it is not affected.)

Nodemgr now clips this value according to the host adapter's link speed.

A pointer expression in nodemgr_check_speed is also changed for clarity.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/nodemgr.c
===================================================================
--- linux.orig/drivers/ieee1394/nodemgr.c	2006-07-02 12:02:06.000000000 +0200
+++ linux/drivers/ieee1394/nodemgr.c	2006-07-02 12:10:49.000000000 +0200
@@ -71,7 +71,7 @@ static int nodemgr_check_speed(struct no
 	u8 i, *speed, old_speed, good_speed;
 	int ret;
 
-	speed = ci->host->speed + NODEID_TO_NODE(ci->nodeid);
+	speed = &(ci->host->speed[NODEID_TO_NODE(ci->nodeid)]);
 	old_speed = *speed;
 	good_speed = IEEE1394_SPEED_MAX + 1;
 
@@ -1251,6 +1251,7 @@ static void nodemgr_node_scan_one(struct
 	octlet_t guid;
 	struct csr1212_csr *csr;
 	struct nodemgr_csr_info *ci;
+	u8 *speed;
 
 	ci = kmalloc(sizeof(*ci), GFP_KERNEL);
 	if (!ci)
@@ -1259,8 +1260,12 @@ static void nodemgr_node_scan_one(struct
 	ci->host = host;
 	ci->nodeid = nodeid;
 	ci->generation = generation;
-	ci->speed_unverified =
-		host->speed[NODEID_TO_NODE(nodeid)] > IEEE1394_SPEED_100;
+
+	/* Prepare for speed probe which occurs when reading the ROM */
+	speed = &(host->speed[NODEID_TO_NODE(nodeid)]);
+	if (*speed > host->csr.lnk_spd)
+		*speed = host->csr.lnk_spd;
+	ci->speed_unverified = *speed > IEEE1394_SPEED_100;
 
 	/* We need to detect when the ConfigROM's generation has changed,
 	 * so we only update the node's info when it needs to be.  */
@@ -1300,8 +1305,6 @@ static void nodemgr_node_scan_one(struct
 		nodemgr_create_node(guid, csr, hi, nodeid, generation);
 	else
 		nodemgr_update_node(ne, csr, hi, nodeid, generation);
-
-	return;
 }
 
 


