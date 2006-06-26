Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWFZN1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWFZN1R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 09:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWFZN1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 09:27:17 -0400
Received: from omta03sl.mx.bigpond.com ([144.140.92.155]:64077 "EHLO
	omta03sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932331AbWFZN1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 09:27:16 -0400
Message-ID: <449FE0B1.3020808@bigpond.net.au>
Date: Mon, 26 Jun 2006 23:27:13 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "John T. Kohl" <jtk@us.ibm.com>
CC: matthltc@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       LSE-Tech <lse-tech@lists.sourceforge.net>, sekharan@us.ibm.com,
       Alan Stern <stern@rowland.harvard.edu>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [PATCH] Per-task watchers: Enable inheritance
References: <1150879635.21787.964.camel@stark>	<6c4pybmv19.fsf@sumu.lexma.ibm.com>	<1151105584.21787.1571.camel@stark> <6clkrk3w84.fsf@sumu.lexma.ibm.com>
In-Reply-To: <6clkrk3w84.fsf@sumu.lexma.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 26 Jun 2006 13:27:13 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John T. Kohl wrote:
>>>>>> "Matt" ==   <matthltc@us.ibm.com> writes:
> 
> Matt> On Fri, 2006-06-23 at 17:17 -0400, John T. Kohl wrote:
>>>>>>>> "MattH" ==   <matthltc@us.ibm.com> writes:
> MattH> This allows per-task watchers to implement inheritance of the
> MattH> same function and/or data in response to the initialization of
> MattH> new tasks. A watcher might implement inheritance using the
> MattH> following notifier_call snippet:
>>> I think this would meet our needs--we (MVFS) need to initialize some new
>>> state in a child process based on our state in the parent process
>>> (essentially, module-private inherited per-process state).  It may still
>>> be a bit clumsy to find the per-process state in other situations,
>>> though.  While a process is executing our module's code, would it be
>>> safe to traverse current's notifier chain to find our state?
> 
> Matt> 	Hmm. We may need to be careful with terminology here. Keep in mind that
> Matt> a task is not the same as the userspace concept of a  "process".
> 
> Right, sorry, I was imprecise in my wording.  What MVFS wants is per-task
> private state and state inheritance on task forks.
> 
> Matt> 	When a task is executing a module's code it will be safe to traverse
> Matt> the task's notifier chain to find state. It will *not* be safe to
> Matt> traverse the notifier chain of other tasks -- even if the other task is
> Matt> a thread in the same "process".
> 
> I'm curious to see Peter's prototype code (mentioned in his reply).

It will be delayed as it's gone down my priority list.

>  I
> worry that to get safe access to the parent task's private state during
> fork, we'll need something like a private hash table for our private
> per-task state.  Ideally we'd like to just be able to find stuff hanging
> off the task structure directly.
> 

No, that shouldn't be necessary.  Just use a container_of() wrapper 
model.  During fork() you're in the parent tasks context so should be 
able to access its state through "current".  Fork() is busily copying 
lots of the parent's state into the child so what you want to do should 
be no different.  If you've been using the wrapper idea, the notifier 
block that's passed into the call back code should give access to your 
data for the parent.

If you like I could give you some code snippets to show what I mean.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
