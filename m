Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbTDNRcU (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 13:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbTDNRcU (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 13:32:20 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35081 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263584AbTDNRcS (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 13:32:18 -0400
Date: Mon, 14 Apr 2003 10:44:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Mackerras <paulus@samba.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] M68k IDE updates
In-Reply-To: <16025.63003.968553.194791@nanango.paulus.ozlabs.org>
Message-ID: <Pine.LNX.4.44.0304141038430.19302-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Apr 2003, Paul Mackerras wrote:
> 
> Since __ide_mm_insw doesn't get told whether it is transferring normal
> sector data or drive ID data, it can't necessarily do the right thing
> in both situations.

Can we please then just separate the two functions out into "fetch sector
data" and "fetch drive ID"? And NOT playing with another frigging broken
passed-down flag that people get wrong and isn't obvious what it does
anyway? It's a lot easier to do

	/* On sane architectures, data and ID are accessed the same */
	#define ide_fetch_sector_data(...) __ide_fetch_data(..)
	#define ide_fetch_id_data(...) __ide_fetch_data(..)

than it is to carry a flag around and having to remember to get it right 
in every place this is used.

It's more efficient too, but the _clarity_ and lack of dynamic flags is a 
hell of a lot more important.

And stupid architectures that may have to re-implement (and possible
duplicate) the ID fetch code only have themselves to blame. Although it 
might easily be as simple as

	/*
	 * The PCI bus is wired up the wrong way, we need to byteswap
	 * the ID results after they come back
	 */
	static inline xxx ide_fetch_id_data(...)
	{
		__ide_fetch_data(..)
		bswap_id_data(..)
	}

and please keep this in some m68k-specific file instead of forcing 
_everybody_ to know about the braindamage.

		Linus

