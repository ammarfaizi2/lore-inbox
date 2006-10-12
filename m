Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422692AbWJLBvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422692AbWJLBvz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 21:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422690AbWJLBvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 21:51:55 -0400
Received: from havoc.gtf.org ([69.61.125.42]:16864 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1422689AbWJLBvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 21:51:54 -0400
Date: Wed, 11 Oct 2006 21:51:53 -0400
From: Jeff Garzik <jeff@garzik.org>
To: chas@cmf.nrl.navy.mil, davem@davemloft.net, netdev@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] NET/atm: handle sysfs errors
Message-ID: <20061012015153.GA13204@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 net/atm/atm_sysfs.c         |   15 ++++++++++++---

diff --git a/net/atm/atm_sysfs.c b/net/atm/atm_sysfs.c
index c0a4ae2..62f6ed1 100644
--- a/net/atm/atm_sysfs.c
+++ b/net/atm/atm_sysfs.c
@@ -141,7 +141,7 @@ static struct class atm_class = {
 int atm_register_sysfs(struct atm_dev *adev)
 {
 	struct class_device *cdev = &adev->class_dev;
-	int i, err;
+	int i, j, err;
 
 	cdev->class = &atm_class;
 	class_set_devdata(cdev, adev);
@@ -151,10 +151,19 @@ int atm_register_sysfs(struct atm_dev *a
 	if (err < 0)
 		return err;
 
-	for (i = 0; atm_attrs[i]; i++)
-		class_device_create_file(cdev, atm_attrs[i]);
+	for (i = 0; atm_attrs[i]; i++) {
+		err = class_device_create_file(cdev, atm_attrs[i]);
+		if (err)
+			goto err_out;
+	}
 
 	return 0;
+
+err_out:
+	for (j = 0; j < i; j++)
+		class_device_remove_file(cdev, atm_attrs[j]);
+	class_device_del(cdev);
+	return err;
 }
 
 void atm_unregister_sysfs(struct atm_dev *adev)
