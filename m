Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266126AbUFPDAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266126AbUFPDAK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 23:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266124AbUFPC7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 22:59:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12973 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266197AbUFPCyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 22:54:50 -0400
Date: Tue, 15 Jun 2004 22:54:42 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: "David S. Miller" <davem@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Chris Wright <chrisw@osdl.org>, <linux-kernel@vger.kernel.org>,
       <selinux@tycho.nsa.gov>
Subject: [SELINUX][PATCH 4/4] Fine-grained Netlink support - SELinux changes
In-Reply-To: <Xine.LNX.4.44.0406152231400.30562@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0406152233430.30562-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains SELinux changes which add support for extended Netlink
socket classes and the associated permissions nlmsg_read and nlmsg_write.

Please apply.

Signed-off-by: James Morris <jmorris@redhat.com>

 security/selinux/Makefile                    |    2 
 security/selinux/hooks.c                     |  102 +++++++++---
 security/selinux/include/av_inherit.h        |    9 +
 security/selinux/include/av_perm_to_string.h |   12 +
 security/selinux/include/av_permissions.h    |  223 +++++++++++++++++++++++++++
 security/selinux/include/class_to_string.h   |    9 +
 security/selinux/include/flask.h             |    9 +
 security/selinux/include/security.h          |    9 -
 security/selinux/nlmsgtab.c                  |  153 ++++++++++++++++++
 security/selinux/ss/policydb.c               |   10 +
 security/selinux/ss/services.c               |   12 +
 11 files changed, 522 insertions(+), 28 deletions(-)


diff -purN -X dontdiff linux-2.6.7-rc3-mm2.p/security/selinux/hooks.c linux-2.6.7-rc3-mm2.w/security/selinux/hooks.c
--- linux-2.6.7-rc3-mm2.p/security/selinux/hooks.c	2004-06-15 22:04:39.007213048 -0400
+++ linux-2.6.7-rc3-mm2.w/security/selinux/hooks.c	2004-06-15 22:04:12.445251080 -0400
@@ -71,6 +71,9 @@
 #define XATTR_SELINUX_SUFFIX "selinux"
 #define XATTR_NAME_SELINUX XATTR_SECURITY_PREFIX XATTR_SELINUX_SUFFIX
 
+extern int policydb_loaded_version;
+extern int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm);
+
 #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
 int selinux_enforcing = 0;
 
@@ -627,7 +630,7 @@ static inline u16 inode_mode_to_security
 	return SECCLASS_FILE;
 }
 
-static inline u16 socket_type_to_security_class(int family, int type)
+static inline u16 socket_type_to_security_class(int family, int type, int protocol)
 {
 	switch (family) {
 	case PF_UNIX:
@@ -648,7 +651,28 @@ static inline u16 socket_type_to_securit
 			return SECCLASS_RAWIP_SOCKET;
 		}
 	case PF_NETLINK:
-		return SECCLASS_NETLINK_SOCKET;
+		switch (protocol) {
+		case NETLINK_ROUTE:
+			return SECCLASS_NETLINK_ROUTE_SOCKET;
+		case NETLINK_FIREWALL:
+			return SECCLASS_NETLINK_FIREWALL_SOCKET;
+		case NETLINK_TCPDIAG:
+			return SECCLASS_NETLINK_TCPDIAG_SOCKET;
+		case NETLINK_NFLOG:
+			return SECCLASS_NETLINK_NFLOG_SOCKET;
+		case NETLINK_XFRM:
+			return SECCLASS_NETLINK_XFRM_SOCKET;
+		case NETLINK_SELINUX:
+			return SECCLASS_NETLINK_SELINUX_SOCKET;
+		case NETLINK_AUDIT:
+			return SECCLASS_NETLINK_AUDIT_SOCKET;
+		case NETLINK_IP6_FW:
+			return SECCLASS_NETLINK_IP6FW_SOCKET;
+		case NETLINK_DNRTMSG:
+			return SECCLASS_NETLINK_DNRT_SOCKET;
+		default:
+			return SECCLASS_NETLINK_SOCKET;
+		}
 	case PF_PACKET:
 		return SECCLASS_PACKET_SOCKET;
 	case PF_KEY:
@@ -853,7 +877,8 @@ out:
 		struct socket *sock = SOCKET_I(inode);
 		if (sock->sk) {
 			isec->sclass = socket_type_to_security_class(sock->sk->sk_family,
-			                                             sock->sk->sk_type);
+			                                             sock->sk->sk_type,
+			                                             sock->sk->sk_protocol);
 		} else {
 			isec->sclass = SECCLASS_SOCKET;
 		}
@@ -1567,22 +1592,6 @@ static int selinux_vm_enough_memory(long
 	return -ENOMEM;
 }
 
-static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
-{
-	if (capable(CAP_NET_ADMIN))
-		cap_raise (NETLINK_CB (skb).eff_cap, CAP_NET_ADMIN);
-	else
-		NETLINK_CB(skb).eff_cap = 0;
-	return 0;
-}
-
-static int selinux_netlink_recv(struct sk_buff *skb)
-{
-	if (!cap_raised(NETLINK_CB(skb).eff_cap, CAP_NET_ADMIN))
-		return -EPERM;
-	return 0;
-}
-
 /* binprm security operations */
 
 static int selinux_bprm_alloc_security(struct linux_binprm *bprm)
@@ -2918,8 +2927,8 @@ static int selinux_socket_create(int fam
 
 	tsec = current->security;
 	err = avc_has_perm(tsec->sid, tsec->sid,
-			   socket_type_to_security_class(family, type),
-			   SOCKET__CREATE, NULL, NULL);
+			   socket_type_to_security_class(family, type,
+			   protocol), SOCKET__CREATE, NULL, NULL);
 
 out:
 	return err;
