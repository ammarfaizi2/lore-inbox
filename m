Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267329AbRGYVFu>; Wed, 25 Jul 2001 17:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267338AbRGYVFl>; Wed, 25 Jul 2001 17:05:41 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:56383 "EHLO
	shaggy.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S267329AbRGYVFb>; Wed, 25 Jul 2001 17:05:31 -0400
From: Dave Kleikamp <shaggy@shaggy.austin.ibm.com>
Message-Id: <200107252104.f6PL4Kn03703@shaggy.austin.ibm.com>
Subject: Re: [Jfs-discussion] Design-Question: end_that_request_* and bh->b_end_io hooks
To: COTTE@de.ibm.com (Carsten Otte)
Date: Wed, 25 Jul 2001 16:04:20 -0500 (CDT)
Cc: jfs-discussion@dwoss.lotus.com, reiserfs-dev@namesys.com, andrea@suse.de,
        sct@dcs.ed.ac.uk, linux-kernel@vger.kernel.org,
        mauelshagen@sistina.com, HSmolinski@de.ibm.com (Holger Smolinski),
        Horst.Hummel@de.ibm.com (Horst Hummel)
In-Reply-To: <OF3CC2BFB9.69086721-ONC1256A93.0059C650@de.ibm.com> from "Carsten Otte" at Jul 24, 2001 07:20:46 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> 
> Hi  Folks,
> 
> as you are deeper into block-devices & filesystems than me,
> here are my two simple questions in short:
> Is it legal for a filesystem (or whatever) to install a hook into
> bh->b_end_io
> which calls generic_make_request?

I believe that JFS is at fault here.  JFS has been using in_interrupt() to
determine whether to initiate I/O or to queue the I/O to a worker thread.
In your case, in_interrupt() will return false, but JFS still should not be
calling generic_make_request.

> Do block drivers need or are they allowed to hold the io_request_lock or
> other (local)
> locks when calling end_that_request_*?

I think you're doing it right.  See if this patch fixes the problem.

(I'm currently at OLS in Ottawa, so I apologize if my response is a little
slow.)

Index: linux/fs/jfs/jfs_logmgr.c
===================================================================
RCS file: /share/Open_Source/CVS_JFS/linux/fs/jfs/jfs_logmgr.c,v
retrieving revision 1.27
diff -u -r1.27 jfs_logmgr.c
--- linux/fs/jfs/jfs_logmgr.c	2001/06/29 14:50:21	1.27
+++ linux/fs/jfs/jfs_logmgr.c	2001/07/25 21:57:57
@@ -242,7 +242,7 @@
 static void lbmFree(lbuf_t * bp);
 static void lbmfree(lbuf_t * bp);
 static int lbmRead(log_t * log, int pn, lbuf_t ** bpp);
-static void lbmWrite(log_t * log, lbuf_t * bp, int flag);
+static void lbmWrite(log_t * log, lbuf_t * bp, int flag, int cant_block);
 static void lbmDirectWrite(log_t * log, lbuf_t * bp, int flag);
 static int lbmIOWait(lbuf_t * bp, int flag);
 static void lbmIODone(struct buffer_head * bh, int);
@@ -251,7 +251,7 @@
 #endif				/* _STILL_TO_PORT */
 void lbmStartIO(lbuf_t * bp);
 #ifdef _JFS_LAZYCOMMIT
-void lmGCwrite(log_t * log);
+void lmGCwrite(log_t * log, int cant_block);
 #endif
 
 
@@ -687,7 +687,7 @@
 		if (bp->l_wqnext == NULL) {
 			/* bp->l_ceor = bp->l_eor; */
 			/* lp->h.eor = lp->t.eor = bp->l_ceor; */
-			lbmWrite(log, bp, 0);
+			lbmWrite(log, bp, 0, 0);
 		}
 	}
 	/* page is not bound with outstanding tblk:
@@ -697,7 +697,7 @@
 		/* finalize the page */
 		bp->l_ceor = bp->l_eor;
 		lp->h.eor = lp->t.eor = cpu_to_le16(bp->l_ceor);
-		lbmWrite(log, bp, lbmWRITE | lbmRELEASE | lbmFREE);
+		lbmWrite(log, bp, lbmWRITE | lbmRELEASE | lbmFREE, 0);
 	}
 	LOGGC_UNLOCK(log);
 
@@ -771,7 +771,7 @@
 		 */
 		log->cflag |= logGC_PAGEOUT;
 
-		lmGCwrite(log);
+		lmGCwrite(log, 0);
 	}
 	/* lmGCwrite gives up LOGGC_LOCK, check again */
 
@@ -831,7 +831,7 @@
  *	LOGGC_LOCK must be held by caller.
  *	N.B. LOG_LOCK is NOT held during lmGroupCommit().
  */
