Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbTDVKHT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 06:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbTDVKHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 06:07:19 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:47750 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263055AbTDVKHK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 06:07:10 -0400
Message-Id: <200304221018.h3MAItX11004@owlet.beaverton.ibm.com>
To: Ingo Molnar <mingo@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] HT scheduler, sched-2.5.68-A9 
In-reply-to: Your message of "Mon, 21 Apr 2003 15:13:31 EDT."
             <Pine.LNX.4.44.0304211509010.11700-100000@devserv.devel.redhat.com> 
Date: Tue, 22 Apr 2003 03:18:54 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo, several questions.

What makes this statement:

    * At this point it's sure that we have a SMT
    * imbalance: this (physical) CPU is idle but
    * another CPU has two (or more) tasks running.

true?  Do you mean "this cpu/sibling set are all idle but another
cpu/sibling set are all non-idle"?  Are we assuming that because both
a physical processor and its sibling are not idle, that it is better to
move a task from the sibling to a physical processor?  In other words,
we are presuming that the case where the task on the physical processor
and the task(s) on the sibling(s) are actually benefitting from the
relationship is rare?

    * We wake up one of the migration threads (it
    * doesnt matter which one) and let it fix things up:

So although a migration thread normally pulls tasks to it, we've altered
migration_thread now so that when cpu_active_balance() is set for its
cpu, it will go find a cpu/sibling set in which all siblings are busy
(knowing it has a good chance of finding one), decrement nr_running in
the runqueue it has found, call load_balance() on the queue which is
idle, and hope that load_balance will again find the busy queue (the
same queue as the migration thread's) and decide to move a task over?

whew. So why are we perverting the migration thread to push rather
than pull?  If active_load_balance() finds a imbalance, why must we use
such indirection?  Why decrement nr_running?  Couldn't we put together
a migration_req_t for the target queue's migration thread?

Making the migration thread TASK_UNINTERRUPTIBLE has the nasty side
effect of artificially raising the load average.  Why is this changed?

Rick
