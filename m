Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268119AbTBWKqC>; Sun, 23 Feb 2003 05:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268123AbTBWKqC>; Sun, 23 Feb 2003 05:46:02 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:34211 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S268119AbTBWKqB>;
	Sun, 23 Feb 2003 05:46:01 -0500
Date: Sun, 23 Feb 2003 11:56:00 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcus Meissner <meissner@suse.de>
cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@redhat.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       engebret@us.ibm.com
Subject: Re: [PATCH] fixed pcnet32 multicast listen on big endian
In-Reply-To: <Pine.GSO.4.21.0302231113120.28500-100000@vervain.sonytel.be>
Message-ID: <Pine.GSO.4.21.0302231154190.28500-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Feb 2003, Geert Uytterhoeven wrote:
> On Wed, 5 Feb 2003, Marcus Meissner wrote:
> > This fixes multicast listen for pcnet32 on at least powerpc and powerpc64
> > kernels.
> > 
> > The mcast_table is in memory referenced by the card and so it needs
> > to be accessed in little endian mode.
> > 
> > Ciao, Marcus
> > 
> > --- linux-2.4.19/drivers/net/pcnet32.c.be	2003-02-05 07:59:27.000000000 +0100
> > +++ linux-2.4.19/drivers/net/pcnet32.c	2003-02-05 08:00:22.000000000 +0100
> > @@ -1534,7 +1534,9 @@
> >  	
> >  	crc = ether_crc_le(6, addrs);
> >  	crc = crc >> 26;
> > -	mcast_table [crc >> 4] |= 1 << (crc & 0xf);
> > +	mcast_table [crc >> 4] = le16_to_cpu(
>                                  ^^^^^^^^^^^
> > +		le16_to_cpu(mcast_table [crc >> 4]) | (1 << (crc & 0xf))
> > +	);
> 
> Shouldn't the first conversion be `cpu_to_le16'?

Ugh, a quick grep shows that this driver _always_ uses `le*_to_cpu()' to
convert from CPU to little endian.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

