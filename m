Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVCaHub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVCaHub (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 02:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVCaHsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 02:48:02 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:47754 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261164AbVCaHoj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 02:44:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=r0Abr/sRb5FXAmODXZJlpL4zB0HZAZF7Nifknn/e6nsuQ/mit72o/46O/npr5kZeQPZ+cxX7h5sk4XZKhjOrGtTbVdGD+uN+L2OxLCr2fZnAzzCe+IyOw7qkPPiqs56gD6jIsobwqxE+8mbw3FVTMpbOShzVjThlRNpULO00lrE=
Message-ID: <df35dfeb05033023445c386d2d@mail.gmail.com>
Date: Wed, 30 Mar 2005 23:44:38 -0800
From: Yum Rayan <yum.rayan@gmail.com>
Reply-To: Yum Rayan <yum.rayan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Reduce stack usage in sys.c
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attempt to reduce stack usage in sys.c (linux-2.6.12-rc1-mm3). Stack
usage was noted using checkstack.pl. Specifically

Before patch
------------
sys_reboot - 256

After patch
-----------
sys_reboot - none (register usage only)

Along the way, wrap code to 80 column width and cleanup lock usage.

Signed-off-by: Yum Rayan <yum.rayan@gmail.com>

--- a/kernel/sys.c	2005-03-25 22:11:06.000000000 -0800
+++ b/kernel/sys.c	2005-03-30 22:34:03.000000000 -0800
@@ -369,9 +369,9 @@
  *
  * reboot doesn't sync: do that yourself before calling this.
  */
-asmlinkage long sys_reboot(int magic1, int magic2, unsigned int cmd,
void __user * arg)
+asmlinkage long sys_reboot(int magic1, int magic2,
+			   unsigned int cmd, void __user * arg)
 {
-	char buffer[256];
 
 	/* We only trust the superuser with rebooting the system. */
 	if (!capable(CAP_SYS_BOOT))
@@ -385,14 +385,15 @@
 	                magic2 != LINUX_REBOOT_MAGIC2C))
 		return -EINVAL;
 
-	lock_kernel();
 	switch (cmd) {
 	case LINUX_REBOOT_CMD_RESTART:
+		lock_kernel();
 		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
 		system_state = SYSTEM_RESTART;
 		device_shutdown();
 		printk(KERN_EMERG "Restarting system.\n");
 		machine_restart(NULL);
+		unlock_kernel();
 		break;
 
 	case LINUX_REBOOT_CMD_CAD_ON:
@@ -404,6 +405,7 @@
 		break;
 
 	case LINUX_REBOOT_CMD_HALT:
+		lock_kernel();
 		notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
 		system_state = SYSTEM_HALT;
 		device_shutdown();
@@ -414,6 +416,7 @@
 		break;
 
 	case LINUX_REBOOT_CMD_POWER_OFF:
+		lock_kernel();
 		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
 		system_state = SYSTEM_POWER_OFF;
 		device_shutdown();
@@ -424,51 +427,60 @@
 		break;
 
 	case LINUX_REBOOT_CMD_RESTART2:
-		if (strncpy_from_user(&buffer[0], arg, sizeof(buffer) - 1) < 0) {
-			unlock_kernel();
+	{
+		char *buffer;
+		buffer = kmalloc(256, GFP_KERNEL);
+		if (!buffer)
+			return -ENOMEM;
+		if (strncpy_from_user(buffer, arg, 255) < 0) {
+			kfree(buffer);
 			return -EFAULT;
 		}
-		buffer[sizeof(buffer) - 1] = '\0';
-
+		buffer[255] = '\0';
+		lock_kernel();
 		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, buffer);
 		system_state = SYSTEM_RESTART;
 		device_shutdown();
-		printk(KERN_EMERG "Restarting system with command '%s'.\n", buffer);
+		printk(KERN_EMERG "Restarting system with command '%s'.\n",
+									buffer);
 		machine_restart(buffer);
+		unlock_kernel();
+		kfree(buffer);
 		break;
-
+	}
 #ifdef CONFIG_KEXEC
 	case LINUX_REBOOT_CMD_KEXEC:
 	{
 		struct kimage *image;
 		image = xchg(&kexec_image, 0);
 		if (!image) {
-			unlock_kernel();
 			return -EINVAL;
 		}
+		lock_kernel();
 		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
 		system_state = SYSTEM_RESTART;
 		device_shutdown();
 		printk(KERN_EMERG "Starting new kernel\n");
 		machine_shutdown();
 		machine_kexec(image);
+		unlock_kernel();
 		break;
 	}
 #endif
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	case LINUX_REBOOT_CMD_SW_SUSPEND:
-		{
-			int ret = software_suspend();
-			unlock_kernel();
-			return ret;
-		}
+	{
+		int ret;
+		lock_kernel();
+		ret = software_suspend();
+		unlock_kernel();
+		return ret;
+	}
 #endif
 
 	default:
-		unlock_kernel();
 		return -EINVAL;
 	}
-	unlock_kernel();
 	return 0;
 }
