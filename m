Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265002AbUF1PFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265002AbUF1PFr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 11:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265008AbUF1PFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 11:05:47 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:34714 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S265002AbUF1PFH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 11:05:07 -0400
Message-ID: <40E033A6.60502@pacbell.net>
Date: Mon, 28 Jun 2004 08:05:10 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: greg@kroah.com, arjanv@redhat.com, jgarzik@redhat.com, tburke@redhat.com,
       linux-kernel@vger.kernel.org, stern@rowland.harvard.edu,
       mdharm-usb@one-eyed-alien.net, oliver@neukum.org
Subject: Re: drivers/block/ub.c
References: <20040626130645.55be13ce@lembas.zaitcev.lan>	<40DF50A7.1020404@pacbell.net> <20040627164327.06b74845@lembas.zaitcev.lan>
In-Reply-To: <20040627164327.06b74845@lembas.zaitcev.lan>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:

>>>+	 * This is a serious infraction, caused by a deficiency in the
>>>+	 * USB sg interface (usb_sg_wait()). ...
>>
>>Well, out with it then -- what deficiency would that be?  :)
> 
> 
> There is no way to submit a URB and give page, offset, length as arguments.

Or a kitchen sink, either.  Just map(page,offset) --> dma_addr
and pass that address, with the length ... no point in changing
the URB calls just for one driver.  Especially when that driver
has so many other options already available, including your three:


>  0. Use bounce buffers and submit with kernel virtual address as argument.
>  1. Map everything yourself with "generic" DMA, then use URB_NO_TRANSFER_DMA_MAP.
>     This includes reading the DMA mask from the controller device, and falling
>     back if it is zero.

By "generic" presumably you really mean usb_buffer_map_sg()?

Remember, the "generic" DMA calls don't take arbitrary devices,
unless arch/platform code first gets modified to understand
that type of device.  Only certain kinds of devices ... and
"usb devices" for some reason aren't on those lists.

That call is what's used inside the usb_sg_init() code.  It solves
several nice-to-have-solved problems.   You might even be able to
use sg_init just to allocate and init the URBs you'll submit, if
you're keen on minimizing your re-use of existing code.

If you only submit one URB at a time, and an IOMMU doesn't turn
your sglist into one dma buffer, you'd surely achieve your goal
of low performance.  I've usually seen at most 10 MByte/sec with
that approach, vs more than 30 MByte/sec if the queue only empties
when there's no more data to transfer.


>  2. usb_sg_wait, which takes sg list but does not allow to submit anything
>     and must be called from a process.

That doesn't make sense.  But what you said later starts to:  you want
to have "submit" separate from "wait" (or more likely, intercept a
final completion callback instead of having to wait_for_completion).
Pretty much like that comment in usb_sg_wait() describes as an
alternate implementation of the same notion ... :)


> Regardin #2 you say that ``that code isn't "very fresh and buggy", having
> been in use with all USB-Storage devices for over a year and a half'' and
> yet I observe that fairly serious fixes were applied just this week. 

I have a hard time calling any bug "serious" when only one person even
manages to report the problem in that amount of time.  "Very...buggy"
is arrant nonsense, if one hard-to-trigger bug is your entire proof.


> The hacking required to create usb_sg_submit() and have it sharing the
> backend with usb_sg_wait is conceptually trivial. But it must be a
> separate project. If it were started a year ago then I'd be happy to use
> that API now. As it is, no way.

So, the basic "deficiency" is that it's not a separate project?
Still doesn't make sense to me.

- Dave




