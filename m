Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264958AbTL1Hnb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 02:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265235AbTL1Hnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 02:43:31 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:24068 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S264958AbTL1Hn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 02:43:28 -0500
Date: Sun, 28 Dec 2003 05:54:27 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Matt Mackall <mpm@selenic.com>
Cc: Linux Networking Development Mailing List <netdev@oss.sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH-2.6.0-tiny] "uninline" {lock,release}_sock
Message-ID: <20031228075426.GB24351@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Matt Mackall <mpm@selenic.com>,
	Linux Networking Development Mailing List <netdev@oss.sgi.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

	Please apply on top of your 2.6.0-tiny1 tree, CC to netdev for
eventual comments.

	With this patch we save more 3.321 bytes. At a first compilation
on top of plain 2.6.0 I thought I had seen it save more, will perhaps check
this later... if you optimized some of the kernel primitives that are called
by the current lock_sock/release_sock... Nah, too sleepy now :)

	Will test too with lock_sock/release_sock as an inline (or not if
CONFIG_NET_SMALL is selected) and not as a macro as it is today, does anybody
knows why it isn't already inline? Dave? /me must be missing something here...

   text    data     bss     dec     hex filename  patch        savings
 858052  163460   65068 1086580  109474 vmlinux   2.6.0-tiny1
 854697  163494   65068 1083259  10877b vmlinux   lock_sock       3321

Best Regards,

- Arnaldo

diff -urp linux-2.6.0.tiny.orig/include/net/sock.h linux-2.6.0.tiny.acme/include/net/sock.h
--- linux-2.6.0.tiny.orig/include/net/sock.h	2003-12-18 00:59:15.000000000 -0200
+++ linux-2.6.0.tiny.acme/include/net/sock.h	2003-12-28 01:32:50.000000000 -0200
@@ -542,7 +542,7 @@ static inline struct inode *SOCK_INODE(s
 extern void __lock_sock(struct sock *sk);
 extern void __release_sock(struct sock *sk);
 #define sock_owned_by_user(sk)	((sk)->sk_lock.owner)
-#define lock_sock(__sk) \
+#define _lock_sock(__sk) \
 do {	might_sleep(); \
 	spin_lock_bh(&((__sk)->sk_lock.slock)); \
 	if ((__sk)->sk_lock.owner) \
@@ -551,7 +551,7 @@ do {	might_sleep(); \
 	spin_unlock_bh(&((__sk)->sk_lock.slock)); \
 } while(0)
 
-#define release_sock(__sk) \
+#define _release_sock(__sk) \
 do {	spin_lock_bh(&((__sk)->sk_lock.slock)); \
 	if ((__sk)->sk_backlog.tail) \
 		__release_sock(__sk); \
@@ -561,6 +561,14 @@ do {	spin_lock_bh(&((__sk)->sk_lock.sloc
 	spin_unlock_bh(&((__sk)->sk_lock.slock)); \
 } while(0)
 
+#ifdef CONFIG_NET_SMALL
+extern void lock_sock(struct sock *sk);
+extern void release_sock(struct sock *sk);
+#else
+#define lock_sock(__sk) _lock_sock(__sk)
+#define release_sock(__sk) _release_sock(__sk)
+#endif
+
 /* BH context may only use the following locking interface. */
 #define bh_lock_sock(__sk)	spin_lock(&((__sk)->sk_lock.slock))
 #define bh_unlock_sock(__sk)	spin_unlock(&((__sk)->sk_lock.slock))
diff -urp linux-2.6.0.tiny.orig/net/core/sock.c linux-2.6.0.tiny.acme/net/core/sock.c
--- linux-2.6.0.tiny.orig/net/core/sock.c	2003-12-18 00:59:15.000000000 -0200
+++ linux-2.6.0.tiny.acme/net/core/sock.c	2003-12-28 01:32:50.000000000 -0200
@@ -1119,6 +1119,22 @@ void sock_init_data(struct socket *sock,
 	atomic_set(&sk->sk_refcnt, 1);
 }
 
+#ifdef CONFIG_NET_SMALL
+void lock_sock(struct sock *sk)
+{
+	_lock_sock(sk);
+}
+
+EXPORT_SYMBOL(lock_sock);
+
+void release_sock(struct sock *sk)
+{
+	_release_sock(sk);
+}
+
+EXPORT_SYMBOL(release_sock);
+#endif
+
 EXPORT_SYMBOL(__lock_sock);
 EXPORT_SYMBOL(__release_sock);
 EXPORT_SYMBOL(sk_alloc);
