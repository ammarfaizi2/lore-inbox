Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267381AbTACB0R>; Thu, 2 Jan 2003 20:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267382AbTACB0R>; Thu, 2 Jan 2003 20:26:17 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:42768 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S267381AbTACB0O>; Thu, 2 Jan 2003 20:26:14 -0500
Date: Fri, 3 Jan 2003 02:30:18 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: inconsistent design of menus and submenus in 2.5.53
In-Reply-To: <Pine.LNX.4.44.0301012153530.4495-100000@dell>
Message-ID: <Pine.LNX.4.44.0301021912080.12251-100000@spit.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 1 Jan 2003, Robert P. J. Day wrote:

>   another example of this (good) design is the recent addition
> of the 10/100 Mbit and 1000 Mbit options under Network device
> support, once again showing clearly the child option structure.
>
>   contrast that with Parallel port support, where lower options
> in the list that *appear* to be sibling choices to Parallel
> port support are actually child options that vanish when you
> deselect Parallel port support.  very confusing.

This is quite easy to fix, but it will require some work. Someone has to
go through the configuration and check the dependencies, as the
dependencies are used to generate the menu structure.
Below I fixed e.g. the parport config, sometimes there is still cml1
cruft, which couldn't be completely fixed during the automatic conversion,
the logic is still the same, but the menu structure is a little messed up.
So if someone wants to do this, I'd be happy to help and review the work.

bye, Roman

diff -ur -X /home/roman/nodiff linux.org/drivers/parport/Kconfig linux/drivers/parport/Kconfig
--- linux.org/drivers/parport/Kconfig	2002-12-16 03:08:23.000000000 +0100
+++ linux/drivers/parport/Kconfig	2003-01-02 18:11:58.000000000 +0100
@@ -34,9 +34,10 @@

 	  If unsure, say Y.

+if PARPORT
+
 config PARPORT_PC
 	tristate "PC-style hardware"
-	depends on PARPORT
 	---help---
 	  You should say Y here if you have a PC-style parallel port. All
 	  IBM PC compatible computers and some Alphas have PC-style
@@ -51,15 +52,9 @@

 	  If unsure, say Y.

-config PARPORT_PC_CML1
-	tristate
-	depends on PARPORT!=n && PARPORT_PC!=n
-	default PARPORT_PC if SERIAL_8250=y
-	default m if SERIAL_8250=m
-
 config PARPORT_SERIAL
 	tristate "Multi-IO cards (parallel and serial)"
-	depends on SERIAL_8250!=n && PARPORT_PC_CML1
+	depends on SERIAL_8250 && PARPORT_PC
 	help
 	  This adds support for multi-IO PCI cards that have parallel and
 	  serial ports.  You should say Y or M here.  If you say M, the module
@@ -88,18 +83,18 @@

 config PARPORT_PC_PCMCIA
 	tristate "Support for PCMCIA management for PC-style ports"
-	depends on PARPORT!=n && HOTPLUG && (PCMCIA!=n && PARPORT_PC=m && PARPORT_PC || PARPORT_PC=y && PCMCIA)
+	depends on PCMCIA && PARPORT_PC
 	help
 	  Say Y here if you need PCMCIA support for your PC-style parallel
 	  ports. If unsure, say N.

 config PARPORT_ARC
 	tristate "Archimedes hardware"
-	depends on ARM && PARPORT
+	depends on ARM

 config PARPORT_AMIGA
 	tristate "Amiga builtin port"
-	depends on AMIGA && PARPORT
+	depends on AMIGA
 	help
 	  Say Y here if you need support for the parallel port hardware on
 	  Amiga machines. This code is also available as a module (say M),
@@ -107,7 +102,7 @@

 config PARPORT_MFC3
 	tristate "Multiface III parallel port"
-	depends on AMIGA && ZORRO && PARPORT
+	depends on AMIGA && ZORRO
 	help
 	  Say Y here if you need parallel port support for the MFC3 card.
 	  This code is also available as a module (say M), called
@@ -115,7 +110,7 @@

 config PARPORT_ATARI
 	tristate "Atari hardware"
-	depends on ATARI && PARPORT
+	depends on ATARI
 	help
 	  Say Y here if you need support for the parallel port hardware on
 	  Atari machines. This code is also available as a module (say M),
@@ -128,7 +123,7 @@

 config PARPORT_SUNBPP
 	tristate "Sparc hardware (EXPERIMENTAL)"
-	depends on SBUS && EXPERIMENTAL && PARPORT
+	depends on SBUS && EXPERIMENTAL
 	help
 	  This driver provides support for the bidirectional parallel port
 	  found on many Sun machines. Note that many of the newer Ultras
@@ -138,7 +133,6 @@
 # support for loading any others.  Defeat this if the user is keen.
 config PARPORT_OTHER
 	bool "Support foreign hardware"
-	depends on PARPORT
 	help
 	  Say Y here if you want to be able to load driver modules to support
 	  other non-standard types of parallel ports. This causes a
@@ -146,7 +140,6 @@

 config PARPORT_1284
 	bool "IEEE 1284 transfer modes"
-	depends on PARPORT
 	help
 	  If you have a printer that supports status readback or device ID, or
 	  want to use a device that uses enhanced parallel port transfer modes
@@ -154,5 +147,7 @@
 	  transfer modes. Also say Y if you want device ID information to
 	  appear in /proc/sys/dev/parport/*/autoprobe*. It is safe to say N.

+endif
+
 endmenu



