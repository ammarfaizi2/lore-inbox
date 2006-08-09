Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWHIM6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWHIM6a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 08:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWHIM6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 08:58:30 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:54740 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750739AbWHIM62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 08:58:28 -0400
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Indan Zupancic <indan@nul.nu>
Cc: Daniel Phillips <phillips@google.com>, netdev@vger.kernel.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <35608.81.207.0.53.1155124956.squirrel@81.207.0.53>
References: <20060808193325.1396.58813.sendpatchset@lappy>
	 <20060808193345.1396.16773.sendpatchset@lappy>
	 <42414.81.207.0.53.1155080443.squirrel@81.207.0.53>
	 <44D92B78.20408@google.com>
	 <35608.81.207.0.53.1155124956.squirrel@81.207.0.53>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 14:54:06 +0200
Message-Id: <1155128046.12225.40.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 14:02 +0200, Indan Zupancic wrote:
> On Wed, August 9, 2006 2:25, Daniel Phillips said:
> >  .... We want the atomic op that some people call
> > "monus": decrement unless zero.
> 
> Currently atomic_inc_not_zero(), atomic_add_unless() and atomic_cmpxchg()
> exist, so making an atomic_dec_not_zero() should be easy.

atomic_add_unless() - will nicely do, thanks.

> I'm not sure, to me it looks like dev_unreserve_skb() is always called
> without really knowing if it is justified or not, or else there wouldn't
> be a chance that the counter became negative. So avoiding the negative
> reserve usage seems like papering over bad accounting.

It was indeed called too often it seems, once when deciding to drop the
skb
and again then actually freeing the skb.

> The assumption made seems to be that if there's reserve used, then it must
> be us using it, and it's unreserved. So it appears that either that
> assumption is wrong, and we can unreserve for others while we never
> reserved for ourselves, or it is correct, in which case it probably makes
> more sense to check for the IFF_MEMALLOC flag.

Changed it to only dec_not_zero on free for IFF_MEMALLOC devices.
I'm thinking of making kfree_skbmem -> skb_release_data return whether
they
released the actual data and also depend on that.

> All in all it seems like a per skb flag which tells us if this skb was the
> one reserving anything is missing.

struct sk_buff::memalloc

However the idea is that freeing non memalloc skbs also returns memory
(albeit
to the slab and not the free page list).

>  Or rx_reserve_used must be updated for
> all in flight skbs whenever the IFF_MEMALLOC flag changes, so that we can
> be sure that the accounting works correctly. 

Yes

> Oh wait, isn't that what the
> memalloc flag is for? So shouldn't it be sufficient to check only with
> sk_is_memalloc()?

See previous comment.

>  That avoids lots of checks and should guarantee that the
> accounting is correct, except in the case when the IFF_MEMALLOC flag is
> cleared and the counter is set to zero manually. Can't that be avoided and
> just let it decrease to zero naturally?

That would put the atomic op on the free path unconditionally, I think
davem
gets nightmares from that.

Thanks

