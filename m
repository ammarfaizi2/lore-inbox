Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265524AbTLIMot (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 07:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265529AbTLIMos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 07:44:48 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:25870 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S265524AbTLIMoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 07:44:34 -0500
Date: Tue, 9 Dec 2003 12:24:18 +0000
From: Joe Thornber <thornber@sistina.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch 1/4] fs.h: b_journal_head
Message-ID: <20031209122418.GC472@reti>
References: <20031209115806.GA472@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031209115806.GA472@reti>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new member to struct buffer_head called b_journal_head.  This is
for jbd to use, rather than have it peeking at b_private for in flight
ios.
--- diff/fs/buffer.c	2003-12-09 10:25:27.000000000 +0000
+++ source/fs/buffer.c	2003-12-09 10:32:41.000000000 +0000
@@ -763,6 +763,7 @@
 	bh->b_list = BUF_CLEAN;
 	bh->b_end_io = handler;
 	bh->b_private = private;
+	bh->b_journal_head = NULL;
 }
 
 static void end_buffer_io_async(struct buffer_head * bh, int uptodate)
--- diff/fs/jbd/journal.c	2003-12-09 10:25:27.000000000 +0000
+++ source/fs/jbd/journal.c	2003-12-09 10:32:41.000000000 +0000
@@ -1802,9 +1802,9 @@
 
 		if (buffer_jbd(bh)) {
 			/* Someone did it for us! */
-			J_ASSERT_BH(bh, bh->b_private != NULL);
+ 			J_ASSERT_BH(bh, bh->b_journal_head != NULL);
 			journal_free_journal_head(jh);
-			jh = bh->b_private;
+ 			jh = bh->b_journal_head;
 		} else {
 			/*
 			 * We actually don't need jh_splice_lock when
@@ -1812,7 +1812,7 @@
 			 */
 			spin_lock(&jh_splice_lock);
 			set_bit(BH_JBD, &bh->b_state);
-			bh->b_private = jh;
+			bh->b_journal_head = jh;
 			jh->b_bh = bh;
 			atomic_inc(&bh->b_count);
 			spin_unlock(&jh_splice_lock);
@@ -1821,7 +1821,7 @@
 	}
 	jh->b_jcount++;
 	spin_unlock(&journal_datalist_lock);
-	return bh->b_private;
+	return bh->b_journal_head;
 }
 
 /*
@@ -1854,7 +1854,7 @@
 			J_ASSERT_BH(bh, jh2bh(jh) == bh);
 			BUFFER_TRACE(bh, "remove journal_head");
 			spin_lock(&jh_splice_lock);
-			bh->b_private = NULL;
+			bh->b_journal_head = NULL;
 			jh->b_bh = NULL;	/* debug, really */
 			clear_bit(BH_JBD, &bh->b_state);
 			__brelse(bh);
--- diff/include/linux/fs.h	2003-12-09 10:25:27.000000000 +0000
+++ source/include/linux/fs.h	2003-12-09 10:32:41.000000000 +0000
@@ -265,7 +265,7 @@
 	struct page *b_page;		/* the page this bh is mapped to */
 	void (*b_end_io)(struct buffer_head *bh, int uptodate); /* I/O completion */
  	void *b_private;		/* reserved for b_end_io */
-
+ 	void *b_journal_head;		/* ext3 journal_heads */
 	unsigned long b_rsector;	/* Real buffer location on disk */
 	wait_queue_head_t b_wait;
 
--- diff/include/linux/jbd.h	2003-06-16 09:56:12.000000000 +0100
+++ source/include/linux/jbd.h	2003-12-09 10:32:41.000000000 +0000
@@ -311,7 +311,7 @@
 
 static inline struct journal_head *bh2jh(struct buffer_head *bh)
 {
-	return bh->b_private;
+	return bh->b_journal_head;
 }
 
 #define HAVE_JOURNAL_CALLBACK_STATUS
