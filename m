Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135898AbRAGGr0>; Sun, 7 Jan 2001 01:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135931AbRAGGrR>; Sun, 7 Jan 2001 01:47:17 -0500
Received: from CPE-203-45-168-41.qld.bigpond.net.au ([203.45.168.41]:38389
	"EHLO athlon.internal") by vger.kernel.org with ESMTP
	id <S135898AbRAGGrI>; Sun, 7 Jan 2001 01:47:08 -0500
Date: Sun, 7 Jan 2001 16:47:01 +1000 (EST)
From: Dave <djdave@bigpond.net.au>
To: <linux-kernel@vger.kernel.org>
Subject: ftruncate returning EPERM on vfat filesystem
Message-ID: <Pine.LNX.4.30.0101071613130.1132-100000@athlon.internal>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi everyone,

I experienced a strange problem after upgrading from 2.4.0-test12 to the
2.4.0 kernel.  My samba configuration stopped working.  Reverting back to
2.4.0-test12, it magically starts working again.

(2.4.0 also hard-locked my machine before I noticed this problem, but
I'll report that later when I work out why.)

I share a local vfat filesystem to a windows machine.  With 2.4.0, the
client kept randomly reporting "...Access is denied.. Make sure the disk
is not full or write-protected..." when transferring files to this
machine.  After much cursing and hair-pulling, I straced samba under both
kernels, and found out that ftruncate was returning EPERM under 2.4.0.

After diffing between 2.4.0-test12 and 2.4.0, i found this little chunk
in fat_notify_change() which may explain the problem:

diff -u --new-file --recursive linux-2.4.0-test12/fs/fat/inode.c linux-2.4.0/fs/fat/inode.c
--- linux-2.4.0-test12/fs/fat/inode.c   Tue Dec  5 13:00:44 2000
+++ linux-2.4.0/fs/fat/inode.c  Mon Jan  1 05:02:21 2001
@@ -903,6 +903,12 @@
        struct super_block *sb = dentry->d_sb;
        struct inode *inode = dentry->d_inode;
        int error;
+
+       /* FAT cannot truncate to a longer file */
+       if (attr->ia_valid & ATTR_SIZE) {
+               if (attr->ia_size > inode->i_size)
+                       return -EPERM;
+       }

        error = inode_change_ok(inode, attr);
        if (error)

Can someone tell me if this is the cause of my samba problems, and if
so, why this was added and if this is safe to revert?

TIA.

David.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
