Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbUCALMg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 06:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbUCALMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 06:12:36 -0500
Received: from mx2.ngi.de ([213.191.74.84]:17065 "EHLO mx2.ngi.de")
	by vger.kernel.org with ESMTP id S261214AbUCALMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 06:12:09 -0500
Date: Mon, 1 Mar 2004 11:43:21 +0100
From: Richard Zidlicky <rz@linux-m68k.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jeff Garzik <jgarzik@pobox.com>,
       Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Worrisome IDE PIO transfers...
Message-ID: <20040301104321.GB1773@linux-m68k.org>
References: <4041232C.7030305@pobox.com> <Pine.GSO.4.58.0402290950590.7483@waterleaf.sonytel.be> <20040229192320.GA20299@linux-m68k.org> <200402292136.33589.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200402292136.33589.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 29, 2004 at 09:36:33PM +0100, Bartlomiej Zolnierkiewicz wrote:
> On Sunday 29 of February 2004 20:23, Richard Zidlicky wrote:
> > On Sun, Feb 29, 2004 at 09:52:08AM +0100, Geert Uytterhoeven wrote:
> > > On Sun, 29 Feb 2004, Bartlomiej Zolnierkiewicz wrote:
> > > > On Sunday 29 of February 2004 01:58, Jeff Garzik wrote:
> > > > > > I like Alan's idea to use loopback instead of "bswap".
> > > > >
> > > > > Neat but no more zerocopy that way.  I much prefer a
> > > > > swap-as-you-go...
> > > >
> > > > Okay, better solution:
> > > >
> > > > - on Atari/Q40:
> > > >   if drive->bswap use insw/outsw instead of swapping variants
> > >
> > > Yep, that sounds the most logical. Richard?
> >
> > looks good.
> >
> > However it appears to fix only part of the problem -  we need some
> > logic to ensure only disk data is swapped.
> > Bswapping WIN_DOWNLOAD_MICROCODE data would not be very
> > clever I guess.
> 
> Actually drive->bswap should die as I overlooked the fact that we are
> _not_ swapping disk data (byteswapped data is used for FS) on Atari/Q40.

correct, on those machines the IDE bus is wired "reversed" and we take
the data without any correction, except for IDENTIFY and atapi requests.
That means that quite a few ioctls (SMART etc) are most likely broken
right now.

> Therefore the real solution is to use device-mapper instead of drive->bswap
> and on Atari/Q40 use standard insw/outs only if blk_fs_request(drive->rq),
> for everything else insw_swapw/outsw_swapw should be used.
> 
> Does it make any sense? :)

that would be the perfect solution. Note that atapi transfers are
already correct the way they are - nothing to fix here.

Richard
