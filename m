Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268709AbUHYU7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268709AbUHYU7z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 16:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268707AbUHYU5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:57:19 -0400
Received: from witte.sonytel.be ([80.88.33.193]:39593 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S268703AbUHYUuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:50:50 -0400
Date: Wed, 25 Aug 2004 22:50:36 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>
cc: "Christian T. Steigies" <cts@debian.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: kernel-image-2.6.7
In-Reply-To: <Pine.GSO.4.58.0408230947190.29370@waterleaf.sonytel.be>
Message-ID: <Pine.GSO.4.58.0408252214080.28854@waterleaf.sonytel.be>
References: <20040809073126.GA4669@skeeve> <Pine.LNX.4.58.0408221129590.25793@anakin>
 <Pine.LNX.4.58.0408221145090.25793@anakin> <20040822101914.GA7480@skeeve>
 <Pine.GSO.4.58.0408221224310.12638@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0408221333460.13834@anakin> <4128C3F4.6070507@linux-m68k.org>
 <Pine.GSO.4.58.0408230947190.29370@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Background: M68k 2.6.x kernels with CONFIG_MODULES=y have been crashing very
  early for me since quite a while. The problem seems to be incorrect addresses
  (and thus sizes) for various variables, causing data structure corruption ]

On Mon, 23 Aug 2004, Geert Uytterhoeven wrote:
> On Sun, 22 Aug 2004, Roman Zippel wrote:
> > Geert Uytterhoeven wrote:
> > > Easily explained by System.map:
> > > | 00194090 B amiga_model
> > > | 00194090 B m68k_memory
> > > | 00194094 B amiga_chipset
> > >
> > > So initializing amiga_model kills m68k_memory...

[ m68k_memory is supposed to be 32 bytes long, not 4 bytes ]

> > Anyway, I still can't reproduce this, but from the object files I've
> > seen, it seems the bss isn't correctly set. Could you please check the
> > various object files under arch/m68k/{kernel,amiga} for their bss size?
>
> At first sight, there seem to be more of them with a zero bss if
> CONFIG_MODULES=y. Will be investigated...

Indeed, in arch/m68k/kernel/setup.o .bss and .init.data become zero-sized,
while all other sections have the same size.

