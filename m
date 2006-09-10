Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWIJXpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWIJXpv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 19:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWIJXpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 19:45:51 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:43424 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S964827AbWIJXpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 19:45:50 -0400
Date: Mon, 11 Sep 2006 01:45:09 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andy Whitcroft <apw@shadowen.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] linear reclaim core
Message-ID: <20060910234509.GB10482@wohnheim.fh-wedel.de>
References: <exportbomb.1157718286@pinky> <20060908122718.GA1662@shadowen.org> <20060908114114.87612de3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060908114114.87612de3.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 September 2006 11:41:14 -0700, Andrew Morton wrote:
> 
> I'm somewhat surprised at the implementation.  Would it not be sufficient
> to do this within shrink_inactive_list()?  Something along the lines of:
> 
> - Pick tail page off LRU.
> 
> - For all "neighbour" pages (alignment == 1<<order, count == 1<<order)
> 
>   - If they're all PageLRU and !PageActive, add them all to page_list for
>     possible reclaim
> 
> And, in shrink_active_list:
> 
> - Pick tail page off LRU
> 
> - For all "neighbour" pages (alignment == 1<<order, count == 1<<order)
> 
>   If they're all PageLRU, put all the active pages in this block onto
>   l_hold for possible deactivation.

Hmm.  Trying to shoot holes into your approach, I find two potential
problems:
A) With sufficient fragmentation, all inactive pages have one active
neighbour, so shrink_inactive_list() will never find a cluster of the
required order.
B) With some likelihood, shrink_active_list() will pick neighbours
which happen to be rather hot pages.  They get freed, only to get
paged in again within little more than rotational latency.

How about something like:
1. Free 1<<order pages from the inactive list.
2. Pick a page cluster of requested order.
3. Move all pages from the cluster to the just freed pages.

[ Disclaimer: I just started dabbling in mm after Andi Kleen's
presentation on Linux Kongress on friday.  My tiny gem of knowledge,
if present at all, might be well hidden in the ignorance of an
mm-newbie. ]

Jörn

-- 
It's not whether you win or lose, it's how you place the blame.
-- unknown
