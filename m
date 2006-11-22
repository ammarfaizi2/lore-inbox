Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031446AbWKVBZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031446AbWKVBZo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 20:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031448AbWKVBZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 20:25:44 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:37095 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1031446AbWKVBZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 20:25:43 -0500
Message-ID: <4563A6AF.6080609@in.ibm.com>
Date: Tue, 21 Nov 2006 17:23:59 -0800
From: Suzuki <suzuki@in.ibm.com>
Organization: IBM Linux Technology Center
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060413 Red Hat/1.7.13-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Vladimir V. Saveliev" <vs@namesys.com>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, reiserfs-dev@namesys.com,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com, akpm@osdl.org,
       suparna@in.ibm.com, amitarora@in.ibm.com
Subject: Re: [BUG] Reiserfs: reiserfs_panic while running fs stress tests
References: <445ADA05.5000801@in.ibm.com>	 <20060511105006.e4811957.rdunlap@xenotime.net>	 <44642F0E.4050500@in.ibm.com> <1147419223.8001.5.camel@tribesman.namesys.com>
In-Reply-To: <1147419223.8001.5.camel@tribesman.namesys.com>
Content-Type: multipart/mixed;
 boundary="------------030002090807020204050307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030002090807020204050307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Vladimir V. Saveliev wrote:
> Hello
> 
> On Fri, 2006-05-12 at 12:15 +0530, Suzuki wrote:
> 
>>Randy.Dunlap wrote:
>>
>>>On Fri, 05 May 2006 10:22:21 +0530 Suzuki wrote:
>>>
>>>
>>>
>>>>Hi,
>>>>
>>>>
>>>>I was working on a reiserfs panic with 2.6.17-rc3, while running fs
>>>>stress tests.
>>>
>>>
>>>Hi,
>>>What test(s) do you use?
>>
>>The problem was initially hit while running the following tests 
>>simultaneously..
>>IOZone, bonnie++, dbench, fs_inod, fs_maim, fsstress, fsx_linux, 
>>postmark, tiobench.
>>
>>As I had mentioned in my post, I have a simple testcase to trigger the 
>>panic which can hit the code path explained below.
>>
>>The root cause of the problem is (as mentioned in the earlier post):
>>
>>  Whenever there is an extending DIO write operation, the fs would
>>create a safe link so as to ensure the file size consistent, if there is
>>crash in between the DIO. This will be deleted once the write operation
>>finishes.
>>
> 
> 
> I am not sure why safe link is needed for write. Maybe one who added
> that still remembers why that was done and can explain, please?
> 
> Suzuki, would you please try the attached patch?

We had no luck in reproducing the issue until recently. This was again 
hit with 2.6.18-rc7. The patch (with  appropriate changes to match the 
current) has been verified to resolve the issue. Attached here is the 
patch which fits the current level.

Thanks,

Suzuki
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> 
> diff -puN fs/reiserfs/file.c~reiserfs-dont-use-safelink-on-write fs/reiserfs/file.c
> --- linux-2.6.17-rc3/fs/reiserfs/file.c~reiserfs-dont-use-safelink-on-write	2006-05-12 11:28:16.000000000 +0400
> +++ linux-2.6.17-rc3-vs/fs/reiserfs/file.c	2006-05-12 11:29:16.000000000 +0400
> @@ -1305,54 +1305,7 @@ static ssize_t reiserfs_file_write(struc
>  	}
>  
>  	if (file->f_flags & O_DIRECT) {	// Direct IO needs treatment
> -		ssize_t result, after_file_end = 0;
> -		if ((*ppos + count >= inode->i_size)
> -		    || (file->f_flags & O_APPEND)) {
> -			/* If we are appending a file, we need to put this savelink in here.
> -			   If we will crash while doing direct io, finish_unfinished will
> -			   cut the garbage from the file end. */
> -			reiserfs_write_lock(inode->i_sb);
> -			err =
> -			    journal_begin(&th, inode->i_sb,
> -					  JOURNAL_PER_BALANCE_CNT);
> -			if (err) {
> -				reiserfs_write_unlock(inode->i_sb);
> -				return err;
> -			}
> -			reiserfs_update_inode_transaction(inode);
> -			add_save_link(&th, inode, 1 /* Truncate */ );
> -			after_file_end = 1;
> -			err =
> -			    journal_end(&th, inode->i_sb,
> -					JOURNAL_PER_BALANCE_CNT);
> -			reiserfs_write_unlock(inode->i_sb);
> -			if (err)
> -				return err;
> -		}
> -		result = generic_file_write(file, buf, count, ppos);
> -
> -		if (after_file_end) {	/* Now update i_size and remove the savelink */
> -			struct reiserfs_transaction_handle th;
> -			reiserfs_write_lock(inode->i_sb);
> -			err = journal_begin(&th, inode->i_sb, 1);
> -			if (err) {
> -				reiserfs_write_unlock(inode->i_sb);
> -				return err;
> -			}
> -			reiserfs_update_inode_transaction(inode);
> -			mark_inode_dirty(inode);
> -			err = journal_end(&th, inode->i_sb, 1);
> -			if (err) {
> -				reiserfs_write_unlock(inode->i_sb);
> -				return err;
> -			}
> -			err = remove_save_link(inode, 1 /* truncate */ );
> -			reiserfs_write_unlock(inode->i_sb);
> -			if (err)
> -				return err;
> -		}
> -
> -		return result;
> +	  	return generic_file_write(file, buf, count, ppos);
>  	}
>  
>  	if (unlikely((ssize_t) count < 0))
> 
> _


--------------030002090807020204050307
Content-Type: text/x-patch;
 name="reiserfs-no-save-links-on-write.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reiserfs-no-save-links-on-write.diff"

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

--------------030002090807020204050307--
