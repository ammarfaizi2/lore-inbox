Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265854AbUA1FQH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 00:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265856AbUA1FQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 00:16:07 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:1474 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265854AbUA1FQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 00:16:01 -0500
Date: Wed, 28 Jan 2004 10:50:38 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Dipankar Sarma <dipankar@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6] proc_check_dir-locking-fix
Message-ID: <20040128052038.GB1285@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please have a look at the following patch fixing locking in proc_check_root().
It brings is_subdir() call under vfsmount_lock. Holding vfsmount_lock will 
ensure mnt_mountpoint dentry is intact and the dentry does not go away while 
it is being checked in is_subdir(). 

 fs/proc/base.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff -puN fs/proc/base.c~proc_check_root-fix-locking fs/proc/base.c
--- linux-2.6.2-rc2/fs/proc/base.c~proc_check_root-fix-locking	2004-01-27 22:28:07.000000000 +0530
+++ linux-2.6.2-rc2-maneesh/fs/proc/base.c	2004-01-27 22:28:07.000000000 +0530
@@ -425,17 +425,15 @@ static int proc_check_root(struct inode 
 	mnt = vfsmnt;
 
 	while (vfsmnt != our_vfsmnt) {
-		if (vfsmnt == vfsmnt->mnt_parent) {
-			spin_unlock(&vfsmount_lock);
+		if (vfsmnt == vfsmnt->mnt_parent)
 			goto out;
-		}
 		de = vfsmnt->mnt_mountpoint;
 		vfsmnt = vfsmnt->mnt_parent;
 	}
-	spin_unlock(&vfsmount_lock);
 
 	if (!is_subdir(de, base))
 		goto out;
+	spin_unlock(&vfsmount_lock);
 
 exit:
 	dput(base);
@@ -444,6 +442,7 @@ exit:
 	mntput(mnt);
 	return res;
 out:
+	spin_unlock(&vfsmount_lock);
 	res = -EACCES;
 	goto exit;
 }

_



-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
