Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263750AbUFFUjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263750AbUFFUjw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 16:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbUFFUjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 16:39:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:5010 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263750AbUFFUju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 16:39:50 -0400
Date: Sun, 6 Jun 2004 22:39:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Pascal Schmidt <der.eremit@email.de>
Cc: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Who has record no. of  DriveReady SeekComplete DataRequest errors?
Message-ID: <20040606203942.GA20267@suse.de>
References: <200406060007.10150.kernel@kolivas.org> <20040606092825.GD2733@suse.de> <Pine.LNX.4.58.0406061408090.202@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406061408090.202@neptune.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06 2004, Pascal Schmidt wrote:
> On Sun, 6 Jun 2004, Jens Axboe wrote:
> 
> > Interesting, and 2.6.2 works flawlessly? The only change in 2.6.3 wrt
> > ide-cd is the addition of the != 2kB sector size support from Pascal
> > Schmidt. A quick guess would be that blocklen isn't set, does this
> > change anything for you?
> 
> Hmmm, another thing that just occured to me is that maybe some broken
> drive might return the raw sector size, despite what the standard says.
> 
> > ===== drivers/ide/ide-cd.c 1.83 vs edited =====
> > --- 1.83/drivers/ide/ide-cd.c	2004-05-29 19:04:42 +02:00
> > +++ edited/drivers/ide/ide-cd.c	2004-06-06 11:27:51 +02:00
> > @@ -2205,6 +2205,8 @@
> >  		*capacity = 1 + be32_to_cpu(capbuf.lba);
> >  		*sectors_per_frame =
> >  			be32_to_cpu(capbuf.blocklen) >> SECTOR_BITS;
> > +		if (*sectors_per_frame == 0)
> > +			*sectors_per_frame = SECTORS_PER_FRAME;
> >  	}
> >
> >  	return stat;
> 
> If this turns out to be the cause, maybe we should check that blocklen
> isn't 0 and divisible by 512.

I could easily imagine some vendors not setting the field, but setting
it to some "buggy" value is far less likely. But might as well add the
check.

Con later confirmed that it was 2.6.2 that introduced the breakage, so
the patch isn't the culprit after all. There are a few seperate things
to look at there - Con, what are you doing when these messages trigger?
Is the drive permanently mounted, or does it happen on open?

-- 
Jens Axboe

