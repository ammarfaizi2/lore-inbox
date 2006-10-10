Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965017AbWJJGyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbWJJGyB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 02:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWJJGyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 02:54:01 -0400
Received: from havoc.gtf.org ([69.61.125.42]:60813 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965017AbWJJGyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 02:54:00 -0400
Date: Tue, 10 Oct 2006 02:53:59 -0400
From: Jeff Garzik <jeff@garzik.org>
To: j.w.r.degoede@hhs.nl, khali@linux-fr.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] hwmon/abituguru: handle sysfs errors
Message-ID: <20061010065359.GA21576@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/hwmon/abituguru.c |   30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

2b10f648c8ed965369976eb7925b922ee187ce21
diff --git a/drivers/hwmon/abituguru.c b/drivers/hwmon/abituguru.c
index e5cb0fd..3ded982 100644
--- a/drivers/hwmon/abituguru.c
+++ b/drivers/hwmon/abituguru.c
@@ -1271,14 +1271,34 @@ static int __devinit abituguru_probe(str
 		res = PTR_ERR(data->class_dev);
 		goto abituguru_probe_error;
 	}
-	for (i = 0; i < sysfs_attr_i; i++)
-		device_create_file(&pdev->dev, &data->sysfs_attr[i].dev_attr);
-	for (i = 0; i < ARRAY_SIZE(abituguru_sysfs_attr); i++)
-		device_create_file(&pdev->dev,
-			&abituguru_sysfs_attr[i].dev_attr);
+	for (i = 0; i < sysfs_attr_i; i++) {
+		res = device_create_file(&pdev->dev,
+					 &data->sysfs_attr[i].dev_attr);
+		if (res) {
+			for (j = 0; j < i; j++)
+				device_remove_file(&pdev->dev,
+					 	&data->sysfs_attr[j].dev_attr);
+			goto err_devreg;
+		}
+	}
+	for (i = 0; i < ARRAY_SIZE(abituguru_sysfs_attr); i++) {
+		res = device_create_file(&pdev->dev,
+					 &abituguru_sysfs_attr[i].dev_attr);
+		if (res) {
+			for (j = 0; j < i; j++)
+				device_remove_file(&pdev->dev,
+					 &abituguru_sysfs_attr[j].dev_attr);
+			goto err_attr_i;
+		}
+	}
 
 	return 0;
 
+err_attr_i:
+	for (i = 0; i < sysfs_attr_i; i++)
+		device_remove_file(&pdev->dev, &data->sysfs_attr[i].dev_attr);
+err_devreg:
+	hwmon_device_unregister(data->class_dev);
 abituguru_probe_error:
 	kfree(data);
 	return res;
