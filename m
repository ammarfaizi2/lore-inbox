Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbTE2VaD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 17:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbTE2VaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 17:30:03 -0400
Received: from fyserv1.fy.chalmers.se ([129.16.110.66]:26768 "EHLO
	fyserv1.fy.chalmers.se") by vger.kernel.org with ESMTP
	id S262568AbTE2VaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 17:30:02 -0400
Message-ID: <3ED67F1C.BE1918E4@fy.chalmers.se>
Date: Thu, 29 May 2003 23:43:56 +0200
From: Andy Polyakov <appro@fy.chalmers.se>
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en,sv,ru
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Markus Plail <linux-kernel@gitteundmarkus.de>,
       linux-kernel@vger.kernel.org
Subject: Re: readcd with 2.5 kernels and ide-cd
References: <fa.hr5v5at.1e5iqab@ifi.uio.no> <fa.cqhesj4.p2oeoc@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is there work going on to get readcd working with 2.5 kernels and
> > ide-cd (without ide-scsi)?
> >
> > strace readcd dev=/dev/dvd f=/dev/null
> > ...
> > ioctl(4, SNDCTL_TMR_TIMEBASE, 0xbfffedd8) = -1 ENOTTY (Inappropriate ioctl for device)
> > ...
> > ioctl(3, 0x2285, 0xbfffef9c)            = -1 ENOTTY (Inappropriate ioctl for device)
> 
> Something _very_ fishy is going on there.

Nothing fishy, nothing at all... It's as simple as
driver/block/scsi_ioctl.c doesn't accepts requestes larger than 64KB,
while readcd asks for 256KB.

> 0x2285 is the SG_IO ioctl.

sg_io returns EINVAL (line 163), but driver/block/ioctl.c transforms it
to ENOTTY (see last 8 lines).

> First call to it completes, second one returns -ENOTTY. Looks very much
> like some kernel bug, see the SNDCTL_TMR_TIMEBASE ioctl returning
> -ENOTTY in-between.

SNDCTL_TMR_TIMEBASE is actually TCGETS, originates in stdio and is not
relevant.

> I've seen this before (this very bug), but haven't chased it down.

It's not a bug, but implementation deficiency. Cheers. A.
