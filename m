Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265650AbUFOOTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265650AbUFOOTY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 10:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265654AbUFOOTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 10:19:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12770 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265650AbUFOOTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 10:19:07 -0400
Date: Tue, 15 Jun 2004 10:18:59 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: [SELINUX/NET] Fix sock_orphan race.
Message-ID: <Xine.LNX.4.44.0406151012030.27745-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes a race between sock_orphan() and
selinux_socket_sock_rcv_skb() which can lead to a null pointer deref oops
under heavy load.  The sk_callback_lock is used in the patch to 
synchronize access to the incoming socket's inode security state.

This patch has been under test in the Fedora kernel for over a month 
without incident.

Please apply.

Author:  Stephen Smalley <sds@epoch.ncsc.mil>
Signed-off-by: James Morris <jmorris@redhat.com>


diff -urNp linux-1130/security/selinux/hooks.c linux-10000/security/selinux/hooks.c
--- linux-1130/security/selinux/hooks.c
+++ linux-10000/security/selinux/hooks.c
@@ -3174,12 +3174,12 @@ static int selinux_socket_sock_rcv_skb(s
 	char *addrp;
 	int len, err = 0;
 	u32 netif_perm, node_perm, node_sid, recv_perm = 0;
+	u32 sock_sid = 0;
+	u16 sock_class = 0;
 	struct socket *sock;
-	struct inode *inode;
 	struct net_device *dev;
 	struct sel_netif *netif;
 	struct netif_security_struct *nsec;
-	struct inode_security_struct *isec;
 	struct avc_audit_data ad;
 
 	family = sk->sk_family;
@@ -3190,15 +3190,21 @@ static int selinux_socket_sock_rcv_skb(s
 	if (family == PF_INET6 && skb->protocol == ntohs(ETH_P_IP))
 		family = PF_INET;
 
-	sock = sk->sk_socket;
-	
-	/* TCP control messages don't always have a socket. */
-	if (!sock)
-		goto out;
-
-	inode = SOCK_INODE(sock);
-	if (!inode)
-		goto out;
+ 	read_lock_bh(&sk->sk_callback_lock);
+ 	sock = sk->sk_socket;
+ 	if (sock) {
+ 		struct inode *inode;
+ 		inode = SOCK_INODE(sock);
+ 		if (inode) {
+ 			struct inode_security_struct *isec;
+ 			isec = inode->i_security;
+ 			sock_sid = isec->sid;
+ 			sock_class = isec->sclass;
+ 		}
+ 	}
+ 	read_unlock_bh(&sk->sk_callback_lock);
+ 	if (!sock_sid)
+  		goto out;
 
 	dev = skb->dev;
 	if (!dev)
@@ -3211,9 +3217,8 @@ static int selinux_socket_sock_rcv_skb(s
 	}
 	
 	nsec = &netif->nsec;
-	isec = inode->i_security;
 
-	switch (isec->sclass) {
+	switch (sock_class) {
 	case SECCLASS_UDP_SOCKET:
 		netif_perm = NETIF__UDP_RECV;
 		node_perm = NODE__UDP_RECV;
@@ -3242,7 +3247,7 @@ static int selinux_socket_sock_rcv_skb(s
 		goto out;
 	}
 
-	err = avc_has_perm(isec->sid, nsec->if_sid, SECCLASS_NETIF,
+	err = avc_has_perm(sock_sid, nsec->if_sid, SECCLASS_NETIF,
 	                   netif_perm, &nsec->avcr, &ad);
 	sel_netif_put(netif);
 	if (err)
@@ -3253,7 +3258,7 @@ static int selinux_socket_sock_rcv_skb(s
 	if (err)
 		goto out;
 	
-	err = avc_has_perm(isec->sid, node_sid, SECCLASS_NODE, node_perm, NULL, &ad);
+	err = avc_has_perm(sock_sid, node_sid, SECCLASS_NODE, node_perm, NULL, &ad);
 	if (err)
 		goto out;
 
@@ -3267,7 +3272,7 @@ static int selinux_socket_sock_rcv_skb(s
 		if (err)
 			goto out;
 
-		err = avc_has_perm(isec->sid, port_sid, isec->sclass,
+		err = avc_has_perm(sock_sid, port_sid, sock_class,
 		                   recv_perm, NULL, &ad);
 	}
 out:	


