Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265855AbTGACcr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 22:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265877AbTGACcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 22:32:46 -0400
Received: from holomorphy.com ([66.224.33.161]:53931 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265855AbTGACcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 22:32:45 -0400
Date: Mon, 30 Jun 2003 19:46:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.73-mm2
Message-ID: <20030701024659.GD26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030627202130.066c183b.akpm@digeo.com> <20030701003958.GB20413@holomorphy.com> <20030630191456.1aef22e0.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030630191456.1aef22e0.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>>  @@ -217,9 +217,9 @@ void out_of_memory(void)
>>   	unsigned long now, since;
>>   
>>   	/*
>>  -	 * Enough swap space left?  Not OOM.
>>  +	 * Enough swap space and ZONE_NORMAL left?  Not OOM.
>>   	 */
>>  -	if (nr_swap_pages > 0)
>>  +	if (nr_swap_pages > 0 && nr_free_buffer_pages() + nr_used_low_pages() > 0)
>>   		return;

On Mon, Jun 30, 2003 at 07:14:56PM -0700, Andrew Morton wrote:
> a) if someone is trying to allocate some ZONE_DMA pages and there are
>    still swappable or free ZONE_NORMAL pages, nobody gets killed.

This is yet another problem for the method above. =(


On Mon, Jun 30, 2003 at 07:14:56PM -0700, Andrew Morton wrote:
> b) If there are free ZONE_NORMAL pages then why on earth did we call
>    out_of_memory()?  Does nr_free_buffer_pages() ever return non-zero in
>    here?  It will do so for a ZONE_DMA allocation, but you're not doing
>    them...

Allocations will enter this path if free memory is below the minimum
page thresholds, since the allocation will be sort of artificially
failed. Basically, with this in place it's more likely to livelock than
to go on killing sprees. There's a small amount of empirical evidence
suggesting this avoids livelocking in some common scenarios, though
that really isn't good enough for this kind of affair.


On Mon, Jun 30, 2003 at 07:14:56PM -0700, Andrew Morton wrote:
> Generally, I'm thinking that this test should just be removed.  It is
> the responsibility of try_to_free_pages() to work out whether the
> allocation can succeed.
> If try_to_free_pages() calls out_of_memory() when there are still
> swappable, reclaimable or free pages in the relevant zones then
> try_to_free_pages() goofed, and needs mending.  out_of_memory()
> shouldn't be cleaning up after try_to_free_pages()'s mistakes.
> I have a bad feeling that it _will_ goof.  A long time ago I looked
> at the amount of scanning we're doing in there and decided that it
> was way overkill and reduced it by a lot.  I may have gone overboard.  
> So how's about I and thy take that test out, see how things get along?

I'm not particularly attached to the method, only the result, so I'm game.


-- wli
