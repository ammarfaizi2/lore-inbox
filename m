Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265301AbUFOFzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265301AbUFOFzU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 01:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265302AbUFOFzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 01:55:20 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:51410 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S265301AbUFOFzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 01:55:14 -0400
Date: Mon, 14 Jun 2004 22:55:07 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: [PATCH] stat nlink resolution fix
Message-ID: <20040615055507.GA9847@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(As already discussed)

Linus,

Some filesystems can get overflows when their link-count exceeds
65534.  This patch increases the kernels internal resolution for this
and also has a check for the old-system call paths to return and error
(-EOVERFLOW) as required (as suggested by Al Viro).

Signed-off-by: Chris Wedgwood <cw@f00f.org>

diff -Nru a/fs/stat.c b/fs/stat.c
--- a/fs/stat.c	2004-06-14 17:40:21 -07:00
+++ b/fs/stat.c	2004-06-14 17:40:21 -07:00
@@ -131,6 +131,8 @@
 	tmp.st_ino = stat->ino;
 	tmp.st_mode = stat->mode;
 	tmp.st_nlink = stat->nlink;
+	if (tmp.st_nlink != stat->nlink)
+		return -EOVERFLOW;
 	SET_UID(tmp.st_uid, stat->uid);
 	SET_GID(tmp.st_gid, stat->gid);
 	tmp.st_rdev = old_encode_dev(stat->rdev);
@@ -199,6 +201,8 @@
 	tmp.st_ino = stat->ino;
 	tmp.st_mode = stat->mode;
 	tmp.st_nlink = stat->nlink;
+	if (tmp.st_nlink != stat->nlink)
+		return -EOVERFLOW;
 	SET_UID(tmp.st_uid, stat->uid);
 	SET_GID(tmp.st_gid, stat->gid);
 #if BITS_PER_LONG == 32
diff -Nru a/include/linux/stat.h b/include/linux/stat.h
--- a/include/linux/stat.h	2004-06-14 17:40:21 -07:00
+++ b/include/linux/stat.h	2004-06-14 17:40:21 -07:00
@@ -60,7 +60,7 @@
 	unsigned long	ino;
 	dev_t		dev;
 	umode_t		mode;
-	nlink_t		nlink;
+	unsigned int	nlink;
 	uid_t		uid;
 	gid_t		gid;
 	dev_t		rdev;
