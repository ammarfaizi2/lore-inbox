Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265431AbUATNGk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 08:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265468AbUATNGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 08:06:40 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:7897 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S265431AbUATNGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 08:06:38 -0500
Date: Tue, 20 Jan 2004 08:06:32 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: David Woodhouse <dwmw2@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] some more fixes for inode.c
Message-ID: <Pine.LNX.4.44.0401200803150.15071-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, David, 

when looking over the 2.4.25-pre6-rmap patch, I found two more
chunks in inode.c that might be needed/useful.  

The first chunk refiles the inode on the inode_unused_pagecache
list if needed, but I'm not 100% sure we need that change, since
maybe only completely unused inodes can end up here. David ?
It should be safe, though.

The second chunk make ssure to also remove the quota stuff for
inodes on the inode_unused_pagecache list, in the same way it
acts the other lists.


diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Mon Jan 19 20:44:17 2004
+++ b/fs/inode.c	Mon Jan 19 20:44:17 2004
@@ -1234,10 +1235,8 @@
 				BUG();
 		} else {
 			if (!list_empty(&inode->i_hash)) {
-				if (!(inode->i_state & (I_DIRTY|I_LOCK))) {
-					list_del(&inode->i_list);
-					list_add(&inode->i_list, &inode_unused);
-				}
+				if (!(inode->i_state & (I_DIRTY|I_LOCK))) 
+					__refile_inode(inode);
 				inodes_stat.nr_unused++;
 				spin_unlock(&inode_lock);
 				if (!sb || (sb->s_flags & MS_ACTIVE))
@@ -1414,6 +1413,11 @@
 			remove_inode_dquot_ref(inode, type, &tofree_head);
 	}
 	list_for_each(act_head, &inode_unused) {
+		inode = list_entry(act_head, struct inode, i_list);
+		if (inode->i_sb == sb && IS_QUOTAINIT(inode))
+			remove_inode_dquot_ref(inode, type, &tofree_head);
+	}
+	list_for_each(act_head, &inode_unused_pagecache) {
 		inode = list_entry(act_head, struct inode, i_list);
 		if (inode->i_sb == sb && IS_QUOTAINIT(inode))
 			remove_inode_dquot_ref(inode, type, &tofree_head);

