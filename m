Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTJZWqM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 17:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbTJZWqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 17:46:12 -0500
Received: from zero.aec.at ([193.170.194.10]:52741 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262164AbTJZWqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 17:46:09 -0500
To: Simon Roscic <simon.roscic@chello.at>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [2.6.0-test8/9] ethertap oops
From: Andi Kleen <ak@muc.de>
Date: Sun, 26 Oct 2003 23:45:52 +0100
In-Reply-To: <L1fo.3gb.9@gated-at.bofh.it> (Simon Roscic's message of "Sun,
 26 Oct 2003 23:10:14 +0100")
Message-ID: <m3ekwz7h3z.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <L1fo.3gb.9@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Roscic <simon.roscic@chello.at> writes:

> EIP is at ethertap_rx+0x131/0x2a0 [ethertap]

Does this patch fix it?

-Andi

diff -u linux-2.6.0test7mm1-averell/drivers/net/ethertap.c-o linux-2.6.0test7mm1-averell/drivers/net/ethertap.c
--- linux-2.6.0test7mm1-averell/drivers/net/ethertap.c-o	2003-09-11 04:12:33.000000000 +0200
+++ linux-2.6.0test7mm1-averell/drivers/net/ethertap.c	2003-10-26 23:41:17.000000000 +0100
@@ -302,11 +302,12 @@
 
 static void ethertap_rx(struct sock *sk, int len)
 {
-	struct net_device *dev = tap_map[sk->sk_protocol];
+	unsigned unit = sk->sk_protocol - NETLINK_TAPBASE; 
+	struct net_device *dev;
 	struct sk_buff *skb;
 
-	if (dev==NULL) {
-		printk(KERN_CRIT "ethertap: bad unit!\n");
+	if (unit >= max_taps || (dev = tap_map[unit]) == NULL) { 
+		printk(KERN_CRIT "ethertap: bad unit %u!\n", unit);
 		skb_queue_purge(&sk->sk_receive_queue);
 		return;
 	}
diff -u linux-2.6.0test7mm1-averell/net/netlink/af_netlink.c-o linux-2.6.0test7mm1-averell/net/netlink/af_netlink.c
--- linux-2.6.0test7mm1-averell/net/netlink/af_netlink.c-o	2003-10-09 00:29:02.000000000 +0200
+++ linux-2.6.0test7mm1-averell/net/netlink/af_netlink.c	2003-10-26 23:42:44.000000000 +0100
@@ -777,6 +777,7 @@
 	if (input)
 		nlk_sk(sk)->data_ready = input;
 
+	sk->sk_protocol = unit;
 	netlink_insert(sk, 0);
 	return sk;
 }
