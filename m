Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbTFYTkI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 15:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264989AbTFYTkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 15:40:08 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:24083 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S264980AbTFYTkE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 15:40:04 -0400
Date: Wed, 25 Jun 2003 21:46:06 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, sfrost@snowman.net, laforge@netfilter.org
Subject: [patch] 2.5.73bk - leak in "recent" iptables
Message-ID: <20030625214606.A23937@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ip_recent_ctrl(): locally allocated variables aren't freed during error path.
No reference to these variables exists outside of ip_recent_ctrl().

<remark>
module already used both "if(foo)" and "if (foo)" before the change.
</remark>

 net/ipv4/netfilter/ipt_recent.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff -puN net/ipv4/netfilter/ipt_recent.c~janitor-leak-iptables-recent net/ipv4/netfilter/ipt_recent.c
--- linux-2.5.73-1.1348.16.4-to-1.1448/net/ipv4/netfilter/ipt_recent.c~janitor-leak-iptables-recent	Wed Jun 25 21:17:10 2003
+++ linux-2.5.73-1.1348.16.4-to-1.1448-fr/net/ipv4/netfilter/ipt_recent.c	Wed Jun 25 21:27:48 2003
@@ -300,9 +300,15 @@ static int ip_recent_ctrl(struct file *f
 	info->name[IPT_RECENT_NAME_LEN-1] = '\0';
 
 	skb = kmalloc(sizeof(struct sk_buff),GFP_KERNEL);
-	if(!skb) { return -ENOMEM; }
+	if (!skb) {
+		used = -ENOMEM;
+		goto out_free_info;
+	}
 	skb->nh.iph = kmalloc(sizeof(struct iphdr),GFP_KERNEL);
-	if(!skb->nh.iph) { return -ENOMEM; }
+	if (!skb->nh.iph) {
+		used = -ENOMEM;
+		goto out_free_skb;
+	}
 
 	skb->nh.iph->saddr = addr;
 	skb->nh.iph->daddr = 0;
@@ -311,7 +317,9 @@ static int ip_recent_ctrl(struct file *f
 	match(skb,NULL,NULL,info,0,NULL);
 
 	kfree(skb->nh.iph);
+out_free_skb:
 	kfree(skb);
+out_free_info:
 	kfree(info);
 
 #ifdef DEBUG

_
