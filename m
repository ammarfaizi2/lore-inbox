Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272242AbRH3O23>; Thu, 30 Aug 2001 10:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272241AbRH3O2O>; Thu, 30 Aug 2001 10:28:14 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:6155 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S272235AbRH3O14>; Thu, 30 Aug 2001 10:27:56 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15246.19766.999421.244992@gargle.gargle.HOWL>
Date: Thu, 30 Aug 2001 18:27:02 +0400
To: Linus Torvalds <Torvalds@Transmeta.COM>
Cc: Reiserfs developers mail-list <Reiserfs-Dev@Namesys.COM>,
        "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: [PATCH]: reiserfs: D-clear-i_blocks.patch
X-Mailer: VM 6.89 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
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
   Alexander Viro and other people proposed that in stead i_blocks
   should be cleared in generic VFS code. This patch is minimal
   change required to correct bug.

This patch is against 2.4.10-pre2.
Please apply.

Nikita.
diff -rup linux/fs/reiserfs/inode.c linux.patched/fs/reiserfs/inode.c
--- linux/fs/reiserfs/inode.c	Wed Aug  1 17:21:10 2001
+++ linux.patched/fs/reiserfs/inode.c	Wed Aug  1 21:33:37 2001
@@ -55,6 +55,7 @@ void reiserfs_delete_inode (struct inode
 	;
     }
     clear_inode (inode); /* note this must go after the journal_end to prevent deadlock */
+    inode->i_blocks = 0;
     unlock_kernel() ;
 }
 
