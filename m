Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263158AbTCSUk2>; Wed, 19 Mar 2003 15:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263159AbTCSUk2>; Wed, 19 Mar 2003 15:40:28 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:48144
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263158AbTCSUk0>; Wed, 19 Mar 2003 15:40:26 -0500
Subject: [patch] scsi-sysfs bug fix
From: Robert Love <rml@tech9.net>
To: hch@infradead.org, axboe@suse.de, mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1048107080.775.96.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 19 Mar 2003 15:51:20 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Apologies for sending this to all the usual suspects here ... ]

drivers/scsi/scsi_sysfs.c :: store_rescan_field() calls
scsi_rescan_device() without a prototype, and thus results in a compiler
warning.

Fix that up by adding the prototype to scsi.h, where it belongs.

But then we see we are storing the return value of a void function (so
that is why ANSI C is good)... so fix that up, too, by setting the
return value to zero if a valid device was found.  Otherwise, return
ENODEV as before.

Patch is against 2.5.65.

	Robert Love


 drivers/scsi/scsi.h       |    1 +
 drivers/scsi/scsi_sysfs.c |    6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)


diff -urN linux-2.5.65/drivers/scsi/scsi.h linux/drivers/scsi/scsi.h
--- linux-2.5.65/drivers/scsi/scsi.h	2003-03-19 15:44:06.279618904 -0500
+++ linux/drivers/scsi/scsi.h	2003-03-19 15:39:47.355981280 -0500
@@ -443,6 +443,7 @@
 extern int scsi_attach_device(struct scsi_device *);
 extern void scsi_detach_device(struct scsi_device *);
 extern int scsi_get_device_flags(unsigned char *vendor, unsigned char *model);
+extern void scsi_rescan_device(struct scsi_device *sdev);
 
 /*
  * Newer request-based interfaces.
diff -urN linux-2.5.65/drivers/scsi/scsi_sysfs.c linux/drivers/scsi/scsi_sysfs.c
--- linux-2.5.65/drivers/scsi/scsi_sysfs.c	2003-03-19 15:44:06.196631520 -0500
+++ linux/drivers/scsi/scsi_sysfs.c	2003-03-19 15:42:45.249937288 -0500
@@ -278,8 +278,10 @@
 	int ret = ENODEV;
 	struct scsi_device *sdev;
 	sdev = to_scsi_device(dev);
-	if (sdev)
-		ret = scsi_rescan_device(sdev);
+	if (sdev) {
+		ret = 0;
+		scsi_rescan_device(sdev);
+	}
 	return ret;
 }
 



