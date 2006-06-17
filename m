Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWFQKKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWFQKKl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 06:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWFQKKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 06:10:41 -0400
Received: from mx2.mail.ru ([194.67.23.122]:45413 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1751358AbWFQKKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 06:10:40 -0400
Date: Sat, 17 Jun 2006 14:16:01 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/5]: ufs: fsync implementation
Message-ID: <20060617101601.GA31408@rain.homenetwork>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At now, ufs doesn't support "fsync",
this make some applications unhappy, for example vim.
This patch fixes this situation.

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

Index: linux-2.6.17-rc6-mm2/fs/ufs/file.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/fs/ufs/file.c
+++ linux-2.6.17-rc6-mm2/fs/ufs/file.c
@@ -25,6 +25,26 @@
 
 #include <linux/fs.h>
 #include <linux/ufs_fs.h>
+#include <linux/buffer_head.h>	/* for sync_mapping_buffers() */
+
+static int ufs_sync_file(struct file *file, struct dentry *dentry, int datasync)
+{
+	struct inode *inode = dentry->d_inode;
+	int err;
+	int ret;
+
+	ret = sync_mapping_buffers(inode->i_mapping);
+	if (!(inode->i_state & I_DIRTY))
+		return ret;
+	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
+		return ret;
+
+	err = ufs_sync_inode(inode);
+	if (ret == 0)
+		ret = err;
+	return ret;
+}
+
 
 /*
  * We have mostly NULL's here: the current defaults are ok for
@@ -37,6 +57,7 @@ const struct file_operations ufs_file_op
 	.write		= generic_file_write,
 	.mmap		= generic_file_mmap,
 	.open           = generic_file_open,
+	.fsync		= ufs_sync_file,
 	.sendfile	= generic_file_sendfile,
 };
 

-- 
/Evgeniy

