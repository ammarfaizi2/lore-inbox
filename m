Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267732AbUH2LjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267732AbUH2LjM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 07:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267739AbUH2LjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 07:39:12 -0400
Received: from witte.sonytel.be ([80.88.33.193]:25296 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S267732AbUH2LjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 07:39:03 -0400
Date: Sun, 29 Aug 2004 13:38:02 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Roman Zippel <zippel@linux-m68k.org>,
       "Christian T. Steigies" <cts@debian.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: kernel-image-2.6.7
In-Reply-To: <20040826195643.GI9539@mars.ravnborg.org>
Message-ID: <Pine.GSO.4.58.0408291324020.10903@teasel.sonytel.be>
References: <20040809073126.GA4669@skeeve> <Pine.LNX.4.58.0408221129590.25793@anakin>
 <Pine.LNX.4.58.0408221145090.25793@anakin> <20040822101914.GA7480@skeeve>
 <Pine.GSO.4.58.0408221224310.12638@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0408221333460.13834@anakin> <4128C3F4.6070507@linux-m68k.org>
 <Pine.GSO.4.58.0408230947190.29370@waterleaf.sonytel.be>
 <Pine.GSO.4.58.0408252214080.28854@waterleaf.sonytel.be>
 <20040826195643.GI9539@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, Sam Ravnborg wrote:
> Could you try to stuff in an echo line here - something like:
> 	echo  $(LD) $(LDFLAGS) 					\
>         $(LD) $(LDFLAGS) -r -o $@ $(@D)/.tmp_$(@F)              \
>                 -T $(@D)/.tmp_$(@F:.o=.ver);                    \
>
> Just to be confirmed that there is no LDFLAGS that fouls us here.

And LDFLAGS doesn't foul us here (it's just `-m m68kelf').

Just for those that are interested: after some more digging this turned out to
be a bug in the (old) binutils I'm using. It got fixed in later releases of
binutils. (Originally I thought the problem was introduced during the final
linking step of the kernel, and it showed up with whatever version of ld I
used for the final linking step).

How to reproduce:

| anakin$ cat test.s
|         .version        "01.01"
| .section        .bss
| m68k_memory:
|         .zero   32
| anakin$

The key is the `.version' keyword, without that the problem cannot be
reproduced.

| anakin$ cat test.ver
| anakin$

Yep, an empty linker script is fine. Without a linker script it cannot be
reproduced, though.

Results for dfferent versions of binutils:

| anakin$ m68k-linux-as -o test.o test.s && m68k-linux-ld -r -o test2.o test.o -T test.ver && m68k-linux-objdump -h test*.o | grep bss; m68k-linux-ld -V
|   2 .bss          00000020  00000000  00000000  00000034  2**2
|   2 .bss          00000000  00000000  00000000  00000034  2**2
                    ^^^^^^^^
BUG! .bss becomes zero sized!

| GNU ld version 2.9.5 (with BFD 2.9.5.0.37)
|   Supported emulations:
|    m68kelf
|    m68klinux
| anakin$

And newer binutils are fine:

| tux$ m68k-linux-as -o test.o test.s && m68k-linux-ld -r -o test2.o test.o -T test.ver && m68k-linux-objdump -h test*.o | grep bss; m68k-linux-ld -V
|   2 .bss          00000020  00000000  00000000  00000034  2**2
|   2 .bss          00000020  00000000  00000000  00000034  2**2
| GNU ld version 2.13.90.0.10 20021010
|   Supported emulations:
|    m68kelf
|    m68klinux
| tux$

| anakin$ m68k-linux-as -o test.o test.s && m68k-linux-ld -r -o test2.o test.o -T test.ver && m68k-linux-objdump -h test*.o | grep bss; m68k-linux-ld -V
|   2 .bss          00000020  00000000  00000000  00000034  2**2
|   2 .bss          00000020  00000000  00000000  00000034  2**2
| GNU ld version 2.14.90.0.7 20031029 Debian GNU/Linux
|   Supported emulations:
|    m68kelf
|    m68klinux
| anakin$

Conclusions: gcc 2.95.2 and binutils 2.9.5 are fine for compiling 2.6.x kernels
for m68k, but:
  - You need a newer binutils for building initramfs (make usr/)
  - You need a newer binutils for building modular kernels with
    CONFIG_MODVERSIONS=y

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
