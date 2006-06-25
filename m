Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWFYNJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWFYNJg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 09:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWFYNJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 09:09:22 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:15326 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751378AbWFYNJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 09:09:16 -0400
Message-ID: <351240953.32670@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060625130922.816467605@localhost.localdomain>
References: <20060625130704.464870100@localhost.localdomain>
Date: Sun, 25 Jun 2006 21:07:09 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 5/6] readahead: kconfig option READAHEAD_HIT_FEEDBACK
Content-Disposition: inline; filename=readahead-kconfig-rahit-feedback.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a kconfig option READAHEAD_HIT_FEEDBACK to enable users
to disable the readahead hit feedback feature.

The readahead hit accounting brings per-page overheads.  However it is
necessary for the onseek method, and possible strides method in future.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


--- linux-2.6.17-mm2.orig/mm/Kconfig
+++ linux-2.6.17-mm2/mm/Kconfig
@@ -215,6 +215,16 @@ config DEBUG_READAHEAD
 
 	  Say N for production servers.
 
+config READAHEAD_HIT_FEEDBACK
+	bool "Readahead hit feedback"
+	default y
+	depends on READAHEAD_ALLOW_OVERHEADS
+	help
+	  Enable readahead hit feedback.
+
+	  It is not needed in normal cases, except for detecting the
+	  seek-and-read pattern.
+
 config READAHEAD_SMOOTH_AGING
 	bool "Fine grained readahead aging"
 	default n
--- linux-2.6.17-mm2.orig/include/linux/fs.h
+++ linux-2.6.17-mm2/include/linux/fs.h
@@ -648,6 +648,13 @@ struct file_ra_state {
 			pgoff_t readahead_index;
 
 			/*
+			 * Snapshot of the (node's) read-ahead aging value
+			 * on time of I/O submission.
+			 */
+			unsigned long age;
+
+#ifdef CONFIG_READAHEAD_HIT_FEEDBACK
+			/*
 			 * Read-ahead hits.
 			 * 	i.e. # of distinct read-ahead pages accessed.
 			 *
@@ -660,12 +667,7 @@ struct file_ra_state {
 			u16	hit1;	/* for the current sequence */
 			u16	hit2;	/* for the previous sequence */
 			u16	hit3;	/* for the prev-prev sequence */
-
-			/*
-			 * Snapshot of the (node's) read-ahead aging value
-			 * on time of I/O submission.
-			 */
-			unsigned long age;
+#endif
 		};
 #endif
 	};
--- linux-2.6.17-mm2.orig/mm/readahead.c
+++ linux-2.6.17-mm2/mm/readahead.c
@@ -933,8 +933,12 @@ static unsigned long ra_invoke_interval(
  */
 static int ra_cache_hit_ok(struct file_ra_state *ra)
 {
+#ifdef CONFIG_READAHEAD_HIT_FEEDBACK
 	return ra->hit0 * readahead_hit_rate >=
 					(ra->lookahead_index - ra->la_index);
+#else
+	return 1;
+#endif
 }
 
 /*
@@ -968,6 +972,7 @@ static void ra_set_class(struct file_ra_
 
 	ra->flags = flags | old_ra_class | ra_class;
 
+#ifdef CONFIG_READAHEAD_HIT_FEEDBACK
 	/*
 	 * Add request-hit up to sequence-hit and reset the former.
 	 */
@@ -984,6 +989,7 @@ static void ra_set_class(struct file_ra_
 		ra->hit2 = ra->hit1;
 		ra->hit1 = 0;
 	}
+#endif
 }
 
 /*
@@ -1684,6 +1690,7 @@ static int
 try_readahead_on_seek(struct file_ra_state *ra, pgoff_t index,
 			unsigned long ra_size, unsigned long ra_max)
 {
+#ifdef CONFIG_READAHEAD_HIT_FEEDBACK
 	unsigned long hit0 = ra->hit0;
 	unsigned long hit1 = ra->hit1 + hit0;
 	unsigned long hit2 = ra->hit2;
@@ -1712,6 +1719,9 @@ try_readahead_on_seek(struct file_ra_sta
 	ra_set_size(ra, ra_size, 0);
 
 	return 1;
+#else
+	return 0;
+#endif
 }
 
 /*
@@ -1739,7 +1749,7 @@ thrashing_recovery_readahead(struct addr
 		ra_size = ra->ra_index - index;
 	else {
 		/* After thrashing, we know the exact thrashing-threshold. */
