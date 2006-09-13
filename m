Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWIMQjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWIMQjT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 12:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWIMQjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 12:39:07 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:61770 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750738AbWIMQip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 12:38:45 -0400
Date: Wed, 13 Sep 2006 18:39:04 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [11/12] driver core fixes: device_create_file() retval check in
 dmapool.c
Message-ID: <20060913183904.578d8a6f@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20060913163007.21cf10a8@gondolin.boeblingen.de.ibm.com>
References: <20060913163007.21cf10a8@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Check for device_create_file() return value in dma_pool_create().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

 dmapool.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- linux-2.6.18-rc6/drivers/base/dmapool.c	2006-09-13 10:55:47.000000000 +0200
+++ linux-2.6.18-rc6+CH/drivers/base/dmapool.c	2006-09-13 10:55:03.000000000 +0200
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
