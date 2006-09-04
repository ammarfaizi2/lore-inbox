Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWIDJz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWIDJz5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 05:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWIDJz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 05:55:57 -0400
Received: from smtp105.biz.mail.mud.yahoo.com ([68.142.200.253]:61317 "HELO
	smtp105.biz.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751311AbWIDJz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 05:55:56 -0400
Mime-Version: 1.0 (Apple Message framework v752.2)
To: linux-kernel@vger.kernel.org
Message-Id: <CB81ECDC-0B48-4BE4-B9C0-C1CDBEC0F739@vhugo.net>
Content-Type: multipart/mixed; boundary=Apple-Mail-3-790210376
Cc: Victor Castro <victorhugo83@yahoo.com>
Subject: [PATCH][RFC] request_firmware examples and MODULE_FIRMWARE
From: Victor Hugo <victor@vhugo.net>
Date: Sun, 3 Sep 2006 19:55:53 -0700
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-3-790210376
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

Hi Everyone,

I'm trying to become the firmware loader maintainer  
(request_firmware) and I felt the first thing I should do is update  
the incomplete example driver under Documentaion/firmware_class/.   
The example (firmware_sample_driver.c) doesn't work out of box and  
needs tweaking just to get it to compile.  I've added two files which  
use request_firmware and the asynchronous request_firmware_nowait.

The next step would be to update the documentation to make hotplug/ 
udev functionality a little more clear.  Hopefully I can get this in  
the next couple of days.

Also, I'd like to comment on Jon Masters push to include the  
MODULE_FIRMWARE api addition.  I strongly believe that policy should  
not be included in driver code, in this case it's in the form of a  
filename.

The firmware loader currently needs a filename passed to it so it can  
then pass the $FIRMWARE environment variable to the hotplug script.   
This is ok if you provide a generic filename like "firmware.bin" and  
then let the hotplug script worry about version numbers, i.e.  
"firmware-x.y.z.bin"

MODULE_FIRMWARE should be used to provide the generic filenames and  
which order the files should be loaded (request_firmware can be  
called various times), but I think its bad to have to change the  
driver everytime a new firmware version is released.

That said, here's the patch...


--Apple-Mail-3-790210376
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=firmware_examples.patch
Content-Disposition: attachment;
	filename=firmware_examples.patch

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

--Apple-Mail-3-790210376
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed




--Apple-Mail-3-790210376--

-- 
VGER BF report: U 0.792604
