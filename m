Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbTJ0XPy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 18:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263762AbTJ0XPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 18:15:54 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:42903 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263760AbTJ0XPv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 18:15:51 -0500
Message-ID: <3F9DA68F.5080000@cyberone.com.au>
Date: Tue, 28 Oct 2003 10:13:19 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Theurer <habanero@us.ibm.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nick's scheduler v17
References: <3F996B10.4080307@cyberone.com.au> <3F99CE07.6030905@cyberone.com.au> <3F9B6D24.7050003@cyberone.com.au> <200310271102.59041.habanero@us.ibm.com>
In-Reply-To: <200310271102.59041.habanero@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Theurer wrote:

>>>>    *imbalance = min(this_load - load_avg, load_avg - max_load)
>>>>
>>>>That way you take just enough to either have busiest_queue or
>>>>this_rq's length be the load_avg.  I suppose you could take even
>>>>less, but IMO, the /=2 is what I really don't like.  Perhaps:
>>>>
>>>That is _exactly_ what I had before! Thats probably the way to go. Thanks
>>>for having a look at it.
>>>
>>>
>>>>*imbalance = min(this_load - load_avg, load_avg - max_load);
>>>>*imbalance = (*imbalance + FPT - 1) / FPT;
>>>>
>>>>This should work well for intranode balances, internode balances may
>>>>need a little optimization, since the load_avg really does not really
>>>>represent the load avg of the two nodes in question, just one cpu
>>>>from one of them and all the cpus from another.
>>>>
>>Oh, actually, after my path, load_avg represents the load average of _all_
>>the nodes. Have a look at find_busiest_node. Which jogs my memory of why
>>its not always a good idea to do your *imbalance min(...) thing (I actually
>>saw this happening).
>>
>
>Oops, I meant avg_load, which you calculate in find_busiest_queue on the fly.  
>

OK

>
>>5 CPUs, 4 processes running on one cpu. load_avg would be 0.8 for all cpus.
>>balancing doesn't happen. I have to think about this a bit more...
>>
>
>Actually, if we use avg_load, I guess it would be 0, since this is an unsigned 
>long.  Maybe avg_load needs to have a min value of 1.  Then if we apply:
>

Well its got a fixed point scaling factor.

>
>*imbalance = min(max_load - avg_load, avg_load - this_load)
>	     min(4 - 1, 1 - 0)
>	     	
>

I think you want:

*imbalance = min(max_load - avg_load, avg_load - this_load)
if ( (*imbalance < 1*FPT) &&
        (max_load - this_load) > 1*FPT )
    *imbalance = 1*FPT;

So if there is a total imbalance of more than 1 task, at least one
will be moved.



>
>And imbalance looks a lot better.  Only concern would be an idle cpu stealing 
>from another, leaving the other cpu idle.  I guess a check could be put 
>there.	
>	     
>

pull_task won't pull a running task, so you get some protection there.


