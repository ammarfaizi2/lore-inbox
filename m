Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281450AbRKLNB3>; Mon, 12 Nov 2001 08:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281452AbRKLNBU>; Mon, 12 Nov 2001 08:01:20 -0500
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:25830 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S281450AbRKLNBF>; Mon, 12 Nov 2001 08:01:05 -0500
Date: Mon, 12 Nov 2001 13:01:01 +0000
From: Patrick Caulfield <caulfield@sistina.com>
To: linux-kernel@vger.kernel.org, linux-lvm@sistina.com
Cc: torvalds@transmeta.com
Subject: [PATCH] lvm in 2.4.15.pre3
Message-ID: <20011112130101.A11020@tykepenguin.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-lvm@sistina.com,
	torvalds@transmeta.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply the following patch to LVM in 2.4.13pre3.

It looks like the LVM patch that came from Alan calls alloc/free_kiovec_sz()
functions which only exist in his tree.

patrick

--- drivers/md/lvm-snap.c.orig	Mon Nov 12 12:53:01 2001
+++ drivers/md/lvm-snap.c	Mon Nov 12 12:53:47 2001
@@ -500,10 +500,9 @@
 int lvm_snapshot_alloc(lv_t * lv_snap)
 {
 	int ret, max_sectors;
-	int nbhs = KIO_MAX_SECTORS;
 
 	/* allocate kiovec to do chunk io */
-	ret = alloc_kiovec_sz(1, &lv_snap->lv_iobuf, &nbhs);
+	ret = alloc_kiovec(1, &lv_snap->lv_iobuf);
 	if (ret) goto out;
 
 	max_sectors = KIO_MAX_SECTORS << (PAGE_SHIFT-9);
@@ -512,7 +511,7 @@
 	if (ret) goto out_free_kiovec;
 
 	/* allocate kiovec to do exception table io */
-	ret = alloc_kiovec_sz(1, &lv_snap->lv_COW_table_iobuf, &nbhs);
+	ret = alloc_kiovec(1, &lv_snap->lv_COW_table_iobuf);
 	if (ret) goto out_free_kiovec;
 
 	ret = lvm_snapshot_alloc_iobuf_pages(lv_snap->lv_COW_table_iobuf,
@@ -528,12 +527,12 @@
 
 out_free_both_kiovecs:
 	unmap_kiobuf(lv_snap->lv_COW_table_iobuf);
-	free_kiovec_sz(1, &lv_snap->lv_COW_table_iobuf, &nbhs);
+	free_kiovec(1, &lv_snap->lv_COW_table_iobuf);
 	lv_snap->lv_COW_table_iobuf = NULL;
 
 out_free_kiovec:
 	unmap_kiobuf(lv_snap->lv_iobuf);
-	free_kiovec_sz(1, &lv_snap->lv_iobuf, &nbhs);
+	free_kiovec(1, &lv_snap->lv_iobuf);
 	lv_snap->lv_iobuf = NULL;
 	if (lv_snap->lv_snapshot_hash_table != NULL)
 		vfree(lv_snap->lv_snapshot_hash_table);
@@ -543,8 +542,6 @@
 
 void lvm_snapshot_release(lv_t * lv)
 {
-	int 	nbhs = KIO_MAX_SECTORS;
-
 	if (lv->lv_block_exception)
 	{
 		vfree(lv->lv_block_exception);
@@ -560,14 +557,14 @@
 	{
 	        kiobuf_wait_for_io(lv->lv_iobuf);
 		unmap_kiobuf(lv->lv_iobuf);
-		free_kiovec_sz(1, &lv->lv_iobuf, &nbhs);
+		free_kiovec(1, &lv->lv_iobuf);
 		lv->lv_iobuf = NULL;
 	}
 	if (lv->lv_COW_table_iobuf)
 	{
                kiobuf_wait_for_io(lv->lv_COW_table_iobuf);
                unmap_kiobuf(lv->lv_COW_table_iobuf);
-               free_kiovec_sz(1, &lv->lv_COW_table_iobuf, &nbhs);
+               free_kiovec(1, &lv->lv_COW_table_iobuf);
                lv->lv_COW_table_iobuf = NULL;
 	}
 }
