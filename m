Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317545AbSFEEKt>; Wed, 5 Jun 2002 00:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317546AbSFEEKs>; Wed, 5 Jun 2002 00:10:48 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:15595 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S317545AbSFEEKq>; Wed, 5 Jun 2002 00:10:46 -0400
Message-ID: <3CFD8E42.7000703@didntduck.org>
Date: Wed, 05 Jun 2002 00:06:26 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs/inode.c list_del_init
Content-Type: multipart/mixed;
 boundary="------------020805000108010003010602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020805000108010003010602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

A few cases of list_del(x) + INIT_LIST_HEAD(x) crept in recently which 
can be replaced with list_del_init(x).

--------------020805000108010003010602
Content-Type: text/plain;
 name="inode-list-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="inode-list-1"

diff -urN linux-bk/fs/inode.c linux/fs/inode.c
--- linux-bk/fs/inode.c	Tue Jun  4 23:54:33 2002
+++ linux/fs/inode.c	Tue Jun  4 23:57:37 2002
@@ -390,8 +390,7 @@
 		if (atomic_read(&inode->i_count))
 			continue;
 		list_del(tmp);
-		list_del(&inode->i_hash);
-		INIT_LIST_HEAD(&inode->i_hash);
+		list_del_init(&inode->i_hash);
 		list_add(tmp, freeable);
 		inode->i_state |= I_FREEING;
 		count++;
@@ -777,8 +776,7 @@
 void remove_inode_hash(struct inode *inode)
 {
 	spin_lock(&inode_lock);
-	list_del(&inode->i_hash);
-	INIT_LIST_HEAD(&inode->i_hash);
+	list_del_init(&inode->i_hash);
 	spin_unlock(&inode_lock);
 }
 
@@ -786,10 +784,8 @@
 {
 	struct super_operations *op = inode->i_sb->s_op;
 
-	list_del(&inode->i_hash);
-	INIT_LIST_HEAD(&inode->i_hash);
-	list_del(&inode->i_list);
-	INIT_LIST_HEAD(&inode->i_list);
+	list_del_init(&inode->i_hash);
+	list_del_init(&inode->i_list);
 	inode->i_state|=I_FREEING;
 	inodes_stat.nr_inodes--;
 	spin_unlock(&inode_lock);

--------------020805000108010003010602--

