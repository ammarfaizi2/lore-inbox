Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbUCZXzZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 18:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbUCZXzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 18:55:24 -0500
Received: from moraine.clusterfs.com ([66.246.132.190]:24755 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261457AbUCZXzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 18:55:14 -0500
Date: Fri, 26 Mar 2004 16:55:11 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [EXT3/JBD] Periodic journal flush not enough?
Message-ID: <20040326235511.GW1177@schnapps.adilger.int>
Mail-Followup-To: Herbert Xu <herbert@gondor.apana.org.au>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040326231958.GA484@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040326231958.GA484@gondor.apana.org.au>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 27, 2004  10:19 +1100, Herbert Xu wrote:
> I've encountered a problem with the journal flush timer.  The problem
> is that when a filesystem is short on space, relying on a timer-based
> flushing mechanism is no longer adequate.  For example, on my P4 2GHz
> I can trigger an ENOSPC error by doing
> 
> while :; do echo test > a; [ -s a ] || break; rm a; done; echo Out of space
> 
> on an ext3 file system with 12Mb of free space using the usual 5s
> journal flush timer.
> 
> Of course, when you extend the flushing period as you do with laptop-mode,
> this problem becomes a lot worse.
> 
> So would it be possible to have the flushing activated on demand?

I had created a patch a while ago, but never really got any testing on it.
It would be great to get this problem fixed.  Patch against a 2.4.x kernel.

--- fs/ext3/balloc.c.orig	Fri Jul 25 19:55:34 2003
+++ fs/ext3/balloc.c	Tue Sep  2 16:27:51 2003
@@ -547,6 +547,8 @@ int ext3_new_block (handle_t *handle, st
 #ifdef EXT3FS_DEBUG
 	static int goal_hits = 0, goal_attempts = 0;
 #endif
+	int tried_commit = 0;
+
 	*errp = -ENOSPC;
 	sb = inode->i_sb;
 	if (!sb) {
@@ -643,6 +645,26 @@ repeat:
 		}
 	}
 
+	/* We can only try to commit the previous transaction, or we will
+	 * deadlock because the current op has a transaction handle open.
+	 * We also can't restart the current handle in a new transaction as
+	 * that might break the atomicity guarantees of this transaction.
+	 * Set current handle h_sync to allow it to be committed ASAP. */
+	if (!tried_commit) {
+		journal_t *journal = handle->h_transaction->t_journal;
+		transaction_t *prev_trans = journal->j_committing_transaction;
+
+		if (prev_trans) {
+			tid_t prev_tid = prev_trans->t_tid;
+			log_start_commit(journal, prev_trans);
+			log_wait_commit(journal, prev_tid);
+		}
+		handle->h_sync = 1;
+		tried_commit = 1;
+
+		goto repeat;
+	}
+
 	/* No space left on the device */
 	goto out;
 
Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

