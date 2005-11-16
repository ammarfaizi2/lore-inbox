Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030240AbVKPI6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbVKPI6c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 03:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbVKPI6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 03:58:32 -0500
Received: from rwcrmhc12.comcast.net ([204.127.198.43]:48828 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030240AbVKPI63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 03:58:29 -0500
Message-ID: <437AF4B3.8010708@namesys.com>
Date: Wed, 16 Nov 2005 00:58:27 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, vs <vs@thebsh.namesys.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [Fwd: [PATCH 8/8] reiser4-fix-zeroing-in-crc-files.patch]
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------000207020603090105020701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000207020603090105020701
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



--------------000207020603090105020701
Content-Type: message/rfc822;
 name="[PATCH 8/8] reiser4-fix-zeroing-in-crc-files.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="[PATCH 8/8] reiser4-fix-zeroing-in-crc-files.patch"

Return-Path: <vs@tribesman.namesys.com>
Delivered-To: reiser@namesys.com
Received: (qmail 24486 invoked from network); 15 Nov 2005 17:00:16 -0000
Received: from ppp83-237-207-83.pppoe.mtu-net.ru (HELO tribesman.namesys.com) (83.237.207.83)
  by thebsh.namesys.com with SMTP; 15 Nov 2005 17:00:16 -0000
Received: by tribesman.namesys.com (Postfix on SuSE Linux 8.0 (i386), from userid 512)
	id C1B0A71D998; Tue, 15 Nov 2005 19:59:46 +0300 (MSK)
Date: Tue, 15 Nov 2005 19:59:46 +0300
To: reiser@namesys.com
Subject: [PATCH 8/8] reiser4-fix-zeroing-in-crc-files.patch
Message-ID: <437A1402.mail7JX113Q5C@tribesman.namesys.com>
User-Agent: nail 10.5 4/27/03
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="1AQLN1GHM5-=-1X2IJUJWDJ-CUT-HERE-1HPPU1TQQ7-=-F97RKJW4O6"
From: vs@tribesman.namesys.com (Vladimir Saveliev)

This is a multi-part message in MIME format.

--1AQLN1GHM5-=-1X2IJUJWDJ-CUT-HERE-1HPPU1TQQ7-=-F97RKJW4O6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

.

--1AQLN1GHM5-=-1X2IJUJWDJ-CUT-HERE-1HPPU1TQQ7-=-F97RKJW4O6
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reiser4-fix-zeroing-in-crc-files.patch"


From: Edward Shishkin <edward@namesys.com>

This patch fixes page zeroing in cryptcompress files.

Signed-off-by: Vladimir V. Saveliev <vs@namesys.com>


 fs/reiser4/plugin/file/cryptcompress.c |   84 +++++++++++++--------------------
 fs/reiser4/plugin/item/ctail.c         |    1 
 2 files changed, 34 insertions(+), 51 deletions(-)

diff -puN fs/reiser4/plugin/file/cryptcompress.c~reiser4-fix-zeroing-in-crc-files fs/reiser4/plugin/file/cryptcompress.c
--- linux-2.6.14-mm2/fs/reiser4/plugin/file/cryptcompress.c~reiser4-fix-zeroing-in-crc-files	2005-11-15 17:21:25.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/plugin/file/cryptcompress.c	2005-11-15 17:28:16.000000000 +0300
@@ -133,7 +133,7 @@ alloc_crypto_tfms(plugin_set * pset, cry
  err:
 	if (cplug->free) {
 		cplug->free(info->tfma[CIPHER_TFM].tfm);
-		info_set_tfm(info, CIPHER_TFM, 0);
+		info_set_tfm(info, CIPHER_TFM, NULL);
 	}
 	return RETERR(-EINVAL);
 }
@@ -145,9 +145,9 @@ free_crypto_tfms(crypto_stat_t * info)
 	if (!info_cipher_tfm(info))
 		return;
 	info_cipher_plugin(info)->free(info_cipher_tfm(info));
-	info_set_tfm(info, CIPHER_TFM, 0);
+	info_set_tfm(info, CIPHER_TFM, NULL);
 	info_digest_plugin(info)->free(info_digest_tfm(info));
-	info_set_tfm(info, DIGEST_TFM, 0);
+	info_set_tfm(info, DIGEST_TFM, NULL);
 	return;
 }
 
@@ -298,7 +298,7 @@ create_crypto_stat(struct inode * object
  	return ERR_PTR(ret);
 }
 
