Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271356AbTG2JdJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 05:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271352AbTG2Jbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 05:31:41 -0400
Received: from mail.convergence.de ([212.84.236.4]:40670 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S271357AbTG2Jag convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 05:30:36 -0400
Subject: [PATCH 5/6] [DVB] TTUSB-DEC driver update
In-Reply-To: <1059471031240@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 29 Jul 2003 11:30:32 +0200
Message-Id: <10594710321293@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, torvalds@osdl.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) 
	<hunold@convergence.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[DVB] - Hand off all processing of urb data to a tasklet
diff -uNrwB --new-file linux-2.6.0-test2.work/drivers/media/dvb/ttusb-dec/ttusb_dec.c linux-2.6.0-test2.patch/drivers/media/dvb/ttusb-dec/ttusb_dec.c
--- linux-2.6.0-test2.work/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2003-07-29 09:10:18.000000000 +0200
+++ linux-2.6.0-test2.patch/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2003-07-21 13:42:42.000000000 +0200
@@ -124,14 +125,10 @@
 
 	ttusb_dec_send_command(dec, 0x50, sizeof(b), b, NULL, NULL);
 
-	if (!down_interruptible(&dec->pes2ts_sem)) {
 		dvb_filter_pes2ts_init(&dec->a_pes2ts, dec->pid[DMX_PES_AUDIO],
 				       ttusb_dec_av_pes2ts_cb, dec->demux.feed);
 		dvb_filter_pes2ts_init(&dec->v_pes2ts, dec->pid[DMX_PES_VIDEO],
 				       ttusb_dec_av_pes2ts_cb, dec->demux.feed);
-
-		up(&dec->pes2ts_sem);
-	}
 }
 
 static int ttusb_dec_i2c_master_xfer(struct dvb_i2c_bus *i2c,
@@ -196,14 +193,8 @@
 				memcpy(&dec->v_pes[dec->v_pes_length],
 				       &av_pes[12], prebytes);
 
-				if (!down_interruptible(&dec->pes2ts_sem)) {
-					dvb_filter_pes2ts(&dec->v_pes2ts,
-							  dec->v_pes,
-							  dec->v_pes_length +
-							  prebytes);
-
-					up(&dec->pes2ts_sem);
-				}
+				dvb_filter_pes2ts(&dec->v_pes2ts, dec->v_pes,
+						  dec->v_pes_length + prebytes);
 			}
 
 			if (av_pes[5] & 0x10) {
@@ -246,16 +237,10 @@
 						     postbytes);
 			memcpy(&dec->v_pes[4], &v_pes_payload_length, 2);
 
-			if (postbytes == 0) {
-				if (!down_interruptible(&dec->pes2ts_sem)) {
-					dvb_filter_pes2ts(&dec->v_pes2ts,
-							  dec->v_pes,
+			if (postbytes == 0)
+				dvb_filter_pes2ts(&dec->v_pes2ts, dec->v_pes,
 							  dec->v_pes_length);
 
-					up(&dec->pes2ts_sem);
-				}
-			}
-
 			break;
 		}
 
@@ -357,6 +342,31 @@
 	}
 }
 
+static void ttusb_dec_process_urb_frame_list(unsigned long data)
+{
+	struct ttusb_dec *dec = (struct ttusb_dec *)data;
+	struct list_head *item;
+	struct urb_frame *frame;
+	unsigned long flags;
+
+	while (1) {
+		spin_lock_irqsave(&dec->urb_frame_list_lock, flags);
+		if ((item = dec->urb_frame_list.next) != &dec->urb_frame_list) {
+			frame = list_entry(item, struct urb_frame,
+					   urb_frame_list);
+			list_del(&frame->urb_frame_list);
+		} else {
+			spin_unlock_irqrestore(&dec->urb_frame_list_lock,
+					       flags);
+			return;
+		}
+		spin_unlock_irqrestore(&dec->urb_frame_list_lock, flags);
+
+		ttusb_dec_process_urb_frame(dec, frame->data, frame->length);
+		kfree(frame);
+	}
+}
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
 static void ttusb_dec_process_urb(struct urb *urb)
 #else
@@ -372,12 +382,28 @@
 			struct usb_iso_packet_descriptor *d;
 			u8 *b;
 			int length;
+			struct urb_frame *frame;
 
 			d = &urb->iso_frame_desc[i];
 			b = urb->transfer_buffer + d->offset;
 			length = d->actual_length;
 
