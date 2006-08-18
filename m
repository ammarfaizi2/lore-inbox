Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161077AbWHRS4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161077AbWHRS4j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161082AbWHRSzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:55:21 -0400
Received: from ns1.coraid.com ([65.14.39.133]:58469 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S1161077AbWHRSy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:54:59 -0400
Message-ID: <a47db3897e5de69fbe6bfaf1fea169a2@coraid.com>
Date: Fri, 18 Aug 2006 13:39:55 -0400
To: linux-kernel@vger.kernel.org
Cc: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.18-rc4] aoe [10/13]: module parameter for device timeout
References: <E1GE8K3-0008Jn-00@kokone.coraid.com>
From: "Ed L. Cashin" <ecashin@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

The aoe_deadsecs module parameter sets the number of seconds that
elapse before a nonresponsive AoE device is marked as dead.

diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoecmd.c 2.6.18-rc4-aoe/drivers/block/aoe/aoecmd.c
--- 2.6.18-rc4-orig/drivers/block/aoe/aoecmd.c	2006-08-17 16:45:34.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoecmd.c	2006-08-17 16:45:34.000000000 -0400
@@ -15,7 +15,10 @@
 #define TIMERTICK (HZ / 10)
 #define MINTIMER (2 * TIMERTICK)
 #define MAXTIMER (HZ << 1)
-#define MAXWAIT (60 * 3)	/* After MAXWAIT seconds, give up and fail dev */
+
+static int aoe_deadsecs = 60 * 3;
+module_param(aoe_deadsecs, int, 0644);
+MODULE_PARM_DESC(aoe_deadsecs, "After aoe_deadsecs seconds, give up and fail dev.");
 
 struct sk_buff *
 new_skb(ulong len)
@@ -373,7 +376,7 @@ rexmit_timer(ulong vp)
 		if (f->tag != FREETAG && tsince(f->tag) >= timeout) {
 			n = f->waited += timeout;
 			n /= HZ;
-			if (n > MAXWAIT) { /* waited too long.  device failure. */
+			if (n > aoe_deadsecs) { /* waited too long for response */
 				aoedev_downdev(d);
 				break;
 			}


-- 
  "Ed L. Cashin" <ecashin@coraid.com>
