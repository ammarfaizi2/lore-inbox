Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422638AbWJ3Us5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422638AbWJ3Us5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422640AbWJ3Us4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:48:56 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:32416 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1422638AbWJ3Us4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:48:56 -0500
Date: Mon, 30 Oct 2006 23:48:43 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
       Jay Lan <jlan@sgi.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] taskstats_exit_alloc: optimize/simplify
Message-ID: <20061030204843.GA1135@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If there are no listeners, every task does unneeded kmem_cache alloc/free on
exit. We don't need listeners->sem for 'if (!list_empty())' check. Yes, we may
have a false positive, but this doesn't differ from the case when the listener
is unregistered after we drop the semaphore. So we don't need to do allocation
beforehand.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- STATS/kernel/taskstats.c~1_alloc	2006-10-29 18:35:40.000000000 +0300
+++ STATS/kernel/taskstats.c	2006-10-30 23:45:20.000000000 +0300
@@ -421,7 +421,6 @@ err:
 void taskstats_exit_alloc(struct taskstats **ptidstats, unsigned int *mycpu)
 {
 	struct listener_list *listeners;
-	struct taskstats *tmp;
 	/*
 	 * This is the cpu on which the task is exiting currently and will
 	 * be the one for which the exit event is sent, even if the cpu
@@ -429,19 +428,11 @@ void taskstats_exit_alloc(struct tasksta
 	 */
 	*mycpu = raw_smp_processor_id();
 
-	*ptidstats = NULL;
-	tmp = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
-	if (!tmp)
-		return;
-
 	listeners = &per_cpu(listener_array, *mycpu);
-	down_read(&listeners->sem);
-	if (!list_empty(&listeners->list)) {
-		*ptidstats = tmp;
-		tmp = NULL;
-	}
-	up_read(&listeners->sem);
-	kfree(tmp);
+
+	*ptidstats = NULL;
+	if (!list_empty(&listeners->list))
+		*ptidstats = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
 }
 
 /* Send pid data out on exit */

