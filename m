Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318369AbSIKFSW>; Wed, 11 Sep 2002 01:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318428AbSIKFSW>; Wed, 11 Sep 2002 01:18:22 -0400
Received: from waste.org ([209.173.204.2]:32404 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318369AbSIKFRc>;
	Wed, 11 Sep 2002 01:17:32 -0400
Date: Wed, 11 Sep 2002 00:22:17 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 9/11] Entropy fixes - refactor reseeding
Message-ID: <20020911052217.GX31597@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Factor pool reseeding out of normal entropy transfer. This allows
different pools to have different policy on how to reseed.

This patch also makes random_read actually use the entropy count in
the secondary pool rather than tracking off the primary.

diff -urN clean/drivers/char/random.c patched/drivers/char/random.c
--- clean/drivers/char/random.c	2002-09-10 23:32:04.000000000 -0500
+++ patched/drivers/char/random.c	2002-09-10 23:34:28.000000000 -0500
@@ -886,7 +886,6 @@
  *********************************************************************/
 
 #define EXTRACT_ENTROPY_USER		1
-#define EXTRACT_ENTROPY_SECONDARY	2
 #define TMP_BUF_SIZE			(HASH_BUFFER_SIZE + HASH_EXTRA_SIZE)
 #define SEC_XFER_SIZE			(TMP_BUF_SIZE*4)
 
@@ -928,10 +927,6 @@
  * number of bytes that are actually obtained.  If the EXTRACT_ENTROPY_USER
  * flag is given, then the buf pointer is assumed to be in user space.
  *
- * If the EXTRACT_ENTROPY_SECONDARY flag is given, then we are actually
- * extracting entropy from the secondary pool, and can refill from the
- * primary pool if needed.
- *
  * Note: extract_entropy() assumes that .poolwords is a multiple of 16 words.
  */
 static ssize_t extract_entropy(struct entropy_store *r, void * buf,
@@ -945,9 +940,6 @@
 	if (r->entropy_count > r->poolinfo.POOLBITS)
 		r->entropy_count = r->poolinfo.POOLBITS;
 
-	if (flags & EXTRACT_ENTROPY_SECONDARY)
-		xfer_secondary_pool(r, nbytes);
-
 	DEBUG_ENT("%s has %d bits, want %d bits\n",
 		  r == sec_random_state ? "secondary" :
 		  r == random_state ? "primary" : "unknown",
@@ -1029,6 +1021,18 @@
 	return ret;
 }
 
+/* Reseed pool with pull bits from input pool, provided input pool has
+ * more than thresh bits available. Pull should be sufficient for a
+ * "catastrophic reseed" - enough to make the destination pool
+ * unguessable should it be compromised
+ */
+void reseed_pool(struct entropy_store *r, int thresh, int pull)
+{
+	if (r->entropy_count < 8 &&
+	    random_state->entropy_count > thresh)
+		xfer_secondary_pool(r, pull/8);
+}
+
 /*
  * This function is the exported kernel interface.  It returns some
  * number of good random numbers, suitable for seeding TCP sequence
@@ -1036,14 +1040,16 @@
  */
 void get_random_bytes(void *buf, int nbytes)
 {
-	if (sec_random_state)  
-		extract_entropy(sec_random_state, (char *) buf, nbytes, 
-				EXTRACT_ENTROPY_SECONDARY);
-	else if (random_state)
-		extract_entropy(random_state, (char *) buf, nbytes, 0);
-	else
+	if (!sec_random_state)  
+	{
 		printk(KERN_NOTICE "get_random_bytes called before "
 				   "random driver initialization\n");
+		return;
+	}
+
+	reseed_pool(sec_random_state, 
+		    random_read_wakeup_thresh, random_read_wakeup_thresh);
+	extract_entropy(sec_random_state, (char *) buf, nbytes, 0);
 }
 
 /*********************************************************************
@@ -1107,14 +1113,19 @@
 		return 0;
 
 	add_wait_queue(&random_read_wait, &wait);
+
 	while (nbytes > 0) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		
+		reseed_pool(sec_random_state, 
+			    random_read_wakeup_thresh,
+			    random_read_wakeup_thresh);
+
 		n = nbytes;
 		if (n > SEC_XFER_SIZE)
 			n = SEC_XFER_SIZE;
-		if (n > random_state->entropy_count / 8)
-			n = random_state->entropy_count / 8;
+		if (n > sec_random_state->entropy_count / 8)
+			n = sec_random_state->entropy_count / 8;
 		if (n == 0) {
 			if (file->f_flags & O_NONBLOCK) {
 				retval = -EAGAIN;
@@ -1133,8 +1144,8 @@
 			  sec_random_state->entropy_count);
 
 		n = extract_entropy(sec_random_state, buf, n,
-				    EXTRACT_ENTROPY_USER |
-				    EXTRACT_ENTROPY_SECONDARY);
+				    EXTRACT_ENTROPY_USER);
+
 		if (n < 0) {
 			retval = n;
 			break;
@@ -1162,9 +1173,11 @@
 urandom_read(struct file * file, char * buf,
 		      size_t nbytes, loff_t *ppos)
 {
+	reseed_pool(sec_random_state, 
+		    random_read_wakeup_thresh, random_read_wakeup_thresh);
+
 	return extract_entropy(sec_random_state, buf, nbytes,
-			       EXTRACT_ENTROPY_USER |
-			       EXTRACT_ENTROPY_SECONDARY);
+			       EXTRACT_ENTROPY_USER);
 }
 
 static unsigned int


-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
