Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWDJXNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWDJXNd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 19:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWDJXNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 19:13:33 -0400
Received: from smtpq3.tilbu1.nb.home.nl ([213.51.146.202]:45536 "EHLO
	smtpq3.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S932188AbWDJXNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 19:13:32 -0400
Message-ID: <443AE6F4.5030905@keyaccess.nl>
Date: Tue, 11 Apr 2006 01:15:00 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: ALSA devel <alsa-devel@alsa-project.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ALSA STABLE 2/3] continue on IS_ERR from platform device registration
Content-Type: multipart/mixed;
 boundary="------------080507080003070207060805"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080507080003070207060805
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi

Continue with the next one on error from device registration for
-stable. Against 2.6.16.2.

Was submitted and acked before. Could you relay to -stable yourself?

   sound/isa/ad1848/ad1848.c       |   14 ++++----------
   sound/isa/cmi8330.c             |   14 ++++----------
   sound/isa/cs423x/cs4231.c       |   14 ++++----------
   sound/isa/cs423x/cs4236.c       |   14 ++++----------
   sound/isa/es1688/es1688.c       |   14 ++++----------
   sound/isa/es18xx.c              |   14 ++++----------
   sound/isa/gus/gusclassic.c      |   14 ++++----------
   sound/isa/gus/gusextreme.c      |   14 ++++----------
   sound/isa/gus/gusmax.c          |   14 ++++----------
   sound/isa/gus/interwave.c       |   14 ++++----------
   sound/isa/opl3sa2.c             |   14 ++++----------
   sound/isa/sb/sb16.c             |   14 ++++----------
   sound/isa/sb/sb8.c              |   14 ++++----------
   sound/isa/sgalaxy.c             |   14 ++++----------
   sound/isa/sscape.c              |   14 ++++----------
   sound/isa/wavefront/wavefront.c |   14 ++++----------
   16 files changed, 64 insertions(+), 160 deletions(-)

Rene


--------------080507080003070207060805
Content-Type: text/plain;
 name="alsa_platform_iserr.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa_platform_iserr.diff"

