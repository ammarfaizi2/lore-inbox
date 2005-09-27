Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbVI0HVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbVI0HVG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 03:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbVI0HVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 03:21:06 -0400
Received: from nproxy.gmail.com ([64.233.182.193]:4836 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964845AbVI0HVF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 03:21:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fCYGZPnv8Ib4BTnYdesuDgmHWI+HiWZOY4wp1JZPvXV0rE1puyCyuyzfVlKP5RPlOsvcjDDi64e1k96xzbXb1n/wjUTL/w2b9dJh/2Xp0e+jMIM03+YDQZeU5Fltobv9hQyttT6uv6AaXz6+nDQCt4PcNMuOXEufeq1/KgLpW+w=
Message-ID: <2cd57c90050927002163f78269@mail.gmail.com>
Date: Tue, 27 Sep 2005 15:21:03 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Joel Schopp <jschopp@austin.ibm.com>
Subject: Re: [PATCH 7/9] try harder on large allocations
Cc: Andrew Morton <akpm@osdl.org>, lhms <lhms-devel@lists.sourceforge.net>,
       Linux Memory Management List <linux-mm@kvack.org>,
       linux-kernel@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>,
       Mike Kravetz <kravetz@us.ibm.com>
In-Reply-To: <433856B2.8030906@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4338537E.8070603@austin.ibm.com> <433856B2.8030906@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/05, Joel Schopp <jschopp@austin.ibm.com> wrote:
> Fragmentation avoidance patches increase our chances of satisfying high order
> allocations.  So this patch takes more than one iteration at trying to fulfill
> those allocations because unlike before the extra iterations are often useful.
>
> Signed-off-by: Mel Gorman <mel@csn.ul.ie>
> Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
>
>
> Index: 2.6.13-joel2/mm/page_alloc.c
> ===================================================================
> --- 2.6.13-joel2.orig/mm/page_alloc.c   2005-09-21 11:13:14.%N -0500
> +++ 2.6.13-joel2/mm/page_alloc.c        2005-09-21 11:14:49.%N -0500
> @@ -944,7 +944,8 @@ __alloc_pages(unsigned int __nocast gfp_
>         int can_try_harder;
>         int did_some_progress;
>         int alloctype;
> -
> +       int highorder_retry = 3;
> +
>         alloctype = (gfp_mask & __GFP_RCLM_BITS);
>         might_sleep_if(wait);
>
> @@ -1090,7 +1091,14 @@ rebalance:
>                                 goto got_pg;
>                 }
>
> -               out_of_memory(gfp_mask, order);
> +               if (order < MAX_ORDER/2) out_of_memory(gfp_mask, order);

Shouldn't that be written in two lines?

> +               /*
> +                * Due to low fragmentation efforts, we should try a little
> +                * harder to satisfy high order allocations
> +                */
> +               if (order >= MAX_ORDER/2 && --highorder_retry > 0)
> +                       goto rebalance;
> +
>                 goto restart;
>         }

--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
