Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261473AbRE3QQl>; Wed, 30 May 2001 12:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261482AbRE3QQb>; Wed, 30 May 2001 12:16:31 -0400
Received: from olsinka.site.cas.cz ([147.231.11.16]:20865 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S261473AbRE3QQV>;
	Wed, 30 May 2001 12:16:21 -0400
Date: Wed, 30 May 2001 18:15:31 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Keith Owens <kaos@ocs.com.au>
Cc: Frank Davis <fdavis112@juno.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.5-ac4 es1371.o unresolved symbols
Message-ID: <20010530181531.A12836@suse.cz>
In-Reply-To: <381058575.991187817702.JavaMail.root@web649-wra> <14942.991198002@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14942.991198002@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Wed, May 30, 2001 at 02:46:42PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 30, 2001 at 02:46:42PM +1000, Keith Owens wrote:
> On Tue, 29 May 2001 21:56:51 -0400 (EDT), 
> Frank Davis <fdavis112@juno.com> wrote:
> >     While 'make modules_install' on 2.4.5-ac4, I received the following error:
> >depmod: *** Unresolved symbols in /lib/modules/2.4.5-ac4/kernel/drivers/sound/es1371.o
> >depmod:  gameport_register_port_Rsmp_aa96bd99
> >depmod:  gameport_unregister_port_Rsmp_ec101047
> 
> This is messy.  gameport.h is included by code outside the joystick
> directory and it needs to expand differently based on whether
> gameport.o is compiled or not.  Also gameport.o needs to be built in if
> _any_ consumers are built in (either joystick or sound), it needs to be
> a module otherwise.  Lots of cross config and cross directory
> dependencies :(.
> 
> serio.[ho] has the same problem but I want opinions on this patch
> before fixing serio.

What about this solution? It's a little cleaner.

-- 
Vojtech Pavlik
SuSE Labs

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="gameport.config.diff"

diff -urN linux-2.4.5-ac4/drivers/char/joystick/Config.in linux/drivers/char/joystick/Config.in
--- linux-2.4.5-ac4/drivers/char/joystick/Config.in	Tue May 29 19:48:14 2001
+++ linux/drivers/char/joystick/Config.in	Wed May 30 17:50:45 2001
@@ -5,54 +5,79 @@
 mainmenu_option next_comment
 comment 'Joysticks'
 
-dep_mbool 'Joystick support' CONFIG_JOYSTICK $CONFIG_INPUT
-if [ "$CONFIG_JOYSTICK" != "n" ]; then
-   comment 'Game port support'
-      dep_tristate '  Classic ISA/PnP gameports' CONFIG_INPUT_NS558 $CONFIG_INPUT
-      dep_tristate '  PDPI Lightning 4 gamecard' CONFIG_INPUT_LIGHTNING $CONFIG_INPUT
-      dep_tristate '  Aureal Vortex and Trident 4DWave gameports' CONFIG_INPUT_PCIGAME $CONFIG_INPUT
-      dep_tristate '  Crystal SoundFusion gameports' CONFIG_INPUT_CS461X $CONFIG_INPUT
-      dep_tristate '  SoundBlaster Live! gameports' CONFIG_INPUT_EMU10K1 $CONFIG_INPUT
-      comment '  ESS Solo1, ES1370, ES1371 and SonicVibes gameports are handled by the sound drivers'
-
-   comment 'Gameport joysticks'
-      dep_tristate '  Classic PC analog joysticks and gamepads' CONFIG_INPUT_ANALOG $CONFIG_INPUT
-      dep_tristate '  Assasin 3D and MadCatz Panther devices' CONFIG_INPUT_A3D $CONFIG_INPUT
-      dep_tristate '  Logitech ADI digital joysticks and gamepads' CONFIG_INPUT_ADI $CONFIG_INPUT
-      dep_tristate '  Creative Labs Blaster Cobra gamepad' CONFIG_INPUT_COBRA $CONFIG_INPUT
-      dep_tristate '  Genius Flight2000 Digital joysticks and gamepads' CONFIG_INPUT_GF2K $CONFIG_INPUT
-      dep_tristate '  Gravis GrIP joysticks and gamepads' CONFIG_INPUT_GRIP $CONFIG_INPUT
-      dep_tristate '  InterAct digital joysticks and gamepads' CONFIG_INPUT_INTERACT $CONFIG_INPUT
-      dep_tristate '  ThrustMaster DirectConnect joysticks and gamepads' CONFIG_INPUT_TMDC $CONFIG_INPUT
-      dep_tristate '  Microsoft SideWinder digital joysticks and gamepads' CONFIG_INPUT_SIDEWINDER $CONFIG_INPUT
-
-   comment 'Serial port support'
-      dep_tristate '  Serial port input line discipline' CONFIG_INPUT_SERPORT $CONFIG_INPUT
-
-   comment 'Serial port joysticks'
-      dep_tristate '  Logitech WingMan Warrior joystick' CONFIG_INPUT_WARRIOR $CONFIG_INPUT
-      dep_tristate '  LogiCad3d Magellan/SpaceMouse 6dof controller' CONFIG_INPUT_MAGELLAN $CONFIG_INPUT
-      dep_tristate '  SpaceTec SpaceOrb/Avenger 6dof controller' CONFIG_INPUT_SPACEORB $CONFIG_INPUT
-      dep_tristate '  SpaceTec SpaceBall 4000 FLX 6dof controller' CONFIG_INPUT_SPACEBALL $CONFIG_INPUT
-      dep_tristate '  Gravis Stinger gamepad' CONFIG_INPUT_STINGER $CONFIG_INPUT
-      dep_tristate '  I-Force/Serial controllers' CONFIG_INPUT_IFORCE_232 $CONFIG_INPUT
-      dep_tristate '  I-Force/USB controllers' CONFIG_INPUT_IFORCE_USB $CONFIG_INPUT $CONFIG_USB
-
-   comment 'Parallel port joysticks'
-   if [ "$CONFIG_PARPORT" != "n" ]; then
-      dep_tristate '  Multisystem, Sega Genesis, Saturn joysticks and gamepads' CONFIG_INPUT_DB9 $CONFIG_INPUT $CONFIG_PARPORT
-      dep_tristate '  Multisystem, NES, SNES, N64, PSX joysticks and gamepads' CONFIG_INPUT_GAMECON $CONFIG_INPUT $CONFIG_PARPORT
-      dep_tristate '  Multisystem joysticks via TurboGraFX device' CONFIG_INPUT_TURBOGRAFX $CONFIG_INPUT $CONFIG_PARPORT
+tristate 'Game port support' CONFIG_INPUT_GAMEPORT
+   dep_tristate '  Classic ISA/PnP gameports' CONFIG_INPUT_NS558 $CONFIG_INPUT_GAMEPORT
+   dep_tristate '  PDPI Lightning 4 gamecard' CONFIG_INPUT_LIGHTNING $CONFIG_INPUT_GAMEPORT
+   dep_tristate '  Aureal Vortex and Trident 4DWave gameports' CONFIG_INPUT_PCIGAME $CONFIG_INPUT_GAMEPORT
+   dep_tristate '  Crystal SoundFusion gameports' CONFIG_INPUT_CS461X  $CONFIG_INPUT_GAMEPORT
+   dep_tristate '  SoundBlaster Live! gameports' CONFIG_INPUT_EMU10K1 $CONFIG_INPUT_GAMEPORT
+if [ "$CONFIG_INPUT_GAMEPORT" != "n" ]; then
+   comment '  ES1370, ES1371 (SoundBlaster 64, 128), SonicVibes and'
+   comment '  ESS Solo1 gameports are handled by the sound drivers'
+fi
+
+tristate 'Serial port device support' CONFIG_INPUT_SERIO
+   dep_tristate '  Serial port input line discipline' CONFIG_INPUT_SERPORT $CONFIG_INPUT_SERIO
+
+if [ "$CONFIG_INPUT" == "n" ]; then
+   comment 'Input core support is needed for joysticks'
+else
+   comment 'Joysticks'
+
+   comment '  Gameport joysticks'
+
+   if [ "$CONFIG_INPUT_GAMEPORT" == "n" ]; then
+      comment '    Gameport support is needed for gameport joysticks'
+   fi
+
+   dep_tristate '    Classic PC analog joysticks and gamepads' CONFIG_INPUT_ANALOG $CONFIG_INPUT $CONFIG_INPUT_GAMEPORT
+   dep_tristate '    Assasin 3D and MadCatz Panther devices' CONFIG_INPUT_A3D $CONFIG_INPUT $CONFIG_INPUT_GAMEPORT
+   dep_tristate '    Logitech ADI digital joysticks and gamepads' CONFIG_INPUT_ADI $CONFIG_INPUT $CONFIG_INPUT_GAMEPORT
+   dep_tristate '    Creative Labs Blaster Cobra gamepad' CONFIG_INPUT_COBRA $CONFIG_INPUT $CONFIG_INPUT_GAMEPORT
+   dep_tristate '    Genius Flight2000 Digital joysticks and gamepads' CONFIG_INPUT_GF2K $CONFIG_INPUT $CONFIG_INPUT_GAMEPORT
+   dep_tristate '    Gravis GrIP joysticks and gamepads' CONFIG_INPUT_GRIP $CONFIG_INPUT $CONFIG_INPUT_GAMEPORT
+   dep_tristate '    InterAct digital joysticks and gamepads' CONFIG_INPUT_INTERACT $CONFIG_INPUT $CONFIG_INPUT_GAMEPORT
+   dep_tristate '    ThrustMaster DirectConnect joysticks and gamepads' CONFIG_INPUT_TMDC $CONFIG_INPUT $CONFIG_INPUT_GAMEPORT
+   dep_tristate '    Microsoft SideWinder digital joysticks and gamepads' CONFIG_INPUT_SIDEWINDER $CONFIG_INPUT $CONFIG_INPUT_GAMEPORT
+
+   comment '  Serial port joysticks'
+
+   if [ "$CONFIG_INPUT_SERIO" == "n" ]; then
+      comment '    Serial port device support is needed for serial joysticks'
+   fi
+
+   dep_tristate '    I-Force Serial joysticks and wheels' CONFIG_INPUT_IFORCE_232 $CONFIG_INPUT $CONFIG_INPUT_SERIO
+   dep_tristate '    Logitech WingMan Warrior joystick' CONFIG_INPUT_WARRIOR $CONFIG_INPUT $CONFIG_INPUT_SERIO
+   dep_tristate '    LogiCad3d Magellan/SpaceMouse 6dof controller' CONFIG_INPUT_MAGELLAN $CONFIG_INPUT $CONFIG_INPUT_SERIO
+   dep_tristate '    SpaceTec SpaceOrb/Avenger 6dof controller' CONFIG_INPUT_SPACEORB $CONFIG_INPUT $CONFIG_INPUT_SERIO
+   dep_tristate '    SpaceTec SpaceBall 4000 FLX 6dof controller' CONFIG_INPUT_SPACEBALL $CONFIG_INPUT $CONFIG_INPUT_SERIO
+   dep_tristate '    Gravis Stinger gamepad' CONFIG_INPUT_STINGER $CONFIG_INPUT $CONFIG_INPUT_SERIO
+
+   comment '  USB joysticks'
+
+   if [ "$CONFIG_INPUT_SERIO" == "n" ]; then
+      comment '    USB support is needed for USB joysticks'
    else
-      comment '  Parport support is needed for parallel port joysticks'
+      comment '    Normal USB joystick are handled by USB HID driver'
    fi
 
+   dep_tristate '    I-Force USB joysticks and wheels' CONFIG_INPUT_IFORCE_USB $CONFIG_INPUT $CONFIG_USB
+
+   comment '  Parallel port joysticks'
+
+   if [ "$CONFIG_PARPORT" == "n" ]; then
+      comment '    Parport support is needed for parallel port joysticks'
+   fi
+
+   dep_tristate '    Multisystem, Sega Genesis, Saturn joysticks and gamepads' CONFIG_INPUT_DB9 $CONFIG_INPUT $CONFIG_PARPORT
+   dep_tristate '    Multisystem, NES, SNES, N64, PSX joysticks and gamepads' CONFIG_INPUT_GAMECON $CONFIG_INPUT $CONFIG_PARPORT
+   dep_tristate '    Multisystem joysticks via TurboGraFX device' CONFIG_INPUT_TURBOGRAFX $CONFIG_INPUT $CONFIG_PARPORT
+
    if [ "$CONFIG_AMIGA" = "y" ]; then
-   comment 'System joysticks'
-      dep_tristate '  Amiga joysticks' CONFIG_INPUT_AMIJOY $CONFIG_INPUT
+      comment '  System joysticks'
+      dep_tristate '    Amiga joysticks' CONFIG_INPUT_AMIJOY $CONFIG_INPUT
    fi
-else
-   comment 'Input core support is needed for joysticks'
+
 fi
 
 endmenu
diff -urN linux-2.4.5-ac4/drivers/char/joystick/Makefile linux/drivers/char/joystick/Makefile
--- linux-2.4.5-ac4/drivers/char/joystick/Makefile	Tue May 29 19:48:14 2001
+++ linux/drivers/char/joystick/Makefile	Wed May 30 17:17:08 2001
@@ -30,31 +30,34 @@
 
 # Each configuration option enables a list of files.
 
-obj-$(CONFIG_INPUT_SERPORT)	+= serport.o serio.o
+obj-$(CONFIG_INPUT_GAMEPORT)	+= gameport.o
+obj-$(CONFIG_INPUT_SERIO)	+= serio.o
 
-obj-$(CONFIG_INPUT_NS558)	+= ns558.o gameport.o
-obj-$(CONFIG_INPUT_LIGHTNING)	+= lightning.o gameport.o
-obj-$(CONFIG_INPUT_PCIGAME)	+= pcigame.o gameport.o
-obj-$(CONFIG_INPUT_CS461X)	+= cs461x.o gameport.o
-obj-$(CONFIG_INPUT_EMU10K1)	+= emu10k1-gp.o gameport.o
+obj-$(CONFIG_INPUT_SERPORT)	+= serport.o
 
-obj-$(CONFIG_INPUT_WARRIOR)	+= warrior.o serio.o
-obj-$(CONFIG_INPUT_MAGELLAN)	+= magellan.o serio.o
-obj-$(CONFIG_INPUT_SPACEORB)	+= spaceorb.o serio.o
-obj-$(CONFIG_INPUT_SPACEBALL)	+= spaceball.o serio.o
-obj-$(CONFIG_INPUT_STINGER)	+= stinger.o serio.o
-obj-$(CONFIG_INPUT_IFORCE_232)	+= iforce.o serio.o
+obj-$(CONFIG_INPUT_NS558)	+= ns558.o
+obj-$(CONFIG_INPUT_LIGHTNING)	+= lightning.o
+obj-$(CONFIG_INPUT_PCIGAME)	+= pcigame.o
+obj-$(CONFIG_INPUT_CS461X)	+= cs461x.o
+obj-$(CONFIG_INPUT_EMU10K1)	+= emu10k1-gp.o
+
+obj-$(CONFIG_INPUT_WARRIOR)	+= warrior.o
+obj-$(CONFIG_INPUT_MAGELLAN)	+= magellan.o
+obj-$(CONFIG_INPUT_SPACEORB)	+= spaceorb.o
+obj-$(CONFIG_INPUT_SPACEBALL)	+= spaceball.o
+obj-$(CONFIG_INPUT_STINGER)	+= stinger.o
+obj-$(CONFIG_INPUT_IFORCE_232)	+= iforce.o
 obj-$(CONFIG_INPUT_IFORCE_USB)	+= iforce.o
 
-obj-$(CONFIG_INPUT_ANALOG)	+= analog.o gameport.o
-obj-$(CONFIG_INPUT_A3D)		+= a3d.o gameport.o
-obj-$(CONFIG_INPUT_ADI)		+= adi.o gameport.o
-obj-$(CONFIG_INPUT_COBRA)	+= cobra.o gameport.o
-obj-$(CONFIG_INPUT_GF2K)	+= gf2k.o gameport.o
-obj-$(CONFIG_INPUT_GRIP)	+= grip.o gameport.o
-obj-$(CONFIG_INPUT_INTERACT)	+= interact.o gameport.o
-obj-$(CONFIG_INPUT_TMDC)	+= tmdc.o gameport.o
-obj-$(CONFIG_INPUT_SIDEWINDER)	+= sidewinder.o gameport.o
+obj-$(CONFIG_INPUT_ANALOG)	+= analog.o
+obj-$(CONFIG_INPUT_A3D)		+= a3d.o
+obj-$(CONFIG_INPUT_ADI)		+= adi.o
+obj-$(CONFIG_INPUT_COBRA)	+= cobra.o
+obj-$(CONFIG_INPUT_GF2K)	+= gf2k.o
+obj-$(CONFIG_INPUT_GRIP)	+= grip.o
+obj-$(CONFIG_INPUT_INTERACT)	+= interact.o
+obj-$(CONFIG_INPUT_TMDC)	+= tmdc.o
+obj-$(CONFIG_INPUT_SIDEWINDER)	+= sidewinder.o
 
 obj-$(CONFIG_INPUT_DB9)		+= db9.o
 obj-$(CONFIG_INPUT_GAMECON)	+= gamecon.o
diff -urN linux-2.4.5-ac4/include/linux/gameport.h linux/include/linux/gameport.h
--- linux-2.4.5-ac4/include/linux/gameport.h	Tue May 29 19:49:21 2001
+++ linux/include/linux/gameport.h	Wed May 30 18:03:14 2001
@@ -68,7 +68,7 @@
 void gameport_close(struct gameport *gameport);
 void gameport_rescan(struct gameport *gameport);
 
-#ifdef CONFIG_JOYSTICK
+#if defined(CONFIG_INPUT_GAMEPORT) || (defined(CONFIG_INPUT_GAMEPORT_MODULE) && defined(MODULE))
 void gameport_register_port(struct gameport *gameport);
 void gameport_unregister_port(struct gameport *gameport);
 #else

--lrZ03NoBR/3+SXJZ--
