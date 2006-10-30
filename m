Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751785AbWJ3Oce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbWJ3Oce (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 09:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbWJ3Oce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 09:32:34 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:49488 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751785AbWJ3Ocd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 09:32:33 -0500
Message-ID: <45460CEF.2060801@sw.ru>
Date: Mon, 30 Oct 2006 17:32:15 +0300
From: Vasily Averin <vvs@sw.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Howells <dhowells@redhat.com>, Jan Blunck <jblunck@suse.de>,
       Andrew Morton <akpm@osdl.org>, Alexander Viro <viro@zeniv.linux.org.uk>
CC: Kirill Korotaev <dev@openvz.org>, devel@openvz.org
Subject: [PATCH 2.6.19-rc3-mm1] VFS: BKL is not required for remount_fs()
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@sw.ru>

according to Documentation/filesystems/Locking remount_fs() is not requires BKL

Signed-off-by:	Vasily Averin <vvs@sw.ru>

--- linux-2.6.19-rc3-mm1/fs/namespace.c.blkrm	2006-10-30 14:36:09.000000000 +0300
+++ linux-2.6.19-rc3-mm1/fs/namespace.c	2006-10-30 14:33:05.000000000 +0300
@@ -594,10 +594,8 @@ static int do_umount(struct vfsmount *mn
 		 */
 		down_write(&sb->s_umount);
 		if (!(sb->s_flags & MS_RDONLY)) {
-			lock_kernel();
 			DQUOT_OFF(sb);
 			retval = do_remount_sb(sb, MS_RDONLY, NULL, 0);
-			unlock_kernel();
 		}
 		up_write(&sb->s_umount);
 		return retval;
--- linux-2.6.19-rc3-mm1/fs/super.c.blkrm	2006-10-30 14:36:01.000000000 +0300
+++ linux-2.6.19-rc3-mm1/fs/super.c	2006-10-30 14:33:05.000000000 +0300
@@ -609,16 +609,8 @@ static void do_emergency_remount(unsigne
 		sb->s_count++;
 		spin_unlock(&sb_lock);
 		down_read(&sb->s_umount);
-		if (sb->s_root && sb->s_bdev && !(sb->s_flags & MS_RDONLY)) {
-			/*
-			 * ->remount_fs needs lock_kernel().
-			 *
-			 * What lock protects sb->s_flags??
-			 */
-			lock_kernel();
+		if (sb->s_root && sb->s_bdev && !(sb->s_flags & MS_RDONLY))
 			do_remount_sb(sb, MS_RDONLY, NULL, 1);
-			unlock_kernel();
-		}
 		drop_super(sb);
 		spin_lock(&sb_lock);
 	}

