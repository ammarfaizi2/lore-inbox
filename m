Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131110AbQLUR53>; Thu, 21 Dec 2000 12:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131220AbQLUR5T>; Thu, 21 Dec 2000 12:57:19 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:54801 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S131110AbQLUR5H>; Thu, 21 Dec 2000 12:57:07 -0500
Date: Thu, 21 Dec 2000 12:27:33 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
To: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] few fixes for ymf_sb.c in test13pre3-ac3
Message-ID: <Pine.LNX.4.30.0012211152490.2220-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Alan!

Thank you for applying my patch to test13pre3-ac3!

However, there is a glaring bug in drivers/sound/Config.in -
CONFIG_SOUND_YMFPCI is declared twice - once outside CONFIG_OSS, then
inside CONFIG_OSS. I'm removing the later declaration.

CONFIG_SOUND_YMPCI should be disabled if the native driver is compiled
into the kernel. I'm fixing it as well.

Also I tried ymf_sb.c without SUPPORT_UART401_MIDI defined (you have to
edit ymf_sb.c to undefine it). I noticed that the "soundcore"  module
would remain in memory with usage count 1 after inserting and removing
"ymf_sb".

It appears that ymf_sb.c should never call sb_dsp_unload with the second
argument being 1 (unload_mpu). It's a 1-byte fix. I decided not to change
the signature of ymf7xxsb_unload_sb for now.

The patch is also available here:
http://www.red-bean.com/~proski/ymf/ymf_sb.patch

P.S. The patch has been tested. My system is running test13pre3-ac3 and
playing nice music :-)

Regards,
Pavel Roskin

________________________
--- linux.orig/drivers/sound/Config.in
+++ linux/drivers/sound/Config.in
@@ -145,9 +145,8 @@
    dep_tristate '    Yamaha FM synthesizer (YM3812/OPL-3) support' CONFIG_SOUND_YM3812 $CONFIG_SOUND_OSS
    dep_tristate '    Yamaha OPL3-SA1 audio controller' CONFIG_SOUND_OPL3SA1 $CONFIG_SOUND_OSS
    dep_tristate '    Yamaha OPL3-SA2, SA3, and SAx based PnP cards' CONFIG_SOUND_OPL3SA2 $CONFIG_SOUND_OSS
-   dep_tristate '    Yamaha YMF7xx PCI audio (legacy mode)' CONFIG_SOUND_YMPCI $CONFIG_SOUND_OSS $CONFIG_PCI
-   if [ "$CONFIG_SOUND_YMPCI" = "n" ]; then
-      dep_tristate '    Yamaha YMF7xx PCI audio (native mode) (EXPERIMENTAL)' CONFIG_SOUND_YMFPCI $CONFIG_SOUND_OSS $CONFIG_PCI $CONFIG_EXPERIMENTAL
+   if [ "$CONFIG_SOUND_YMFPCI" != "y" ]; then
+     dep_tristate '    Yamaha YMF7xx PCI audio (legacy mode)' CONFIG_SOUND_YMPCI $CONFIG_SOUND_OSS $CONFIG_PCI
    fi
    dep_tristate '    6850 UART support' CONFIG_SOUND_UART6850 $CONFIG_SOUND_OSS

--- linux.orig/drivers/sound/ymf_sb.c
+++ linux/drivers/sound/ymf_sb.c
@@ -836,7 +836,7 @@
 		ymf7xxsb_unload_sb (&sb_data[i], 0);
 		ymf7xxsb_unload_midi (&mpu_data[i]);
 #else
-		ymf7xxsb_unload_sb (&sb_data[i], 1);
+		ymf7xxsb_unload_sb (&sb_data[i], 0);
 #endif
 	}

________________________


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
