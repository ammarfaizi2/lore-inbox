Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268936AbRHBOJU>; Thu, 2 Aug 2001 10:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268945AbRHBOJL>; Thu, 2 Aug 2001 10:09:11 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:52240 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S268941AbRHBOJD>; Thu, 2 Aug 2001 10:09:03 -0400
From: Nikita Danilov <NikitaDanilov@Yahoo.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15209.24275.734360.775764@beta.namesys.com>
Date: Thu, 2 Aug 2001 18:08:19 +0400
To: Linus Torvalds <Torvalds@Transmeta.COM>
CC: Reiserfs developers mail-list <Reiserfs-Dev@Namesys.COM>,
        linux-kernel@vger.kernel.org
Subject: [PATCH]: reiserfs: A-panic-in-reiserfs_read_super.patch
X-Mailer: VM 6.89 under 21.1 (patch 8) "Bryce Canyon" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

some bug-fixes for reiserfs missed 2.4.8-pre kernels. I am resending
them.

this patch allows reiserfs to cope with an attempt to mount file-system
with corrupted super-block: reiserfs stores both version-dependent magic
and version itself in a super-block. This patch just returns error
rather than panics if they don't match. Please apply.

[lkml: please CC me, I am not subscribed.]

Nikita.
diff -rup linux-2.4.8-pre3/fs/reiserfs/super.c linux-2.4.8-pre3.patched/fs/reiserfs/super.c
--- linux-2.4.8-pre3/fs/reiserfs/super.c	Wed Jul  4 13:45:55 2001
+++ linux-2.4.8-pre3.patched/fs/reiserfs/super.c	Wed Aug  1 21:08:16 2001
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
