Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262935AbUC2Mlx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 07:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbUC2MkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:40:04 -0500
Received: from moutng.kundenserver.de ([212.227.126.185]:36824 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262923AbUC2Mi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:38:57 -0500
Date: Mon, 29 Mar 2004 14:38:41 +0200
From: Armin Schindler <armin@melware.de>
Message-Id: <200403291238.i2TCcfDp021931@phoenix.one.melware.de>
To: torvalds@osdl.org, akpm@osdl.org
Subject: [PATCH] 2.6 ISDN CAPI: fix capiminor_alloc()
Cc: i4ldeveloper@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Hi Linus,

this patch fixes assigning a correct minor for the capi tty.

Please apply.

Thanks,
Armin


Name: ISDN CAPI: fix capiminor_alloc() to assign lowest free minor 
Author: Frank A. Uepping

D: This fixes capiminor_alloc() to assign the lowest free minor for a 
   new capi_tty. Thanks to Frank A. Uepping and Tim Woods.



--- linux-2.5/drivers/isdn/capi/capi.c_orig	Mon Mar 29 14:25:49 2004
+++ linux-2.5/drivers/isdn/capi/capi.c	Mon Mar 29 14:25:54 2004
@@ -1,4 +1,4 @@
-/* $Id: capi.c,v 1.1.2.3 2004/01/16 21:09:26 keil Exp $
+/* $Id: capi.c,v 1.1.2.4 2004/03/29 10:38:02 armin Exp $
  *
  * CAPI 2.0 Interface for Linux
  *
@@ -44,7 +44,7 @@
 #include "capifs.h"
 #endif
 
-static char *revision = "$Revision: 1.1.2.3 $";
+static char *revision = "$Revision: 1.1.2.4 $";
 
 MODULE_DESCRIPTION("CAPI4Linux: Userspace /dev/capi20 interface");
 MODULE_AUTHOR("Carsten Paeth");
@@ -200,7 +200,6 @@
 static struct capiminor *capiminor_alloc(struct capi20_appl *ap, u32 ncci)
 {
 	struct capiminor *mp, *p;
-	struct list_head *l;
 	unsigned int minor = 0;
 	unsigned long flags;
 
@@ -219,26 +218,31 @@
 	skb_queue_head_init(&mp->inqueue);
 	skb_queue_head_init(&mp->outqueue);
 
+	/* Allocate the least unused minor number.
+	 */
 	write_lock_irqsave(&capiminor_list_lock, flags);
-	if (list_empty(&capiminor_list)) {
+	if (list_empty(&capiminor_list))
 		list_add(&mp->list, &capiminor_list);
-		write_unlock_irqrestore(&capiminor_list_lock, flags);
-	} else {
-		list_for_each(l, &capiminor_list) {
-			p = list_entry(l, struct capiminor, list);
-			if (p->minor > minor) {
-				mp->minor = minor;
-				list_add_tail(&mp->list, &p->list);
+	else {
+		list_for_each_entry(p, &capiminor_list, list) {
+			if (p->minor > minor)
 				break;
-			}
 			minor++;
 		}
+		
+		if (minor < capi_ttyminors) {
+			mp->minor = minor;
+			list_add(&mp->list, p->list.prev);
+		}
+	}
 		write_unlock_irqrestore(&capiminor_list_lock, flags);
-		if (l == &capiminor_list) {
+
+	if (!(minor < capi_ttyminors)) {
+		printk(KERN_NOTICE "capi: out of minors\n");
 			kfree(mp);
-			return NULL;
-		}
+		return 0;
 	}
+
 	return mp;
 }
 
