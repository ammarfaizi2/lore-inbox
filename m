Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262205AbSIPTsG>; Mon, 16 Sep 2002 15:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262802AbSIPTsG>; Mon, 16 Sep 2002 15:48:06 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:63429 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262205AbSIPTsF>;
	Mon, 16 Sep 2002 15:48:05 -0400
Date: Mon, 16 Sep 2002 21:52:55 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Experimental IDE oops dumper v0.1
Message-ID: <20020916215255.A60197@ucw.cz>
References: <20020916120022.AD2EA2C06F@lists.samba.org> <200209161218.g8GCI7301692@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200209161218.g8GCI7301692@devserv.devel.redhat.com>; from alan@redhat.com on Mon, Sep 16, 2002 at 08:18:07AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2002 at 08:18:07AM -0400, Alan Cox wrote:
> > +	/* Pause (at least 400ns) in case we just issued a command */
> > +	oopser_usec(1);
> > +	for (i = 0; i < 1000; i++) {
> > +		b = inb(HD_STATUS);
> > +		if (!(b & BUSY_STAT)) {
> > +			if (b & ERR_STAT) return 0;
> > +			if (b & flag) return 1;
> > +		}
> > +		oopser_usec(1000);
> 
> This will stop working on SATA when VDMA goes into newer controllers btw.

I think VDMA is an extra feature, the old PIO will still remain - it has
to, for other register accesses, and the data port is not much
different.

> Be careful here - one or two drives get nIEN backwards, you might just
> want to turn off interrupts and be done with it
> 
> > +	oopser_usec(1); /* 400ns according to spec */
> > +	outb(0x0a, HD_CMD);
> 
> You really need to reset and reprogram/retune the controller as well.

No. The controller is always tuned for both PIO and DMA. This is a must
- not all commands are DMA (eg IDENTIFY) and for for example ATAPI some
data is sent over PIO and some over DMA even for a single command. So
using PIO when the drive is switched to DMA is perfectly OK.

> I like the infrastructure but the IDE dumper code is wishful thinking
> in one or two spots. You don't know if the controller is in DMA modes,
> tuned for different things to the drives or legacy free.

Legacy free? That is wishful thinking. Not going to happen any soon.
Unfortunately. As for DMA vs PIO, see above.

> Im not sure what
> to do for legacy free cases but the other bits like LBA48 and retuning
> probably can be handled with some small chipset specific hooks

Retuning not needed, LBA48 might be needed. Not sure about LBA48 in PIO
mode, it might work even without chipset support - it's usually the
LBA48+DMA combination that confuses the chips.

-- 
Vojtech Pavlik
SuSE Labs
