Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267283AbUIAQuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267283AbUIAQuF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 12:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267258AbUIAP4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:56:47 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:947 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267344AbUIAPvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:51:45 -0400
Date: Wed, 1 Sep 2004 16:51:22 +0100
Message-Id: <200409011551.i81FpMgF000675@delerium.codemonkey.org.uk>
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix possible leaks in netfilter.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spotted with the source checker from Coverity.com.

Signed-off-by: Dave Jones <davej@redhat.com>


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/net/ipv4/netfilter/ipt_recent.c linux-2.6/net/ipv4/netfilter/ipt_recent.c
--- bk-linus/net/ipv4/netfilter/ipt_recent.c	2004-08-24 00:02:41.000000000 +0100
+++ linux-2.6/net/ipv4/netfilter/ipt_recent.c	2004-09-01 13:31:21.000000000 +0100
@@ -827,6 +827,7 @@ checkentry(const char *tablename,
 			if(debug) printk(KERN_INFO RECENT_NAME ": checkentry() create_proc failed, no tables.\n");
 #endif
 			spin_unlock_bh(&recent_lock);
+			vfree(hold);
 			return -ENOMEM;
 		}
 		while( strncmp(info->name,curr_table->name,IPT_RECENT_NAME_LEN) && (last_table = curr_table) && (curr_table = curr_table->next) );
@@ -835,6 +836,7 @@ checkentry(const char *tablename,
 			if(debug) printk(KERN_INFO RECENT_NAME ": checkentry() create_proc failed, table already destroyed.\n");
 #endif
 			spin_unlock_bh(&recent_lock);
+			vfree(hold);
 			return -ENOMEM;
 		}
 		if(last_table) last_table->next = curr_table->next; else r_tables = curr_table->next;
