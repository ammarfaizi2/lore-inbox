Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129724AbQK0SFg>; Mon, 27 Nov 2000 13:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129799AbQK0SF0>; Mon, 27 Nov 2000 13:05:26 -0500
Received: from ife.ee.ethz.ch ([129.132.29.2]:46065 "EHLO ife.ee.ethz.ch")
        by vger.kernel.org with ESMTP id <S129724AbQK0SFV>;
        Mon, 27 Nov 2000 13:05:21 -0500
Date: Mon, 27 Nov 2000 18:35:16 +0100 (MET)
From: Thomas Sailer <sailer@ife.ee.ethz.ch>
Message-Id: <200011271735.eARHZGZ05973@eldrich.ee.ethz.ch>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH]: 2.4.0-testx: USB Audio
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a workaround for the Dallas chip; the chip tags
its 8bit formats with PCM8 but expects signed data.

Also, the driver is less verbose; I forward ported Alan Cox's changes
in 2.2.18pre

Tom
--- drivers/usb/audio.c.orig	Fri Oct 13 21:13:29 2000
+++ drivers/usb/audio.c	Mon Nov 27 18:32:32 2000
@@ -89,6 +89,9 @@
  *              Somewhat peculiar due to OSS interface limitations. Only works
  *              for channels where a "slider" is already in front of it (i.e.
  *              a MIXER unit or a FEATURE unit with volume capability).
+ * 2000-11-26:  Thomas Sailer
+ *              Workaround for Dallas DS4201. The DS4201 uses PCM8 as format tag for
+ *              its 8 bit modes, but expects signed data (and should therefore have used PCM).
  *
  */
 
@@ -191,6 +194,7 @@
 
 #define SND_DEV_DSP16   5 
 
+#define dprintk(x)
 
 /* --------------------------------------------------------------------- */
 
@@ -472,10 +476,10 @@
 	}
 	db->bufsize = nr << PAGE_SHIFT;
 	db->ready = 1;
-	printk(KERN_DEBUG "dmabuf_init: bytepersec %d bufs %d ossfragshift %d ossmaxfrags %d "
-	       "fragshift %d fragsize %d numfrag %d dmasize %d bufsize %d fmt 0x%x\n",
-	       bytepersec, bufs, db->ossfragshift, db->ossmaxfrags, db->fragshift, db->fragsize,
-	       db->numfrag, db->dmasize, db->bufsize, db->format);
+	dprintk((KERN_DEBUG "dmabuf_init: bytepersec %d bufs %d ossfragshift %d ossmaxfrags %d "
+	         "fragshift %d fragsize %d numfrag %d dmasize %d bufsize %d fmt 0x%x\n",
+	         bytepersec, bufs, db->ossfragshift, db->ossmaxfrags, db->fragshift, db->fragsize,
+	         db->numfrag, db->dmasize, db->bufsize, db->format));
 	return 0;
 }
 
@@ -829,7 +833,7 @@
 	for (i = 0; i < DESCFRAMES; i++) {
 		cp = ((unsigned char *)urb->transfer_buffer) + urb->iso_frame_desc[i].offset;
 		if (urb->iso_frame_desc[i].status) {
-			printk(KERN_DEBUG "usbin_retire_desc: frame %u status %d\n", i, urb->iso_frame_desc[i].status);
+			dprintk((KERN_DEBUG "usbin_retire_desc: frame %u status %d\n", i, urb->iso_frame_desc[i].status));
 			continue;
 		}
 		scnt = urb->iso_frame_desc[i].actual_length >> ufmtsh;
@@ -921,7 +925,7 @@
 	
 	for (i = 0; i < SYNCFRAMES; i++)
 		if (urb->iso_frame_desc[0].status)
-			printk(KERN_DEBUG "usbin_sync_retire_desc: frame %u status %d\n", i, urb->iso_frame_desc[i].status);
+			dprintk((KERN_DEBUG "usbin_sync_retire_desc: frame %u status %d\n", i, urb->iso_frame_desc[i].status));
 	return 0;
 }
 
