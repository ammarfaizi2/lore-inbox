Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbTHLJhZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 05:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263990AbTHLJhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 05:37:25 -0400
Received: from dyn-ctb-210-9-241-99.webone.com.au ([210.9.241.99]:47627 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S263319AbTHLJhX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 05:37:23 -0400
Message-ID: <3F38B53C.6080507@cyberone.com.au>
Date: Tue, 12 Aug 2003 19:37:00 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: rob@landley.net, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O13int for interactivity
References: <5.2.1.1.2.20030812075224.01988de8@pop.gmx.net> <200308110248.09399.rob@landley.net> <200308050207.18096.kernel@kolivas.org> <200308052022.01377.kernel@kolivas.org> <3F2F87DA.7040103@cyberone.com.au> <200308110248.09399.rob@landley.net> <5.2.1.1.2.20030812075224.01988de8@pop.gmx.net> <5.2.1.1.2.20030812105738.019ca6e8@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20030812105738.019ca6e8@pop.gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Galbraith wrote:

> At 05:07 PM 8/12/2003 +1000, Nick Piggin wrote:
>
>
>> Mike Galbraith wrote:
>>

snip

>>>
>>> Ah, but there is something there.  Take the X and xmms's gl thread 
>>> thingy I posted a while back.  (X runs long enough to expire in the 
>>> presence of a couple of low priority cpu hogs.  gl thread, which is 
>>> a mondo cpu hog, and normally runs and runs and runs at cpu hog 
>>> priority, suddenly acquires extreme interactive priority, and X, 
>>> which is normally sleepy suddenly becomes permanently runnable at 
>>> cpu hog priority)  The gl thread starts sleeping because X isn't 
>>> getting enough cpu to be able to get it's work done and go to 
>>> sleep.  The gl thread isn't voluntarily sleeping, and X isn't 
>>> voluntarily running.
>>> The behavior change is forced upon both.
>>
>>
>>
>> It does... It is I tell ya!
>>
>> Look, the gl thread is probably _very_ explicitly asking to sleep. No I
>> don't know how X works, but I have an idea that select is generally used
>> as an event notification, right?
>
>
> Oh, sure, it blocks because it asks for it... but not because it 
> _wants_ to :)  It wants to create work for X fast enough to make a 
> nice stutter free bit of eye-candy.


Well if it doesn't want to, it could just give select a timeout of 0 though.

>
>> Now the gl thread is essentially saying "wait until X finishes the work
>> I've given it, or I get some other event": ie. "put me to sleep until
>> this fd becomes readable".
>
>
> Yes.  Voluntary or involuntary is just a matter of point of view.


Well I would think a NULL, or non-zero timeout would mean its a voluntary
sleep. If the thread has nothing to do until there is an event on the fd,
then it really does want to sleep.

Anyway, this whole thread arose because Con was making the scheduler do
different things for interruptible and uninterruptible sleeps which I
didn't think was a very good idea. Con thought uninterruptible implied
involuntary sleep (though there might have been some confusion).

I don't think they should be treated any differently, but hey I'm not
making any code or having any problems! Just trying to stir the pot a
bit!

>
>> OK maybe your scenario is a big problem. Its not due to any imagined
>> semantics in the way things are sleeping. Its due to the scheduler.
>
>
> It's due to the scheduler to a point... only in that it doesn't 
> recognize the problem and correct it (that might be pretty hard to 
> do).  If my hardware were fast enough that X could get the work done 
> in the allotted time, the problem wouldn't arise in the first place.  
> I bet it's fairly hard to reproduce on a really fast box.  It happens 
> easily on my box because the combination of X and the gl thread need 
> most of what my hardware has to offer.
>

I think backboost was very nice. I'd say Con could probably get a lot
further if that was in but its not going to happen now.


