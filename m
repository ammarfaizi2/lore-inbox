Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290829AbSBFV5Z>; Wed, 6 Feb 2002 16:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290828AbSBFV5Q>; Wed, 6 Feb 2002 16:57:16 -0500
Received: from ip68-3-104-241.ph.ph.cox.net ([68.3.104.241]:35243 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S290829AbSBFV5L>;
	Wed, 6 Feb 2002 16:57:11 -0500
Message-ID: <3C61A416.3040703@candelatech.com>
Date: Wed, 06 Feb 2002 14:45:58 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Chris Friesen <cfriesen@nortelnetworks.com>, linux-kernel@vger.kernel.org
Subject: Re: want opinions on possible glitch in 2.4 network error reporting
In-Reply-To: <Pine.LNX.3.95.1020206154220.29419A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

However, if you use non-blocking IO you will get EAGAIN if
there is no buffer space.  Blocking calls should always
block untill there is buffer space.

Also, just because select says the socket/poll is writable, it
may not be (immediately) because you can send UDP packets
that are larger than 2048 bytes, and that is the cutoff that
tells select the socket is writable...

I've actually sent a patch to Dave Miller to make select/poll
wait untill there is 64k of buffer space (the maximum size of
a UDP packet), but he is still reviewing the issue.


Enjoy,
Ben

Richard B. Johnson wrote:

> On Wed, 6 Feb 2002, Chris Friesen wrote:
> 
> [SNIPPED...]
> 
> 
> 
>>I ran into a somewhat related issue on a 2.2.16 system, where I had an app that
>>was calling sendto() on 217000 packets/sec, even though the wire could only
>>handle about 127000 packets/sec.  I got no errors at all in sendto, even though
>>over a third of the packets were not actually being sent.
>>
>>
> 
> In principle, sendto() will always succeed unless you provided the
> wrong parameters in the function call, or the machines crashes, at
> which time your task won't be there to receive the error code anyway.
> 
> Hackers code sendto as:
> 	sendto(s,...);
> Professional programmers use:
> 	(void)sendto(s,...);
> 
> checking the return value is useless.
> 
> Note that the man-page specifically states that ENOBUFS can't happen.
> 
> You cannot assume that any sendto() data actually gets on the wire, much
> less to its destination. With any user-datagram-protocol, both ends,
> sender and receiver, have to work out what they will do with missing
> packets and packets received out-of-order.
> 
> 
> Cheers,
> Dick Johnson


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


