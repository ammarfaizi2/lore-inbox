Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264238AbRFSOad>; Tue, 19 Jun 2001 10:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264240AbRFSOaW>; Tue, 19 Jun 2001 10:30:22 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:40714 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S264238AbRFSOaM>;
	Tue, 19 Jun 2001 10:30:12 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac15 -- Unresolved symbols "gameport_register_port"
In-Reply-To: Your message of "Tue, 19 Jun 2001 14:48:09 +0200."
             <Pine.LNX.4.31.0106191444410.6488-200000@neon.hh59.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 20 Jun 2001 00:30:05 +1000
Message-ID: <20509.992961005@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2001 14:48:09 +0200 (CEST), 
<axel@rayfun.org> wrote:
>something similar is happening with my kernel 2.4.5-ac15 compilation.
>drivers/sound/sounddrivers.o: In function `es1371_probe':
>drivers/sound/sounddrivers.o(.text.init+0xddb): undefined reference to
>`gameport_register_port'

Gameports and joysticks should not be available unless input core
support is selected first.  Invalid configs were slipping through.

Index: 5.37/drivers/char/joystick/Config.in
--- 5.37/drivers/char/joystick/Config.in Wed, 06 Jun 2001 11:47:52 +1000 kaos (linux-2.4/Y/b/35_Config.in 1.1.1.3 644)
+++ 5.37(w)/drivers/char/joystick/Config.in Wed, 20 Jun 2001 00:06:14 +1000 kaos (linux-2.4/Y/b/35_Config.in 1.1.1.3 644)
@@ -5,15 +5,20 @@
 mainmenu_option next_comment
 comment 'Joysticks'
 
-tristate 'Game port support' CONFIG_INPUT_GAMEPORT
-   dep_tristate '  Classic ISA/PnP gameports' CONFIG_INPUT_NS558 $CONFIG_INPUT_GAMEPORT
-   dep_tristate '  PDPI Lightning 4 gamecard' CONFIG_INPUT_LIGHTNING $CONFIG_INPUT_GAMEPORT
-   dep_tristate '  Aureal Vortex and Trident 4DWave gameports' CONFIG_INPUT_PCIGAME $CONFIG_INPUT_GAMEPORT
-   dep_tristate '  Crystal SoundFusion gameports' CONFIG_INPUT_CS461X  $CONFIG_INPUT_GAMEPORT
-   dep_tristate '  SoundBlaster Live! gameports' CONFIG_INPUT_EMU10K1 $CONFIG_INPUT_GAMEPORT
-
-tristate 'Serial port device support' CONFIG_INPUT_SERIO
-   dep_tristate '  Serial port input line discipline' CONFIG_INPUT_SERPORT $CONFIG_INPUT_SERIO
+if [ "$CONFIG_INPUT" != "n" ]; then
+   tristate 'Game port support' CONFIG_INPUT_GAMEPORT
+      dep_tristate '  Classic ISA/PnP gameports' CONFIG_INPUT_NS558 $CONFIG_INPUT_GAMEPORT
+      dep_tristate '  PDPI Lightning 4 gamecard' CONFIG_INPUT_LIGHTNING $CONFIG_INPUT_GAMEPORT
+      dep_tristate '  Aureal Vortex and Trident 4DWave gameports' CONFIG_INPUT_PCIGAME $CONFIG_INPUT_GAMEPORT
+      dep_tristate '  Crystal SoundFusion gameports' CONFIG_INPUT_CS461X  $CONFIG_INPUT_GAMEPORT
+      dep_tristate '  SoundBlaster Live! gameports' CONFIG_INPUT_EMU10K1 $CONFIG_INPUT_GAMEPORT
+   tristate 'Serial port device support' CONFIG_INPUT_SERIO
+      dep_tristate '  Serial port input line discipline' CONFIG_INPUT_SERPORT $CONFIG_INPUT_SERIO
+else
+   # Must explicitly set to n for drivers/sound/Config.in
+   define_tristate CONFIG_INPUT_GAMEPORT n
+   comment 'Input core support is needed for gameports'
+fi
 
 if [ "$CONFIG_INPUT" != "n" ]; then
    comment 'Joysticks'

