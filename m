Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275477AbTHJJQJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 05:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275486AbTHJJQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 05:16:09 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:9489 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S275477AbTHJJQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 05:16:03 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.6.0-test3] i386 msr.c devfs support 1/2
Date: Sun, 10 Aug 2003 12:51:03 +0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_3dgN/d3G9wl+Wyc"
Message-Id: <200308101251.03605.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_3dgN/d3G9wl+Wyc
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Please let me know if default permissions (644) are not appropriate. Tested on 
2-way SMP kernel single CPU system; it correctly rejects access to 
no-existing CPU.

/dev/cpu/N is not removed on module unload. It is impossible to cleanly 
unregister directories shared by independent drivers given current devfs 
implementation (no actual refcounting)

-andrey
--Boundary-00=_3dgN/d3G9wl+Wyc
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.6.0-test3-msr_devfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.6.0-test3-msr_devfs.patch"

--- linux-2.6.0-test3-smp/arch/i386/kernel/msr.c.devfs	2003-06-26 21:39:26.000000000 +0400
+++ linux-2.6.0-test3-smp/arch/i386/kernel/msr.c	2003-08-09 22:29:56.000000000 +0400
@@ -37,6 +37,8 @@
 #include <linux/major.h>
 #include <linux/fs.h>
 
+#include <linux/devfs_fs_kernel.h>
+
 #include <asm/processor.h>
 #include <asm/msr.h>
 #include <asm/uaccess.h>
@@ -263,17 +265,28 @@ static struct file_operations msr_fops =
 
 int __init msr_init(void)
 {
+  int i;
+
   if (register_chrdev(MSR_MAJOR, "cpu/msr", &msr_fops)) {
     printk(KERN_ERR "msr: unable to get major %d for msr\n",
 	   MSR_MAJOR);
     return -EBUSY;
   }
+
+  for (i = 0; i < NR_CPUS; i++)
+    devfs_mk_cdev(MKDEV(MSR_MAJOR, i), S_IFCHR | S_IRUGO | S_IWUSR,
+		  "cpu/%d/msr", i);
   
   return 0;
 }
 
 void __exit msr_exit(void)
 {
+  int i;
+
+  for (i = 0; i < NR_CPUS; i++)
+    devfs_remove("cpu/%d/msr", i);
+  
   unregister_chrdev(MSR_MAJOR, "cpu/msr");
 }
 

--Boundary-00=_3dgN/d3G9wl+Wyc--

