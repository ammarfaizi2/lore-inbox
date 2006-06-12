Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932663AbWFLX6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbWFLX6P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 19:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbWFLX6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 19:58:15 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:6590 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932658AbWFLX6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 19:58:12 -0400
Subject: [RFC/PATCH 1/2] in-kernel sockets API
From: Sridhar Samudrala <sri@us.ibm.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 12 Jun 2006 16:56:01 -0700
Message-Id: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes it convenient to use the sockets API by the in-kernel
users like sunrpc, cifs & ocfs2 etc and any future users.
Currently they get to this API by directly accesing the function pointers
in the sock structure.

Most of these functions are pretty simple and can be made inline and moved
to linux/net.h.

I used kernel_ prefix for this API to match with the existing kernel_sendmsg
and kernel_recvmsg() although i would prefer ksock_.

I have updated sunrpc to use this API.

I would appreciate any comments or suggestions for improvements.

Thanks
Sridhar

diff --git a/include/linux/net.h b/include/linux/net.h
index 84a490e..b70c28f 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -208,6 +208,25 @@ extern int   	     kernel_recvmsg(struct
 				    struct kvec *vec, size_t num,
 				    size_t len, int flags);
 
+extern int kernel_bind(struct socket *sock, struct sockaddr *addr,
+		       int addrlen);
+extern int kernel_listen(struct socket *sock, int backlog);
+extern int kernel_accept(struct socket *sock, struct socket **newsock,
+			 int flags);
+extern int kernel_connect(struct socket *sock, struct sockaddr *addr,
+			  int addrlen, int flags);
+extern int kernel_getsockname(struct socket *sock, struct sockaddr *addr,
+			      int *addrlen);
+extern int kernel_getpeername(struct socket *sock, struct sockaddr *addr,
+			      int *addrlen);
+extern int kernel_getsockopt(struct socket *sock, int level, int optname,
+			     char *optval, int *optlen);
+extern int kernel_setsockopt(struct socket *sock, int level, int optname,
+			     char *optval, int optlen);
+extern int kernel_sendpage(struct socket *sock, struct page *page, int offset,
+			   size_t size, int flags);
+extern int kernel_ioctl(struct socket *sock, int cmd, unsigned long arg);
+
 #ifndef CONFIG_SMP
 #define SOCKOPS_WRAPPED(name) name
 #define SOCKOPS_WRAP(name, fam)
diff --git a/net/socket.c b/net/socket.c
index 02948b6..8f36be7 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2160,6 +2160,109 @@ static long compat_sock_ioctl(struct fil
 }
 #endif
 
+int kernel_bind(struct socket *sock, struct sockaddr *addr, int addrlen)
+{
+	return sock->ops->bind(sock, addr, addrlen);
+}
+
+int kernel_listen(struct socket *sock, int backlog)
+{
+	return sock->ops->listen(sock, backlog);
+}
+
+int kernel_accept(struct socket *sock, struct socket **newsock, int flags)
+{
+	struct sock *sk = sock->sk;
+	int err;
+
+	err = sock_create_lite(sk->sk_family, sk->sk_type, sk->sk_protocol,
+			       newsock);	
+	if (err < 0)
+		goto done;	
+
+	err = sock->ops->accept(sock, *newsock, flags);
+	if (err < 0) {
+		sock_release(*newsock);
+		goto done;
+	}
+			
+	(*newsock)->ops = sock->ops;
+
+done:
+	return err;
+}
+
+int kernel_connect(struct socket *sock, struct sockaddr *addr, int addrlen,
+                   int flags)
+{
+	return sock->ops->connect(sock, addr, addrlen, flags);
+}	
+
+int kernel_getsockname(struct socket *sock, struct sockaddr *addr,
+			 int *addrlen)
+{
+	return sock->ops->getname(sock, addr, addrlen, 0);
+}
+
+int kernel_getpeername(struct socket *sock, struct sockaddr *addr,
+			 int *addrlen)
+{
+	return sock->ops->getname(sock, addr, addrlen, 1);
+}
+
+int kernel_getsockopt(struct socket *sock, int level, int optname,
+			char *optval, int *optlen)
+{
+	mm_segment_t oldfs = get_fs();
+	int err;
+
+	set_fs(KERNEL_DS);
+	if (level == SOL_SOCKET)
+		err = sock_getsockopt(sock, level, optname, optval, optlen);
+	else
+		err = sock->ops->getsockopt(sock, level, optname, optval,
+					    optlen);
+	set_fs(oldfs);
+	return err;
+}
+
+int kernel_setsockopt(struct socket *sock, int level, int optname,
+			char *optval, int optlen)
+{
+	mm_segment_t oldfs = get_fs();
+	int err;
+
+	set_fs(KERNEL_DS);
+	if (level == SOL_SOCKET)
+		err = sock_setsockopt(sock, level, optname, optval, optlen);
+	else
+		err = sock->ops->setsockopt(sock, level, optname, optval,
+					    optlen);
+	set_fs(oldfs);
+	return err;
+}
+
+int kernel_sendpage(struct socket *sock, struct page *page, int offset,
+		    size_t size, int flags)
+{
+	if (sock->ops->sendpage)
+		return sock->ops->sendpage(sock, page, offset, size, flags);
+	
+	return sock_no_sendpage(sock, page, offset, size, flags);
+}
+
+int kernel_ioctl(struct socket *sock, int cmd, unsigned long arg)
+{
+	mm_segment_t oldfs = get_fs();
+	int err;
+
+	set_fs(KERNEL_DS);
+	err = sock->ops->ioctl(sock, cmd, arg);
+	set_fs(oldfs);
+	
+	return err;
+}
+
 /* ABI emulation layers need these two */
 EXPORT_SYMBOL(move_addr_to_kernel);
 EXPORT_SYMBOL(move_addr_to_user);
@@ -2176,3 +2279,13 @@ EXPORT_SYMBOL(sock_wake_async);
 EXPORT_SYMBOL(sockfd_lookup);
 EXPORT_SYMBOL(kernel_sendmsg);
 EXPORT_SYMBOL(kernel_recvmsg);
+EXPORT_SYMBOL(kernel_bind);
+EXPORT_SYMBOL(kernel_listen);
+EXPORT_SYMBOL(kernel_accept);
+EXPORT_SYMBOL(kernel_connect);
+EXPORT_SYMBOL(kernel_getsockname);
+EXPORT_SYMBOL(kernel_getpeername);
+EXPORT_SYMBOL(kernel_getsockopt);
+EXPORT_SYMBOL(kernel_setsockopt);
+EXPORT_SYMBOL(kernel_sendpage);
+EXPORT_SYMBOL(kernel_ioctl);


