Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbUKIB6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbUKIB6I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 20:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUKIB6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 20:58:08 -0500
Received: from covert.brown-ring.iadfw.net ([209.196.123.142]:42766 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S261328AbUKIBwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 20:52:53 -0500
From: "Art Haas" <ahaas@airmail.net>
Date: Mon, 8 Nov 2004 19:52:47 -0600
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel memory requirements and BK [SOLVED]
Message-ID: <20041109015247.GB2701@artsapartment.org>
References: <200411070004_MC3-1-8E11-3F5E@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411070004_MC3-1-8E11-3F5E@compuserve.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2004 at 12:02:07AM -0500, Chuck Ebbert wrote:
> Art Haas wrote:
> 
> > With the 2.6.9 and 2.6.10-rc kernels, BK bombs out with
> > out-of-memory errors once the repository checking begins.
> 
> There's nothing wrong with BK's performance that can't be
> solved by a terahertz processor and a terabyte of RAM. ;)
> 
> But these patches might help:
> 

[ snip first patch added into Linus's BK tree]

> ============================================================================
> # spurious_oomkill.patch
> #
> #       Prevent spurious out of memory process kills.
> #       Reported to work by testers on lkml.
> #
> #       Patch by Rik van Riel <riel@redhat.com>
> #       Status: NOT in 2.6.10
> #
> --- 2.6.9/mm/vmscan.c
> +++ 2.6.9.1/mm/vmscan.c
> @@ -379,7 +379,7 @@
>  
>                 referenced = page_referenced(page, 1);
>                 /* In active use or really unfreeable?  Activate it. */
> -               if (referenced && page_mapping_inuse(page))
> +               if (referenced && sc->priority && page_mapping_inuse(page))
>                         goto activate_locked;
>  
>  #ifdef CONFIG_SWAP
> @@ -715,7 +715,7 @@
>                 if (page_mapped(page)) {
>                         if (!reclaim_mapped ||
>                             (total_swap_pages == 0 && PageAnon(page)) ||
> -                           page_referenced(page, 0)) {
> +                           (page_referenced(page, 0) && sc->priority)) {
>                                 list_add(&page->lru, &l_active);
>                                 continue;
>                         }

This patch did the trick for me. I booted up my 2.6.8.1 kernel, did a
'bk pull' to get the code (Sunday Morning), and added in this patch. After
building and installing the patched kernel, I did another 'bk pull'
later and things worked fine. Consider me one more person to vouch for
this patch solving the OOM problem!

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
