Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129260AbQK0SBq>; Mon, 27 Nov 2000 13:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129340AbQK0SBg>; Mon, 27 Nov 2000 13:01:36 -0500
Received: from ife.ee.ethz.ch ([129.132.29.2]:25841 "EHLO ife.ee.ethz.ch")
        by vger.kernel.org with ESMTP id <S129260AbQK0SB0>;
        Mon, 27 Nov 2000 13:01:26 -0500
Date: Mon, 27 Nov 2000 18:31:20 +0100 (MET)
From: Thomas Sailer <sailer@ife.ee.ethz.ch>
Message-Id: <200011271731.eARHVKv05965@eldrich.ee.ethz.ch>
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH]: USB Audio 2.2.18pre
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a workaround for the Dallas chip; the chip tags
its 8bit formats with PCM8 but expects signed data.

--- drivers/usb/audio.c.orig	Mon Oct  2 15:23:28 2000
+++ drivers/usb/audio.c	Mon Nov 27 00:08:54 2000
@@ -89,6 +89,9 @@
  *              Somewhat peculiar due to OSS interface limitations. Only works
  *              for channels where a "slider" is already in front of it (i.e.
  *              a MIXER unit or a FEATURE unit with volume capability).
+ * 2000-11-26:  Thomas Sailer
+ *              Workaround for Dallas DS4201. The DS4201 uses PCM8 as format tag for
+ *              its 8 bit modes, but expects signed data (and should therefore have used PCM).
  *
  */
 
@@ -1551,6 +1554,7 @@
 		       dev->devnum, u->interface, fmt->altsetting, d->srate, data[0] | (data[1] << 8) | (data[2] << 16)));
 		d->srate = data[0] | (data[1] << 8) | (data[2] << 16);
 	}
+	dprintk((KERN_DEBUG "usbaudio: set_format_in: USB format 0x%x, DMA format 0x%x srate %u\n", u->format, d->format, d->srate));
 	return 0;
 }
 
@@ -1647,6 +1651,7 @@
 		       dev->devnum, u->interface, fmt->altsetting, d->srate, data[0] | (data[1] << 8) | (data[2] << 16)));
 		d->srate = data[0] | (data[1] << 8) | (data[2] << 16);
 	}
+	dprintk((KERN_DEBUG "usbaudio: set_format_out: USB format 0x%x, DMA format 0x%x srate %u\n", u->format, d->format, d->srate));
 	return 0;
 }
 
@@ -2851,6 +2856,9 @@
 				continue;
 			}
 			format = (fmt[5] == 2) ? (AFMT_U16_LE | AFMT_U8) : (AFMT_S16_LE | AFMT_S8);
+			/* Dallas DS4201 workaround */
+			if (dev->descriptor.idVendor == 0x04fa && dev->descriptor.idProduct == 0x4201)
+				format = (AFMT_S16_LE | AFMT_S8);
 			fmt = find_csinterface_descriptor(buffer, buflen, NULL, FORMAT_TYPE, asifout, i);
 			if (!fmt) {
 				printk(KERN_ERR "usbaudio: device %u interface %u altsetting %u FORMAT_TYPE descriptor not found\n", 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
