Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283550AbRK3IAx>; Fri, 30 Nov 2001 03:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283552AbRK3IAo>; Fri, 30 Nov 2001 03:00:44 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:29454 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S283550AbRK3IAa>; Fri, 30 Nov 2001 03:00:30 -0500
Message-ID: <3C073C96.76A7A32E@zip.com.au>
Date: Fri, 30 Nov 2001 00:00:22 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolinux.com>
CC: kernel list <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.14 still not making fs dirty when it should
In-Reply-To: <20011128231504.A26510@elf.ucw.cz> <3C069291.82E205F1@zip.com.au>, <3C069291.82E205F1@zip.com.au> <20011129120826.F7992@thune.mrc-home.com> <3C069919.E679F1F8@zip.com.au>,
		<3C069919.E679F1F8@zip.com.au>; from akpm@zip.com.au on Thu, Nov 29, 2001 at 12:22:49PM -0800 <20011129141226.N29249@lynx.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> On Nov 29, 2001  12:22 -0800, Andrew Morton wrote:
> > This actually happens.  On a stock RH7.1 setup, you can
> > hit reset as soon as you get the first login prompt.  fsck
> > will not be run on reboot.  If you run it by hand, fsck
> > finds errors.
> >
> > Andreas, my one-liner was, umm, hasty.  I think you had
> > a decent fix for this?
> 
> Yes, I thought I did as well.  It may have gotten lost during the
> -ac -> Linus merge, as I thought it was in there (some other ext2
> fixes that were definitely in -ac are not in 2.4.16).  Luckily,
> I was just generating patches of all my local changes last night,
> so I have a brand-new patch to fix this.
> 
> It _should_ do the right thing, but please give it a once-over, as
> I wrote it a long time ago.  The theory is - changing the dirty
> flag is synchronously written to disk, but other superblock changes
> are async as they always have been (sync_super vs. commit_super).
> 

Your patch isn't working quite as intended, because of this
code in ext2_remount:

                /*
                 * Mounting a RDONLY partition read-write, so reread and
                 * store the current valid flag.  (It may have been changed
                 * by e2fsck since we originally mounted the partition.)
                 */
                sb->u.ext2_sb.s_mount_state = le16_to_cpu(es->s_state);
                if (!ext2_setup_super (sb, es, 0))
                        sb->s_flags &= ~MS_RDONLY;

see, when we call ext2_setup_super(), MS_RDONLY is set, so
ext2_setup_super() doesn't write the superblock. That's
trivially fixed.

The below patch passes all the mount/remount tests I could think
of.

--- linux-2.4.17-pre1/fs/ext2/super.c	Thu Nov 22 23:02:58 2001
+++ linux-akpm/fs/ext2/super.c	Thu Nov 29 23:54:53 2001
@@ -28,6 +28,8 @@
 #include <asm/uaccess.h>
 
 
+static void ext2_sync_super(struct super_block *sb,
+			    struct ext2_super_block *es);
 
 static char error_buf[1024];
 
@@ -35,13 +37,13 @@ void ext2_error (struct super_block * sb
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
@@ -124,8 +126,10 @@ void ext2_put_super (struct super_block 
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
@@ -305,13 +309,10 @@ static int ext2_setup_super (struct supe
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
@@ -664,6 +665,15 @@ static void ext2_commit_super (struct su
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
@@ -682,13 +692,14 @@ void ext2_write_super (struct super_bloc
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
@@ -725,11 +736,7 @@ int ext2_remount (struct super_block * s
 		 */
 		es->s_state = cpu_to_le16(sb->u.ext2_sb.s_mount_state);
 		es->s_mtime = cpu_to_le32(CURRENT_TIME);
-		mark_buffer_dirty(sb->u.ext2_sb.s_sbh);
-		sb->s_dirt = 1;
-		ext2_commit_super (sb, es);
-	}
-	else {
+	} else {
 		int ret;
 		if ((ret = EXT2_HAS_RO_COMPAT_FEATURE(sb,
 					       ~EXT2_FEATURE_RO_COMPAT_SUPP))) {
@@ -747,6 +754,7 @@ int ext2_remount (struct super_block * s
 		if (!ext2_setup_super (sb, es, 0))
 			sb->s_flags &= ~MS_RDONLY;
 	}
+	ext2_sync_super(sb, es);
 	return 0;
 }
