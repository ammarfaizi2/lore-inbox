Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbUBTSdG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 13:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbUBTSdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 13:33:06 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:56540 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261235AbUBTSc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 13:32:57 -0500
Subject: [PATCH] Fix ISDN v.110.
From: David Woodhouse <dwmw2@infradead.org>
To: torvalds@osdl.org
Cc: kkeil@suse.de, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1077301973.427.538.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Fri, 20 Feb 2004 18:32:54 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we coalesce ACKs for outgoing packets, the v.110 code needs to
look at the size it's given rather than assuming it'll get precisely one
callback for each packet sent...

===== drivers/isdn/i4l/isdn_v110.c 1.15 vs edited =====
--- 1.15/drivers/isdn/i4l/isdn_v110.c	Thu Feb 19 03:42:12 2004
+++ edited/drivers/isdn/i4l/isdn_v110.c	Thu Feb 19 20:39:46 2004
@@ -535,13 +535,15 @@
 			if (!(v = dev->v110[idx]))
 				return 0;
 			atomic_inc(&dev->v110use[idx]);
-			if (v->skbidle > 0) {
-				v->skbidle--;
-				ret = 1;
-			} else {
-				if (v->skbuser > 0)
-					v->skbuser--;
-				ret = 0;
+			for (i=0; i * v->framelen < c->parm.length; i++) {
+				if (v->skbidle > 0) {
+					v->skbidle--;
+					ret = 1;
+				} else {
+					if (v->skbuser > 0)
+						v->skbuser--;
+					ret = 0;
+				}
 			}
 			for (i = v->skbuser + v->skbidle; i < 2; i++) {
 				struct sk_buff *skb;


-- 
dwmw2

