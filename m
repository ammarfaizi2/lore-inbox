Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbVCWOss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbVCWOss (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 09:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbVCWOss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 09:48:48 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:51179 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S262398AbVCWOsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 09:48:03 -0500
Subject: [PATCH][SELINUX] Add name_connect permission check
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 23 Mar 2005 09:40:07 -0500
Message-Id: <1111588807.21107.68.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a name_connect permission check to SELinux to provide
control over outbound TCP connections to particular ports distinct
from the general controls over sending and receiving packets.  Please
apply.

 security/selinux/hooks.c                     |   48 ++++++++++++++++++++++++++-
 security/selinux/include/av_perm_to_string.h |    1 
 security/selinux/include/av_permissions.h    |    1 
 3 files changed, 49 insertions(+), 1 deletion(-)

Index: linux-2.6/security/selinux/hooks.c
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/hooks.c,v
retrieving revision 1.160
diff -u -p -r1.160 hooks.c
--- linux-2.6/security/selinux/hooks.c	22 Mar 2005 17:30:12 -0000	1.160
+++ linux-2.6/security/selinux/hooks.c	23 Mar 2005 14:17:26 -0000
@@ -3085,7 +3085,53 @@ out:
 
 static int selinux_socket_connect(struct socket *sock, struct sockaddr *address, int addrlen)
 {
-	return socket_has_perm(current, sock, SOCKET__CONNECT);
+	struct inode_security_struct *isec;
+	int err;
+
+	err = socket_has_perm(current, sock, SOCKET__CONNECT);
+	if (err)
+		return err;
+
+	/*
+	 * If a TCP socket, check name_connect permission for the port.
+	 */
+	isec = SOCK_INODE(sock)->i_security;
+	if (isec->sclass == SECCLASS_TCP_SOCKET) {
+		struct sock *sk = sock->sk;
+		struct avc_audit_data ad;
+		struct sockaddr_in *addr4 = NULL;
+		struct sockaddr_in6 *addr6 = NULL;
+		unsigned short snum;
+		u32 sid;
+
+		if (sk->sk_family == PF_INET) {
+			addr4 = (struct sockaddr_in *)address;
+			if (addrlen != sizeof(struct sockaddr_in))
+				return -EINVAL;
+			snum = ntohs(addr4->sin_port);
+		} else {
+			addr6 = (struct sockaddr_in6 *)address;
+			if (addrlen != sizeof(struct sockaddr_in6))
+				return -EINVAL;
+			snum = ntohs(addr6->sin6_port);
+		}
+
+		err = security_port_sid(sk->sk_family, sk->sk_type,
+					sk->sk_protocol, snum, &sid);
+		if (err)
+			goto out;
+
+		AVC_AUDIT_DATA_INIT(&ad,NET);
+		ad.u.net.dport = htons(snum);
+		ad.u.net.family = sk->sk_family;
+		err = avc_has_perm(isec->sid, sid, isec->sclass,
+				   TCP_SOCKET__NAME_CONNECT, &ad);
+		if (err)
+			goto out;
+	}
+
+out:
+	return err;
 }
 
 static int selinux_socket_listen(struct socket *sock, int backlog)
Index: linux-2.6/security/selinux/include/av_perm_to_string.h
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/include/av_perm_to_string.h,v
retrieving revision 1.23
diff -u -p -r1.23 av_perm_to_string.h
--- linux-2.6/security/selinux/include/av_perm_to_string.h	23 Feb 2005 20:26:54 -0000	1.23
+++ linux-2.6/security/selinux/include/av_perm_to_string.h	22 Mar 2005 20:29:05 -0000
@@ -25,6 +25,7 @@
    S_(SECCLASS_TCP_SOCKET, TCP_SOCKET__NEWCONN, "newconn")
    S_(SECCLASS_TCP_SOCKET, TCP_SOCKET__ACCEPTFROM, "acceptfrom")
    S_(SECCLASS_TCP_SOCKET, TCP_SOCKET__NODE_BIND, "node_bind")
+   S_(SECCLASS_TCP_SOCKET, TCP_SOCKET__NAME_CONNECT, "name_connect")
    S_(SECCLASS_UDP_SOCKET, UDP_SOCKET__NODE_BIND, "node_bind")
    S_(SECCLASS_RAWIP_SOCKET, RAWIP_SOCKET__NODE_BIND, "node_bind")
    S_(SECCLASS_NODE, NODE__TCP_RECV, "tcp_recv")
Index: linux-2.6/security/selinux/include/av_permissions.h
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/include/av_permissions.h,v
retrieving revision 1.22
diff -u -p -r1.22 av_permissions.h
--- linux-2.6/security/selinux/include/av_permissions.h	23 Feb 2005 20:26:54 -0000	1.22
+++ linux-2.6/security/selinux/include/av_permissions.h	22 Mar 2005 20:29:05 -0000
@@ -253,6 +253,7 @@
 #define TCP_SOCKET__NEWCONN                       0x00800000UL
 #define TCP_SOCKET__ACCEPTFROM                    0x01000000UL
 #define TCP_SOCKET__NODE_BIND                     0x02000000UL
+#define TCP_SOCKET__NAME_CONNECT                  0x04000000UL
 
 #define UDP_SOCKET__IOCTL                         0x00000001UL
 #define UDP_SOCKET__READ                          0x00000002UL

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency

