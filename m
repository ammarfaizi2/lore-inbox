Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262947AbVDLVKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262947AbVDLVKJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 17:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbVDLVDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 17:03:19 -0400
Received: from mail.dif.dk ([193.138.115.101]:52894 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S263020AbVDLUzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 16:55:37 -0400
Date: Tue, 12 Apr 2005 22:58:13 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-usb-devel@lists.sourceforge.net
Subject: [PATCH] usb: kfree cleanup for drivers/usb/* - no need to check for
 NULL 
Message-ID: <Pine.LNX.4.62.0504122211070.2572@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of a bunch of redundant NULL pointer checks in drivers/usb/*, 
there's no need to check a pointer for NULL before calling kfree() on it.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 class/audio.c             |   48 +++++++++++++++-------------------------------
 class/bluetty.c           |    4 +--
 core/devices.c            |    7 +-----
 core/hub.c                |   16 +++++----------
 gadget/serial.c           |    5 +---
 host/ehci-mem.c           |    3 --
 host/uhci-hcd.c           |    7 +-----
 input/hid-core.c          |    3 --
 media/dabusb.c            |    3 --
 media/ov511.c             |   12 +++--------
 media/se401.c             |   15 +++++++-------
 media/usbvideo.c          |    6 +----
 media/w9968cf.c           |    6 +----
 misc/auerswald.c          |   26 +++++++++---------------
 net/zd1201.c              |    3 --
 serial/belkin_sa.c        |    3 --
 serial/cypress_m8.c       |    5 +---
 serial/empeg.c            |    6 +----
 serial/ftdi_sio.c         |   10 ++-------
 serial/io_edgeport.c      |   24 +++++++----------------
 serial/io_ti.c            |    5 +---
 serial/kl5kusb105.c       |    3 --
 serial/omninet.c          |    5 ----
 serial/pl2303.c           |    5 +---
 serial/ti_usb_3410_5052.c |    3 --
 storage/sddr55.c          |   24 +++++++----------------
 26 files changed, 91 insertions(+), 166 deletions(-)


diff -upr linux-2.6.12-rc2-mm3-orig/drivers/usb/class/audio.c linux-2.6.12-rc2-mm3/drivers/usb/class/audio.c
--- linux-2.6.12-rc2-mm3-orig/drivers/usb/class/audio.c	2005-04-05 21:21:39.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/usb/class/audio.c	2005-04-12 20:55:53.000000000 +0200
@@ -649,14 +649,10 @@ static void usbin_stop(struct usb_audiod
 		}
 	}
 	set_current_state(TASK_RUNNING);
-	if (u->durb[0].urb->transfer_buffer)
-		kfree(u->durb[0].urb->transfer_buffer);
-	if (u->durb[1].urb->transfer_buffer)
-		kfree(u->durb[1].urb->transfer_buffer);
-	if (u->surb[0].urb->transfer_buffer)
-		kfree(u->surb[0].urb->transfer_buffer);
-	if (u->surb[1].urb->transfer_buffer)
-		kfree(u->surb[1].urb->transfer_buffer);
+	kfree(u->durb[0].urb->transfer_buffer);
+	kfree(u->durb[1].urb->transfer_buffer);
+	kfree(u->surb[0].urb->transfer_buffer);
+	kfree(u->surb[1].urb->transfer_buffer);
 	u->durb[0].urb->transfer_buffer = u->durb[1].urb->transfer_buffer = 
 		u->surb[0].urb->transfer_buffer = u->surb[1].urb->transfer_buffer = NULL;
 }
@@ -1009,21 +1005,17 @@ static int usbin_start(struct usb_audiod
 		u->phase = 0;
 		maxsze = (u->freqmax + 0x3fff) >> (14 - AFMT_BYTESSHIFT(u->format));
 		bufsz = DESCFRAMES * maxsze;
-		if (u->durb[0].urb->transfer_buffer)
-			kfree(u->durb[0].urb->transfer_buffer);
+		kfree(u->durb[0].urb->transfer_buffer);
 		u->durb[0].urb->transfer_buffer = kmalloc(bufsz, GFP_KERNEL);
 		u->durb[0].urb->transfer_buffer_length = bufsz;
-		if (u->durb[1].urb->transfer_buffer)
-			kfree(u->durb[1].urb->transfer_buffer);
+		kfree(u->durb[1].urb->transfer_buffer);
 		u->durb[1].urb->transfer_buffer = kmalloc(bufsz, GFP_KERNEL);
 		u->durb[1].urb->transfer_buffer_length = bufsz;
 		if (u->syncpipe) {
-			if (u->surb[0].urb->transfer_buffer)
-				kfree(u->surb[0].urb->transfer_buffer);
+			kfree(u->surb[0].urb->transfer_buffer);
 			u->surb[0].urb->transfer_buffer = kmalloc(3*SYNCFRAMES, GFP_KERNEL);
 			u->surb[0].urb->transfer_buffer_length = 3*SYNCFRAMES;
-			if (u->surb[1].urb->transfer_buffer)
-				kfree(u->surb[1].urb->transfer_buffer);
+			kfree(u->surb[1].urb->transfer_buffer);
 			u->surb[1].urb->transfer_buffer = kmalloc(3*SYNCFRAMES, GFP_KERNEL);
 			u->surb[1].urb->transfer_buffer_length = 3*SYNCFRAMES;
 		}
@@ -1128,14 +1120,10 @@ static void usbout_stop(struct usb_audio
 		}
 	}
 	set_current_state(TASK_RUNNING);
-	if (u->durb[0].urb->transfer_buffer)
-		kfree(u->durb[0].urb->transfer_buffer);
-	if (u->durb[1].urb->transfer_buffer)
-		kfree(u->durb[1].urb->transfer_buffer);
-	if (u->surb[0].urb->transfer_buffer)
-		kfree(u->surb[0].urb->transfer_buffer);
-	if (u->surb[1].urb->transfer_buffer)
-		kfree(u->surb[1].urb->transfer_buffer);
+	kfree(u->durb[0].urb->transfer_buffer);
+	kfree(u->durb[1].urb->transfer_buffer);
+	kfree(u->surb[0].urb->transfer_buffer);
+	kfree(u->surb[1].urb->transfer_buffer);
 	u->durb[0].urb->transfer_buffer = u->durb[1].urb->transfer_buffer = 
 		u->surb[0].urb->transfer_buffer = u->surb[1].urb->transfer_buffer = NULL;
 }
@@ -1376,21 +1364,17 @@ static int usbout_start(struct usb_audio
 		u->phase = 0;
 		maxsze = (u->freqmax + 0x3fff) >> (14 - AFMT_BYTESSHIFT(u->format));
 		bufsz = DESCFRAMES * maxsze;
-		if (u->durb[0].urb->transfer_buffer)
-			kfree(u->durb[0].urb->transfer_buffer);
+		kfree(u->durb[0].urb->transfer_buffer);
 		u->durb[0].urb->transfer_buffer = kmalloc(bufsz, GFP_KERNEL);
 		u->durb[0].urb->transfer_buffer_length = bufsz;
-		if (u->durb[1].urb->transfer_buffer)
-			kfree(u->durb[1].urb->transfer_buffer);
+		kfree(u->durb[1].urb->transfer_buffer);
 		u->durb[1].urb->transfer_buffer = kmalloc(bufsz, GFP_KERNEL);
 		u->durb[1].urb->transfer_buffer_length = bufsz;
 		if (u->syncpipe) {
-			if (u->surb[0].urb->transfer_buffer)
-				kfree(u->surb[0].urb->transfer_buffer);
+			kfree(u->surb[0].urb->transfer_buffer);
 			u->surb[0].urb->transfer_buffer = kmalloc(3*SYNCFRAMES, GFP_KERNEL);
 			u->surb[0].urb->transfer_buffer_length = 3*SYNCFRAMES;
-			if (u->surb[1].urb->transfer_buffer)
-				kfree(u->surb[1].urb->transfer_buffer);
+			kfree(u->surb[1].urb->transfer_buffer);
 			u->surb[1].urb->transfer_buffer = kmalloc(3*SYNCFRAMES, GFP_KERNEL);
 			u->surb[1].urb->transfer_buffer_length = 3*SYNCFRAMES;
 		}
diff -upr linux-2.6.12-rc2-mm3-orig/drivers/usb/class/bluetty.c linux-2.6.12-rc2-mm3/drivers/usb/class/bluetty.c
--- linux-2.6.12-rc2-mm3-orig/drivers/usb/class/bluetty.c	2005-03-02 08:38:17.000000000 +0100
+++ linux-2.6.12-rc2-mm3/drivers/usb/class/bluetty.c	2005-04-12 20:56:14.000000000 +0200
@@ -309,7 +309,7 @@ static int bluetooth_ctrl_msg (struct us
 		}
 	}
 	if (urb->transfer_buffer_length < len) {
-		kfree (urb->transfer_buffer);
+		kfree(urb->transfer_buffer);
 		urb->transfer_buffer = kmalloc (len, GFP_KERNEL);
 		if (urb->transfer_buffer == NULL) {
 			err ("%s - out of memory", __FUNCTION__);
@@ -535,7 +535,7 @@ static int bluetooth_write (struct tty_s
 	}
 
 exit:
-	kfree (temp_buffer);
+	kfree(temp_buffer);
 
 	return retval;
 } 
diff -upr linux-2.6.12-rc2-mm3-orig/drivers/usb/core/devices.c linux-2.6.12-rc2-mm3/drivers/usb/core/devices.c
--- linux-2.6.12-rc2-mm3-orig/drivers/usb/core/devices.c	2005-04-11 21:20:49.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/usb/core/devices.c	2005-04-12 20:58:53.000000000 +0200
@@ -637,11 +637,8 @@ static int usb_device_open(struct inode 
 
 static int usb_device_release(struct inode *inode, struct file *file)
 {
-	if (file->private_data) {
-		kfree(file->private_data);
-		file->private_data = NULL;
-	}
-
+	kfree(file->private_data);
+	file->private_data = NULL;
         return 0;
 }
 
diff -upr linux-2.6.12-rc2-mm3-orig/drivers/usb/core/hub.c linux-2.6.12-rc2-mm3/drivers/usb/core/hub.c
--- linux-2.6.12-rc2-mm3-orig/drivers/usb/core/hub.c	2005-04-11 21:20:49.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/usb/core/hub.c	2005-04-12 21:00:53.000000000 +0200
@@ -381,7 +381,7 @@ static void hub_tt_kevent (void *arg)
 			dev_err (&hdev->dev,
 				"clear tt %d (%04x) error %d\n",
 				clear->tt, clear->devinfo, status);
-		kfree (clear);
+		kfree(clear);
 	}
 	spin_unlock_irqrestore (&hub->tt.lock, flags);
 }
@@ -728,15 +728,11 @@ static void hub_disconnect(struct usb_in
 	list_del_init(&hub->event_list);
 	spin_unlock_irq(&hub_event_lock);
 
-	if (hub->descriptor) {
-		kfree(hub->descriptor);
-		hub->descriptor = NULL;
-	}
+	kfree(hub->descriptor);
+	hub->descriptor = NULL;
 
-	if (hub->status) {
-		kfree(hub->status);
-		hub->status = NULL;
-	}
+	kfree(hub->status);
+	hub->status = NULL;
 
 	if (hub->buffer) {
 		usb_buffer_free(hdev, sizeof(*hub->buffer), hub->buffer,
@@ -2354,7 +2350,7 @@ check_highspeed (struct usb_hub *hub, st
 			schedule_work (&hub->leds);
 		}
 	}
-	kfree (qual);
+	kfree(qual);
 }
 
 static unsigned
diff -upr linux-2.6.12-rc2-mm3-orig/drivers/usb/gadget/serial.c linux-2.6.12-rc2-mm3/drivers/usb/gadget/serial.c
--- linux-2.6.12-rc2-mm3-orig/drivers/usb/gadget/serial.c	2005-04-05 21:21:39.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/usb/gadget/serial.c	2005-04-12 21:08:00.000000000 +0200
@@ -2312,9 +2312,8 @@ static struct gs_buf *gs_buf_alloc(unsig
  */
 void gs_buf_free(struct gs_buf *gb)
 {
-	if (gb != NULL) {
-		if (gb->buf_buf != NULL)
-			kfree(gb->buf_buf);
+	if (gb) {
+		kfree(gb->buf_buf);
 		kfree(gb);
 	}
 }
diff -upr linux-2.6.12-rc2-mm3-orig/drivers/usb/host/ehci-mem.c linux-2.6.12-rc2-mm3/drivers/usb/host/ehci-mem.c
--- linux-2.6.12-rc2-mm3-orig/drivers/usb/host/ehci-mem.c	2005-03-02 08:38:26.000000000 +0100
+++ linux-2.6.12-rc2-mm3/drivers/usb/host/ehci-mem.c	2005-04-12 21:08:36.000000000 +0200
@@ -156,8 +156,7 @@ static void ehci_mem_cleanup (struct ehc
 	ehci->periodic = NULL;
 
 	/* shadow periodic table */
-	if (ehci->pshadow)
-		kfree (ehci->pshadow);
+	kfree(ehci->pshadow);
 	ehci->pshadow = NULL;
 }
 
diff -upr linux-2.6.12-rc2-mm3-orig/drivers/usb/host/uhci-hcd.c linux-2.6.12-rc2-mm3/drivers/usb/host/uhci-hcd.c
--- linux-2.6.12-rc2-mm3-orig/drivers/usb/host/uhci-hcd.c	2005-04-11 21:20:49.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/usb/host/uhci-hcd.c	2005-04-12 21:10:35.000000000 +0200
@@ -890,8 +890,7 @@ up_failed:
 	debugfs_remove(uhci_debugfs_root);
 
 debug_failed:
-	if (errbuf)
-		kfree(errbuf);
+	kfree(errbuf);
 
 errbuf_failed:
 
@@ -906,9 +905,7 @@ static void __exit uhci_hcd_cleanup(void
 		warn("not all urb_priv's were freed!");
 
 	debugfs_remove(uhci_debugfs_root);
-
-	if (errbuf)
-		kfree(errbuf);
+	kfree(errbuf);
 }
 
 module_init(uhci_hcd_init);
diff -upr linux-2.6.12-rc2-mm3-orig/drivers/usb/input/hid-core.c linux-2.6.12-rc2-mm3/drivers/usb/input/hid-core.c
--- linux-2.6.12-rc2-mm3-orig/drivers/usb/input/hid-core.c	2005-04-11 21:20:49.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/usb/input/hid-core.c	2005-04-12 21:12:33.000000000 +0200
@@ -558,8 +558,7 @@ static void hid_free_device(struct hid_d
 		}
 	}
 
-	if (device->rdesc)
-		kfree(device->rdesc);
+	kfree(device->rdesc);
 	kfree(device);
 }
 
