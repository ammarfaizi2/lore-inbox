Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264619AbSIQWAp>; Tue, 17 Sep 2002 18:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264625AbSIQWAp>; Tue, 17 Sep 2002 18:00:45 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:35061 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264619AbSIQWAl>;
	Tue, 17 Sep 2002 18:00:41 -0400
Date: Tue, 17 Sep 2002 15:02:15 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Juan M. de la Torre" <jmtorre@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: Possible bug in __alloc_pages() ?
Message-ID: <132900000.1032300135@flay>
In-Reply-To: <20020917214804.GA891@apocalipsis>
References: <20020917214804.GA891@apocalipsis>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is deliberate, and is to discourage fallback. I'm not desperately fond
of the method, but I'm told it's not an accidental typo / bug.

M.

--On Tuesday, September 17, 2002 23:48:04 +0200 "Juan M. de la Torre" <jmtorre@gmx.net> wrote:

> 
>  Hi, this code appears at the beggining of __page_alloc() (kernel 2.4.19):
> 
>         min = 1UL << order;
>         for (;;) {
>                 zone_t *z = *(zone++);
>                 if (!z)
>                         break;
> 
>                 min += z->pages_low;
>                 if (z->free_pages > min) {
>                         page = rmqueue(z, order);
>                         if (page)
>                                 return page;
>                 }
>         }
> 
>  AFAIK, what this code does is to try to alloc the requested pages from
> the first zone in a zone_list (passed as argument) which have enought free 
> pages.
> 
>  A zone is considered to have enought free pages if z->free_pages is greater 
> than (number_of_requested_pages + z->pages_low).
> 
>  In the loop shown, the first iteration is OK, but in the second iteration
> (which only occurs if the first zone in the zone_list hasn't enought free
> pages) the zone will only be considered to have enought free pages if
> z->free_pages is greater that (number_of_requested_pages + z->pages_low
> + PREV_ZONE->pages_low). 
> 
>  I think this is a bug, but i'm not sure (i'm not a VM hacker).
> 
>  If it is a bug, there are other two loops in the same function which
> are buggy.
> 
> 
> Possible patch:
> 
> --- linux/mm/page_alloc.c.orig  Tue Sep 17 23:45:02 2002
> +++ linux/mm/page_alloc.c       Tue Sep 17 23:46:45 2002
> @@ -330,8 +330,7 @@
>                 if (!z)
>                         break;
> 
> -               min += z->pages_low;
> -               if (z->free_pages > min) {
> +               if (z->free_pages > min + z->pages_low) {
>                         page = rmqueue(z, order);
>                         if (page)
>                                 return page;
> @@ -354,8 +353,8 @@
>                 local_min = z->pages_min;
>                 if (!(gfp_mask & __GFP_WAIT))
>                         local_min >>= 2;
> -               min += local_min;
> -               if (z->free_pages > min) {
> +
> +               if (z->free_pages > min + local_min) {
>                         page = rmqueue(z, order);
>                         if (page)
>                                 return page;
> @@ -394,8 +393,7 @@
>                 if (!z)
>                         break;
> 
> -               min += z->pages_min;
> -               if (z->free_pages > min) {
> +               if (z->free_pages > min + z->pages_min) {
>                         page = rmqueue(z, order);
>                         if (page)
>                                 return page;
> 
> Regards,
> Juanma
> 
> -- 
> /jm
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


