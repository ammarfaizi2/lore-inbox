Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268251AbUGXDLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268251AbUGXDLf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 23:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268252AbUGXDLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 23:11:35 -0400
Received: from peabody.ximian.com ([130.57.169.10]:3734 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268251AbUGXDLI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 23:11:08 -0400
Subject: [patch] kernel events layer, updated
From: Robert Love <rml@ximian.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
In-Reply-To: <20040723200335.521fe42a.akpm@osdl.org>
References: <1090604517.13415.0.camel@lucy>
	 <20040723200335.521fe42a.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 23 Jul 2004 23:11:19 -0400
Message-Id: <1090638679.2296.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.90 (1.5.90-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, Andrew, here we go again.  I met all the issues except the GPL-only
export.  Waiting to here from Arjan.  I am all for it.

To rehash, the following patch implements the kernel events layer, which
is a simple wrapper around netlink to allow asynchronous communication
from the kernel to user-space of events, errors, logging, and so on.  A
D-BUS daemon is to link the kernel events into the D-BUS.

Changes since the last post:

	- rename everything to kevent.  it is shorter and sweeter.
	- use GFP_KERNEL
	- add send_kevent_atomic, which uses GFP_ATOMIC
	- add CONFIG_KERNEL_EVENTS
	- depend on CONFIG_NET (which implies netlink:
	  CONFIG_NETLINK_DEV is for the old device node interface,
	  Andrew)
	- remove MODULE_* cruft
	- remove kmessage_exit() to pacify concerns of race
	- make send_kevent and send_kevent_atomic return error code
	- use snprintf, not sprintf, for building the buffer

Patch is against 2.6.8-rc2.  Tested both with and without
CONFIG_KERNEL_EVENTS.

Feel the love,

	Robert Love


Kernel to user-space communication layer using netlink
X-Signed-Off-By: Robert Love <rml@ximian.com>

 arch/i386/kernel/cpu/mcheck/p4.c |    9 ++
 include/linux/kevent.h           |   37 ++++++++++
 include/linux/netlink.h          |    1 
 init/Kconfig                     |   14 +++
 kernel/Makefile                  |    1 
 kernel/kevent.c                  |  141 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 202 insertions(+), 1 deletion(-)

diff -urN linux-2.6.8-rc2/arch/i386/kernel/cpu/mcheck/p4.c linux/arch/i386/kernel/cpu/mcheck/p4.c
--- linux-2.6.8-rc2/arch/i386/kernel/cpu/mcheck/p4.c	2004-06-16 01:19:37.000000000 -0400
+++ linux/arch/i386/kernel/cpu/mcheck/p4.c	2004-07-23 22:55:20.000000000 -0400
@@ -9,6 +9,7 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/smp.h>
+#include <linux/kevent.h>
 
 #include <asm/processor.h> 
 #include <asm/system.h>
@@ -59,9 +60,15 @@
 	if (l & 0x1) {
 		printk(KERN_EMERG "CPU%d: Temperature above threshold\n", cpu);
 		printk(KERN_EMERG "CPU%d: Running in modulated clock mode\n",
-				cpu);
+			cpu);
+		send_kevent(KMSG_POWER,
+			"/org/kernel/devices/system/cpu/temperature", "high",
+			"Cpu: %d\n", cpu);
 	} else {
 		printk(KERN_INFO "CPU%d: Temperature/speed normal\n", cpu);
+		send_kevent(KMSG_POWER,
+			"/org/kernel/devices/system/cpu/temperature", "normal",
+			"Cpu: %d\n", cpu);
 	}
 }
 
