Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVAMGq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVAMGq7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 01:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVAMGq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 01:46:58 -0500
Received: from waste.org ([216.27.176.166]:12676 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261171AbVAMGqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 01:46:35 -0500
Date: Wed, 12 Jan 2005 22:46:29 -0800
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, "Theodore Y. Ts'o" <tytso@MIT.EDU>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] random periodicity detection fix
Message-ID: <20050113064629.GZ2940@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The input layer is now sending us a bunch of events in a row for each
actual event. This shows up weaknesses in the periodicity detector and
using the high clock rate from get_clock: each keystroke is getting
accounted as 10 different tmaximal-entropy events.

A brief touch on a trackpad will generate as much as 2000 maximal
entropy events which is more than 2k of /dev/random output. IOW, we're
WAY overestimating input entropy. Here's one keystroke:

random 0024 0000 0000: mouse event
random 0035 0000 0000: added 11 entropy credits to input
random 0035 0000 0000: mouse event
random 0046 0000 0000: added 11 entropy credits to input
random 0046 0000 0000: mouse event
random 0056 0000 0000: added 10 entropy credits to input
random 0056 0000 0000: keyboard event
random 0067 0000 0000: added 11 entropy credits to input
random 0067 0000 0000: mouse event
random 0078 0000 0000: added 11 entropy credits to input
random 0078 0000 0000: awake
random 0078 0000 0000: reading 128 bits
random 0078 0000 0000: going to reseed blocking with 128 bits (128 of 0 requested)
random 0078 0000 0000: trying to extract 128 bits from input
random 0006 0000 0000: debiting 72 entropy credits from input
random 0006 0072 0000: added 72 entropy credits to blocking
random 0006 0072 0000: trying to extract 128 bits from blocking
random 0006 0000 0000: debiting 72 entropy credits from blocking
random 0006 0000 0000: read got 72 bits (56 still needed)
random 0006 0000 0000: reading 56 bits
random 0006 0000 0000: going to reseed blocking with 64 bits (56 of 0 requested
random 0006 0000 0000: trying to extract 64 bits from input
random 0006 0000 0000: debiting 0 entropy credits from input
random 0006 0000 0000: trying to extract 56 bits from blocking
random 0006 0000 0000: debiting 0 entropy credits from blocking
random 0006 0000 0000: read got 0 bits (56 still needed)
random 0006 0000 0000: sleeping
random 0006 0000 0000: mouse event
random 0017 0000 0000: added 11 entropy credits to input
random 0017 0000 0000: mouse event
random 0028 0000 0000: added 11 entropy credits to input
random 0028 0000 0000: mouse event
random 0038 0000 0000: added 10 entropy credits to input
random 0038 0000 0000: keyboard event
random 0049 0000 0000: added 11 entropy credits to input
random 0049 0000 0000: mouse event
random 0060 0000 0000: added 11 entropy credits to input

The first step to fixing this is to check periodicity and estimate
entropy against a slow clock like jiffies. We continue to mix in
get_clock() rather than jiffies where available.

This throws away most of the duplicate events and gives us more
sensible entropy estimates, but we still duplicates from input.c and
keyboard.c.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: rnd/drivers/char/random.c
===================================================================
--- rnd.orig/drivers/char/random.c	2005-01-12 21:27:56.027022454 -0800
+++ rnd/drivers/char/random.c	2005-01-12 21:27:57.406846542 -0800
@@ -805,8 +805,8 @@
  */
 static void add_timer_randomness(struct timer_rand_state *state, unsigned num)
 {
-	cycles_t time;
-	long delta, delta2, delta3;
+	cycles_t data;
+	long delta, delta2, delta3, time;
 	int entropy = 0;
 
 	preempt_disable();
@@ -816,20 +816,12 @@
 		goto out;
 
 	/*
-	 * Use get_cycles() if implemented, otherwise fall back to
-	 * jiffies.
-	 */
-	time = get_cycles();
-	if (time)
-		num ^= (u32)((time >> 31) >> 1);
-	else
-		time = jiffies;
-
-	/*
 	 * Calculate number of bits of randomness we probably added.
 	 * We take into account the first, second and third-order deltas
 	 * in order to make our estimate.
 	 */
+	time = jiffies;
+
 	if (!state->dont_count_entropy) {
 		delta = time - state->last_time;
 		state->last_time = time;
@@ -861,7 +853,18 @@
 
 		entropy = int_ln_12bits(delta);
 	}
-	batch_entropy_store(num, time, entropy);
+
+	/*
+	 * Use get_cycles() if implemented, otherwise fall back to
+	 * jiffies.
+	 */
+	data = get_cycles();
+	if (data)
+		num ^= (u32)((data >> 31) >> 1);
+	else
+		data = time;
+
+	batch_entropy_store(num, data, entropy);
 out:
 	preempt_enable();
 }


-- 
Mathematics is the supreme nostalgia of our time.
