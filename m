Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266433AbUAODjQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 22:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266434AbUAODjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 22:39:16 -0500
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:3975 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S266433AbUAODjJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 22:39:09 -0500
Date: Thu, 15 Jan 2004 10:35:00 +1100
From: Rusty Russell <rusty@au1.ibm.com>
To: dipankar@in.ibm.com
Cc: rusty@au1.ibm.com, paul.mckenney@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] RCU for low latency [2/2]
Message-Id: <20040115103500.28f9e1bf.rusty@rustcorp.com.au>
In-Reply-To: <20040114082420.GA3755@in.ibm.com>
References: <20040108115051.GC5128@in.ibm.com>
	<20040109000244.8C58D17DDE@ozlabs.au.ibm.com>
	<20040114082420.GA3755@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jan 2004 13:54:20 +0530
Dipankar Sarma <dipankar@in.ibm.com> wrote:
> > static inline unsigned int max_rcu_at_once(int cpu)
> > {
> > 	if (in_softirq() && RCU_krcud(cpu) && rq_has_rt_task(cpu))
> > 		return rcu_max_bh_callbacks;
> > 	return (unsigned int)-1;
> > }
> 
> Done, except that once we reach the callback limit, we need to check
> for RT tasks after every callback, instead of at the start of the RCU batch.

AFAICT, if you're in a softirq it can't change.  If you're not, there's
no limit anyway.

> > Ideally you'd create a new workqueue for this, or at the very least
> > use kthread primitives (once they're in -mm, hopefully soon).
> 
> I will use kthread primitives once they are available in mainline.

But ulterior motive is to push the kthread primitives by making as much
code depend on it as possible 8)

> I will clean this up later should we come to a conclusion that
> we need the low-latency changes in mainline. I don't see
> any non-driver kernel code using module_param() though.

I'm trying to catch them as new ones get introduced.  If the name is
old-style, then there's little point changing (at least for 2.6).

>From now on, I'm being more vigilant 8)

> New patch below. Needs rq-has-rt-task.patch I mailed earlier.
> There are more issues that need investigations - can we starve
> RCU callbacks leading to OOMs

You can screw your machine up with RT tasks, yes.  This is no new problem,
I think.

> should we compile out krcuds
> based on a config option (CONFIG_PREEMPT?). Any suggestions ?

Depends on the neatness of the code, I think...

Cheers,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
