Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbVLNSNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbVLNSNJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 13:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbVLNSNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 13:13:09 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:8854 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964797AbVLNSNH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 13:13:07 -0500
Subject: Re: [RFC][PATCH 3/3] TCP/IP Critical socket communication mechanism
From: Sridhar Samudrala <sri@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <1134559039.25663.12.camel@localhost.localdomain>
References: <Pine.LNX.4.58.0512140052470.31720@w-sridhar.beaverton.ibm.com>
	 <1134559039.25663.12.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 10:11:36 -0800
Message-Id: <1134583896.8698.33.camel@w-sridhar2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 11:17 +0000, Alan Cox wrote:
> On Mer, 2005-12-14 at 01:12 -0800, Sridhar Samudrala wrote:
> > Pass __GFP_CRITICAL flag with all allocation requests that are critical.
> > - All allocations needed to process incoming packets are marked as CRITICAL.
> >   This includes the allocations
> >      - made by the driver to receive incoming packets
> >      - to process and send ARP packets
> >      - to create new routes for incoming packets
> 
> But your user space that would add the routes is not so protected so I'm
> not sure this is actually a solution, more of an extended fudge. In
> which case I'm not clear why it is any better than the current
> GFP_ATOMIC approach.

I am not referring to routes that are added by user-space, but the allocations
needed for cached routes stored in skb->dst in ip_route_input() path.

> > +#define SK_CRIT_ALLOC(sk, flags) ((sk->sk_allocation & __GFP_CRITICAL) | flags)
> 
> Lots of hidden conditional logic on critical paths. Also sk should be in
> brackets so that the macro evaluation order is defined as should flags
> 
> > +#define CRIT_ALLOC(flags) (__GFP_CRITICAL | flags)
> 
> Pointless obfuscation

The only reason i made these macros is that i would expect this to a compile
time configurable option so that there is zero overhead for regular users.

#ifdef CONFIG_CRIT_SOCKET
#define SK_CRIT_ALLOC(sk, flags) ((sk->sk_allocation & __GFP_CRITICAL) | flags)
#define CRIT_ALLOC(flags) (__GFP_CRITICAL | flags)
#else
#define SK_CRIT_ALLOC(sk, flags) flags
#define CRIT_ALLOC(flags) flags
#endif

Thanks
Sridhar

