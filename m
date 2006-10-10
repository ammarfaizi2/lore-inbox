Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWJJRqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWJJRqo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWJJRqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:46:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1720 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751050AbWJJRqn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:46:43 -0400
Date: Tue, 10 Oct 2006 10:43:15 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, openib-general@openib.org,
       Roland Dreier <rolandd@cisco.com>
Subject: Re: Dropping NETIF_F_SG since no checksum feature.
Message-ID: <20061010104315.61540986@freekitty>
In-Reply-To: <20061010144330.GA28175@mellanox.co.il>
References: <20061009095051.38ed9f22@freekitty>
	<20061010144330.GA28175@mellanox.co.il>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 16:43:30 +0200
"Michael S. Tsirkin" <mst@mellanox.co.il> wrote:

> Quoting r. Stephen Hemminger <shemminger@osdl.org>:
> > Subject: Re: Dropping NETIF_F_SG since no checksum feature.
> > 
> > On Mon, 9 Oct 2006 19:47:05 +0200
> > "Michael S. Tsirkin" <mst@mellanox.co.il> wrote:
> > 
> > > Hi!
> > > I'm trying to build a network device driver supporting a very large MTU (around 64K)
> > > on top of an infiniband connection, and I've hit a couple of issues I'd
> > > appreciate some feedback on:
> > > 
> > > 1. On the send side,
> > >    I've set NETIF_F_SG, but hardware does not support checksum offloading,
> > >    and I see "dropping NETIF_F_SG since no checksum feature" warning,
> > >    and I seem to be getting large packets all in one chunk.
> > >    The reason I've set NETIF_F_SG, is because I'm concerned that under real life
> > >    stress Linux won't be able to allocate 64K of continuous memory.
> > > 
> > >    Is this concern of mine valid? I saw in-tree drivers allocating at least 8K.
> > >    What's the best way to enable S/G on send side?
> > >    Is checksum offloading really required for S/G?
> > 
> > Yes, in the current implementation, Linux needs checksum offload. But there
> > is no reason, your driver can't compute the checksum in software.
>
> Are there drivers that do this already? Couldn't find any such beast ...

dev_queue_xmit() does it, all you need to do in your driver is:
	
	/* If packet is not checksummed and device does not support
	 * checksumming for this protocol, complete checksumming here.
	 */
	if (skb->ip_summed == CHECKSUM_PARTIAL) {
	      	if (skb_checksum_help(skb))
	      		goto error_recovery
	}


> I'm worried whether an extra pass over data won't eat up all of
> the performance gains I get from the large MTU ...

Yup, the cost is in touching the data, not in the copy.

> > >    What are the helpers legal for fragmented skb?
> 
> BTW, I found skb_put_frags in sky2 which seems generic enough - I even wander
> why isn't this in net/core.
> 

Only because I just wrote it for my needs. If you need it, then it
can be moved to skbuff.c



-- 
Stephen Hemminger <shemminger@osdl.org>
