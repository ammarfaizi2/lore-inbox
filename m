Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268672AbTCCRAK>; Mon, 3 Mar 2003 12:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268617AbTCCRAH>; Mon, 3 Mar 2003 12:00:07 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:38620 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S268672AbTCCQ7j>; Mon, 3 Mar 2003 11:59:39 -0500
Message-ID: <3E638C51.2000904@nortelnetworks.com>
Date: Mon, 03 Mar 2003 12:09:37 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, davem@redhat.com
Subject: Re: anyone ever done multicast AF_UNIX sockets?
References: <3E5E7081.6020704@nortelnetworks.com> <1046695876.7731.78.camel@pc-16.office.scali.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terje Eggestad wrote:
> On a single box you would use a shared memory segment to do this. It has
> the following advantages:
> - no syscalls at all

Unless you poll for messages on the receiving side, how do you trigger 
the receiver to look for a message?  Shared memory doesn't have file 
descriptors.

> - whenever the recipients need to use the info, they access the shm
> directly (you may need to use a semaphore to enforce consistency, or if
> you're really pressed on time, spin lock a shm location) There is no
> need for the recipients to copy the info to private data structs.

How do they know the information has changed?  Suppose one process 
detects that the ethernet link has dropped.  How does it alert other 
processes which need to do something?

> Why does it help you to know that there are no recipients contra the
> wrong number recipients ???? OR asked differently, if you don't have a
> notion of who the recipients are/should be, why would you care if there
> are none??????
> There are practically no real applications for this feature. 

It's true that if I have a nonzero number of listeners it doesn't tell 
me anything since I don't know if the right one is included.  However, 
if I send a message and there were *no* listeners but I know that there 
should be at least one, then I can log the anomaly, raise an alarm, or 
take whatever action is appropriate.

> Also: Keep in mind that either you do multicast, or explisit send to
> all, the data you're sending are copied from you buffer to the dest
> sockets recv buffers anyway. If you're sending 1k you need somewhere
> between 250 to 1000 cycles to do the copy, depending on alignment. I've
> measured the syscall overhead for a write(len=0) to be about 800 cycles
> on a P3 or athlon, and about 2000 on P4. If you really have enough
> possible recipients, you should use a shm segment instead. If you have
> only a few (~10) the overhead is worst case 20000 cycles, or on a 2G P4,
> 10 microsecs to do a syscall for each. Who cares... 

Granted, shared memory (or sysV message queues) are the fastest way to 
transfer data between processes.  However, you still have to implement 
some way to alert the receiver that there is a message waiting for it.

For large packet sizes it may be sufficient to send a small unix socket 
message to alert it that there is a message waiting, but for small 
messages the cost of the copying is small compared to the cost of the 
context switch, and the unix multicast cuts the number of context 
switches in half.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

