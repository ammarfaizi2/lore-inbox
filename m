Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbVIZSbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbVIZSbv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 14:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbVIZSbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 14:31:51 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52958 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932462AbVIZSbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 14:31:50 -0400
Date: Mon, 26 Sep 2005 16:26:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/3][Fix] swsusp: prevent swsusp from failing if there's too many pagedir pages
Message-ID: <20050926142608.GA32249@elf.ucw.cz>
References: <200509252018.36867.rjw@sisk.pl> <200509261311.29269.rjw@sisk.pl> <20050926112022.GD3554@elf.ucw.cz> <200509261454.09702.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509261454.09702.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Lets see...
> > > > 
> > > > for i386, we have 768 pagedir entries. Each pagedir entry points to
> > > > page with 1023 pointers to pages. That means that up-to 768*1023*4096
> > > > bytes image can be saved to swap ~= 768 * 1K * 4K ~= 3 GB. That's more
> > > > than enough for i386.
> > > > 
> > > > for x86-64, we can have 128 pagedir entries (could not we fit more
> > > > there? 384 entries should fit, no?).
> > > 
> > > Yes.  To be exact, 460.
> > > 
> > > > Each pagedir entry has 511 pointers to pages (IIRC)...
> > > 
> > > 512, I think.
> > 
> > Okay, can we do simple solution where we put 460 there, plus a check
> > if it overflows (printk, abort suspend), for now? That should fix
> > 768MB machine...
> 
> For now: a constant in power.h depending on sizeof(long) and PAGE_SIZE,
> the size of swsusp_info.pagedir[] depending on it and the overflow check
> in write_pagedir()?

Yes, that would be very nice.

> Unfortunately it's not enough for what I'm cooking (think of resuming in 35 sec.
> to a fully responsive system - well, that's on my box).  A preliminary patch
> is at http://www.sisk.pl/kernel/patches/2.6.14-rc2-git3/swsusp-improve-freeing-memory.patch

Okay, I see, nice... We want to support that in future. (Actually it
is last piece of puzzle for swsusp3).

> > No, they probably will not be consecutive.
> > 
> > OTOH pagedirs are stored as a link list in memory already. Maybe we
> > should be able to extend that link list for a disk, too, with minimal
> > fuss? ...we'd have to write pagedir _backwards_ for that to work,
> > probably not nice, and swap_free() would really like direct access.
> 
> We write the pagedir after we have written the image, so the address
> field of each entry is not needed at that time, except for freeing the
> image memory in case of failure (with the "rework image freeing patch"
> they are not needed at all).  Thus potentially we can use the address
> fields of pagedir entries to link the pages on the swap.

I plan to push "rework image freeing patch" for other reasons,
too. I'd like to run longer tests on it, but so far it looks okay.

								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
