Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbWFTJwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbWFTJwP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 05:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbWFTJwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 05:52:15 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:27796 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932537AbWFTJwO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 05:52:14 -0400
Subject: Re: [RFC] New MMC driver model
From: Marcel Holtmann <marcel@holtmann.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <449553E5.9030004@drzeus.cx>
References: <449553E5.9030004@drzeus.cx>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 11:35:22 +0200
Message-Id: <1150796122.18381.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

> I've been looking at how we can support SDIO cards and how we need to
> adapt our driver model for it.
> 
> Functions
> =========
> 
> First of all, we need to have multiple drivers for one physical card.
> This is needed to handle both "combo cards" (mem and I/O) and because
> SDIO cards can have seven distinct functions in one card.
> 
> For this I propose we add the concept of "function" and that each "card"
> has 1 to 8 of these. The drivers then bind to these functions, not to
> the card.

sounds reasonable to me and a storage only card has only one function.

> Identification
> ==============
> 
> SDIO uses the PCMCIA CIS structure for its generic fields. This includes
> the CISTPL_MANFID tuple, which has one 16-bit value for manufacturer and
> one 16-bit value for card id. The standard also has a special field for
> "standard" interfaces, which are similar to PCI classes.
> 
> This scheme would allow us to handle storage cards quite nicely:
> 
> #define SDIO_ID_ANY                  0xFFFFFFFF
> 
> #define SDIO_VENDOR_STORAGE          0xFFFFFFFE
> #define SDIO_DEVICE_ID_STORAGE_MMC   0x00000000
> #define SDIO_DEVICE_ID_STORAGE_SD    0x00000001
> 
> (If the prefix makes the MMC layer a bit SDIO centric, feel free to come
> with other suggestions)

So we can have SDIO_DEVICE and SDIO_DEVICE_CLASS macros for the matching
drivers to functions.

> Interrupts
> ==========
> 
> SDIO has generic interrupts that cards can use how they damn well
> please. The interrupts are also level triggered and have the nice
> "feature" of being active when there is no card in the slot.
> 
> So I propose the following:
> 
>  * We add a "interrupt enable" field to the ios structure so that hosts
> know when a SDIO card has been inserted and card interrupts should be
> caught.
> 
>  * When a interrupt is caught, the host driver masks it and tells the
> MMC layer that a interrupt is pending. The MMC layer then calls a card
> interrupt handler in some deferred manner (suggestions welcome).
> 
>  * When the card driver feels that it has handled the interrupt, it
> calls a special acknowledge command that removes the mask the host has set.

It looks very straight forward to me.

> Since SDIO cards can have seven distinct functions, there is a generic
> register that tells which of the seven that currently has a pending
> interrupt. This allows us to call only the relevant handlers.
> 
> The "interrupt pending" register also allows us to do a polled solution
> for non-SDIO capable hosts. I'm unsure how to get a good balance between
> latency and resource usage though.

I think that polled solution is not really working out. Especially if
you need some high speed transfers.

> Register functions
> ==================
> 
> I also intend to write a couple of register functions (sdio_read[bwl])
> so that card drivers doesn't have to deal with MMC requests more than
> necessary. Endianness can also be handled there (SDIO are always LE).

Good idea.

> Comment away! :)

My understanding of the current MMC core is rather limited and I think
that I am not of any good help to get this started. However I have a
couple of SDIO cards (various types) for testing and I am happy to test
any patch you send around.

Regards

Marcel


