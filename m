Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVBNObM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVBNObM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 09:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVBNObL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 09:31:11 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:25256 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261436AbVBNOaf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 09:30:35 -0500
Subject: Re: [PATCH] 2/5: LSM hooks rework
From: Andreas Gruenbacher <agruen@suse.de>
To: Kurt Garloff <garloff@suse.de>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
In-Reply-To: <20050213211109.GJ27893@tpkurt.garloff.de>
References: <20050213210515.GH27893@tpkurt.garloff.de>
	 <20050213211034.GI27893@tpkurt.garloff.de>
	 <20050213211109.GJ27893@tpkurt.garloff.de>
Content-Type: multipart/mixed; boundary="=-OOkgn+tLWHSYVOO48y9x"
Organization: SUSE Labs
Message-Id: <1108391432.2974.6.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 14 Feb 2005 15:30:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OOkgn+tLWHSYVOO48y9x
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2005-02-13 at 22:11, Kurt Garloff wrote:
> From: Kurt Garloff <garloff@suse.de>
> Subject: Clean LSM stub file
> References: 40217, 39439
> 
> Rather than having every LSM hook twice, once for the case with
> CONFIG_SECURITY enabled and once for the disabled case, put
> everything in one inline function.

The attached patch fixes compilation if CONFIG_SECURITY_NETWORK is
turned off.

> This reduces the chance of the two to go out of sync immensely.

... as it already happened with security_sk_free(). Also fixed in the
attached patch.


Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

--=-OOkgn+tLWHSYVOO48y9x
Content-Disposition: attachment; filename="CONFIG_SECURITY_NETWORK=n.diff"
Content-Type: message/rfc822; name="CONFIG_SECURITY_NETWORK=n.diff"

From: Andreas Gruenbacher <agruen@suse.de>
Subject: Fix for CONFIG_SECURITY_NETWORK=n
Date: Mon, 14 Feb 2005 15:28:56 +0100
Message-Id: <1108391336.2974.4.camel@winden.suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

The patch didn't define dummy inline functions for the
CONFIG_SECURITY_NETWORK=n case.

Also, security_sk_free() returns void.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.11-rc3/include/linux/security.h
===================================================================
--- linux-2.6.11-rc3.orig/include/linux/security.h
+++ linux-2.6.11-rc3/include/linux/security.h
@@ -1261,6 +1261,11 @@ static inline int security_init(void)
 # define COND_SECURITY(seop, def) def
 #endif
 
+#ifdef CONFIG_SECURITY_NETWORK
+#define COND_SECURITY_NETWORK(seop, def) COND_SECURITY(seop, def)
+#else
+#define COND_SECURITY_NETWORK(seop, def) def
+#endif
 /* SELinux noop */
 #define SE_NOP ({})
 
@@ -2044,12 +2049,11 @@ static inline int security_netlink_recv(
 			 cap_netlink_recv (skb));
 }
 
