Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVDDGjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVDDGjy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 02:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVDDGjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 02:39:25 -0400
Received: from mx1.elte.hu ([157.181.1.137]:10924 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261561AbVDDGjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 02:39:20 -0400
Date: Mon, 4 Apr 2005 08:39:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: Paul Jackson <pj@engr.sgi.com>, torvalds@osdl.org, nickpiggin@yahoo.com.au,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tune migration costs [was: Re: Industry db benchmark result on recent 2.6 kernels]
Message-ID: <20050404063910.GA23094@elte.hu>
References: <20050403142959.GB22798@elte.hu> <200504040131.j341Vlg31981@unix-os.sc.intel.com> <20050404062414.GA22664@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050404062414.GA22664@elte.hu>
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

> > a numa scheduler domain at the top level and cache_hot_time will be 
> > set to 0 in that case on smp box.  Though this will be a mutt point 
> > with recent patch from Suresh Siddha for removing the extra bogus 
> > scheduler domains.  
> > http://marc.theaimsgroup.com/?t=111240208000001&r=1&w=2
> 
> at first sight the dummy domain should not be a problem, [...]

at second sight, maybe it could be a problem after all. It's safe is 
load_balance(), where task_hot() should never happen to be called for 
the dummy domain. (because the dummy domain has only one CPU group on 
such boxes)

But if the dummy domain has SD_WAKE_AFFINE set then it's being 
considered for passive migration, and a value of 0 means 'can always 
migrate', and in situations where other domains signalled 'task is too 
hot', this domain may still override the decision (incorrectly). So the 
safe value for dummy domains would a cacheflush time of 'infinity' - to 
make sure migration decisions are only done via other domains.

I've changed this in my tree - migration_cost[] is now initialized to 
-1LL, which should solve this problem.

	Ingo
