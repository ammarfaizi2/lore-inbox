Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbVDAVUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbVDAVUG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 16:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262908AbVDAVQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 16:16:32 -0500
Received: from rev.193.226.232.52.euroweb.hu ([193.226.232.52]:3511 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262903AbVDAU4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:56:11 -0500
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE: readdir fixes
Message-Id: <E1DHTBG-0006sj-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 01 Apr 2005 22:55:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch correctly sets f_pos in readdir.  The offset passed from
userspace is now the offset of the next entry.  Needs at least libfuse
2.3-pre2 to work properly.

Zero lengh filenames are also disallowed.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.12-rc1-mm4/fs/fuse/dir.c linux-fuse/fs/fuse/dir.c
--- linux-2.6.12-rc1-mm4/fs/fuse/dir.c	2005-03-31 21:52:18.000000000 +0200
+++ linux-fuse/fs/fuse/dir.c	2005-04-01 22:49:25.000000000 +0200
@@ -477,19 +477,19 @@ static int parse_dirfile(char *buf, size
 		struct fuse_dirent *dirent = (struct fuse_dirent *) buf;
 		size_t reclen = FUSE_DIRENT_SIZE(dirent);
 		int over;
-		if (dirent->namelen > FUSE_NAME_MAX)
+		if (!dirent->namelen || dirent->namelen > FUSE_NAME_MAX)
 			return -EIO;
 		if (reclen > nbytes)
 			break;
 
 		over = filldir(dstbuf, dirent->name, dirent->namelen,
-			       dirent->off, dirent->ino, dirent->type);
+			       file->f_pos, dirent->ino, dirent->type);
 		if (over)
 			break;
 
 		buf += reclen;
-		file->f_pos += reclen;
 		nbytes -= reclen;
+		file->f_pos = dirent->off;
 	}
 
 	return 0;
