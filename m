Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbVHMLTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbVHMLTQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 07:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVHMLTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 07:19:15 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:8326 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751329AbVHMLTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 07:19:15 -0400
Date: Sat, 13 Aug 2005 13:19:14 +0200
From: Jan Kara <jack@suse.cz>
To: Tarmo =?iso-8859-2?Q?T=E4nav?= <tarmo@itech.ee>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com, akpm@osdl.org,
       mason@suse.com, jeffm@suse.com
Subject: Re: BUG: reiserfs+acl+quota deadlock
Message-ID: <20050813111914.GE4516@atrey.karlin.mff.cuni.cz>
References: <1123643111.27819.23.camel@localhost> <20050810130009.GE22112@atrey.karlin.mff.cuni.cz> <1123684298.14562.4.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <1123684298.14562.4.camel@localhost>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Tried the attached patch but it changed nothing, I trying to create
> a new file as a user whose quota grace time has ran out will still
> cause everything accessing the users homedir (the one with the quota)
> to hang in D state.
> 
> Also note that the bug I reported only exists when acl is also
> enabled (does not have to be used). And although my kernel is not
> built with debug (or reiserfs debug) support, I don't get any
> oopses or reiserfs errors.. it just hangs.
  OK, I've debugged the hang (I think the bug was actually introduced by
Jeff's fix). Attached patch should fix it.

								Honza

> On K, 2005-08-10 at 15:00 +0200, Jan Kara wrote:
> >   Hello,
> > 
> > > I've already reported a similiar bug to the one I found now
> > > and that was fixed by:
> > > "[PATCH] reiserfs: fix deadlock in inode creation failure path w/
> > > default ACL"
> > > 
> > > This bug is similiar in effect but has some differences in how
> > > to trigger it. The end effect will be just like with the other
> > > bug that the affected directory will be unaccessible to any user
> > > or process.
> > > 
> > > So here's the way to reproduce it, as minimal as I could get it:
> > > 
> > > You need reiserfs, quota and acl support in kernel.
> > > you also need quota tools (edquota, quotaon, quotacheck), I used
> > > linuxquota 3.12.
> > > 
> > > # cd /mnt
> > > # dd if=/dev/zero of=test bs=1M count=50
> > > 50+0 records in
> > > 50+0 records out
> > > # mkreiserfs -f test >/dev/null
> > > mkreiserfs 3.6.19 (2003 www.namesys.com)
> > > 
> > > test is not a block special device
> > > Continue (y/n):y
> > > # mkdir mpoint
> > > # mount test mpoint -o loop,acl,usrquota
> > > # mkdir mpoint/user1
> > > # useradd -d /mnt/mpoint/user1 user1     # may also use existing user
> > > # chown user1 mpoint/user1
> > > # quotacheck -v mpoint                   # initializes quota file
> > > # edquota user1
> > > ---- set soft block limit to 1000, hard limit to 4000 ----
> > > # edquota -t
> > > ---- set the grace periods to something small: 1minutes ---
> > > # quotaon mpoint
> > > # ## at this point "repquota -a" should show the quota for user1
> > > # su user1
> > > # cd
> > > # ## now we are in user1 home dir as user1
> > > # cat /dev/zero > file1
> > > loop2: warning, user block quota exceeded.
> > > loop2: write failed, user block limit reached.
> > > cat: write error: No space left on device
> > > --- now we wait till the grace period expires (repquota -a) ----
> > > # cat "" > otherfile
> > > loop2: write failed, user block quota exceeded too long.
> > > ---- and it will hang forever ----
> > > # ## /mnt/mpoint can still be accessed, but /mnt/mpoint/user1 can't
> > > 
> > > 
> > > I tested this on an -mm patchset kernel (2.6.13-rc5-mm1), but I
> > > discovered the bug in my server which runs plain 2.6.12 with the
> > > patch from Jeff Mahoney for the first reiserfs+acl bug.
> > > 
> > > The main difference between the two bugs is that the first one requires
> > > the existance of a default acl, this one does not, but it does require
> > > acl to be enabled.
> >   This seems to be the same problem as bug #4771 that I've just fix. Can
> > you try attached patch please?
> >   Andrew, can you include the patch into -mm if ReiserFS guys won't object?
> 
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--vkogqOf2sHV7VnPd
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

--vkogqOf2sHV7VnPd--
