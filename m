Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbUCKUmI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 15:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbUCKUji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 15:39:38 -0500
Received: from ns.suse.de ([195.135.220.2]:59562 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261718AbUCKUgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 15:36:44 -0500
Subject: [PATCH] race in mempool_alloc/free
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Message-Id: <1079037543.27197.50.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Mar 2004 15:39:04 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

mempool_alloc and mempool_free check pool->curr_nr without any locks
held.  This can lead to skipping a wakeup when there are people waiting,
and sleeping when there are free elements in the pool.  

I can't trigger this reliably, but sooner or later someone on ppc is
probably going to hit it.

-chris

--- linux.t.orig/mm/mempool.c	2004-03-11 14:34:50.000000000 -0500
+++ linux.t/mm/mempool.c	2004-03-11 14:38:30.000000000 -0500
@@ -203,6 +203,7 @@
 	 * If the pool is less than 50% full and we can perform effective
 	 * page reclaim then try harder to allocate an element.
 	 */
+	mb();
 	if ((gfp_mask & __GFP_FS) && (gfp_mask != gfp_nowait) &&
 				(pool->curr_nr <= pool->min_nr/2)) {
 		element = pool->alloc(gfp_mask, pool->pool_data);
@@ -230,6 +231,7 @@
 	blk_run_queues();
 
 	prepare_to_wait(&pool->wait, &wait, TASK_UNINTERRUPTIBLE);
+	mb();
 	if (!pool->curr_nr)
 		io_schedule();
 	finish_wait(&pool->wait, &wait);
@@ -250,6 +252,7 @@
 {
 	unsigned long flags;
 
+	mb();
 	if (pool->curr_nr < pool->min_nr) {
 		spin_lock_irqsave(&pool->lock, flags);
 		if (pool->curr_nr < pool->min_nr) {



