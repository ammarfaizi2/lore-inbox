Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbTJZGpW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 01:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbTJZGpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 01:45:22 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:2181 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262859AbTJZGpR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 01:45:17 -0500
Message-ID: <3F9B6D24.7050003@cyberone.com.au>
Date: Sun, 26 Oct 2003 17:43:48 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Andrew Theurer <habanero@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nick's scheduler v17
References: <3F996B10.4080307@cyberone.com.au> <200310241649.05310.habanero@us.ibm.com> <3F99CE07.6030905@cyberone.com.au>
In-Reply-To: <3F99CE07.6030905@cyberone.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

>
>
> Andrew Theurer wrote:
>
>> On Friday 24 October 2003 13:10, Nick Piggin wrote:
>>
>>> Hi,
>>> http://www.kerneltrap.org/~npiggin/v17/
>>>
>>> Still working on SMP and NUMA. Some (maybe) interesting things I put 
>>> in are
>>> - Sequential CPU balancing so you don't get a big storm of balances
>>> every 1/4s.
>>> - Balancing is trying to err more on the side of caution, I have to 
>>> start
>>>  analysing it more thoroughly though.
>>>
>>
>> +
>> +    *imbalance /= 2;
>> +    *imbalance = (*imbalance + FPT - 1) / FPT;
>>
>> I think I see what is going on here, but would something like this 
>> work out better?
>>
>
> Yeah, sorry its not well commented. Its still changing quite quickly.
>
>>
>>     *imbalance = min(this_load - load_avg, load_avg - max_load)
>>
>> That way you take just enough to either have busiest_queue or 
>> this_rq's length be the load_avg.  I suppose you could take even 
>> less, but IMO, the /=2 is what I really don't like.  Perhaps:
>>
>
> That is _exactly_ what I had before! Thats probably the way to go. Thanks
> for having a look at it.
>
>>
>>
>> *imbalance = min(this_load - load_avg, load_avg - max_load);
>> *imbalance = (*imbalance + FPT - 1) / FPT;
>>
>> This should work well for intranode balances, internode balances may 
>> need a little optimization, since the load_avg really does not really 
>> represent the load avg of the two nodes in question, just one cpu 
>> from one of them and all the cpus from another.
>>

Oh, actually, after my path, load_avg represents the load average of _all_
the nodes. Have a look at find_busiest_node. Which jogs my memory of why
its not always a good idea to do your *imbalance min(...) thing (I actually
saw this happening).

5 CPUs, 4 processes running on one cpu. load_avg would be 0.8 for all cpus.
balancing doesn't happen. I have to think about this a bit more...


