Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265310AbUFOGf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265310AbUFOGf6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 02:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265313AbUFOGf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 02:35:58 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:23525 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S265310AbUFOGfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 02:35:55 -0400
Date: Mon, 14 Jun 2004 23:35:50 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: [PATCH] 2.4.x stat nlink resolution fix
Message-ID: <20040615063550.GA10086@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I thought I sent this already?)

Marcelo,

On some architectures (ie. i386) the internal kernel data-structure
'struct inode' has a nlink resolution of only 16-bits.  This can
obviously overflow is you put 2^16-2 (65534) directories in one place.

Older (compatible) syscalls don't have necessary resolution to return
correct values anyhow so checks are made and if there is a low of
value EOVERFLOW is returned (as suggest by Al Viro).  This seems
pretty reasonable and it's unlikely anything much uses the old
syscalls and if they do probably not likely they will stat and
directories with more than 2^16-2 directory children.

This patch prevents the internal overflow and adds the checks to the
older.

Signed-of-by: Chris Wedgwood <cw@f00f.org>



 fs/stat.c          |    4 ++++
 include/linux/fs.h |    2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)


===== fs/stat.c 1.6 vs edited =====
--- 1.6/fs/stat.c	2003-11-28 19:26:56 -08:00
+++ edited/fs/stat.c	2004-06-14 22:30:15 -07:00
@@ -52,6 +52,8 @@
 	tmp.st_ino = inode->i_ino;
 	tmp.st_mode = inode->i_mode;
 	tmp.st_nlink = inode->i_nlink;
+	if (tmp.st_nlink != inode->i_nlink)
+		return -EOVERFLOW;
 	SET_OLDSTAT_UID(tmp, inode->i_uid);
 	SET_OLDSTAT_GID(tmp, inode->i_gid);
 	tmp.st_rdev = kdev_t_to_nr(inode->i_rdev);
@@ -78,6 +80,8 @@
 	tmp.st_ino = inode->i_ino;
 	tmp.st_mode = inode->i_mode;
 	tmp.st_nlink = inode->i_nlink;
+	if (tmp.st_nlink != inode->i_nlink)
+		return -EOVERFLOW;
 	SET_STAT_UID(tmp, inode->i_uid);
 	SET_STAT_GID(tmp, inode->i_gid);
 	tmp.st_rdev = kdev_t_to_nr(inode->i_rdev);
===== include/linux/fs.h 1.96 vs edited =====
--- 1.96/include/linux/fs.h	2004-01-08 07:03:26 -08:00
+++ edited/include/linux/fs.h	2004-06-14 22:29:26 -07:00
@@ -449,7 +449,7 @@
 	atomic_t		i_count;
 	kdev_t			i_dev;
 	umode_t			i_mode;
-	nlink_t			i_nlink;
+	unsigned int		i_nlink;
 	uid_t			i_uid;
 	gid_t			i_gid;
 	kdev_t			i_rdev;
