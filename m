Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283391AbRK2VNo>; Thu, 29 Nov 2001 16:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283393AbRK2VNf>; Thu, 29 Nov 2001 16:13:35 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:23802 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S283391AbRK2VNQ>;
	Thu, 29 Nov 2001 16:13:16 -0500
Date: Thu, 29 Nov 2001 14:12:26 -0700
From: Andreas Dilger <adilger@turbolinux.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Mike Castle <dalgoda@ix.netcom.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.14 still not making fs dirty when it should
Message-ID: <20011129141226.N29249@lynx.no>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Mike Castle <dalgoda@ix.netcom.com>,
	kernel list <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20011128231504.A26510@elf.ucw.cz> <3C069291.82E205F1@zip.com.au>, <3C069291.82E205F1@zip.com.au> <20011129120826.F7992@thune.mrc-home.com> <3C069919.E679F1F8@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3C069919.E679F1F8@zip.com.au>; from akpm@zip.com.au on Thu, Nov 29, 2001 at 12:22:49PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 29, 2001  12:22 -0800, Andrew Morton wrote:
> This actually happens.  On a stock RH7.1 setup, you can
> hit reset as soon as you get the first login prompt.  fsck
> will not be run on reboot.  If you run it by hand, fsck
> finds errors.
> 
> Andreas, my one-liner was, umm, hasty.  I think you had
> a decent fix for this?

Yes, I thought I did as well.  It may have gotten lost during the
-ac -> Linus merge, as I thought it was in there (some other ext2
fixes that were definitely in -ac are not in 2.4.16).  Luckily,
I was just generating patches of all my local changes last night,
so I have a brand-new patch to fix this.

It _should_ do the right thing, but please give it a once-over, as
I wrote it a long time ago.  The theory is - changing the dirty
flag is synchronously written to disk, but other superblock changes
are async as they always have been (sync_super vs. commit_super).

This should definitely go into 2.4.17-pre and 2.5.0, even though I
am personally only using ext3 at this point (I used this patch for
a long time while ext3 was not done on 2.4 though).

Cheers, Andreas
====================== ext2-2.4.16-super.diff ===========================
diff -ru linux-2.4.15.orig/fs/ext2/super.c linux-2.4.15-aed/fs/ext2/super.c
--- linux-2.4.15.orig/fs/ext2/super.c	Wed Nov 28 23:25:02 2001
+++ linux-2.4.15-aed/fs/ext2/super.c	Thu Nov 29 00:38:31 2001
@@ -28,20 +28,22 @@
 #include <asm/uaccess.h>
 
 
+static void ext2_sync_super(struct super_block *sb,
+			    struct ext2_super_block *es);
 
 static char error_buf[1024];
 
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
@@ -305,13 +321,10 @@
 		(le32_to_cpu(es->s_lastcheck) + le32_to_cpu(es->s_checkinterval) <= CURRENT_TIME))
 		printk ("EXT2-fs warning: checktime reached, "
 			"running e2fsck is recommended\n");
-	es->s_state = cpu_to_le16(le16_to_cpu(es->s_state) & ~EXT2_VALID_FS);
 	if (!(__s16) le16_to_cpu(es->s_max_mnt_count))
 		es->s_max_mnt_count = (__s16) cpu_to_le16(EXT2_DFL_MAX_MNT_COUNT);
 	es->s_mnt_count=cpu_to_le16(le16_to_cpu(es->s_mnt_count) + 1);
-	es->s_mtime = cpu_to_le32(CURRENT_TIME);
-	mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
-	sb->s_dirt = 1;
+	ext2_write_super(sb);
 	if (test_opt (sb, DEBUG))
 		printk ("[EXT II FS %s, %s, bs=%lu, fs=%lu, gc=%lu, "
 			"bpg=%lu, ipg=%lu, mo=%04lx]\n",
@@ -664,6 +681,15 @@
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
@@ -682,13 +708,14 @@
 	if (!(sb->s_flags & MS_RDONLY)) {
 		es = sb->u.ext2_sb.s_es;
 
-		ext2_debug ("setting valid to 0\n");
-
 		if (le16_to_cpu(es->s_state) & EXT2_VALID_FS) {
-			es->s_state = cpu_to_le16(le16_to_cpu(es->s_state) & ~EXT2_VALID_FS);
+			ext2_debug ("setting valid to 0\n");
+			es->s_state = cpu_to_le16(le16_to_cpu(es->s_state) &
+						  ~EXT2_VALID_FS);
 			es->s_mtime = cpu_to_le32(CURRENT_TIME);
-		}
-		ext2_commit_super (sb, es);
+			ext2_sync_super(sb, es);
+		} else
+			ext2_commit_super (sb, es);
 	}
 	sb->s_dirt = 0;
 }
@@ -725,9 +751,7 @@
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
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

