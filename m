Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268295AbUJJMtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268295AbUJJMtz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 08:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268296AbUJJMtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 08:49:55 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:4872 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S268295AbUJJMto
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 08:49:44 -0400
Date: Sun, 10 Oct 2004 13:49:26 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ladislav Michl <ladis@linux-mips.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Paul Fulghum <paulkf@microgate.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] TTY flip buffer SMP changes
In-Reply-To: <1097378811.14279.29.camel@gaston>
Message-ID: <Pine.LNX.4.58L.0410101322231.1980@blysk.ds.pg.gda.pl>
References: <1097179099.1519.17.camel@deimos.microgate.com> 
 <1097177830.31768.129.camel@localhost.localdomain>  <20041008062650.GC2745@thunk.org>
  <1097242506.2008.30.camel@deimos.microgate.com>  <1097239894.2290.13.camel@localhost.localdomain>
  <20041008150055.GA13870@thunk.org>  <1097286154.5592.9.camel@gaston> 
 <1097368333.6128.2.camel@localhost.localdomain> <1097378811.14279.29.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Oct 2004, Benjamin Herrenschmidt wrote:

> On Sun, 2004-10-10 at 10:32, Alan Cox wrote:
> > On Sad, 2004-10-09 at 02:42, Benjamin Herrenschmidt wrote:
> > > That reminds me... a while ago, I toyed with the idea of having DMA
> > > support in pmac_zilog. The case where it would work well is typically
> > > for things that have a known sized frame. If that information was
> > > provided down to the driver, I could setup the DMA descriptor for
> > > that frame size & have it interrupt me when the frame is complete,
> > > along with a timeout set to the estimated time for receiving such
> > > a frame + X% (I was thinking +20%)
> > 
> > I thought the 85C30 only supported DMA for sync modes ? We have sync
> > 8530 DMA code for ISA bus already, which I never got around to adding
> > async too 8)
> 
> Nope, Apple's one is hooked to a DBDMA controller taht works well
> in async mode too, though flow control can be a bit nasty.
> We used to do DMA with the old macserial driver on the Rx side but it
> had weird bugs and I didn't keep that implementation when rewriting
> the driver.

 FYI, the DECstation and TURBOchannel Alpha systems also have a DMA
facility for their 85C30s, both for async and for sync modes.  It is set
up in a much less fancy way, though.  For transmission you set up a
pointer to a buffer within a 4kB page containing data to be sent.  The
transmission concludes with the end of the page and you get a
transmit-done interrupt.  For reception you set up a pointer within the
first half of a 4kB page.  You get an interrupt when the pointer crosses
the half-page boundary, meaning you need to switch buffers.  Once the
pointer reaches the end of the page, reception is disabled and you get an
overrun interrupt.  The only oddity is bytes in transmit and receive
buffers need to be word-aligned -- the transactions on the system bus are
performed as 32-bit ones.

  Maciej
