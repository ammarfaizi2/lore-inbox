Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270813AbTHJXlP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 19:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270814AbTHJXlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 19:41:15 -0400
Received: from [66.212.224.118] ([66.212.224.118]:6926 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S270813AbTHJXk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 19:40:58 -0400
Date: Sun, 10 Aug 2003 19:29:09 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.6] fix hugetlbfs slab corruption on umount
Message-ID: <Pine.LNX.4.53.0308101916080.31799@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hugetlbfs was accessing super_block->s_fs_info after free'ing it. 
This was because it was being free'd prematurely. I have deferred free until 
->put_super(). I have also removed hugetlbfs_kill_super since it now is 
simply a kill_litter_super. The odd part was that the oops says that inodes_lock 
is corrupted (trigger is lock->magic check), but that appears to be fixed 
now too.

------------[ cut here ]------------
kernel BUG at include/asm/spinlock.h:93!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c01c1006>]    Not tainted
EFLAGS: 00010a97
EIP is at hugetlbfs_forget_inode+0x1b6/0x210
eax: 0000006b   ebx: e3fb6004   ecx: 6b6b6b6c   edx: 00000001
esi: e3ea4000   edi: e3f3660c   ebp: e3f365fc   esp: e3ea5ec8
ds: 007b   es: 007b   ss: 0068
Process umount (pid: 1158, threadinfo=e3ea4000 task=e3d81000)
Stack: e3fb6004 e3ea4000 e3fb6004 c0608780 c0180df4 e3fb6004 e3d5f004 c017ca5e 
       e3fb6004 00000000 e3ea4000 c017da07 00000000 e3d5f004 e3fb0004 c0608720 
       c016a394 e3d5f004 e3fb0094 e3d5f004 e3fb0044 00000016 e3ea4000 c016b387 
Call Trace:
 [<c0180df4>] iput+0x64/0x70
 [<c017ca5e>] dput+0x2ee/0x350
 [<c017da07>] shrink_dcache_anon+0xe7/0x100
 [<c016a394>] generic_shutdown_super+0x34/0x210
 [<c016b387>] kill_anon_super+0x17/0x90
 [<c016a0d2>] deactivate_super+0xa2/0x140
 [<c0183118>] __mntput+0x18/0x30
 [<c0172699>] path_release+0x29/0x30
 [<c0183a70>] sys_umount+0x60/0x70
 [<c0156a14>] sys_munmap+0x44/0x70
 [<c0183a8c>] sys_oldumount+0xc/0x10
 [<c0109539>] sysenter_past_esp+0x52/0x79

Code: 0f 0b 5d 00 e4 97 55 c0 89 f6 8a 45 10 84 c0 7e 08 0f 0b 5e 

...

Slab corruption: start=e3f365fc, expend=e3f3661b, problemat=e3f36608
Last user: [<c01c1c79>](hugetlbfs_kill_super+0x19/0x30)
Data: ************6C ***00 **************A5 
Next: 71 F0 2C .79 1C 1C C0 71 F0 2C .********************
slab error in check_poison_obj(): cache `size-32': object was modified after freeing

Index: linux-2.6.0-test3-huge_kpage/fs/hugetlbfs/inode.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test3/fs/hugetlbfs/inode.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 inode.c
--- linux-2.6.0-test3-huge_kpage/fs/hugetlbfs/inode.c	10 Aug 2003 08:42:46 -0000	1.1.1.1
+++ linux-2.6.0-test3-huge_kpage/fs/hugetlbfs/inode.c	10 Aug 2003 23:17:49 -0000
@@ -575,6 +575,16 @@ static int hugetlbfs_rename(struct inode
 	return 0;
 }
 
+static void hugetlbfs_put_super(struct super_block *sb)
+{
+	struct hugetlbfs_sb_info *sbi = HUGETLBFS_SB(sb);
+
+	if (sbi) {
+		sb->s_fs_info = NULL;
+		kfree(sbi);
+	}
+}
+
 static struct address_space_operations hugetlbfs_aops = {
 	.readpage	= hugetlbfs_readpage,
 	.prepare_write	= hugetlbfs_prepare_write,
@@ -608,6 +618,7 @@ static struct inode_operations hugetlbfs
 static struct super_operations hugetlbfs_ops = {
 	.statfs		= hugetlbfs_statfs,
 	.drop_inode	= hugetlbfs_drop_inode,
+	.put_super	= hugetlbfs_put_super,
 };
 
 static int
@@ -709,19 +720,10 @@ static struct super_block *hugetlbfs_get
 	return get_sb_nodev(fs_type, flags, data, hugetlbfs_fill_super);
 }
 
-static void hugetlbfs_kill_super(struct super_block *sb)
-{
-	if (sb) {
-		if(sb->s_fs_info)
-			kfree(sb->s_fs_info);
-		kill_litter_super(sb);
-	}
-}
-
 static struct file_system_type hugetlbfs_fs_type = {
 	.name		= "hugetlbfs",
 	.get_sb		= hugetlbfs_get_sb,
-	.kill_sb	= hugetlbfs_kill_super
+	.kill_sb	= kill_litter_super,
 };
 
 static struct vfsmount *hugetlbfs_vfsmount;
