Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbTBERtH>; Wed, 5 Feb 2003 12:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262452AbTBERtH>; Wed, 5 Feb 2003 12:49:07 -0500
Received: from mail.ithnet.com ([217.64.64.8]:26637 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S262420AbTBERtB>;
	Wed, 5 Feb 2003 12:49:01 -0500
Date: Wed, 5 Feb 2003 18:58:25 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org, rossb@google.com
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
Message-Id: <20030205185825.6039eecc.skraw@ithnet.com>
In-Reply-To: <1044467091.685.155.camel@zion.wanadoo.fr>
References: <20030202161837.010bed14.skraw@ithnet.com>
	<3E3D4C08.2030300@pobox.com>
	<20030202185205.261a45ce.skraw@ithnet.com>
	<3E3D6367.9090907@pobox.com>
	<20030205104845.17a0553c.skraw@ithnet.com>
	<1044443761.685.44.camel@zion.wanadoo.fr>
	<3E414243.4090303@google.com>
	<1044465151.685.149.camel@zion.wanadoo.fr>
	<3E4147A0.4050709@google.com>
	<1044466495.684.153.camel@zion.wanadoo.fr>
	<20030205183808.3a2fa115.skraw@ithnet.com>
	<1044467091.685.155.camel@zion.wanadoo.fr>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 Feb 2003 18:44:51 +0100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Wed, 2003-02-05 at 18:38, Stephan von Krawczynski wrote:
> > On 05 Feb 2003 18:34:55 +0100
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > > On Wed, 2003-02-05 at 18:19, Ross Biro wrote:
> > > > Benjamin Herrenschmidt wrote:
> > > > 
> > > > >While I agree with you here, I don't think it's what's happening.
> > > > >	/* clear INTR & ERROR flags */
> > > > >	hwif->OUTB(dma_stat|6, hwif->dma_status);
> > > > >
> > > > >  
> > > > >
> > > > You have way to much faith in the hardware.  Promise is especially
> > > > known for not keeping to the spec.  I wouldn't trust the interrupt bit
> > > > to be valid unless a dma is actually active, i.e. that
> > > > 
> > > >                   hwif->OUTB(hwif->INB(dma_base)|1, dma_base);
> > > > 
> > > > has actually been written.  
> > > > 
> > > > I've actually had a manufacturer tell me that they don't worry about
> > > > the spec, just making things work with Windows.
> > > 
> > > Ok, so that gives us 2 possibilities. The above problem, which would be
> > > fixed by locking all around ide_dma_read/write (or rather in the
> > > _caller_, seems better so we don't have to drop the lock for ATAPI).
> > > 
> > > And a possible wraparound of waiting_for_dma if 255 IRQs come in from
> > > whatever device we share the IRQ line with.
> > > 
> > > I beleive both need fixing...
> > > 
> > > Ben.
> > 
> > Ok, yet another small brick in the wall: this mb has 64bit/66MHz PCI slots.
> > PDC is only 32bit/33MHz PCI. So it may well be that others are in fact
> > _able_ to produce a damn lot more data/interrupts than the PDC. I am pretty
> > astonished by the number of interrupts created by the 3com tg3 cards
> > anyways...
> 
> Ok, then please try my "fix" to remove the increment of waiting_for_dma
> and let us know if it helps.

I will try, in the meantime can any kind soul please give me a hint why I
cannot see the interrupts distributed among the CPUs when enabling smp and
apic on this very same box:

           CPU0       CPU1       
  0:      71158          0    IO-APIC-edge  timer
  1:        941          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
 12:      33166          0    IO-APIC-edge  PS/2 Mouse
 15:          4          0    IO-APIC-edge  ide1
 17:       1732          0   IO-APIC-level  ide2, ide3
 18:       3423          0   IO-APIC-level  eth0, eth1
 21:       8177          0   IO-APIC-level  eth2
 22:     112943          0   IO-APIC-level  aic7xxx
 23:         16          0   IO-APIC-level  aic7xxx
 25:         74          0   IO-APIC-level  HiSax
 26:          0          0   IO-APIC-level  EMU10K1
NMI:          0          0 
LOC:      71085      71059 
ERR:          0
MIS:          0

??
(kernel 2.4.21-pre4)
-- 
Regards,
Stephan
