Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274290AbRITBDL>; Wed, 19 Sep 2001 21:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274291AbRITBDC>; Wed, 19 Sep 2001 21:03:02 -0400
Received: from mx5.sac.fedex.com ([199.81.194.37]:22803 "EHLO
	mx5.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S274290AbRITBCs>; Wed, 19 Sep 2001 21:02:48 -0400
Date: Thu, 20 Sep 2001 09:04:40 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: <root@boston.corp.fedex.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Jeff Chua <jchua@fedex.com>
Subject: Re: pre12 VM doubts and patch
In-Reply-To: <20010920013153.C720@athlon.random>
Message-ID: <Pine.LNX.4.33.0109200903300.23427-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 09/20/2001
 09:03:05 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 09/20/2001
 09:03:08 AM,
	Serialize complete at 09/20/2001 09:03:08 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I still can't find pre12. The latest I've seen is pre11.

Where can I get pre12?

Thanks,
Jeff
[ jchua@fedex.com ]

On Thu, 20 Sep 2001, Andrea Arcangeli wrote:

> On Wed, Sep 19, 2001 at 04:16:13PM -0700, Linus Torvalds wrote:
> >
> > On Wed, 19 Sep 2001, Andrea Arcangeli wrote:
> > >
> > > On Wed, Sep 19, 2001 at 08:42:39PM +0100, Hugh Dickins wrote:
> > > > --- 2.4.10-pre12/mm/swap_state.c	Wed Sep 19 14:05:54 2001
> > > > +++ linux/mm/swap_state.c	Mon Sep 17 06:30:26 2001
> > > > @@ -23,6 +23,17 @@
> > > >   */
> > > >  static int swap_writepage(struct page *page)
> > > >  {
> > > > +	/* One for the page cache, one for this user, one for page->buffers */
> > > > +	if (page_count(page) > 2 + !!page->buffers)
> > >
> > > this is racy, you have to spin_lock(&pagecache_lock) before you can
> > > expect the page_count() stays constant. then after you checked the page
> > > has count == 1, you must atomically drop it from the pagecache so it's
> > > not visible anymore to the swapin lookups.
> >
> > No.
> >
> > Note how it is a _heuristic_ only. The "safe" answer is always to say "the
> > page is in use", and note that once the page_count has dropped to 2 or
> > less, it won't increase unless somebody else has a swap count..
>
> the "somebody else has a swap count" is interesting. so we rely on the
> fact any swap_duplicate is always run before the swapcache is unlocked.
>
> Also the "> 2" should be "> 1", but really I noticed I cannot avoid
> getting a reference so please apply also this patch instead of replacing
> "> 2" with "> 1" (it was a race condition):
>
> --- 2.4.10pre11aa1/mm/vmscan.c.~1~	Tue Sep 18 21:23:49 2001
> +++ 2.4.10pre11aa1/mm/vmscan.c	Thu Sep 20 01:29:58 2001
> @@ -415,7 +415,10 @@
>  				spin_unlock(&pagemap_lru_lock);
>
>  				ClearPageDirty(page);
> +
> +				page_cache_get(page);
>  				writepage(page);
> +				page_cache_release(page);
>
>  				spin_lock(&pagemap_lru_lock);
>  				continue;
>
>
> > And we check for the "somebody else has a swap count" two lines lower.
>
> I see.
>
> > Do you see anything wrong with that logic?
>
> Looks ok now :), I guess it would be good to write a comment now, so
> maybe other people won't share my worry, the swap_count thing wasn't
> very obvious. thanks,
>
> Andrea
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

