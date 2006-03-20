Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWCTKho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWCTKho (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 05:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWCTKho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 05:37:44 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:52114
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750890AbWCTKhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 05:37:43 -0500
Date: Mon, 20 Mar 2006 02:37:04 -0800 (PST)
Message-Id: <20060320.023704.70907203.davem@davemloft.net>
To: mst@mellanox.co.il
Cc: rick.jones2@hp.com, netdev@vger.kernel.org, rdreier@cisco.com,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: TSO and IPoIB performance degradation
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060320102234.GV29929@mellanox.co.il>
References: <20060320090629.GA11352@mellanox.co.il>
	<20060320.015500.72136710.davem@davemloft.net>
	<20060320102234.GV29929@mellanox.co.il>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Date: Mon, 20 Mar 2006 12:22:34 +0200

> Quoting r. David S. Miller <davem@davemloft.net>:
> > The path an SKB can take is opaque and unknown until the very last
> > moment it is actually given to the device transmit function.
> 
> Why, I was proposing looking at dst cache. If that's NULL, well,
> we won't stretch ACKs. Worst case we apply the wrong optimization.
> Right?

Where you receive a packet from isn't very useful for determining
even the full patch on which that packet itself flowed.

More importantly, packets also do not necessarily go back out over the
same path on which packets are received for a connection.  This is
actually quite common.

Maybe packets for this connection come in via IPoIB but go out via
gigabit ethernet and another route altogether.

> What I'd like to clarify, however: rfc2581 explicitly states that in
> some cases it might be OK to generate ACKs less frequently than
> every second full-sized segment. Given Matt's measurements, TCP on
> top of IP over InfiniBand on Linux seems to hit one of these cases.
> Do you agree to that?

I disagree with Linux changing it's behavior.  It would be great to
turn off congestion control completely over local gigabit networks,
but that isn't determinable in any way, so we don't do that.

The IPoIB situation is no different, you can set all the bits you want
in incoming packets, the barrier to doing this remains the same.

It hurts performance if any packet drop occurs because it will require
an extra round trip for recovery to begin to be triggered at the
sender.

The network is a black box, routes to and from a destination are
arbitrary, and so is packet rewriting and reflection, so being able to
say "this all occurs on IPoIB" is simply infeasible.

I don't know how else to say this, we simply cannot special case IPoIB
or any other topology type.
