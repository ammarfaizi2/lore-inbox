Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261590AbSKLP2m>; Tue, 12 Nov 2002 10:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261605AbSKLP2m>; Tue, 12 Nov 2002 10:28:42 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:35750 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261590AbSKLP2m>; Tue, 12 Nov 2002 10:28:42 -0500
Subject: Re: [PATCH] [RFC] increase MAX_ADDR_LEN
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roland Dreier <roland@topspin.com>
Cc: "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <521y5qn7l5.fsf@topspin.com>
References: <Pine.LNX.4.44.0211111808240.1236-100000@localhost.localdomain>
	<20021111.151929.31543489.davem@redhat.com> <52r8drn0jk.fsf_-_@topspin.com>
	<20021111.153845.69968013.davem@redhat.com>
	<1037060322.2887.76.camel@irongate.swansea.linux.org.uk>
	<52isz3mza0.fsf@topspin.com>
	<1037111029.8321.12.camel@irongate.swansea.linux.org.uk> 
	<521y5qn7l5.fsf@topspin.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Nov 2002 16:00:36 +0000
Message-Id: <1037116836.8500.55.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-12 at 15:14, Roland Dreier wrote:
> Hmm... the problem I would like to solve is that IP-over-InfiniBand
> has 20 byte hardware addresses.  One can implement a driver that lies
> about its HW address len (you have an internal ARP cache and only
> expose a hash value/cookie to the rest of the world).  In fact I've
> done just that for IPoIB.

Our ARP code handles AX.25 fine, and that can include long addresses, so
either we have a live bug or it works 8). The multicast layer does have
problems with addresses over 8 bytes (MAX_ADDR_LEN).

> It works but it's ugly and overly complex.  I would like to find a
> clean solution for 2.5/2.6, but it looks like it will require changes
> to the net core.  I'd like to do those now so the IPoIB driver can
> just drop in cleanly later.  (I want to be able to just add
> drivers/infiniband during 2.6 without and invasive changes required)

I think you need to do two things.

1. Increase MAX_ADDR_LEN
2. Add some new address setting ioctls, and ensure the old ones keep the
old address length limit. That is needed because the old caller wont
have allocated enough address space for a 20 byte address return.

You have to solve both though, and the first patch should probably be
the one to add more sensible address set/get functions.

