Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbTBERCD>; Wed, 5 Feb 2003 12:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261894AbTBERCD>; Wed, 5 Feb 2003 12:02:03 -0500
Received: from [217.167.51.129] ([217.167.51.129]:64209 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S261874AbTBERCB>;
	Wed, 5 Feb 2003 12:02:01 -0500
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ross Biro <rossb@google.com>
Cc: alan@redhat.com, Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3E414243.4090303@google.com>
References: <20030202161837.010bed14.skraw@ithnet.com>
	 <3E3D4C08.2030300@pobox.com> <20030202185205.261a45ce.skraw@ithnet.com>
	 <3E3D6367.9090907@pobox.com>  <20030205104845.17a0553c.skraw@ithnet.com>
	 <1044443761.685.44.camel@zion.wanadoo.fr>  <3E414243.4090303@google.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044465151.685.149.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 05 Feb 2003 18:12:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-05 at 17:56, Ross Biro wrote:
> Benjamin Herrenschmidt wrote:
> 
> >>Okay, I had to watch for it a bit longer and it turns out that the kernel PDC driver has a problem in this shared interrupt setup. When loads get high it seems to run into some timing problem which causes things like:
> >>
> >>Feb  4 01:02:22 admin kernel: hde: dma_intr: status=0xd0 { Busy }
> >>
> >>    
> >>
> Since the busy bit is set, we know the drive must have received a 
> command.  Since dma_intr thought the drive was not busy, an interrupt 
> must have snuck through between the command being issued and the dma 
> being started.  I think in my original patch, I had the dma start 
> outside of the spinlock, that is a bug.  The command to the controller 
> to start the dma must be inside of the spinlock.

While I agree with you here, I don't think it's what's happening.

In ide-disk, do_rw_disk sets up the taskfile, then basically calls
hwif->ide_dma_read/write to start the command.

In ide-dma.c in 2.4.21-pre4, what happens is:

	/* PRD table */
	hwif->OUTL(hwif->dmatable_dma, hwif->dma_prdtable);
	/* specify r/w */
	hwif->OUTB(reading, hwif->dma_command);
	/* read dma_status for INTR & ERROR flags */
	dma_stat = hwif->INB(hwif->dma_status);
	/* clear INTR & ERROR flags */
	hwif->OUTB(dma_stat|6, hwif->dma_status);
	drive->waiting_for_dma = 1;
	if (drive->media != ide_disk)
		return 0;
        .../...
        Then issue command byte.

Below we clear the DMA status _and_ set waiting_for_dma to 1.
That means that if an IRQ sneaks in, we will call
drive_is_ready(), which shouldn't return INTR 1 since we
just cleared it. I don't see how a race could happen here,
but I might have missed something.

Even if, on SMP, the code below executes _simultaneously_
with ide_intr, the later will check for handler beeing
non-NULL before checking waiting_for_dma (drive_is_ready),
and thus will not race since we set the handler after.

The only thing I see is a possible wraparound of
waiting_for_dma. It's an u8, so it wraps at 255. However,
it's incremented in each __ide_dma_test_irq call. So if you
get more than 255 shared (network in your case) interrupts
before the end of the command, you die.

Alan: you can remove safely the waiting_for_dma++, I beleive,
in drive_is_ready(). I don't know how that code sneaked in
ide-dma. I indeed do that in ppc/pmac.c for other reasons
(sort of timeout condition on the DMA controller that happens
when I get an initial error), but this is totally unrelated
HW on which I know I have no shared IRQ.
   
Stephan: Can you try editing ide-dma.c, function
__ide_dma_test_irq(), and remove that line:

-	drive->waiting_for_dma++;

And tell us if it helps in any way.

Ben.

