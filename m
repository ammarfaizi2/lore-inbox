Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbTFGSre (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 14:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTFGSre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 14:47:34 -0400
Received: from smtp02.web.de ([217.72.192.151]:27426 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263338AbTFGSrc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 14:47:32 -0400
Date: Sat, 7 Jun 2003 21:18:38 +0200
From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Urban Widmark <urban@teststation.com>
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH 2.5-bk] Some more stuff missed during the struct sock
 cleanup
Message-Id: <20030607211838.432de939.l.s.r@web.de>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

the members of struct sock got a prefix of 'sk_' recently. This patch
renames them in smbfs, too.

René



diff -u ./fs/smbfs/sock.c~ ./fs/smbfs/sock.c
--- ./fs/smbfs/sock.c~	2003-06-07 20:27:22.000000000 +0200
+++ ./fs/smbfs/sock.c	2003-06-07 20:27:29.000000000 +0200
@@ -68,7 +68,7 @@
 static struct smb_sb_info *
 server_from_socket(struct socket *socket)
 {
-	return socket->sk->user_data;
+	return socket->sk->sk_user_data;
 }
 
 /*
@@ -77,7 +77,7 @@
 void
 smb_data_ready(struct sock *sk, int len)
 {
-	struct smb_sb_info *server = server_from_socket(sk->socket);
+	struct smb_sb_info *server = server_from_socket(sk->sk_socket);
 	void (*data_ready)(struct sock *, int) = server->data_ready;
 
 	data_ready(sk, len);
@@ -117,7 +117,7 @@
 		struct socket *sock = server_sock(server);
 
 		VERBOSE("closing socket %p\n", sock);
-		sock->sk->data_ready = server->data_ready;
+		sock->sk->sk_data_ready = server->data_ready;
 		server->sock_file = NULL;
 		fput(file);
 	}
@@ -226,7 +226,7 @@
 	sock = server_sock(server);
 	if (!sock)
 		goto out;
-	if (sock->sk->state != TCP_ESTABLISHED)
+	if (sock->sk->sk_state != TCP_ESTABLISHED)
 		goto out;
 
 	if (!server->smb_read) {
@@ -290,7 +290,7 @@
 	sock = server_sock(server);
 	if (!sock)
 		goto out;
-	if (sock->sk->state != TCP_ESTABLISHED)
+	if (sock->sk->sk_state != TCP_ESTABLISHED)
 		goto out;
 
 	fs = get_fs();
@@ -345,7 +345,7 @@
 	sock = server_sock(server);
 	if (!sock)
 		goto out;
-	if (sock->sk->state != TCP_ESTABLISHED)
+	if (sock->sk->sk_state != TCP_ESTABLISHED)
 		goto out;
 
 	fs = get_fs();
@@ -400,7 +400,7 @@
 	sock = server_sock(server);
 	if (!sock)
 		goto out;
-	if (sock->sk->state != TCP_ESTABLISHED)
+	if (sock->sk->sk_state != TCP_ESTABLISHED)
 		goto out;
 
 	msg.msg_name = NULL;
diff -u ./fs/smbfs/proc.c~ ./fs/smbfs/proc.c
--- ./fs/smbfs/proc.c~	2003-06-07 20:27:22.000000000 +0200
+++ ./fs/smbfs/proc.c	2003-06-07 20:27:29.000000000 +0200
@@ -900,10 +900,10 @@
 	 * Store the server in sock user_data (Only used by sunrpc)
 	 */
 	sk = SOCKET_I(filp->f_dentry->d_inode)->sk;
-	sk->user_data = server;
+	sk->sk_user_data = server;
 
 	/* chain into the data_ready callback */
-	server->data_ready = xchg(&sk->data_ready, smb_data_ready);
+	server->data_ready = xchg(&sk->sk_data_ready, smb_data_ready);
 
 	/* check if we have an old smbmount that uses seconds for the 
 	   serverzone */
