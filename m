Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbULOAvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbULOAvy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 19:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbULOAt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 19:49:26 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53516 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261714AbULOAqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 19:46:07 -0500
Date: Wed, 15 Dec 2004 01:46:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/netlink/af_netlink.c: possible cleanups
Message-ID: <20041215004604.GH23151@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following possible cleanups:
- make the needlessly global function netlink_getsockbypid static
- remove the EXPORT_SYMBOL'ed but unused functions netlink_attach and 
  netlink_detach

Please review whether these changes are correct or whether they conflict 
with pending patches.


diffstat output:
 include/linux/netlink.h  |    3 ---
 net/netlink/af_netlink.c |   28 +---------------------------
 2 files changed, 1 insertion(+), 30 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc3-mm1-full/include/linux/netlink.h.old	2004-12-14 21:43:16.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/include/linux/netlink.h	2004-12-14 21:44:27.000000000 +0100
@@ -116,8 +116,6 @@
 #define NETLINK_CREDS(skb)	(&NETLINK_CB((skb)).creds)
 
 
-extern int netlink_attach(int unit, int (*function)(int,struct sk_buff *skb));
-extern void netlink_detach(int unit);
 extern int netlink_post(int unit, struct sk_buff *skb);
 extern struct sock *netlink_kernel_create(int unit, void (*input)(struct sock *sk, int len));
 extern void netlink_ack(struct sk_buff *in_skb, struct nlmsghdr *nlh, int err);
@@ -129,7 +127,6 @@
 extern int netlink_unregister_notifier(struct notifier_block *nb);
 
 /* finegrained unicast helpers: */
-struct sock *netlink_getsockbypid(struct sock *ssk, u32 pid);
 struct sock *netlink_getsockbyfilp(struct file *filp);
 int netlink_attachskb(struct sock *sk, struct sk_buff *skb, int nonblock, long timeo);
 void netlink_detachskb(struct sock *sk, struct sk_buff *skb);
--- linux-2.6.10-rc3-mm1-full/net/netlink/af_netlink.c.old	2004-12-14 21:43:31.000000000 +0100
+++ linux-2.6.10-rc3-mm1-full/net/netlink/af_netlink.c	2004-12-14 21:44:34.000000000 +0100
@@ -546,7 +546,7 @@
 	}
 }
 
-struct sock *netlink_getsockbypid(struct sock *ssk, u32 pid)
+static struct sock *netlink_getsockbypid(struct sock *ssk, u32 pid)
 {
 	int protocol = ssk->sk_protocol;
 	struct sock *sock;
@@ -1210,30 +1210,6 @@
  *	Backward compatibility.
  */	
  
-int netlink_attach(int unit, int (*function)(int, struct sk_buff *skb))
-{
-	struct sock *sk = netlink_kernel_create(unit, NULL);
-	if (sk == NULL)
-		return -ENOBUFS;
-	nlk_sk(sk)->handler = function;
-	write_lock_bh(&nl_emu_lock);
-	netlink_kernel[unit] = sk->sk_socket;
-	write_unlock_bh(&nl_emu_lock);
-	return 0;
-}
-
-void netlink_detach(int unit)
-{
-	struct socket *sock;
-
-	write_lock_bh(&nl_emu_lock);
-	sock = netlink_kernel[unit];
-	netlink_kernel[unit] = NULL;
-	write_unlock_bh(&nl_emu_lock);
-
-	sock_release(sock);
-}
-
 int netlink_post(int unit, struct sk_buff *skb)
 {
 	struct socket *sock;
@@ -1522,7 +1498,5 @@
 EXPORT_SYMBOL(netlink_unregister_notifier);
 
 #if defined(CONFIG_NETLINK_DEV) || defined(CONFIG_NETLINK_DEV_MODULE)
-EXPORT_SYMBOL(netlink_attach);
-EXPORT_SYMBOL(netlink_detach);
 EXPORT_SYMBOL(netlink_post);
 #endif

