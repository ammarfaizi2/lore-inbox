Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264526AbUF0W57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbUF0W57 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 18:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264527AbUF0W57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 18:57:59 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:23483 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S264526AbUF0W55
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 18:57:57 -0400
Message-ID: <40DF50A7.1020404@pacbell.net>
Date: Sun, 27 Jun 2004 15:56:39 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: greg@kroah.com, arjanv@redhat.com, jgarzik@redhat.com, tburke@redhat.com,
       linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
       mdharm-usb@one-eyed-alien.net, oliver@neukum.org
Subject: Re: drivers/block/ub.c
References: <20040626130645.55be13ce@lembas.zaitcev.lan>
In-Reply-To: <20040626130645.55be13ce@lembas.zaitcev.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:

> This posting is largely a "release early release often" excercise, as
> Papa ESR taught us. But you can see the design outline clearly now,
> I hope, and I'm interested in feedback on that.

What hardware have you tested it with?  It'd be good to know that it
works on Linux hardware running Alan's "File Storage Gadget" driver.
Which means most everything, given dummy_hcd ... :)


> +config BLK_DEV_UB
> +	tristate "Low Performance USB Block driver"

Hmm, I'd have thought "low overhead" ... isn't that one
of the goals of omitting the SCSI layer?


> +	/*
> +	 * We do not support transfers from highmem pages
> +	 * because the underlying USB framework does not.
> +	 *
> +	 * XXX Actually, there is a (very fresh and buggy) support
> +	 * for transfers under control of struct scatterlist, usb_map_sg()
> +	 * in 2.6.6, but it seems to have issues with highmem.
> +	 */

I could easily believe highmem issues, but there's nothing
preventing USB from handing highmem pages.  The HCDs just
use the DMA addreses given to them, and don't care if that's
a highmem page, an ioummu mapped address, or a bounce buffer
allocated by dma mapping or other code.

That code isn't "very fresh and buggy", having been in use
with all USB-Storage devices for over a year and a half.
The bugs I've heard about have been either "device doesn't
work correctly at its peak transfer rate" (sigh) or, without
many recent reports, "wedged in cleanup after error".


> +	/*
> +	 * This is a serious infraction, caused by a deficiency in the
> +	 * USB sg interface (usb_sg_wait()). We plan to remove this once
> +	 * we get mileage on the driver and can justify a change to USB API.
> +	 * See blk_queue_bounce_limit() to understand this part.
> +	 */
> +	q->bounce_pfn = blk_max_low_pfn;
> +	q->bounce_gfp = GFP_NOIO;

Well, out with it then -- what deficiency would that be?  :)

It's true that EHCI doesn't do 64bit DMA on those Intel boxes,
but that's hardly a "serious" problem.

- Dave



