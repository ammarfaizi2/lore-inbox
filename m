Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293445AbSCUMGn>; Thu, 21 Mar 2002 07:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310372AbSCUMGe>; Thu, 21 Mar 2002 07:06:34 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:11999 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S293445AbSCUMGZ>; Thu, 21 Mar 2002 07:06:25 -0500
Date: Thu, 21 Mar 2002 13:06:03 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [patch] Don't offer CONFIG_INDYDOG on non-ip22 machines
In-Reply-To: <3C8D380A.166A7895@eyal.emu.id.au>
Message-ID: <Pine.NEB.4.44.0203211258110.2125-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2002, Eyal Lebedinsky wrote:

> gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
> /data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h
> -DKBUILD_BASENAME=indydog  -c -o indydog.o indydog.c
> indydog.c:25: asm/sgi/sgimc.h: No such file or directory
> indydog.c:31: warning: function declaration isn't a prototype
> indydog.c: In function `indydog_ping':
> indydog.c:32: dereferencing pointer to incomplete type
> indydog.c: In function `indydog_open':
> indydog.c:52: `KSEG1' undeclared (first use in this function)
> indydog.c:52: (Each undeclared identifier is reported only once
> indydog.c:52: for each function it appears in.)
> indydog.c:54: dereferencing pointer to incomplete type
> indydog.c:54: `SGIMC_CCTRL0_WDOG' undeclared (first use in this
> function)
> indydog.c:55: dereferencing pointer to incomplete type
> indydog.c: In function `indydog_release':
> indydog.c:72: dereferencing pointer to incomplete type
> indydog.c:73: `SGIMC_CCTRL0_WDOG' undeclared (first use in this
> function)
> indydog.c:74: dereferencing pointer to incomplete type
> make[2]: *** [indydog.o] Error 1
> make[2]: Leaving directory
> `/data2/usr/local/src/linux-2.4-pre/drivers/char'
>
>
> Now, I am on an i386 machine, and indydog.c looks like a foreign object
> here.
> Since I automatically select 'm' for all offered options (just for
> testing)
> I guess we have a bad dependency in the watchdog config (but I am only
> guessing):
>
>    dep_tristate '  Indy/I2 Hardware Watchdog' CONFIG_INDYDOG
> $CONFIG_SGI_IP22
>
> Looks OK to me though. However CONFIG_SGI_IP22 is not set anywhere,
> should
> dep_tristate treat it as FALSE?

After reading Documentation/kbuild/config-language.txt it seems that this
should work in theory...

The following patch fixes it so that it works for me:

--- drivers/char/Config.in.old	Thu Mar 21 12:48:57 2002
+++ drivers/char/Config.in	Thu Mar 21 13:01:21 2002
@@ -201,7 +201,9 @@
    tristate '  SBC-60XX Watchdog Timer' CONFIG_60XX_WDT
    tristate '  W83877F (EMACS) Watchdog Timer' CONFIG_W83877F_WDT
    tristate '  ZF MachZ Watchdog' CONFIG_MACHZ_WDT
-   dep_tristate '  Indy/I2 Hardware Watchdog' CONFIG_INDYDOG $CONFIG_SGI_IP22
+   if [ "$CONFIG_SGI_IP22" = "y" ]; then
+      tristate '  Indy/I2 Hardware Watchdog' CONFIG_INDYDOG
+   fi
 fi
 endmenu



cu
Adrian


