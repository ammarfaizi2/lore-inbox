Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWHISeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWHISeS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 14:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbWHISeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 14:34:18 -0400
Received: from helium.samage.net ([83.149.67.129]:22146 "EHLO
	helium.samage.net") by vger.kernel.org with ESMTP id S1751302AbWHISeR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 14:34:17 -0400
Message-ID: <62411.194.109.238.121.1155148442.squirrel@194.109.238.121>
In-Reply-To: <1155132032.12225.65.camel@twins>
References: <20060808193325.1396.58813.sendpatchset@lappy> 
    <20060808193345.1396.16773.sendpatchset@lappy> 
    <42414.81.207.0.53.1155080443.squirrel@81.207.0.53> 
    <44D92B78.20408@google.com> 
    <35608.81.207.0.53.1155124956.squirrel@81.207.0.53> 
    <1155128046.12225.40.camel@twins> 
    <39903.81.207.0.53.1155131329.squirrel@81.207.0.53>
    <1155132032.12225.65.camel@twins>
Date: Wed, 9 Aug 2006 20:34:02 +0200 (CEST)
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
From: "Indan Zupancic" <indan@nul.nu>
To: "Peter Zijlstra" <a.p.zijlstra@chello.nl>
Cc: "Daniel Phillips" <phillips@google.com>, netdev@vger.kernel.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, August 9, 2006 16:00, Peter Zijlstra said:
> On Wed, 2006-08-09 at 15:48 +0200, Indan Zupancic wrote:
>> On Wed, August 9, 2006 14:54, Peter Zijlstra said:
>> > On Wed, 2006-08-09 at 14:02 +0200, Indan Zupancic wrote:
>> >>  That avoids lots of checks and should guarantee that the
>> >> accounting is correct, except in the case when the IFF_MEMALLOC flag is
>> >> cleared and the counter is set to zero manually. Can't that be avoided and
>> >> just let it decrease to zero naturally?
>> >
>> > That would put the atomic op on the free path unconditionally, I think
>> > davem gets nightmares from that.
>>
>> I confused SOCK_MEMALLOC with sk_buff::memalloc, sorry. What I meant was
>> to unconditionally decrement the reserved usage only when memalloc is true
>> on the free path. That way all skbs that increased the reserve also decrease
>> it, and the counter should never go below zero.
>
> OK, so far so good, except we loose the notion of getting memory back
> from regular skbs.

I don't understand this, regular skbs don't have anything to do with
rx_reserve_used as far as I can see. I'm only talking about keeping
that field up to date and correct. rx_reserve_used is only increased
by a skb when memalloc is set to true on that skb, so only if that field
is set rx_reserve_used needs to be reduced when the skb is freed.

Why is it needed for the protocol specific code to call dev_unreserve_skb?

Only problem is if the device can change. rx_reserve_used should probably
be updated when that happens, as a skb can't use reserved memory on a device
it was moved away from. (right?)

>> Also as far as I can see it should be possible to replace all atomic
>> "if (unlikely(dev_reserve_used(skb->dev)))" checks witha check if
>> memalloc is set. That should make davem happy, as there aren't any
>> atomic instructions left in hot paths.
>
> dev_reserve_used() uses atomic_read() which isn't actually a LOCK'ed
> instruction, so that should not matter.

Perhaps, but the main reason to check memalloc instead of using
dev_reserve_used is because the latter doesn't tell which skb did the
reservation.

>> If IFF_MEMALLOC is set new skbs set memalloc and increase the reserve.
>
> Not quite, if IFF_MEMALLOC is set new skbs _could_ get memalloc set. We
> only fall back to alloc_pages() if the regular path fails to alloc. If the
> skb is backed by a page (as opposed to kmem_cache fluff) sk_buff::memalloc
> is set.

Yes, true. But doesn't matter for the rx_reserve_used accounting, as long as
memalloc set means that it did increase rx_reserve_used.

> Also, I've been thinking (more pain), should I not up the reserve for
> each SOCK_MEMALLOC socket.

Up rx_reserve_used or the total ammount of reserved memory? Probably 'no' for
both though, as it's either device specific or skb dependent.

I'm slowly getting a clearer image of the big picture, I'll take another look
when you post the updated code.

Greetings,

Indan


