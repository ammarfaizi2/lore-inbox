Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWHHFcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWHHFcF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 01:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWHHFcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 01:32:04 -0400
Received: from possum.icir.org ([192.150.187.67]:14857 "EHLO possum.icir.org")
	by vger.kernel.org with ESMTP id S1750832AbWHHFcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 01:32:04 -0400
Message-Id: <200608080531.k785VxYL077237@possum.icir.org>
To: David Miller <davem@davemloft.net>
cc: pavlin@icir.org, linux-kernel@vger.kernel.org, roland@topspin.com
Subject: Re: Bug in the RTM_SETLINK kernel API for setting MAC address 
In-Reply-To: Message from David Miller <davem@davemloft.net> 
   of "Mon, 07 Aug 2006 20:48:10 PDT." <20060807.204810.11384152.davem@davemloft.net> 
Date: Mon, 07 Aug 2006 22:31:59 -0700
From: Pavlin Radoslavov <pavlin@icir.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Note that the payload with the MAC address has to be
> > "struct sockaddr" (or equivalent) and the length of that payload is
> > the equivalent of "sizeof(sa_family) + mac_address_size".
> 
> It should just be the MAC address, that's why the kernel side
> is coded the way it is.

I couldn't find any documentation about the API, so I wasn't sure
whether it is actually suppose to be the MAC address or "sockaddr".

In fact, earlier version of our userland code was assuming it
is just the MAC address, until we found that it doesn't work on
recent kernels.

> Where does this sockaddr come from?

The set_mac_address() functions for each network device driver make
that assumption:

static int set_mac_address(struct net_device *dev, void *p)
{
        int i;
        struct sockaddr *addr = p;

> I don't see how it could work with the sockaddr there in
> 2.6.17, as 2.6.17 makes the same exact length check:
> 
> 		if (ida[IFLA_ADDRESS - 1]->rta_len != RTA_LENGTH(dev->addr_len))
> 			goto out;

Note that in my example rta_len was tweaked to match the MAC address
size, but the the payload itself and the netlink message nlmsg_len
actually match the sockaddr alignment.

The real mismatch is that ida[IFLA_ADDRESS - 1] is (as you say)
suppose to be a MAC address, but the set_mac_address() functions
for each device assume that the RTA_DATA(ida[IFLA_ADDRESS - 1])
payload is a sockaddr.

Pavlin
