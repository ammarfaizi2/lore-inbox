Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316610AbSFZOqk>; Wed, 26 Jun 2002 10:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316611AbSFZOqj>; Wed, 26 Jun 2002 10:46:39 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:27551
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S316610AbSFZOqh>; Wed, 26 Jun 2002 10:46:37 -0400
Date: Wed, 26 Jun 2002 07:46:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Brad Hards <bhards@bigpond.net.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC 2.4.19-rc1] Fix dependancies on keybdev.o
Message-ID: <20020626144609.GR3489@opus.bloom.county>
References: <20020625160644.GP3489@opus.bloom.county> <200206261236.24247.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200206261236.24247.bhards@bigpond.net.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2002 at 12:36:24PM +1000, Brad Hards wrote:
> On Wed, 26 Jun 2002 02:06, Tom Rini wrote:
> > Right now drivers/input/keybdev.o depends on drivers/char/keyboard.o for
> > handle_scancode, keyboard_tasklet and kbd_ledfunc.  However, compiling
> > drivers/char/keyboard.o isn't quite straight forward, as we have:
> > ifndef CONFIG_SUN_KEYBOARD
> >   obj-$(CONFIG_VT) += keyboard.o $(KEYMAP) $(KEYBD)
> > else
> >   obj-$(CONFIG_PCI) += keyboard.o $(KEYMAP)
> > endif
> > in drivers/char/Makefile
> >
> > To attempt to work around this, I've come up with the following patch
> > for drivers/input/Config.in.  Comments?
> Here is a bit of arch/i386/config.in:
> <extract>
> # input before char - char/joystick depends on it. As does USB.
> #
> source drivers/input/Config.in
> source drivers/char/Config.in
> </extract>

Boy, it would be nice if that was mentioned somewhere else. :)  alpha,
mips, and mips64 get that wrong..

> So it will still crap out, because CONFIG_VT and CONFIG_SUN_KEYBOARD won't be 
> set early enough.

Well CONFIG_SUN_KEYBOARD is define_bool'ed at the begining on
sparc/sparc64 (and PCI is asked before input, so that is OK).  But
CONFIG_VT makes things less fun..

> Three possible options, none of them especially good:
> 1. Do various munging of config and make setup and try to cover this.

Probably harder than it's worth.

> 2. Move keyboard handling code to input subsystem

I think that will work out the best.  How's the attached look?  It moves
drivers/input/Config.in inside of drivers/char/Config.in and then fixes
arches which had both.  (Lightly tested from xconfig[1] for all arches
which got changed).


> 3. Do wholesale backport of input subsystem from 2.5

Not really an option (and 2.5 has this problem anyhow) since it's so
invasive, once it's done.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

[1] xconfig because it tends to be the easiest to break.

===== arch/alpha/config.in 1.15 vs edited =====
--- 1.15/arch/alpha/config.in	Sat May 25 19:37:06 2002
+++ edited/arch/alpha/config.in	Wed Jun 26 07:30:11 2002
@@ -397,7 +397,6 @@
 endmenu
 
 source drivers/usb/Config.in
-source drivers/input/Config.in
 
 source net/bluetooth/Config.in
 
===== arch/arm/config.in 1.14 vs edited =====
--- 1.14/arch/arm/config.in	Fri Apr  5 12:12:20 2002
+++ edited/arch/arm/config.in	Wed Jun 26 07:30:24 2002
@@ -554,11 +554,6 @@
 fi
 endmenu
 
-#
-# input before char - char/joystick depends on it. As does USB.
-#
-source drivers/input/Config.in
-
 source drivers/char/Config.in
 if [ "$CONFIG_ARCH_ACORN" = "y" -a \
      "$CONFIG_BUSMOUSE" = "y" ]; then
===== arch/cris/config.in 1.10 vs edited =====
--- 1.10/arch/cris/config.in	Tue Feb  5 07:10:18 2002
+++ edited/arch/cris/config.in	Wed Jun 26 07:30:29 2002
@@ -222,10 +222,6 @@
 fi
 endmenu
 
-#
-# input before char - char/joystick depends on it. As does USB.
-#
-source drivers/input/Config.in
 source drivers/char/Config.in
 
 #source drivers/misc/Config.in
===== arch/i386/config.in 1.28 vs edited =====
--- 1.28/arch/i386/config.in	Tue Apr 16 04:30:28 2002
+++ edited/arch/i386/config.in	Wed Jun 26 07:30:32 2002
@@ -375,10 +375,6 @@
 fi
 endmenu
 
-#
-# input before char - char/joystick depends on it. As does USB.
-#
-source drivers/input/Config.in
 source drivers/char/Config.in
 
 #source drivers/misc/Config.in
===== arch/ia64/config.in 1.9 vs edited =====
--- 1.9/arch/ia64/config.in	Sat Mar  9 13:41:04 2002
+++ edited/arch/ia64/config.in	Wed Jun 26 07:30:36 2002
@@ -203,10 +203,6 @@
 
 fi # !HP_SIM
 
-#
-# input before char - char/joystick depends on it. As does USB.
-#
-source drivers/input/Config.in
 source drivers/char/Config.in
 
 #source drivers/misc/Config.in
