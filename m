Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbUAYASA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 19:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbUAYASA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 19:18:00 -0500
Received: from hera.cwi.nl ([192.16.191.8]:37098 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263522AbUAYAR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 19:17:58 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 25 Jan 2004 01:17:47 +0100 (MET)
Message-Id: <UTC200401250017.i0P0Hlc09374.aeb@smtp.cwi.nl>
To: akpm@osdl.org, torvalds@osdl.org
Subject: [uPATCH] refuse plain ufs mount
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Installed some machine with a reiserfs rootfs.
The boot messages contain a lot of garbage spouted by Intermezzo
and ufs_read_super caused by the fact that the kernel tried lots
of other filesystems before hitting on reiserfs.

On the one hand this is solved by "rootfstype=reiserfs".

But on the other hand, the kernel should not complain about the
guessing it does itself. There is a parameter "silent" for this
purpose, but in this case I think it cleaner just to remove the
complaint and tighten the requirement.

Andries

--- /linux/2.6/linux-2.6.1/linux/fs/ufs/super.c	2003-12-18 03:57:57.000000000 +0100
+++ super.c	2004-01-25 01:05:47.000000000 +0100
@@ -516,14 +516,10 @@
 		printk("wrong mount options\n");
 		goto failed;
 	}
-	if (!(sbi->s_mount_opt & UFS_MOUNT_UFSTYPE)) {
-		printk("You didn't specify the type of your ufs filesystem\n\n"
-		"mount -t ufs -o ufstype="
-		"sun|sunx86|44bsd|old|hp|nextstep|netxstep-cd|openstep ...\n\n"
-		">>>WARNING<<< Wrong ufstype may corrupt your filesystem, "
-		"default is ufstype=old\n");
-		ufs_set_opt (sbi->s_mount_opt, UFSTYPE_OLD);
-	}
+
+	/* "old" used to be default - now: always specify type */
+	if (!(sbi->s_mount_opt & UFS_MOUNT_UFSTYPE))
+		goto failed;
 
 	sbi->s_uspi = uspi =
 		kmalloc (sizeof(struct ufs_sb_private_info), GFP_KERNEL);
