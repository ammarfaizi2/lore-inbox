Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271961AbRHVIou>; Wed, 22 Aug 2001 04:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271963AbRHVIok>; Wed, 22 Aug 2001 04:44:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:32772 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S271961AbRHVIo0>; Wed, 22 Aug 2001 04:44:26 -0400
Date: Wed, 22 Aug 2001 10:44:24 +0200
From: Jan Kara <jack@suse.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Ext2 quota bug in 2.4.8
Message-ID: <20010822104424.D11019@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  Jan Sanislo <oystr@cs.washington.edu> found a bug in ext2 quota code in 2.4.6+.
During changes in ext2 code in 2.4.6 some DQUOT_INIT()s were removed but they
shouldn't and as a result quota is not computed right.
  The patch which adds missing DQUOT_INIT()s is below. I didn't place DQUOT_INIT()s to
original places but rather to generic vfs parts which seems better to me.
  Please apply - patch is against 2.4.8.

								Honza
--
Jan Kara <jack@suse.cz>
SuSE Labs

-------------------------------------------------------------------------

--- linux-2.4.8/fs/namei.c	Tue Aug 21 20:43:31 2001
+++ linux-2.4.8/fs/namei.c	Tue Aug 21 20:44:08 2001
@@ -1330,6 +1330,7 @@
 		return -EPERM;
 
 	DQUOT_INIT(dir);
+	DQUOT_INIT(dentry->d_inode);
 
 	double_down(&dir->i_zombie, &dentry->d_inode->i_zombie);
 	d_unhash(dentry);
@@ -1405,10 +1406,11 @@
 	if (!error) {
 		error = -EPERM;
 		if (dir->i_op && dir->i_op->unlink) {
-			DQUOT_INIT(dir);
 			if (d_mountpoint(dentry))
 				error = -EBUSY;
 			else {
+				DQUOT_INIT(dir);
+				DQUOT_INIT(dentry->d_inode);
 				lock_kernel();
 				error = dir->i_op->unlink(dir, dentry);
 				unlock_kernel();
