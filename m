Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWITS5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWITS5i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWITS5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:57:32 -0400
Received: from ns1.coraid.com ([65.14.39.133]:46456 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S932260AbWITS5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:57:04 -0400
Message-ID: <c74a505f0ee8714dd6aecc33f7188caf@coraid.com>
Date: Wed, 20 Sep 2006 14:36:50 -0400
To: linux-kernel@vger.kernel.org
Cc: ecashin@coraid.com, Greg K-H <greg@kroah.com>
Subject: [PATCH 2.6.18-rc4] aoe [10/14]: module parameter for device timeout
References: <E1GQ6uv-0001qi-00@kokone>
From: "Ed L. Cashin" <ecashin@coraid.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The aoe_deadsecs module parameter sets the number of seconds that
elapse before a nonresponsive AoE device is marked as dead.

This is runtime settable in sysfs or settable with a module load or
kernel boot parameter.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
---

diff -upr 2.6.18-rc4-orig/drivers/block/aoe/aoecmd.c 2.6.18-rc4-aoe/drivers/block/aoe/aoecmd.c
--- 2.6.18-rc4-orig/drivers/block/aoe/aoecmd.c	2006-09-20 14:29:36.000000000 -0400
+++ 2.6.18-rc4-aoe/drivers/block/aoe/aoecmd.c	2006-09-20 14:29:36.000000000 -0400
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
