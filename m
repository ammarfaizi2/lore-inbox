Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbVLPSjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbVLPSjs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 13:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbVLPSjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 13:39:48 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:18596 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932093AbVLPSjr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 13:39:47 -0500
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
From: Sridhar Samudrala <sri@us.ibm.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, mpm@selenic.com, ak@suse.de,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20051216094810.70082caa@dxpl.pdx.osdl.net>
References: <20051215033937.GC11856@waste.org>
	 <20051214.203023.129054759.davem@davemloft.net>
	 <Pine.LNX.4.58.0512142318410.7197@w-sridhar.beaverton.ibm.com>
	 <20051215.002120.133621586.davem@davemloft.net>
	 <1134698963.10101.43.camel@w-sridhar2.beaverton.ibm.com>
	 <20051216094810.70082caa@dxpl.pdx.osdl.net>
Content-Type: text/plain
Date: Fri, 16 Dec 2005 10:38:19 -0800
Message-Id: <1134758299.10691.28.camel@w-sridhar2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-16 at 09:48 -0800, Stephen Hemminger wrote:
> On Thu, 15 Dec 2005 18:09:22 -0800
> Sridhar Samudrala <sri@us.ibm.com> wrote:
> 
> > On Thu, 2005-12-15 at 00:21 -0800, David S. Miller wrote:
> > > From: Sridhar Samudrala <sri@us.ibm.com>
> > > Date: Wed, 14 Dec 2005 23:37:37 -0800 (PST)
> > > 
> > > > Instead, you seem to be suggesting in_emergency to be set dynamically
> > > > when we are about to run out of ATOMIC memory. Is this right?
> > > 
> > > Not when we run out, but rather when we reach some low water mark, the
> > > "critical sockets" would still use GFP_ATOMIC memory but only
> > > "critical sockets" would be allowed to do so.
> > > 
> > > But even this has faults, consider the IPSEC scenerio I mentioned, and
> > > this applies to any kind of encapsulation actually, even simple
> > > tunneling examples can be concocted which make the "critical socket"
> > > idea fail.
> > > 
> > > The knee jerk reaction is "mark IPSEC's sockets critical, and mark the
> > > tunneling allocations critical, and... and..."  well you have
> > > GFP_ATOMIC then my friend.
> > 
> > I would like to mention another reason why we need to have a new 
> > GFP_CRITICAL flag for an allocation request. When we are in emergency,
> > even the GFP_KERNEL allocations for a critical socket should not 
> > sleep. This is because the swap device may have failed and we would
> > like to communicate this event to a management server over the 
> > critical socket so that it can initiate the failover.
> > 
> > We are not trying to solve swapping over network problem. It is much
> > simpler. The critical sockets are to be used only to send/receive
> > a few critical messages reliably during a short period of emergency.
> > 
> 
> If it is only one place, why not pre-allocate one "I'm sick now"
> skb and hold onto it. Any bigger solution seems to snowball into
> a huge mess.

But the problem is even sending/receiving a single packet can cause 
multiple dynamic allocations in the networking path all the way from
the sockets layer->transport->ip->driver.
To successfully send a packet, we may have to do arp, send acks and 
create cached routes etc. So my patch tried to identify the allocations
that are needed to succesfully send/receive packets over a pre-established
socket and adds a new flag GFP_CRITICAL to those calls.
This doesn't make any difference when we are not in emergency. But when
we go into emergency, VM will try to satisfy these allocations from a
critical pool if the normal path leads to failure.

We go into emergency when some management app detects that a swap device
is about to fail(we are not yet in OOM, but will enter OOM soon). In order
to avoid entering OOM, we need to send a message over a critical socket to
a remote server that can initiate failover and switch to a different swap
device. The switchover will happen within 2 minutes after it is initiated.
In a cluster environment, the remote server also sends a message to other
nodes which are also running the management app so that they also enter
emergency. Once we successfully switch to a different swap device, the remote
server sends a message to all the nodes and they come out of emergency.

During the period of emergency, all other communications can block. But
guranteeing the successful delivery of the critical messages will help 
in making sure that we do not enter OOM situation.

Thanks
Sridhar


