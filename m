Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277230AbRKFBpu>; Mon, 5 Nov 2001 20:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277112AbRKFBpi>; Mon, 5 Nov 2001 20:45:38 -0500
Received: from cogito.cam.org ([198.168.100.2]:40731 "EHLO cogito.cam.org")
	by vger.kernel.org with ESMTP id <S277230AbRKFBp2>;
	Mon, 5 Nov 2001 20:45:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] vm_swap_full
Date: Mon, 5 Nov 2001 07:37:59 -0500
X-Mailer: KMail [version 1.3.2]
Cc: Mike Fedyk <mfedyk@matchmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011105123800.07D741126F@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Think of it this way.  nr_swap_pages is the ammount of space
available for new swap pages.  nr inactive pages is the ammount
of pages we know that just might get swapped - so we want to be
sure we keep space in swap for them.  The logic I am trying to
implement is to switch to aggressive swap (reclaim the swap space
at page in) when we are in at risk of filling swap.  IMO we
do not way to reclaim until we have too, as there are gains to
be had if we page in a page,it does not get changed and we have
memory pressure.  

The test as it stood would be fine for machines with small swap.
Some applications (SAP for instance) recommend swap as 3 x memory.
If you have 2G memory and 6G swap it does not make much sense to
start unmapping swap pages at swap in when you have only 3G in
swap.  It does make sense to do this when you have less than
600M of free swap pages.  Problem is to decide what is a reasonable
threshold.  Since the inactive list is what can get swapped out,
using its size as the metric makes sense.

Ed Tomlinson 

Mike Fedyk wrote:

> On Sun, Nov 04, 2001 at 09:58:17PM -0500, Ed Tomlinson wrote:
>> On November 4, 2001 09:08 pm, Mike Fedyk wrote:
>> > On Sun, Nov 04, 2001 at 02:36:34PM -0200, Rik van Riel wrote:
>> > > On Sun, 4 Nov 2001, Ed Tomlinson wrote:
>> > > > -/* Swap 50% full? Release swapcache more aggressively.. */
>> > > > -#define vm_swap_full() (nr_swap_pages*2 < total_swap_pages)
>> > > > +/* Free swap less than inactive pages? Release swapcache more
>> > > > aggressively.. */ +#define vm_swap_full() (nr_swap_pages <
>> > > > nr_inactive_pages)
>> > > >
>> > > > Comments?
>> > >
>> > > Makes absolutely no sense for systems which have more
>> > > swap than RAM, eg. a 64MB system with 200MB of swap.
>> >
>> > How does the inactive list get bigger than physical ram?
>> >
>> > If swap is bigger than ram, there is *no* possibility of the inactive
>> > list being bigger than swap, and thus no aggressive swapping...
>> 
>> nr_swap_pages is the number of swap pages free.
> 
> Oh, I thought it was total swap pages...
> 
>>The idea is to start
>> aggressive swap only when we are at risk of running out of swap.  This
>> way we get to take full advantage of throwing away clean pages that are
>> backed up by swap when under vm pressure.
>> 
> Yes.  My point is that the inactive list can't get bigger than RAM, and
> thus if swap is bigger than ram this case wouldn't trigger...
> 
> But now that nr_swap_pages is *free* swap, you'll have to add another test
> for (swap > RAM)...
> 
> Mike
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
