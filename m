Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbUAOGCt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 01:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbUAOGCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 01:02:49 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:31159 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261965AbUAOGCr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 01:02:47 -0500
Date: Thu, 15 Jan 2004 11:33:21 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Rusty Russell <rusty@au1.ibm.com>
Cc: paul.mckenney@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] RCU for low latency [2/2]
Message-ID: <20040115060320.GA3985@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040108115051.GC5128@in.ibm.com> <20040109000244.8C58D17DDE@ozlabs.au.ibm.com> <20040114082420.GA3755@in.ibm.com> <20040115103500.28f9e1bf.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040115103500.28f9e1bf.rusty@rustcorp.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 10:35:00AM +1100, Rusty Russell wrote:
> On Wed, 14 Jan 2004 13:54:20 +0530
> Dipankar Sarma <dipankar@in.ibm.com> wrote:
> > Done, except that once we reach the callback limit, we need to check
> > for RT tasks after every callback, instead of at the start of the RCU batch.
> 
> AFAICT, if you're in a softirq it can't change.  If you're not, there's
> no limit anyway.

What if a blocked RT task was woken up by an irq that interrupted
RCU callback processing ? All of a sudden you now have a RT task
in the queue. Isn't this possible ?


> > > Ideally you'd create a new workqueue for this, or at the very least
> > > use kthread primitives (once they're in -mm, hopefully soon).
> > 
> > I will use kthread primitives once they are available in mainline.
> 
> But ulterior motive is to push the kthread primitives by making as much
> code depend on it as possible 8)

hehe. How nefarious :-)

> > I will clean this up later should we come to a conclusion that
> > we need the low-latency changes in mainline. I don't see
> > any non-driver kernel code using module_param() though.
> 
> I'm trying to catch them as new ones get introduced.  If the name is
> old-style, then there's little point changing (at least for 2.6).

OK, but I am not sure how to do this for non-module code.

> > New patch below. Needs rq-has-rt-task.patch I mailed earlier.
> > There are more issues that need investigations - can we starve
> > RCU callbacks leading to OOMs
> 
> You can screw your machine up with RT tasks, yes.  This is no new problem,
> I think.

That is another way to look at it :)

> > should we compile out krcuds
> > based on a config option (CONFIG_PREEMPT?). Any suggestions ?
> 
> Depends on the neatness of the code, I think...

Well there seems to be a difference in opinion about whether the
krcuds should be pervasive or not. Some think they should be,
some thinks they should not be when we aren't aiming for low
latency (say CONFIG_PREEMPT=n).

Thanks
Dipankar
