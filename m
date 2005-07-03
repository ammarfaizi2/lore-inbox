Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVGCSQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVGCSQL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 14:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVGCSQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 14:16:11 -0400
Received: from mx1.elte.hu ([157.181.1.137]:51370 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261484AbVGCSMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 14:12:45 -0400
Date: Sun, 3 Jul 2005 20:12:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
Message-ID: <20050703181229.GA32741@elte.hu>
References: <200506281927.43959.annabellesgarden@yahoo.de> <200506301952.22022.annabellesgarden@yahoo.de> <20050630205029.GB1824@elte.hu> <200507010027.33079.annabellesgarden@yahoo.de> <20050701071850.GA18926@elte.hu> <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org> <20050703140432.GA19074@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050703140432.GA19074@elte.hu>
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

> > A few things are left working (but not enough to get the system back):
> > 
> > - Mouse pointer (movements are chunky) and window focus.
> > - Mouse scroll wheel can still scroll xterms and switch workspaces.
> > - SysRq-B
> 
> hm, i can reproduce a variant of this, by starting enough 'dd' tasks.  
> (it needed more than two on a 2-way/4-way HT testbox though) Indeed 
> everything seems to be starved, but SysRq still worked so i was able 
> to SysRq-kIll all tasks and thus the system recovered.
> 
> i'm debugging this now.

ok, found a bug that could explain the situation: mutex sleeps+wakeups 
were incorrectly credited as 'interactive sleep' periods, causing the dd 
processes to be boosted incorrectly. The dd processes created a workload 
in which they blocked each other in such a pattern that they got boosted 
periodically, starving pretty much every other task.

the fix is significant and affects alot of workloads, and should further 
improve interactivity in noticeable ways. I'm not 100% sure it solves 
all the starvation problems (e.g. how could normal-prio dd tasks starve 
the SCHED_FIFO irq threads that drove SysRq?), but the results so far 
look promising.

i've uploaded the -50-45 patch, can you under this kernel trigger a 
'meltdown' on your SMT box?

	Ingo