-		ra_size = ra->hit0;
+		ra_size = index - ra->ra_index;
 		update_ra_thrash_bytes(mapping->backing_dev_info, ra_size);
 
 		/* And we'd better be a bit conservative. */
@@ -1908,6 +1918,7 @@ readit:
 	return size;
 }
 
+#if defined(CONFIG_READAHEAD_HIT_FEEDBACK) || defined(CONFIG_DEBUG_READAHEAD)
 /**
  * readahead_cache_hit - adaptive read-ahead feedback function
  * @ra: file_ra_state which holds the readahead state
@@ -1927,13 +1938,16 @@ void readahead_cache_hit(struct file_ra_
 	if (!ra_has_index(ra, page->index))
 		return;
 
+#ifdef CONFIG_READAHEAD_HIT_FEEDBACK
 	ra->hit0++;
+#endif
 
 	if (page->index >= ra->ra_index)
 		ra_account(ra, RA_EVENT_READAHEAD_HIT, 1);
 	else
 		ra_account(ra, RA_EVENT_READAHEAD_HIT, -1);
 }
+#endif
 
 /*
  * When closing a normal readonly file,
@@ -1949,7 +1963,6 @@ void readahead_close(struct file *file)
 	struct address_space *mapping = inode->i_mapping;
 	struct backing_dev_info *bdi = mapping->backing_dev_info;
 	unsigned long pos = file->f_pos;	/* supposed to be small */
-	unsigned long pgrahit = file->f_ra.hit0;
 	unsigned long pgcached = mapping->nrpages;
 	unsigned long pgaccess;
 
@@ -1959,7 +1972,12 @@ void readahead_close(struct file *file)
 	if (pgcached > bdi->ra_pages0)		/* excessive reads */
 		return;
 
-	pgaccess = max(pgrahit, 1 + pos / PAGE_CACHE_SIZE);
+	pgaccess = 1 + pos / PAGE_CACHE_SIZE;
+#ifdef CONFIG_READAHEAD_HIT_FEEDBACK
+	if (pgaccess < file->f_ra.hit0)
+		pgaccess = file->f_ra.hit0;
+#endif
+
 	if (pgaccess >= pgcached) {
 		if (bdi->ra_expect_bytes < bdi->ra_pages0 * PAGE_CACHE_SIZE)
 			bdi->ra_expect_bytes += pgcached * PAGE_CACHE_SIZE / 8;
@@ -1980,12 +1998,11 @@ void readahead_close(struct file *file)
 
 		debug_inc(initial_ra_miss);
 		dprintk("initial_ra_miss on file %s "
-				"size %lluK cached %luK hit %luK "
+				"size %lluK cached %luK "
 				"pos %lu by %s(%d)\n",
 				file->f_dentry->d_name.name,
 				i_size_read(inode) / 1024,
 				pgcached << (PAGE_CACHE_SHIFT - 10),
-				pgrahit << (PAGE_CACHE_SHIFT - 10),
 				pos,
 				current->comm, current->pid);
 	}
--- linux-2.6.17-mm2.orig/include/linux/mm.h
+++ linux-2.6.17-mm2/include/linux/mm.h
@@ -998,7 +998,16 @@ page_cache_readahead_adaptive(struct add
 			struct file_ra_state *ra, struct file *filp,
 			struct page *prev_page, struct page *page,
 			pgoff_t first_index, pgoff_t index, pgoff_t last_index);
+
+#if defined(CONFIG_READAHEAD_HIT_FEEDBACK) || defined(CONFIG_DEBUG_READAHEAD)
 void readahead_cache_hit(struct file_ra_state *ra, struct page *page);
+#else
+static inline void readahead_cache_hit(struct file_ra_state *ra,
+					struct page *page)
+{
+}
+#endif
+
 
 #ifdef CONFIG_ADAPTIVE_READAHEAD
 extern int readahead_ratio;

--