@@ -2938,7 +2947,7 @@ static void selinux_socket_post_create(s
 	isec = SOCK_INODE(sock)->i_security;
 
 	tsec = current->security;
-	isec->sclass = socket_type_to_security_class(family, type);
+	isec->sclass = socket_type_to_security_class(family, type, protocol);
 	isec->sid = kern ? SECINITSID_KERNEL : tsec->sid;
 
 	return;
@@ -3322,6 +3331,55 @@ static void selinux_sk_free_security(str
 	sk_free_security(sk);
 }
 
+static int selinux_nlmsg_perm(struct sock *sk, struct sk_buff *skb)
+{
+	int err = 0;
+	u32 perm;
+	struct nlmsghdr *nlh;
+	struct socket *sock = sk->sk_socket;
+	struct inode_security_struct *isec = SOCK_INODE(sock)->i_security;
+	
+	if (skb->len < NLMSG_SPACE(0)) {
+		err = -EINVAL;
+		goto out;
+	}
+	nlh = (struct nlmsghdr *)skb->data;
+	
+	err = selinux_nlmsg_lookup(isec->sclass, nlh->nlmsg_type, &perm);
+	if (err) {
+		/* Ignore */
+		if (err == -ENOENT)
+			err = 0;
+		goto out;
+	}
+
+	err = socket_has_perm(current, sock, perm);
+out:
+	return err;
+}
+
+static int selinux_netlink_send(struct sock *sk, struct sk_buff *skb)
+{
+	int err = 0;
+	
+	if (capable(CAP_NET_ADMIN))
+		cap_raise (NETLINK_CB (skb).eff_cap, CAP_NET_ADMIN);
+	else
+		NETLINK_CB(skb).eff_cap = 0;
+	
+	if (policydb_loaded_version >= POLICYDB_VERSION_NLCLASS)
+		err = selinux_nlmsg_perm(sk, skb);
+	
+	return err;
+}
+
+static int selinux_netlink_recv(struct sk_buff *skb)
+{
+	if (!cap_raised(NETLINK_CB(skb).eff_cap, CAP_NET_ADMIN))
+		return -EPERM;
+	return 0;
+}
+
 #ifdef CONFIG_NETFILTER
 
 static unsigned int selinux_ip_postroute_last(unsigned int hooknum,
diff -purN -X dontdiff linux-2.6.7-rc3-mm2.p/security/selinux/include/av_inherit.h linux-2.6.7-rc3-mm2.w/security/selinux/include/av_inherit.h
--- linux-2.6.7-rc3-mm2.p/security/selinux/include/av_inherit.h	2004-05-09 22:32:39.000000000 -0400
+++ linux-2.6.7-rc3-mm2.w/security/selinux/include/av_inherit.h	2004-06-15 22:04:12.466247888 -0400
@@ -29,6 +29,15 @@ static struct av_inherit av_inherit[] = 
    { SECCLASS_SEM, common_ipc_perm_to_string, 0x00000200UL },
    { SECCLASS_MSGQ, common_ipc_perm_to_string, 0x00000200UL },
    { SECCLASS_SHM, common_ipc_perm_to_string, 0x00000200UL },
+   { SECCLASS_NETLINK_ROUTE_SOCKET, common_socket_perm_to_string, 0x00400000UL },
+   { SECCLASS_NETLINK_FIREWALL_SOCKET, common_socket_perm_to_string, 0x00400000UL },
+   { SECCLASS_NETLINK_TCPDIAG_SOCKET, common_socket_perm_to_string, 0x00400000UL },
+   { SECCLASS_NETLINK_NFLOG_SOCKET, common_socket_perm_to_string, 0x00400000UL },
+   { SECCLASS_NETLINK_XFRM_SOCKET, common_socket_perm_to_string, 0x00400000UL },
+   { SECCLASS_NETLINK_SELINUX_SOCKET, common_socket_perm_to_string, 0x00400000UL },
+   { SECCLASS_NETLINK_AUDIT_SOCKET, common_socket_perm_to_string, 0x00400000UL },
+   { SECCLASS_NETLINK_IP6FW_SOCKET, common_socket_perm_to_string, 0x00400000UL },
+   { SECCLASS_NETLINK_DNRT_SOCKET, common_socket_perm_to_string, 0x00400000UL },
 };
 
 
diff -purN -X dontdiff linux-2.6.7-rc3-mm2.p/security/selinux/include/av_permissions.h linux-2.6.7-rc3-mm2.w/security/selinux/include/av_permissions.h
--- linux-2.6.7-rc3-mm2.p/security/selinux/include/av_permissions.h	2004-06-15 22:04:29.352680760 -0400
+++ linux-2.6.7-rc3-mm2.w/security/selinux/include/av_permissions.h	2004-06-15 22:04:12.468247584 -0400
@@ -653,5 +653,228 @@
 #define PAX__RANDEXEC                             0x00000010UL
 #define PAX__SEGMEXEC                             0x00000020UL
 
+#define NETLINK_ROUTE_SOCKET__IOCTL               0x00000001UL
+#define NETLINK_ROUTE_SOCKET__READ                0x00000002UL
+#define NETLINK_ROUTE_SOCKET__WRITE               0x00000004UL
+#define NETLINK_ROUTE_SOCKET__CREATE              0x00000008UL
+#define NETLINK_ROUTE_SOCKET__GETATTR             0x00000010UL
+#define NETLINK_ROUTE_SOCKET__SETATTR             0x00000020UL
+#define NETLINK_ROUTE_SOCKET__LOCK                0x00000040UL
+#define NETLINK_ROUTE_SOCKET__RELABELFROM         0x00000080UL
+#define NETLINK_ROUTE_SOCKET__RELABELTO           0x00000100UL
+#define NETLINK_ROUTE_SOCKET__APPEND              0x00000200UL
+#define NETLINK_ROUTE_SOCKET__BIND                0x00000400UL
+#define NETLINK_ROUTE_SOCKET__CONNECT             0x00000800UL
+#define NETLINK_ROUTE_SOCKET__LISTEN              0x00001000UL
+#define NETLINK_ROUTE_SOCKET__ACCEPT              0x00002000UL
+#define NETLINK_ROUTE_SOCKET__GETOPT              0x00004000UL
+#define NETLINK_ROUTE_SOCKET__SETOPT              0x00008000UL
+#define NETLINK_ROUTE_SOCKET__SHUTDOWN            0x00010000UL
+#define NETLINK_ROUTE_SOCKET__RECVFROM            0x00020000UL
+#define NETLINK_ROUTE_SOCKET__SENDTO              0x00040000UL
+#define NETLINK_ROUTE_SOCKET__RECV_MSG            0x00080000UL
+#define NETLINK_ROUTE_SOCKET__SEND_MSG            0x00100000UL
+#define NETLINK_ROUTE_SOCKET__NAME_BIND           0x00200000UL
+
+#define NETLINK_ROUTE_SOCKET__NLMSG_READ          0x00400000UL
+#define NETLINK_ROUTE_SOCKET__NLMSG_WRITE         0x00800000UL
+
+#define NETLINK_FIREWALL_SOCKET__IOCTL            0x00000001UL
+#define NETLINK_FIREWALL_SOCKET__READ             0x00000002UL
+#define NETLINK_FIREWALL_SOCKET__WRITE            0x00000004UL
+#define NETLINK_FIREWALL_SOCKET__CREATE           0x00000008UL
+#define NETLINK_FIREWALL_SOCKET__GETATTR          0x00000010UL
+#define NETLINK_FIREWALL_SOCKET__SETATTR          0x00000020UL
+#define NETLINK_FIREWALL_SOCKET__LOCK             0x00000040UL
+#define NETLINK_FIREWALL_SOCKET__RELABELFROM      0x00000080UL
+#define NETLINK_FIREWALL_SOCKET__RELABELTO        0x00000100UL
+#define NETLINK_FIREWALL_SOCKET__APPEND           0x00000200UL
+#define NETLINK_FIREWALL_SOCKET__BIND             0x00000400UL
+#define NETLINK_FIREWALL_SOCKET__CONNECT          0x00000800UL
+#define NETLINK_FIREWALL_SOCKET__LISTEN           0x00001000UL
+#define NETLINK_FIREWALL_SOCKET__ACCEPT           0x00002000UL
+#define NETLINK_FIREWALL_SOCKET__GETOPT           0x00004000UL
+#define NETLINK_FIREWALL_SOCKET__SETOPT           0x00008000UL
+#define NETLINK_FIREWALL_SOCKET__SHUTDOWN         0x00010000UL
+#define NETLINK_FIREWALL_SOCKET__RECVFROM         0x00020000UL
+#define NETLINK_FIREWALL_SOCKET__SENDTO           0x00040000UL
+#define NETLINK_FIREWALL_SOCKET__RECV_MSG         0x00080000UL
+#define NETLINK_FIREWALL_SOCKET__SEND_MSG         0x00100000UL
+#define NETLINK_FIREWALL_SOCKET__NAME_BIND        0x00200000UL
+
+#define NETLINK_FIREWALL_SOCKET__NLMSG_READ       0x00400000UL
+#define NETLINK_FIREWALL_SOCKET__NLMSG_WRITE      0x00800000UL
+
+#define NETLINK_TCPDIAG_SOCKET__IOCTL             0x00000001UL
+#define NETLINK_TCPDIAG_SOCKET__READ              0x00000002UL
+#define NETLINK_TCPDIAG_SOCKET__WRITE             0x00000004UL
+#define NETLINK_TCPDIAG_SOCKET__CREATE            0x00000008UL
+#define NETLINK_TCPDIAG_SOCKET__GETATTR           0x00000010UL
+#define NETLINK_TCPDIAG_SOCKET__SETATTR           0x00000020UL
+#define NETLINK_TCPDIAG_SOCKET__LOCK              0x00000040UL
+#define NETLINK_TCPDIAG_SOCKET__RELABELFROM       0x00000080UL
+#define NETLINK_TCPDIAG_SOCKET__RELABELTO         0x00000100UL
+#define NETLINK_TCPDIAG_SOCKET__APPEND            0x00000200UL
+#define NETLINK_TCPDIAG_SOCKET__BIND              0x00000400UL
+#define NETLINK_TCPDIAG_SOCKET__CONNECT           0x00000800UL
+#define NETLINK_TCPDIAG_SOCKET__LISTEN            0x00001000UL
+#define NETLINK_TCPDIAG_SOCKET__ACCEPT            0x00002000UL
+#define NETLINK_TCPDIAG_SOCKET__GETOPT            0x00004000UL
+#define NETLINK_TCPDIAG_SOCKET__SETOPT            0x00008000UL
+#define NETLINK_TCPDIAG_SOCKET__SHUTDOWN          0x00010000UL
+#define NETLINK_TCPDIAG_SOCKET__RECVFROM          0x00020000UL
+#define NETLINK_TCPDIAG_SOCKET__SENDTO            0x00040000UL
+#define NETLINK_TCPDIAG_SOCKET__RECV_MSG          0x00080000UL
+#define NETLINK_TCPDIAG_SOCKET__SEND_MSG          0x00100000UL
+#define NETLINK_TCPDIAG_SOCKET__NAME_BIND         0x00200000UL
+
+#define NETLINK_TCPDIAG_SOCKET__NLMSG_READ        0x00400000UL
+#define NETLINK_TCPDIAG_SOCKET__NLMSG_WRITE       0x00800000UL
+
+#define NETLINK_NFLOG_SOCKET__IOCTL               0x00000001UL
+#define NETLINK_NFLOG_SOCKET__READ                0x00000002UL
+#define NETLINK_NFLOG_SOCKET__WRITE               0x00000004UL
+#define NETLINK_NFLOG_SOCKET__CREATE              0x00000008UL
+#define NETLINK_NFLOG_SOCKET__GETATTR             0x00000010UL
+#define NETLINK_NFLOG_SOCKET__SETATTR             0x00000020UL
+#define NETLINK_NFLOG_SOCKET__LOCK                0x00000040UL
+#define NETLINK_NFLOG_SOCKET__RELABELFROM         0x00000080UL
+#define NETLINK_NFLOG_SOCKET__RELABELTO           0x00000100UL
+#define NETLINK_NFLOG_SOCKET__APPEND              0x00000200UL
+#define NETLINK_NFLOG_SOCKET__BIND                0x00000400UL
+#define NETLINK_NFLOG_SOCKET__CONNECT             0x00000800UL
+#define NETLINK_NFLOG_SOCKET__LISTEN              0x00001000UL
+#define NETLINK_NFLOG_SOCKET__ACCEPT              0x00002000UL
+#define NETLINK_NFLOG_SOCKET__GETOPT              0x00004000UL
+#define NETLINK_NFLOG_SOCKET__SETOPT              0x00008000UL
+#define NETLINK_NFLOG_SOCKET__SHUTDOWN            0x00010000UL
+#define NETLINK_NFLOG_SOCKET__RECVFROM            0x00020000UL
+#define NETLINK_NFLOG_SOCKET__SENDTO              0x00040000UL
+#define NETLINK_NFLOG_SOCKET__RECV_MSG            0x00080000UL
+#define NETLINK_NFLOG_SOCKET__SEND_MSG            0x00100000UL
+#define NETLINK_NFLOG_SOCKET__NAME_BIND           0x00200000UL
+
+#define NETLINK_XFRM_SOCKET__IOCTL                0x00000001UL
+#define NETLINK_XFRM_SOCKET__READ                 0x00000002UL
+#define NETLINK_XFRM_SOCKET__WRITE                0x00000004UL
+#define NETLINK_XFRM_SOCKET__CREATE               0x00000008UL
+#define NETLINK_XFRM_SOCKET__GETATTR              0x00000010UL
+#define NETLINK_XFRM_SOCKET__SETATTR              0x00000020UL
+#define NETLINK_XFRM_SOCKET__LOCK                 0x00000040UL
+#define NETLINK_XFRM_SOCKET__RELABELFROM          0x00000080UL
+#define NETLINK_XFRM_SOCKET__RELABELTO            0x00000100UL
+#define NETLINK_XFRM_SOCKET__APPEND               0x00000200UL
+#define NETLINK_XFRM_SOCKET__BIND                 0x00000400UL
+#define NETLINK_XFRM_SOCKET__CONNECT              0x00000800UL
+#define NETLINK_XFRM_SOCKET__LISTEN               0x00001000UL
+#define NETLINK_XFRM_SOCKET__ACCEPT               0x00002000UL
+#define NETLINK_XFRM_SOCKET__GETOPT               0x00004000UL
+#define NETLINK_XFRM_SOCKET__SETOPT               0x00008000UL
+#define NETLINK_XFRM_SOCKET__SHUTDOWN             0x00010000UL
+#define NETLINK_XFRM_SOCKET__RECVFROM             0x00020000UL
+#define NETLINK_XFRM_SOCKET__SENDTO               0x00040000UL
+#define NETLINK_XFRM_SOCKET__RECV_MSG             0x00080000UL
+#define NETLINK_XFRM_SOCKET__SEND_MSG             0x00100000UL
+#define NETLINK_XFRM_SOCKET__NAME_BIND            0x00200000UL
+
+#define NETLINK_XFRM_SOCKET__NLMSG_READ           0x00400000UL
+#define NETLINK_XFRM_SOCKET__NLMSG_WRITE          0x00800000UL
+
+#define NETLINK_SELINUX_SOCKET__IOCTL             0x00000001UL
+#define NETLINK_SELINUX_SOCKET__READ              0x00000002UL
+#define NETLINK_SELINUX_SOCKET__WRITE             0x00000004UL
+#define NETLINK_SELINUX_SOCKET__CREATE            0x00000008UL
+#define NETLINK_SELINUX_SOCKET__GETATTR           0x00000010UL
+#define NETLINK_SELINUX_SOCKET__SETATTR           0x00000020UL
+#define NETLINK_SELINUX_SOCKET__LOCK              0x00000040UL
+#define NETLINK_SELINUX_SOCKET__RELABELFROM       0x00000080UL
+#define NETLINK_SELINUX_SOCKET__RELABELTO         0x00000100UL
+#define NETLINK_SELINUX_SOCKET__APPEND            0x00000200UL
+#define NETLINK_SELINUX_SOCKET__BIND              0x00000400UL
+#define NETLINK_SELINUX_SOCKET__CONNECT           0x00000800UL
+#define NETLINK_SELINUX_SOCKET__LISTEN            0x00001000UL
+#define NETLINK_SELINUX_SOCKET__ACCEPT            0x00002000UL
+#define NETLINK_SELINUX_SOCKET__GETOPT            0x00004000UL
+#define NETLINK_SELINUX_SOCKET__SETOPT            0x00008000UL
+#define NETLINK_SELINUX_SOCKET__SHUTDOWN          0x00010000UL
+#define NETLINK_SELINUX_SOCKET__RECVFROM          0x00020000UL
+#define NETLINK_SELINUX_SOCKET__SENDTO            0x00040000UL
+#define NETLINK_SELINUX_SOCKET__RECV_MSG          0x00080000UL
+#define NETLINK_SELINUX_SOCKET__SEND_MSG          0x00100000UL
+#define NETLINK_SELINUX_SOCKET__NAME_BIND         0x00200000UL
+
+#define NETLINK_AUDIT_SOCKET__IOCTL               0x00000001UL
+#define NETLINK_AUDIT_SOCKET__READ                0x00000002UL
+#define NETLINK_AUDIT_SOCKET__WRITE               0x00000004UL
+#define NETLINK_AUDIT_SOCKET__CREATE              0x00000008UL
+#define NETLINK_AUDIT_SOCKET__GETATTR             0x00000010UL
+#define NETLINK_AUDIT_SOCKET__SETATTR             0x00000020UL
+#define NETLINK_AUDIT_SOCKET__LOCK                0x00000040UL
+#define NETLINK_AUDIT_SOCKET__RELABELFROM         0x00000080UL
+#define NETLINK_AUDIT_SOCKET__RELABELTO           0x00000100UL
+#define NETLINK_AUDIT_SOCKET__APPEND              0x00000200UL
+#define NETLINK_AUDIT_SOCKET__BIND                0x00000400UL
+#define NETLINK_AUDIT_SOCKET__CONNECT             0x00000800UL
+#define NETLINK_AUDIT_SOCKET__LISTEN              0x00001000UL
+#define NETLINK_AUDIT_SOCKET__ACCEPT              0x00002000UL
+#define NETLINK_AUDIT_SOCKET__GETOPT              0x00004000UL
+#define NETLINK_AUDIT_SOCKET__SETOPT              0x00008000UL
+#define NETLINK_AUDIT_SOCKET__SHUTDOWN            0x00010000UL
+#define NETLINK_AUDIT_SOCKET__RECVFROM            0x00020000UL
+#define NETLINK_AUDIT_SOCKET__SENDTO              0x00040000UL
+#define NETLINK_AUDIT_SOCKET__RECV_MSG            0x00080000UL
+#define NETLINK_AUDIT_SOCKET__SEND_MSG            0x00100000UL
+#define NETLINK_AUDIT_SOCKET__NAME_BIND           0x00200000UL
+
+#define NETLINK_AUDIT_SOCKET__NLMSG_READ          0x00400000UL
+#define NETLINK_AUDIT_SOCKET__NLMSG_WRITE         0x00800000UL
+
+#define NETLINK_IP6FW_SOCKET__IOCTL               0x00000001UL
+#define NETLINK_IP6FW_SOCKET__READ                0x00000002UL
+#define NETLINK_IP6FW_SOCKET__WRITE               0x00000004UL
+#define NETLINK_IP6FW_SOCKET__CREATE              0x00000008UL
+#define NETLINK_IP6FW_SOCKET__GETATTR             0x00000010UL
+#define NETLINK_IP6FW_SOCKET__SETATTR             0x00000020UL
+#define NETLINK_IP6FW_SOCKET__LOCK                0x00000040UL
+#define NETLINK_IP6FW_SOCKET__RELABELFROM         0x00000080UL
+#define NETLINK_IP6FW_SOCKET__RELABELTO           0x00000100UL
+#define NETLINK_IP6FW_SOCKET__APPEND              0x00000200UL
+#define NETLINK_IP6FW_SOCKET__BIND                0x00000400UL
+#define NETLINK_IP6FW_SOCKET__CONNECT             0x00000800UL
+#define NETLINK_IP6FW_SOCKET__LISTEN              0x00001000UL
+#define NETLINK_IP6FW_SOCKET__ACCEPT              0x00002000UL
+#define NETLINK_IP6FW_SOCKET__GETOPT              0x00004000UL
+#define NETLINK_IP6FW_SOCKET__SETOPT              0x00008000UL
+#define NETLINK_IP6FW_SOCKET__SHUTDOWN            0x00010000UL
+#define NETLINK_IP6FW_SOCKET__RECVFROM            0x00020000UL
+#define NETLINK_IP6FW_SOCKET__SENDTO              0x00040000UL
+#define NETLINK_IP6FW_SOCKET__RECV_MSG            0x00080000UL
+#define NETLINK_IP6FW_SOCKET__SEND_MSG            0x00100000UL
+#define NETLINK_IP6FW_SOCKET__NAME_BIND           0x00200000UL
+
+#define NETLINK_IP6FW_SOCKET__NLMSG_READ          0x00400000UL
+#define NETLINK_IP6FW_SOCKET__NLMSG_WRITE         0x00800000UL
+
+#define NETLINK_DNRT_SOCKET__IOCTL                0x00000001UL
+#define NETLINK_DNRT_SOCKET__READ                 0x00000002UL
+#define NETLINK_DNRT_SOCKET__WRITE                0x00000004UL
+#define NETLINK_DNRT_SOCKET__CREATE               0x00000008UL
+#define NETLINK_DNRT_SOCKET__GETATTR              0x00000010UL
+#define NETLINK_DNRT_SOCKET__SETATTR              0x00000020UL
+#define NETLINK_DNRT_SOCKET__LOCK                 0x00000040UL
+#define NETLINK_DNRT_SOCKET__RELABELFROM          0x00000080UL
+#define NETLINK_DNRT_SOCKET__RELABELTO            0x00000100UL
+#define NETLINK_DNRT_SOCKET__APPEND               0x00000200UL
+#define NETLINK_DNRT_SOCKET__BIND                 0x00000400UL
+#define NETLINK_DNRT_SOCKET__CONNECT              0x00000800UL
+#define NETLINK_DNRT_SOCKET__LISTEN               0x00001000UL
+#define NETLINK_DNRT_SOCKET__ACCEPT               0x00002000UL
+#define NETLINK_DNRT_SOCKET__GETOPT               0x00004000UL
+#define NETLINK_DNRT_SOCKET__SETOPT               0x00008000UL
+#define NETLINK_DNRT_SOCKET__SHUTDOWN             0x00010000UL
+#define NETLINK_DNRT_SOCKET__RECVFROM             0x00020000UL
+#define NETLINK_DNRT_SOCKET__SENDTO               0x00040000UL
+#define NETLINK_DNRT_SOCKET__RECV_MSG             0x00080000UL
+#define NETLINK_DNRT_SOCKET__SEND_MSG             0x00100000UL
 
 /* FLASK */
diff -purN -X dontdiff linux-2.6.7-rc3-mm2.p/security/selinux/include/av_perm_to_string.h linux-2.6.7-rc3-mm2.w/security/selinux/include/av_perm_to_string.h
--- linux-2.6.7-rc3-mm2.p/security/selinux/include/av_perm_to_string.h	2004-06-15 22:04:29.337683040 -0400
+++ linux-2.6.7-rc3-mm2.w/security/selinux/include/av_perm_to_string.h	2004-06-15 22:04:12.514240592 -0400
@@ -207,6 +207,18 @@ static struct av_perm_to_string av_perm_
    { SECCLASS_PAX, PAX__RANDMMAP, "randmmap" },
    { SECCLASS_PAX, PAX__RANDEXEC, "randexec" },
    { SECCLASS_PAX, PAX__SEGMEXEC, "segmexec" },
+   { SECCLASS_NETLINK_ROUTE_SOCKET, NETLINK_ROUTE_SOCKET__NLMSG_READ, "nlmsg_read" },
+   { SECCLASS_NETLINK_ROUTE_SOCKET, NETLINK_ROUTE_SOCKET__NLMSG_WRITE, "nlmsg_write" },
+   { SECCLASS_NETLINK_FIREWALL_SOCKET, NETLINK_FIREWALL_SOCKET__NLMSG_READ, "nlmsg_read" },
+   { SECCLASS_NETLINK_FIREWALL_SOCKET, NETLINK_FIREWALL_SOCKET__NLMSG_WRITE, "nlmsg_write" },
+   { SECCLASS_NETLINK_TCPDIAG_SOCKET, NETLINK_TCPDIAG_SOCKET__NLMSG_READ, "nlmsg_read" },
+   { SECCLASS_NETLINK_TCPDIAG_SOCKET, NETLINK_TCPDIAG_SOCKET__NLMSG_WRITE, "nlmsg_write" },
+   { SECCLASS_NETLINK_XFRM_SOCKET, NETLINK_XFRM_SOCKET__NLMSG_READ, "nlmsg_read" },
+   { SECCLASS_NETLINK_XFRM_SOCKET, NETLINK_XFRM_SOCKET__NLMSG_WRITE, "nlmsg_write" },
+   { SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_READ, "nlmsg_read" },
+   { SECCLASS_NETLINK_AUDIT_SOCKET, NETLINK_AUDIT_SOCKET__NLMSG_WRITE, "nlmsg_write" },
+   { SECCLASS_NETLINK_IP6FW_SOCKET, NETLINK_IP6FW_SOCKET__NLMSG_READ, "nlmsg_read" },
+   { SECCLASS_NETLINK_IP6FW_SOCKET, NETLINK_IP6FW_SOCKET__NLMSG_WRITE, "nlmsg_write" },
 };
 
 
