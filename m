Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965090AbVHJNAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbVHJNAU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 09:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965091AbVHJNAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 09:00:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49625 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S965090AbVHJNAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 09:00:19 -0400
Date: Wed, 10 Aug 2005 15:00:10 +0200
From: Jan Kara <jack@suse.cz>
To: Tarmo =?iso-8859-2?Q?T=E4nav?= <tarmo@itech.ee>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com, akpm@osdl.org,
       mason@suse.com, jeffm@suse.com
Subject: Re: BUG: reiserfs+acl+quota deadlock
Message-ID: <20050810130009.GE22112@atrey.karlin.mff.cuni.cz>
References: <1123643111.27819.23.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <1123643111.27819.23.camel@localhost>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

> I've already reported a similiar bug to the one I found now
> and that was fixed by:
> "[PATCH] reiserfs: fix deadlock in inode creation failure path w/
> default ACL"
> 
> This bug is similiar in effect but has some differences in how
> to trigger it. The end effect will be just like with the other
> bug that the affected directory will be unaccessible to any user
> or process.
> 
> So here's the way to reproduce it, as minimal as I could get it:
> 
> You need reiserfs, quota and acl support in kernel.
> you also need quota tools (edquota, quotaon, quotacheck), I used
> linuxquota 3.12.
> 
> # cd /mnt
> # dd if=/dev/zero of=test bs=1M count=50
> 50+0 records in
> 50+0 records out
> # mkreiserfs -f test >/dev/null
> mkreiserfs 3.6.19 (2003 www.namesys.com)
> 
> test is not a block special device
> Continue (y/n):y
> # mkdir mpoint
> # mount test mpoint -o loop,acl,usrquota
> # mkdir mpoint/user1
> # useradd -d /mnt/mpoint/user1 user1     # may also use existing user
> # chown user1 mpoint/user1
> # quotacheck -v mpoint                   # initializes quota file
> # edquota user1
> ---- set soft block limit to 1000, hard limit to 4000 ----
> # edquota -t
> ---- set the grace periods to something small: 1minutes ---
> # quotaon mpoint
> # ## at this point "repquota -a" should show the quota for user1
> # su user1
> # cd
> # ## now we are in user1 home dir as user1
> # cat /dev/zero > file1
> loop2: warning, user block quota exceeded.
> loop2: write failed, user block limit reached.
> cat: write error: No space left on device
> --- now we wait till the grace period expires (repquota -a) ----
> # cat "" > otherfile
> loop2: write failed, user block quota exceeded too long.
> ---- and it will hang forever ----
> # ## /mnt/mpoint can still be accessed, but /mnt/mpoint/user1 can't
> 
> 
> I tested this on an -mm patchset kernel (2.6.13-rc5-mm1), but I
> discovered the bug in my server which runs plain 2.6.12 with the
> patch from Jeff Mahoney for the first reiserfs+acl bug.
> 
> The main difference between the two bugs is that the first one requires
> the existance of a default acl, this one does not, but it does require
> acl to be enabled.
  This seems to be the same problem as bug #4771 that I've just fix. Can
you try attached patch please?
  Andrew, can you include the patch into -mm if ReiserFS guys won't object?

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="reiser-2.6.13-rc6-create_fix.diff"

Initialize key object ID in inode so that we don't try to remove the inode
when we fail on some checks even before we manage to allocate something.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.13-rc6/fs/reiserfs/namei.c linux-2.6.13-rc6-reiser_create_fix/fs/reiserfs/namei.c
--- linux-2.6.13-rc6/fs/reiserfs/namei.c	2005-08-12 10:39:25.000000000 +0200
+++ linux-2.6.13-rc6-reiser_create_fix/fs/reiserfs/namei.c	2005-08-12 10:39:07.000000000 +0200
@@ -593,6 +593,9 @@ static int new_inode_init(struct inode *
 	 */
 	inode->i_uid = current->fsuid;
 	inode->i_mode = mode;
+	/* Make inode invalid - just in case we are going to drop it before
+	 * the initialization happens */
+	INODE_PKEY(inode)->k_objectid = 0;
 
 	if (dir->i_mode & S_ISGID) {
 		inode->i_gid = dir->i_gid;

--TB36FDmn/VVEgNH/--
