Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbUAOUqQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 15:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbUAOUos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 15:44:48 -0500
Received: from mail.kroah.org ([65.200.24.183]:20443 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262686AbUAOUoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 15:44:10 -0500
Date: Thu, 15 Jan 2004 12:41:53 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: [PATCH] add sysfs class support for mem devices [04/10]
Message-ID: <20040115204153.GE22199@kroah.com>
References: <20040115204048.GA22199@kroah.com> <20040115204111.GB22199@kroah.com> <20040115204125.GC22199@kroah.com> <20040115204138.GD22199@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040115204138.GD22199@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This adds class/mem/ for all memory devices (random, raw, null, etc.)

diff -Nru a/drivers/char/mem.c b/drivers/char/mem.c
--- a/drivers/char/mem.c	Thu Jan 15 11:06:02 2004
+++ b/drivers/char/mem.c	Thu Jan 15 11:06:02 2004
@@ -24,6 +24,7 @@
 #include <linux/smp_lock.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/ptrace.h>
+#include <linux/device.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -676,6 +677,8 @@
 	{11,"kmsg",    S_IRUGO | S_IWUSR,           &kmsg_fops},
 };
 
+static struct class_simple *mem_class;
+
 static int __init chr_dev_init(void)
 {
 	int i;
@@ -683,7 +686,11 @@
 	if (register_chrdev(MEM_MAJOR,"mem",&memory_fops))
 		printk("unable to get major %d for memory devs\n", MEM_MAJOR);
 
+	mem_class = class_simple_create(THIS_MODULE, "mem");
 	for (i = 0; i < ARRAY_SIZE(devlist); i++) {
+		class_simple_device_add(mem_class,
+					MKDEV(MEM_MAJOR, devlist[i].minor),
+					NULL, devlist[i].name);
 		devfs_mk_cdev(MKDEV(MEM_MAJOR, devlist[i].minor),
 				S_IFCHR | devlist[i].mode, devlist[i].name);
 	}
