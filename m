Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289341AbSAOB0z>; Mon, 14 Jan 2002 20:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289344AbSAOB0p>; Mon, 14 Jan 2002 20:26:45 -0500
Received: from mail5.mx.voyager.net ([216.93.66.204]:26384 "EHLO
	mail5.mx.voyager.net") by vger.kernel.org with ESMTP
	id <S289341AbSAOB0f>; Mon, 14 Jan 2002 20:26:35 -0500
Message-ID: <3C438584.8B304D65@megsinet.net>
Date: Mon, 14 Jan 2002 19:27:32 -0600
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: m.knoblauch@TeraPort.de
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <3C430662.71C4F3D8@TeraPort.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Knoblauch wrote:
> 
> > Re: [2.4.17/18pre] VM and swap - it's really unusable
> >
> >
> > Ken,
> >
> > Attached is an update to my previous vmscan.patch.2.4.17.c
> >
> > Version "d" fixes a BUG due to a race in the old code _and_
> > is much less agressive at cache_shrinkage or conversely more
> > willing to swap out but not as much as the stock kernel.
> >
> > It continues to work well wrt to high vm pressure.
> >
> > Give it a whirl to see if it changes your "-j" symptoms.
> >
> > If you like you can change the one line in the patch
> > from "DEF_PRIORITY" which is "6" to progressively smaller
> > values to "tune" whatever kind of swap_out behaviour you
> > like.
> >
> > Martin
> >
> Martin,
> 
>  looking at the "d" version, I have one question on the piece that calls
> swap_out:
> 
> @@ -521,6 +524,9 @@
>         }
>         spin_unlock(&pagemap_lru_lock);
> 
> +       if (max_mapped <= 0 && (nr_pages > 0 || priority <
> DEF_PRIORITY))
> +               swap_out(priority, gfp_mask, classzone);
> +
>         return nr_pages;
>  }
> 
>  Curious on the conditions where swap_out is actually called, I added a
> printk and found actaully cases where you call swap_out when nr_pages is
> already 0. What sense does that make? I would have thought that
> shrink_cache had done its job in that case.
> 
> shrink_cache: 24 page-request, 0 pages-to swap, max_mapped=-1599,
> max_scan=4350, priority=5
> shrink_cache: 24 page-request, 0 pages-to swap, max_mapped=-487,
> max_scan=4052, priority=5
> shrink_cache: 29 page-request, 0 pages-to swap, max_mapped=-1076,
> max_scan=1655, priority=5
> shrink_cache: 2 page-request, 0 pages-to swap, max_mapped=-859,
> max_scan=820, priority=5
> 

Martin,

The old kernel behavior was to call swapout as soon as max_mapped became zero and
never finished shrinking cache upto nr_pages.  This change adds some swap pressure
back to the system based on the whether or not we managed to find nr_pages on
the first (or subsequent) max_scan pages.

By changing DEF_PRIORITY in the above patch piece to a fixed value of 5, 4, or 3 you
can see the affects of the change on the amount of swap used in my test case with
a kernel build with various number of seti clients running.

A lower number means less swap pressure and more page cache shrinkage.

Martin

         STOCK      MH KERNEL.d   MH KERNEL.d  MH KERNEL.d MH KERNEL.d
                     prior = 5     prior = 4    prior = 3   prior = 2,1

CLEAN    1.1M         0.0M         0.0M         0.0M       not tested
CACHE    1.1M         0.0M         0.0M         0.0M       not tested
SETI 1   1.1M         0.8M         0.0M         0.0M       not tested
SETI 2   5.8M         2.5M         1.7M         1.0M       not tested
SETI 3  16.2M         4.2M         3.3M         1.9M       not tested
SETI 4  18.7M        10.5M         8.9M         4.8M       not tested
SETI 5  31.7M        15.3M        12.7M        12.0M       not tested
SETI 6  35.3M        25.4M        18.6M        18.2M       not tested
SETI 7  38.8M        37.7M        25.3M        27.2M       not tested
