Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264591AbUATAvj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265398AbUATAt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:49:59 -0500
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:26365 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S265370AbUATArw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:47:52 -0500
From: Rusty Russell <rusty@au1.ibm.com>
To: dipankar@in.ibm.com
Cc: paul.mckenney@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] RCU for low latency [2/2] 
In-reply-to: Your message of "Thu, 15 Jan 2004 11:33:21 +0530."
             <20040115060320.GA3985@in.ibm.com> 
Date: Tue, 20 Jan 2004 10:25:04 +1100
Message-Id: <20040120004745.2C58617DD8@ozlabs.au.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040115060320.GA3985@in.ibm.com> you write:
> On Thu, Jan 15, 2004 at 10:35:00AM +1100, Rusty Russell wrote:
> > On Wed, 14 Jan 2004 13:54:20 +0530
> > Dipankar Sarma <dipankar@in.ibm.com> wrote:
> > > Done, except that once we reach the callback limit, we need to check
> > > for RT tasks after every callback, instead of at the start of the RCU batch.
> > 
> > AFAICT, if you're in a softirq it can't change.  If you're not, there's
> > no limit anyway.
> 
> What if a blocked RT task was woken up by an irq that interrupted
> RCU callback processing ? All of a sudden you now have a RT task
> in the queue. Isn't this possible ?

Yes, you're absolutely right.  You could just handle this by breaking
out of the loop (after processing one rcu) as soon as there's a
runnable rt task, independent of limit.

> > But ulterior motive is to push the kthread primitives by making as much
> > code depend on it as possible 8)
> 
> hehe. How nefarious :-)

Well, you don't get to be a kernel hacker simply by looking good in
Speedos.

> > I'm trying to catch them as new ones get introduced.  If the name is
> > old-style, then there's little point changing (at least for 2.6).
> 
> OK, but I am not sure how to do this for non-module code.

module_param() works for non-module code (it automatically inserts a
"rcu." prefix in the name though).

> > You can screw your machine up with RT tasks, yes.  This is no new problem,
> > I think.
> 
> That is another way to look at it :)

I think it's fair, though.  If you really absorb all your CPU with RT
tasks, you will starve important things: that's why RT is a root priv.

> > > should we compile out krcuds
> > > based on a config option (CONFIG_PREEMPT?). Any suggestions ?
> > 
> > Depends on the neatness of the code, I think...
> 
> Well there seems to be a difference in opinion about whether the
> krcuds should be pervasive or not. Some think they should be,
> some thinks they should not be when we aren't aiming for low
> latency (say CONFIG_PREEMPT=n).

Personally I don't like overloading the semantic of CONFIG_PREEMPT.
But I think CONFIG_PREEMPT is a bad idea anyway: it's not really a
question you can ask a user during config.

CONFIG_LOW_LATENCY (Description: Sacrifice some raw performance to
increase latency) makes more sense, and would fit here, too.

Another option is to overload ksoftirq to do what krcud does: they're
v. similar in nature AFAICT.

Sorry I can't be more helpful 8)
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
