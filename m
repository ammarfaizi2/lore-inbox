Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162259AbWLAX2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162259AbWLAX2B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162274AbWLAXXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:23:50 -0500
Received: from cantor.suse.de ([195.135.220.2]:24205 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1162257AbWLAXXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:23:10 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 17/36] Driver core: convert cpuid code to use struct device
Date: Fri,  1 Dec 2006 15:21:47 -0800
Message-Id: <11650153792132-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650153763330-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com> <11650153463092-git-send-email-greg@kroah.com> <1165015349830-git-send-email-greg@kroah.com> <11650153522862-git-send-email-greg@kroah.com> <116501535622-git-send-email-greg@kroah.com> <11650153591876-git-send-email-greg@kroah.com> <11650153631070-git-send-email-greg@kroah.com> <1165015366759-git-send-email-greg@kroah.com> <11650153704007-git-send-email-greg@kroah.com> <11650153733277-git-send-email-greg@kroah.com> <11650153763330-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Converts from using struct "class_device" to "struct device" making
everything show up properly in /sys/devices/ with symlinks from the
/sys/class directory.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/i386/kernel/cpuid.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/i386/kernel/cpuid.c b/arch/i386/kernel/cpuid.c
index fde8bea..ab0c327 100644
--- a/arch/i386/kernel/cpuid.c
+++ b/arch/i386/kernel/cpuid.c
@@ -156,14 +156,14 @@ static struct file_operations cpuid_fops
 	.open = cpuid_open,
 };
 
-static int cpuid_class_device_create(int i)
+static int cpuid_device_create(int i)
 {
 	int err = 0;
-	struct class_device *class_err;
+	struct device *dev;
 
-	class_err = class_device_create(cpuid_class, NULL, MKDEV(CPUID_MAJOR, i), NULL, "cpu%d",i);
-	if (IS_ERR(class_err))
-		err = PTR_ERR(class_err);
+	dev = device_create(cpuid_class, NULL, MKDEV(CPUID_MAJOR, i), "cpu%d",i);
+	if (IS_ERR(dev))
+		err = PTR_ERR(dev);
 	return err;
 }
 
@@ -174,10 +174,10 @@ static int cpuid_class_cpu_callback(stru
 
 	switch (action) {
 	case CPU_ONLINE:
-		cpuid_class_device_create(cpu);
+		cpuid_device_create(cpu);
 		break;
 	case CPU_DEAD:
-		class_device_destroy(cpuid_class, MKDEV(CPUID_MAJOR, cpu));
+		device_destroy(cpuid_class, MKDEV(CPUID_MAJOR, cpu));
 		break;
 	}
 	return NOTIFY_OK;
@@ -206,7 +206,7 @@ static int __init cpuid_init(void)
 		goto out_chrdev;
 	}
 	for_each_online_cpu(i) {
-		err = cpuid_class_device_create(i);
+		err = cpuid_device_create(i);
 		if (err != 0) 
 			goto out_class;
 	}
@@ -218,7 +218,7 @@ static int __init cpuid_init(void)
 out_class:
 	i = 0;
 	for_each_online_cpu(i) {
-		class_device_destroy(cpuid_class, MKDEV(CPUID_MAJOR, i));
+		device_destroy(cpuid_class, MKDEV(CPUID_MAJOR, i));
 	}
 	class_destroy(cpuid_class);
 out_chrdev:
@@ -232,7 +232,7 @@ static void __exit cpuid_exit(void)
 	int cpu = 0;
 
 	for_each_online_cpu(cpu)
-		class_device_destroy(cpuid_class, MKDEV(CPUID_MAJOR, cpu));
+		device_destroy(cpuid_class, MKDEV(CPUID_MAJOR, cpu));
 	class_destroy(cpuid_class);
 	unregister_chrdev(CPUID_MAJOR, "cpu/cpuid");
 	unregister_hotcpu_notifier(&cpuid_class_cpu_notifier);
-- 
1.4.4.1

