Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129152AbQKSBjI>; Sat, 18 Nov 2000 20:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129234AbQKSBjA>; Sat, 18 Nov 2000 20:39:00 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:15411 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129152AbQKSBit>; Sat, 18 Nov 2000 20:38:49 -0500
Date: Sun, 19 Nov 2000 02:08:29 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2 largefile fixes + [f]truncate() error value fix
Message-ID: <20001119020829.A29947@athlon.random>
In-Reply-To: <20001119013324.F26779@athlon.random> <Pine.GSO.4.21.0011181943110.21893-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0011181943110.21893-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Nov 18, 2000 at 07:46:29PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2000 at 07:46:29PM -0500, Alexander Viro wrote:
> ed fs/ext2/inode.c <<EOF
> /ext2_notify_change/
> /size >> 33/
> s/33/32/
> w
> q
> EOF

Good spotting but wrong fix.

Right fix for 2.2.x:

--- 33/fs/ext2/inode.c.~1~	Sun Nov 12 00:45:43 2000
+++ 33/fs/ext2/inode.c	Sun Nov 19 02:02:51 2000
@@ -739,7 +739,7 @@
 		}
 
 #if BITS_PER_LONG == 64	
-		if (size >> 33) {
+		if (size >> 31) {
 			struct super_block *sb = inode->i_sb;
 			struct ext2_super_block *es = sb->u.ext2_sb.s_es;
 			if (!(es->s_feature_ro_compat &


Fix for 2.4.0-test11-pre6:

--- 2.4.0-test11-pre6/fs/ext2/inode.c.~1~	Thu Nov 16 15:37:32 2000
+++ 2.4.0-test11-pre6/fs/ext2/inode.c	Sun Nov 19 02:07:03 2000
@@ -1188,7 +1188,7 @@
 		raw_inode->i_dir_acl = cpu_to_le32(inode->u.ext2_i.i_dir_acl);
 	else {
 		raw_inode->i_size_high = cpu_to_le32(inode->i_size >> 32);
-		if (raw_inode->i_size_high) {
+		if (inode->i_size >> 31) {
 			struct super_block *sb = inode->i_sb;
 			struct ext2_super_block *es = sb->u.ext2_sb.s_es;
 			if (!(es->s_feature_ro_compat & cpu_to_le32(EXT2_FEATURE_RO_COMPAT_LARGE_FILE))) {


Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
