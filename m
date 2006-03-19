Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWCSCfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWCSCfB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 21:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWCSCe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 21:34:59 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:61890 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751314AbWCSCeq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 21:34:46 -0500
Message-Id: <20060319023459.605496000@localhost.localdomain>
References: <20060319023413.305977000@localhost.localdomain>
Date: Sun, 19 Mar 2006 10:34:35 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 22/23] readahead: debug traces showing accessed file names
Content-Disposition: inline; filename=readahead-debug-traces-file-list.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Print file names on their first read-ahead, for tracing file access patterns.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 mm/readahead.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+)

--- linux-2.6.16-rc6-mm2.orig/mm/readahead.c
+++ linux-2.6.16-rc6-mm2/mm/readahead.c
@@ -1229,6 +1229,20 @@ static int ra_dispatch(struct file_ra_st
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
