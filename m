Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265265AbTLMS25 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 13:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265267AbTLMS25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 13:28:57 -0500
Received: from smtp02.web.de ([217.72.192.151]:33049 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S265265AbTLMS24 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 13:28:56 -0500
Date: Sat, 13 Dec 2003 19:34:58 +0100
From: Rene Scharfe <l.s.r@web.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Timo Maier <tam@gmx.de>
Subject: [PATCH][2.6] HPFS: missing lock_kernel() in hpfs_readdir()
Message-Id: <20031213193458.0e4a4b97.l.s.r@web.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

recently the BKL was pushed from vfs_readdir() into the filesystem
specific functions. But only the unlock_kernel() made it into the HPFS
code, lock_kernel() got lost on the way. This rendered the filesystem
unusable.

The patch below adds the missing lock_kernel(). It's been tested by Timo
Maier who also reported the problem earlier today.

Please apply.

Thanks,
René



--- linux-2.6.0-test11/fs/hpfs/dir.c~	2003-11-26 21:43:26.000000000 +0100
+++ linux-2.6.0-test11/fs/hpfs/dir.c	2003-12-13 16:52:17.000000000 +0100
@@ -65,6 +65,8 @@
 	int c1, c2 = 0;
 	int ret = 0;
 
+	lock_kernel();
+
 	if (hpfs_sb(inode->i_sb)->sb_chk) {
 		if (hpfs_chk_sectors(inode->i_sb, inode->i_ino, 1, "dir_fnode")) {
 			ret = -EFSERROR;
