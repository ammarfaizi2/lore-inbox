Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbWDYVMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWDYVMz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 17:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbWDYVMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 17:12:55 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:43200 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751311AbWDYVMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 17:12:54 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Date: Tue, 25 Apr 2006 23:12:25 +0200
User-Agent: KMail/1.9.1
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Linux PM <linux-pm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <nigel@suspend2.net>
References: <200604242355.08111.rjw@sisk.pl> <200604251739.13377.rjw@sisk.pl> <20060425203256.GD6379@elf.ucw.cz>
In-Reply-To: <20060425203256.GD6379@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604252312.26249.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 25 April 2006 22:32, Pavel Machek wrote:
> > >   > -unsigned int count_data_pages(void)
> > > > +/**
> > > > + *	need_to_copy - determine if a page needs to be copied before saving.
> > > > + *	Returns false if the page can be saved without copying.
> > > > + */
> > > > +
> > > > +static int need_to_copy(struct page *page)
> > > > +{
> > > > +	if (!PageLRU(page) || PageCompound(page))
> > > > +		return 1;
> > > > +	if (page_mapped(page))
> > > > +		return page_mapped_by_current(page);
> > > > +
> > > > +	return 1;
> > > > +}
> > > 
> > > I'd much rather VM internal type stuff get moved *out* of kernel/power :(
> > 
> > Well, I kind of agree, but I don't know where to place it under mm/.
> > 
> > > It needs more comments too. Also, how important is it for the page to be
> > > off the LRU?
> > 
> > Hm, I'm not sure if that's what you're asking about, but the pages off the LRU
> > are handled in a usual way, ie. copied when snapshotting the system.  The
> > pages _on_ the LRU may be included in the snapshot image without
> > copying, but I require them additionally to be (a) mapped by someone and
> > (b) not mapped by the current task.
> 
> Why do you _want_ them mapped by someone?

Because this means they belong to a task that is frozen and won't touch them
(of course unless it's us).  The kernel has no reason to access them either
(even after we resume devices) except for reclaiming, but that's handled
explicitly.  Thus it's safe to include them in the image without copying.

As I said before, I think the page cache pages may be treated this way too.
It probably applies to all of the LRU pages, but there may be some corner
cases.  The mapped pages are just easy to single out.

> > > b) Why are you clearing PageLRU outside the spinlock?
> > 
> > Well, good question. ;-)  Moreover it seems I don't need to acquire the
> > spinlock at all, because this is done on one CPU with IRQs disabled and the
> > other tasks frozen.
> 
> Well, it is probably better to still take the spinlock. That way, if
> something goes wrong we get deadlock, not anything worse.

OK, so I'll just clear/set the LRU flag under the spinlock.

Greetings,
Rafael
