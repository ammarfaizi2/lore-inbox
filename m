Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269006AbTCBFx2>; Sun, 2 Mar 2003 00:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268958AbTCBFx1>; Sun, 2 Mar 2003 00:53:27 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:15870 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S267499AbTCBFxZ>; Sun, 2 Mar 2003 00:53:25 -0500
Message-ID: <3E619E97.8010508@nortelnetworks.com>
Date: Sun, 02 Mar 2003 01:03:03 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: jamal <hadi@cyberus.ca>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       linux-net@vger.kernel.org
Subject: Re: anyone ever done multicast AF_UNIX sockets?
References: <3E5E7081.6020704@nortelnetworks.com> <20030228083009.Y53276@shell.cyberus.ca> <3E5F748E.2080605@nortelnetworks.com> <20030228212309.C57212@shell.cyberus.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal wrote:
> Did you also measure throughput?

No.  lmbench doesn't appear to test UDP socket local throughput.

> You are overlooking the flexibility that already exists in IP based
> transports as an advantage; the fact that you can make them
> distributed instead of localized with a simple addressing change
> is a very powerful abstraction.

True.  On the other hand, the same could be said about unicast IP 
sockets vs unix sockets.  Unix sockets exist for a reason, and I'm 
simply proposing to extend them.

>>From
>>userspace, multicast unix would be *simple* to use, as in totally
>>transparent.

> You could implement the abstraction in user space as a library today by
> having some server that muxes to several registered clients.

This is what we have now, though with a suboptimal solution (we 
inherited it from another group).  The disadvantage with this is that it 
adds a send/schedule/receive iteration.  If you have a small number of 
listeners this can have a large effect percentage-wise on your messaging 
cost.  The kernel approach also cuts the number of syscalls required by 
a factor of two compared to the server-based approach.

> So whats the addressing scheme for multicast unix? Would it be a
> reserved path?

Actually I was thinking it could be arbitrary, with a flag in the unix 
part of struct sock saying that it was actually a multicast address. 
The api would be something like the IP multicast one, where you get and 
bind a normal socket and then use setsockopt to attach yourself to one 
or more of multicast addresses.  A given address could be multicast or 
not, but they would reside in the same namespace and would collide as 
currently happens.  The only way to create a multicast address would be 
the setsockopt call--if the address doesn't already exist a socket would 
be created by the kernel and bound to the desired address.

To see if its feasable I've actually coded up a proof-of-concept that 
seems to do fairly well. I tested it with a process sending an 8-byte 
packet containing a timestamp to three listeners, who checked the time 
on receipt and printed out the difference.

For comparison I have two different userspace implementations, one with 
a server process (very simple for test purposes) and the other using an 
mmap'd file to store which process is listening to what messages.

The timings (in usec) for the delays to each of the listeners were as 
follows on my duron 750:

userspace server:     104 133 153
userspace no server:   72 111 138
kernelspace:           60  91 113

As you can see, the kernelspace code is the fastest and since its in the 
kernel it can be written to avoid being scheduled out while holding 
locks which is hard to avoid with the no-server userspace option.

If this sounds at all interesting I would be glad to post a patch so you 
could shoot holes in it, otherwise I'll continue working on it privately.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

