Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263774AbTDNTnN (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 15:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263773AbTDNTnN (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 15:43:13 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:35562 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id S263774AbTDNTnF (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 15:43:05 -0400
Date: Mon, 14 Apr 2003 21:54:58 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Paul Mackerras <paulus@samba.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] M68k IDE updates
In-Reply-To: <Pine.LNX.4.44.0304141038430.19302-100000@home.transmeta.com>
Message-ID: <Pine.GSO.4.21.0304142148210.25092-100000@vervain.sonytel.be>
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
> 
> It's more efficient too, but the _clarity_ and lack of dynamic flags is a 
> hell of a lot more important.
> 
> And stupid architectures that may have to re-implement (and possible
> duplicate) the ID fetch code only have themselves to blame. Although it 
> might easily be as simple as
> 
> 	/*
> 	 * The PCI bus is wired up the wrong way, we need to byteswap
> 	 * the ID results after they come back
> 	 */
> 	static inline xxx ide_fetch_id_data(...)
> 	{
> 		__ide_fetch_data(..)
> 		bswap_id_data(..)
> 	}
> 
> and please keep this in some m68k-specific file instead of forcing 
> _everybody_ to know about the braindamage.

I think the least-intrusive solution is something like this:

--- linux-2.5/drivers/ide/ide-iops.c.orig	Mon Apr 14 21:43:30 2003
+++ linux-2.5/drivers/ide/ide-iops.c	Mon Apr 14 21:44:53 2003
@@ -423,8 +423,7 @@
  */
 void ide_fix_driveid (struct hd_driveid *id)
 {
-#ifndef __LITTLE_ENDIAN
-# ifdef __BIG_ENDIAN
+    if (ide_driveid_needs_swapping(id)) {
 	int i;
 	u16 *stringcast;
 
@@ -512,10 +511,7 @@
 	for (i = 0; i < 48; i++)
 		id->words206_254[i] = __le16_to_cpu(id->words206_254[i]);
 	id->integrity_word  = __le16_to_cpu(id->integrity_word);
-# else
-#  error "Please fix <asm/byteorder.h>"
-# endif
-#endif
+    }
 }
 
 EXPORT_SYMBOL(ide_fix_driveid);

Where ide_driveid_needs_swapping() is #define'd to return 0 (never swap), 1
(always swap), or whatever architecture-specific logic you need.

We can even have defaults in <linux/ide.h>

    #ifndef ide_driveid_needs_swapping
    # ifdef __LITTLE_ENDIAN
    #  define ide_driveid_needs_swapping(id)	0
    # else
    #  ifdef __BIG_ENDIAN
    #   define ide_driveid_needs_swapping(id)	1
    #  else
    #   error "Please fix <asm/byteorder.h>"
    #  endif
    # endif
    #endif

Sounds sufficiently sane?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

