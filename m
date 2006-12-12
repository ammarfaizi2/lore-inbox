Return-Path: <linux-kernel-owner+w=401wt.eu-S932071AbWLLGh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWLLGh0 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 01:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWLLGh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 01:37:26 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:64448 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932071AbWLLGhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 01:37:23 -0500
Message-ID: <457E4E20.5090101@bx.jp.nec.com>
Date: Tue, 12 Dec 2006 15:37:20 +0900
From: Keiichi KII <k-keiichi@bx.jp.nec.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: mpm@selenic.com
CC: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 2.6.19 5/6] add "add" element in /sys/class/misc/netconsole
References: <457E498C.1050806@bx.jp.nec.com>
In-Reply-To: <457E498C.1050806@bx.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keiichi KII <k-keiichi@bx.jp.nec.com>

This patch contains the following changes.

To add port dynamically, create "add" element in /sys/class/misc/netconsole.

ex)
1. echo "eth0" > /sys/clas/misc/netconsole/add
   then the port is added with the default settings.

2. echo "@/eth0,@192.168.0.1/" > /sys/class/misc/netconsole/add
   then the port is added with the settings sending kernel messages
   to 192.168.0.1 using eth0 device.

-+- /sys/class/misc/
 |-+- netconsole/
   |--- add       [-w-------]  If you write parameter(network interface name
   |                           or one config parameter of netconsole), The
   |                            port related its config is added
   |--- port1/
   |--- port2/
   ...

Signed-off-by: Keiichi KII <k-keiichi@bx.jp.nec.com>
---
--- linux-2.6.19/drivers/net/netconsole.c	2006-12-06 14:37:26.874827500 +0900
+++ enhanced-netconsole/drivers/net/netconsole.c.add	2006-12-06
13:33:05.661516750 +0900
@@ -321,6 +321,50 @@ static struct miscdevice netcon_miscdev
 	.name = "netconsole",
 };

+static ssize_t set_netconmisc_add(struct class_device *cdev, const char *buf,
+				  size_t count)
+{
+	char *target;
+	char *target_param;
+
+	target_param = (char*)kmalloc(count+1, GFP_ATOMIC);
+	if (!target_param) {
+		printk(KERN_INFO "netconsole: kmalloc() failed!\n");
+		return -ENOMEM;
+	}
+
+	strcpy(target_param, buf);
+	if (target_param[count - 1] == '\n') {
+		target_param[count - 1] = '\0';
+	}
+
+	if (dev_get_by_name(target_param)) {
+		printk(KERN_INFO "netconsole: device name = [%s]\n",
+		       target_param);
+		target = (char*)kmalloc(MAX_CONFIG_LENGTH+1, GFP_ATOMIC);
+		if (!target) {
+			printk(KERN_INFO "netconsole: kmalloc() failed!\n");
+			kfree(target_param);
+			return -ENOMEM;
+		}
+		sprintf(target,"@/%s,@/", target_param);
+		add_netcon_dev(target);
+		kfree(target);
+	} else {
+		printk(KERN_INFO "netconsole: config = [%s]\n", target_param);
+		add_netcon_dev(target_param);
+	}
+	kfree(target_param);
+
+	return count;
+}
+
+static CLASS_DEVICE_ATTR(add, S_IWUSR, NULL, set_netconmisc_add);
+
+static struct class_device_attribute *netcon_misc_attr[] = {
+	&class_device_attr_add,
+};
+
 static struct netpoll np = {
 	.name = "netconsole",
 	.dev_name = "eth0",
@@ -446,6 +490,7 @@ static int __init init_netconsole(void)
 {
 	char *p;
 	char *tmp = config;
+	int i = 0;

 	if (misc_register(&netcon_miscdev)) {
 		printk(KERN_INFO
@@ -456,6 +501,11 @@ static int __init init_netconsole(void)
 	}
 	register_console(&netconsole);

+	for(i=0; i < ARRAY_SIZE(netcon_misc_attr); i++) {
+		class_device_create_file(netcon_miscdev.class,
+					 netcon_misc_attr[i]);
+	}
+
 	if(!strlen(config)) {
 		printk(KERN_INFO "netconsole: not configured\n");
 		return 0;

-- 
Keiichi KII
NEC Corporation OSS Promotion Center
E-mail: k-keiichi@bx.jp.nec.com
