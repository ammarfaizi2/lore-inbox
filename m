Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318435AbSIKFUe>; Wed, 11 Sep 2002 01:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318432AbSIKFUb>; Wed, 11 Sep 2002 01:20:31 -0400
Received: from waste.org ([209.173.204.2]:35476 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318428AbSIKFSp>;
	Wed, 11 Sep 2002 01:18:45 -0400
Date: Wed, 11 Sep 2002 00:23:31 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/11] Entropy fixes - independent pool for /dev/urandom
Message-ID: <20020911052331.GY31597@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stop /dev/urandom readers from starving /dev/random for entropy by
creating a separate pool and not reseeding if doing so would prevent
/dev/random from reseeding.

diff -ur a/drivers/char/random.c b/drivers/char/random.c
--- a/drivers/char/random.c	2002-09-08 21:00:11.000000000 -0500
+++ b/drivers/char/random.c	2002-09-08 21:45:13.000000000 -0500
@@ -365,7 +365,7 @@
 /*
  * Static global variables
  */
-static struct entropy_store *input_pool, *blocking_pool;
+static struct entropy_store *input_pool, *blocking_pool, *nonblocking_pool;
 static DECLARE_WAIT_QUEUE_HEAD(random_read_wait);
 static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
 
@@ -601,6 +601,7 @@
 
 	/* switch pools if current full */
 	if (r->entropy_count >= r->poolinfo->POOLBITS) r = blocking_pool;
+	if (r->entropy_count >= r->poolinfo->POOLBITS) r = nonblocking_pool;
 
 	/* Don't allow more credit BITS > pool WORDS */
 	if(credit > batch_max) credit=batch_max;
@@ -1004,16 +1005,17 @@
  */
 void get_random_bytes(void *buf, int nbytes)
 {
-	if (!blocking_pool)  
+	if (!nonblocking_pool)  
 	{
 		printk(KERN_NOTICE "get_random_bytes called before "
 				   "random driver initialization\n");
 		return;
 	}
 
-	reseed_pool(blocking_pool, 
-		    random_read_wakeup_thresh, random_read_wakeup_thresh);
-	extract_entropy(blocking_pool, (char *) buf, nbytes, 0);
+	/* Leave enough for blocking pool to reseed itself */
+	reseed_pool(nonblocking_pool, 
+		    random_read_wakeup_thresh*2, random_read_wakeup_thresh);
+	extract_entropy(nonblocking_pool, (char *) buf, nbytes, 0);
 }
 
 /*********************************************************************
@@ -1055,8 +1057,9 @@
 {
 	input_pool = create_entropy_store(512, "input");
 	blocking_pool = create_entropy_store(128, "blocking");
+	nonblocking_pool = create_entropy_store(128, "nonblocking");
 
-	if(!(input_pool && blocking_pool)) return;
+	if(!(input_pool && blocking_pool && nonblocking_pool)) return;
 	if(batch_entropy_init(256)) return;
 
 	init_std_data(input_pool);
@@ -1134,10 +1137,10 @@
 urandom_read(struct file * file, char * buf,
 		      size_t nbytes, loff_t *ppos)
 {
-	reseed_pool(blocking_pool, 
-		    random_read_wakeup_thresh, random_read_wakeup_thresh);
+	reseed_pool(nonblocking_pool, 
+		    random_read_wakeup_thresh*2, random_read_wakeup_thresh);
 
-	return extract_entropy(blocking_pool, buf, nbytes,
+	return extract_entropy(nonblocking_pool, buf, nbytes,
 			       EXTRACT_ENTROPY_USER);
 }
 

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
