Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266064AbTB0ScH>; Thu, 27 Feb 2003 13:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266069AbTB0ScH>; Thu, 27 Feb 2003 13:32:07 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:64403 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S266064AbTB0ScC>; Thu, 27 Feb 2003 13:32:02 -0500
Date: Thu, 27 Feb 2003 19:41:10 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia: update register_pcmcia_driver users
Message-ID: <20030227184110.GA22487@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[depends on the pcmcia: bus_type pcmcia_bus_type, pcmcia-drivers patch 
sent to you a few minutes ago.]

register_pcmcia_driver was equivalent to register_pccard_driver. Only leave
the latter, and convert the users of the former name to use the (advanced)
registration function pcmcia_register_driver().

Please apply,

	Dominik

diff -ruN linux-original/drivers/net/wireless/airo_cs.c linux/drivers/net/wireless/airo_cs.c
--- linux-original/drivers/net/wireless/airo_cs.c	2003-02-27 18:55:06.000000000 +0100
+++ linux/drivers/net/wireless/airo_cs.c	2003-02-27 19:27:52.000000000 +0100
@@ -628,6 +628,13 @@
 
 /*====================================================================*/
 
+static struct pcmcia_driver airo_driver = {
+       .drv.name       = "airo_cs",
+       .attach         = airo_attach,
+       .detach         = airo_detach,
+       .owner          = THIS_MODULE,
+};
+
 static int airo_cs_init(void)
 {
 	servinfo_t serv;
@@ -638,14 +645,14 @@
 		       "does not match!\n");
 		return -1;
 	}
-	register_pcmcia_driver(&dev_info, &airo_attach, &airo_detach);
+	pcmcia_register_driver(&airo_driver);
 	return 0;
 }
 
 static void airo_cs_cleanup(void)
 {
 	DEBUG(0, "airo_cs: unloading\n");
-	unregister_pcmcia_driver(&dev_info);
+	pcmcia_unregister_driver(&airo_driver);
 	while (dev_list != NULL) {
 		if (dev_list->state & DEV_CONFIG)
 			airo_release((u_long)dev_list);
diff -ruN linux-original/drivers/net/wireless/ray_cs.c linux/drivers/net/wireless/ray_cs.c
--- linux-original/drivers/net/wireless/ray_cs.c	2003-02-27 18:55:06.000000000 +0100
+++ linux/drivers/net/wireless/ray_cs.c	2003-02-27 19:33:06.000000000 +0100
@@ -2962,13 +2962,20 @@
 }
 #endif
 
+static struct pcmcia_driver raylink_driver = {
+       .drv.name       = "raylink_cs",
+       .attach         = ray_attach,
+       .detach         = ray_detach,
+       .owner          = THIS_MODULE,
+};
+
 static int __init init_ray_cs(void)
 {
     int rc;
     
     DEBUG(1, "%s\n", rcsid);
-    rc = register_pcmcia_driver(&dev_info, &ray_attach, &ray_detach);
-    DEBUG(1, "raylink init_module register_pcmcia_driver returns 0x%x\n",rc);
+    rc = pcmcia_register_driver(&raylink_driver);
+    DEBUG(1, "raylink init_module pcmcia_register_driver returns 0x%x\n",rc);
 
 #ifdef CONFIG_PROC_FS
     proc_mkdir("driver/ray_cs", 0);
@@ -2993,7 +3000,7 @@
     remove_proc_entry("ray_cs", proc_root_driver);
 #endif
 
-    unregister_pcmcia_driver(&dev_info);
+    pcmcia_unregister_driver(&raylink_driver);
     while (dev_list != NULL)
         ray_detach(dev_list);
 
diff -ruN linux-original/drivers/scsi/pcmcia/nsp_cs.c linux/drivers/scsi/pcmcia/nsp_cs.c
--- linux-original/drivers/scsi/pcmcia/nsp_cs.c	2003-02-27 19:01:55.000000000 +0100
+++ linux/drivers/scsi/pcmcia/nsp_cs.c	2003-02-27 19:30:12.000000000 +0100
@@ -1990,6 +1990,14 @@
 /*======================================================================*
  *	module entry point
  *====================================================================*/
+
+static struct pcmcia_driver nsp_driver = {
+       .drv.name       = "nsp_cs",
+       .attach         = nsp_cs_attach,
+       .detach         = nsp_cs_detach,
+       .owner          = THIS_MODULE,
+};
+
 static int __init nsp_cs_init(void)
 {
 	servinfo_t serv;
@@ -2002,7 +2010,7 @@
 		       "does not match!\n");
 		return -1;
 	}
-	register_pcmcia_driver(&dev_info, &nsp_cs_attach, &nsp_cs_detach);
+	pcmcia_register_driver(&nsp_driver);
 
 	DEBUG(0, "%s: out\n", __FUNCTION__);
 	return 0;
@@ -2012,7 +2020,7 @@
 static void __exit nsp_cs_cleanup(void)
 {
 	DEBUG(0, "%s: unloading\n", __FUNCTION__);
-	unregister_pcmcia_driver(&dev_info);
+	pcmcia_unregister_driver(&nsp_driver);
 	while (dev_list != NULL) {
 		if (dev_list->state & DEV_CONFIG) {
 			nsp_cs_release((u_long)dev_list);
diff -ruN linux-original/drivers/telephony/ixj_pcmcia.c linux/drivers/telephony/ixj_pcmcia.c
--- linux-original/drivers/telephony/ixj_pcmcia.c	2003-02-27 18:55:17.000000000 +0100
+++ linux/drivers/telephony/ixj_pcmcia.c	2003-02-27 19:31:26.000000000 +0100
@@ -310,6 +310,13 @@
 	return 0;
 }
 
+static struct pcmcia_driver ixj_driver = {
+       .drv.name       = "ixj_cs",
+       .attach         = ixj_attach,
+       .detach         = ixj_detach,
+       .owner          = THIS_MODULE,
+};
+
 int __init ixj_register_pcmcia(void)
 {
 	servinfo_t serv;
@@ -319,14 +326,14 @@
 		printk(KERN_NOTICE "ixj_cs: Card Services release does not match!\n");
 		return -EINVAL;
 	}
-	register_pcmcia_driver(&dev_info, &ixj_attach, &ixj_detach);
+	pcmcia_register_driver(&ixj_driver);
 	return 0;
 }
 
 static void ixj_pcmcia_unload(void)
 {
 	DEBUG(0, "ixj_cs: unloading\n");
-	unregister_pcmcia_driver(&dev_info);
+	pcmcia_unregister_driver(&ixj_driver);
 	while (dev_list != NULL)
 		ixj_detach(dev_list);
 }
diff -ruN linux-original/include/pcmcia/ds.h linux/include/pcmcia/ds.h
--- linux-original/include/pcmcia/ds.h	2003-02-27 19:36:36.000000000 +0100
+++ linux/include/pcmcia/ds.h	2003-02-27 19:31:50.000000000 +0100
@@ -140,9 +140,6 @@
 
 int unregister_pccard_driver(dev_info_t *dev_info);
 
-#define register_pcmcia_driver register_pccard_driver
-#define unregister_pcmcia_driver unregister_pccard_driver
-
 #include <linux/device.h>
 
 extern struct bus_type pcmcia_bus_type;
