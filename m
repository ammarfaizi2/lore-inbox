Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422722AbWIGXZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422722AbWIGXZv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 19:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422725AbWIGXZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 19:25:51 -0400
Received: from smtp103.biz.mail.mud.yahoo.com ([68.142.200.238]:22098 "HELO
	smtp103.biz.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422722AbWIGXZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 19:25:49 -0400
Message-ID: <4500AA79.10400@vhugo.net>
Date: Thu, 07 Sep 2006 16:25:45 -0700
From: Victor Hugo <victor@vhugo.net>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org, jonathan@jonmasters.org, greg@kroah.com,
       marcel@holtmann.org
Subject: [PATCH] request_firmware_examples
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



My e-mail client should die a horrible death--

Sorry Andrew, lets try this again



Signed-off-by : Victor Hugo <victor@vhugo.net>

---


diff -Nur 
linux-2.6.17.11/Documentation/firmware_class/firmware_example.c 
linux/Documentation/firmware_class/firmware_example.c
--- linux-2.6.17.11/Documentation/firmware_class/firmware_example.c     
1969-12-31 16:00:00.000000000 -0800
+++ linux/Documentation/firmware_class/firmware_example.c       
2006-09-06 00:57:45.000000000 -0700
@@ -0,0 +1,68 @@
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
+       u8 *buf = kmalloc(size + 1, GFP_KERNEL);
+       memcpy(buf, firmware, size);
+       buf[size] = '\0';
+       printk(KERN_INFO "firmware_example: Firmware: %s\n", buf);
+       kfree(buf);
+}
+
+static void sample_probe(struct device *dev)
+{
+       /* uses the default method to get the firmware */
+       const struct firmware *fw_entry;
+       printk(KERN_INFO "firmware_example: ghost device inserted\n");
+
+       if (request_firmware(&fw_entry, "sample_firware.bin", dev) != 0) {
+               printk(KERN_ERR "firmware_example: Firmware not 
available\n");
+               return;
+       }
+
+       sample_firmware_load(fw_entry->data, fw_entry->size);
+
+       release_firmware(fw_entry);
+
+       /* finish setting up the device */
+}
+
+static void ghost_release(struct device *dev)
+{
+       printk(KERN_DEBUG "firmware_example : ghost device released\n");
+}
+
+static struct device ghost_device = {
+       .bus_id = "ghost0",
+       .release = ghost_release
+};
+
+static int __init sample_init(void)
+{
+       device_register(&ghost_device);
+       sample_probe(&ghost_device);
+       return 0;
+}
+static void __exit sample_exit(void)
+{
+       device_unregister(&ghost_device);
+}
+
+module_init(sample_init);
+module_exit(sample_exit);
+
+MODULE_LICENSE("GPL");
diff -Nur 
linux-2.6.17.11/Documentation/firmware_class/firmware_nowait_example.c 
linux/Documentation/firmware_class/firmware_nowait_example.c
--- 
linux-2.6.17.11/Documentation/firmware_class/firmware_nowait_example.c      
1969-12-31 16:00:00.000000000 -0800
+++ linux/Documentation/firmware_class/firmware_nowait_example.c        
2006-09-06 00:58:06.000000000 -0700
@@ -0,0 +1,83 @@
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
+       u8 *buf = kmalloc(size + 1, GFP_KERNEL);
+       memcpy(buf, firmware, size);
+       buf[size] = '\0';
+       printk(KERN_INFO "firmware_example: Firmware: %s\n", buf);
+       kfree(buf);
+}
+
+static void sample_probe_async_cont(const struct firmware *fw, void 
*context)
+{
+       if (!fw) {
+               printk(KERN_ERR
+                      "firmware_nowait_example: Firmware not available\n");
+               return;
+       }
+
+       printk(KERN_INFO "firmware_nowait_example: Device Pointer \"%s\"\n",
+              (char *)context);
+       sample_firmware_load(fw->data, fw->size);
+
+}
+
+static void sample_probe_async(struct device *dev)
+{
+       /* Let's say I can't sleep */
+       int error;
+
+       printk(KERN_INFO "firmware_example: ghost device inserted\n");
+
+       error = request_firmware_nowait(THIS_MODULE, FW_ACTION_NOHOTPLUG,
+                                       "sample_firmware.bin", dev,
+                                       "my device pointer",
+                                       sample_probe_async_cont);
+
+       if (error) {
+               printk(KERN_ERR
+                      "firmware_nowait_example: request_firmware_nowait 
Failed\n");
+       }
+
+}
+
+static void ghost_release(struct device *dev)
+{
+       printk(KERN_DEBUG "firmware_nowait_example: ghost device 
released\n");
+}
+
+static struct device ghost_device = {
+       .bus_id = "ghost0",
+       .release = ghost_release
+};
+
+static int __init sample_init(void)
+{
+       device_register(&ghost_device);
+       sample_probe_async(&ghost_device);
+       return 0;
+}
+static void __exit sample_exit(void)
+{
+       device_unregister(&ghost_device);
+}
+
+module_init(sample_init);
+module_exit(sample_exit);
+
+MODULE_LICENSE("GPL");
diff -Nur 
linux-2.6.17.11/Documentation/firmware_class/firmware_sample_driver.c 
linux/Documentation/firmware_class/firmware_sample_driver.c
--- 
linux-2.6.17.11/Documentation/firmware_class/firmware_sample_driver.c       
2006-08-23 14:16:33.000000000 -0700
+++ linux/Documentation/firmware_class/firmware_sample_driver.c 
1969-12-31 16:00:00.000000000 -0800
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
-       .bus_id    = "ghost0",
-};
-
-
-static void sample_firmware_load(char *firmware, int size)
-{
-       u8 buf[size+1];
-       memcpy(buf, firmware, size);
-       buf[size] = '\0';
-       printk(KERN_INFO "firmware_sample_driver: firmware: %s\n", buf);
-}
-
-static void sample_probe_default(void)
-{
-       /* uses the default method to get the firmware */
-        const struct firmware *fw_entry;
-       printk(KERN_INFO "firmware_sample_driver: a ghost device got 
inserted :)\n");
-
-        if(request_firmware(&fw_entry, "sample_driver_fw", 
&ghost_device)!=0)
-       {
-               printk(KERN_ERR
-                      "firmware_sample_driver: Firmware not available\n");
-               return;
-       }
-
-       sample_firmware_load(fw_entry->data, fw_entry->size);
-
-       release_firmware(fw_entry);
-
-       /* finish setting up the device */
-}
-static void sample_probe_specific(void)
-{
-       /* Uses some specific hotplug support to get the firmware from
-        * userspace  directly into the hardware, or via some sysfs file */
-
-       /* NOTE: This currently doesn't work */
-
-       printk(KERN_INFO "firmware_sample_driver: a ghost device got 
inserted :)\n");
-
-        if(request_firmware(NULL, "sample_driver_fw", &ghost_device)!=0)
-       {
-               printk(KERN_ERR
-                      "firmware_sample_driver: Firmware load failed\n");
-               return;
-       }
-
-       /* request_firmware blocks until userspace finished, so at
-        * this point the firmware should be already in the device */
-
-       /* finish setting up the device */
-}
-static void sample_probe_async_cont(const struct firmware *fw, void 
*context)
-{
-       if(!fw){
-               printk(KERN_ERR
-                      "firmware_sample_driver: firmware load failed\n");
-               return;
-       }
-
-       printk(KERN_INFO "firmware_sample_driver: device pointer \"%s\"\n",
-              (char *)context);
-       sample_firmware_load(fw->data, fw->size);
-}
-static void sample_probe_async(void)
-{
-       /* Let's say that I can't sleep */
-       int error;
-       error = request_firmware_nowait (THIS_MODULE, FW_ACTION_NOHOTPLUG,
-                                        "sample_driver_fw", &ghost_device,
-                                        "my device pointer",
-                                        sample_probe_async_cont);
-       if(error){
-               printk(KERN_ERR
-                      "firmware_sample_driver:"
-                      " request_firmware_nowait failed\n");
-       }
-}
-
-static int sample_init(void)
-{
-       device_initialize(&ghost_device);
-       /* since there is no real hardware insertion I just call the
-        * sample probe functions here */
-       sample_probe_specific();
-       sample_probe_default();
-       sample_probe_async();
-       return 0;
-}
-static void __exit sample_exit(void)
-{
-}
-
-module_init (sample_init);
-module_exit (sample_exit);
-
-MODULE_LICENSE("GPL");
