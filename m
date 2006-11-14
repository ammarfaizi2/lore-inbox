Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966423AbWKNWgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966423AbWKNWgo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 17:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966418AbWKNWgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 17:36:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9178 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966415AbWKNWgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 17:36:42 -0500
Message-ID: <455A44F6.5030202@redhat.com>
Date: Tue, 14 Nov 2006 16:36:38 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: zippel@linux-m68k.org
Subject: [PATCH] hfs_fill_super returns success even if no root inode
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://kernelfun.blogspot.com/2006/11/mokb-14-11-2006-linux-26x-selinux.html

mount that image...
fs: filesystem was not cleanly unmounted, running fsck.hfs is recommended.  mounting read-only.
hfs: get root inode failed.
BUG: unable to handle kernel NULL pointer dereference at virtual address 00000018
 printing eip
...
EIP is at superblock_doinit+0x21/0x767
...
 [] selinux_sb_kern_mount+0xc/0x4b
 [] vfs_kern_mount+0x99/0xf6
 [] do_kern_mount+0x2d/0x3e
 [] do_mount+0x5fa/0x66d
 [] sys_mount+0x77/0xae
 [] syscall_call+0x7/0xb
DWARF2 unwinder stuck at syscall_call+0x7/0xb

hfs_fill_super() returns success even if 
  root_inode = hfs_iget(sb, &fd.search_key->cat, &rec);
or
  sb->s_root = d_alloc_root(root_inode);

fails.  This superblock finds its way to superblock_doinit() which does:

        struct dentry *root = sb->s_root;
        struct inode *inode = root->d_inode;

and boom.  Need to make sure the error cases return an error, I think.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Index: linux-2.6.18/fs/hfs/super.c
===================================================================
--- linux-2.6.18.orig/fs/hfs/super.c
+++ linux-2.6.18/fs/hfs/super.c
@@ -391,6 +391,7 @@ static int hfs_fill_super(struct super_b
 		hfs_find_exit(&fd);
 		goto bail_no_root;
 	}
+	res = -EINVAL;
 	root_inode = hfs_iget(sb, &fd.search_key->cat, &rec);
 	hfs_find_exit(&fd);
 	if (!root_inode)


