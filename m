Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285809AbRLJULq>; Mon, 10 Dec 2001 15:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286368AbRLJUL1>; Mon, 10 Dec 2001 15:11:27 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.1.197.194]:959 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S285809AbRLJULM>;
	Mon, 10 Dec 2001 15:11:12 -0500
Message-ID: <3C1516DC.5010500@candelatech.com>
Date: Mon, 10 Dec 2001 13:11:08 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: min-write-size for a UDP socket to be POLLOUT cannot be set. (proposed fixes)
In-Reply-To: <Pine.LNX.3.95.1011210145814.405A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Richard B. Johnson wrote:

> On Mon, 10 Dec 2001, Ben Greear wrote:
> 
> 
>>This relates to my earlier question about setting the threshold
>>at which select returns that a (UDP) socket is writable.
>>
>>It appears that UDP sockets are hardwired at 2048 bytes...
>>
>> From linux/include/net/sock.h:
>>
> 
>     int len = 0x8000;
> 
>     setsockopt(s, SOL_SOCKET, SO_SNDBUF, &len, sizeof(len));
>     setsockopt(s, SOL_SOCKET, SO_RCVBUF, &len, sizeof(len));
> 
> 
> Doesn't this work?


That sets the queue sizes bigger, but suppose this:

I have 4M queue size.  I have 4M-2k bytes already in the
queue (2k free).  I have a 4k UDP buffer to write.  I call
select and it says the socket is writable.  However, in this
case I cannot actually write to the socket because I have only
2 of the 4k that I need...  Now, I can detect the failure to send
and re-transmit, but that basically gets me into a tight loop because
select keeps saying I can write, and I keep trying.  The tight loop
is doubly bad because the machine is already highly stressed or it's
buffers would never be so full....

I want select to only say I can write when I'm at XX (say, 64k) bytes of
free buffer-queue space...

Ben


> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).
> 
>     I was going to compile a list of innovations that could be
>     attributed to Microsoft. Once I realized that Ctrl-Alt-Del
>     was handled in the BIOS, I found that there aren't any.
> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


