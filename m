Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWDKRD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWDKRD5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 13:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWDKRD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 13:03:56 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:11103 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750856AbWDKRD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 13:03:56 -0400
Date: Tue, 11 Apr 2006 19:03:57 +0200
From: Jens Axboe <axboe@suse.de>
To: Rachita Kothiyal <rachita@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [RFC] Patch to fix cdrom being confused on using kdump
Message-ID: <20060411170357.GR4791@suse.de>
References: <20060407135714.GA25569@in.ibm.com> <20060409102942.GI3859@suse.de> <20060411153114.GA5255@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060411153114.GA5255@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11 2006, Rachita Kothiyal wrote:
> On Sun, Apr 09, 2006 at 12:29:42PM +0200, Jens Axboe wrote:
> > On Fri, Apr 07 2006, Rachita Kothiyal wrote:
> > 
> > if (stat & DRQ_STAT)
> > 
> > checking for DRQ_STAT again doesn't make sense, how can it ever be
> > anything but DRQ_STAT if DRQ_STAT is set?
> 
> Hi Jens,
> 
> Yes, you are right. The condition itself is redundant there as 
> DRQ will always be set there. I will remove it.

Good so far.

> > 
> > > +			/* DRQ is set. Interrupt not welcome now. Ignore */
> > > +			HWIF(drive)->OUTB((stat & 0xEF), IDE_STATUS_REG);
> > > +			return ide_stopped;
> > 
> > And this looks very wrong, you can't write to the status register. Well
> > you can, but then it's the command register! Writing stat & 0xef to the
> > command register is an odd thing to do. I think you just want to clear
> > the DRQ bit, which should be fine after it was read initially. How about
> > 
> > 
> >         if (stat & DRQ_STAT)
> >                 return ide_stopped;
> > 
> > Can you test that?
> 
> I tested this, but I see it fail a couple of times...sometimes it hung
> while booting up the second kernel and sometimes the kernel paniced 
> while shutting it down.(attached partial log for panic)
> 
> I see your point that writing to the status register is not a good idea.
> I think what we want to do is just ignore this particular interrupt and 
> let it continue.
> Am not sure if clearing DRQ bit will achieve this. Please correct me if
> I am wrong, but to clear the DRQ bit also we will have to write to the 
> status register. 

No, there is not writable status register - that is called the command
register. Just reading the status register is enough to clear the irq,
so if you just want to ignore the interrupt that'll work.

What happens if you rearm the interrupt handler instead of returning
ide_stopped?

-- 
Jens Axboe

