Return-Path: <linux-kernel-owner+w=401wt.eu-S1751421AbWLLPWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWLLPWQ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 10:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWLLPWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 10:22:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35682 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417AbWLLPWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 10:22:15 -0500
Message-ID: <457EC924.3000401@redhat.com>
Date: Tue, 12 Dec 2006 09:22:12 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: ext4 development <linux-ext4@vger.kernel.org>
Subject: [PATCH] process orphan list if device transitions to readonly
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a patch in -mm now to skip orphan inode processing on a read-only
device (where IO may fail if issued), but Stephen points out that if
the device ever transitions back to readwrite, and the filesystem is
remounted as rewrite, we should process the orphan inode list at that point.

Today, I'm not sure how we can easily get into this situation - for example,
lvm apparently cannot transform a RO snapshot into RW.  But it is at least
possible to do this.  For example I tested by:

create orphan list
crash
mark block device RO via BLKROSET
mount fs RO
mark block device RW via BLKROSET
remount fs RW

so it's within the realm of possibility, certainly.

here's what I came up with; I'm not very pleased with it though, but I need
some way to let ext3_orphan_del know that the sb is already locked and it's
safe to do this orphan processing w/o re-taking it, so I added a state flag...
It's worked in my testing.  Comments or commit would be appreciated.

Thanks,

-Eric

Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Index: linux-2.6.19/fs/ext3/namei.c
===================================================================
--- linux-2.6.19.orig/fs/ext3/namei.c
+++ linux-2.6.19/fs/ext3/namei.c
@@ -1942,15 +1942,15 @@ int ext3_orphan_del(handle_t *handle, st
 	struct ext3_iloc iloc;
 	int err = 0;
 
-	lock_super(inode->i_sb);
-	if (list_empty(&ei->i_orphan)) {
-		unlock_super(inode->i_sb);
-		return 0;
-	}
+	sbi = EXT3_SB(inode->i_sb);
+	if (!(sbi->s_mount_state & EXT3_REMOUNTING_FS))
+		lock_super(inode->i_sb);
+
+	if (list_empty(&ei->i_orphan))
+		goto out;
 
 	ino_next = NEXT_ORPHAN(inode);
 	prev = ei->i_orphan.prev;
-	sbi = EXT3_SB(inode->i_sb);
 
 	jbd_debug(4, "remove inode %lu from orphan list\n", inode->i_ino);
 
@@ -1996,7 +1996,8 @@ int ext3_orphan_del(handle_t *handle, st
 out_err:
 	ext3_std_error(inode->i_sb, err);
 out:
-	unlock_super(inode->i_sb);
+	if (!(sbi->s_mount_state & EXT3_REMOUNTING_FS))
+		unlock_super(inode->i_sb);
 	return err;
 
 out_brelse:
Index: linux-2.6.19/fs/ext3/super.c
===================================================================
--- linux-2.6.19.orig/fs/ext3/super.c
+++ linux-2.6.19/fs/ext3/super.c
@@ -2358,6 +2358,10 @@ static int ext3_remount (struct super_bl
 				goto restore_opts;
 			if (!ext3_setup_super (sb, es, 0))
 				sb->s_flags &= ~MS_RDONLY;
+			EXT3_SB(sb)->s_mount_state |= (EXT3_ORPHAN_FS|EXT3_REMOUNTING_FS);
+			ext3_orphan_cleanup(sb, es);
+			EXT3_SB(sb)->s_mount_state &= ~(EXT3_ORPHAN_FS|EXT3_REMOUNTING_FS);
+
 		}
 	}
 #ifdef CONFIG_QUOTA
Index: linux-2.6.19/include/linux/ext3_fs.h
===================================================================
--- linux-2.6.19.orig/include/linux/ext3_fs.h
+++ linux-2.6.19/include/linux/ext3_fs.h
@@ -356,6 +356,7 @@ struct ext3_inode {
 #define	EXT3_VALID_FS			0x0001	/* Unmounted cleanly */
 #define	EXT3_ERROR_FS			0x0002	/* Errors detected */
 #define	EXT3_ORPHAN_FS			0x0004	/* Orphans being recovered */
+#define	EXT3_REMOUNTING_FS		0x0008	/* Filesystem remounting, sb locked */
 
 /*
  * Mount flags


