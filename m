Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267841AbUHKACu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267841AbUHKACu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 20:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267839AbUHKABS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 20:01:18 -0400
Received: from mta8.srv.hcvlny.cv.net ([167.206.5.75]:9127 "EHLO
	mta8.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S267838AbUHJX7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 19:59:00 -0400
Date: Tue, 10 Aug 2004 19:58:21 -0400
From: Nathan Bryant <nbryant@optonline.net>
Subject: [PATCH] SCSI midlayer power management
To: "'James Bottomley'" <James.Bottomley@steeleye.com>
Cc: Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, jgarzik@pobox.com
Message-id: <4119611D.60401@optonline.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_o91vZCm1wtiF4ZTOaVGBLw)"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_o91vZCm1wtiF4ZTOaVGBLw)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT


[resend] oops, sorry, forgot to send the patch!

Hi,

This proposed patch implements enough power-management support within
the SCSI midlayer to get ACPI S3 working on my system. Changes as follows:

* Add generic_scsi_{suspend,resume} methods to scsi.c
* Add suspend and resume callbacks to the scsi_driver structure, and
implement those callbacks in sd.c
* In sd.c, we call sd_shutdown on suspend, in order to synchronize the
write-back cache.
* In sd.c, we call sd_rescan from sd_resume in order to ensure that
drives have spun up and avoid passing not ready errors back to the block
layer.
* In generic_scsi_suspend, we call scsi_device_quiesce before calling
the scsi_driver suspend callback. We resume from quiesce state in
reverse order in generic_scsi_resume.

ACPI S1 and S4/swsusp are untested, but I think there should be no
regressions with S1. To do S1 properly, we probably need to tell the
drive to spin down, and I don't know what the SCSI command is for
that... For S4, the call to scsi_device_quiesce might pose a problem for
the subsequent state dump to disk. But I'm not sure swsusp ever worked
for SCSI.

This might help SATA drives, too, but I seem to remember that the SATA
layer doesn't properly emulate the SYNCHRONIZE_CACHE command.

Comments, anybody? Can this be applied upstream? I think it's a step in
the right direction.

Applies to scsi-misc-2.6

Nathan


--Boundary_(ID_o91vZCm1wtiF4ZTOaVGBLw)
Content-type: text/x-patch; name=scsi-powermanage.patch
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=scsi-powermanage.patch

===== drivers/scsi/scsi.c 1.145 vs edited =====
--- 1.145/drivers/scsi/scsi.c	2004-06-19 10:38:34 -04:00
+++ edited/drivers/scsi/scsi.c	2004-08-10 19:31:45 -04:00
@@ -60,6 +60,7 @@
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_dbg.h>
 #include <scsi/scsi_device.h>
+#include <scsi/scsi_driver.h>
 #include <scsi/scsi_eh.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_tcq.h>
@@ -1175,6 +1176,40 @@
 #define register_scsi_cpu()
 #define unregister_scsi_cpu()
 #endif /* CONFIG_HOTPLUG_CPU */
+
+#ifdef CONFIG_PM
+int generic_scsi_suspend(struct device *dev, u32 state)
+{
+	int err;
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct scsi_driver *drv = to_scsi_driver(dev->driver);
+
+	err = scsi_device_quiesce(sdev);
+	if (err)
+		return err;
+
+	if (drv->suspend)
+		return drv->suspend(dev, state);
+
+	return 0;
+}
+
+int generic_scsi_resume(struct device *dev)
+{
+	int err;
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct scsi_driver *drv = to_scsi_driver(dev->driver);
+
+	if (drv->resume) {
+		err = drv->resume(dev);
+		if (err)
+			return err;
+	}
+
+	scsi_device_resume(sdev);
+	return 0;
+}
+#endif /*CONFIG_PM*/
 
 MODULE_DESCRIPTION("SCSI core");
 MODULE_LICENSE("GPL");
===== drivers/scsi/scsi_priv.h 1.33 vs edited =====
--- 1.33/drivers/scsi/scsi_priv.h	2004-06-16 11:45:44 -04:00
+++ edited/drivers/scsi/scsi_priv.h	2004-08-09 20:07:35 -04:00
@@ -92,6 +92,10 @@
 static inline void scsi_log_completion(struct scsi_cmnd *cmd, int disposition)
 	{ };
 #endif
+#ifdef CONFIG_PM
+extern int generic_scsi_suspend(struct device *dev, u32 state);
+extern int generic_scsi_resume(struct device *dev);
+#endif
 
 /* scsi_devinfo.c */
 extern int scsi_get_device_flags(struct scsi_device *sdev,
===== drivers/scsi/scsi_sysfs.c 1.52 vs edited =====
--- 1.52/drivers/scsi/scsi_sysfs.c	2004-07-28 23:59:10 -04:00
+++ edited/drivers/scsi/scsi_sysfs.c	2004-08-10 17:43:04 -04:00
@@ -187,8 +187,12 @@
 }
 
 struct bus_type scsi_bus_type = {
-        .name		= "scsi",
-        .match		= scsi_bus_match,
+	.name		= "scsi",
+	.match		= scsi_bus_match,
+#ifdef CONFIG_PM
+	.suspend	= generic_scsi_suspend,
+	.resume		= generic_scsi_resume,
+#endif
 };
 
 int scsi_sysfs_register(void)
===== drivers/scsi/sd.c 1.154 vs edited =====
--- 1.154/drivers/scsi/sd.c	2004-06-19 10:38:40 -04:00
+++ edited/drivers/scsi/sd.c	2004-08-10 19:33:15 -04:00
@@ -110,6 +110,10 @@
 
 static int sd_probe(struct device *);
 static int sd_remove(struct device *);
+#ifdef CONFIG_PM
+static int sd_suspend(struct device *, u32);
+static int sd_resume(struct device *);
+#endif
 static void sd_shutdown(struct device *dev);
 static void sd_rescan(struct device *);
 static int sd_init_command(struct scsi_cmnd *);
@@ -126,6 +130,10 @@
 	},
 	.rescan			= sd_rescan,
 	.init_command		= sd_init_command,
+#ifdef CONFIG_PM
+	.suspend		= sd_suspend,
+	.resume			= sd_resume,
+#endif
 };
 
 /* Device no to disk mapping:
@@ -1549,7 +1557,21 @@
 	
 	scsi_release_request(sreq);
 	printk("\n");
-}	
+}
+
+#ifdef CONFIG_PM
+static int sd_suspend(struct device *dev, u32 state)
+{
+	sd_shutdown(dev);
+	return 0;
+}
+
+static int sd_resume(struct device *dev)
+{
+	sd_rescan(dev);
+	return 0;
+}
+#endif /*CONFIG_PM*/
 
 /**
  *	init_sd - entry point for this driver (both when built in or when
===== include/scsi/scsi_driver.h 1.2 vs edited =====
--- 1.2/include/scsi/scsi_driver.h	2003-11-12 09:15:46 -05:00
+++ edited/include/scsi/scsi_driver.h	2004-08-10 18:02:45 -04:00
@@ -13,6 +13,10 @@
 
 	int (*init_command)(struct scsi_cmnd *);
 	void (*rescan)(struct device *);
+#ifdef CONFIG_PM
+	int (*suspend)(struct device *dev, u32 state);
+	int (*resume)(struct device *dev);
+#endif
 };
 #define to_scsi_driver(drv) \
 	container_of((drv), struct scsi_driver, gendrv)

--Boundary_(ID_o91vZCm1wtiF4ZTOaVGBLw)--
