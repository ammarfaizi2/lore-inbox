Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263311AbTE3Gfj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 02:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263317AbTE3Gfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 02:35:39 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43744 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263311AbTE3Gfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 02:35:37 -0400
Date: Fri, 30 May 2003 08:48:56 +0200
From: Jens Axboe <axboe@suse.de>
To: Andy Polyakov <appro@fy.chalmers.se>
Cc: Markus Plail <linux-kernel@gitteundmarkus.de>,
       linux-kernel@vger.kernel.org
Subject: Re: readcd with 2.5 kernels and ide-cd
Message-ID: <20030530064856.GA845@suse.de>
References: <fa.hr5v5at.1e5iqab@ifi.uio.no> <fa.cqhesj4.p2oeoc@ifi.uio.no> <3ED67F1C.BE1918E4@fy.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED67F1C.BE1918E4@fy.chalmers.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29 2003, Andy Polyakov wrote:
> > > Is there work going on to get readcd working with 2.5 kernels and
> > > ide-cd (without ide-scsi)?
> > >
> > > strace readcd dev=/dev/dvd f=/dev/null
> > > ...
> > > ioctl(4, SNDCTL_TMR_TIMEBASE, 0xbfffedd8) = -1 ENOTTY (Inappropriate ioctl for device)
> > > ...
> > > ioctl(3, 0x2285, 0xbfffef9c)            = -1 ENOTTY (Inappropriate ioctl for device)
> > 
> > Something _very_ fishy is going on there.
> 
> Nothing fishy, nothing at all... It's as simple as
> driver/block/scsi_ioctl.c doesn't accepts requestes larger than 64KB,
> while readcd asks for 256KB.

Hmm you are right, well we can increase that without any problems. For
bio transfers at least, kmalloc() runs into problems much beyond that.
But for larger transfers, they better be aligned.

> > 0x2285 is the SG_IO ioctl.
> 
> sg_io returns EINVAL (line 163), but driver/block/ioctl.c transforms it
> to ENOTTY (see last 8 lines).

Ah, so that is the bug.

> > First call to it completes, second one returns -ENOTTY. Looks very much
> > like some kernel bug, see the SNDCTL_TMR_TIMEBASE ioctl returning
> > -ENOTTY in-between.
> 
> SNDCTL_TMR_TIMEBASE is actually TCGETS, originates in stdio and is not
> relevant.

Well yes it's resolved incorrectly, the line was the interesting part.
The -ENOTTY was the interesting part, but no not relevant.

-- 
Jens Axboe

