Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751701AbWD1DKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbWD1DKT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 23:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbWD1DKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 23:10:19 -0400
Received: from c-67-191-14-151.hsd1.fl.comcast.net ([67.191.14.151]:53245 "EHLO
	samantha") by vger.kernel.org with ESMTP id S1751701AbWD1DKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 23:10:18 -0400
Message-Id: <p06210202beea43ef060b@[192.168.1.96]>
Date: Thu Apr 13 23:42:09 EDT 2006 -0400
To: yoshfuji@linux-ipv6.org
Cc: opendon@donlaw.com, davem@davemloft.net, kuznet@ms2.inr.ac.ru,
       pekkas@netcore.fi, jmorris@namei.org, kaber@coreworks.de,
       linux-kernel@vger.kernel.org
From: Don Law <opendon@donlaw.com>
Subject: [PATCH linux-2.6.17-rc1] net: fix neigh_delete to handle mult. tables
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm resending the patch I just sent. Sorry - it looks like my
mailer likes to damage the white space in the patch.

This version should be cleaner:

Signed-off-by: Don Law <opendon@donlaw.com>

--- linux-2.6.17-rc1/net/core/neighbour.c.orig	2006-04-11 16:28:10.000000000 -0400
+++ linux-2.6.17-rc1/net/core/neighbour.c	2006-04-26 23:36:04.535992104 -0400
@@ -1430,48 +1430,55 @@ int neigh_delete(struct sk_buff *skb, st
 	struct rtattr **nda = arg;
 	struct neigh_table *tbl;
 	struct net_device *dev = NULL;
-	int err = -ENODEV;
+	int err;
 
 	if (ndm->ndm_ifindex &&
-	    (dev = dev_get_by_index(ndm->ndm_ifindex)) == NULL)
-		goto out;
+			(dev = dev_get_by_index(ndm->ndm_ifindex)) == NULL)
+		return -ENODEV;
 
 	read_lock(&neigh_tbl_lock);
-	for (tbl = neigh_tables; tbl; tbl = tbl->next) {
+	for (tbl = neigh_tables; ; tbl = tbl->next) {
 		struct rtattr *dst_attr = nda[NDA_DST - 1];
 		struct neighbour *n;
 
+		if (!tbl) {
+			read_unlock(&neigh_tbl_lock);
+			err = -EADDRNOTAVAIL;
+			break;
+		}
 		if (tbl->family != ndm->ndm_family)
 			continue;
-		read_unlock(&neigh_tbl_lock);
 
 		err = -EINVAL;
-		if (!dst_attr || RTA_PAYLOAD(dst_attr) < tbl->key_len)
-			goto out_dev_put;
+		if (!dst_attr || RTA_PAYLOAD(dst_attr) < tbl->key_len) {
+			read_unlock(&neigh_tbl_lock);
+			break;
+		}
 
 		if (ndm->ndm_flags & NTF_PROXY) {
-			err = pneigh_delete(tbl, RTA_DATA(dst_attr), dev);
-			goto out_dev_put;
+			if (!pneigh_delete(tbl, RTA_DATA(dst_attr), dev)) {
+				read_unlock(&neigh_tbl_lock);
+				break;
+			}
 		}
 
-		if (!dev)
-			goto out;
+		if (!dev) {
+			read_unlock(&neigh_tbl_lock);
+			break;
+		}
 
 		n = neigh_lookup(tbl, RTA_DATA(dst_attr), dev);
 		if (n) {
-			err = neigh_update(n, NULL, NUD_FAILED, 
+			read_unlock(&neigh_tbl_lock);
+			err = neigh_update(n, NULL, NUD_FAILED,
 					   NEIGH_UPDATE_F_OVERRIDE|
 					   NEIGH_UPDATE_F_ADMIN);
 			neigh_release(n);
+			break;
 		}
-		goto out_dev_put;
 	}
-	read_unlock(&neigh_tbl_lock);
-	err = -EADDRNOTAVAIL;
-out_dev_put:
 	if (dev)
 		dev_put(dev);
-out:
 	return err;
 }
 
