Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265152AbSKFIhw>; Wed, 6 Nov 2002 03:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265999AbSKFIhw>; Wed, 6 Nov 2002 03:37:52 -0500
Received: from packet.digeo.com ([12.110.80.53]:41905 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265152AbSKFIhv>;
	Wed, 6 Nov 2002 03:37:51 -0500
Message-ID: <3DC8D665.40CA099A@digeo.com>
Date: Wed, 06 Nov 2002 00:44:21 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: chrisl@vmware.com
CC: Jeremy Fitzhardinge <jeremy@goop.org>,
       Ext2 devel <ext2-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix bug in ext3 htree rename: doesn't delete old name, 
 leaves ino with bad nlink
References: <1036471670.21855.15.camel@ixodes.goop.org> <20021105212415.GB1472@vmware.com> <20021106082500.GA3680@vmware.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Nov 2002 08:44:22.0164 (UTC) FILETIME=[B3F27D40:01C28570]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chrisl@vmware.com wrote:
> 
> This should fix the ext3 htree rename problem. Please try it again.
> 

The 2.5 version....


--- 25/fs/ext3/namei.c~ext3-rename-fix	Wed Nov  6 00:36:43 2002
+++ 25-akpm/fs/ext3/namei.c	Wed Nov  6 00:41:20 2002
@@ -2160,7 +2160,7 @@ static int ext3_rename (struct inode * o
 
 	lock_kernel();
 	handle = ext3_journal_start(old_dir, 2 * EXT3_DATA_TRANS_BLOCKS +
-			 		EXT3_INDEX_EXTRA_TRANS_BLOCKS + 2);
+			 		EXT3_INDEX_EXTRA_TRANS_BLOCKS + 3);
 	if (IS_ERR(handle)) {
 		unlock_kernel();
 		return PTR_ERR(handle);
@@ -2237,7 +2237,30 @@ static int ext3_rename (struct inode * o
 	/*
 	 * ok, that's it
 	 */
-	ext3_delete_entry(handle, old_dir, old_de, old_bh);
+	retval = ext3_delete_entry(handle, old_dir, old_de, old_bh);
+	if (retval == -ENOENT) {
+		/*
+		 * old_de can be moved during ext3_add_entry.
+		 */
+		struct buffer_head *old_bh2;
+		struct ext3_dir_entry_2 *old_de2;
+		old_bh2 = ext3_find_entry(old_dentry, &old_de2);
+		if (old_bh2) {
+			retval = ext3_delete_entry(handle, old_dir,
+						old_de2, old_bh2);
+			brelse(old_bh2);
+		} else {
+			ext3_warning(old_dir->i_sb, "ext3_rename",
+				"Deleting old file not found (%lu), %d",
+				old_dir->i_ino, old_dir->i_nlink);
+		}
+	}
+
+	if (retval) {
+		ext3_warning(old_dir->i_sb, "ext3_rename",
+				"Deleting old file (%lu), %d, error=%d",
+				old_dir->i_ino, old_dir->i_nlink, retval);
+	}
 
 	if (new_inode) {
 		new_inode->i_nlink--;

_
