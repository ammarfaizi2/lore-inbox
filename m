Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVEDMRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVEDMRw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 08:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbVEDMRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 08:17:51 -0400
Received: from [213.170.72.194] ([213.170.72.194]:3532 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261678AbVEDMRj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 08:17:39 -0400
Subject: Re: [PATCH] VFS bugfix: two read_inode() calles without
	clear_inode() call between
From: "Artem B. Bityuckiy" <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Andrew Morton <akpm@osdl.org>
Cc: miklos@szeredi.hu, linux-kernel@vger.kernel.org, dwmw2@infradead.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <20050428003450.51687b65.akpm@osdl.org>
References: <1114607741.12617.4.camel@sauron.oktetlabs.ru>
	 <E1DQoui-0002In-00@dorka.pomaz.szeredi.hu>
	 <1114618748.12617.23.camel@sauron.oktetlabs.ru>
	 <E1DQqZu-0002Rf-00@dorka.pomaz.szeredi.hu>
	 <1114673528.3483.2.camel@sauron.oktetlabs.ru>
	 <20050428003450.51687b65.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-sshnUMV0dxyS7CixPepE"
Organization: MTD
Date: Wed, 04 May 2005 16:17:35 +0400
Message-Id: <1115209055.8559.12.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sshnUMV0dxyS7CixPepE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello Andrew,

here you can find a new patch for the VFS bug which was discussed at
http://lkml.org/lkml/2005/4/27/84

I added wake_up_inode() invocation just as Miklos suggested.


Bug symptoms
~~~~~~~~~~~~
For the same inode VFS calls read_inode() twice and doesn't call
clear_inode() between the two read_inode() invocations.

Bug description
~~~~~~~~~~~~~~~
Suppose we have an inode which has zero reference count but is still in
the inode cache. Suppose kswapd invokes shrink_icache_memory() to free
some RAM. In prune_icache() inodes are removed from i_hash. prune_icache
() is then going to call clear_inode(), but drops the inode_lock
spinlock before this. If in this moment another task calls iget() for an
inode which was just removed from i_hash by prune_icache(), then iget()
invokes read_inode() for this inode, because it is *already removed*
from i_hash.

The end result is: we call iget(#N) then iput(#N); inode #N has zero
i_count now and is in the inode cache; kswapd starts. kswapd removes the
inode #N from i_hash ans is preempted; we call iget(#N) again;
read_inode() is invoked as the result; but we expect clear_inode()
before.

Fix
~~~~~~~
To fix the bug I remove inodes from i_hash later, when clear_inode() is
actually called. I remove them from i_hash under spinlock protection.
Since the i_state is set to I_FREEING, it is safe to do this. The others
will sleep waiting for the inode state change.

I also postpone removing inodes from i_sb_list. It is not compulsory to
do so but I do it for readability reasons. Inodes are added/removed to
the lists together everywhere in the code and there is no point to
change this rule. This is harmless because the only user of i_sb_list
which somehow may interfere with me (invalidate_list()) is excluded by
the iprune_sem mutex.

The same race is possible in invalidate_list() so I do the same for it.

The patch is against linux 2.6.11.5.
The patch was tested for JFFS2.

Please. apply/comment.

Cheers,
Artem.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.

--=-sshnUMV0dxyS7CixPepE
Content-Disposition: attachment; filename=vfs-double_inode_read-2.diff
Content-Type: text/x-patch; name=vfs-double_inode_read-2.diff; charset=KOI8-R
Content-Transfer-Encoding: 7bit

diff -auNrp linux-2.6.11.5/fs/inode.c linux-2.6.11.5_fixed/fs/inode.c
--- linux-2.6.11.5/fs/inode.c	2005-03-19 09:35:04.000000000 +0300
+++ linux-2.6.11.5_fixed/fs/inode.c	2005-05-04 14:51:14.000000000 +0400
@@ -284,6 +284,13 @@ static void dispose_list(struct list_hea
 		if (inode->i_data.nrpages)
 			truncate_inode_pages(&inode->i_data, 0);
 		clear_inode(inode);
+		
+		spin_lock(&inode_lock);
+		hlist_del_init(&inode->i_hash);
+		list_del_init(&inode->i_sb_list);
+		spin_unlock(&inode_lock);
+		
+		wake_up_inode(inode);
 		destroy_inode(inode);
 		nr_disposed++;
 	}
@@ -319,8 +326,6 @@ static int invalidate_list(struct list_h
 		inode = list_entry(tmp, struct inode, i_sb_list);
 		invalidate_inode_buffers(inode);
 		if (!atomic_read(&inode->i_count)) {
-			hlist_del_init(&inode->i_hash);
-			list_del(&inode->i_sb_list);
 			list_move(&inode->i_list, dispose);
 			inode->i_state |= I_FREEING;
 			count++;
@@ -455,8 +460,6 @@ static void prune_icache(int nr_to_scan)
 			if (!can_unuse(inode))
 				continue;
 		}
-		hlist_del_init(&inode->i_hash);
-		list_del_init(&inode->i_sb_list);
 		list_move(&inode->i_list, &freeable);
 		inode->i_state |= I_FREEING;
 		nr_pruned++;

--=-sshnUMV0dxyS7CixPepE--

