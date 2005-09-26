Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbVIZMyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbVIZMyD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 08:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbVIZMyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 08:54:03 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:52169 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932117AbVIZMyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 08:54:01 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/3][Fix] swsusp: prevent swsusp from failing if there's too many pagedir pages
Date: Mon, 26 Sep 2005 14:54:09 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <200509252018.36867.rjw@sisk.pl> <200509261311.29269.rjw@sisk.pl> <20050926112022.GD3554@elf.ucw.cz>
In-Reply-To: <20050926112022.GD3554@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509261454.09702.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 26 of September 2005 13:20, Pavel Machek wrote:
> Hi!
> 
> > > Lets see...
> > > 
> > > for i386, we have 768 pagedir entries. Each pagedir entry points to
> > > page with 1023 pointers to pages. That means that up-to 768*1023*4096
> > > bytes image can be saved to swap ~= 768 * 1K * 4K ~= 3 GB. That's more
> > > than enough for i386.
> > > 
> > > for x86-64, we can have 128 pagedir entries (could not we fit more
> > > there? 384 entries should fit, no?).
> > 
> > Yes.  To be exact, 460.
> > 
> > > Each pagedir entry has 511 pointers to pages (IIRC)...
> > 
> > 512, I think.
> 
> Okay, can we do simple solution where we put 460 there, plus a check
> if it overflows (printk, abort suspend), for now? That should fix
> 768MB machine...

For now: a constant in power.h depending on sizeof(long) and PAGE_SIZE,
the size of swsusp_info.pagedir[] depending on it and the overflow check
in write_pagedir()?

Unfortunately it's not enough for what I'm cooking (think of resuming in 35 sec.
to a fully responsive system - well, that's on my box).  A preliminary patch
is at http://www.sisk.pl/kernel/patches/2.6.14-rc2-git3/swsusp-improve-freeing-memory.patch

> > > that is up-to 128*511*4K ~= 64*1K*4K = 256 MB image.
> > > Hmm, that should still be enough for any 512MB machine, and 
> > > probably okay for much bigger machines, too...
> > > 
> > > We can still get to 768 MB image (good enough for any 1.5GB machine,
> > > and probably for anything else, too).
> > > 
> > > If that is not good enough for you, can you simply allocate more than
> > > 1 page for swsusp_info? No need for linklists yet.
> > 
> > I can.  The problem is I have to track the swap offsets of these pages
> > which is necessary for resume.  Is it guaranteed that the swap offsets
> > of pages allocated in a row will be consecutive?
> 
> No, they probably will not be consecutive.
> 
> OTOH pagedirs are stored as a link list in memory already. Maybe we
> should be able to extend that link list for a disk, too, with minimal
> fuss? ...we'd have to write pagedir _backwards_ for that to work,
> probably not nice, and swap_free() would really like direct access.

We write the pagedir after we have written the image, so the address
field of each entry is not needed at that time, except for freeing the
image memory in case of failure (with the "rework image freeing patch"
they are not needed at all).  Thus potentially we can use the address
fields of pagedir entries to link the pages on the swap.

Greetings,
Rafael
