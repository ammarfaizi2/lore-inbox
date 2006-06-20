Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWFTWTv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWFTWTv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWFTWTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:19:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:45069 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751286AbWFTWTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:19:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=euvunsrHQWSUZHOshgWJFAJlUHFS/UzK1Q68Hu3OV6wLvKwIkK5fSz/i7zDlQTxqB1sgFjxnkxPIghiufWAusAn4l6TDJAyZcvYC/AS4jyXu8H1e2JUiG2wtSENUEpijTHTz08JlTgBRJVuMJF0dIi6LpK065GhVByhCc7j3fAE=
Date: Wed, 21 Jun 2006 00:19:59 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Thomas Gleixner <tglx@linutronix.de>
cc: Esben Nielsen <nielsen.esben@googlemail.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
In-Reply-To: <1150835732.6780.293.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0606202344240.11643@localhost.localdomain>
References: <20060618070641.GA6759@elte.hu>  <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
  <1150816429.6780.222.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain> 
 <1150821311.6780.240.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0606201914170.11643@localhost.localdomain>
 <1150835732.6780.293.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006, Thomas Gleixner wrote:

> On Tue, 2006-06-20 at 22:16 +0100, Esben Nielsen wrote:
>>> We had this before and it is horrible.
>>
>> "Horrible" in what respect?
>
> Unbound latencies.
>
>>> A nice solution would be to enqueue the timer into the task struct of
>>> the thread which is target of the signal, wake that thread in a special
>>> state which only runs the callback and then does the signal delivery.
>>
>> What if the thread is running?
>
> Well, do it in the return from interrupt path.

Wouldn't it just be the same as interrupt context then?

>
>> Hmm, a practical thing to do would be to make a system where you can post
>> jobs in a thread. These jobs can then be done in thread context
>> around schedule or just before the task returns to user-space.
>
> Thats basically what I said. But you have to take care of asynchronous
> signal delivery. Therefor you need a special state. Also return to
> userspace is not enough. You have to do the check in the return from
> interrupt path, as you might delay async signals otherwise.
>

It doesn't sound very preemptible then.

I was more thinking along the lines of having a "message" where threads 
(and interrupts) can post functions to each other to be executed in 
the target context.

The idea is:
1) You can get a fairly standeard code executeded with a priority 
associated with the target thread.
2) Make sure that only one thread touches some data and that way avoid 
having locks and therefore deadlocks.
3) Simplyfying callbacks. Instead of installing a callback which can be 
executed in some task or interrupt, you can with this system make a 
callback which will be executed in client's context, and thus simplyfying 
the client's headaches with locks.

By "fairly standeard" code I mean code which doesn't block 
except that it should be allowed to use mutexes, which in many ways is not 
real blocking when PI is implemented.

If this should be safe you can't just preemp and execute these functions 
anywhere in a thread. It must be in a well-defined place where no mutexes are 
held. Many (all?) kernel threads have a while() with a central schedule() in
the middle. One can most often call these functions safely at this 
schedule(). For userspace threads it would also be safe to call the functions
when going in and out of userspace. It will probably be safe to call the
functions at any call to schedule() except for the one inside the mutex 
lock operation. The volentary-preemption points Ingo made some years ago 
would probably be ok places, too.

Esben

> 	tglx
>
>
