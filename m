Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbUAIPqj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 10:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbUAIPow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 10:44:52 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:53107 "EHLO
	thoron.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261950AbUAIPkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 10:40:22 -0500
Date: Fri, 9 Jan 2004 10:40:17 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>,
       <selinux@tycho.nsa.gov>
Subject: [PATCH][SELINUX] 4/7 Add node_bind control
In-Reply-To: <Xine.LNX.4.44.0401091017250.21309@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0401091021000.21309-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.1-mm1 adds a new SELinux access control, node_bind, 
which can be used to restrict the local IP address to which an application 
may bind.

Please apply.

 avc.c                       |    5 +++++
 hooks.c                     |   39 +++++++++++++++++++++++++++++++++------
 include/av_perm_to_string.h |    3 +++
 include/av_permissions.h    |    3 +++
 include/avc.h               |    1 +
 5 files changed, 45 insertions(+), 6 deletions(-)


diff -urN -X dontdiff linux-2.6.1-rc2.pending/security/selinux/avc.c linux-2.6.1-rc2.w1/security/selinux/avc.c
--- linux-2.6.1-rc2.pending/security/selinux/avc.c	2003-09-27 20:50:38.000000000 -0400
+++ linux-2.6.1-rc2.w1/security/selinux/avc.c	2004-01-07 11:49:27.467600048 -0500
@@ -636,6 +636,11 @@
 				       NIPQUAD(a->u.net.daddr));
 				if (a->u.net.port)
 					printk(" dest=%d", a->u.net.port);
+			} else if (a->u.net.saddr) {
+				printk(" saddr=%d.%d.%d.%d",
+				       NIPQUAD(a->u.net.saddr));
+				if (a->u.net.port)
+					printk(" src=%d", a->u.net.port);
 			} else if (a->u.net.port)
 				printk(" port=%d", a->u.net.port);
 			if (a->u.net.skb) {
diff -urN -X dontdiff linux-2.6.1-rc2.pending/security/selinux/hooks.c linux-2.6.1-rc2.w1/security/selinux/hooks.c
--- linux-2.6.1-rc2.pending/security/selinux/hooks.c	2004-01-07 11:49:19.517808600 -0500
+++ linux-2.6.1-rc2.w1/security/selinux/hooks.c	2004-01-07 11:49:27.471599440 -0500
@@ -2403,7 +2403,7 @@
 
 	err = socket_has_perm(current, sock, SOCKET__BIND);
 	if (err)
-		return err;
+		goto out;
 
 	/*
 	 * If PF_INET, check name_bind permission for the port.
@@ -2415,7 +2415,7 @@
 		struct sockaddr_in *addr = (struct sockaddr_in *)address;
 		unsigned short snum = ntohs(addr->sin_port);
 		struct sock *sk = sock->sk;
-		u32 sid;
+		u32 sid, node_perm;
 
 		tsec = current->security;
 		isec = SOCK_INODE(sock)->i_security;
@@ -2425,18 +2425,45 @@
 			err = security_port_sid(sk->sk_family, sk->sk_type,
 						sk->sk_protocol, snum, &sid);
 			if (err)
-				return err;
+				goto out;
 			AVC_AUDIT_DATA_INIT(&ad,NET);
 			ad.u.net.port = snum;
 			err = avc_has_perm(isec->sid, sid,
 					   isec->sclass,
 					   SOCKET__NAME_BIND, NULL, &ad);
 			if (err)
-				return err;
+				goto out;
 		}
+		
+		switch(sk->sk_protocol) {
+		case IPPROTO_TCP:
+			node_perm = TCP_SOCKET__NODE_BIND;
+			break;
+			
+		case IPPROTO_UDP:
+			node_perm = UDP_SOCKET__NODE_BIND;
+			break;
+			
+		default:
+			node_perm = RAWIP_SOCKET__NODE_BIND;
+			break;
+		}
+		
+		err = security_node_sid(PF_INET, &addr->sin_addr.s_addr,
+		                        sizeof(addr->sin_addr.s_addr), &sid);
+		if (err)
+			goto out;
+		
+		AVC_AUDIT_DATA_INIT(&ad,NET);
+		ad.u.net.port = snum;
+		ad.u.net.saddr = addr->sin_addr.s_addr;
+		err = avc_has_perm(isec->sid, sid,
+		                   isec->sclass, node_perm, NULL, &ad);
+		if (err)
+			goto out;
 	}
-
-	return 0;
+out:
+	return err;
 }
 
 static int selinux_socket_connect(struct socket *sock, struct sockaddr *address, int addrlen)
diff -urN -X dontdiff linux-2.6.1-rc2.pending/security/selinux/include/avc.h linux-2.6.1-rc2.w1/security/selinux/include/avc.h
--- linux-2.6.1-rc2.pending/security/selinux/include/avc.h	2003-09-27 20:50:10.000000000 -0400
+++ linux-2.6.1-rc2.w1/security/selinux/include/avc.h	2004-01-07 11:49:27.472599288 -0500
@@ -67,6 +67,7 @@
 			struct sock *sk;
 			u16 port;
 			u32 daddr;
+			u32 saddr;
 		} net;
 		int cap;
 		int ipc_id;
diff -urN -X dontdiff linux-2.6.1-rc2.pending/security/selinux/include/av_permissions.h linux-2.6.1-rc2.w1/security/selinux/include/av_permissions.h
--- linux-2.6.1-rc2.pending/security/selinux/include/av_permissions.h	2004-01-07 11:44:16.759834808 -0500
+++ linux-2.6.1-rc2.w1/security/selinux/include/av_permissions.h	2004-01-07 11:49:27.473599136 -0500
@@ -249,6 +249,7 @@
 #define TCP_SOCKET__CONNECTTO                     0x00400000UL
 #define TCP_SOCKET__NEWCONN                       0x00800000UL
 #define TCP_SOCKET__ACCEPTFROM                    0x01000000UL
+#define TCP_SOCKET__NODE_BIND                     0x02000000UL
 
 #define UDP_SOCKET__RELABELTO                     0x00000100UL
 #define UDP_SOCKET__RECV_MSG                      0x00080000UL
@@ -272,6 +273,7 @@
 #define UDP_SOCKET__SEND_MSG                      0x00100000UL
 #define UDP_SOCKET__RECVFROM                      0x00020000UL
 #define UDP_SOCKET__GETATTR                       0x00000010UL
+#define UDP_SOCKET__NODE_BIND                     0x00400000UL
 
 #define RAWIP_SOCKET__RELABELTO                   0x00000100UL
 #define RAWIP_SOCKET__RECV_MSG                    0x00080000UL
@@ -295,6 +297,7 @@
 #define RAWIP_SOCKET__SEND_MSG                    0x00100000UL
 #define RAWIP_SOCKET__RECVFROM                    0x00020000UL
 #define RAWIP_SOCKET__GETATTR                     0x00000010UL
+#define RAWIP_SOCKET__NODE_BIND                   0x00400000UL
 
 #define NODE__TCP_RECV                            0x00000001UL
 #define NODE__TCP_SEND                            0x00000002UL
diff -urN -X dontdiff linux-2.6.1-rc2.pending/security/selinux/include/av_perm_to_string.h linux-2.6.1-rc2.w1/security/selinux/include/av_perm_to_string.h
--- linux-2.6.1-rc2.pending/security/selinux/include/av_perm_to_string.h	2004-01-07 11:44:16.760834656 -0500
+++ linux-2.6.1-rc2.w1/security/selinux/include/av_perm_to_string.h	2004-01-07 11:49:27.474598984 -0500
@@ -46,6 +46,9 @@
    { SECCLASS_UNIX_STREAM_SOCKET, UNIX_STREAM_SOCKET__CONNECTTO, "connectto" },
    { SECCLASS_UNIX_STREAM_SOCKET, UNIX_STREAM_SOCKET__NEWCONN, "newconn" },
    { SECCLASS_UNIX_STREAM_SOCKET, UNIX_STREAM_SOCKET__ACCEPTFROM, "acceptfrom" },
+   { SECCLASS_TCP_SOCKET, TCP_SOCKET__NODE_BIND, "node_bind" },
+   { SECCLASS_UDP_SOCKET, UDP_SOCKET__NODE_BIND, "node_bind" },
+   { SECCLASS_RAWIP_SOCKET, RAWIP_SOCKET__NODE_BIND, "node_bind" },
    { SECCLASS_PROCESS, PROCESS__FORK, "fork" },
    { SECCLASS_PROCESS, PROCESS__TRANSITION, "transition" },
    { SECCLASS_PROCESS, PROCESS__SIGCHLD, "sigchld" },


