Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264584AbUEDTAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264584AbUEDTAn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 15:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264586AbUEDTAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 15:00:42 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:27376 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264584AbUEDTAR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 15:00:17 -0400
Subject: [PATCH] [CHECKER] Double txEnd calls causing the kernel to panic
	(JFS 2.4, kernel 2.4.19)
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Junfeng Yang <yjf@stanford.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       JFS Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       mc@cs.Stanford.EDU, Madanlal S Musuvathi <madan@stanford.edu>,
       "David L. Dill" <dill@cs.Stanford.EDU>
In-Reply-To: <Pine.GSO.4.44.0404301531390.14340-100000@elaine24.Stanford.EDU>
References: <Pine.GSO.4.44.0404301531390.14340-100000@elaine24.Stanford.EDU>
Content-Type: text/plain
Message-Id: <1083697198.2206.152.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 04 May 2004 13:59:58 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-30 at 17:33, Junfeng Yang wrote:
> The common pattern in JFS is to call txCommit then call txEnd to end a
> transction.  But if diWrite in txCommit fails (it fails when
> read_cache_page fails to get a page), txAbortCommit will be called.
> txAbortCommit will subsequently call txEnd and set tblk->next to
> txAnchor.freetid.  Later on, when the second txEnd gets called on the same
> tid, the assertion assert(tblk->next) in txEnd will always fail.

The obvious fix here is that txAbortCommit should not call txEnd().  By
fixing this and the bug reported in your other note, "Kernel panic when
diWrite fails to get a page", txAbortCommit becomes functionally
equivalent to txAbort(), which has neither problem.  The fix then, is to
kill txAbortCommit, and have txCommit call txAbort instead.

Here is the patch, which will be pushed to Marcelo & Linus soon.

===== fs/jfs/jfs_txnmgr.c 1.33 vs edited =====
--- 1.33/fs/jfs/jfs_txnmgr.c	Mon Apr 12 10:54:51 2004
+++ edited/fs/jfs/jfs_txnmgr.c	Tue May  4 13:34:39 2004
@@ -1,5 +1,5 @@
 /*
- *   Copyright (C) International Business Machines Corp., 2000-2003
+ *   Copyright (C) International Business Machines Corp., 2000-2004
  *   Portions Copyright (C) Christoph Hellwig, 2001-2002
  *
  *   This program is free software;  you can redistribute it and/or modify
@@ -175,7 +175,6 @@
 		struct tlock * tlck);
 static void mapLog(struct jfs_log * log, struct tblock * tblk, struct lrd * lrd,
 		struct tlock * tlck);
-static void txAbortCommit(struct commit * cd);
 static void txAllocPMap(struct inode *ip, struct maplock * maplock,
 		struct tblock * tblk);
 static void txForce(struct tblock * tblk);
@@ -1295,7 +1294,7 @@
 
       out:
 	if (rc != 0)
-		txAbortCommit(&cd);
+		txAbort(tid, 1);
 
       TheEnd:
 	jfs_info("txCommit: tid = %d, returning %d", tid, rc);
@@ -2632,64 +2631,6 @@
 
 	return;
 }
-
-
-/*
- *      txAbortCommit()
- *
- * function: abort commit.
- *
- * frees tlocks of transaction; line-locks and segment locks for all
- * segments in comdata structure. frees malloc storage
- * sets state of file-system to FM_MDIRTY in super-block.
- * log age of page-frames in memory for which caller has
- * are reset to 0 (to avoid logwarap).
- */
-static void txAbortCommit(struct commit * cd)
-{
-	struct tblock *tblk;
-	tid_t tid;
-	lid_t lid, next;
-	struct metapage *mp;
-
-	jfs_warn("txAbortCommit: cd:0x%p", cd);
-
-	/*
-	 * free tlocks of the transaction
-	 */
-	tid = cd->tid;
-	tblk = tid_to_tblock(tid);
-	for (lid = tblk->next; lid; lid = next) {
-		next = lid_to_tlock(lid)->next;
-
-		mp = lid_to_tlock(lid)->mp;
-		if (mp) {
-			mp->lid = 0;
-
-			/*
-			 * reset lsn of page to avoid logwarap;
-			 */
-			if (mp->xflag & COMMIT_PAGE)
-				LogSyncRelease(mp);
-		}
-
-		/* insert tlock at head of freelist */
-		TXN_LOCK();
-		txLockFree(lid);
-		TXN_UNLOCK();
-	}
-
-	tblk->next = tblk->last = 0;
-
-	/* free the transaction block */
-	txEnd(tid);
-
-	/*
-	 * mark filesystem dirty
-	 */
-	jfs_error(cd->sb, "txAbortCommit");
-}
-
 
 /*
  *      txLazyCommit(void)

-- 
David Kleikamp
IBM Linux Technology Center