@@ -954,7 +958,7 @@
 	} else {
 		u->flags &= ~(mask | FLG_RUNNING);
 		wake_up(&u->dma.wait);
-		printk(KERN_DEBUG "usbin_sync_completed: descriptor not restarted (usb_submit_urb: %d)\n", suret);
+		dprintk((KERN_DEBUG "usbin_sync_completed: descriptor not restarted (usb_submit_urb: %d)\n", suret));
 	}
 	spin_unlock_irqrestore(&as->lock, flags);
 }
@@ -1211,7 +1215,7 @@
 
 	for (i = 0; i < DESCFRAMES; i++) {
 		if (urb->iso_frame_desc[i].status) {
-			printk(KERN_DEBUG "usbout_retire_desc: frame %u status %d\n", i, urb->iso_frame_desc[i].status);
+			dprintk((KERN_DEBUG "usbout_retire_desc: frame %u status %d\n", i, urb->iso_frame_desc[i].status));
 			continue;
 		}
 	}
@@ -1247,7 +1251,7 @@
 	} else {
 		u->flags &= ~(mask | FLG_RUNNING);
 		wake_up(&u->dma.wait);
-		printk(KERN_DEBUG "usbout_completed: descriptor not restarted (usb_submit_urb: %d)\n", suret);
+		dprintk((KERN_DEBUG "usbout_completed: descriptor not restarted (usb_submit_urb: %d)\n", suret));
 	}
 	spin_unlock_irqrestore(&as->lock, flags);
 }
@@ -1273,11 +1277,11 @@
 
 	for (i = 0; i < SYNCFRAMES; i++, cp += 3) {
 		if (urb->iso_frame_desc[i].status) {
-			printk(KERN_DEBUG "usbout_sync_retire_desc: frame %u status %d\n", i, urb->iso_frame_desc[i].status);
+			dprintk((KERN_DEBUG "usbout_sync_retire_desc: frame %u status %d\n", i, urb->iso_frame_desc[i].status));
 			continue;
 		}
 		if (urb->iso_frame_desc[i].actual_length < 3) {
-			printk(KERN_DEBUG "usbout_sync_retire_desc: frame %u length %d\n", i, urb->iso_frame_desc[i].actual_length);
+			dprintk((KERN_DEBUG "usbout_sync_retire_desc: frame %u length %d\n", i, urb->iso_frame_desc[i].actual_length));
 			continue;
 		}
 		f = cp[0] | (cp[1] << 8) | (cp[2] << 16);
@@ -1319,7 +1323,7 @@
 	} else {
 		u->flags &= ~(mask | FLG_RUNNING);
 		wake_up(&u->dma.wait);
-		printk(KERN_DEBUG "usbout_sync_completed: descriptor not restarted (usb_submit_urb: %d)\n", suret);
+		dprintk((KERN_DEBUG "usbout_sync_completed: descriptor not restarted (usb_submit_urb: %d)\n", suret));
 	}
 	spin_unlock_irqrestore(&as->lock, flags);
 }
@@ -1520,9 +1524,7 @@
 		d->srate = fmt->sratelo;
 	if (d->srate > fmt->sratehi)
 		d->srate = fmt->sratehi;
-#if 1
-	printk(KERN_DEBUG "usb_audio: set_format_in: usb_set_interface %u %u\n", alts->bInterfaceNumber, fmt->altsetting);
-#endif
+	dprintk((KERN_DEBUG "usb_audio: set_format_in: usb_set_interface %u %u\n", alts->bInterfaceNumber, fmt->altsetting));
 	if (usb_set_interface(dev, alts->bInterfaceNumber, fmt->altsetting) < 0) {
 		printk(KERN_WARNING "usbaudio: usb_set_interface failed, device %d interface %d altsetting %d\n",
 		       dev->devnum, u->interface, fmt->altsetting);
@@ -1558,10 +1560,11 @@
 			       ret, dev->devnum, u->interface, ep);
 			return -1;
 		}
