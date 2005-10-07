Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbVJGMIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbVJGMIN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 08:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbVJGMIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 08:08:13 -0400
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:23958 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932382AbVJGMIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 08:08:12 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH] vm - swap_prefetch-15
Date: Fri, 7 Oct 2005 22:08:01 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
References: <200510070001.01418.kernel@kolivas.org> <200510072054.11145.kernel@kolivas.org> <84144f020510070431n3b18250eo9d4777844a448b8a@mail.gmail.com>
In-Reply-To: <84144f020510070431n3b18250eo9d4777844a448b8a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510072208.01357.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Oct 2005 21:31, Pekka Enberg wrote:
> Hi,
>
> On 10/7/05, Con Kolivas <kernel@kolivas.org> wrote:
> > Good point, thanks! Any and all feedback is appreciated.
>
> Well, since you asked :-)
>
> > +/*
> > + * How many pages to prefetch at a time. We prefetch SWAP_CLUSTER_MAX *
> > + * swap_prefetch per PREFETCH_INTERVAL, but prefetch ten times as much
> > at a + * time in laptop_mode to minimise the time we keep the disk
> > spinning. + */
> > +#define PREFETCH_PAGES()     (SWAP_CLUSTER_MAX * swap_prefetch * \
> > +                                     (1 + 9 * laptop_mode))
>
> This looks strange. Please either drop the parenthesis from PREFETCH_PAGES
> or make it a real static inline function.

I have seen this sort of macro style before in the kernel where () just makes 
it clear that it is a function but a real static inline is ok with me.

> > +/*
> > + * Find the zone with the most free pages, recheck the watermarks and
> > + * then directly allocate the ram. We don't want prefetch to use
> > + * __alloc_pages and go calling on reclaim.
> > + */
> > +static struct page *prefetch_get_page(void)
> > +{
>
> Should this be put in mm/page_alloc.c? It is, after all, a special-purpose
> page allocator. That way you wouldn't have to export zone_statistics and
> buffered_rmqueue.

Makes sense but it is only used in the CONFIG_SWAP_PREFETCH case so it would 
end up as a static inline in swap.h to avoid ending being #ifdefed in 
page_alloc.c. Do you think that's preferable to having it in 
swap_prefetch.c ?

>
> > +/*
> > + * trickle_swap is the main function that initiates the swap
> > prefetching. It + * first checks to see if the busy flag is set, and does
> > not prefetch if it + * is, as the flag implied we are low on memory or
> > swapping in currently. + * Otherwise it runs till PREFETCH_PAGES() are
> > prefetched.
> > + * This function returns 1 if it succeeds in a cycle of prefetching, 0
> > if it + * is interrupted or -1 if there is nothing left to prefetch.
> > + */
> > +static int trickle_swap(void)
> > +{
>
> This could perhaps use a three-state enum as return value. I find return
> value checks in kprefetchd() slightly confusing.

Good idea.

Thanks!
Con
