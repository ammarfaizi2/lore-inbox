Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965242AbWJ2P4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965242AbWJ2P4R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 10:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965267AbWJ2P4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 10:56:17 -0500
Received: from mail.parknet.jp ([210.171.160.80]:65286 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S965242AbWJ2P4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 10:56:16 -0500
X-AuthUser: hirofumi@parknet.jp
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] nfs: Fix nfs_readpages() error path
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 30 Oct 2006 00:56:08 +0900
Message-ID: <877iyjundz.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got the following oops.

------------[ cut here ]------------
kernel BUG at /devel/linux/works/linux-2.6/mm/readahead.c:315!
invalid opcode: 0000 [#1]
SMP

[...]

EFLAGS: 00210283   (2.6.19-rc3 #3)
EIP is at __do_page_cache_readahead+0x1a4/0x1b7
eax: f260db64   ebx: f8f9aa18   ecx: 00000001   edx: f7710594
esi: f6042b94   edi: f6042b84   ebp: f260db78   esp: f260db0c
ds: 007b   es: 007b   ss: 0068
Process emacs (pid: 3694, ti=f260d000 task=f670caa0 task.ti=f260d000)
Stack: 00000001 000001ac f25dd88c 0000085e 0000001e 00000001 00001000 d7f4a48c
       d7f4a50c d7f4a50c 00001000 d7f4a50c f260db60 00200246 00000001 22222222
       22222222 d7f4a50c d7f4a50c 00001000 d7f4a48c f260db68 c13cb9f8 c13cb9f8
Call Trace:
 [<c0140a3a>] do_page_cache_readahead+0x43/0x4d
 [<c013ce9b>] filemap_nopage+0x14e/0x328
 [<c0145b8e>] __handle_mm_fault+0x146/0x7b6
 [<c01463cc>] get_user_pages+0x1ce/0x293
 [<c017f0a8>] elf_core_dump+0xa05/0xba5
 [<c015b8a7>] do_coredump+0x565/0x5d1
 [<c0123acb>] get_signal_to_deliver+0x701/0x758
 [<c010246b>] do_notify_resume+0x8b/0x6c4
 [<c0102ede>] work_notifysig+0x13/0x19

The a_ops->readpages() is nfs_readpages(), and it seems to don't free
pages list in error path. So, it hit the
BUG_ON(!list_empty(&page_pool)) in __do_page_cache_readahead.

This clears all pages in error path.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/nfs/read.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff -puN fs/nfs/read.c~nfs_readpages-error-path-fix fs/nfs/read.c
--- linux-2.6/fs/nfs/read.c~nfs_readpages-error-path-fix	2006-10-29 23:52:22.000000000 +0900
+++ linux-2.6-hirofumi/fs/nfs/read.c	2006-10-29 23:54:07.000000000 +0900
@@ -687,7 +687,7 @@ int nfs_readpages(struct file *filp, str
 	};
 	struct inode *inode = mapping->host;
 	struct nfs_server *server = NFS_SERVER(inode);
-	int ret = -ESTALE;
+	int ret;
 
 	dprintk("NFS: nfs_readpages (%s/%Ld %d)\n",
 			inode->i_sb->s_id,
@@ -695,13 +695,17 @@ int nfs_readpages(struct file *filp, str
 			nr_pages);
 	nfs_inc_stats(inode, NFSIOS_VFSREADPAGES);
 
-	if (NFS_STALE(inode))
-		goto out;
+	if (NFS_STALE(inode)) {
+		ret = -ESTALE;
+		goto out_error;
+	}
 
 	if (filp == NULL) {
 		desc.ctx = nfs_find_open_context(inode, NULL, FMODE_READ);
-		if (desc.ctx == NULL)
-			return -EBADF;
+		if (desc.ctx == NULL) {
+			ret = -EBADF;
+			goto out_error;
+		}
 	} else
 		desc.ctx = get_nfs_open_context((struct nfs_open_context *)
 				filp->private_data);
@@ -713,7 +717,11 @@ int nfs_readpages(struct file *filp, str
 			ret = err;
 	}
 	put_nfs_open_context(desc.ctx);
-out:
+
+	return ret;
+
+out_error:
+	put_pages_list(pages);
 	return ret;
 }
 
_