-		printk(KERN_DEBUG "usbaudio: set_format_in: device %d interface %d altsetting %d srate req: %u real %u\n",
-		       dev->devnum, u->interface, fmt->altsetting, d->srate, data[0] | (data[1] << 8) | (data[2] << 16));
+		dprintk((KERN_DEBUG "usbaudio: set_format_in: device %d interface %d altsetting %d srate req: %u real %u\n",
+		        dev->devnum, u->interface, fmt->altsetting, d->srate, data[0] | (data[1] << 8) | (data[2] << 16)));
 		d->srate = data[0] | (data[1] << 8) | (data[2] << 16);
 	}
+	dprintk((KERN_DEBUG "usbaudio: set_format_in: USB format 0x%x, DMA format 0x%x srate %u\n", u->format, d->format, d->srate));
 	return 0;
 }
 
@@ -1616,9 +1619,7 @@
 		d->srate = fmt->sratelo;
 	if (d->srate > fmt->sratehi)
 		d->srate = fmt->sratehi;
-#if 1
-	printk(KERN_DEBUG "usb_audio: set_format_out: usb_set_interface %u %u\n", alts->bInterfaceNumber, fmt->altsetting);
-#endif
+	dprintk((KERN_DEBUG "usb_audio: set_format_out: usb_set_interface %u %u\n", alts->bInterfaceNumber, fmt->altsetting));
 	if (usb_set_interface(dev, u->interface, fmt->altsetting) < 0) {
 		printk(KERN_WARNING "usbaudio: usb_set_interface failed, device %d interface %d altsetting %d\n",
 		       dev->devnum, u->interface, fmt->altsetting);
@@ -1654,10 +1655,11 @@
 			       ret, dev->devnum, u->interface, ep);
 			return -1;
 		}
-		printk(KERN_DEBUG "usbaudio: set_format_out: device %d interface %d altsetting %d srate req: %u real %u\n",
-		       dev->devnum, u->interface, fmt->altsetting, d->srate, data[0] | (data[1] << 8) | (data[2] << 16));
+		dprintk((KERN_DEBUG "usbaudio: set_format_out: device %d interface %d altsetting %d srate req: %u real %u\n",
+		        dev->devnum, u->interface, fmt->altsetting, d->srate, data[0] | (data[1] << 8) | (data[2] << 16)));
 		d->srate = data[0] | (data[1] << 8) | (data[2] << 16);
 	}
+	dprintk((KERN_DEBUG "usbaudio: set_format_out: USB format 0x%x, DMA format 0x%x srate %u\n", u->format, d->format, d->srate));
 	return 0;
 }
 
@@ -2895,6 +2897,9 @@
 				continue;
 			}
 			format = (fmt[5] == 2) ? (AFMT_U16_LE | AFMT_U8) : (AFMT_S16_LE | AFMT_S8);
+			/* Dallas DS4201 workaround */
+			if (dev->descriptor.idVendor == 0x04fa && dev->descriptor.idProduct == 0x4201)
+				format = (AFMT_S16_LE | AFMT_S8);
 			fmt = find_csinterface_descriptor(buffer, buflen, NULL, FORMAT_TYPE, asifout, i);
 			if (!fmt) {
 				printk(KERN_ERR "usbaudio: device %u interface %u altsetting %u FORMAT_TYPE descriptor not found\n", 
@@ -3709,11 +3714,11 @@
 
 	/* we get called with -1 for every audiostreaming interface registered */
 	if (s == (struct usb_audio_state *)-1) {
-		printk(KERN_DEBUG "usb_audio_disconnect: called with -1\n");
+		dprintk((KERN_DEBUG "usb_audio_disconnect: called with -1\n"));
 		return;
 	}
 	if (!s->usbdev) {
-		printk(KERN_DEBUG "usb_audio_disconnect: already called for %p!\n", s);
+		dprintk((KERN_DEBUG "usb_audio_disconnect: already called for %p!\n", s));
 		return;
 	}
 	down(&open_sem);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
