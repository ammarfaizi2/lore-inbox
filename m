Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266531AbUGKJbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266531AbUGKJbV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 05:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266533AbUGKJbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 05:31:21 -0400
Received: from mx2.elte.hu ([157.181.151.9]:3768 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S266531AbUGKJbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 05:31:03 -0400
Date: Sun, 11 Jul 2004 11:32:09 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com,
       linux-audio-dev@music.columbia.edu
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040711093209.GA17095@elte.hu>
References: <20040709182638.GA11310@elte.hu> <20040710222510.0593f4a4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040710222510.0593f4a4.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=0, required 5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Minor point:  this:
> 
> 	cond_resched();
> 	function_which_might_sleep();
> 
> is less efficient than
> 
> 	function_which_might_sleep();
> 	cond_resched();
> 
> because if function_which_might_sleep() _does_ sleep, need_resched()
> will likely be false when we hit cond_resched(), thus saving a context
> switch.  Unfortunately, might_sleep() calls tend to go at the entry to
> functions, whereas cond_resched() calls should be neat the exit point,
> or inside loop bodies.

agreed, but the argument goes both ways. Whether entry or exit
scheduling is better very much depends on the function.

E.g. for user copy type of stuff we often want to do the reschedule
_first_, to not pollute the cache with hot (dirty) cachelines that
likely get thrown away - and which have to be brought back again later
on.

For IO type of functions that will sleep we most likely want to preempt
at the exit of the function.

but we'd like to profile the typical preemption points (hence the
profile=sched profiling change) to determine which are the hottest
functions. For those handful of functions we can do __might_sleep() at
the front of the function and a cond_resched() at the back. For all the
other 200 might_sleep() points it doesnt matter much.

i've also added the nr_preempt counter so that we can see the proportion
of forced preemption vs. intentional reschedules for various workloads.

	Ingo
