Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263829AbUCZAFb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263828AbUCZAEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:04:53 -0500
Received: from waste.org ([209.173.204.2]:53913 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263829AbUCYX6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:58:07 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <12.524465763@selenic.com>
Message-Id: <13.524465763@selenic.com>
Subject: [PATCH 12/22] /dev/random: add pool for /dev/urandom to prevent starv
Date: Thu, 25 Mar 2004 17:57:44 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/dev/random  add pool for /dev/urandom to prevent starvation

Prevent readers of /dev/urandom from starving readers of /dev/random
by adding a second output pool for nonblocking reads. /dev/urandom
will always leave enough entropy in input pool for /dev/random to
reseed itself.


 tiny-mpm/drivers/char/random.c |   32 +++++++++++++++++---------------
 1 files changed, 17 insertions(+), 15 deletions(-)

diff -puN drivers/char/random.c~nonblocking-pool drivers/char/random.c
--- tiny/drivers/char/random.c~nonblocking-pool	2004-03-20 13:38:28.000000000 -0600
+++ tiny-mpm/drivers/char/random.c	2004-03-20 13:38:28.000000000 -0600
@@ -399,8 +399,7 @@ static struct poolinfo {
 /*
  * Static global variables
  */
-static struct entropy_store *input_pool; /* The default global store */
-static struct entropy_store *blocking_pool; /* secondary store */
+static struct entropy_store *input_pool, *blocking_pool, *nonblocking_pool;
 static DECLARE_WAIT_QUEUE_HEAD(random_read_wait);
 static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
 
@@ -477,9 +476,11 @@ static inline __u32 int_ln_12bits(__u32 
 #endif
 
 #if 0
-#define DEBUG_ENT(fmt, arg...) printk(KERN_DEBUG "random %04d %04d: " fmt,\
+#define DEBUG_ENT(fmt, arg...) \
+printk(KERN_DEBUG "random %04d %04d %04d: " fmt,\
 	input_pool->entropy_count,\
 	blocking_pool->entropy_count,\
+	nonblocking_pool->entropy_count,\
 	## arg)
 #else
 #define DEBUG_ENT(fmt, arg...) do {} while (0)
@@ -700,8 +701,7 @@ EXPORT_SYMBOL(batch_entropy_store);
  */
 static void batch_entropy_process(void *private_)
 {
-	struct entropy_store *r	= (struct entropy_store *) private_, *p;
-	int max_entropy = r->poolinfo->POOLBITS;
+	struct entropy_store *r	= input_pool;
 	unsigned head, tail;
 
 	/* Mixing into the pool is expensive, so copy over the batch
@@ -720,18 +720,17 @@ static void batch_entropy_process(void *
 
 	spin_unlock_irq(&batch_lock);
 
-	p = r;
 	while (head != tail) {
-		if (r->entropy_count >= max_entropy) {
-			r = (r == blocking_pool) ? input_pool :
-							blocking_pool;
-			max_entropy = r->poolinfo->POOLBITS;
-		}
+		if (r->entropy_count >= r->poolinfo->POOLBITS)
+			r = blocking_pool;
+		if (r->entropy_count >= r->poolinfo->POOLBITS)
+			r = nonblocking_pool;
+
 		add_entropy_words(r, batch_entropy_copy[tail].data, 2);
 		credit_entropy_store(r, batch_entropy_copy[tail].credit);
 		tail = (tail+1) & (batch_max-1);
 	}
-	if (p->entropy_count >= random_read_wakeup_thresh)
+	if (input_pool->entropy_count >= random_read_wakeup_thresh)
 		wake_up_interruptible(&random_read_wait);
 }
 
@@ -1427,7 +1426,7 @@ static ssize_t extract_entropy(struct en
 void get_random_bytes(void *buf, int nbytes)
 {
 	BUG_ON(!blocking_pool);
-	extract_entropy(blocking_pool, buf, nbytes, 0, 0, 0);
+	extract_entropy(nonblocking_pool, buf, nbytes, 0, 0, 0);
 }
 
 EXPORT_SYMBOL(get_random_bytes);
@@ -1473,8 +1472,11 @@ static int __init rand_initialize(void)
 
 	input_pool = create_entropy_store(INPUT_POOL_SIZE, "input");
 	blocking_pool = create_entropy_store(BLOCKING_POOL_SIZE, "blocking");
+	nonblocking_pool = create_entropy_store(BLOCKING_POOL_SIZE,
+						"nonblocking");
+	nonblocking_pool->reserved = 1;
 
-	if (!(input_pool && blocking_pool))
+	if (!(input_pool && blocking_pool && nonblocking_pool))
 		return -1;
 
 	if (batch_entropy_init(BATCH_ENTROPY_SIZE, input_pool))
@@ -1595,7 +1597,7 @@ static ssize_t
 urandom_read(struct file * file, char * buf,
 		      size_t nbytes, loff_t *ppos)
 {
-	return extract_entropy(blocking_pool, buf, nbytes, 0, 0,
+	return extract_entropy(nonblocking_pool, buf, nbytes, 0, 0,
 			       EXTRACT_ENTROPY_USER);
 }
 

_
