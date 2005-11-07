Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbVKGDWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbVKGDWj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 22:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVKGDQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 22:16:33 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:17301 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932424AbVKGDQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 22:16:30 -0500
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, video4linux-list@redhat.com,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Subject: [Patch 18/20] V4L(920) Fixed autodetection of max size by if
	alternate setting
Date: Mon, 07 Nov 2005 00:58:11 -0200
Message-Id: <1131333341.25215.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1-2mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

- Fixed autodetection of max size by if alternate setting
- Fixed some debug messages

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

-----------------

diff -upNr oldtree/drivers/media/video/em28xx/em28xx-core.c linux/drivers/media/video/em28xx/em28xx-core.c
--- oldtree/drivers/media/video/em28xx/em28xx-core.c	2005-11-06 16:13:28.000000000 -0200
+++ linux/drivers/media/video/em28xx/em28xx-core.c	2005-11-06 16:13:29.000000000 -0200
@@ -797,20 +797,19 @@ int em28xx_set_alternate(struct em28xx *
 	dev->alt = alt;
 	if (dev->alt == 0) {
 		int i;
-		for(i=0;i< EM28XX_MAX_ALT; i++)
+		for(i=0;i< dev->num_alt; i++)
 			if(dev->alt_max_pkt_size[i]>dev->alt_max_pkt_size[dev->alt])
 				dev->alt=i;
 	}
 
 	if (dev->alt != prev_alt) {
 		dev->max_pkt_size = dev->alt_max_pkt_size[dev->alt];
-		em28xx_coredbg("setting alternate %d with wMaxPacketSize=%u", dev->alt,
+		em28xx_coredbg("setting alternate %d with wMaxPacketSize=%u\n", dev->alt,
 		       dev->max_pkt_size);
 		errCode = usb_set_interface(dev->udev, 0, dev->alt);
 		if (errCode < 0) {
-			em28xx_errdev
-					("cannot change alternate number to %d (error=%i)\n",
-					 dev->alt, errCode);
+			em28xx_errdev ("cannot change alternate number to %d (error=%i)\n",
+							dev->alt, errCode);
 			return errCode;
 		}
 	}
diff -upNr oldtree/drivers/media/video/em28xx/em28xx.h linux/drivers/media/video/em28xx/em28xx.h
--- oldtree/drivers/media/video/em28xx/em28xx.h	2005-11-06 16:13:28.000000000 -0200
+++ linux/drivers/media/video/em28xx/em28xx.h	2005-11-06 16:13:29.000000000 -0200
@@ -63,7 +63,6 @@
 
 /* default alternate; 0 means choose the best */
 #define EM28XX_PINOUT 0
-#define EM28XX_MAX_ALT 7
 
 #define EM28XX_INTERLACED_DEFAULT 1
 
@@ -267,7 +266,8 @@ struct em28xx {
 	struct usb_device *udev;	/* the usb device */
 	int alt;		/* alternate */
 	int max_pkt_size;	/* max packet size of isoc transaction */
-	unsigned int alt_max_pkt_size[EM28XX_MAX_ALT + 1];	/* array of wMaxPacketSize */
+	int num_alt;		/* Number of alternative settings */
+	unsigned int *alt_max_pkt_size;	/* array of wMaxPacketSize */
 	struct urb *urb[EM28XX_NUM_BUFS];	/* urb for isoc transfers */
 	char *transfer_buffer[EM28XX_NUM_BUFS];	/* transfer buffers for isoc transfer */
 	/* helper funcs that call usb_control_msg */
diff -upNr oldtree/drivers/media/video/em28xx/em28xx-video.c linux/drivers/media/video/em28xx/em28xx-video.c
--- oldtree/drivers/media/video/em28xx/em28xx-video.c	2005-11-06 16:13:28.000000000 -0200
+++ linux/drivers/media/video/em28xx/em28xx-video.c	2005-11-06 16:13:29.000000000 -0200
@@ -52,8 +52,7 @@ MODULE_LICENSE("GPL");
 
 static LIST_HEAD(em28xx_devlist);
 
-static unsigned int card[]  = {[0 ... (EM28XX_MAXBOARDS - 1)] = UNSET };
-
+static unsigned int card[]     = {[0 ... (EM28XX_MAXBOARDS - 1)] = UNSET };
 module_param_array(card,  int, NULL, 0444);
 MODULE_PARM_DESC(card,"card type");
 
@@ -1590,7 +1589,6 @@ static int em28xx_init_dev(struct em28xx
 	int retval = -ENOMEM;
 	int errCode, i;
 	unsigned int maxh, maxw;
-	struct usb_interface *uif;
 
 	dev->udev = udev;
 	dev->model = model;
@@ -1650,17 +1648,6 @@ static int em28xx_init_dev(struct em28xx
 	dev->vpic.depth = 16;
 	dev->vpic.palette = VIDEO_PALETTE_YUV422;
 
-	/* compute alternate max packet sizes */
-	uif = dev->udev->actconfig->interface[0];
-	dev->alt_max_pkt_size[0] = 0;
-	for (i = 1; i <= EM28XX_MAX_ALT && i < uif->num_altsetting ; i++) {
-		u16 tmp =
-		    le16_to_cpu(uif->altsetting[i].endpoint[1].desc.
-				wMaxPacketSize);
-		dev->alt_max_pkt_size[i] =
-		    (tmp & 0x07ff) * (((tmp & 0x1800) >> 11) + 1);
-	}
-
 #ifdef CONFIG_MODULES
 	/* request some modules */
 	if (dev->decoder == EM28XX_SAA7113 || dev->decoder == EM28XX_SAA7114)
@@ -1755,6 +1742,7 @@ static int em28xx_usb_probe(struct usb_i
 {
 	const struct usb_endpoint_descriptor *endpoint;
 	struct usb_device *udev;
+	struct usb_interface *uif;
 	struct em28xx *dev = NULL;
 	int retval = -ENODEV;
 	int model,i,nr,ifnum;
@@ -1794,7 +1782,7 @@ static int em28xx_usb_probe(struct usb_i
 	nr=interface->minor;
 
 	if (nr>EM28XX_MAXBOARDS) {
-		printk ("em28xx: Supports only %i em28xx boards.\n",EM28XX_MAXBOARDS);
+		printk (DRIVER_NAME ": Supports only %i em28xx boards.\n",EM28XX_MAXBOARDS);
 		return -ENOMEM;
 	}
 
@@ -1806,6 +1794,28 @@ static int em28xx_usb_probe(struct usb_i
 	}
 	memset(dev, 0, sizeof(*dev));
 
+	/* compute alternate max packet sizes */
+	uif = udev->actconfig->interface[0];
+
+	dev->num_alt=uif->num_altsetting;
+	printk(DRIVER_NAME ": Alternate settings: %i\n",dev->num_alt);
+//	dev->alt_max_pkt_size = kmalloc(sizeof(*dev->alt_max_pkt_size)*
+	dev->alt_max_pkt_size = kmalloc(32*
+						dev->num_alt,GFP_KERNEL);
+	if (dev->alt_max_pkt_size == NULL) {
+		em28xx_err(DRIVER_NAME ": out of memory!\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < dev->num_alt ; i++) {
+		u16 tmp = le16_to_cpu(uif->altsetting[i].endpoint[1].desc.
+							wMaxPacketSize);
+		dev->alt_max_pkt_size[i] =
+		    (tmp & 0x07ff) * (((tmp & 0x1800) >> 11) + 1);
+		printk(DRIVER_NAME ": Alternate setting %i, max size= %i\n",i,
+							dev->alt_max_pkt_size[i]);
+	}
+
 	snprintf(dev->name, 29, "em28xx #%d", nr);
 
 	if ((card[nr]>=0)&&(card[nr]<em28xx_bcount))
@@ -1875,11 +1885,12 @@ static void em28xx_usb_disconnect(struct
 
 	up(&dev->lock);
 
-	if (!dev->users)
+	if (!dev->users) {
+		kfree(dev->alt_max_pkt_size);
 		kfree(dev);
+	}
 
 	up_write(&em28xx_disconnect);
-
 }
 
 static struct usb_driver em28xx_usb_driver = {


	

	
		
_______________________________________________________ 
Yahoo! Acesso Grátis: Internet rápida e grátis. 
Instale o discador agora!
http://br.acesso.yahoo.com/

