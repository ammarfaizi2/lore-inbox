Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWHIOE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWHIOE5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 10:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWHIOE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 10:04:57 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:46300 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750860AbWHIOE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 10:04:56 -0400
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Indan Zupancic <indan@nul.nu>
Cc: Daniel Phillips <phillips@google.com>, netdev@vger.kernel.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <39903.81.207.0.53.1155131329.squirrel@81.207.0.53>
References: <20060808193325.1396.58813.sendpatchset@lappy>
	 <20060808193345.1396.16773.sendpatchset@lappy>
	 <42414.81.207.0.53.1155080443.squirrel@81.207.0.53>
	 <44D92B78.20408@google.com>
	 <35608.81.207.0.53.1155124956.squirrel@81.207.0.53>
	 <1155128046.12225.40.camel@twins>
	 <39903.81.207.0.53.1155131329.squirrel@81.207.0.53>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 16:00:32 +0200
Message-Id: <1155132032.12225.65.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 15:48 +0200, Indan Zupancic wrote:
> On Wed, August 9, 2006 14:54, Peter Zijlstra said:
> > On Wed, 2006-08-09 at 14:02 +0200, Indan Zupancic wrote:
> >>  That avoids lots of checks and should guarantee that the
> >> accounting is correct, except in the case when the IFF_MEMALLOC flag is
> >> cleared and the counter is set to zero manually. Can't that be avoided and
> >> just let it decrease to zero naturally?
> >
> > That would put the atomic op on the free path unconditionally, I think
> > davem gets nightmares from that.
> 
> I confused SOCK_MEMALLOC with sk_buff::memalloc, sorry. What I meant was
> to unconditionally decrement the reserved usage only when memalloc is true
> on the free path. That way all skbs that increased the reserve also decrease
> it, and the counter should never go below zero.

OK, so far so good, except we loose the notion of getting memory back
from
regular skbs.

> Also as far as I can see it should be possible to replace all atomic
> "if (unlikely(dev_reserve_used(skb->dev)))" checks witha check if
> memalloc is set. That should make davem happy, as there aren't any
> atomic instructions left in hot paths.

dev_reserve_used() uses atomic_read() which isn't actually a LOCK'ed 
instruction, so that should not matter.

> If IFF_MEMALLOC is set new skbs set memalloc and increase the reserve.

Not quite, if IFF_MEMALLOC is set new skbs _could_ get memalloc set. We
only
fall back to alloc_pages() if the regular path fails to alloc. If the
skb
is backed by a page (as opposed to kmem_cache fluff) sk_buff::memalloc
is set.

> When the skb is being destroyed it doesn't matter if IFF_MEMALLOC is set
> or not, only if that skb used reserves and thus only the memalloc flag
> needs to be checked. This means that changing the IFF_MEMALLOC doesn't
> affect in-flight skbs but only newly created ones, and there's no need to
> update in-flight skbs whenever the flag is changed as all should go well.

Your reasoning is sound, except for these two point above...

<snip code>

> It seems that here SOCK_MEMALLOC is only set on the first socket.
> Shouldn't it be set on all sockets instead?

Ouch, where was my brain... Thanks!

Also, I've been thinking (more pain), should I not up the reserve for
each
SOCK_MEMALLOC socket.

