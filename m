Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVDOH6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVDOH6R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 03:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVDOH6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 03:58:17 -0400
Received: from mx1.elte.hu ([157.181.1.137]:55440 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261762AbVDOH6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 03:58:11 -0400
Date: Fri, 15 Apr 2005 09:58:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Robert Love <rml@tech9.net>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] sched: fix never executed code due to expression always false
Message-ID: <20050415075801.GA24974@elte.hu>
References: <Pine.LNX.4.62.0504150140250.3466@dragon.hyggekrogen.localhost> <425F064E.8050003@yahoo.com.au> <Pine.LNX.4.62.0504150213240.3466@dragon.hyggekrogen.localhost> <425F0735.6010407@yahoo.com.au> <Pine.LNX.4.62.0504150222390.3466@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504150222390.3466@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jesper Juhl <juhl-lkml@dif.dk> wrote:

> As per this patch perhaps? : 
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

this is still not enough (there was one more comparison to cover). Also, 
it's a bit cleaner to just cast the left side to signed than cast every 
member separately.

	Ingo

--

fix signed comparisons of long long.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -2695,9 +2695,9 @@ need_resched_nonpreemptible:
 
 	schedstat_inc(rq, sched_cnt);
 	now = sched_clock();
-	if (likely((long long)now - prev->timestamp < NS_MAX_SLEEP_AVG)) {
+	if (likely((long long)(now - prev->timestamp) < NS_MAX_SLEEP_AVG)) {
 		run_time = now - prev->timestamp;
-		if (unlikely((long long)now - prev->timestamp < 0))
+		if (unlikely((long long)(now - prev->timestamp) < 0))
 			run_time = 0;
 	} else
 		run_time = NS_MAX_SLEEP_AVG;
@@ -2775,7 +2775,7 @@ go_idle:
 
 	if (!rt_task(next) && next->activated > 0) {
 		unsigned long long delta = now - next->timestamp;
-		if (unlikely((long long)now - next->timestamp < 0))
+		if (unlikely((long long)(now - next->timestamp) < 0))
 			delta = 0;
 
 		if (next->activated == 1)
