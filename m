Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWEST1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWEST1x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 15:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWEST1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 15:27:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28125 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932468AbWEST1w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 15:27:52 -0400
To: fastboot@osdl.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [patch] Add a sysfs file to determine if a kexec kernel is loaded
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
From: Jeff Moyer <jmoyer@redhat.com>
Date: Fri, 19 May 2006 15:27:41 -0400
Message-ID: <x49odxthl1u.fsf@segfault.boston.redhat.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a repost of a patch I sent back in February.  Eric, you indicated
that you had no problem with this version.  I've verified that it still
applies to current kernels.

This patch creates two files in /sys/kernel, kexec_loaded and
kexec_crash_loaded.  Each file contains a simple boolean value indicating
whether the relevant kernel has been loaded into memory.  The motivation
for this is geared around support.

Comments are welcome, as always.

-Jeff

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

--- linux-2.6.16-rc1-mm1/kernel/kexec.c.orig	2006-02-03 18:13:35.000000000 -0500
+++ linux-2.6.16-rc1-mm1/kernel/kexec.c	2006-02-13 10:13:56.000000000 -0500
@@ -903,7 +903,7 @@ static int kimage_load_segment(struct ki
  * that to happen you need to do that yourself.
  */
 struct kimage *kexec_image = NULL;
-static struct kimage *kexec_crash_image = NULL;
+struct kimage *kexec_crash_image = NULL;
 /*
  * A home grown binary mutex.
  * Nothing can wait so this mutex is safe to use
--- linux-2.6.16-rc1-mm1/kernel/ksysfs.c.orig	2006-02-10 12:08:52.000000000 -0500
+++ linux-2.6.16-rc1-mm1/kernel/ksysfs.c	2006-02-13 10:15:48.000000000 -0500
@@ -14,6 +14,7 @@
 #include <linux/sysfs.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/kexec.h>
 
 u64 uevent_seqnum;
 char uevent_helper[UEVENT_HELPER_PATH_LEN] = "/sbin/hotplug";
@@ -51,6 +52,20 @@ static ssize_t uevent_helper_store(struc
 KERNEL_ATTR_RW(uevent_helper);
 #endif
 
+#ifdef CONFIG_KEXEC
+static ssize_t kexec_loaded_show(struct subsystem *subsys, char *page)
+{
+	return sprintf(page, "%d\n", !!kexec_image);
+}
+KERNEL_ATTR_RO(kexec_loaded);
+
+static ssize_t kexec_crash_loaded_show(struct subsystem *subsys, char *page)
+{
+	return sprintf(page, "%d\n", !!kexec_crash_image);
+}
+KERNEL_ATTR_RO(kexec_crash_loaded);
+#endif /* CONFIG_KEXEC */
+
 decl_subsys(kernel, NULL, NULL);
 EXPORT_SYMBOL_GPL(kernel_subsys);
 
@@ -59,6 +74,10 @@ static struct attribute * kernel_attrs[]
 	&uevent_seqnum_attr.attr,
 	&uevent_helper_attr.attr,
 #endif
+#ifdef CONFIG_KEXEC
+	&kexec_loaded_attr.attr,
+	&kexec_crash_loaded_attr.attr,
+#endif
 	NULL
 };
 
--- linux-2.6.16-rc1-mm1/include/linux/kexec.h.orig	2006-02-13 10:11:00.000000000 -0500
+++ linux-2.6.16-rc1-mm1/include/linux/kexec.h	2006-02-13 10:11:09.000000000 -0500
@@ -105,6 +105,7 @@ extern struct page *kimage_alloc_control
 extern void crash_kexec(struct pt_regs *);
 int kexec_should_crash(struct task_struct *);
 extern struct kimage *kexec_image;
+extern struct kimage *kexec_crash_image;
 
 #define KEXEC_ON_CRASH  0x00000001
 #define KEXEC_ARCH_MASK 0xffff0000
