Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263815AbUD0GmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263815AbUD0GmD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 02:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbUD0GmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 02:42:03 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.120]:5861 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S263815AbUD0Gl7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 02:41:59 -0400
Date: Mon, 26 Apr 2004 23:41:55 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>, <mc@stanford.edu>,
       Madanlal S Musuvathi <madan@stanford.edu>,
       "David L. Dill" <dill@cs.stanford.edu>
Subject: [CHECKER] warnings in fs/ext3/namei.c (2.4.19) where disk read errors
 get ignored, causing non-empty dir to be deleted
Message-ID: <Pine.GSO.4.44.0404262339360.7250-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We checked EXT3 filesystem on 2.4.19 recently and found 2 cases that look
like bugs.  For both of the cases, disk read errors are ignored, which
appears to cause a non-empty directory to be wrongly deleted or a dir to
contain more than one entries with identical names.

I'm not sure if they are real bugs or not, so your confirmations
/clarifications are appericated.

Please let me know if anything isn't clear

all warnings are in file fs/ext3/namei.c

----------------------------------------------------------------------------
[BUG] A non-empty dir may be deleted because ext3_read errors are ignored
by ext3_find_entry.  empty_dir is called whenenver ext3_rmdir tries to
remove a directory.


static int empty_dir (struct inode * inode)
{
			bh = ext3_bread (NULL, inode,
				offset >> EXT3_BLOCK_SIZE_BITS(sb), 0, &err);
			if (!bh) {
#if 0
				ext3_error (sb, "empty_dir",
				"directory #%lu contains a hole at offset %lu",
					inode->i_ino, offset);
#endif
				offset += sb->s_blocksize;
ERROR --->			continue;
			}
			de = (struct ext3_dir_entry_2 *) bh->b_data;
		}

----------------------------------------------------------------------------
[BUG] A dir may end up containing more than one entries with identical
names because because disk read errors are ignored by ext3_find_entry.
ext3_find_entry is called by lots of other ext3 functions (ext3_add_entry,
ext3_unlink, ext3_rename)

static struct buffer_head * ext3_find_entry (struct dentry *dentry,
					struct ext3_dir_entry_2 ** res_dir)
{
.....
		if ((bh = bh_use[ra_ptr++]) == NULL)
			goto next;
		wait_on_buffer(bh);
		if (!buffer_uptodate(bh)) {
			/* read error, skip block & hope for the best */
			brelse(bh);
ERROR --->		goto next;
		}




