Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWG0U7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWG0U7y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWG0U7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:59:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:24334 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750940AbWG0U7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:59:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=uCidQAW1uP/MpsvBBun+a4updulMX4g9pkFdpIW5QeZCFak3fer/rMCkx4Tn5auXCdoVei4AzL9iSC5Kjp5Vjnv5HiNy3VS5m+xAOaExZbIZDp950/zz/GNwtJJYGLVvqsoxq1clRNDq4g6i9/aBQVqwIIQfm+PpsODT0pWrxMU=
Date: Fri, 28 Jul 2006 00:59:11 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] #define rwxr_xr_x 0755
Message-ID: <20060727205911.GB5356@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every time I try to decipher S_I* combos I cry in pain. Often I just
refer to include/linux/stat.h defines to find out what mode it is
because numbers are actually quickier to understand.

Compare and contrast:

	0644 vs S_IRUGO|S_IWUSR vs rw_r__r__

I'd say #2 really sucks.

Another rationale: "ls -l" is used pretty often and people are used to
its output so new defines would be very easy to understand.

Target usage sysfs attributes modes and similar stuff. Driver authors
would just write

	.attr = {.name = "state", .mode = r__r__r__ },

and be done with it.

I'm not sure you want to see

	if (mode & _w__w__w_)

somewhere in generic code, this is debatable, so I'll go with attribute
stuff first.

What people think? Should folks at Moscow call 03 ASAP?

--- a/fs/smbfs/inode.c
+++ b/fs/smbfs/inode.c
@@ -575,10 +575,8 @@ static int smb_fill_super(struct super_b
 		mnt->flags = (oldmnt->file_mode >> 9) | SMB_MOUNT_UID |
 			SMB_MOUNT_GID | SMB_MOUNT_FMODE | SMB_MOUNT_DMODE;
 	} else {
-		mnt->file_mode = S_IRWXU | S_IRGRP | S_IXGRP |
-				S_IROTH | S_IXOTH | S_IFREG;
-		mnt->dir_mode = S_IRWXU | S_IRGRP | S_IXGRP |
-				S_IROTH | S_IXOTH | S_IFDIR;
+		mnt->file_mode = rwxr_xr_x | S_IFREG;
+		mnt->dir_mode = rwxr_xr_x | S_IFDIR;
 		if (parse_options(mnt, raw_data))
 			goto out_bad_option;
 	}
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -29,6 +29,8 @@ #define S_ISBLK(m)	(((m) & S_IFMT) == S_
 #define S_ISFIFO(m)	(((m) & S_IFMT) == S_IFIFO)
 #define S_ISSOCK(m)	(((m) & S_IFMT) == S_IFSOCK)
 
+#define rwxr_xr_x 0755
+
 #define S_IRWXU 00700
 #define S_IRUSR 00400
 #define S_IWUSR 00200

