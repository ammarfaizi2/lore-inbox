Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965044AbWJJG4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbWJJG4V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 02:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965043AbWJJG4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 02:56:21 -0400
Received: from havoc.gtf.org ([69.61.125.42]:6286 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965044AbWJJG4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 02:56:20 -0400
Date: Tue, 10 Oct 2006 02:56:20 -0400
From: Jeff Garzik <jeff@garzik.org>
To: abhay_salunke@dell.com, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] firmware/dell_rbu: handle sysfs errors
Message-ID: <20061010065620.GA21720@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/firmware/dell_rbu.c |   21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

3ee9d835887cc49e747f3b39e7d8623918457e3d
diff --git a/drivers/firmware/dell_rbu.c b/drivers/firmware/dell_rbu.c
index fc17599..4fb5d72 100644
--- a/drivers/firmware/dell_rbu.c
+++ b/drivers/firmware/dell_rbu.c
@@ -718,14 +718,27 @@ static int __init dcdrbu_init(void)
 		return -EIO;
 	}
 
-	sysfs_create_bin_file(&rbu_device->dev.kobj, &rbu_data_attr);
-	sysfs_create_bin_file(&rbu_device->dev.kobj, &rbu_image_type_attr);
-	sysfs_create_bin_file(&rbu_device->dev.kobj,
+	rc = sysfs_create_bin_file(&rbu_device->dev.kobj, &rbu_data_attr);
+	if (rc)
+		goto out_devreg;
+	rc = sysfs_create_bin_file(&rbu_device->dev.kobj, &rbu_image_type_attr);
+	if (rc)
+		goto out_data;
+	rc = sysfs_create_bin_file(&rbu_device->dev.kobj,
 		&rbu_packet_size_attr);
+	if (rc)
+		goto out_imtype;
 
 	rbu_data.entry_created = 0;
-	return rc;
+	return 0;
 
+out_imtype:
+	sysfs_remove_bin_file(&rbu_device->dev.kobj, &rbu_image_type_attr);
+out_data:
+	sysfs_remove_bin_file(&rbu_device->dev.kobj, &rbu_data_attr);
+out_devreg:
+	platform_device_unregister(rbu_device);
+	return rc;
 }
 
 static __exit void dcdrbu_exit(void)
