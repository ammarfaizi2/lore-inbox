Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269303AbUINOJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269303AbUINOJR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 10:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269306AbUINOJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 10:09:17 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:23443 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S269303AbUINOJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 10:09:15 -0400
Date: Tue, 14 Sep 2004 16:09:05 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
Message-ID: <20040914140905.GM4180@dualathlon.random>
References: <20040914104449.GA30790@elte.hu> <20040914105048.GA31238@elte.hu> <20040914105904.GB31370@elte.hu> <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu> <20040914112847.GA2804@elte.hu> <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4146F33C.9030504@yahoo.com.au>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 11:33:48PM +1000, Nick Piggin wrote:
> cond_rescheds everywhere? Isn't this now the worst of both worlds?

1) cond_resched should become a noop if CONFIG_PREEMPT=y
   (cond_resched_lock of course should still unlock/relock if
    need_resched() is set, but not __cond_resched).
2) all Ingo's new and old might_sleep should be converted to
   cond_resched (or optionally to cond_resched_costly, see point 5).
3) might_sleep should return a debug statement.
4) cond_resched should call might_sleep if need_resched is not set if
   CONFIG_PREEMPT=n is disabled, and it should _only_ call might_sleep
   if CONFIG_PREEMPT=y after we implement point 1.
5) no further config option should exist (if we really add an option
   it should be called CONFIG_COND_RESCHED_COSTLY of similar to 
   differentiate scheduling points in fast paths (like spinlock places
   with CONFIG_PREEMPT=n) (so you can choose between cond_resched() and
   cond_resched_costly())

I recommended point 2,3,4,5 already (a few of them twice), point 1 (your
point) looks lower prio (CONFIG_PREEMPT=y already does an overkill of
implicit need_resched() checks anyways).

> Why would someone who really cares about latency not enable preempt?

to avoid lots of worthless cond_resched in all spin_unlock and to avoid
kernel crashes if some driver is not preempt complaint?

I've a better question for you, why would someone ever disable
CONFIG_PREEMPT_VOLUNTARY? That config option is a nosense as far as I
can tell. If something it should be renamed to
"CONFIG_I_DON_T_WANT_TO_RUN_THE_OLD_KERNEL_CODE" ;)
