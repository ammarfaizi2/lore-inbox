Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWADWEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWADWEf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWADWCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:02:03 -0500
Received: from a34-mta01.direcpc.com ([66.82.4.90]:65524 "EHLO
	a34-mta01.direcway.com") by vger.kernel.org with ESMTP
	id S932104AbWADWBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:01:00 -0500
Date: Wed, 04 Jan 2006 17:00:38 -0500
From: Ben Collins <bcollins@ubuntu.com>
Subject: [PATCH 08/15] sonypi: Enable ACPI events for Sony laptop hotkeys
To: linux-kernel@vger.kernel.org
Message-id: <0ISL001SM95JWW@a34-mta01.direcway.com>
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ben Collins <bcollins@ubuntu.com>

---

 drivers/char/sonypi.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

487226fc8285a99f10b68c06938e77570aaf1c6a
diff --git a/drivers/char/sonypi.c b/drivers/char/sonypi.c
index 51a0737..b375da5 100644
--- a/drivers/char/sonypi.c
+++ b/drivers/char/sonypi.c
@@ -511,6 +511,11 @@ static struct sonypi_device {
 #define SONYPI_ACPI_ACTIVE 0
 #endif				/* CONFIG_ACPI */
 
+#ifdef CONFIG_ACPI
+static struct acpi_device *sonypi_acpi_device;
+static int acpi_enabled;
+#endif
+
 static int sonypi_ec_write(u8 addr, u8 value)
 {
 #ifdef CONFIG_ACPI_EC
@@ -864,6 +869,11 @@ found:
 	if (useinput)
 		sonypi_report_input_event(event);
 
+#ifdef CONFIG_ACPI
+	if (acpi_enabled)
+		acpi_bus_generate_event(sonypi_acpi_device, 1, event);
+#endif
+
 	kfifo_put(sonypi_device.fifo, (unsigned char *)&event, sizeof(event));
 	kill_fasync(&sonypi_device.fifo_async, SIGIO, POLL_IN);
 	wake_up_interruptible(&sonypi_device.fifo_proc_list);
@@ -1199,6 +1209,32 @@ static struct platform_driver sonypi_dri
 	},
 };
 
+#ifdef CONFIG_ACPI
+static int sonypi_acpi_add (struct acpi_device *device)
+{
+	sonypi_acpi_device = device;
+	strcpy(acpi_device_name(device), "Sony laptop hotkeys");
+	strcpy(acpi_device_class(device), "sony/hotkey");
+	return 0;
+}
+
+static int sonypi_acpi_remove (struct acpi_device *device, int type)
+{
+	sonypi_acpi_device = NULL;
+	return 0;
+}
+
+static struct acpi_driver sonypi_acpi_driver = {
+	.name           = "sonypi",
+	.class          = "hkey",
+	.ids            = "SNY6001",
+	.ops            = {
+		           .add = sonypi_acpi_add,
+			   .remove = sonypi_acpi_remove,
+	},
+};
+#endif
+
 static int __devinit sonypi_create_input_devices(void)
 {
 	struct input_dev *jog_dev;
@@ -1464,11 +1500,20 @@ static int __init sonypi_init(void)
 	if (ret)
 		platform_driver_unregister(&sonypi_driver);
 
+#ifdef CONFIG_ACPI
+	if (acpi_bus_register_driver(&sonypi_acpi_driver) > 0)
+		acpi_enabled=1;
+#endif
+
 	return ret;
 }
 
 static void __exit sonypi_exit(void)
 {
+#ifdef CONFIG_ACPI
+	if (acpi_enabled)
+		acpi_bus_unregister_driver(&sonypi_acpi_driver);
+#endif
 	platform_driver_unregister(&sonypi_driver);
 	sonypi_remove();
 }
-- 
1.0.5
