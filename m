Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315748AbSILNyz>; Thu, 12 Sep 2002 09:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315758AbSILNyy>; Thu, 12 Sep 2002 09:54:54 -0400
Received: from cochiti.nm.org ([129.121.1.13]:54021 "HELO cochiti.nm.org")
	by vger.kernel.org with SMTP id <S315748AbSILNyx>;
	Thu, 12 Sep 2002 09:54:53 -0400
Date: Thu, 12 Sep 2002 07:57:04 -0600 (MDT)
From: Todd Underwood <todd@osogrande.com>
X-X-Sender: todd@gp
To: jamal <hadi@cyberus.ca>
cc: "David S. Miller" <davem@redhat.com>,
       "tcw@tempest.prismnet.com" <tcw@tempest.prismnet.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "netdev@oss.sgi.com" <netdev@oss.sgi.com>,
       patricia gilfeather <pfeather@cs.unm.edu>
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
In-Reply-To: <Pine.GSO.4.30.0209120811300.16149-100000@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.44.0209120729200.27963-100000@gp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamal,

> Good work. The first time i have seen someone say Linux's way of
> reverse order is a GoodThing(tm). It was also great to see de-mything
> some of the old assumption of the world.

thanks.  although i'd love to take credit, i don't think that the 
reverse-order fragmentation appreciation is all that original:  who 
wouldn't want their data sctructure size determined up-front? :-) (not to 
mention getting header-overwriting for-free as part of the single copy.

> BTW, TSO is not a intelligent as what you are suggesting.
> If i am not mistaken you are not only suggesting fragmentation and
> assembly at that level you are also suggesting retransmits at the NIC.
> This could be dangerous for practical reasons (changes in TCP congestion
> control algorithms etc). TSO as was pointed in earlier emails is just a
> dumb sender of packets. I think even fragmentation is a misnomer.
> Essentially you shove a huge buffer to the NIC and it breaks it into MTU
> sized packets for you and sends them.

the biggest problem to our approach is that itis extremely difficult to
mix two very different kinds of workloads together:  the regular
server-on-the-internet workload (SOI) and the large-cluster-member
workload (LCM).  in the former case, SOI, you get dropped packets,
fragments, no fragments, out of order fragments, etc.  in the LCM case you 
basically never get any of that stuff--you're on a closed network with 
1000-10000 of your closest cluster friends and that's just what you're 
doing.  no fragments (unless you put them there), no out of order 
fragments (unless you send them) and basically no dropped packets ever.  
obviously, if you can assume conditions like that, you can do things like:  
only reassmble fragments in reverse order since you know you'll only send 
them that way, e.g.

> In regards to the receive side CPU utilization improvements: I think
> that NAPI does a good job at least in getting ridding of the biggest
> offender -- interupt overload. Also with NAPI also having got rid of
> intermidiate queues to the socket level, facilitating of zero copy receive
> should be relatively easy to add but there are no capable NICs in
> existence (well, ok not counting the TIGONII/acenic that you can hack
> and the fact that the tigon 2 is EOL doesnt help other than just for
> experiments). I dont think theres any NIC that can offload reassembly;
> that might not be such a bad idea.

i've done some reading about NAPI just recently (somehow i missed the 
splash when it came out).  the two things i like about it are the hardware 
independent interrupt mitigation technique and using the DMA buffers as a 
receive backlog.  i'm concerned about the numbers posted by ibm folx 
recently showing a slowdown under some conditions using NAPI and need to 
read the rest of that discussion.

we are definitely aware of the fact that the more you want to put on the 
NIC, the more the NIC will have to do (and the more expensive it will have 
to be).  right now the NICs, that people are developing on are the 
TigonII/III and, even more closed/proprietary, the Myrinet NICs.  i would 
love to have a <$200 NIC with open firmware and a CPU/memory so that we 
could offload some more of this functionality (where it makes sense).  
> 
> Are you still continuing work on this?
> 

definitely!  we were just talking about some of these issues yesterday
(and trying to find hardware sepc info on the web for the e1000 platform
to see what else they might be able to do). patricia gilfeather is working
on finding parts of TCP that are separable from the rest of TCP, but the 
problems you raise are serious:  it would have to be on an 
application-specific and socket-specific basis, so that the app would 
*know* that functionality (like acks for synchronization packets or 
whatever) was being offloaded. 

the biggest difference in our perspective, versus the common kernel
developers, is that we're still looking for ways to get the OS out of the
way of the applications.  if we can do large data transfers (with
pre-posted receives and pre-posted memory allocation, obviously) directly
from the nic into application memory and have a clean, relatively simple
and standard api to do that, we avoid all of the interrupt mitigation 
techniques and save hugely on context switching overhead.

this may now be off-topic for linux-kernel and i'd be happy to chat 
further in private email if others are getting bored :-).

> cheers,
> jamal

t.
-- 
todd underwood, vp & cto
oso grande technologies, inc.
todd@osogrande.com

"Those who give up essential liberties for temporary safety deserve
neither liberty nor safety." - Benjamin Franklin


