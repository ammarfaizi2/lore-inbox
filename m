Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262493AbVA0AnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbVA0AnQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbVA0ASL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:18:11 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:10921 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262337AbVAZWlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 17:41:17 -0500
Date: Wed, 26 Jan 2005 23:41:16 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: Andreas Gruenbacher <agruen@suse.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, jack@suse.cz
Subject: Re: 2.6.11-rc2/ext3 quota allocation bug on error path ...
Message-ID: <20050126224116.GA20720@mail.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Andreas Gruenbacher <agruen@suse.de>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, jack@suse.cz
References: <20050122155044.GA4573@mail.13thfloor.at> <1106764346.13004.232.camel@winden.suse.de> <20050126112430.2daf812d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050126112430.2daf812d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 11:24:30AM -0800, Andrew Morton wrote:
> Andreas Gruenbacher <agruen@suse.de> wrote:
> >
> > > +cleanup_dquot:
> >  > +	DQUOT_FREE_BLOCK(inode, 1);
> >  > +	goto cleanup;
> >  > +
> >  >  bad_block:
> >  >  	ext3_error(inode->i_sb, __FUNCTION__,
> >  >  		   "inode %ld: bad block %d", inode->i_ino,
> > 
> >  looks good. Can this please be added?
> 
> Yup.  But nobody has sent the equivalent ext2 fix yet?

hmm, what about this one?

diff -NurpP --minimal linux-2.6.11-rc2/fs/ext2/xattr.c linux-2.6.11-rc2-fixed/fs/ext2/xattr.c
--- linux-2.6.11-rc2/fs/ext2/xattr.c	2005-01-22 15:07:50 +0100
+++ linux-2.6.11-rc2-fixed/fs/ext2/xattr.c	2005-01-26 22:40:28 +0100
@@ -706,8 +706,11 @@ ext2_xattr_set2(struct inode *inode, str
 	inode->i_ctime = CURRENT_TIME_SEC;
 	if (IS_SYNC(inode)) {
 		error = ext2_sync_inode (inode);
-		if (error)
+		if (error) {
+			if (new_bh && new_bh != old_bh) 
+				DQUOT_FREE_BLOCK(inode, 1);
 			goto cleanup;
+		}
 	} else
 		mark_inode_dirty(inode);
 
@@ -748,7 +751,6 @@ ext2_xattr_set2(struct inode *inode, str
 
 cleanup:
 	brelse(new_bh);
-
 	return error;
 }
 


and here the ext3 fix again:


Signed-off-by: Herbert Pötzl <herbert@13thfloor.at>

diff -NurpP --minimal linux-2.6.11-rc2/fs/ext3/xattr.c linux-2.6.11-rc2-fixed/fs/ext3/xattr.c
--- linux-2.6.11-rc2/fs/ext3/xattr.c	2005-01-22 15:07:50 +0100
+++ linux-2.6.11-rc2-fixed/fs/ext3/xattr.c	2005-01-26 22:19:29 +0100
@@ -773,7 +773,7 @@ inserted:
 				error = ext3_journal_get_write_access(handle,
 								      new_bh);
 				if (error)
-					goto cleanup;
+					goto cleanup_dquot;
 				lock_buffer(new_bh);
 				BHDR(new_bh)->h_refcount = cpu_to_le32(1 +
 					le32_to_cpu(BHDR(new_bh)->h_refcount));
@@ -783,7 +783,7 @@ inserted:
 				error = ext3_journal_dirty_metadata(handle,
 								    new_bh);
 				if (error)
-					goto cleanup;
+					goto cleanup_dquot;
 			}
 			mb_cache_entry_release(ce);
 			ce = NULL;
@@ -844,6 +844,10 @@ cleanup:
 
 	return error;
 
+cleanup_dquot:
+	DQUOT_FREE_BLOCK(inode, 1);
+	goto cleanup;
+
 bad_block:
 	ext3_error(inode->i_sb, __FUNCTION__,
 		   "inode %ld: bad block %d", inode->i_ino,


best,
Herbert
