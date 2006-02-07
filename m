Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWBGB24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWBGB24 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 20:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWBGB24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 20:28:56 -0500
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:25731 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932393AbWBGB2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 20:28:55 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] mm: implement swap prefetching
Date: Tue, 7 Feb 2006 12:29:25 +1100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, ck@vds.kolivas.org
References: <200602071028.30721.kernel@kolivas.org> <20060206163842.7ff70c49.akpm@osdl.org>
In-Reply-To: <20060206163842.7ff70c49.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071229.25793.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2006 11:38 am, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> > After you removed it from -mm there were some people that described
> > the benefits it afforded their workloads. -mm being ever so slightly
> > quieter at the moment please reconsider.
>
> I wish I could convince myself this is sufficiently beneficial..
>
> I've been running 2.6.15-rc2-mm2 on my main workstation (x86, 2G) since
> whenever.  (Am lazy, haven't gotten around to upgrading that machine).  It
> has swap prefetch.

Tons of ram, no swapping maybe?

> I can't say I noticed any difference, although I did turn it off in /proc a
> few reboots ago because it was irritating me for some reason which I forget
> (sorry).

It could be the intermittent way it was actually doing any prefetching. It 
ticks the drive over every second. I'll change this. 

> One thing about 2.6.15-rc2-mm2 is that the `so' and `si' columns in
> `vmstat' always read zero.  I don't know whether that bug is due to the
> prefetch patch or not.

so and si work fine here and are the main way I watch if it has started 
prefetching.

>
> > The amount prefetched in each group is configurable via the tunable in
> > /proc/sys/vm/swap_prefetch. This is set to a value based on memory size.
> > When laptop_mode is enabled it prefetches in ten times larger blocks to
> > minimise the time spent reading.
>
> That's incomprehensible, sorry.
>
> I think it'd be much clearer if the thing was called swap_prefetch_kbytes
> or swap_prefetch_mbytes or (worse) swap_prefetch_pages - putting the units
> in the name really helps clarify things.
>
> And if such a change is made, the internal variable should also be renamed.
>  Right now it's "swap_prefetch", which sounds like a boolean.

I might just change it to a boolean and be done with.

>
> > +swap_prefetch
> > +
> > +This is the amount of data prefetched per prefetching interval when
> > +swap prefetching is compiled in. The value means multiples of 128K,
> > +except when laptop_mode is enabled and then it is ten times larger.
> > +Setting it to 0 disables prefetching entirely.
>
> What does "ten times larger" mean?  If laptop_mode, this thing is in units
> of 1280 kbytes and if !laptop_mode it's in units of 128 kbytes?
>
> If so (or if not), this tunable is quite obscure and hard-to-understand.
> Can you find a way to make this more user-friendly?

Changing it to on or off should fix that. I'll blow the idea that you can set 
the amount to prefetch, and I'll just change it to - on: prefetch till ram is 
sufficiently full or we run out of pages to prefetch.

[ack snipped comments]

> > +/* Last total free pages */
> > +static unsigned long last_free = 0;
> > +static unsigned long temp_free = 0;
>
> Unneeded initialisation.

Very first use of both of these variables depends on them being initialised.

> > +	if (unlikely(!spin_trylock(&swapped.lock)))
> > +		goto out;
>
> hm, spin_trylock() should internally do unlikely(), but it doesn't.  (It's
> a bit of a mess, too).

Good point. Perhaps I should submit a separate patch for this instead.

[ack other snipped points]

> > +		/* Select the zone with the most free ram preferring high */
> > +		if ((free > most_free && (!high_zone(zone) || high_zone(z))) ||
> > +			(!high_zone(zone) && high_zone(z))) {
> > +				most_free = free;
> > +				zone = z;
> > +		}
> > +	}
>
> <stares at the above expression for three minutes>
>
> I think it'll always select ZONE_HIGHMEM no matter what.  Users of 1G x86
> boxes not happy.

Rethink in order..

> > +static inline unsigned long prefetch_pages(void)
> > +{
> > +	return (SWAP_CLUSTER_MAX * swap_prefetch * (1 + 9 * !!laptop_mode));
> > +}
>
> I don't think this should be done in-kernel.  There's a nice script to
> start and stop laptop mode.  We can make this decision in that script.

Will be unnecessary as I'm blowing away the idea of scaling the amount of 
pages to prefetch.

> > +	if (last_free) {
> > +		if (temp_free + SWAP_CLUSTER_MAX < last_free) {
> > +			last_free = temp_free;
> > +			goto out;
> > +		}
> > +	} else
> > +		last_free = temp_free;
>
> What is the actual threshold rate here?
> SWAP_CLUSTER_MAX/(how fast your CPU is)?  Seems a bit vague?

temp_free is the total amount of free pages in all zones at the moment. 

If SWAP_CLUSTER_MAX pages have been allocated since we last called 
prefetch_suitable it returns that prefetching is unsuitable.

> > +	get_page_state(&ps);
>
> get_page_state() can be super-expensive.  How frequently is this called?

It will call this only if the system is very idle for at least 5 seconds. 
However once it starts doing the actual prefetching it calls it regularly 
when every page is prefetched, but only if the system remains idle. If 
there's pretty much anything else going on it won't hit this.

> > +		case TRICKLE_SUCCESS:
> > +			last_free = temp_free;
>
> This `last_free' thing is really confusing.  It's central to the algorithms
> yet its name is largely meaningless.  last_free *what*?  It seems to mean
> "total number of free pages on the last prefetching pass", yes?  Wanna
> think of a better name and a better comment for it?

Yes that's what it means. I'll have a renaming rethink and spray more comments 
around.

Thanks very much for your patch reviewing and comments!

I'll rework it, thrash it around a bit here and resubmit.

Cheers,
Con
