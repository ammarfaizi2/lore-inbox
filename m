Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289858AbSAKDrt>; Thu, 10 Jan 2002 22:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289855AbSAKDrd>; Thu, 10 Jan 2002 22:47:33 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:50348
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S289854AbSAKDrL>; Thu, 10 Jan 2002 22:47:11 -0500
Date: Thu, 10 Jan 2002 20:47:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Fix fs/fat/inode.c when compiled with gcc-3.0.x
Message-ID: <20020111034703.GK13931@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  Currently when fs/fat/inode.c is compiled with gcc-3.0.x, there
are to lines which will cause a __divdi3 call to be used.  But on most
archs, there isn't currently a __divdi3 implementation in the kernel, so
FAT will no longer link (or load as a module).  The easy fix (pointed
out by Andrew Morton) is to replace the divide by 512 with a shift right
by 9, which has the same effect but doesn't use a divide.

This is vs 2.4.18-pre3, but applies to 2.5.2-pre9 as well (and probably
pre10 too..)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== fs/fat/inode.c 1.10 vs edited =====
--- 1.10/fs/fat/inode.c	Wed Nov 21 15:12:16 2001
+++ edited/fs/fat/inode.c	Thu Jan 10 15:40:11 2002
@@ -406,7 +406,7 @@
 	}
 	inode->i_blksize = 1 << sbi->cluster_bits;
 	inode->i_blocks = ((inode->i_size + inode->i_blksize - 1)
-			   & ~(inode->i_blksize - 1)) / 512;
+			   & ~(inode->i_blksize - 1)) >> 9;
 	MSDOS_I(inode)->i_logstart = 0;
 	MSDOS_I(inode)->mmu_private = inode->i_size;
 
@@ -952,7 +952,7 @@
 	/* this is as close to the truth as we can get ... */
 	inode->i_blksize = 1 << sbi->cluster_bits;
 	inode->i_blocks = ((inode->i_size + inode->i_blksize - 1)
-			   & ~(inode->i_blksize - 1)) / 512;
+			   & ~(inode->i_blksize - 1)) >> 9;
 	inode->i_mtime = inode->i_atime =
 		date_dos2unix(CF_LE_W(de->time),CF_LE_W(de->date));
 	inode->i_ctime =