===== arch/m68k/config.in 1.8 vs edited =====
--- 1.8/arch/m68k/config.in	Fri Mar  1 05:29:44 2002
+++ edited/arch/m68k/config.in	Wed Jun 26 07:42:36 2002
@@ -171,10 +171,6 @@
    source net/Config.in
 fi
 
-if [ "$CONFIG_MAC" = "y" ]; then
-   source drivers/input/Config.in
-fi
-
 mainmenu_option next_comment
 comment 'ATA/IDE/MFM/RLL support'
 
@@ -396,6 +392,10 @@
    if [ "$CONFIG_VT" = "y" ]; then
       bool 'Support for console on virtual terminal' CONFIG_VT_CONSOLE
    fi
+fi
+
+if [ "$CONFIG_MAC" = "y" ]; then
+   source drivers/input/Config.in
 fi
 
 if [ "$CONFIG_ATARI" = "y" ]; then
===== arch/mips/config.in 1.6 vs edited =====
--- 1.6/arch/mips/config.in	Thu Feb 28 06:57:19 2002
+++ edited/arch/mips/config.in	Wed Jun 26 07:30:46 2002
@@ -628,7 +628,6 @@
 fi
 
 source drivers/usb/Config.in
-source drivers/input/Config.in
 
 mainmenu_option next_comment
 comment 'Kernel hacking'
===== arch/mips64/config.in 1.6 vs edited =====
--- 1.6/arch/mips64/config.in	Thu Feb 28 06:57:19 2002
+++ edited/arch/mips64/config.in	Wed Jun 26 07:30:50 2002
@@ -325,7 +325,6 @@
 fi
 
 source drivers/usb/Config.in
-source drivers/input/Config.in
 
 mainmenu_option next_comment
 comment 'Kernel hacking'
===== arch/ppc/config.in 1.17 vs edited =====
--- 1.17/arch/ppc/config.in	Fri Apr  5 03:38:55 2002
+++ edited/arch/ppc/config.in	Wed Jun 26 07:31:14 2002
@@ -321,8 +321,6 @@
 fi
 endmenu
 
-source drivers/input/Config.in
-
 mainmenu_option next_comment
 comment 'Macintosh device drivers'
 
===== arch/ppc64/config.in 1.2 vs edited =====
--- 1.2/arch/ppc64/config.in	Fri Mar 29 03:18:26 2002
+++ edited/arch/ppc64/config.in	Wed Jun 26 07:31:19 2002
@@ -170,8 +170,6 @@
 source drivers/video/Config.in
 endmenu
 
-source drivers/input/Config.in
-
 if [ "$CONFIG_PPC_ISERIES" = "y" ]; then
 mainmenu_option next_comment
 comment 'iSeries device drivers'
===== arch/sh/config.in 1.6 vs edited =====
--- 1.6/arch/sh/config.in	Tue Feb  5 07:10:15 2002
+++ edited/arch/sh/config.in	Wed Jun 26 07:43:22 2002
@@ -275,11 +275,6 @@
 fi
 endmenu
 
-#
-# input before char - char/joystick depends on it. As does USB.
-#
-source drivers/input/Config.in
-
 # if [ "$CONFIG_SH_DREAMCAST" = "y" ]; then
 #    source drivers/maple/Config.in
 # fi
@@ -312,6 +307,8 @@
      "$CONFIG_SH_SOLUTION_ENGINE" = "y" ]; then
    bool 'Heartbeat LED' CONFIG_HEARTBEAT
 fi
+
+source drivers/input/Config.in
 
 if [ "$CONFIG_SH_DREAMCAST" = "y" -a "$CONFIG_MAPLE" != "n" ]; then
    mainmenu_option next_comment
===== drivers/char/Config.in 1.28 vs edited =====
--- 1.28/drivers/char/Config.in	Fri May  3 01:49:04 2002
+++ edited/drivers/char/Config.in	Wed Jun 26 07:28:09 2002
@@ -137,6 +137,8 @@
 
 source drivers/i2c/Config.in
 
+source drivers/input/Config.in
+
 mainmenu_option next_comment
 comment 'Mice'
 tristate 'Bus Mouse Support' CONFIG_BUSMOUSE
===== drivers/input/Config.in 1.2 vs edited =====
--- 1.2/drivers/input/Config.in	Tue Feb  5 00:45:17 2002
+++ edited/drivers/input/Config.in	Tue Jun 25 08:58:41 2002
@@ -6,7 +6,12 @@
 comment 'Input core support'
 
 tristate 'Input core support' CONFIG_INPUT
-dep_tristate '  Keyboard support' CONFIG_INPUT_KEYBDEV $CONFIG_INPUT
+if [ "$CONFIG_SUN_KEYBOARD" = "y" -a "$CONFIG_PCI" = "y"]; then
+   define_bool CONFIG_SUN_CAN_INPUT_KEYBDEV y
+fi
+if [ "$CONFIG_VT" = "y" -o "$CONFIG_SUN_CAN_INPUT_KEYBDEV" = "y" ]; then
+   dep_tristate '  Keyboard support' CONFIG_INPUT_KEYBDEV $CONFIG_INPUT
+fi
 dep_tristate '  Mouse support' CONFIG_INPUT_MOUSEDEV $CONFIG_INPUT
 if [ "$CONFIG_INPUT_MOUSEDEV" != "n" ]; then
    int '   Horizontal screen resolution' CONFIG_INPUT_MOUSEDEV_SCREEN_X 1024
