Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934632AbWK1C5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934632AbWK1C5m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 21:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934633AbWK1C5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 21:57:42 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:17322 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S934632AbWK1C5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 21:57:41 -0500
Message-ID: <456BA59D.3060208@linux.vnet.ibm.com>
Date: Mon, 27 Nov 2006 18:57:33 -0800
From: suzuki <suzuki@linux.vnet.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: amitarora@in.ibm.com, "Vladimir V. Saveliev" <vs@namesys.com>,
       reiserfs-list@namesys.com, reiserfs-dev@namesys.com,
       lkml <linux-kernel@vger.kernel.org>, rdunlap@xenotime.net
Subject: Re: [BUG] Reiserfs panic while running fsstress due to multiple	truncate
 "safe links" for a file.
References: <445F2C95.4000604@in.ibm.com>	<20060730161348.94ecc5e0.akpm@osdl.org> <456B76CD.5000600@in.ibm.com> <20061127172646.0d6c4dd1.akpm@osdl.org>
In-Reply-To: <20061127172646.0d6c4dd1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 27 Nov 2006 15:37:49 -0800
> Suzuki <suzuki@in.ibm.com> wrote:
> 
> 
>>* Do not add save links for O_DIRECT writes.
>>
>>We add a save link for O_DIRECT writes to protect the i_size against the crashes before we actually finish the I/O. If we hit an -ENOSPC in aops->prepare_write(), we would do a truncate() to release the blocks which might have got initialized. Now the truncate would add another save link for the same inode causing a reiserfs panic for having multiple save links for the same inode.
>>
>>
> 
> 
> OK...
> 
> But how does this patch fix it?  It removes a lot of code - how come we
> don't need it any more?

We were adding save links for appending writes only. The links were 
removed once we finish the write operation successfully.

Now we don't add the save links at all.

May be Valdimir has better answers for this.

Thanks,

Suzuki

> 
> 
>>
>>Index: linux-2.6.19-rc1/fs/reiserfs/file.c
>>===================================================================
>>--- linux-2.6.19-rc1.orig/fs/reiserfs/file.c	2006-10-10 05:54:30.000000000 -0700
>>+++ linux-2.6.19-rc1/fs/reiserfs/file.c	2006-11-21 17:17:36.000000000 -0800
>>@@ -1306,56 +1306,8 @@
>> 			count = MAX_NON_LFS - (unsigned long)*ppos;
>> 	}
>>
>>-	if (file->f_flags & O_DIRECT) {	// Direct IO needs treatment
>>-		ssize_t result, after_file_end = 0;
>>-		if ((*ppos + count >= inode->i_size)
>>-		    || (file->f_flags & O_APPEND)) {
>>-			/* If we are appending a file, we need to put this savelink in here.
>>-			   If we will crash while doing direct io, finish_unfinished will
>>-			   cut the garbage from the file end. */
>>-			reiserfs_write_lock(inode->i_sb);
>>-			err =
>>-			    journal_begin(&th, inode->i_sb,
>>-					  JOURNAL_PER_BALANCE_CNT);
>>-			if (err) {
>>-				reiserfs_write_unlock(inode->i_sb);
>>-				return err;
>>-			}
>>-			reiserfs_update_inode_transaction(inode);
>>-			add_save_link(&th, inode, 1 /* Truncate */ );
>>-			after_file_end = 1;
>>-			err =
>>-			    journal_end(&th, inode->i_sb,
>>-					JOURNAL_PER_BALANCE_CNT);
>>-			reiserfs_write_unlock(inode->i_sb);
>>-			if (err)
>>-				return err;
>>-		}
>>-		result = do_sync_write(file, buf, count, ppos);
>>-
>>-		if (after_file_end) {	/* Now update i_size and remove the savelink */
>>-			struct reiserfs_transaction_handle th;
>>-			reiserfs_write_lock(inode->i_sb);
>>-			err = journal_begin(&th, inode->i_sb, 1);
>>-			if (err) {
>>-				reiserfs_write_unlock(inode->i_sb);
>>-				return err;
>>-			}
>>-			reiserfs_update_inode_transaction(inode);
>>-			mark_inode_dirty(inode);
>>-			err = journal_end(&th, inode->i_sb, 1);
>>-			if (err) {
>>-				reiserfs_write_unlock(inode->i_sb);
>>-				return err;
>>-			}
>>-			err = remove_save_link(inode, 1 /* truncate */ );
>>-			reiserfs_write_unlock(inode->i_sb);
>>-			if (err)
>>-				return err;
>>-		}
>>-
>>-		return result;
>>-	}
>>+	if (file->f_flags & O_DIRECT)
>>+		return do_sync_write(file, buf, count, ppos);
>>
>> 	if (unlikely((ssize_t) count < 0))
>> 		return -EINVAL;

