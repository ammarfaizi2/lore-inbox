Return-Path: <linux-kernel-owner+w=401wt.eu-S965033AbXAMGqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965033AbXAMGqW (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 01:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbXAMGqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 01:46:22 -0500
Received: from mail.suse.de ([195.135.220.2]:57124 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965033AbXAMGqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 01:46:22 -0500
Date: Sat, 13 Jan 2007 07:46:18 +0100
From: Nick Piggin <npiggin@suse.de>
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched: avoid div in rebalance_tick
Message-ID: <20070113064618.GA30425@wotan.suse.de>
References: <20070112060213.GB28611@wotan.suse.de> <20070112095940.0795a998@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070112095940.0795a998@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 09:59:40AM +0000, Alan wrote:
> On Fri, 12 Jan 2007 07:02:13 +0100
> Nick Piggin <npiggin@suse.de> wrote:
> 
> > Just noticed this while looking at a bug.
> > Avoid an expensive integer divide 3 times per CPU per tick.
> 
> Integer divide is cheap on some modern processors, and multibit shift
> isn't on all embedded ones.
> 
> How about putting back scale = 1 and using
> 
> scale += scale;
> 
> instead of the shift and getting what ought to be even better results

OK, how about this? It only works out to be around 0.01% of my P3's CPU time
at 1000HZ, but it also did make the x86 code 16 bytes smaller.


--
Avoid expensive integer divide 3 times per CPU per tick.

A userspace test of this loop went from 26ns, down to 19ns on a G5; and
from 123ns down to 28ns on a P3.

(Also avoid a variable bit shift, as suggested by Alan. The effect
of this wasn't noticable on the CPUs I tested with).

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c
+++ linux-2.6/kernel/sched.c
@@ -2887,14 +2887,16 @@ static void active_load_balance(struct r
 static void update_load(struct rq *this_rq)
 {
 	unsigned long this_load;
-	int i, scale;
+	unsigned int i, scale;
 
 	this_load = this_rq->raw_weighted_load;
 
 	/* Update our load: */
-	for (i = 0, scale = 1; i < 3; i++, scale <<= 1) {
+	for (i = 0, scale = 1; i < 3; i++, scale += scale) {
 		unsigned long old_load, new_load;
 
+		/* scale is effectively 1 << i now, and >> i divides by scale */
+
 		old_load = this_rq->cpu_load[i];
 		new_load = this_load;
 		/*
@@ -2904,7 +2906,7 @@ static void update_load(struct rq *this_
 		 */
 		if (new_load > old_load)
 			new_load += scale-1;
-		this_rq->cpu_load[i] = (old_load*(scale-1) + new_load) / scale;
+		this_rq->cpu_load[i] = (old_load*(scale-1) + new_load) >> i;
 	}
 }
 