-void lmGCwrite(log_t * log)
+void lmGCwrite(log_t * log, int cant_write)
 {
 	lbuf_t *bp;
 	logpage_t *lp;
@@ -873,7 +873,7 @@
 		jEVENT(0,
 		       ("gc: tclsn:0x%x, bceor:0x%x\n", tblk->clsn,
 			bp->l_ceor));
-		lbmWrite(log, bp, lbmWRITE | lbmRELEASE | lbmGC);
+		lbmWrite(log, bp, lbmWRITE | lbmRELEASE | lbmGC, cant_write);
 	}
 	/* page is not yet full */
 	else {
@@ -882,7 +882,7 @@
 		jEVENT(0,
 		       ("gc: tclsn:0x%x, bceor:0x%x\n", tblk->clsn,
 			bp->l_ceor));
-		lbmWrite(log, bp, lbmWRITE | lbmGC);
+		lbmWrite(log, bp, lbmWRITE | lbmGC, cant_write);
 	}
 }
 
@@ -962,7 +962,7 @@
 			bp->l_ceor = bp->l_eor;
 			lp->h.eor = lp->t.eor = cpu_to_le16(bp->l_eor);
 			jEVENT(0, ("lmPostGC: calling lbmWrite\n"));
-			lbmWrite(log, bp, lbmWRITE | lbmRELEASE | lbmFREE);
+			lbmWrite(log, bp, lbmWRITE | lbmRELEASE | lbmFREE, 1);
 		}
 
 	}
@@ -977,7 +977,7 @@
 		/*
 		 * Call lmGCwrite with new group leader
 		 */
-		lmGCwrite(log);
+		lmGCwrite(log, 1);
 
 	/* no transaction are ready yet (transactions are only just
 	 * queued (GC_QUEUE) and not entered for group commit yet).
@@ -1169,7 +1169,7 @@
 		jFYI(1,
 		       ("gc: tclsn:0x%x, bceor:0x%x\n", tblk->clsn,
 			bp->l_ceor));
-		lbmWrite(log, bp, lbmWRITE | lbmRELEASE | lbmSYNC);
+		lbmWrite(log, bp, lbmWRITE | lbmRELEASE | lbmSYNC, 0);
 	}
 	/* page is not yet full */
 	else {
@@ -1178,7 +1178,7 @@
 		jFYI(1,
 		       ("gc: tclsn:0x%x, bceor:0x%x\n", tblk->clsn,
 			bp->l_ceor));
-		lbmWrite(log, bp, lbmWRITE | lbmSYNC);
+		lbmWrite(log, bp, lbmWRITE | lbmSYNC, 0);
 	}
 
 	LOGGC_UNLOCK(log);
@@ -1237,7 +1237,7 @@
 			/* finalize the page */
 			bp->l_ceor = bp->l_eor;
 			lp->h.eor = lp->t.eor = cpu_to_le16(bp->l_eor);
-			lbmWrite(log, bp, lbmWRITE | lbmRELEASE | lbmFREE);
+			lbmWrite(log, bp, lbmWRITE | lbmRELEASE | lbmFREE, 0);
 		}
 
 		tblk = tblk->cqnext;
@@ -1780,7 +1780,7 @@
 	bp->l_ceor = bp->l_eor;
 	lp = (logpage_t *) bp->l_ldata;
 	lp->h.eor = lp->t.eor = cpu_to_le16(bp->l_eor);
-	lbmWrite(log, bp, lbmWRITE | lbmSYNC);
+	lbmWrite(log, bp, lbmWRITE | lbmSYNC, 0);
 	if ((rc = lbmIOWait(bp, 0)))
 		goto errout30;
 
@@ -1981,7 +1981,7 @@
 	bp = log->bp;
 	lp = (logpage_t *) bp->l_ldata;
 	lp->h.eor = lp->t.eor = cpu_to_le16(bp->l_eor);
-	lbmWrite(log, log->bp, lbmWRITE | lbmRELEASE | lbmSYNC);
+	lbmWrite(log, log->bp, lbmWRITE | lbmRELEASE | lbmSYNC, 0);
 	lbmIOWait(log->bp, lbmFREE);
 
 	/*
@@ -2431,7 +2431,7 @@
  * LOGGC_LOCK() serializes lbmWrite() by lmNextPage() and lmGroupCommit().
  * LCACHE_LOCK() serializes xflag between lbmWrite() and lbmIODone()
  */
-static void lbmWrite(log_t * log, lbuf_t * bp, int flag)
+static void lbmWrite(log_t * log, lbuf_t * bp, int flag, int cant_block)
 {
 	lbuf_t *tail;
 	unsigned long flags;
@@ -2481,7 +2481,7 @@
 
 	LCACHE_UNLOCK();	/* unlock+enable */
 
-	if (in_interrupt()) {
+	if (cant_block) {
 		spin_lock_irqsave(&async_lock, flags);
 		bp->l_redrive_next = log_redrive_list;
 		log_redrive_list = bp;
