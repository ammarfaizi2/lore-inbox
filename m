Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269661AbUINUdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269661AbUINUdO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 16:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269731AbUINU3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 16:29:40 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:41918 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269738AbUINUXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 16:23:48 -0400
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Robert Love <rml@ximian.com>, Andrea Arcangeli <andrea@novell.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040914192104.GB9106@holomorphy.com>
References: <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au>
	 <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au>
	 <20040914140905.GM4180@dualathlon.random> <41470021.1030205@yahoo.com.au>
	 <20040914150316.GN4180@dualathlon.random>
	 <1095185103.23385.1.camel@betsy.boston.ximian.com>
	 <20040914185212.GY9106@holomorphy.com>
	 <1095188569.23385.11.camel@betsy.boston.ximian.com>
	 <20040914192104.GB9106@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095189593.16988.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 14 Sep 2004 20:19:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-14 at 20:21, William Lee Irwin III wrote:
> The "safely call schedule() while holding it" needs quite a bit of
> qualification; it's implicitly dropped during voluntary context
> switches and reacquired when rescheduled, but it's not valid to force
> such a task into an involuntary context switch and calling schedule()
> implies dropping the lock, so it has to be done at the proper times.
> This is a complex semantic that likely trips up numerous callers (as
> well as attempts to explain it, though surely you know these things,
> and merely wanted a shorter line for the bullet point).

The problem is people think of the BKL as a lock. It isn't a lock it has
never been a lock and it's all DaveM's fault 8) for naming it that when
he moved my asm entry point stuff into C.

The BKL turns on old style unix non-pre-emptive sematics between all
code that is within lock_kernel sections, that is it. That also makes it
hard to clean up because lock_kernel is delimiting code properties (its
essentially almost a function attribute) and spin_lock/down/up and
friends are real locks and lock data.

I've seen very few cases where there is a magic transform from one to
the other because of this. So if you want to kill the BKL add proper
locking to data structures covered by BKL users until the lock_kernel
simply does nothing.

> or sweeps others care to devolve to me, so I'll largely be using
> whatever tactic whoever cares to drive all this (probably Alan) prefers.

Fix the data structure locking starting at the lowest level is how I've
always tackled these messes. When the low level locking is right the
rest just works (usually 8)).

	"Lock data not code"

Alan

