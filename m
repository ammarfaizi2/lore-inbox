Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbVHWQqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVHWQqI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 12:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbVHWQqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 12:46:08 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:2768
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750705AbVHWQqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 12:46:07 -0400
Date: Tue, 23 Aug 2005 09:46:03 -0700 (PDT)
Message-Id: <20050823.094603.29591786.davem@davemloft.net>
To: tedu@coverity.com
Cc: linux-kernel@vger.kernel.org, ralf@linux-mips.org
Subject: Re: some missing spin_unlocks
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <430A5127.5000304@coverity.com>
References: <430A5127.5000304@coverity.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ted Unangst <tedu@coverity.com>
Date: Mon, 22 Aug 2005 15:26:47 -0700

> net/rose/rose_route.c rose_route_frame, line 998
> returns without unlocking rose_node_list_lock, rose_neigh_list_lock, or 
> rose_route_list_lock

I fixed this one with the patch below.

> net/rose/rose_timer.c rose_heartbeat_expiry, line 141
> rose_destroy_socket does not unlock sk as far as i can see

This one needs more care.  We can't drop the lock, because
the destroy actions need to be protected by that lock, but
we can't release the lock after rose_destroy_socket() because
the object may not even exist any longer.

The problem there, at the core, is that the timer doesn't
grab a reference to the socket, which would make the solution
to this bug very straight forward.

Someone should work on that :-)

diff-tree 61ef36aa6cf356649863a24a850c2183cb762c61 (from daf53344fadaa8c47c6b0864e7f34efcbb66e391)
Author: David S. Miller <davem@davemloft.net>
Date:   Tue Aug 23 09:42:38 2005 -0700

    [ROSE]: Fix missing unlocks in rose_route_frame()
    
    Noticed by Coverity checker.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/rose/rose_route.c b/net/rose/rose_route.c
--- a/net/rose/rose_route.c
+++ b/net/rose/rose_route.c
@@ -994,8 +994,10 @@ int rose_route_frame(struct sk_buff *skb
 	 *	1. The frame isn't for us,
 	 *	2. It isn't "owned" by any existing route.
 	 */
-	if (frametype != ROSE_CALL_REQUEST)	/* XXX */
-		return 0;
+	if (frametype != ROSE_CALL_REQUEST) {	/* XXX */
+		ret = 0;
+		goto out;
+	}
 
 	len  = (((skb->data[3] >> 4) & 0x0F) + 1) / 2;
 	len += (((skb->data[3] >> 0) & 0x0F) + 1) / 2;
