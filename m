Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267703AbUHJVM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267703AbUHJVM5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 17:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267707AbUHJVM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 17:12:57 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:15769 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S267703AbUHJVMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 17:12:55 -0400
Date: Tue, 10 Aug 2004 23:12:45 +0200
From: Roger Luethi <rl@hellgate.ch>
To: faith@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] audit code
Message-ID: <20040810211245.GA7646@k3.hellgate.ch>
Mail-Followup-To: faith@redhat.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.8-rc3-mm1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two things that struck me as odd when reading parts of audit.c:

- audit_receive_skb calls netlink_ack with positive errnos; AFAICT
  they should be negative, though (netlink(7)).

- audit_receive_skb always returns 0; therefore, the condition
  in audit_receive is always false.

Signed-off-by: Roger Luethi <rl@hellgate.ch>

--- 2.6-mm/kernel/audit.c.orig	2004-08-10 20:49:07.407311613 +0200
+++ 2.6-mm/kernel/audit.c	2004-08-10 20:54:39.810234132 +0200
@@ -419,7 +419,7 @@ static int audit_receive_skb(struct sk_b
 		if (rlen > skb->len)
 			rlen = skb->len;
 		if ((err = audit_receive_msg(skb, nlh))) {
-			netlink_ack(skb, nlh, -err);
+			netlink_ack(skb, nlh, err);
 		} else if (nlh->nlmsg_flags & NLM_F_ACK)
 			netlink_ack(skb, nlh, 0);
 		skb_pull(skb, rlen);
@@ -437,10 +437,8 @@ static void audit_receive(struct sock *s
 
 				/* FIXME: this must not cause starvation */
 	while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
-		if (audit_receive_skb(skb) && skb->len)
-			skb_queue_head(&sk->sk_receive_queue, skb);
-		else
-			kfree_skb(skb);
+		audit_receive_skb(skb);
+		kfree_skb(skb);
 	}
 	up(&audit_netlink_sem);
 }

