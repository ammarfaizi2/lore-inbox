Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263138AbTDRQFA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 12:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263140AbTDRQD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 12:03:59 -0400
Received: from verein.lst.de ([212.34.181.86]:13325 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S263138AbTDRQBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 12:01:10 -0400
Date: Fri, 18 Apr 2003 18:13:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] devfs (5/7) - sanitize devfs_register_tape prototype
Message-ID: <20030418181304.E363@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pass in the path directly instead of getting it from a devfs_handle_t.


diff -Nru a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c	Fri Apr 18 15:58:31 2003
+++ b/drivers/ide/ide-tape.c	Fri Apr 18 15:58:31 2003
@@ -6318,7 +6318,7 @@
 			S_IFCHR | S_IRUGO | S_IWUGO,
 			&idetape_fops, NULL);
 
-	drive->disk->number = devfs_register_tape(drive->de);
+	drive->disk->number = devfs_register_tape(drive->devfs_name);
 	drive->disk->fops = &idetape_block_ops;
 	return 0;
 failed:
diff -Nru a/drivers/scsi/osst.c b/drivers/scsi/osst.c
--- a/drivers/scsi/osst.c	Fri Apr 18 15:58:31 2003
+++ b/drivers/scsi/osst.c	Fri Apr 18 15:58:31 2003
@@ -5571,7 +5571,7 @@
 					S_IFCHR | S_IRUGO | S_IWUGO,
 					&osst_fops, NULL);
 	}
-	drive->number = devfs_register_tape (SDp->de);
+	drive->number = devfs_register_tape(SDp->devfs_name);
 
 	printk(KERN_INFO
 		"osst :I: Attached OnStream %.5s tape at scsi%d, channel %d, id %d, lun %d as %s\n",
diff -Nru a/drivers/scsi/st.c b/drivers/scsi/st.c
--- a/drivers/scsi/st.c	Fri Apr 18 15:58:31 2003
+++ b/drivers/scsi/st.c	Fri Apr 18 15:58:31 2003
@@ -3909,7 +3909,7 @@
 				S_IFCHR | S_IRUGO | S_IWUGO,
 				&st_fops, NULL);
 	}
-	disk->number = devfs_register_tape(SDp->de);
+	disk->number = devfs_register_tape(SDp->devfs_name);
 
 	printk(KERN_WARNING
 	"Attached scsi tape %s at scsi%d, channel %d, id %d, lun %d\n",
diff -Nru a/fs/devfs/util.c b/fs/devfs/util.c
--- a/fs/devfs/util.c	Fri Apr 18 15:58:31 2003
+++ b/fs/devfs/util.c	Fri Apr 18 15:58:31 2003
@@ -77,28 +77,18 @@
 #define PRINTK(format, args...) \
    {printk (KERN_ERR "%s" format, __FUNCTION__ , ## args);}
 
-
-/*  Private functions follow  */
-
-/**
- *	devfs_register_tape - Register a tape device in the "/dev/tapes" hierarchy.
- *	@de: Any tape device entry in the device directory.
- */
-
-int devfs_register_tape (devfs_handle_t de)
+int devfs_register_tape(const char *name)
 {
-    int pos;
-    char name[32], dest[64];
-    static unsigned int tape_counter;
-    int n = tape_counter++;
+	char tname[32], dest[64];
+	static unsigned int tape_counter;
+	unsigned int n = tape_counter++;
+
+	sprintf(dest, "../%s", name);
+	sprintf(tname, "tapes/tape%u", n);
+	devfs_mk_symlink(tname, dest);
 
-    pos = devfs_generate_path (de, dest + 3, sizeof dest - 3);
-    if (pos < 0) return -1;
-    strncpy (dest + pos, "../", 3);
-    sprintf (name, "tapes/tape%u", n);
-    devfs_mk_symlink (name, dest + pos);
-    return n;
-}   /*  End Function devfs_register_tape  */
+	return n;
+}
 EXPORT_SYMBOL(devfs_register_tape);
 
 void devfs_unregister_tape(int num)
diff -Nru a/include/linux/devfs_fs_kernel.h b/include/linux/devfs_fs_kernel.h
--- a/include/linux/devfs_fs_kernel.h	Fri Apr 18 15:58:31 2003
+++ b/include/linux/devfs_fs_kernel.h	Fri Apr 18 15:58:31 2003
@@ -32,7 +32,7 @@
 extern void devfs_remove(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
 extern int devfs_generate_path (devfs_handle_t de, char *path, int buflen);
-extern int devfs_register_tape (devfs_handle_t de);
+extern int devfs_register_tape(const char *name);
 extern void devfs_unregister_tape(int num);
 extern void devfs_create_partitions(struct gendisk *dev);
 extern void devfs_create_cdrom(struct gendisk *dev);
