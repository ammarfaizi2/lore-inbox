Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266161AbTCCRxH>; Mon, 3 Mar 2003 12:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265736AbTCCRxH>; Mon, 3 Mar 2003 12:53:07 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:9437 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S265132AbTCCRxD>; Mon, 3 Mar 2003 12:53:03 -0500
Message-ID: <3E6398C4.2020605@nortelnetworks.com>
Date: Mon, 03 Mar 2003 13:02:44 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: jamal <hadi@cyberus.ca>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       linux-net@vger.kernel.org
Subject: Re: anyone ever done multicast AF_UNIX sockets?
References: <3E5E7081.6020704@nortelnetworks.com> <20030228083009.Y53276@shell.cyberus.ca> <3E5F748E.2080605@nortelnetworks.com> <20030228212309.C57212@shell.cyberus.ca> <3E619E97.8010508@nortelnetworks.com> <20030302081916.S61365@shell.cyberus.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:
> On Sun, 2 Mar 2003, Chris Friesen wrote
>>jamal wrote
>>>Did you also measure throughput

>>No.  lmbench doesn't appear to test UDP socket local throughput

> I think you need to collect all data if you are trying to show
> improvements.

I'll look at how they were measuring unix socket throughput and try 
implementing something similar for UDP.  It's not clear to me how to 
really measure throughput in a multicast environment though since it 
depends very much on your application messaging patterns.

> Ok, so its only a problem when you have a few listeners i.e user space
> scheme scales just fine as you keep adding listeners.
> In your tests what was the break-even point?

See below for more detailed test results.

> Addressing has to be backwared compatible i.e not affecting any other
> program.

Of course.  The way I've designed it is that you get and bind() a socket 
as normal, and then use setsockopt() to register interest in a multicast 
address (same as IP multicast).  If the address already exists but is 
not a multicast address, then you get an error.  If a socket tries to 
bind() or connect() to an existing multicast address, you get an error. 
  The different types of addresses exist in the same address space, but 
the only way to register interest in multicast addresses is through 
setsockopt().

>>The timings (in usec) for the delays to each of the listeners were as
>>follows on my duron 750:
>>
>>userspace server:     104 133 153
>>userspace no server:   72 111 138
>>kernelspace:           60  91 113

> Actually, the difference between user space server and kernel doesnt
> appear that big. What you need to do is collect more data.
> repeat with incrementing number of listeners.

What would you consider a "big" difference?  Here the userspace server 
is 35% slower than the kernelspace version.

You wanted more data, so here's results comparing the no-server 
userspace method vs the kernel method.  The server-based one would be 
slightly more expensive than the no-server version.  The results below 
are the smallest and largest latencies (in usecs) for the message to 
reach the listeners in userspace.  I've used three different sizes, the 
two extremes and a roughly average sized message in my particular domain.

44bytes
# listeners    userspace         kernelspace
10              73,335             103,252
20              72,610             106,429
50              74,1482            205,1301
100             76,3000            362,3425
200                                737,9917

236bytes
# listeners    userspace         kernelspace
10              70,346               81,265
20              74,639              122,468
50              75,1557             230,1421
100             80,3107             408,3743

40036-byte message
# listeners    userspace         kernelspace
10             302,4181           322,1692
20             303,7491           347,3450
50             306,10451          483,8394
100            309,23107          697,17061
200            313,45528          997,39810

As one would expect, the initial latencies are somewhat higher for the 
kernel space solution since all the skb header duplication is done 
before anyone is woken up.  One thing that I did not expect was the 
increased max latency in the kernel space soltion when the number of 
listeners grew large.  On reflection, however, I suspect that this is 
due to scheduler load since all of the listening processes have become 
runnable while in the userspace version they become runnable one at a 
time.  It would be interesting to run this on 2.5 with the O(1) 
scheduler and see if it makes a difference.

With larger message sizes, the cost of the additional copies in the 
userspace solution start to outweigh the overhead of the additional 
runnable processes and the kernel space solution stays faster in all 
runs tested.

Chris




-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

