Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261900AbTBERYW>; Wed, 5 Feb 2003 12:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbTBERYW>; Wed, 5 Feb 2003 12:24:22 -0500
Received: from [217.167.51.129] ([217.167.51.129]:55508 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S261900AbTBERYV>;
	Wed, 5 Feb 2003 12:24:21 -0500
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ross Biro <rossb@google.com>
Cc: alan@redhat.com, Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3E4147A0.4050709@google.com>
References: <20030202161837.010bed14.skraw@ithnet.com>
	 <3E3D4C08.2030300@pobox.com> <20030202185205.261a45ce.skraw@ithnet.com>
	 <3E3D6367.9090907@pobox.com>  <20030205104845.17a0553c.skraw@ithnet.com>
	 <1044443761.685.44.camel@zion.wanadoo.fr>  <3E414243.4090303@google.com>
	 <1044465151.685.149.camel@zion.wanadoo.fr>  <3E4147A0.4050709@google.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044466495.684.153.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 05 Feb 2003 18:34:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-05 at 18:19, Ross Biro wrote:
> Benjamin Herrenschmidt wrote:
> 
> >While I agree with you here, I don't think it's what's happening.
> >	/* clear INTR & ERROR flags */
> >	hwif->OUTB(dma_stat|6, hwif->dma_status);
> >
> >  
> >
> You have way to much faith in the hardware.  Promise is especially known 
> for not keeping to the spec.  I wouldn't trust the interrupt bit to be 
> valid unless a dma is actually active, i.e. that
> 
>                   hwif->OUTB(hwif->INB(dma_base)|1, dma_base);
> 
> has actually been written.  
> 
> I've actually had a manufacturer tell me that they don't worry about the 
> spec, just making things work with Windows.

Ok, so that gives us 2 possibilities. The above problem, which would be
fixed by locking all around ide_dma_read/write (or rather in the
_caller_, seems better so we don't have to drop the lock for ATAPI).

And a possible wraparound of waiting_for_dma if 255 IRQs come in from
whatever device we share the IRQ line with.

I beleive both need fixing...

Ben.

