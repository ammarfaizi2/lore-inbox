Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752838AbWKBNOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbWKBNOs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 08:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752834AbWKBNOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 08:14:48 -0500
Received: from py-out-1112.google.com ([64.233.166.179]:1866 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1752843AbWKBNOr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 08:14:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:organization:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=eZnmFgx/HFBsgPYIn0bywzI9OxzqU+7pTfUh18SASupkMC3Ft5+aoET+yEiXvRnIwz6bNvhmlt+CYITc7Sc0RVpWnxG5uar2QY6NThOFP62yZhPTzucdQOsVKgRvYDlbKwNSjnb0+70HQAxT0GQ8szTunXcbUXLd1hc8fU9ZaEs=
From: Yu Luming <luming.yu@gmail.com>
Organization: gmail
To: Andrew Morton <akpm@osdl.org>
Subject: [patch 2/6] Add display output class support
Date: Sat, 4 Nov 2006 21:13:56 +0800
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, len.brown@intel.com,
       Matt Domsch <Matt_Domsch@dell.com>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr,
       Richard Hughes <hughsient@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611042113.56913.luming.yu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add display output class support

signed-off-by   Luming.yu@gmail.com
---
 drivers/video/output.c |  129 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/output.h |   42 +++++++++++++++
 2 files changed, 171 insertions(+)

diff --git a/drivers/video/output.c b/drivers/video/output.c
new file mode 100644
index 0000000..4142662
--- /dev/null
+++ b/drivers/video/output.c
@@ -0,0 +1,129 @@
+/*
+ *  output.c - Display output swither driver
+ *
+ *  Copyright (C) 2006 Luming Yu <luming.yu@gmail.com>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or (at
+ *  your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+#include <linux/module.h>
+#include <linux/output.h>
+#include <linux/err.h>
+#include <linux/ctype.h>
+
+
+MODULE_DESCRIPTION("Display Output Switcher Lowlevel Control Abstraction");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Luming Yu <luming.yu@intel.com>");
+
+static ssize_t video_output_show_state(struct class_device *dev,char *buf)
+{
+	ssize_t ret_size = 0;
+	struct output_device *od = to_output_device(dev);
+	if (od->props)
+		ret_size = sprintf(buf,"%.8x\n",od->props->get_status(od));
+	return ret_size;
+}
+
+static ssize_t video_output_store_state(struct class_device *dev,
+	const char *buf,size_t count)
+{
+	char *endp;
+	struct output_device *od = to_output_device(dev);
+	int request_state = simple_strtoul(buf,&endp,0);
+	size_t size = endp - buf;
+
+        if (*endp && isspace(*endp))
+                size++;
+        if (size != count)
+                return -EINVAL;
+
+	if (od->props) {
+		od->request_state = request_state;
+		od->props->set_state(od);
+	}
+	return count;
+}
+
+static void video_output_class_release(struct class_device *dev)
+{
+        struct output_device *od = to_output_device(dev);
+        kfree(od);
+}
+
+static struct class_device_attribute video_output_attributes[] = {
+	__ATTR(state, 0644, video_output_show_state, video_output_store_state),
+	__ATTR_NULL,
+};
+
+static struct class video_output_class = {
+	.name = "video_output",
+	.release = video_output_class_release,
+	.class_dev_attrs = video_output_attributes,
+};
+
+struct output_device *video_output_register(const char *name,
+	struct device *dev,
+	void *devdata,
+	struct output_properties *op)
+{
+	struct output_device *new_dev;
+	int ret_code = 0;
+
+	new_dev = kzalloc(sizeof(struct output_device),GFP_KERNEL);
+	if (!new_dev) {
+		ret_code = -ENOMEM;
+		goto error_return;
+	}
+	new_dev->props = op;
+	new_dev->class_dev.class = &video_output_class;
+	new_dev->class_dev.dev = dev;
+	strlcpy(new_dev->class_dev.class_id,name,KOBJ_NAME_LEN);
+	class_set_devdata(&new_dev->class_dev,devdata);
+	ret_code = class_device_register(&new_dev->class_dev);
+	if (ret_code) {
+		kfree(new_dev);
+		goto error_return;
+	}
+	return new_dev;
+
+error_return:
+	return ERR_PTR(ret_code);
+}
+EXPORT_SYMBOL(video_output_register);
+
+void video_output_unregister(struct output_device *dev)
+{
+	if (!dev)
+		return;
+	class_device_unregister(&dev->class_dev);
+}
+EXPORT_SYMBOL(video_output_unregister);
+
+static void __exit video_output_class_exit(void)
+{
+	class_unregister(&video_output_class);
+}
+
+static int __init video_output_class_init(void)
+{
+	return class_register(&video_output_class);
+}
+
+postcore_initcall(video_output_class_init);
+module_exit(video_output_class_exit);
diff --git a/include/linux/output.h b/include/linux/output.h
new file mode 100644
index 0000000..6fc47f5
--- /dev/null
+++ b/include/linux/output.h
@@ -0,0 +1,42 @@
+/*
+ *
+ *  Copyright (C) 2006 Luming Yu <luming.yu@gmail.com>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or (at
+ *  your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+#ifndef _LINUX_OUTPUT_H
+#define _LINUX_OUTPUT_H
+#include <linux/device.h>
+struct output_device;
+struct output_properties {
+	int (*set_state)(struct output_device *);
+	int (*get_status)(struct output_device *);
+};
+struct output_device {
+	int request_state;
+	struct output_properties *props;
+	struct class_device class_dev;
+};
+#define to_output_device(obj) container_of(obj, struct output_device, class_dev)
+struct output_device *video_output_register(const char *name,
+	struct device *dev,
+	void *devdata,
+	struct output_properties *op);
+void video_output_unregister(struct output_device *dev);
+#endif
