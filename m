Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWDXIej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWDXIej (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 04:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWDXIeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 04:34:23 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:37732 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751192AbWDXIeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 04:34:16 -0400
Message-Id: <20060424083342.448143000@localhost.localdomain>
References: <20060424083333.217677000@localhost.localdomain>
Date: Mon, 24 Apr 2006 16:33:36 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 3/4] dynamic configurable kref debugging 
Content-Disposition: inline; filename=kref-debug-dynamic-off.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes kref-debugging dynamically configurable
by sysctl kernel.kref_debug

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 Documentation/sysctl/kernel.txt |    8 ++++++++
 include/linux/sysctl.h          |    1 +
 kernel/sysctl.c                 |   14 ++++++++++++++
 lib/kref.c                      |    9 +++++++++
 4 files changed, 32 insertions(+)

Index: 2.6-git/lib/kref.c
===================================================================
--- 2.6-git.orig/lib/kref.c
+++ 2.6-git/lib/kref.c
@@ -24,13 +24,22 @@ void kref_init(struct kref *kref)
 }
 
 #ifdef CONFIG_DEBUG_KREF
+
+int kref_debug = 1;
+
 static void kref_get_debug_check(struct kref *kref)
 {
+	if (!kref_debug)
+		return;
+
 	BUG_ON(!atomic_read(&kref->refcount));
 }
 static void kref_put_debug_check(struct kref *kref,
 				void (*release)(struct kref *kref))
 {
+	if (!kref_debug)
+		return;
+
 	BUG_ON(atomic_read(&kref->refcount) < 1);
 	BUG_ON(release == NULL);
 	BUG_ON(release == (void (*)(struct kref *))kfree);
Index: 2.6-git/include/linux/sysctl.h
===================================================================
--- 2.6-git.orig/include/linux/sysctl.h
+++ 2.6-git/include/linux/sysctl.h
@@ -148,6 +148,7 @@ enum
 	KERN_SPIN_RETRY=70,	/* int: number of spinlock retries */
 	KERN_ACPI_VIDEO_FLAGS=71, /* int: flags for setting up video after ACPI sleep */
 	KERN_IA64_UNALIGNED=72, /* int: ia64 unaligned userland trap enable */
+	KERN_KREF_DEBUG=73,	/* int: kref debug on or off */
 };
 
 
Index: 2.6-git/kernel/sysctl.c
===================================================================
--- 2.6-git.orig/kernel/sysctl.c
+++ 2.6-git/kernel/sysctl.c
@@ -131,6 +131,10 @@ extern int acct_parm[];
 extern int no_unaligned_warning;
 #endif
 
+#ifdef CONFIG_DEBUG_KREF
+extern int kref_debug;
+#endif
+
 static int parse_table(int __user *, int, void __user *, size_t __user *, void __user *, size_t,
 		       ctl_table *, void **);
 static int proc_doutsstring(ctl_table *table, int write, struct file *filp,
@@ -683,6 +687,16 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+#ifdef CONFIG_DEBUG_KREF
+	{
+		.ctl_name	= KERN_KREF_DEBUG,
+		.procname	= "kref_debug",
+		.data		= &kref_debug,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+#endif
 	{ .ctl_name = 0 }
 };
 
Index: 2.6-git/Documentation/sysctl/kernel.txt
===================================================================
--- 2.6-git.orig/Documentation/sysctl/kernel.txt
+++ 2.6-git/Documentation/sysctl/kernel.txt
@@ -27,6 +27,7 @@ show up in /proc/sys/kernel:
 - hotplug
 - java-appletviewer           [ binfmt_java, obsolete ]
 - java-interpreter            [ binfmt_java, obsolete ]
+- kref_debug
 - l2cr                        [ PPC only ]
 - modprobe                    ==> Documentation/kmod.txt
 - msgmax
@@ -161,6 +162,13 @@ Default value is "/sbin/hotplug".
 
 ==============================================================
 
+kref_debug:
+
+This flag controls the kref debugging. If 0, kref debugging is
+disabled.  Enabled if nonzero.
+
+==============================================================
+
 l2cr: (PPC only)
 
 This flag controls the L2 cache of G3 processor boards. If

--
