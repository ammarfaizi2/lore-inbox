Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143598AbRAHNRu>; Mon, 8 Jan 2001 08:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143720AbRAHNRl>; Mon, 8 Jan 2001 08:17:41 -0500
Received: from monsoon.mail.pipex.net ([158.43.128.69]:48564 "HELO
	monsoon.mail.pipex.net") by vger.kernel.org with SMTP
	id <S143637AbRAHNRb>; Mon, 8 Jan 2001 08:17:31 -0500
From: Chris Rankin <rankinc@zip.com.au>
Message-Id: <200101081308.f08D8iv01511@wittsend.ukgateway.net>
Subject: PATCH for 2.4.0: assign ad1848 mixer operations to correct module
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Date: Mon, 8 Jan 2001 13:08:44 +0000 (GMT)
Reply-To: rankinc@zip.com.au
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch fixes a problem that I was having with the ENSONIQ
SoundScape mixer: basically, the mixer device was owned by the ad1848
module but was being deallocated when the sscape module was
unloaded. This patch hands the mixer device to the sscape module
instead so that the sscape module -cannot- be unloaded while the mixer
is in use.

--- linux-vanilla/drivers/sound/ad1848.c  Fri Aug 11 16:26:43 2000
+++ linux-2.4.0-ac3/drivers/sound/ad1848.c  Mon Jan  8 12:36:30 2001
@@ -1986,6 +1986,10 @@
      if (sound_alloc_dma(dma_capture, devc->name))
        printk(KERN_WARNING "ad1848.c: Can't allocate DMA%d\n", dma_capture);
  }
+
+ if (owner)
+   ad1848_mixer_operations.owner = owner;
+
  if ((e = sound_install_mixer(MIXER_DRIVER_VERSION,
             dev_name,
             &ad1848_mixer_operations,

BTW Isn't it ever-so-slightly dodgy modifying the static
ad1848_mixer_operations structure like this? I have modified the mixer
operations in exactly the same way as the ad1848_audio_driver
structure, but doesn't this mean that the ad1848_init() function now
"remembers" the owner from the previous call?

Maybe a better patch would be:

--- linux-vanilla/drivers/sound/ad1848.c	Fri Aug 11 16:26:43 2000
+++ linux-2.4.0-ac3/drivers/sound/ad1848.c	Mon Jan  8 13:01:54 2001
@@ -1900,8 +1900,7 @@
 	if(portc==NULL)
 		return -1;
 
-	if (owner)
-		ad1848_audio_driver.owner = owner;
+	ad1848_audio_driver.owner = (owner ? owner : THIS_MODULE);
 	
 	if ((my_dev = sound_install_audiodrv(AUDIO_DRIVER_VERSION,
 					     dev_name,
@@ -1986,6 +1985,9 @@
 			if (sound_alloc_dma(dma_capture, devc->name))
 				printk(KERN_WARNING "ad1848.c: Can't allocate DMA%d\n", dma_capture);
 	}
+
+	ad1848_mixer_operations.owner = (owner ? owner : THIS_MODULE);
+
 	if ((e = sound_install_mixer(MIXER_DRIVER_VERSION,
 				     dev_name,
 				     &ad1848_mixer_operations,

Or maybe the sound_install_XXXX() functions should accept "owner"
parameters, so that the static structs could become "const"?

Cheers,
Chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
