Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264957AbTGHRSi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 13:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbTGHRSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 13:18:38 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:42401 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264957AbTGHRSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 13:18:32 -0400
Message-ID: <3F0AFFE6.E85FF283@us.ibm.com>
Date: Tue, 08 Jul 2003 10:31:18 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: netdev <netdev@oss.sgi.net>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Randy Dunlap <rddunlap@osdl.org>
Subject: [PATCH - RFC] [1/2] 2.6 must-fix list - kernel error reporting
Content-Type: multipart/mixed;
 boundary="------------B1378E96213CD756664D1FA4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B1378E96213CD756664D1FA4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Andrew Morton's 2.6 must-fix list includes the following item:
> o We need a kernel side API for reporting error events to userspace (could
>   be async to 2.6 itself)
>
>   (Prototype core based on netlink exists)

The enclosed patches provide a mechanism for reporting error events
to user-mode applications via netlink.  This mechanism supplements
the text-oriented printk mechanism, providing a way to log binary
data or a mixture of text+binary.

Patch #1, closely based on a prototype by Dave Miller, implements the
NETLINK_KERROR protocol for AF_NETLINK sockets.  It provides two
functions for broadcasting data packets to user-mode applications:
in one, the caller provides a single data buffer, and in the other,
the caller provides an iovec[].

Patch #2 (see accompanying post) provides an API built on patch #1's
infrastructure.  Patch #2's functions capture context about the error
(e.g., driver/module, severity level, in interrupt or not, pid/uid/gid,
CPU ID), pack this information into a header, add the error-specific
data, and send the resulting packet via netlink.  The two principal
functions are:

- evl_write(), which accepts an arbitrarily defined buffer of
error-specific data; and

- evl_printf(), which accepts a format string plus args, printk-style.
Rather than combining the format and args, evl_printf() keeps them
separate, as various developers have suggested.  Thus the receiving
application can easily determine both the type of error (as indicated
by the raw format string) and the args' values, without parsing the
message string.

Applications that respond to kernel errors can establish
AF_NETLINK/NETLINK_KERROR sockets and receive the error packets
directly; or they can register with an event subsystem (e.g., see
evlog.sourceforge.net), which will deliver events that match specific
criteria.

These patches are posted on evlog.sourceforge.net.  (Click on "Latest
Release"; then scroll down to "evlog-2.5_kernel/evlog + netlink".  Or
just follow the links posted below.)  Also posted there is a tar file,
kerrord.tar.gz, which contains:
- a sample module that logs errors using evl_write() and evl_printf();
and
- a sample daemon that reads such errors from netlink and logs them.

Jim Keniston
IBM Linux Technology Center

http://prdownloads.sourceforge.net/evlog/kerror-2.5.74.patch?download
http://prdownloads.sourceforge.net/evlog/evlog-2.5.74.patch?download
http://prdownloads.sourceforge.net/evlog/kerrord.tar.gz?download
-----
--------------B1378E96213CD756664D1FA4
Content-Type: text/plain; charset=us-ascii;
 name="kerror-2.5.74.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kerror-2.5.74.patch"

diff -Naur linux.org/include/linux/kerror.h linux.kerror.patched/include/linux/kerror.h
--- linux.org/include/linux/kerror.h	Wed Dec 31 16:00:00 1969
+++ linux.kerror.patched/include/linux/kerror.h	Thu Jul  3 14:18:46 2003
@@ -0,0 +1,27 @@
+#ifndef _KERROR_H
+#define _KERROR_H
+
+#ifdef __KERNEL__
+#include <linux/config.h>
+#include <linux/uio.h>
+#include <asm/types.h>
+
+#ifdef CONFIG_NET
+extern int kernel_error_event(void *data, size_t len, __u32 groups);
+extern int kernel_error_event_iov(const struct iovec *iov,
+	unsigned int nseg, __u32 groups);
+#else
+static inline int kernel_error_event(void *data, size_t len, __u32 groups)
+	{ return -ENOSYS; }
+static inline int kernel_error_event_iov(const struct iovec *iov,
+	unsigned int nseg, __u32 groups)
+	{ return -ENOSYS; }
+#endif /* CONFIG_NET */
+#endif /* __KERNEL__ */
+
+#define KERROR_GROUP_RAW	0x00000001
+#define KERROR_GROUP_EVLOG	0x00000002
+
+#define KERROR_GROUP_ALL	(~(u32)0)
+
+#endif /* _KERROR_H */
diff -Naur linux.org/include/linux/netlink.h linux.kerror.patched/include/linux/netlink.h
--- linux.org/include/linux/netlink.h	Thu Jul  3 14:18:46 2003
+++ linux.kerror.patched/include/linux/netlink.h	Thu Jul  3 14:18:46 2003
@@ -10,6 +10,7 @@
 #define NETLINK_TCPDIAG		4	/* TCP socket monitoring			*/
 #define NETLINK_NFLOG		5	/* netfilter/iptables ULOG */
 #define NETLINK_XFRM		6	/* ipsec */
+#define NETLINK_KERROR		7	/* kernel error event facility */
 #define NETLINK_ARPD		8
 #define NETLINK_ROUTE6		11	/* af_inet6 route comm channel */
 #define NETLINK_IP6_FW		13
diff -Naur linux.org/net/netlink/Makefile linux.kerror.patched/net/netlink/Makefile
--- linux.org/net/netlink/Makefile	Thu Jul  3 14:18:46 2003
+++ linux.kerror.patched/net/netlink/Makefile	Thu Jul  3 14:18:46 2003
@@ -2,5 +2,5 @@
 # Makefile for the netlink driver.
 #
 
