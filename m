Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWELHsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWELHsR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 03:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbWELHsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 03:48:17 -0400
Received: from chen.mtu.ru ([195.34.34.232]:10768 "EHLO chen.mtu.ru")
	by vger.kernel.org with ESMTP id S1751060AbWELHsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 03:48:16 -0400
Subject: Re: [BUG] Reiserfs: reiserfs_panic while running fs stress tests
From: "Vladimir V. Saveliev" <vs@namesys.com>
To: Suzuki <suzuki@in.ibm.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, reiserfs-dev@namesys.com,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com, akpm@osdl.org,
       suparna@in.ibm.com, amitarora@in.ibm.com
In-Reply-To: <44642F0E.4050500@in.ibm.com>
References: <445ADA05.5000801@in.ibm.com>
	 <20060511105006.e4811957.rdunlap@xenotime.net>
	 <44642F0E.4050500@in.ibm.com>
Content-Type: multipart/mixed; boundary="=-kj5jbvq6/uO2FTm10odP"
Date: Fri, 12 May 2006 11:33:43 +0400
Message-Id: <1147419223.8001.5.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kj5jbvq6/uO2FTm10odP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello

On Fri, 2006-05-12 at 12:15 +0530, Suzuki wrote:
> Randy.Dunlap wrote:
> > On Fri, 05 May 2006 10:22:21 +0530 Suzuki wrote:
> > 
> > 
> >>Hi,
> >>
> >>
> >>I was working on a reiserfs panic with 2.6.17-rc3, while running fs
> >>stress tests.
> > 
> > 
> > Hi,
> > What test(s) do you use?
> 
> The problem was initially hit while running the following tests 
> simultaneously..
> IOZone, bonnie++, dbench, fs_inod, fs_maim, fsstress, fsx_linux, 
> postmark, tiobench.
> 
> As I had mentioned in my post, I have a simple testcase to trigger the 
> panic which can hit the code path explained below.
> 
> The root cause of the problem is (as mentioned in the earlier post):
> 
>   Whenever there is an extending DIO write operation, the fs would
> create a safe link so as to ensure the file size consistent, if there is
> crash in between the DIO. This will be deleted once the write operation
> finishes.
> 

I am not sure why safe link is needed for write. Maybe one who added
that still remembers why that was done and can explain, please?

Suzuki, would you please try the attached patch?



--=-kj5jbvq6/uO2FTm10odP
Content-Disposition: attachment; filename=reiserfs-dont-use-safelink-on-write.patch
Content-Type: text/x-patch; name=reiserfs-dont-use-safelink-on-write.patch; charset=utf-8
Content-Transfer-Encoding: 7bit


diff -puN fs/reiserfs/file.c~reiserfs-dont-use-safelink-on-write fs/reiserfs/file.c
--- linux-2.6.17-rc3/fs/reiserfs/file.c~reiserfs-dont-use-safelink-on-write	2006-05-12 11:28:16.000000000 +0400
+++ linux-2.6.17-rc3-vs/fs/reiserfs/file.c	2006-05-12 11:29:16.000000000 +0400
@@ -1305,54 +1305,7 @@ static ssize_t reiserfs_file_write(struc
 	}
 
 	if (file->f_flags & O_DIRECT) {	// Direct IO needs treatment
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
-		result = generic_file_write(file, buf, count, ppos);
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
+	  	return generic_file_write(file, buf, count, ppos);
 	}
 
 	if (unlikely((ssize_t) count < 0))

_

--=-kj5jbvq6/uO2FTm10odP--

