Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263416AbRGKSJi>; Wed, 11 Jul 2001 14:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263089AbRGKSJ3>; Wed, 11 Jul 2001 14:09:29 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:19959 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S264797AbRGKSJW>; Wed, 11 Jul 2001 14:09:22 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107111806.f6BI6h43009023@webber.adilger.int>
Subject: Re: Filesystem can be marked clear when it is not
In-Reply-To: <20010710232603.A242@bug.ucw.cz> "from Pavel Machek at Jul 10, 2001
 11:26:03 pm"
To: Pavel Machek <pavel@suse.cz>
Date: Wed, 11 Jul 2001 12:06:42 -0600 (MDT)
CC: kernel list <linux-kernel@vger.kernel.org>, viro@math.psu.edu,
        torvalds@transmeta.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ext2 development mailing list 
	<ext2-devel@lists.sourceforge.net>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel writes:
> Long time ago I noticed that forced reboot from multiuser (/ mounted
> rw long time ago) sometimes does not force filesystem check. It
> happened again today...
> 
> So I remounted r/o and fsck-ed. And hey, they are errors: [zero dtimes
> are ok, but bitmap differences really are not].

It is funny you should mention this, as I made a patch last night for
exactly this problem (Andrew Morton and Ted Ts'o have noticed this as
well, and we discussed it previously on ext2-devel), and I only just
got around to separating out the patch...

> I *think* that we do not force ordering of "mark filesystem unclean"
> and writes to filesystem. And we really *should* force that
> ordering... Quick and dirty solution would be to sync just after we
> mark filesystem dirty...

Basically this is what the patch does.  For the (very rare) cases where
we change the VALID or ERROR flags on the filesystem, we write the super
block to disk synchronously.  This does not impact performance under normal
operations, only a millisecond at mount/unmount and on error.

Note that I left ext2_panic() alone.  It is not clear whether it should
be doing sync I/O in this case, and it is just a cop-out.  It is only
called from a couple of impossible-to-reach places that should probably
be eliminated anyways (i.e. NULL pointers that are always set at fs
mount time).

Cheers, Andreas
============================ ext2-commit.diff ==========================
diff -ru linux.orig/fs/ext2/super.c linux/fs/ext2/super.c
--- linux.orig/fs/ext2/super.c	Tue May 29 13:13:19 2001
+++ linux/fs/ext2/super.c	Wed Jul 11 11:48:40 2001
@@ -28,39 +28,54 @@
 #include <asm/uaccess.h>
 
 
+static void ext2_sync_super(struct super_block *sb,
+			    struct ext2_super_block *es);
 
 static char error_buf[1024];
 
