Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030529AbVJ1SXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030529AbVJ1SXy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 14:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030568AbVJ1SXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 14:23:54 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:18941 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1030529AbVJ1SXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 14:23:54 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix ext3 warning for unused var
References: <20051009195850.27237.90873.stgit@zion.home.lan>
	<Pine.LNX.4.64.0510091314200.31407@g5.osdl.org>
From: Peter Osterlund <petero2@telia.com>
Date: 28 Oct 2005 20:23:39 +0200
In-Reply-To: <Pine.LNX.4.64.0510091314200.31407@g5.osdl.org>
Message-ID: <m3acgto5zo.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 9 Oct 2005, Paolo 'Blaisorblade' Giarrusso wrote:
> >
> > Can please someone merge this? It's the 3rd time I send it.
> 
> I don't like #ifdef's in code. 
> 
> You could just have split up the quota-specific stuff into a function of 
> their own: "ext3_show_quota_options()". The patch might have been larger, 
> but it would actually clean up the code rather than make it uglier.
> 
> Warnings are not a reason for ugly code.

Fix compile warning in ext3 quota code.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 fs/ext3/super.c |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/ext3/super.c b/fs/ext3/super.c
index 9e24ceb..097383c 100644
--- a/fs/ext3/super.c
+++ b/fs/ext3/super.c
@@ -510,19 +510,11 @@ static void ext3_clear_inode(struct inod
 	kfree(rsv);
 }
 
-static int ext3_show_options(struct seq_file *seq, struct vfsmount *vfs)
+static inline void ext3_show_quota_options(struct seq_file *seq, struct super_block *sb)
 {
-	struct super_block *sb = vfs->mnt_sb;
+#if defined(CONFIG_QUOTA)
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
 
-	if (test_opt(sb, DATA_FLAGS) == EXT3_MOUNT_JOURNAL_DATA)
-		seq_puts(seq, ",data=journal");
-	else if (test_opt(sb, DATA_FLAGS) == EXT3_MOUNT_ORDERED_DATA)
-		seq_puts(seq, ",data=ordered");
-	else if (test_opt(sb, DATA_FLAGS) == EXT3_MOUNT_WRITEBACK_DATA)
-		seq_puts(seq, ",data=writeback");
-
-#if defined(CONFIG_QUOTA)
 	if (sbi->s_jquota_fmt)
 		seq_printf(seq, ",jqfmt=%s",
 		(sbi->s_jquota_fmt == QFMT_VFS_OLD) ? "vfsold": "vfsv0");
@@ -539,6 +531,20 @@ static int ext3_show_options(struct seq_
 	if (sbi->s_mount_opt & EXT3_MOUNT_GRPQUOTA)
 		seq_puts(seq, ",grpquota");
 #endif
+}
+
+static int ext3_show_options(struct seq_file *seq, struct vfsmount *vfs)
+{
+	struct super_block *sb = vfs->mnt_sb;
+
+	if (test_opt(sb, DATA_FLAGS) == EXT3_MOUNT_JOURNAL_DATA)
+		seq_puts(seq, ",data=journal");
+	else if (test_opt(sb, DATA_FLAGS) == EXT3_MOUNT_ORDERED_DATA)
+		seq_puts(seq, ",data=ordered");
+	else if (test_opt(sb, DATA_FLAGS) == EXT3_MOUNT_WRITEBACK_DATA)
+		seq_puts(seq, ",data=writeback");
+
+	ext3_show_quota_options(seq, sb);
 
 	return 0;
 }

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
