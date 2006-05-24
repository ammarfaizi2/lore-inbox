Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932701AbWEXLUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932701AbWEXLUG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 07:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbWEXLT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 07:19:56 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:45441 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932701AbWEXLTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 07:19:09 -0400
Message-ID: <348469546.16482@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060524111907.134685550@localhost.localdomain>
References: <20060524111246.420010595@localhost.localdomain>
Date: Wed, 24 May 2006 19:13:06 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 20/33] readahead: initial method - expected read size
Content-Disposition: inline; filename=readahead-method-initial-size-expect.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

backing_dev_info.ra_expect_bytes is dynamicly updated to be the expected
read pages on start-of-file. It allows the initial readahead to be more
aggressive and hence efficient.


Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---

 fs/file_table.c    |    7 ++++++
 include/linux/mm.h |    1 
 mm/readahead.c     |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

--- linux-2.6.17-rc4-mm3.orig/include/linux/mm.h
+++ linux-2.6.17-rc4-mm3/include/linux/mm.h
@@ -1032,6 +1032,7 @@ unsigned long page_cache_readahead(struc
 void handle_ra_miss(struct address_space *mapping, 
 		    struct file_ra_state *ra, pgoff_t offset);
 unsigned long max_sane_readahead(unsigned long nr);
+void fastcall readahead_close(struct file *file);
 
 #ifdef CONFIG_ADAPTIVE_READAHEAD
 extern int readahead_ratio;
--- linux-2.6.17-rc4-mm3.orig/fs/file_table.c
+++ linux-2.6.17-rc4-mm3/fs/file_table.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/smp_lock.h>
+#include <linux/mm.h>
 #include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/eventpoll.h>
@@ -160,6 +161,12 @@ void fastcall __fput(struct file *file)
 	might_sleep();
 
 	fsnotify_close(file);
+
+#ifdef CONFIG_ADAPTIVE_READAHEAD
+	if (file->f_ra.flags & RA_FLAG_EOF)
+		readahead_close(file);
+#endif
+
 	/*
 	 * The function eventpoll_release() should be the first called
 	 * in the file cleanup chain.
--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc4-mm3/mm/readahead.c
@@ -1555,6 +1555,61 @@ static inline void get_readahead_bounds(
 					PAGES_KB(128)), *ra_max / 2);
 }
 
+/*
+ * When closing a normal readonly file,
+ * 	- on cache hit:  increase `backing_dev_info.ra_expect_bytes' slowly;
+ * 	- on cache miss: decrease it rapidly.
+ *
+ * The resulted `ra_expect_bytes' answers the question of:
+ * 	How many pages are expected to be read on start-of-file?
+ */
+void fastcall readahead_close(struct file *file)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	struct address_space *mapping = inode->i_mapping;
+	struct backing_dev_info *bdi = mapping->backing_dev_info;
+	unsigned long pos = file->f_pos;
+	unsigned long pgrahit = file->f_ra.cache_hits;
+	unsigned long pgaccess = 1 + pos / PAGE_CACHE_SIZE;
+	unsigned long pgcached = mapping->nrpages;
+
+	if (!pos)				/* pread */
+		return;
+
+	if (pgcached > bdi->ra_pages0)		/* excessive reads */
+		return;
+
+	if (pgaccess >= pgcached) {
+		if (bdi->ra_expect_bytes < bdi->ra_pages0 * PAGE_CACHE_SIZE)
+			bdi->ra_expect_bytes += pgcached * PAGE_CACHE_SIZE / 8;
+
+		debug_inc(initial_ra_hit);
+		dprintk("initial_ra_hit on file %s size %lluK "
+				"pos %lu by %s(%d)\n",
+				file->f_dentry->d_name.name,
+				i_size_read(inode) / 1024,
+				pos,
+				current->comm, current->pid);
+	} else {
+		unsigned long missed;
+
+		missed = (pgcached - pgaccess) * PAGE_CACHE_SIZE;
+		if (bdi->ra_expect_bytes >= missed / 2)
+			bdi->ra_expect_bytes -= missed / 2;
+
+		debug_inc(initial_ra_miss);
+		dprintk("initial_ra_miss on file %s "
+				"size %lluK cached %luK hit %luK "
+				"pos %lu by %s(%d)\n",
+				file->f_dentry->d_name.name,
+				i_size_read(inode) / 1024,
+				pgcached << (PAGE_CACHE_SHIFT - 10),
+				pgrahit << (PAGE_CACHE_SHIFT - 10),
+				pos,
+				current->comm, current->pid);
+	}
+}
+
 #endif /* CONFIG_ADAPTIVE_READAHEAD */
 
 /*

--
