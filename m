Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264185AbTDPBNG (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 21:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264183AbTDPBNF 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 21:13:05 -0400
Received: from anumail3.anu.edu.au ([150.203.2.43]:39040 "EHLO anu.edu.au")
	by vger.kernel.org with ESMTP id S264182AbTDPBNA 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 21:13:00 -0400
Message-ID: <3E9CAED5.7000000@cyberone.com.au>
Date: Wed, 16 Apr 2003 11:16:05 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.2.1) Gecko/20021217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-raid <linux-raid@vger.kernel.org>
Subject: Re: Benefits from computing physical IDE disk geometry?
References: <200304151436_MC3-1-3487-215F@compuserve.com>
In-Reply-To: <200304151436_MC3-1-3487-215F@compuserve.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Sender-Domain: cyberone.com.au
X-Spam-Score: (-4.2)
X-Spam-Tests: EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,SPAM_PHRASE_02_03,USER_AGENT,USER_AGENT_MOZILLA_UA,X_ACCEPT_LANG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:

>Nick Piggin wrote:
>
>
>
>>OK right. As far as I can see, the algorithm in the RAID1 code
>>is used to select the best drive to read from? If that is the
>>case then I don't think it could make better decisions given
>>more knowledge.
>>
>
>
>  How about if it just asks the elevator whether or not a given read
>is a good fit with its current workload?  I saw in 2.5 where the balance
>code is looking at the number of pending requests and if it's zero then
>it sends it to that device.  Somehow I think something better than
>that could be done, anyway.
>
That balance code is probably the IDE or SCSI channel balancing?
In that case, the driver simply wants to know which device it
should service next, which is an appropriate fit (is that what
you were talking about? I don't have source here sorry)


We could ask the elevator if a given read is a good fit. It
would probably help.

>
>
>
>>It seems to me that a better way to layer it would be to have
>>the complex (ie deadline/AS/CFQ/etc) scheduler handling all
>>requests into the raid block device, then having a raid
>>scheduler distributing to the disks, and having the disks
>>run no scheduler (fifo).
>>
>
>
> That only works if RAID1 is working at the physical disk level (which
>it should be AFAIC but people want flexibility to mirror partitions.)
>
How so? Basically you want your high level scheduler to run first.
You want it to act on the stream of requests from the system, not
on the stream of requests to the device. If you know what I mean.

I might be wrong here. I haven't done any testing, and only a
little bit of thinking.

>
>
>
>>In practice the current scheme probably works OK, though I
>>wouldn't know due to lack of resources here :P
>>
>
>
> I've been playing with the 2.4 read balance code and have some
>improvements, but real gains need a new approach.
>
The problem I see, is the higher level schedulers (deadline for
example, as opposed to the RAID scheduler) will find it difficult
to tell if a request will be "good" for them or not. For example
we have 2 devices, 100 requests in each scheduler queue.

Device A's head is at sector x and next request is at x+100,
Device B's head is at sector x+10 and next request is at x+200.

RAID wants to know which queue should take a request at sector
x+1000. What do you do?

The way you would do a good "goodness" function, I guess,
would be to search through all requests on the device, and return
the minimum distance from the request you are running the query
on. Do this for both queues, and insert the request into the
queue with the smallest delta. I don't see much else doing any
good.

On the other hand, if you simply have a fifo after the RAID
scheduler, the RAID scheduler itself knows where each disk's
head will end up simply by tracking the value of the last
sector it has submitted to the device. It also has the advantage
that it doesn't have "high level" scheduling stuff below it
ie. request deadline handling, elevator scheme, etc.

This gives the RAID scheduler more information, without
taking any away from the high level scheduler AFAIKS.



