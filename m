Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWFVJct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWFVJct (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 05:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWFVJct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 05:32:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:23425 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932470AbWFVJcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 05:32:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=lLA5sHIaB+tIBtw/8G63Wezhzf3ARq4rLhKkK/Wn/yORbclqhyCcwfhbo6UeKDIGCYUVCxjr+5yYdN/ZJqVbln+sLf5x0JTgwvmUY+OdNacoA0PI1/JwA+ud5Ha9vjMdZYsJNeCY49lY23oDNUQO8xg+91Zv38kVeTB/dF2ZXg8=
Date: Thu, 22 Jun 2006 11:32:59 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Thomas Gleixner <tglx@linutronix.de>
cc: Esben Nielsen <nielsen.esben@googlemail.com>,
       Esben Nielsen <nielsen.esben@gogglemail.com>,
       Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
In-Reply-To: <1150959972.25491.40.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0606221129110.10550@localhost.localdomain>
References: <20060618070641.GA6759@elte.hu>  <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
  <1150816429.6780.222.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain> 
 <Pine.LNX.4.58.0606201229310.729@gandalf.stny.rr.com> 
 <Pine.LNX.4.64.0606201903030.11643@localhost.localdomain> 
 <1150824092.6780.255.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0606202217160.11643@localhost.localdomain> 
 <Pine.LNX.4.58.0606210418160.29673@gandalf.stny.rr.com> 
 <Pine.LNX.4.64.0606211204220.10723@localhost.localdomain> 
 <Pine.LNX.4.64.0606211638560.6572@localhost.localdomain> 
 <1150907165.25491.4.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0606212226291.7939@localhost.localdomain> 
 <1150922007.25491.24.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0606212341410.10077@localhost.localdomain>
 <1150959972.25491.40.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Jun 2006, Thomas Gleixner wrote:

> On Thu, 2006-06-22 at 00:35 +0100, Esben Nielsen wrote:
>> On Wed, 21 Jun 2006, Thomas Gleixner wrote:
>>
>>> On Wed, 2006-06-21 at 22:29 +0100, Esben Nielsen wrote:
>>>>> Find an version against the code in -mm below. Not too much tested yet.
>>>>
>>>> What if setscheduler is called from interrup context as in the hrt timers?
>>>
>>> It simply gets stuff going, nothing else.
>>>
>> What I mean is that we will then do the full priority inheritance boost
>> with interrupts off.
>
> Only in the case when its called from IRQ context.
>
>> Before setscheduler() was O(1), now it is O(<lock depth of what ever lock
>> the target task might be locked on>).
>>
>> This is not a problem for your use of setscheduler() as the task involved
>> only can be blocked on kernel mutexes, but when the function is used on a
>> userspace process the lock depth can be deep.
>
> Damn, I missed that this is still in the irq off section, when called
> from do_sched_setscheduler().
>

There is more to it than that:
What if you for some reason try to set the priority of a low level task 
from a high priority one? It could be that your application have some kind 
of watchdog or manager process dynamically adjusting the priorities of the 
other tasks. You simply don't want to be concerned about those tasks being 
blocked in some strange (maybe even buggy) logging structure. You want to 
do it O(1) and then let those tasks handle it.

> Good catch. I fix that.
>

I know you hate to let the scheduler do the work for you, but I find it 
very elegant and easy once in a while :-)

Esben

> 	tglx
>
>
