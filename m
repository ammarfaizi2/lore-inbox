Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264541AbUF0Xnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264541AbUF0Xnl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 19:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264542AbUF0Xnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 19:43:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43924 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264541AbUF0Xnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 19:43:35 -0400
Date: Sun, 27 Jun 2004 16:43:27 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: David Brownell <david-b@pacbell.net>
Cc: greg@kroah.com, arjanv@redhat.com, jgarzik@redhat.com, tburke@redhat.com,
       linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
       mdharm-usb@one-eyed-alien.net, oliver@neukum.org, zaitcev@redhat.com
Subject: Re: drivers/block/ub.c
Message-Id: <20040627164327.06b74845@lembas.zaitcev.lan>
In-Reply-To: <40DF50A7.1020404@pacbell.net>
References: <20040626130645.55be13ce@lembas.zaitcev.lan>
	<40DF50A7.1020404@pacbell.net>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jun 2004 15:56:39 -0700
David Brownell <david-b@pacbell.net> wrote:

> > +config BLK_DEV_UB
> > +	tristate "Low Performance USB Block driver"
> 
> Hmm, I'd have thought "low overhead" ... isn't that one
> of the goals of omitting the SCSI layer?

I do not care for the runtime overhead with ub. It might as well be
written in Java, copy every byte with get_user, and take a context
switch on every byte as long as it's bug free. Throwing SCSI away
throws away SCSI bugs (which are few, thanks jejb!), but also throws
away problems with interfacing to SCSI and sd.

Also, private SCSI stack allows to mimic Windows as closely as we can.
Want 36 byte inquiry? No problem! Want to ban START STOP UNIT? Be my
guest! With any luck, we'll be able to get by without anything like
unusual_devs.h (yes, I know it won't happen, but it's the ideal).

Custom error processing is a help as well. Currenly usb-storage
attempts to make SCSI eh to do the right thing by pulling very
thin threads. It is an excessively roundabout way to do things.

Performance is not a goal here. In some cases, ub might end marginally
faster than usb-storage, if only because it uses no worker thread, but
it's purely by accident.

> > +	/*
> > +	 * This is a serious infraction, caused by a deficiency in the
> > +	 * USB sg interface (usb_sg_wait()). We plan to remove this once
> > +	 * we get mileage on the driver and can justify a change to USB API.
> > +	 * See blk_queue_bounce_limit() to understand this part.
> > +	 */
> > +	q->bounce_pfn = blk_max_low_pfn;
> > +	q->bounce_gfp = GFP_NOIO;
> 
> Well, out with it then -- what deficiency would that be?  :)

There is no way to submit a URB and give page, offset, length as arguments.
Three ways to accomplish a similar result exist currently:
 0. Use bounce buffers and submit with kernel virtual address as argument.
 1. Map everything yourself with "generic" DMA, then use URB_NO_TRANSFER_DMA_MAP.
    This includes reading the DMA mask from the controller device, and falling
    back if it is zero.
 2. usb_sg_wait, which takes sg list but does not allow to submit anything
    and must be called from a process.

Regardin #2 you say that ``that code isn't "very fresh and buggy", having
been in use with all USB-Storage devices for over a year and a half'' and
yet I observe that fairly serious fixes were applied just this week. What
passes muster with usb-storage is nowhere near the standard which Havoc
gave me mandate to reach and where ub shoots.

The hacking required to create usb_sg_submit() and have it sharing the
backend with usb_sg_wait is conceptually trivial. But it must be a
separate project. If it were started a year ago then I'd be happy to use
that API now. As it is, no way.

The #1 is a possibility, but it requires a little extra coding.

-- Pete