If I do `make V=1 arch/m68k/kernel/setup.o', I get:

| anakin$ make V=1 arch/m68k/kernel/setup.o
| make -C /home/geert/linux/testing/linux-m68k-2.6.9-rc1 O=/home/geert/linux/testing/linux-m68k-2.6.x-amiga-mod arch/m68k/kernel/setup.o
| make -C /home/geert/linux/testing/linux-m68k-2.6.x-amiga-mod            \
| KBUILD_SRC=/home/geert/linux/testing/linux-m68k-2.6.9-rc1            KBUILD_VERBOSE=1   \
| KBUILD_CHECK= KBUILD_EXTMOD=""  \
|         -f /home/geert/linux/testing/linux-m68k-2.6.9-rc1/Makefile arch/m68k/kernel/setup.o
| make -f /home/geert/linux/testing/linux-m68k-2.6.9-rc1/scripts/Makefile.build obj=scripts/basic
| make -f /home/geert/linux/testing/linux-m68k-2.6.9-rc1/scripts/Makefile.build obj=scripts
| make -f /home/geert/linux/testing/linux-m68k-2.6.9-rc1/scripts/Makefile.build obj=scripts/genksyms
| make -f /home/geert/linux/testing/linux-m68k-2.6.9-rc1/scripts/Makefile.build obj=scripts/mod
| make -f /home/geert/linux/testing/linux-m68k-2.6.9-rc1/scripts/Makefile.build obj=arch/m68k/kernel arch/m68k/kernel/setup.o
|   m68k-linux-gcc -Wp,-MD,arch/m68k/kernel/.setup.o.d -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude -Iinclude2 -I/home/geert/linux/testing/linux-m68k-2.6.9-rc1/include -I/home/geert/linux/testing/linux-m68k-2.6.9-rc1/arch/m68k/kernel -Iarch/m68k/kernel -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -pipe -fno-strength-reduce -ffixed-a2 -m68040 -O2 -fomit-frame-pointer  -DKBUILD_BASENAME=setup -DKBUILD_MODNAME=setup -c -o arch/m68k/kernel/.tmp_setup.o /home/geert/linux/testing/linux-m68k-2.6.9-rc1/arch/m68k/kernel/setup.c
| anakin$

Note that according to the last line, m68k-linux-gcc will store its output in
arch/m68k/kernel/.tmp_setup.o instead of arch/m68k/kernel/setup.o! But
afterwards there is no arch/m68k/kernel/.tmp_setup.o, only
arch/m68k/kernel/setup.o?

If I execute the m68k-linux-gcc command by hand, it does create
arch/m68k/kernel/.tmp_setup.o, and ... surprise! The sizes of the .bss and .init.data sections in that file are correct:

| anakin$ m68k-linux-objdump -h arch/m68k/kernel/.tmp_setup.o
|
| arch/m68k/kernel/.tmp_setup.o:     file format elf32-m68k
|
| Sections:
| Idx Name          Size      VMA       LMA       File off  Algn
|   0 .text         0000024a  00000000  00000000  00000034  2**2
|                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
|   1 .data         0000001a  00000000  00000000  00000280  2**2
|                   CONTENTS, ALLOC, LOAD, RELOC, DATA
|   2 .bss          00000188  00000000  00000000  0000029c  2**2
                    ^^^^^^^^
|                   ALLOC
|   3 .note         00000014  00000000  00000000  0000029c  2**0
|                   CONTENTS, READONLY
|   4 .init.data    00000008  00000000  00000000  000002b0  2**1
                    ^^^^^^^^
|                   CONTENTS, ALLOC, LOAD, DATA
|   5 __kcrctab     00000004  00000000  00000000  000002b8  2**1
|                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
|   6 __ksymtab_strings 0000000f  00000000  00000000  000002bc  2**0
|                   CONTENTS, ALLOC, LOAD, READONLY, DATA
|   7 __ksymtab     00000008  00000000  00000000  000002cc  2**1
|                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
|   8 .rodata       00000256  00000000  00000000  000002d4  2**0
|                   CONTENTS, ALLOC, LOAD, READONLY, DATA
|   9 .init.text    00000396  00000000  00000000  0000052a  2**1
|                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
|  10 .comment      0000002f  00000000  00000000  000008c0  2**0
|                   CONTENTS, READONLY
| anakin$

while .bss and .init.data are of size zero in arch/m68k/kernel/setup.o:

| anakin$ m68k-linux-objdump -h arch/m68k/kernel/setup.o
|
| arch/m68k/kernel/setup.o:     file format elf32-m68k
|
| Sections:
| Idx Name          Size      VMA       LMA       File off  Algn
|   0 .text         0000024a  00000000  00000000  00000034  2**2
|                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
|   1 __kcrctab     00000004  00000000  00000000  0000027e  2**1
|                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
|   2 __ksymtab_strings 0000000f  00000000  00000000  00000282  2**0
|                   CONTENTS, ALLOC, LOAD, READONLY, DATA
|   3 __ksymtab     00000008  00000000  00000000  00000292  2**1
|                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, DATA
|   4 .rodata       00000256  00000000  00000000  0000029a  2**0
|                   CONTENTS, ALLOC, LOAD, READONLY, DATA
|   5 .init.text    00000396  00000000  00000000  000004f0  2**1
|                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
|   6 .data         0000001a  00000000  00000000  00000888  2**2
|                   CONTENTS, ALLOC, LOAD, RELOC, DATA
|   7 .bss          00000000  00000000  00000000  000008a4  2**2
                    ^^^^^^^^
|                   ALLOC
|   8 .init.data    00000000  00000000  00000000  000008a4  2**1
                    ^^^^^^^^
|                   CONTENTS, ALLOC, LOAD, DATA
|   9 .note         00000014  00000000  00000000  000008a4  2**0
|                   CONTENTS, READONLY
|  10 .comment      0000002f  00000000  00000000  000008b8  2**0
|                   CONTENTS, READONLY
| anakin$

Now the remaining questions are:
  1. Why does kbuild create arch/m68k/kernel/.tmp_setup.o?
  2. How does kbuild create setup.o from .tmp_setup.o, destroying .bss and
     .init.data?
  3. Why doesn't the above step show up with `make V=1'?

[ digging into scripts/Makefile.build ]

Aha, kbuild does this only if CONFIG_MODVERSIONS=y.

So it goes wrong during this step:

| m68k-linux-ld -r -o x.o arch/m68k/kernel/.tmp_setup.o -T \
| arch/m68k/kernel/.tmp_setup.ver

| anakin$ cat arch/m68k/kernel/.tmp_setup.ver
| __crc_mach_heartbeat = 0x39638af7 ;
| anakin$

Does the above look like a valid linker file? `mach_heartbeat' is indeed the
only exported symbol in arch/m68k/kernel/setup.c.

[ disabling CONFIG_MODVERSIONS ]

And now .bss and .initdata are OK as well... Let's see whether the resulting
kernel works...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
