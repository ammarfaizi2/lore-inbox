Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262532AbVFWK2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbVFWK2q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 06:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbVFWKVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 06:21:19 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:6846 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S262571AbVFWKNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 06:13:33 -0400
Subject: [PATCH] reiserfs: do not ignore i/io error on readpage
From: Vladimir Saveliev <vs@namesys.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-4om+Tp6WHfOdfQcCdylH"
Message-Id: <1119521586.4115.78.camel@tribesman.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 23 Jun 2005 14:13:07 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4om+Tp6WHfOdfQcCdylH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello, Andrew

Reiserfs's readpage does not notice i/o errors. This patch makes
reiserfs_readpage to return -EIO when i/o error appears.
Please, apply.

--=-4om+Tp6WHfOdfQcCdylH
Content-Disposition: attachment; filename=reiserfs-get_block-handle-io-error.patch
Content-Type: text/plain; name=reiserfs-get_block-handle-io-error.patch; charset=KOI8-R
Content-Transfer-Encoding: 7bit


From: Qu Fuping <fs@ercist.iscas.ac.cn>

This patch makes reiserfs to not ignore I/O error on readpage.

Signed-off-by: Qu Fuping <fs@ercist.iscas.ac.cn>
Signed-off-by: Vladimir V. Saveliev <vs@namesys.com>
---


 fs/reiserfs/inode.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff -puN fs/reiserfs/inode.c~reiserfs-get_block-handle-io-error fs/reiserfs/inode.c
--- linux-2.6.12-mm1/fs/reiserfs/inode.c~reiserfs-get_block-handle-io-error	2005-06-23 13:37:41.000000000 +0400
+++ linux-2.6.12-mm1-vs/fs/reiserfs/inode.c	2005-06-23 13:47:36.000000000 +0400
@@ -254,6 +254,7 @@ static int _get_block_create_0 (struct i
     char * p = NULL;
     int chars;
     int ret ;
+    int result ;
     int done = 0 ;
     unsigned long offset ;
 
@@ -262,10 +263,13 @@ static int _get_block_create_0 (struct i
 		  (loff_t)block * inode->i_sb->s_blocksize + 1, TYPE_ANY, 3);
 
 research:
-    if (search_for_position_by_key (inode->i_sb, &key, &path) != POSITION_FOUND) {
+    result = search_for_position_by_key (inode->i_sb, &key, &path) ;
+    if (result != POSITION_FOUND) {
 	pathrelse (&path);
         if (p)
             kunmap(bh_result->b_page) ;
+	if (result == IO_ERROR)
+	    return -EIO;
 	// We do not return -ENOENT if there is a hole but page is uptodate, because it means
 	// That there is some MMAPED data associated with it that is yet to be written to disk.
 	if ((args & GET_BLOCK_NO_HOLE) && !PageUptodate(bh_result->b_page) ) {
@@ -382,8 +386,9 @@ research:
 
 	// update key to look for the next piece
 	set_cpu_key_k_offset (&key, cpu_key_k_offset (&key) + chars);
-	if (search_for_position_by_key (inode->i_sb, &key, &path) != POSITION_FOUND)
-	    // we read something from tail, even if now we got IO_ERROR
+	result = search_for_position_by_key (inode->i_sb, &key, &path);
+	if (result != POSITION_FOUND)
+	    // i/o error most likely
 	    break;
 	bh = get_last_bh (&path);
 	ih = get_ih (&path);
@@ -394,6 +399,10 @@ research:
 
 finished:
     pathrelse (&path);
+
+    if (result == IO_ERROR)
+	return -EIO;
+    
     /* this buffer has valid data, but isn't valid for io.  mapping it to
      * block #0 tells the rest of reiserfs it just has a tail in it
      */

_

--=-4om+Tp6WHfOdfQcCdylH--