diff -urN linux-2.6.8-rc2/include/linux/kevent.h linux/include/linux/kevent.h
--- linux-2.6.8-rc2/include/linux/kevent.h	1969-12-31 19:00:00.000000000 -0500
+++ linux/include/linux/kevent.h	2004-07-23 22:53:45.000000000 -0400
@@ -0,0 +1,37 @@
+#ifndef _LINUX_KEVENT_H
+#define _LINUX_KEVENT_H
+
+#include <linux/config.h>
+
+/* kevent types - these are used as the multicast group */
+#define KMSG_GENERAL	0
+#define KMSG_STORAGE	1
+#define KMSG_POWER	2
+#define KMSG_FS		3
+#define KMSG_HOTPLUG	4
+
+#ifdef CONFIG_KERNEL_EVENTS
+
+int send_kevent(int type, const char *object, const char *signal,
+		const char *fmt, ...);
+
+int send_kevent_atomic(int type, const char *object, const char *signal,
+		const char *fmt, ...);
+
+#else
+
+static inline int send_kevent(int type, const char *object, const char *signal,
+		const char *fmt, ...)
+{
+	return 0;
+}
+
+static inline int send_kevent_atomic(int type, const char *object,
+		const char *signal, const char *fmt, ...)
+{
+	return 0;
+}
+
+#endif /* ! CONFIG_KERNEL_EVENTS */
+
+#endif	/* _LINUX_KEVENT_H */
diff -urN linux-2.6.8-rc2/include/linux/netlink.h linux/include/linux/netlink.h
--- linux-2.6.8-rc2/include/linux/netlink.h	2004-07-23 22:18:04.000000000 -0400
+++ linux/include/linux/netlink.h	2004-07-23 22:21:18.000000000 -0400
@@ -17,6 +17,7 @@
 #define NETLINK_ROUTE6		11	/* af_inet6 route comm channel */
 #define NETLINK_IP6_FW		13
 #define NETLINK_DNRTMSG		14	/* DECnet routing messages */
+#define NETLINK_KMESSAGE	15	/* Kernel messages to userspace */
 #define NETLINK_TAPBASE		16	/* 16 to 31 are ethertap */
 
 #define MAX_LINKS 32		
diff -urN linux-2.6.8-rc2/init/Kconfig linux/init/Kconfig
--- linux-2.6.8-rc2/init/Kconfig	2004-07-23 22:18:04.000000000 -0400
+++ linux/init/Kconfig	2004-07-23 22:44:26.000000000 -0400
@@ -160,6 +160,20 @@
 	  logging of avc messages output).  Does not do system-call
 	  auditing without CONFIG_AUDITSYSCALL.
 
+config KERNEL_EVENTS
+	bool "Kernel Events Layer"
+	depends on NET
+	default y
+	help
+	  This option enables the kernel events layer, which is a simple
+	  mechanism for kernel-to-user communication over a netlink socket.
+	  The goal of the kernel events layer is to provide a simple and
+	  efficient logging, error, and events system.  Specifically, code
+	  is available to link the events into D-BUS.  Say Y, unless you
+	  are building a system requiring minimal memory consumption.
+
+	  D-BUS is available at http://dbus.freedesktop.org/
+
 config AUDITSYSCALL
 	bool "Enable system-call auditing support"
 	depends on AUDIT && (X86 || PPC64 || ARCH_S390 || IA64)
