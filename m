Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbVCHGbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbVCHGbl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 01:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVCHGbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 01:31:41 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:60069 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S261542AbVCHGaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 01:30:39 -0500
Message-ID: <422D468C.7060900@candelatech.com>
Date: Mon, 07 Mar 2005 22:30:36 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Christian Schmid <webmaster@rapidforum.com>, linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
References: <4229E805.3050105@rapidforum.com> <422BAAC6.6040705@candelatech.com> <422BB548.1020906@rapidforum.com> <422BC303.9060907@candelatech.com> <422BE33D.5080904@yahoo.com.au> <422C1D57.9040708@candelatech.com> <422C1EC0.8050106@yahoo.com.au>
In-Reply-To: <422C1EC0.8050106@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Ben Greear wrote:
> 
>> Nick Piggin wrote:
>>
>>> Ben Greear wrote:
>>>
> 
>>> In that case, writing the network only test would help to confirm the
>>> problem is not a networking one - so not useless by any means.
>>
>>
>>
>> It's not trivial to write something like this :)
>>
>> I'll be using something I already have.  If I can't reproduce the 
>> problem,
>> then perhaps it is due to sendfile and someone can write a customized
>> test.  The main reason I offered is because people are ignoring the
>> bug report for the most part and asking for a test case.  I may be able
>> to offer an independent verification of the problem which might convince
>> someone to write up a dedicated test case...
>>
> 
> OK, no that sounds good, please do make the test case.
> 
> I have actually been following up with Christian regarding
> the disk IO / memory management side of things but the thread
> has gone offline for some reason :\

Initial test setup:  two machines, running connections between them.
Mostly asymetric (about 50Mbps in one direction,
GigE in the other).  Each connection is trying some random rate between 128kbps
and 3Mbps in one direction, and 1kbps in the other direction.

Sending machine is dual 3.0Ghz xeons, 1MB cache, HT, and emt64 (running 32-bit
kernel & user space though). 1GB of RAM

Receiving machine is dual 2.8Ghz xeons, 512 MB cache, HT, 32-bit.  2GB of RAM
(but only 850Mbps of low memory of course...saw the thing OOM kill me with 1GB of
free high memory :( )


Zero latency:

2000 TCP connections:  When I first start, I see errors indicating I'm out of low
         memory..but it quickly recovers.  Probably because my program takes a small
         bit of time before it starts reading the sockets.
         986Mbps of ethernet traffic (counting all ethernet headers)

3000 TCP connections:  Same memory issue
         986Mbps of ethernet traffic, about 82kpps

4000 TCP connections:  Had to drop max_backlog to 5000 from 10000 to keep
         the machine from going OOM and killing my traffic generator (on
         the receiving side).
	986Mbps of ethernet traffic

I will work on some numbers with latency tomorrow (had to stop and
re-write some of my code to better handle managing the 8000 endpoints
that 4000 connections requires!)

I think we can assume that the problem is either related to latency,
or sendfile, since 4000 connections with no latency rocks along just
fine...

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

