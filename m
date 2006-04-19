Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWDSIGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWDSIGo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 04:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWDSIGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 04:06:44 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:39897 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750751AbWDSIGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 04:06:43 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: [RFC][PATCH -mm] swsusp: use less memory during resume
Date: Wed, 19 Apr 2006 10:05:41 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Linux PM <linux-pm@osdl.org>
References: <200604181319.47400.rjw@sisk.pl> <200604182307.26114.ncunningham@cyclades.com>
In-Reply-To: <200604182307.26114.ncunningham@cyclades.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604191005.41701.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday 18 April 2006 15:07, Nigel Cunningham wrote:
> On Tuesday 18 April 2006 21:19, Rafael J. Wysocki wrote:
> > Currently during resume swsusp puts the image data in the page frames that
> > don't conflict with the original locations of the data (ie. the locations
> > the data will be put in when the saved system state is restored from the
> > image). These page frames are considered as "safe" and the other page
> > frames are treadet as "unsafe".
> >
> > Of course we cannot force the memory allocator to allocate "safe" pages
> > only, so if an "unsafe" page is allocated, swsusp treats it as an "eaten
> > page" and attempts to allocate another page in the hope that it'll be
> > "safe" etc. swsusp tries to allocate as many "safe" pages as necessary to
> > store the image data, so it "eats" a considerable number of "unsafe" pages
> > in the process.  Next, it reads the image and puts the data into the
> > allocated "safe" pages.  Finally, the data are copied to their "original"
> > locations.
> >
> > This approach, although it works nicely, is quite inefficient from the
> > memory utilization point of view and it also turns out to be unnecessary. 
> > Namely, for each "unsafe" page frame returned by the memory allocator
> > there's exactly one page in the image that finally should be placed in this
> > page frame. Therefore we can put the right data into this page frame as
> > soon as they're read from the image and we won't have to copy these data
> > later on.  This way we'll only need to allocate as many pages as necessary
> > to store the image data and we won't have to "eat" the "unsafe" pages.
> >
> > The appended patch implements this idea.  It makes swsusp allocate as
> > many pages as it'll need to store the data read from the image in one
> > shot, creating a list of allocated "safe" pages, and uses the observation
> > that all pages allocated by swsusp are marked with the PG_nosave and
> > PG_nosave_free flags set.  Namely, when it's about to read a page, it
> > checks whether the page frame corresponding to the "original" location of
> > this page has been allocated (ie. if the page frame has the PG_nosave and
> > PG_nosave_free flags set) and if so, it reads the page directly into this
> > page frame.  Otherwise it uses an allocated "safe" page from the list to
> > store the data that will be copied to their "original" location later on.
> >
> > On my box this patch allows us to save as many as approx. 90000 page
> > copyings and 90000 (at least - probably twice as many, because it's an
> > x86_64 box) page allocations for an image of approx. 100000 of pages.  Also
> > it will allow us to read images greater than 50% of the normal zone (when
> > we learn how to create them ;-)).
> 
> Haven't looked at the patch itself, but this sounds like a great idea. I 
> wonder though, won't the 50% limit still apply, because you'll still have to 
> make an atomic copy to start with (unless you figure out which pages aren't 
> going to change and therefore don't need to be atomically copied)?

You are right, and I'm going to figure out which pages won't change.  I think
I have some good candidates. ;-)

Greetings,
Rafael