-			ttusb_dec_process_urb_frame(dec, b, length);
+			if ((frame = kmalloc(sizeof(struct urb_frame),
+					     GFP_ATOMIC))) {
+				unsigned long flags;
+
+				memcpy(frame->data, b, length);
+				frame->length = length;
+
+				spin_lock_irqsave(&dec->urb_frame_list_lock,
+						     flags);
+				list_add_tail(&frame->urb_frame_list,
+					      &dec->urb_frame_list);
+				spin_unlock_irqrestore(&dec->urb_frame_list_lock,
+						       flags);
+
+				tasklet_schedule(&dec->urb_tasklet);
+			}
 		}
 	} else {
 		 /* -ENOENT is expected when unlinking urbs */
@@ -653,6 +679,14 @@
 	return 0;
 }
 
+static void ttusb_dec_init_tasklet(struct ttusb_dec *dec)
+{
+	dec->urb_frame_list_lock = SPIN_LOCK_UNLOCKED;
+	INIT_LIST_HEAD(&dec->urb_frame_list);
+	tasklet_init(&dec->urb_tasklet, ttusb_dec_process_urb_frame_list,
+		     (unsigned long)dec);
+}
+
 static void ttusb_dec_init_v_pes(struct ttusb_dec *dec)
 {
 	dprintk("%s\n", __FUNCTION__);
@@ -834,8 +868,6 @@
 		return result;
 	}
 
-	sema_init(&dec->pes2ts_sem, 1);
-
 	dvb_net_init(dec->adapter, &dec->dvb_net, &dec->demux.dmx);
 
 	return 0;
@@ -868,6 +900,20 @@
 	ttusb_dec_free_iso_urbs(dec);
 }
 
+static void ttusb_dec_exit_tasklet(struct ttusb_dec *dec)
+{
+	struct list_head *item;
+	struct urb_frame *frame;
+
+	tasklet_kill(&dec->urb_tasklet);
+
+	while ((item = dec->urb_frame_list.next) != &dec->urb_frame_list) {
+		frame = list_entry(item, struct urb_frame, urb_frame_list);
+		list_del(&frame->urb_frame_list);
+		kfree(frame);
+	}
+}
+
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
 static void *ttusb_dec_probe(struct usb_device *udev, unsigned int ifnum,
 			     const struct usb_device_id *id)
@@ -892,6 +938,7 @@
 	ttusb_dec_init_stb(dec);
 	ttusb_dec_init_dvb(dec);
 	ttusb_dec_init_v_pes(dec);
+	ttusb_dec_init_tasklet(dec);
 
 	return (void *)dec;
 }
@@ -919,6 +966,7 @@
 	ttusb_dec_init_stb(dec);
 	ttusb_dec_init_dvb(dec);
 	ttusb_dec_init_v_pes(dec);
+	ttusb_dec_init_tasklet(dec);
 
 	usb_set_intfdata(intf, (void *)dec);
 	ttusb_dec_set_streaming_interface(dec);
@@ -941,6 +989,7 @@
 
 	dprintk("%s\n", __FUNCTION__);
 
+	ttusb_dec_exit_tasklet(dec);
 	ttusb_dec_exit_usb(dec);
 	ttusb_dec_exit_dvb(dec);
 
diff -uNrwB --new-file linux-2.6.0-test2.work/drivers/media/dvb/ttusb-dec/ttusb_dec.h linux-2.6.0-test2.patch/drivers/media/dvb/ttusb-dec/ttusb_dec.h
--- linux-2.6.0-test2.work/drivers/media/dvb/ttusb-dec/ttusb_dec.h	2003-07-29 09:10:18.000000000 +0200
+++ linux-2.6.0-test2.patch/drivers/media/dvb/ttusb-dec/ttusb_dec.h	2003-07-21 13:42:42.000000000 +0200
@@ -22,7 +22,10 @@
 #ifndef _TTUSB_DEC_H
 #define _TTUSB_DEC_H
 
-#include "asm/semaphore.h"
+#include <asm/semaphore.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
 #include "dmxdev.h"
 #include "dvb_demux.h"
 #include "dvb_filter.h"
@@ -77,11 +80,20 @@
 
 	struct dvb_filter_pes2ts	a_pes2ts;
 	struct dvb_filter_pes2ts	v_pes2ts;
-	struct semaphore		pes2ts_sem;
 
 	u8			v_pes[16 + MAX_AV_PES_LENGTH];
 	int			v_pes_length;
 	int			v_pes_postbytes;
+
+	struct list_head	urb_frame_list;
+	struct tasklet_struct	urb_tasklet;
+	spinlock_t		urb_frame_list_lock;
+};
+
+struct urb_frame {
+	u8			data[ISO_FRAME_SIZE];
+	int			length;
+	struct list_head	urb_frame_list;
 };
 
 #endif

