Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318257AbSIEV70>; Thu, 5 Sep 2002 17:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318258AbSIEV67>; Thu, 5 Sep 2002 17:58:59 -0400
Received: from nl-ams-slo-l4-02-pip-7.chellonetwork.com ([213.46.243.26]:48144
	"EHLO amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id <S318257AbSIEV6c>; Thu, 5 Sep 2002 17:58:32 -0400
Date: Fri, 6 Sep 2002 00:08:32 +0200
From: Jeroen Vreeken <pe1rxq@amsat.org>
To: Greg KH <greg@kroah.com>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Kernel Janitors ML 
	<kernel-janitor-discuss@lists.sourceforge.net>
Subject: Re: Broken inlines all over the source tree
Message-ID: <20020906000832.A2854@jeroen.pe1rxq.ampr.org>
References: <1030232838.1451.99.camel@ldb> <20020826162204.GB17819@kroah.com> <20020903173347.C377@jeroen.pe1rxq.ampr.org> <20020904181723.GB7177@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AWniW0JNca5xppdA"
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020904181723.GB7177@kroah.com>; from greg@kroah.com on Wed, Sep 04, 2002 at 20:17:23 +0200
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AWniW0JNca5xppdA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

On 2002.09.04 20:17:23 +0200 Greg KH wrote:
> On Tue, Sep 03, 2002 at 05:33:47PM +0200, Jeroen Vreeken wrote:
> > On 2002.08.26 18:22:05 +0200 Greg KH wrote:
> > > On Sun, Aug 25, 2002 at 01:47:18AM +0200, Luca Barbieri wrote:
> > > > ./drivers/usb/media/se401.h
> > > 
> > > Should be fixed, Jeroen, do you want to do this?
> > 
> > Attached is a patch against 2.4.20-pre5 that updates the se401 driver
> to
> > update it to version 0.24.
> > This fixes the inline problem, a memory leak on disconnect and disables
> the
> > button for cameras that don't support it.
> > 
> > I haven't been folowing 2.5 for a while, but I think it will apply
> without
> > problems.
> 
> Sorry, but the patch does not apply (even after adjusting the path).  I
> get lots of failed hunks.

I made a new patch against 2.5.33, it was mostly litle things like the v4l
changes.

Jeroen

--AWniW0JNca5xppdA
Content-Type: application/octet-stream; charset=us-ascii
Content-Disposition: attachment; filename="se401-0.24-2.5.33.diff"

--- linux-2.5.33/drivers/usb/media/se401.c.org	Thu Sep  5 23:27:06 2002
+++ linux-2.5.33/drivers/usb/media/se401.c	Thu Sep  5 23:59:53 2002
@@ -25,7 +25,7 @@
  * 	- Jeroen Vreeken
  */
 
-static const char version[] = "0.23";
+static const char version[] = "0.24";
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -980,6 +980,34 @@
 	return 0;
 }
 
+static void usb_se401_remove_disconnected (struct usb_se401 *se401)
+{
+	int i;
+
+        se401->dev = NULL;
+
+	for (i=0; i<SE401_NUMSBUF; i++) if (se401->urb[i]) {
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
@@ -1015,20 +1043,16 @@
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
 	file->private_data = NULL;
 	return 0;
@@ -1302,7 +1326,7 @@
 
 
 /***************************/
-static int se401_init(struct usb_se401 *se401)
+static int se401_init(struct usb_se401 *se401, int button)
 {
         int i=0, rc;
         unsigned char cp[0x40];
@@ -1367,22 +1391,25 @@
 	se401->readcount=0;
 
 	/* Start interrupt transfers for snapshot button */
-	se401->inturb=usb_alloc_urb(0, GFP_KERNEL);
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
-	if (usb_submit_urb(se401->inturb, GFP_KERNEL)) {
-		info("int urb burned down");
-		return 1;
-	}
+	if (button) {
+		se401->inturb=usb_alloc_urb(0, GFP_KERNEL);
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
+		if (usb_submit_urb(se401->inturb, GFP_KERNEL)) {
+			info("int urb burned down");
+			return 1;
+		}
+	} else
+		se401->inturb=NULL;
 
         /* Flash the led */
         se401_sndctrl(1, se401, SE401_REQ_CAMERA_POWER, 1, NULL, 0);
@@ -1399,6 +1426,7 @@
         struct usb_interface_descriptor *interface;
         struct usb_se401 *se401;
         char *camera_name=NULL;
+	int button=1;
 
         /* We don't handle multi-config cameras */
         if (dev->descriptor.bNumConfigurations != 1)
@@ -1422,6 +1450,7 @@
         } else if (dev->descriptor.idVendor == 0x047d &&
 	    dev->descriptor.idProduct == 0x5003) {
 		camera_name="Kensington VideoCAM 67016";
+		button=0;
 	} else
 		return NULL;
 
@@ -1447,7 +1476,7 @@
 
 	info("firmware version: %02x", dev->descriptor.bcdDevice & 255);
 
-        if (se401_init(se401)) {
+        if (se401_init(se401, button)) {
 		kfree(se401);
 		return NULL;
 	}
@@ -1479,45 +1508,18 @@
 	if (!se401->user){
 		usb_se401_remove_disconnected(se401);
 	} else {
-		se401->removed = 1;
-	}
-}
+		se401->frame[0].grabstate = FRAME_ERROR;
+		se401->frame[0].grabstate = FRAME_ERROR;
 
-static inline void usb_se401_remove_disconnected (struct usb_se401 *se401)
-{
-	int i;
-
-        se401->dev = NULL;
-        se401->frame[0].grabstate = FRAME_ERROR;
-        se401->frame[1].grabstate = FRAME_ERROR;
-
-	se401->streaming = 0;
-
-	wake_up_interruptible(&se401->wq);
-
-	for (i=0; i<SE401_NUMSBUF; i++) if (se401->urb[i]) {
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
+		se401->streaming = 0;
+		
+		wake_up_interruptible(&se401->wq);
+		se401->removed = 1;
 	}
-        info("%s disconnected", se401->camera_name);
-
 #if defined(CONFIG_PROC_FS) && defined(CONFIG_VIDEO_PROC_FS)
 	destroy_proc_se401_cam(se401);
 #endif
 
-        /* Free the memory */
-	kfree(se401->width);
-	kfree(se401->height);
-	kfree(se401);
 }
 
 static struct usb_driver se401_driver = {
--- linux-2.5.33/drivers/usb/media/se401.h.org	Thu Sep  5 23:27:10 2002
+++ linux-2.5.33/drivers/usb/media/se401.h	Thu Sep  5 23:27:15 2002
@@ -230,7 +230,6 @@
 	int nullpackets;
 };
 
-static inline void usb_se401_remove_disconnected (struct usb_se401 *se401);
 
 
 #endif

--AWniW0JNca5xppdA--


