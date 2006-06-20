Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWFTU0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWFTU0r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWFTU0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:26:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:44314 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750930AbWFTU0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:26:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=oRoMlMWY8nDYQMoM5q6smOxAGt+wC1JN+hekP119UmxfZMKf3gJjNVZwVVkOaisifUcFFmofCnT9BrOGwa81LGrnqhcD3gdJRIeGW8p+IUNIJU9+Ac4c9HOPFU5ZIcx23EN/COZmwhtucC2X9kkte+2tv8GTFmK9uEig7B3SImQ=
Date: Tue, 20 Jun 2006 22:26:55 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Thomas Gleixner <tglx@linutronix.de>
cc: Esben Nielsen <nielsen.esben@googlemail.com>,
       Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
In-Reply-To: <1150824092.6780.255.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0606202217160.11643@localhost.localdomain>
References: <20060618070641.GA6759@elte.hu>  <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
  <1150816429.6780.222.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain> 
 <Pine.LNX.4.58.0606201229310.729@gandalf.stny.rr.com> 
 <Pine.LNX.4.64.0606201903030.11643@localhost.localdomain>
 <1150824092.6780.255.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006, Thomas Gleixner wrote:

> On Tue, 2006-06-20 at 19:12 +0100, Esben Nielsen wrote:
>>>
>>>>
>>>> Another complicated design would be to make a task for each priority.
>>>> Then the interrupt wakes the highest priority one, which handles the first
>>>> callback and awakes the next one etc.
>>>
>>> Don't think that is necessary.
>>
>> Me neither :-) Running sofhtirq-hrt at priority 99 - or whatever is
>> set by chrt - should be sufficient.
>
> It is not, that was the reason, why we implemted it. You get arbitrary
> latencies caused by timer storms.
>

What you are saying is that there is a lot of timers timing out at the 
same time. When that happens you will get them all executed at priority 
99 with the simple setup. In the current design you get them executed in 
order of priority and the task lowers it's priority as it goes along.
If you have a long list of low priority callbacks pending to be executed 
the running one will finish at priority 99 and then the high priority one 
will be put in as the list on the list.

Ok, I see your point: Although you can't preempt the individual callbacks 
you can preempt the loop, which helps on latencies as many timers can 
timeout before they are executed.

> I have to check, whether the priority is propagated when the softirq is
> blocked on a lock. If not its a bug and has to be fixed.

I think the simplest solution would be to add

         if (p->blocked_on)
                 wake_up_process(p);

in __setscheduler().

>
> 	tglx
>
>
