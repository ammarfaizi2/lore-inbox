Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277412AbRJJVem>; Wed, 10 Oct 2001 17:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277413AbRJJVed>; Wed, 10 Oct 2001 17:34:33 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:58295 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277412AbRJJVeU>; Wed, 10 Oct 2001 17:34:20 -0400
Message-ID: <3BC4E8AD.72F175E3@us.ibm.com>
Date: Wed, 10 Oct 2001 14:32:45 -1000
From: Mingming cao <cmm@us.ibm.com>
Organization: Linux Technology Center
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, viro@math.psu.edu
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]Fix bug:rmdir could remove current working directory
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Alan and Al,

I found that rmdir(2) could remove current working directory
successfully.  This happens when the given pathname points to current
working directory, not ".", but something else. For example, the current
working directory's absolute pathname.  I read the man page of
rmdir(2).  It says in this case EBUSY error should be returned.  I
suspected this is a bug and added a check in vfs_rmdir(). The following
patch is against 2.4.10 and has been verified.  Please comment and
apply.

-- 
Mingming Cao

--- linux-2.4.10/fs/namei.c	Tue Sep 18 11:01:47 2001
+++ /home/ming/linux-tk/fs/namei.c	Tue Oct  9 11:58:50 2001
@@ -1362,6 +1362,8 @@
 		error = -ENOENT;
 	else if (d_mountpoint(dentry))
 		error = -EBUSY;
+	else if (dentry == current->fs->pwd)
+		error = -EBUSY;
 	else {
 		lock_kernel();
 		error = dir->i_op->rmdir(dir, dentry);
