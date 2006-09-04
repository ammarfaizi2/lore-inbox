Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWIDJGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWIDJGA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 05:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWIDJGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 05:06:00 -0400
Received: from web415.biz.mail.mud.yahoo.com ([68.142.200.62]:14241 "HELO
	web415.biz.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751157AbWIDIpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 04:45:06 -0400
Message-ID: <20060904084505.30467.qmail@web415.biz.mail.mud.yahoo.com>
Date: Mon, 4 Sep 2006 01:45:05 -0700 (PDT)
From: Victor Hugo <victor@vhugo.net>
Subject: [PATCH][RFC] request_firmware examples and MODULE_FIRMWARE
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1023607119-1157359505=:27068"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1023607119-1157359505=:27068
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi Everyone,

I'm trying to become the firmware loader maintainer
(request_firmware) and I felt the first thing I should
do is update the incomplete example driver under
Documentaion/firmware_class/.  The example
(firmware_sample_driver.c) doesn't work out of box and
needs tweaking just to get it to compile.  I've added
two files which use request_firmware and the
asynchronous request_firmware_nowait.

The next step would be to update the documentation to
make hotplug/udev functionality a little more clear. 
Hopefully I can get this in the next couple of days.

Also, I'd like to comment on Jon Masters push to
include the MODULE_FIRMWARE api addition.  I strongly
believe that policy should not be included in driver
code, in this case it's in the form of a filename. 

The firmware loader currently needs a filename passed
to it so it can then pass the $FIRMWARE environment
variable to the hotplug script.  This is ok if you
provide a generic filename like "firmware.bin" and
then let the hotplug script worry about version
numbers, i.e. "firmware-x.y.z.bin"

MODULE_FIRMWARE should be used to provide the generic
filenames and which order the files should be loaded
(request_firmware can be called various times), but I
think its bad to have to change the driver everytime a
new firmware version is released.

That said, here's the patch...
--0-1023607119-1157359505=:27068
Content-Type: text/x-patch; name="firmware_examples.patch"
Content-Description: pat882669590
Content-Disposition: inline; filename="firmware_examples.patch"

diff -Nur linux-2.6.17.11/Documentation/firmware_class/firmware_example.c linux/Documentation/firmware_class/firmware_example.c
--- linux-2.6.17.11/Documentation/firmware_class/firmware_example.c	1969-12-31 16:00:00.000000000 -0800
+++ linux/Documentation/firmware_class/firmware_example.c	2006-09-04 00:42:29.000000000 -0700
@@ -0,0 +1,69 @@
+/*
+ * firmware_example.c -
+ *
+ * Copyright (c) 2006 Victor Hugo <victor@vhugo.net>
+ * Based on firmware_sample_driver.c by Manuel Estrada Sainz
+ * Sample code on how to use request_firmware() from drivers.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/string.h>
+#include <linux/firmware.h>
+
+static void sample_firmware_load(char *firmware, int size)
+{
+	u8 buf[size + 1];
+	memcpy(buf, firmware, size);
+	buf[size] = '\0';
+	printk(KERN_INFO "firmware_example: Firmware: %s\n", buf);
+}
+
+static void sample_probe(struct device *dev)
+{
+	/* uses the default method to get the firmware */
+	const struct firmware *fw_entry;
+	printk(KERN_INFO
+	       "firmware_example: ghost device inserted\n");
+
+	if (request_firmware(&fw_entry, "sample_firware.bin", dev) != 0) {
+		printk(KERN_ERR
+		       "firmware_example: Firmware not available\n");
+		return;
+	}
+
+	sample_firmware_load(fw_entry->data, fw_entry->size);
+
+	release_firmware(fw_entry);
+
+	/* finish setting up the device */
+}
+
+static void ghost_release(struct device *dev)
+{
+	printk(KERN_DEBUG "firmware_example : ghost device released\n");
+}
+
+static struct device ghost_device = {
+	.bus_id = "ghost0",
+	.release = ghost_release
+};
+
+static int __init sample_init(void)
+{
+	device_register(&ghost_device);
+	sample_probe(&ghost_device);
+	return 0;
+}
+static void __exit sample_exit(void)
+{
+	device_unregister(&ghost_device);
+}
+
+module_init(sample_init);
+module_exit(sample_exit);
+
+MODULE_LICENSE("GPL");
diff -Nur linux-2.6.17.11/Documentation/firmware_class/firmware_nowait_example.c linux/Documentation/firmware_class/firmware_nowait_example.c
--- linux-2.6.17.11/Documentation/firmware_class/firmware_nowait_example.c	1969-12-31 16:00:00.000000000 -0800
+++ linux/Documentation/firmware_class/firmware_nowait_example.c	2006-09-04 00:44:59.000000000 -0700
@@ -0,0 +1,84 @@
+/*
+ * firmware_nowait_example.c -
+ *
+ * Copyright (c) 2006 Victor Hugo <victor@vhugo.net>
+ * Based on firmware_sample_driver.c by Manuel Estrada Sainz
+ * Sample code on how to use request_firmware() from drivers.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/string.h>
+#include <linux/firmware.h>
+
+static void sample_firmware_load(char *firmware, int size)
+{
+	u8 buf[size+1];
+	memcpy(buf, firmware, size);
+	buf[size] = '\0';
+	printk(KERN_INFO "firmware_nowait_example: Firmware: %s\n", buf);
+}
+
+static void sample_probe_async_cont(const struct firmware *fw, void *context)
+{
+	if(!fw)
+	{
+		printk(KERN_ERR "firmware_nowait_example: Firmware not available\n");
+		return;
+	}
+
+
+	printk(KERN_INFO "firmware_nowait_example: Device Pointer \"%s\"\n",
+	       (char *)context);
+	sample_firmware_load(fw->data, fw->size);
+
+}
+
+static void sample_probe_async(struct device *dev)
+{
+	/* Let's say I can't sleep */
+	int error;
+	
+	printk(KERN_INFO
+	       "firmware_example: ghost device inserted\n");
+
+	error = request_firmware_nowait(THIS_MODULE, FW_ACTION_NOHOTPLUG,
+					"sample_firmware.bin", dev,
+					"my device pointer",sample_probe_async_cont);
+
+	if(error)
+	{
+		printk(KERN_ERR 
+		       "firmware_nowait_example: request_firmware_nowait Failed\n");
+	}
+
+}
+
+static void ghost_release(struct device *dev)
+{
+	printk(KERN_DEBUG "firmware_nowait_example: ghost device released\n");
+}
+
+static struct device ghost_device = {
+	.bus_id    = "ghost0",
+	.release   = ghost_release
+};
+
+static int __init sample_init(void)
+{
+	device_register(&ghost_device);
+	sample_probe_async(&ghost_device);
+return 0;
+}
+static void __exit sample_exit(void)
+{
+	device_unregister(&ghost_device);
+}
+
+module_init (sample_init);
+module_exit (sample_exit);
+
+MODULE_LICENSE("GPL");
diff -Nur linux-2.6.17.11/Documentation/firmware_class/firmware_sample_driver.c linux/Documentation/firmware_class/firmware_sample_driver.c
--- linux-2.6.17.11/Documentation/firmware_class/firmware_sample_driver.c	2006-08-23 14:16:33.000000000 -0700
+++ linux/Documentation/firmware_class/firmware_sample_driver.c	1969-12-31 16:00:00.000000000 -0800
@@ -1,115 +0,0 @@
-/*
- * firmware_sample_driver.c -
- *
- * Copyright (c) 2003 Manuel Estrada Sainz <ranty@debian.org>
- *
- * Sample code on how to use request_firmware() from drivers.
- *
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/device.h>
-#include <linux/string.h>
-
-#include "linux/firmware.h"
-
-static struct device ghost_device = {
-	.bus_id    = "ghost0",
-};
-
-
-static void sample_firmware_load(char *firmware, int size)
-{
-	u8 buf[size+1];
-	memcpy(buf, firmware, size);
-	buf[size] = '\0';
-	printk(KERN_INFO "firmware_sample_driver: firmware: %s\n", buf);
-}
-
-static void sample_probe_default(void)
-{
-	/* uses the default method to get the firmware */
-        const struct firmware *fw_entry;
-	printk(KERN_INFO "firmware_sample_driver: a ghost device got inserted :)\n");
-
-        if(request_firmware(&fw_entry, "sample_driver_fw", &ghost_device)!=0)
-	{
-		printk(KERN_ERR
-		       "firmware_sample_driver: Firmware not available\n");
-		return;
-	}
-	
-	sample_firmware_load(fw_entry->data, fw_entry->size);
-
-	release_firmware(fw_entry);
-
-	/* finish setting up the device */
-}
-static void sample_probe_specific(void)
-{
-	/* Uses some specific hotplug support to get the firmware from
-	 * userspace  directly into the hardware, or via some sysfs file */
-
-	/* NOTE: This currently doesn't work */
-
-	printk(KERN_INFO "firmware_sample_driver: a ghost device got inserted :)\n");
-
-        if(request_firmware(NULL, "sample_driver_fw", &ghost_device)!=0)
-	{
-		printk(KERN_ERR
-		       "firmware_sample_driver: Firmware load failed\n");
-		return;
-	}
-	
-	/* request_firmware blocks until userspace finished, so at
-	 * this point the firmware should be already in the device */
-
-	/* finish setting up the device */
-}
-static void sample_probe_async_cont(const struct firmware *fw, void *context)
-{
-	if(!fw){
-		printk(KERN_ERR
-		       "firmware_sample_driver: firmware load failed\n");
-		return;
-	}
-
-	printk(KERN_INFO "firmware_sample_driver: device pointer \"%s\"\n",
-	       (char *)context);
-	sample_firmware_load(fw->data, fw->size);
-}
-static void sample_probe_async(void)
-{
-	/* Let's say that I can't sleep */
-	int error;
-	error = request_firmware_nowait (THIS_MODULE, FW_ACTION_NOHOTPLUG,
-					 "sample_driver_fw", &ghost_device,
-					 "my device pointer",
-					 sample_probe_async_cont);
-	if(error){
-		printk(KERN_ERR 
-		       "firmware_sample_driver:"
-		       " request_firmware_nowait failed\n");
-	}
-}
-
-static int sample_init(void)
-{
-	device_initialize(&ghost_device);
-	/* since there is no real hardware insertion I just call the
-	 * sample probe functions here */
-	sample_probe_specific();
-	sample_probe_default();
-	sample_probe_async();
-	return 0;
-}
-static void __exit sample_exit(void)
-{
-}
-
-module_init (sample_init);
-module_exit (sample_exit);
-
-MODULE_LICENSE("GPL");

--0-1023607119-1157359505=:27068--

-- 
VGER BF report: S 1
