Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268094AbUJJD1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268094AbUJJD1k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 23:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268095AbUJJD1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 23:27:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:51636 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268094AbUJJD1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 23:27:37 -0400
Subject: Re: [RFC][PATCH] TTY flip buffer SMP changes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Paul Fulghum <paulkf@microgate.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1097368333.6128.2.camel@localhost.localdomain>
References: <1097179099.1519.17.camel@deimos.microgate.com>
	 <1097177830.31768.129.camel@localhost.localdomain>
	 <20041008062650.GC2745@thunk.org>
	 <1097242506.2008.30.camel@deimos.microgate.com>
	 <1097239894.2290.13.camel@localhost.localdomain>
	 <20041008150055.GA13870@thunk.org>  <1097286154.5592.9.camel@gaston>
	 <1097368333.6128.2.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1097378811.14279.29.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 10 Oct 2004 13:26:52 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-10 at 10:32, Alan Cox wrote:
> On Sad, 2004-10-09 at 02:42, Benjamin Herrenschmidt wrote:
> > That reminds me... a while ago, I toyed with the idea of having DMA
> > support in pmac_zilog. The case where it would work well is typically
> > for things that have a known sized frame. If that information was
> > provided down to the driver, I could setup the DMA descriptor for
> > that frame size & have it interrupt me when the frame is complete,
> > along with a timeout set to the estimated time for receiving such
> > a frame + X% (I was thinking +20%)
> 
> I thought the 85C30 only supported DMA for sync modes ? We have sync
> 8530 DMA code for ISA bus already, which I never got around to adding
> async too 8)

Nope, Apple's one is hooked to a DBDMA controller taht works well
in async mode too, though flow control can be a bit nasty.
We used to do DMA with the old macserial driver on the Rx side but it
had weird bugs and I didn't keep that implementation when rewriting
the driver.

Apple in Darwin does it in a funny way: they basically have a DBDMA
descriptor for _every_byte_ on the Rx side. After a given threshold
of time or data, they trigger an irq and 'harvest' it (that is walk
the DBDMA descriptors and for each completed, they "create" a status
byte to go along and recycle the descriptor. If the ring ends up
completely empty, an irq is triggered on the first Rx byte.

But that's a total waste of course. I'm pretty sure just using a
timer and a pair of DBDMA descriptors set to transfer the whole bunch,
I can just "pause" the dbdma engine while harvesting the buffer
(provided I do it quick enough since the HW Rx buffer is painfully
small on these, but HW irq latency is good and I can flip a new
buffer in right away before processing).

But for that scheme to be efficient with things like PPP, I need to
know the expected frame size (if there is such a notion with PPP, or
does it variable size frames holding one IP packet each ?) to set
my timer properly... Or I can just set my threshold to something
smaller instead, that is the DMA irq to something like 16 bytes and
the timeout timer to the estimated time of receiving 20 bytes or so...

That may not be worth the pain tho ... but we do lost data at 115200
on old G3 machines without DMA.

Ben.


