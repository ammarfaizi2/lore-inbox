Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUAIPkO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 10:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbUAIPkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 10:40:14 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:45939 "EHLO
	thoron.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261931AbUAIPjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 10:39:47 -0500
Date: Fri, 9 Jan 2004 10:39:39 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>,
       <selinux@tycho.nsa.gov>
Subject: [PATCH][SELINUX] 3/7 Add node controls
In-Reply-To: <Xine.LNX.4.44.0401091012460.21309@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0401091017250.21309-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.1-mm2 adds 'node' access controls for SELinux,
which allows network traffic to be controlled on the basis of remote 
address.
  
Like the previous patch, similar functionality was present in earlier
SELinux implementations; this is a rework within the constraints of the
LSM hooks present in the mainline kernel.
  
Please apply.

 hooks.c |   36 ++++++++++++++++++++++++++++++++----
 1 files changed, 32 insertions(+), 4 deletions(-)

diff -urN -X dontdiff linux-2.6.1-rc2.pending/security/selinux/hooks.c linux-2.6.1-rc2.w1/security/selinux/hooks.c
--- linux-2.6.1-rc2.pending/security/selinux/hooks.c	2004-01-07 11:46:47.687890256 -0500
+++ linux-2.6.1-rc2.w1/security/selinux/hooks.c	2004-01-07 11:48:08.107664592 -0500
@@ -2668,10 +2668,11 @@
 static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
 	int err = 0;
-	u32 netif_perm;
+	u32 netif_perm, node_perm, node_sid;
 	struct socket *sock;
 	struct inode *inode;
 	struct net_device *dev;
+	struct iphdr *iph;
 	struct sel_netif *netif;
 	struct netif_security_struct *nsec;
 	struct inode_security_struct *isec;
@@ -2707,14 +2708,17 @@
 	switch (isec->sclass) {
 	case SECCLASS_UDP_SOCKET:
 		netif_perm = NETIF__UDP_RECV;
+		node_perm = NODE__UDP_RECV;
 		break;
 	
 	case SECCLASS_TCP_SOCKET:
 		netif_perm = NETIF__TCP_RECV;
+		node_perm = NODE__TCP_RECV;
 		break;
 	
 	default:
 		netif_perm = NETIF__RAWIP_RECV;
+		node_perm = NODE__RAWIP_RECV;
 		break;
 	}
 
@@ -2724,8 +2728,18 @@
 
 	err = avc_has_perm(isec->sid, nsec->if_sid, SECCLASS_NETIF,
 	                   netif_perm, &nsec->avcr, &ad);
-
 	sel_netif_put(netif);
+	if (err)
+		goto out;
+	
+	/* Fixme: this lookup is inefficient */
+	iph = skb->nh.iph;
+	err = security_node_sid(PF_INET, &iph->saddr, sizeof(iph->saddr), &node_sid);
+	if (err)
+		goto out;
+	
+	err = avc_has_perm(isec->sid, node_sid, SECCLASS_NODE, node_perm, NULL, &ad);
+
 out:	
 	return err;
 }
@@ -2738,9 +2752,10 @@
                                               int (*okfn)(struct sk_buff *))
 {
 	int err = NF_ACCEPT;
-	u32 netif_perm;
+	u32 netif_perm, node_perm, node_sid;
 	struct socket *sock;
 	struct inode *inode;
+	struct iphdr *iph;
 	struct sel_netif *netif;
 	struct sk_buff *skb = *pskb;
 	struct netif_security_struct *nsec;
@@ -2771,14 +2786,17 @@
 	switch (isec->sclass) {
 	case SECCLASS_UDP_SOCKET:
 		netif_perm = NETIF__UDP_SEND;
+		node_perm = NODE__UDP_SEND;
 		break;
 	
 	case SECCLASS_TCP_SOCKET:
 		netif_perm = NETIF__TCP_SEND;
+		node_perm = NODE__TCP_SEND;
 		break;
 	
 	default:
 		netif_perm = NETIF__RAWIP_SEND;
+		node_perm = NODE__RAWIP_SEND;
 		break;
 	}
 
@@ -2788,8 +2806,18 @@
 
 	err = avc_has_perm(isec->sid, nsec->if_sid, SECCLASS_NETIF,
 	                   netif_perm, &nsec->avcr, &ad) ? NF_DROP : NF_ACCEPT;
-
 	sel_netif_put(netif);
+	if (err != NF_ACCEPT)
+		goto out;
+		
+	/* Fixme: this lookup is inefficient */
+	iph = skb->nh.iph;
+	err = security_node_sid(PF_INET, &iph->daddr, sizeof(iph->daddr), &node_sid);
+	if (err)
+		goto out;
+	
+	err = avc_has_perm(isec->sid, node_sid, SECCLASS_NODE,
+	                   node_perm, NULL, &ad) ? NF_DROP : NF_ACCEPT;
 out:
 	return err;
 }


