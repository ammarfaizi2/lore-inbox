Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTLHTIe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 14:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbTLHTIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 14:08:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:64181 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261595AbTLHTId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 14:08:33 -0500
Date: Mon, 8 Dec 2003 11:08:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Volkov <Andrew.Volkov@transas.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: possible proceses leak 
In-Reply-To: <2E74F312D6980D459F3A05492BA40F8D0391B0E9@clue.transas.com>
Message-ID: <Pine.LNX.4.58.0312081106150.13236@home.osdl.org>
References: <2E74F312D6980D459F3A05492BA40F8D0391B0E9@clue.transas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Dec 2003, Andrew Volkov wrote:
>
> In all kernels (up to 2.6-test11) next sequence of code
> in __down/__down_interruptible function
> (arch/i386/kernel/semaphore.c) may cause processes or threads leaking.

Nope. Quite the reverse, in fact. Having the "state" setting above the
wait-queue is usually a good idea, since it means that there are less
races to worry about.

> |-----tsk->state = TASK_UNINTERRUPTIBLE;		<----- BUG:
> |          -- If "do_schedule" from kernel/schedule will calling
> |              at this point, due to expire of time slice,
> |              then current task will removed from run_queue,
> | 		   but doesn't added to any waiting queue, and hence
> |	         will never run again. --

No.

Kernel preemption is special, and it will preempt the process WITHOUT
CHANGING the state of it. See the PREEMPT_ACTIVE test in schedule(). The
process will still be left on the run-queue, and it will be run again,
even if it is marked sleeping.

		Linus
