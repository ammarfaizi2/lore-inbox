Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVFPWap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVFPWap (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 18:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbVFPWap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 18:30:45 -0400
Received: from mail.dif.dk ([193.138.115.101]:7874 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261835AbVFPWah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 18:30:37 -0400
Date: Fri, 17 Jun 2005 00:36:04 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: laforge@netfilter.org, Stephen Frost <sfrost@snowman.net>,
       Jesper Juhl <juhl-lkml@dif.dk>, Jesper Juhl <jesper.juhl@gmail.com>
Subject: Shouldn't we be using alloc_skb/kfree_skb in
 net/ipv4/netfilter/ipt_recent.c::ip_recent_ctrl ?
Message-ID: <Pine.LNX.4.62.0506170025140.2477@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was just grep'ing through the source looking for places where skb's 
might be freed by plain kfree() and, amongst other things, I noticed 
net/ipv4/netfilter/ipt_recent.c::ip_recent_ctrl, where a struct sk_buff* 
is defined and then storage for it is allocated with kmalloc() and freed 
with kfree(), and I'm wondering if we shouldn't be using 
alloc_skb/kfree_skb instead (as pr the patch below)? Or is there some good 
reason for doing it the way it's currently done?


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 net/ipv4/netfilter/ipt_recent.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.12-rc6-mm1-orig/net/ipv4/netfilter/ipt_recent.c	2005-06-12 15:58:58.000000000 +0200
+++ linux-2.6.12-rc6-mm1/net/ipv4/netfilter/ipt_recent.c	2005-06-16 23:41:55.000000000 +0200
@@ -303,7 +303,7 @@ static int ip_recent_ctrl(struct file *f
 	strncpy(info->name,curr_table->name,IPT_RECENT_NAME_LEN);
 	info->name[IPT_RECENT_NAME_LEN-1] = '\0';
 
-	skb = kmalloc(sizeof(struct sk_buff),GFP_KERNEL);
+	skb = alloc_skb(sizeof(struct sk_buff),GFP_KERNEL);
 	if (!skb) {
 		used = -ENOMEM;
 		goto out_free_info;
@@ -322,7 +322,7 @@ static int ip_recent_ctrl(struct file *f
 
 	kfree(skb->nh.iph);
 out_free_skb:
-	kfree(skb);
+	kfree_skb(skb);
 out_free_info:
 	kfree(info);
 


