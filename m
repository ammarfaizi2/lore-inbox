Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318949AbSIIXU3>; Mon, 9 Sep 2002 19:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318955AbSIIXU3>; Mon, 9 Sep 2002 19:20:29 -0400
Received: from mailout.nordcom.net ([213.168.202.90]:51948 "HELO
	mailout.nordcom.net") by vger.kernel.org with SMTP
	id <S318949AbSIIXU2>; Mon, 9 Sep 2002 19:20:28 -0400
Date: Tue, 10 Sep 2002 01:24:56 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@redhat.com>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH] 2.4.20-pre5-ac4: Add support for ALi 5451 gameport
Message-ID: <Pine.LNX.4.44.0209100118170.1462-100000@neptune.sol.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all!

This patch adds support for the gameport found on ALi 5451 chips to
drivers/sound/trident.c and drivers/char/joystick/pcigame.c. The ALi
5451 gameport works just like a Trident 4DWave gameport, so the patch
just adds the ALi device id in the relevant places.

Patch against 2.4.20-pre5-ac4 since that has the necessary code to
use trident and pcigame at the same time.

Tested and found working on a Soyo K7ADA motherboard (ALi Magik1 chipset).

Please cc me on any comments.


diff -urN linux-2.4.20-pre5-ac4/Documentation/Configure.help linux-mod/Documentation/Configure.help
--- linux-2.4.20-pre5-ac4/Documentation/Configure.help	Tue Sep 10 00:06:15 2002
+++ linux-mod/Documentation/Configure.help	Tue Sep 10 01:06:15 2002
@@ -19197,10 +19197,11 @@
   The module will be called cs461x.o.  If you want to compile it as a
   module, say M here and read <file:Documentation/modules.txt>.
 
-Aureal Vortex and Trident 4DWave gameports
+Aureal Vortex, Trident 4DWave, and ALi 5451 gameports
 CONFIG_INPUT_PCIGAME
   Say Y here if you have a Trident 4DWave DX/NX or Aureal Vortex 1/2
-  card. For more information on how to use the driver please read
+  card or an ALi 5451 chip on your motherboard. For more information
+  on how to use the driver please read
   <file:Documentation/input/joystick.txt>.
 
   This driver is also available as a module ( = code which can be
diff -urN linux-2.4.20-pre5-ac4/drivers/char/joystick/Config.in linux-mod/drivers/char/joystick/Config.in
--- linux-2.4.20-pre5-ac4/drivers/char/joystick/Config.in	Mon Sep 24 22:43:30 2001
+++ linux-mod/drivers/char/joystick/Config.in	Tue Sep 10 01:04:42 2002
@@ -9,7 +9,7 @@
    dep_tristate 'Game port support' CONFIG_INPUT_GAMEPORT $CONFIG_INPUT
       dep_tristate '  Classic ISA/PnP gameports' CONFIG_INPUT_NS558 $CONFIG_INPUT_GAMEPORT
       dep_tristate '  PDPI Lightning 4 gamecard' CONFIG_INPUT_LIGHTNING $CONFIG_INPUT_GAMEPORT
-      dep_tristate '  Aureal Vortex and Trident 4DWave gameports' CONFIG_INPUT_PCIGAME $CONFIG_INPUT_GAMEPORT
+      dep_tristate '  Aureal Vortex, Trident 4DWave, and ALi 5451 gameports' CONFIG_INPUT_PCIGAME $CONFIG_INPUT_GAMEPORT
       dep_tristate '  Crystal SoundFusion gameports' CONFIG_INPUT_CS461X  $CONFIG_INPUT_GAMEPORT
       dep_tristate '  SoundBlaster Live! gameports' CONFIG_INPUT_EMU10K1 $CONFIG_INPUT_GAMEPORT
    tristate 'Serial port device support' CONFIG_INPUT_SERIO
diff -urN linux-2.4.20-pre5-ac4/drivers/char/joystick/pcigame.c linux-mod/drivers/char/joystick/pcigame.c
--- linux-2.4.20-pre5-ac4/drivers/char/joystick/pcigame.c	Tue Sep 10 00:06:15 2002
+++ linux-mod/drivers/char/joystick/pcigame.c	Tue Sep 10 00:10:42 2002
@@ -180,6 +180,7 @@
 #if !defined(CONFIG_SOUND_TRIDENT) && !defined(CONFIG_SOUND_TRIDENT_MODULE)
  { PCI_VENDOR_ID_TRIDENT, 0x2000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PCIGAME_4DWAVE  },
  { PCI_VENDOR_ID_TRIDENT, 0x2001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PCIGAME_4DWAVE  },
+ { PCI_VENDOR_ID_AL,      0x5451, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PCIGAME_4DWAVE  },
 #endif 
  { PCI_VENDOR_ID_AUREAL,  0x0001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PCIGAME_VORTEX  },
  { PCI_VENDOR_ID_AUREAL,  0x0002, PCI_ANY_ID, PCI_ANY_ID, 0, 0, PCIGAME_VORTEX2 },
diff -urN linux-2.4.20-pre5-ac4/drivers/sound/trident.c linux-mod/drivers/sound/trident.c
--- linux-2.4.20-pre5-ac4/drivers/sound/trident.c	Tue Sep 10 00:06:27 2002
+++ linux-mod/drivers/sound/trident.c	Tue Sep 10 00:19:51 2002
@@ -36,8 +36,11 @@
  *	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
  *  History
+ *  v0.14.10h
+ *	Sept 10 2002 Pascal Schmidt <der.eremit@email.de>
+ *	added support for ALi 5451 joystick port
  *  v0.14.10g
- *	Sept 05 2002 Alan Cox <alan@redhat.com
+ *	Sept 05 2002 Alan Cox <alan@redhat.com>
  *	adapt to new pci joystick attachment interface
  *  v0.14.10f
  *      July 24 2002 Muli Ben-Yehuda <mulix@actcom.co.il>
@@ -213,7 +216,7 @@
 
 #include "trident.h"
 
-#define DRIVER_VERSION "0.14.10f"
+#define DRIVER_VERSION "0.14.10h"
 
 /* magic numbers to protect our data structures */
 #define TRIDENT_CARD_MAGIC	0x5072696E /* "Prin" */
@@ -4245,7 +4248,8 @@
 	trident_enable_loop_interrupts(card);
 	
 	/* Attach joystick */
-	if(pci_dev->vendor == PCI_VENDOR_ID_TRIDENT)
+	if((pci_dev->vendor == PCI_VENDOR_ID_TRIDENT) ||
+	   (pci_dev->vendor == PCI_VENDOR_ID_AL))
 		card->joystick = pcigame_attach(pci_dev, PCIGAME_4DWAVE);
 out:	return rc;
 out_unregister_sound_dsp:


