Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262612AbVDAEwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbVDAEwg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 23:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbVDAEwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 23:52:36 -0500
Received: from mx1.elte.hu ([157.181.1.137]:16565 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262612AbVDAEwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 23:52:33 -0500
Date: Fri, 1 Apr 2005 06:52:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Industry db benchmark result on recent 2.6 kernels
Message-ID: <20050401045219.GC22753@elte.hu>
References: <Pine.LNX.4.58.0503311206210.4774@ppc970.osdl.org> <200503312214.j2VMEag23175@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503312214.j2VMEag23175@unix-os.sc.intel.com>
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


* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:

> The low point in 2.6.11 could very well be the change in the 
> scheduler. It does too many load balancing in the wake up path and 
> possibly made a lot of unwise decision.  For example, in 
> try_to_wake_up(), it will try SD_WAKE_AFFINE for task that is not hot.  
> By not hot, it looks at when it was last ran and compare to a constant 
> sd->cache_hot_time.  The problem is this cache_hot_time is fixed for 
> the entire universe, whether it is a little celeron processor with 
> 128KB of cache or a sever class Itanium2 processor with 9MB L3 cache.  
> This one size fit all isn't really working at all.

the current scheduler queue in -mm has some experimental bits as well 
which will reduce the amount of balancing. But we cannot just merge them 
an bloc right now, there's been too much back and forth in recent 
kernels. The safe-to-merge-for-2.6.12 bits are already in -BK.

> We had experimented that parameter earlier and found it was one of the 
> major source of low point in 2.6.8.  I debated the issue on LKML about 
> 4 month ago and finally everyone agreed to make that parameter a boot 
> time param. The change made into bk tree for 2.6.9 release, but 
> somehow it got ripped right out 2 days after it went in.  I suspect 
> 2.6.11 is a replay of 2.6.8 for the regression in the scheduler.  We 
> are running experiment to confirm this theory.

the current defaults for cache_hot_time are 10 msec for NUMA domains, 
and 2.5 msec for SMP domains. Clearly too low for CPUs with 9MB cache.  
Are you increasing cache_hot_time in your experiment? If that solves 
most of the problem that would be an easy thing to fix for 2.6.12.

	Ingo
