Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbTIXEOX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 00:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbTIXEOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 00:14:23 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:45406 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261760AbTIXEON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 00:14:13 -0400
Date: Wed, 24 Sep 2003 00:13:34 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Chris Wright <chrisw@osdl.org>, marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu, alan@lxorguk.ukuu.org.uk,
       zaitcev@redhat.com
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths
Message-ID: <20030924001334.A19940@devserv.devel.redhat.com>
References: <20030923140503.N20572@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030923140503.N20572@osdlab.pdx.osdl.net>; from chrisw@osdl.org on Tue, Sep 23, 2003 at 02:05:03PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Tue, 23 Sep 2003 13:15:15 -0700
> From: Chris Wright <chrisw@osdl.org>

> --- 1.38/sound/oss/ymfpci.c	Tue Aug 26 09:25:41 2003
> +++ edited/sound/oss/ymfpci.c	Tue Sep 23 12:42:45 2003
> @@ -2638,6 +2638,7 @@
>   out_free:
>  	if (codec->ac97_codec[0])
>  		ac97_release_codec(codec->ac97_codec[0]);
> +	kfree(codec);
>  	return -ENODEV;
>  }

Someone was savaging sound code, adding these bugs.
For 2.6, the above patch is probably ok; it's immaterial,
because ALSA won long ago.

A patch for 2.4 to undo the damage is attached.

-- Pete

diff -ur -X dontdiff linux-2.4.23-pre5/drivers/sound/ymfpci.c linux-2.4.23-pre5-nip/drivers/sound/ymfpci.c
--- linux-2.4.23-pre5/drivers/sound/ymfpci.c	2003-09-23 17:41:04.000000000 -0700
+++ linux-2.4.23-pre5-nip/drivers/sound/ymfpci.c	2003-09-23 20:44:46.000000000 -0700
@@ -173,43 +173,40 @@
 
 static void ymfpci_codec_write(struct ac97_codec *dev, u8 reg, u16 val)
 {
-	ymfpci_t *codec = dev->private_data;
+	ymfpci_t *unit = dev->private_data;
 	u32 cmd;
 
-	spin_lock(&codec->ac97_lock);
+	down(&unit->ac97_lock);
 	/* XXX Do make use of dev->id */
-	ymfpci_codec_ready(codec, 0, 0);
+	ymfpci_codec_ready(unit, 0, 0);
 	cmd = ((YDSXG_AC97WRITECMD | reg) << 16) | val;
-	ymfpci_writel(codec, YDSXGR_AC97CMDDATA, cmd);
-	spin_unlock(&codec->ac97_lock);
+	ymfpci_writel(unit, YDSXGR_AC97CMDDATA, cmd);
+	up(&unit->ac97_lock);
 }
 
-static u16 _ymfpci_codec_read(ymfpci_t *unit, u8 reg)
+static u16 ymfpci_codec_read(struct ac97_codec *dev, u8 reg)
 {
+	ymfpci_t *unit = dev->private_data;
 	int i;
+	u16 ret;
 
+	down(&unit->ac97_lock);
 	if (ymfpci_codec_ready(unit, 0, 0))
-		return ~0;
+		goto out_none;
 	ymfpci_writew(unit, YDSXGR_AC97CMDADR, YDSXG_AC97READCMD | reg);
 	if (ymfpci_codec_ready(unit, 0, 0))
-		return ~0;
+		goto out_none;
 	if (unit->pci->device == PCI_DEVICE_ID_YAMAHA_744 && unit->rev < 2) {
 		for (i = 0; i < 600; i++)
 			ymfpci_readw(unit, YDSXGR_PRISTATUSDATA);
 	}
-	return ymfpci_readw(unit, YDSXGR_PRISTATUSDATA);
-}
-
-static u16 ymfpci_codec_read(struct ac97_codec *dev, u8 reg)
-{
-	ymfpci_t *unit = dev->private_data;
-	u16 ret;
-	
-	spin_lock(&unit->ac97_lock);
-	ret = _ymfpci_codec_read(unit, reg);
-	spin_unlock(&unit->ac97_lock);
-	
+	ret = ymfpci_readw(unit, YDSXGR_PRISTATUSDATA);
+	up(&unit->ac97_lock);
 	return ret;
+
+out_none:
+	up(&unit->ac97_lock);
+	return ~0;
 }
 
 /*
@@ -2526,7 +2523,7 @@
 
 	spin_lock_init(&codec->reg_lock);
 	spin_lock_init(&codec->voice_lock);
-	spin_lock_init(&codec->ac97_lock);
+	init_MUTEX(&codec->ac97_lock);
 	init_MUTEX(&codec->open_sem);
 	INIT_LIST_HEAD(&codec->states);
 	codec->pci = pcidev;
@@ -2625,6 +2622,7 @@
  out_release_region:
 	release_mem_region(pci_resource_start(pcidev, 0), 0x8000);
  out_free:
+	kfree(codec);
 	return -ENODEV;
 }
 
@@ -2652,6 +2650,7 @@
 		unload_uart401(&codec->mpu_data);
 	}
 #endif /* CONFIG_SOUND_YMFPCI_LEGACY */
+	kfree(codec);
 }
 
 MODULE_AUTHOR("Jaroslav Kysela");
diff -ur -X dontdiff linux-2.4.23-pre5/drivers/sound/ymfpci.h linux-2.4.23-pre5-nip/drivers/sound/ymfpci.h
--- linux-2.4.23-pre5/drivers/sound/ymfpci.h	2003-09-23 17:56:01.000000000 -0700
+++ linux-2.4.23-pre5-nip/drivers/sound/ymfpci.h	2003-09-23 20:46:06.000000000 -0700
@@ -275,7 +275,7 @@
 
 	spinlock_t reg_lock;
 	spinlock_t voice_lock;
-	spinlock_t ac97_lock;
+	struct semaphore ac97_lock;
 
 	/* soundcore stuff */
 	int dev_audio;
