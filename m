Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265139AbUAMSgj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 13:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbUAMSgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 13:36:39 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:33084 "EHLO
	thoron.boston.redhat.com") by vger.kernel.org with ESMTP
	id S265140AbUAMSbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 13:31:39 -0500
Date: Tue, 13 Jan 2004 13:31:27 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, <selinux@tycho.nsa.gov>,
       Stephen Smalley <sds@epoch.ncsc.mil>
Subject: [PATCH][SELINUX] 2/2 Add SEND_MSG and RECV_MSG controls
In-Reply-To: <Xine.LNX.4.44.0401131318410.6829@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0401131326240.6829-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements two new access controls for SELinux: SEND_MSG and 
RECV_MSG, providing mediation of network packets based on destination 
port (IPv4 only at this stage).

Please apply.

 security/selinux/hooks.c |   47 +++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 43 insertions(+), 4 deletions(-)


diff -urN -X dontdiff linux-2.6.1-rc3.pending/security/selinux/hooks.c linux-2.6.1-rc3.w1/security/selinux/hooks.c
--- linux-2.6.1-rc3.pending/security/selinux/hooks.c	2004-01-08 13:56:32.000000000 -0500
+++ linux-2.6.1-rc3.w1/security/selinux/hooks.c	2004-01-08 14:37:03.251274816 -0500
@@ -2694,7 +2694,7 @@
 static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
 	int err = 0;
-	u32 netif_perm, node_perm, node_sid;
+	u32 netif_perm, node_perm, node_sid, recv_perm = 0;
 	struct socket *sock;
 	struct inode *inode;
 	struct net_device *dev;
@@ -2735,11 +2735,13 @@
 	case SECCLASS_UDP_SOCKET:
 		netif_perm = NETIF__UDP_RECV;
 		node_perm = NODE__UDP_RECV;
+		recv_perm = UDP_SOCKET__RECV_MSG;
 		break;
 	
 	case SECCLASS_TCP_SOCKET:
 		netif_perm = NETIF__TCP_RECV;
 		node_perm = NODE__TCP_RECV;
+		recv_perm = TCP_SOCKET__RECV_MSG;
 		break;
 	
 	default:
@@ -2766,6 +2768,20 @@
 	
 	err = avc_has_perm(isec->sid, node_sid, SECCLASS_NODE, node_perm, NULL, &ad);
 
+	if (recv_perm) {
+		u32 port_sid;
+
+		/* Fixme: make this more efficient */
+		err = security_port_sid(sk->sk_family, sk->sk_type,
+		                        sk->sk_protocol, ntohs(ad.u.net.dport),
+		                        &port_sid);
+		if (err)
+			goto out;
+
+		err = avc_has_perm(isec->sid, port_sid, isec->sclass,
+		                   recv_perm, NULL, &ad);
+	}
+
 out:	
 	return err;
 }
@@ -2826,7 +2842,8 @@
                                               int (*okfn)(struct sk_buff *))
 {
 	int err = NF_ACCEPT;
-	u32 netif_perm, node_perm, node_sid;
+	u32 netif_perm, node_perm, node_sid, send_perm = 0;
+	struct sock *sk;
 	struct socket *sock;
 	struct inode *inode;
 	struct iphdr *iph;
@@ -2837,10 +2854,11 @@
 	struct avc_audit_data ad;
 	struct net_device *dev = (struct net_device *)out;
 	
-	if (!skb->sk)
+	sk = skb->sk;
+	if (!sk)
 		goto out;
 		
-	sock = skb->sk->sk_socket;
+	sock = sk->sk_socket;
 	if (!sock)
 		goto out;
 		
@@ -2861,11 +2879,13 @@
 	case SECCLASS_UDP_SOCKET:
 		netif_perm = NETIF__UDP_SEND;
 		node_perm = NODE__UDP_SEND;
+		send_perm = UDP_SOCKET__SEND_MSG;
 		break;
 	
 	case SECCLASS_TCP_SOCKET:
 		netif_perm = NETIF__TCP_SEND;
 		node_perm = NODE__TCP_SEND;
+		send_perm = TCP_SOCKET__SEND_MSG;
 		break;
 	
 	default:
@@ -2892,6 +2912,25 @@
 	
 	err = avc_has_perm(isec->sid, node_sid, SECCLASS_NODE,
 	                   node_perm, NULL, &ad) ? NF_DROP : NF_ACCEPT;
+	if (err != NF_ACCEPT)
+		goto out;
+
+	if (send_perm) {
+		u32 port_sid;
+		
+		/* Fixme: make this more efficient */
+		err = security_port_sid(sk->sk_family,
+		                        sk->sk_type,
+		                        sk->sk_protocol,
+		                        ntohs(ad.u.net.dport),
+		                        &port_sid) ? NF_DROP : NF_ACCEPT;
+		if (err != NF_ACCEPT)
+			goto out;
+
+		err = avc_has_perm(isec->sid, port_sid, isec->sclass,
+		                   send_perm, NULL, &ad) ? NF_DROP : NF_ACCEPT;
+	}
+
 out:
 	return err;
 }


