Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbTFTPiB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 11:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263239AbTFTPhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 11:37:19 -0400
Received: from [66.212.224.118] ([66.212.224.118]:45322 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S263212AbTFTPgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 11:36:52 -0400
Date: Fri, 20 Jun 2003 11:39:24 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Urban Widmark <urban@teststation.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5] Ugly workaround for smb_proc_getattr oops
Message-ID: <Pine.LNX.4.53.0306201136200.2627@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is by no means a solution, but only a workaround until something 
get's hashed out.

Unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
6b6b6b6b
*pde = 00000000
Oops: 0000 [#1]
CPU:    2
EIP:    0060:[<6b6b6b6b>]    Not tainted
EFLAGS: 00210246
EIP is at 0x6b6b6b6b
eax: ca52dd6c   ebx: cb74331c   ecx: c7207e3c   edx: cb74331c
esi: c7207e3c   edi: c0a89288   ebp: c0a89288   esp: c7207e0c
ds: 007b   es: 007b   ss: 0068
Process xmms (pid: 2732, threadinfo=c7206000 task=c88acce0)
Stack: c0208ba7 cb74331c c0a89288 c7207e3c cb74331c c7207e3c 00000000 c0a89288 
       c7207e3c c020a277 c0a89288 c7207e3c 00000000 00000000 00010000 00000000 
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
Call Trace:
 [<c0208ba7>] smb_proc_getattr+0x27/0x40
 [<c020a277>] smb_lookup+0x57/0x190
 [<c016f72a>] real_lookup+0xaa/0xd0
 [<c016fb9f>] do_lookup+0x6f/0x80
 [<c016fcc7>] link_path_walk+0x117/0xb20
 [<c012c174>] run_timer_softirq+0x104/0x260
 [<c017112f>] open_namei+0x7f/0x510
 [<c0146970>] check_poison_obj+0x30/0x170
 [<c015f544>] filp_open+0x34/0x60
 [<c016f28b>] getname+0x6b/0xb0
 [<c015fadb>] sys_open+0x3b/0x70
 [<c0109567>] syscall_call+0x7/0xb

Code:  Bad EIP value.

Index: linux-2.5/include/linux/smb_fs.h
===================================================================
RCS file: /home/cvs/linux-2.5/include/linux/smb_fs.h,v
retrieving revision 1.14
diff -u -p -B -r1.14 smb_fs.h
--- linux-2.5/include/linux/smb_fs.h	8 Oct 2002 23:53:00 -0000	1.14
+++ linux-2.5/include/linux/smb_fs.h	20 Jun 2003 14:29:31 -0000
@@ -198,7 +198,7 @@ smb_is_open(struct inode *i)
 	return (SMB_I(i)->open == server_from_inode(i)->generation);
 }
 
-
+extern void smb_install_null_ops(struct smb_ops *);
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_SMB_FS_H */
Index: linux-2.5/fs/smbfs/inode.c
===================================================================
RCS file: /home/cvs/linux-2.5/fs/smbfs/inode.c,v
retrieving revision 1.41
diff -u -p -B -r1.41 inode.c
--- linux-2.5/fs/smbfs/inode.c	26 May 2003 01:04:50 -0000	1.41
+++ linux-2.5/fs/smbfs/inode.c	20 Jun 2003 14:29:31 -0000
@@ -526,6 +526,7 @@ int smb_fill_super(struct super_block *s
 		goto out_no_mem;
 
 	server->ops = mem;
+	smb_install_null_ops(server->ops);
 	server->mnt = mem + sizeof(struct smb_ops);
 
 	/* Setup NLS stuff */
Index: linux-2.5/fs/smbfs/proc.c
===================================================================
RCS file: /home/cvs/linux-2.5/fs/smbfs/proc.c,v
retrieving revision 1.31
diff -u -p -B -r1.31 proc.c
--- linux-2.5/fs/smbfs/proc.c	7 Jun 2003 19:05:54 -0000	1.31
+++ linux-2.5/fs/smbfs/proc.c	20 Jun 2003 14:29:32 -0000
@@ -2802,6 +2802,13 @@ out:
 	return result;
 }
 
+static int
+smb_proc_getattr_null(struct smb_sb_info *server, struct dentry *dir,
+		      struct smb_fattr *attr)
+{
+	return -EIO;
+}
+
 int
 smb_proc_getattr(struct dentry *dir, struct smb_fattr *fattr)
 {
@@ -3429,3 +3436,14 @@ static struct smb_ops smb_ops_unix =
 	/* .setattr	= smb_proc_setattr_unix, */
 	.truncate	= smb_proc_trunc64,
 };
+
+/* Place holder until real ops are in place */
+static struct smb_ops smb_ops_null =
+{
+	.getattr	= smb_proc_getattr_null,
+};
+
+void smb_install_null_ops(struct smb_ops *ops)
+{
+	install_ops(ops, &smb_ops_null);
+}
