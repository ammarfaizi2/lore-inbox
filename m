Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318835AbSICPY5>; Tue, 3 Sep 2002 11:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318839AbSICPY4>; Tue, 3 Sep 2002 11:24:56 -0400
Received: from nl-ams-slo-l4-02-pip-3.chellonetwork.com ([213.46.243.18]:1093
	"EHLO amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id <S318838AbSICPYv>; Tue, 3 Sep 2002 11:24:51 -0400
Date: Tue, 3 Sep 2002 17:33:47 +0200
From: Jeroen Vreeken <pe1rxq@amsat.org>
To: Greg KH <greg@kroah.com>
Cc: Luca Barbieri <ldb@ldb.ods.org>, petkan@users.sourceforge.net,
       pe1rxq@amsat.org, Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Kernel Janitors ML 
	<kernel-janitor-discuss@lists.sourceforge.net>
Subject: Re: Broken inlines all over the source tree
Message-ID: <20020903173347.C377@jeroen.pe1rxq.ampr.org>
References: <1030232838.1451.99.camel@ldb> <20020826162204.GB17819@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+fexcqMh/evT6CrY"
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020826162204.GB17819@kroah.com>; from greg@kroah.com on Mon, Aug 26, 2002 at 18:22:05 +0200
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+fexcqMh/evT6CrY
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

On 2002.08.26 18:22:05 +0200 Greg KH wrote:
> On Sun, Aug 25, 2002 at 01:47:18AM +0200, Luca Barbieri wrote:
> > ./drivers/usb/media/se401.h
> 
> Should be fixed, Jeroen, do you want to do this?

Attached is a patch against 2.4.20-pre5 that updates the se401 driver to
update it to version 0.24.
This fixes the inline problem, a memory leak on disconnect and disables the
button for cameras that don't support it.

I haven't been folowing 2.5 for a while, but I think it will apply without
problems.

Jeroen

--+fexcqMh/evT6CrY
Content-Type: application/octet-stream; charset=us-ascii
Content-Disposition: attachment; filename="se401-0.24.diff"

--- linux/drivers/usb/se401.c.org	Tue Sep  3 15:18:22 2002
+++ linux/drivers/usb/se401.c	Tue Sep  3 17:19:06 2002
@@ -25,7 +25,7 @@
  * 	- Jeroen Vreeken
  */
 
-static const char version[] = "0.23";
+static const char version[] = "0.24";
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -986,6 +986,35 @@
 	return 0;
 }
 
+static void usb_se401_remove_disconnected (struct usb_se401 *se401)
+{
+	int i;
+
+        se401->dev = NULL;
+
+	for (i=0; i<SE401_NUMSBUF; i++) if (se401->urb[i]) {
+		se401->urb[i]->next = NULL;
+		usb_unlink_urb(se401->urb[i]);
+		usb_free_urb(se401->urb[i]);
+		se401->urb[i] = NULL;
+		kfree(se401->sbuf[i].data);
+	}
+	for (i=0; i<SE401_NUMSCRATCH; i++) if (se401->scratch[i].data) {
+		kfree(se401->scratch[i].data);
+	}
+	if (se401->inturb) {
+		usb_unlink_urb(se401->inturb);
+		usb_free_urb(se401->inturb);
+	}
+        info("%s disconnected", se401->camera_name);
+
+        /* Free the memory */
+	kfree(se401->width);
+	kfree(se401->height);
+	kfree(se401);
+}
+
+
 
 /****************************************************************************
  *
@@ -1020,21 +1049,17 @@
         struct usb_se401 *se401 = (struct usb_se401 *)dev;
 	int i;
 
-	for (i=0; i<SE401_NUMFRAMES; i++)
-		se401->frame[i].grabstate=FRAME_UNUSED;
-	if (se401->streaming)
-		se401_stop_stream(se401);
-
 	rvfree(se401->fbuf, se401->maxframesize * SE401_NUMFRAMES);
-	se401->user=0;
-
         if (se401->removed) {
                 video_unregister_device(&se401->vdev);
-		kfree(se401->width);
-		kfree(se401->height);
-                kfree(se401);
-                se401 = NULL;
+		usb_se401_remove_disconnected(se401);
 		info("device unregistered");
+	} else {
+		for (i=0; i<SE401_NUMFRAMES; i++)
+			se401->frame[i].grabstate=FRAME_UNUSED;
+		if (se401->streaming)
+			se401_stop_stream(se401);
+		se401->user=0;
 	}
 
         MOD_DEC_USE_COUNT;
@@ -1350,7 +1375,7 @@
 
 
 /***************************/
