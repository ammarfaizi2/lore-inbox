Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWIVJhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWIVJhs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 05:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWIVJhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 05:37:36 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:29379 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751124AbWIVJhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 05:37:04 -0400
Date: Fri, 22 Sep 2006 11:37:27 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [8/9] driver core fixes: device_create_file() retval check in
 dmapool.c
Message-ID: <20060922113727.13275319@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Check for device_create_file() return value in dma_pool_create().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---
 drivers/base/dmapool.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- linux-2.6-CH.orig/drivers/base/dmapool.c
+++ linux-2.6-CH/drivers/base/dmapool.c
@@ -141,11 +141,20 @@ dma_pool_create (const char *name, struc
 	init_waitqueue_head (&retval->waitq);
 
 	if (dev) {
+		int ret;
+
 		down (&pools_lock);
 		if (list_empty (&dev->dma_pools))
-			device_create_file (dev, &dev_attr_pools);
+			ret = device_create_file (dev, &dev_attr_pools);
+		else
+			ret = 0;
 		/* note:  not currently insisting "name" be unique */
-		list_add (&retval->pools, &dev->dma_pools);
+		if (!ret)
+			list_add (&retval->pools, &dev->dma_pools);
+		else {
+			kfree(retval);
+			retval = NULL;
+		}
 		up (&pools_lock);
 	} else
 		INIT_LIST_HEAD (&retval->pools);
