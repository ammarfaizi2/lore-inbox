Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135845AbRDYMUk>; Wed, 25 Apr 2001 08:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135842AbRDYMUb>; Wed, 25 Apr 2001 08:20:31 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:2820 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S135843AbRDYMUW>;
	Wed, 25 Apr 2001 08:20:22 -0400
Message-ID: <20010422141042.A1354@bug.ucw.cz>
Date: Sun, 22 Apr 2001 14:10:42 +0200
From: Pavel Machek <pavel@suse.cz>
To: viro@math.psu.edu, kernel list <linux-kernel@vger.kernel.org>
Cc: torvalds@transmeta.com
Subject: [patch] linux likes to kill bad inodes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I had a temporary disk failure (played with acpi too much). What
happened was that disk was not able to do anything for five minutes
or so. When disk recovered, linux happily overwrote all inodes it
could not read while disk was down with zeros -> massive disk
corruption.

Solution is not to write bad inodes back to disk.

[Thanx to Jan Kara]							    
								Pavel

--- clean/fs/inode.c	Wed Apr  4 23:58:04 2001
+++ linux/fs/inode.c	Sun Apr 22 14:04:46 2001
@@ -179,7 +179,7 @@
 
 static inline void write_inode(struct inode *inode, int sync)
 {
-	if (inode->i_sb && inode->i_sb->s_op && inode->i_sb->s_op->write_inode)
+	if (inode->i_sb && inode->i_sb->s_op && inode->i_sb->s_op->write_inode && !is_bad_inode(inode))
 		inode->i_sb->s_op->write_inode(inode, sync);
 }
 
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
