Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271787AbRHUS3u>; Tue, 21 Aug 2001 14:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271783AbRHUS3m>; Tue, 21 Aug 2001 14:29:42 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:41484 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S271786AbRHUS3a>;
	Tue, 21 Aug 2001 14:29:30 -0400
Message-Id: <200108202252.CAA00742@mops.inr.ac.ru>
Subject: Re: yenta_socket hangs sager laptop in kernel 2.4.6
To: kraxel@bytesex.ORG (Gerd Knorr)
Date: Tue, 21 Aug 2001 02:52:24 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <slrn9o270m.rg.kraxel@bytesex.org> from "Gerd Knorr" at Aug 20, 1 06:45:06 pm
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Same problem here.  I've spend some time today to figure what is going
> on.  Workaround:
> 
> ---------------------------- cut here -----------------------------
> --- 2.4.9/drivers/pcmcia/yenta.c.fix	Mon Aug 20 11:02:23 2001
> +++ 2.4.9/drivers/pcmcia/yenta.c	Mon Aug 20 14:21:33 2001
> @@ -729,7 +729,7 @@
>  	if (type & IORESOURCE_IO) {
>  		align = 1024;
>  		size = 256;
> -		min = PCIBIOS_MIN_IO;
> +		min = 0x4000 /* PCIBIOS_MIN_IO */;
>  		max = 0xffff;
>  	}
>  		
> ---------------------------- cut here -----------------------------

I do not know how to thank you... You saved my life. :-)
How did you guess this?



> Looks like a ressource conflict to me.  The kernel gives I/O ranges to
> the cardbus socket which it thinks are free but which are *not* free for
> some reason (and probably used for APM stuff).  BIOS bug?  PCI quirks
> time?

The same hardware is here, Mitac M722. :-) BTW what bios is installed
on your one?

Anyway, Windows with the _same_ bios manages to guess and to reserve
a few of ports tagged as some obscure "motherboard resources":
230-233, 398-399, 4d0-4d1, 1000-103f(!), 1400-140f(!) and 3810-381f.
yenta_socket eats ones marked with !. At least 1400 is really critical,
it is interface to SM mode. So, probably, more correct fix
is something sort of:

--- mitac-quirk.c

#include <linux/config.h>
#include <linux/version.h>
#include <linux/module.h>

#include <linux/kernel.h>
#include <linux/ioport.h>
#include <linux/init.h>

static __init int mitac_init(void)
{
	/* No guesses */
	request_region(0x230, 4, "Mitac");

	/* Hmm... look at 0x64 @ 0:7.3, 0x398 is set there, no doubts.
	 * What is this? */
	request_region(0x398, 2, "Mitac");

	/* 82440MX: ELCR 1&2, Edge/Level Control Regs */
	request_region(0x4D0, 2, "82440MX INT CNTRL");

	/* No guesses */
	request_region(0x1000, 0x40, "Mitac");

	/* SMBus: selected with bits 4:15 at 0x90 @ 0:7.3 */
	request_region(0x1400, 0x10, "82440MX SMBus");

	/* No guesses. */
	request_region(0x3810, 0x10, "Mitac");
	return 0;
}

module_init(mitac_init);

/*
 * Local variables:
 * compile-command: "gcc -DMODULE -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -c mitac.c"
 * End:
 */


Alexey

