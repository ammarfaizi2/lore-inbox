Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWCRXoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWCRXoy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 18:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWCRXoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 18:44:54 -0500
Received: from nproxy.gmail.com ([64.233.182.200]:64249 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751138AbWCRXox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 18:44:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ZTyvF7910sPXoGuZxXBqxYXvctnne6RJjcWH4OrmlTT+edJuWcIQ1oPm4AeaqqF7lxvSDGAQ7Vm72uto9ua+hqb3AJIeI3CSuZAIHvcMkYtwSBVijCk8IsGG3Al5wTLeeBxPyBuXXskQ6CtUumLgn8/bUuY81MDCDW+aaSwD7ZM=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] cleanup for net/tipc/name_distr.c::tipc_named_node_up()
Date: Sun, 19 Mar 2006 00:45:23 +0100
User-Agent: KMail/1.9.1
Cc: Per Liden <per.liden@ericsson.com>, Jon Maloy <jon.maloy@ericsson.com>,
       Allan Stephens <allan.stephens@windriver.com>,
       tipc-discussion@lists.sourceforge.net,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603190045.24176.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Small cleanup patch for net/tipc/name_distr.c::tipc_named_node_up()

Patch does the following:

 - Change a few pointer assignments from 0 to NULL (makes sparse happy).
 - Move a few variable assignment outside the tipc_nametbl_lock lock.
 - Make sure to free the allocated buffer before returning so we don't leak.


Note: patch is compile tested only and I'm not familiar with this code, so
      please check my changes carefully.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 net/tipc/name_distr.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

--- linux-2.6.16-rc6-orig/net/tipc/name_distr.c	2006-03-12 14:19:18.000000000 +0100
+++ linux-2.6.16-rc6/net/tipc/name_distr.c	2006-03-19 00:36:41.000000000 +0100
@@ -168,17 +168,17 @@ void tipc_named_withdraw(struct publicat
 void tipc_named_node_up(unsigned long node)
 {
 	struct publication *publ;
-	struct distr_item *item = 0;
-	struct sk_buff *buf = 0;
+	struct distr_item *item = NULL;
+	struct sk_buff *buf = NULL;
 	u32 left = 0;
 	u32 rest;
 	u32 max_item_buf;
 
 	assert(in_own_cluster(node));
-	read_lock_bh(&tipc_nametbl_lock); 
 	max_item_buf = TIPC_MAX_USER_MSG_SIZE / ITEM_SIZE;
 	max_item_buf *= ITEM_SIZE;
 	rest = publ_cnt * ITEM_SIZE;
+	read_lock_bh(&tipc_nametbl_lock); 
 
 	list_for_each_entry(publ, &publ_root, local_list) {
 		if (!buf) {
@@ -200,10 +200,11 @@ void tipc_named_node_up(unsigned long no
 			    "<%u.%u.%u>\n", tipc_zone(node), 
 			    tipc_cluster(node), tipc_node(node));
 			tipc_link_send(buf, node, node);
-			buf = 0;
+			buf = NULL;
 		}
 	}
 exit:
+	kfree_skb(buf);
 	read_unlock_bh(&tipc_nametbl_lock); 
 }
 



