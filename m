Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751521AbWBENzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbWBENzj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 08:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbWBENzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 08:55:39 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:46514 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751521AbWBENzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 08:55:39 -0500
Date: Sun, 5 Feb 2006 13:55:17 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH, RFC] Driver for reading HP laptop LCD brightness
Message-ID: <20060205135517.GA21795@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch provides a sysfs mechanism for reading the LCD 
brightness on HP laptops. Since there's no clean way to determine 
whether a machine is a laptop or not from within the kernel (this 
information is in the DMI tables, but we don't currently export the 
chassis field), it does nothing until userspace has enabled it.

Right now, I'm looking for comments on how to integrate it sensibly - 
leaving it under drivers/misc and registering it as a platform device 
/works/, but isn't terribly clean.

Patch is against the Ubuntu kernel tree, so the Makefile and Kconfig 
hunks may need a tiny bit of massaging.

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 25f6d65..040ffa1 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -28,6 +28,13 @@ config IBM_ASM
 
 	  If unsure, say N.
 
+config HPLCD
+	tristate "Device driver HP LCD brightness"
+	depends on X86 && EXPERIMENTAL
+	default n
+	---help---
+	Provides a sysfs interface to read the screen brightness on HP laptops
+
 config AVERATEC_5100P
         tristate "Device driver for Averatec 5100P SW Switch"
 	depends on X86 && EXPERIMENTAL
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 3bf328a..7658427 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -3,6 +3,7 @@
 #
 obj- := misc.o	# Dummy rule to force built-in.o to be made
 
+obj-$(CONFIG_HPLCD)	+= hplcd.o
 obj-$(CONFIG_IBM_ASM)	+= ibmasm/
 obj-$(CONFIG_HDPU_FEATURES)	+= hdpuftrs/
 obj-$(CONFIG_AVERATEC_5100P) += av5100.o
diff --git a/drivers/misc/hplcd.c b/drivers/misc/hplcd.c
new file mode 100644
index 0000000..4174135
--- /dev/null
+++ b/drivers/misc/hplcd.c
@@ -0,0 +1,159 @@
+/*
+ * hplcd.c - driver to provide backlight information for HP laptops
+ *
+ * Copyright (C) 2006 Matthew Garrett <mjg59@srcf.ucam.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License v2 as published by the
+ * Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA
+ */
+
+#include <linux/module.h>
+#include <linux/dmi.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/sysfs.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <asm/io.h>
+
+static int enable;
+static struct platform_device *pdev = NULL;
+
+static struct dmi_system_id __initdata hplcd_device_table[] = {
+	{ 
+		.ident = "HP",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
+		},
+	},
+	{ }
+};
+
+static ssize_t store_enable(struct device *dev, 
+			    struct device_attribute *attr,
+			    const char * buf,
+			    size_t count)
+{
+	char *last = NULL;
+	if (simple_strtoul(buf, &last, 0) >0) {
+		enable = 1;
+	} else {
+		enable = 0;
+	}
+	
+	return count;
+}
+
+static ssize_t show_enable(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", enable);
+}
+
+static ssize_t show_ac_brt(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	int value;
+
+	if (enable==0) {
+		return snprintf(buf, PAGE_SIZE, "NA\n");
+	}
+
+	disable_irq(8);
+
+	outb(0x97, 0x72);
+	value = inb(0x73);
+	
+	enable_irq(8);
+
+	value &= 0x1f; // Brightness is in the lower 5 bits
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", value);
+}
+
+static ssize_t show_dc_brt(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	int value;
+
+	if (enable==0) {
+		return snprintf(buf, PAGE_SIZE, "NA\n");
+	}
+
+	disable_irq(8);
+
+	outb(0x99, 0x72);
+	value = inb(0x73);
+	
+	enable_irq(8);
+
+	value &= 0x1f; // Brightness is in the lower 5 bits
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", value);
+}
+
+static DEVICE_ATTR(enable, 0644, show_enable, store_enable);
+static DEVICE_ATTR(ac_brt, 0644, show_ac_brt, NULL);
+static DEVICE_ATTR(dc_brt, 0644, show_dc_brt, NULL);
+
+static struct attribute *hplcd_attributes[] = {
+	&dev_attr_enable.attr,
+	&dev_attr_ac_brt.attr,
+	&dev_attr_dc_brt.attr,
+	NULL,
+};
+
+static struct attribute_group hplcd_attribute_group = {
+	.attrs = hplcd_attributes,
+};
+
+static struct platform_driver hplcd_driver = {
+	.driver = {
+		.name = "hplcd",
+		.owner = THIS_MODULE,
+	}
+};
+
+static int __init hplcd_init(void)
+{
+	int rc;
+
+	if (!dmi_check_system(hplcd_device_table))
+		return -ENODEV;
+
+	if (rc = platform_driver_register(&hplcd_driver))
+		return rc;
+
+	pdev = platform_device_register_simple("hplcd", -1, NULL, 0);
+	
+	if (IS_ERR(pdev)) {
+		rc = PTR_ERR(pdev);
+		return rc;
+	}
+
+	if (rc = sysfs_create_group(&pdev->dev.kobj, &hplcd_attribute_group))
+		return rc;
+
+	return 0;
+}
+
+static void __exit hplcd_exit(void)
+{
+	sysfs_remove_group(&pdev->dev.kobj, &hplcd_attribute_group);
+	platform_device_unregister(pdev);
+	platform_driver_unregister(&hplcd_driver);
+}
+
+module_init(hplcd_init);
+module_exit(hplcd_exit);
+MODULE_LICENSE("GPL");


-- 
Matthew Garrett | mjg59@srcf.ucam.org
