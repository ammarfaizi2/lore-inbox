Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280878AbRKTFVo>; Tue, 20 Nov 2001 00:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280892AbRKTFVf>; Tue, 20 Nov 2001 00:21:35 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:43025 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S280878AbRKTFVR>;
	Tue, 20 Nov 2001 00:21:17 -0500
Date: Mon, 19 Nov 2001 22:19:03 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: [PATCH] PCI Hotplug core bugfix
Message-ID: <20011119221903.D3736@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a patch against 2.4.15-pre7 that fixes a potential overflow
problem in the PCI Hotplug core code.  Thanks to Andrew Morton for
pointing this out to me.

thanks,

greg k-h


diff --minimal -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Mon Nov 19 20:55:21 2001
+++ b/drivers/hotplug/pci_hotplug_core.c	Mon Nov 19 20:55:21 2001
@@ -622,7 +622,7 @@
 static ssize_t power_write_file (struct file *file, const char *ubuff, size_t count, loff_t *offset)
 {
 	struct hotplug_slot *slot = file->private_data;
-	const char *buff;
+	char *buff;
 	unsigned long lpower;
 	u8 power;
 	int retval = 0;
@@ -639,10 +639,11 @@
 		return -ENODEV;
 	}
 
-	buff = kmalloc (count, GFP_KERNEL);
+	buff = kmalloc (count + 1, GFP_KERNEL);
 	if (!buff)
 		return -ENOMEM;
-
+	memset (buff, 0x00, count + 1);
+ 
 	if (copy_from_user ((void *)buff, (void *)ubuff, count)) {
 		retval = -EFAULT;
 		goto exit;
@@ -732,7 +733,7 @@
 static ssize_t attention_write_file (struct file *file, const char *ubuff, size_t count, loff_t *offset)
 {
 	struct hotplug_slot *slot = file->private_data;
-	const char *buff;
+	char *buff;
 	unsigned long lattention;
 	u8 attention;
 	int retval = 0;
@@ -749,9 +750,10 @@
 		return -ENODEV;
 	}
 
-	buff = kmalloc (count, GFP_KERNEL);
+	buff = kmalloc (count + 1, GFP_KERNEL);
 	if (!buff)
 		return -ENOMEM;
+	memset (buff, 0x00, count + 1);
 
 	if (copy_from_user ((void *)buff, (void *)ubuff, count)) {
 		retval = -EFAULT;
@@ -868,7 +870,7 @@
 static ssize_t test_write_file (struct file *file, const char *ubuff, size_t count, loff_t *offset)
 {
 	struct hotplug_slot *slot = file->private_data;
-	const char *buff;
+	char *buff;
 	unsigned long ltest;
 	u32 test;
 	int retval = 0;
@@ -885,9 +887,10 @@
 		return -ENODEV;
 	}
 
-	buff = kmalloc (count, GFP_KERNEL);
+	buff = kmalloc (count + 1, GFP_KERNEL);
 	if (!buff)
 		return -ENOMEM;
+	memset (buff, 0x00, count + 1);
 
 	if (copy_from_user ((void *)buff, (void *)ubuff, count)) {
 		retval = -EFAULT;

