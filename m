Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbUJXNsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbUJXNsM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 09:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbUJXNq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 09:46:58 -0400
Received: from verein.lst.de ([213.95.11.210]:59046 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261474AbUJXNoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 09:44:05 -0400
Date: Sun, 24 Oct 2004 15:43:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove dead socket layer exports
Message-ID: <20041024134359.GA20316@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- 1.25/include/linux/net.h	2004-09-15 21:58:39 +02:00
+++ edited/include/linux/net.h	2004-10-23 13:43:46 +02:00
@@ -176,7 +176,6 @@
 extern int	     sock_wake_async(struct socket *sk, int how, int band);
 extern int	     sock_register(struct net_proto_family *fam);
 extern int	     sock_unregister(int family);
-extern struct socket *sock_alloc(void);
 extern int	     sock_create(int family, int type, int proto,
 				 struct socket **res);
 extern int	     sock_create_kern(int family, int type, int proto,
===== include/net/sock.h 1.85 vs edited =====
--- 1.85/include/net/sock.h	2004-10-08 00:09:21 +02:00
+++ edited/include/net/sock.h	2004-10-23 13:46:58 +02:00
@@ -746,7 +746,6 @@
  * Functions to fill in entries in struct proto_ops when a protocol
  * does not implement a particular function.
  */
-extern int                      sock_no_release(struct socket *);
 extern int                      sock_no_bind(struct socket *, 
 					     struct sockaddr *, int);
 extern int                      sock_no_connect(struct socket *,
@@ -1275,7 +1274,6 @@
 
 extern atomic_t netstamp_needed;
 extern void sock_enable_timestamp(struct sock *sk);
-extern void sock_disable_timestamp(struct sock *sk);
 
 static inline void net_timestamp(struct timeval *stamp) 
 { 
===== net/socket.c 1.90 vs edited =====
--- 1.90/net/socket.c	2004-08-08 04:05:14 +02:00
+++ edited/net/socket.c	2004-10-23 13:44:07 +02:00
@@ -459,7 +459,7 @@
  *	NULL is returned.
  */
 
-struct socket *sock_alloc(void)
+static struct socket *sock_alloc(void)
 {
 	struct inode * inode;
 	struct socket * sock;
@@ -2089,8 +2089,6 @@
 /* ABI emulation layers need these two */
 EXPORT_SYMBOL(move_addr_to_kernel);
 EXPORT_SYMBOL(move_addr_to_user);
-EXPORT_SYMBOL(sock_alloc);
-EXPORT_SYMBOL(sock_alloc_inode);
 EXPORT_SYMBOL(sock_create);
 EXPORT_SYMBOL(sock_create_kern);
 EXPORT_SYMBOL(sock_create_lite);
===== net/core/sock.c 1.51 vs edited =====
--- 1.51/net/core/sock.c	2004-09-14 01:05:09 +02:00
+++ edited/net/core/sock.c	2004-10-23 13:47:45 +02:00
@@ -175,6 +175,15 @@
 	}
 }
 
+static void sock_disable_timestamp(struct sock *sk)
+{	
+	if (sock_flag(sk, SOCK_TIMESTAMP)) { 
+		sock_reset_flag(sk, SOCK_TIMESTAMP);
+		atomic_dec(&netstamp_needed);
+	}
+}
+
+
 /*
  *	This is meant for all protocols to use and covers goings on
  *	at the socket level. Everything here is generic.
@@ -972,11 +981,6 @@
  * function, some default processing is provided.
  */
 
-int sock_no_release(struct socket *sock)
-{
-	return 0;
-}
-
 int sock_no_bind(struct socket *sock, struct sockaddr *saddr, int len)
 {
 	return -EOPNOTSUPP;
@@ -1247,15 +1251,6 @@
 }
 EXPORT_SYMBOL(sock_enable_timestamp); 
 
-void sock_disable_timestamp(struct sock *sk)
-{	
-	if (sock_flag(sk, SOCK_TIMESTAMP)) { 
-		sock_reset_flag(sk, SOCK_TIMESTAMP);
-		atomic_dec(&netstamp_needed);
-	}
-}
-EXPORT_SYMBOL(sock_disable_timestamp);
-
 /*
  *	Get a socket option on an socket.
  *
@@ -1371,7 +1366,6 @@
 EXPORT_SYMBOL(sk_send_sigurg);
 EXPORT_SYMBOL(sock_alloc_send_pskb);
 EXPORT_SYMBOL(sock_alloc_send_skb);
-EXPORT_SYMBOL(sock_getsockopt);
 EXPORT_SYMBOL(sock_init_data);
 EXPORT_SYMBOL(sock_kfree_s);
 EXPORT_SYMBOL(sock_kmalloc);
@@ -1385,14 +1379,12 @@
 EXPORT_SYMBOL(sock_no_mmap);
 EXPORT_SYMBOL(sock_no_poll);
 EXPORT_SYMBOL(sock_no_recvmsg);
-EXPORT_SYMBOL(sock_no_release);
 EXPORT_SYMBOL(sock_no_sendmsg);
 EXPORT_SYMBOL(sock_no_sendpage);
 EXPORT_SYMBOL(sock_no_setsockopt);
 EXPORT_SYMBOL(sock_no_shutdown);
 EXPORT_SYMBOL(sock_no_socketpair);
 EXPORT_SYMBOL(sock_rfree);
-EXPORT_SYMBOL(sock_rmalloc);
 EXPORT_SYMBOL(sock_setsockopt);
 EXPORT_SYMBOL(sock_wfree);
 EXPORT_SYMBOL(sock_wmalloc);
