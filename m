Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318713AbSHAJxB>; Thu, 1 Aug 2002 05:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318714AbSHAJxB>; Thu, 1 Aug 2002 05:53:01 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:9862 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318713AbSHAJxA>;
	Thu, 1 Aug 2002 05:53:00 -0400
Date: Thu, 1 Aug 2002 11:56:09 +0200
From: Jens Axboe <axboe@suse.de>
To: martin@dalecki.de
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: IDE from current bk tree, UDMA and two channels...
Message-ID: <20020801095609.GE1096@suse.de>
References: <9B9F331783@vcnet.vc.cvut.cz> <3D48420F.5050407@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D48420F.5050407@evision.ag>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31 2002, Marcin Dalecki wrote:
> >Unfortunately, problem is still here: when kernel was in idedisk_do_request
> >performed on channel 0, IRQ for channel 1 arrived, and this irq found 
> >channel 1 DMA engine ready, but drive had DRQ set... oops. Shortly after 
> >that IRQ for channel 1 arrived again, but as it was unexpected, nothing 
> >happened. 
> >
> >I hope that i845 is not simplex device, but first (unexpected) IRQ arrived 
> >just when channel 0 code wrote new value to its IDE_SELECT_REG register. 
> >Now I even disconnected DVD drive, so it is simple two masters, two
> >channels configuration, but it still happens.
> 
> One idea and one experiment I was already thinking about is
> to change do_ide_request to actually *not* select delibreately which 
> device do handle. (The big for loop found there...)
> One can instead search for a device on the channel which is matching
> the queue for which do_ide_request() was called.
> 
> for (unit = 0; unit < MAX_DEVICES; ++unit) {
>   ....
>   if (tmp->queue == q) {
>         drive = tmp;
> 	break;
>   }
> }
> if (!drive)
>   BUG();

hey that sucks :-)

seriously, the better way to do this would be to change the q->queuedata
to be a pointer to drive instead of the channel.

that would work, but I think it would seriously starve the other device
on the same channel.

-- 
Jens Axboe

