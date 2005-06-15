Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVFOTJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVFOTJG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 15:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVFOTJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 15:09:06 -0400
Received: from mail.dif.dk ([193.138.115.101]:21198 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261355AbVFOTIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 15:08:30 -0400
Date: Wed, 15 Jun 2005 21:13:52 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: "David S. Miller" <davem@davemloft.net>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       James Morris <jmorris@redhat.com>,
       "Fred N. van Kempen" <waltje@uWalt.NL.Mugnet.ORG>,
       Ross Biro <ross.biro@gmail.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: [-mm PATCH] signed vs unsigned cleanup in net/ipv4/raw.c
Message-ID: <Pine.LNX.4.62.0506152101350.3842@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up some signed versus unsigned variable use in 
net/ipv4/raw.c

Before this patch, building net/ipv4/raw.c from 2.6.12-rc6-mm1 with 
gcc -W produces a bunch of warnings : 

net/ipv4/raw.c: In function `raw_send_hdrinc':
net/ipv4/raw.c:272: warning: comparison between signed and unsigned
net/ipv4/raw.c:301: warning: comparison between signed and unsigned
net/ipv4/raw.c: In function `raw_probe_proto_opt':
net/ipv4/raw.c:340: warning: comparison between signed and unsigned
net/ipv4/raw.c: In function `raw_sendmsg':
net/ipv4/raw.c:387: warning: comparison of unsigned expression < 0 is always false
net/ipv4/raw.c:405: warning: comparison between signed and unsigned
net/ipv4/raw.c:517: warning: signed and unsigned type in conditional expression
net/ipv4/raw.c:374: warning: unused parameter `iocb'
net/ipv4/raw.c: In function `raw_close':
net/ipv4/raw.c:527: warning: unused parameter `timeout'
net/ipv4/raw.c: In function `raw_bind':
net/ipv4/raw.c:545: warning: comparison between signed and unsigned
net/ipv4/raw.c: In function `raw_recvmsg':
net/ipv4/raw.c:613: warning: signed and unsigned type in conditional expression
net/ipv4/raw.c:565: warning: unused parameter `iocb'
net/ipv4/raw.c: In function `raw_seticmpfilter':
net/ipv4/raw.c:627: warning: comparison between signed and unsigned
net/ipv4/raw.c: In function `raw_geticmpfilter':
net/ipv4/raw.c:643: warning: comparison between signed and unsigned
net/ipv4/raw.c: In function `raw_seq_stop':
net/ipv4/raw.c:799: warning: unused parameter `seq'
net/ipv4/raw.c:799: warning: unused parameter `v'
net/ipv4/raw.c: In function `raw_seq_open':
net/ipv4/raw.c:847: warning: unused parameter `inode'

10 of which are related to signedness issues.
With this patch we are down to just 4 signed vs unsigned warnings - 
cleaning up the last 4 didn't really seem feasible.

net/ipv4/raw.c: In function `raw_sendmsg':
net/ipv4/raw.c:405: warning: comparison between signed and unsigned
net/ipv4/raw.c:374: warning: unused parameter `iocb'
net/ipv4/raw.c: In function `raw_close':
net/ipv4/raw.c:530: warning: unused parameter `timeout'
net/ipv4/raw.c: In function `raw_bind':
net/ipv4/raw.c:548: warning: comparison between signed and unsigned
net/ipv4/raw.c: In function `raw_recvmsg':
net/ipv4/raw.c:568: warning: unused parameter `iocb'
net/ipv4/raw.c: In function `raw_seticmpfilter':
net/ipv4/raw.c:633: warning: comparison between signed and unsigned
net/ipv4/raw.c: In function `raw_geticmpfilter':
net/ipv4/raw.c:649: warning: comparison between signed and unsigned
net/ipv4/raw.c: In function `raw_seq_stop':
net/ipv4/raw.c:805: warning: unused parameter `seq'
net/ipv4/raw.c:805: warning: unused parameter `v'
net/ipv4/raw.c: In function `raw_seq_open':
net/ipv4/raw.c:853: warning: unused parameter `inode'


So, here's the patch. I hope you like it and want to merge it :-)


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
--- 

 net/ipv4/raw.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

--- linux-2.6.12-rc6-mm1-orig/net/ipv4/raw.c	2005-06-12 15:58:58.000000000 +0200
+++ linux-2.6.12-rc6-mm1/net/ipv4/raw.c	2005-06-15 20:55:06.000000000 +0200
@@ -259,7 +259,7 @@ int raw_rcv(struct sock *sk, struct sk_b
 	return 0;
 }
 
-static int raw_send_hdrinc(struct sock *sk, void *from, int length,
+static int raw_send_hdrinc(struct sock *sk, void *from, size_t length,
 			struct rtable *rt, 
 			unsigned int flags)
 {
@@ -298,7 +298,7 @@ static int raw_send_hdrinc(struct sock *
 		goto error_fault;
 
 	/* We don't modify invalid header */
-	if (length >= sizeof(*iph) && iph->ihl * 4 <= length) {
+	if (length >= sizeof(*iph) && (size_t)(iph->ihl * 4) <= length) {
 		if (!iph->saddr)
 			iph->saddr = rt->rt_src;
 		iph->check   = 0;
@@ -332,7 +332,7 @@ static void raw_probe_proto_opt(struct f
 	u8 __user *type = NULL;
 	u8 __user *code = NULL;
 	int probed = 0;
-	int i;
+	unsigned int i;
 
 	if (!msg->msg_iov)
 		return;
@@ -384,7 +384,7 @@ static int raw_sendmsg(struct kiocb *ioc
 	int err;
 
 	err = -EMSGSIZE;
-	if (len < 0 || len > 0xFFFF)
+	if (len > 0xFFFF)
 		goto out;
 
 	/*
@@ -514,7 +514,10 @@ done:
 		kfree(ipc.opt);
 	ip_rt_put(rt);
 
-out:	return err < 0 ? err : len;
+out:
+	if (err < 0)
+		return err;
+	return len;
 
 do_confirm:
 	dst_confirm(&rt->u.dst);
@@ -610,7 +613,10 @@ static int raw_recvmsg(struct kiocb *ioc
 		copied = skb->len;
 done:
 	skb_free_datagram(sk, skb);
-out:	return err ? err : copied;
+out:	
+	if (err)
+		return err;
+	return copied;
 }
 
 static int raw_init(struct sock *sk)




Please CC me on replies.

-- 
Jesper Juhl




