Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbTCTIBg>; Thu, 20 Mar 2003 03:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261297AbTCTIBg>; Thu, 20 Mar 2003 03:01:36 -0500
Received: from franka.aracnet.com ([216.99.193.44]:43416 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261292AbTCTIBe>; Thu, 20 Mar 2003 03:01:34 -0500
Date: Thu, 20 Mar 2003 00:12:25 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: andmike@us.ibm.com, Patrick Mochel <mochel@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: [PATCH][RFC] fixup store_rescan_field / scsi_rescan_device
Message-ID: <2080000.1048147945@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, started off with this warning:

drivers/scsi/scsi_sysfs.c: In function `store_rescan_field':
drivers/scsi/scsi_sysfs.c:282: warning: implicit declaration of function `scsi_rescan_device

which is easy to fix by just adding a declaration in the header, but
store_rescan_field is expecting a return value from a void func (oops).
I made it assume 0, which *seems* reasonable giving the surrounding 
code, but I'm not really familiar with this area, so would like 
someone's blessing?

M.

diff -urpN -X /home/fletch/.diff.exclude virgin/drivers/scsi/scsi.h scsi_sysfs_fix/drivers/scsi/scsi.h
--- virgin/drivers/scsi/scsi.h	Mon Mar 17 21:43:46 2003
+++ scsi_sysfs_fix/drivers/scsi/scsi.h	Wed Mar 19 23:54:50 2003
@@ -442,6 +442,7 @@ extern void scsi_finish_command(Scsi_Cmn
 extern int scsi_retry_command(Scsi_Cmnd *);
 extern int scsi_attach_device(struct scsi_device *);
 extern void scsi_detach_device(struct scsi_device *);
+extern void scsi_rescan_device(struct scsi_device *);
 extern int scsi_get_device_flags(unsigned char *vendor, unsigned char *model);
 
 /*
diff -urpN -X /home/fletch/.diff.exclude virgin/drivers/scsi/scsi_sysfs.c scsi_sysfs_fix/drivers/scsi/scsi_sysfs.c
--- virgin/drivers/scsi/scsi_sysfs.c	Mon Mar 17 21:43:46 2003
+++ scsi_sysfs_fix/drivers/scsi/scsi_sysfs.c	Thu Mar 20 00:01:13 2003
@@ -275,12 +275,13 @@ show_rescan_field (struct device *dev, c
 static ssize_t
 store_rescan_field (struct device *dev, const char *buf, size_t count) 
 {
-	int ret = ENODEV;
 	struct scsi_device *sdev;
 	sdev = to_scsi_device(dev);
-	if (sdev)
-		ret = scsi_rescan_device(sdev);
-	return ret;
+	if (sdev) {
+		scsi_rescan_device(sdev);
+		return 0;
+	} else 
+		return ENODEV;
 }
 
 static DEVICE_ATTR(rescan, S_IRUGO | S_IWUSR, show_rescan_field, store_rescan_field)

