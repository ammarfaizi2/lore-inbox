Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272231AbRH3OX7>; Thu, 30 Aug 2001 10:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272232AbRH3OXu>; Thu, 30 Aug 2001 10:23:50 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:37642 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S272231AbRH3OXf>; Thu, 30 Aug 2001 10:23:35 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15246.19448.805095.697159@gargle.gargle.HOWL>
Date: Thu, 30 Aug 2001 18:21:44 +0400
To: Linus Torvalds <Torvalds@Transmeta.COM>
Cc: Reiserfs developers mail-list <Reiserfs-Dev@Namesys.COM>,
        "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: [PATCH]: reiserfs: A-panic-in-reiserfs_read_super.patch
X-Mailer: VM 6.89 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

    This patch allows reiserfs to cope with an attempt to mount file-system
    with corrupted super-block: reiserfs stores both version-dependent magic
    and version itself in a super-block. This patch just returns error
    rather than panics if they don't match.

(This patch is bug fix just like most other patches I'll send today.
Linus, I sent them several (four, I guess) times already, but they
didn't get in. Can you please clarify on this, because we are so
confused.)

This patch is against 2.4.10-pre2.
Please apply.

Nikita.
diff -rup linux/fs/reiserfs/super.c linux.patched/fs/reiserfs/super.c
--- linux/fs/reiserfs/super.c	Wed Jul  4 13:45:55 2001
+++ linux.patched/fs/reiserfs/super.c	Wed Aug  1 21:08:16 2001
@@ -779,16 +779,23 @@ struct super_block * reiserfs_read_super
 
     if (!(s->s_flags & MS_RDONLY)) {
 	struct reiserfs_super_block * rs = SB_DISK_SUPER_BLOCK (s);
+	int old_magic;
+
+	old_magic = strncmp (rs->s_magic,  REISER2FS_SUPER_MAGIC_STRING, 
+			     strlen ( REISER2FS_SUPER_MAGIC_STRING));
+	if( old_magic && le16_to_cpu(rs->s_version) != 0 ) {
+	  dput(s->s_root) ;
+	  s->s_root = NULL ;
+	  reiserfs_warning("reiserfs: wrong version/magic combination in the super-block\n") ;
+	  goto error ;
+	}
 
 	journal_begin(&th, s, 1) ;
 	reiserfs_prepare_for_journal(s, SB_BUFFER_WITH_SB(s), 1) ;
 
 	rs->s_state = cpu_to_le16 (REISERFS_ERROR_FS);
 
-        if (strncmp (rs->s_magic,  REISER2FS_SUPER_MAGIC_STRING, 
-		     strlen ( REISER2FS_SUPER_MAGIC_STRING))) {
-	    if (le16_to_cpu(rs->s_version) != 0)
-		BUG ();
+        if ( old_magic ) {
 	    // filesystem created under 3.5.x found
 	    if (!old_format_only (s)) {
 		reiserfs_warning("reiserfs: converting 3.5.x filesystem to the new format\n") ;