diff -urN linux-2.6.8-rc2/kernel/kevent.c linux/kernel/kevent.c
--- linux-2.6.8-rc2/kernel/kevent.c	1969-12-31 19:00:00.000000000 -0500
+++ linux/kernel/kevent.c	2004-07-23 22:49:21.000000000 -0400
@@ -0,0 +1,141 @@
+/*
+ * kernel/kevent.c - kernel event delivery over a netlink socket
+ * 
+ * Copyright (C) 2004 Red Hat, Inc.  All rights reserved.
+ *
+ * Licensed under the GNU GPL v2.
+ *
+ * Authors:
+ *	Arjan van de Ven	<arjanv@redhat.com>
+ *	Kay Sievers		<kay.sievers@vrfy.org>
+ *	Robert Love		<rml@novell.com>
+ */
+
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/socket.h>
+#include <linux/skbuff.h>
+#include <linux/netlink.h>
+#include <linux/string.h>
+#include <linux/kevent.h>
+#include <net/sock.h>
+
+/* There is one global netlink socket */
+static struct sock *kevent_sock = NULL;
+
+static void netlink_receive(struct sock *sk, int len)
+{
+	struct sk_buff *skb;
+
+	 /* just drop them all */
+	while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL)
+		kfree_skb(skb);
+}
+
+static int netlink_send(__u32 groups, int gfp_mask, const char *buffer, int len)
+{
+	struct sk_buff *skb;
+	char *data_start;
+
+	if (!kevent_sock)
+		return -EIO;
+
+	if (!buffer)
+		return -EINVAL;
+
+	if (len > PAGE_SIZE)
+		return -EINVAL;
+
+	skb = alloc_skb(len, gfp_mask);
+	if (!skb)
+		return -ENOMEM;
+	data_start = skb_put(skb, len);
+	memcpy(data_start, buffer, len);
+
+	return netlink_broadcast(kevent_sock, skb, 0, groups, gfp_mask);
+}
+
+static int do_send_kevent(int type, int gfp_mask, const char *object,
+			  const char *signal, const char *fmt, va_list args)
+{
+	char *buffer;
+	int len;
+	int ret;
+
+	if (!object)
+		return -EINVAL;
+
+	if (!signal)
+		return -EINVAL;
+
+	if (strlen(object) > PAGE_SIZE)
+		return -EINVAL;
+
+	buffer = (char *) get_zeroed_page(gfp_mask);
+	if (!buffer)
+		return -ENOMEM;
+
+	len = snprintf(buffer, PAGE_SIZE, "From: %s\n", object);
+	len += snprintf(&buffer[len], PAGE_SIZE - len, "Signal: %s\n", signal);
+
+	/* possible anxiliary data */
+	if (fmt)
+		len += vscnprintf(&buffer[len], PAGE_SIZE-len-1, fmt, args);
+	buffer[len++] = '\0';
+
+	ret = netlink_send((1 << type), gfp_mask, buffer, len);
+	free_page((unsigned long) buffer);
+
+	return ret;
+}
+
+/**
+ * send_kevent - send a message to user-space via the kernel events layer
+ */
+int send_kevent(int type, const char *object, const char *signal,
+		const char *fmt, ...)
+{
+	va_list args;
+	int ret;
+
+	va_start(args, fmt);
+	ret = do_send_kevent(type, GFP_KERNEL, object, signal, fmt, args);
+	va_end(args);
+
+	return ret;
+}
+
+EXPORT_SYMBOL_GPL(send_kevent);
+
+/**
+ * send_kevent_atomic - send a message to user-space via the kernel events layer
+ */
+int send_kevent_atomic(int type, const char *object, const char *signal,
+		       const char *fmt, ...)
+{
+	va_list args;
+	int ret;
+
+	va_start(args, fmt);
+	ret = do_send_kevent(type, GFP_ATOMIC, object, signal, fmt, args);
+	va_end(args);
+
+	return ret;
+}
+
+EXPORT_SYMBOL_GPL(send_kevent_atomic);
+
+static int kevent_init(void)
+{
+	kevent_sock = netlink_kernel_create(NETLINK_KMESSAGE, netlink_receive);
+
+	if (!kevent_sock) {
+		printk(KERN_ERR "kevent: "
+		       "unable to create netlink socket; aborting\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+module_init(kevent_init);
diff -urN linux-2.6.8-rc2/kernel/Makefile linux/kernel/Makefile
--- linux-2.6.8-rc2/kernel/Makefile	2004-07-23 22:18:04.000000000 -0400
+++ linux/kernel/Makefile	2004-07-23 22:33:36.000000000 -0400
@@ -23,6 +23,7 @@
 obj-$(CONFIG_STOP_MACHINE) += stop_machine.o
 obj-$(CONFIG_AUDIT) += audit.o
 obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
+obj-$(CONFIG_KERNEL_EVENTS) += kevent.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is