+/*
+ * Deal with the reporting of failure conditions on a filesystem such as
+ * inconsistencies detected in the on-disk structure or read IO failures.
+ * We set an error flag in the superblock and e2fsck will check this after
+ * each boot.
+ */
 void ext2_error (struct super_block * sb, const char * function,
 		 const char * fmt, ...)
 {
 	va_list args;
+	struct ext2_super_block *es = EXT2_SB(sb)->s_es;
 
 	if (!(sb->s_flags & MS_RDONLY)) {
 		sb->u.ext2_sb.s_mount_state |= EXT2_ERROR_FS;
-		sb->u.ext2_sb.s_es->s_state =
-			cpu_to_le16(le16_to_cpu(sb->u.ext2_sb.s_es->s_state) | EXT2_ERROR_FS);
-		mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
-		sb->s_dirt = 1;
+		es->s_state =
+			cpu_to_le16(le16_to_cpu(es->s_state) | EXT2_ERROR_FS);
+		ext2_sync_super(sb, es);
 	}
 	va_start (args, fmt);
 	vsprintf (error_buf, fmt, args);
 	va_end (args);
 	if (test_opt (sb, ERRORS_PANIC) ||
-	    (le16_to_cpu(sb->u.ext2_sb.s_es->s_errors) == EXT2_ERRORS_PANIC &&
+	    (le16_to_cpu(es->s_errors) == EXT2_ERRORS_PANIC &&
 	     !test_opt (sb, ERRORS_CONT) && !test_opt (sb, ERRORS_RO)))
 		panic ("EXT2-fs panic (device %s): %s: %s\n",
 		       bdevname(sb->s_dev), function, error_buf);
 	printk (KERN_CRIT "EXT2-fs error (device %s): %s: %s\n",
 		bdevname(sb->s_dev), function, error_buf);
 	if (test_opt (sb, ERRORS_RO) ||
-	    (le16_to_cpu(sb->u.ext2_sb.s_es->s_errors) == EXT2_ERRORS_RO &&
-	     !test_opt (sb, ERRORS_CONT) && !test_opt (sb, ERRORS_PANIC))) {
+	    (le16_to_cpu(es->s_errors) == EXT2_ERRORS_RO &&
+	     !test_opt (sb, ERRORS_CONT))) {
 		printk ("Remounting filesystem read-only\n");
 		sb->s_flags |= MS_RDONLY;
 	}
 }
 
+/* Deal with the reporting of failure conditions while running, such as
+ * inconsistencies in operation or invalid system states where it is not
+ * possible to continue.
+ *
+ * Use ext2_error() for cases of invalid filesystem states, as that allows
+ * the administrator to control the error behaviour to meet their needs.
+ */
 NORET_TYPE void ext2_panic (struct super_block * sb, const char * function,
 			    const char * fmt, ...)
 {
@@ -124,8 +139,10 @@
 	int i;
 
 	if (!(sb->s_flags & MS_RDONLY)) {
-		sb->u.ext2_sb.s_es->s_state = le16_to_cpu(sb->u.ext2_sb.s_mount_state);
-		mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
+		struct ext2_super_block *es = EXT2_SB(sb)->s_es;
+
+		es->s_state = le16_to_cpu(EXT2_SB(sb)->s_mount_state);
+		ext2_sync_super(sb, es);
 	}
 	db_count = EXT2_SB(sb)->s_gdb_count;
 	for (i = 0; i < db_count; i++)
@@ -310,8 +327,7 @@
 		es->s_max_mnt_count = (__s16) cpu_to_le16(EXT2_DFL_MAX_MNT_COUNT);
 	es->s_mnt_count=cpu_to_le16(le16_to_cpu(es->s_mnt_count) + 1);
 	es->s_mtime = cpu_to_le32(CURRENT_TIME);
-	mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
-	sb->s_dirt = 1;
+	ext2_sync_super(sb, es);
 	if (test_opt (sb, DEBUG))
 		printk ("[EXT II FS %s, %s, bs=%lu, fs=%lu, gc=%lu, "
 			"bpg=%lu, ipg=%lu, mo=%04lx]\n",
@@ -663,6 +679,15 @@
 	sb->s_dirt = 0;
 }
 
+static void ext2_sync_super(struct super_block *sb, struct ext2_super_block *es)
+{
+	es->s_wtime = cpu_to_le32(CURRENT_TIME);
+	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
+	ll_rw_block(WRITE, 1, &EXT2_SB(sb)->s_sbh);
+	wait_on_buffer(EXT2_SB(sb)->s_sbh);
+	sb->s_dirt = 0;
+}
+
 /*
  * In the second extended file system, it is not necessary to
  * write the super block since we use a mapping of the
@@ -681,13 +706,13 @@
 	if (!(sb->s_flags & MS_RDONLY)) {
 		es = sb->u.ext2_sb.s_es;
 
-		ext2_debug ("setting valid to 0\n");
-
 		if (le16_to_cpu(es->s_state) & EXT2_VALID_FS) {
+			ext2_debug ("setting valid to 0\n");
 			es->s_state = cpu_to_le16(le16_to_cpu(es->s_state) & ~EXT2_VALID_FS);
 			es->s_mtime = cpu_to_le32(CURRENT_TIME);
-		}
-		ext2_commit_super (sb, es);
+			ext2_sync_super(sb, es);
+		} else
+			ext2_commit_super (sb, es);
 	}
 	sb->s_dirt = 0;
 }
@@ -724,9 +749,7 @@
 		 */
 		es->s_state = cpu_to_le16(sb->u.ext2_sb.s_mount_state);
 		es->s_mtime = cpu_to_le32(CURRENT_TIME);
-		mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
-		sb->s_dirt = 1;
-		ext2_commit_super (sb, es);
+		ext2_sync_super(sb, es);
 	}
 	else {
 		int ret;
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
