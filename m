Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318258AbSIOVWN>; Sun, 15 Sep 2002 17:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318266AbSIOVWN>; Sun, 15 Sep 2002 17:22:13 -0400
Received: from 84e5e703.math.leidenuniv.nl ([132.229.231.3]:57487 "EHLO
	zada.math.leidenuniv.nl") by vger.kernel.org with ESMTP
	id <S318258AbSIOVWM>; Sun, 15 Sep 2002 17:22:12 -0400
Date: Sun, 15 Sep 2002 23:27:06 +0200
From: Lennert Buytenhek <buytenh@math.leidenuniv.nl>
To: "David S. Miller" <davem@redhat.com>
Cc: bart.de.schuymer@pandora.be, linux-kernel@vger.kernel.org
Subject: Re: bridge-netfilter patch
Message-ID: <20020915232706.A21527@math.leidenuniv.nl>
References: <200209130812.27093.bart.de.schuymer@pandora.be> <20020912.230916.96754743.davem@redhat.com> <20020913144518.A31318@math.leidenuniv.nl> <20020913.112235.27948638.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020913.112235.27948638.davem@redhat.com>; from davem@redhat.com on Fri, Sep 13, 2002 at 11:22:35AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Sep 13, 2002 at 11:22:35AM -0700, David S. Miller wrote:

>    > You need to remove the IPv4 bits, that copy of the MAC has to happen
>    > at a different layer, it does not belong in IPv4.  At best, everyone
>    > shouldn't eat that header copy.
>    
>    What if I make the memcpy conditional on "if (skb->physindev != NULL)"?
> 
> First explain to me why the copy is needed for.

This is just to elaborate upon what Bart said earlier.

In the "L2 switched frame" case, we have a bit of a nasty problem
with IP fragmentation.  And in the "L3 'switched' frame" case
(brouted frame), we have an ordering problem with IP fragmentation
and neighbor resolution.

This is what the call stack looks like when we have a purely
bridged frame (that needs to be netfiltered):

	net_rx_action
	  -> br_handle_frame
	    -> PF_BRIDGE/PRE_ROUTING
	      -> br_handle_frame_finish
		-> br_forward
		  -> PF_BRIDGE/FORWARD
		    -> __br_forward_finish
		      -> PF_BRIDGE/POST_ROUTING
			-> dev_queue_xmit


This case is easy to see.  With ip_conntrack enabled, packets
are reassembled in PRE_ROUTING and refragmented in POST_ROUTING.
This refragmenting messes up the hardware header, so the fragments
will leave the box with incorrect HW headers.


The broute case is a bit harder to see.  If L3 (routed) packets
are destined for a bridge device, we don't know what subdevice
(slave port) they will go to until the bridge layer's br_dev_xmit
has its way.  However, we would like to be able to use the real
outgoing interface (physoutdev) in FORWARD and POST_ROUTING.

To be able to do this, we postpone calling IPv4/FORWARD and
IPv4/POST_ROUTING until after PF_BRIDGE/POST_ROUTING has happened,
because at that point we know physoutdev so we can feed it to
said IPv4 hooks.

But.  Packet refragmentation normally happens in IPv4/POST_ROUTING.
We don't want to do it there though, because that would cause the
eventual call to IPv4/FORWARD and IPv4/POST_ROUTING to see all
fragments instead of one packet (which goes against the idea of
conntrack).

So if we postpone FORWARD and POST_ROUTING until after br_dev_xmit,
we effectively reverse refragmentation and neighbor resolution.
But refragmentation messes up the hardware header.


The 16byte hardware header copy fixes this by copying to each
fragment the hardware header that was tacked onto or was already
present on the bigger packet.  It's ugly, I admit.  There's
currently no better way though.

(And Bart, I chose 16 because 16-byte aligned 16-byte copies
should be cheaper than 2-byte aligned 14-byte copies, and there
should be at least 16 bytes before skb->data at this point
anyway.  That is, if I understood the code correctly.)


cheers,
Lennert
