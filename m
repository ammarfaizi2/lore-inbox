Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbTLCXM4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 18:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbTLCXM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 18:12:56 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:49404 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262324AbTLCXMv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 18:12:51 -0500
Message-ID: <3FCE6DEC.1010207@mvista.com>
Date: Wed, 03 Dec 2003 15:12:44 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Peterson <chris@potamus.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: question about preempt_disable()
References: <000d01c3b6dd$30ab34a0$8a04a943@bananacabana>
In-Reply-To: <000d01c3b6dd$30ab34a0$8a04a943@bananacabana>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Peterson wrote:
> I just bought Robert Love's new book "Linux Kernel Development". The book
> has been very informative, but I have some unanswered questions about kernel
> preemption.
> 
>>From what I understand, SMP-safe code is also preempt-safe. The preempt
> count is the number of spinlocks held by the current kernel thread. If the
> preempt code is greater zero, then the kernel thread cannot be preempted.
> 
> My question is: if the code is already SMP-safe and holding the necessary
> spinlocks, why is the preempt count necessary? Why must preemption be
> disabled and re-enabled as spinlocks are acquired and released? Is it just
> an optimization for accessing per-cpu data? Or is it necessary to prevent
> priority inversion of kernel threads, when a low priority thread holds
> spinlock X and is preempted by a high priority thread that hogs the CPU,
> forever spinning in spin_lock(&X)?

There are a couple of things here.  First, the preempt count includes other 
reasons not to preempt.  One of these is used when working with per-cpu data and 
a cpu switch would NOT be good (a pointer would point to the wrong cpu's data). 
  Also, at one time, the bh-lock was also cause to bump the preempt count.  In 
2.6, I think that is no longer true, BUT, the bh-count is in the same word. 
This is important as we want to test just one thing at interrupt return time to 
see if it is ok to preempt.  (Well, we actually have to test the need_resched 
flag too...)  From the interrupt codes point of view, the fact that the current 
task holds one or more spin locks is ONLY visible via the preempt count.  Thus 
the count collects all these things in one, easy to check, place.  This allows 
us to keep the interrupt path as fast as possible.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

