Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263827AbUD0HpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263827AbUD0HpH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 03:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263871AbUD0HpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 03:45:07 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:19337 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S263827AbUD0Ho7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 03:44:59 -0400
Date: Tue, 27 Apr 2004 01:44:55 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Junfeng Yang <yjf@stanford.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, mc@stanford.edu,
       Madanlal S Musuvathi <madan@stanford.edu>,
       "David L. Dill" <dill@cs.stanford.edu>
Subject: Re: [Ext2-devel] [CHECKER] warnings in fs/ext3/namei.c (2.4.19) where disk read errors get ignored, causing non-empty dir to be deleted
Message-ID: <20040427074455.GD30529@schnapps.adilger.int>
Mail-Followup-To: Junfeng Yang <yjf@stanford.edu>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net, mc@stanford.edu,
	Madanlal S Musuvathi <madan@stanford.edu>,
	"David L. Dill" <dill@cs.stanford.edu>
References: <Pine.GSO.4.44.0404262339360.7250-100000@elaine24.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0404262339360.7250-100000@elaine24.Stanford.EDU>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 26, 2004  23:41 -0700, Junfeng Yang wrote:
> We checked EXT3 filesystem on 2.4.19 recently and found 2 cases that look
> like bugs.  For both of the cases, disk read errors are ignored, which
> appears to cause a non-empty directory to be wrongly deleted or a dir to
> contain more than one entries with identical names.
> 
> I'm not sure if they are real bugs or not, so your confirmations
> /clarifications are appericated.

I don't consider this a bug, but rather a conscious decision on the part of
the developers.  If you are trying to delete a directory and it has read
errors, then it is better to let the unlink succeed than to refuse to unlink
the directory.

> ----------------------------------------------------------------------------
> [BUG] A non-empty dir may be deleted because ext3_read errors are ignored
> by ext3_find_entry.  empty_dir is called whenenver ext3_rmdir tries to
> remove a directory.
> 
> 
> static int empty_dir (struct inode * inode)
> {
> 			bh = ext3_bread (NULL, inode,
> 				offset >> EXT3_BLOCK_SIZE_BITS(sb), 0, &err);
> 			if (!bh) {
> #if 0
> 				ext3_error (sb, "empty_dir",
> 				"directory #%lu contains a hole at offset %lu",
> 					inode->i_ino, offset);
> #endif
> 				offset += sb->s_blocksize;
> ERROR --->			continue;
> 			}
> 			de = (struct ext3_dir_entry_2 *) bh->b_data;
> 		}

What is more of a bug is a few lines down.  The error return from
ext3_check_dir_entry() causes the rest of the directory to be skipped and
"1" returned instead of skipping that block/page and continuing to check
the rest of the directory.  With this if there is a read error anywhere
in the directory it is possible to rmdir the directory without actually
deleting entries that are returned by ls.

> ----------------------------------------------------------------------------
> [BUG] A dir may end up containing more than one entries with identical
> names because because disk read errors are ignored by ext3_find_entry.
> ext3_find_entry is called by lots of other ext3 functions (ext3_add_entry,
> ext3_unlink, ext3_rename)
> 
> static struct buffer_head * ext3_find_entry (struct dentry *dentry,
> 					struct ext3_dir_entry_2 ** res_dir)
> {
> .....
> 		if ((bh = bh_use[ra_ptr++]) == NULL)
> 			goto next;
> 		wait_on_buffer(bh);
> 		if (!buffer_uptodate(bh)) {
> 			/* read error, skip block & hope for the best */
> 			brelse(bh);
> ERROR --->		goto next;
> 		}

Again a conscious decision.  If a name is potentially inaccessible because
of an IO error it is better to allow the creation of a potentially duplicate
name than refuse creation of any new entries in the directory.  It's a matter
of allowing the filesystem to be used as well as possible in the face of
failures vs. just giving up and refusing to do anything.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

