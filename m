Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267856AbUGWRmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267856AbUGWRmO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 13:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267854AbUGWRmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 13:42:14 -0400
Received: from peabody.ximian.com ([130.57.169.10]:8338 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S267856AbUGWRlp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 13:41:45 -0400
Subject: [patch] kernel events layer
From: Robert Love <rml@ximian.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 23 Jul 2004 13:41:57 -0400
Message-Id: <1090604517.13415.0.camel@lucy>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, et al,

OK, Kernel Summit and my OLS talk are over, so here are the goods.

Following patch implements the kernel events layer, which is a simple
wrapper around netlink to allow asynchronous communication from the
kernel to user-space of events, errors, logging, and so on.

Current intention is to hook the kernel via this interface into D-BUS,
although the patch is intended to be agnostic to any of that and policy
free.

D-BUS can be found here:

	http://dbus.freedesktop.org/

Other user-space utilities (including code to utilize this) can be found
here:

	http://vrfy.org/projects/kdbusd/

This patch only implements a single event, processor temperature
detection.  Other useful events include md sync, filesystem mount,
driver errors, etc.  We can add those later, on a case-by-case basis.  I
would like to be more careful with adding events than we are with adding
printk's, with some aim toward a stable interface.

Usage of the new interface is simple:

	send_kmessage(group, interface, message, ...)

Credit to Arjan for the initial implementation, Kay Sievers for some
updates, and the netlink code.

	Robert Love


Kernel to user-space communication layer using netlink
X-Signed-Off-By: Robert Love <rml@ximian.com>

 arch/i386/kernel/cpu/mcheck/p4.c |    9 ++
 include/linux/kmessage.h         |   15 ++++
 include/linux/netlink.h          |    1 
 kernel/Makefile                  |    2 
 kernel/kmessage.c                |  134 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 159 insertions(+), 2 deletions(-)

diff -urN linux-2.6.8-rc2/arch/i386/kernel/cpu/mcheck/p4.c linux/arch/i386/kernel/cpu/mcheck/p4.c
--- linux-2.6.8-rc2/arch/i386/kernel/cpu/mcheck/p4.c	2004-06-16 01:19:37.000000000 -0400
+++ linux/arch/i386/kernel/cpu/mcheck/p4.c	2004-07-23 11:56:43.443944768 -0400
@@ -9,6 +9,7 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/smp.h>
+#include <linux/kmessage.h>
 
 #include <asm/processor.h> 
 #include <asm/system.h>
@@ -59,9 +60,15 @@
 	if (l & 0x1) {
 		printk(KERN_EMERG "CPU%d: Temperature above threshold\n", cpu);
 		printk(KERN_EMERG "CPU%d: Running in modulated clock mode\n",
-				cpu);
+			cpu);
+		send_kmessage(KMSG_POWER,
+			"/org/kernel/devices/system/cpu/temperature", "high",
+			"Cpu: %d\n", cpu);
 	} else {
 		printk(KERN_INFO "CPU%d: Temperature/speed normal\n", cpu);
+		send_kmessage(KMSG_POWER,
+			"/org/kernel/devices/system/cpu/temperature", "normal",
+			"Cpu: %d\n", cpu);
 	}
 }
 
diff -urN linux-2.6.8-rc2/include/linux/kmessage.h linux/include/linux/kmessage.h
--- linux-2.6.8-rc2/include/linux/kmessage.h	1969-12-31 19:00:00.000000000 -0500
+++ linux/include/linux/kmessage.h	2004-07-23 11:56:43.443944768 -0400
@@ -0,0 +1,15 @@
+#ifndef _LINUX_KMESSAGE_H
+#define _LINUX_KMESSAGE_H
+
+void send_kmessage(int type, const char *object, const char *signal,
+		   const char *fmt, ...);
+
+/* kmessage types */
+
+#define KMSG_GENERAL	0
+#define KMSG_STORAGE	1
+#define KMSG_POWER	2
+#define KMSG_FS		3
+#define KMSG_HOTPLUG	4
+
+#endif	/* _LINUX_KMESSAGE_H */
diff -urN linux-2.6.8-rc2/include/linux/netlink.h linux/include/linux/netlink.h
--- linux-2.6.8-rc2/include/linux/netlink.h	2004-07-20 15:40:14.000000000 -0400
+++ linux/include/linux/netlink.h	2004-07-23 11:56:43.490937624 -0400
@@ -17,6 +17,7 @@
 #define NETLINK_ROUTE6		11	/* af_inet6 route comm channel */
 #define NETLINK_IP6_FW		13
 #define NETLINK_DNRTMSG		14	/* DECnet routing messages */
