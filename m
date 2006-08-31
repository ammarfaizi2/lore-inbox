Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWHaTxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWHaTxc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 15:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWHaTxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 15:53:32 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:8843 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932328AbWHaTxc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 15:53:32 -0400
Message-ID: <44F73E37.6030602@drzeus.cx>
Date: Thu, 31 Aug 2006 21:53:27 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: madhu chikkature <crmadhu210@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: SDIO card support in Linux
References: <f71aedf40608310804w75728559ma5fd317e16e94b56@mail.gmail.com>
In-Reply-To: <f71aedf40608310804w75728559ma5fd317e16e94b56@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

madhu chikkature wrote:
> Hi,
> 
> This is regarding the discussion going on in the list about the
> support of SDIO cards in Linux. I read some discussion happening to
> support SDIO cards using the existing Linux MMC core but I could not
> figure out what would be the direction the community to support the
> SDIO cards.
> 

I've been casually working on adding SDIO support to the MMC layer. The
driver model needs quite a bit of changes, so it's a bit of work before
we have something working. So far I've only got the basic init up and
running.

The current version of the patch included (ignore the failed chunks for
mmc_block.c). Feel free to test away. :)

> I have done some work using our own hardware platform runing ARM
> Linux. My hardware platform can support MMC/SD/SDIO cards.
> 

Out of curiosity, what controller are you using?

> 
> CMD3 of MMC can be reused during the discover cards phase, except that
> the card will respond back with the RCA.
> 

This is a SD "feature" and not specific to SDIO, so we have code for
this already.

> 
> With this, is it a fissible solution to have the MMC core do the
> initialization part of the card by having the CMD sequence for SDIO
> card (CMD5 and CMD3) in the mmc_setup sequence and maintain the SDIO
> card list along with MMC/SD?
> 

SD mandates a star topology (just a single card per bus), so we'll just
force a single card into the list. SD memory cards can actually work on
a shared bus, SDIO can not. It's not a big problem in practice though.

> The CMD52 and CMD53 can be implemented with a simple pointer to
> mmc_data structure(An instance of it for SDIO) to send and receive
> data. Exporting the functions that implement CMD52 and CMD53 need to
> be done, so that any card specific driver sitting on the top of the
> MMC core can call these functions to read/write data from the card and
> configure the card.

I've started implementing some SDIO equivalents of readX/writeX.

> 
> Couple of issues i faced are, how do we maintain the list of SDIO
> cards? Right now, i am not adding it to the list of MMC cards. SDIO
> combo cards need more work.
> 

The driver model isn't designed for SDIO cards, so it needs to be
changed. The design I'm working on couples "functions" to each card,
where drivers will bind to these functions instead of the card. Search
the archives for "MMC driver model" and you should find my LKML post
about it.

> Second issue is related to how well the data transfer commands can be
> supported in such a way that the middleware, which does not exist as
> of today to hook the SDIO cards to specific Linux subsystems based on
> the type of the SDIO cards detected, for exaple WLAN SDIO card may
> need to talk to the networking subsystem etc.

It shouldn't be different from PCI, USB or any other bus.

> 
> I am leaving the SDIO generic interrupts to the card specific driver.
> With this setup and few additions to the MMC controller driver, i
> could get the SDIO cards to be detected and i am able to read and
> write data from the SDIO card CCCR registers.In fact the MMC/SD and
> SDIO cards can co-exist.
> 

We need controller help to do interrupts. It's on my todo-list as it
requires a bit more indirection than "normal" interrupts.

> Does this provide a basic support on which SDIO support can be worked
> on? or does community have any other idea?

The basic model changes should come first as they will dictate on how
the rest of the code must be organised. I'd love to see your code though.

> 
> SD support came in at 2.6.14 times and many people still does not have
> access to SD specification easily. Is there any such issues related to
> SDIO as well which might prevent the community from supporting SDIO
> cards?
> 

SDIO is actually easier as there is a spec for at least the protocol and
Bluetooth cards.

Rgds
Pierre

