Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269173AbTGORbf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269211AbTGORbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:31:35 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:54689 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269173AbTGORbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 13:31:09 -0400
Message-ID: <3F143D0A.A052F0B6@us.ibm.com>
Date: Tue, 15 Jul 2003 10:42:34 -0700
From: Jim Keniston <jkenisto@us.ibm.com>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: James Morris <jmorris@intercode.com.au>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, akpm@osdl.org, jgarzik@pobox.com,
       alan@lxorguk.ukuu.org.uk, rddunlap@osdl.org, kuznet@ms2.inr.ac.ru,
       jkenisto@us.ibm.com
Subject: [PATCH] [1/2] kernel error reporting (revised)
References: <Mutt.LNX.4.44.0307131052420.2146-100000@excalibur.intercode.com.au>
Content-Type: multipart/mixed;
 boundary="------------0BE7F200693D6C2244226BA0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0BE7F200693D6C2244226BA0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Jim Keniston <jkenisto@us.ibm.com> wrote:

> Subject: [PATCH - RFC] [1/2] 2.6 must-fix list - kernel error reporting
>
> Andrew Morton's 2.6 must-fix list includes the following item:
> > o We need a kernel side API for reporting error events to userspace (could
> >   be async to 2.6 itself)
> >
> >   (Prototype core based on netlink exists)
>
> The enclosed patches provide a mechanism for reporting error events
> to user-mode applications via netlink.  This mechanism supplements
> the text-oriented printk mechanism, providing a way to log binary
> data or a mixture of text+binary.
> ...
>

Here are updated patches, reflecting the following changes:

Patch #1 (kerror.c et al):
- Given James Morris's patch to af_netlink.c (Rev 1.30 in BitKeeper), I 
was able to remove kerror_netlink_rcv().  (My patches work fine without
this, except that any packets sent to the NETLINK_KERROR socket by an
ill-behaved, root-owned application would accumulate in the kernel's
socket buffer.)

Patch #2 (evlog.c et al -- see accompanying post):
- Paraphrase dropped packets via printk() when nobody's listening to
netlink socket.
- Added support for 'z' qualifier, to resync with vsnprintf().
- In evlog.h, reordered members of struct kern_log_entry to address
alignment worries.

These patches work for both 2.5.74 and 2.5.75.

Jim Keniston
IBM Linux Technology Center

http://prdownloads.sourceforge.net/evlog/kerror-2.5.75.patch?download
http://prdownloads.sourceforge.net/evlog/evlog-2.5.75.patch?download
http://prdownloads.sourceforge.net/evlog/kerrord.tar.gz?download
--------------0BE7F200693D6C2244226BA0
Content-Type: text/plain; charset=us-ascii;
 name="kerror-2.5.75.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kerror-2.5.75.patch"

diff -Naur linux.org/include/linux/kerror.h linux.kerror.patched/include/linux/kerror.h
--- linux.org/include/linux/kerror.h	Wed Dec 31 16:00:00 1969
+++ linux.kerror.patched/include/linux/kerror.h	Mon Jul 14 09:53:00 2003
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
--- linux.org/include/linux/netlink.h	Mon Jul 14 09:53:00 2003
+++ linux.kerror.patched/include/linux/netlink.h	Mon Jul 14 09:53:00 2003
@@ -10,6 +10,7 @@
 #define NETLINK_TCPDIAG		4	/* TCP socket monitoring			*/
 #define NETLINK_NFLOG		5	/* netfilter/iptables ULOG */
 #define NETLINK_XFRM		6	/* ipsec */
+#define NETLINK_KERROR		7	/* kernel error event facility */
 #define NETLINK_ARPD		8
 #define NETLINK_ROUTE6		11	/* af_inet6 route comm channel */
 #define NETLINK_IP6_FW		13
diff -Naur linux.org/net/netlink/Makefile linux.kerror.patched/net/netlink/Makefile
--- linux.org/net/netlink/Makefile	Mon Jul 14 09:53:00 2003
+++ linux.kerror.patched/net/netlink/Makefile	Mon Jul 14 09:53:00 2003
@@ -2,5 +2,5 @@
 # Makefile for the netlink driver.
 #
 
-obj-y  				:= af_netlink.o
+obj-y  				:= af_netlink.o kerror.o
 obj-$(CONFIG_NETLINK_DEV)	+= netlink_dev.o
diff -Naur linux.org/net/netlink/kerror.c linux.kerror.patched/net/netlink/kerror.c
--- linux.org/net/netlink/kerror.c	Wed Dec 31 16:00:00 1969
+++ linux.kerror.patched/net/netlink/kerror.c	Mon Jul 14 09:53:00 2003
@@ -0,0 +1,97 @@
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
+	/* Note that we ignore all incoming messages on this socket. */
+	kerror_nl = netlink_kernel_create(NETLINK_KERROR, NULL);
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
--- linux.org/net/netsyms.c	Mon Jul 14 09:53:00 2003
+++ linux.kerror.patched/net/netsyms.c	Mon Jul 14 09:53:00 2003
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

--------------0BE7F200693D6C2244226BA0--

