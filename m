Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161138AbWJKSYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161138AbWJKSYo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 14:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161178AbWJKSYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 14:24:44 -0400
Received: from palrel10.hp.com ([156.153.255.245]:3780 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1161138AbWJKSYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 14:24:43 -0400
Message-Id: <6.2.0.14.2.20061011111146.03292b50@esmail.cup.hp.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.0.14
Date: Wed, 11 Oct 2006 11:21:43 -0700
To: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       "David Miller" <davem@davemloft.net>
From: Michael Krause <krause@cup.hp.com>
Subject: Re: [openib-general] Dropping NETIF_F_SG since no checksum
  feature.
Cc: netdev@vger.kernel.org, openib-general@openib.org,
       linux-kernel@vger.kernel.org, shemminger@osdl.org
In-Reply-To: <20061011094649.GD2701@mellanox.co.il>
References: <20061011.022015.63051509.davem@davemloft.net>
 <20061011094649.GD2701@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:46 AM 10/11/2006, Michael S. Tsirkin wrote:
>Quoting r. David Miller <davem@davemloft.net>:
> > Subject: Re: Dropping NETIF_F_SG since no checksum feature.
> >
> > From: "Michael S. Tsirkin" <mst@mellanox.co.il>
> > Date: Wed, 11 Oct 2006 11:05:04 +0200
> >
> > > So, it seems that if I set NETIF_F_SG but clear NETIF_F_ALL_CSUM,
> > > data will be copied over rather than sent directly.
> > > So why does dev.c have to force set NETIF_F_SG to off then?
> >
> > Because it's more efficient to copy into a linear destination
> > buffer of an SKB than page sub-chunks when doing checksum+copy.
> >
>
>Thanks for the explanation.
>Obviously its true as long as you can allocate the skb that big.
>I think you won't realistically be able to get 64K in a
>linear SKB on a busy system, though, is not that right?
>
>OTOH, having large MTU (e.g. 64K) helps performance a lot since it reduces 
>receive side processing overhead.

One thing to keep in mind is while it may help performance in a 
micro-benchmark, the system performance or the QoS impacts to other flows 
can be negatively impacted depending upon implementation.  For example, 
consider multiple messages interleaving (heaven help implementations that 
are not able to interleave multiple messages) on either the transmit or 
receive HCA / RNIC and how the time-to-completion of any message is 
extended out in time as a result of the interleave.  The effective 
throughput in terms of useful units of work can be lower as a result.   The 
same effect can be observed when there are a significant number connections 
in a device being simultaneously processed.

Also, if the copy-checksum is not performed on the processor where the 
application resides, then the performance can also be negatively impacted 
(want to have the right cache hot when initiated or concluded).  While the 
aggregate computational performance of systems may be increasing at a 
significant rate (set aside the per core vs. aggregate core debate), the 
memory performance gains are much less.  If you examine the longer term 
trends, there may be a flattening out of memory performance improvements by 
2009/10 without some major changes in the way controllers and subsystems 
are designed.

Mike 


