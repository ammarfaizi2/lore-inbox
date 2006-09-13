Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030447AbWIMA54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbWIMA54 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 20:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030451AbWIMA54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 20:57:56 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:46281 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030447AbWIMA5z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 20:57:55 -0400
Date: Tue, 12 Sep 2006 17:57:38 -0700
From: Ram Pai <linuxram@us.ibm.com>
Message-Id: <200609130057.k8D0vcqJ028474@ram.us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] VFS: fixes a bug in sys_linkat() 
Cc: akpm@osdl.org, linuxram@us.ibm.com, nacc@us.ibm.com, viro@ftp.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hardlink using sys_linkat() returns EXDEV when the source and the destination
point to the same filesystem, residing under different mounts.

An example scenario is:

mount /dev/sda /mnt
mount /dev/sdb /mnt1
mkdir /mnt1/src
mkdir /mnt/dest
mount --bind /mnt1/src /mnt/dest   (note: at this point the filesystems
			under /mnt1/src and /mnt/dest is same)
touch /mnt1/src/testfile
ln /mnt1/src/testfile /mnt/dest/sametestfile  (note: this should succeed).

The ln command fails. It does not correctly recognize that both
the source and destination point to the same filesystem.

The following patch fixes the problem.
Thanks to Nishanth Aravamudan(nacc@us.ibm.com) for identifying the bug.

Signed by Ram Pai (linuxram@us.ibm.com)
---
 fs/namei.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.17.10/fs/namei.c
===================================================================
--- linux-2.6.17.10.orig/fs/namei.c
+++ linux-2.6.17.10/fs/namei.c
@@ -2263,7 +2263,7 @@ asmlinkage long sys_linkat(int olddfd, c
 	if (error)
 		goto out;
 	error = -EXDEV;
-	if (old_nd.mnt != nd.mnt)
+	if (old_nd.mnt->mnt_sb != nd.mnt->mnt_sb)
 		goto out_release;
 	new_dentry = lookup_create(&nd, 0);
 	error = PTR_ERR(new_dentry);
