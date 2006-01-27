Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030334AbWA0UDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbWA0UDG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 15:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030332AbWA0UDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 15:03:06 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:58002 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1030334AbWA0UDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 15:03:05 -0500
Date: Fri, 27 Jan 2006 21:03:04 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Al Viro <viro@ftp.linux.org.uk>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] vfs: propagate mnt_flags into do_loopback/vfsmount
Message-ID: <20060127200304.GB16752@MAIL.13thfloor.at>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@ftp.linux.org.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20060121083843.GA10044@MAIL.13thfloor.at> <20060121084055.GC10044@MAIL.13thfloor.at> <20060124190256.GA14201@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060124190256.GA14201@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the mnt_flags are propagated into do_loopback(), so that
they can be stored with the vfsmount

Signed-off-by: Herbert Pötzl <herbert@13thfloor.at>
Acked-by: Christoph Hellwig <hch@infradead.org>
---
; Bind Mount Extensions
; 02_2.6.16-rc1_lo0.01.diff

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

