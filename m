Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbVLTUfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVLTUfk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbVLTUfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:35:40 -0500
Received: from smtp2.brturbo.com.br ([200.199.201.158]:41345 "EHLO
	smtp2.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932081AbVLTUfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:35:40 -0500
Subject: Re: [Alsa-devel] 2.6.15-rc6: boot failure in saa7134-alsa.c
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Sergey Vlasov <vsu@altlinux.ru>,
       Ricardo Cerqueira <v4l@cerqueira.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
In-Reply-To: <20051220191412.GA4578@stusta.de>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
	 <20051220131810.GB6789@stusta.de>
	 <20051220155216.GA19797@master.mivlgu.local>
	 <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org>
	 <20051220191412.GA4578@stusta.de>
Content-Type: multipart/mixed; boundary="=-bRPS/4XTTMJc0SgediSZ"
Date: Tue, 20 Dec 2005 18:35:30 -0200
Message-Id: <1135110930.7822.18.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-1mdk 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bRPS/4XTTMJc0SgediSZ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Em Ter, 2005-12-20 às 20:14 +0100, Adrian Bunk escreveu:
> (plus disabling building of saa7134-oss.o because
> otherwise saa7134-alsa.o wouldn't do anything). 

	This patch should fix alsa-oss incompatibilities when both are linked
as module. It will also require either -oss or -alsa if it is statically
linked.

	It doesn't address the OOPS because of sound late init.

	Adrian,

	Please test and give us some feedback.

Cheers, 
Mauro.

--=-bRPS/4XTTMJc0SgediSZ
Content-Disposition: attachment; filename=v4l_dvb_3200_fix_saa7134_alsa_oss_collisions.patch
Content-Type: text/x-patch; name=v4l_dvb_3200_fix_saa7134_alsa_oss_collisions.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

V4L/DVB (3200): Fix saa7134 ALSA/OSS collisions

From: Ricardo Cerqueira <v4l@cerqueira.org>

- When ALSA or OSS are loaded, check if the other is present
Fixed hotplug notifiers cleanup on module removal
- The saa7134 DMA sound modules now have their own Kconfig entries, and
if built statically enforce exclusivity
- SND_PCM_OSS isn't necessary for the OSS driver

Signed-off-by: Ricardo Cerqueira <v4l@cerqueira.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
---

 drivers/media/video/saa7134/Kconfig        |   26 ++++++++++++++++++++++++--
 drivers/media/video/saa7134/Makefile       |    7 +++++--
 drivers/media/video/saa7134/saa7134-alsa.c |   13 ++++++++++---
 drivers/media/video/saa7134/saa7134-oss.c  |   15 ++++++++++++---
 4 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/drivers/media/video/saa7134/Kconfig b/drivers/media/video/saa7134/Kconfig
index c512c44..c0f604a 100644
--- a/drivers/media/video/saa7134/Kconfig
+++ b/drivers/media/video/saa7134/Kconfig
@@ -1,11 +1,10 @@
 config VIDEO_SAA7134
 	tristate "Philips SAA7134 support"
-	depends on VIDEO_DEV && PCI && I2C && SOUND && SND
+	depends on VIDEO_DEV && PCI && I2C
 	select VIDEO_BUF
 	select VIDEO_IR
 	select VIDEO_TUNER
 	select CRC32
-	select SND_PCM_OSS
 	---help---
 	  This is a video4linux driver for Philips SAA713x based
 	  TV cards.
@@ -13,6 +12,29 @@ config VIDEO_SAA7134
 	  To compile this driver as a module, choose M here: the
 	  module will be called saa7134.
 
+config VIDEO_SAA7134_ALSA
+	tristate "Philips SAA7134 DMA audio support"
+	depends on VIDEO_SAA7134 && SOUND && SND && (!VIDEO_SAA7134_OSS || VIDEO_SAA7134_OSS = m)
+	select SND_PCM_OSS
+	---help---
+	  This is a video4linux driver for direct (DMA) audio in
+	  Philips SAA713x based TV cards using ALSA
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called saa7134-alsa.
+
+config VIDEO_SAA7134_OSS
+	tristate "Philips SAA7134 DMA audio support (OSS, DEPRECATED)"
+	depends on VIDEO_SAA7134 && SOUND_PRIME && (!VIDEO_SAA7134_ALSA || VIDEO_SAA7134_ALSA = m)
+	---help---
+	  This is a video4linux driver for direct (DMA) audio in
+	  Philips SAA713x based TV cards using OSS
+
+	  This is deprecated in favor of the ALSA module
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called saa7134-oss.
+
 config VIDEO_SAA7134_DVB
 	tristate "DVB/ATSC Support for saa7134 based TV cards"
 	depends on VIDEO_SAA7134 && DVB_CORE
diff --git a/drivers/media/video/saa7134/Makefile b/drivers/media/video/saa7134/Makefile
index 134f83a..1ba9984 100644
--- a/drivers/media/video/saa7134/Makefile
+++ b/drivers/media/video/saa7134/Makefile
@@ -4,8 +4,11 @@ saa7134-objs :=	saa7134-cards.o saa7134-
 		saa7134-video.o saa7134-input.o
 
 obj-$(CONFIG_VIDEO_SAA7134) +=  saa7134.o saa7134-empress.o \
-				saa6752hs.o saa7134-alsa.o \
-				saa7134-oss.o
+				saa6752hs.o
+
+obj-$(CONFIG_VIDEO_SAA7134_ALSA) += saa7134-alsa.o
+obj-$(CONFIG_VIDEO_SAA7134_OSS) += saa7134-oss.o
+
 obj-$(CONFIG_VIDEO_SAA7134_DVB) += saa7134-dvb.o
 
 EXTRA_CFLAGS += -I$(src)/..
diff --git a/drivers/media/video/saa7134/saa7134-alsa.c b/drivers/media/video/saa7134/saa7134-alsa.c
index 953d5fe..ac608b1 100644
--- a/drivers/media/video/saa7134/saa7134-alsa.c
+++ b/drivers/media/video/saa7134/saa7134-alsa.c
@@ -989,6 +989,14 @@ static int saa7134_alsa_init(void)
 	struct saa7134_dev *dev = NULL;
 	struct list_head *list;
 
+	if (!dmasound_init && !dmasound_exit) {
+		dmasound_init = alsa_device_init;
+		dmasound_exit = alsa_device_exit;
+	} else {
+		printk(KERN_WARNING "saa7134 ALSA: can't load, DMA sound handler already assigned (probably to OSS)\n");
+		return -EBUSY;
+	}
+
 	printk(KERN_INFO "saa7134 ALSA driver for DMA sound loaded\n");
 
 	list_for_each(list,&saa7134_devlist) {
@@ -1001,9 +1009,6 @@ static int saa7134_alsa_init(void)
 		}
 	}
 
-	dmasound_init = alsa_device_init;
-	dmasound_exit = alsa_device_exit;
-
 	if (dev == NULL)
 		printk(KERN_INFO "saa7134 ALSA: no saa7134 cards found\n");
 
@@ -1023,6 +1028,8 @@ static void saa7134_alsa_exit(void)
 		snd_card_free(snd_saa7134_cards[idx]);
 	}
 