diff -purN -X dontdiff linux-2.6.7-rc3-mm2.p/security/selinux/include/class_to_string.h linux-2.6.7-rc3-mm2.w/security/selinux/include/class_to_string.h
--- linux-2.6.7-rc3-mm2.p/security/selinux/include/class_to_string.h	2004-06-15 22:04:29.353680608 -0400
+++ linux-2.6.7-rc3-mm2.w/security/selinux/include/class_to_string.h	2004-06-15 22:04:13.502090416 -0400
@@ -47,5 +47,14 @@ static char *class_to_string[] =
     "xserver",
     "xextension",
     "pax",
+    "netlink_route_socket",
+    "netlink_firewall_socket",
+    "netlink_tcpdiag_socket",
+    "netlink_nflog_socket",
+    "netlink_xfrm_socket",
+    "netlink_selinux_socket",
+    "netlink_audit_socket",
+    "netlink_ip6fw_socket",
+    "netlink_dnrt_socket",
 };
 
diff -purN -X dontdiff linux-2.6.7-rc3-mm2.p/security/selinux/include/flask.h linux-2.6.7-rc3-mm2.w/security/selinux/include/flask.h
--- linux-2.6.7-rc3-mm2.p/security/selinux/include/flask.h	2004-06-15 22:04:29.354680456 -0400
+++ linux-2.6.7-rc3-mm2.w/security/selinux/include/flask.h	2004-06-15 22:04:13.503090264 -0400
@@ -47,6 +47,15 @@
 #define SECCLASS_XSERVER                                 40
 #define SECCLASS_XEXTENSION                              41
 #define SECCLASS_PAX                                     42
