Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263330AbUJ2OME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbUJ2OME (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 10:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263333AbUJ2OME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 10:12:04 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:57803 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263330AbUJ2OLw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:11:52 -0400
Subject: Re: [2.6 patch] jfs_metapage.c: remove an unused function
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: JFS Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041029001839.GK29142@stusta.de>
References: <20041028222444.GQ3207@stusta.de>
	 <20041029001839.GK29142@stusta.de>
Content-Type: text/plain
Message-Id: <1099059105.7480.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 29 Oct 2004 09:11:45 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-28 at 19:18, Adrian Bunk wrote:
> The patch below removes an unused function from fs/jfs/jfs_metapage.c
>
> --- patch removed ---

I guess I had intended to call alloc_metapage when I wrote that code,
but I never did.  This must have been my intent:

diff -urp linux.orig/fs/jfs/jfs_metapage.c linux/fs/jfs/jfs_metapage.c
--- linux.orig/fs/jfs/jfs_metapage.c	2004-10-29 08:55:16.670499440 -0500
+++ linux/fs/jfs/jfs_metapage.c	2004-10-29 08:56:35.603499800 -0500
@@ -289,7 +289,7 @@ again:
 		 */
 		mp = NULL;
 		if (JFS_IP(inode)->fileset == AGGREGATE_I) {
-			mp =  mempool_alloc(metapage_mempool, GFP_ATOMIC);
+			mp = alloc_metapage(1);
 			if (!mp) {
 				/*
 				 * mempool is supposed to protect us from
@@ -306,7 +306,7 @@ again:
 			struct metapage *mp2;
 
 			spin_unlock(&meta_lock);
-			mp =  mempool_alloc(metapage_mempool, GFP_NOFS);
+			mp = alloc_metapage(0);
 			spin_lock(&meta_lock);
 
 			/* we dropped the meta_lock, we need to search the

It seems cleaner to call alloc_metapage, since we have a corresponding
free_metapage, but this version is less cryptic:

diff -urp linux.orig/fs/jfs/jfs_metapage.c linux/fs/jfs/jfs_metapage.c
--- linux.orig/fs/jfs/jfs_metapage.c	2004-10-29 08:55:16.670499440 -0500
+++ linux/fs/jfs/jfs_metapage.c	2004-10-29 09:01:24.560571648 -0500
@@ -108,9 +108,9 @@ static void init_once(void *foo, kmem_ca
 	}
 }
 
-static inline struct metapage *alloc_metapage(int no_wait)
+static inline struct metapage *alloc_metapage(int gfp_mask)
 {
-	return mempool_alloc(metapage_mempool, no_wait ? GFP_ATOMIC : GFP_NOFS);
+	return mempool_alloc(metapage_mempool, gfp_mask);
 }
 
 static inline void free_metapage(struct metapage *mp)
@@ -289,7 +289,7 @@ again:
 		 */
 		mp = NULL;
 		if (JFS_IP(inode)->fileset == AGGREGATE_I) {
-			mp =  mempool_alloc(metapage_mempool, GFP_ATOMIC);
+			mp = alloc_metapage(GFP_ATOMIC);
 			if (!mp) {
 				/*
 				 * mempool is supposed to protect us from
@@ -306,7 +306,7 @@ again:
 			struct metapage *mp2;
 
 			spin_unlock(&meta_lock);
-			mp =  mempool_alloc(metapage_mempool, GFP_NOFS);
+			mp = alloc_metapage(GFP_NOFS);
 			spin_lock(&meta_lock);
 
 			/* we dropped the meta_lock, we need to search the
-- 
Dave Kleikamp
IBM Linux Technology Center
shaggy@austin.ibm.com

