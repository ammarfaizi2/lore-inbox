Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S261229AbVCEX7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVCEX7c (ORCPT <rfc822;akpm@zip.com.au>);
	Sat, 5 Mar 2005 18:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVCEX4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 18:56:09 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:27880 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S261231AbVCEXhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 18:37:20 -0500
Date: Sat, 05 Mar 2005 17:37:18 -0600 (CST)
Date-warning: Date header was inserted by vms046.mailsrvcs.net
From: James Nelson <james4765@cwazy.co.uk>
Subject: [PATCH 2/13] usbaudio: Clean up printk()'s in drivers/usb/class/audio.c
In-reply-to: <20050305233712.7648.24364.93822@localhost.localdomain>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-id: <20050305233718.7648.18888.22315@localhost.localdomain>
References: <20050305233712.7648.24364.93822@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a badly-implemented debugging printk macro, and clean up the other printk()s
in drivers/usb/class/audio.c

Signed-off-by: James Nelson <james4765@gmail.com>

diff -Nurp -x dontdiff-osdl --exclude='*~' linux-2.6.11-mm1-original/drivers/usb/class/audio.c linux-2.6.11-mm1/drivers/usb/class/audio.c
--- linux-2.6.11-mm1-original/drivers/usb/class/audio.c	2005-03-05 13:29:48.000000000 -0500
+++ linux-2.6.11-mm1/drivers/usb/class/audio.c	2005-03-05 14:47:44.000000000 -0500
@@ -179,6 +179,10 @@
 
 /*****************************************************************************/
 
+#ifdef CONFIG_USB_DEBUG
+#define DEBUG
+#endif /*CONFIG_USB_DEBUG*/
+
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -206,11 +210,13 @@
 #define DRIVER_AUTHOR "Alan Cox <alan@lxorguk.ukuu.org.uk>, Thomas Sailer (sailer@ife.ee.ethz.ch)"
 #define DRIVER_DESC "USB Audio Class driver"
 
+#define PFX "usbaudio: "
+
 #define AUDIO_DEBUG 1
 
 #define SND_DEV_DSP16   5
 
-#define dprintk(x)
+#define DPRINTK(fmt, args...) pr_debug (PFX "%s(): ", fmt, __FUNCTION__, ##args)
 
 /* --------------------------------------------------------------------- */
 
@@ -490,10 +496,11 @@ static int dmabuf_init(struct dmabuf *db
 	}
 	db->bufsize = nr << PAGE_SHIFT;
 	db->ready = 1;
-	dprintk((KERN_DEBUG "usbaudio: dmabuf_init bytepersec %d bufs %d ossfragshift %d ossmaxfrags %d "
-	         "fragshift %d fragsize %d numfrag %d dmasize %d bufsize %d fmt 0x%x srate %d\n",
-	         bytepersec, bufs, db->ossfragshift, db->ossmaxfrags, db->fragshift, db->fragsize,
-	         db->numfrag, db->dmasize, db->bufsize, db->format, db->srate));
+	DPRINTK("bytepersec %d bufs %d ossfragshift %d ossmaxfrags %d "
+		"fragshift %d fragsize %d numfrag %d dmasize %d bufsize %d "
+		"fmt 0x%x srate %d\n", bytepersec, bufs,db->ossfragshift,
+		db->ossmaxfrags, db->fragshift, db->fragsize, db->numfrag,
+		db->dmasize, db->bufsize, db->format, db->srate);
 	return 0;
 }
 
