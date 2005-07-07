Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262376AbVGGB27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262376AbVGGB27 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 21:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVGGB2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 21:28:52 -0400
Received: from unused.mind.net ([69.9.134.98]:54468 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S262376AbVGGB1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 21:27:31 -0400
Date: Wed, 6 Jul 2005 18:26:35 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
In-Reply-To: <20050703181229.GA32741@elte.hu>
Message-ID: <Pine.LNX.4.58.0507061802570.20214@echo.lysdexia.org>
References: <200506281927.43959.annabellesgarden@yahoo.de>
 <200506301952.22022.annabellesgarden@yahoo.de> <20050630205029.GB1824@elte.hu>
 <200507010027.33079.annabellesgarden@yahoo.de> <20050701071850.GA18926@elte.hu>
 <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org> <20050703140432.GA19074@elte.hu>
 <20050703181229.GA32741@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jul 2005, Ingo Molnar wrote:

> ok, found a bug that could explain the situation: mutex sleeps+wakeups 
> were incorrectly credited as 'interactive sleep' periods, causing the dd 
> processes to be boosted incorrectly. The dd processes created a workload 
> in which they blocked each other in such a pattern that they got boosted 
> periodically, starving pretty much every other task.
> 
> the fix is significant and affects alot of workloads, and should further 
> improve interactivity in noticeable ways. I'm not 100% sure it solves 
> all the starvation problems (e.g. how could normal-prio dd tasks starve 
> the SCHED_FIFO irq threads that drove SysRq?), but the results so far 
> look promising.
> 
> i've uploaded the -50-45 patch, can you under this kernel trigger a 
> 'meltdown' on your SMT box?

Still looking into this issue on -51-06.  Found something really odd:  
SCHED_NORMAL tasks will start to inherit the priority value of some other
SCHED_FIFO task.  If JACK is started at a given SCHED_FIFO priority, X and
all of its children will inherit the same priority value after login.  
Other random processes will inherit this, too -- sometimes init...

SCHED_NORMAL tasks suddenly inheriting priority values in the range
normally reserved for SCHED_FIFO could explain at least part of the
meltdown I've been seeing.  Any thoughts?


Cheers,
--ww
