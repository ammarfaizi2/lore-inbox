Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932874AbWF2Jur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932874AbWF2Jur (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 05:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932879AbWF2Jur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 05:50:47 -0400
Received: from [141.84.69.5] ([141.84.69.5]:39435 "HELO mailout.stusta.mhn.de")
	by vger.kernel.org with SMTP id S932874AbWF2Juq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 05:50:46 -0400
Date: Thu, 29 Jun 2006 11:49:44 +0200
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix the SND_FM801_TEA575X dependencies
Message-ID: <20060629094944.GA29056@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_SND_FM801=y, CONFIG_SND_FM801_TEA575X=m resulted in the following 
compile error:

<--  snip  -->

...
  LD      vmlinux
sound/built-in.o: In function `snd_fm801_free':
fm801.c:(.text+0x3c15b): undefined reference to `snd_tea575x_exit'
sound/built-in.o: In function `snd_card_fm801_probe':
fm801.c:(.text+0x3cfde): undefined reference to `snd_tea575x_init'
make: *** [vmlinux] Error 1

<--  snip  -->

This patch fixes kernel Bugzilla #6458.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 sound/pci/Kconfig |   14 ++++++++------
 sound/pci/fm801.c |    2 +-
 2 files changed, 9 insertions(+), 7 deletions(-)

--- linux-2.6.17-mm3-full/sound/pci/Kconfig.old	2006-06-28 18:47:02.000000000 +0200
+++ linux-2.6.17-mm3-full/sound/pci/Kconfig	2006-06-28 19:03:58.000000000 +0200
@@ -323,17 +323,19 @@
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-fm801.
 
-config SND_FM801_TEA575X
-	tristate "ForteMedia FM801 + TEA5757 tuner"
+config SND_FM801_TEA575X_BOOL
+	bool "ForteMedia FM801 + TEA5757 tuner"
 	depends on SND_FM801
-        select VIDEO_DEV
 	help
 	  Say Y here to include support for soundcards based on the ForteMedia
 	  FM801 chip with a TEA5757 tuner connected to GPIO1-3 pins (Media
-	  Forte SF256-PCS-02).
+	  Forte SF256-PCS-02) into the snd-fm801 driver.
 
-	  To compile this driver as a module, choose M here: the module
-	  will be called snd-fm801-tea575x.
+config SND_FM801_TEA575X
+       tristate
+       depends on SND_FM801_TEA575X_BOOL
+       default SND_FM801
+       select VIDEO_DEV
 
 config SND_HDA_INTEL
 	tristate "Intel HD Audio"
--- linux-2.6.17-mm3-full/sound/pci/fm801.c.old	2006-06-28 18:50:29.000000000 +0200
+++ linux-2.6.17-mm3-full/sound/pci/fm801.c	2006-06-28 19:05:35.000000000 +0200
@@ -35,7 +35,7 @@
 
 #include <asm/io.h>
 
-#if (defined(CONFIG_SND_FM801_TEA575X) || defined(CONFIG_SND_FM801_TEA575X_MODULE)) && (defined(CONFIG_VIDEO_DEV) || defined(CONFIG_VIDEO_DEV_MODULE))
+#ifdef CONFIG_SND_FM801_TEA575X_BOOL
 #include <sound/tea575x-tuner.h>
 #define TEA575X_RADIO 1
 #endif