@@ -851,7 +858,7 @@ static int usbin_retire_desc(struct usbi
 	for (i = 0; i < DESCFRAMES; i++) {
 		cp = ((unsigned char *)urb->transfer_buffer) + urb->iso_frame_desc[i].offset;
 		if (urb->iso_frame_desc[i].status) {
-			dprintk((KERN_DEBUG "usbin_retire_desc: frame %u status %d\n", i, urb->iso_frame_desc[i].status));
+			DPRINTK("frame %u status %d\n", i, urb->iso_frame_desc[i].status);
 			continue;
 		}
 		scnt = urb->iso_frame_desc[i].actual_length >> ufmtsh;
@@ -869,11 +876,11 @@ static int usbin_retire_desc(struct usbi
 		u->dma.count += cnt;
 		if (u->format == u->dma.format) {
 			/* we do not need format conversion */
-			dprintk((KERN_DEBUG "usbaudio: no sample format conversion\n"));
+			DPRINTK("no sample format conversion\n");
 			dmabuf_copyin(&u->dma, cp, cnt);
 		} else {
 			/* we need sampling format conversion */
-			dprintk((KERN_DEBUG "usbaudio: sample format conversion %x != %x\n", u->format, u->dma.format));
+			DPRINTK("sample format conversion %x != %x\n", u->format, u->dma.format);
 			usbin_convert(u, cp, scnt);
 		}
 	}
@@ -893,7 +900,8 @@ static void usbin_completed(struct urb *
 	int suret = 0;
 
 #if 0
-	printk(KERN_DEBUG "usbin_completed: status %d errcnt %d flags 0x%x\n", urb->status, urb->error_count, u->flags);
+	printk(KERN_DEBUG PFX "%s(): status %d errcnt %d flags 0x%x\n",
+		__FUNCTION__, urb->status, urb->error_count, u->flags);
 #endif
 	if (urb == u->durb[0].urb)
 		mask = FLG_URB0RUNNING;
@@ -901,7 +909,7 @@ static void usbin_completed(struct urb *
 		mask = FLG_URB1RUNNING;
 	else {
 		mask = 0;
-		printk(KERN_ERR "usbin_completed: panic: unknown URB\n");
+		printk(KERN_ERR PFX "%s(): unknown URB\n", __FUNCTION__);
 	}
 	urb->dev = as->state->usbdev;
 	spin_lock_irqsave(&as->lock, flags);
@@ -913,7 +921,8 @@ static void usbin_completed(struct urb *
 	} else {
 		u->flags &= ~(mask | FLG_RUNNING);
 		wake_up(&u->dma.wait);
-		printk(KERN_DEBUG "usbin_completed: descriptor not restarted (usb_submit_urb: %d)\n", suret);
+		printk(KERN_DEBUG PFX "%s(): descriptor not restarted (usb_submit_urb: %d)\n",
+			__FUNCTION__, suret);
 	}
 	spin_unlock_irqrestore(&as->lock, flags);
 }
@@ -946,7 +955,7 @@ static int usbin_sync_retire_desc(struct
 	
 	for (i = 0; i < SYNCFRAMES; i++)
 		if (urb->iso_frame_desc[0].status)
-			dprintk((KERN_DEBUG "usbin_sync_retire_desc: frame %u status %d\n", i, urb->iso_frame_desc[i].status));
+			DPRINTK("frame %u status %d\n", i, urb->iso_frame_desc[i].status);
 	return 0;
 }
 
@@ -959,7 +968,8 @@ static void usbin_sync_completed(struct 
 	int suret = 0;
 
 #if 0
-	printk(KERN_DEBUG "usbin_sync_completed: status %d errcnt %d flags 0x%x\n", urb->status, urb->error_count, u->flags);
+	printk(KERN_DEBUG PFX "%s(): status %d errcnt %d flags 0x%x\n",
+		__FUNCTION__, urb->status, urb->error_count, u->flags);
 #endif
 	if (urb == u->surb[0].urb)
 		mask = FLG_SYNC0RUNNING;
@@ -967,7 +977,7 @@ static void usbin_sync_completed(struct 
 		mask = FLG_SYNC1RUNNING;
 	else {
 		mask = 0;
-		printk(KERN_ERR "usbin_sync_completed: panic: unknown URB\n");
+		printk(KERN_ERR PFX "%s(): unknown URB\n", __FUNCTION__);
 	}
 	urb->dev = as->state->usbdev;
 	spin_lock_irqsave(&as->lock, flags);
@@ -979,7 +989,7 @@ static void usbin_sync_completed(struct 
 	} else {
 		u->flags &= ~(mask | FLG_RUNNING);
 		wake_up(&u->dma.wait);
-		dprintk((KERN_DEBUG "usbin_sync_completed: descriptor not restarted (usb_submit_urb: %d)\n", suret));
+		DPRINTK("descriptor not restarted (usb_submit_urb: %d)\n", suret);
 	}
 	spin_unlock_irqrestore(&as->lock, flags);
 }
@@ -993,8 +1003,8 @@ static int usbin_start(struct usb_audiod
 	unsigned int maxsze, bufsz;
 
 #if 0
-	printk(KERN_DEBUG "usbin_start: device %d ufmt 0x%08x dfmt 0x%08x srate %d\n",
-	       dev->devnum, u->format, u->dma.format, u->dma.srate);
+	printk(KERN_DEBUG PFX "%s(): device %d ufmt 0x%08x dfmt 0x%08x srate %d\n",
+		__FUNCTION__, dev->devnum, u->format, u->dma.format, u->dma.srate);
 #endif
 	/* allocate USB storage if not already done */
 	spin_lock_irqsave(&as->lock, flags);
@@ -1029,7 +1039,7 @@ static int usbin_start(struct usb_audiod
 		}
 		if (!u->durb[0].urb->transfer_buffer || !u->durb[1].urb->transfer_buffer || 
 		    (u->syncpipe && (!u->surb[0].urb->transfer_buffer || !u->surb[1].urb->transfer_buffer))) {
-			printk(KERN_ERR "usbaudio: cannot start playback device %d\n", dev->devnum);
+			printk(KERN_ERR PFX "cannot start playback device %d\n", dev->devnum);
 			return 0;
 		}
 		spin_lock_irqsave(&as->lock, flags);
@@ -1237,7 +1247,7 @@ static int usbout_retire_desc(struct usb
 
 	for (i = 0; i < DESCFRAMES; i++) {
 		if (urb->iso_frame_desc[i].status) {
-			dprintk((KERN_DEBUG "usbout_retire_desc: frame %u status %d\n", i, urb->iso_frame_desc[i].status));
+			DPRINTK("frame %u status %d\n", i, urb->iso_frame_desc[i].status);
 			continue;
 		}
 	}
@@ -1253,7 +1263,8 @@ static void usbout_completed(struct urb 
 	int suret = 0;
 
 #if 0
-	printk(KERN_DEBUG "usbout_completed: status %d errcnt %d flags 0x%x\n", urb->status, urb->error_count, u->flags);
+	printk(KERN_DEBUG PFX "%s(): status %d errcnt %d flags 0x%x\n", __FUNCTION__,
+		urb->status, urb->error_count, u->flags);
 #endif
 	if (urb == u->durb[0].urb)
 		mask = FLG_URB0RUNNING;
@@ -1261,7 +1272,7 @@ static void usbout_completed(struct urb 
 		mask = FLG_URB1RUNNING;
 	else {
 		mask = 0;
-		printk(KERN_ERR "usbout_completed: panic: unknown URB\n");
+		printk(KERN_ERR PFX "%s(): unknown URB\n", __FUNCTION__);
 	}
 	urb->dev = as->state->usbdev;
 	spin_lock_irqsave(&as->lock, flags);
@@ -1273,7 +1284,7 @@ static void usbout_completed(struct urb 
 	} else {
 		u->flags &= ~(mask | FLG_RUNNING);
 		wake_up(&u->dma.wait);
-		dprintk((KERN_DEBUG "usbout_completed: descriptor not restarted (usb_submit_urb: %d)\n", suret));
+		DPRINTK("descriptor not restarted (usb_submit_urb: %d)\n", suret);
 	}
 	spin_unlock_irqrestore(&as->lock, flags);
 }
@@ -1300,16 +1311,17 @@ static int usbout_sync_retire_desc(struc
 
 	for (i = 0; i < SYNCFRAMES; i++, cp += 3) {
 		if (urb->iso_frame_desc[i].status) {
-			dprintk((KERN_DEBUG "usbout_sync_retire_desc: frame %u status %d\n", i, urb->iso_frame_desc[i].status));
+			DPRINTK("frame %u status %d\n", i, urb->iso_frame_desc[i].status);
 			continue;
 		}
 		if (urb->iso_frame_desc[i].actual_length < 3) {
-			dprintk((KERN_DEBUG "usbout_sync_retire_desc: frame %u length %d\n", i, urb->iso_frame_desc[i].actual_length));
+			DPRINTK("frame %u length %d\n", i, urb->iso_frame_desc[i].actual_length);
 			continue;
 		}
 		f = cp[0] | (cp[1] << 8) | (cp[2] << 16);
 		if (abs(f - u->freqn) > (u->freqn >> 3) || f > u->freqmax) {
-			printk(KERN_WARNING "usbout_sync_retire_desc: requested frequency %u (nominal %u) out of range!\n", f, u->freqn);
+			printk(KERN_WARNING PFX "%s(): requested frequency %u (nominal %u) out of range!\n",
+				__FUNCTION__, f, u->freqn);
 			continue;
 		}
 		u->freqm = f;
@@ -1326,7 +1338,8 @@ static void usbout_sync_completed(struct
 	int suret = 0;
 
 #if 0
-	printk(KERN_DEBUG "usbout_sync_completed: status %d errcnt %d flags 0x%x\n", urb->status, urb->error_count, u->flags);
+	printk(KERN_DEBUG PFX "%s(): status %d errcnt %d flags 0x%x\n", __FUNCTION__,
+		urb->status, urb->error_count, u->flags);
 #endif
 	if (urb == u->surb[0].urb)
 		mask = FLG_SYNC0RUNNING;
@@ -1334,7 +1347,7 @@ static void usbout_sync_completed(struct
 		mask = FLG_SYNC1RUNNING;
 	else {
 		mask = 0;
-		printk(KERN_ERR "usbout_sync_completed: panic: unknown URB\n");
+		printk(KERN_ERR PFX "%s(): unknown URB\n", __FUNCTION__);
 	}
 	urb->dev = as->state->usbdev;
 	spin_lock_irqsave(&as->lock, flags);
@@ -1346,7 +1359,7 @@ static void usbout_sync_completed(struct
 	} else {
 		u->flags &= ~(mask | FLG_RUNNING);
 		wake_up(&u->dma.wait);
-		dprintk((KERN_DEBUG "usbout_sync_completed: descriptor not restarted (usb_submit_urb: %d)\n", suret));
+		DPRINTK("descriptor not restarted (usb_submit_urb: %d)\n", suret);
 	}
 	spin_unlock_irqrestore(&as->lock, flags);
 }
@@ -1360,8 +1373,8 @@ static int usbout_start(struct usb_audio
 	unsigned int maxsze, bufsz;
 
 #if 0
-	printk(KERN_DEBUG "usbout_start: device %d ufmt 0x%08x dfmt 0x%08x srate %d\n",
-	       dev->devnum, u->format, u->dma.format, u->dma.srate);
+	printk(KERN_DEBUG PFX "%s(): device %d ufmt 0x%08x dfmt 0x%08x srate %d\n",
+		__FUNCTION__, dev->devnum, u->format, u->dma.format, u->dma.srate);
 #endif
 	/* allocate USB storage if not already done */
 	spin_lock_irqsave(&as->lock, flags);
@@ -1396,7 +1409,7 @@ static int usbout_start(struct usb_audio
 		}
 		if (!u->durb[0].urb->transfer_buffer || !u->durb[1].urb->transfer_buffer || 
 		    (u->syncpipe && (!u->surb[0].urb->transfer_buffer || !u->surb[1].urb->transfer_buffer))) {
-			printk(KERN_ERR "usbaudio: cannot start playback device %d\n", dev->devnum);
+			printk(KERN_ERR PFX "cannot start playback device %d\n", dev->devnum);
 			return 0;
 		}
 		spin_lock_irqsave(&as->lock, flags);
@@ -1521,7 +1534,7 @@ static int set_format_in(struct usb_audi
 
 	fmtnr = find_format(as->fmtin, as->numfmtin, d->format, d->srate);
 	if (fmtnr < 0) {
-		printk(KERN_ERR "usbaudio: set_format_in(): failed to find desired format/speed combination.\n");
+		printk(KERN_ERR PFX "%s(): failed to find desired format/speed combination\n", __FUNCTION__);
 		return -1;
 	}
 
@@ -1535,7 +1548,7 @@ static int set_format_in(struct usb_audi
 		    alts->endpoint[1].desc.bmAttributes != 0x01 ||
 		    alts->endpoint[1].desc.bSynchAddress != 0 ||
 		    alts->endpoint[1].desc.bEndpointAddress != (alts->endpoint[0].desc.bSynchAddress & 0x7f)) {
-			printk(KERN_WARNING "usbaudio: device %d interface %d altsetting %d claims adaptive in "
+			printk(KERN_WARNING PFX "device %d interface %d altsetting %d claims adaptive in "
 			       "but has invalid synch pipe; treating as asynchronous in\n",
 			       dev->devnum, u->interface, fmt->altsetting);
 		} else {
@@ -1547,10 +1560,9 @@ static int set_format_in(struct usb_audi
 		d->srate = fmt->sratelo;
 	if (d->srate > fmt->sratehi)
 		d->srate = fmt->sratehi;
-	dprintk((KERN_DEBUG "usbaudio: set_format_in: usb_set_interface %u %u\n",
-			u->interface, fmt->altsetting));
+	DPRINTK("usb_set_interface %u %u\n", u->interface, fmt->altsetting);
 	if (usb_set_interface(dev, alts->desc.bInterfaceNumber, fmt->altsetting) < 0) {
-		printk(KERN_WARNING "usbaudio: usb_set_interface failed, device %d interface %d altsetting %d\n",
+		printk(KERN_WARNING PFX "usb_set_interface failed, device %d interface %d altsetting %d\n",
 		       dev->devnum, u->interface, fmt->altsetting);
 		return -1;
 	}
@@ -1562,7 +1574,7 @@ static int set_format_in(struct usb_audi
 		data[0] = 1;
 		if ((ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), SET_CUR, USB_TYPE_CLASS|USB_RECIP_ENDPOINT|USB_DIR_OUT, 
 					   PITCH_CONTROL << 8, ep, data, 1, 1000)) < 0) {
-			printk(KERN_ERR "usbaudio: failure (error %d) to set output pitch control device %d interface %u endpoint 0x%x to %u\n",
+			printk(KERN_ERR PFX "failure (error %d) to set output pitch control device %d interface %u endpoint 0x%x to %u\n",
 			       ret, dev->devnum, u->interface, ep, d->srate);
 			return -1;
 		}
@@ -1574,21 +1586,23 @@ static int set_format_in(struct usb_audi
 		data[2] = d->srate >> 16;
 		if ((ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), SET_CUR, USB_TYPE_CLASS|USB_RECIP_ENDPOINT|USB_DIR_OUT, 
 					   SAMPLING_FREQ_CONTROL << 8, ep, data, 3, 1000)) < 0) {
-			printk(KERN_ERR "usbaudio: failure (error %d) to set input sampling frequency device %d interface %u endpoint 0x%x to %u\n",
-			       ret, dev->devnum, u->interface, ep, d->srate);
+			printk(KERN_ERR PFX "failure (error %d) to set input sampling frequency "
+				"device %d interface %u endpoint 0x%x to %u\n",
+				ret, dev->devnum, u->interface, ep, d->srate);
 			return -1;
 		}
 		if ((ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), GET_CUR, USB_TYPE_CLASS|USB_RECIP_ENDPOINT|USB_DIR_IN,
 					   SAMPLING_FREQ_CONTROL << 8, ep, data, 3, 1000)) < 0) {
-			printk(KERN_ERR "usbaudio: failure (error %d) to get input sampling frequency device %d interface %u endpoint 0x%x\n",
+			printk(KERN_ERR PFX "failure (error %d) to get input sampling frequency device %d interface %u endpoint 0x%x\n",
 			       ret, dev->devnum, u->interface, ep);
 			return -1;
 		}
-		dprintk((KERN_DEBUG "usbaudio: set_format_in: device %d interface %d altsetting %d srate req: %u real %u\n",
-		        dev->devnum, u->interface, fmt->altsetting, d->srate, data[0] | (data[1] << 8) | (data[2] << 16)));
+		DPRINTK("device %d interface %d altsetting %d srate req: %u real %u\n",
+			dev->devnum, u->interface, fmt->altsetting, d->srate,
+			data[0] | (data[1] << 8) | (data[2] << 16)));
 		d->srate = data[0] | (data[1] << 8) | (data[2] << 16);
 	}
-	dprintk((KERN_DEBUG "usbaudio: set_format_in: USB format 0x%x, DMA format 0x%x srate %u\n", u->format, d->format, d->srate));
+	DPRINTK("USB format 0x%x, DMA format 0x%x srate %u\n", u->format, d->format, d->srate);
 	return 0;
 }
 
@@ -1610,7 +1624,7 @@ static int set_format_out(struct usb_aud
 
 	fmtnr = find_format(as->fmtout, as->numfmtout, d->format, d->srate);
 	if (fmtnr < 0) {
-		printk(KERN_ERR "usbaudio: set_format_out(): failed to find desired format/speed combination.\n");
+		printk(KERN_ERR PFX "%s(): failed to find desired format/speed combination\n", __FORMAT__);
 		return -1;
 	}
 
@@ -1621,9 +1635,9 @@ static int set_format_out(struct usb_aud
 	u->syncpipe = u->syncinterval = 0;
 	if ((alts->endpoint[0].desc.bmAttributes & 0x0c) == 0x04) {
 #if 0
-		printk(KERN_DEBUG "bNumEndpoints 0x%02x endpoint[1].bmAttributes 0x%02x\n"
-		       KERN_DEBUG "endpoint[1].bSynchAddress 0x%02x endpoint[1].bEndpointAddress 0x%02x\n"
-		       KERN_DEBUG "endpoint[0].bSynchAddress 0x%02x\n", alts->bNumEndpoints,
+		printk(KERN_DEBUG PFX "bNumEndpoints 0x%02x endpoint[1].bmAttributes 0x%02x\n"
+		       KERN_DEBUG PFX "endpoint[1].bSynchAddress 0x%02x endpoint[1].bEndpointAddress 0x%02x\n"
+		       KERN_DEBUG PFX "endpoint[0].bSynchAddress 0x%02x\n", alts->bNumEndpoints,
 		       alts->endpoint[1].bmAttributes, alts->endpoint[1].bSynchAddress,
 		       alts->endpoint[1].bEndpointAddress, alts->endpoint[0].bSynchAddress);
 #endif
@@ -1631,7 +1645,7 @@ static int set_format_out(struct usb_aud
 		    alts->endpoint[1].desc.bmAttributes != 0x01 ||
 		    alts->endpoint[1].desc.bSynchAddress != 0 ||
 		    alts->endpoint[1].desc.bEndpointAddress != (alts->endpoint[0].desc.bSynchAddress | 0x80)) {
-			printk(KERN_WARNING "usbaudio: device %d interface %d altsetting %d claims asynch out "
+			printk(KERN_WARNING PFX "device %d interface %d altsetting %d claims asynch out "
 			       "but has invalid synch pipe; treating as adaptive out\n",
 			       dev->devnum, u->interface, fmt->altsetting);
 		} else {
@@ -1643,11 +1657,10 @@ static int set_format_out(struct usb_aud
 		d->srate = fmt->sratelo;
 	if (d->srate > fmt->sratehi)
 		d->srate = fmt->sratehi;
-	dprintk((KERN_DEBUG "usbaudio: set_format_out: usb_set_interface %u %u\n",
-			u->interface, fmt->altsetting));
+	DPRINTK("usb_set_interface %u %u\n", u->interface, fmt->altsetting);
 	if (usb_set_interface(dev, u->interface, fmt->altsetting) < 0) {
-		printk(KERN_WARNING "usbaudio: usb_set_interface failed, device %d interface %d altsetting %d\n",
-		       dev->devnum, u->interface, fmt->altsetting);
+		printk(KERN_WARNING PFX "usb_set_interface failed, device %d interface %d altsetting %d\n",
+			dev->devnum, u->interface, fmt->altsetting);
 		return -1;
 	}
 	if (fmt->sratelo == fmt->sratehi)
@@ -1658,8 +1671,9 @@ static int set_format_out(struct usb_aud
 		data[0] = 1;
 		if ((ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), SET_CUR, USB_TYPE_CLASS|USB_RECIP_ENDPOINT|USB_DIR_OUT, 
 					   PITCH_CONTROL << 8, ep, data, 1, 1000)) < 0) {
-			printk(KERN_ERR "usbaudio: failure (error %d) to set output pitch control device %d interface %u endpoint 0x%x to %u\n",
-			       ret, dev->devnum, u->interface, ep, d->srate);
+			printk(KERN_ERR PFX "failure (error %d) to set output pitch control "
+				"device %d interface %u endpoint 0x%x to %u\n",
+				ret, dev->devnum, u->interface, ep, d->srate);
 			return -1;
 		}
 	}
@@ -1670,21 +1684,24 @@ static int set_format_out(struct usb_aud
 		data[2] = d->srate >> 16;
 		if ((ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), SET_CUR, USB_TYPE_CLASS|USB_RECIP_ENDPOINT|USB_DIR_OUT, 
 					   SAMPLING_FREQ_CONTROL << 8, ep, data, 3, 1000)) < 0) {
-			printk(KERN_ERR "usbaudio: failure (error %d) to set output sampling frequency device %d interface %u endpoint 0x%x to %u\n",
-			       ret, dev->devnum, u->interface, ep, d->srate);
+			printk(KERN_ERR PFX "failure (error %d) to set output sampling "
+				"frequency device %d interface %u endpoint 0x%x to %u\n",
+				ret, dev->devnum, u->interface, ep, d->srate);
 			return -1;
 		}
 		if ((ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), GET_CUR, USB_TYPE_CLASS|USB_RECIP_ENDPOINT|USB_DIR_IN,
 					   SAMPLING_FREQ_CONTROL << 8, ep, data, 3, 1000)) < 0) {
-			printk(KERN_ERR "usbaudio: failure (error %d) to get output sampling frequency device %d interface %u endpoint 0x%x\n",
-			       ret, dev->devnum, u->interface, ep);
+			printk(KERN_ERR PFX "failure (error %d) to get output sampling "
+				"frequency device %d interface %u endpoint 0x%x\n",
+				driver_pfx, ret, dev->devnum, u->interface, ep);
 			return -1;
 		}
-		dprintk((KERN_DEBUG "usbaudio: set_format_out: device %d interface %d altsetting %d srate req: %u real %u\n",
-		        dev->devnum, u->interface, fmt->altsetting, d->srate, data[0] | (data[1] << 8) | (data[2] << 16)));
+		DPRINTK("device %d interface %d altsetting %d srate req: %u real %u\n",
+			dev->devnum, u->interface, fmt->altsetting, d->srate,
+			data[0] | (data[1] << 8) | (data[2] << 16));
 		d->srate = data[0] | (data[1] << 8) | (data[2] << 16);
 	}
-	dprintk((KERN_DEBUG "usbaudio: set_format_out: USB format 0x%x, DMA format 0x%x srate %u\n", u->format, d->format, d->srate));
+	DPRINTK("USB format 0x%x, DMA format 0x%x srate %u\n", u->format, d->format, d->srate);
 	return 0;
 }
 
@@ -1803,7 +1820,7 @@ static int wrmixer(struct usb_mixerdev *
 	return 0;
 
  err:
-	printk(KERN_ERR "usbaudio: mixer request device %u if %u unit %u ch %u selector %u failed\n", 
+	printk(KERN_ERR PFX "mixer request device %u if %u unit %u ch %u selector %u failed\n", 
 		dev->devnum, ms->iface, ch->unitid, ch->chnum, ch->selector);
 	return -1;
 }
@@ -1822,7 +1839,7 @@ static int get_rec_src(struct usb_mixerd
 		if (usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), GET_CUR, USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 				    0, ms->iface | (ms->ch[i].slctunitid << 8), &buf, 1, 1000) < 0) {
 			err = -EIO;
-			printk(KERN_ERR "usbaudio: selector read request device %u if %u unit %u failed\n", 
+			printk(KERN_ERR PFX "selector read request device %u if %u unit %u failed\n", 
 			       dev->devnum, ms->iface, ms->ch[i].slctunitid & 0xff);
 			continue;
 		}
@@ -1853,7 +1870,7 @@ static int set_rec_src(struct usb_mixerd
 		if (usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), GET_CUR, USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
 				    0, ms->iface | (ms->ch[i].slctunitid << 8), &buf, 1, 1000) < 0) {
 			err = -EIO;
-			printk(KERN_ERR "usbaudio: selector read request device %u if %u unit %u failed\n", 
+			printk(KERN_ERR PFX "selector read request device %u if %u unit %u failed\n", 
 			       dev->devnum, ms->iface, ms->ch[i].slctunitid & 0xff);
 			continue;
 		}
@@ -1882,7 +1899,7 @@ static int set_rec_src(struct usb_mixerd
 			if (usb_control_msg(dev, usb_sndctrlpipe(dev, 0), SET_CUR, USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
 				    0, ms->iface | (ms->ch[j].slctunitid << 8), &buf, 1, 1000) < 0) {
 				err = -EIO;
-				printk(KERN_ERR "usbaudio: selector write request device %u if %u unit %u failed\n", 
+				printk(KERN_ERR PFX "selector write request device %u if %u unit %u failed\n", 
 				       dev->devnum, ms->iface, ms->ch[j].slctunitid & 0xff);
 				continue;
 			}
@@ -2125,7 +2142,7 @@ static int drain_out(struct usb_audiodev
 		tmo = 3 * HZ * count / as->usbout.dma.srate;
 		tmo >>= AFMT_BYTESSHIFT(as->usbout.dma.format);
 		if (!schedule_timeout(tmo + 1)) {
-			printk(KERN_DEBUG "usbaudio: dma timed out??\n");
+			printk(KERN_DEBUG PFX "dma timed out?\n");
 			break;
 		}
 	}
@@ -2224,9 +2241,9 @@ static ssize_t usb_audio_write(struct fi
 	add_wait_queue(&as->usbout.dma.wait, &wait);
 	while (count > 0) {
 #if 0
-		printk(KERN_DEBUG "usb_audio_write: count %u dma: count %u rdptr %u wrptr %u dmasize %u fragsize %u flags 0x%02x taskst 0x%lx\n",
-		       count, as->usbout.dma.count, as->usbout.dma.rdptr, as->usbout.dma.wrptr, as->usbout.dma.dmasize, as->usbout.dma.fragsize,
-		       as->usbout.flags, current->state);
+		printk(KERN_DEBUG PFX "%s(): count %u dma: count %u rdptr %u wrptr %u dmasize %u fragsize %u flags 0x%02x taskst 0x%lx\n",
+			__FUNCTION__, count, as->usbout.dma.count, as->usbout.dma.rdptr, as->usbout.dma.wrptr, as->usbout.dma.dmasize,
+			as->usbout.dma.fragsize, as->usbout.flags, current->state);
 #endif
 		spin_lock_irqsave(&as->lock, flags);
 		if (as->usbout.dma.count < 0) {
@@ -2367,7 +2384,7 @@ static int usb_audio_ioctl(struct inode 
 #if 0
 	if (arg)
 		get_user(val, (int *)arg);
-	printk(KERN_DEBUG "usbaudio: usb_audio_ioctl cmd=%x arg=%lx *arg=%d\n", cmd, arg, val)
+	printk(KERN_DEBUG PFX "%s(): cmd=%x arg=%lx *arg=%d\n", __FUNCTION__, cmd, arg, val)
 #endif
 	switch (cmd) {
 	case OSS_GETVERSION:
@@ -2626,7 +2643,7 @@ static int usb_audio_ioctl(struct inode 
 	case SOUND_PCM_READ_FILTER:
 		return -EINVAL;
 	}
-	dprintk((KERN_DEBUG "usbaudio: usb_audio_ioctl - no command found\n"));
+	DPRINTK("no command found\n");
 	return -ENOIOCTLCMD;
 }
 
@@ -2864,49 +2881,49 @@ static void usb_audio_parsestreaming(str
 				continue;
 			if (alts->desc.bNumEndpoints < 1) {
 				if (i != 0) {  /* altsetting 0 has no endpoints (Section B.3.4.1) */
-					printk(KERN_ERR "usbaudio: device %u interface %u altsetting %u does not have an endpoint\n", 
-					       dev->devnum, asifin, i);
+					printk(KERN_ERR PFX "device %u interface %u altsetting %u does not have an endpoint\n", 
+						dev->devnum, asifin, i);
 				}
 				continue;
 			}
 			if ((alts->endpoint[0].desc.bmAttributes & 0x03) != 0x01 ||
 			    !(alts->endpoint[0].desc.bEndpointAddress & 0x80)) {
-				printk(KERN_ERR "usbaudio: device %u interface %u altsetting %u first endpoint not isochronous in\n", 
-				       dev->devnum, asifin, i);
+				printk(KERN_ERR PFX "device %u interface %u altsetting %u first endpoint not isochronous in\n", 
+					dev->devnum, asifin, i);
 				continue;
 			}
 			fmt = find_csinterface_descriptor(buffer, buflen, NULL, AS_GENERAL, asifin, i);
 			if (!fmt) {
-				printk(KERN_ERR "usbaudio: device %u interface %u altsetting %u FORMAT_TYPE descriptor not found\n", 
-				       dev->devnum, asifin, i);
+				printk(KERN_ERR PFX "device %u interface %u altsetting %u FORMAT_TYPE descriptor not found\n", 
+					dev->devnum, asifin, i);
 				continue;
 			}
 			if (fmt[0] < 7 || fmt[6] != 0 || (fmt[5] != 1 && fmt[5] != 2)) {
-				printk(KERN_ERR "usbaudio: device %u interface %u altsetting %u format not supported\n", 
-				       dev->devnum, asifin, i);
+				printk(KERN_ERR PFX "device %u interface %u altsetting %u format not supported\n", 
+					dev->devnum, asifin, i);
 				continue;
 			}
 			format = (fmt[5] == 2) ? (AFMT_U16_LE | AFMT_U8) : (AFMT_S16_LE | AFMT_S8);
 			fmt = find_csinterface_descriptor(buffer, buflen, NULL, FORMAT_TYPE, asifin, i);
 			if (!fmt) {
-				printk(KERN_ERR "usbaudio: device %u interface %u altsetting %u FORMAT_TYPE descriptor not found\n", 
-				       dev->devnum, asifin, i);
+				printk(KERN_ERR PFX "device %u interface %u altsetting %u FORMAT_TYPE descriptor not found\n", 
+					dev->devnum, asifin, i);
 				continue;
 			}
 			if (fmt[0] < 8+3*(fmt[7] ? fmt[7] : 2) || fmt[3] != 1) {
-				printk(KERN_ERR "usbaudio: device %u interface %u altsetting %u FORMAT_TYPE descriptor not supported\n", 
-				       dev->devnum, asifin, i);
+				printk(KERN_ERR PFX "device %u interface %u altsetting %u FORMAT_TYPE descriptor not supported\n", 
+					dev->devnum, asifin, i);
 				continue;
 			}
 			if (fmt[4] < 1 || fmt[4] > 2 || fmt[5] < 1 || fmt[5] > 2) {
-				printk(KERN_ERR "usbaudio: device %u interface %u altsetting %u unsupported channels %u framesize %u\n", 
-				       dev->devnum, asifin, i, fmt[4], fmt[5]);
+				printk(KERN_ERR PFX "device %u interface %u altsetting %u unsupported channels %u framesize %u\n", 
+					dev->devnum, asifin, i, fmt[4], fmt[5]);
 				continue;
 			}
 			csep = find_descriptor(buffer, buflen, NULL, USB_DT_CS_ENDPOINT, asifin, i);
 			if (!csep || csep[0] < 7 || csep[2] != EP_GENERAL) {
-				printk(KERN_ERR "usbaudio: device %u interface %u altsetting %u no or invalid class specific endpoint descriptor\n", 
-				       dev->devnum, asifin, i);
+				printk(KERN_ERR PFX "device %u interface %u altsetting %u no or invalid class specific endpoint descriptor\n",
+					dev->devnum, asifin, i);
 				continue;
 			}
 			if (as->numfmtin >= MAXFORMATS)
@@ -2921,18 +2938,18 @@ static void usb_audio_parsestreaming(str
 			fp->format = format;
 			fp->altsetting = i;
 			fp->sratelo = fp->sratehi = fmt[8] | (fmt[9] << 8) | (fmt[10] << 16);
-			printk(KERN_INFO "usbaudio: valid input sample rate %u\n", fp->sratelo);
+			pr_info(PFX "valid input sample rate %u\n", fp->sratelo);
 			for (j = fmt[7] ? (fmt[7]-1) : 1; j > 0; j--) {
 				k = fmt[8+3*j] | (fmt[9+3*j] << 8) | (fmt[10+3*j] << 16);
-				printk(KERN_INFO "usbaudio: valid input sample rate %u\n", k);
+				pr_info(PFX "valid input sample rate %u\n", k);
 				if (k > fp->sratehi)
 					fp->sratehi = k;
 				if (k < fp->sratelo)
 					fp->sratelo = k;
 			}
 			fp->attributes = csep[3];
-			printk(KERN_INFO "usbaudio: device %u interface %u altsetting %u: format 0x%08x sratelo %u sratehi %u attributes 0x%02x\n", 
-			       dev->devnum, asifin, i, fp->format, fp->sratelo, fp->sratehi, fp->attributes);
+			pr_info(PFX "device %u interface %u altsetting %u: format 0x%08x sratelo %u sratehi %u attributes 0x%02x\n", 
+				dev->devnum, asifin, i, fp->format, fp->sratelo, fp->sratehi, fp->attributes);
 		}
 	}
 	/* search for output formats */
@@ -2947,26 +2964,26 @@ static void usb_audio_parsestreaming(str
 			if (alts->desc.bNumEndpoints < 1) {
 				/* altsetting 0 should never have iso EPs */
 				if (i != 0)
-				printk(KERN_ERR "usbaudio: device %u interface %u altsetting %u does not have an endpoint\n", 
-				       dev->devnum, asifout, i);
+				printk(KERN_ERR PFX "device %u interface %u altsetting %u does not have an endpoint\n", 
+					dev->devnum, asifout, i);
 				continue;
 			}
 			if ((alts->endpoint[0].desc.bmAttributes & 0x03) != 0x01 ||
 			    (alts->endpoint[0].desc.bEndpointAddress & 0x80)) {
-				printk(KERN_ERR "usbaudio: device %u interface %u altsetting %u first endpoint not isochronous out\n", 
-				       dev->devnum, asifout, i);
+				printk(KERN_ERR PFX "device %u interface %u altsetting %u first endpoint not isochronous out\n", 
+					dev->devnum, asifout, i);
 				continue;
 			}
 			/* See USB audio formats manual, section 2 */
 			fmt = find_csinterface_descriptor(buffer, buflen, NULL, AS_GENERAL, asifout, i);
 			if (!fmt) {
-				printk(KERN_ERR "usbaudio: device %u interface %u altsetting %u FORMAT_TYPE descriptor not found\n", 
-				       dev->devnum, asifout, i);
+				printk(KERN_ERR PFX "device %u interface %u altsetting %u FORMAT_TYPE descriptor not found\n", 
+					dev->devnum, asifout, i);
 				continue;
 			}
 			if (fmt[0] < 7 || fmt[6] != 0 || (fmt[5] != 1 && fmt[5] != 2)) {
-				printk(KERN_ERR "usbaudio: device %u interface %u altsetting %u format not supported\n", 
-				       dev->devnum, asifout, i);
+				printk(KERN_ERR PFX "device %u interface %u altsetting %u format not supported\n", 
+					dev->devnum, asifout, i);
 				continue;
 			}
 			format = (fmt[5] == 2) ? (AFMT_U16_LE | AFMT_U8) : (AFMT_S16_LE | AFMT_S8);
@@ -2976,23 +2993,23 @@ static void usb_audio_parsestreaming(str
 				format = (AFMT_S16_LE | AFMT_S8);
 			fmt = find_csinterface_descriptor(buffer, buflen, NULL, FORMAT_TYPE, asifout, i);
 			if (!fmt) {
-				printk(KERN_ERR "usbaudio: device %u interface %u altsetting %u FORMAT_TYPE descriptor not found\n", 
-				       dev->devnum, asifout, i);
+				printk(KERN_ERR PFX "device %u interface %u altsetting %u FORMAT_TYPE descriptor not found\n", 
+					dev->devnum, asifout, i);
 				continue;
 			}
 			if (fmt[0] < 8+3*(fmt[7] ? fmt[7] : 2) || fmt[3] != 1) {
-				printk(KERN_ERR "usbaudio: device %u interface %u altsetting %u FORMAT_TYPE descriptor not supported\n", 
-				       dev->devnum, asifout, i);
+				printk(KERN_ERR PFX "device %u interface %u altsetting %u FORMAT_TYPE descriptor not supported\n", 
+					dev->devnum, asifout, i);
 				continue;
 			}
 			if (fmt[4] < 1 || fmt[4] > 2 || fmt[5] < 1 || fmt[5] > 2) {
-				printk(KERN_ERR "usbaudio: device %u interface %u altsetting %u unsupported channels %u framesize %u\n", 
+				printk(KERN_ERR PFX "device %u interface %u altsetting %u unsupported channels %u framesize %u\n", 
 				       dev->devnum, asifout, i, fmt[4], fmt[5]);
 				continue;
 			}
 			csep = find_descriptor(buffer, buflen, NULL, USB_DT_CS_ENDPOINT, asifout, i);
 			if (!csep || csep[0] < 7 || csep[2] != EP_GENERAL) {
-				printk(KERN_ERR "usbaudio: device %u interface %u altsetting %u no or invalid class specific endpoint descriptor\n", 
+				printk(KERN_ERR PFX "device %u interface %u altsetting %u no or invalid class specific endpoint descriptor\n", 
 				       dev->devnum, asifout, i);
 				continue;
 			}
@@ -3008,17 +3025,17 @@ static void usb_audio_parsestreaming(str
 			fp->format = format;
 			fp->altsetting = i;
 			fp->sratelo = fp->sratehi = fmt[8] | (fmt[9] << 8) | (fmt[10] << 16);
-			printk(KERN_INFO "usbaudio: valid output sample rate %u\n", fp->sratelo);
+			pr_info(PFX "valid output sample rate %u\n", fp->sratelo);
 			for (j = fmt[7] ? (fmt[7]-1) : 1; j > 0; j--) {
 				k = fmt[8+3*j] | (fmt[9+3*j] << 8) | (fmt[10+3*j] << 16);
-				printk(KERN_INFO "usbaudio: valid output sample rate %u\n", k);
+				pr_info(PFX "valid output sample rate %u\n", k);
 				if (k > fp->sratehi)
 					fp->sratehi = k;
 				if (k < fp->sratelo)
 					fp->sratelo = k;
 			}
 			fp->attributes = csep[3];
-			printk(KERN_INFO "usbaudio: device %u interface %u altsetting %u: format 0x%08x sratelo %u sratehi %u attributes 0x%02x\n", 
+			pr_info(PFX "device %u interface %u altsetting %u: format 0x%08x sratelo %u sratehi %u attributes 0x%02x\n", 
 			       dev->devnum, asifout, i, fp->format, fp->sratelo, fp->sratehi, fp->attributes);
 		}
 	}
@@ -3035,7 +3052,7 @@ static void usb_audio_parsestreaming(str
 		return;
 	}
 	if ((as->dev_audio = register_sound_dsp(&usb_audio_fops, -1)) < 0) {
-		printk(KERN_ERR "usbaudio: cannot register dsp\n");
+		printk(KERN_ERR PFX "cannot register dsp\n");
 		usb_free_urb(as->usbin.durb[0].urb);
 		usb_free_urb(as->usbin.durb[1].urb);
 		usb_free_urb(as->usbin.surb[0].urb);
@@ -3047,7 +3064,7 @@ static void usb_audio_parsestreaming(str
 		kfree(as);
 		return;
 	}
-	printk(KERN_INFO "usbaudio: registered dsp 14,%d\n", as->dev_audio);
+	pr_info(PFX "registered dsp 14,%d\n", as->dev_audio);
 	/* everything successful */
 	list_add_tail(&as->list, &s->audiolist);
 }
@@ -3072,11 +3089,11 @@ static struct mixerchannel *getmixchanne
 	struct mixerchannel *c;
 
 	if (nr >= SOUND_MIXER_NRDEVICES) {
-		printk(KERN_ERR "usbaudio: invalid OSS mixer channel %u\n", nr);
+		printk(KERN_ERR PFX "invalid OSS mixer channel %u\n", nr);
 		return NULL;
 	}
 	if (!(state->mixchmask & (1 << nr))) {
-		printk(KERN_WARNING "usbaudio: OSS mixer channel %u already in use\n", nr);
+		printk(KERN_WARNING PFX "OSS mixer channel %u already in use\n", nr);
 		return NULL;
 	}
 	c = &state->mixch[state->nrmixch++];
@@ -3128,7 +3145,7 @@ static void prepmixch(struct consmixstat
 		return;
 	buf = kmalloc(sizeof(*buf) * 2, GFP_KERNEL);
 	if (!buf) {
-		printk(KERN_ERR "prepmixch: out of memory\n") ;
+		printk(KERN_ERR PFX "%s(): out of memory\n", __FUNCTION__);
 		return;
 	}
 
@@ -3248,7 +3265,7 @@ static void prepmixch(struct consmixstat
 	kfree(buf);
 	return;
  err:
-	printk(KERN_ERR "usbaudio: mixer request device %u if %u unit %u ch %u selector %u failed\n", 
+	printk(KERN_ERR PFX "mixer request device %u if %u unit %u ch %u selector %u failed\n", 
 	       dev->devnum, state->ctrlif, ch->unitid, ch->chnum, ch->selector);
 	if (state->nrmixch)
 		state->nrmixch--;
@@ -3285,11 +3302,11 @@ static void usb_audio_mixerunit(struct c
 	unsigned int i;
 
 	if (!mixer[4]) {
-		printk(KERN_ERR "usbaudio: unit %u invalid MIXER_UNIT descriptor\n", mixer[3]);
+		printk(KERN_ERR PFX "unit %u invalid MIXER_UNIT descriptor\n", mixer[3]);
 		return;
 	}
 	if (mixer[4] > SOUND_MIXER_NRDEVICES) {
-		printk(KERN_ERR "usbaudio: mixer unit %u: too many input pins\n", mixer[3]);
+		printk(KERN_ERR PFX "mixer unit %u: too many input pins\n", mixer[3]);
 		return;
 	}
 	chidx[0] = 0;
@@ -3303,7 +3320,7 @@ static void usb_audio_mixerunit(struct c
 	bmapsize = (nroutch * chidx[mixer[4]] + 7) >> 3;
 	bmap += bmapsize - 1;
 	if (mixer[0] < 10+mixer[4]+bmapsize) {
-		printk(KERN_ERR "usbaudio: unit %u invalid MIXER_UNIT descriptor (bitmap too small)\n", mixer[3]);
+		printk(KERN_ERR PFX "unit %u invalid MIXER_UNIT descriptor (bitmap too small)\n", mixer[3]);
 		return;
 	}
 	for (i = 0; i < mixer[4]; i++) {
@@ -3353,7 +3370,7 @@ static void usb_audio_selectorunit(struc
 	struct mixerchannel *mch;
 
 	if (!selector[4]) {
-		printk(KERN_ERR "usbaudio: unit %u invalid SELECTOR_UNIT descriptor\n", selector[3]);
+		printk(KERN_ERR PFX "unit %u invalid SELECTOR_UNIT descriptor\n", selector[3]);
 		return;
 	}
 	mixch = state->nrmixch;
@@ -3364,14 +3381,14 @@ static void usb_audio_selectorunit(struc
 	} else if ((mch = slctsrc_findunit(state, selector[5]))) {
 		mch->slctunitid = selector[3] | (1 << 8);
 	} else {
-		printk(KERN_INFO "usbaudio: selector unit %u: ignoring channel 1\n", selector[3]);
+		pr_info(PFX "selector unit %u: ignoring channel 1\n", selector[3]);
 	}
 	chnum = state->nrchannels;
 	for (i = 1; i < selector[4]; i++) {
 		mixch = state->nrmixch;
 		usb_audio_recurseunit(state, selector[5+i]);
 		if (chnum != state->nrchannels) {
-			printk(KERN_ERR "usbaudio: selector unit %u: input pins with varying channel numbers\n", selector[3]);
+			printk(KERN_ERR PFX "selector unit %u: input pins with varying channel numbers\n", selector[3]);
 			state->termtype = 0;
 			state->chconfig = 0;
 			state->nrchannels = 0;
@@ -3383,7 +3400,7 @@ static void usb_audio_selectorunit(struc
 		} else if ((mch = slctsrc_findunit(state, selector[5+i]))) {
 			mch->slctunitid = selector[3] | ((i + 1) << 8);
 		} else {
-			printk(KERN_INFO "usbaudio: selector unit %u: ignoring channel %u\n", selector[3], i+1);
+			pr_info(PFX "selector unit %u: ignoring channel %u\n", selector[3], i+1);
 		}
 	}
 	state->termtype = 0;
@@ -3418,29 +3435,32 @@ static void usb_audio_featureunit(struct
 	usb_audio_recurseunit(state, ftr[4]);
 
 	if (ftr[5] == 0 ) {
-		printk(KERN_ERR "usbaudio: wrong controls size in feature unit %u\n",ftr[3]);
+		printk(KERN_ERR PFX "wrong controls size in feature unit %u\n",ftr[3]);
 		return;
 	}
 
 	if (state->nrchannels == 0) {
-		printk(KERN_ERR "usbaudio: feature unit %u source has no channels\n", ftr[3]);
+		printk(KERN_ERR PFX "feature unit %u source has no channels\n", ftr[3]);
 		return;
 	}
 	if (state->nrchannels > 2)
-		printk(KERN_WARNING "usbaudio: feature unit %u: OSS mixer interface does not support more than 2 channels\n", ftr[3]);
+		printk(KERN_WARNING PFX "feature unit %u: OSS mixer interface does not support more than 2 channels\n", ftr[3]);
 
 	nr_logical_channels=(ftr[0]-7)/ftr[5]-1;
 
 	if (nr_logical_channels != state->nrchannels) {
-		printk(KERN_WARNING "usbaudio: warning: found %d of %d logical channels.\n", state->nrchannels,nr_logical_channels);
+		printk(KERN_WARNING PFX "warning: found %d of %d logical channels\n", state->nrchannels,nr_logical_channels);
 
 		if (state->nrchannels == 1 && nr_logical_channels==0) {
-			printk(KERN_INFO "usbaudio: assuming the channel found is the master channel (got a Philips camera?). Should be fine.\n");
+			pr_info(PFX "assuming the channel found is the master channel "
+				"(got a Philips camera?) - should be fine\n");
 		} else if (state->nrchannels == 1 && nr_logical_channels==2) {
-			printk(KERN_INFO "usbaudio: assuming that a stereo channel connected directly to a mixer is missing in search (got Labtec headset?). Should be fine.\n");
+			pr_info(PFX "assuming that a stereo channel connected directly "
+				"to a mixer is missing in search (got Labtec headset?) "
+				"- should be fine\n");
 			state->nrchannels=nr_logical_channels;
 		} else {
-			printk(KERN_WARNING "usbaudio: no idea what's going on..., contact linux-usb-devel@lists.sourceforge.net\n");
+			printk(KERN_WARNING PFX "no idea what's going on..., contact linux-usb-devel@lists.sourceforge.net\n");
 		}
 	}
 
@@ -3519,11 +3539,11 @@ static void usb_audio_featureunit(struct
 	/* if there are mute controls, unmute them */
 	/* does not seem to be necessary, and the Dallas chip does not seem to support the "all" channel (255) */
 	if ((chftr & 1) || (mchftr & 1)) {
-		printk(KERN_DEBUG "usbaudio: unmuting feature unit %u interface %u\n", ftr[3], state->ctrlif);
+		printk(KERN_DEBUG PFX "unmuting feature unit %u interface %u\n", ftr[3], state->ctrlif);
 		data[0] = 0;
 		if (usb_control_msg(dev, usb_sndctrlpipe(dev, 0), SET_CUR, USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
 				    (MUTE_CONTROL << 8) | 0xff, state->ctrlif | (ftr[3] << 8), data, 1, 1000) < 0)
-			printk(KERN_WARNING "usbaudio: failure to unmute feature unit %u interface %u\n", ftr[3], state->ctrlif);
+			printk(KERN_WARNING PFX "failure to unmute feature unit %u interface %u\n", ftr[3], state->ctrlif);
  	}
 #endif
 }
@@ -3534,12 +3554,12 @@ static void usb_audio_recurseunit(struct
 	unsigned int i, j;
 
 	if (test_and_set_bit(unitid, state->unitbitmap)) {
-		printk(KERN_INFO "usbaudio: mixer path revisits unit %d\n", unitid);
+		pr_info(PFX "mixer path revisits unit %d\n", unitid);
 		return;
 	}
 	p1 = find_audiocontrol_unit(state->buffer, state->buflen, NULL, unitid, state->ctrlif);
 	if (!p1) {
-		printk(KERN_ERR "usbaudio: unit %d not found!\n", unitid);
+		printk(KERN_ERR PFX "unit %d not found!\n", unitid);
 		return;
 	}
 	state->nrchannels = 0;
@@ -3548,7 +3568,7 @@ static void usb_audio_recurseunit(struct
 	switch (p1[2]) {
 	case INPUT_TERMINAL:
 		if (p1[0] < 12) {
-			printk(KERN_ERR "usbaudio: unit %u: invalid INPUT_TERMINAL descriptor\n", unitid);
+			printk(KERN_ERR PFX "unit %u: invalid INPUT_TERMINAL descriptor\n", unitid);
 			return;
 		}
 		state->nrchannels = p1[7];
@@ -3558,7 +3578,7 @@ static void usb_audio_recurseunit(struct
 
 	case MIXER_UNIT:
 		if (p1[0] < 10 || p1[0] < 10+p1[4]) {
-			printk(KERN_ERR "usbaudio: unit %u: invalid MIXER_UNIT descriptor\n", unitid);
+			printk(KERN_ERR PFX "unit %u: invalid MIXER_UNIT descriptor\n", unitid);
 			return;
 		}
 		usb_audio_mixerunit(state, p1);
@@ -3566,7 +3586,7 @@ static void usb_audio_recurseunit(struct
 
 	case SELECTOR_UNIT:
 		if (p1[0] < 6 || p1[0] < 6+p1[4]) {
-			printk(KERN_ERR "usbaudio: unit %u: invalid SELECTOR_UNIT descriptor\n", unitid);
+			printk(KERN_ERR PFX "unit %u: invalid SELECTOR_UNIT descriptor\n", unitid);
 			return;
 		}
 		usb_audio_selectorunit(state, p1);
@@ -3574,7 +3594,7 @@ static void usb_audio_recurseunit(struct
 
 	case FEATURE_UNIT: /* See USB Audio Class Spec 4.3.2.5 */
 		if (p1[0] < 7 || p1[0] < 7+p1[5]) {
-			printk(KERN_ERR "usbaudio: unit %u: invalid FEATURE_UNIT descriptor\n", unitid);
+			printk(KERN_ERR PFX "unit %u: invalid FEATURE_UNIT descriptor\n", unitid);
 			return;
 		}
 		usb_audio_featureunit(state, p1);
@@ -3582,7 +3602,7 @@ static void usb_audio_recurseunit(struct
 
 	case PROCESSING_UNIT:
 		if (p1[0] < 13 || p1[0] < 13+p1[6] || p1[0] < 13+p1[6]+p1[11+p1[6]]) {
-			printk(KERN_ERR "usbaudio: unit %u: invalid PROCESSING_UNIT descriptor\n", unitid);
+			printk(KERN_ERR PFX "unit %u: invalid PROCESSING_UNIT descriptor\n", unitid);
 			return;
 		}
 		usb_audio_processingunit(state, p1);
@@ -3590,7 +3610,7 @@ static void usb_audio_recurseunit(struct
 
 	case EXTENSION_UNIT:
 		if (p1[0] < 13 || p1[0] < 13+p1[6] || p1[0] < 13+p1[6]+p1[11+p1[6]]) {
-			printk(KERN_ERR "usbaudio: unit %u: invalid EXTENSION_UNIT descriptor\n", unitid);
+			printk(KERN_ERR PFX "unit %u: invalid EXTENSION_UNIT descriptor\n", unitid);
 			return;
 		}
 		for (j = i = 0; i < p1[6]; i++) {
@@ -3606,12 +3626,13 @@ static void usb_audio_recurseunit(struct
 		return;
 
 	default:
-		printk(KERN_ERR "usbaudio: unit %u: unexpected type 0x%02x\n", unitid, p1[2]);
+		printk(KERN_ERR PFX "unit %u: unexpected type 0x%02x\n", unitid, p1[2]);
 		return;
 	}
 }
 
-static void usb_audio_constructmixer(struct usb_audio_state *s, unsigned char *buffer, unsigned int buflen, unsigned int ctrlif, unsigned char *oterm)
+static void usb_audio_constructmixer(struct usb_audio_state *s, unsigned char *buffer,
+			unsigned int buflen, unsigned int ctrlif, unsigned char *oterm)
 {
 	struct usb_mixerdev *ms;
 	struct consmixstate state;
@@ -3624,11 +3645,11 @@ static void usb_audio_constructmixer(str
 	state.buflen = buflen;
 	state.ctrlif = ctrlif;
 	set_bit(oterm[3], state.unitbitmap);  /* mark terminal ID as visited */
-	printk(KERN_DEBUG "usbaudio: constructing mixer for Terminal %u type 0x%04x\n",
+	printk(KERN_DEBUG PFX "constructing mixer for Terminal %u type 0x%04x\n",
 	       oterm[3], oterm[4] | (oterm[5] << 8));
 	usb_audio_recurseunit(&state, oterm[7]);
 	if (!state.nrmixch) {
-		printk(KERN_INFO "usbaudio: no mixer controls found for Terminal %u\n", oterm[3]);
+		pr_info(PFX "no mixer controls found for Terminal %u\n", oterm[3]);
 		return;
 	}
 	if (!(ms = kmalloc(sizeof(struct usb_mixerdev)+state.nrmixch*sizeof(struct mixerchannel), GFP_KERNEL)))
@@ -3639,11 +3660,11 @@ static void usb_audio_constructmixer(str
 	ms->iface = ctrlif;
 	ms->numch = state.nrmixch;
 	if ((ms->dev_mixer = register_sound_mixer(&usb_mixer_fops, -1)) < 0) {
-		printk(KERN_ERR "usbaudio: cannot register mixer\n");
+		printk(KERN_ERR PFX "cannot register mixer\n");
 		kfree(ms);
 		return;
 	}
-	printk(KERN_INFO "usbaudio: registered mixer 14,%d\n", ms->dev_mixer);
+	pr_info(PFX "registered mixer 14,%d\n", ms->dev_mixer);
 	list_add_tail(&ms->list, &s->mixerlist);
 }
 
@@ -3669,48 +3690,48 @@ static struct usb_audio_state *usb_audio
 
 	/* find audiocontrol interface */
 	if (!(p1 = find_csinterface_descriptor(buffer, buflen, NULL, HEADER, ctrlif, -1))) {
-		printk(KERN_ERR "usbaudio: device %d audiocontrol interface %u no HEADER found\n",
+		printk(KERN_ERR PFX "device %d audiocontrol interface %u no HEADER found\n",
 		       dev->devnum, ctrlif);
 		goto ret;
 	}
 	if (p1[0] < 8 + p1[7]) {
-		printk(KERN_ERR "usbaudio: device %d audiocontrol interface %u HEADER error\n",
+		printk(KERN_ERR PFX "device %d audiocontrol interface %u HEADER error\n",
 		       dev->devnum, ctrlif);
 		goto ret;
 	}
 	if (!p1[7])
-		printk(KERN_INFO "usbaudio: device %d audiocontrol interface %u has no AudioStreaming and MidiStreaming interfaces\n",
+		pr_info(PFX "device %d audiocontrol interface %u has no AudioStreaming and MidiStreaming interfaces\n",
 		       dev->devnum, ctrlif);
 	for (i = 0; i < p1[7]; i++) {
 		j = p1[8+i];
 		iface = usb_ifnum_to_if(dev, j);
 		if (!iface) {
-			printk(KERN_ERR "usbaudio: device %d audiocontrol interface %u interface %u does not exist\n",
+			printk(KERN_ERR PFX "device %d audiocontrol interface %u interface %u does not exist\n",
 			       dev->devnum, ctrlif, j);
 			continue;
 		}
 		if (iface->num_altsetting == 1) {
-			printk(KERN_ERR "usbaudio: device %d audiocontrol interface %u has only 1 altsetting.\n", dev->devnum, ctrlif);
+			printk(KERN_ERR PFX "device %d audiocontrol interface %u has only 1 altsetting.\n", dev->devnum, ctrlif);
 			continue;
 		}
 		alt = usb_altnum_to_altsetting(iface, 0);
 		if (!alt) {
-			printk(KERN_ERR "usbaudio: device %d audiocontrol interface %u interface %u has no altsetting 0\n",
+			printk(KERN_ERR PFX "device %d audiocontrol interface %u interface %u has no altsetting 0\n",
 			       dev->devnum, ctrlif, j);
 			continue;
 		}
 		if (alt->desc.bInterfaceClass != USB_CLASS_AUDIO) {
-			printk(KERN_ERR "usbaudio: device %d audiocontrol interface %u interface %u is not an AudioClass interface\n",
+			printk(KERN_ERR PFX "device %d audiocontrol interface %u interface %u is not an AudioClass interface\n",
 			       dev->devnum, ctrlif, j);
 			continue;
 		}
 		if (alt->desc.bInterfaceSubClass == 3) {
-			printk(KERN_INFO "usbaudio: device %d audiocontrol interface %u interface %u MIDIStreaming not supported\n",
+			printk(KERN_INFO PFX "device %d audiocontrol interface %u interface %u MIDIStreaming not supported\n",
 			       dev->devnum, ctrlif, j);
 			continue;
 		}
 		if (alt->desc.bInterfaceSubClass != 2) {
-			printk(KERN_ERR "usbaudio: device %d audiocontrol interface %u interface %u invalid AudioClass subtype\n",
+			printk(KERN_ERR PFX "device %d audiocontrol interface %u interface %u invalid AudioClass subtype\n",
 			       dev->devnum, ctrlif, j);
 			continue;
 		}
@@ -3718,7 +3739,8 @@ static struct usb_audio_state *usb_audio
 			/* Check all endpoints; should they all have a bandwidth of 0 ? */
 			for (k = 0; k < alt->desc.bNumEndpoints; k++) {
 				if (le16_to_cpu(alt->endpoint[k].desc.wMaxPacketSize) > 0) {
-					printk(KERN_ERR "usbaudio: device %d audiocontrol interface %u endpoint %d does not have 0 bandwidth at alt[0]\n", dev->devnum, ctrlif, k);
+					printk(KERN_ERR PFX "device %d audiocontrol interface %u endpoint %d does not have "
+						"0 bandwidth at alt[0]\n", dev->devnum, ctrlif, k);
 					break;
 				}
 			}
@@ -3728,12 +3750,12 @@ static struct usb_audio_state *usb_audio
 
 		alt = usb_altnum_to_altsetting(iface, 1);
 		if (!alt) {
-			printk(KERN_ERR "usbaudio: device %d audiocontrol interface %u interface %u has no altsetting 1\n",
+			printk(KERN_ERR PFX "device %d audiocontrol interface %u interface %u has no altsetting 1\n",
 			       dev->devnum, ctrlif, j);
 			continue;
 		}
 		if (alt->desc.bNumEndpoints < 1) {
-			printk(KERN_ERR "usbaudio: device %d audiocontrol interface %u interface %u has no endpoint\n",
+			printk(KERN_ERR PFX "device %d audiocontrol interface %u interface %u has no endpoint\n",
 			       dev->devnum, ctrlif, j);
 			continue;
 		}
@@ -3751,7 +3773,7 @@ static struct usb_audio_state *usb_audio
 			}
 		}
 	}
-	printk(KERN_INFO "usbaudio: device %d audiocontrol interface %u has %u input and %u output AudioStreaming interfaces\n",
+	pr_info(PFX "device %d audiocontrol interface %u has %u input and %u output AudioStreaming interfaces\n",
 	       dev->devnum, ctrlif, numifin, numifout);
 	for (i = 0; i < numifin && i < numifout; i++)
 		usb_audio_parsestreaming(s, buffer, buflen, ifin[i], ifout[i]);
@@ -3776,7 +3798,7 @@ ret:
 	down(&open_sem);
 	list_add_tail(&s->audiodev, &audiodevs);
 	up(&open_sem);
-	printk(KERN_DEBUG "usb_audio_parsecontrol: usb_audio_state at %p\n", s);
+	printk(KERN_DEBUG PFX "%s(): usb_audio_state at %p\n", __FUNCTION__, s);
 	return s;
 }
 
@@ -3791,7 +3813,7 @@ static int usb_audio_probe(struct usb_in
 	unsigned int buflen;
 
 #if 0
-	printk(KERN_DEBUG "usbaudio: Probing if %i: IC %x, ISC %x\n", ifnum,
+	printk(KERN_DEBUG PFX "probing if %i: IC %x, ISC %x\n", ifnum,
 	       config->interface[ifnum].altsetting[0].desc.bInterfaceClass,
 	       config->interface[ifnum].altsetting[0].desc.bInterfaceSubClass);
 #endif
@@ -3824,11 +3846,11 @@ static void usb_audio_disconnect(struct 
 
 	/* we get called with -1 for every audiostreaming interface registered */
 	if (s == (struct usb_audio_state *)-1) {
-		dprintk((KERN_DEBUG "usbaudio: note, usb_audio_disconnect called with -1\n"));
+		DPRINTK("called with -1, returning\n");
 		return;
 	}
 	if (!s->usbdev) {
-		dprintk((KERN_DEBUG "usbaudio: error,  usb_audio_disconnect already called for %p!\n", s));
+		DPRINTK("already called for %p, returning\n", s);
 		return;
 	}
 	down(&open_sem);
@@ -3844,14 +3866,14 @@ static void usb_audio_disconnect(struct 
 		wake_up(&as->usbout.dma.wait);
 		if (as->dev_audio >= 0) {
 			unregister_sound_dsp(as->dev_audio);
-			printk(KERN_INFO "usbaudio: unregister dsp 14,%d\n", as->dev_audio);
+			pr_info(PFX "unregister dsp 14,%d\n", as->dev_audio);
 		}
 		as->dev_audio = -1;
 	}
 	list_for_each_entry(ms, &s->mixerlist, list) {
 		if (ms->dev_mixer >= 0) {
 			unregister_sound_mixer(ms->dev_mixer);
-			printk(KERN_INFO "usbaudio: unregister mixer 14,%d\n", ms->dev_mixer);
+			pr_info(PFX "unregister mixer 14,%d\n", ms->dev_mixer);
 		}
 		ms->dev_mixer = -1;
 	}
