Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbVJGLbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbVJGLbp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 07:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbVJGLbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 07:31:45 -0400
Received: from nproxy.gmail.com ([64.233.182.200]:4988 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751310AbVJGLbo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 07:31:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UWh6taqAQNv3+BjjDguivt6cSiNreOkd+0eFA41v2IzlxtPM+0cPhenBCMFlWoz1AklGtp0F0gCm/tT84kCHRmPduyqudCsmlNqGVqJXXhPL4XWKgWCpZtvUJGcGOWKGZ7U1AgXa2SSRlK9NluN9gxtCoOBpJSfkInMWjbHwZUs=
Message-ID: <84144f020510070431n3b18250eo9d4777844a448b8a@mail.gmail.com>
Date: Fri, 7 Oct 2005 14:31:42 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
Reply-To: Pekka Enberg <penberg@cs.helsinki.fi>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] vm - swap_prefetch-15
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
In-Reply-To: <200510072054.11145.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200510070001.01418.kernel@kolivas.org>
	 <84144f020510070303u13872f33hb4a40451acea4d5a@mail.gmail.com>
	 <200510072054.11145.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/7/05, Con Kolivas <kernel@kolivas.org> wrote:
> Good point, thanks! Any and all feedback is appreciated.

Well, since you asked :-)

> +/*
> + * How many pages to prefetch at a time. We prefetch SWAP_CLUSTER_MAX *
> + * swap_prefetch per PREFETCH_INTERVAL, but prefetch ten times as much at a
> + * time in laptop_mode to minimise the time we keep the disk spinning.
> + */
> +#define PREFETCH_PAGES()     (SWAP_CLUSTER_MAX * swap_prefetch * \
> +                                     (1 + 9 * laptop_mode))

This looks strange. Please either drop the parenthesis from PREFETCH_PAGES or
make it a real static inline function.

> +/*
> + * Find the zone with the most free pages, recheck the watermarks and
> + * then directly allocate the ram. We don't want prefetch to use
> + * __alloc_pages and go calling on reclaim.
> + */
> +static struct page *prefetch_get_page(void)
> +{

Should this be put in mm/page_alloc.c? It is, after all, a special-purpose
page allocator. That way you wouldn't have to export zone_statistics and
buffered_rmqueue.

> +/*
> + * trickle_swap is the main function that initiates the swap prefetching. It
> + * first checks to see if the busy flag is set, and does not prefetch if it
> + * is, as the flag implied we are low on memory or swapping in currently.
> + * Otherwise it runs till PREFETCH_PAGES() are prefetched.
> + * This function returns 1 if it succeeds in a cycle of prefetching, 0 if it
> + * is interrupted or -1 if there is nothing left to prefetch.
> + */
> +static int trickle_swap(void)
> +{

This could perhaps use a three-state enum as return value. I find return value
checks in kprefetchd() slightly confusing.

                                Pekka
