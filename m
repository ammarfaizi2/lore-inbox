Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbVHROgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbVHROgy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 10:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbVHROgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 10:36:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:11723 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932233AbVHROgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 10:36:53 -0400
Date: Thu, 18 Aug 2005 16:36:52 +0200
From: Jan Kara <jack@suse.cz>
To: "Vladimir V. Saveliev" <vs@namesys.com>
Cc: Tarmo =?iso-8859-2?Q?T=E4nav?= <tarmo@itech.ee>, Jan Kara <jack@suse.cz>,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com, mason@suse.com,
       jeffm@suse.com, grev@namesys.com
Subject: Re: BUG: reiserfs+acl+quota deadlock
Message-ID: <20050818143652.GH29138@atrey.karlin.mff.cuni.cz>
References: <1123643111.27819.23.camel@localhost> <20050810130009.GE22112@atrey.karlin.mff.cuni.cz> <1123684298.14562.4.camel@localhost> <20050810144024.GA18584@atrey.karlin.mff.cuni.cz> <42FCB873.8070900@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <42FCB873.8070900@namesys.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

> Jan Kara wrote:
> >>Tried the attached patch but it changed nothing, I trying to create
> >>a new file as a user whose quota grace time has ran out will still
> >>cause everything accessing the users homedir (the one with the quota)
> >>to hang in D state.
> >>
> >>Also note that the bug I reported only exists when acl is also
> >>enabled (does not have to be used). And although my kernel is not
> >>built with debug (or reiserfs debug) support, I don't get any
> >>oopses or reiserfs errors.. it just hangs.
> >
> 
> It looks like the problem is that reiserfs_new_inode can be called either 
> having xattrs locked or not.
> It does unlocking/locking xattrs on error handling path, but has no idea 
> about whether
> xattrs are locked of not.
> The attached patch seems to fix the problem.
> I am not sure whether it is correct way to fix this problem, though.
  I've already fixed this problem and Andrew accepted the patch into
-mm. I took a bit different approach but yours might be better in a long
run (mine is just a one liner). The patch is attached if you're
interested.

								Honza
--
Jan Kara <jack@suse.cz>
SuSE CR Labs

--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reiser-2.6.13-rc6-2-xattr_fix.diff"

When i_acl_default is set to some error we do not hold the lock (hence we are
not allowed to drop it and reacquire later).

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.13-rc6-1-reiser_create_fix/fs/reiserfs/inode.c linux-2.6.13-rc6-2-reiser_xattr_fix/fs/reiserfs/inode.c
--- linux-2.6.13-rc6-1-reiser_create_fix/fs/reiserfs/inode.c	2005-08-14 17:10:21.000000000 +0200
+++ linux-2.6.13-rc6-2-reiser_xattr_fix/fs/reiserfs/inode.c	2005-08-14 17:11:35.000000000 +0200
@@ -1985,7 +1985,7 @@ int reiserfs_new_inode(struct reiserfs_t
 	 * iput doesn't deadlock in reiserfs_delete_xattrs. The locking
 	 * code really needs to be reworked, but this will take care of it
 	 * for now. -jeffm */
-	if (REISERFS_I(dir)->i_acl_default) {
+	if (REISERFS_I(dir)->i_acl_default && !IS_ERR(REISERFS_I(dir)->i_acl_default)) {
 		reiserfs_write_unlock_xattrs(dir->i_sb);
 		iput(inode);
 		reiserfs_write_lock_xattrs(dir->i_sb);

--6c2NcOVqGQ03X4Wi--
