Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbVHWVmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbVHWVmK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbVHWVmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:42:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50869 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932408AbVHWVmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:42:02 -0400
To: torvalds@osdl.org
Subject: [PATCH] (4/43) Kconfig fix (ISA_DMA_API and sound/*)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1E7gZu-00078b-29@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:45:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fixed kconfig dependencies on ISA_DMA_API for parts of sound/* that rely
on it.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-epca/include/sound/core.h RC13-rc6-git13-sound-isa-dma/include/sound/core.h
--- RC13-rc6-git13-epca/include/sound/core.h	2005-08-10 10:37:54.000000000 -0400
+++ RC13-rc6-git13-sound-isa-dma/include/sound/core.h	2005-08-21 13:16:47.000000000 -0400
@@ -360,11 +360,13 @@
 
 /* isadma.c */
 
+#ifdef CONFIG_ISA_DMA_API
 #define DMA_MODE_NO_ENABLE	0x0100
 
 void snd_dma_program(unsigned long dma, unsigned long addr, unsigned int size, unsigned short mode);
 void snd_dma_disable(unsigned long dma);
 unsigned int snd_dma_pointer(unsigned long dma, unsigned int size);
+#endif
 
 /* misc.c */
 
diff -urN RC13-rc6-git13-epca/sound/Kconfig RC13-rc6-git13-sound-isa-dma/sound/Kconfig
--- RC13-rc6-git13-epca/sound/Kconfig	2005-08-10 10:37:55.000000000 -0400
+++ RC13-rc6-git13-sound-isa-dma/sound/Kconfig	2005-08-21 13:16:47.000000000 -0400
@@ -77,7 +77,7 @@
 endmenu
 
 menu "Open Sound System"
-	depends on SOUND!=n && (BROKEN || (!SPARC32 && !SPARC64))
+	depends on SOUND!=n
 
 config SOUND_PRIME
 	tristate "Open Sound System (DEPRECATED)"
diff -urN RC13-rc6-git13-epca/sound/core/Makefile RC13-rc6-git13-sound-isa-dma/sound/core/Makefile
--- RC13-rc6-git13-epca/sound/core/Makefile	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc6-git13-sound-isa-dma/sound/core/Makefile	2005-08-21 13:16:47.000000000 -0400
@@ -5,7 +5,7 @@
 
 snd-objs     := sound.o init.o memory.o info.o control.o misc.o \
                 device.o wrappers.o
-ifeq ($(CONFIG_ISA),y)
+ifeq ($(CONFIG_ISA_DMA_API),y)
 snd-objs     += isadma.o
 endif
 ifeq ($(CONFIG_SND_OSSEMUL),y)
diff -urN RC13-rc6-git13-epca/sound/core/sound.c RC13-rc6-git13-sound-isa-dma/sound/core/sound.c
--- RC13-rc6-git13-epca/sound/core/sound.c	2005-08-10 10:37:55.000000000 -0400
+++ RC13-rc6-git13-sound-isa-dma/sound/core/sound.c	2005-08-21 13:16:47.000000000 -0400
@@ -432,7 +432,7 @@
 EXPORT_SYMBOL(snd_device_register);
 EXPORT_SYMBOL(snd_device_free);
   /* isadma.c */
-#ifdef CONFIG_ISA
+#ifdef CONFIG_ISA_DMA_API
 EXPORT_SYMBOL(snd_dma_program);
 EXPORT_SYMBOL(snd_dma_disable);
 EXPORT_SYMBOL(snd_dma_pointer);
diff -urN RC13-rc6-git13-epca/sound/isa/Kconfig RC13-rc6-git13-sound-isa-dma/sound/isa/Kconfig
--- RC13-rc6-git13-epca/sound/isa/Kconfig	2005-08-10 10:37:55.000000000 -0400
+++ RC13-rc6-git13-sound-isa-dma/sound/isa/Kconfig	2005-08-21 13:16:47.000000000 -0400
@@ -1,7 +1,7 @@
 # ALSA ISA drivers
 
 menu "ISA devices"
-	depends on SND!=n && ISA
+	depends on SND!=n && ISA && ISA_DMA_API
 
 config SND_AD1848_LIB
         tristate
diff -urN RC13-rc6-git13-epca/sound/oss/Kconfig RC13-rc6-git13-sound-isa-dma/sound/oss/Kconfig
--- RC13-rc6-git13-epca/sound/oss/Kconfig	2005-08-10 10:37:55.000000000 -0400
+++ RC13-rc6-git13-sound-isa-dma/sound/oss/Kconfig	2005-08-21 13:16:47.000000000 -0400
@@ -80,7 +80,7 @@
 
 config MIDI_EMU10K1
 	bool "Creative SBLive! MIDI (EXPERIMENTAL)"
-	depends on SOUND_EMU10K1 && EXPERIMENTAL
+	depends on SOUND_EMU10K1 && EXPERIMENTAL && ISA_DMA_API
 	help
 	  Say Y if you want to be able to use the OSS /dev/sequencer
 	  interface.  This code is still experimental.
@@ -503,7 +503,7 @@
 
 config MIDI_VIA82CXXX
 	bool "VIA 82C686 MIDI"
-	depends on SOUND_VIA82CXXX
+	depends on SOUND_VIA82CXXX && ISA_DMA_API
 	help
 	  Answer Y to use the MIDI interface of the Via686. You may need to
 	  enable this in the BIOS before it will work. This is for connection
@@ -512,7 +512,7 @@
 
 config SOUND_OSS
 	tristate "OSS sound modules"
-	depends on SOUND_PRIME
+	depends on SOUND_PRIME && ISA_DMA_API
 	help
 	  OSS is the Open Sound System suite of sound card drivers.  They make
 	  sound programming easier since they provide a common API.  Say Y or
diff -urN RC13-rc6-git13-epca/sound/pci/Kconfig RC13-rc6-git13-sound-isa-dma/sound/pci/Kconfig
--- RC13-rc6-git13-epca/sound/pci/Kconfig	2005-08-10 10:37:55.000000000 -0400
+++ RC13-rc6-git13-sound-isa-dma/sound/pci/Kconfig	2005-08-21 13:16:47.000000000 -0400
@@ -314,7 +314,7 @@
 
 config SND_ALS4000
 	tristate "Avance Logic ALS4000"
-	depends on SND
+	depends on SND && ISA_DMA_API
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_PCM
