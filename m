Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317589AbSG2TER>; Mon, 29 Jul 2002 15:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317590AbSG2TER>; Mon, 29 Jul 2002 15:04:17 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:28804
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S317589AbSG2TEQ>; Mon, 29 Jul 2002 15:04:16 -0400
Date: Mon, 29 Jul 2002 12:07:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: Serial core problems on embedded PPC)
Message-ID: <20020729190703.GB12964@opus.bloom.county>
References: <20020729174341.GA12964@opus.bloom.county> <20020729181352.27999@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020729181352.27999@192.168.4.1>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2002 at 08:13:52PM +0200, Benjamin Herrenschmidt wrote:

> >> a. architectures provide a sub-module to 8250.c which contains the
> >>    per-port details, rather than a table in serial.h.  This would
> >>    ideally mean removing serial.h completely.  The relevant object
> >>    would be linked into 8250.c when 8250.c is built as a module.
> >
> >I think this would work best.  On PPC this would allow us to change the
> >mess of include/asm-ppc/serial.h into a slightly cleaner Makefile
> >(especially if we do the automagic <platforms/platform.h> or
> ><asm/platform.h> bit that's been talked about in the past) magic and we
> >could use that object file as well in the bootwrapper as well.
> 
> Especially, please, let's avoid once for all statically defined table,
> on PPC (specifically on pmac) the table is really dynamic, and
> the "legacy ports" (if any) may not be ttyS0..1, but could well be
> 2..3, or higher, all this having to be decided at runtime for both
> built-in driver and modular (so eraly_serial_setup isn't good).

Well, on pmac yes.  But for a good hunk of the rest of the PPC world the
inital ports are static (and as long as new ports, ie pcmcia stuff, is
handled sanely anyhow, I don't think this is an issue).

> I quite like the sub-module mecanism. I'd rather have it done the
> opposite though. I don't care that much about sharing those files
> with the bootloader, and i'd rather see the core serial code beeing
> a submodule of the arch specific module.

Then how do you propose to keep the bootloader working and kill off the
ugly ugly include/asm-ppc/serial.h ?

> Typically, that would give us:
> 
>  - 8250_legacy.c would load 8250 core, probe legacy ports and
> instanciate them for typical x86 setup
>  - 8250_ppc.c would instanciate known ports on PReP or CHRP machines
> and do nothing on pmac
>  - 8250_pci.c would be a pci_driver and instanciate ports for a given
> PCI card
>  - 8250_cs.c would be a pcmcia driver and instanciate ports for a 
> given PCMCIA modem card
> 
> etc... And of course, we can have an arbitrary set of the above loaded
> instanciating ports are they are found.

I _think_ the 8250_cs.c case is seperate in this case.  But most of what
you describe would work fine in the arch-is-a-submodule case.  What I
was thinking of was some makefile bits to something like:
# The true legacy ports, prep/chrp/others.  With a _machine test or
# something.
serial-$(CONFIG_ALL_PPC) += legacy.o
# K2 uses the legacy locations too
serial-$(CONFIG_K2) += legacy.o
# These boards make use of iomem_base/reg shift
serial-$(CONFIG_A) += a_serial.o
serial-$(CONFIG_B) += b_serial.o
...

obj-$(CONFIG_SERIAL_8250) += $(serial-y)

Or so.  Maybe with a rule to turn $(serial-y) into arch_serial.o or
something.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
