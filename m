Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263538AbTDCU7W 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 15:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263546AbTDCU7W 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 15:59:22 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:8460 "EHLO probity.mcc.ac.uk")
	by vger.kernel.org with ESMTP id S263538AbTDCU7K 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 15:59:10 -0500
Date: Thu, 3 Apr 2003 22:10:31 +0100
From: John Levon <levon@movementarian.org>
To: torvalds@transmeta.com, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: [PATCH] bk - fix oprofile for pm driver register
Message-ID: <20030403211031.GA45979@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *191Byo-000Ger-00*EApDA4UqJgI*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, so I screwed up - didn't notice the late_initcall() that was
introduced, which was obviously bogus. This one should build OK for the
module case. I've tested insmod/rmmod alongside a mounted sysfs, seems
to work.

I think the built-in case is OK: oprofile/ is after kernel/ in the link
order. I tested that too.

please apply,
john


diff -X dontdiff -Naur linux-cvs/arch/alpha/oprofile/common.c linux-me/arch/alpha/oprofile/common.c
--- linux-cvs/arch/alpha/oprofile/common.c	2003-02-19 05:13:09.000000000 +0000
+++ linux-me/arch/alpha/oprofile/common.c	2003-04-03 20:35:44.000000000 +0100
@@ -186,3 +186,9 @@
 
 	return 0;
 }
+
+
+void __exit
+oprofile_arch_exit(void)
+{
+}
diff -X dontdiff -Naur linux-cvs/arch/i386/Makefile linux-me/arch/i386/Makefile
--- linux-cvs/arch/i386/Makefile	2003-03-07 15:39:16.000000000 +0000
+++ linux-me/arch/i386/Makefile	2003-04-03 20:24:40.000000000 +0100
@@ -84,7 +84,7 @@
 					   arch/i386/$(mcore-y)/
 drivers-$(CONFIG_MATH_EMULATION)	+= arch/i386/math-emu/
 drivers-$(CONFIG_PCI)			+= arch/i386/pci/
-# FIXME: is drivers- right ?
+# must be linked after kernel/
 drivers-$(CONFIG_OPROFILE)		+= arch/i386/oprofile/
 
 CFLAGS += $(mflags-y)
diff -X dontdiff -Naur linux-cvs/arch/i386/oprofile/init.c linux-me/arch/i386/oprofile/init.c
--- linux-cvs/arch/i386/oprofile/init.c	2003-02-11 20:25:38.000000000 +0000
+++ linux-me/arch/i386/oprofile/init.c	2003-04-03 20:50:32.000000000 +0100
@@ -17,6 +17,7 @@
  */
  
 extern int nmi_init(struct oprofile_operations ** ops);
+extern void nmi_exit(void);
 extern void timer_init(struct oprofile_operations ** ops);
 
 int __init oprofile_arch_init(struct oprofile_operations ** ops)
@@ -27,3 +28,11 @@
 		timer_init(ops);
 	return 0;
 }
+
+
+void __exit oprofile_arch_exit(void)
+{
+#ifdef CONFIG_X86_LOCAL_APIC
+	nmi_exit();
+#endif
+}
diff -X dontdiff -Naur linux-cvs/arch/i386/oprofile/nmi_int.c linux-me/arch/i386/oprofile/nmi_int.c
--- linux-cvs/arch/i386/oprofile/nmi_int.c	2003-04-03 19:52:50.000000000 +0100
+++ linux-me/arch/i386/oprofile/nmi_int.c	2003-04-03 21:27:38.000000000 +0100
@@ -67,15 +67,22 @@
 };
 
 
-static int __init init_nmi_driverfs(void)
+static int __init init_driverfs(void)
 {
 	driver_register(&nmi_driver);
 	return device_register(&device_nmi);
 }
 
 
-late_initcall(init_nmi_driverfs);
+static void __exit exit_driverfs(void)
+{
+	device_unregister(&device_nmi);
+	driver_unregister(&nmi_driver);
+}
 
+#else
+#define init_driverfs() do { } while (0)
+#define exit_driverfs() do { } while (0)
 #endif /* CONFIG_PM */
 
 
@@ -297,6 +304,10 @@
 
 #endif /* !CONFIG_X86_64 */
  
+
+/* in order to get driverfs right */
+static int using_nmi;
+
 int __init nmi_init(struct oprofile_operations ** ops)
 {
 	__u8 vendor = current_cpu_data.x86_vendor;
@@ -339,7 +350,16 @@
 			return 0;
 	}
 
+	init_driverfs();
+	using_nmi = 1;
 	*ops = &nmi_ops;
 	printk(KERN_INFO "oprofile: using NMI interrupt.\n");
 	return 1;
 }
+
+
+void __exit nmi_exit(void)
+{
+	if (using_nmi)
+		exit_driverfs();
+}
diff -X dontdiff -Naur linux-cvs/arch/parisc/oprofile/init.c linux-me/arch/parisc/oprofile/init.c
--- linux-cvs/arch/parisc/oprofile/init.c	2003-02-11 20:25:38.000000000 +0000
+++ linux-me/arch/parisc/oprofile/init.c	2003-04-03 20:36:01.000000000 +0100
@@ -18,3 +18,8 @@
 	timer_init(ops);
 	return 0;
 }
+
+
+void __exit oprofile_arch_exit()
+{
+}
diff -X dontdiff -Naur linux-cvs/arch/ppc64/oprofile/init.c linux-me/arch/ppc64/oprofile/init.c
--- linux-cvs/arch/ppc64/oprofile/init.c	2003-02-11 20:25:38.000000000 +0000
+++ linux-me/arch/ppc64/oprofile/init.c	2003-04-03 20:36:18.000000000 +0100
@@ -18,3 +18,8 @@
 	timer_init(ops);
 	return 0;
 }
+
+
+void __exit oprofile_arch_exit(void)
+{
+}
diff -X dontdiff -Naur linux-cvs/arch/sparc64/oprofile/init.c linux-me/arch/sparc64/oprofile/init.c
--- linux-cvs/arch/sparc64/oprofile/init.c	2003-02-11 20:25:38.000000000 +0000
+++ linux-me/arch/sparc64/oprofile/init.c	2003-04-03 20:36:41.000000000 +0100
@@ -18,3 +18,8 @@
 	timer_init(ops);
 	return 0;
 }
+
+
+void __exit oprofile_arch_exit(void)
+{
+}
diff -X dontdiff -Naur linux-cvs/drivers/oprofile/oprof.c linux-me/drivers/oprofile/oprof.c
--- linux-cvs/drivers/oprofile/oprof.c	2003-02-11 20:25:38.000000000 +0000
+++ linux-me/drivers/oprofile/oprof.c	2003-04-03 21:24:09.000000000 +0100
@@ -148,6 +148,7 @@
 static void __exit oprofile_exit(void)
 {
 	oprofilefs_unregister();
+	oprofile_arch_exit();
 }
 
  
diff -X dontdiff -Naur linux-cvs/include/linux/oprofile.h linux-me/include/linux/oprofile.h
--- linux-cvs/include/linux/oprofile.h	2003-02-19 05:13:09.000000000 +0000
+++ linux-me/include/linux/oprofile.h	2003-04-03 20:35:15.000000000 +0100
@@ -46,6 +46,11 @@
 int oprofile_arch_init(struct oprofile_operations ** ops);
  
 /**
+ * One-time exit/cleanup for the arch.
+ */
+void oprofile_arch_exit(void);
+
+/**
  * Add a sample. This may be called from any context. Pass
  * smp_processor_id() as cpu.
  */
