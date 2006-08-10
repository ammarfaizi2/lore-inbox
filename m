Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030568AbWHJBX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030568AbWHJBX1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 21:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030538AbWHJBX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 21:23:26 -0400
Received: from helium.samage.net ([83.149.67.129]:6845 "EHLO helium.samage.net")
	by vger.kernel.org with ESMTP id S1751445AbWHJBVe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 21:21:34 -0400
Message-ID: <62799.194.109.238.121.1155172885.squirrel@194.109.238.121>
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
Date: Thu, 10 Aug 2006 03:21:25 +0200 (CEST)
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

On Wed, August 9, 2006 21:45, Peter Zijlstra said:
> On Wed, 2006-08-09 at 20:34 +0200, Indan Zupancic wrote:
>> Why is it needed for the protocol specific code to call dev_unreserve_skb?
>
> It uses this to get an indication of memory pressure; if we have
> memalloc'ed skbs memory pressure must be high, hence we must drop all
> non critical packets. But you are right in that this is a problematic
> area; the mapping from skb to device is non trivial.
>
> Your suggestion of testing skb->memalloc might work just as good; indeed
> if we have regressed into the fallback allocator we know we have
> pressure.

You seem to have explained dev_reserve_used usage, not the dev_unreserve_skb calls.
But I've just found -v2 and see that they're gone now, great. -v2 looks much better.

>> Only problem is if the device can change. rx_reserve_used should probably
>> be updated when that happens, as a skb can't use reserved memory on a device
>> it was moved away from. (right?)
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

The point of the reservations is to avoid deadlocks, and they're always big
enough to hold all in-flight skbs, right? So what about solving the whole
device problem by using a global counter and limit instead of per device?

The question is whether traffic on one device can starve traffic on other
devices or not, and how big a problem that is. It probably can, tricky stuff.
Though getting rid of the per device stuff would simplify a lot...

>> > Also, I've been thinking (more pain), should I not up the reserve for
>> > each SOCK_MEMALLOC socket.
>>
>> Up rx_reserve_used or the total ammount of reserved memory? Probably 'no' for
>> both though, as it's either device specific or skb dependent.
>
> I came up with yes, if for each socket you gain a request queue, the
> number of in-flight pages is proportional to the number of sockets.

Yes, seems so.

Good night,

Indan


