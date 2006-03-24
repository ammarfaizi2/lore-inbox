Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423142AbWCXFce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423142AbWCXFce (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 00:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423144AbWCXFce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 00:32:34 -0500
Received: from smtpq3.groni1.gr.home.nl ([213.51.130.202]:60117 "EHLO
	smtpq3.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S1423142AbWCXFcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 00:32:11 -0500
Message-ID: <4423848E.9030805@keyaccess.nl>
Date: Fri, 24 Mar 2006 06:33:02 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Greg Kroah-Hartman <gregkh@suse.de>,
       ALSA devel <alsa-devel@alsa-project.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ALSA] ISA drivers bailing on first IS_ERR
Content-Type: multipart/mixed;
 boundary="------------070003090208090007090509"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070003090208090007090509
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi.

If as per the previous message an error return from the probe() method
should make platform_driver_register_simple() return IS_ERR, then the
SNDRV_CARDS loop should continue with the next one, instead of bailing.

If the bus_add_device() patch and the attached is applied, the pre
platform_driver behaviour of not loading on not finding any devices (and
printing a message to that effect) is restored. Without, the printk is
dead code.

This has been generated against 2.6.16 + the earlier !enable[i] patch.

   sound/isa/ad1848/ad1848.c       |   14 ++++----------
   sound/isa/cmi8330.c             |   14 ++++----------
   sound/isa/cs423x/cs4231.c       |   14 ++++----------
   sound/isa/cs423x/cs4236.c       |   14 ++++----------
   sound/isa/es1688/es1688.c       |   14 ++++----------
   sound/isa/gus/gusclassic.c      |   14 ++++----------
   sound/isa/gus/gusextreme.c      |   14 ++++----------
   sound/isa/gus/gusmax.c          |   14 ++++----------
   sound/isa/gus/interwave.c       |   14 ++++----------
   sound/isa/opl3sa2.c             |   14 ++++----------
   sound/isa/sb/sb16.c             |   14 ++++----------
   sound/isa/sb/sb8.c              |   14 ++++----------
   sound/isa/sgalaxy.c             |   14 ++++----------
   sound/isa/wavefront/wavefront.c |   14 ++++----------
   14 files changed, 56 insertions(+), 140 deletions(-)

Rene.



--------------070003090208090007090509
Content-Type: text/plain;
 name="alsa_platform_dont_bail_on_error.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa_platform_dont_bail_on_error.diff"

Index: local/sound/isa/ad1848/ad1848.c
===================================================================
--- local.orig/sound/isa/ad1848/ad1848.c	2006-03-24 03:16:06.000000000 +0100
+++ local/sound/isa/ad1848/ad1848.c	2006-03-24 05:10:00.000000000 +0100
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
--- local.orig/sound/isa/cmi8330.c	2006-03-24 03:16:06.000000000 +0100
+++ local/sound/isa/cmi8330.c	2006-03-24 04:46:48.000000000 +0100
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
--- local.orig/sound/isa/cs423x/cs4231.c	2006-03-24 03:16:06.000000000 +0100
+++ local/sound/isa/cs423x/cs4231.c	2006-03-24 04:48:15.000000000 +0100
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
--- local.orig/sound/isa/cs423x/cs4236.c	2006-03-24 03:16:06.000000000 +0100
+++ local/sound/isa/cs423x/cs4236.c	2006-03-24 04:50:04.000000000 +0100
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
--- local.orig/sound/isa/es1688/es1688.c	2006-03-24 03:16:06.000000000 +0100
+++ local/sound/isa/es1688/es1688.c	2006-03-24 04:52:52.000000000 +0100
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
--- local.orig/sound/isa/gus/gusclassic.c	2006-03-24 03:16:06.000000000 +0100
+++ local/sound/isa/gus/gusclassic.c	2006-03-24 04:53:46.000000000 +0100
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
--- local.orig/sound/isa/gus/gusextreme.c	2006-03-24 03:16:06.000000000 +0100
+++ local/sound/isa/gus/gusextreme.c	2006-03-24 04:55:00.000000000 +0100
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
--- local.orig/sound/isa/gus/gusmax.c	2006-03-24 03:16:06.000000000 +0100
+++ local/sound/isa/gus/gusmax.c	2006-03-24 04:56:05.000000000 +0100
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
--- local.orig/sound/isa/gus/interwave.c	2006-03-24 03:16:06.000000000 +0100
+++ local/sound/isa/gus/interwave.c	2006-03-24 04:56:52.000000000 +0100
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
--- local.orig/sound/isa/opl3sa2.c	2006-03-24 03:16:06.000000000 +0100
+++ local/sound/isa/opl3sa2.c	2006-03-24 04:58:02.000000000 +0100
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
--- local.orig/sound/isa/sb/sb16.c	2006-03-24 03:16:06.000000000 +0100
+++ local/sound/isa/sb/sb16.c	2006-03-24 05:01:09.000000000 +0100
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
--- local.orig/sound/isa/sb/sb8.c	2006-03-24 03:16:06.000000000 +0100
+++ local/sound/isa/sb/sb8.c	2006-03-24 05:01:46.000000000 +0100
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
--- local.orig/sound/isa/sgalaxy.c	2006-03-24 03:16:06.000000000 +0100
+++ local/sound/isa/sgalaxy.c	2006-03-24 05:05:21.000000000 +0100
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
--- local.orig/sound/isa/wavefront/wavefront.c	2006-03-24 03:16:06.000000000 +0100
+++ local/sound/isa/wavefront/wavefront.c	2006-03-24 05:07:05.000000000 +0100
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



--------------070003090208090007090509--
