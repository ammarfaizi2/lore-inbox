Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965184AbWJKPCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965184AbWJKPCL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 11:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbWJKPCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 11:02:10 -0400
Received: from dev.mellanox.co.il ([194.90.237.44]:50562 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S965184AbWJKPCJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 11:02:09 -0400
Date: Wed, 11 Oct 2006 17:01:03 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Steven Whitehouse <steve@chygwyn.com>
Cc: David Miller <davem@davemloft.net>, shemminger@osdl.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       openib-general@openib.org, rolandd@cisco.com
Subject: Re: Dropping NETIF_F_SG since no checksum feature.
Message-ID: <20061011150103.GF4888@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20061011090926.GA15393@fogou.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011090926.GA15393@fogou.chygwyn.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Steven Whitehouse <steve@chygwyn.com>:
> > ssize_t tcp_sendpage(struct socket *sock, struct page *page, int offset,
> >                      size_t size, int flags)
> > {
> >         ssize_t res;
> >         struct sock *sk = sock->sk;
> > 
> >         if (!(sk->sk_route_caps & NETIF_F_SG) ||
> >             !(sk->sk_route_caps & NETIF_F_ALL_CSUM))
> >                 return sock_no_sendpage(sock, page, offset, size, flags);
> > 
> > 
> > So, it seems that if I set NETIF_F_SG but clear NETIF_F_ALL_CSUM,
> > data will be copied over rather than sent directly.
> > So why does dev.c have to force set NETIF_F_SG to off then?
> >
> I agree with that analysis,

So, would you Ack something like the following then?

======================

Enabling NETIF_F_SG without NETIF_F_ALL_CSUM actually seems to work fine by
doing an old-fashioned data copy in tcp_sendpage.
And for devices that do not calculate IP checksum in hardware (e.g. InfiniBand)
calculating the checksum for all packets in network driver is worse than have
the CPU piggyback the checksum compitation with the copy process.
Finally, note that NETIF_F_SG is necessary to be able to allocate skbs >
PAGE_SIZE on busy systems.

So, let's allow that combination, again, for drivers that want it.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

---

diff --git a/net/core/dev.c b/net/core/dev.c
index d4a1ec3..2d731a0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2930,14 +2930,6 @@ #endif
 		}
  	}
 
-	/* Fix illegal SG+CSUM combinations. */
-	if ((dev->features & NETIF_F_SG) &&
-	    !(dev->features & NETIF_F_ALL_CSUM)) {
-		printk(KERN_NOTICE "%s: Dropping NETIF_F_SG since no checksum feature.\n",
-		       dev->name);
-		dev->features &= ~NETIF_F_SG;
-	}
-
 	/* TSO requires that SG is present as well. */
 	if ((dev->features & NETIF_F_TSO) &&
 	    !(dev->features & NETIF_F_SG)) {

-- 
MST
