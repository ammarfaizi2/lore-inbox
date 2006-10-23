Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbWJWPYK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbWJWPYK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 11:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbWJWPYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 11:24:10 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:29373 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S964934AbWJWPYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 11:24:09 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm] swsusp: Improve handling of highmem
Date: Mon, 23 Oct 2006 17:22:57 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200610142156.05161.rjw@sisk.pl> <20061023150444.GC31273@elf.ucw.cz>
In-Reply-To: <20061023150444.GC31273@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610231722.57560.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 23 October 2006 17:04, Pavel Machek wrote:
> HI!
> 
> > Currently swsusp saves the contents of highmem pages by copying them to the
> > normal zone which is quite inefficient  (eg. it requires two normal pages to be
> > used for saving one highmem page).  This may be improved by using highmem
> > for saving the contents of saveable highmem pages.
> ...
> >  include/linux/suspend.h |    9 
> >  kernel/power/power.h    |    2 
> >  kernel/power/snapshot.c |  841 ++++++++++++++++++++++++++++++++++++------------
> >  kernel/power/swap.c     |    2 
> >  kernel/power/swsusp.c   |   53 +--
> >  kernel/power/user.c     |    2 
> >  mm/vmscan.c             |    3 
> 
> Well, I just hoped that highmem would quietly die out...
> 
> ...
> > +static struct page *alloc_image_page(gfp_t gfp_mask) {
> > +	struct page *page;
> 
> { should go on new line.

Ah, yes, thanks.  I'll fix this later if you don't mind.

> >  	memory_bm_position_reset(orig_bm);
> >  	memory_bm_position_reset(copy_bm);
> >  	do {
> >  		pfn = memory_bm_next_pfn(orig_bm);
> > -		if (likely(pfn != BM_END_OF_MAP)) {
> > -			struct page *page;
> > -			void *src;
> > -
> > -			page = pfn_to_page(pfn);
> > -			src = page_address(page);
> > -			page = pfn_to_page(memory_bm_next_pfn(copy_bm));
> > -			copy_data_page(page_address(page), src);
> > -		}
> > +		if (likely(pfn != BM_END_OF_MAP))
> > +			copy_data_page(memory_bm_next_pfn(copy_bm), pfn);
> >  	} while (pfn != BM_END_OF_MAP);
> >  }
> 
> While(1) and "if (pfn != BM_END_OF_MAP) { ...break; } ? Why do you
> need to test pfn != BM_END_OF_MAP *three* times?

Why?  It's two times, and I don't like while(1) loops, really.

> > Index: linux-2.6.18-mm3/mm/vmscan.c
> > ===================================================================
> > --- linux-2.6.18-mm3.orig/mm/vmscan.c
> > +++ linux-2.6.18-mm3/mm/vmscan.c
> > @@ -1233,6 +1233,9 @@ out:
> >  	}
> >  	if (!all_zones_ok) {
> >  		cond_resched();
> > +
> > +		try_to_freeze();
> > +
> >  		goto loop_again;
> >  	}
> 
> What is this?

:-)

This is needed because during the resume there likely are no free pages in the
highmem zone which makes kswapd spin forever, but we have to freeze it before
the image is restored.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
