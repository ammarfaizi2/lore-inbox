Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313151AbSDDMAc>; Thu, 4 Apr 2002 07:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313150AbSDDMAX>; Thu, 4 Apr 2002 07:00:23 -0500
Received: from sv1.valinux.co.jp ([202.221.173.100]:24851 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S313149AbSDDMAL>;
	Thu, 4 Apr 2002 07:00:11 -0500
Date: Thu, 04 Apr 2002 21:00:55 +0900 (JST)
Message-Id: <20020404.210055.97296453.taka@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [BUGFIX] racing between rmdir and rename on 2.4.18
From: Hirokazu Takahashi <taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I found a bug and fix it.

When files are moved under a directory which is just being removed,
it may cause a problem because target directory might be dead.

In function vfs_rename_other(), IS_DEADDIR(new_dir) check should
be done after double_down() like vfs_rename_dir() does.



--- linux/fs/namei.c.orig	Tue Feb 26 04:38:09 2002
+++ linux/fs/namei.c	Tue Apr  2 12:37:37 2002
@@ -1802,7 +1802,9 @@
 	DQUOT_INIT(old_dir);
 	DQUOT_INIT(new_dir);
 	double_down(&old_dir->i_zombie, &new_dir->i_zombie);
-	if (d_mountpoint(old_dentry)||d_mountpoint(new_dentry))
+	if (IS_DEADDIR(old_dir)||IS_DEADDIR(new_dir))
+		error = -ENOENT;
+	else if (d_mountpoint(old_dentry)||d_mountpoint(new_dentry))
 		error = -EBUSY;
 	else
 		error = old_dir->i_op->rename(old_dir, old_dentry, new_dir, new_dentry);
