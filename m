Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135870AbREDHQp>; Fri, 4 May 2001 03:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135879AbREDHQg>; Fri, 4 May 2001 03:16:36 -0400
Received: from smtp2.libero.it ([193.70.192.52]:57310 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S135870AbREDHQY>;
	Fri, 4 May 2001 03:16:24 -0400
Message-ID: <3AF25700.19889930@alsa-project.org>
Date: Fri, 04 May 2001 09:15:12 +0200
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: David Woodhouse <dwmw2@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: unsigned long ioremap()?
In-Reply-To: <3AF10E80.63727970@alsa-project.org>
		<Pine.LNX.4.05.10105030852330.9438-100000@callisto.of.borg>
		<15089.979.650927.634060@pizda.ninka.net>
		<11718.988883128@redhat.com>
		<3AF12B94.60083603@alsa-project.org> <15089.63036.52229.489681@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Abramo Bagnara writes:
>  > IMO this is a far less effective debugging strategy.
> 
> I agree with you.
> 
> But guess what driver authors are going to do?  They are going to cast
> the thing left and right.  And sure you can then search for that, but
> it isn't likely to make people fix this from the start.

We can easily find now the current misuses (I've already posted a
complete list some time ago) and ensure that authors will do the right
thing.

True benefits will come in future from to have a correct API (the only
point to remember is that ioremap returned value and readl arguments is
*not* a pointer, this is not questionable).

> 
> I suppose the point is that there is a fine line wrt. using APIs to
> influence people to "do the right thing", and this has been
> exemplified in several threads I've been involved in wrt. PCI dma
> and other topics. :-)
> 
> One final point, I want to reiterate that I believe:
> 
>         foo = readl(&regs->bar);
> 
> is perfectly legal and should not be discouraged and in particular,
> not made painful to do.

I disagree: regs it's not a dereferenceable thing and I think it's an
abuse of pointer type. You're keeping a pointer that need a big sign on
it saying "Don't dereference me", it's a mess.

However you might like to substitute this with:

#define fld_readl(cookie, str, fld) readl(cookie + (unsigned
long)&((struct str *) 0)->fld)

or without that, it's perfectly fine to have:

regs = (struct reg *) ioremap(addr, size);
foo = readl((unsigned long)&regs->bar);

It's a driver author matter of preference, that don't touch the fact
that API is correct.

However I've verified that often this lead to unexpected errors due to
different alignment on different architecture and this is why I
personally prefer constant offsets over structures fields.

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!
