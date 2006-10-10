Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWJJNSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWJJNSk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 09:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWJJNSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 09:18:40 -0400
Received: from havoc.gtf.org ([69.61.125.42]:48021 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750742AbWJJNSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 09:18:39 -0400
Date: Tue, 10 Oct 2006 09:18:03 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] EISA: handle sysfs errors
Message-ID: <20061010131803.GA8947@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/eisa/eisa-bus.c         |   22 +++++++++++++++++-----

diff --git a/drivers/eisa/eisa-bus.c b/drivers/eisa/eisa-bus.c
index 3a365e1..d944647 100644
--- a/drivers/eisa/eisa-bus.c
+++ b/drivers/eisa/eisa-bus.c
@@ -226,14 +226,26 @@ #endif
 
 static int __init eisa_register_device (struct eisa_device *edev)
 {
-	if (device_register (&edev->dev))
-		return -1;
+	int rc = device_register (&edev->dev);
+	if (rc)
+		return rc;
 
-	device_create_file (&edev->dev, &dev_attr_signature);
-	device_create_file (&edev->dev, &dev_attr_enabled);
-	device_create_file (&edev->dev, &dev_attr_modalias);
+	rc = device_create_file (&edev->dev, &dev_attr_signature);
+	if (rc) goto err_devreg;
+	rc = device_create_file (&edev->dev, &dev_attr_enabled);
+	if (rc) goto err_sig;
+	rc = device_create_file (&edev->dev, &dev_attr_modalias);
+	if (rc) goto err_enab;
 
 	return 0;
+
+err_enab:
+	device_remove_file (&edev->dev, &dev_attr_enabled);
+err_sig:
+	device_remove_file (&edev->dev, &dev_attr_signature);
+err_devreg:
+	device_unregister(&edev->dev);
+	return rc;
 }
 
 static int __init eisa_request_resources (struct eisa_root_device *root,
