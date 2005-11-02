Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932600AbVKBIl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbVKBIl2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 03:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbVKBIl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 03:41:28 -0500
Received: from pop3.ispwest.com ([216.52.245.18]:20498 "EHLO
	ispwest-email1.mdeinc.com") by vger.kernel.org with ESMTP
	id S932600AbVKBIl1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 03:41:27 -0500
X-Modus-BlackList: 216.52.245.25=OK;kjak@ispwest.com=OK
X-Modus-Trusted: 216.52.245.25=YES
Message-ID: <e626300280b94e0abc26defcc6043b91.kjak@ispwest.com>
X-EM-APIVersion: 2, 0, 1, 0
X-Priority: 3 (Normal)
Reply-To: "Kris Katterjohn" <kjak@users.sourceforge.net>
From: "Kris Katterjohn" <kjak@ispwest.com>
To: jschlst@samba.org
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Merge __load_pointer() and load_pointer() in net/core/filter.c; kernel 2.6.14
Date: Wed, 2 Nov 2005 00:41:15 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another patch for net/core/filter.c by me. I merged __load_pointer() into
load_pointer(). I don't see a point in having two seperate functions when
both functions are really small and load_pointer() calls __load_pointer().
Renamed the variable "k" to "offset" since that's what it is, and in
skb_header_pointer() it's "offset".

This patch is a diff from kernel 2.6.14

Thanks



Signed-off-by: Kris Katterjohn <kjak@users.sourceforge.net>

---


--- x/net/core/filter.c	2005-10-27 19:02:08.000000000 -0500
+++ y/net/core/filter.c	2005-11-02 02:05:40.000000000 -0600
@@ -13,6 +13,8 @@
  * 2 of the License, or (at your option) any later version.
  *
  * Andi Kleen - Fix a few bad bugs and races.
+ * Kris Katterjohn - Merged __load_pointer() into load_pointer() and
+ *                   cleaned it up a little bit - 2005-11-01
  */
 
 #include <linux/module.h>
@@ -35,31 +37,27 @@
 #include <asm/uaccess.h>
 #include <linux/filter.h>
 
-/* No hurry in this branch */
-static void *__load_pointer(struct sk_buff *skb, int k)
+static inline void *load_pointer(struct sk_buff *skb, int offset,
+                                 unsigned int size, void *buffer)
 {
 	u8 *ptr = NULL;
 
-	if (k >= SKF_NET_OFF)
-		ptr = skb->nh.raw + k - SKF_NET_OFF;
-	else if (k >= SKF_LL_OFF)
-		ptr = skb->mac.raw + k - SKF_LL_OFF;
+	if (offset >= 0)
+		return skb_header_pointer(skb, offset, size, buffer);
+
+	if (offset >= SKF_AD_OFF)
+		return NULL;
+
+	if (offset >= SKF_NET_OFF)
+		ptr = skb->nh.raw + offset - SKF_NET_OFF;
+
+	else if (offset >= SKF_LL_OFF)
+		ptr = skb->mac.raw + offset - SKF_LL_OFF;
 
 	if (ptr >= skb->head && ptr < skb->tail)
 		return ptr;
-	return NULL;
-}
 
-static inline void *load_pointer(struct sk_buff *skb, int k,
-                                 unsigned int size, void *buffer)
-{
-	if (k >= 0)
-		return skb_header_pointer(skb, k, size, buffer);
-	else {
-		if (k >= SKF_AD_OFF)
-			return NULL;
-		return __load_pointer(skb, k);
-	}
+	return NULL;
 }
 
 /**