-#ifdef CONFIG_SECURITY_NETWORK
 static inline int security_unix_stream_connect(struct socket * sock,
 					       struct socket * other, 
 					       struct sock * newsk)
 {
-	return COND_SECURITY(unix_stream_connect(sock, other, newsk),
+	return COND_SECURITY_NETWORK(unix_stream_connect(sock, other, newsk),
 			 0);
 }
 
@@ -2057,14 +2061,14 @@ static inline int security_unix_stream_c
 static inline int security_unix_may_send(struct socket * sock, 
 					 struct socket * other)
 {
-	return COND_SECURITY(unix_may_send(sock, other),
+	return COND_SECURITY_NETWORK(unix_may_send(sock, other),
 			 0);
 }
 
 static inline int security_socket_create (int family, int type,
 					  int protocol, int kern)
 {
-	return COND_SECURITY(socket_create(family, type, protocol, kern),
+	return COND_SECURITY_NETWORK(socket_create(family, type, protocol, kern),
 			 0);
 }
 
@@ -2073,7 +2077,7 @@ static inline void security_socket_post_
 					       int type, 
 					       int protocol, int kern)
 {
-	COND_SECURITY(socket_post_create(sock, family, type, protocol, kern),
+	COND_SECURITY_NETWORK(socket_post_create(sock, family, type, protocol, kern),
 		  SE_NOP);
 }
 
@@ -2081,7 +2085,7 @@ static inline int security_socket_bind(s
 				       struct sockaddr * address, 
 				       int addrlen)
 {
-	return COND_SECURITY(socket_bind(sock, address, addrlen),
+	return COND_SECURITY_NETWORK(socket_bind(sock, address, addrlen),
 			 0);
 }
 
@@ -2089,34 +2093,34 @@ static inline int security_socket_connec
 					  struct sockaddr * address, 
 					  int addrlen)
 {
-	return COND_SECURITY(socket_connect(sock, address, addrlen),
+	return COND_SECURITY_NETWORK(socket_connect(sock, address, addrlen),
 			 0);
 }
 
 static inline int security_socket_listen(struct socket * sock, int backlog)
 {
-	return COND_SECURITY(socket_listen(sock, backlog),
+	return COND_SECURITY_NETWORK(socket_listen(sock, backlog),
 			 0);
 }
 
 static inline int security_socket_accept(struct socket * sock, 
 					 struct socket * newsock)
 {
-	return COND_SECURITY(socket_accept(sock, newsock),
+	return COND_SECURITY_NETWORK(socket_accept(sock, newsock),
 			 0);
 }
 
 static inline void security_socket_post_accept(struct socket * sock, 
 					       struct socket * newsock)
 {
-	COND_SECURITY(socket_post_accept(sock, newsock),
+	COND_SECURITY_NETWORK(socket_post_accept(sock, newsock),
 		  SE_NOP);
 }
 
 static inline int security_socket_sendmsg(struct socket * sock, 
 					  struct msghdr * msg, int size)
 {
-	return COND_SECURITY(socket_sendmsg(sock, msg, size),
+	return COND_SECURITY_NETWORK(socket_sendmsg(sock, msg, size),
 			 0);
 }
 
@@ -2124,68 +2128,67 @@ static inline int security_socket_recvms
 					  struct msghdr * msg, int size, 
 					  int flags)
 {
-	return COND_SECURITY(socket_recvmsg(sock, msg, size, flags),
+	return COND_SECURITY_NETWORK(socket_recvmsg(sock, msg, size, flags),
 			 0);
 }
 
 static inline int security_socket_getsockname(struct socket * sock)
 {
-	return COND_SECURITY(socket_getsockname(sock),
+	return COND_SECURITY_NETWORK(socket_getsockname(sock),
 			 0);
 }
 
 static inline int security_socket_getpeername(struct socket * sock)
 {
-	return COND_SECURITY(socket_getpeername(sock),
+	return COND_SECURITY_NETWORK(socket_getpeername(sock),
 			 0);
 }
 
 static inline int security_socket_getsockopt(struct socket * sock, 
 					     int level, int optname)
 {
-	return COND_SECURITY(socket_getsockopt(sock, level, optname),
+	return COND_SECURITY_NETWORK(socket_getsockopt(sock, level, optname),
 			 0);
 }
 
 static inline int security_socket_setsockopt(struct socket * sock, 
 					     int level, int optname)
 {
-	return COND_SECURITY(socket_setsockopt(sock, level, optname),
+	return COND_SECURITY_NETWORK(socket_setsockopt(sock, level, optname),
 			 0);
 }
 
 static inline int security_socket_shutdown(struct socket * sock, int how)
 {
-	return COND_SECURITY(socket_shutdown(sock, how),
+	return COND_SECURITY_NETWORK(socket_shutdown(sock, how),
 			 0);
 }
 
 static inline int security_sock_rcv_skb (struct sock * sk, 
 					 struct sk_buff * skb)
 {
-	return COND_SECURITY(socket_sock_rcv_skb(sk, skb),
+	return COND_SECURITY_NETWORK(socket_sock_rcv_skb(sk, skb),
 			 0);
 }
 
 static inline int security_socket_getpeersec(struct socket *sock, char __user *optval,
 					     int __user *optlen, unsigned len)
 {
-	return COND_SECURITY(socket_getpeersec(sock, optval, optlen, len),
+	return COND_SECURITY_NETWORK(socket_getpeersec(sock, optval, optlen, len),
 			 -ENOPROTOOPT);
 }
 
 static inline int security_sk_alloc(struct sock *sk, int family, int priority)
 {
-	return COND_SECURITY(sk_alloc_security(sk, family, priority),
+	return COND_SECURITY_NETWORK(sk_alloc_security(sk, family, priority),
 			 0);
 }
 
 static inline void security_sk_free(struct sock *sk)
 {
-	return COND_SECURITY(sk_free_security(sk),
-		  	 0);
+	COND_SECURITY_NETWORK(sk_free_security(sk),
+		  	 SE_NOP);
 }
-#endif	/* CONFIG_SECURITY_NETWORK */
 
 #endif /* ! __LINUX_SECURITY_H */
 

--=-OOkgn+tLWHSYVOO48y9x--

