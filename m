Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVASInZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVASInZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 03:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVASId2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 03:33:28 -0500
Received: from waste.org ([216.27.176.166]:20396 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261633AbVASIQz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 03:16:55 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3.64403262@selenic.com>
Message-Id: <4.64403262@selenic.com>
Subject: [PATCH 3/12] random pt3: Static sysctl bits
Date: Wed, 19 Jan 2005 00:17:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Static initialization for sysctl support

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/drivers/char/random.c
===================================================================
--- rnd.orig/drivers/char/random.c	2005-01-18 10:36:10.542146558 -0800
+++ rnd/drivers/char/random.c	2005-01-18 10:37:42.989360541 -0800
@@ -380,14 +380,6 @@
 static DECLARE_WAIT_QUEUE_HEAD(random_read_wait);
 static DECLARE_WAIT_QUEUE_HEAD(random_write_wait);
 
-/*
- * Forward procedure declarations
- */
-#ifdef CONFIG_SYSCTL
-struct entropy_store;
-static void sysctl_init_random(struct entropy_store *pool);
-#endif
-
 static inline __u32 rol32(__u32 word, int shift)
 {
 	return (word << shift) | (word >> (32 - shift));
@@ -1386,16 +1378,12 @@
 static int __init rand_initialize(void)
 {
 	if (batch_entropy_init(BATCH_ENTROPY_SIZE, &input_pool))
-		goto err;
+		return -1;
+
 	init_std_data(&input_pool);
 	init_std_data(&blocking_pool);
 	init_std_data(&nonblocking_pool);
-#ifdef CONFIG_SYSCTL
-	sysctl_init_random(&input_pool);
-#endif
 	return 0;
-err:
-	return -1;
 }
 module_init(rand_initialize);
 
@@ -1665,8 +1653,9 @@
 
 #include <linux/sysctl.h>
 
-static int min_read_thresh, max_read_thresh;
-static int min_write_thresh, max_write_thresh;
+static int min_read_thresh = 8, min_write_thresh;
+static int max_read_thresh = INPUT_POOL_WORDS * 32;
+static int max_write_thresh = INPUT_POOL_WORDS * 32;
 static char sysctl_bootid[16];
 
 /*
@@ -1750,6 +1739,7 @@
 		.maxlen		= sizeof(int),
 		.mode		= 0444,
 		.proc_handler	= &proc_dointvec,
+		.data		= &input_pool.entropy_count,
 	},
 	{
 		.ctl_name	= RANDOM_READ_THRESH,
@@ -1792,14 +1782,6 @@
 	},
 	{ .ctl_name = 0 }
 };
-
-static void sysctl_init_random(struct entropy_store *pool)
-{
-	min_read_thresh = 8;
-	min_write_thresh = 0;
-	max_read_thresh = max_write_thresh = pool->poolinfo->POOLBITS;
-	random_table[1].data = &pool->entropy_count;
-}
 #endif 	/* CONFIG_SYSCTL */
 
 /********************************************************************
