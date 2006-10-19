Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945937AbWJSOPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945937AbWJSOPH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 10:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945962AbWJSOPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 10:15:07 -0400
Received: from mx3.mail.ru ([194.67.23.149]:4989 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S1945937AbWJSOPF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 10:15:05 -0400
Date: Thu, 19 Oct 2006 18:16:06 +0400
From: Anton Vorontsov <cbou@mail.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: kernel-discuss@handhelds.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genhd fix or ide workaround -- choose one
Message-ID: <20061019141606.GA10095@localhost>
Reply-To: cbou@mail.ru
References: <20061018221506.GA4187@localhost> <1161259553.17335.30.camel@localhost.localdomain> <20061019122516.GA9040@localhost> <1161263312.17335.40.camel@localhost.localdomain> <20061019133307.GA9518@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20061019133307.GA9518@localhost>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 05:33:07PM +0400, Anton Vorontsov wrote:
> On Thu, Oct 19, 2006 at 02:08:32PM +0100, Alan Cox wrote:
> > Ar Iau, 2006-10-19 am 16:25 +0400, ysgrifennodd Anton Vorontsov:
> > > It just happens every time on HP iPaq hx4700. hx4700 have internal CF
> > > slot, which is working via pxa2xx pcmcia driver.
> > 
> > I can't duplicate this with the ide_cs driver and a laptop.
> > 
> > > Have you read comments inside -fix patch? Imho it's obvious that nobody
> > > putting driverfs_device second time, but got it twice.
> > 
> > Its also obvious that it currently works on millions of PC systems and
> > that also needs explaining before any change is made.
> 
> You're right, it needs explanation. Unfortunately I don't have any other
> PCMCIAable devices to find it out. :-/ Though, I'll try to find answers
> in the code.

Okay. Wild guess: you're using 32 bit CardBus (yenta socket?), but hx4700
is using 16 bit PCMCIA (drivers/pcmcia/ds.c). And indeed ds.c calling
device_unregister() which triggers that sequece:
ide_cs.c:ide_detach()
ide_cs.c:ide_release()
ide.c:ide_unregister() <- hang here

I've grep'ed drivers/pcmcia/ for the device_unregister and seems nobody
calling it except drivers/pcmcia/ds.c.

-- Anton (irc: bd2)

p.s. drivers/pcmcia/cardbus.c states:
 * cardbus.c -- 16-bit PCMCIA core support

typo?
