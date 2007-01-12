Return-Path: <linux-kernel-owner+w=401wt.eu-S1030501AbXALGCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030501AbXALGCT (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 01:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161002AbXALGCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 01:02:19 -0500
Received: from ns2.suse.de ([195.135.220.15]:39243 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030501AbXALGCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 01:02:19 -0500
Date: Fri, 12 Jan 2007 07:02:13 +0100
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] sched: avoid div in rebalance_tick
Message-ID: <20070112060213.GB28611@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just noticed this while looking at a bug.

--

Avoid an expensive integer divide 3 times per CPU per tick.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c
+++ linux-2.6/kernel/sched.c
@@ -2887,13 +2887,14 @@ static void active_load_balance(struct r
 static void update_load(struct rq *this_rq)
 {
 	unsigned long this_load;
-	int i, scale;
+	int i;
 
 	this_load = this_rq->raw_weighted_load;
 
 	/* Update our load: */
-	for (i = 0, scale = 1; i < 3; i++, scale <<= 1) {
+	for (i = 0; i < 3; i++) {
 		unsigned long old_load, new_load;
+		int scale;
 
 		old_load = this_rq->cpu_load[i];
 		new_load = this_load;
@@ -2902,9 +2903,11 @@ static void update_load(struct rq *this_
 		 * prevents us from getting stuck on 9 if the load is 10, for
 		 * example.
 		 */
+		scale = 1 << i;
 		if (new_load > old_load)
 			new_load += scale-1;
-		this_rq->cpu_load[i] = (old_load*(scale-1) + new_load) / scale;
+		this_rq->cpu_load[i] = (old_load*(scale-1) + new_load)
+					>> i; /* (divide by 'scale') */
 	}
 }
 
