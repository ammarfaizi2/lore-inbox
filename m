Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbTDQUdj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 16:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTDQUdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 16:33:39 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:17662 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S262549AbTDQUdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 16:33:33 -0400
Date: Thu, 17 Apr 2003 21:47:25 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] stop swapoff 2/3 EINTR
In-Reply-To: <Pine.LNX.4.44.0304172142530.2039-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0304172146420.2039-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes you start a swapoff and, seeing how long it takes,
wish you had not: allow signal to interrupt and stop swapoff.

--- swapoff1/mm/swapfile.c	Thu Apr 17 18:32:40 2003
+++ swapoff2/mm/swapfile.c	Thu Apr 17 18:32:50 2003
@@ -592,6 +592,11 @@
 	 * to swapoff for a while, then reappear - but that is rare.
 	 */
 	while ((i = find_next_to_unuse(si, i))) {
+		if (signal_pending(current)) {
+			retval = -EINTR;
+			break;
+		}
+
 		/* 
 		 * Get a page for the entry, using the existing swap
 		 * cache page if there is one.  Otherwise, get a clean
@@ -761,8 +766,7 @@
 
 		/*
 		 * Make sure that we aren't completely killing
-		 * interactive performance.  Interruptible check on
-		 * signal_pending() would be nice, but changes the spec?
+		 * interactive performance.
 		 */
 		cond_resched();
 	}

