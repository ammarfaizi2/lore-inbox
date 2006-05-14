Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWENIPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWENIPF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 04:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWENIPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 04:15:04 -0400
Received: from mx2.mail.ru ([194.67.23.122]:1326 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1751366AbWENIPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 04:15:03 -0400
Date: Sun, 14 May 2006 12:18:08 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] ufs: ufs_trunc_indirect: infinite cycle
Message-ID: <20060514081807.GA9802@rain.homenetwork>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, ufs write support have two sets of problems:
work with files and work with directories.

This series of patches should solve the first problem.

This patch similar to 
http://lkml.org/lkml/2006/1/17/61 
this patch complements it.

The situation the same: in ufs_trunc_(not direct),
we read block,
check if count of links to it is equal to one, 
if so we finish cycle, if not continue.
Because of "count of links" always >=2 this operation cause 
infinite cycle and hang up the kernel.

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---

diff -upr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4-vanilla/fs/ufs/truncate.c linux-2.6.17-rc4/fs/ufs/truncate.c
--- linux-2.6.17-rc4-vanilla/fs/ufs/truncate.c	2006-05-13 23:50:53.000000000 +0400
+++ linux-2.6.17-rc4/fs/ufs/truncate.c	2006-05-14 00:21:03.696891750 +0400
@@ -237,19 +237,14 @@ static int ufs_trunc_indirect (struct in
 	for (i = 0; i < uspi->s_apb; i++)
 		if (*ubh_get_addr32(ind_ubh,i))
 			break;
-	if (i >= uspi->s_apb) {
-		if (ubh_max_bcount(ind_ubh) != 1) {
-			retry = 1;
-		}
-		else {
-			tmp = fs32_to_cpu(sb, *p);
-			*p = 0;
-			inode->i_blocks -= uspi->s_nspb;
-			mark_inode_dirty(inode);
-			ufs_free_blocks (inode, tmp, uspi->s_fpb);
-			ubh_bforget(ind_ubh);
-			ind_ubh = NULL;
-		}
+	if (i >= uspi->s_apb) {		
+		tmp = fs32_to_cpu(sb, *p);
+		*p = 0;
+		inode->i_blocks -= uspi->s_nspb;
+		mark_inode_dirty(inode);
+		ufs_free_blocks (inode, tmp, uspi->s_fpb);
+		ubh_bforget(ind_ubh);
+		ind_ubh = NULL;
 	}
 	if (IS_SYNC(inode) && ind_ubh && ubh_buffer_dirty(ind_ubh)) {
 		ubh_ll_rw_block (SWRITE, 1, &ind_ubh);
@@ -305,18 +300,14 @@ static int ufs_trunc_dindirect (struct i
 	for (i = 0; i < uspi->s_apb; i++)
 		if (*ubh_get_addr32 (dind_bh, i))
 			break;
-	if (i >= uspi->s_apb) {
-		if (ubh_max_bcount(dind_bh) != 1)
-			retry = 1;
-		else {
-			tmp = fs32_to_cpu(sb, *p);
-			*p = 0;
-			inode->i_blocks -= uspi->s_nspb;
-			mark_inode_dirty(inode);
-			ufs_free_blocks (inode, tmp, uspi->s_fpb);
-			ubh_bforget(dind_bh);
-			dind_bh = NULL;
-		}
+	if (i >= uspi->s_apb) {		
+		tmp = fs32_to_cpu(sb, *p);
+		*p = 0;
+		inode->i_blocks -= uspi->s_nspb;
+		mark_inode_dirty(inode);
+		ufs_free_blocks (inode, tmp, uspi->s_fpb);
+		ubh_bforget(dind_bh);
+		dind_bh = NULL;
 	}
 	if (IS_SYNC(inode) && dind_bh && ubh_buffer_dirty(dind_bh)) {
 		ubh_ll_rw_block (SWRITE, 1, &dind_bh);
@@ -369,18 +360,14 @@ static int ufs_trunc_tindirect (struct i
 	for (i = 0; i < uspi->s_apb; i++)
 		if (*ubh_get_addr32 (tind_bh, i))
 			break;
-	if (i >= uspi->s_apb) {
-		if (ubh_max_bcount(tind_bh) != 1)
-			retry = 1;
-		else {
-			tmp = fs32_to_cpu(sb, *p);
-			*p = 0;
-			inode->i_blocks -= uspi->s_nspb;
-			mark_inode_dirty(inode);
-			ufs_free_blocks (inode, tmp, uspi->s_fpb);
-			ubh_bforget(tind_bh);
-			tind_bh = NULL;
-		}
+	if (i >= uspi->s_apb) {		
+		tmp = fs32_to_cpu(sb, *p);
+		*p = 0;
+		inode->i_blocks -= uspi->s_nspb;
+		mark_inode_dirty(inode);
+		ufs_free_blocks (inode, tmp, uspi->s_fpb);
+		ubh_bforget(tind_bh);
+		tind_bh = NULL;
 	}
 	if (IS_SYNC(inode) && tind_bh && ubh_buffer_dirty(tind_bh)) {
 		ubh_ll_rw_block (SWRITE, 1, &tind_bh);
diff -upr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4-vanilla/fs/ufs/util.c linux-2.6.17-rc4/fs/ufs/util.c
--- linux-2.6.17-rc4-vanilla/fs/ufs/util.c	2006-05-13 23:50:53.000000000 +0400
+++ linux-2.6.17-rc4/fs/ufs/util.c	2006-05-14 00:19:07.757646000 +0400
@@ -139,18 +139,6 @@ void ubh_wait_on_buffer (struct ufs_buff
 		wait_on_buffer (ubh->bh[i]);
 }
 
-unsigned ubh_max_bcount (struct ufs_buffer_head * ubh)
-{
-	unsigned i;
-	unsigned max = 0;
-	if (!ubh)
-		return 0;
-	for ( i = 0; i < ubh->count; i++ ) 
-		if ( atomic_read(&ubh->bh[i]->b_count) > max )
-			max = atomic_read(&ubh->bh[i]->b_count);
-	return max;
-}
-
 void ubh_bforget (struct ufs_buffer_head * ubh)
 {
 	unsigned i;
diff -upr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4-vanilla/fs/ufs/util.h linux-2.6.17-rc4/fs/ufs/util.h
--- linux-2.6.17-rc4-vanilla/fs/ufs/util.h	2006-05-13 23:50:53.000000000 +0400
+++ linux-2.6.17-rc4/fs/ufs/util.h	2006-05-14 00:19:14.186047750 +0400
@@ -238,7 +238,6 @@ extern void ubh_mark_buffer_dirty (struc
 extern void ubh_mark_buffer_uptodate (struct ufs_buffer_head *, int);
 extern void ubh_ll_rw_block (int, unsigned, struct ufs_buffer_head **);
 extern void ubh_wait_on_buffer (struct ufs_buffer_head *);
-extern unsigned ubh_max_bcount (struct ufs_buffer_head *);
 extern void ubh_bforget (struct ufs_buffer_head *);
 extern int  ubh_buffer_dirty (struct ufs_buffer_head *);
 #define ubh_ubhcpymem(mem,ubh,size) _ubh_ubhcpymem_(uspi,mem,ubh,size)

-- 
/Evgeniy

