Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVCGC5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVCGC5T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 21:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVCGC5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 21:57:19 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:12706 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S261628AbVCGC5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 21:57:10 -0500
Message-ID: <422BC303.9060907@candelatech.com>
Date: Sun, 06 Mar 2005 18:57:07 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christian Schmid <webmaster@rapidforum.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
References: <4229E805.3050105@rapidforum.com> <422BAAC6.6040705@candelatech.com> <422BB548.1020906@rapidforum.com>
In-Reply-To: <422BB548.1020906@rapidforum.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schmid wrote:
> Ben Greear wrote:
> 

>> I have a tool that can also generate TCP traffic on a large number of
>> sockets.  If I can understand what you are trying to do, I may be able
>> to reproduce the problem.  My biggest machine at present has only
>> 2GB of RAM, however...not sure if that matters or not.
> 
> It should not matter. Low-memory is both just 1 GB if you have default 
> 32 bit with 3/1 split.
> 
>> Are you sending traffic in only one direction, or more of a full-duplex
>> configuration?
> 
> Its a full-duplex. Its a download-service with 3000 downloaders all over 
> the world.

So actually it's really mostly one-way traffic, ie in the download direction.
Anything significant at all going upstream, other than ACKs, etc?

>>  Is each socket running the same bandwidth?
> 
> No. It ranges from 3 kb/sec to 100 kb/sec. 100 kb/sec is the limit 
> because of the send-buffer limits.
> 
>> What is this bandwidth?
> 
> 1000 MBit
> 
>> Are you setting the send & rcv buffers in the socket creation
>> code?  (To what values if so?)
> 
> Yes. send-buffer to 64 kbytes and receive buffer to 16 kbytes.

With regard to this note in the 'man 7 socket' man page:

NOTES
        Linux assumes that half of the send/receive buffer is used for internal kernel struc-
        tures; thus the sysctls are twice what can be observed on the wire.

What value are you using for the sockopt call?

>> How many bytes are you sending with each call to write()/sendto() 
>> whatever?
>  
> I am using sendfile-call every 100 ms per socket with the poll-api. So 
> basically around 40 kb per round.

My application is single-threaded, uses non-blocking IO, and sends/rcvs from/to memory.
It will be a good test of the TCP stack, but will not use the sendfile logic,
nor will it touch the HD.

>> Is there any significant latency between your sender and receiver 
>> machine?
>> If so, how much?
> 
> 3000 different downloaders, 3000 different locations, 3000 different 
> machines ;)

I can emulate delay if I need to, but I'd rather just stick with one
delay setting and not have to set up a separate delay for each connection.

Maybe 30ms is average for round-trip time?

Have you tried benchmarking your app in a controlled manner, or are you just
letting a random 3000 machines hit it and start downloading?  If the latter,
then I'd suggest getting more controll over your testing environment, otherwise
it may be impossible to really figure out where the problem lies.

I'll set up a configuration similar to the values discussed above and see
what I can see.  Will probably be late tomorrow before I can do the
test though...

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

