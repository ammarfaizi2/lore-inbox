Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWAUIk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWAUIk5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 03:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbWAUIk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 03:40:57 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:25533 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751175AbWAUIk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 03:40:56 -0500
Date: Sat, 21 Jan 2006 09:40:55 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/6] vfs: propagate mnt_flags into do_loopback/vfsmount
Message-ID: <20060121084055.GC10044@MAIL.13thfloor.at>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20060121083843.GA10044@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060121083843.GA10044@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


;
; Bind Mount Extensions
;
; Copyright (C) 2003-2006 Herbert Pötzl <herbert@13thfloor.at>
;
; the mnt_flags are propagated into do_loopback(), so that
; they can be stored with the vfsmount
;
;
; Changelog:
;
;   0.01  - broken out from bm0.01
;

Signed-off-by: Herbert Pötzl <herbert@13thfloor.at>

diff -NurpP --minimal linux-2.6.16-rc1/fs/namespace.c linux-2.6.16-rc1-bme0.06.2-lo0.01/fs/namespace.c
--- linux-2.6.16-rc1/fs/namespace.c	2006-01-18 06:08:30 +0100
+++ linux-2.6.16-rc1-bme0.06.2-lo0.01/fs/namespace.c	2006-01-21 09:08:29 +0100
@@ -861,11 +861,13 @@ static int do_change_type(struct nameida
 /*
  * do loopback mount.
  */
-static int do_loopback(struct nameidata *nd, char *old_name, int recurse)
+static int do_loopback(struct nameidata *nd, char *old_name, unsigned long flags, int mnt_flags)
 {
 	struct nameidata old_nd;
 	struct vfsmount *mnt = NULL;
+	int recurse = flags & MS_REC;
 	int err = mount_is_safe(nd);
+
 	if (err)
 		return err;
 	if (!old_name || !*old_name)
@@ -899,6 +901,7 @@ static int do_loopback(struct nameidata 
 		spin_unlock(&vfsmount_lock);
 		release_mounts(&umount_list);
 	}
+	mnt->mnt_flags = mnt_flags;
 
 out:
 	up_write(&namespace_sem);
@@ -1312,7 +1315,7 @@ long do_mount(char *dev_name, char *dir_
 		retval = do_remount(&nd, flags & ~MS_REMOUNT, mnt_flags,
 				    data_page);
 	else if (flags & MS_BIND)
-		retval = do_loopback(&nd, dev_name, flags & MS_REC);
+		retval = do_loopback(&nd, dev_name, flags, mnt_flags);
 	else if (flags & (MS_SHARED | MS_PRIVATE | MS_SLAVE | MS_UNBINDABLE))
 		retval = do_change_type(&nd, flags);
 	else if (flags & MS_MOVE)

