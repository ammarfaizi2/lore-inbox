Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264954AbTLTTXz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 14:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264958AbTLTTXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 14:23:55 -0500
Received: from mx2.elte.hu ([157.181.151.9]:30393 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264954AbTLTTXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 14:23:54 -0500
Date: Sat, 20 Dec 2003 20:22:38 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] 2.6.0 fix preempt ctx switch accounting
Message-ID: <20031220192238.GA30970@elte.hu>
References: <3FE46885.2030905@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE46885.2030905@cyberone.com.au>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: SpamAssassin ELTE 1.0
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nick Piggin <piggin@cyberone.com.au> wrote:

> Make sure to count kernel preemption as a context switch. A short cut
> has been preventing it.

i'd prefer the much simpler patch below. This also keeps the kernel
preemption logic isolated instead of mixing it into the normal path.

	Ingo

--- linux/kernel/sched.c.orig	
+++ linux/kernel/sched.c	
@@ -1520,8 +1520,10 @@ need_resched:
 	 * if entering off of a kernel preemption go straight
 	 * to picking the next task.
 	 */
-	if (unlikely(preempt_count() & PREEMPT_ACTIVE))
+	if (unlikely(preempt_count() & PREEMPT_ACTIVE)) {
+		prev->nivcsw++;
 		goto pick_next_task;
+	}
 
 	switch (prev->state) {
 	case TASK_INTERRUPTIBLE:
