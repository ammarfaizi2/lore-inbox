Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277578AbRJRDbr>; Wed, 17 Oct 2001 23:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277580AbRJRDbh>; Wed, 17 Oct 2001 23:31:37 -0400
Received: from kaa.perlsupport.com ([205.245.149.25]:268 "EHLO
	kaa.perlsupport.com") by vger.kernel.org with ESMTP
	id <S277578AbRJRDbY>; Wed, 17 Oct 2001 23:31:24 -0400
Date: Wed, 17 Oct 2001 20:31:46 -0700
From: Chip Salzenberg <chip@pobox.com>
To: jsimmons@transvirtual.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        linuxconsole-dev@lists.sourceforge.net
Subject: [PATCH] input-ps2: Put serio and serport in drivers/input
Message-ID: <20011017203146.A5503@perlsupport.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The recently posted input-ps2 patch breaks if the serio and serport
object files in drivers/char/joystick are required only for PS/2
(i.e. they weren't enabled already for joysticks).  And that brings
up the question: What the heck are those files doing in the joystick
driver dir in the first place?!

It seems to me that serio.c and serport.c belong in drivers/input more
than anywhere else.  I'm enclosing a patch that handles just such a
relocation.  The patch doesn't actually move the files ... that would
just inflate the patch, and it's a lot easier to just "mv" them.

Share & Enjoy!
-- 
Chip Salzenberg               - a.k.a. -              <chip@pobox.com>
 "We have no fuel on board, plus or minus 8 kilograms."  -- NEAR tech

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=input-ps2-fixes-1


Index: drivers/char/Config.in
--- drivers/char/Config.in.old	Wed Oct 17 13:36:43 2001
+++ drivers/char/Config.in	Wed Oct 17 15:31:56 2001
@@ -103,13 +103,12 @@
 fi
 
-if [ "$CONFIG_INPUT" != "n" -a "CONFIG_INPUT_KEYBDEV" != "n" ]; then
+if [ "$CONFIG_INPUT" != "n" -a "CONFIG_INPUT_KEYBDEV" != "n" -a "$CONFIG_INPUT_SERIO" != "n" ]; then
    bool 'PS/2 port support' CONFIG_INPUT_PS2
    if [ "$CONFIG_INPUT_PS2" != "n" ]; then
-      tristate '  i8042 aux+kbd controller' CONFIG_INPUT_I8042
-      comment 'PS/2 port input devices'
-      tristate '  XT keyboard' CONFIG_INPUT_XTKBD
-      tristate '  AT and PS/2 keyboards' CONFIG_INPUT_ATKBD
-      tristate '  PS/2 mouse' CONFIG_INPUT_PSMOUSE
-   fi	
+      dep_tristate '  i8042 aux+kbd controller' CONFIG_INPUT_I8042 $CONFIG_INPUT_SERIO
+      dep_tristate '  XT keyboard' CONFIG_INPUT_XTKBD $CONFIG_INPUT_SERIO
+      dep_tristate '  AT and PS/2 keyboards' CONFIG_INPUT_ATKBD $CONFIG_INPUT_SERIO
+      dep_tristate '  PS/2 mouse' CONFIG_INPUT_PSMOUSE $CONFIG_INPUT_SERIO
+   fi
 else
    comment 'Input core support is needed for new PS/2 drivers' 

Index: drivers/char/Makefile
--- drivers/char/Makefile.old	Wed Oct 17 13:36:43 2001
+++ drivers/char/Makefile	Wed Oct 17 15:18:35 2001
@@ -143,8 +143,8 @@
 endif
 
-obj-$(CONFIG_INPUT_I8042)       += i8042.o joystick/serio.o
-obj-$(CONFIG_INPUT_ATKBD)       += atkbd.o joystick/serio.o
-obj-$(CONFIG_INPUT_XTKBD)       += xtkbd.o joystick/serio.o
-obj-$(CONFIG_INPUT_PSMOUSE)     += psmouse.o joystick/serio.o
+obj-$(CONFIG_INPUT_I8042)       += i8042.o
+obj-$(CONFIG_INPUT_ATKBD)       += atkbd.o
+obj-$(CONFIG_INPUT_XTKBD)       += xtkbd.o
+obj-$(CONFIG_INPUT_PSMOUSE)     += psmouse.o
 
 obj-$(CONFIG_MAGIC_SYSRQ) += sysrq.o

Index: drivers/char/joystick/Config.in
--- drivers/char/joystick/Config.in.old	Wed Sep 12 15:34:06 2001
+++ drivers/char/joystick/Config.in	Wed Oct 17 15:13:26 2001
@@ -13,6 +13,4 @@
       dep_tristate '  Crystal SoundFusion gameports' CONFIG_INPUT_CS461X  $CONFIG_INPUT_GAMEPORT
       dep_tristate '  SoundBlaster Live! gameports' CONFIG_INPUT_EMU10K1 $CONFIG_INPUT_GAMEPORT
-   tristate 'Serial port device support' CONFIG_INPUT_SERIO
-      dep_tristate '  Serial port input line discipline' CONFIG_INPUT_SERPORT $CONFIG_INPUT_SERIO
 else
    # Must explicitly set to n for drivers/sound/Config.in

Index: drivers/char/joystick/Makefile
--- drivers/char/joystick/Makefile.old	Wed Sep 12 15:34:06 2001
+++ drivers/char/joystick/Makefile	Wed Oct 17 15:19:31 2001
@@ -7,5 +7,5 @@
 # Objects that export symbols.
 
-export-objs	:= serio.o gameport.o
+export-objs	:= gameport.o
 
 # I-Force may need both USB and RS-232
@@ -32,7 +32,4 @@
 
 obj-$(CONFIG_INPUT_GAMEPORT)	+= gameport.o
-obj-$(CONFIG_INPUT_SERIO)	+= serio.o
-
-obj-$(CONFIG_INPUT_SERPORT)	+= serport.o
 
 obj-$(CONFIG_INPUT_NS558)	+= ns558.o

Index: drivers/input/Config.in
--- drivers/input/Config.in.old	Wed Sep 12 15:34:06 2001
+++ drivers/input/Config.in	Wed Oct 17 15:23:01 2001
@@ -14,4 +14,6 @@
 fi
 dep_tristate '  Joystick support' CONFIG_INPUT_JOYDEV $CONFIG_INPUT
+dep_tristate '  Serial support' CONFIG_INPUT_SERIO $CONFIG_INPUT
+dep_tristate '    Serial line discipline' CONFIG_INPUT_SERPORT $CONFIG_INPUT_SERIO
 dep_tristate '  Event interface support' CONFIG_INPUT_EVDEV $CONFIG_INPUT
 

Index: drivers/input/Makefile
--- drivers/input/Makefile.old	Fri Dec 29 14:07:22 2000
+++ drivers/input/Makefile	Wed Oct 17 15:27:05 2001
@@ -9,5 +9,5 @@
 # Objects that export symbols.
 
-export-objs	:= input.o
+export-objs	:= input.o serio.o
 
 # Object file lists.
@@ -25,4 +25,6 @@
 obj-$(CONFIG_INPUT_JOYDEV)	+= joydev.o
 obj-$(CONFIG_INPUT_EVDEV)	+= evdev.o
+obj-$(CONFIG_INPUT_SERIO)	+= serio.o
+obj-$(CONFIG_INPUT_SERPORT)	+= serport.o
 
 # The global Rules.make.

--gBBFr7Ir9EOA20Yy--