+#define NETLINK_KMESSAGE	15	/* Kernel messages to userspace */
 #define NETLINK_TAPBASE		16	/* 16 to 31 are ethertap */
 
 #define MAX_LINKS 32		
diff -urN linux-2.6.8-rc2/kernel/kmessage.c linux/kernel/kmessage.c
--- linux-2.6.8-rc2/kernel/kmessage.c	1969-12-31 19:00:00.000000000 -0500
+++ linux/kernel/kmessage.c	2004-07-23 11:58:25.704398816 -0400
@@ -0,0 +1,134 @@
+/*
+ * Kernel event delivery over a netlink socket
+ * 
+ * Copyright (C) 2004 Red Hat, Inc. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *  
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ *  Authors:
+ *	Arjan van de Ven	<arjanv@redhat.com>
+ *	Kay Sievers		<kay.sievers@vrfy.org>
+ *	Robert Love		<rml@novell.com>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/socket.h>
+#include <linux/skbuff.h>
+#include <linux/netlink.h>
+#include <linux/string.h>
+#include <linux/kmessage.h>
+#include <net/sock.h>
+
+/* There is one global netlink socket */
+static struct sock *kmessage_sock = NULL;
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
+static int netlink_send(__u32 groups, const char *buffer, int len)
+{
+	struct sk_buff *skb;
+	char *data_start;
+
+	if (!kmessage_sock)
+		return -EIO;
+
+	if (!buffer)
+		return -EINVAL;
+
+	if (len > PAGE_SIZE)
+		return -EINVAL;
+
+	skb = alloc_skb(len, GFP_ATOMIC);
+	if (!skb)
+		return -ENOMEM;
+	data_start = skb_put(skb, len);
+	memcpy(data_start, buffer, len);
+
+	return netlink_broadcast(kmessage_sock, skb, 0, groups, GFP_ATOMIC);
+}
+
+void send_kmessage(int type, const char *object, const char *signal,
+		   const char *fmt, ...)
+{
+	char *buffer;
+	int len;
+	int ret;
+
+	if (!object)
+		return;
+
+	if (!signal)
+		return;
+
+	if (strlen(object) > PAGE_SIZE)
+		return;
+
+	buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+	if (!buffer)
+		return;
+
+	len = sprintf(buffer, "From: %s\n", object);
+	len += sprintf(&buffer[len], "Signal: %s\n", signal);
+
+	/* possible anxiliary data */
+	if (fmt) {
+		va_list args;
+
+		va_start(args, fmt);
+		len += vscnprintf(&buffer[len], PAGE_SIZE-len-1, fmt, args);
+		va_end(args);
+	}
+	buffer[len++] = '\0';
+
+	ret = netlink_send((1 << type), buffer, len);
+	free_page((unsigned long) buffer);
+}
+
+EXPORT_SYMBOL_GPL(send_kmessage);
+
+static int kmessage_init(void)
+{
+	kmessage_sock = netlink_kernel_create(NETLINK_KMESSAGE,
+					      netlink_receive);
+
+	if (!kmessage_sock) {
+		printk(KERN_ERR "kmessage: "
+		       "unable to create netlink socket; aborting\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void kmessage_exit(void)
+{
+	if (kmessage_sock)
+		sock_release(kmessage_sock->sk_socket);
+}
+
+MODULE_DESCRIPTION("Kernel message delivery to userspace");
+MODULE_AUTHOR("Arjan van de Ven <arjanv@redhat.com>");
+MODULE_LICENSE("GPL");
+
+module_init(kmessage_init);
+module_exit(kmessage_exit);
diff -urN linux-2.6.8-rc2/kernel/Makefile linux/kernel/Makefile
--- linux-2.6.8-rc2/kernel/Makefile	2004-07-20 15:40:14.000000000 -0400
+++ linux/kernel/Makefile	2004-07-23 11:56:43.490937624 -0400
@@ -3,7 +3,7 @@
 #
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o profile.o \
-	    exit.o itimer.o time.o softirq.o resource.o \
+	    exit.o itimer.o time.o softirq.o resource.o kmessage.o\
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \


