Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262764AbUB0NIy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 08:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262843AbUB0NIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 08:08:54 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:12743 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262764AbUB0NIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 08:08:50 -0500
Date: Fri, 27 Feb 2004 08:08:37 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Vincent Hanquez <tab@snarc.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: about runqueues locking
In-Reply-To: <20040227122311.GA28181@snarc.org>
Message-ID: <Pine.LNX.4.58.0402270749010.17504@montezuma.fsmlabs.com>
References: <20040227122311.GA28181@snarc.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Feb 2004, Vincent Hanquez wrote:

> I've got a code for 2.4 which do:
>
> ================================================================
> spin_lock_irqsave(&runqueue_lock, flags)
> for_each_process(p)
> {
> 	// modify p attributes
> }
> spin_unlock_irqrestore(&runqueue_lock, flags)
> ================================================================
>
> and I need to translate it to 2.6.
> What is exactly the best solution since runqueues are per cpu now ?

runqueue locking is done in ascending order when you want to lock multiple
runqueues, i.e. you have to lock cpu_rq(0) before cpu_rq(1). There are
functions to aid in doing double lock acquisitions, namely
double_rq_lock() which does all the work for you.

> or if not, is tasklist_lock can be use to lock all runqueues at once ?

If you're going to be walking the task list and modifying then you just
need to write_lock the tasklist_lock. Some operations may require you to
lock the task's runqueue, in which case the runqueue lock must be done
within the tasklist_lock.

> and one another question, what is the difference between
> local_irq_disable() and local_irq_save() ?
> irq_save push eflags register on the stack, but why for ?

local_irq_save() is for when you don't know the interrupt enable status
and would like to restore it upon exit of the given per cpu critical
section. local_irq_disable() is normally paired with a local_irq_enable() so it
unconditionally enables interrupts, something you may not always want to
do. If unsure, local_irq_save() is always the safe bet. You may also find
the following of interest;

http://www.kernel.org/pub/linux/kernel/people/rusty/kernel-locking/
