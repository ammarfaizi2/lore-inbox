Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261639AbSJMVgY>; Sun, 13 Oct 2002 17:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261644AbSJMVgX>; Sun, 13 Oct 2002 17:36:23 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:24787 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261639AbSJMVgV>; Sun, 13 Oct 2002 17:36:21 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.42: accessfs 1/3: new networking hooks
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Date: Sun, 13 Oct 2002 23:42:01 +0200
Message-ID: <87k7km9fti.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds two hooks to IPv4 and IPv6. These hooks allow modules
to control, who may bind to low numbered ports (< 1024).

Regards, Olaf.

diff -urN a/include/net/sock.h b/include/net/sock.h
--- a/include/net/sock.h	Sat Oct 12 14:24:20 2002
+++ b/include/net/sock.h	Sat Oct 12 17:35:42 2002
@@ -830,4 +830,21 @@
 extern __u32 sysctl_wmem_max;
 extern __u32 sysctl_rmem_max;
 
+/* Networking hooks */
+#ifdef	CONFIG_NET_HOOKS
+struct net_hook_operations {
+	int	(*ip_prot_sock)(struct socket *sock,
+				struct sockaddr *uaddr, int addr_len);
+	int	(*ip6_prot_sock)(struct socket *sock,
+				 struct sockaddr *uaddr, int addr_len);
+};
+
+extern struct net_hook_operations	*net_ops;
+
+extern int default_ip_prot_sock(struct socket *sock, struct sockaddr *uaddr, int addr_len);
+extern int default_ip6_prot_sock(struct socket *sock, struct sockaddr *uaddr, int addr_len);
+extern void net_hooks_register(struct net_hook_operations *ops);
+extern void net_hooks_unregister(struct net_hook_operations *ops);
+#endif
+
 #endif	/* _SOCK_H */
diff -urN a/net/Config.help b/net/Config.help
--- a/net/Config.help	Sat Oct  5 18:44:47 2002
+++ b/net/Config.help	Sat Oct 12 17:35:42 2002
@@ -512,3 +512,10 @@
   performance will be written to /proc/net/profile. If you don't know
   what it is about, you don't need it: say N.
 
+CONFIG_NET_HOOKS
+  This option enables other kernel parts or modules to hook into the
+  networking area and provide fine grained control over the access to
+  IP ports.
+
+  If you're unsure, say N.
+
diff -urN a/net/Config.in b/net/Config.in
--- a/net/Config.in	Sat Oct  5 18:45:54 2002
+++ b/net/Config.in	Sat Oct 12 17:35:42 2002
@@ -29,6 +29,8 @@
    if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
       source net/sctp/Config.in
    fi
+
+   dep_bool '  Networking hooks (EXPERIMENTAL)' CONFIG_NET_HOOKS $CONFIG_EXPERIMENTAL
 fi
 if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
    bool 'Asynchronous Transfer Mode (ATM) (EXPERIMENTAL)' CONFIG_ATM
diff -urN a/net/Makefile b/net/Makefile
--- a/net/Makefile	Sat Oct  5 18:45:54 2002
+++ b/net/Makefile	Sat Oct 12 17:35:42 2002
@@ -5,7 +5,7 @@
 # Rewritten to use lists instead of if-statements.
 #
 
-export-objs :=	netsyms.o
+export-objs :=	netsyms.o hooks.o
 
 obj-y	:= socket.o core/
 
@@ -34,6 +34,7 @@
 obj-$(CONFIG_ECONET)		+= econet/
 obj-$(CONFIG_VLAN_8021Q)	+= 8021q/
 obj-$(CONFIG_IP_SCTP)		+= sctp/
+obj-$(CONFIG_NET_HOOKS)		+= hooks.o
 
 ifeq ($(CONFIG_NET),y)
 obj-$(CONFIG_MODULES)		+= netsyms.o
diff -urN a/net/hooks.c b/net/hooks.c
--- a/net/hooks.c	Thu Jan  1 01:00:00 1970
+++ b/net/hooks.c	Sat Oct 12 17:35:42 2002
@@ -0,0 +1,56 @@
+/* Copyright (c) 2002 Olaf Dietsche
+ *
+ * Networking hooks. Currently for IPv4 and IPv6 only.
+ */
+
+#include <linux/module.h>
+#include <linux/in.h>
+#include <linux/in6.h>
+#include <net/sock.h>
+
+int default_ip_prot_sock(struct socket *sock, struct sockaddr *uaddr, int addr_len)
+{
+	struct sockaddr_in *addr = (struct sockaddr_in *) uaddr;
+	unsigned short snum = ntohs(addr->sin_port);
+	if (snum && snum < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
+		return -EACCES;
+
+	return 0;
+}
+
+int default_ip6_prot_sock(struct socket *sock, struct sockaddr *uaddr, int addr_len)
+{
+#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
+	struct sockaddr_in6 *addr = (struct sockaddr_in6 *) uaddr;
+	unsigned short snum = ntohs(addr->sin6_port);
+	if (snum && snum < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
+		return -EACCES;
+
+	return 0;
+#else
+	return -EACCES;
+#endif
+}
+
+static struct net_hook_operations default_net_ops = {
+	.ip_prot_sock =	default_ip_prot_sock,
+	.ip6_prot_sock =	default_ip6_prot_sock,
+};
+
+struct net_hook_operations *net_ops = &default_net_ops;
+
+void net_hooks_register(struct net_hook_operations *ops)
+{
+	net_ops = ops;
+}
+
+void net_hooks_unregister(struct net_hook_operations *ops)
+{
+	net_ops = &default_net_ops;
+}
+
+EXPORT_SYMBOL(net_ops);
+EXPORT_SYMBOL(default_ip_prot_sock);
+EXPORT_SYMBOL(default_ip6_prot_sock);
+EXPORT_SYMBOL(net_hooks_register);
+EXPORT_SYMBOL(net_hooks_unregister);
diff -urN a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
--- a/net/ipv4/af_inet.c	Sat Oct 12 14:24:20 2002
+++ b/net/ipv4/af_inet.c	Sat Oct 12 17:35:42 2002
@@ -528,7 +528,11 @@
 
 	snum = ntohs(addr->sin_port);
 	err = -EACCES;
+#ifdef	CONFIG_NET_HOOKS
+	if (net_ops->ip_prot_sock(sock, uaddr, addr_len))
+#else
 	if (snum && snum < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
+#endif
 		goto out;
 
 	/*      We keep a pair of addresses. rcv_saddr is the one
diff -urN a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
--- a/net/ipv6/af_inet6.c	Fri Oct 11 22:37:25 2002
+++ b/net/ipv6/af_inet6.c	Sat Oct 12 17:35:42 2002
@@ -313,7 +313,11 @@
 	}
 
 	snum = ntohs(addr->sin6_port);
+#ifdef	CONFIG_NET_HOOKS
+	if (net_ops->ip6_prot_sock(sock, uaddr, addr_len))
+#else
 	if (snum && snum < PROT_SOCK && !capable(CAP_NET_BIND_SERVICE))
+#endif
 		return -EACCES;
 
 	lock_sock(sk);
