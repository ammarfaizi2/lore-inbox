Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262515AbULOWXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbULOWXI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 17:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262517AbULOWXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 17:23:08 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:29820 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262515AbULOWXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 17:23:01 -0500
Date: Wed, 15 Dec 2004 22:22:37 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Greg KH <greg@kroah.com>
cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Dave Airlie <airlied@linux.ie>, <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at mm/rmap.c:480 in 2.6.10-rc3-bk7
In-Reply-To: <Pine.LNX.4.44.0412151830270.3267-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0412152203150.3599-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2004, Hugh Dickins wrote:
> On Wed, 15 Dec 2004, Greg KH wrote:
> > On Wed, Dec 15, 2004 at 05:23:14PM +0000, Hugh Dickins wrote:
> > > 
> > > I think it very likely that your page_remove_rmap BUGs are caused by
> > > the first idea that occurred to me, months back, which intervening
> > > reports didn't seem to fit with: PageReserved(page) when the page is
> > > mapped into userspace, but !PageReserved(page) when it gets unmapped.
> > > 
> > > Which would suggest some kind of refcounting bug in drivers/char/drm/,
> > > such that the reserved pages get unreserved and freed before their
> > > last unmap.  I've started looking for that, but drivers/char/drm/ is
> > > unfamiliar territory to me, so I'd be glad for someone to beat me to it.
> ...
> > > I'll report back whether they confirm or refute the hypothesis.
> > 
> > Here's the files.  gish.map has the map file and I've put the dmesg
> > output inline below.
> 
> Thanks a lot.  They seem to refute the PageReserved -> !PageReserved
> theory.  It sure looks like a problem in this area (gish.maps shows
> this vma maps /dev/dri/card0), but not quite what I was expecting.
> 
> > If there's anything else I can do to help out, please let me know.
> 
> Thanks: I'm sure there will be later, but right now I need to
> look further around that source before proposing anything more.
> 
> > Bad rmap in gish: page c1279380 flags 20000014 count 3 mapcount 0 addr b6913000 vm_flags 800fb
> ....
> > Bad rmap in gish: page c127d360 flags 20000014 count 2 mapcount 0 addr b6b12000 vm_flags 800fb
> 
> And in gish.maps:
> > b6913000-b6b13000 rw-s d8247000 00:0a 10806      /dev/dri/card0

I've surreptitiously corrected that last line, I picked out the wrong one
in the mail I'm quoting: now corrected to the line covering those pages
which are page_remove_rmap'ed without corresponding page_add_file_rmap.

It's worth noting, by the way, that the vm_flags include VM_RESERVED
but not VM_IO: VM_IO would be set if it had gone through remap_pfn_range,
but this is one of the DRM(vm*nopage) vmas.

I've spent the last few hours looking in drivers/char/drm/ but I've
not found any explanation, I'm just as baffled as I've been for months.

Sorry, Greg, I'm holding up progress on this, I think someone else
needs to take over.  I've copied Dave Airlie, as someone well versed
in the current state of DRM.  Clearly it's implicated, but that's not
to say it's guilty.

I hope Dave, or someone else, can work this out;
but I'm giving up for the day.

Hugh