-void load_crypto_stat(crypto_stat_t * info)
+static void load_crypto_stat(crypto_stat_t * info)
 {
 	assert("edward-1380", info != NULL);
 	inc_keyload_count(info);
@@ -499,6 +499,8 @@ create_cryptcompress(struct inode *objec
 
 int open_cryptcompress(struct inode * inode, struct file * file)
 {
+	struct inode * parent;
+
 	assert("edward-1394", inode != NULL);
 	assert("edward-1395", file != NULL);
 	assert("edward-1396", file != NULL);
@@ -508,7 +510,7 @@ int open_cryptcompress(struct inode * in
 	assert("edward-698",
 	       inode_file_plugin(inode) ==
 	       file_plugin_by_id(CRC_FILE_PLUGIN_ID));
-	struct inode * parent;
+
 	if (!need_cipher(inode))
 		/* the file is not to be ciphered */
 		return 0;
@@ -1202,7 +1204,7 @@ int readpage_cryptcompress(struct file *
 		reiser4_exit_context(ctx);
 		return 0;
 	}
-	cluster_init_read(&clust, 0);
+	cluster_init_read(&clust, NULL);
 	clust.file = file;
 	iplug = item_plugin_by_id(CTAIL_ID);
 	if (!iplug->s.file.readpage) {
@@ -2181,6 +2183,23 @@ read_some_cluster_pages(struct inode *in
 		assert("edward-734", schedulable());
 		assert("edward-735", clust->hint->lh.owner == NULL);
 
+		if (clust->nr_pages) {
+			int off;
+			char *data;
+			struct page * pg;
+			assert("edward-1419", clust->pages != NULL);
+			pg = clust->pages[clust->nr_pages - 1];
+			assert("edward-1420", pg != NULL);
+			off = off_to_pgoff(win->off+win->count+win->delta);
+			if (off) {
+				lock_page(pg);
+				data = kmap_atomic(pg, KM_USER0);
+				memset(data + off, 0, PAGE_CACHE_SIZE - off); 
+				flush_dcache_page(pg);
+				kunmap_atomic(data, KM_USER0);
+				unlock_page(pg);
+			}
+		}
 		clust->dstat = FAKE_DISK_CLUSTER;
 		return 0;
 	}
@@ -2208,6 +2227,7 @@ read_some_cluster_pages(struct inode *in
 		    i < off_to_pg(win->off + win->count + win->delta))
 			/* page will be completely overwritten */
 			continue;
+
 		if (win && (i == clust->nr_pages - 1) &&
 		    /* the last page is
 		       partially modified,
@@ -2778,18 +2798,17 @@ static ssize_t write_crc_file(struct fil
 	pos = *off;
 	written =
 	    write_cryptcompress_flow(file, inode, buf, count, pos);
+
+	up_write(&info->lock);
+	LOCK_CNT_DEC(inode_sem_w);
+
 	if (written < 0) {
 		if (written == -EEXIST)
 			printk("write_crc_file returns EEXIST!\n");
 		return written;
 	}
-
 	/* update position in a file */
 	*off = pos + written;
-
-	up_write(&info->lock);
-	LOCK_CNT_DEC(inode_sem_w);
-
 	/* return number of written bytes */
 	return written;
 }
@@ -3179,6 +3198,10 @@ cryptcompress_append_hole(struct inode *
 	nr_zeroes =
 	    min_count(inode_cluster_size(inode) -
 		      off_to_cloff(inode->i_size, inode), hole_size);
+	nr_zeroes +=
+		(new_size % PAGE_CACHE_SIZE ?
+		 PAGE_CACHE_SIZE - new_size % PAGE_CACHE_SIZE :
+		 0);
 
 	set_window(&clust, &win, inode, inode->i_size,
 		   inode->i_size + nr_zeroes);
@@ -3622,45 +3645,6 @@ writepages_cryptcompress(struct address_
 	return result;
 }
 
-int capturepage_cryptcompress(struct page * page) {
-	int result = 0;
-	assert("edward-1350", PageLocked(page));
-	assert("edward-1351", page->mapping != NULL);
-	assert("edward-1352", page->mapping->host != NULL);
-	if (PagePrivate(page) && JF_ISSET(jnode_by_page(page), JNODE_DIRTY)) {
-		assert("edward-1353", PageDirty(page));
-		return 0;
-	}
-	else {
-		hint_t hint;
-		lock_handle lh;
-		reiser4_cluster_t clust;
-
-		init_lh(&lh);
-		hint_init_zero(&hint);
-		hint.ext_coord.lh = &lh;
-		cluster_init_read(&clust, 0);
-		clust.hint = &hint;
-
-		page_cache_get(page);
-		unlock_page(page);
-
-		result = set_cluster_by_page(&clust,
-					     page,
-					     cluster_nrpages(page->mapping->host));
-		if (result)
-			goto out;
-		result = capture_page_cluster(&clust, page->mapping->host);
-	out:
-		done_lh(&lh);
-		put_cluster_handle(&clust);
-
-		lock_page(page);
-		page_cache_release(page);
-	}
- 	return result;
-}
-
 /* plugin->u.file.mmap */
 int mmap_cryptcompress(struct file *file, struct vm_area_struct *vma)
 {
diff -puN fs/reiser4/plugin/item/ctail.c~reiser4-fix-zeroing-in-crc-files fs/reiser4/plugin/item/ctail.c
--- linux-2.6.14-mm2/fs/reiser4/plugin/item/ctail.c~reiser4-fix-zeroing-in-crc-files	2005-11-15 17:21:25.000000000 +0300
+++ linux-2.6.14-mm2-vs/fs/reiser4/plugin/item/ctail.c	2005-11-15 17:21:25.000000000 +0300
@@ -619,7 +619,6 @@ int do_readpage_ctail(reiser4_cluster_t 
 		assert("edward-1290", 0);
 		return RETERR(-EINVAL);
 	}
-
 	assert("edward-119", tfm_cluster_is_uptodate(tc));
 
 	switch (clust->dstat) {

_

--1AQLN1GHM5-=-1X2IJUJWDJ-CUT-HERE-1HPPU1TQQ7-=-F97RKJW4O6--



--------------000207020603090105020701--
