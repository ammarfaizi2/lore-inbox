Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269214AbTGJLMc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 07:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269211AbTGJLLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 07:11:33 -0400
Received: from holomorphy.com ([66.224.33.161]:18865 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S269206AbTGJLL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 07:11:28 -0400
Date: Thu, 10 Jul 2003 04:27:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm3 OOM killer fubared ?
Message-ID: <20030710112728.GX15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Miquel van Smoorenburg <miquels@cistron.nl>,
	linux-kernel@vger.kernel.org
References: <bejhrj$dgg$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bejhrj$dgg$1@news.cistron.nl>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 11:14:59AM +0000, Miquel van Smoorenburg wrote:
> Enough memory free, no problems at all .. yet every few minutes
> the OOM killer kills one of my innfeed processes.
> I notice that in -mm3 this was deleted relative to -vanilla:
> 
> -
> -       /*
> -        * Enough swap space left?  Not OOM.
> -        */
> -       if (nr_swap_pages > 0)
> -               return;
> .. is that what causes this ? In any case, that should't vene matter -
> there's plenty of memory in this box, all buffers and cached, but that
> should be easily freed ..

This means we're calling into it more often than we should be.
Basically, we hit __alloc_pages() with __GFP_WAIT set, find nothing
we're allowed to touch, dive into try_to_free_pages(), fall through
scanning there, sleep in blk_congestion_wait(), wake up again, try
to shrink_slab(), find nothing there either, repeat that 11 more times,
and then fall through to out_of_memory()... and this happens at at
least 10Hz.

        since = now - lastkill;
        if (since < HZ*5)
                goto out_unlock;

try s/goto out_unlock/goto reset/ and let me know how it goes.


-- wli
