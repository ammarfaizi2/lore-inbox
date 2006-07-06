Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030261AbWGFNOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbWGFNOR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 09:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbWGFNOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 09:14:17 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:30498 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030261AbWGFNOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 09:14:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=fZT54p2Y6w5ECnkYrdOhg392lbfzuiLqH1BK1+Um0KalDXSyoXaFSWp55HLNXG1LpA5XlhT57uWUf1aioFW9i849zRCS0nnmorcn6wsZByveBWTz5ZqKxRniyhyYH3X6tZ8cjNSLtjFf1nj0pGvRr4+Y/qaGyqaMKtX6BZgYkWg=
Date: Thu, 6 Jul 2006 15:11:48 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Thomas Gleixner <tglx@linutronix.de>
cc: Esben Nielsen <nielsen.esben@googlemail.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: New PriorityInheritanceTest - bug in 2.6.17-rt7 confirmed
In-Reply-To: <1152189293.24611.146.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0607061443050.30970@localhost.localdomain>
References: <Pine.LNX.4.64.0607061307260.10454@localhost.localdomain>
 <1152189293.24611.146.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jul 2006, Thomas Gleixner wrote:

> On Thu, 2006-07-06 at 14:07 +0100, Esben Nielsen wrote:
>> So this is a real bug.
>
> True
>
>> In the previous mail I posted a fix for that problem (and other problems).
>
> I had not much time to look at the patch, but I doubt that we need such
> a complex hack to achieve that. I will look at it later.

The problem is that the deboosting code have to run somewhere.
It can run within try_to_wake_up(). But then it the whole lock chain is 
traversed in an atomic section. That unpredictable overall system 
latencies since the locks can be in userspace.
So it has to run in some task. That task has to be high priority enough 
to preempt the boosted tasks, but it can't be so high priority that it bothers
any higher priority threads than those involved in this. So it can't be, 
forinstance a general priority 99 task we just use for this. We thus need 
something running at a slightly higher priority than the priority to 
which the tasks are boosted, but not a full +1 priority. I.e. we need to 
run it at priority "+0.5".

I also think that other stuff, like high resolution timers and others 
doing "scheduler plumbing work" in the kernel could benifit from a +0.5 
priority.

I thought about some improvements:
1) Make a general TSK_LIFO flag, That would remove some of the direct 
references in sched.c to the rtmutex system. In effect it will be the 
same, but be more usefull to other subsystems.
2) Double the number of in-kernel priorities. I.e. simply add a number of 
"hidden" priorities in which this kind of "plumbing" work can be run:

Kernel priority          User space
      0                      hidden
      1                        RT 99
      2                      hidden
      3                        RT 98
....

    199                         0
...

This might turn out more clean than a TSK_LIFO. There will be no need to
hack the core scheduler code, which can have some strange side-effect. 
But to be honest I don't think the hacks I have done are that bad - except
they refer directly to the rtmutex subsystem. Also adding priorities would
slow down the system.


>
> 	tglx
>
>

Esben
