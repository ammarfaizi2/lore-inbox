Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTLWVdf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 16:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbTLWVc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 16:32:26 -0500
Received: from mail.kroah.org ([65.200.24.183]:50911 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262603AbTLWVbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 16:31:41 -0500
Date: Tue, 23 Dec 2003 13:29:29 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: [PATCH] add sysfs mem class  [3/5]
Message-ID: <20031223212929.GD15700@kroah.com>
References: <20031223212459.GA15700@kroah.com> <20031223212620.GB15700@kroah.com> <20031223212739.GC15700@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223212739.GC15700@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adds support for mem class devices.  Hopefully one day the
/proc/sys/kernel/random files will move under sysfs into the location
created by this patch (yeah, I know about the sysctl logic...)



diff -Nru a/drivers/char/mem.c b/drivers/char/mem.c
--- a/drivers/char/mem.c	Tue Dec 23 12:53:45 2003
+++ b/drivers/char/mem.c	Tue Dec 23 12:53:45 2003
@@ -24,6 +24,7 @@
 #include <linux/smp_lock.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/ptrace.h>
+#include <linux/device.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -676,6 +677,10 @@
 	{11,"kmsg",    S_IRUGO | S_IWUSR,           &kmsg_fops},
 };
 
+static struct class mem_class = {
+	.name	= "mem",
+};
+
 static int __init chr_dev_init(void)
 {
 	int i;
@@ -683,7 +688,11 @@
 	if (register_chrdev(MEM_MAJOR,"mem",&memory_fops))
 		printk("unable to get major %d for memory devs\n", MEM_MAJOR);
 
+	class_register(&mem_class);
 	for (i = 0; i < ARRAY_SIZE(devlist); i++) {
+		simple_add_class_device(&mem_class,
+					MKDEV(MEM_MAJOR, devlist[i].minor),
+					NULL, devlist[i].name);
 		devfs_mk_cdev(MKDEV(MEM_MAJOR, devlist[i].minor),
 				S_IFCHR | devlist[i].mode, devlist[i].name);
 	}
