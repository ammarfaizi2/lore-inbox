Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965197AbWJKJGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965197AbWJKJGS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 05:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965204AbWJKJGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 05:06:18 -0400
Received: from dev.mellanox.co.il ([194.90.237.44]:25218 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S965197AbWJKJGQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 05:06:16 -0400
Date: Wed, 11 Oct 2006 11:05:04 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: David Miller <davem@davemloft.net>
Cc: shemminger@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       openib-general@openib.org, rolandd@cisco.com
Subject: Re: Dropping NETIF_F_SG since no checksum feature.
Message-ID: <20061011090504.GC2938@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20061010.191547.83619974.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010.191547.83619974.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. David Miller <davem@davemloft.net>:
> Subject: Re: Dropping NETIF_F_SG since no checksum feature.
> 
> From: "Michael S. Tsirkin" <mst@mellanox.co.il>
> Date: Wed, 11 Oct 2006 02:13:38 +0200
> 
> > Maybe I can patch linux to allow SG without checksum?
> > Dave, maybe you could drop a hint or two on whether this is worthwhile
> > and what are the issues that need addressing to make this work?
> > 
> > I imagine it's not just the matter of changing net/core/dev.c :).
> 
> You can't, it's a quality of implementation issue.  We sendfile()
> pages directly out of the filesystem page cache without any
> blocking of modifications to the page contents, and the only way
> that works is if the card computes the checksum for us.
> 
> If we sendfile() a page directly, we must compute a correct checksum
> no matter what the contents.  We can't do this on the cpu before the
> data hits the device because another thread of execution can go in and
> modify the page contents which would invalidate the checksum and thus
> invalidating the packet.  We cannot allow this.
> 
> Blocking modifications is too expensive, so that's not an option
> either.
> 

But copying still works fine, does it not?
Dave, could you clarify this please?

ssize_t tcp_sendpage(struct socket *sock, struct page *page, int offset,
                     size_t size, int flags)
{
        ssize_t res;
        struct sock *sk = sock->sk;

        if (!(sk->sk_route_caps & NETIF_F_SG) ||
            !(sk->sk_route_caps & NETIF_F_ALL_CSUM))
                return sock_no_sendpage(sock, page, offset, size, flags);


So, it seems that if I set NETIF_F_SG but clear NETIF_F_ALL_CSUM,
data will be copied over rather than sent directly.
So why does dev.c have to force set NETIF_F_SG to off then?

-- 
MST
