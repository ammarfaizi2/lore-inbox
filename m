Return-Path: <linux-kernel-owner+w=401wt.eu-S1751194AbXAOSTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbXAOSTY (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 13:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbXAOSTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 13:19:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46041 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194AbXAOSTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 13:19:22 -0500
Message-ID: <45ABC572.2070206@redhat.com>
Date: Mon, 15 Jan 2007 12:18:26 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
MIME-Version: 1.0
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext4 development <linux-ext4@vger.kernel.org>
CC: dmonakhov@sw.ru, alex@clusterfs.com, Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH] return ENOENT from ext3_link when racing with unlink
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An update from the earlier thread, 
[PATCH] [RFC] remove ext3 inode from orphan list when link and unlink race

I think this is better than the original idea of trying to handle the race;
I've seen that the orphan inode list can get corrupted, but there may well
be other implications of the race which haven't yet been exposed.  I think
it's safer to simply return -ENOENT in this race window, and avoid other
potential problems.  Anything wrong with this?

Thanks for the comments suggesting this approach in the prior thread.

Thanks,

-Eric

---

Return -ENOENT from ext[34]_link if we've raced with unlink and
i_nlink is 0.  Doing otherwise has the potential to corrupt the
orphan inode list, because we'd wind up with an inode with a
non-zero link count on the list, and it will never get properly
cleaned up & removed from the orphan list before it is freed.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Index: linux-2.6.19/fs/ext3/namei.c
===================================================================
--- linux-2.6.19.orig/fs/ext3/namei.c
+++ linux-2.6.19/fs/ext3/namei.c
@@ -2191,6 +2191,8 @@ static int ext3_link (struct dentry * ol
 
 	if (inode->i_nlink >= EXT3_LINK_MAX)
 		return -EMLINK;
+	if (inode->i_nlink == 0)
+		return -ENOENT;
 
 retry:
 	handle = ext3_journal_start(dir, EXT3_DATA_TRANS_BLOCKS(dir->i_sb) +
Index: linux-2.6.19/fs/ext4/namei.c
===================================================================
--- linux-2.6.19.orig/fs/ext4/namei.c
+++ linux-2.6.19/fs/ext4/namei.c
@@ -2189,6 +2189,8 @@ static int ext4_link (struct dentry * ol
 
 	if (inode->i_nlink >= EXT4_LINK_MAX)
 		return -EMLINK;
+	if (inode->i_nlink == 0)
+		return -ENOENT;
 
 retry:
 	handle = ext4_journal_start(dir, EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +


