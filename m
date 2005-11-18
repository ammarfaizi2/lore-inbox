Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbVKRRMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbVKRRMx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 12:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbVKRRMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 12:12:53 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:26920
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S1030202AbVKRRMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 12:12:53 -0500
Date: Fri, 18 Nov 2005 18:12:49 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, edwardsg@sgi.com
Subject: shrinker->nr = LONG_MAX means deadlock for icache
Message-ID: <20051118171249.GJ24970@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Greg Edwards found some deadlock in the icache shrinker.

I believe the major bug is that the VM is currently potentially setting
nr = LONG_MAX before shrinking the icache (and the icache shrinker never
returns -1, which means the api doesn't currently require shrinkers to
return -1 when they're finished).

The below is the most obviously safe way I could address this problem
(still untested).

This is not necessairly the way we want to fix it in mainline, but it at
least shows what I believe to be the major cuplrit in the code (i.e. nr
growing insane ;).

Comments welcome as usual.

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

diff -r 5111ab3d0d8a mm/vmscan.c
--- a/mm/vmscan.c	Fri Nov 18 09:26:56 2005 +0800
+++ b/mm/vmscan.c	Fri Nov 18 19:01:55 2005 +0200
@@ -201,13 +201,21 @@
 	list_for_each_entry(shrinker, &shrinker_list, list) {
 		unsigned long long delta;
 		unsigned long total_scan;
+		unsigned long max_pass = (*shrinker->shrinker)(0, gfp_mask);
 
 		delta = (4 * scanned) / shrinker->seeks;
-		delta *= (*shrinker->shrinker)(0, gfp_mask);
+		delta *= max_pass;
 		do_div(delta, lru_pages + 1);
 		shrinker->nr += delta;
 		if (shrinker->nr < 0)
 			shrinker->nr = LONG_MAX;	/* It wrapped! */
+		/*
+		 * Avoid risking looping forever due to too large nr value:
+		 * never try to free more than twice the estimate number of
+		 * freeable entries.
+		 */
+		if (shrinker->nr > max_pass * 2)
+			shrinker->nr = max_pass * 2;
 
 		total_scan = shrinker->nr;
 		shrinker->nr = 0;
