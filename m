Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbVJIFii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbVJIFii (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 01:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbVJIFii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 01:38:38 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:61663 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932211AbVJIFih
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 01:38:37 -0400
Date: Sun, 9 Oct 2005 06:38:35 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Subject: [RFC] gfp flags annotations - part 5 (net/*)
Message-ID: <20051009053835.GJ7992@ftp.linux.org.uk>
References: <20050905164712.GI5155@ZenIV.linux.org.uk> <20050905212026.GL5155@ZenIV.linux.org.uk> <20050907183131.GF5155@ZenIV.linux.org.uk> <20050912191744.GN25261@ZenIV.linux.org.uk> <20050912192049.GO25261@ZenIV.linux.org.uk> <20050930120831.GI7992@ftp.linux.org.uk> <20051004203009.GQ7992@ftp.linux.org.uk> <20051005202904.GA27229@mipter.zuzino.mipt.ru> <20051006201534.GX7992@ftp.linux.org.uk> <Pine.LNX.4.64.0510081630030.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510081630030.31407@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	missing gfp_t in net/* and around
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN lib/include/linux/security.h net/include/linux/security.h
--- lib/include/linux/security.h	2005-10-08 21:04:47.000000000 -0400
+++ net/include/linux/security.h	2005-10-09 01:22:12.000000000 -0400
@@ -1210,7 +1210,7 @@
 	int (*socket_shutdown) (struct socket * sock, int how);
 	int (*socket_sock_rcv_skb) (struct sock * sk, struct sk_buff * skb);
 	int (*socket_getpeersec) (struct socket *sock, char __user *optval, int __user *optlen, unsigned len);
-	int (*sk_alloc_security) (struct sock *sk, int family, int priority);
+	int (*sk_alloc_security) (struct sock *sk, int family, gfp_t priority);
 	void (*sk_free_security) (struct sock *sk);
 #endif	/* CONFIG_SECURITY_NETWORK */
 };
diff -urN lib/include/net/sock.h net/include/net/sock.h
--- lib/include/net/sock.h	2005-10-08 21:04:47.000000000 -0400
+++ net/include/net/sock.h	2005-10-09 01:22:12.000000000 -0400
@@ -207,7 +207,7 @@
 	struct sk_buff_head	sk_write_queue;
 	int			sk_wmem_queued;
 	int			sk_forward_alloc;
-	unsigned int		sk_allocation;
+	gfp_t			sk_allocation;
 	int			sk_sndbuf;
 	int			sk_route_caps;
 	unsigned long 		sk_flags;
diff -urN lib/net/core/sock.c net/net/core/sock.c
--- lib/net/core/sock.c	2005-10-08 21:04:47.000000000 -0400
+++ net/net/core/sock.c	2005-10-09 01:22:12.000000000 -0400
@@ -940,7 +940,7 @@
 					    int noblock, int *errcode)
 {
 	struct sk_buff *skb;
-	unsigned int gfp_mask;
+	gfp_t gfp_mask;
 	long timeo;
 	int err;
 
diff -urN lib/net/dccp/output.c net/net/dccp/output.c
--- lib/net/dccp/output.c	2005-09-22 14:50:54.000000000 -0400
+++ net/net/dccp/output.c	2005-10-09 01:22:12.000000000 -0400
@@ -495,7 +495,7 @@
 {
 	struct dccp_sock *dp = dccp_sk(sk);
 	struct sk_buff *skb;
-	const unsigned int prio = active ? GFP_KERNEL : GFP_ATOMIC;
+	const gfp_t prio = active ? GFP_KERNEL : GFP_ATOMIC;
 
 	skb = alloc_skb(sk->sk_prot->max_header, prio);
 	if (skb == NULL)
diff -urN lib/net/netlink/af_netlink.c net/net/netlink/af_netlink.c
--- lib/net/netlink/af_netlink.c	2005-10-08 21:04:47.000000000 -0400
+++ net/net/netlink/af_netlink.c	2005-10-09 01:22:12.000000000 -0400
@@ -827,7 +827,7 @@
 	int failure;
 	int congested;
 	int delivered;
-	unsigned int allocation;
+	gfp_t allocation;
 	struct sk_buff *skb, *skb2;
 };
 
diff -urN lib/security/dummy.c net/security/dummy.c
--- lib/security/dummy.c	2005-09-22 14:50:54.000000000 -0400
+++ net/security/dummy.c	2005-10-09 01:22:12.000000000 -0400
@@ -768,7 +768,7 @@
 	return -ENOPROTOOPT;
 }
 
-static inline int dummy_sk_alloc_security (struct sock *sk, int family, int priority)
+static inline int dummy_sk_alloc_security (struct sock *sk, int family, gfp_t priority)
 {
 	return 0;
 }
diff -urN lib/security/selinux/hooks.c net/security/selinux/hooks.c
--- lib/security/selinux/hooks.c	2005-09-30 20:59:37.000000000 -0400
+++ net/security/selinux/hooks.c	2005-10-09 01:22:12.000000000 -0400
@@ -262,7 +262,7 @@
 }
 
 #ifdef CONFIG_SECURITY_NETWORK
-static int sk_alloc_security(struct sock *sk, int family, int priority)
+static int sk_alloc_security(struct sock *sk, int family, gfp_t priority)
 {
 	struct sk_security_struct *ssec;
 
@@ -3380,7 +3380,7 @@
 	return err;
 }
 
-static int selinux_sk_alloc_security(struct sock *sk, int family, int priority)
+static int selinux_sk_alloc_security(struct sock *sk, int family, gfp_t priority)
 {
 	return sk_alloc_security(sk, family, priority);
 }
