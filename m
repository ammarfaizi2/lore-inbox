Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269028AbRHBPrA>; Thu, 2 Aug 2001 11:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269047AbRHBPqu>; Thu, 2 Aug 2001 11:46:50 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:56079 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S269041AbRHBPql>; Thu, 2 Aug 2001 11:46:41 -0400
From: Nikita Danilov <NikitaDanilov@Yahoo.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15209.30134.699801.417492@beta.namesys.com>
Date: Thu, 2 Aug 2001 19:45:58 +0400
To: Linus Torvalds <Torvalds@Transmeta.COM>
CC: Reiserfs developers mail-list <Reiserfs-Dev@Namesys.COM>,
        linux-kernel@vger.kernel.org
Subject: [PATCH]: reiserfs: D-clear-i_blocks.patch
X-Mailer: VM 6.89 under 21.1 (patch 8) "Bryce Canyon" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

This patch sets inode.i_blocks to zero on deletion of reiserfs
file. This in particular cures hard to believe bug when saving file in
EMACS caused top to loose sight of all processes:
 . reiserfs didn't properly cleared i_blocks when removing
   symlinks. Actually -7 was inserted into unsigned i_blocks field. This
   didn't usually hurt because file is being deleted;
 . inode is reused for procfs and neither get_new_inode() nor
   proc_read_inode() cleared i_blocks;
 . now procfs inode has huge i_blocks field;
 . top calls stat on it and libc wrapper returns EOVERFLOW, as i_blocks
   doesn't fit into user-level struct.
 . top sees nothing.
  
[lkml: please CC me, I am not subscribed.]

Nikita.
diff -rup linux-2.4.8-pre3/fs/reiserfs/inode.c linux-2.4.8-pre3.patched/fs/reiserfs/inode.c
--- linux-2.4.8-pre3/fs/reiserfs/inode.c	Wed Aug  1 17:21:10 2001
+++ linux-2.4.8-pre3.patched/fs/reiserfs/inode.c	Wed Aug  1 21:33:37 2001
@@ -55,6 +55,7 @@ void reiserfs_delete_inode (struct inode
 	;
     }
     clear_inode (inode); /* note this must go after the journal_end to prevent deadlock */
+    inode->i_blocks = 0;
     unlock_kernel() ;
 }
 
