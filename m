Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129652AbQLSMeT>; Tue, 19 Dec 2000 07:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130092AbQLSMeK>; Tue, 19 Dec 2000 07:34:10 -0500
Received: from smtp5.mail.yahoo.com ([128.11.69.102]:11782 "HELO
	smtp5.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130090AbQLSMeE>; Tue, 19 Dec 2000 07:34:04 -0500
X-Apparently-From: <p?gortmaker@yahoo.com>
Message-ID: <3A3F42FC.4E341732@yahoo.com>
Date: Tue, 19 Dec 2000 06:14:04 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
X-Mailer: Mozilla 3.04 (X11; I; Linux 2.2.18 i486)
MIME-Version: 1.0
To: linux-kernel list <linux-kernel@vger.kernel.org>
CC: tytso@mit.edu
Subject: [PATCH] ident of whole-disk ext2 fs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I always disliked the unknown partition table messages you get when you
mke2fs a whole disk and don't bother with a table at all, so I fixed it.
Output before/after shown below:

 Partition check:
  hda: hda1 hda2
- hdd: unknown partition table
+ hdd: whole disk EXT2-fs, revision 1.0, 1k blocks, status: clean.
 VFS: Mounted root (ext2 filesystem) readonly.
 Freeing unused kernel memory: 32k freed

Note that I placed the check right before we give up and print the unknown
message, so all the other identification schemes get their chance to prod
at the disk first.  Patch against 2.2.18 follows -- not necessarily
advocating it for 2.2 - just happened to be what I patched... :)

Paul.



--- linux-2.2.18/drivers/block/genhd.c~	Mon Dec 11 20:26:14 2000
+++ linux/drivers/block/genhd.c	Tue Dec 12 08:11:12 2000
@@ -232,6 +232,39 @@
 	return ret;
 }
 
+/*
+ * Lots of people put ext2 fs directly onto a whole disk, without a 
+ * partition table.  Looks kind of silly if we call a disk with our
+ * own filesystem "unknown". - Paul G.
+ */
+
+#ifdef CONFIG_EXT2_FS
+#include <linux/ext2_fs.h>
+
+static int ext2_partition(struct gendisk *hd, unsigned int dev, unsigned long first_sector)
+{
+	struct buffer_head *bh;
+	struct ext2_super_block *es;
+
+	if (!(bh = bread(dev, 1, get_ptable_blocksize(dev)))) {
+		printk("unable to read block one.\n");
+		return -1;
+	}
+	es = (struct ext2_super_block *) bh->b_data;
+	if (le16_to_cpu(es->s_magic) != EXT2_SUPER_MAGIC) {
+		brelse(bh);
+		return 0;
+	}
+	printk(" whole disk EXT2-fs, revision %d.%d, %dk blocks, status: %sclean.\n",
+		le32_to_cpu(es->s_rev_level),
+		le16_to_cpu(es->s_minor_rev_level),
+		1<<le32_to_cpu(es->s_log_block_size),
+		le16_to_cpu(es->s_state) == EXT2_VALID_FS ? "" : "un");
+	brelse(bh);
+	return 1;
+}
+#endif
+
 #ifdef CONFIG_MSDOS_PARTITION
 /*
  * Create devices for each logical partition in an extended partition.
@@ -1608,6 +1641,10 @@
 #endif
 #ifdef CONFIG_ARCH_S390
 	if (ibm_partition (hd, dev, first_sector))
+		return;
+#endif
+#ifdef CONFIG_EXT2_FS
+	if (ext2_partition(hd, dev, first_sector))
 		return;
 #endif
 	printk(" unknown partition table\n");



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
