Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319215AbSHNF4q>; Wed, 14 Aug 2002 01:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319218AbSHNF4q>; Wed, 14 Aug 2002 01:56:46 -0400
Received: from rj.SGI.COM ([192.82.208.96]:32189 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S319215AbSHNF4o>;
	Wed, 14 Aug 2002 01:56:44 -0400
Message-ID: <3D59F22E.D0DA5FC6@alphalink.com.au>
Date: Wed, 14 Aug 2002 16:01:18 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.15-4mdkfb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Samuelson <peter@cadcamlab.org>
CC: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
References: <Pine.LNX.4.44.0208120924320.5882-100000@chaos.physics.uiowa.edu> <3D587483.1C459694@alphalink.com.au> <20020813033951.GF761@cadcamlab.org> <3D59110B.6D9A1223@alphalink.com.au> <20020813155330.GG761@cadcamlab.org> <3D59AEB7.7B80F33@alphalink.com.au> <20020814032841.GM761@cadcamlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> 
> > > [...]  Perhaps a "kernel subsystems" submenu under "general setup",
> > > or even as a toplevel menu.
> >
> > Sounds like a good idea.  You could put CONFIG_SERIAL and CONFIG_PCMCIA
> > in there too.
> 
> CONFIG_SERIAL and CONFIG_PCMCIA didn't generate any noise, though.

warning:drivers/parport/Config.in:14:forward declared symbol "CONFIG_SERIAL" compared ambiguously to "n"
warning:drivers/parport/Config.in:14:forward reference to "CONFIG_SERIAL"
warning:drivers/parport/Config.in:15:forward reference to "CONFIG_SERIAL"


warning:drivers/char/Config.in:193:forward declared symbol "CONFIG_PCMCIA" compared ambiguously to "n"
warning:drivers/char/pcmcia/Config.in:8:forward declared symbol "CONFIG_PCMCIA" used in dependency list for "CONFIG_SYNCLINK_CS"
warning:drivers/ide/Config.in:19:forward declared symbol "CONFIG_PCMCIA" used in dependency list for "CONFIG_BLK_DEV_IDECS"
warning:drivers/isdn/hardware/avm/Config.in:20:forward declared symbol "CONFIG_PCMCIA" used in dependency list for "CONFIG_ISDN_DRV_AVMB1_AVM_CS"
[...30-odd more...]

> Here's a start.  It looks a little hacky but it does fix real issues.
> I decided to combine "general setup", "module config" and "major
> subsystems" - the latter needs to come after modules but really
> belongs with general setup.  Eh?
> 
> I think the first patch belongs on trivial@rustcorp - what's the
> protocol there, just an email cc?  Attach or inline?  etc.

I've been inlining.  Use a unique subject line for when you get status
updates.

The diffs look ok to me, except...

> +# FIXME usb should depend on (PCI || SA1111) - but that causes other ordering problems
> +tristate 'USB support' CONFIG_USB

Nasty.

> +
> +# FIXME parisc, sparc didn't include this menu before - any reason?

I'd suggest preserving that behaviour.  CONFIG_PARISC for parisc.

> +if [ "$CONFIG_ARCH_S390" != "y" ]; then
> +   tristate 'Input core support' CONFIG_INPUT
> +fi
> +
> +# FIXME m68k, sparc* didn't include this either but we can't test for them

I still don't know the right way to test for m68k, but for sparc* you
need to test CONFIG_SPARC32 and CONFIG_SPARC64.

> +   dep_tristate '  I2C bit-banging interfaces' CONFIG_I2C_ALGOBIT $CONFIG_I2C
> +fi
> +
>  endmenu

Are you sure want this one there?


Your first patch made the following improvements

--- s-2.5.31.txt	Wed Aug 14 15:51:44 2002
+++ s-2.5.31-sam1.txt	Wed Aug 14 15:52:48 2002
@@ -313,8 +313,6 @@
     1      CONFIG_PROC_FS
-287    forward-reference
-    48     CONFIG_USB
+251    forward-reference
+    54     CONFIG_USB
     43     CONFIG_PROC_FS
     31     CONFIG_SCSI
-    24     CONFIG_INPUT
-    18     CONFIG_SOUND_GAMEPORT
     16     CONFIG_I2C
@@ -335,7 +333,5 @@
     1      CONFIG_ZORRO
-152    forward-dependancy
-    32     CONFIG_USB
+116    forward-dependancy
+    35     CONFIG_USB
     31     CONFIG_SCSI
-    21     CONFIG_INPUT
-    18     CONFIG_SOUND_GAMEPORT
     11     CONFIG_ISDN_CAPI
@@ -408,2 +404,2 @@
 8      different-compound-type
-3362   total
+3290   total

Your second patch made the following improvements (well,
mostly improvements).

--- s-2.5.31-sam1.txt	Wed Aug 14 15:52:48 2002
+++ s-2.5.31-sam2.txt	Wed Aug 14 15:56:09 2002
@@ -206,3 +206,3 @@
     1      CONFIG_WILLOW
-61     different-parent
+66     different-parent
     7      CONFIG_NET_FC
@@ -210,2 +210,5 @@
     2      CONFIG_FB
+    2      CONFIG_KMOD
+    2      CONFIG_MODULES
+    2      CONFIG_MODVERSIONS
     2      CONFIG_RTC
@@ -251,5 +254,4 @@
     1      CONFIG_SCC_ENET
-    1      CONFIG_USB
     1      CONFIG_USE_MDIO
-36     overlapping-definitions
+38     overlapping-definitions
     11     CONFIG_SOUND_CMPCI_FMIO
@@ -261,2 +263,3 @@
     2      CONFIG_PARPORT
+    2      CONFIG_USB
     1      CONFIG_ALPHA_AVANTI
@@ -301,3 +304,3 @@
     1      CONFIG_XSCALE_PMU_TIMER
-75     forward-compared-to-n
+59     forward-compared-to-n
     13     CONFIG_INPUT_GAMEPORT
@@ -306,4 +309,2 @@
     12     CONFIG_PCMCIA
-    10     CONFIG_USB
-    6      CONFIG_I2C
     3      CONFIG_CARDBUS
@@ -313,8 +314,4 @@
     1      CONFIG_PROC_FS
-251    forward-reference
-    54     CONFIG_USB
+134    forward-reference
     43     CONFIG_PROC_FS
-    31     CONFIG_SCSI
-    16     CONFIG_I2C
-    16     CONFIG_I2C_ALGOBIT
     14     CONFIG_SCSI_AIC7XXX_OLD
@@ -333,5 +330,3 @@
     1      CONFIG_ZORRO
-116    forward-dependancy
-    35     CONFIG_USB
-    31     CONFIG_SCSI
+34     forward-dependancy
     11     CONFIG_ISDN_CAPI
@@ -339,10 +334,8 @@
     11     CONFIG_SOUND_ACI_MIXER
-    9      CONFIG_I2C_ALGOBIT
-    7      CONFIG_I2C
     1      CONFIG_BLK_DEV_SD
-823    undeclared-dependancy
+794    undeclared-dependancy
     94     CONFIG_PCI
     69     CONFIG_ISA
-    60     CONFIG_X86
     58     CONFIG_ALL_PPC
+    54     CONFIG_X86
     48     CONFIG_ARCH_ACORN
@@ -361,3 +354,2 @@
     11     CONFIG_ATARI
-    11     CONFIG_I2C
     11     CONFIG_MAC
@@ -384,6 +376,4 @@
     8      CONFIG_SBUS
-    7      CONFIG_I2C_ALGOBIT
     6      CONFIG_MTD
     6      CONFIG_SOUND_GAMEPORT
-    5      CONFIG_USB
     4      CONFIG_PARPORT
@@ -403,3 +393,3 @@
     1      CONFIG_SH_WDT
-8      different-compound-type
-3290   total
+10     different-compound-type
+3055   total



Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.     - Roger Sandall, The Age, 28Sep2001.
