Return-Path: <linux-kernel-owner+w=401wt.eu-S932349AbWLZFgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWLZFgJ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 00:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWLZFgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 00:36:09 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:42564 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932349AbWLZFgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 00:36:08 -0500
Message-ID: <4590B4BB.9090808@bx.jp.nec.com>
Date: Tue, 26 Dec 2006 14:35:55 +0900
From: Keiichi KII <k-keiichi@bx.jp.nec.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: mpm@selenic.com
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH -mm take2 5/5] add "add" element in /sys/class/misc/netconsole
References: <4590AE00.5040102@bx.jp.nec.com>
In-Reply-To: <4590AE00.5040102@bx.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keiichi KII <k-keiichi@bx.jp.nec.com>

This patch contains switch function of netpoll.

If "enabled" attribute of certain port is '1', this port is used
and the configurations of this port are uable to change.

If "enabled" attribute of certain port is '0', this port isn't used
and the configurations of this port are able to change.

-+- /sys/class/misc/
|-+- netconsole/
  |-+- port1/
  | |--- id          [r--r--r--]  id
  | |--- enabled     [rw-r--r--]  0: disable 1: enable, writable
  | ...
  |--- port2/
  ...

Signed-off-by: Keiichi KII <k-keiichi@bx.jp.nec.com>
Signed-off-by: Takayoshi Kochi <t-kochi@bq.jp.nec.com>
---
--- linux-mm/drivers/net/netconsole.c	2006-12-26 14:19:01.481857000 +0900
+++ enhanced-netconsole/drivers/net/netconsole.c.add	2006-12-25 16:45:05.121887750 +0900
@@ -335,6 +335,30 @@ static struct miscdevice netconsole_misc
 	.name = "netconsole",
 };
 
+static ssize_t store_miscdev_add(struct class_device *cdev,
+					const char *buf, size_t count)
+{
+	char *target_param;
+
+	target_param = kmalloc(count+1, GFP_KERNEL);
+	if (!target_param) {
+		printk(KERN_ERR "netconsole: kmalloc() failed!\n");
+		return -ENOMEM;
+	}
+
+	strcpy(target_param, buf);
+	if (target_param[count - 1] == '\n')
+		target_param[count - 1] = '\0';
+
+	printk(KERN_INFO "netconsole: config = [%s]\n", target_param);
+	add_target(target_param);
+	kfree(target_param);
+
+	return count;
+}
+
+static CLASS_DEVICE_ATTR(add, S_IWUSR, NULL, store_miscdev_add);
+
 static struct netpoll np = {
 	.name = "netconsole",
 	.dev_name = "eth0",
@@ -464,6 +488,9 @@ static int __init init_netconsole(void)
 
 	register_console(&netconsole);
 
+	class_device_create_file(netconsole_miscdev.class,
+				 &class_device_attr_add);
+
 	if(!strlen(config)) {
 		printk(KERN_ERR "netconsole: not configured\n");
 		return 0;


-- 
Keiichi KII
NEC Corporation OSS Promotion Center
E-mail: k-keiichi@bx.jp.nec.com
