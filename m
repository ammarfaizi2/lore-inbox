Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966361AbWKNVSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966361AbWKNVSZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 16:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966364AbWKNVSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 16:18:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:22632 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S966361AbWKNVSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 16:18:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=uUbZPC7y8WJuTRlSc39e7x5csG5bI+9WhEqZqcuc8HeOdkial6eY8bfnJs1PSI9pmh74b3NAJysdmejZLsGj/wIk8layF0ZCRyJQ0i8LlCFz2pSdMFiK4Ro9JycG33iC2ZDL6/2iXCEBgY8TW7hpqO1J1y+eo2pEVWUjfRs5+gc=
Date: Wed, 15 Nov 2006 06:18:23 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Abhay Salunke <abhay_salunke@dell.com>
Subject: [PATCH] dell_rbu: fix error check
Message-ID: <20061114211823.GC20524@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org,
	Abhay Salunke <abhay_salunke@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

platform_device_register_simple() returns error code as pointer
when it fails. The return value should be checked by IS_ERR().

Cc: Abhay Salunke <abhay_salunke@dell.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/firmware/dell_rbu.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Index: work-fault-inject/drivers/firmware/dell_rbu.c
===================================================================
--- work-fault-inject.orig/drivers/firmware/dell_rbu.c
+++ work-fault-inject/drivers/firmware/dell_rbu.c
@@ -705,17 +705,16 @@ static struct bin_attribute rbu_packet_s
 
 static int __init dcdrbu_init(void)
 {
-	int rc = 0;
+	int rc;
 	spin_lock_init(&rbu_data.lock);
 
 	init_packet_head();
-	rbu_device =
-		platform_device_register_simple("dell_rbu", -1, NULL, 0);
-	if (!rbu_device) {
+	rbu_device = platform_device_register_simple("dell_rbu", -1, NULL, 0);
+	if (IS_ERR(rbu_device)) {
 		printk(KERN_ERR
 			"dell_rbu:%s:platform_device_register_simple "
 			"failed\n", __FUNCTION__);
-		return -EIO;
+		return PTR_ERR(rbu_device);
 	}
 
 	rc = sysfs_create_bin_file(&rbu_device->dev.kobj, &rbu_data_attr);
