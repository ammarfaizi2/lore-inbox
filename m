Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWFLVIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWFLVIf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 17:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWFLVIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 17:08:35 -0400
Received: from gold.veritas.com ([143.127.12.110]:58388 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932237AbWFLVIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 17:08:34 -0400
X-IronPort-AV: i="4.05,229,1146466800"; 
   d="scan'208"; a="60529041:sNHT29364308"
Date: Mon, 12 Jun 2006 21:53:23 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Sergey Vlasov <vsu@altlinux.ru>, Al Viro <viro@zeniv.linux.org.uk>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] tmpfs: Decrement i_nlink correctly in shmem_rmdir()
In-Reply-To: <Pine.LNX.4.64.0606121957580.18760@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0606122150400.23556@blonde.wat.veritas.com>
References: <11501251772137-git-send-email-vsu@altlinux.ru>
 <Pine.LNX.4.64.0606121957580.18760@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 12 Jun 2006 21:08:33.0816 (UTC) FILETIME=[5D336180:01C68E64]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergey Vlasov <vsu@altlinux.ru>

shmem_rmdir() must undo the increment of i_nlink done in
shmem_get_inode() for directories, otherwise at least
IN_DELETE_SELF inotify event generation is broken.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
This can also be included in 2.6.17, though only inotify depends on it.

 mm/shmem.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

--- 2.6.17-rc6-git/mm/shmem.c
+++ linux/mm/shmem.c
@@ -1780,6 +1780,7 @@ static int shmem_rmdir(struct inode *dir
 	if (!simple_empty(dentry))
 		return -ENOTEMPTY;
 
+	dentry->d_inode->i_nlink--;
 	dir->i_nlink--;
 	return shmem_unlink(dir, dentry);
 }
