Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263848AbTEZCKK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 22:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263852AbTEZCKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 22:10:10 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28690 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263848AbTEZCKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 22:10:08 -0400
Date: Sun, 25 May 2003 19:22:56 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: viro@parcelfarce.linux.theplanet.co.uk, <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: netlink init order
In-Reply-To: <20030525.190710.112599236.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0305251922310.1621-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 25 May 2003, David S. Miller wrote:
>    
> That being said, you should be able to safely use module_init() there.

Mind testing (and pushing back if ok) something like this, then?

		Linus

---

===== include/linux/netlink.h 1.10 vs edited =====
--- 1.10/include/linux/netlink.h	Sun Apr  6 06:03:54 2003
+++ edited/include/linux/netlink.h	Sun May 25 19:20:21 2003
@@ -108,7 +108,6 @@
 extern int netlink_attach(int unit, int (*function)(int,struct sk_buff *skb));
 extern void netlink_detach(int unit);
 extern int netlink_post(int unit, struct sk_buff *skb);
-extern int init_netlink(void);
 extern struct sock *netlink_kernel_create(int unit, void (*input)(struct sock *sk, int len));
 extern void netlink_ack(struct sk_buff *in_skb, struct nlmsghdr *nlh, int err);
 extern int netlink_unicast(struct sock *ssk, struct sk_buff *skb, __u32 pid, int nonblock);
===== net/netlink/af_netlink.c 1.24 vs edited =====
--- 1.24/net/netlink/af_netlink.c	Wed May 14 19:19:15 2003
+++ edited/net/netlink/af_netlink.c	Sun May 25 19:12:23 2003
@@ -1070,9 +1070,6 @@
 #endif
 	/* The netlink device handler may be needed early. */ 
 	rtnetlink_init();
-#ifdef CONFIG_NETLINK_DEV
-	init_netlink();
-#endif
 	return 0;
 }
 
===== net/netlink/netlink_dev.c 1.17 vs edited =====
--- 1.17/net/netlink/netlink_dev.c	Tue May 20 19:39:24 2003
+++ edited/net/netlink/netlink_dev.c	Sun May 25 19:14:21 2003
@@ -220,7 +220,7 @@
 	},
 };
 
-int __init init_netlink(void)
+static int __init init_netlink(void)
 {
 	int i;
 
@@ -245,17 +245,7 @@
 	return 0;
 }
 
-#ifdef MODULE
-
-MODULE_LICENSE("GPL");
-
-int init_module(void)
-{
-	printk(KERN_INFO "Network Kernel/User communications module 0.04\n");
-	return init_netlink();
-}
-
-void cleanup_module(void)
+static void __exit cleanup_netlink(void)
 {
 	int i;
 
@@ -267,4 +257,6 @@
 	unregister_chrdev(NETLINK_MAJOR, "netlink");
 }
 
-#endif
+MODULE_LICENSE("GPL");
+__initcall(init_netlink);
+__exitcall(cleanup_netlink);

