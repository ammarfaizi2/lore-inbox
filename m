Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317641AbSG2Sua>; Mon, 29 Jul 2002 14:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317779AbSG2Sua>; Mon, 29 Jul 2002 14:50:30 -0400
Received: from AMarseille-201-1-5-10.abo.wanadoo.fr ([217.128.250.10]:10608
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S317641AbSG2Su3>; Mon, 29 Jul 2002 14:50:29 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>, Russell King <rmk@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 3 Serial issues up for discussion (was: Re: Serial core
 problems on embedded PPC)
Date: Mon, 29 Jul 2002 20:13:52 +0200
Message-Id: <20020729181352.27999@192.168.4.1>
In-Reply-To: <20020729174341.GA12964@opus.bloom.county>
References: <20020729174341.GA12964@opus.bloom.county>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> a. architectures provide a sub-module to 8250.c which contains the
>>    per-port details, rather than a table in serial.h.  This would
>>    ideally mean removing serial.h completely.  The relevant object
>>    would be linked into 8250.c when 8250.c is built as a module.
>
>I think this would work best.  On PPC this would allow us to change the
>mess of include/asm-ppc/serial.h into a slightly cleaner Makefile
>(especially if we do the automagic <platforms/platform.h> or
><asm/platform.h> bit that's been talked about in the past) magic and we
>could use that object file as well in the bootwrapper as well.

Especially, please, let's avoid once for all statically defined table,
on PPC (specifically on pmac) the table is really dynamic, and
the "legacy ports" (if any) may not be ttyS0..1, but could well be
2..3, or higher, all this having to be decided at runtime for both
built-in driver and modular (so eraly_serial_setup isn't good).

I quite like the sub-module mecanism. I'd rather have it done the
opposite though. I don't care that much about sharing those files
with the bootloader, and i'd rather see the core serial code beeing
a submodule of the arch specific module.

Typically, that would give us:

 - 8250_legacy.c would load 8250 core, probe legacy ports and
instanciate them for typical x86 setup
 - 8250_ppc.c would instanciate known ports on PReP or CHRP machines
and do nothing on pmac
 - 8250_pci.c would be a pci_driver and instanciate ports for a given
PCI card
 - 8250_cs.c would be a pcmcia driver and instanciate ports for a 
given PCMCIA modem card

etc... And of course, we can have an arbitrary set of the above loaded
instanciating ports are they are found.

Ben.


