Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264477AbUDZKG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264477AbUDZKG5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 06:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264471AbUDZKG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 06:06:57 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:13552 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264477AbUDZKGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 06:06:40 -0400
Date: Mon, 26 Apr 2004 12:06:29 +0200
From: Armin Schindler <armin@melware.de>
Message-Id: <200404261006.i3QA6TTd009454@phoenix.one.melware.de>
To: torvalds@osdl.org, akpm@osdl.org
Subject: [PATCH] 2.6 ISDN CAPI: add ncci list semaphore
Cc: i4ldeveloper@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Hi Linus,

this patch adds a sempahore for the ISDN CAPI internal
ncci list handling.

Please apply.

Thanks,
Armin


Name: ISDN CAPI: add ncci list semaphore 
Author: Armin Schindler

D: Fix race conditions of ISDN CAPI's internal ncci
   list handling by using a per capidev semaphore.




--- linux-2.6/drivers/isdn/capi/capi.c.orig	2004-04-26 11:49:08.000000000 +0200
+++ linux-2.6/drivers/isdn/capi/capi.c	2004-04-26 11:33:07.000000000 +0200
@@ -1,4 +1,4 @@
-/* $Id: capi.c,v 1.1.2.4 2004/03/29 10:38:02 armin Exp $
+/* $Id: capi.c,v 1.1.2.6 2004/04/26 09:33:07 armin Exp $
  *
  * CAPI 2.0 Interface for Linux
  *
@@ -45,7 +45,7 @@
 #include "capifs.h"
 #endif
 
-static char *revision = "$Revision: 1.1.2.4 $";
+static char *revision = "$Revision: 1.1.2.6 $";
 
 MODULE_DESCRIPTION("CAPI4Linux: Userspace /dev/capi20 interface");
 MODULE_AUTHOR("Carsten Paeth");
@@ -136,6 +136,8 @@
 	wait_queue_head_t recvwait;
 
 	struct capincci *nccis;
+
+	struct semaphore ncci_list_sem;
 };
 
 /* -------- global variables ---------------------------------------- */
@@ -378,6 +380,7 @@
 		return 0;
 	memset(cdev, 0, sizeof(struct capidev));
 
+	init_MUTEX(&cdev->ncci_list_sem);
 	skb_queue_head_init(&cdev->recvqueue);
 	init_waitqueue_head(&cdev->recvwait);
 	write_lock_irqsave(&capidev_list_lock, flags);
@@ -396,6 +399,10 @@
 	}
 	skb_queue_purge(&cdev->recvqueue);
 
+	down(&cdev->ncci_list_sem);
+	capincci_free(cdev, 0xffffffff);
+	up(&cdev->ncci_list_sem);
+
 	write_lock_irqsave(&capidev_list_lock, flags);
 	list_del(&cdev->list);
 	write_unlock_irqrestore(&capidev_list_lock, flags);
@@ -569,11 +576,16 @@
 
 	if (CAPIMSG_CMD(skb->data) == CAPI_CONNECT_B3_CONF) {
 		u16 info = CAPIMSG_U16(skb->data, 12); // Info field
-		if (info == 0)
+		if (info == 0) {
+			down(&cdev->ncci_list_sem);
 			capincci_alloc(cdev, CAPIMSG_NCCI(skb->data));
+			up(&cdev->ncci_list_sem);
+		}
 	}
 	if (CAPIMSG_CMD(skb->data) == CAPI_CONNECT_B3_IND) {
+		down(&cdev->ncci_list_sem);
 		capincci_alloc(cdev, CAPIMSG_NCCI(skb->data));
+		up(&cdev->ncci_list_sem);
 	}
 	if (CAPIMSG_COMMAND(skb->data) != CAPI_DATA_B3) {
 		skb_queue_tail(&cdev->recvqueue, skb);
@@ -716,8 +728,9 @@
 	CAPIMSG_SETAPPID(skb->data, cdev->ap.applid);
 
 	if (CAPIMSG_CMD(skb->data) == CAPI_DISCONNECT_B3_RESP) {
+		down(&cdev->ncci_list_sem);
 		capincci_free(cdev, CAPIMSG_NCCI(skb->data));
-			
+		up(&cdev->ncci_list_sem);
 	}
 
 	cdev->errcode = capi20_put_message(&cdev->ap, skb);
@@ -904,13 +917,17 @@
 			if (copy_from_user((void *)&ncci, (void *)arg,
 					   sizeof(ncci)))
 				return -EFAULT;
-			nccip = capincci_find(cdev, (u32) ncci);
-			if (!nccip)
+
+			down(&cdev->ncci_list_sem);
+			if ((nccip = capincci_find(cdev, (u32) ncci)) == 0) {
+				up(&cdev->ncci_list_sem);
 				return 0;
+			}
 #ifdef CONFIG_ISDN_CAPI_MIDDLEWARE
 			if ((mp = nccip->minorp) != 0) {
 				count += atomic_read(&mp->ttyopencount);
 			}
+			up(&cdev->ncci_list_sem);
 #endif /* CONFIG_ISDN_CAPI_MIDDLEWARE */
 			return count;
 		}
@@ -922,13 +939,19 @@
 			struct capincci *nccip;
 			struct capiminor *mp;
 			unsigned ncci;
+			int unit = 0;
 			if (copy_from_user((void *)&ncci, (void *)arg,
 					   sizeof(ncci)))
 				return -EFAULT;
+			down(&cdev->ncci_list_sem);
 			nccip = capincci_find(cdev, (u32) ncci);
-			if (!nccip || (mp = nccip->minorp) == 0)
+			if (!nccip || (mp = nccip->minorp) == 0) {
+				up(&cdev->ncci_list_sem);
 				return -ESRCH;
-			return mp->minor;
+			}
+			unit = mp->minor;
+			up(&cdev->ncci_list_sem);
+			return unit;
 		}
 		return 0;
 #endif /* CONFIG_ISDN_CAPI_MIDDLEWARE */
@@ -953,7 +976,6 @@
 {
 	struct capidev *cdev = (struct capidev *)file->private_data;
 
-	capincci_free(cdev, 0xffffffff);
 	capidev_free(cdev);
 	file->private_data = NULL;
 	
