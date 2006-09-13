Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWIMQlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWIMQlx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 12:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWIMQlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 12:41:37 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:26222 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750734AbWIMQiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 12:38:20 -0400
Date: Wed, 13 Sep 2006 18:38:40 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Greg K-H <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [03/12] driver core fixes: fixup platform_device_register_simple()
Message-ID: <20060913183840.5a2e4989@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20060913163007.21cf10a8@gondolin.boeblingen.de.ibm.com>
References: <20060913163007.21cf10a8@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Remember to remove allocated resources if platform_device_add() fails.
Introduce a helper function platform_device_del_resources() for this,
which can also be used by platform_device_del().

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

 platform.c |   29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

--- linux-2.6.18-rc6/drivers/base/platform.c	2006-09-12 16:37:21.000000000 +0200
+++ linux-2.6.18-rc6+CH/drivers/base/platform.c	2006-09-12 16:39:10.000000000 +0200
@@ -202,6 +202,17 @@ int platform_device_add_resources(struct
 }
 EXPORT_SYMBOL_GPL(platform_device_add_resources);
 
+static void platform_device_del_resources(struct platform_device *pdev)
+{
+	int i;
+
+	for (i = 0; i < pdev->num_resources; i++) {
+		struct resource *r = &pdev->resource[i];
+		if (r->flags & (IORESOURCE_MEM|IORESOURCE_IO))
+			release_resource(r);
+	}
+}
+
 /**
  *	platform_device_add_data
  *	@pdev:	platform device allocated by platform_device_alloc to add resources to
@@ -296,15 +307,8 @@ EXPORT_SYMBOL_GPL(platform_device_add);
  */
 void platform_device_del(struct platform_device *pdev)
 {
-	int i;
-
 	if (pdev) {
-		for (i = 0; i < pdev->num_resources; i++) {
-			struct resource *r = &pdev->resource[i];
-			if (r->flags & (IORESOURCE_MEM|IORESOURCE_IO))
-				release_resource(r);
-		}
-
+		platform_device_del_resources(pdev);
 		device_del(&pdev->dev);
 	}
 }
@@ -365,17 +369,20 @@ struct platform_device *platform_device_
 	if (num) {
 		retval = platform_device_add_resources(pdev, res, num);
 		if (retval)
-			goto error;
+			goto error_put;
 	}
 
 	retval = platform_device_add(pdev);
 	if (retval)
-		goto error;
+		goto error_resources;
 
 	return pdev;
 
-error:
+error_resources:
+	platform_device_del_resources(pdev);
+error_put:
 	platform_device_put(pdev);
+error:
 	return ERR_PTR(retval);
 }
 EXPORT_SYMBOL_GPL(platform_device_register_simple);
