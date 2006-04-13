Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWDMBlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWDMBlw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 21:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWDMBlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 21:41:52 -0400
Received: from smtpq3.tilbu1.nb.home.nl ([213.51.146.202]:38369 "EHLO
	smtpq3.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S932416AbWDMBlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 21:41:51 -0400
Message-ID: <443DACC2.5050802@keyaccess.nl>
Date: Thu, 13 Apr 2006 03:43:30 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: ALSA devel <alsa-devel@alsa-project.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ALSA 2/2] a few more -- unregister platform device again if probe
 was unsuccessful
Content-Type: multipart/mixed;
 boundary="------------010204000408050302020006"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010204000408050302020006
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi.

This second one unregisters the platform device again when the probe is
unsuccesful for sound/drivers, sound/arm/sa11xx-uda1341.c and
sound/ppc/powermac.c. This gets them all.

   sound/arm/sa11xx-uda1341.c    |   14 +++++++++-----
   sound/drivers/dummy.c         |    4 ++++
   sound/drivers/mpu401/mpu401.c |    4 ++++
   sound/drivers/mtpav.c         |   14 +++++++++-----
   sound/drivers/serial-u16550.c |    4 ++++
   sound/drivers/virmidi.c       |    4 ++++
   sound/ppc/powermac.c          |   14 +++++++++-----

Signed-off-by: Rene Herman <rene.herman@keyaccess.nl>



--------------010204000408050302020006
Content-Type: text/plain;
 name="alsa_platform_unregister_remainder.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa_platform_unregister_remainder.diff"

Index: mm/sound/arm/sa11xx-uda1341.c
===================================================================
--- mm.orig/sound/arm/sa11xx-uda1341.c	2006-03-20 06:53:29.000000000 +0100
+++ mm/sound/arm/sa11xx-uda1341.c	2006-04-13 02:04:30.000000000 +0200
@@ -984,11 +984,15 @@ static int __init sa11xx_uda1341_init(vo
 	if ((err = platform_driver_register(&sa11xx_uda1341_driver)) < 0)
 		return err;
 	device = platform_device_register_simple(SA11XX_UDA1341_DRIVER, -1, NULL, 0);
-	if (IS_ERR(device)) {
-		platform_driver_unregister(&sa11xx_uda1341_driver);
-		return PTR_ERR(device);
-	}
-	return 0;
+	if (!IS_ERR(device)) {
+		if (platform_get_drvdata(device))
+			return 0;
+		platform_device_unregister(device);
+		err = -ENODEV
+	} else
+		err = PTR_ERR(device);
+	platform_driver_unregister(&sa11xx_uda1341_driver);
+	return err;
 }
 
 static void __exit sa11xx_uda1341_exit(void)
Index: mm/sound/drivers/dummy.c
===================================================================
--- mm.orig/sound/drivers/dummy.c	2006-04-13 01:45:57.000000000 +0200
+++ mm/sound/drivers/dummy.c	2006-04-13 02:05:33.000000000 +0200
@@ -677,6 +677,10 @@ static int __init alsa_card_dummy_init(v
 							 i, NULL, 0);
 		if (IS_ERR(device))
 			continue;
+		if (!platform_get_drvdata(device)) {
+			platform_device_unregister(device);
+			continue;
+		}
 		devices[i] = device;
 		cards++;
 	}
Index: mm/sound/drivers/mpu401/mpu401.c
===================================================================
--- mm.orig/sound/drivers/mpu401/mpu401.c	2006-04-13 01:45:57.000000000 +0200
+++ mm/sound/drivers/mpu401/mpu401.c	2006-04-13 02:06:23.000000000 +0200
@@ -254,6 +254,10 @@ static int __init alsa_card_mpu401_init(
 							 i, NULL, 0);
 		if (IS_ERR(device))
 			continue;
+		if (!platform_get_drvdata(device)) {
+			platform_device_unregister(device);
+			continue;
+		}
 		platform_devices[i] = device;
 		snd_mpu401_devices++;
 	}
Index: mm/sound/drivers/mtpav.c
===================================================================
--- mm.orig/sound/drivers/mtpav.c	2006-04-13 01:45:57.000000000 +0200
+++ mm/sound/drivers/mtpav.c	2006-04-13 02:08:27.000000000 +0200
@@ -770,11 +770,15 @@ static int __init alsa_card_mtpav_init(v
 		return err;
 
 	device = platform_device_register_simple(SND_MTPAV_DRIVER, -1, NULL, 0);
-	if (IS_ERR(device)) {
-		platform_driver_unregister(&snd_mtpav_driver);
-		return PTR_ERR(device);
-	}
-	return 0;
+	if (!IS_ERR(device)) {
+		if (platform_get_drvdata(device))
+			return 0;
+		platform_device_unregister(device);
+		err = -ENODEV;
+	} else
+		err = PTR_ERR(device);
+	platform_driver_unregister(&snd_mtpav_driver);
+	return err;
 }
 
 static void __exit alsa_card_mtpav_exit(void)
Index: mm/sound/drivers/serial-u16550.c
===================================================================
--- mm.orig/sound/drivers/serial-u16550.c	2006-04-13 01:45:57.000000000 +0200
+++ mm/sound/drivers/serial-u16550.c	2006-04-13 02:09:07.000000000 +0200
@@ -998,6 +998,10 @@ static int __init alsa_card_serial_init(
 							 i, NULL, 0);
 		if (IS_ERR(device))
 			continue;
+		if (!platform_get_drvdata(device)) {
+			platform_device_unregister(device);
+			continue;
+		}
 		devices[i] = device;
 		cards++;
 	}
Index: mm/sound/drivers/virmidi.c
===================================================================
--- mm.orig/sound/drivers/virmidi.c	2006-04-13 01:45:57.000000000 +0200
+++ mm/sound/drivers/virmidi.c	2006-04-13 02:09:53.000000000 +0200
@@ -171,6 +171,10 @@ static int __init alsa_card_virmidi_init
 							 i, NULL, 0);
 		if (IS_ERR(device))
 			continue;
+		if (!platform_get_drvdata(device)) {
+			platform_device_unregister(device);
+			continue;
+		}
 		devices[i] = device;
 		cards++;
 	}
Index: mm/sound/ppc/powermac.c
===================================================================
--- mm.orig/sound/ppc/powermac.c	2006-03-20 06:53:29.000000000 +0100
+++ mm/sound/ppc/powermac.c	2006-04-13 02:11:27.000000000 +0200
@@ -188,11 +188,15 @@ static int __init alsa_card_pmac_init(vo
 	if ((err = platform_driver_register(&snd_pmac_driver)) < 0)
 		return err;
 	device = platform_device_register_simple(SND_PMAC_DRIVER, -1, NULL, 0);
-	if (IS_ERR(device)) {
-		platform_driver_unregister(&snd_pmac_driver);
-		return PTR_ERR(device);
-	}
-	return 0;
+	if (!IS_ERR(device)) {
+		if (platform_get_drvdata(device))
+			return 0;
+		platform_device_unregister(device);
+		err = -ENODEV;
+	} else
+		err = PTR_ERR(device);
+	platform_driver_unregister(&snd_pmac_driver);
+	return err;
 
 }
 


--------------010204000408050302020006--
