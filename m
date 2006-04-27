Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbWD0ENZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbWD0ENZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 00:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbWD0ENZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 00:13:25 -0400
Received: from narn.hozed.org ([209.234.73.39]:21656 "EHLO narn.hozed.org")
	by vger.kernel.org with ESMTP id S964922AbWD0ENY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 00:13:24 -0400
Date: Wed, 26 Apr 2006 23:13:24 -0500
From: Troy Benjegerdes <hozer@hozed.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: mst@mellanox.co.il, rick.jones2@hp.com, netdev@vger.kernel.org,
       rdreier@cisco.com, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: TSO and IPoIB performance degradation
Message-ID: <20060427041323.GX15855@narn.hozed.org>
References: <20060320090629.GA11352@mellanox.co.il> <20060320.015500.72136710.davem@davemloft.net> <20060320102234.GV29929@mellanox.co.il> <20060320.023704.70907203.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060320.023704.70907203.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 02:37:04AM -0800, David S. Miller wrote:
> From: "Michael S. Tsirkin" <mst@mellanox.co.il>
> Date: Mon, 20 Mar 2006 12:22:34 +0200
> 
> > Quoting r. David S. Miller <davem@davemloft.net>:
> > > The path an SKB can take is opaque and unknown until the very last
> > > moment it is actually given to the device transmit function.
> > 
> > Why, I was proposing looking at dst cache. If that's NULL, well,
> > we won't stretch ACKs. Worst case we apply the wrong optimization.
> > Right?
> 
> Where you receive a packet from isn't very useful for determining
> even the full patch on which that packet itself flowed.
> 
> More importantly, packets also do not necessarily go back out over the
> same path on which packets are received for a connection.  This is
> actually quite common.
> 
> Maybe packets for this connection come in via IPoIB but go out via
> gigabit ethernet and another route altogether.
> 
> > What I'd like to clarify, however: rfc2581 explicitly states that in
> > some cases it might be OK to generate ACKs less frequently than
> > every second full-sized segment. Given Matt's measurements, TCP on
> > top of IP over InfiniBand on Linux seems to hit one of these cases.
> > Do you agree to that?
> 
> I disagree with Linux changing it's behavior.  It would be great to
> turn off congestion control completely over local gigabit networks,
> but that isn't determinable in any way, so we don't do that.
> 
> The IPoIB situation is no different, you can set all the bits you want
> in incoming packets, the barrier to doing this remains the same.
> 
> It hurts performance if any packet drop occurs because it will require
> an extra round trip for recovery to begin to be triggered at the
> sender.
> 
> The network is a black box, routes to and from a destination are
> arbitrary, and so is packet rewriting and reflection, so being able to
> say "this all occurs on IPoIB" is simply infeasible.
> 
> I don't know how else to say this, we simply cannot special case IPoIB
> or any other topology type.

David is right. If you care about performance, you are already using SDP
or verbs layer for the transport anyway. If I am going to be doing IPoIB,
it's because eventually I expect the packet might get off the IB network
and onto some other network and go halfway across the country.

