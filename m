Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317561AbSGOS0p>; Mon, 15 Jul 2002 14:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317566AbSGOS0o>; Mon, 15 Jul 2002 14:26:44 -0400
Received: from chaos.analogic.com ([204.178.40.224]:896 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317561AbSGOS0m>; Mon, 15 Jul 2002 14:26:42 -0400
Date: Mon, 15 Jul 2002 14:29:28 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Repeatable remount problem.
Message-ID: <Pine.LNX.3.95.1020715142537.175A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Last week I reported a remount problem on 2.4.18 where a remounting
an already-mounted file-system, with new flags (like noatime), results
in a fsck upon reboot.

Here is a fix. Standard disclaimer: (works-for-me).

--- linux-2.4.18/fs/super.c.orig	Mon Feb 25 14:38:09 2002
+++ linux-2.4.18/fs/super.c	Mon Jul 15 14:18:55 2002
@@ -829,22 +829,14 @@
 	if ((flags & MS_RDONLY) && !(sb->s_flags & MS_RDONLY))
 		if (!fs_may_remount_ro(sb))
 			return -EBUSY;
+        retval = 0;
 	if (sb->s_op && sb->s_op->remount_fs) {
 		lock_super(sb);
-		retval = sb->s_op->remount_fs(sb, &flags, data);
+		if(!(retval = sb->s_op->remount_fs(sb, &flags, data)));
+	            sb->s_flags = (sb->s_flags & ~MS_RMT_MASK) | (flags & MS_RMT_MASK);
 		unlock_super(sb);
-		if (retval)
-			return retval;
 	}
-	sb->s_flags = (sb->s_flags & ~MS_RMT_MASK) | (flags & MS_RMT_MASK);
-
-	/*
-	 * We can't invalidate inodes as we can loose data when remounting
-	 * (someone might manage to alter data while we are waiting in lock_super()
-	 * or in foo_remount_fs()))
-	 */
-
-	return 0;
+	return retval;
 }
 
 struct vfsmount *do_kern_mount(char *type, int flags, char *name, void *data)





Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