+	dmasound_init = NULL;
+	dmasound_exit = NULL;
 	printk(KERN_INFO "saa7134 ALSA driver for DMA sound unloaded\n");
 
 	return;
diff --git a/drivers/media/video/saa7134/saa7134-oss.c b/drivers/media/video/saa7134/saa7134-oss.c
index 513a699..0061acf 100644
--- a/drivers/media/video/saa7134/saa7134-oss.c
+++ b/drivers/media/video/saa7134/saa7134-oss.c
@@ -959,8 +959,17 @@ static int saa7134_oss_init(void)
 	struct saa7134_dev *dev = NULL;
 	struct list_head *list;
 
+	if (!dmasound_init && !dmasound_exit) {
+		dmasound_init = oss_device_init;
+		dmasound_exit = oss_device_exit;
+	} else {
+		printk(KERN_WARNING "saa7134 OSS: can't load, DMA sound handler already assigned (probably to ALSA)\n");
+		return -EBUSY;
+	}
+
 	printk(KERN_INFO "saa7134 OSS driver for DMA sound loaded\n");
 
+
 	list_for_each(list,&saa7134_devlist) {
 		dev = list_entry(list, struct saa7134_dev, devlist);
 		if (dev->dmasound.priv_data == NULL) {
@@ -974,9 +983,6 @@ static int saa7134_oss_init(void)
 	if (dev == NULL)
 		printk(KERN_INFO "saa7134 OSS: no saa7134 cards found\n");
 
-	dmasound_init = oss_device_init;
-	dmasound_exit = oss_device_exit;
-
 	return 0;
 
 }
@@ -997,6 +1003,9 @@ static void saa7134_oss_exit(void)
 
 	}
 
+	dmasound_init = NULL;
+	dmasound_exit = NULL;
+
 	printk(KERN_INFO "saa7134 OSS driver for DMA sound unloaded\n");
 
 	return;

--=-bRPS/4XTTMJc0SgediSZ--