-obj-y  				:= af_netlink.o
+obj-y  				:= af_netlink.o kerror.o
 obj-$(CONFIG_NETLINK_DEV)	+= netlink_dev.o
diff -Naur linux.org/net/netlink/kerror.c linux.kerror.patched/net/netlink/kerror.c
--- linux.org/net/netlink/kerror.c	Wed Dec 31 16:00:00 1969
+++ linux.kerror.patched/net/netlink/kerror.c	Thu Jul  3 14:18:46 2003
@@ -0,0 +1,110 @@
+/* kerror.c: Kernel error event logging facility.
+ *
+ * Copyright (C) 2003 David S. Miller (davem@redhat.com)
+ * June 2003 - Jim Keniston and Dan Stekloff (kenistoj and dsteklof@us.ibm.com)
+ *	Fixed a couple of bugs and added iovec interface.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/skbuff.h>
+#include <linux/socket.h>
+#include <linux/netlink.h>
+#include <linux/kerror.h>
+#include <linux/init.h>
+#include <linux/uio.h>
+#include <net/sock.h>
+
+static struct sock *kerror_nl;
+
+static void kerror_netlink_rcv(struct sock *sk, int len)
+{
+	do {
+		struct sk_buff *skb;
+
+		while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL) {
+			/* Just ignore all the messages, they cannot be
+			 * destined for the kernel.
+			 */
+			kfree_skb(skb);
+		}
+	} while (kerror_nl && kerror_nl->sk_receive_queue.qlen);
+}
+
+/**
+ * kernel_error_event_iov() - Broadcast packet to NETLINK_KERROR sockets.
+ * @iov: the packet's data
+ * @nseg: number of segments in iov[]
+ * @groups: as with kernel_error_event()
+ */
+int kernel_error_event_iov(const struct iovec *iov, unsigned int nseg,
+	u32 groups)
+{
+	struct sk_buff *skb;
+	struct nlmsghdr *nlh;
+	unsigned char *b, *p;
+	size_t len;
+	unsigned int seg;
+
+	if (!groups)
+		return -EINVAL;
+
+	len = iov_length(iov, nseg);
+	skb = alloc_skb(NLMSG_SPACE(len), GFP_ATOMIC);
+	if (skb == NULL)
+		return -ENOMEM;
+
+	b = skb->tail;
+
+	nlh = NLMSG_PUT(skb, current->pid, 0, 0, len);
+	nlh->nlmsg_flags = 0;
+
+	p = NLMSG_DATA(nlh);
+	for (seg = 0; seg < nseg; seg++) {
+		memcpy(p, (const void*)iov[seg].iov_base, iov[seg].iov_len);
+		p += iov[seg].iov_len;
+	}
+	nlh->nlmsg_len = skb->tail - b;
+
+	NETLINK_CB(skb).dst_groups = groups;
+
+	return netlink_broadcast(kerror_nl, skb, 0, ~0, GFP_ATOMIC);
+
+nlmsg_failure:
+	kfree_skb(skb);
+	return -EINVAL;
+}
+
+/**
+ * kernel_error_event() - Broadcast packet to NETLINK_KERROR sockets.
+ * @data, @len: the packet's data
+ * @groups: the group(s) to which the packet pertains -- e.g.,
+ *	KERROR_GROUP_EVLOG.  On a recvmsg(), this shows up in
+ *	((struct sockaddr_nl*)(msg->msg_name))->nl_groups.
+ */
+int kernel_error_event(void *data, size_t len, u32 groups)
+{
+	struct iovec iov;
+	iov.iov_base = data;
+	iov.iov_len = len;
+	return kernel_error_event_iov(&iov, 1, groups);
+}
+
+static int __init kerror_init(void)
+{
+	printk(KERN_INFO "Initializing KERROR netlink socket\n");
+
+	kerror_nl = netlink_kernel_create(NETLINK_KERROR, kerror_netlink_rcv);
+	if (kerror_nl == NULL)
+		panic("kerror_init: cannot initialize kerror_nl\n");
+
+	return 0;
+}
+
+static void __exit kerror_exit(void)
+{
+	sock_release(kerror_nl->sk_socket);
+}
+
+module_init(kerror_init);
+module_exit(kerror_exit);
diff -Naur linux.org/net/netsyms.c linux.kerror.patched/net/netsyms.c
--- linux.org/net/netsyms.c	Thu Jul  3 14:18:46 2003
+++ linux.kerror.patched/net/netsyms.c	Thu Jul  3 14:18:46 2003
@@ -83,6 +83,7 @@
 #endif
 
 #include <linux/rtnetlink.h>
+#include <linux/kerror.h>
 
 #ifdef CONFIG_IPX_MODULE
 extern struct datalink_proto   *make_EII_client(void);
@@ -505,6 +506,8 @@
 EXPORT_SYMBOL(netlink_set_nonroot);
 EXPORT_SYMBOL(netlink_register_notifier);
 EXPORT_SYMBOL(netlink_unregister_notifier);
+EXPORT_SYMBOL(kernel_error_event);
+EXPORT_SYMBOL(kernel_error_event_iov);
 #if defined(CONFIG_NETLINK_DEV) || defined(CONFIG_NETLINK_DEV_MODULE)
 EXPORT_SYMBOL(netlink_attach);
 EXPORT_SYMBOL(netlink_detach);

--------------B1378E96213CD756664D1FA4--

