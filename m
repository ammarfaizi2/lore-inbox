Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422892AbWJRURr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422892AbWJRURr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422815AbWJRUQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:16:30 -0400
Received: from cantor.suse.de ([195.135.220.2]:17842 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1422852AbWJRUJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:09:40 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 11/16] driver core fixes: device_create_file() retval check in dmapool.c
Date: Wed, 18 Oct 2006 13:09:02 -0700
Message-Id: <11612021801495-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.4
In-Reply-To: <11612021771048-git-send-email-greg@kroah.com>
References: <20061018195833.GA21808@kroah.com> <1161202147758-git-send-email-greg@kroah.com> <11612021503109-git-send-email-greg@kroah.com> <1161202153578-git-send-email-greg@kroah.com> <11612021563449-git-send-email-greg@kroah.com> <11612021603361-git-send-email-greg@kroah.com> <1161202163247-git-send-email-greg@kroah.com> <1161202166551-git-send-email-greg@kroah.com> <11612021701905-git-send-email-greg@kroah.com> <11612021733101-git-send-email-greg@kroah.com> <11612021771048-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Check for device_create_file() return value in dma_pool_create().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/dmapool.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/base/dmapool.c b/drivers/base/dmapool.c
index 33c5cce..b2efbd4 100644
--- a/drivers/base/dmapool.c
+++ b/drivers/base/dmapool.c
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
-- 
1.4.2.4

