Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267481AbTBQXR2>; Mon, 17 Feb 2003 18:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267646AbTBQXRE>; Mon, 17 Feb 2003 18:17:04 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:17057 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S267481AbTBQXOL>;
	Mon, 17 Feb 2003 18:14:11 -0500
Date: Mon, 17 Feb 2003 18:24:04 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] pnp - Convert Radio Cadet Driver (8/13)
Message-ID: <20030217182404.GA31461@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the radio cadet driver to the new pnp api.

Please apply,

Adam


--- a/drivers/media/radio/radio-cadet.c	Tue Jan 14 05:58:38 2003
+++ b/drivers/media/radio/radio-cadet.c	Fri Jan 17 15:30:12 2003
@@ -1,4 +1,4 @@
-/* radio-cadet.c - A video4linux driver for the ADS Cadet AM/FM Radio Card 
+/* radio-cadet.c - A video4linux driver for the ADS Cadet AM/FM Radio Card
  *
  * by Fred Gleason <fredg@wava.com>
  * Version 0.3.3
@@ -20,6 +20,9 @@
  *		Removed dead CONFIG_RADIO_CADET_PORT code
  *		PnP detection on load is now default (no args necessary)
  *
+ * 2002-01-17	Adam Belay <ambx1@neo.rr.com>
+ *		Updated to latest pnp code
+ *
 */
 
 #include <linux/module.h>	/* Modules 			*/
@@ -30,7 +33,7 @@
 #include <asm/uaccess.h>	/* copy to/from user		*/
 #include <linux/videodev.h>	/* kernel radio structs		*/
 #include <linux/param.h>
-#include <linux/isapnp.h>
+#include <linux/pnp.h>
 
 #define RDS_BUFFER 256
 
@@ -47,8 +50,6 @@
 static int cadet_lock=0;
 
 static int cadet_probe(void);
-static struct pnp_dev *dev = NULL;
-static int isapnp_cadet_probe(void);
 
 /*
  * Signal Strength Threshold Values
@@ -152,7 +153,7 @@
          */
         outb(curvol,io+1);
 	cadet_lock--;
-	
+
 	return fifo;
 }
 
@@ -541,22 +542,23 @@
 	.fops           = &cadet_fops,
 };
 
-static int isapnp_cadet_probe(void)
-{
-	dev = pnp_find_dev (NULL, ISAPNP_VENDOR('M','S','M'),
-			    ISAPNP_FUNCTION(0x0c24), NULL);
+static struct pnp_device_id cadet_pnp_devices[] = {
+	/* ADS Cadet AM/FM Radio Card */
+	{.id = "MSM0c24", .driver_data = 0},
+	{.id = ""}
+};
 
+MODULE_DEVICE_TABLE(pnp, id_table);
+
+static int cadet_pnp_probe(struct pnp_dev * dev, const struct pnp_device_id *dev_id)
+{
 	if (!dev)
 		return -ENODEV;
-	if (pnp_device_attach(dev) < 0)
-		return -EAGAIN;
-	if (pnp_activate_dev(dev, NULL) < 0) {
-		printk ("radio-cadet: pnp configure failed (out of resources?)\n");
-		pnp_device_detach(dev);
-		return -EIO;
-	}
+	/* only support one device */
+	if (io > 0)
+		return -EBUSY;
+
 	if (!pnp_port_valid(dev, 0)) {
-		pnp_device_detach(dev);
 		return -ENODEV;
 	}
 
@@ -567,6 +569,13 @@
 	return io;
 }
 
+static struct pnp_driver cadet_pnp_driver = {
+	.name		= "radio-cadet",
+	.id_table	= cadet_pnp_devices,
+	.probe		= cadet_pnp_probe,
+	.remove		= NULL,
+};
+
 static int cadet_probe(void)
 {
         static int iovals[8]={0x330,0x332,0x334,0x336,0x338,0x33a,0x33c,0x33e};
@@ -597,7 +606,7 @@
 	 *	If a probe was requested then probe ISAPnP first (safest)
 	 */
 	if (io < 0)
-		io = isapnp_cadet_probe();
+		pnp_register_driver(&cadet_pnp_driver);
 	/*
 	 *	If that fails then probe unsafely if probe is requested
 	 */
@@ -612,16 +621,19 @@
 #ifdef MODULE        
 		printk(KERN_ERR "You must set an I/O address with io=0x???\n");
 #endif
-	        return -EINVAL;
+	        goto fail;
 	}
 	if (!request_region(io,2,"cadet"))
-		return -EBUSY;
+		goto fail;
 	if(video_register_device(&cadet_radio,VFL_TYPE_RADIO,radio_nr)==-1) {
 		release_region(io,2);
-		return -EINVAL;
+		goto fail;
 	}
 	printk(KERN_INFO "ADS Cadet Radio Card at 0x%x\n",io);
 	return 0;
+fail:
+	pnp_unregister_driver(&cadet_pnp_driver);
+	return -1;
 }
 
 
@@ -634,21 +646,11 @@
 MODULE_PARM_DESC(io, "I/O address of Cadet card (0x330,0x332,0x334,0x336,0x338,0x33a,0x33c,0x33e)");
 MODULE_PARM(radio_nr, "i");
 
-static struct isapnp_device_id id_table[] __devinitdata = {
-	{ 	ISAPNP_ANY_ID, ISAPNP_ANY_ID,
-		ISAPNP_VENDOR('M','S','M'), ISAPNP_FUNCTION(0x0c24), 0 },
-	{0}
-};
-
-MODULE_DEVICE_TABLE(isapnp, id_table);
-
 static void __exit cadet_cleanup_module(void)
 {
 	video_unregister_device(&cadet_radio);
 	release_region(io,2);
-
-	if (dev)
-		pnp_device_detach(dev);
+	pnp_unregister_driver(&cadet_pnp_driver);
 }
 
 module_init(cadet_init);
