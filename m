Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262502AbVCXO71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262502AbVCXO71 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 09:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262517AbVCXO71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 09:59:27 -0500
Received: from geode.he.net ([216.218.230.98]:37132 "HELO noserose.net")
	by vger.kernel.org with SMTP id S262502AbVCXO7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 09:59:21 -0500
From: ecashin@noserose.net
Message-Id: <1111676358.20123@geode.he.net>
Date: Thu, 24 Mar 2005 06:59:18 -0800
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.11] aoe [1/12]: remove too-low cap on minor number
References: <87mztbi79d.fsf@coraid.com> <20050317234641.GA7091@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


remove too-low cap on minor number

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>

diff -uprN a/drivers/block/aoe/aoe.h b/drivers/block/aoe/aoe.h
--- a/drivers/block/aoe/aoe.h	2005-03-10 11:59:55.000000000 -0500
+++ b/drivers/block/aoe/aoe.h	2005-03-10 12:19:04.000000000 -0500
@@ -2,9 +2,14 @@
 #define VERSION "5"
 #define AOE_MAJOR 152
 #define DEVICE_NAME "aoe"
+
+/* set AOE_PARTITIONS to 1 to use whole-disks only
+ * default is 16, which is 15 partitions plus the whole disk
+ */
 #ifndef AOE_PARTITIONS
 #define AOE_PARTITIONS 16
 #endif
+
 #define SYSMINOR(aoemajor, aoeminor) ((aoemajor) * 10 + (aoeminor))
 #define AOEMAJOR(sysminor) ((sysminor) / 10)
 #define AOEMINOR(sysminor) ((sysminor) % 10)
diff -uprN a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
--- a/drivers/block/aoe/aoecmd.c	2005-03-10 11:59:55.000000000 -0500
+++ b/drivers/block/aoe/aoecmd.c	2005-03-10 12:19:04.000000000 -0500
@@ -577,7 +577,7 @@ aoecmd_cfg_rsp(struct sk_buff *skb)
 	struct aoe_cfghdr *ch;
 	ulong flags, bufcnt, sysminor, aoemajor;
 	struct sk_buff *sl;
-	enum { MAXFRAMES = 8, MAXSYSMINOR = 255 };
+	enum { MAXFRAMES = 8 };
 
 	h = (struct aoe_hdr *) skb->mac.raw;
 	ch = (struct aoe_cfghdr *) (h+1);
@@ -594,9 +594,10 @@ aoecmd_cfg_rsp(struct sk_buff *skb)
 	}
 
 	sysminor = SYSMINOR(aoemajor, h->minor);
-	if (sysminor > MAXSYSMINOR) {
-		printk(KERN_INFO "aoe: aoecmd_cfg_rsp: sysminor %ld too "
-			"large\n", sysminor);
+	if (sysminor * AOE_PARTITIONS + AOE_PARTITIONS > MINORMASK) {
+		printk(KERN_INFO
+			"aoe: e%ld.%d: minor number too large\n", 
+			aoemajor, (int) h->minor);
 		return;
 	}
 


-- 
  Ed L. Cashin <ecashin@coraid.com>
