Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261852AbSJFRIk>; Sun, 6 Oct 2002 13:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261807AbSJFRIk>; Sun, 6 Oct 2002 13:08:40 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46340 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261852AbSJFRIi>; Sun, 6 Oct 2002 13:08:38 -0400
Subject: PATCH: 2.5.40  forward port toughbook fixes for maestro3
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Sun, 6 Oct 2002 18:05:34 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yEqU-0001rA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Jaroslav you may want to clone this into ALSA if ALSA lacks this one)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.40/sound/oss/maestro3.c linux.2.5.40-ac5/sound/oss/maestro3.c
--- linux.2.5.40/sound/oss/maestro3.c	2002-10-02 21:33:42.000000000 +0100
+++ linux.2.5.40-ac5/sound/oss/maestro3.c	2002-10-03 00:15:43.000000000 +0100
@@ -28,6 +28,9 @@
  * Shouts go out to Mike "DJ XPCom" Ang.
  *
  * History
+ *  v1.23 - Jun 5 2002 - Michael Olson <olson@cs.odu.edu>
+ *   added a module option to allow selection of GPIO pin number 
+ *   for external amp 
  *  v1.22 - Feb 28 2001 - Zach Brown <zab@zabbo.net>
  *   allocate mem at insmod/setup, rather than open
  *   limit pci dma addresses to 28bit, thanks guys.
@@ -153,7 +156,7 @@
 
 #define M_DEBUG 1
 
-#define DRIVER_VERSION      "1.22"
+#define DRIVER_VERSION      "1.23"
 #define M3_MODULE_NAME      "maestro3"
 #define PFX                 M3_MODULE_NAME ": "
 
@@ -190,6 +193,7 @@
 };
 
 int external_amp = 1;
+int gpio_pin = -1;
 
 struct m3_state {
     unsigned int magic;
@@ -2472,14 +2476,20 @@
     if(!external_amp)
         return;
 
-    switch (card->card_type) {
-        case ESS_ALLEGRO:
-            polarity_port = 0x1800;
-            break;
-        default:
-            /* presumably this is for all 'maestro3's.. */
-            polarity_port = 0x1100;
-            break;
+    if (gpio_pin >= 0  && gpio_pin <= 15) {
+        polarity_port = 0x1000 + (0x100 * gpio_pin);
+    } else {
+        switch (card->card_type) {
+            case ESS_ALLEGRO:
+                polarity_port = 0x1800;
+                break;
+            default:
+                polarity_port = 0x1100;
+                /* Panasonic toughbook CF72 has to be different... */
+                if(card->pcidev->subsystem_vendor == 0x10F7 && card->pcidev->subsystem_device == 0x833D)
+                	polarity_port = 0x1D00;
+                break;
+        }
     }
 
     gpo = (polarity_port >> 8) & 0x0F;
@@ -2912,6 +2922,7 @@
 MODULE_PARM(debug,"i");
 #endif
 MODULE_PARM(external_amp,"i");
+MODULE_PARM(gpio_pin, "i");
 
 static struct pci_driver m3_pci_driver = {
     name:       "ess_m3_audio",
