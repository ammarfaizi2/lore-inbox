Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293337AbSCKGdt>; Mon, 11 Mar 2002 01:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293395AbSCKGdi>; Mon, 11 Mar 2002 01:33:38 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:2944 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S293337AbSCKGd2>;
	Mon, 11 Mar 2002 01:33:28 -0500
Date: Mon, 11 Mar 2002 01:33:26 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix for get_sb_bdev() bug
Message-ID: <Pine.GSO.4.21.0203110123340.9713-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Grr...  When loop in get_sb_bdev() had been switched from
global list of superblock to per-type one, we should have switched
from sb_entry(p) (aka. list_entry(p, struct super_block, s_list)) to
list_entry(p, struct super_block, s_instances).

	As it is, we end up with false negatives all the time.  I.e.
second mount from the same block device with the same type gices
a new superblock.  With obvious nasty results...

	Patch below fixes that.

--- C6-0/fs/super.c	Fri Mar  8 19:01:07 2002
+++ C6-0/fs/super.c.fix	Mon Mar 11 01:22:26 2002
@@ -728,7 +728,8 @@
 	spin_lock(&sb_lock);
 
 	list_for_each(p, &fs_type->fs_supers) {
-		struct super_block *old = sb_entry(p);
+		struct super_block *old;
+		old = list_entry(p, struct super_block, s_instances);
 		if (old->s_bdev != bdev)
 			continue;
 		if (!grab_super(old))

