Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268303AbUGXGCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268303AbUGXGCw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 02:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268306AbUGXGCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 02:02:52 -0400
Received: from peabody.ximian.com ([130.57.169.10]:27030 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S268303AbUGXGCk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 02:02:40 -0400
Subject: Re: [patch] kernel events layer
From: Robert Love <rml@ximian.com>
To: Andrew Morton <akpm@osdl.org>
Cc: kaos@ocs.com.au, da-x@gmx.net, linux-kernel@vger.kernel.org
In-Reply-To: <1090647444.2296.54.camel@localhost>
References: <4956.1090644161@ocs3.ocs.com.au>
	 <1090645238.2296.37.camel@localhost>
	 <20040724011129.54971669.akpm@osdl.org>
	 <1090647444.2296.54.camel@localhost>
Content-Type: text/plain
Date: Sat, 24 Jul 2004 02:02:53 -0400
Message-Id: <1090648973.2296.68.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.90 (1.5.90-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-24 at 01:37 -0400, Robert Love wrote:

> Updated patch attached - also converts the 'type' value to an enum,
> which is safer and something a debugger in user-space can resolve.

Small fix with that.

This is the latest patch.

	Robert Love


Kernel to user-space communication layer using netlink
Signed-off-by: Robert Love <rml@ximian.com>

 arch/i386/kernel/cpu/mcheck/p4.c |    9 ++
 include/linux/kevent.h           |   39 ++++++++++
 include/linux/netlink.h          |    1 
 init/Kconfig                     |   14 +++
 kernel/Makefile                  |    1 
 kernel/kevent.c                  |  141 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 204 insertions(+), 1 deletion(-)

diff -urN linux-2.6.8-rc2/arch/i386/kernel/cpu/mcheck/p4.c linux/arch/i386/kernel/cpu/mcheck/p4.c
--- linux-2.6.8-rc2/arch/i386/kernel/cpu/mcheck/p4.c	2004-06-16 01:19:37.000000000 -0400
+++ linux/arch/i386/kernel/cpu/mcheck/p4.c	2004-07-24 01:25:07.301870200 -0400
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
+		send_kevent(KEVENT_GENERAL,
+			"/org/kernel/arch/kernel/cpu/temperature", "high",
+			"Cpu: %d\n", cpu);
 	} else {
 		printk(KERN_INFO "CPU%d: Temperature/speed normal\n", cpu);
+		send_kevent(KEVENT_GENERAL,
+			"/org/kernel/arch/kernel/cpu/temperature", "normal",
+			"Cpu: %d\n", cpu);
 	}
 }
 
diff -urN linux-2.6.8-rc2/include/linux/kevent.h linux/include/linux/kevent.h
--- linux-2.6.8-rc2/include/linux/kevent.h	1969-12-31 19:00:00.000000000 -0500
+++ linux/include/linux/kevent.h	2004-07-24 01:31:33.077223432 -0400
@@ -0,0 +1,39 @@
+#ifndef _LINUX_KEVENT_H
+#define _LINUX_KEVENT_H
+
+#include <linux/config.h>
+
+/* kevent types - these are used as the multicast group */
+enum kevent {
+	KEVENT_GENERAL	=	0,
+	KEVENT_STORAGE	=	1,
+	KEVENT_POWER	=	2,
+	KEVENT_FS	= 	3,
+	KEVENT_HOTPLUG	=	4,
+};
+
+#ifdef CONFIG_KERNEL_EVENTS
+
+int send_kevent(enum kevent type, const char *object,
+		const char *signal, const char *fmt, ...);
+
+int send_kevent_atomic(enum kevent type, const char *object,
+		const char *signal, const char *fmt, ...);
+
+#else
+
+static inline int send_kevent(enum kevent type,  const char *object,
+		const char *signal, const char *fmt, ...)
+{
+	return 0;
+}
+
+static inline int send_kevent_atomic(enum kevent type, const char *object,
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
+++ linux/include/linux/netlink.h	2004-07-24 01:25:07.302870048 -0400
@@ -17,6 +17,7 @@
 #define NETLINK_ROUTE6		11	/* af_inet6 route comm channel */
 #define NETLINK_IP6_FW		13
 #define NETLINK_DNRTMSG		14	/* DECnet routing messages */
+#define NETLINK_KEVENT		15	/* Kernel messages to userspace */
 #define NETLINK_TAPBASE		16	/* 16 to 31 are ethertap */
 
 #define MAX_LINKS 32		
diff -urN linux-2.6.8-rc2/init/Kconfig linux/init/Kconfig
--- linux-2.6.8-rc2/init/Kconfig	2004-07-23 22:18:04.000000000 -0400
+++ linux/init/Kconfig	2004-07-24 01:25:07.302870048 -0400
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
+++ linux/kernel/kevent.c	2004-07-24 01:31:38.561389712 -0400
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
+static int do_send_kevent(enum kevent type, int gfp_mask, const char *object,
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
+	buffer = (char *) alloc_page(gfp_mask);
+	if (!buffer)
+		return -ENOMEM;
+
+	snprintf(buffer, PAGE_SIZE, "From: %s\nSignal: %s\n", object, signal);
+	len = strlen(buffer);
+
+	/* possible auxiliary data */
+	if (fmt)
+		len += vscnprintf(buffer+len, PAGE_SIZE-len-1, fmt, args);
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
+int send_kevent(enum kevent type, const char *object,
+		const char *signal, const char *fmt, ...)
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
+int send_kevent_atomic(enum kevent type, const char *object,
+		const char *signal, const char *fmt, ...)
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
+	kevent_sock = netlink_kernel_create(NETLINK_KEVENT, netlink_receive);
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
+++ linux/kernel/Makefile	2004-07-24 01:25:07.303869896 -0400
@@ -23,6 +23,7 @@
 obj-$(CONFIG_STOP_MACHINE) += stop_machine.o
 obj-$(CONFIG_AUDIT) += audit.o
 obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
+obj-$(CONFIG_KERNEL_EVENTS) += kevent.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is


