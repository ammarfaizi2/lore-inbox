Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266516AbUAWGb7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 01:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266517AbUAWGb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 01:31:59 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:45494 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S266516AbUAWGb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 01:31:57 -0500
Date: Thu, 22 Jan 2004 22:31:40 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>, nevdull@us.ibm.com,
       dvhart@us.ibm.com
Subject: [PATCH] clarify find_busiest_group
Message-ID: <224300000.1074839500@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a minor nit with the find_busiest_group code. No functional change,
but makes the code simpler and clearer. This patch does two things ... 
adds some more expansive comments, and removes this if clause:

      if (*imbalance < SCHED_LOAD_SCALE
                      && max_load - this_load > SCHED_LOAD_SCALE)
		*imbalance = SCHED_LOAD_SCALE;

If we remove the scaling factor, we're basically conditionally doing:

	if (*imbalance < 1)
		*imbalance = 1;

Which is pointless, as the very next thing we do is to remove the scaling
factor, rounding up to the nearest integer as we do:

	*imbalance = (*imbalance + SCHED_LOAD_SCALE - 1) >> SCHED_LOAD_SHIFT;

Thus the if statement is redundant, and only makes the code harder to read ;-)

M.

diff -aurpN -X /home/fletch/.diff.exclude mm5/kernel/sched.c mm5-find_busiest_group/kernel/sched.c
--- mm5/kernel/sched.c	Wed Jan 21 22:07:11 2004
+++ mm5-find_busiest_group/kernel/sched.c	Thu Jan 22 22:21:22 2004
@@ -1440,11 +1440,16 @@ nextgroup:
 	if (idle == NOT_IDLE && 100*max_load <= domain->imbalance_pct*this_load)
 		goto out_balanced;
 
-	/* Take the minimum possible imbalance. */
+	/* 
+	 * We're trying to get all the cpus to the average_load, so we don't 
+	 * want to push ourselves above the average load, nor do we wish to 
+	 * reduce the max loaded cpu below the average load, as either of these
+	 * actions would just result in more rebalancing later, and ping-pong
+	 * tasks around. Thus we look for the minimum possible imbalance.
+	 */
 	*imbalance = min(max_load - avg_load, avg_load - this_load);
-	if (*imbalance < SCHED_LOAD_SCALE
-			&& max_load - this_load > SCHED_LOAD_SCALE)
-		*imbalance = SCHED_LOAD_SCALE;
+	
+	/* Get rid of the scaling factor now, rounding *up* as we divide */
 	*imbalance = (*imbalance + SCHED_LOAD_SCALE - 1) >> SCHED_LOAD_SHIFT;
 
 	if (*imbalance == 0) {

