Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265885AbSIRJvF>; Wed, 18 Sep 2002 05:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265908AbSIRJvF>; Wed, 18 Sep 2002 05:51:05 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:20693 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265885AbSIRJvD>; Wed, 18 Sep 2002 05:51:03 -0400
Date: Wed, 18 Sep 2002 11:56:00 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Ivan Gyurdiev <ivg2@cornell.edu>, <ralf@dea.linux-mips.net>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: xconfig doesn't work, 2.4.20-pre7
In-Reply-To: <200209150816.16473.ivg2@cornell.edu>
Message-ID: <Pine.NEB.4.44.0209181144460.15721-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Sep 2002, Ivan Gyurdiev wrote:

> After make clean and make mrproper:
>
> ================================
> [root@cobra linux-2.4]# make xconfig
> rm -f include/asm
> ( cd include ; ln -sf asm-i386 asm)
> make -C scripts kconfig.tk
> make[1]: Entering directory `/usr/src/linux-2.4.20-pre7/scripts'
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkparse.o
> tkparse.c
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkcond.o tkcond.c
> gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkgen.o tkgen.c
> gcc -o tkparse tkparse.o tkcond.o tkgen.o
> cat header.tk >> ./kconfig.tk
> ./tkparse < ../arch/i386/config.in >> kconfig.tk
> drivers/video/Config.in: 216: can't handle dep_bool/dep_mbool/dep_tristate
> condition
> make[1]: *** [kconfig.tk] Error 1
> make[1]: Leaving directory `/usr/src/linux-2.4.20-pre7/scripts'
> make: *** [xconfig] Error 2
> [root@cobra linux-2.4]#


Thanks for the report. The MIPS update in -pre7 changed CONFIG_FB_MAXINE
from bool to dep_bool although no dependency was introduced (most likely
accidentially because the two symbols above got a dependency on
CONFIG_TC). "make xconfig" does the strictest checking and users the do
"make menuconfig" or "make oldconfig" don't see the problem. The
following patch fixes it:


--- drivers/video/Config.in.old	2002-09-18 11:50:30.000000000 +0200
+++ drivers/video/Config.in	2002-09-18 11:50:36.000000000 +0200
@@ -213,7 +213,7 @@
    if [ "$CONFIG_DECSTATION" = "y" ]; then
       dep_bool '  PMAG-BA TURBOchannel framebuffer support' CONFIG_FB_PMAG_BA $CONFIG_TC
       dep_bool '  PMAGB-B TURBOchannel framebuffer support' CONFIG_FB_PMAGB_B $CONFIG_TC
-      dep_bool '  Maxine (Personal DECstation) onboard framebuffer support' CONFIG_FB_MAXINE
+      bool '  Maxine (Personal DECstation) onboard framebuffer support' CONFIG_FB_MAXINE
    fi
    if [ "$CONFIG_NINO" = "y" ]; then
       bool '  TMPTX3912/PR31700 frame buffer support' CONFIG_FB_TX3912


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


