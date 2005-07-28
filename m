Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVG1JT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVG1JT2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 05:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVG1JT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 05:19:28 -0400
Received: from mx2.elte.hu ([157.181.151.9]:41929 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261397AbVG1JTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 05:19:25 -0400
Date: Thu, 28 Jul 2005 11:19:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Keith Owens <kaos@ocs.com.au>, David.Mosberger@acm.org,
       Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Add prefetch switch stack hook in scheduler function
Message-ID: <20050728091901.GA26419@elte.hu>
References: <10613.1122538148@kao2.melbourne.sgi.com> <42E897FD.6060506@yahoo.com.au> <20050728083544.GA22740@elte.hu> <42E89BE6.6040304@yahoo.com.au> <20050728091638.GA25846@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050728091638.GA25846@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> next->mm we might want to prefetch, but it's probably not worth it 
> because we are referencing it too soon, in context_switch(). (while 
> the kernel stack itself wont be referenced until the full 
> context-switch is done) But might be worth trying - but even then, it 
> should be done from the generic code, like the thread_info and 
> kernel-stack prefetching.

the patch below adds next->mm prefetching too, ontop of the previous 
patch.

	Ingo

------

cache-prefetch next->mm too.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 kernel/sched.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -2866,10 +2866,11 @@ go_idle:
 
 	/*
 	 * Cache-prefetch crutial memory areas of the next task,
-	 * its thread_info and its kernel stack:
+	 * its thread_info, its kernel stack and mm:
 	 */
 	prefetch(next->thread_info);
 	prefetch(kernel_stack(next));
+	prefetch(next->mm);
 
 	if (!rt_task(next) && next->activated > 0) {
 		unsigned long long delta = now - next->timestamp;
