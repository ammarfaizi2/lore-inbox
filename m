Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbTDVHzb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 03:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262985AbTDVHzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 03:55:31 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:30902 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id S262984AbTDVHz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 03:55:28 -0400
Date: Mon, 21 Apr 2003 18:55:52 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Paul Mackerras <paulus@samba.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] M68k IDE updates
In-Reply-To: <Pine.LNX.4.44.0304141038430.19302-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0304211833010.14857-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Apr 2003, Linus Torvalds wrote:
> On Mon, 14 Apr 2003, Paul Mackerras wrote:
> > Since __ide_mm_insw doesn't get told whether it is transferring normal
> > sector data or drive ID data, it can't necessarily do the right thing
> > in both situations.
> 
> Can we please then just separate the two functions out into "fetch sector
> data" and "fetch drive ID"? And NOT playing with another frigging broken
> passed-down flag that people get wrong and isn't obvious what it does
> anyway? It's a lot easier to do
> 
> 	/* On sane architectures, data and ID are accessed the same */
> 	#define ide_fetch_sector_data(...) __ide_fetch_data(..)
> 	#define ide_fetch_id_data(...) __ide_fetch_data(..)
> 
> than it is to carry a flag around and having to remember to get it right 
> in every place this is used.

OK, I took a closer look at the IDE identification innards.

It's quite easy to call hwif->ata_input_id() instead of hwif->ata_input_data()
for reading the drive ID. Then hwif->ata_input_id() can take care of the
byteswapping for hardwired byteswapped IDE busses.

However, there's also a routine that involves more magic:
taskfile_lib_get_identify(). While trying to understand that one, I found more
commands that should call the (possible byteswapping) hwif->ata_input_id()
operations, like SMART commands. So first we need a clearer differentiation
between commands that transfer on-platter data, or other drive data.

Any comments from the IDE experts?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


