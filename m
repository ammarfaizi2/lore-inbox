Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262565AbVA0KoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262565AbVA0KoT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 05:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbVA0Kms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 05:42:48 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:31376 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262571AbVA0Kjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 05:39:49 -0500
Date: Thu, 27 Jan 2005 11:39:42 +0100
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@osdl.org>, Andreas Gruenbacher <agruen@suse.de>,
       Herbert Poetzl <herbert@13thfloor.at>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: 2.6.11-rc2/ext3 quota allocation bug on error path ...
Message-ID: <20050127103942.GA18556@atrey.karlin.mff.cuni.cz>
References: <20050122155044.GA4573@mail.13thfloor.at> <1106764346.13004.232.camel@winden.suse.de> <20050126112430.2daf812d.akpm@osdl.org> <20050126224116.GA20720@mail.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050126224116.GA20720@mail.13thfloor.at>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Jan 26, 2005 at 11:24:30AM -0800, Andrew Morton wrote:
> > Andreas Gruenbacher <agruen@suse.de> wrote:
> > >
> > > > +cleanup_dquot:
> > >  > +	DQUOT_FREE_BLOCK(inode, 1);
> > >  > +	goto cleanup;
> > >  > +
> > >  >  bad_block:
> > >  >  	ext3_error(inode->i_sb, __FUNCTION__,
> > >  >  		   "inode %ld: bad block %d", inode->i_ino,
> > > 
> > >  looks good. Can this please be added?
> > 
> > Yup.  But nobody has sent the equivalent ext2 fix yet?
> 
> hmm, what about this one?
  I have already made a fix and sent it to Andreas and linux-fsdevel.
For ext2 it's actually a bit more complicated because ext2_sync_inode()
can return with ENOSPC (because do_writepages() need not be able to
write the dirty data of the inode) but inode would be written and hence
in that case we should not release the quota (and we should release the
old xattr block properly). Andreas proposed to just call write_inode()
instead of ext2_sync_inode() to avoid the ENOSPC case but then we might
end up with inconsistency between inode metadata and indirect blocks for
SYNC inode (though the only way I see how this can happen is that we
race against file write and the short time inconsistency might be
bearable...).
  I send a combination of mine and Herbert's patch.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

Fix a subtle bug in error handling of ext2 xattrs. When ext2_sync_inode() fails
because of ENOSPC (it could not write inode's dirty data) we want to keep
xattrs in a consistent state and release the old block properly.

Signed-off-by: Jan Kara <jack@suse.cz>

--- linux/fs/ext2/xattr.c	2005-01-27 12:56:25.782729816 +0100
+++ linux/fs/ext2/xattr.c	2005-01-27 13:14:21.196242112 +0100
@@ -706,8 +706,14 @@
 	inode->i_ctime = CURRENT_TIME_SEC;
 	if (IS_SYNC(inode)) {
 		error = ext2_sync_inode (inode);
-		if (error)
+		/* In case sync failed due to ENOSPC the inode was actually
+		 * written (only some dirty data were not) so we just proceed
+		 * as if nothing happened and cleanup the unused block */
+		if (error && error != ENOSPC) {
+			if (new_bh && new_bh != old_bh)
+				DQUOT_FREE_BLOCK(inode, 1);
 			goto cleanup;
+		}
 	} else
 		mark_inode_dirty(inode);
 
