Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261357AbTCGFiG>; Fri, 7 Mar 2003 00:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261362AbTCGFiF>; Fri, 7 Mar 2003 00:38:05 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:62869 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S261357AbTCGFiC>; Fri, 7 Mar 2003 00:38:02 -0500
Message-ID: <3E6832A5.2020502@nortelnetworks.com>
Date: Fri, 07 Mar 2003 00:48:21 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: unix socket latency regression from 2.4 to 2.5    (and multicast AF_UNIX benchmarks)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've done another series of benchmarks with regards to multicast AF_UNIX 
on the 2.5.63 kernel.  One of the biggest surprises to me was the 
performance regression in the normal userspace case and in the kernel 
case with samll numbers of listeners.

The tests basically work by having a single sender send messages of 
three different sizes to varying numbers of listeners, which take a 
timestamp and then nanosleep() for a second to allow the other listeners 
to wake up as fast as possible.  When the listeners wake up they figure 
out the latency and send it on to a third utility which dumps out the 
latencies.  In the case of the userspace test, the sender sends to each 
listener in turn.  In the case of the multicast test, the kernel handles 
the cloning of the packet to distribute it to the listeners.

Here are the new results combined with the old for comparison.  The 
machine is a Duron 750, with K7 optimizations in the kernel. Both 
kernels were compiled with gcc 3.2.

44bytes         2.4.20       2.5.63        2.4.20         2.5.63
# listeners    userspace    userspace     kernelspace    kernelspace
10              73,335      96,493         103,252        100,286
20              72,610      99,885         106,429        134,517
50              74,1482     95,2075        205,1301       230,1273
100             76,3000     97,4173        362,3425       431,2654
200                         107,8719       737,9917       831,5412

236bytes         2.4.20      2.5.63         2.4.20        2.5.63
# listeners    userspace    userspace      kernelspace   kernelspace
10              70,346      98,510         81,265        100,290
20              74,639      100,918        122,468       137,533
50              75,1557     103,2225       230,1421      238,1329
100             80,3107     105,4415       408,3743      461,2794
200                         131,9117                     889,5720

40036-bytes     2.4.20       2.5.63         2.4.20       2.5.63
# listeners    userspace    userspace      kernelspace   kernelspace
10             302,4181     841,6218       322,1692      702,2231
20             303,7491     873,12606      347,3450      722,3829
50             306,10451    868,38031      483,8394      884,8583
100            309,23107    881,69403      697,17061     1137,16729
200            313,45528    898,132887     997,39810     1586,32722


It appears that sending/receiving is significantly more expensive in 2.5 
than it was in 2.4, with the difference going up as the size of the 
message goes up.  Is 2.5 using different copying code or something? 
Anyone have any ideas as to what is going on here?

Also, even with the increased copying costs, the O(1) scheduler in 2.5 
means that the kernelspace multicast solution is faster than the 
userspace solution in either kernel in all cases, even when waking up 
200 listeners simultaneously.

Any comments on the multicast concept that haven't been discussed already?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

