Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbTJQI5K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 04:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263342AbTJQI5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 04:57:09 -0400
Received: from asplinux.ru ([195.133.213.194]:53257 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S263340AbTJQI5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 04:57:06 -0400
From: Kirill Korotaev <dev@sw.ru>
Reply-To: dev@sw.ru
Organization: SWsoft
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.6.0-test7-mm1
Date: Fri, 17 Oct 2003 12:58:11 +0400
User-Agent: KMail/1.5.1
References: <20031015013649.4aebc910.akpm@osdl.org> <1066232576.25102.1.camel@telecentrolivre> <20031015165508.GA723@holomorphy.com>
In-Reply-To: <20031015165508.GA723@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_j86j/wOBcg9UG+1"
Message-Id: <200310171258.11519.dev@sw.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_j86j/wOBcg9UG+1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> Yup.  The "invalidate_inodes-speedup-fixes" and "invalidate_inodes-speedup"
> patches were not so great and need to be reverted.
I found another bug in invalidate_inodes-speedup.patch
introduced by WLI when doing forward porting:

-			list_del(&inode->i_list);
+			list_del(&inode->i_sb_list);

first list_del should be kept!!!

Patch fixing this issue and hugetlbfs is attached.

Kirill

--Boundary-00=_j86j/wOBcg9UG+1
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="invalidate_inodes-speedup-fix2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="invalidate_inodes-speedup-fix2.patch"

--- linux-2.6.0-test7-mm1/fs/inode.c.ii	2003-10-17 12:26:59.000000000 +0400
+++ linux-2.6.0-test7-mm1/fs/inode.c	2003-10-17 12:55:54.000000000 +0400
@@ -303,6 +303,7 @@ static int invalidate_list(struct list_h
 		invalidate_inode_buffers(inode);
 		if (!atomic_read(&inode->i_count)) {
 			hlist_del_init(&inode->i_hash);
+			list_del(&inode->i_list);
 			list_del(&inode->i_sb_list);
 			list_add(&inode->i_list, dispose);
 			inode->i_state |= I_FREEING;
--- linux-2.6.0-test7-mm1/fs/hugetlbfs/inode.c.ii	2003-10-17 12:51:51.000000000 +0400
+++ linux-2.6.0-test7-mm1/fs/hugetlbfs/inode.c	2003-10-17 12:52:24.000000000 +0400
@@ -191,6 +191,7 @@ static void hugetlbfs_delete_inode(struc
 
 	hlist_del_init(&inode->i_hash);
 	list_del_init(&inode->i_list);
+	list_del_init(&inode->i_sb_list);
 	inode->i_state |= I_FREEING;
 	inodes_stat.nr_inodes--;
 	spin_unlock(&inode_lock);
@@ -233,6 +234,7 @@ static void hugetlbfs_forget_inode(struc
 	hlist_del_init(&inode->i_hash);
 out_truncate:
 	list_del_init(&inode->i_list);
+	list_del_init(&inode->i_sb_list);
 	inode->i_state |= I_FREEING;
 	inodes_stat.nr_inodes--;
 	spin_unlock(&inode_lock);

--Boundary-00=_j86j/wOBcg9UG+1--