Index: local/sound/isa/ad1848/ad1848.c
===================================================================
--- local.orig/sound/isa/ad1848/ad1848.c	2006-04-06 03:10:35.000000000 +0200
+++ local/sound/isa/ad1848/ad1848.c	2006-04-06 03:10:39.000000000 +0200
@@ -193,10 +193,8 @@ static int __init alsa_card_ad1848_init(
 			continue;
 		device = platform_device_register_simple(SND_AD1848_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		devices[i] = device;
 		cards++;
 	}
@@ -204,14 +202,10 @@ static int __init alsa_card_ad1848_init(
 #ifdef MODULE
 		printk(KERN_ERR "AD1848 soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_ad1848_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_ad1848_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_ad1848_exit(void)
Index: local/sound/isa/cmi8330.c
===================================================================
--- local.orig/sound/isa/cmi8330.c	2006-04-06 03:10:35.000000000 +0200
+++ local/sound/isa/cmi8330.c	2006-04-06 03:10:39.000000000 +0200
@@ -696,10 +696,8 @@ static int __init alsa_card_cmi8330_init
 			continue;
 		device = platform_device_register_simple(CMI8330_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		platform_devices[i] = device;
 		cards++;
 	}
@@ -716,14 +714,10 @@ static int __init alsa_card_cmi8330_init
 #ifdef MODULE
 		snd_printk(KERN_ERR "CMI8330 not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_cmi8330_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_cmi8330_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_cmi8330_exit(void)
Index: local/sound/isa/cs423x/cs4231.c
===================================================================
--- local.orig/sound/isa/cs423x/cs4231.c	2006-04-06 03:10:35.000000000 +0200
+++ local/sound/isa/cs423x/cs4231.c	2006-04-06 03:10:39.000000000 +0200
@@ -209,10 +209,8 @@ static int __init alsa_card_cs4231_init(
 			continue;
 		device = platform_device_register_simple(SND_CS4231_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		devices[i] = device;
 		cards++;
 	}
@@ -220,14 +218,10 @@ static int __init alsa_card_cs4231_init(
 #ifdef MODULE
 		printk(KERN_ERR "CS4231 soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_cs4231_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_cs4231_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_cs4231_exit(void)
Index: local/sound/isa/cs423x/cs4236.c
===================================================================
--- local.orig/sound/isa/cs423x/cs4236.c	2006-04-06 03:10:35.000000000 +0200
+++ local/sound/isa/cs423x/cs4236.c	2006-04-06 03:10:39.000000000 +0200
@@ -777,10 +777,8 @@ static int __init alsa_card_cs423x_init(
 			continue;
 		device = platform_device_register_simple(CS423X_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		platform_devices[i] = device;
 		cards++;
 	}
@@ -803,14 +801,10 @@ static int __init alsa_card_cs423x_init(
 #ifdef MODULE
 		printk(KERN_ERR IDENT " soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_cs423x_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_cs423x_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_cs423x_exit(void)
Index: local/sound/isa/es1688/es1688.c
===================================================================
--- local.orig/sound/isa/es1688/es1688.c	2006-04-06 03:10:35.000000000 +0200
+++ local/sound/isa/es1688/es1688.c	2006-04-06 03:10:39.000000000 +0200
@@ -213,10 +213,8 @@ static int __init alsa_card_es1688_init(
 			continue;
 		device = platform_device_register_simple(ES1688_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		devices[i] = device;
 		cards++;
 	}
@@ -224,14 +222,10 @@ static int __init alsa_card_es1688_init(
 #ifdef MODULE
 		printk(KERN_ERR "ESS AudioDrive ES1688 soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_es1688_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_es1688_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_es1688_exit(void)
Index: local/sound/isa/gus/gusclassic.c
===================================================================
--- local.orig/sound/isa/gus/gusclassic.c	2006-04-06 03:10:35.000000000 +0200
+++ local/sound/isa/gus/gusclassic.c	2006-04-06 03:10:39.000000000 +0200
@@ -253,10 +253,8 @@ static int __init alsa_card_gusclassic_i
 			continue;
 		device = platform_device_register_simple(GUSCLASSIC_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		devices[i] = device;
 		cards++;
 	}
@@ -264,14 +262,10 @@ static int __init alsa_card_gusclassic_i
 #ifdef MODULE
 		printk(KERN_ERR "GUS Classic soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_gusclassic_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_gusclassic_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_gusclassic_exit(void)
Index: local/sound/isa/gus/gusextreme.c
===================================================================
--- local.orig/sound/isa/gus/gusextreme.c	2006-04-06 03:10:35.000000000 +0200
+++ local/sound/isa/gus/gusextreme.c	2006-04-06 03:10:39.000000000 +0200
@@ -363,10 +363,8 @@ static int __init alsa_card_gusextreme_i
 			continue;
 		device = platform_device_register_simple(GUSEXTREME_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		devices[i] = device;
 		cards++;
 	}
@@ -374,14 +372,10 @@ static int __init alsa_card_gusextreme_i
 #ifdef MODULE
 		printk(KERN_ERR "GUS Extreme soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_gusextreme_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_gusextreme_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_gusextreme_exit(void)
Index: local/sound/isa/gus/gusmax.c
===================================================================
--- local.orig/sound/isa/gus/gusmax.c	2006-04-06 03:10:35.000000000 +0200
+++ local/sound/isa/gus/gusmax.c	2006-04-06 03:10:39.000000000 +0200
@@ -390,10 +390,8 @@ static int __init alsa_card_gusmax_init(
 			continue;
 		device = platform_device_register_simple(GUSMAX_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		devices[i] = device;
 		cards++;
 	}
@@ -401,14 +399,10 @@ static int __init alsa_card_gusmax_init(
 #ifdef MODULE
 		printk(KERN_ERR "GUS MAX soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_gusmax_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_gusmax_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_gusmax_exit(void)
Index: local/sound/isa/gus/interwave.c
===================================================================
--- local.orig/sound/isa/gus/interwave.c	2006-04-06 03:10:35.000000000 +0200
+++ local/sound/isa/gus/interwave.c	2006-04-06 03:10:39.000000000 +0200
@@ -945,10 +945,8 @@ static int __init alsa_card_interwave_in
 #endif
 		device = platform_device_register_simple(INTERWAVE_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		platform_devices[i] = device;
 		cards++;
 	}
@@ -964,14 +962,10 @@ static int __init alsa_card_interwave_in
 #ifdef MODULE
 		printk(KERN_ERR "InterWave soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_interwave_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_interwave_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_interwave_exit(void)
Index: local/sound/isa/opl3sa2.c
===================================================================
--- local.orig/sound/isa/opl3sa2.c	2006-04-06 03:10:35.000000000 +0200
+++ local/sound/isa/opl3sa2.c	2006-04-06 03:10:39.000000000 +0200
@@ -959,10 +959,8 @@ static int __init alsa_card_opl3sa2_init
 #endif
 		device = platform_device_register_simple(OPL3SA2_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		platform_devices[i] = device;
 		cards++;
 	}
@@ -984,14 +982,10 @@ static int __init alsa_card_opl3sa2_init
 #ifdef MODULE
 		snd_printk(KERN_ERR "Yamaha OPL3-SA soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_opl3sa2_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_opl3sa2_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_opl3sa2_exit(void)
Index: local/sound/isa/sb/sb16.c
===================================================================
--- local.orig/sound/isa/sb/sb16.c	2006-04-06 03:10:35.000000000 +0200
+++ local/sound/isa/sb/sb16.c	2006-04-06 03:10:39.000000000 +0200
@@ -718,10 +718,8 @@ static int __init alsa_card_sb16_init(vo
 			continue;
 		device = platform_device_register_simple(SND_SB16_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		platform_devices[i] = device;
 		cards++;
 	}
@@ -743,14 +741,10 @@ static int __init alsa_card_sb16_init(vo
 		snd_printk(KERN_ERR "In case, if you have AWE card, try snd-sbawe module\n");
 #endif
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_sb16_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_sb16_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_sb16_exit(void)
Index: local/sound/isa/sb/sb8.c
===================================================================
--- local.orig/sound/isa/sb/sb8.c	2006-04-06 03:10:35.000000000 +0200
+++ local/sound/isa/sb/sb8.c	2006-04-06 03:10:39.000000000 +0200
@@ -264,10 +264,8 @@ static int __init alsa_card_sb8_init(voi
 			continue;
 		device = platform_device_register_simple(SND_SB8_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		devices[i] = device;
 		cards++;
 	}
@@ -275,14 +273,10 @@ static int __init alsa_card_sb8_init(voi
 #ifdef MODULE
 		snd_printk(KERN_ERR "Sound Blaster soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_sb8_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_sb8_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_sb8_exit(void)
Index: local/sound/isa/sgalaxy.c
===================================================================
--- local.orig/sound/isa/sgalaxy.c	2006-04-06 03:10:35.000000000 +0200
+++ local/sound/isa/sgalaxy.c	2006-04-06 03:10:39.000000000 +0200
@@ -366,10 +366,8 @@ static int __init alsa_card_sgalaxy_init
 			continue;
 		device = platform_device_register_simple(SND_SGALAXY_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		devices[i] = device;
 		cards++;
 	}
@@ -377,14 +375,10 @@ static int __init alsa_card_sgalaxy_init
 #ifdef MODULE
 		snd_printk(KERN_ERR "Sound Galaxy soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_sgalaxy_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_sgalaxy_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_sgalaxy_exit(void)
Index: local/sound/isa/wavefront/wavefront.c
===================================================================
--- local.orig/sound/isa/wavefront/wavefront.c	2006-04-06 03:10:35.000000000 +0200
+++ local/sound/isa/wavefront/wavefront.c	2006-04-06 03:10:39.000000000 +0200
@@ -720,10 +720,8 @@ static int __init alsa_card_wavefront_in
 #endif
 		device = platform_device_register_simple(WAVEFRONT_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		platform_devices[i] = device;
 		cards++;
 	}
@@ -740,14 +738,10 @@ static int __init alsa_card_wavefront_in
 #ifdef MODULE
 		printk (KERN_ERR "No WaveFront cards found or devices busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_wavefront_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_wavefront_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_wavefront_exit(void)
Index: local/sound/isa/es18xx.c
===================================================================
--- local.orig/sound/isa/es18xx.c	2006-04-06 03:10:10.000000000 +0200
+++ local/sound/isa/es18xx.c	2006-04-06 03:10:39.000000000 +0200
@@ -2231,10 +2231,8 @@ static int __init alsa_card_es18xx_init(
 			continue;
 		device = platform_device_register_simple(ES18XX_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+	       		continue;
 		platform_devices[i] = device;
 		cards++;
 	}
@@ -2251,14 +2249,10 @@ static int __init alsa_card_es18xx_init(
 #ifdef MODULE
 		snd_printk(KERN_ERR "ESS AudioDrive ES18xx soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_es18xx_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_es18xx_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_es18xx_exit(void)
Index: local/sound/isa/sscape.c
===================================================================
--- local.orig/sound/isa/sscape.c	2006-04-06 03:10:10.000000000 +0200
+++ local/sound/isa/sscape.c	2006-04-06 03:10:39.000000000 +0200
@@ -1427,8 +1427,8 @@ static int __init sscape_manual_probe(vo
 		    dma[i] == SNDRV_AUTO_DMA) {
 			printk(KERN_INFO
 			       "sscape: insufficient parameters, need IO, IRQ, MPU-IRQ and DMA\n");
-			ret = -ENXIO;
-			goto errout;
+			sscape_unregister_all();
+			return -ENXIO;
 		}
 
 		/*
@@ -1436,17 +1436,11 @@ static int __init sscape_manual_probe(vo
 		 */
 		device = platform_device_register_simple(SSCAPE_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			ret = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		platform_devices[i] = device;
 	}
 	return 0;
-
- errout:
-	sscape_unregister_all();
-	return ret;
 }
 
 static void sscape_exit(void)


--------------080507080003070207060805--