-static int se401_init(struct usb_se401 *se401)
+static int se401_init(struct usb_se401 *se401, int button)
 {
         int i=0, rc;
         unsigned char cp[0x40];
@@ -1415,22 +1440,25 @@
 	se401->readcount=0;
 
 	/* Start interrupt transfers for snapshot button */
-	se401->inturb=usb_alloc_urb(0);
-	if (!se401->inturb) {
-		info("Allocation of inturb failed");
-		return 1;
-	}
-	FILL_INT_URB(se401->inturb, se401->dev,
-	    usb_rcvintpipe(se401->dev, SE401_BUTTON_ENDPOINT),
-	    &se401->button, sizeof(se401->button),
-	    se401_button_irq,
-	    se401,
-	    HZ/10
-	);
-	if (usb_submit_urb(se401->inturb)) {
-		info("int urb burned down");
-		return 1;
-	}
+	if (button) {
+		se401->inturb=usb_alloc_urb(0);
+		if (!se401->inturb) {
+			info("Allocation of inturb failed");
+			return 1;
+		}
+		FILL_INT_URB(se401->inturb, se401->dev,
+		    usb_rcvintpipe(se401->dev, SE401_BUTTON_ENDPOINT),
+		    &se401->button, sizeof(se401->button),
+		    se401_button_irq,
+		    se401,
+		    HZ/10
+		);
+		if (usb_submit_urb(se401->inturb)) {
+			info("int urb burned down");
+			return 1;
+		}
+	} else
+		se401->inturb=NULL;
 
         /* Flash the led */
         se401_sndctrl(1, se401, SE401_REQ_CAMERA_POWER, 1, NULL, 0);
@@ -1447,6 +1475,7 @@
         struct usb_interface_descriptor *interface;
         struct usb_se401 *se401;
         char *camera_name=NULL;
+	int button=1;
 
         /* We don't handle multi-config cameras */
         if (dev->descriptor.bNumConfigurations != 1)
@@ -1470,6 +1499,7 @@
         } else if (dev->descriptor.idVendor == 0x047d &&
 	    dev->descriptor.idProduct == 0x5003) {
 		camera_name="Kensington VideoCAM 67016";
+		button=0;
 	} else
 		return NULL;
 
@@ -1495,7 +1525,7 @@
 
 	info("firmware version: %02x", dev->descriptor.bcdDevice & 255);
 
-        if (se401_init(se401)) {
+        if (se401_init(se401, button)) {
 		kfree(se401);
 		return NULL;
 	}
@@ -1526,47 +1556,20 @@
 		video_unregister_device(&se401->vdev);
 		usb_se401_remove_disconnected(se401);
 	} else {
-		se401->removed = 1;
-	}
-	unlock_kernel();
-}
+	        se401->frame[0].grabstate = FRAME_ERROR;
+	        se401->frame[1].grabstate = FRAME_ERROR;
 
-static inline void usb_se401_remove_disconnected (struct usb_se401 *se401)
-{
-	int i;
-
-        se401->dev = NULL;
-        se401->frame[0].grabstate = FRAME_ERROR;
-        se401->frame[1].grabstate = FRAME_ERROR;
+		se401->streaming = 0;
 
-	se401->streaming = 0;
-
-	wake_up_interruptible(&se401->wq);
-
-	for (i=0; i<SE401_NUMSBUF; i++) if (se401->urb[i]) {
-		se401->urb[i]->next = NULL;
-		usb_unlink_urb(se401->urb[i]);
-		usb_free_urb(se401->urb[i]);
-		se401->urb[i] = NULL;
-		kfree(se401->sbuf[i].data);
-	}
-	for (i=0; i<SE401_NUMSCRATCH; i++) if (se401->scratch[i].data) {
-		kfree(se401->scratch[i].data);
-	}
-	if (se401->inturb) {
-		usb_unlink_urb(se401->inturb);
-		usb_free_urb(se401->inturb);
+		wake_up_interruptible(&se401->wq);
+		se401->removed = 1;
 	}
-        info("%s disconnected", se401->camera_name);
 
 #if defined(CONFIG_PROC_FS) && defined(CONFIG_VIDEO_PROC_FS)
 	destroy_proc_se401_cam(se401);
 #endif
 
-        /* Free the memory */
-	kfree(se401->width);
-	kfree(se401->height);
-	kfree(se401);
+	unlock_kernel();
 }
 
 static struct usb_driver se401_driver = {
--- linux/drivers/usb/se401.h.org	Tue Sep  3 17:27:29 2002
+++ linux/drivers/usb/se401.h	Tue Sep  3 17:28:11 2002
@@ -230,7 +230,6 @@
 	int nullpackets;
 };
 
-static inline void usb_se401_remove_disconnected (struct usb_se401 *se401);
 
 
 #endif

--+fexcqMh/evT6CrY--


