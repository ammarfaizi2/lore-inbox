Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751633AbWH3XWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbWH3XWV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 19:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbWH3XWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 19:22:21 -0400
Received: from tomts10.bellnexxia.net ([209.226.175.54]:54214 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751633AbWH3XWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 19:22:17 -0400
Date: Wed, 30 Aug 2006 19:16:49 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>
Cc: ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: [PATCH 6/16] LTTng : Linux Trace Toolkit Next Generation 0.5.95, kernel 2.6.17
Message-ID: <20060830231649.GG17079@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_Krystal-6818-1156979809-0001-2"
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:15:57 up 7 days, 20:24,  9 users,  load average: 0.45, 0.37, 0.25
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-6818-1156979809-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

6- LTTng facility loader
This patch adds kernel modules responsible for loading the facilities
currently available.
patch-2.6.17-lttng-0.5.95-facilities-loader.diff

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

--=_Krystal-6818-1156979809-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-2.6.17-lttng-0.5.95-facilities-loader.diff"

--- /dev/null
+++ b/ltt/Makefile
@@ -0,0 +1,27 @@
+#
+# Makefile for the LTT objects.
+#
+obj-$(CONFIG_LTT_FACILITY_CORE)		+= ltt-facility-loader-core.o
+obj-$(CONFIG_LTT_FACILITY_FS)		+= ltt-facility-loader-fs.o
+obj-$(CONFIG_LTT_FACILITY_FS_DATA)	+= ltt-facility-loader-fs_data.o
+obj-$(CONFIG_LTT_FACILITY_IPC)		+= ltt-facility-loader-ipc.o
+obj-$(CONFIG_LTT_FACILITY_KERNEL_ARCH)	+= \
+			ltt-facility-loader-kernel_arch_$(ARCH).o
+obj-$(CONFIG_LTT_FACILITY_KERNEL)	+= ltt-facility-loader-kernel.o
+obj-$(CONFIG_LTT_FACILITY_LOCKING)	+= ltt-facility-loader-locking.o
+obj-$(CONFIG_LTT_FACILITY_MEMORY)	+= ltt-facility-loader-memory.o
+obj-$(CONFIG_LTT_FACILITY_NETWORK)	+= ltt-facility-loader-network.o
+obj-$(CONFIG_LTT_FACILITY_PROCESS)	+= ltt-facility-loader-process.o
+obj-$(CONFIG_LTT_FACILITY_SOCKET)	+= ltt-facility-loader-socket.o
+obj-$(CONFIG_LTT_FACILITY_TIMER)	+= ltt-facility-loader-timer.o
+obj-$(CONFIG_LTT_FACILITY_STATEDUMP)	+= ltt-facility-loader-statedump.o
+obj-$(CONFIG_LTT_FACILITY_STACK)	+= \
+			ltt-facility-loader-stack.o
+obj-$(CONFIG_LTT_FACILITY_STATEDUMP)	+= \
+			ltt-facility-loader-network_ip_interface.o
+
+obj-$(CONFIG_LTT_TRACER)		+= ltt-core.o
+obj-$(CONFIG_LTT_RELAY)			+= ltt-relay.o
+obj-$(CONFIG_LTT_NETLINK_CONTROL)	+= ltt-control.o
+obj-$(CONFIG_LTT_STATEDUMP)		+= ltt-statedump.o
+
diff --git a/ltt/ltt-control.c b/ltt/ltt-control.c
new file mode 100644
index 0000000..76c3e7f
--- /dev/null
+++ b/ltt/ltt-facility-loader-core.c
@@ -0,0 +1,66 @@
+/*
+ * ltt-facility-loader-core.c
+ *
+ * (C) Copyright  2005 - 
+ *          Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ *
+ * Contains the LTT facility loader.
+ *
+ */
+
+
+#include <linux/ltt-facilities.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/config.h>
+#include "ltt-facility-loader-core.h"
+
+
+#ifdef CONFIG_LTT
+
+EXPORT_SYMBOL(LTT_FACILITY_SYMBOL);
+EXPORT_SYMBOL(LTT_FACILITY_CHECKSUM_SYMBOL);
+
+static const char ltt_facility_name[] = LTT_FACILITY_NAME;
+
+#define SYMBOL_STRING(sym) #sym
+
+static struct ltt_facility facility = {
+	.name = ltt_facility_name,
+	.num_events = LTT_FACILITY_NUM_EVENTS,
+	.checksum = LTT_FACILITY_CHECKSUM,
+	.symbol = SYMBOL_STRING(LTT_FACILITY_SYMBOL),
+};
+
+static int __init facility_init(void)
+{
+	printk(KERN_INFO "LTT : ltt-facility-core init in kernel\n");
+
+	LTT_FACILITY_SYMBOL = ltt_facility_kernel_register(&facility);
+	LTT_FACILITY_CHECKSUM_SYMBOL = LTT_FACILITY_SYMBOL;
+	
+	return LTT_FACILITY_SYMBOL;
+}
+
+#ifndef MODULE
+__initcall(facility_init);
+#else
+module_init(facility_init);
+static void __exit facility_exit(void)
+{
+	int err;
+
+	err = ltt_facility_unregister(LTT_FACILITY_SYMBOL);
+	if(err != 0)
+		printk(KERN_ERR "LTT : Error in unregistering facility.\n");
+
+}
+module_exit(facility_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mathieu Desnoyers");
+MODULE_DESCRIPTION("Linux Trace Toolkit Facility");
+
+#endif //MODULE
+
+#endif //CONFIG_LTT
diff --git a/ltt/ltt-facility-loader-core.h b/ltt/ltt-facility-loader-core.h
new file mode 100644
index 0000000..2ad06c6
--- /dev/null
+++ b/ltt/ltt-facility-loader-core.h
@@ -0,0 +1,20 @@
+#ifndef _LTT_FACILITY_LOADER_CORE_H_
+#define _LTT_FACILITY_LOADER_CORE_H_
+
+#ifdef CONFIG_LTT
+
+#include <linux/ltt-facilities.h>
+#include <linux/ltt/ltt-facility-id-core.h>
+
+ltt_facility_t	ltt_facility_core;
+ltt_facility_t	ltt_facility_core_1A8DE486;
+
+#define LTT_FACILITY_SYMBOL		ltt_facility_core
+#define LTT_FACILITY_CHECKSUM_SYMBOL	ltt_facility_core_1A8DE486
+#define LTT_FACILITY_CHECKSUM		0x1A8DE486
+#define LTT_FACILITY_NAME		"core"
+#define LTT_FACILITY_NUM_EVENTS	facility_core_num_events
+
+#endif //CONFIG_LTT
+
+#endif //_LTT_FACILITY_LOADER_CORE_H_
diff --git a/ltt/ltt-facility-loader-fs.c b/ltt/ltt-facility-loader-fs.c
new file mode 100644
index 0000000..c902610
--- /dev/null
+++ b/ltt/ltt-facility-loader-fs.c
@@ -0,0 +1,66 @@
+/*
+ * ltt-facility-loader-fs.c
+ *
+ * (C) Copyright  2005 - 
+ *          Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ *
+ * Contains the LTT facility loader.
+ *
+ */
+
+
+#include <linux/ltt-facilities.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/config.h>
+#include "ltt-facility-loader-fs.h"
+
+
+#ifdef CONFIG_LTT
+
+EXPORT_SYMBOL(LTT_FACILITY_SYMBOL);
+EXPORT_SYMBOL(LTT_FACILITY_CHECKSUM_SYMBOL);
+
+static const char ltt_facility_name[] = LTT_FACILITY_NAME;
+
+#define SYMBOL_STRING(sym) #sym
+
+static struct ltt_facility facility = {
+	.name = ltt_facility_name,
+	.num_events = LTT_FACILITY_NUM_EVENTS,
+	.checksum = LTT_FACILITY_CHECKSUM,
+	.symbol = SYMBOL_STRING(LTT_FACILITY_SYMBOL),
+};
+
+static int __init facility_init(void)
+{
+	printk(KERN_INFO "LTT : ltt-facility-fs init in kernel\n");
+
+	LTT_FACILITY_SYMBOL = ltt_facility_kernel_register(&facility);
+	LTT_FACILITY_CHECKSUM_SYMBOL = LTT_FACILITY_SYMBOL;
+	
+	return LTT_FACILITY_SYMBOL;
+}
+
+#ifndef MODULE
+__initcall(facility_init);
+#else
+module_init(facility_init);
+static void __exit facility_exit(void)
+{
+	int err;
+
+	err = ltt_facility_unregister(LTT_FACILITY_SYMBOL);
+	if(err != 0)
+		printk(KERN_ERR "LTT : Error in unregistering facility.\n");
+
+}
+module_exit(facility_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mathieu Desnoyers");
+MODULE_DESCRIPTION("Linux Trace Toolkit Facility");
+
+#endif //MODULE
+
+#endif //CONFIG_LTT
diff --git a/ltt/ltt-facility-loader-fs.h b/ltt/ltt-facility-loader-fs.h
new file mode 100644
index 0000000..dabf1d5
--- /dev/null
+++ b/ltt/ltt-facility-loader-fs.h
@@ -0,0 +1,20 @@
+#ifndef _LTT_FACILITY_LOADER_FS_H_
+#define _LTT_FACILITY_LOADER_FS_H_
+
+#ifdef CONFIG_LTT
+
+#include <linux/ltt-facilities.h>
+#include <linux/ltt/ltt-facility-id-fs.h>
+
+ltt_facility_t	ltt_facility_fs;
+ltt_facility_t	ltt_facility_fs_40A645EC;
+
+#define LTT_FACILITY_SYMBOL		ltt_facility_fs
+#define LTT_FACILITY_CHECKSUM_SYMBOL	ltt_facility_fs_40A645EC
+#define LTT_FACILITY_CHECKSUM		0x40A645EC
+#define LTT_FACILITY_NAME		"fs"
+#define LTT_FACILITY_NUM_EVENTS	facility_fs_num_events
+
+#endif //CONFIG_LTT
+
+#endif //_LTT_FACILITY_LOADER_FS_H_
diff --git a/ltt/ltt-facility-loader-fs_data.c b/ltt/ltt-facility-loader-fs_data.c
new file mode 100644
index 0000000..6b73612
--- /dev/null
+++ b/ltt/ltt-facility-loader-fs_data.c
@@ -0,0 +1,66 @@
+/*
+ * ltt-facility-loader-fs_data.c
+ *
+ * (C) Copyright  2005 - 
+ *          Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ *
+ * Contains the LTT facility loader.
+ *
+ */
+
+
+#include <linux/ltt-facilities.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/config.h>
+#include "ltt-facility-loader-fs_data.h"
+
+
+#ifdef CONFIG_LTT
+
+EXPORT_SYMBOL(LTT_FACILITY_SYMBOL);
+EXPORT_SYMBOL(LTT_FACILITY_CHECKSUM_SYMBOL);
+
+static const char ltt_facility_name[] = LTT_FACILITY_NAME;
+
+#define SYMBOL_STRING(sym) #sym
+
+static struct ltt_facility facility = {
+	.name = ltt_facility_name,
+	.num_events = LTT_FACILITY_NUM_EVENTS,
+	.checksum = LTT_FACILITY_CHECKSUM,
+	.symbol = SYMBOL_STRING(LTT_FACILITY_SYMBOL),
+};
+
+static int __init facility_init(void)
+{
+	printk(KERN_INFO "LTT : ltt-facility-fs_data init in kernel\n");
+
+	LTT_FACILITY_SYMBOL = ltt_facility_kernel_register(&facility);
+	LTT_FACILITY_CHECKSUM_SYMBOL = LTT_FACILITY_SYMBOL;
+	
+	return LTT_FACILITY_SYMBOL;
+}
+
+#ifndef MODULE
+__initcall(facility_init);
+#else
+module_init(facility_init);
+static void __exit facility_exit(void)
+{
+	int err;
+
+	err = ltt_facility_unregister(LTT_FACILITY_SYMBOL);
+	if(err != 0)
+		printk(KERN_ERR "LTT : Error in unregistering facility.\n");
+
+}
+module_exit(facility_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mathieu Desnoyers");
+MODULE_DESCRIPTION("Linux Trace Toolkit Facility");
+
+#endif //MODULE
+
+#endif //CONFIG_LTT
diff --git a/ltt/ltt-facility-loader-fs_data.h b/ltt/ltt-facility-loader-fs_data.h
new file mode 100644
index 0000000..c08d1ce
--- /dev/null
+++ b/ltt/ltt-facility-loader-fs_data.h
@@ -0,0 +1,20 @@
+#ifndef _LTT_FACILITY_LOADER_FS_DATA_H_
+#define _LTT_FACILITY_LOADER_FS_DATA_H_
+
+#ifdef CONFIG_LTT
+
+#include <linux/ltt-facilities.h>
+#include <linux/ltt/ltt-facility-id-fs_data.h>
+
+ltt_facility_t	ltt_facility_fs_data;
+ltt_facility_t	ltt_facility_fs_data_155CEE69;
+
+#define LTT_FACILITY_SYMBOL		ltt_facility_fs_data
+#define LTT_FACILITY_CHECKSUM_SYMBOL	ltt_facility_fs_data_155CEE69
+#define LTT_FACILITY_CHECKSUM		0x155CEE69
+#define LTT_FACILITY_NAME		"fs_data"
+#define LTT_FACILITY_NUM_EVENTS	facility_fs_data_num_events
+
+#endif //CONFIG_LTT
+
+#endif //_LTT_FACILITY_LOADER_FS_DATA_H_
diff --git a/ltt/ltt-facility-loader-ipc.c b/ltt/ltt-facility-loader-ipc.c
new file mode 100644
index 0000000..d3dbb39
--- /dev/null
+++ b/ltt/ltt-facility-loader-ipc.c
@@ -0,0 +1,66 @@
+/*
+ * ltt-facility-loader-ipc.c
+ *
+ * (C) Copyright  2005 - 
+ *          Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ *
+ * Contains the LTT facility loader.
+ *
+ */
+
+
+#include <linux/ltt-facilities.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/config.h>
+#include "ltt-facility-loader-ipc.h"
+
+
+#ifdef CONFIG_LTT
+
+EXPORT_SYMBOL(LTT_FACILITY_SYMBOL);
+EXPORT_SYMBOL(LTT_FACILITY_CHECKSUM_SYMBOL);
+
+static const char ltt_facility_name[] = LTT_FACILITY_NAME;
+
+#define SYMBOL_STRING(sym) #sym
+
+static struct ltt_facility facility = {
+	.name = ltt_facility_name,
+	.num_events = LTT_FACILITY_NUM_EVENTS,
+	.checksum = LTT_FACILITY_CHECKSUM,
+	.symbol = SYMBOL_STRING(LTT_FACILITY_SYMBOL),
+};
+
+static int __init facility_init(void)
+{
+	printk(KERN_INFO "LTT : ltt-facility-ipc init in kernel\n");
+
+	LTT_FACILITY_SYMBOL = ltt_facility_kernel_register(&facility);
+	LTT_FACILITY_CHECKSUM_SYMBOL = LTT_FACILITY_SYMBOL;
+	
+	return LTT_FACILITY_SYMBOL;
+}
+
+#ifndef MODULE
+__initcall(facility_init);
+#else
+module_init(facility_init);
+static void __exit facility_exit(void)
+{
+	int err;
+
+	err = ltt_facility_unregister(LTT_FACILITY_SYMBOL);
+	if(err != 0)
+		printk(KERN_ERR "LTT : Error in unregistering facility.\n");
+
+}
+module_exit(facility_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mathieu Desnoyers");
+MODULE_DESCRIPTION("Linux Trace Toolkit Facility");
+
+#endif //MODULE
+
+#endif //CONFIG_LTT
diff --git a/ltt/ltt-facility-loader-ipc.h b/ltt/ltt-facility-loader-ipc.h
new file mode 100644
index 0000000..cf9dee1
--- /dev/null
+++ b/ltt/ltt-facility-loader-ipc.h
@@ -0,0 +1,20 @@
+#ifndef _LTT_FACILITY_LOADER_IPC_H_
+#define _LTT_FACILITY_LOADER_IPC_H_
+
+#ifdef CONFIG_LTT
+
+#include <linux/ltt-facilities.h>
+#include <linux/ltt/ltt-facility-id-ipc.h>
+
+ltt_facility_t	ltt_facility_ipc;
+ltt_facility_t	ltt_facility_ipc_14120A9A;
+
+#define LTT_FACILITY_SYMBOL		ltt_facility_ipc
+#define LTT_FACILITY_CHECKSUM_SYMBOL	ltt_facility_ipc_14120A9A
+#define LTT_FACILITY_CHECKSUM		0x14120A9A
+#define LTT_FACILITY_NAME		"ipc"
+#define LTT_FACILITY_NUM_EVENTS	facility_ipc_num_events
+
+#endif //CONFIG_LTT
+
+#endif //_LTT_FACILITY_LOADER_IPC_H_
diff --git a/ltt/ltt-facility-loader-kernel.c b/ltt/ltt-facility-loader-kernel.c
new file mode 100644
index 0000000..1197627
--- /dev/null
+++ b/ltt/ltt-facility-loader-kernel.c
@@ -0,0 +1,66 @@
+/*
+ * ltt-facility-loader-kernel.c
+ *
+ * (C) Copyright  2005 - 
+ *          Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ *
+ * Contains the LTT facility loader.
+ *
+ */
+
+
+#include <linux/ltt-facilities.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/config.h>
+#include "ltt-facility-loader-kernel.h"
+
+
+#ifdef CONFIG_LTT
+
+EXPORT_SYMBOL(LTT_FACILITY_SYMBOL);
+EXPORT_SYMBOL(LTT_FACILITY_CHECKSUM_SYMBOL);
+
+static const char ltt_facility_name[] = LTT_FACILITY_NAME;
+
+#define SYMBOL_STRING(sym) #sym
+
+static struct ltt_facility facility = {
+	.name = ltt_facility_name,
+	.num_events = LTT_FACILITY_NUM_EVENTS,
+	.checksum = LTT_FACILITY_CHECKSUM,
+	.symbol = SYMBOL_STRING(LTT_FACILITY_SYMBOL),
+};
+
+static int __init facility_init(void)
+{
+	printk(KERN_INFO "LTT : ltt-facility-kernel init in kernel\n");
+
+	LTT_FACILITY_SYMBOL = ltt_facility_kernel_register(&facility);
+	LTT_FACILITY_CHECKSUM_SYMBOL = LTT_FACILITY_SYMBOL;
+	
+	return LTT_FACILITY_SYMBOL;
+}
+
+#ifndef MODULE
+__initcall(facility_init);
+#else
+module_init(facility_init);
+static void __exit facility_exit(void)
+{
+	int err;
+
+	err = ltt_facility_unregister(LTT_FACILITY_SYMBOL);
+	if(err != 0)
+		printk(KERN_ERR "LTT : Error in unregistering facility.\n");
+
+}
+module_exit(facility_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mathieu Desnoyers");
+MODULE_DESCRIPTION("Linux Trace Toolkit Facility");
+
+#endif //MODULE
+
+#endif //CONFIG_LTT
diff --git a/ltt/ltt-facility-loader-kernel.h b/ltt/ltt-facility-loader-kernel.h
new file mode 100644
index 0000000..07dd826
--- /dev/null
+++ b/ltt/ltt-facility-loader-kernel.h
@@ -0,0 +1,20 @@
+#ifndef _LTT_FACILITY_LOADER_KERNEL_H_
+#define _LTT_FACILITY_LOADER_KERNEL_H_
+
+#ifdef CONFIG_LTT
+
+#include <linux/ltt-facilities.h>
+#include <linux/ltt/ltt-facility-id-kernel.h>
+
+ltt_facility_t	ltt_facility_kernel;
+ltt_facility_t	ltt_facility_kernel_6D8B2404;
+
+#define LTT_FACILITY_SYMBOL		ltt_facility_kernel
+#define LTT_FACILITY_CHECKSUM_SYMBOL	ltt_facility_kernel_6D8B2404
+#define LTT_FACILITY_CHECKSUM		0x6D8B2404
+#define LTT_FACILITY_NAME		"kernel"
+#define LTT_FACILITY_NUM_EVENTS	facility_kernel_num_events
+
+#endif //CONFIG_LTT
+
+#endif //_LTT_FACILITY_LOADER_KERNEL_H_
diff --git a/ltt/ltt-facility-loader-kernel_arch_arm.c b/ltt/ltt-facility-loader-kernel_arch_arm.c
new file mode 100644
index 0000000..54391db
--- /dev/null
+++ b/ltt/ltt-facility-loader-locking.c
@@ -0,0 +1,66 @@
+/*
+ * ltt-facility-loader-locking.c
+ *
+ * (C) Copyright  2005 - 
+ *          Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ *
+ * Contains the LTT facility loader.
+ *
+ */
+
+
+#include <linux/ltt-facilities.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/config.h>
+#include "ltt-facility-loader-locking.h"
+
+
+#ifdef CONFIG_LTT
+
+EXPORT_SYMBOL(LTT_FACILITY_SYMBOL);
+EXPORT_SYMBOL(LTT_FACILITY_CHECKSUM_SYMBOL);
+
+static const char ltt_facility_name[] = LTT_FACILITY_NAME;
+
+#define SYMBOL_STRING(sym) #sym
+
+static struct ltt_facility facility = {
+	.name = ltt_facility_name,
+	.num_events = LTT_FACILITY_NUM_EVENTS,
+	.checksum = LTT_FACILITY_CHECKSUM,
+	.symbol = SYMBOL_STRING(LTT_FACILITY_SYMBOL),
+};
+
+static int __init facility_init(void)
+{
+	printk(KERN_INFO "LTT : ltt-facility-locking init in kernel\n");
+
+	LTT_FACILITY_SYMBOL = ltt_facility_kernel_register(&facility);
+	LTT_FACILITY_CHECKSUM_SYMBOL = LTT_FACILITY_SYMBOL;
+	
+	return LTT_FACILITY_SYMBOL;
+}
+
+#ifndef MODULE
+__initcall(facility_init);
+#else
+module_init(facility_init);
+static void __exit facility_exit(void)
+{
+	int err;
+
+	err = ltt_facility_unregister(LTT_FACILITY_SYMBOL);
+	if(err != 0)
+		printk(KERN_ERR "LTT : Error in unregistering facility.\n");
+
+}
+module_exit(facility_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mathieu Desnoyers");
+MODULE_DESCRIPTION("Linux Trace Toolkit Facility");
+
+#endif //MODULE
+
+#endif //CONFIG_LTT
diff --git a/ltt/ltt-facility-loader-locking.h b/ltt/ltt-facility-loader-locking.h
new file mode 100644
index 0000000..d1b6909
--- /dev/null
+++ b/ltt/ltt-facility-loader-locking.h
@@ -0,0 +1,20 @@
+#ifndef _LTT_FACILITY_LOADER_LOCKING_H_
+#define _LTT_FACILITY_LOADER_LOCKING_H_
+
+#ifdef CONFIG_LTT
+
+#include <linux/ltt-facilities.h>
+#include <linux/ltt/ltt-facility-id-locking.h>
+
+ltt_facility_t	ltt_facility_locking;
+ltt_facility_t	ltt_facility_locking_51595CB2;
+
+#define LTT_FACILITY_SYMBOL		ltt_facility_locking
+#define LTT_FACILITY_CHECKSUM_SYMBOL	ltt_facility_locking_51595CB2
+#define LTT_FACILITY_CHECKSUM		0x51595CB2
+#define LTT_FACILITY_NAME		"locking"
+#define LTT_FACILITY_NUM_EVENTS	facility_locking_num_events
+
+#endif //CONFIG_LTT
+
+#endif //_LTT_FACILITY_LOADER_LOCKING_H_
diff --git a/ltt/ltt-facility-loader-memory.c b/ltt/ltt-facility-loader-memory.c
new file mode 100644
index 0000000..444ca35
--- /dev/null
+++ b/ltt/ltt-facility-loader-memory.c
@@ -0,0 +1,66 @@
+/*
+ * ltt-facility-loader-memory.c
+ *
+ * (C) Copyright  2005 - 
+ *          Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ *
+ * Contains the LTT facility loader.
+ *
+ */
+
+
+#include <linux/ltt-facilities.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/config.h>
+#include "ltt-facility-loader-memory.h"
+
+
+#ifdef CONFIG_LTT
+
+EXPORT_SYMBOL(LTT_FACILITY_SYMBOL);
+EXPORT_SYMBOL(LTT_FACILITY_CHECKSUM_SYMBOL);
+
+static const char ltt_facility_name[] = LTT_FACILITY_NAME;
+
+#define SYMBOL_STRING(sym) #sym
+
+static struct ltt_facility facility = {
+	.name = ltt_facility_name,
+	.num_events = LTT_FACILITY_NUM_EVENTS,
+	.checksum = LTT_FACILITY_CHECKSUM,
+	.symbol = SYMBOL_STRING(LTT_FACILITY_SYMBOL),
+};
+
+static int __init facility_init(void)
+{
+	printk(KERN_INFO "LTT : ltt-facility-memory init in kernel\n");
+
+	LTT_FACILITY_SYMBOL = ltt_facility_kernel_register(&facility);
+	LTT_FACILITY_CHECKSUM_SYMBOL = LTT_FACILITY_SYMBOL;
+	
+	return LTT_FACILITY_SYMBOL;
+}
+
+#ifndef MODULE
+__initcall(facility_init);
+#else
+module_init(facility_init);
+static void __exit facility_exit(void)
+{
+	int err;
+
+	err = ltt_facility_unregister(LTT_FACILITY_SYMBOL);
+	if(err != 0)
+		printk(KERN_ERR "LTT : Error in unregistering facility.\n");
+
+}
+module_exit(facility_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mathieu Desnoyers");
+MODULE_DESCRIPTION("Linux Trace Toolkit Facility");
+
+#endif //MODULE
+
+#endif //CONFIG_LTT
diff --git a/ltt/ltt-facility-loader-memory.h b/ltt/ltt-facility-loader-memory.h
new file mode 100644
index 0000000..0928374
--- /dev/null
+++ b/ltt/ltt-facility-loader-memory.h
@@ -0,0 +1,20 @@
+#ifndef _LTT_FACILITY_LOADER_MEMORY_H_
+#define _LTT_FACILITY_LOADER_MEMORY_H_
+
+#ifdef CONFIG_LTT
+
+#include <linux/ltt-facilities.h>
+#include <linux/ltt/ltt-facility-id-memory.h>
+
+ltt_facility_t	ltt_facility_memory;
+ltt_facility_t	ltt_facility_memory_D63D41C7;
+
+#define LTT_FACILITY_SYMBOL		ltt_facility_memory
+#define LTT_FACILITY_CHECKSUM_SYMBOL	ltt_facility_memory_D63D41C7
+#define LTT_FACILITY_CHECKSUM		0xD63D41C7
+#define LTT_FACILITY_NAME		"memory"
+#define LTT_FACILITY_NUM_EVENTS	facility_memory_num_events
+
+#endif //CONFIG_LTT
+
+#endif //_LTT_FACILITY_LOADER_MEMORY_H_
diff --git a/ltt/ltt-facility-loader-network.c b/ltt/ltt-facility-loader-network.c
new file mode 100644
index 0000000..1b5ff75
--- /dev/null
+++ b/ltt/ltt-facility-loader-network.c
@@ -0,0 +1,66 @@
+/*
+ * ltt-facility-loader-network.c
+ *
+ * (C) Copyright  2005 - 
+ *          Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ *
+ * Contains the LTT facility loader.
+ *
+ */
+
+
+#include <linux/ltt-facilities.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/config.h>
+#include "ltt-facility-loader-network.h"
+
+
+#ifdef CONFIG_LTT
+
+EXPORT_SYMBOL(LTT_FACILITY_SYMBOL);
+EXPORT_SYMBOL(LTT_FACILITY_CHECKSUM_SYMBOL);
+
+static const char ltt_facility_name[] = LTT_FACILITY_NAME;
+
+#define SYMBOL_STRING(sym) #sym
+
+static struct ltt_facility facility = {
+	.name = ltt_facility_name,
+	.num_events = LTT_FACILITY_NUM_EVENTS,
+	.checksum = LTT_FACILITY_CHECKSUM,
+	.symbol = SYMBOL_STRING(LTT_FACILITY_SYMBOL),
+};
+
+static int __init facility_init(void)
+{
+	printk(KERN_INFO "LTT : ltt-facility-network init in kernel\n");
+
+	LTT_FACILITY_SYMBOL = ltt_facility_kernel_register(&facility);
+	LTT_FACILITY_CHECKSUM_SYMBOL = LTT_FACILITY_SYMBOL;
+	
+	return LTT_FACILITY_SYMBOL;
+}
+
+#ifndef MODULE
+__initcall(facility_init);
+#else
+module_init(facility_init);
+static void __exit facility_exit(void)
+{
+	int err;
+
+	err = ltt_facility_unregister(LTT_FACILITY_SYMBOL);
+	if(err != 0)
+		printk(KERN_ERR "LTT : Error in unregistering facility.\n");
+
+}
+module_exit(facility_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mathieu Desnoyers");
+MODULE_DESCRIPTION("Linux Trace Toolkit Facility");
+
+#endif //MODULE
+
+#endif //CONFIG_LTT
diff --git a/ltt/ltt-facility-loader-network.h b/ltt/ltt-facility-loader-network.h
new file mode 100644
index 0000000..2ae98b7
--- /dev/null
+++ b/ltt/ltt-facility-loader-network.h
@@ -0,0 +1,20 @@
+#ifndef _LTT_FACILITY_LOADER_NETWORK_H_
+#define _LTT_FACILITY_LOADER_NETWORK_H_
+
+#ifdef CONFIG_LTT
+
+#include <linux/ltt-facilities.h>
+#include <linux/ltt/ltt-facility-id-network.h>
+
+ltt_facility_t	ltt_facility_network;
+ltt_facility_t	ltt_facility_network_51F19296;
+
+#define LTT_FACILITY_SYMBOL		ltt_facility_network
+#define LTT_FACILITY_CHECKSUM_SYMBOL	ltt_facility_network_51F19296
+#define LTT_FACILITY_CHECKSUM		0x51F19296
+#define LTT_FACILITY_NAME		"network"
+#define LTT_FACILITY_NUM_EVENTS	facility_network_num_events
+
+#endif //CONFIG_LTT
+
+#endif //_LTT_FACILITY_LOADER_NETWORK_H_
diff --git a/ltt/ltt-facility-loader-network_ip_interface.c b/ltt/ltt-facility-loader-network_ip_interface.c
new file mode 100644
index 0000000..ca5ea65
--- /dev/null
+++ b/ltt/ltt-facility-loader-network_ip_interface.c
@@ -0,0 +1,66 @@
+/*
+ * ltt-facility-loader-network_ip_interface.c
+ *
+ * (C) Copyright  2005 - 
+ *          Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ *
+ * Contains the LTT facility loader.
+ *
+ */
+
+
+#include <linux/ltt-facilities.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/config.h>
+#include "ltt-facility-loader-network_ip_interface.h"
+
+
+#ifdef CONFIG_LTT
+
+EXPORT_SYMBOL(LTT_FACILITY_SYMBOL);
+EXPORT_SYMBOL(LTT_FACILITY_CHECKSUM_SYMBOL);
+
+static const char ltt_facility_name[] = LTT_FACILITY_NAME;
+
+#define SYMBOL_STRING(sym) #sym
+
+static struct ltt_facility facility = {
+	.name = ltt_facility_name,
+	.num_events = LTT_FACILITY_NUM_EVENTS,
+	.checksum = LTT_FACILITY_CHECKSUM,
+	.symbol = SYMBOL_STRING(LTT_FACILITY_SYMBOL),
+};
+
+static int __init facility_init(void)
+{
+	printk(KERN_INFO "LTT : ltt-facility-network_ip_interface init in kernel\n");
+
+	LTT_FACILITY_SYMBOL = ltt_facility_kernel_register(&facility);
+	LTT_FACILITY_CHECKSUM_SYMBOL = LTT_FACILITY_SYMBOL;
+	
+	return LTT_FACILITY_SYMBOL;
+}
+
+#ifndef MODULE
+__initcall(facility_init);
+#else
+module_init(facility_init);
+static void __exit facility_exit(void)
+{
+	int err;
+
+	err = ltt_facility_unregister(LTT_FACILITY_SYMBOL);
+	if(err != 0)
+		printk(KERN_ERR "LTT : Error in unregistering facility.\n");
+
+}
+module_exit(facility_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mathieu Desnoyers");
+MODULE_DESCRIPTION("Linux Trace Toolkit Facility");
+
+#endif //MODULE
+
+#endif //CONFIG_LTT
diff --git a/ltt/ltt-facility-loader-network_ip_interface.h b/ltt/ltt-facility-loader-network_ip_interface.h
new file mode 100644
index 0000000..3dd59c6
--- /dev/null
+++ b/ltt/ltt-facility-loader-network_ip_interface.h
@@ -0,0 +1,20 @@
+#ifndef _LTT_FACILITY_LOADER_NETWORK_IP_INTERFACE_H_
+#define _LTT_FACILITY_LOADER_NETWORK_IP_INTERFACE_H_
+
+#ifdef CONFIG_LTT
+
+#include <linux/ltt-facilities.h>
+#include <linux/ltt/ltt-facility-id-network_ip_interface.h>
+
+ltt_facility_t	ltt_facility_network_ip_interface;
+ltt_facility_t	ltt_facility_network_ip_interface_7A3120EF;
+
+#define LTT_FACILITY_SYMBOL		ltt_facility_network_ip_interface
+#define LTT_FACILITY_CHECKSUM_SYMBOL	ltt_facility_network_ip_interface_7A3120EF
+#define LTT_FACILITY_CHECKSUM		0x7A3120EF
+#define LTT_FACILITY_NAME		"network_ip_interface"
+#define LTT_FACILITY_NUM_EVENTS	facility_network_ip_interface_num_events
+
+#endif //CONFIG_LTT
+
+#endif //_LTT_FACILITY_LOADER_NETWORK_IP_INTERFACE_H_
diff --git a/ltt/ltt-facility-loader-process.c b/ltt/ltt-facility-loader-process.c
new file mode 100644
index 0000000..cc0c9c9
--- /dev/null
+++ b/ltt/ltt-facility-loader-process.c
@@ -0,0 +1,66 @@
+/*
+ * ltt-facility-loader-process.c
+ *
+ * (C) Copyright  2005 - 
+ *          Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ *
+ * Contains the LTT facility loader.
+ *
+ */
+
+
+#include <linux/ltt-facilities.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/config.h>
+#include "ltt-facility-loader-process.h"
+
+
+#ifdef CONFIG_LTT
+
+EXPORT_SYMBOL(LTT_FACILITY_SYMBOL);
+EXPORT_SYMBOL(LTT_FACILITY_CHECKSUM_SYMBOL);
+
+static const char ltt_facility_name[] = LTT_FACILITY_NAME;
+
+#define SYMBOL_STRING(sym) #sym
+
+static struct ltt_facility facility = {
+	.name = ltt_facility_name,
+	.num_events = LTT_FACILITY_NUM_EVENTS,
+	.checksum = LTT_FACILITY_CHECKSUM,
+	.symbol = SYMBOL_STRING(LTT_FACILITY_SYMBOL),
+};
+
+static int __init facility_init(void)
+{
+	printk(KERN_INFO "LTT : ltt-facility-process init in kernel\n");
+
+	LTT_FACILITY_SYMBOL = ltt_facility_kernel_register(&facility);
+	LTT_FACILITY_CHECKSUM_SYMBOL = LTT_FACILITY_SYMBOL;
+	
+	return LTT_FACILITY_SYMBOL;
+}
+
+#ifndef MODULE
+__initcall(facility_init);
+#else
+module_init(facility_init);
+static void __exit facility_exit(void)
+{
+	int err;
+
+	err = ltt_facility_unregister(LTT_FACILITY_SYMBOL);
+	if(err != 0)
+		printk(KERN_ERR "LTT : Error in unregistering facility.\n");
+
+}
+module_exit(facility_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mathieu Desnoyers");
+MODULE_DESCRIPTION("Linux Trace Toolkit Facility");
+
+#endif //MODULE
+
+#endif //CONFIG_LTT
diff --git a/ltt/ltt-facility-loader-process.h b/ltt/ltt-facility-loader-process.h
new file mode 100644
index 0000000..2ef98ba
--- /dev/null
+++ b/ltt/ltt-facility-loader-process.h
@@ -0,0 +1,20 @@
+#ifndef _LTT_FACILITY_LOADER_PROCESS_H_
+#define _LTT_FACILITY_LOADER_PROCESS_H_
+
+#ifdef CONFIG_LTT
+
+#include <linux/ltt-facilities.h>
+#include <linux/ltt/ltt-facility-id-process.h>
+
+ltt_facility_t	ltt_facility_process;
+ltt_facility_t	ltt_facility_process_2905B6EB;
+
+#define LTT_FACILITY_SYMBOL		ltt_facility_process
+#define LTT_FACILITY_CHECKSUM_SYMBOL	ltt_facility_process_2905B6EB
+#define LTT_FACILITY_CHECKSUM		0x2905B6EB
+#define LTT_FACILITY_NAME		"process"
+#define LTT_FACILITY_NUM_EVENTS	facility_process_num_events
+
+#endif //CONFIG_LTT
+
+#endif //_LTT_FACILITY_LOADER_PROCESS_H_
diff --git a/ltt/ltt-facility-loader-socket.c b/ltt/ltt-facility-loader-socket.c
new file mode 100644
index 0000000..0c69f61
--- /dev/null
+++ b/ltt/ltt-facility-loader-socket.c
@@ -0,0 +1,66 @@
+/*
+ * ltt-facility-loader-socket.c
+ *
+ * (C) Copyright  2005 - 
+ *          Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ *
+ * Contains the LTT facility loader.
+ *
+ */
+
+
+#include <linux/ltt-facilities.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/config.h>
+#include "ltt-facility-loader-socket.h"
+
+
+#ifdef CONFIG_LTT
+
+EXPORT_SYMBOL(LTT_FACILITY_SYMBOL);
+EXPORT_SYMBOL(LTT_FACILITY_CHECKSUM_SYMBOL);
+
+static const char ltt_facility_name[] = LTT_FACILITY_NAME;
+
+#define SYMBOL_STRING(sym) #sym
+
+static struct ltt_facility facility = {
+	.name = ltt_facility_name,
+	.num_events = LTT_FACILITY_NUM_EVENTS,
+	.checksum = LTT_FACILITY_CHECKSUM,
+	.symbol = SYMBOL_STRING(LTT_FACILITY_SYMBOL),
+};
+
+static int __init facility_init(void)
+{
+	printk(KERN_INFO "LTT : ltt-facility-socket init in kernel\n");
+
+	LTT_FACILITY_SYMBOL = ltt_facility_kernel_register(&facility);
+	LTT_FACILITY_CHECKSUM_SYMBOL = LTT_FACILITY_SYMBOL;
+	
+	return LTT_FACILITY_SYMBOL;
+}
+
+#ifndef MODULE
+__initcall(facility_init);
+#else
+module_init(facility_init);
+static void __exit facility_exit(void)
+{
+	int err;
+
+	err = ltt_facility_unregister(LTT_FACILITY_SYMBOL);
+	if(err != 0)
+		printk(KERN_ERR "LTT : Error in unregistering facility.\n");
+
+}
+module_exit(facility_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mathieu Desnoyers");
+MODULE_DESCRIPTION("Linux Trace Toolkit Facility");
+
+#endif //MODULE
+
+#endif //CONFIG_LTT
diff --git a/ltt/ltt-facility-loader-socket.h b/ltt/ltt-facility-loader-socket.h
new file mode 100644
index 0000000..508e456
--- /dev/null
+++ b/ltt/ltt-facility-loader-socket.h
@@ -0,0 +1,20 @@
+#ifndef _LTT_FACILITY_LOADER_SOCKET_H_
+#define _LTT_FACILITY_LOADER_SOCKET_H_
+
+#ifdef CONFIG_LTT
+
+#include <linux/ltt-facilities.h>
+#include <linux/ltt/ltt-facility-id-socket.h>
+
+ltt_facility_t	ltt_facility_socket;
+ltt_facility_t	ltt_facility_socket_5E76ED18;
+
+#define LTT_FACILITY_SYMBOL		ltt_facility_socket
+#define LTT_FACILITY_CHECKSUM_SYMBOL	ltt_facility_socket_5E76ED18
+#define LTT_FACILITY_CHECKSUM		0x5E76ED18
+#define LTT_FACILITY_NAME		"socket"
+#define LTT_FACILITY_NUM_EVENTS	facility_socket_num_events
+
+#endif //CONFIG_LTT
+
+#endif //_LTT_FACILITY_LOADER_SOCKET_H_
diff --git a/ltt/ltt-facility-loader-stack.c b/ltt/ltt-facility-loader-stack.c
new file mode 100644
index 0000000..0d32858
--- /dev/null
+++ b/ltt/ltt-facility-loader-stack.c
@@ -0,0 +1,66 @@
+/*
+ * ltt-facility-loader-stack.c
+ *
+ * (C) Copyright  2005 - 
+ *          Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ *
+ * Contains the LTT facility loader.
+ *
+ */
+
+
+#include <linux/ltt-facilities.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/config.h>
+#include "ltt-facility-loader-stack.h"
+
+
+#ifdef CONFIG_LTT
+
+EXPORT_SYMBOL(LTT_FACILITY_SYMBOL);
+EXPORT_SYMBOL(LTT_FACILITY_CHECKSUM_SYMBOL);
+
+static const char ltt_facility_name[] = LTT_FACILITY_NAME;
+
+#define SYMBOL_STRING(sym) #sym
+
+static struct ltt_facility facility = {
+	.name = ltt_facility_name,
+	.num_events = LTT_FACILITY_NUM_EVENTS,
+	.checksum = LTT_FACILITY_CHECKSUM,
+	.symbol = SYMBOL_STRING(LTT_FACILITY_SYMBOL),
+};
+
+static int __init facility_init(void)
+{
+	printk(KERN_INFO "LTT : ltt-facility-stack init in kernel\n");
+
+	LTT_FACILITY_SYMBOL = ltt_facility_kernel_register(&facility);
+	LTT_FACILITY_CHECKSUM_SYMBOL = LTT_FACILITY_SYMBOL;
+	
+	return LTT_FACILITY_SYMBOL;
+}
+
+#ifndef MODULE
+__initcall(facility_init);
+#else
+module_init(facility_init);
+static void __exit facility_exit(void)
+{
+	int err;
+
+	err = ltt_facility_unregister(LTT_FACILITY_SYMBOL);
+	if(err != 0)
+		printk(KERN_ERR "LTT : Error in unregistering facility.\n");
+
+}
+module_exit(facility_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mathieu Desnoyers");
+MODULE_DESCRIPTION("Linux Trace Toolkit Facility");
+
+#endif //MODULE
+
+#endif //CONFIG_LTT
diff --git a/ltt/ltt-facility-loader-stack.h b/ltt/ltt-facility-loader-stack.h
new file mode 100644
index 0000000..904ca32
--- /dev/null
+++ b/ltt/ltt-facility-loader-stack.h
@@ -0,0 +1,20 @@
+#ifndef _LTT_FACILITY_LOADER_STACK_H_
+#define _LTT_FACILITY_LOADER_STACK_H_
+
+#ifdef CONFIG_LTT
+
+#include <linux/ltt-facilities.h>
+#include <linux/ltt/ltt-facility-id-stack.h>
+
+ltt_facility_t	ltt_facility_stack;
+ltt_facility_t	ltt_facility_stack_C90868B5;
+
+#define LTT_FACILITY_SYMBOL		ltt_facility_stack
+#define LTT_FACILITY_CHECKSUM_SYMBOL	ltt_facility_stack_C90868B5
+#define LTT_FACILITY_CHECKSUM		0xC90868B5
+#define LTT_FACILITY_NAME		"stack"
+#define LTT_FACILITY_NUM_EVENTS	facility_stack_num_events
+
+#endif //CONFIG_LTT
+
+#endif //_LTT_FACILITY_LOADER_STACK_H_
diff --git a/ltt/ltt-facility-loader-statedump.c b/ltt/ltt-facility-loader-statedump.c
new file mode 100644
index 0000000..d08b195
--- /dev/null
+++ b/ltt/ltt-facility-loader-statedump.c
@@ -0,0 +1,66 @@
+/*
+ * ltt-facility-loader-statedump.c
+ *
+ * (C) Copyright  2005 - 
+ *          Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ *
+ * Contains the LTT facility loader.
+ *
+ */
+
+
+#include <linux/ltt-facilities.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/config.h>
+#include "ltt-facility-loader-statedump.h"
+
+
+#ifdef CONFIG_LTT
+
+EXPORT_SYMBOL(LTT_FACILITY_SYMBOL);
+EXPORT_SYMBOL(LTT_FACILITY_CHECKSUM_SYMBOL);
+
+static const char ltt_facility_name[] = LTT_FACILITY_NAME;
+
+#define SYMBOL_STRING(sym) #sym
+
+static struct ltt_facility facility = {
+	.name = ltt_facility_name,
+	.num_events = LTT_FACILITY_NUM_EVENTS,
+	.checksum = LTT_FACILITY_CHECKSUM,
+	.symbol = SYMBOL_STRING(LTT_FACILITY_SYMBOL),
+};
+
+static int __init facility_init(void)
+{
+	printk(KERN_INFO "LTT : ltt-facility-statedump init in kernel\n");
+
+	LTT_FACILITY_SYMBOL = ltt_facility_kernel_register(&facility);
+	LTT_FACILITY_CHECKSUM_SYMBOL = LTT_FACILITY_SYMBOL;
+	
+	return LTT_FACILITY_SYMBOL;
+}
+
+#ifndef MODULE
+__initcall(facility_init);
+#else
+module_init(facility_init);
+static void __exit facility_exit(void)
+{
+	int err;
+
+	err = ltt_facility_unregister(LTT_FACILITY_SYMBOL);
+	if(err != 0)
+		printk(KERN_ERR "LTT : Error in unregistering facility.\n");
+
+}
+module_exit(facility_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mathieu Desnoyers");
+MODULE_DESCRIPTION("Linux Trace Toolkit Facility");
+
+#endif //MODULE
+
+#endif //CONFIG_LTT
diff --git a/ltt/ltt-facility-loader-statedump.h b/ltt/ltt-facility-loader-statedump.h
new file mode 100644
index 0000000..128a3eb
--- /dev/null
+++ b/ltt/ltt-facility-loader-statedump.h
@@ -0,0 +1,20 @@
+#ifndef _LTT_FACILITY_LOADER_STATEDUMP_H_
+#define _LTT_FACILITY_LOADER_STATEDUMP_H_
+
+#ifdef CONFIG_LTT
+
+#include <linux/ltt-facilities.h>
+#include <linux/ltt/ltt-facility-id-statedump.h>
+
+ltt_facility_t	ltt_facility_statedump;
+ltt_facility_t	ltt_facility_statedump_5E184DBD;
+
+#define LTT_FACILITY_SYMBOL		ltt_facility_statedump
+#define LTT_FACILITY_CHECKSUM_SYMBOL	ltt_facility_statedump_5E184DBD
+#define LTT_FACILITY_CHECKSUM		0x5E184DBD
+#define LTT_FACILITY_NAME		"statedump"
+#define LTT_FACILITY_NUM_EVENTS	facility_statedump_num_events
+
+#endif //CONFIG_LTT
+
+#endif //_LTT_FACILITY_LOADER_STATEDUMP_H_
diff --git a/ltt/ltt-facility-loader-timer.c b/ltt/ltt-facility-loader-timer.c
new file mode 100644
index 0000000..5410123
--- /dev/null
+++ b/ltt/ltt-facility-loader-timer.c
@@ -0,0 +1,66 @@
+/*
+ * ltt-facility-loader-timer.c
+ *
+ * (C) Copyright  2005 - 
+ *          Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ *
+ * Contains the LTT facility loader.
+ *
+ */
+
+
+#include <linux/ltt-facilities.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/config.h>
+#include "ltt-facility-loader-timer.h"
+
+
+#ifdef CONFIG_LTT
+
+EXPORT_SYMBOL(LTT_FACILITY_SYMBOL);
+EXPORT_SYMBOL(LTT_FACILITY_CHECKSUM_SYMBOL);
+
+static const char ltt_facility_name[] = LTT_FACILITY_NAME;
+
+#define SYMBOL_STRING(sym) #sym
+
+static struct ltt_facility facility = {
+	.name = ltt_facility_name,
+	.num_events = LTT_FACILITY_NUM_EVENTS,
+	.checksum = LTT_FACILITY_CHECKSUM,
+	.symbol = SYMBOL_STRING(LTT_FACILITY_SYMBOL),
+};
+
+static int __init facility_init(void)
+{
+	printk(KERN_INFO "LTT : ltt-facility-timer init in kernel\n");
+
+	LTT_FACILITY_SYMBOL = ltt_facility_kernel_register(&facility);
+	LTT_FACILITY_CHECKSUM_SYMBOL = LTT_FACILITY_SYMBOL;
+	
+	return LTT_FACILITY_SYMBOL;
+}
+
+#ifndef MODULE
+__initcall(facility_init);
+#else
+module_init(facility_init);
+static void __exit facility_exit(void)
+{
+	int err;
+
+	err = ltt_facility_unregister(LTT_FACILITY_SYMBOL);
+	if(err != 0)
+		printk(KERN_ERR "LTT : Error in unregistering facility.\n");
+
+}
+module_exit(facility_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mathieu Desnoyers");
+MODULE_DESCRIPTION("Linux Trace Toolkit Facility");
+
+#endif //MODULE
+
+#endif //CONFIG_LTT
diff --git a/ltt/ltt-facility-loader-timer.h b/ltt/ltt-facility-loader-timer.h
new file mode 100644
index 0000000..ab46936
--- /dev/null
+++ b/ltt/ltt-facility-loader-timer.h
@@ -0,0 +1,20 @@
+#ifndef _LTT_FACILITY_LOADER_TIMER_H_
+#define _LTT_FACILITY_LOADER_TIMER_H_
+
+#ifdef CONFIG_LTT
+
+#include <linux/ltt-facilities.h>
+#include <linux/ltt/ltt-facility-id-timer.h>
+
+ltt_facility_t	ltt_facility_timer;
+ltt_facility_t	ltt_facility_timer_68AB77C3;
+
+#define LTT_FACILITY_SYMBOL		ltt_facility_timer
+#define LTT_FACILITY_CHECKSUM_SYMBOL	ltt_facility_timer_68AB77C3
+#define LTT_FACILITY_CHECKSUM		0x68AB77C3
+#define LTT_FACILITY_NAME		"timer"
+#define LTT_FACILITY_NUM_EVENTS	facility_timer_num_events
+
+#endif //CONFIG_LTT
+
+#endif //_LTT_FACILITY_LOADER_TIMER_H_
diff --git a/ltt/ltt-relay.c b/ltt/ltt-relay.c
new file mode 100644
index 0000000..5061839
--- /dev/null
+++ b/ltt/ltt-facility-loader-kernel_arch_i386.c
@@ -0,0 +1,66 @@
+/*
+ * ltt-facility-loader-kernel_arch_i386.c
+ *
+ * (C) Copyright  2005 - 
+ *          Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ *
+ * Contains the LTT facility loader.
+ *
+ */
+
+
+#include <linux/ltt-facilities.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/config.h>
+#include "ltt-facility-loader-kernel_arch_i386.h"
+
+
+#ifdef CONFIG_LTT
+
+EXPORT_SYMBOL(LTT_FACILITY_SYMBOL);
+EXPORT_SYMBOL(LTT_FACILITY_CHECKSUM_SYMBOL);
+
+static const char ltt_facility_name[] = LTT_FACILITY_NAME;
+
+#define SYMBOL_STRING(sym) #sym
+
+static struct ltt_facility facility = {
+	.name = ltt_facility_name,
+	.num_events = LTT_FACILITY_NUM_EVENTS,
+	.checksum = LTT_FACILITY_CHECKSUM,
+	.symbol = SYMBOL_STRING(LTT_FACILITY_SYMBOL),
+};
+
+static int __init facility_init(void)
+{
+	printk(KERN_INFO "LTT : ltt-facility-kernel_arch init in kernel\n");
+
+	LTT_FACILITY_SYMBOL = ltt_facility_kernel_register(&facility);
+	LTT_FACILITY_CHECKSUM_SYMBOL = LTT_FACILITY_SYMBOL;
+	
+	return LTT_FACILITY_SYMBOL;
+}
+
+#ifndef MODULE
+__initcall(facility_init);
+#else
+module_init(facility_init);
+static void __exit facility_exit(void)
+{
+	int err;
+
+	err = ltt_facility_unregister(LTT_FACILITY_SYMBOL);
+	if(err != 0)
+		printk(KERN_ERR "LTT : Error in unregistering facility.\n");
+
+}
+module_exit(facility_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mathieu Desnoyers");
+MODULE_DESCRIPTION("Linux Trace Toolkit Facility");
+
+#endif //MODULE
+
+#endif //CONFIG_LTT
diff --git a/ltt/ltt-facility-loader-kernel_arch_i386.h b/ltt/ltt-facility-loader-kernel_arch_i386.h
new file mode 100644
index 0000000..57cfa21
--- /dev/null
+++ b/ltt/ltt-facility-loader-kernel_arch_i386.h
@@ -0,0 +1,20 @@
+#ifndef _LTT_FACILITY_LOADER_KERNEL_ARCH_H_
+#define _LTT_FACILITY_LOADER_KERNEL_ARCH_H_
+
+#ifdef CONFIG_LTT
+
+#include <linux/ltt-facilities.h>
+#include <asm/ltt/ltt-facility-id-kernel_arch_i386.h>
+
+ltt_facility_t	ltt_facility_kernel_arch;
+ltt_facility_t	ltt_facility_kernel_arch_BDE45AD9;
+
+#define LTT_FACILITY_SYMBOL		ltt_facility_kernel_arch
+#define LTT_FACILITY_CHECKSUM_SYMBOL	ltt_facility_kernel_arch_BDE45AD9
+#define LTT_FACILITY_CHECKSUM		0xBDE45AD9
+#define LTT_FACILITY_NAME		"kernel_arch"
+#define LTT_FACILITY_NUM_EVENTS	facility_kernel_arch_num_events
+
+#endif //CONFIG_LTT
+
+#endif //_LTT_FACILITY_LOADER_KERNEL_ARCH_H_
diff --git a/ltt/ltt-facility-loader-kernel_arch_mips.c b/ltt/ltt-facility-loader-kernel_arch_mips.c
new file mode 100644
index 0000000..8f3eb06
--- /dev/null
+++ b/ltt/ltt-facility-loader-kernel_arch_arm.c
@@ -0,0 +1,66 @@
+/*
+ * ltt-facility-loader-kernel_arch_arm.c
+ *
+ * (C) Copyright  2005 - 
+ *          Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ *
+ * Contains the LTT facility loader.
+ *
+ */
+
+
+#include <linux/ltt-facilities.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/config.h>
+#include "ltt-facility-loader-kernel_arch_arm.h"
+
+
+#ifdef CONFIG_LTT
+
+EXPORT_SYMBOL(LTT_FACILITY_SYMBOL);
+EXPORT_SYMBOL(LTT_FACILITY_CHECKSUM_SYMBOL);
+
+static const char ltt_facility_name[] = LTT_FACILITY_NAME;
+
+#define SYMBOL_STRING(sym) #sym
+
+static struct ltt_facility facility = {
+	.name = ltt_facility_name,
+	.num_events = LTT_FACILITY_NUM_EVENTS,
+	.checksum = LTT_FACILITY_CHECKSUM,
+	.symbol = SYMBOL_STRING(LTT_FACILITY_SYMBOL),
+};
+
+static int __init facility_init(void)
+{
+	printk(KERN_INFO "LTT : ltt-facility-kernel_arch init in kernel\n");
+
+	LTT_FACILITY_SYMBOL = ltt_facility_kernel_register(&facility);
+	LTT_FACILITY_CHECKSUM_SYMBOL = LTT_FACILITY_SYMBOL;
+	
+	return LTT_FACILITY_SYMBOL;
+}
+
+#ifndef MODULE
+__initcall(facility_init);
+#else
+module_init(facility_init);
+static void __exit facility_exit(void)
+{
+	int err;
+
+	err = ltt_facility_unregister(LTT_FACILITY_SYMBOL);
+	if(err != 0)
+		printk(KERN_ERR "LTT : Error in unregistering facility.\n");
+
+}
+module_exit(facility_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mathieu Desnoyers");
+MODULE_DESCRIPTION("Linux Trace Toolkit Facility");
+
+#endif //MODULE
+
+#endif //CONFIG_LTT
diff --git a/ltt/ltt-facility-loader-kernel_arch_arm.h b/ltt/ltt-facility-loader-kernel_arch_arm.h
new file mode 100644
index 0000000..4943ad8
--- /dev/null
+++ b/ltt/ltt-facility-loader-kernel_arch_arm.h
@@ -0,0 +1,20 @@
+#ifndef _LTT_FACILITY_LOADER_KERNEL_ARCH_H_
+#define _LTT_FACILITY_LOADER_KERNEL_ARCH_H_
+
+#ifdef CONFIG_LTT
+
+#include <linux/ltt-facilities.h>
+#include <asm/ltt/ltt-facility-id-kernel_arch_arm.h>
+
+ltt_facility_t	ltt_facility_kernel_arch;
+ltt_facility_t	ltt_facility_kernel_arch_8E8193AC;
+
+#define LTT_FACILITY_SYMBOL		ltt_facility_kernel_arch
+#define LTT_FACILITY_CHECKSUM_SYMBOL	ltt_facility_kernel_arch_8E8193AC
+#define LTT_FACILITY_CHECKSUM		0x8E8193AC
+#define LTT_FACILITY_NAME		"kernel_arch"
+#define LTT_FACILITY_NUM_EVENTS	facility_kernel_arch_num_events
+
+#endif //CONFIG_LTT
+
+#endif //_LTT_FACILITY_LOADER_KERNEL_ARCH_H_
diff --git a/ltt/ltt-facility-loader-kernel_arch_i386.c b/ltt/ltt-facility-loader-kernel_arch_i386.c
new file mode 100644
index 0000000..29cfda9
--- /dev/null
+++ b/ltt/ltt-facility-loader-kernel_arch_mips.c
@@ -0,0 +1,66 @@
+/*
+ * ltt-facility-loader-kernel_arch_mips.c
+ *
+ * (C) Copyright  2005 - 
+ *          Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ *
+ * Contains the LTT facility loader.
+ *
+ */
+
+
+#include <linux/ltt-facilities.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/config.h>
+#include "ltt-facility-loader-kernel_arch_mips.h"
+
+
+#ifdef CONFIG_LTT
+
+EXPORT_SYMBOL(LTT_FACILITY_SYMBOL);
+EXPORT_SYMBOL(LTT_FACILITY_CHECKSUM_SYMBOL);
+
+static const char ltt_facility_name[] = LTT_FACILITY_NAME;
+
+#define SYMBOL_STRING(sym) #sym
+
+static struct ltt_facility facility = {
+	.name = ltt_facility_name,
+	.num_events = LTT_FACILITY_NUM_EVENTS,
+	.checksum = LTT_FACILITY_CHECKSUM,
+	.symbol = SYMBOL_STRING(LTT_FACILITY_SYMBOL),
+};
+
+static int __init facility_init(void)
+{
+	printk(KERN_INFO "LTT : ltt-facility-kernel_arch init in kernel\n");
+
+	LTT_FACILITY_SYMBOL = ltt_facility_kernel_register(&facility);
+	LTT_FACILITY_CHECKSUM_SYMBOL = LTT_FACILITY_SYMBOL;
+	
+	return LTT_FACILITY_SYMBOL;
+}
+
+#ifndef MODULE
+__initcall(facility_init);
+#else
+module_init(facility_init);
+static void __exit facility_exit(void)
+{
+	int err;
+
+	err = ltt_facility_unregister(LTT_FACILITY_SYMBOL);
+	if(err != 0)
+		printk(KERN_ERR "LTT : Error in unregistering facility.\n");
+
+}
+module_exit(facility_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mathieu Desnoyers");
+MODULE_DESCRIPTION("Linux Trace Toolkit Facility");
+
+#endif //MODULE
+
+#endif //CONFIG_LTT
diff --git a/ltt/ltt-facility-loader-kernel_arch_mips.h b/ltt/ltt-facility-loader-kernel_arch_mips.h
new file mode 100644
index 0000000..6ef9474
--- /dev/null
+++ b/ltt/ltt-facility-loader-kernel_arch_mips.h
@@ -0,0 +1,20 @@
+#ifndef _LTT_FACILITY_LOADER_KERNEL_ARCH_H_
+#define _LTT_FACILITY_LOADER_KERNEL_ARCH_H_
+
+#ifdef CONFIG_LTT
+
+#include <linux/ltt-facilities.h>
+#include <asm/ltt/ltt-facility-id-kernel_arch_mips.h>
+
+ltt_facility_t	ltt_facility_kernel_arch;
+ltt_facility_t	ltt_facility_kernel_arch_8597B65C;
+
+#define LTT_FACILITY_SYMBOL		ltt_facility_kernel_arch
+#define LTT_FACILITY_CHECKSUM_SYMBOL	ltt_facility_kernel_arch_8597B65C
+#define LTT_FACILITY_CHECKSUM		0x8597B65C
+#define LTT_FACILITY_NAME		"kernel_arch"
+#define LTT_FACILITY_NUM_EVENTS	facility_kernel_arch_num_events
+
+#endif //CONFIG_LTT
+
+#endif //_LTT_FACILITY_LOADER_KERNEL_ARCH_H_
diff --git a/ltt/ltt-facility-loader-kernel_arch_powerpc.c b/ltt/ltt-facility-loader-kernel_arch_powerpc.c
new file mode 100644
index 0000000..0f8e689
--- /dev/null
+++ b/ltt/ltt-facility-loader-kernel_arch_powerpc.c
@@ -0,0 +1,66 @@
+/*
+ * ltt-facility-loader-kernel_arch_powerpc.c
+ *
+ * (C) Copyright  2005 - 
+ *          Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ *
+ * Contains the LTT facility loader.
+ *
+ */
+
+
+#include <linux/ltt-facilities.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/config.h>
+#include "ltt-facility-loader-kernel_arch_powerpc.h"
+
+
+#ifdef CONFIG_LTT
+
+EXPORT_SYMBOL(LTT_FACILITY_SYMBOL);
+EXPORT_SYMBOL(LTT_FACILITY_CHECKSUM_SYMBOL);
+
+static const char ltt_facility_name[] = LTT_FACILITY_NAME;
+
+#define SYMBOL_STRING(sym) #sym
+
+static struct ltt_facility facility = {
+	.name = ltt_facility_name,
+	.num_events = LTT_FACILITY_NUM_EVENTS,
+	.checksum = LTT_FACILITY_CHECKSUM,
+	.symbol = SYMBOL_STRING(LTT_FACILITY_SYMBOL),
+};
+
+static int __init facility_init(void)
+{
+	printk(KERN_INFO "LTT : ltt-facility-kernel_arch init in kernel\n");
+
+	LTT_FACILITY_SYMBOL = ltt_facility_kernel_register(&facility);
+	LTT_FACILITY_CHECKSUM_SYMBOL = LTT_FACILITY_SYMBOL;
+	
+	return LTT_FACILITY_SYMBOL;
+}
+
+#ifndef MODULE
+__initcall(facility_init);
+#else
+module_init(facility_init);
+static void __exit facility_exit(void)
+{
+	int err;
+
+	err = ltt_facility_unregister(LTT_FACILITY_SYMBOL);
+	if(err != 0)
+		printk(KERN_ERR "LTT : Error in unregistering facility.\n");
+
+}
+module_exit(facility_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mathieu Desnoyers");
+MODULE_DESCRIPTION("Linux Trace Toolkit Facility");
+
+#endif //MODULE
+
+#endif //CONFIG_LTT
diff --git a/ltt/ltt-facility-loader-kernel_arch_powerpc.h b/ltt/ltt-facility-loader-kernel_arch_powerpc.h
new file mode 100644
index 0000000..f9bdd6e
--- /dev/null
+++ b/ltt/ltt-facility-loader-kernel_arch_powerpc.h
@@ -0,0 +1,20 @@
+#ifndef _LTT_FACILITY_LOADER_KERNEL_ARCH_H_
+#define _LTT_FACILITY_LOADER_KERNEL_ARCH_H_
+
+#ifdef CONFIG_LTT
+
+#include <linux/ltt-facilities.h>
+#include <asm/ltt/ltt-facility-id-kernel_arch_powerpc.h>
+
+ltt_facility_t	ltt_facility_kernel_arch;
+ltt_facility_t	ltt_facility_kernel_arch_E944278C;
+
+#define LTT_FACILITY_SYMBOL		ltt_facility_kernel_arch
+#define LTT_FACILITY_CHECKSUM_SYMBOL	ltt_facility_kernel_arch_E944278C
+#define LTT_FACILITY_CHECKSUM		0xE944278C
+#define LTT_FACILITY_NAME		"kernel_arch"
+#define LTT_FACILITY_NUM_EVENTS	facility_kernel_arch_num_events
+
+#endif //CONFIG_LTT
+
+#endif //_LTT_FACILITY_LOADER_KERNEL_ARCH_H_
diff --git a/ltt/ltt-facility-loader-kernel_arch_ppc.c b/ltt/ltt-facility-loader-kernel_arch_ppc.c
new file mode 100644
index 0000000..74017e1
--- /dev/null
+++ b/ltt/ltt-facility-loader-kernel_arch_ppc.c
@@ -0,0 +1,66 @@
+/*
+ * ltt-facility-loader-kernel_arch_ppc.c
+ *
+ * (C) Copyright  2005 - 
+ *          Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ *
+ * Contains the LTT facility loader.
+ *
+ */
+
+
+#include <linux/ltt-facilities.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/config.h>
+#include "ltt-facility-loader-kernel_arch_ppc.h"
+
+
+#ifdef CONFIG_LTT
+
+EXPORT_SYMBOL(LTT_FACILITY_SYMBOL);
+EXPORT_SYMBOL(LTT_FACILITY_CHECKSUM_SYMBOL);
+
+static const char ltt_facility_name[] = LTT_FACILITY_NAME;
+
+#define SYMBOL_STRING(sym) #sym
+
+static struct ltt_facility facility = {
+	.name = ltt_facility_name,
+	.num_events = LTT_FACILITY_NUM_EVENTS,
+	.checksum = LTT_FACILITY_CHECKSUM,
+	.symbol = SYMBOL_STRING(LTT_FACILITY_SYMBOL),
+};
+
+static int __init facility_init(void)
+{
+	printk(KERN_INFO "LTT : ltt-facility-kernel_arch init in kernel\n");
+
+	LTT_FACILITY_SYMBOL = ltt_facility_kernel_register(&facility);
+	LTT_FACILITY_CHECKSUM_SYMBOL = LTT_FACILITY_SYMBOL;
+	
+	return LTT_FACILITY_SYMBOL;
+}
+
+#ifndef MODULE
+__initcall(facility_init);
+#else
+module_init(facility_init);
+static void __exit facility_exit(void)
+{
+	int err;
+
+	err = ltt_facility_unregister(LTT_FACILITY_SYMBOL);
+	if(err != 0)
+		printk(KERN_ERR "LTT : Error in unregistering facility.\n");
+
+}
+module_exit(facility_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mathieu Desnoyers");
+MODULE_DESCRIPTION("Linux Trace Toolkit Facility");
+
+#endif //MODULE
+
+#endif //CONFIG_LTT
diff --git a/ltt/ltt-facility-loader-kernel_arch_ppc.h b/ltt/ltt-facility-loader-kernel_arch_ppc.h
new file mode 100644
index 0000000..40d84aa
--- /dev/null
+++ b/ltt/ltt-facility-loader-kernel_arch_ppc.h
@@ -0,0 +1,20 @@
+#ifndef _LTT_FACILITY_LOADER_KERNEL_ARCH_H_
+#define _LTT_FACILITY_LOADER_KERNEL_ARCH_H_
+
+#ifdef CONFIG_LTT
+
+#include <linux/ltt-facilities.h>
+#include <asm/ltt/ltt-facility-id-kernel_arch_ppc.h>
+
+ltt_facility_t	ltt_facility_kernel_arch;
+ltt_facility_t	ltt_facility_kernel_arch_E944278C;
+
+#define LTT_FACILITY_SYMBOL		ltt_facility_kernel_arch
+#define LTT_FACILITY_CHECKSUM_SYMBOL	ltt_facility_kernel_arch_E944278C
+#define LTT_FACILITY_CHECKSUM		0xE944278C
+#define LTT_FACILITY_NAME		"kernel_arch"
+#define LTT_FACILITY_NUM_EVENTS	facility_kernel_arch_num_events
+
+#endif //CONFIG_LTT
+
+#endif //_LTT_FACILITY_LOADER_KERNEL_ARCH_H_
diff --git a/ltt/ltt-facility-loader-kernel_arch_x86_64.c b/ltt/ltt-facility-loader-kernel_arch_x86_64.c
new file mode 100644
index 0000000..3adb236
--- /dev/null
+++ b/ltt/ltt-facility-loader-kernel_arch_x86_64.c
@@ -0,0 +1,66 @@
+/*
+ * ltt-facility-loader-kernel_arch_x86_64.c
+ *
+ * (C) Copyright  2005 - 
+ *          Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca)
+ *
+ * Contains the LTT facility loader.
+ *
+ */
+
+
+#include <linux/ltt-facilities.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/config.h>
+#include "ltt-facility-loader-kernel_arch_x86_64.h"
+
+
+#ifdef CONFIG_LTT
+
+EXPORT_SYMBOL(LTT_FACILITY_SYMBOL);
+EXPORT_SYMBOL(LTT_FACILITY_CHECKSUM_SYMBOL);
+
+static const char ltt_facility_name[] = LTT_FACILITY_NAME;
+
+#define SYMBOL_STRING(sym) #sym
+
+static struct ltt_facility facility = {
+	.name = ltt_facility_name,
+	.num_events = LTT_FACILITY_NUM_EVENTS,
+	.checksum = LTT_FACILITY_CHECKSUM,
+	.symbol = SYMBOL_STRING(LTT_FACILITY_SYMBOL),
+};
+
+static int __init facility_init(void)
+{
+	printk(KERN_INFO "LTT : ltt-facility-kernel_arch init in kernel\n");
+
+	LTT_FACILITY_SYMBOL = ltt_facility_kernel_register(&facility);
+	LTT_FACILITY_CHECKSUM_SYMBOL = LTT_FACILITY_SYMBOL;
+	
+	return LTT_FACILITY_SYMBOL;
+}
+
+#ifndef MODULE
+__initcall(facility_init);
+#else
+module_init(facility_init);
+static void __exit facility_exit(void)
+{
+	int err;
+
+	err = ltt_facility_unregister(LTT_FACILITY_SYMBOL);
+	if(err != 0)
+		printk(KERN_ERR "LTT : Error in unregistering facility.\n");
+
+}
+module_exit(facility_exit)
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mathieu Desnoyers");
+MODULE_DESCRIPTION("Linux Trace Toolkit Facility");
+
+#endif //MODULE
+
+#endif //CONFIG_LTT
diff --git a/ltt/ltt-facility-loader-kernel_arch_x86_64.h b/ltt/ltt-facility-loader-kernel_arch_x86_64.h
new file mode 100644
index 0000000..732e9f8
--- /dev/null
+++ b/ltt/ltt-facility-loader-kernel_arch_x86_64.h
@@ -0,0 +1,20 @@
+#ifndef _LTT_FACILITY_LOADER_KERNEL_ARCH_H_
+#define _LTT_FACILITY_LOADER_KERNEL_ARCH_H_
+
+#ifdef CONFIG_LTT
+
+#include <linux/ltt-facilities.h>
+#include <asm/ltt/ltt-facility-id-kernel_arch_x86_64.h>
+
+ltt_facility_t	ltt_facility_kernel_arch;
+ltt_facility_t	ltt_facility_kernel_arch_18A18187;
+
+#define LTT_FACILITY_SYMBOL		ltt_facility_kernel_arch
+#define LTT_FACILITY_CHECKSUM_SYMBOL	ltt_facility_kernel_arch_18A18187
+#define LTT_FACILITY_CHECKSUM		0x18A18187
+#define LTT_FACILITY_NAME		"kernel_arch"
+#define LTT_FACILITY_NUM_EVENTS	facility_kernel_arch_num_events
+
+#endif //CONFIG_LTT
+
+#endif //_LTT_FACILITY_LOADER_KERNEL_ARCH_H_
diff --git a/ltt/ltt-facility-loader-locking.c b/ltt/ltt-facility-loader-locking.c
new file mode 100644
index 0000000..963266f

--=_Krystal-6818-1156979809-0001-2--
