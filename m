Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289183AbSAQPwT>; Thu, 17 Jan 2002 10:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289190AbSAQPwK>; Thu, 17 Jan 2002 10:52:10 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:47146 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289183AbSAQPv5>; Thu, 17 Jan 2002 10:51:57 -0500
Date: Thu, 17 Jan 2002 16:52:29 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Diego Calleja <grundig@teleline.es>, linux-kernel@vger.kernel.org
Subject: Re: bugfix backed out
Message-ID: <20020117165229.O4847@athlon.random>
In-Reply-To: <20020117153504.J4847@athlon.random> <Pine.LNX.4.33L.0201171300271.32617-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33L.0201171300271.32617-100000@imladris.surriel.com>; from riel@conectiva.com.br on Thu, Jan 17, 2002 at 01:04:07PM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2002 at 01:04:07PM -0200, Rik van Riel wrote:
> On Thu, 17 Jan 2002, Andrea Arcangeli wrote:
> 
> > hmm, is this the bugfix you mean? that shouldn't really matter to me as
> > far I can tell, I did it in an alternate way since the first place.
> 
> It matters a lot since without this change max_mapped
> will always be larger than max_scan and swap_out() will
> NEVER be called.

I see, thanks for the explanation.

> If this is fixed in another way in -aa I must have missed

yes, -aa handles differently the case where max_scan expires.

> > diff -urN 2.4.17pre8/mm/vmscan.c 2.4.17/mm/vmscan.c
> > --- 2.4.17pre8/mm/vmscan.c      Fri Nov 23 08:21:05 2001
> > +++ 2.4.17/mm/vmscan.c  Fri Dec 21 20:06:55 2001
> > @@ -338,7 +338,7 @@
> >  {
> >         struct list_head * entry;
> >         int max_scan = nr_inactive_pages / priority;
> > -       int max_mapped = nr_pages << (9 - priority);
> > +       int max_mapped = min((nr_pages << (10 - priority)), max_scan / 10);
> >
> >         spin_lock(&pagemap_lru_lock);
> >         while (--max_scan >= 0 && (entry = inactive_list.prev) != &inactive_list) {
> >
> > furthmore I hate those "10" hardwirded magic numbers that you keep
> > adding. The less of them the better. At least I put those magics in
> > sysctl.
> 
> Absolutely agreed ... if it helps you, it was marcelo who
> changed the 9 to 10 ;)

Never mind :)

> Ideally we'd have a VM which runs ok without magic numbers,
> or at least one where changing the magic numbers has extremely
> little influence, the defaults work and the sysctl switches
> don't require you to learn how all the VM internals work.

100% agreed.

> 
> > see what my max_mapped is:
> >
> > 	int orig_max_mapped = SWAP_CLUSTER_MAX * vm_mapped_ratio,
> >
> > It is controlled by the vm_mapped_ratio and by the swap-cluster. So we
> > unmap one swap cluster at every vm_mapped_ratio of pages scanned that
> > were mapped. This ensure we unmap when there's some relevant work to do.
> > The lower the vm_mapped_ratio, the earlier the kernel will start
> > swapping/paging. (ah, and of course also the SWAP_CLUSTER_MAX would
> > better be a sysctl but it isn't yet)
> 
> Yes, but what happens when orig_max_mapped gets larger than
> max_scan ?  How does the -aa VM protect against that ?

in short I recall swap_out also from the outside of shrink_caches, if it
fails (if max_scan timeouts it means shrink_caches will fail).

Andrea
