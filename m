Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315540AbSFYQGt>; Tue, 25 Jun 2002 12:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315547AbSFYQGs>; Tue, 25 Jun 2002 12:06:48 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:63132
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S315540AbSFYQGr>; Tue, 25 Jun 2002 12:06:47 -0400
Date: Tue, 25 Jun 2002 09:06:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH/RFC 2.4.19-rc1] Fix dependancies on keybdev.o
Message-ID: <20020625160644.GP3489@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Right now drivers/input/keybdev.o depends on drivers/char/keyboard.o for
handle_scancode, keyboard_tasklet and kbd_ledfunc.  However, compiling
drivers/char/keyboard.o isn't quite straight forward, as we have:
ifndef CONFIG_SUN_KEYBOARD
  obj-$(CONFIG_VT) += keyboard.o $(KEYMAP) $(KEYBD)
else
  obj-$(CONFIG_PCI) += keyboard.o $(KEYMAP)
endif
in drivers/char/Makefile

To attempt to work around this, I've come up with the following patch
for drivers/input/Config.in.  Comments?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

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
