Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbVAOBDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbVAOBDR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 20:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262067AbVAOAuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 19:50:02 -0500
Received: from waste.org ([216.27.176.166]:9697 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262070AbVAOAtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 19:49:13 -0500
Date: Fri, 14 Jan 2005 18:49:06 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4.563253706@selenic.com>
Message-Id: <5.563253706@selenic.com>
Subject: [PATCH 4/10] random pt2: re-init all pools on zero
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re-init all three pools in ioctls
Clear entropy count in init_std_data under a lock
Add kerneldoc comment

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/drivers/char/random.c
===================================================================
--- rnd.orig/drivers/char/random.c	2005-01-12 21:28:01.110374382 -0800
+++ rnd/drivers/char/random.c	2005-01-12 21:28:02.593185340 -0800
@@ -1473,16 +1473,14 @@
 
 EXPORT_SYMBOL(get_random_bytes);
 
-/*********************************************************************
- *
- * Functions to interface with Linux
- *
- *********************************************************************/
-
 /*
- * Initialize the random pool with standard stuff.
+ * init_std_data - initialize pool with system data
  *
- * NOTE: This is an OS-dependent function.
+ * @r: pool to initialize
+ *
+ * This function clears the pool's entropy count and mixes some system
+ * data into the pool to prepare it for use. The pool is not cleared
+ * as that can only decrease the entropy in the pool.
  */
 static void init_std_data(struct entropy_store *r)
 {
@@ -1490,6 +1488,11 @@
 	__u32 words[2];
 	char *p;
 	int i;
+	unsigned long flags;
+
+	spin_lock_irqsave(&r->lock, flags);
+	r->entropy_count = 0;
+	spin_unlock_irqrestore(&r->lock, flags);
 
 	do_gettimeofday(&tv);
 	words[0] = tv.tv_sec;
@@ -1752,8 +1755,9 @@
 		/* Clear the entropy pool counters. */
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		random_state->entropy_count = 0;
 		init_std_data(random_state);
+		init_std_data(sec_random_state);
+		init_std_data(urandom_state);
 		return 0;
 	default:
 		return -EINVAL;
