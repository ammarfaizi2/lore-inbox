Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263819AbUCZAAn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263839AbUCZAAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:00:42 -0500
Received: from waste.org ([209.173.204.2]:49049 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263819AbUCYX6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:58:00 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1.524465763@selenic.com>
Message-Id: <2.524465763@selenic.com>
Subject: [PATCH 1/22] /dev/random: Simplify entropy debugging
Date: Thu, 25 Mar 2004 17:57:42 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Simplify entropy debugging



 tiny-mpm/drivers/char/random.c |   47 ++++++++---------------------------------
 1 files changed, 10 insertions(+), 37 deletions(-)

diff -puN drivers/char/random.c~debug-cleanup drivers/char/random.c
--- tiny/drivers/char/random.c~debug-cleanup	2004-03-13 13:00:13.000000000 -0600
+++ tiny-mpm/drivers/char/random.c	2004-03-13 13:00:13.000000000 -0600
@@ -477,7 +477,10 @@ static inline __u32 int_ln_12bits(__u32 
 #endif
 
 #if 0
-#define DEBUG_ENT(fmt, arg...) printk(KERN_DEBUG "random: " fmt, ## arg)
+#define DEBUG_ENT(fmt, arg...) printk(KERN_DEBUG "random %04d %04d: " fmt,\
+	random_state->entropy_count,\
+	sec_random_state->entropy_count,\
+	## arg)
 #else
 #define DEBUG_ENT(fmt, arg...) do {} while (0)
 #endif
@@ -624,9 +627,7 @@ static void credit_entropy_store(struct 
 	} else {
 		r->entropy_count += nbits;
 		if (nbits)
-			DEBUG_ENT("%04d %04d : added %d bits to %s\n",
-				  random_state->entropy_count,
-				  sec_random_state->entropy_count,
+			DEBUG_ENT("added %d bits to %s\n",
 				  nbits,
 				  r == sec_random_state ? "secondary" :
 				  r == random_state ? "primary" : "unknown");
@@ -1300,10 +1301,8 @@ static inline void xfer_secondary_pool(s
 		int bytes = max_t(int, random_read_wakeup_thresh / 8,
 				min_t(int, nbytes, TMP_BUF_SIZE));
 
-		DEBUG_ENT("%04d %04d : going to reseed %s with %d bits "
+		DEBUG_ENT("going to reseed %s with %d bits "
 			  "(%d of %d requested)\n",
-			  random_state->entropy_count,
-			  sec_random_state->entropy_count,
 			  r == sec_random_state ? "secondary" : "unknown",
 			  bytes * 8, nbytes * 8, r->entropy_count);
 
@@ -1346,9 +1345,7 @@ static ssize_t extract_entropy(struct en
 	/* Hold lock while accounting */
 	spin_lock_irqsave(&r->lock, cpuflags);
 
-	DEBUG_ENT("%04d %04d : trying to extract %d bits from %s\n",
-		  random_state->entropy_count,
-		  sec_random_state->entropy_count,
+	DEBUG_ENT("trying to extract %d bits from %s\n",
 		  nbytes * 8,
 		  r == sec_random_state ? "secondary" :
 		  r == random_state ? "primary" : "unknown");
@@ -1364,9 +1361,7 @@ static ssize_t extract_entropy(struct en
 	if (r->entropy_count < random_write_wakeup_thresh)
 		wake_up_interruptible(&random_write_wait);
 
-	DEBUG_ENT("%04d %04d : debiting %d bits from %s%s\n",
-		  random_state->entropy_count,
-		  sec_random_state->entropy_count,
+	DEBUG_ENT("debiting %d bits from %s%s\n",
 		  nbytes * 8,
 		  r == sec_random_state ? "secondary" :
 		  r == random_state ? "primary" : "unknown",
@@ -1386,15 +1381,7 @@ static ssize_t extract_entropy(struct en
 				break;
 			}
 
-			DEBUG_ENT("%04d %04d : extract feeling sleepy (%d bytes left)\n",
-				  random_state->entropy_count,
-				  sec_random_state->entropy_count, nbytes);
-
 			schedule();
-
-			DEBUG_ENT("%04d %04d : extract woke up\n",
-				  random_state->entropy_count,
-				  sec_random_state->entropy_count);
 		}
 
 		/* Hash the pool to get the output */
@@ -1580,20 +1567,14 @@ random_read(struct file * file, char * b
 		if (n > SEC_XFER_SIZE)
 			n = SEC_XFER_SIZE;
 
-		DEBUG_ENT("%04d %04d : reading %d bits, p: %d s: %d\n",
-			  random_state->entropy_count,
-			  sec_random_state->entropy_count,
-			  n*8, random_state->entropy_count,
-			  sec_random_state->entropy_count);
+		DEBUG_ENT("reading %d bits\n", n*8);
 
 		n = extract_entropy(sec_random_state, buf, n,
 				    EXTRACT_ENTROPY_USER |
 				    EXTRACT_ENTROPY_LIMIT |
 				    EXTRACT_ENTROPY_SECONDARY);
 
-		DEBUG_ENT("%04d %04d : read got %d bits (%d still needed)\n",
-			  random_state->entropy_count,
-			  sec_random_state->entropy_count,
+		DEBUG_ENT("read got %d bits (%d still needed)\n",
 			  n*8, (nbytes-n)*8);
 
 		if (n == 0) {
@@ -1606,10 +1587,6 @@ random_read(struct file * file, char * b
 				break;
 			}
 
-			DEBUG_ENT("%04d %04d : sleeping?\n",
-				  random_state->entropy_count,
-				  sec_random_state->entropy_count);
-
 			set_current_state(TASK_INTERRUPTIBLE);
 			add_wait_queue(&random_read_wait, &wait);
 
@@ -1619,10 +1596,6 @@ random_read(struct file * file, char * b
 			set_current_state(TASK_RUNNING);
 			remove_wait_queue(&random_read_wait, &wait);
 
-			DEBUG_ENT("%04d %04d : waking up\n",
-				  random_state->entropy_count,
-				  sec_random_state->entropy_count);
-
 			continue;
 		}
 

_
