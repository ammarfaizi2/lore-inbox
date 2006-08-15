Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030459AbWHOTGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbWHOTGt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 15:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030463AbWHOTGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 15:06:49 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:51388 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1030459AbWHOTGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 15:06:48 -0400
Date: Tue, 15 Aug 2006 21:06:47 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH -mm] fs/inode.c tweaks
Message-ID: <20060815190647.GA23766@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only touch inode's i_mtime and i_ctime to make them equal to "now"
in case they aren't yet (don't just update timestamp unconditionally).
Uninline the hash function to save 259 Bytes.

This tiny inode change which may improve cache behaviour
also shaves off 8 Bytes from file_update_time() on i386.


Please complain loudly if you think that hash() really should remain
inlined (but note that it has 7 callsites in this file and a function size
of 42 Bytes on i386!).


0000004d <hash>:
      4d:       0f af c2                imul   %edx,%eax
      50:       81 ea ff ff c8 61       sub    $0x61c8ffff,%edx
      56:       8b 0d 04 00 00 00       mov    0x4,%ecx
                        58: R_386_32    .data.read_mostly
      5c:       55                      push   %ebp
      5d:       c1 ea 07                shr    $0x7,%edx
      60:       89 e5                   mov    %esp,%ebp
      62:       31 d0                   xor    %edx,%eax
      64:       89 c2                   mov    %eax,%edx
      66:       81 f2 01 00 37 9e       xor    $0x9e370001,%edx
      6c:       d3 ea                   shr    %cl,%edx
      6e:       31 d0                   xor    %edx,%eax
      70:       23 05 00 00 00 00       and    0x0,%eax
                        72: R_386_32    .data.read_mostly
      76:       c9                      leave
      77:       c3                      ret


Included a tiny codestyle cleanup, too.

Compile-tested and run-tested on 2.6.18-rc4-mm1.


Signed-off-by: Andreas Mohr <andi@lisas.de>


--- linux-2.6.18-rc4-mm1.orig/fs/inode.c	2006-08-22 21:13:22.000000000 +0200
+++ linux-2.6.18-rc4-mm1/fs/inode.c	2006-08-23 20:34:20.000000000 +0200
@@ -678,7 +678,7 @@
 	return inode;
 }
 
-static inline unsigned long hash(struct super_block *sb, unsigned long hashval)
+static unsigned long hash(struct super_block *sb, unsigned long hashval)
 {
 	unsigned long tmp;
 
@@ -1024,7 +1024,7 @@
 
 	list_del_init(&inode->i_list);
 	list_del_init(&inode->i_sb_list);
-	inode->i_state|=I_FREEING;
+	inode->i_state |= I_FREEING;
 	inodes_stat.nr_inodes--;
 	spin_unlock(&inode_lock);
 
@@ -1231,13 +1231,15 @@
 		return;
 
 	now = current_fs_time(inode->i_sb);
-	if (!timespec_equal(&inode->i_mtime, &now))
+	if (!timespec_equal(&inode->i_mtime, &now)) {
+		inode->i_mtime = now;
 		sync_it = 1;
-	inode->i_mtime = now;
+	}
 
-	if (!timespec_equal(&inode->i_ctime, &now))
+	if (!timespec_equal(&inode->i_ctime, &now)) {
+		inode->i_ctime = now;
 		sync_it = 1;
-	inode->i_ctime = now;
+	}
 
 	if (sync_it)
 		mark_inode_dirty_sync(inode);
