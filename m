Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264197AbTDPBwR (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 21:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264196AbTDPBwQ 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 21:52:16 -0400
Received: from anumail3.anu.edu.au ([150.203.2.43]:2961 "EHLO anu.edu.au")
	by vger.kernel.org with ESMTP id S264195AbTDPBwL 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 21:52:11 -0400
Message-ID: <3E9CB8EA.6060403@cyberone.com.au>
Date: Wed, 16 Apr 2003 11:59:06 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.2.1) Gecko/20021217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-raid <linux-raid@vger.kernel.org>
Subject: Re: Benefits from computing physical IDE disk geometry?
References: <200304151436_MC3-1-3487-215F@compuserve.com> <3E9CAED5.7000000@cyberone.com.au>
In-Reply-To: <3E9CAED5.7000000@cyberone.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Sender-Domain: cyberone.com.au
X-Spam-Score: (-3)
X-Spam-Tests: EMAIL_ATTRIBUTION,FROM_AND_TO_SAME_2,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,SPAM_PHRASE_02_03,USER_AGENT,USER_AGENT_MOZILLA_UA,X_ACCEPT_LANG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Chuck Ebbert wrote:
>
>> Nick Piggin wrote:
>>
>>
>>
>>> OK right. As far as I can see, the algorithm in the RAID1 code
>>> is used to select the best drive to read from? If that is the
>>> case then I don't think it could make better decisions given
>>> more knowledge.
>>>
>>
>>
>>  How about if it just asks the elevator whether or not a given read
>> is a good fit with its current workload?  I saw in 2.5 where the balance
>> code is looking at the number of pending requests and if it's zero then
>> it sends it to that device.  Somehow I think something better than
>> that could be done, anyway.
>>
> That balance code is probably the IDE or SCSI channel balancing?
> In that case, the driver simply wants to know which device it
> should service next, which is an appropriate fit (is that what
> you were talking about? I don't have source here sorry)
>
>
> We could ask the elevator if a given read is a good fit. It
> would probably help.
>
>>
>>
>>
>>> It seems to me that a better way to layer it would be to have
>>> the complex (ie deadline/AS/CFQ/etc) scheduler handling all
>>> requests into the raid block device, then having a raid
>>> scheduler distributing to the disks, and having the disks
>>> run no scheduler (fifo).
>>>
>>
>>
>> That only works if RAID1 is working at the physical disk level (which
>> it should be AFAIC but people want flexibility to mirror partitions.)
>>
> How so? Basically you want your high level scheduler to run first.
> You want it to act on the stream of requests from the system, not
> on the stream of requests to the device. If you know what I mean.
>
> I might be wrong here. I haven't done any testing, and only a
> little bit of thinking.
>
>>
>>
>>
>>> In practice the current scheme probably works OK, though I
>>> wouldn't know due to lack of resources here :P
>>>
>>
>>
>> I've been playing with the 2.4 read balance code and have some
>> improvements, but real gains need a new approach.
>>
> The problem I see, is the higher level schedulers (deadline for
> example, as opposed to the RAID scheduler) will find it difficult
> to tell if a request will be "good" for them or not. For example
> we have 2 devices, 100 requests in each scheduler queue.
>
> Device A's head is at sector x and next request is at x+100,
> Device B's head is at sector x+10 and next request is at x+200.
>
> RAID wants to know which queue should take a request at sector
> x+1000. What do you do?
>
> The way you would do a good "goodness" function, I guess,
> would be to search through all requests on the device, and return
> the minimum distance from the request you are running the query
> on. Do this for both queues, and insert the request into the
> queue with the smallest delta. I don't see much else doing any
> good. 

Well no I'm an idiot. You obviously don't have to "search
through all requests" as they are (for AS, DL, CFQ) in an
rbtree. So that might not be too bad an idea to investigate.
But...
It still means you get the high level scheduling below where
you want it. This means the read/write batches for each queue
will not stay in sync (not sure if this is a bad thing), request
deadlines will mean even the good "goodness" calculation
does not always be good, process fairness could be badly
impacted for some loads, and AS has other problems
(hopefully not too bad).


