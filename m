Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbRE3ErP>; Wed, 30 May 2001 00:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262607AbRE3ErF>; Wed, 30 May 2001 00:47:05 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:53015 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S262604AbRE3Eqx>; Wed, 30 May 2001 00:46:53 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Frank Davis <fdavis112@juno.com>
cc: linux-kernel@vger.kernel.org, vojtech@suse.cz,
        alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: 2.4.5-ac4 es1371.o unresolved symbols 
In-Reply-To: Your message of "Tue, 29 May 2001 21:56:51 -0400."
             <381058575.991187817702.JavaMail.root@web649-wra> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 30 May 2001 14:46:42 +1000
Message-ID: <14942.991198002@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2001 21:56:51 -0400 (EDT), 
Frank Davis <fdavis112@juno.com> wrote:
>     While 'make modules_install' on 2.4.5-ac4, I received the following error:
>depmod: *** Unresolved symbols in /lib/modules/2.4.5-ac4/kernel/drivers/sound/es1371.o
>depmod:  gameport_register_port_Rsmp_aa96bd99
>depmod:  gameport_unregister_port_Rsmp_ec101047

This is messy.  gameport.h is included by code outside the joystick
directory and it needs to expand differently based on whether
gameport.o is compiled or not.  Also gameport.o needs to be built in if
_any_ consumers are built in (either joystick or sound), it needs to be
a module otherwise.  Lots of cross config and cross directory
dependencies :(.

serio.[ho] has the same problem but I want opinions on this patch
before fixing serio.

Index: 5.7/include/linux/gameport.h
--- 5.7/include/linux/gameport.h Wed, 30 May 2001 11:45:37 +1000 kaos (linux-2.4/V/32_gameport.h 1.2 644)
+++ 5.7(w)/include/linux/gameport.h Wed, 30 May 2001 14:36:09 +1000 kaos (linux-2.4/V/32_gameport.h 1.2 644)
@@ -31,6 +31,8 @@
 
 #include <asm/io.h>
 
+#if defined(CONFIG_INPUT_GAMEPORT) || defined(CONFIG_INPUT_GAMEPORT_MODULE)
+
 struct gameport;
 
 struct gameport {
@@ -68,13 +70,8 @@ int gameport_open(struct gameport *gamep
 void gameport_close(struct gameport *gameport);
 void gameport_rescan(struct gameport *gameport);
 
-#ifdef CONFIG_JOYSTICK
 void gameport_register_port(struct gameport *gameport);
 void gameport_unregister_port(struct gameport *gameport);
-#else
-void __inline__ gameport_register_port(struct gameport *gameport) { return; }
-void __inline__ gameport_unregister_port(struct gameport *gameport) { return; }
-#endif
 
 void gameport_register_device(struct gameport_dev *dev);
 void gameport_unregister_device(struct gameport_dev *dev);
@@ -135,5 +132,17 @@ static __inline__ void wait_ms(unsigned 
 	current->state = TASK_UNINTERRUPTIBLE;
 	schedule_timeout(1 + ms * HZ / 1000);
 }
+
+#else	/* !(defined(CONFIG_INPUT_GAMEPORT) || defined(CONFIG_INPUT_GAMEPORT_MODULE)) */
+
+struct gameport {
+       int io;
+       int size;
+};
+
+extern inline void gameport_register_port(struct gameport *gameport) { }
+extern inline void gameport_unregister_port(struct gameport *gameport) { }
+
+#endif	/* defined(CONFIG_INPUT_GAMEPORT) || defined(CONFIG_INPUT_GAMEPORT_MODULE) */
 
 #endif
Index: 5.7/drivers/sound/Config.in
--- 5.7/drivers/sound/Config.in Sun, 27 May 2001 10:30:27 +1000 kaos (linux-2.4/P/b/0_Config.in 1.4.1.1.1.4 644)
+++ 5.7(w)/drivers/sound/Config.in Wed, 30 May 2001 14:06:32 +1000 kaos (linux-2.4/P/b/0_Config.in 1.4.1.1.1.4 644)
@@ -195,3 +195,18 @@ if [ "$CONFIG_SOUND_OSS" = "y" -o "$CONF
 fi
 
 dep_tristate '  TV card (bt848) mixer support' CONFIG_SOUND_TVMIXER $CONFIG_SOUND $CONFIG_I2C
+
+# If CONFIG_INPUT_GAMEPORT is set then gameport.o will be compiled.  If any of
+# the consumers of gameport.o in this directory are built in then force
+# gameport.o to be built in.  See also drivers/char/joystick/Config.in.  KAO
+
+# Extreme ugliness.  Roll on CML2.
+
+if [ "$CONFIG_INPUT_GAMEPORT" != "n" ]; then
+  if [ "$CONFIG_SOUND_ESSSOLO1" = "y" -o \
+       "$CONFIG_SOUND_ES1370" = "y" -o \
+       "$CONFIG_SOUND_ES1371" = "y" -o \
+       "$CONFIG_SOUND_SONICVIBES" = "y" ]; then
+    define_tristate CONFIG_INPUT_GAMEPORT y
+  fi
+fi
Index: 5.7/drivers/char/joystick/Makefile
--- 5.7/drivers/char/joystick/Makefile Wed, 30 May 2001 11:45:37 +1000 kaos (linux-2.4/Y/b/34_Makefile 1.1.1.2 644)
+++ 5.7(w)/drivers/char/joystick/Makefile Wed, 30 May 2001 13:53:00 +1000 kaos (linux-2.4/Y/b/34_Makefile 1.1.1.2 644)
@@ -32,11 +32,11 @@ obj-	:=
 
 obj-$(CONFIG_INPUT_SERPORT)	+= serport.o serio.o
 
-obj-$(CONFIG_INPUT_NS558)	+= ns558.o gameport.o
-obj-$(CONFIG_INPUT_LIGHTNING)	+= lightning.o gameport.o
-obj-$(CONFIG_INPUT_PCIGAME)	+= pcigame.o gameport.o
-obj-$(CONFIG_INPUT_CS461X)	+= cs461x.o gameport.o
-obj-$(CONFIG_INPUT_EMU10K1)	+= emu10k1-gp.o gameport.o
+obj-$(CONFIG_INPUT_NS558)	+= ns558.o
+obj-$(CONFIG_INPUT_LIGHTNING)	+= lightning.o
+obj-$(CONFIG_INPUT_PCIGAME)	+= pcigame.o
+obj-$(CONFIG_INPUT_CS461X)	+= cs461x.o
+obj-$(CONFIG_INPUT_EMU10K1)	+= emu10k1-gp.o
 
 obj-$(CONFIG_INPUT_WARRIOR)	+= warrior.o serio.o
 obj-$(CONFIG_INPUT_MAGELLAN)	+= magellan.o serio.o
@@ -46,21 +46,23 @@ obj-$(CONFIG_INPUT_STINGER)	+= stinger.o
 obj-$(CONFIG_INPUT_IFORCE_232)	+= iforce.o serio.o
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
 obj-$(CONFIG_INPUT_TURBOGRAFX)	+= turbografx.o
 
 obj-$(CONFIG_INPUT_AMIJOY)	+= amijoy.o
+
+obj-$(CONFIG_INPUT_GAMEPORT)	+= gameport.o
 
 # The global Rules.make.
 
Index: 5.7/drivers/char/joystick/Config.in
--- 5.7/drivers/char/joystick/Config.in Wed, 30 May 2001 11:45:37 +1000 kaos (linux-2.4/Y/b/35_Config.in 1.1.1.2 644)
+++ 5.7(w)/drivers/char/joystick/Config.in Wed, 30 May 2001 14:26:17 +1000 kaos (linux-2.4/Y/b/35_Config.in 1.1.1.2 644)
@@ -5,6 +5,8 @@
 mainmenu_option next_comment
 comment 'Joysticks'
 
+define_tristate CONFIG_INPUT_GAMEPORT n
+
 dep_mbool 'Joystick support' CONFIG_JOYSTICK $CONFIG_INPUT
 if [ "$CONFIG_JOYSTICK" != "n" ]; then
    comment 'Game port support'
@@ -51,6 +53,49 @@ if [ "$CONFIG_JOYSTICK" != "n" ]; then
    comment 'System joysticks'
       dep_tristate '  Amiga joysticks' CONFIG_INPUT_AMIJOY $CONFIG_INPUT
    fi
+
+   # gameport.h is included in code outside the joystick directory, we need to know
+   # if gameport.o is being compiled in order to select a full or partial expansion
+   # of gameport.h.  We also need to know if gameport.o is to be built in or
+   # compiled as a module, it depends on the combination of input devices.
+   # See also drivers/sound/Config.in.  KAO
+
+   # Extreme ugliness.  Roll on CML2.
+
+   if [ "$CONFIG_INPUT_NS558" = "y" -o \
+	"$CONFIG_INPUT_LIGHTNING" = "y" -o \
+	"$CONFIG_INPUT_PCIGAME" = "y" -o \
+	"$CONFIG_INPUT_CS461X" = "y" -o \
+	"$CONFIG_INPUT_EMU10K1" = "y" -o \
+	"$CONFIG_INPUT_ANALOG" = "y" -o \
+	"$CONFIG_INPUT_A3D" = "y" -o \
+	"$CONFIG_INPUT_ADI" = "y" -o \
+	"$CONFIG_INPUT_COBRA" = "y" -o \
+	"$CONFIG_INPUT_GF2K" = "y" -o \
+	"$CONFIG_INPUT_GRIP" = "y" -o \
+	"$CONFIG_INPUT_INTERACT" = "y" -o \
+	"$CONFIG_INPUT_TMDC" = "y" -o \
+	"$CONFIG_INPUT_SIDEWINDER" = "y" ]; then
+      define_tristate CONFIG_INPUT_GAMEPORT y
+   else
+      if [ "$CONFIG_INPUT_NS558" = "m" -o \
+	   "$CONFIG_INPUT_LIGHTNING" = "m" -o \
+	   "$CONFIG_INPUT_PCIGAME" = "m" -o \
+	   "$CONFIG_INPUT_CS461X" = "m" -o \
+	   "$CONFIG_INPUT_EMU10K1" = "m" -o \
+	   "$CONFIG_INPUT_ANALOG" = "m" -o \
+	   "$CONFIG_INPUT_A3D" = "m" -o \
+	   "$CONFIG_INPUT_ADI" = "m" -o \
+	   "$CONFIG_INPUT_COBRA" = "m" -o \
+	   "$CONFIG_INPUT_GF2K" = "m" -o \
+	   "$CONFIG_INPUT_GRIP" = "m" -o \
+	   "$CONFIG_INPUT_INTERACT" = "m" -o \
+	   "$CONFIG_INPUT_TMDC" = "m" -o \
+	   "$CONFIG_INPUT_SIDEWINDER" = "m" ]; then
+	 define_tristate CONFIG_INPUT_GAMEPORT m
+      fi
+   fi
+
 else
    comment 'Input core support is needed for joysticks'
 fi

