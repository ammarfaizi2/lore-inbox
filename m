Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262588AbSJGT1c>; Mon, 7 Oct 2002 15:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262585AbSJGTZp>; Mon, 7 Oct 2002 15:25:45 -0400
Received: from mail2.ameuro.de ([62.208.90.8]:42399 "EHLO mail2.ameuro.de")
	by vger.kernel.org with ESMTP id <S262592AbSJGTYk>;
	Mon, 7 Oct 2002 15:24:40 -0400
Date: Mon, 7 Oct 2002 21:30:14 +0200
From: Anders Larsen <al@alarsen.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.41 qnx4fs (2/2): recognize qnx6 file-systems
Message-ID: <20021007193014.GC1568@errol.alarsen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
this patch (forward ported from 2.4.19) replaces the check for the QNX
boot-sector signature by a check for another signature in the superblock
(the (invariant) name of the root dir) - this allows us to mount
partitions created with QNX 6.1 (that don't have the boot-sector
signature we used to check for), without breaking existing
functionality.
The corresponding updates to fs/Config.help have somehow already found
their way into your tree...
Please apply.

Cheers
  Anders (maintainer)


diff -ur linux-2.5.41-qnx4fs-patch1/fs/qnx4/inode.c linux-2.5.41/fs/qnx4/inode.c
--- linux-2.5.41-qnx4fs-patch1/fs/qnx4/inode.c	Fri Oct  4 22:23:09 2002
+++ linux-2.5.41/fs/qnx4/inode.c	Fri Oct  4 23:04:07 2002
@@ -356,26 +356,19 @@
 
 	sb_set_blocksize(s, QNX4_BLOCK_SIZE);
 
-	/* Check the boot signature. Since the qnx4 code is
+	/* Check the superblock signature. Since the qnx4 code is
 	   dangerous, we should leave as quickly as possible
 	   if we don't belong here... */
-	bh = sb_bread(s, 0);
+	bh = sb_bread(s, 1);
 	if (!bh) {
-		printk("qnx4: unable to read the boot sector\n");
+		printk("qnx4: unable to read the superblock\n");
 		goto outnobh;
 	}
-	if ( memcmp( (char*)bh->b_data + 4, "QNX4FS", 6 ) ) {
+	if ( le32_to_cpu( *(__u32*)bh->b_data ) != QNX4_SUPER_MAGIC ) {
 		if (!silent)
-			printk("qnx4: wrong fsid in boot sector.\n");
+			printk("qnx4: wrong fsid in superblock.\n");
 		goto out;
 	}
-	brelse(bh);
-
-	bh = sb_bread(s, 1);
-	if (!bh) {
-		printk("qnx4: unable to read the superblock\n");
-		goto outnobh;
-	}
 	s->s_op = &qnx4_sops;
 	s->s_magic = QNX4_SUPER_MAGIC;
 #ifndef CONFIG_QNX4FS_RW
@@ -583,7 +576,7 @@
 		return err;
 	}
 
-	printk("QNX4 filesystem 0.2.2 registered.\n");
+	printk("QNX4 filesystem 0.2.3 registered.\n");
 	return 0;
 }
 

