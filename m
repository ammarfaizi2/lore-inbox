Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319595AbSH2XP4>; Thu, 29 Aug 2002 19:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319596AbSH2XPz>; Thu, 29 Aug 2002 19:15:55 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:52956 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S319595AbSH2XPx>; Thu, 29 Aug 2002 19:15:53 -0400
Date: Fri, 30 Aug 2002 01:20:14 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Dave Hansen <haveblue@us.ibm.com>
cc: Michael Obster <michael.obster@bingo-ev.de>,
       <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Compiling 2.5.32
In-Reply-To: <3D6E82DF.2090100@us.ibm.com>
Message-ID: <Pine.NEB.4.44.0208300113410.2879-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2002, Dave Hansen wrote:

> Michael Obster wrote:
> > can anybody give me hint. I don't think it is a bug, but i don't know
> > what this error means for me. It is in "make bzImage" and the config is
> > attached. Symlink asm is on asm-i386 and i added "ln -s
> > /usr/src/linux/include/asm-generic /usr/include/asm-generic". Build
> > environment is Athlon, Kernel 2.4.18, gcc 2.95.3
> > <snip>
> > drivers/built-in.o(.data+0x2fab4): undefined reference to `local symbols
>
>  From what I understand this happens when these conditions are met:
> 1. You use a recent version of binutils (Debian has one)
> 2. CONFIG_HOTPLUG is not set
> 3. You compile a driver that doesn't properly use __devexit_p macro
>
> I fixed this in the IPS driver:
> http://linus.bkbits.net:8080/linux-2.5/user=haveblue/cset@1.485.7.2
>
> So, find and fix the driver, use hotplug, or get an older binutils.


Michael's problem is drivers/net/tulip/de2104x.c and this problem is known
since several months.

There are two possible solutions:

1. make the driver hot-pluggable
2. #ifdef the .remove away


Jeff Garzik doesn't want 1. until "someone actually tells me they are
trying to hot-plug such a card" and he didn't apply the following patch to
#ifdef the .remove away if the driver is compiled statically into the
kernel:


--- drivers/net/tulip/de2104x.c.old	2002-08-30 01:06:09.000000000 +0200
+++ drivers/net/tulip/de2104x.c	2002-08-30 01:06:45.000000000 +0200
@@ -2216,7 +2216,9 @@
 	.name		= DRV_NAME,
 	.id_table	= de_pci_tbl,
 	.probe		= de_init_one,
+#ifdef MODULE
 	.remove		= de_remove_one,
+#endif
 #ifdef CONFIG_PM
 	.suspend	= de_suspend,
 	.resume		= de_resume,


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

