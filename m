Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWDYUdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWDYUdi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 16:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWDYUdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 16:33:38 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13770 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932123AbWDYUdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 16:33:37 -0400
Date: Tue, 25 Apr 2006 22:32:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Linux PM <linux-pm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Message-ID: <20060425203256.GD6379@elf.ucw.cz>
References: <200604242355.08111.rjw@sisk.pl> <444DF9B3.7080600@yahoo.com.au> <200604251739.13377.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604251739.13377.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >   > -unsigned int count_data_pages(void)
> > > +/**
> > > + *	need_to_copy - determine if a page needs to be copied before saving.
> > > + *	Returns false if the page can be saved without copying.
> > > + */
> > > +
> > > +static int need_to_copy(struct page *page)
> > > +{
> > > +	if (!PageLRU(page) || PageCompound(page))
> > > +		return 1;
> > > +	if (page_mapped(page))
> > > +		return page_mapped_by_current(page);
> > > +
> > > +	return 1;
> > > +}
> > 
> > I'd much rather VM internal type stuff get moved *out* of kernel/power :(
> 
> Well, I kind of agree, but I don't know where to place it under mm/.
> 
> > It needs more comments too. Also, how important is it for the page to be
> > off the LRU?
> 
> Hm, I'm not sure if that's what you're asking about, but the pages off the LRU
> are handled in a usual way, ie. copied when snapshotting the system.  The
> pages _on_ the LRU may be included in the snapshot image without
> copying, but I require them additionally to be (a) mapped by someone and
> (b) not mapped by the current task.

Why do you _want_ them mapped by someone?

> > b) Why are you clearing PageLRU outside the spinlock?
> 
> Well, good question. ;-)  Moreover it seems I don't need to acquire the
> spinlock at all, because this is done on one CPU with IRQs disabled and the
> other tasks frozen.

Well, it is probably better to still take the spinlock. That way, if
something goes wrong we get deadlock, not anything worse.
								Pavel
-- 
Thanks for all the (sleeping) penguins.
