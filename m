Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277152AbRJDQdP>; Thu, 4 Oct 2001 12:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277155AbRJDQdF>; Thu, 4 Oct 2001 12:33:05 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:62338 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S277152AbRJDQcv>;
	Thu, 4 Oct 2001 12:32:51 -0400
Date: Thu, 4 Oct 2001 18:33:31 +0200 (CEST)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fs/fat/inode.c missing errorhandling
Message-ID: <Pine.LNX.4.21.0110041826060.8923-100000@tux.rsn.bth.se>
X-message-flag: Get yourself a real mail client! http://www.washington.edu/pine/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found a problem with fat when I tried to mount a fat filesystem created
with 'mkdosfs -F 32 -S 8192'. I tried mounting it as vfat and I got a
panic() from set_blocksize() in fs/buffer.c

fs/fat/inode.c sets an error veriable if it detects an error but it
doesn't bail out immediately, instead it tries to pass this sectorsize to
set_blocksize() which checks if it's bigger than PAGE_SIZE and then
panics.

The solution is to bail out before set_blocksize() is called.
I checked with Al Viro on irc and he agreed.

--- linux/fs/fat/inode.c.orig	Thu Oct  4 18:19:37 2001
+++ linux/fs/fat/inode.c	Thu Oct  4 18:20:39 2001
@@ -712,6 +712,9 @@
 	}
 	brelse(bh);
 
+	if (error)
+		goto out_invalid;
+
 	sb->s_blocksize = logical_sector_size;
 	sb->s_blocksize_bits = ffs(logical_sector_size) - 1;
 	set_blocksize(sb->s_dev, sb->s_blocksize);


/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.

