Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263366AbTJVS0d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 14:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263420AbTJVS0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 14:26:33 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:28892 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263366AbTJVS03
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 14:26:29 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: Patch to add support for SGI's IOC4 chipset
Date: Wed, 22 Oct 2003 20:31:02 +0200
User-Agent: KMail/1.5.4
Cc: gwh@sgi.com, jbarnes@sgi.com, aniket_m@hotmail.com,
       linux-kernel@vger.kernel.org
References: <3F7CB4A9.3C1F1237@sgi.com> <200310211639.28346.bzolnier@elka.pw.edu.pl> <20031022043058.GC80096@sgi.com>
In-Reply-To: <20031022043058.GC80096@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310222031.02243.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 of October 2003 06:30, Jeremy Higdon wrote:
> On Tue, Oct 21, 2003 at 04:39:28PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Tuesday 21 of October 2003 08:35, Jeremy Higdon wrote:
> > > > - defining IDE_ARCH_ACK_INTR and ide_ack_intr() in sgiioc4.c is a
> > > > no-op, it should be done <asm/ide.h> to make it work
> > > >   (I think the same problem is present in 2.4.x)
> > >
> > > The definition in <include/linux/ide.h> is only used if
> > > IDE_ARCH_ACK_INTR is not defined.  sgiioc4.c defines IDE_ARCH_ACK_INTR
> > > before including that file, so I believe we get the definition we want
> > > without touching ide.h, don't we?
> >
> > ide_ack_intr() is used by ide-io.c.  If IDE_ARCH_ACK_INTR is not defined
> > in ide.h (and it won't be cause you are doing this only in sgiioc4.c
> > /sgiioc4.h in 2.4.x case/ about which ide-io.c has abolutely no idea)
> > ide_ack_intr() will turn into no-op and hwif->ack_intr() won't be called.
>
> I see what you mean.  Thanks for spotting and fixing this.

I think there is another bug:

...
	hwif->hw.ack_intr = &sgiioc4_checkirq;	/* MultiFunction Chip */
...

sgiioc4_clearirq() should be used instead of sgiioc4_checkirq() here,
because otherwise IRQ won't be cleared.

In order to do this you must modify sgiioc4_clearirq() slightly,
just change "return intr_reg;" to "return intr_reg & 0x03;".

If you wonder why, please look at ide_ack_intr() use in ide-io.c:ide_intr().

> I've run into a problem in testing.  For some reason, I've started to get
> ide timeouts, and the error recovery is not working correctly, due to a
> problem in the driver.
>
> In sgiioc4_ide_dma_stop(), sgiioc4_ide_dma_end(), and sgiioc4_clearirq(),
> there are calls to xide_delay(), which uses schedule_timeout() to sleep.
> Since all of these sgiioc4_ functions can be called from interrupt context,
> that's an obvious problem.
>
> In sgiioc4_clearirq(), the delay function is while we're waiting for the
> interrupt to clear.
>
> In sgiioc4_ide_dma_stop(), we're waiting for the DMA bit to clear.
>
> In sgiioc4_ide_dma_end(), we're waiting for another DMA to finish.
>
> I believe that the right answer is to use udelay() and give up after
> a short period of time.  My question is what does the ide layer

Yes, just use udelay().

> expect?  That is, if you call the dma_end function and the hardware
> driver can't succeed, what would you like us to do?  Is there a way
> to return error, or should we just fail and the ide infrastructure
> will pick it up later and reset things?

The latter, sgiioc4_ide_dma_end() already returns error value to higher layer.
dma_intr() checks it and handle errors (at least in theory).

> I am new to Linux IDE, so forgive these questions if the answers should
> be obvious.

No problem.

thanks,
--bartlomiej

