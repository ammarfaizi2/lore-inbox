Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264058AbTEWM4o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 08:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264060AbTEWM4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 08:56:44 -0400
Received: from ns.suse.de ([213.95.15.193]:32009 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264058AbTEWM4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 08:56:43 -0400
Date: Fri, 23 May 2003 15:09:48 +0200
From: Andi Kleen <ak@suse.de>
To: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: race in smp idle task startup
Message-ID: <20030523130948.GA30288@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think it was there before, but I now noticed it:

The 2.5 SMP bootup path does now:

 	idle = fork_by_hand();
 	if (IS_ERR(idle))
	 		panic("failed fork for CPU %d", cpu);
	wake_up_forked_process(idle);

	<----------- process on run queue ---------------->

	/*
	 * We remove it from the pidhash and the runqueue
 	 * once we got the process:
 	 */
 	init_idle(idle,cpu);

But sched_init has been called before and the load balance timers 
are already running. If you have multiple CPUs to start another CPU
could come and balance the idle thread away. Its registers contain
random values from fork_by_hand so it would likely crash.

It probably needs a __wake_up_forked_process that does not actually
put it onto an runqueue. Or did I miss something?

-Andi

