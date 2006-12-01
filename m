Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162344AbWLAX2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162344AbWLAX2A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162259AbWLAXXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:23:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:31725 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1162247AbWLAXXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:23:07 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 16/36] Driver core: convert msr code to use struct device
Date: Fri,  1 Dec 2006 15:21:46 -0800
Message-Id: <11650153763330-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650153733277-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com> <11650153463092-git-send-email-greg@kroah.com> <1165015349830-git-send-email-greg@kroah.com> <11650153522862-git-send-email-greg@kroah.com> <116501535622-git-send-email-greg@kroah.com> <11650153591876-git-send-email-greg@kroah.com> <11650153631070-git-send-email-greg@kroah.com> <1165015366759-git-send-email-greg@kroah.com> <11650153704007-git-send-email-greg@kroah.com> <11650153733277-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Converts from using struct "class_device" to "struct device" making
everything show up properly in /sys/devices/ with symlinks from the
/sys/class directory.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/i386/kernel/msr.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/i386/kernel/msr.c b/arch/i386/kernel/msr.c
index d535cdb..a773f77 100644
--- a/arch/i386/kernel/msr.c
+++ b/arch/i386/kernel/msr.c
@@ -239,14 +239,14 @@ static struct file_operations msr_fops =
 	.open = msr_open,
 };
 
-static int msr_class_device_create(int i)
+static int msr_device_create(int i)
 {
 	int err = 0;
-	struct class_device *class_err;
+	struct device *dev;
 
-	class_err = class_device_create(msr_class, NULL, MKDEV(MSR_MAJOR, i), NULL, "msr%d",i);
-	if (IS_ERR(class_err)) 
-		err = PTR_ERR(class_err);
+	dev = device_create(msr_class, NULL, MKDEV(MSR_MAJOR, i), "msr%d",i);
+	if (IS_ERR(dev))
+		err = PTR_ERR(dev);
 	return err;
 }
 
@@ -258,10 +258,10 @@ static int msr_class_cpu_callback(struct
 
 	switch (action) {
 	case CPU_ONLINE:
-		msr_class_device_create(cpu);
+		msr_device_create(cpu);
 		break;
 	case CPU_DEAD:
-		class_device_destroy(msr_class, MKDEV(MSR_MAJOR, cpu));
+		device_destroy(msr_class, MKDEV(MSR_MAJOR, cpu));
 		break;
 	}
 	return NOTIFY_OK;
@@ -290,7 +290,7 @@ static int __init msr_init(void)
 		goto out_chrdev;
 	}
 	for_each_online_cpu(i) {
-		err = msr_class_device_create(i);
+		err = msr_device_create(i);
 		if (err != 0)
 			goto out_class;
 	}
@@ -302,7 +302,7 @@ static int __init msr_init(void)
 out_class:
 	i = 0;
 	for_each_online_cpu(i)
-		class_device_destroy(msr_class, MKDEV(MSR_MAJOR, i));
+		device_destroy(msr_class, MKDEV(MSR_MAJOR, i));
 	class_destroy(msr_class);
 out_chrdev:
 	unregister_chrdev(MSR_MAJOR, "cpu/msr");
@@ -314,7 +314,7 @@ static void __exit msr_exit(void)
 {
 	int cpu = 0;
 	for_each_online_cpu(cpu)
-		class_device_destroy(msr_class, MKDEV(MSR_MAJOR, cpu));
+		device_destroy(msr_class, MKDEV(MSR_MAJOR, cpu));
 	class_destroy(msr_class);
 	unregister_chrdev(MSR_MAJOR, "cpu/msr");
 	unregister_hotcpu_notifier(&msr_class_cpu_notifier);
-- 
1.4.4.1

