Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbVANGQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVANGQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 01:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVANGPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 01:15:34 -0500
Received: from opersys.com ([64.40.108.71]:17 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261925AbVANGEA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 01:04:00 -0500
Message-ID: <41E76292.1010606@opersys.com>
Date: Fri, 14 Jan 2005 01:11:30 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH 7/8 ] ltt for 2.6.10 : net/ events
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


signed-off-by: Karim Yaghmour (karim@opersys.com)

--- linux-2.6.10-relayfs/net/core/dev.c	2004-12-24 16:34:45.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/net/core/dev.c	2005-01-13 22:21:51.000000000 -0500
@@ -107,6 +107,7 @@
 #include <linux/module.h>
 #include <linux/kallsyms.h>
 #include <linux/netpoll.h>
+#include <linux/ltt-events.h>
 #include <linux/rcupdate.h>
 #ifdef CONFIG_NET_RADIO
 #include <linux/wireless.h>		/* Note : will define WIRELESS_EXT */
@@ -1245,6 +1246,8 @@ int dev_queue_xmit(struct sk_buff *skb)
 	      	if (skb_checksum_help(skb, 0))
 	      		goto out_kfree_skb;

+	ltt_ev_network(LTT_EV_NETWORK_PACKET_OUT, skb->protocol);
+
 	/* Disable soft irqs for various locks below. Also
 	 * stops preemption for RCU.
 	 */
@@ -1642,6 +1645,8 @@ int netif_receive_skb(struct sk_buff *sk

 	__get_cpu_var(netdev_rx_stat).total++;

+ 	ltt_ev_network(LTT_EV_NETWORK_PACKET_IN, skb->protocol);
+
 	skb->h.raw = skb->nh.raw = skb->data;
 	skb->mac_len = skb->nh.raw - skb->mac.raw;

--- linux-2.6.10-relayfs/net/socket.c	2004-12-24 16:34:31.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/net/socket.c	2005-01-13 22:21:51.000000000 -0500
@@ -81,6 +81,7 @@
 #include <linux/syscalls.h>
 #include <linux/compat.h>
 #include <linux/kmod.h>
+#include <linux/ltt-events.h>

 #ifdef CONFIG_NET_RADIO
 #include <linux/wireless.h>		/* Note : will define WIRELESS_EXT */
@@ -551,6 +552,8 @@ int sock_sendmsg(struct socket *sock, st
 	struct sock_iocb siocb;
 	int ret;

+	ltt_ev_socket(LTT_EV_SOCKET_SEND, sock->type, size);
+
 	init_sync_kiocb(&iocb, NULL);
 	iocb.private = &siocb;
 	ret = __sock_sendmsg(&iocb, sock, msg, size);
@@ -603,6 +606,8 @@ int sock_recvmsg(struct socket *sock, st
 	struct sock_iocb siocb;
 	int ret;

+	ltt_ev_socket(LTT_EV_SOCKET_RECEIVE, sock->type, size);
+
         init_sync_kiocb(&iocb, NULL);
 	iocb.private = &siocb;
 	ret = __sock_recvmsg(&iocb, sock, msg, size, flags);
@@ -1197,6 +1202,8 @@ asmlinkage long sys_socket(int family, i
 	if (retval < 0)
 		goto out_release;

+	ltt_ev_socket(LTT_EV_SOCKET_CREATE, retval, type);
+
 out:
 	/* It may be already another descriptor 8) Not kernel problem. */
 	return retval;
@@ -1916,6 +1923,8 @@ asmlinkage long sys_socketcall(int call,
 		
 	a0=a[0];
 	a1=a[1];
+
+	ltt_ev_socket(LTT_EV_SOCKET_CALL, call, a0);
 	
 	switch(call)
 	{


