Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264625AbUFGN4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264625AbUFGN4o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 09:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264623AbUFGN4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 09:56:44 -0400
Received: from holomorphy.com ([207.189.100.168]:14007 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264625AbUFGN4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 09:56:37 -0400
Date: Mon, 7 Jun 2004 06:56:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
Message-ID: <20040607135631.GY21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Zwane Mwaikambo <zwane@linuxpower.ca>
References: <200406070139.38433.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406070139.38433.kernel@kolivas.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 01:39:26AM +1000, Con Kolivas wrote:
> This is an update of the scheduler policy mechanism rewrite using the 
> infrastructure of the current O(1) scheduler. Slight changes from the 
> original design require a detailed description. The change to the original 
> design has enabled all known corner cases to be abolished and cpu 
> distribution to be much better maintained. It has proven to be stable in my 
> testing and is ready for more widespread public testing now.

There is only one "array" per runqueue; the removed code should be at
most a BUG_ON() or WARN_ON(); I opted to delete it altogether.

Index: kolivas-2.6.7-rc2/kernel/sched.c
===================================================================
--- kolivas-2.6.7-rc2.orig/kernel/sched.c	2004-06-07 06:19:45.938605000 -0700
+++ kolivas-2.6.7-rc2/kernel/sched.c	2004-06-07 06:53:21.555185000 -0700
@@ -1789,13 +1789,7 @@
 		cpustat->user += user_ticks;
 	cpustat->system += sys_ticks;
 
-	/* Task might have expired already, but not scheduled off yet */
-	if (p->array != &rq->array) {
-		set_tsk_need_resched(p);
-		goto out;
-	}
 	spin_lock(&rq->lock);
-	
 	// SCHED_FIFO tasks never run out of timeslice.
 	if (unlikely(p->policy == SCHED_FIFO))
 		goto out_unlock;
