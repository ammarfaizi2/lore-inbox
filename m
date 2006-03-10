Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752115AbWCJAVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115AbWCJAVI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752112AbWCJAVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:21:08 -0500
Received: from palrel11.hp.com ([156.153.255.246]:58289 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S1752110AbWCJAVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:21:07 -0500
Message-ID: <4410C671.2050300@hp.com>
Date: Thu, 09 Mar 2006 16:21:05 -0800
From: Rick Jones <rick.jones2@hp.com>
User-Agent: Mozilla/5.0 (X11; U; HP-UX 9000/785; en-US; rv:1.6) Gecko/20040304
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org
Cc: mst@mellanox.co.il, rdreier@cisco.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: TSO and IPoIB performance degradation
References: <adaacc1raz9.fsf@cisco.com>	<20060307.172336.107863253.davem@davemloft.net>	<20060308125311.GE17618@mellanox.co.il> <20060309.154819.104282952.davem@davemloft.net>
In-Reply-To: <20060309.154819.104282952.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> From: "Michael S. Tsirkin" <mst@mellanox.co.il>
> Date: Wed, 8 Mar 2006 14:53:11 +0200
> 
> 
>>What I was trying to figure out was, how can we re-enable the trick
>>without hurting TSO? Could a solution be to simply look at the frame
>>size, and call tcp_send_delayed_ack if the frame size is small?
> 
> 
> The change is really not related to TSO.
> 
> By reverting it, you are reducing the number of ACKs on the wire, and
> the number of context switches at the sender to push out new data.
> That's why it can make things go faster, but it also leads to bursty
> TCP sender behavior, which is bad for congestion on the internet.

naughty naughty Solaris and HP-UX TCP :)

> 
> When the receiver has a strong cpu and can keep up with the incoming
> packet rate very well and we are in an environment with no congestion,
> the old code helps a lot.  But if the receiver is cpu limited or we
> have congestion of any kind, it does exactly the wrong thing.  It will
> delay ACKs a very long time to the point where the pipe is depleted
> and this kills performance in that case.  For congested environments,
> due to the decreased ACK feedback, packet loss recovery will be
> extremely poor.  This is the first reason behind my change.

well, there are stacks which do "stretch acks" (after a fashion) that 
make sure when they see packet loss to "do the right thing" wrt sending 
enough acks to allow cwnds to open again in a timely fashion.

that brings-back all that stuff I posted ages ago about the performance 
delta when using an HP-UX receiver and altering the number of segmetns 
per ACK.  should be in the netdev archive somewhere.

might have been around the time of the discussions about MacOS and its 
ack avoidance - which wasn't done very well at the time.


> 
> The behavior is also specifically frowned upon in the TCP implementor
> community.  It is specifically mentioned in the Known TCP
> Implementation Problems RFC2525, in section 2.13 "Stretch ACK
> violation".
> 
> The entry, quoted below for reference, is very clear on the reasons
> why stretch ACKs are bad.  And although it may help performance for
> your case, in congested environments and also with cpu limited
> receivers it will have a negative impact on performance.  So, this was
> the second reason why I made this change.

I would have thought that a receiver "stretching ACK's" would be helpful 
when it was CPU limited since it was spending fewer CPU cycles 
generating ACKs?

> 
> So reverting the change isn't really an option.
> 
>    Name of Problem
>       Stretch ACK violation
> 
>    Classification
>       Congestion Control/Performance
> 
>    Description
>       To improve efficiency (both computer and network) a data receiver
>       may refrain from sending an ACK for each incoming segment,
>       according to [RFC1122].  However, an ACK should not be delayed an
>       inordinate amount of time.  Specifically, ACKs SHOULD be sent for
>       every second full-sized segment that arrives.  If a second full-
>       sized segment does not arrive within a given timeout (of no more
>       than 0.5 seconds), an ACK should be transmitted, according to
>       [RFC1122].  A TCP receiver which does not generate an ACK for
>       every second full-sized segment exhibits a "Stretch ACK
>       Violation".

How can it be a "violation" of a SHOULD?-)

> 
>    Significance
>       TCP receivers exhibiting this behavior will cause TCP senders to
>       generate burstier traffic, which can degrade performance in
>       congested environments.  In addition, generating fewer ACKs
>       increases the amount of time needed by the slow start algorithm to
>       open the congestion window to an appropriate point, which
>       diminishes performance in environments with large bandwidth-delay
>       products.  Finally, generating fewer ACKs may cause needless
>       retransmission timeouts in lossy environments, as it increases the
>       possibility that an entire window of ACKs is lost, forcing a
>       retransmission timeout.

Of those three, I think the most meaningful is the second, which can be 
dealt with by smarts in the ACK-stretching receiver.

For the first, it will only degrade performance if it triggers packet loss.

I'm not sure I've ever seen the third item happen.

> 
>    Implications
>       When not in loss recovery, every ACK received by a TCP sender
>       triggers the transmission of new data segments.  The burst size is
>       determined by the number of previously unacknowledged segments
>       each ACK covers.  Therefore, a TCP receiver ack'ing more than 2
>       segments at a time causes the sending TCP to generate a larger
>       burst of traffic upon receipt of the ACK.  This large burst of
>       traffic can overwhelm an intervening gateway, leading to higher
>       drop rates for both the connection and other connections passing
>       through the congested gateway.

Doesn't RED mean that those other connections are rather less likely to 
be affected?

> 
>       In addition, the TCP slow start algorithm increases the congestion
>       window by 1 segment for each ACK received.  Therefore, increasing
>       the ACK interval (thus decreasing the rate at which ACKs are
>       transmitted) increases the amount of time it takes slow start to
>       increase the congestion window to an appropriate operating point,
>       and the connection consequently suffers from reduced performance.
>       This is especially true for connections using large windows.

This one is dealt with by ABC isn't it?  At least in part since ABC 
appears to cap cwnd increase at 2*SMSS (I only know this because I just 
read the RFC mentioned in another thread - seems a bit much to have made 
that limit a MUST rather than a SHOULD :)

rick jones
