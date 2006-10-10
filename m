Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965072AbWJJH2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbWJJH2Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 03:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbWJJH2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 03:28:16 -0400
Received: from smtp2.versatel.nl ([62.58.50.89]:21727 "EHLO smtp2.versatel.nl")
	by vger.kernel.org with ESMTP id S965072AbWJJH2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 03:28:16 -0400
Message-ID: <452B4B59.1050606@hhs.nl>
Date: Tue, 10 Oct 2006 09:27:21 +0200
From: Hans de Goede <j.w.r.degoede@hhs.nl>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: khali@linux-fr.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hwmon/abituguru: handle sysfs errors
References: <20061010065359.GA21576@havoc.gtf.org>
In-Reply-To: <20061010065359.GA21576@havoc.gtf.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean, Jeff,

You (Jean) already mailed me about this and it was on my todo list, but I'm currently rather busy with work. So it looks like Jeff beat me to it.

Jeff's patch looks fine, please apply. Thanks Jeff!

Regards,

Hans

Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
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

