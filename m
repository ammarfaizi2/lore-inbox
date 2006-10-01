Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWJAQYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWJAQYP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 12:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWJAQYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 12:24:15 -0400
Received: from havoc.gtf.org ([69.61.125.42]:7661 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751218AbWJAQYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 12:24:14 -0400
Date: Sun, 1 Oct 2006 12:24:13 -0400
From: Jeff Garzik <jeff@garzik.org>
To: per.liden@ericsson.com, jon.maloy@ericsson.com,
       allan.stephens@windriver.com, davem@davemloft.net,
       Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] TIPC: fix printk warning
Message-ID: <20061001162413.GA8000@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc spits out this warning:

net/tipc/link.c: In function ‘link_retransmit_failure’:
net/tipc/link.c:1669: warning: cast from pointer to integer of different
size

More than a little bit ugly, storing integers in void*, but at least the
code is correct, unlike some of the more crufty Linux kernel code found
elsewhere.

Rather than having two casts to massage the value into u32, it's easier
just to have a single cast and use "%lu", since it's just a printk.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 693f02e..53bc8cb 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1666,8 +1666,9 @@ static void link_retransmit_failure(stru
 		char addr_string[16];
 
 		tipc_printf(TIPC_OUTPUT, "Msg seq number: %u,  ", msg_seqno(msg));
-		tipc_printf(TIPC_OUTPUT, "Outstanding acks: %u\n", (u32)TIPC_SKB_CB(buf)->handle);
-		
+		tipc_printf(TIPC_OUTPUT, "Outstanding acks: %lu\n",
+				     (unsigned long) TIPC_SKB_CB(buf)->handle);
+
 		n_ptr = l_ptr->owner->next;
 		tipc_node_lock(n_ptr);
 
