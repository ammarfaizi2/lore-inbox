Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbUAIPoU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 10:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbUAIPoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 10:44:20 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:55923 "EHLO
	thoron.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261957AbUAIPlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 10:41:00 -0500
Date: Fri, 9 Jan 2004 10:40:56 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>,
       <selinux@tycho.nsa.gov>
Subject: [PATCH][SELINUX] 5/7 socket_has_perm cleanup
In-Reply-To: <Xine.LNX.4.44.0401091021000.21309@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0401091031500.21309-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cleanup for the SELinux code, which converts all 
remaining appropriate socket hooks over to using socket_has_perm().

Please apply.

 hooks.c |  123 ++++------------------------------------------------------------
 1 files changed, 8 insertions(+), 115 deletions(-)


diff -urN -X dontdiff linux-2.6.1-rc2.pending/security/selinux/hooks.c linux-2.6.1-rc2.w1/security/selinux/hooks.c
--- linux-2.6.1-rc2.pending/security/selinux/hooks.c	2004-01-07 11:50:22.570223176 -0500
+++ linux-2.6.1-rc2.w1/security/selinux/hooks.c	2004-01-07 11:50:31.946797720 -0500
@@ -2468,65 +2468,21 @@
 
 static int selinux_socket_connect(struct socket *sock, struct sockaddr *address, int addrlen)
 {
-	int err;
-	struct sock *sk = sock->sk;
-	struct avc_audit_data ad;
-	struct task_security_struct *tsec;
-	struct inode_security_struct *isec;
-
-	isec = SOCK_INODE(sock)->i_security;
-
-	tsec = current->security;
-
-	AVC_AUDIT_DATA_INIT(&ad, NET);
-	ad.u.net.sk = sk;
-	err = avc_has_perm(tsec->sid, isec->sid, isec->sclass,
-			   SOCKET__CONNECT, &isec->avcr, &ad);
-	if (err)
-		return err;
-
-	return 0;
+	return socket_has_perm(current, sock, SOCKET__CONNECT);
 }
 
 static int selinux_socket_listen(struct socket *sock, int backlog)
 {
-	int err;
-	struct task_security_struct *tsec;
-	struct inode_security_struct *isec;
-	struct avc_audit_data ad;
-
-	tsec = current->security;
-
-	isec = SOCK_INODE(sock)->i_security;
-
-	AVC_AUDIT_DATA_INIT(&ad, NET);
-	ad.u.net.sk = sock->sk;
-
-	err = avc_has_perm(tsec->sid, isec->sid, isec->sclass,
-			   SOCKET__LISTEN, &isec->avcr, &ad);
-	if (err)
-		return err;
-
-	return 0;
+	return socket_has_perm(current, sock, SOCKET__LISTEN);
 }
 
 static int selinux_socket_accept(struct socket *sock, struct socket *newsock)
 {
 	int err;
-	struct task_security_struct *tsec;
 	struct inode_security_struct *isec;
 	struct inode_security_struct *newisec;
-	struct avc_audit_data ad;
-
-	tsec = current->security;
-
-	isec = SOCK_INODE(sock)->i_security;
 
-	AVC_AUDIT_DATA_INIT(&ad, NET);
-	ad.u.net.sk = sock->sk;
-
-	err = avc_has_perm(tsec->sid, isec->sid, isec->sclass,
-			   SOCKET__ACCEPT, &isec->avcr, &ad);
+	err = socket_has_perm(current, sock, SOCKET__ACCEPT);
 	if (err)
 		return err;
 
@@ -2535,6 +2491,7 @@
 		return err;
 	newisec = SOCK_INODE(newsock)->i_security;
 
+	isec = SOCK_INODE(sock)->i_security;
 	newisec->sclass = isec->sclass;
 	newisec->sid = isec->sid;
 
@@ -2544,87 +2501,23 @@
 static int selinux_socket_sendmsg(struct socket *sock, struct msghdr *msg,
  				  int size)
 {
-	struct task_security_struct *tsec;
-	struct inode_security_struct *isec;
-	struct avc_audit_data ad;
-	struct sock *sk;
-	int err;
-
-	isec = SOCK_INODE(sock)->i_security;
-
-	tsec = current->security;
-
-	sk = sock->sk;
-
-	AVC_AUDIT_DATA_INIT(&ad, NET);
-	ad.u.net.sk = sk;
-	err = avc_has_perm(tsec->sid, isec->sid, isec->sclass,
-			   SOCKET__WRITE, &isec->avcr, &ad);
-	if (err)
-		return err;
-
-	return 0;
+	return socket_has_perm(current, sock, SOCKET__WRITE);
 }
 
 static int selinux_socket_recvmsg(struct socket *sock, struct msghdr *msg,
 				  int size, int flags)
 {
-	struct inode_security_struct *isec;
-	struct task_security_struct *tsec;
-	struct avc_audit_data ad;
-	int err;
-
-	isec = SOCK_INODE(sock)->i_security;
-	tsec = current->security;
-
-	AVC_AUDIT_DATA_INIT(&ad,NET);
-	ad.u.net.sk = sock->sk;
-	err = avc_has_perm(tsec->sid, isec->sid, isec->sclass,
-			   SOCKET__READ, &isec->avcr, &ad);
-	if (err)
-		return err;
-
-	return 0;
+	return socket_has_perm(current, sock, SOCKET__READ);
 }
 
 static int selinux_socket_getsockname(struct socket *sock)
 {
-	struct inode_security_struct *isec;
-	struct task_security_struct *tsec;
-	struct avc_audit_data ad;
-	int err;
-
-	tsec = current->security;
-	isec = SOCK_INODE(sock)->i_security;
-
-	AVC_AUDIT_DATA_INIT(&ad,NET);
-	ad.u.net.sk = sock->sk;
-	err = avc_has_perm(tsec->sid, isec->sid, isec->sclass,
-			   SOCKET__GETATTR, &isec->avcr, &ad);
-	if (err)
-		return err;
-
-	return 0;
+	return socket_has_perm(current, sock, SOCKET__GETATTR);
 }
 
 static int selinux_socket_getpeername(struct socket *sock)
 {
-	struct inode_security_struct *isec;
-	struct task_security_struct *tsec;
-	struct avc_audit_data ad;
-	int err;
-
-	tsec = current->security;
-	isec = SOCK_INODE(sock)->i_security;
-
-	AVC_AUDIT_DATA_INIT(&ad,NET);
-	ad.u.net.sk = sock->sk;
-	err = avc_has_perm(tsec->sid, isec->sid, isec->sclass,
-			   SOCKET__GETATTR, &isec->avcr, &ad);
-	if (err)
-		return err;
-
-	return 0;
+	return socket_has_perm(current, sock, SOCKET__GETATTR);
 }
 
 static int selinux_socket_setsockopt(struct socket *sock,int level,int optname)


