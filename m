Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265529AbUBIXea (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265501AbUBIXcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:32:41 -0500
Received: from mail.kroah.org ([65.200.24.183]:6335 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265445AbUBIX22 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:28:28 -0500
Subject: Re: [PATCH] Driver Core update for 2.6.3-rc1
In-Reply-To: <10763691402412@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:25:40 -0800
Message-Id: <10763691403705@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.19.1, 2004/02/02 15:39:32-08:00, jonsmirl@yahoo.com

[PATCH] Driver core: add hotplug support for class_simple

This is needed by the DRI code.


 drivers/base/class_simple.c |   18 ++++++++++++++++++
 include/linux/device.h      |    2 ++
 2 files changed, 20 insertions(+)


diff -Nru a/drivers/base/class_simple.c b/drivers/base/class_simple.c
--- a/drivers/base/class_simple.c	Mon Feb  9 15:09:13 2004
+++ b/drivers/base/class_simple.c	Mon Feb  9 15:09:13 2004
@@ -170,6 +170,24 @@
 EXPORT_SYMBOL(class_simple_device_add);
 
 /**
+ * class_simple_set_hotplug - set the hotplug callback in the embedded struct class
+ * @cs: pointer to the struct class_simple to hold the pointer
+ * @hotplug: function pointer to the hotplug function
+ *
+ * Implement and set a hotplug function to add environment variables specific to this 
+ * class on the hotplug event.
+ */
+int class_simple_set_hotplug(struct class_simple *cs, 
+	int (*hotplug)(struct class_device *dev, char **envp, int num_envp, char *buffer, int buffer_size))
+{
+	if ((cs == NULL) || (IS_ERR(cs)))
+		return -ENODEV;
+	cs->class.hotplug = hotplug;
+	return 0;
+}
+EXPORT_SYMBOL(class_simple_set_hotplug);
+
+/**
  * class_simple_device_remove - removes a class device that was created with class_simple_device_add()
  * @dev: the dev_t of the device that was previously registered.
  *
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Mon Feb  9 15:09:13 2004
+++ b/include/linux/device.h	Mon Feb  9 15:09:13 2004
@@ -253,6 +253,8 @@
 extern void class_simple_destroy(struct class_simple *cs);
 extern struct class_device *class_simple_device_add(struct class_simple *cs, dev_t dev, struct device *device, const char *fmt, ...)
 	__attribute__((format(printf,4,5)));
+extern int class_simple_set_hotplug(struct class_simple *, 
+	int (*hotplug)(struct class_device *dev, char **envp, int num_envp, char *buffer, int buffer_size));
 extern void class_simple_device_remove(dev_t dev);
 
 

