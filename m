Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261499AbULFOnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbULFOnc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 09:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbULFOnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 09:43:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:25480 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261538AbULFOmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 09:42:53 -0500
Date: Mon, 6 Dec 2004 15:42:19 +0100
From: Jens Axboe <axboe@suse.de>
To: Kevin Corry <kevcorry@us.ibm.com>
Cc: Adrian Bunk <bunk@stusta.de>, dm-devel@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6: drivers/md/dm-io.c partially copies bio.c
Message-ID: <20041206144218.GA10498@suse.de>
References: <20041206120941.GB7250@stusta.de> <200412060748.51047.kevcorry@us.ibm.com> <20041206135539.GZ10498@suse.de> <200412060822.18688.kevcorry@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412060822.18688.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06 2004, Kevin Corry wrote:
> On Monday 06 December 2004 7:55 am, Jens Axboe wrote:
> > On Mon, Dec 06 2004, Kevin Corry wrote:
> > > Hi Adrian,
> > >
> > > On Monday 06 December 2004 6:09 am, Adrian Bunk wrote:
> > > > drivers/md/dm-io.c copies functionality from bio.c .
> > > >
> > > > Is there a specific reason why you don't simply use the functionality
> > > > bio.c provides?
> > >
> > > Can you give some specific examples of the functionality you think is
> > > duplicated? Meanwhile, I'll take a look and see if I can explain any code
> > > overlaps.
> >
> > Ah come on Kevin, a 2 second glance shows lots of uneccesary
> > duplication. Basically only the concept of the bio_set is not duplicated
> > in the first many lines, you even set up matching slabs.
> >
> > How was that ever accepted for merging?
> 
> If I recall correctly (and it's been a while since I've looked at that
> code), the bio_set was added because a few DM modules like to initiate
> their own I/O requests (things like snapshots and DM's kcopyd daemon),
> and we felt it was better to allow these modules to each create their
> own mempools to allocate bios from, rather than allocate from the
> single kernel-wide bio pool used by the filesystem layer.

That is fully correct and also something that eg the bouncing code needs
to be 100% deadlock free.

> Strictly speaking (and as you mentioned), the slabs in the bio_set are
> unnecessary, and they could use the global bio_slab. But there's
> probably some argument to be made for having separate bio mempools for
> these modules.

The mempools are needed, the duplicated slabs are not. But that's just a
small part of it, basically the whole allocation and index stuff is 100%
duplicated from bio.c. Even bio_init().

> Actually, I also seem to recall discussions with Joe Thornber from
> quite awhile ago about trying to move this bio_set functionality into
> fs/bio.c, to allow other device drivers to create their own private
> bio pools. If you think something like this would be desireable, I can
> try to look into the specifics again. If you think that having the
> single kernel-wide bio pool is sufficient for all filesystems and
> device-drivers (you certainly understand the trade-offs better than I
> do), then I can look into removing the necessary code from dm-io.c

An abstraction for this would be nice, as there are two users of it then
(dm-io and highmem.c). So if your team would do that, I would sure help
you review and integrate it.

That's not what I'm arguing against, it's the (almost) wholesale
duplication that's a bit silly.

-- 
Jens Axboe

