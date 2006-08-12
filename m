Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbWHLRp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWHLRp6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 13:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbWHLRp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 13:45:58 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:46502 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S964919AbWHLRp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 13:45:57 -0400
Subject: Re: [RFC][PATCH 3/4] deadlock prevention core
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Indan Zupancic <indan@nul.nu>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>
In-Reply-To: <44640.81.207.0.53.1155403862.squirrel@81.207.0.53>
References: <20060812141415.30842.78695.sendpatchset@lappy>
	 <20060812141445.30842.47336.sendpatchset@lappy>
	 <44640.81.207.0.53.1155403862.squirrel@81.207.0.53>
Content-Type: text/plain
Date: Sat, 12 Aug 2006 19:44:56 +0200
Message-Id: <1155404697.13508.81.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-12 at 19:31 +0200, Indan Zupancic wrote:
> On Sat, August 12, 2006 16:14, Peter Zijlstra said:
> > +struct sk_buff *__alloc_skb(unsigned int size, gfp_t gfp_mask, int fclone)
> > +{
> > +	struct sk_buff *skb;
> > +
> > +	skb = ___alloc_skb(size, gfp_mask & ~__GFP_MEMALLOC, fclone);
> > +
> > +	if (!skb && (gfp_mask & __GFP_MEMALLOC) && memalloc_skbs_available())
> > +		skb = ___alloc_skb(size, gfp_mask, fclone);
> > +
> > +	return skb;
> > +}
> > +
> 
> I'd drop the memalloc_skbs_available() check, as that's already done by
> ___alloc_skb.

Right, thanks. Hmm, its the last occurence of that function, even
better.

> > +static DEFINE_SPINLOCK(memalloc_lock);
> > +static int memalloc_socks;
> > +static unsigned long memalloc_reserve;
> 
> Why is this a long? adjust_memalloc_reserve() takes an int.

Euhm, right :-) long comes naturaly when I think about quantities op
pages. The adjust_memalloc_reserve() argument is an increment, a delta;
perhaps I should change that to long.

> Is it needed at all, considering var_free_kbytes already exists?

Having them separate would allow ajust_memalloc_reserve() to be used by
other callers too (would need some extra locking).

