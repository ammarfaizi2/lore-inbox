Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261481AbSJMJvG>; Sun, 13 Oct 2002 05:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261483AbSJMJvG>; Sun, 13 Oct 2002 05:51:06 -0400
Received: from mail2.ameuro.de ([62.208.90.8]:59324 "EHLO mail2.ameuro.de")
	by vger.kernel.org with ESMTP id <S261481AbSJMJvF>;
	Sun, 13 Oct 2002 05:51:05 -0400
Date: Sun, 13 Oct 2002 11:56:50 +0200
From: Anders Larsen <al@alarsen.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH][RESEND] 2.5.42 qnx4fs (2/2): recognize qnx6 file-systems
Message-ID: <20021013095650.GC1337@errol.alarsen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
please apply this patch (a forward port from 2.4.19) which replaces the
check for the QNX boot-sector signature by a check for another signature
in the superblock (the (invariant) name of the root dir).
This allows us to mount partitions created with QNX 6.1+ (that don't
have the boot-sector signature we used to check for), without breaking
existing functionality.

fs/Config.help already claims we have this functionality, so the code
really needs to be updated to reflect that...

Cheers
  Anders (qnx4fs maintainer)


diff -ur linux-2.5.42.qnx4fs-patch1/fs/qnx4/inode.c linux-2.5.42/fs/qnx4/inode.c
--- linux-2.5.42.qnx4fs-patch1/fs/qnx4/inode.c	Sun Oct 13 10:53:54 2002
+++ linux-2.5.42/fs/qnx4/inode.c	Sun Oct 13 10:54:35 2002
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
 
