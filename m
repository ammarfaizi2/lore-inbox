Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbTK2JZb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 04:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263762AbTK2JZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 04:25:31 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:59154 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S263760AbTK2JZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 04:25:25 -0500
Date: Sat, 29 Nov 2003 20:24:58 +1100
To: Marcelo Tosatti <marcelo@conectiva.com.br>, Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [JBD] Handle j_commit_interval == 0
Message-ID: <20031129092458.GA19338@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

After the laptop mode patch was merged, it is now possible for
j_commit_interval to be zero.  Unfortunately jbd doesn't handle
this situation very well.

This patch makes it do the sensible thing.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-source-2.4/fs/jbd/journal.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/fs/jbd/journal.c,v
retrieving revision 1.1.1.9
diff -u -r1.1.1.9 journal.c
--- kernel-source-2.4/fs/jbd/journal.c	29 Nov 2003 06:39:14 -0000	1.1.1.9
+++ kernel-source-2.4/fs/jbd/journal.c	29 Nov 2003 09:20:32 -0000
@@ -253,6 +253,7 @@
 
 		/* Were we woken up by a commit wakeup event? */
 		if ((transaction = journal->j_running_transaction) != NULL &&
+		    journal->j_commit_interval &&
 		    time_after_eq(jiffies, transaction->t_expires)) {
 			journal->j_commit_request = transaction->t_tid;
 			jbd_debug(1, "woke because of timeout\n");
Index: kernel-source-2.4/fs/jbd/transaction.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.4/fs/jbd/transaction.c,v
retrieving revision 1.1.1.6
diff -u -r1.1.1.6 transaction.c
--- kernel-source-2.4/fs/jbd/transaction.c	28 Nov 2003 18:26:21 -0000	1.1.1.6
+++ kernel-source-2.4/fs/jbd/transaction.c	29 Nov 2003 06:59:58 -0000
@@ -60,10 +60,12 @@
 	INIT_LIST_HEAD(&transaction->t_jcb);
 
 	/* Set up the commit timer for the new transaction. */
-	J_ASSERT (!journal->j_commit_timer_active);
-	journal->j_commit_timer_active = 1;
-	journal->j_commit_timer->expires = transaction->t_expires;
-	add_timer(journal->j_commit_timer);
+	if (journal->j_commit_interval) {
+		J_ASSERT (!journal->j_commit_timer_active);
+		journal->j_commit_timer_active = 1;
+		journal->j_commit_timer->expires = transaction->t_expires;
+		add_timer(journal->j_commit_timer);
+	}
 	
 	J_ASSERT (journal->j_running_transaction == NULL);
 	journal->j_running_transaction = transaction;
@@ -1465,7 +1467,8 @@
 	if (handle->h_sync ||
 			transaction->t_outstanding_credits >
 				journal->j_max_transaction_buffers ||
-	    		time_after_eq(jiffies, transaction->t_expires)) {
+	    		(journal->j_commit_interval &&
+	    		 time_after_eq(jiffies, transaction->t_expires))) {
 		/* Do this even for aborted journals: an abort still
 		 * completes the commit thread, it just doesn't write
 		 * anything to disk. */

--fUYQa+Pmc3FrFX/N--