+#define SECCLASS_NETLINK_ROUTE_SOCKET                    43
+#define SECCLASS_NETLINK_FIREWALL_SOCKET                 44
+#define SECCLASS_NETLINK_TCPDIAG_SOCKET                  45
+#define SECCLASS_NETLINK_NFLOG_SOCKET                    46
+#define SECCLASS_NETLINK_XFRM_SOCKET                     47
+#define SECCLASS_NETLINK_SELINUX_SOCKET                  48
+#define SECCLASS_NETLINK_AUDIT_SOCKET                    49
+#define SECCLASS_NETLINK_IP6FW_SOCKET                    50
+#define SECCLASS_NETLINK_DNRT_SOCKET                     51
 
 /*
  * Security identifier indices for initial entities
diff -purN -X dontdiff linux-2.6.7-rc3-mm2.p/security/selinux/include/security.h linux-2.6.7-rc3-mm2.w/security/selinux/include/security.h
--- linux-2.6.7-rc3-mm2.p/security/selinux/include/security.h	2004-05-09 22:31:59.000000000 -0400
+++ linux-2.6.7-rc3-mm2.w/security/selinux/include/security.h	2004-06-15 22:04:13.509089352 -0400
@@ -17,13 +17,14 @@
 #define SELINUX_MAGIC 0xf97cff8c
 
 /* Identify specific policy version changes */
