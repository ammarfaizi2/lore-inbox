Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758616AbWK0Xh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758616AbWK0Xh6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 18:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758617AbWK0Xh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 18:37:58 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:53680 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1758616AbWK0Xh5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 18:37:57 -0500
Message-ID: <456B76CD.5000600@in.ibm.com>
Date: Mon, 27 Nov 2006 15:37:49 -0800
From: Suzuki <suzuki@in.ibm.com>
Organization: IBM Linux Technology Center
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060413 Red Hat/1.7.13-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: amitarora@in.ibm.com, "Vladimir V. Saveliev" <vs@namesys.com>,
       reiserfs-list@namesys.com, reiserfs-dev@namesys.com,
       lkml <linux-kernel@vger.kernel.org>, rdunlap@xenotime.net
Subject: Re: [BUG] Reiserfs panic while running fsstress due to multiple truncate
 "safe links" for a file.
References: <445F2C95.4000604@in.ibm.com> <20060730161348.94ecc5e0.akpm@osdl.org>
In-Reply-To: <20060730161348.94ecc5e0.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------010702040207040904090204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010702040207040904090204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> On Mon, 08 May 2006 17:03:41 +0530
> Suzuki <suzuki@in.ibm.com> wrote:
> 
> 
>>Resending, since there were no responses to the earlier post.
>>
>>Hi,
>>
>>
>>I was working on a reiserfs panic with 2.6.17-rc3, while running fs
>>stress tests.
>>
>>The panic message looked like :
>>
>>" REISERFS: panic (device Null superblock): reiserfs[4248]: assertion
>>!(truncate && (REISERFS_I(inode)->i_flags & i_link_saved_truncate_mask)
>>) failed at fs/reiserfs/super.c:328:add_save_link: saved link already re
>>exists for truncated inode 13b5a "
>>
>>------ Summary of the problem -----------
>>
>>Reiserfs uses "safe links" ( directory entries with some special key
>>value) to keep track of "truncated" or "unlinked" files to ensure
>>integrity across crashes.
>>
>>Whenever there is a truncate/unlink on a file, Reiserfs creates a safe
>>link for the same and deletes the same once the operation is complete.
>>If the machine crashes before committing the operation, whenever the fs
>>is mounted next time, the fs will look for the saved links ( easy to
>>find out, since they have special key) and commit the operation that was
>>unfinished.
>>
>>
>>The problem here occurs as follows:
>>
>>  Whenever there is an extending DIO write operation, the fs would
>>create a safe link so as to ensure the file size consistent, if there is
>>crash in between the DIO. This will be deleted once the write operation
>>finishes.
>>
>>  If the DIO write happens to go through a "HOLE" region in the file, it
>>will fall into normal "buffered write", which is done  through the
>>address space operations prepare_write() & commit_write(). Now, the
>>prepare_write() might allocate blocks for the file (if needed). So if
>>there is some error at a later point (say ENOSPC) in prepare_write(), we
>>need to discard the allocated blocks. This is done by calling
>>"vmtruncate()" on the file. This call leads to reiserfs specific
>>truncate, which would try to add a save link for the file.
>>
>>This addition causes a reiserfs_panic, since there is already a "save
>>link" stored for the file.
>>
>>
>>I have a simple testcase to reproduce the problem, which does the same 
>>as described above. I will attach it if required.
>>
>>Any thoughts on how to fix this ?
>>
> 
> 
> Did we end up fixing this?

Finally, we were able to verify this on 2.6.18-rc7. Sorry for the delay.

Vladimir wrote :

     "I am not sure why safe link is needed for write. Maybe one who 
added that still remembers why that was done and can explain, please? "


The patch attached by Vladimir has been modified to fit into the current 
level.

The patch is on 2.6.19-rc1.

Thanks,

-Suzuki

> 
> Thanks.


--------------010702040207040904090204
Content-Type: text/x-patch;
 name="reiserfs-no-save-links-on-write.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reiserfs-no-save-links-on-write.diff"

* Do not add save links for O_DIRECT writes.  

We add a save link for O_DIRECT writes to protect the i_size against the crashes before we actually finish the I/O. If we hit an -ENOSPC in aops->prepare_write(), we would do a truncate() to release the blocks which might have got initialized. Now the truncate would add another save link for the same inode causing a reiserfs panic for having multiple save links for the same inode.


Signed-off-by:  Vladimir V. Saveliev <vs@namesys.com>
Signed-off-by:  Amit Arora <amitarora@in.ibm.com>
Signed-off-by:  Suzuki K P <suzuki@in.ibm.com>


Index: linux-2.6.19-rc1/fs/reiserfs/file.c
===================================================================
--- linux-2.6.19-rc1.orig/fs/reiserfs/file.c	2006-10-10 05:54:30.000000000 -0700
+++ linux-2.6.19-rc1/fs/reiserfs/file.c	2006-11-21 17:17:36.000000000 -0800
@@ -1306,56 +1306,8 @@
 			count = MAX_NON_LFS - (unsigned long)*ppos;
 	}
 
-	if (file->f_flags & O_DIRECT) {	// Direct IO needs treatment
-		ssize_t result, after_file_end = 0;
-		if ((*ppos + count >= inode->i_size)
-		    || (file->f_flags & O_APPEND)) {
-			/* If we are appending a file, we need to put this savelink in here.
-			   If we will crash while doing direct io, finish_unfinished will
-			   cut the garbage from the file end. */
-			reiserfs_write_lock(inode->i_sb);
-			err =
-			    journal_begin(&th, inode->i_sb,
-					  JOURNAL_PER_BALANCE_CNT);
-			if (err) {
-				reiserfs_write_unlock(inode->i_sb);
-				return err;
-			}
-			reiserfs_update_inode_transaction(inode);
-			add_save_link(&th, inode, 1 /* Truncate */ );
-			after_file_end = 1;
-			err =
-			    journal_end(&th, inode->i_sb,
-					JOURNAL_PER_BALANCE_CNT);
-			reiserfs_write_unlock(inode->i_sb);
-			if (err)
-				return err;
-		}
-		result = do_sync_write(file, buf, count, ppos);
-
-		if (after_file_end) {	/* Now update i_size and remove the savelink */
-			struct reiserfs_transaction_handle th;
-			reiserfs_write_lock(inode->i_sb);
-			err = journal_begin(&th, inode->i_sb, 1);
-			if (err) {
-				reiserfs_write_unlock(inode->i_sb);
-				return err;
-			}
-			reiserfs_update_inode_transaction(inode);
-			mark_inode_dirty(inode);
-			err = journal_end(&th, inode->i_sb, 1);
-			if (err) {
-				reiserfs_write_unlock(inode->i_sb);
-				return err;
-			}
-			err = remove_save_link(inode, 1 /* truncate */ );
-			reiserfs_write_unlock(inode->i_sb);
-			if (err)
-				return err;
-		}
-
-		return result;
-	}
+	if (file->f_flags & O_DIRECT) 
+		return do_sync_write(file, buf, count, ppos);
 
 	if (unlikely((ssize_t) count < 0))
 		return -EINVAL;

--------------010702040207040904090204--
