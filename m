Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262066AbVAOAtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbVAOAtT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 19:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbVAOAtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 19:49:19 -0500
Received: from waste.org ([216.27.176.166]:8673 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262066AbVAOAtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 19:49:11 -0500
Date: Fri, 14 Jan 2005 18:49:06 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2.563253706@selenic.com>
Message-Id: <3.563253706@selenic.com>
Subject: [PATCH 2/10] random pt2: kill pool clearing
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove pool clearing. We've only ever cleared one of three pools and
there's no good reason to do it. Instead just reset the entropy count.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/drivers/char/random.c
===================================================================
--- rnd.orig/drivers/char/random.c	2005-01-12 21:27:58.951649596 -0800
+++ rnd/drivers/char/random.c	2005-01-12 21:28:00.196490892 -0800
@@ -546,15 +546,6 @@
 	return 0;
 }
 
-/* Clear the entropy pool and associated counters. */
-static void clear_entropy_store(struct entropy_store *r)
-{
-	r->add_ptr = 0;
-	r->entropy_count = 0;
-	r->input_rotate = 0;
-	memset(r->pool, 0, r->poolinfo.POOLBYTES);
-}
-
 /*
  * This function adds a byte into the entropy "pool".  It does not
  * update the entropy estimate.  The caller should call
@@ -1531,9 +1522,6 @@
 	if (create_entropy_store(SECONDARY_POOL_SIZE, "urandom",
 				 &urandom_state))
 		goto err;
-	clear_entropy_store(random_state);
-	clear_entropy_store(sec_random_state);
-	clear_entropy_store(urandom_state);
 	init_std_data(random_state);
 	init_std_data(sec_random_state);
 	init_std_data(urandom_state);
@@ -1765,10 +1753,10 @@
 		random_state->entropy_count = 0;
 		return 0;
 	case RNDCLEARPOOL:
-		/* Clear the entropy pool and associated counters. */
+		/* Clear the entropy pool counters. */
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		clear_entropy_store(random_state);
+		random_state->entropy_count = 0;
 		init_std_data(random_state);
 		return 0;
 	default:
