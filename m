Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWIWLDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWIWLDm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 07:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWIWLDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 07:03:42 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:46837 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750725AbWIWLDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 07:03:41 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Date: Sat, 23 Sep 2006 13:03:35 +0200
User-Agent: KMail/1.9.4
Cc: "Luke Yang" <luke.adi@gmail.com>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com> <200609230218.36894.arnd@arndb.de> <8bd0f97a0609222350o3a9c8c36g468a6177ae7b1ea7@mail.gmail.com>
In-Reply-To: <8bd0f97a0609222350o3a9c8c36g468a6177ae7b1ea7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609231303.35481.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 23 September 2006 08:50, Mike Frysinger wrote:
> On 9/22/06, Arnd Bergmann <arnd@arndb.de> wrote:
>
> > It would be nice if you could use a generic way to pass this partition data
> > to the kernel from the mtd medium, instead of hardcoding it here.
> 
> i often wish for such things myself :)
> 
> unfortunately, the boot loader we utilize (u-boot) isnt exactly
> friendly to the idea of managing flash partitions like redboot, and
> what we have here is the current standard method for defining flash
> partitions with mtd

For powerpc, we have started using a flattened device tree derived
from the Open Firmware standard for passing data to the kernel.
AFAIK, u-boot has some support for this, or at least you can build
a generic kernel and stick it into uboot together with a device
tree file.

There are different views on whether it's a good idea to have
the same format on platforms that don't have an Open Firmware
implementation, but even if you use a different format, it helps
to have a single blob describing all of your system, including
stuff like mmio register areas, cpu types, flash layout,
attached buses, etc.

> > There is not much point in trying to use the same numbers as an existing
> > architecture if that means that you have to leave holes like setup().
> > I don't know if you still have the choice of completely changing the
> > syscall numbers, but it would make it nicer in the future.
> 
> we do, fortunately, have this luxury ... so we can look forward to a
> nice cleaning of our syscall interface

Ah, very good.

> > > +#define BUG() do { \
> > > +     dump_stack(); \
> > > +     printk("\nkernel BUG at %s:%d!\n", __FILE__, __LINE__); \
> > > +     panic("BUG!"); \
> > > +} while (0)
> >
> > This is probably better done as an external function:
> 
> *shrug* i just did it the same way everyone else does ... i'm a sheep like that

Ah, then just stay with your code. Maybe someone will want to change it
across architectures some day and it would help to have it common then.

Actually, the preferred way of implementing BUG and BUG_ON is to have
a single inline assembly opcode that will do an unconditional or a 
condition trap (e.g. invalid opcode) so you can use your regular
fault handler to print the backtrace and such.

> > > diff -urN linux-2.6.18/include/asm-blackfin/mach-bf533/anomaly.h
> > linux-2.6.18.patch1/include/asm-blackfin/mach-bf533/anomaly.h
> > > --- linux-2.6.18/include/asm-blackfin/mach-bf533/anomaly.h    1970-01-01
> > 08:00:00.000000000 +0800
> > > +++ linux-2.6.18.patch1/include/asm-blackfin/mach-bf533/anomaly.h     2006-09-21
> > 09:29:49.000000000 +0800
> > > @@ -0,0 +1,172 @@
> > > +/*
> > > + * File:         include/asm-blackfin/mach-bf533/anomaly.h
> >
> > You seem to have lots of these machine specfic header files in include/asm.
> > Please move them to the respective machine implementation directory
> > if they are only used from there
> 
> these are arch specific, not machine (aka board)
> 
> this is what the blackfin family looks like (first entry is the architecture):
>  - BF535
>  - BF533 / BF532 / BF531
>  - BF537 / BF536 / BF534
>  - BF561
> 
> which is why you find the anomaly definitions in the architecture
> specific header dir

Ok, we need to align on the terminology then. The 'architecture'
is a fixed term for the top level of the hierarchy (i386, powerpc,
blackfin, ...), so you should try to avoid using that to refer
to things inside of blackfin.

We have at least three established terms for more specific things:
'subarchitecture', 'platform' and 'machine'.

Calling the most specific one 'machine' is very common, so that's
fine.

What you call 'architecture' (bf535, bf533, bf537, bf561) should
probably be either 'subarchitecture' or 'platform' in your code.

Now to my point: If all the files that use the platform specific
headers are in the same source directory, then these headers should
also be in that platform directory. To compare it with powerpc,
where we have discussed a long time about the ideal file layout,
that would mean you get:

arch/blackfin/platforms/bf535/anomaly.h
                              setup.c
arch/blackfin/platforms/bf533/anomaly.h
                              setup-531.c
                              setup-532.c
                              setup-533.c

> > > +/* Clock and System Control (0xFFC0 0400-0xFFC0 07FF) */
> > > +#define bfin_read_PLL_CTL()                  bfin_read16(PLL_CTL)
> > > +#define bfin_write_PLL_CTL(val)              bfin_write16(PLL_CTL,val)
> > > +#define bfin_read_PLL_STAT()                 bfin_read16(PLL_STAT)
> > (and 700 more of these)
> >
> > What's the point, are you getting paid by lines of code? Just use
> > the registers directly!
> 
> in our last submission we were doing exactly that ... and we were told
> to switch to a function style method of reading/writing memory mapped
> registers

It's hard to imagine that what you have here was intended by the comment
then. Do you have an archive link about that discussion?

	Arnd <><
