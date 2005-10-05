Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030369AbVJEUYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030369AbVJEUYq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 16:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030370AbVJEUYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 16:24:46 -0400
Received: from lirs02.phys.au.dk ([130.225.28.43]:682 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S1030369AbVJEUYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 16:24:45 -0400
Date: Wed, 5 Oct 2005 22:24:16 +0200 (METDST)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>, Todd.Kneisel@bull.com,
       Felix Oxley <lkml@oxley.org>
Subject: Re: 2.6.14-rc3-rt2
In-Reply-To: <20051004084405.GA24296@elte.hu>
Message-Id: <Pine.OSF.4.05.10510042303580.23734-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Oct 2005, Ingo Molnar wrote:

> 
> i have released the 2.6.14-rc3-rt2 tree, which can be downloaded from 
> the usual place:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 
> the biggest change in this release is the long-anticipated merge of a 
> streamlined version of the "robust futexes/mutexes with priority 
> queueing and priority inheritance" code into the -rt tree. The original 
> upstream patch is from Todd Kneisel, with further improvements, cleanups 
> and -RT integration done by David Singleton.
> 
> robustness is handled by extending the futex framework with 
> registering/unregistering ops and extended wait/wake ops. Priority 
> queueing and inheritance is implemented by embedding the rt_mutex object 
> into the robust-futex structure. This approach made the patches 
> significantly simpler and smaller (but still not trivial at all) than 
> e.g. the fusyn patchset was.
> 

This is great! Priority inheritance in user-space!
I try to follow this development a little when I get time. You might
already have addresses this on the list, but let me raise these two "buts"
anyway:
1) The rt_mutex can promote mutex-deadlocks to raw_spinlock deadlocks
according to the comment in the top of rt.c). Doesn't that mean that a
user-space mutex deadlock can become a raw_spinlock deadlock?
2) The PI traversal for nested interrupts is done with interrupts
disabled. I.e. you can increase the overall system latency by an arbitrary 
amount of time by constructing a code with deep enough lock-nesting.

A year ago, roughly, I worked on PI-mutex for the -RT branch. I didn't
finish  it fast enough for Ingo not to do his own. It was based on some of
the first principles as Ingo's. One of the ideas (which wasn't included in
the patch I send to the list) was to do the PI traversal in steps while
unlocking all the held spinlocks before going to the next depth in the
chain. I used get_task_struct() and put_task_struct() to make sure the
next task in the  traversal didn't get deleted during the periods where no
locks where held.
I'll try to cook something up based on this idea, but to be honest I don't
have any time for it :-(

Esben