diff -upr linux-2.6.12-rc2-mm3-orig/drivers/usb/media/dabusb.c linux-2.6.12-rc2-mm3/drivers/usb/media/dabusb.c
--- linux-2.6.12-rc2-mm3-orig/drivers/usb/media/dabusb.c	2005-03-02 08:38:10.000000000 +0100
+++ linux-2.6.12-rc2-mm3/drivers/usb/media/dabusb.c	2005-04-12 21:17:22.000000000 +0200
@@ -138,8 +138,7 @@ static int dabusb_free_queue (struct lis
 #ifdef DEBUG 
 		dump_urb(b->purb);
 #endif
-		if (b->purb->transfer_buffer)
-			kfree (b->purb->transfer_buffer);
+		kfree(b->purb->transfer_buffer);
 		usb_free_urb(b->purb);
 		tmp = p->next;
 		list_del (p);
diff -upr linux-2.6.12-rc2-mm3-orig/drivers/usb/media/ov511.c linux-2.6.12-rc2-mm3/drivers/usb/media/ov511.c
--- linux-2.6.12-rc2-mm3-orig/drivers/usb/media/ov511.c	2005-04-05 21:21:40.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/usb/media/ov511.c	2005-04-12 21:18:36.000000000 +0200
@@ -3915,10 +3915,8 @@ ov51x_do_dealloc(struct usb_ov511 *ov)
 	ov->tempfbuf = NULL;
 
 	for (i = 0; i < OV511_NUMSBUF; i++) {
-		if (ov->sbuf[i].data) {
-			kfree(ov->sbuf[i].data);
-			ov->sbuf[i].data = NULL;
-		}
+		kfree(ov->sbuf[i].data);
+		ov->sbuf[i].data = NULL;
 	}
 
 	for (i = 0; i < OV511_NUMFRAMES; i++) {
@@ -5954,10 +5952,8 @@ error:
 		up(&ov->cbuf_lock);
 	}
 
-	if (ov) {
-		kfree(ov);
-		ov = NULL;
-	}
+	kfree(ov);
+	ov = NULL;
 
 error_out:
 	err("Camera initialization failed");
diff -upr linux-2.6.12-rc2-mm3-orig/drivers/usb/media/se401.c linux-2.6.12-rc2-mm3/drivers/usb/media/se401.c
--- linux-2.6.12-rc2-mm3-orig/drivers/usb/media/se401.c	2005-04-05 21:21:40.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/usb/media/se401.c	2005-04-12 21:22:01.000000000 +0200
@@ -868,13 +868,14 @@ static void usb_se401_remove_disconnecte
 
         se401->dev = NULL;
 
-	for (i=0; i<SE401_NUMSBUF; i++) if (se401->urb[i]) {
-		usb_kill_urb(se401->urb[i]);
-		usb_free_urb(se401->urb[i]);
-		se401->urb[i] = NULL;
-		kfree(se401->sbuf[i].data);
-	}
-	for (i=0; i<SE401_NUMSCRATCH; i++) if (se401->scratch[i].data) {
+	for (i=0; i<SE401_NUMSBUF; i++)
+		if (se401->urb[i]) {
+			usb_kill_urb(se401->urb[i]);
+			usb_free_urb(se401->urb[i]);
+			se401->urb[i] = NULL;
+			kfree(se401->sbuf[i].data);
+		}
+	for (i=0; i<SE401_NUMSCRATCH; i++) {
 		kfree(se401->scratch[i].data);
 	}
 	if (se401->inturb) {
diff -upr linux-2.6.12-rc2-mm3-orig/drivers/usb/media/usbvideo.c linux-2.6.12-rc2-mm3/drivers/usb/media/usbvideo.c
--- linux-2.6.12-rc2-mm3-orig/drivers/usb/media/usbvideo.c	2005-04-05 21:21:40.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/usb/media/usbvideo.c	2005-04-12 21:25:51.000000000 +0200
@@ -1169,10 +1169,8 @@ static int usbvideo_v4l_open(struct inod
 			}
 			RingQueue_Free(&uvd->dp);
 			for (i=0; i < USBVIDEO_NUMSBUF; i++) {
-				if (uvd->sbuf[i].data != NULL) {
-					kfree (uvd->sbuf[i].data);
-					uvd->sbuf[i].data = NULL;
-				}
+				kfree(uvd->sbuf[i].data);
+				uvd->sbuf[i].data = NULL;
 			}
 		}
 	}
diff -upr linux-2.6.12-rc2-mm3-orig/drivers/usb/media/w9968cf.c linux-2.6.12-rc2-mm3/drivers/usb/media/w9968cf.c
--- linux-2.6.12-rc2-mm3-orig/drivers/usb/media/w9968cf.c	2005-03-02 08:38:17.000000000 +0100
+++ linux-2.6.12-rc2-mm3/drivers/usb/media/w9968cf.c	2005-04-12 21:26:40.000000000 +0200
@@ -3624,10 +3624,8 @@ w9968cf_usb_probe(struct usb_interface* 
 	return 0;
 
 fail: /* Free unused memory */
-	if (cam->control_buffer)
-		kfree(cam->control_buffer);
-	if (cam->data_buffer)
-		kfree(cam->data_buffer);
+	kfree(cam->control_buffer);
+	kfree(cam->data_buffer);
 	if (cam->v4ldev)
 		video_device_release(cam->v4ldev);
 	up(&cam->dev_sem);
diff -upr linux-2.6.12-rc2-mm3-orig/drivers/usb/misc/auerswald.c linux-2.6.12-rc2-mm3/drivers/usb/misc/auerswald.c
--- linux-2.6.12-rc2-mm3-orig/drivers/usb/misc/auerswald.c	2005-04-05 21:21:40.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/usb/misc/auerswald.c	2005-04-12 21:32:12.000000000 +0200
@@ -705,16 +705,12 @@ static int auerchain_control_msg (pauerc
 /* free a single auerbuf */
 static void auerbuf_free (pauerbuf_t bp)
 {
-	if (bp->bufp) {
-		kfree (bp->bufp);
-	}
-	if (bp->dr) {
-		kfree (bp->dr);
-	}
+	kfree(bp->bufp);
+	kfree(bp->dr);
 	if (bp->urbp) {
-		usb_free_urb (bp->urbp);
+		usb_free_urb(bp->urbp);
 	}
-	kfree (bp);
+	kfree(bp);
 }
 
 /* free the buffers from an auerbuf list */
@@ -1093,14 +1089,12 @@ exit:
 */
 static void auerswald_int_free (pauerswald_t cp)
 {
-        if (cp->inturbp) {
-                usb_free_urb (cp->inturbp);
-                cp->inturbp = NULL;
-        }
-        if (cp->intbufp) {
-                kfree (cp->intbufp);
-                cp->intbufp = NULL;
-        }
+	if (cp->inturbp) {
+		usb_free_urb(cp->inturbp);
+		cp->inturbp = NULL;
+	}
+	kfree(cp->intbufp);
+	cp->intbufp = NULL;
 }
 
 /* This function is called to activate the interrupt
diff -upr linux-2.6.12-rc2-mm3-orig/drivers/usb/net/zd1201.c linux-2.6.12-rc2-mm3/drivers/usb/net/zd1201.c
--- linux-2.6.12-rc2-mm3-orig/drivers/usb/net/zd1201.c	2005-04-11 21:20:49.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/usb/net/zd1201.c	2005-04-12 21:36:54.000000000 +0200
@@ -106,8 +106,7 @@ int zd1201_fw_upload(struct usb_device *
 
 	err = 0;
 exit:
- 	if (buf)
-		kfree(buf);
+	kfree(buf);
 	release_firmware(fw_entry);
 	return err;
 }
diff -upr linux-2.6.12-rc2-mm3-orig/drivers/usb/serial/belkin_sa.c linux-2.6.12-rc2-mm3/drivers/usb/serial/belkin_sa.c
--- linux-2.6.12-rc2-mm3-orig/drivers/usb/serial/belkin_sa.c	2005-04-05 21:21:40.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/usb/serial/belkin_sa.c	2005-04-12 21:37:05.000000000 +0200
@@ -202,8 +202,7 @@ static void belkin_sa_shutdown (struct u
 	for (i=0; i < serial->num_ports; ++i) {
 		/* My special items, the standard routines free my urbs */
 		priv = usb_get_serial_port_data(serial->port[i]);
-		if (priv)
-			kfree(priv);
+		kfree(priv);
 	}
 }
 
diff -upr linux-2.6.12-rc2-mm3-orig/drivers/usb/serial/cypress_m8.c linux-2.6.12-rc2-mm3/drivers/usb/serial/cypress_m8.c
--- linux-2.6.12-rc2-mm3-orig/drivers/usb/serial/cypress_m8.c	2005-04-05 21:21:40.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/usb/serial/cypress_m8.c	2005-04-12 21:38:06.000000000 +0200
@@ -1340,9 +1340,8 @@ static struct cypress_buf *cypress_buf_a
 
 static void cypress_buf_free(struct cypress_buf *cb)
 {
-	if (cb != NULL) {
-		if (cb->buf_buf != NULL)
-			kfree(cb->buf_buf);
+	if (cb) {
+		kfree(cb->buf_buf);
 		kfree(cb);
 	}
 }
diff -upr linux-2.6.12-rc2-mm3-orig/drivers/usb/serial/empeg.c linux-2.6.12-rc2-mm3/drivers/usb/serial/empeg.c
--- linux-2.6.12-rc2-mm3-orig/drivers/usb/serial/empeg.c	2005-03-02 08:38:33.000000000 +0100
+++ linux-2.6.12-rc2-mm3/drivers/usb/serial/empeg.c	2005-04-12 21:39:19.000000000 +0200
@@ -550,8 +550,7 @@ failed_usb_register:
 failed_usb_serial_register:
 	for (i = 0; i < NUM_URBS; ++i) {
 		if (write_urb_pool[i]) {
-			if (write_urb_pool[i]->transfer_buffer)
-				kfree(write_urb_pool[i]->transfer_buffer);
+			kfree(write_urb_pool[i]->transfer_buffer);
 			usb_free_urb(write_urb_pool[i]);
 		}
 	}
@@ -575,8 +574,7 @@ static void __exit empeg_exit (void)
 			 * the host controllers get fixed to set urb->dev = NULL after
 			 * the urb is finished.  Otherwise this call oopses. */
 			/* usb_kill_urb(write_urb_pool[i]); */
-			if (write_urb_pool[i]->transfer_buffer)
-				kfree(write_urb_pool[i]->transfer_buffer);
+			kfree(write_urb_pool[i]->transfer_buffer);
 			usb_free_urb (write_urb_pool[i]);
 		}
 	}
