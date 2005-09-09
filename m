Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbVIIDJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbVIIDJy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 23:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbVIIDJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 23:09:54 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:21644 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1751156AbVIIDJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 23:09:54 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=C5Ql5UO/Sp7H32C+5iEyNa67unY0Z30QdtxM1JwUlHlS0VemJ+543JFP18yQoHT3k
	2+CQfMFdmSGuAcQbbDG0Q==
Date: Thu, 08 Sep 2005 20:09:34 -0700
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org, basicmark@yahoo.com
Subject: Re: SPI redux ... driver model support
Cc: dpervushin@ru.mvista.com
References: <20050907183843.14745.qmail@web30307.mail.mud.yahoo.com>
In-Reply-To: <20050907183843.14745.qmail@web30307.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050909030934.8419AE9DCC@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Wed, 7 Sep 2005 19:38:43 +0100 (BST)
> From: Mark Underwood <basicmark@yahoo.com>
> ...
>
> I see several posabiltiys of how SPI devices could be
> connected to an adapter.

Certainly, and all are addressed cleanly by the kind of
configuration scheme I showed.


> 1) All SPI devices are hardwired to the adapter. I
> think this would be the most common.

For custom hardware, not designed for expansion, yes.  Zaurus Corgi
models, for example, keep three SPI devices busy.

But in that category I'd also include custom hardware that happens to
be packaged by connecting boards, which is also the territory of #2 or
#3 below.  "Hard wired" can include connectors that are removable by
breaking the warranty.  :)


> 2) Some SPI devices are hardwired and some are
> removable.

Development/Evaluation boards -- the reference implementations in most
environments, not just Linux -- seem to all but universally choose this
option (or, more rarely, #3).  There might be some domain-specific chips
hardwired (touchscreen or CAN controller, ADC/DAC, etc), but expansion
connectors WILL expose SPI.

That makes sense; one goal is to support system prototyping, and it's
hard to do that if for any reason one of the major hardware connectivity
options is hard to get at!


> 3) All SPI devices are removable.

This is common for the sort of single board computers that get sold
to run Linux (or whatever) as part of semicustom hardware:  maybe not
much more than a few square inches packed with an SOC CPU, FLASH, RAM,
and expansion connectors providing access to a few dozen SOC peripherals.
(There might be 250 or so SOC pins, with expansion connectors providing
access to some big portion of those pins ... including some for SPI.)

It'd be nice to be able to support those SBCs with a core Linux port,
and then just layer support for addon boards on top of that without
needing to touch a line of arch code.  And convenient for folk who
are adding value through those addons.  :)



> 	 When you plug a card in you use
> spi_device_register to add that device to the system
> and when you remove the card you call
> spi_device_unregister. You can then do the same for a
> different card and at no time have you changed the
> declaration of the controller.

That implies whoever is registering is actually going and creating the
SPI devices ... and doing it AFTER the controller driver is registered.
I actually have issues with each of those implications.

However, I was also aiming to support the model where the controller
drivers are modular, and the "add driver" and "declare hardware" steps
can go in any order.  That way things can work "just like other busses"
when you load the controller drivers ... and the approach is like the
familiar "boot firmware gives hardware description tables to the OS"
approach used by lots of _other_ hardware that probes poorly.  (Except
that Linux is likely taking over lots of that "boot firmware" role.)


> > I'll post a refresh of my patch that seems to me to be
> > a much better match for those goals.  The refresh includes
> > some tweaks based on what you sent, but it's still just
> > one KByte of overhead in the target ROM.  :)

Grr.  I added sysfs attributes and an I/O utility function,
and now it's a bit bigger than 1KByte.  Especially with
debugging enabled, it's nearer 1.5KB.  The curse of actually
trying to hook up to hardware and its quirks.  :(


> OK. I will post an updated version of my SPI subsystem
> within the next few days with the transfer stuff added
> and maybe the interrupt and GPO abstraction as well.

OK.


> I haven't seen any replies to my SPI patch :( did you
> reply to it?

No, I was going to sent it when I sent that refresh; it's helped
focus my thoughts a bit.  :)

Several of the comments (like "get rid of algorithm layer!") you'll have
heard before in response to the RFC from MontaVista.  It seems both
approaches are still trying to make SPI seem like I2C, and not taking
the opportunity to _fix_ very much of the I2C oddness.

- Dave

