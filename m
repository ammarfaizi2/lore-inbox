Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbWGQQh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbWGQQh2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWGQQgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:36:54 -0400
Received: from mail.kroah.org ([69.55.234.183]:49084 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750974AbWGQQdo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:33:44 -0400
Date: Mon, 17 Jul 2006 09:28:56 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Adrian Bunk <bunk@stusta.de>,
       Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 37/45] ALSA: fix the SND_FM801_TEA575X dependencies
Message-ID: <20060717162856.GL4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="alsa-fix-the-snd_fm801_tea575x-dependencies.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Takashi Iwai <tiwai@suse.de>

[PATCH] ALSA: fix the SND_FM801_TEA575X dependencies

CONFIG_SND_FM801=y, CONFIG_SND_FM801_TEA575X=m resulted in the following
compile error:
<--  snip  -->
...
  LD      vmlinux
sound/built-in.o: In function 'snd_fm801_free':
fm801.c:(.text+0x3c15b): undefined reference to 'snd_tea575x_exit'
sound/built-in.o: In function 'snd_card_fm801_probe':
fm801.c:(.text+0x3cfde): undefined reference to 'snd_tea575x_init'
make: *** [vmlinux] Error 1
<--  snip  -->
This patch fixes kernel Bugzilla #6458.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Jaroslav Kysela <perex@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 sound/pci/Kconfig |   14 ++++++++------
 sound/pci/fm801.c |    2 +-
 2 files changed, 9 insertions(+), 7 deletions(-)

--- linux-2.6.17.6.orig/sound/pci/Kconfig
+++ linux-2.6.17.6/sound/pci/Kconfig
@@ -318,17 +318,19 @@ config SND_FM801
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
--- linux-2.6.17.6.orig/sound/pci/fm801.c
+++ linux-2.6.17.6/sound/pci/fm801.c
@@ -35,7 +35,7 @@
 
 #include <asm/io.h>
 
-#if (defined(CONFIG_SND_FM801_TEA575X) || defined(CONFIG_SND_FM801_TEA575X_MODULE)) && (defined(CONFIG_VIDEO_DEV) || defined(CONFIG_VIDEO_DEV_MODULE))
+#ifdef CONFIG_SND_FM801_TEA575X_BOOL
 #include <sound/tea575x-tuner.h>
 #define TEA575X_RADIO 1
 #endif

--
