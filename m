Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbUDRAvc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 20:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264094AbUDRAvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 20:51:32 -0400
Received: from outmx017.isp.belgacom.be ([195.238.2.116]:41858 "EHLO
	outmx017.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261298AbUDRAv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 20:51:28 -0400
Subject: [PATCH 2.6.6pre1 nfs4] portmap register switcher
From: Fabian Frederick <Fabian.Frederick@skynet.be>
To: Trond <trond.myklebust@fys.uio.no>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-1c4UtJsZstzzzj+j31l/"
Message-Id: <1082249676.2075.11.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 18 Apr 2004 02:54:36 +0200
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx017.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1c4UtJsZstzzzj+j31l/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Trond,

	Here's a patch to have an svc_makesock portmap switcher (+ lockd & nfs
updated).


Regards,
Fabian

--=-1c4UtJsZstzzzj+j31l/
Content-Disposition: attachment; filename=pmap_reg1.diff
Content-Type: text/x-patch; name=pmap_reg1.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -Naur orig/fs/lockd/svc.c edited/fs/lockd/svc.c
--- orig/fs/lockd/svc.c	2004-04-04 05:37:36.000000000 +0200
+++ edited/fs/lockd/svc.c	2004-04-18 02:32:00.000000000 +0200
@@ -237,9 +237,9 @@
 		goto out;
 	}
 
-	if ((error = svc_makesock(serv, IPPROTO_UDP, nlm_udpport)) < 0 
+	if ((error = svc_makesock(serv, IPPROTO_UDP, nlm_udpport, 1)) < 0 
 #ifdef CONFIG_NFSD_TCP
-	 || (error = svc_makesock(serv, IPPROTO_TCP, nlm_tcpport)) < 0
+	 || (error = svc_makesock(serv, IPPROTO_TCP, nlm_tcpport, 1)) < 0
 #endif
 		) {
 		if (warned++ == 0) 
diff -Naur orig/fs/nfs/callback.c edited/fs/nfs/callback.c
--- orig/fs/nfs/callback.c	2004-04-17 00:38:02.000000000 +0200
+++ edited/fs/nfs/callback.c	2004-04-18 02:30:08.000000000 +0200
@@ -93,8 +93,7 @@
 	ret = -ENOMEM;
 	if (!serv)
 		goto out_err;
-	/* FIXME: We don't want to register this socket with the portmapper */
-	ret = svc_makesock(serv, IPPROTO_TCP, 0);
+	ret = svc_makesock(serv, IPPROTO_TCP, 0, 0);
 	if (ret < 0)
 		goto out_destroy;
 	if (!list_empty(&serv->sv_permsocks)) {
diff -Naur orig/fs/nfsd/nfssvc.c edited/fs/nfsd/nfssvc.c
--- orig/fs/nfsd/nfssvc.c	2004-04-04 05:37:23.000000000 +0200
+++ edited/fs/nfsd/nfssvc.c	2004-04-18 02:37:25.000000000 +0200
@@ -101,12 +101,12 @@
 		nfsd_serv = svc_create(&nfsd_program, NFSD_BUFSIZE);
 		if (nfsd_serv == NULL)
 			goto out;
-		error = svc_makesock(nfsd_serv, IPPROTO_UDP, port);
+		error = svc_makesock(nfsd_serv, IPPROTO_UDP, port, 1);
 		if (error < 0)
 			goto failure;
 
 #ifdef CONFIG_NFSD_TCP
-		error = svc_makesock(nfsd_serv, IPPROTO_TCP, port);
+		error = svc_makesock(nfsd_serv, IPPROTO_TCP, port, 1);
 		if (error < 0)
 			goto failure;
 #endif
diff -Naur orig/include/linux/sunrpc/svcsock.h edited/include/linux/sunrpc/svcsock.h
--- orig/include/linux/sunrpc/svcsock.h	2004-04-04 05:36:53.000000000 +0200
+++ edited/include/linux/sunrpc/svcsock.h	2004-04-18 02:42:49.000000000 +0200
@@ -55,7 +55,7 @@
 /*
  * Function prototypes.
  */
-int		svc_makesock(struct svc_serv *, int, unsigned short);
+int		svc_makesock(struct svc_serv *, int, unsigned short, int);
 void		svc_delete_socket(struct svc_sock *);
 int		svc_recv(struct svc_serv *, struct svc_rqst *, long);
 int		svc_send(struct svc_rqst *);
diff -Naur orig/net/sunrpc/svcsock.c edited/net/sunrpc/svcsock.c
--- orig/net/sunrpc/svcsock.c	2004-04-17 00:37:41.000000000 +0200
+++ edited/net/sunrpc/svcsock.c	2004-04-18 02:42:04.000000000 +0200
@@ -1388,7 +1388,7 @@
  * Create socket for RPC service.
  */
 static int
-svc_create_socket(struct svc_serv *serv, int protocol, struct sockaddr_in *sin)
+svc_create_socket(struct svc_serv *serv, int protocol, struct sockaddr_in *sin, int pmap_register)
 {
 	struct svc_sock	*svsk;
 	struct socket	*sock;
@@ -1424,7 +1424,7 @@
 			goto bummer;
 	}
 
-	if ((svsk = svc_setup_socket(serv, sock, &error, 1)) != NULL)
+	if ((svsk = svc_setup_socket(serv, sock, &error, pmap_register)) != NULL)
 		return 0;
 
 bummer:
@@ -1474,7 +1474,7 @@
  * Make a socket for nfsd and lockd
  */
 int
-svc_makesock(struct svc_serv *serv, int protocol, unsigned short port)
+svc_makesock(struct svc_serv *serv, int protocol, unsigned short port, int pmap_register)
 {
 	struct sockaddr_in	sin;
 
@@ -1482,7 +1482,7 @@
 	sin.sin_family      = AF_INET;
 	sin.sin_addr.s_addr = INADDR_ANY;
 	sin.sin_port        = htons(port);
-	return svc_create_socket(serv, protocol, &sin);
+	return svc_create_socket(serv, protocol, &sin, pmap_register);
 }
 
 /*

--=-1c4UtJsZstzzzj+j31l/--

