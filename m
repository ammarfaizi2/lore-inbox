Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267429AbUHTE64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267429AbUHTE64 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 00:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267556AbUHTE5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 00:57:42 -0400
Received: from thunk.org ([140.239.227.29]:16044 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S267429AbUHTE5V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 00:57:21 -0400
To: linux-kernel@vger.kernel.org
cc: akpm@osdl.org
Subject: [PATCH] [3/4] /dev/random: Use separate entropy store for /dev/urandom
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E1By1Sq-0001TP-BV@thunk.org>
Date: Fri, 20 Aug 2004 00:57:20 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds a separate pool for use with /dev/urandom.  This
prevents a /dev/urandom read from being able to completely drain the
entropy in the /dev/random pool, and also makes it much more difficult
for an attacker to carry out a state extension attack.

patch-random-3-urandom-pool

--- random.c	2004/08/19 22:49:48	1.3
+++ random.c	2004/08/19 22:50:19	1.4
@@ -401,6 +401,7 @@
  */
 static struct entropy_store *random_state; /* The default global store */
 static struct entropy_store *sec_random_state; /* secondary store */
+static struct entropy_store *urandom_state; /* For urandom */
 static DECLARE_WAIT_QUEUE_HEAD(random_read_wait);
 static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
 
@@ -1474,14 +1475,21 @@
  */
 void get_random_bytes(void *buf, int nbytes)
 {
-	if (sec_random_state)  
-		extract_entropy(sec_random_state, (char *) buf, nbytes, 
-				EXTRACT_ENTROPY_SECONDARY);
-	else if (random_state)
-		extract_entropy(random_state, (char *) buf, nbytes, 0);
-	else
+	struct entropy_store *r = urandom_state;
+	int flags = EXTRACT_ENTROPY_SECONDARY;
+
+	if (!r)
+		r = sec_random_state;
+	if (!r) {
+		r = random_state;
+		flags = 0;
+	}
+	if (!r) {
 		printk(KERN_NOTICE "get_random_bytes called before "
 				   "random driver initialization\n");
+		return;
+	}
+	extract_entropy(r, (char *) buf, nbytes, flags);
 }
 
 EXPORT_SYMBOL(get_random_bytes);
@@ -1532,8 +1540,12 @@
 	if (create_entropy_store(SECONDARY_POOL_SIZE, "secondary", 
 				 &sec_random_state))
 		goto err;
+	if (create_entropy_store(SECONDARY_POOL_SIZE, "urandom", 
+				 &urandom_state))
+		goto err;
 	clear_entropy_store(random_state);
 	clear_entropy_store(sec_random_state);
+	clear_entropy_store(urandom_state);
 	init_std_data(random_state);
 #ifdef CONFIG_SYSCTL
 	sysctl_init_random(random_state);
@@ -1667,9 +1679,15 @@
 urandom_read(struct file * file, char __user * buf,
 		      size_t nbytes, loff_t *ppos)
 {
-	return extract_entropy(sec_random_state, buf, nbytes,
-			       EXTRACT_ENTROPY_USER |
-			       EXTRACT_ENTROPY_SECONDARY);
+	int flags = EXTRACT_ENTROPY_USER;
+	unsigned long cpuflags;
+
+	spin_lock_irqsave(&random_state->lock, cpuflags);
+	if (random_state->entropy_count > random_state->poolinfo.POOLBITS)
+		flags |= EXTRACT_ENTROPY_SECONDARY;
+	spin_unlock_irqrestore(&random_state->lock, cpuflags);
+
+	return extract_entropy(urandom_state, buf, nbytes, flags);
 }
 
 static unsigned int
