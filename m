Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbWEZL4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbWEZL4s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 07:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWEZLxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 07:53:32 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:33755 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932474AbWEZLxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:53:15 -0400
Message-ID: <348644392.05317@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060526115318.181350700@localhost.localdomain>
References: <20060526113906.084341801@localhost.localdomain>
Date: Fri, 26 May 2006 19:39:38 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 32/33] readahead: debug traces showing accessed file names
Content-Disposition: inline; filename=readahead-debug-traces-file-list.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Print file names on their first read-ahead, for tracing file access patterns.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/readahead.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+)

--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc4-mm3/mm/readahead.c
@@ -1074,6 +1074,20 @@ static int ra_dispatch(struct file_ra_st
 		ra_account(ra, RA_EVENT_IO_CACHE_HIT, ra_size - actual);
 	ra_account(ra, RA_EVENT_READAHEAD, actual);
 
+	if (!ra->ra_index && filp->f_dentry->d_inode) {
+		char *fn;
+		static char path[1024];
+		unsigned long size;
+
+		size = (i_size_read(filp->f_dentry->d_inode)+1023)/1024;
+		fn = d_path(filp->f_dentry, filp->f_vfsmnt, path, 1000);
+		if (!IS_ERR(fn))
+			ddprintk("ino %lu is %s size %luK by %s(%d)\n",
+					filp->f_dentry->d_inode->i_ino,
+					fn, size,
+					current->comm, current->pid);
+	}
+
 	dprintk("readahead-%s(ino=%lu, index=%lu, ra=%lu+%lu-%lu) = %d\n",
 			ra_class_name[ra_class],
 			mapping->host->i_ino, ra->la_index,

--
