Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbTJDHe1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 03:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbTJDHe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 03:34:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:59838 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261930AbTJDHe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 03:34:26 -0400
Date: Sat, 4 Oct 2003 00:36:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] fix networking memory leak in current -bk
Message-Id: <20031004003600.6905f268.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Quicky fix for a horrid skb data leak...


 net/core/dev.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff -puN net/core/dev.c~skb-leak-fix net/core/dev.c
--- 25/net/core/dev.c~skb-leak-fix	2003-10-04 00:32:19.000000000 -0700
+++ 25-akpm/net/core/dev.c	2003-10-04 00:33:18.000000000 -0700
@@ -1576,9 +1576,13 @@ int netif_receive_skb(struct sk_buff *sk
 		}
 	}
 
-	if (pt_prev)
-		ret = deliver_skb(skb, pt_prev, 1);
-	else {
+	if (pt_prev) {
+		if (!pt_prev->data) {
+			ret = deliver_to_old_ones(pt_prev, skb, 1);
+		} else {
+			ret = pt_prev->func(skb, skb->dev, pt_prev);
+		}
+	} else {
 		kfree_skb(skb);
 		/* Jamal, now you will not able to escape explaining
 		 * me how you were going to use this. :-)

_

