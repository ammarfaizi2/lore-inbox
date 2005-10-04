Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbVJDQsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbVJDQsr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 12:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbVJDQsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 12:48:47 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:6315 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964851AbVJDQsr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 12:48:47 -0400
Date: Tue, 4 Oct 2005 17:48:44 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Tigran A. Aivazian" <tigran@veritas.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] bfs iget() abuses
Message-ID: <20051004164844.GH7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	bfs_fill_super() walks the inode table to get the bitmap of
free inodes and collect stats.  It has no business using iget() for
that - it's a lot of extra work, extra icache pollution and more
complex code.  Switched to walking the damn thing directly.

	Note: that also allows to kill ->i_dsk_ino in there - separate
patch if Tigran can confirm that this field can be zero only for deleted
inodes (i.e. something that could only be found during that scan and not
by normal lookups).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
[this is a followup to Alexey's bfs annotations patch]

diff -urN RC14-rc3-git4-base/fs/bfs/inode.c current/fs/bfs/inode.c
--- RC14-rc3-git4-base/fs/bfs/inode.c	2005-10-04 12:30:06.000000000 -0400
+++ current/fs/bfs/inode.c	2005-10-04 05:57:46.000000000 -0400
@@ -362,23 +362,41 @@
 	info->si_lf_eblk = 0;
 	info->si_lf_sblk = 0;
 	info->si_lf_ioff = 0;
+	bh = NULL;
 	for (i=BFS_ROOT_INO; i<=info->si_lasti; i++) {
-		inode = iget(s,i);
-		if (BFS_I(inode)->i_dsk_ino == 0)
+		struct bfs_inode *di;
+		int block = (i - BFS_ROOT_INO)/BFS_INODES_PER_BLOCK + 1;
+		int off = (i - BFS_ROOT_INO) % BFS_INODES_PER_BLOCK;
+		unsigned long sblock, eblock;
+
+		if (!off) {
+			brelse(bh);
+			bh = sb_bread(s, block);
+		}
+
+		if (!bh)
+			continue;
+
+		di = (struct bfs_inode *)bh->b_data + off;
+
+		if (!di->i_ino) {
 			info->si_freei++;
-		else {
-			set_bit(i, info->si_imap);
-			info->si_freeb -= inode->i_blocks;
-			if (BFS_I(inode)->i_eblock > info->si_lf_eblk) {
-				info->si_lf_eblk = BFS_I(inode)->i_eblock;
-				info->si_lf_sblk = BFS_I(inode)->i_sblock;
-				info->si_lf_ioff = BFS_INO2OFF(i);
-			}
+			continue;
+		}
+		set_bit(i, info->si_imap);
+		info->si_freeb -= BFS_FILEBLOCKS(di);
+
+		sblock =  le32_to_cpu(di->i_sblock);
+		eblock =  le32_to_cpu(di->i_eblock);
+		if (eblock > info->si_lf_eblk) {
+			info->si_lf_eblk = eblock;
+			info->si_lf_sblk = sblock;
+			info->si_lf_ioff = BFS_INO2OFF(i);
 		}
-		iput(inode);
 	}
+	brelse(bh);
 	if (!(s->s_flags & MS_RDONLY)) {
-		mark_buffer_dirty(bh);
+		mark_buffer_dirty(info->si_sbh);
 		s->s_dirt = 1;
 	} 
 	dump_imap("read_super", s);