-#define POLICYDB_VERSION_BASE  15
-#define POLICYDB_VERSION_BOOL  16
-#define POLICYDB_VERSION_IPV6  17
+#define POLICYDB_VERSION_BASE		15
+#define POLICYDB_VERSION_BOOL		16
+#define POLICYDB_VERSION_IPV6		17
+#define POLICYDB_VERSION_NLCLASS	18
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_IPV6
+#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_NLCLASS
 
 #ifdef CONFIG_SECURITY_SELINUX_BOOTPARAM
 extern int selinux_enabled;
diff -purN -X dontdiff linux-2.6.7-rc3-mm2.p/security/selinux/Makefile linux-2.6.7-rc3-mm2.w/security/selinux/Makefile
--- linux-2.6.7-rc3-mm2.p/security/selinux/Makefile	2004-05-09 22:31:56.000000000 -0400
+++ linux-2.6.7-rc3-mm2.w/security/selinux/Makefile	2004-06-15 22:04:13.538084944 -0400
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_SECURITY_SELINUX) := selinux.o ss/
 
-selinux-y := avc.o hooks.o selinuxfs.o netlink.o
+selinux-y := avc.o hooks.o selinuxfs.o netlink.o nlmsgtab.o
 
 selinux-$(CONFIG_SECURITY_NETWORK) += netif.o
 
