Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263026AbTCWL2D>; Sun, 23 Mar 2003 06:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263027AbTCWL2D>; Sun, 23 Mar 2003 06:28:03 -0500
Received: from verein.lst.de ([212.34.181.86]:14090 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S263026AbTCWL2A>;
	Sun, 23 Mar 2003 06:28:00 -0500
Date: Sun, 23 Mar 2003 12:39:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] convert remaining register_pcmcia_driver users
Message-ID: <20030323123903.A28508@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert remaining register_pcmcia_driver users to use the new
pcmcia_register_driver interfaces.


--- 1.6/drivers/net/wireless/airo_cs.c	Sun Feb  2 16:40:35 2003
+++ edited/drivers/net/wireless/airo_cs.c	Sun Mar 23 11:28:12 2003
@@ -626,26 +626,25 @@
 	return 0;
 } /* airo_event */
 
-/*====================================================================*/
+static struct pcmcia_driver airo_driver = {
+	.owner		= THIS_MODULE,
+	.drv		= {
+		.name	= "airo_cs",
+	},
+	.attach		= airo_attach,
+	.detach		= airo_detach,
+};
 
 static int airo_cs_init(void)
 {
-	servinfo_t serv;
-	DEBUG(0, "%s\n", version);
-	CardServices(GetCardServicesInfo, &serv);
-	if (serv.Revision != CS_RELEASE_CODE) {
-		printk(KERN_NOTICE "airo_cs: Card Services release "
-		       "does not match!\n");
-		return -1;
-	}
-	register_pcmcia_driver(&dev_info, &airo_attach, &airo_detach);
-	return 0;
+	return pcmcia_register_driver(&airo_driver);
 }
 
 static void airo_cs_cleanup(void)
 {
-	DEBUG(0, "airo_cs: unloading\n");
-	unregister_pcmcia_driver(&dev_info);
+	pcmcia_unregister_driver(&airo_driver);
+
+	/* XXX: this really needs to move into generic code.. */
 	while (dev_list != NULL) {
 		if (dev_list->state & DEV_CONFIG)
 			airo_release((u_long)dev_list);
--- 1.15/drivers/net/wireless/ray_cs.c	Tue Feb 18 20:22:50 2003
+++ edited/drivers/net/wireless/ray_cs.c	Sun Mar 23 11:27:36 2003
@@ -2962,12 +2962,21 @@
 }
 #endif
 
+static struct pcmcia_driver ray_driver = {
+	.owner		= THIS_MODULE,
+	.drv		= {
+		.name	= "ray_cs",
+	},
+	.attach		= ray_attach,
+	.detach		= ray_detach,
+};
+
 static int __init init_ray_cs(void)
 {
     int rc;
     
     DEBUG(1, "%s\n", rcsid);
-    rc = register_pcmcia_driver(&dev_info, &ray_attach, &ray_detach);
+    rc = pcmcia_register_driver(&ray_driver);
     DEBUG(1, "raylink init_module register_pcmcia_driver returns 0x%x\n",rc);
 
 #ifdef CONFIG_PROC_FS
@@ -2993,7 +3002,7 @@
     remove_proc_entry("ray_cs", proc_root_driver);
 #endif
 
-    unregister_pcmcia_driver(&dev_info);
+    pcmcia_unregister_driver(&ray_driver);
     while (dev_list != NULL)
         ray_detach(dev_list);
 
--- 1.17/drivers/scsi/pcmcia/nsp_cs.c	Wed Feb 26 15:18:50 2003
+++ edited/drivers/scsi/pcmcia/nsp_cs.c	Sun Mar 23 11:30:39 2003
@@ -1987,32 +1987,26 @@
 	return 0;
 } /* nsp_cs_event */
 
-/*======================================================================*
- *	module entry point
- *====================================================================*/
+static struct pcmcia_driver nsp_driver = {
+	.owner		= THIS_MODULE,
+	.drv		= {
+		.name	= "nsp_cs",
+	},
+	.attach		= nsp_cs_attach,
+	.detach		= nsp_cs_detach,
+};
+
 static int __init nsp_cs_init(void)
 {
-	servinfo_t serv;
-
-	DEBUG(0, "%s: in\n", __FUNCTION__);
-	DEBUG(0, "%s\n", version);
-	CardServices(GetCardServicesInfo, &serv);
-	if (serv.Revision != CS_RELEASE_CODE) {
-		printk(KERN_DEBUG "nsp_cs: Card Services release "
-		       "does not match!\n");
-		return -1;
-	}
-	register_pcmcia_driver(&dev_info, &nsp_cs_attach, &nsp_cs_detach);
-
-	DEBUG(0, "%s: out\n", __FUNCTION__);
-	return 0;
+	return pcmcia_register_driver(&nsp_driver);
 }
 
 
-static void __exit nsp_cs_cleanup(void)
+static void __exit nsp_cs_exit(void)
 {
-	DEBUG(0, "%s: unloading\n", __FUNCTION__);
-	unregister_pcmcia_driver(&dev_info);
+	pcmcia_unregister_driver(&nsp_driver);
+
+	/* XXX: this really needs to move into generic code.. */
 	while (dev_list != NULL) {
 		if (dev_list->state & DEV_CONFIG) {
 			nsp_cs_release((u_long)dev_list);
@@ -2022,11 +2016,4 @@
 }
 
 module_init(nsp_cs_init)
-module_exit(nsp_cs_cleanup)
-
-/*
- *
- *
- */
-
-/* end */
+module_exit(nsp_cs_exit)
--- 1.3/drivers/telephony/ixj_pcmcia.c	Sun Feb  2 16:40:35 2003
+++ edited/drivers/telephony/ixj_pcmcia.c	Sun Mar 23 11:34:31 2003
@@ -310,29 +310,30 @@
 	return 0;
 }
 
-int __init ixj_register_pcmcia(void)
+static struct pcmcia_driver ixj_driver = {
+	.owner		= THIS_MODULE,
+	.drv		= {
+		.name	= "ixj_cs",
+	},
+	.attach		= ixj_attach,
+	.detach		= ixj_detach,
+};
+
+static int __init ixj_pcmcia_init(void)
 {
-	servinfo_t serv;
-	DEBUG(0, "%s\n", version);
-	CardServices(GetCardServicesInfo, &serv);
-	if (serv.Revision != CS_RELEASE_CODE) {
-		printk(KERN_NOTICE "ixj_cs: Card Services release does not match!\n");
-		return -EINVAL;
-	}
-	register_pcmcia_driver(&dev_info, &ixj_attach, &ixj_detach);
-	return 0;
+	return pcmcia_register_driver(&ixj_driver);
 }
 
-static void ixj_pcmcia_unload(void)
+static void ixj_pcmcia_exit(void)
 {
-	DEBUG(0, "ixj_cs: unloading\n");
-	unregister_pcmcia_driver(&dev_info);
+	pcmcia_unregister_driver(&ixj_driver);
+
+	/* XXX: this really needs to move into generic code.. */
 	while (dev_list != NULL)
 		ixj_detach(dev_list);
 }
 
-module_init(ixj_register_pcmcia);
-module_exit(ixj_pcmcia_unload);
+module_init(ixj_pcmcia_init);
+module_exit(ixj_pcmcia_exit);
 
 MODULE_LICENSE("GPL");
-
--- 1.5/include/pcmcia/ds.h	Sat Mar 22 10:51:43 2003
+++ edited/include/pcmcia/ds.h	Sun Mar 23 11:34:47 2003
@@ -141,9 +141,6 @@
 
 int unregister_pccard_driver(dev_info_t *dev_info);
 
-#define register_pcmcia_driver register_pccard_driver
-#define unregister_pcmcia_driver unregister_pccard_driver
-
 extern struct bus_type pcmcia_bus_type;
 
 struct pcmcia_driver {
