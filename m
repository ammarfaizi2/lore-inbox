Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbTHSSmB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbTHSSmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:42:01 -0400
Received: from bozo.vmware.com ([65.113.40.130]:11282 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S272356AbTHSS0R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 14:26:17 -0400
Date: Tue, 19 Aug 2003 11:23:20 -0700
From: chrisl@vmware.com
To: Andrew Morton <akpm@osdl.org>
Cc: azarah@gentoo.org, linux-kernel@vger.kernel.org, adilger@clusterfs.com,
       ext3-users@redhat.com, x86-kernel@gentoo.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] fix for htree corruption. Was: [2.6] Perl weirdness with ext3 and HTREE
Message-ID: <20030819182320.GA1475@vmware.com>
References: <68F326C497FDB743B5F844B776C9B146097700@pa-exch4.vmware.com> <1060208887.12477.31.camel@nosferatu.lan> <20030819104026.GA25402@vmware.com> <20030819035506.28f72a6a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030819035506.28f72a6a.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 03:55:06AM -0700, Andrew Morton wrote:
> chrisl@vmware.com wrote:
> 
> Could you please regenerate a full, single diff against a known kernel
> version?  That patch generated 100% rejects for me...
> 
> 
Sorry for that. Here is the patch again. It is against the 2.6-test3.
It also apply cleanly on current BK tree.

Chris


===== fs/ext3/namei.c 1.44 vs edited =====
--- 1.44/fs/ext3/namei.c	Sun Jun 29 23:49:04 2003
+++ edited/fs/ext3/namei.c	Tue Aug 19 03:28:52 2003
@@ -1304,7 +1304,8 @@
 	data1 = bh2->b_data;
 
 	/* The 0th block becomes the root, move the dirents out */
-	de = (struct ext3_dir_entry_2 *) &root->info;
+	de = &root->dotdot;
+	de = (struct ext3_dir_entry_2 *) ((char *)de + de->rec_len);
 	len = ((char *) root) + blocksize - (char *) de;
 	memcpy (data1, de, len);
 	de = (struct ext3_dir_entry_2 *) data1;
@@ -2006,9 +2007,9 @@
 	 * recovery. */
 	inode->i_size = 0;
 	ext3_orphan_add(handle, inode);
+	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	ext3_mark_inode_dirty(handle, inode);
 	dir->i_nlink--;
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
 	ext3_update_dx_flag(dir);
 	ext3_mark_inode_dirty(handle, dir);
 
@@ -2060,8 +2061,8 @@
 	inode->i_nlink--;
 	if (!inode->i_nlink)
 		ext3_orphan_add(handle, inode);
-	ext3_mark_inode_dirty(handle, inode);
 	inode->i_ctime = dir->i_ctime;
+	ext3_mark_inode_dirty(handle, inode);
 	retval = 0;
 
 end_unlink:
@@ -2220,7 +2221,6 @@
 			goto end_rename;
 	} else {
 		BUFFER_TRACE(new_bh, "get write access");
-		BUFFER_TRACE(new_bh, "get_write_access");
 		ext3_journal_get_write_access(handle, new_bh);
 		new_de->inode = le32_to_cpu(old_inode->i_ino);
 		if (EXT3_HAS_INCOMPAT_FEATURE(new_dir->i_sb,


