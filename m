Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVGGKtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVGGKtm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 06:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVGGKtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 06:49:41 -0400
Received: from mx2.elte.hu ([157.181.151.9]:12259 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261169AbVGGKtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 06:49:41 -0400
Date: Thu, 7 Jul 2005 12:48:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Weston <weston@sysex.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
Message-ID: <20050707104859.GD22422@elte.hu>
References: <200506281927.43959.annabellesgarden@yahoo.de> <200506301952.22022.annabellesgarden@yahoo.de> <20050630205029.GB1824@elte.hu> <200507010027.33079.annabellesgarden@yahoo.de> <20050701071850.GA18926@elte.hu> <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org> <20050703140432.GA19074@elte.hu> <20050703181229.GA32741@elte.hu> <Pine.LNX.4.58.0507061802570.20214@echo.lysdexia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507061802570.20214@echo.lysdexia.org>
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


* William Weston <weston@sysex.net> wrote:

> Still looking into this issue on -51-06.  Found something really odd: 
> SCHED_NORMAL tasks will start to inherit the priority value of some 
> other SCHED_FIFO task.  If JACK is started at a given SCHED_FIFO 
> priority, X and all of its children will inherit the same priority 
> value after login.  Other random processes will inherit this, too -- 
> sometimes init...
> 
> SCHED_NORMAL tasks suddenly inheriting priority values in the range 
> normally reserved for SCHED_FIFO could explain at least part of the 
> meltdown I've been seeing.  Any thoughts?

is this inheritance perpetual? It is normal for some tasks to be boosted 
momentarily, but if the condition remains even after jackd has exited, 
it's clearly an anomaly. (lets call it "RT priority leakage".) Priority 
leakage on SMP was fixed recently, but there could be other bugs 
remaining.

There's priority-leakage debugging code in the -RT kernel, which is 
activated if you enable CONFIG_DEBUG_PREEMPT. This debugging code, if 
triggered, should produce 'BUG: comm/123 leaked RT prio 123 (123)?" type 
of messages. But ... due to a bug it would not print out anything but 
would lock up hard if it detects the condition (and if 
RT_DEADLOCK_DETECT is enabled). I have fixed this reporting bug in the 
-51-08 kernel.

	Ingo
