Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966604AbWKOH44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966604AbWKOH44 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966591AbWKOH4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:56:01 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:6607 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1755479AbWKOHud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:50:33 -0500
Message-ID: <363577029.13886@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20061115075032.515501374@localhost.localdomain>
References: <20061115075007.832957580@localhost.localdomain>
Date: Wed, 15 Nov 2006 15:50:32 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 25/28] readahead: nfsd case
Content-Disposition: inline; filename=readahead-nfsd-case.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bypass nfsd raparms cache -- the new logic do not rely on it.

Also try to work in peace with the chaotic nfsd requests.

For nfsd reads, the new read-ahead logic can handle
+ disordered nfsd requests
+ concurrent sequential requests on large files

Notes about the chaotic nfsd requests issue:

nfsd read requests can be out of order, concurrent and with no ra-state info.
They are handled by the context based read-ahead method, which does the job
in the following steps:

1. scan in page cache
2. make read-ahead decisions
3. alloc new pages
4. insert new pages to page cache

A single read-ahead chunk in the client side will be dissembled and serviced
by many concurrent nfsd in the server side. It is highly possible for two or
more of these parallel nfsd instances to be in step 1/2/3 at the same time.
Without knowing others working on the same file region, they will issue
overlapped read-ahead requests, which lead to many conflicts at step 4.

To work with the tricky situation, readahead decision of nfsd requests is
delayed a bit.

Benchmark results with local mounted nfs(tcp,rsize=32768):

SMALL FILES
readahead_ratio = 8, ra_max = 1024kb
92.99s real  10.32s system  3.23s user  145004+1826 cs  diff -r $NFSDIR $NFSDIR2
readahead_ratio = 70, ra_max = 1024kb
90.96s real  10.68s system  3.22s user  144414+2520 cs  diff -r $NFSDIR $NFSDIR2

BIG FILES
readahead_ratio = 8, ra_max = 1024kb (old logic)
48.36s real  2.22s system  1.51s user  7209+4110 cs  diff $NFSFILE $NFSFILE2
readahead_ratio = 70, ra_max = 1024kb (new logic)
30.04s real  2.46s system  1.33s user  5420+2492 cs  diff $NFSFILE $NFSFILE2

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
Signed-off-by: Andrew Morton <akpm@osdl.org>
--- linux-2.6.19-rc5-mm2.orig/fs/nfsd/vfs.c
+++ linux-2.6.19-rc5-mm2/fs/nfsd/vfs.c
@@ -853,7 +853,11 @@ nfsd_vfs_read(struct svc_rqst *rqstp, st
 #endif
 
 	/* Get readahead parameters */
-	ra = nfsd_get_raparms(inode->i_sb->s_dev, inode->i_ino);
+	if (prefer_adaptive_readahead()) {
+		ra = NULL;
+		file->f_ra.flags |= RA_FLAG_NFSD;
+	} else
+		ra = nfsd_get_raparms(inode->i_sb->s_dev, inode->i_ino);
 
 	if (ra && ra->p_set)
 		file->f_ra = ra->p_ra;
--- linux-2.6.19-rc5-mm2.orig/include/linux/fs.h
+++ linux-2.6.19-rc5-mm2/include/linux/fs.h
@@ -742,6 +742,7 @@ struct file_ra_state {
 #define RA_FLAG_INCACHE	(1UL<<30) /* file is already in cache */
 #define RA_FLAG_MMAP	(1UL<<29) /* mmap page access */
 #define RA_FLAG_LOOP	(1UL<<28) /* loopback file */
+#define RA_FLAG_NFSD	(1UL<<27) /* nfsd read */
 
 struct file {
 	/*
--- linux-2.6.19-rc5-mm2.orig/mm/readahead.c
+++ linux-2.6.19-rc5-mm2/mm/readahead.c
@@ -1298,7 +1298,6 @@ static unsigned long count_history_pages
 	pgoff_t head;
 	unsigned long count;
 	unsigned long lookback;
-	unsigned long hit_rate;
 
 	/*
 	 * Scan backward and check the near @ra_max pages.
@@ -1312,11 +1311,13 @@ static unsigned long count_history_pages
 	count = offset - head;
 
 	/*
-	 * Ensure readahead hit rate
+	 * Ensure readahead hit rate, when it's not a chaotic nfsd read.
 	 */
-	hit_rate = max(readahead_hit_rate, 1);
-	if (count_cache_hit(mapping, head, offset) * hit_rate < count)
-		count = 0;
+	if (!(ra->flags & RA_FLAG_NFSD)) {
+		unsigned long hit_rate = max(readahead_hit_rate, 1);
+		if (count_cache_hit(mapping, head, offset) * hit_rate < count)
+			count = 0;
+	}
 
 	/*
 	 * Unnecessary to count more?
@@ -1669,6 +1670,9 @@ page_cache_readahead_adaptive(struct add
 						offset + LAPTOP_POLL_INTERVAL))
 				return 0;
 		}
+	} else if (ra->flags & RA_FLAG_NFSD) { /* nfsd read */
+		ra_size = max_sane_readahead(req_size);
+		goto readit;
 	}
 
 	if (page)
@@ -1740,6 +1744,21 @@ readit:
 	dprintk("random_read(ino=%lu, req=%lu+%lu) = %lu\n",
 		mapping->host->i_ino, offset, req_size, ra_size);
 
+	/*
+	 * nfsd read-ahead, starting stage.
+	 */
+	if (ra->flags & RA_FLAG_NFSD) {
+		pgoff_t ra_index = offset + ra_size;
+		if (probe_page(mapping, offset - 1) &&
+		   !probe_page(mapping, ra_index)) {
+			ra->prev_page = ra_index - 1;
+			ret = try_context_based_readahead(mapping, ra, NULL,
+						 ra_index, ra_min, ra_max);
+			if (ret > 0)
+				ra_size += ra_submit(ra, mapping, filp);
+		}
+	}
+
 	return ra_size;
 }
 EXPORT_SYMBOL_GPL(page_cache_readahead_adaptive);
--- linux-2.6.19-rc5-mm2.orig/fs/nfs/client.c
+++ linux-2.6.19-rc5-mm2/fs/nfs/client.c
@@ -661,6 +661,9 @@ static void nfs_server_set_fsinfo(struct
 		server->rsize = NFS_MAX_FILE_IO_SIZE;
 	server->rpages = (server->rsize + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 	server->backing_dev_info.ra_pages = server->rpages * NFS_MAX_READAHEAD;
+	server->backing_dev_info.ra_pages0 = min(server->rpages, VM_MIN_READAHEAD
+							>> (PAGE_CACHE_SHIFT - 10));
+	server->backing_dev_info.ra_thrash_bytes = server->rsize * NFS_MAX_READAHEAD;
 
 	if (server->wsize > max_rpc_payload)
 		server->wsize = max_rpc_payload;

--
