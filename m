Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265288AbUFOEzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265288AbUFOEzR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 00:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbUFOEzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 00:55:17 -0400
Received: from mx1.elte.hu ([157.181.1.137]:6058 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265288AbUFOEzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 00:55:11 -0400
Date: Tue, 15 Jun 2004 06:56:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@osdl.org>, markw@osdl.org
Subject: Re: [PATCH] Performance regression in 2.6.7-rc3
Message-ID: <20040615045616.GA2006@elte.hu>
References: <200406121028.06812.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406121028.06812.kernel@kolivas.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> with a little bit of detective work and help from Wli we tracked down that 
> this patch caused it:
> [PATCH] sched: improve wakeup-affinity

> A massive increase in idle time was observed and the throughput
> dropped by 40% Reversing this patch gave these results:

> backsched1: http://khack.osdl.org/stp/293865/
> Composite 	Query Processing Power 	Throughput Numerical Quantity
> 193.93 	145.95 	257.67
> 
> It may be best to reverse this patch until the regression is better 
> understood.

agreed. It is weird because Nick said that pgsql was tested with the
patch - and we applied the patch based on those good results. Nick?

Anyway, does the patch below fix the pgsql problem? It reverts to the
more agressive idle-balancing variant (which isnt strictly necessary for
the bw_pipe problem).

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/sched.c
+++ linux/kernel/sched.c
@@ -1625,8 +1626,7 @@
 	return busiest;
 
 out_balanced:
-	if (busiest && idle != NOT_IDLE && max_load > SCHED_LOAD_SCALE) {
+	if (busiest && (idle == NEWLY_IDLE ||
+			(idle == IDLE && max_load > SCHED_LOAD_SCALE)) ) {
 		*imbalance = 1;
 		return busiest;
 	}