diff -purN -X dontdiff linux-2.6.7-rc3-mm2.p/security/selinux/nlmsgtab.c linux-2.6.7-rc3-mm2.w/security/selinux/nlmsgtab.c
--- linux-2.6.7-rc3-mm2.p/security/selinux/nlmsgtab.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.7-rc3-mm2.w/security/selinux/nlmsgtab.c	2004-06-15 22:04:13.539084792 -0400
@@ -0,0 +1,153 @@
+/*
+ * Netlink message type permission tables, for user generated messages.
+ *
+ * Author: James Morris <jmorris@redhat.com>
+ *
+ * Copyright (C) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2,
+ * as published by the Free Software Foundation.
+ */
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/skbuff.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
+#include <linux/if.h>
+#include <linux/netfilter_ipv4/ip_queue.h>
+#include <linux/tcp_diag.h>
+#include <linux/xfrm.h>
+#include <linux/audit.h>
+
+#include "flask.h"
+#include "av_permissions.h"
+
+struct nlmsg_perm
+{
+	u16	nlmsg_type;
+	u32	perm;
+};
+
+static struct nlmsg_perm nlmsg_route_perms[] =
+{
+	{ RTM_NEWLINK,		NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_DELLINK,		NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_GETLINK,		NETLINK_ROUTE_SOCKET__NLMSG_READ  },
+	{ RTM_SETLINK,		NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_NEWADDR,		NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_DELADDR,		NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_GETADDR,		NETLINK_ROUTE_SOCKET__NLMSG_READ  },
+	{ RTM_NEWROUTE,		NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_DELROUTE,		NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_GETROUTE,		NETLINK_ROUTE_SOCKET__NLMSG_READ  },
+	{ RTM_NEWNEIGH,		NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_DELNEIGH,		NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_GETNEIGH,		NETLINK_ROUTE_SOCKET__NLMSG_READ  },
+	{ RTM_NEWRULE,		NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_DELRULE,		NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_GETRULE,		NETLINK_ROUTE_SOCKET__NLMSG_READ  },
+	{ RTM_NEWQDISC,		NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_DELQDISC,		NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_GETQDISC,		NETLINK_ROUTE_SOCKET__NLMSG_READ  },
+	{ RTM_NEWTCLASS,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_DELTCLASS,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_GETTCLASS,	NETLINK_ROUTE_SOCKET__NLMSG_READ  },
+	{ RTM_NEWTFILTER,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_DELTFILTER,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_GETTFILTER,	NETLINK_ROUTE_SOCKET__NLMSG_READ  },
+	{ RTM_NEWPREFIX,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_GETPREFIX,	NETLINK_ROUTE_SOCKET__NLMSG_READ  },
+	{ RTM_GETMULTICAST,	NETLINK_ROUTE_SOCKET__NLMSG_READ  },
+	{ RTM_GETANYCAST,	NETLINK_ROUTE_SOCKET__NLMSG_READ  },
+};
+
+static struct nlmsg_perm nlmsg_firewall_perms[] =
+{
+	{ IPQM_MODE,		NETLINK_FIREWALL_SOCKET__NLMSG_WRITE },
+	{ IPQM_VERDICT,		NETLINK_FIREWALL_SOCKET__NLMSG_WRITE },
+};
+
+static struct nlmsg_perm nlmsg_tcpdiag_perms[] =
+{
+	{ TCPDIAG_GETSOCK,	NETLINK_TCPDIAG_SOCKET__NLMSG_READ },
+};
+
+static struct nlmsg_perm nlmsg_xfrm_perms[] =
+{
+	{ XFRM_MSG_NEWSA,	NETLINK_XFRM_SOCKET__NLMSG_WRITE },
+	{ XFRM_MSG_DELSA,	NETLINK_XFRM_SOCKET__NLMSG_WRITE },
+	{ XFRM_MSG_GETSA,	NETLINK_XFRM_SOCKET__NLMSG_READ  },
+	{ XFRM_MSG_NEWPOLICY,	NETLINK_XFRM_SOCKET__NLMSG_WRITE },
+	{ XFRM_MSG_DELPOLICY,	NETLINK_XFRM_SOCKET__NLMSG_WRITE },
+	{ XFRM_MSG_GETPOLICY,	NETLINK_XFRM_SOCKET__NLMSG_READ  },
+	{ XFRM_MSG_ALLOCSPI,	NETLINK_XFRM_SOCKET__NLMSG_WRITE },
+	{ XFRM_MSG_UPDPOLICY,	NETLINK_XFRM_SOCKET__NLMSG_WRITE },
+	{ XFRM_MSG_UPDSA,	NETLINK_XFRM_SOCKET__NLMSG_WRITE },
+};
+
+static struct nlmsg_perm nlmsg_audit_perms[] =
+{
+	{ AUDIT_GET,		NETLINK_AUDIT_SOCKET__NLMSG_READ  },
+	{ AUDIT_SET,		NETLINK_AUDIT_SOCKET__NLMSG_WRITE },
+	{ AUDIT_LIST,		NETLINK_AUDIT_SOCKET__NLMSG_READ  },
+	{ AUDIT_ADD,		NETLINK_AUDIT_SOCKET__NLMSG_WRITE },
+	{ AUDIT_DEL,		NETLINK_AUDIT_SOCKET__NLMSG_WRITE },
+	{ AUDIT_USER,		NETLINK_AUDIT_SOCKET__NLMSG_WRITE },
+	{ AUDIT_LOGIN,		NETLINK_AUDIT_SOCKET__NLMSG_WRITE },
+};
+
+
+static int nlmsg_perm(u16 nlmsg_type, u32 *perm, struct nlmsg_perm *tab, size_t tabsize)
+{
+	int i, err = -EINVAL;
+
+	for (i = 0; i < tabsize/sizeof(struct nlmsg_perm); i++)
+		if (nlmsg_type == tab[i].nlmsg_type) {
+			*perm = tab[i].perm;
+			err = 0;
+			break;
+		}
+	
+	return err;
+}
+
+int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
+{
+	int err = 0;
+	
+	switch (sclass) {
+	case SECCLASS_NETLINK_ROUTE_SOCKET:
+		err = nlmsg_perm(nlmsg_type, perm, nlmsg_route_perms,
+				 sizeof(nlmsg_route_perms));
+		break;
+
+	case SECCLASS_NETLINK_FIREWALL_SOCKET:
+	case NETLINK_IP6_FW:
+		err = nlmsg_perm(nlmsg_type, perm, nlmsg_firewall_perms,
+				 sizeof(nlmsg_firewall_perms));
+		break;
+	
+	case SECCLASS_NETLINK_TCPDIAG_SOCKET:
+		err = nlmsg_perm(nlmsg_type, perm, nlmsg_tcpdiag_perms,
+				 sizeof(nlmsg_tcpdiag_perms));
+		break;
+		
+	case SECCLASS_NETLINK_XFRM_SOCKET:
+		err = nlmsg_perm(nlmsg_type, perm, nlmsg_xfrm_perms,
+				 sizeof(nlmsg_xfrm_perms));
+		break;
+
+	case SECCLASS_NETLINK_AUDIT_SOCKET:
+		err = nlmsg_perm(nlmsg_type, perm, nlmsg_audit_perms,
+				 sizeof(nlmsg_audit_perms));
+		break;
+
+	/* No messaging from userspace, or class unknown/unhandled */
+	default:
+		err = -ENOENT;
+		break;
+	}
+	
+	return err;
+}
diff -purN -X dontdiff linux-2.6.7-rc3-mm2.p/security/selinux/ss/policydb.c linux-2.6.7-rc3-mm2.w/security/selinux/ss/policydb.c
--- linux-2.6.7-rc3-mm2.p/security/selinux/ss/policydb.c	2004-05-09 22:32:28.000000000 -0400
+++ linux-2.6.7-rc3-mm2.w/security/selinux/ss/policydb.c	2004-06-15 22:04:13.575079320 -0400
@@ -38,6 +38,8 @@ static char *symtab_name[SYM_NUM] = {
 };
 #endif
 
