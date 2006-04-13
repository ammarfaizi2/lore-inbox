Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbWDMBoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbWDMBoX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 21:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWDMBoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 21:44:23 -0400
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:50567 "EHLO
	smtpq1.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S932414AbWDMBoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 21:44:23 -0400
Message-ID: <443DAD5C.8080007@keyaccess.nl>
Date: Thu, 13 Apr 2006 03:46:04 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: ALSA devel <alsa-devel@alsa-project.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ALSA STABLE 3/3] a few more -- unregister platform device again
 if probe was unsuccessful
Content-Type: multipart/mixed;
 boundary="------------040703020001050005080109"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040703020001050005080109
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi.

And finally, unregister on probe failure for sound/drivers,
sound/arm/sa11xx-uda1341.c and sound/ppc/powermac.c.

   sound/arm/sa11xx-uda1341.c    |   14 +++++++++-----
   sound/drivers/dummy.c         |    4 ++++
   sound/drivers/mpu401/mpu401.c |    4 ++++
   sound/drivers/mtpav.c         |   14 +++++++++-----
   sound/drivers/serial-u16550.c |    4 ++++
   sound/drivers/virmidi.c       |    4 ++++
   sound/ppc/powermac.c          |   14 +++++++++-----
   7 files changed, 43 insertions(+), 15 deletions(-)

Signed-off-by: Rene Herman <rene.herman@keyaccess.nl>


--------------040703020001050005080109
Content-Type: text/plain;
 name="alsa_platform_unregister_remainder.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa_platform_unregister_remainder.diff"

Index: local/sound/arm/sa11xx-uda1341.c
===================================================================
--- local.orig/sound/arm/sa11xx-uda1341.c	2006-03-20 06:53:29.000000000 +0100
+++ local/sound/arm/sa11xx-uda1341.c	2006-04-13 03:14:49.000000000 +0200
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
Index: local/sound/drivers/dummy.c
===================================================================
--- local.orig/sound/drivers/dummy.c	2006-04-13 03:11:35.000000000 +0200
+++ local/sound/drivers/dummy.c	2006-04-13 03:14:49.000000000 +0200
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
Index: local/sound/drivers/mpu401/mpu401.c
===================================================================
--- local.orig/sound/drivers/mpu401/mpu401.c	2006-04-13 03:11:35.000000000 +0200
+++ local/sound/drivers/mpu401/mpu401.c	2006-04-13 03:14:49.000000000 +0200
@@ -252,6 +252,10 @@ static int __init alsa_card_mpu401_init(
 							 i, NULL, 0);
 		if (IS_ERR(device))
 			continue;
+		if (!platform_get_drvdata(device)) {
+			platform_device_unregister(device);
+			continue;
+		}
 		platform_devices[i] = device;
 		devices++;
 	}
Index: local/sound/drivers/mtpav.c
===================================================================
--- local.orig/sound/drivers/mtpav.c	2006-03-20 06:53:29.000000000 +0100
+++ local/sound/drivers/mtpav.c	2006-04-13 03:14:49.000000000 +0200
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
Index: local/sound/drivers/serial-u16550.c
===================================================================
--- local.orig/sound/drivers/serial-u16550.c	2006-04-13 03:11:35.000000000 +0200
+++ local/sound/drivers/serial-u16550.c	2006-04-13 03:14:49.000000000 +0200
@@ -997,6 +997,10 @@ static int __init alsa_card_serial_init(
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
Index: local/sound/drivers/virmidi.c
===================================================================
--- local.orig/sound/drivers/virmidi.c	2006-04-13 03:11:35.000000000 +0200
+++ local/sound/drivers/virmidi.c	2006-04-13 03:14:49.000000000 +0200
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
Index: local/sound/ppc/powermac.c
===================================================================
--- local.orig/sound/ppc/powermac.c	2006-03-20 06:53:29.000000000 +0100
+++ local/sound/ppc/powermac.c	2006-04-13 03:14:49.000000000 +0200
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
 


--------------040703020001050005080109--
