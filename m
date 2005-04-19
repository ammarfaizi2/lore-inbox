Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVDSMi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVDSMi7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 08:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVDSMi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 08:38:59 -0400
Received: from [213.170.72.194] ([213.170.72.194]:9627 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261484AbVDSMit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 08:38:49 -0400
Subject: [PATCH] VFS bugfix: two read_inode() calles without clear_inode()
	call between
From: "Artem B. Bityuckiy" <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: linux-kernel@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org,
       viro@math.psu.edu, linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Organization: MTD
Date: Tue, 19 Apr 2005 16:38:44 +0400
Message-Id: <1113914324.2125.61.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

here is a patch to fix the problem discussed at the "[PATC] small VFS
change for JFFS2" thread in LKML (http://lkml.org/lkml/2005/4/18/77).

The problem description:
~~~~~~~~~~~~~~~~~~~~~~

prune_icache() removes inodes from the inode hash (inode->i_hash) and
drops the node_lock spinlock. If at that moment iget() is called, we end
up with the situation when VFS calls ->read_inode() twice for the same
inode without calling ->clear_inode() between. This happens despite of
the I_FREEING inode state because the inode is already removed from the
hash by the time find_inode_fast() is invoked.

The fix is: do not remove the inode from the hash too early.

The following patch fixes the problem. It was tested with JFFS2 (only)
and works perfectly.

Comments?



Signed-off-by: Artem B. Bityuckiy <dedekind@infradead.org>


diff -auNrp linux-2.6.11.5/fs/inode.c linux-2.6.11.5_fixed/fs/inode.c
--- linux-2.6.11.5/fs/inode.c   2005-03-19 09:35:04.000000000 +0300
+++ linux-2.6.11.5_fixed/fs/inode.c     2005-04-18 17:54:16.000000000
+0400
@@ -284,6 +284,12 @@ static void dispose_list(struct list_hea
                if (inode->i_data.nrpages)
                        truncate_inode_pages(&inode->i_data, 0);
                clear_inode(inode);
+
+               spin_lock(&inode_lock);
+               hlist_del_init(&inode->i_hash);
+               list_del_init(&inode->i_sb_list);
+               spin_unlock(&inode_lock);
+
                destroy_inode(inode);
                nr_disposed++;
        }
@@ -319,8 +325,6 @@ static int invalidate_list(struct list_h
                inode = list_entry(tmp, struct inode, i_sb_list);
                invalidate_inode_buffers(inode);
                if (!atomic_read(&inode->i_count)) {
-                       hlist_del_init(&inode->i_hash);
-                       list_del(&inode->i_sb_list);
                        list_move(&inode->i_list, dispose);
                        inode->i_state |= I_FREEING;
                        count++;
@@ -455,8 +459,6 @@ static void prune_icache(int nr_to_scan)
                        if (!can_unuse(inode))
                                continue;
                }
-               hlist_del_init(&inode->i_hash);
-               list_del_init(&inode->i_sb_list);
                list_move(&inode->i_list, &freeable);
                inode->i_state |= I_FREEING;
                nr_pruned++;

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.