+int policydb_loaded_version;
+
 static unsigned int symtab_sizes[SYM_NUM] = {
 	2,
 	32,
@@ -71,6 +73,11 @@ static struct policydb_compat_info polic
 		.sym_num        = SYM_NUM,
 		.ocon_num       = OCON_NUM,
 	},
+	{
+		.version        = POLICYDB_VERSION_NLCLASS,
+		.sym_num        = SYM_NUM,
+		.ocon_num       = OCON_NUM,
+	},
 };
 
 static struct policydb_compat_info *policydb_lookup_compat(int version)
@@ -1125,7 +1132,7 @@ int policydb_read(struct policydb *p, vo
 	struct role_trans *tr, *ltr;
 	struct ocontext *l, *c, *newc;
 	struct genfs *genfs_p, *genfs, *newgenfs;
-	int i, j, rc, r_policyvers;
+	int i, j, rc, r_policyvers = 0;
 	u32 *buf, len, len2, config, nprim, nel, nel2;
 	char *policydb_str;
 	struct policydb_compat_info *info;
@@ -1546,6 +1553,7 @@ int policydb_read(struct policydb *p, vo
 	if (rc)
 		goto bad;
 out:
+	policydb_loaded_version = r_policyvers;
 	return rc;
 bad_newc:
 	ocontext_destroy(newc,OCON_FSUSE);
diff -purN -X dontdiff linux-2.6.7-rc3-mm2.p/security/selinux/ss/services.c linux-2.6.7-rc3-mm2.w/security/selinux/ss/services.c
--- linux-2.6.7-rc3-mm2.p/security/selinux/ss/services.c	2004-06-07 18:54:14.000000000 -0400
+++ linux-2.6.7-rc3-mm2.w/security/selinux/ss/services.c	2004-06-15 22:04:13.584077952 -0400
@@ -40,6 +40,7 @@
 #include "mls.h"
 
 extern void selnl_notify_policyload(u32 seqno);
+extern int policydb_loaded_version;
 
 static rwlock_t policy_rwlock = RW_LOCK_UNLOCKED;
 #define POLICY_RDLOCK read_lock(&policy_rwlock)
@@ -203,6 +204,17 @@ static int context_struct_compute_av(str
 	struct avtab_datum *avdatum;
 	struct class_datum *tclass_datum;
 
+	/*
+	 * Remap extended Netlink classes for old policy versions.
+	 * Do this here rather than socket_type_to_security_class()
+	 * in case a newer policy version is loaded, allowing sockets
+	 * to remain in the correct class.
+	 */
+	if (policydb_loaded_version < POLICYDB_VERSION_NLCLASS)
+		if (tclass >= SECCLASS_NETLINK_ROUTE_SOCKET &&
+		    tclass <= SECCLASS_NETLINK_DNRT_SOCKET)
+			tclass = SECCLASS_NETLINK_SOCKET;
+
 	if (!tclass || tclass > policydb.p_classes.nprim) {
 		printk(KERN_ERR "security_compute_av:  unrecognized class %d\n",
 		       tclass);


