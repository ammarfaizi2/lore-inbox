Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271945AbRHVGfP>; Wed, 22 Aug 2001 02:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271944AbRHVGfE>; Wed, 22 Aug 2001 02:35:04 -0400
Received: from gnu.in-berlin.de ([192.109.42.4]:64777 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S271945AbRHVGev>;
	Wed, 22 Aug 2001 02:34:51 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 21 Aug 2001 22:37:01 +0200
From: Gerd Knorr <kraxel@bytesex.org>
Message-Id: <200108212037.f7LKb15N009912@bytesex.masq.in-berlin.de>
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: yenta_socket hangs sager laptop in kernel 2.4.6
In-Reply-To: <200108202252.CAA00742@mops.inr.ac.ru>
In-Reply-To: <slrn9o270m.rg.kraxel@bytesex.org> from "Gerd Knorr" at Aug 20, 1 06:45:06 pm <200108202252.CAA00742@mops.inr.ac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In lists.linux.kernel, you wrote:
>  Hello!
>  
> > Same problem here.  I've spend some time today to figure what is going
> > on.  Workaround:
> > -		min = PCIBIOS_MIN_IO;
> > +		min = 0x4000 /* PCIBIOS_MIN_IO */;
>  
>  I do not know how to thank you... You saved my life. :-)
>  How did you guess this?

Long trial-and-error session.  Deactivate code and see if it still does
crash to narrow down the code lines which trigger the lockup.  Once I've
figured that enabling the I/O-Windows triggers the lookup the guess was
easy ...

> > Looks like a ressource conflict to me.  The kernel gives I/O ranges to
> > the cardbus socket which it thinks are free but which are *not* free for
> > some reason (and probably used for APM stuff).  BIOS bug?  PCI quirks
> > time?
>  
>  The same hardware is here, Mitac M722. :-) BTW what bios is installed
>  on your one?

"SYSTEM BIOS R1.02"

>  Anyway, Windows with the _same_ bios manages to guess and to reserve
>  a few of ports tagged as some obscure "motherboard resources":
>  230-233, 398-399, 4d0-4d1, 1000-103f(!), 1400-140f(!) and 3810-381f.
>  yenta_socket eats ones marked with !. At least 1400 is really critical,
>  it is interface to SM mode.

0x1000 is critical too.  Activating the first I/O window only is enough
to hang the notebook on any APM activity.

>  So, probably, more correct fix
>  is something sort of:
>  
>  --- mitac-quirk.c
>  [ reserve resources ]

I've also noticed this in the boot messages:

PCI: PCI BIOS revision 2.10 entry at 0xeb1d0, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7198] at 00:07.0
PCI: Cannot allocate resource region 0 of device 00:0b.0
  got res[10000000:10000fff] for resource 0 of Texas Instruments PCI1410 PC card Cardbus Controller
  got res[10001000:10001fff] for resource 0 of PCI device 1033:00cd (NEC Corporation)
PCI: BIOS reporting unknown device 00:01
PCI: BIOS reporting unknown device 00:02

The "unknown device" looks suspicious to me ...

  Gerd

-- 
Damn lot people confuse usability and eye-candy.
