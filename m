Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030681AbWK3QQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030681AbWK3QQK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 11:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030671AbWK3QQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 11:16:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26028 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S967836AbWK3QQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 11:16:07 -0500
Message-ID: <456F014C.5040200@redhat.com>
Date: Thu, 30 Nov 2006 11:05:32 -0500
From: Wendy Cheng <wcheng@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: wcheng@redhat.com, Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] prune_icache_sb
References: <4564C28B.30604@redhat.com>	<20061122153603.33c2c24d.akpm@osdl.org>	<456B7A5A.1070202@redhat.com>	<20061127165239.9616cbc9.akpm@osdl.org>	<456CACF3.7030200@redhat.com> <20061128162144.8051998a.akpm@osdl.org> <456D2259.1050306@redhat.com>
In-Reply-To: <456D2259.1050306@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------010205040907020905070307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010205040907020905070307
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit

How about a simple and plain change with this uploaded patch ....

The idea is, instead of unconditionally dropping every buffer associated 
with the particular mount point (that defeats the purpose of page 
caching), base kernel exports the "drop_pagecache_sb()" call that allows 
page cache to be trimmed. More importantly, it is changed to offer the 
choice of not randomly purging any buffer but the ones that seem to be 
unused (i_state is NULL and i_count is zero). This will encourage 
filesystem(s) to pro actively response to vm memory shortage if they 
choose so.

 From our end (cluster locks are expensive - that's why we cache them), 
one of our kernel daemons will invoke this newly exported call based on 
a set of pre-defined tunables. It is then followed by a lock reclaim 
logic to trim the locks by checking the page cache associated with the 
inode (that this cluster lock is created for). If nothing is attached to 
the inode (based on i_mapping->nrpages count), we know it is a good 
candidate for trimming and will subsequently drop this lock (instead of 
waiting until the end of vfs inode life cycle).

Note that I could do invalidate_inode_pages() within our kernel modules 
to accomplish what drop_pagecache_sb() does (without coming here to bug 
people) but I don't have access to inode_lock as an external kernel 
module. So either EXPORT_SYMBOL(inode_lock) or this patch ?

The end result (of this change) should encourage filesystem to actively 
avoid depleting too much memory and we'll encourage our applications to 
understand clustering locality issues.

Haven't tested this out though - would appreciate some comments before 
spending more efforts on this direction.

-- Wendy



--------------010205040907020905070307
Content-Type: text/x-patch;
 name="inode_prune_sb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="inode_prune_sb.patch"

--- linux-2.6.18/include/linux/fs.h	2006-09-19 23:42:06.000000000 -0400
+++ ups-kernel/include/linux/fs.h	2006-11-30 02:16:34.000000000 -0500
@@ -1625,7 +1625,8 @@ extern void remove_inode_hash(struct ino
 static inline void insert_inode_hash(struct inode *inode) {
 	__insert_inode_hash(inode, inode->i_ino);
 }
-
+extern void void drop_pagecache_sb(struct super_block *sb, int nr_goal);:q
+ 
 extern struct file * get_empty_filp(void);
 extern void file_move(struct file *f, struct list_head *list);
 extern void file_kill(struct file *f);
--- linux-2.6.18/fs/drop_caches.c	2006-09-19 23:42:06.000000000 -0400
+++ ups-kernel/fs/drop_caches.c	2006-11-30 03:36:11.000000000 -0500
@@ -12,13 +12,20 @@
 /* A global variable is a bit ugly, but it keeps the code simple */
 int sysctl_drop_caches;
 
-static void drop_pagecache_sb(struct super_block *sb)
+void drop_pagecache_sb(struct super_block *sb, int nr_goal)
 {
 	struct inode *inode;
+	int nr_count=0;
 
 	spin_lock(&inode_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		if (inode->i_state & (I_FREEING|I_WILL_FREE))
+		if (nr_goal) {
+			if (nr_goal == nr_count)
+				break;
+			if ((inode->i_state || atomic_read(&inode->i_count))
+				continue;
+			nr_count++;
+		} else if (inode->i_state & (I_FREEING|I_WILL_FREE))
 			continue;
 		invalidate_inode_pages(inode->i_mapping);
 	}
@@ -36,7 +43,7 @@ restart:
 		spin_unlock(&sb_lock);
 		down_read(&sb->s_umount);
 		if (sb->s_root)
-			drop_pagecache_sb(sb);
+			drop_pagecache_sb(sb, 0);
 		up_read(&sb->s_umount);
 		spin_lock(&sb_lock);
 		if (__put_super_and_need_restart(sb))
@@ -66,3 +73,6 @@ int drop_caches_sysctl_handler(ctl_table
 	}
 	return 0;
 }
+
+EXPORT_SYMBOL(drop_pagecache_sb);
+

--------------010205040907020905070307--
