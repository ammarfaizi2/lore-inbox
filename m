Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbTIBLJf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 07:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbTIBLJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 07:09:35 -0400
Received: from dyn-ctb-203-221-73-133.webone.com.au ([203.221.73.133]:59398
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S261197AbTIBLJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 07:09:32 -0400
Message-ID: <3F547A4B.7060309@cyberone.com.au>
Date: Tue, 02 Sep 2003 21:08:59 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Ian Kumlien <pomac@vapor.com>
CC: Con Kolivas <kernel@kolivas.org>, Daniel Phillips <phillips@arcor.de>,
       linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
Subject: Re: [SHED] Questions.
References: <1062324435.9959.56.camel@big.pomac.com>	 <200309011707.20135.phillips@arcor.de>	 <1062457396.9959.243.camel@big.pomac.com>	 <200309021023.24763.kernel@kolivas.org> <1062498307.5171.267.camel@big.pomac.com>
In-Reply-To: <1062498307.5171.267.camel@big.pomac.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ian Kumlien wrote:

>On Tue, 2003-09-02 at 02:23, Con Kolivas wrote:
>
>>On Tue, 2 Sep 2003 09:03, Ian Kumlien wrote:
>>
>>>On Mon, 2003-09-01 at 17:07, Daniel Phillips wrote:
>>>
>>>>IMHO, this minor change will provide a more solid, predictable base for
>>>>Con and Nick's dynamic priority and dynamic timeslice experiments.
>>>>
>>>Most definitely.
>>>
>>No, the correct answer is maybe... if after it's redesigned and put through 
>>lots of testing to ensure it doesn't create other regressions. I'm not saying 
>>it isn't correct, just that it's a major architectural change you're 
>>promoting. Now isn't the time for that.
>>
>>Why not just wait till 2.6.10 and plop in a new scheduler a'la dropping in a 
>>new vm into 2.4.10... <sigh> 
>>
>
>Wouldn't a new scheduler be easier to test? And your patches changes
>it's behavior quite a lot. Wouldn't they require the same testing?
>(And Nicks for that mater, who changes more)
>

Well a new scheduler needs the same testing as an old scheduler.
The difference is less of it has been done.

>
>>The cpu scheduler simply isn't broken as the people on this mailing list seem 
>>to think it is. While my tweaks _look_ large, they're really just tweaking 
>>the way the numbers feed back into a basically unchanged design. All the 
>>incremental changes have been modifying the same small sections of sched.c 
>>over and over again. Nick's changes change the size of timeslices and the 
>>priority variation in a much more fundamental way but still use the basic 
>>architecture of the scheduler. 
>>
>
>But, can't this scheduler suffer from starvation? If the run queue is
>long enough? Either via that deadline or via processes not running...
>
>Wouldn't a starved process boost ensure that even hogs on a loaded
>system got their share now and then?
>
>You could say that the problem the current scheduler has is that it's
>not allowed to starve anything, thats why we add stuff to give
>interactive bonus. But if it *was* allowed to starve but gave bonus to
>the starved processes that would make most of the interactive detection
>useless (yes, we still need the "didn't use their timeslice" bit and
>with a timeslice that gets smaller the higher the pri we'd automagically
>balance most processes).
>
>(As usual my assumptions might be really wrong...)
>

First off, no general purpose scheduler should allow starvation depending
on your definition. The interactivity stuff, and even dynamic priorities
allow short term unfairness.

A cpu hog is not a starved process. It becomes a CPU hog because it is
running all the time. True, it mustn't be starved indefinitely by a lot
of higher priority processes. This is something Con's and my schedulers
both ensure.

Hmm... what else? The "didn't use their timeslice" thing is not
applicable: a new timeslice doesn't get handed out until the previous one
is used. The priorities thing is done based on how much sleeping the
process does.

Its funny, everyone seems to have very similar ideas that they are
expressing by describing different implementations they have in mind.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


Ian Kumlien wrote:

>On Tue, 2003-09-02 at 02:23, Con Kolivas wrote:
>
>>On Tue, 2 Sep 2003 09:03, Ian Kumlien wrote:
>>
>>>On Mon, 2003-09-01 at 17:07, Daniel Phillips wrote:
>>>
>>>>IMHO, this minor change will provide a more solid, predictable base for
>>>>Con and Nick's dynamic priority and dynamic timeslice experiments.
>>>>
>>>Most definitely.
>>>
>>No, the correct answer is maybe... if after it's redesigned and put through 
>>lots of testing to ensure it doesn't create other regressions. I'm not saying 
>>it isn't correct, just that it's a major architectural change you're 
>>promoting. Now isn't the time for that.
>>
>>Why not just wait till 2.6.10 and plop in a new scheduler a'la dropping in a 
>>new vm into 2.4.10... <sigh> 
>>
>
>Wouldn't a new scheduler be easier to test? And your patches changes
>it's behavior quite a lot. Wouldn't they require the same testing?
>(And Nicks for that mater, who changes more)
>

Well a new scheduler needs the same testing as an old scheduler.
The difference is less of it has been done.

>
>>The cpu scheduler simply isn't broken as the people on this mailing list seem 
>>to think it is. While my tweaks _look_ large, they're really just tweaking 
>>the way the numbers feed back into a basically unchanged design. All the 
>>incremental changes have been modifying the same small sections of sched.c 
>>over and over again. Nick's changes change the size of timeslices and the 
>>priority variation in a much more fundamental way but still use the basic 
>>architecture of the scheduler. 
>>
>
>But, can't this scheduler suffer from starvation? If the run queue is
>long enough? Either via that deadline or via processes not running...
>
>Wouldn't a starved process boost ensure that even hogs on a loaded
>system got their share now and then?
>
>You could say that the problem the current scheduler has is that it's
>not allowed to starve anything, thats why we add stuff to give
>interactive bonus. But if it *was* allowed to starve but gave bonus to
>the starved processes that would make most of the interactive detection
>useless (yes, we still need the "didn't use their timeslice" bit and
>with a timeslice that gets smaller the higher the pri we'd automagically
>balance most processes).
>
>(As usual my assumptions might be really wrong...)
>

First off, no general purpose scheduler should allow starvation depending
on your definition. The interactivity stuff, and even dynamic priorities
allow short term unfairness.

A cpu hog is not a starved process. It becomes a CPU hog because it is
running all the time. True, it mustn't be starved indefinitely by a lot
of higher priority processes. This is something Con's and my schedulers
both ensure.

Hmm... what else? The "didn't use their timeslice" thing is not
applicable: a new timeslice doesn't get handed out until the previous one
is used. The priorities thing is done based on how much sleeping the
process does.

Its funny, everyone seems to have very similar ideas that they are
expressing by describing different implementations they have in mind.



