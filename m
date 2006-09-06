Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWIFO0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWIFO0t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 10:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWIFO0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 10:26:49 -0400
Received: from relay03.pair.com ([209.68.5.17]:55564 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1751144AbWIFO0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 10:26:47 -0400
X-pair-Authenticated: 71.197.50.189
Date: Wed, 6 Sep 2006 09:23:56 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
cc: Chase Venters <chase.venters@clientec.com>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Johann Borck <johann.borck@densedata.com>
Subject: Re: [take16 1/4] kevent: Core files.
In-Reply-To: <20060906140330.GA24057@2ka.mipt.ru>
Message-ID: <Pine.LNX.4.64.0609060907560.18512@turbotaz.ourhouse>
References: <1157543723488@2ka.mipt.ru> <Pine.LNX.4.64.0609060824090.18512@turbotaz.ourhouse>
 <20060906140330.GA24057@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Sep 2006, Evgeniy Polyakov wrote:

>>> +
>>> +struct kevent_user
>>> +{
>>
>> These structure names get a little dicey (kevent, kevent_user, ukevent,
>> mukevent)... might there be slightly different names that could be
>> selected to better distinguish the purpose of each?
>
> Like what?
> ukevent means userspace_kevent, but ukevent is much smaller.
> mukevent is mapped userspace kevent, mukevent is again much smaller.
>

Hmm, well, kevent_user and ukevent are perhaps the only ones I'm concerned 
about. What about calling kevent_user a kevent_queue, kevent_fd or 
kevent_set?

>
> I decided to use queue length for mmaped buffer, using size of the
> mmapped buffer as queue length is possible too.
> But in any case it is very broken behaviour to introduce any kind of
> overflow and special marking for that - rt signals already have it, no
> need to create additional headache.
>

Hmm. The concern here is pinned memory, is it not? I'm trying to think of 
the best way to avoid compile-time limits. select() has a rather 
(infamous) compile-time limit of 1,024 thanks to libc (and thanks to the 
bit vector, a glass ceiling). Now, you'd be a fool to use select() on that many
fd's in modern code meant to run on modern UNIXes. But kevent is a new 
system, the grand unified event loop all of us userspace programmers have 
been begging for since many years ago. Glass ceilings tend to hurt when 
you run into them :)

Using the size of the memory mapped buffer as queue length sounds like a 
sane simplification.

>>> +static int kevent_user_ring_init(struct kevent_user *u)
>>> +{
>>> +	int pnum;
>>> +
>>> +	pnum = ALIGN(KEVENT_MAX_EVENTS*sizeof(struct mukevent) +
>>> sizeof(unsigned int), PAGE_SIZE)/PAGE_SIZE;
>>
>> This calculation works with the current constants, but it comes up a page
>> short if, say, KEVENT_MAX_EVENTS were 4095. It also looks incorrect
>> visually since the 'sizeof(unsigned int)' is only factored in once (rather
>> than once per page). I suggest a static / inline __max_kevent_pages()
>> function that either does:
>>
>> return KEVENT_MAX_EVENTS / KEVENTS_ON_PAGE + 1;
>>
>> or
>>
>> int pnum = KEVENT_MAX_EVENTS / KEVENTS_ON_PAGE;
>> if (KEVENT_MAX_EVENTS % KEVENTS_ON_PAGE)
>> 	pnum++;
>> return pnum;
>>
>> Both should be optimized away by the compiler and will give correct
>> answers regardless of the constant values.
>
> Above pnum calculation aligns number of mukevents to pages size with
> appropriate check for (unsigned int), although it is not stated in that
> comment (more clear commant can be found around KEVENTS_ON_PAGE).
> You propose esentially the same calcualtion in the seconds case, while
> first one requires additional page in some cases.
>

You are right about my first suggestion sometimes coming up a page extra. 
What I'm worried about is that the current ALIGN() based calculation comes 
up a page short if KEVENT_MAX_EVENTS is certain values (say 4095). This is 
because the "unsigned int index" is inside kevent_mring for every page, 
though the ALIGN() calculation just factors in room for one of them. In 
these boundary cases (KEVENT_MAX_EVENTS == 4095), your calculation thinks 
it can fit one last mukevent on a page because it didn't factor in room 
for "unsigned int index" at the start of every page; rather just for one 
page. In this case, the modulus should always come up non-zero, giving us 
the extra required page.

>
> It is unused, but I'm still waiting on comments if we need
> kevent_get_events() at all - some people wanted to completely eliminate
> that function in favour of total mmap domination.
>

Interesting idea. It would certainly simplify the interface.

>
> I have no strong opinion on how to behave in this situation.
> kevent can panic, can free cache, can go to infinite loop or screw up
> the hard drive. Everything is (almost) the same.
>

Obviously it's not a huge deal :)

If kevent is to screw up the hard drive, though, we must put in an 
exception for it to avoid my music directory.

>> Looking pretty good. This is my first pass of comments, and I'll probably
>> have questions that follow, but I'm trying to get a really good picture of
>> what is going on here for documentation purposes.
>
> Thank you, Chase.
> I will definitely get your comments into account and change related
> bits.

Thanks again!
Chase
