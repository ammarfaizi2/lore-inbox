Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262281AbVBQJci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbVBQJci (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 04:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbVBQJci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 04:32:38 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:4241 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262281AbVBQJcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 04:32:31 -0500
Date: Thu, 17 Feb 2005 10:32:30 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: [Patch] passcred cleanup in struct socket
Message-ID: <20050217093230.GA15066@mail.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


struct socket uses a 'bool' (unsigned char) to
'flag' the pass-credential option for sockets
(which can be easily replaced by a flag)

best,
Herbert


diff -NurpP --minimal linux-2.6.11-rc4/include/linux/net.h linux-2.6.11-rc4-sock/include/linux/net.h
--- linux-2.6.11-rc4/include/linux/net.h	2005-02-13 17:17:06 +0100
+++ linux-2.6.11-rc4-sock/include/linux/net.h	2005-02-17 09:47:44 +0100
@@ -61,6 +61,7 @@ typedef enum {
 #define SOCK_ASYNC_NOSPACE	0
 #define SOCK_ASYNC_WAITDATA	1
 #define SOCK_NOSPACE		2
+#define SOCK_PASSCRED		3
 
 #ifndef ARCH_HAS_SOCKET_TYPES
 /** sock_type - Socket types
@@ -111,7 +112,6 @@ struct socket {
 	struct sock		*sk;
 	wait_queue_head_t	wait;
 	short			type;
-	unsigned char		passcred;
 };
 
 struct vm_area_struct;
diff -NurpP --minimal linux-2.6.11-rc4/include/net/scm.h linux-2.6.11-rc4-sock/include/net/scm.h
--- linux-2.6.11-rc4/include/net/scm.h	2004-08-14 12:55:32 +0200
+++ linux-2.6.11-rc4-sock/include/net/scm.h	2005-02-17 09:49:42 +0100
@@ -51,13 +51,13 @@ static __inline__ void scm_recv(struct s
 {
 	if (!msg->msg_control)
 	{
-		if (sock->passcred || scm->fp)
+		if (test_bit(SOCK_PASSCRED, &sock->flags) || scm->fp)
 			msg->msg_flags |= MSG_CTRUNC;
 		scm_destroy(scm);
 		return;
 	}
 
-	if (sock->passcred)
+	if (test_bit(SOCK_PASSCRED, &sock->flags))
 		put_cmsg(msg, SOL_SOCKET, SCM_CREDENTIALS, sizeof(scm->creds), &scm->creds);
 
 	if (!scm->fp)
diff -NurpP --minimal linux-2.6.11-rc4/net/core/sock.c linux-2.6.11-rc4-sock/net/core/sock.c
--- linux-2.6.11-rc4/net/core/sock.c	2005-02-13 17:17:18 +0100
+++ linux-2.6.11-rc4-sock/net/core/sock.c	2005-02-17 09:49:42 +0100
@@ -333,7 +333,10 @@ int sock_setsockopt(struct socket *sock,
 			break;
 
 		case SO_PASSCRED:
-			sock->passcred = valbool;
+			if (valbool)
+				set_bit(SOCK_PASSCRED, &sock->flags);
+			else
+				clear_bit(SOCK_PASSCRED, &sock->flags);
 			break;
 
 		case SO_TIMESTAMP:
@@ -557,7 +560,7 @@ int sock_getsockopt(struct socket *sock,
 			break; 
 
 		case SO_PASSCRED:
-			v.val = sock->passcred;
+			v.val = test_bit(SOCK_PASSCRED, &sock->flags) ? 1 : 0;
 			break;
 
 		case SO_PEERCRED:
diff -NurpP --minimal linux-2.6.11-rc4/net/socket.c linux-2.6.11-rc4-sock/net/socket.c
--- linux-2.6.11-rc4/net/socket.c	2005-02-13 17:17:19 +0100
+++ linux-2.6.11-rc4-sock/net/socket.c	2005-02-17 09:34:41 +0100
@@ -287,7 +287,7 @@ static struct inode *sock_alloc_inode(st
 	ei->socket.ops = NULL;
 	ei->socket.sk = NULL;
 	ei->socket.file = NULL;
-	ei->socket.passcred = 0;
+	ei->socket.flags = 0;
 
 	return &ei->vfs_inode;
 }
diff -NurpP --minimal linux-2.6.11-rc4/net/unix/af_unix.c linux-2.6.11-rc4-sock/net/unix/af_unix.c
--- linux-2.6.11-rc4/net/unix/af_unix.c	2005-02-13 17:17:19 +0100
+++ linux-2.6.11-rc4-sock/net/unix/af_unix.c	2005-02-17 09:49:42 +0100
@@ -861,8 +861,8 @@ static int unix_dgram_connect(struct soc
 			goto out;
 		alen = err;
 
-		if (sock->passcred && !unix_sk(sk)->addr &&
-		    (err = unix_autobind(sock)) != 0)
+		if (test_bit(SOCK_PASSCRED, &sock->flags) &&
+		    !unix_sk(sk)->addr && (err = unix_autobind(sock)) != 0)
 			goto out;
 
 		other=unix_find_other(sunaddr, alen, sock->type, hash, &err);
@@ -952,7 +952,8 @@ static int unix_stream_connect(struct so
 		goto out;
 	addr_len = err;
 
-	if (sock->passcred && !u->addr && (err = unix_autobind(sock)) != 0)
+	if (test_bit(SOCK_PASSCRED, &sock->flags)
+		&& !u->addr && (err = unix_autobind(sock)) != 0)
 		goto out;
 
 	timeo = sock_sndtimeo(sk, flags & O_NONBLOCK);
@@ -1286,7 +1287,8 @@ static int unix_dgram_sendmsg(struct kio
 			goto out;
 	}
 
-	if (sock->passcred && !u->addr && (err = unix_autobind(sock)) != 0)
+	if (test_bit(SOCK_PASSCRED, &sock->flags)
+		&& !u->addr && (err = unix_autobind(sock)) != 0)
 		goto out;
 
 	err = -EMSGSIZE;
