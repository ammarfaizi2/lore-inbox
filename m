Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbWHIUT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbWHIUT4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 16:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWHIUT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 16:19:56 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:44331 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751361AbWHIUTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 16:19:55 -0400
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Indan Zupancic <indan@nul.nu>
Cc: Daniel Phillips <phillips@google.com>, netdev@vger.kernel.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <1155152744.23134.67.camel@lappy>
References: <20060808193325.1396.58813.sendpatchset@lappy>
	 <20060808193345.1396.16773.sendpatchset@lappy>
	 <42414.81.207.0.53.1155080443.squirrel@81.207.0.53>
	 <44D92B78.20408@google.com>
	 <35608.81.207.0.53.1155124956.squirrel@81.207.0.53>
	 <1155128046.12225.40.camel@twins>
	 <39903.81.207.0.53.1155131329.squirrel@81.207.0.53>
	 <1155132032.12225.65.camel@twins>
	 <62411.194.109.238.121.1155148442.squirrel@194.109.238.121>
	 <1155152744.23134.67.camel@lappy>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 22:19:12 +0200
Message-Id: <1155154752.13508.5.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 21:45 +0200, Peter Zijlstra wrote:
> On Wed, 2006-08-09 at 20:34 +0200, Indan Zupancic wrote:

> > Why is it needed for the protocol specific code to call dev_unreserve_skb?
> 
> It uses this to get an indication of memory pressure; if we have
> memalloc'ed skbs memory pressure must be high, hence we must drop all
> non critical packets. But you are right in that this is a problematic
> area; the mapping from skb to device is non trivial.
> 
> Your suggestion of testing skb->memalloc might work just as good; indeed
> if we have regressed into the fallback allocator we know we have
> pressure.
> 
> > Only problem is if the device can change. rx_reserve_used should probably
> > be updated when that happens, as a skb can't use reserved memory on a device
> > it was moved away from. (right?)
> 
> Well yes, this is a problem, only today have I understood how volatile
> the mapping actually is. I think you are right in that transferring the
> accounting from the old to the new device is correct solution.
> 
> However this brings us the problem of limiting the fallback allocator;
> currently this is done in __netdev_alloc_skb where rx_reserve_used it
> compared against rx_reserve. If we transfer accounting away this will
> not work anymore. I'll have to think about this case, perhaps we already
> have a problem here.

Humm, if we do not use dev_reserve_used in the protocols anymore, the
only place that still uses it is the fallback limit. If we could solve
that in another way we might be able to get rid of it all together. That
would save the pain of managing the accounting transferal on skb::dev
assignments too.

Daniel, any ideas? I'm fighting to stay awake... ;-)