diff -upr linux-2.6.12-rc2-mm3-orig/drivers/usb/serial/ftdi_sio.c linux-2.6.12-rc2-mm3/drivers/usb/serial/ftdi_sio.c
--- linux-2.6.12-rc2-mm3-orig/drivers/usb/serial/ftdi_sio.c	2005-04-05 21:21:40.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/usb/serial/ftdi_sio.c	2005-04-12 21:40:49.000000000 +0200
@@ -1347,9 +1347,7 @@ static int ftdi_common_startup (struct u
 	priv->flags = ASYNC_LOW_LATENCY;
 
 	/* Increase the size of read buffers */
-	if (port->bulk_in_buffer) {
-		kfree (port->bulk_in_buffer);
-	}
+	kfree(port->bulk_in_buffer);
 	port->bulk_in_buffer = kmalloc (BUFSZ, GFP_KERNEL);
 	if (!port->bulk_in_buffer) {
 		kfree (priv);
@@ -1365,10 +1363,8 @@ static int ftdi_common_startup (struct u
 		usb_free_urb (port->write_urb);
 		port->write_urb = NULL;
 	}
-	if (port->bulk_out_buffer) {
-		kfree (port->bulk_out_buffer);
-		port->bulk_out_buffer = NULL;
-	}
+	kfree(port->bulk_out_buffer);
+	port->bulk_out_buffer = NULL;
 
 	usb_set_serial_port_data(serial->port[0], priv);
 	
diff -upr linux-2.6.12-rc2-mm3-orig/drivers/usb/serial/io_edgeport.c linux-2.6.12-rc2-mm3/drivers/usb/serial/io_edgeport.c
--- linux-2.6.12-rc2-mm3-orig/drivers/usb/serial/io_edgeport.c	2005-04-05 21:21:40.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/usb/serial/io_edgeport.c	2005-04-12 21:52:43.000000000 +0200
@@ -951,9 +951,7 @@ static void edge_bulk_out_cmd_callback (
 
 
 	/* clean up the transfer buffer */
-	if (urb->transfer_buffer != NULL) {
-		kfree(urb->transfer_buffer);
-	}
+	kfree(urb->transfer_buffer);
 
 	/* Free the command urb */
 	usb_free_urb (urb);
@@ -1266,16 +1264,12 @@ static void edge_close (struct usb_seria
 
 	if (edge_port->write_urb) {
 		/* if this urb had a transfer buffer already (old transfer) free it */
-		if (edge_port->write_urb->transfer_buffer != NULL) {
-			kfree(edge_port->write_urb->transfer_buffer);
-		}
-		usb_free_urb   (edge_port->write_urb);
+		kfree(edge_port->write_urb->transfer_buffer);
+		usb_free_urb(edge_port->write_urb);
 		edge_port->write_urb = NULL;
 	}
-	if (edge_port->txfifo.fifo) {
-		kfree(edge_port->txfifo.fifo);
-		edge_port->txfifo.fifo = NULL;
-	}
+	kfree(edge_port->txfifo.fifo);
+	edge_port->txfifo.fifo = NULL;
 
 	dbg("%s exited", __FUNCTION__);
 }   
@@ -1419,11 +1413,9 @@ static void send_more_port_data(struct e
 	// get a pointer to the write_urb
 	urb = edge_port->write_urb;
 
-	/* if this urb had a transfer buffer already (old transfer) free it */
-	if (urb->transfer_buffer != NULL) {
-		kfree(urb->transfer_buffer);
-		urb->transfer_buffer = NULL;
-	}
+	/* make sure transfer buffer is freed */
+	kfree(urb->transfer_buffer);
+	urb->transfer_buffer = NULL;
 
 	/* build the data header for the buffer and port that we are about to send out */
 	count = fifo->count;
diff -upr linux-2.6.12-rc2-mm3-orig/drivers/usb/serial/io_ti.c linux-2.6.12-rc2-mm3/drivers/usb/serial/io_ti.c
--- linux-2.6.12-rc2-mm3-orig/drivers/usb/serial/io_ti.c	2005-04-05 21:21:40.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/usb/serial/io_ti.c	2005-04-12 21:54:20.000000000 +0200
@@ -2845,9 +2845,8 @@ static struct edge_buf *edge_buf_alloc(u
 
 void edge_buf_free(struct edge_buf *eb)
 {
-	if (eb != NULL) {
-		if (eb->buf_buf != NULL)
-			kfree(eb->buf_buf);
+	if (eb) {
+		kfree(eb->buf_buf);
 		kfree(eb);
 	}
 }
diff -upr linux-2.6.12-rc2-mm3-orig/drivers/usb/serial/kl5kusb105.c linux-2.6.12-rc2-mm3/drivers/usb/serial/kl5kusb105.c
--- linux-2.6.12-rc2-mm3-orig/drivers/usb/serial/kl5kusb105.c	2005-04-05 21:21:40.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/usb/serial/kl5kusb105.c	2005-04-12 21:57:37.000000000 +0200
@@ -341,8 +341,7 @@ static void klsi_105_shutdown (struct us
 					 * finished.  Otherwise this call
 					 * oopses. */
 					/* usb_kill_urb(write_urbs[j]); */
-					if (write_urbs[j]->transfer_buffer)
-						    kfree(write_urbs[j]->transfer_buffer);
+					kfree(write_urbs[j]->transfer_buffer);
 					usb_free_urb (write_urbs[j]);
 				}
 			}
diff -upr linux-2.6.12-rc2-mm3-orig/drivers/usb/serial/omninet.c linux-2.6.12-rc2-mm3/drivers/usb/serial/omninet.c
--- linux-2.6.12-rc2-mm3-orig/drivers/usb/serial/omninet.c	2005-03-02 08:38:25.000000000 +0100
+++ linux-2.6.12-rc2-mm3/drivers/usb/serial/omninet.c	2005-04-12 21:59:18.000000000 +0200
@@ -178,7 +178,6 @@ static void omninet_close (struct usb_se
 {
 	struct usb_serial 	*serial = port->serial;
 	struct usb_serial_port 	*wport;
-	struct omninet_data 	*od;
 
 	dbg("%s - port %d", __FUNCTION__, port->number);
 
@@ -186,9 +185,7 @@ static void omninet_close (struct usb_se
 	usb_kill_urb(wport->write_urb);
 	usb_kill_urb(port->read_urb);
 
-	od = usb_get_serial_port_data(port);
-	if (od)
-		kfree(od);
+	kfree(usb_get_serial_port_data(port));
 }
 
 
diff -upr linux-2.6.12-rc2-mm3-orig/drivers/usb/serial/pl2303.c linux-2.6.12-rc2-mm3/drivers/usb/serial/pl2303.c
--- linux-2.6.12-rc2-mm3-orig/drivers/usb/serial/pl2303.c	2005-03-02 08:38:08.000000000 +0100
+++ linux-2.6.12-rc2-mm3/drivers/usb/serial/pl2303.c	2005-04-12 21:59:45.000000000 +0200
@@ -1022,9 +1022,8 @@ static struct pl2303_buf *pl2303_buf_all
 
 static void pl2303_buf_free(struct pl2303_buf *pb)
 {
-	if (pb != NULL) {
-		if (pb->buf_buf != NULL)
-			kfree(pb->buf_buf);
+	if (pb) {
+		kfree(pb->buf_buf);
 		kfree(pb);
 	}
 }
diff -upr linux-2.6.12-rc2-mm3-orig/drivers/usb/serial/ti_usb_3410_5052.c linux-2.6.12-rc2-mm3/drivers/usb/serial/ti_usb_3410_5052.c
--- linux-2.6.12-rc2-mm3-orig/drivers/usb/serial/ti_usb_3410_5052.c	2005-04-05 21:21:40.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/usb/serial/ti_usb_3410_5052.c	2005-04-12 22:00:12.000000000 +0200
@@ -517,8 +517,7 @@ static void ti_shutdown(struct usb_seria
 		}
 	}
 
-	if (tdev)
-		kfree(tdev);
+	kfree(tdev);
 	usb_set_serial_data(serial, NULL);
 }
 
diff -upr linux-2.6.12-rc2-mm3-orig/drivers/usb/storage/sddr55.c linux-2.6.12-rc2-mm3/drivers/usb/storage/sddr55.c
--- linux-2.6.12-rc2-mm3-orig/drivers/usb/storage/sddr55.c	2005-04-05 21:21:41.000000000 +0200
+++ linux-2.6.12-rc2-mm3/drivers/usb/storage/sddr55.c	2005-04-12 22:04:27.000000000 +0200
@@ -119,10 +119,8 @@ static int sddr55_status(struct us_data 
 	/* expect to get short transfer if no card fitted */
 	if (result == USB_STOR_XFER_SHORT || result == USB_STOR_XFER_STALLED) {
 		/* had a short transfer, no card inserted, free map memory */
-		if (info->lba_to_pba)
-			kfree(info->lba_to_pba);
-		if (info->pba_to_lba)
-			kfree(info->pba_to_lba);
+		kfree(info->lba_to_pba);
+		kfree(info->pba_to_lba);
 		info->lba_to_pba = NULL;
 		info->pba_to_lba = NULL;
 
@@ -649,18 +647,14 @@ static int sddr55_read_map(struct us_dat
 		return -1;
 	}
 
-	if (info->lba_to_pba)
-		kfree(info->lba_to_pba);
-	if (info->pba_to_lba)
-		kfree(info->pba_to_lba);
+	kfree(info->lba_to_pba);
+	kfree(info->pba_to_lba);
 	info->lba_to_pba = kmalloc(numblocks*sizeof(int), GFP_NOIO);
 	info->pba_to_lba = kmalloc(numblocks*sizeof(int), GFP_NOIO);
 
 	if (info->lba_to_pba == NULL || info->pba_to_lba == NULL) {
-		if (info->lba_to_pba != NULL)
-			kfree(info->lba_to_pba);
-		if (info->pba_to_lba != NULL)
-			kfree(info->pba_to_lba);
+		kfree(info->lba_to_pba);
+		kfree(info->pba_to_lba);
 		info->lba_to_pba = NULL;
 		info->pba_to_lba = NULL;
 		kfree(buffer);
@@ -728,10 +722,8 @@ static void sddr55_card_info_destructor(
 	if (!extra)
 		return;
 
-	if (info->lba_to_pba)
-		kfree(info->lba_to_pba);
-	if (info->pba_to_lba)
-		kfree(info->pba_to_lba);
+	kfree(info->lba_to_pba);
+	kfree(info->pba_to_lba);
 }
 
 


