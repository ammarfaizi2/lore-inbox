Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266621AbUBGDju (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 22:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266628AbUBGDju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 22:39:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31888 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266621AbUBGDjr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 22:39:47 -0500
Date: Fri, 6 Feb 2004 22:39:45 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Valdis.Kletnieks@vt.edu
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: 2.6.2-mm1, selinux, and initrd
In-Reply-To: <200402060228.i162SwKo004935@turing-police.cc.vt.edu>
Message-ID: <Xine.LNX.4.44.0402062238390.17854-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Feb 2004 Valdis.Kletnieks@vt.edu wrote:

> Booting 2.6.2-mm1, I get:
> 
> RAMDISK: Compressed image found at block 0
> VFS: Mounted root (ext2 filesystem).
> Mounted devfs on /dev
> VFS: Cannot open root device 
> 
> and things come to a screeching halt.  Absolutely nothing in the linuxrc
> seems to happen - and since the real root is on an LVM, we come to a
> screeching halt.

Vladis, 

Can you please try the patch below against  the 2.6.2-mm1 kernel and let 
me know if you still see the problem.


- James
-- 
James Morris
<jmorris@redhat.com>

diff -urN -X dontdiff linux-2.6.2-mm1.o/fs/super.c linux-2.6.2-mm1.w/fs/super.c
--- linux-2.6.2-mm1.o/fs/super.c	2004-02-05 09:24:12.000000000 -0500
+++ linux-2.6.2-mm1.w/fs/super.c	2004-02-06 22:32:43.309927664 -0500
@@ -709,7 +709,6 @@
 	struct super_block *sb = ERR_PTR(-ENOMEM);
 	struct vfsmount *mnt;
 	int error;
-	char *secdata = NULL;
 
 	if (!type)
 		return ERR_PTR(-ENODEV);
@@ -718,24 +717,10 @@
 	if (!mnt)
 		goto out;
 
-	if (data) {
-		secdata = alloc_secdata();
-		if (!secdata) {
-			sb = ERR_PTR(-ENOMEM);
-			goto out_mnt;
-		}
-
-		error = security_sb_copy_data(fstype, data, secdata);
-		if (error) {
-			sb = ERR_PTR(error);
-			goto out_free_secdata;
-		}
-	}
-
 	sb = type->get_sb(type, flags, name, data);
 	if (IS_ERR(sb))
-		goto out_free_secdata;
- 	error = security_sb_kern_mount(sb, secdata);
+		goto out_mnt;
+ 	error = security_sb_kern_mount(sb, NULL);
  	if (error)
  		goto out_sb;
 	mnt->mnt_sb = sb;
@@ -749,8 +734,6 @@
 	up_write(&sb->s_umount);
 	deactivate_super(sb);
 	sb = ERR_PTR(error);
-out_free_secdata:
-	free_secdata(secdata);
 out_mnt:
 	free_vfsmnt(mnt);
 out:

