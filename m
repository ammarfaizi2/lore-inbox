Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbTCVPww>; Sat, 22 Mar 2003 10:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbTCVPwF>; Sat, 22 Mar 2003 10:52:05 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:26292 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262791AbTCVPvc>; Sat, 22 Mar 2003 10:51:32 -0500
Date: Sat, 22 Mar 2003 17:01:08 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5] pcmcia (4/5): remove single linked list of drivers
Message-ID: <20030322160108.GD12342@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the linked list of pcmcia_drivers. It didn't even handle removal of a
driver properly, so it won't be missed all that much.

	Dominik

diff -ruN linux-original/drivers/pcmcia/ds.c linux/drivers/pcmcia/ds.c
--- linux-original/drivers/pcmcia/ds.c	2003-03-22 16:51:20.000000000 +0100
+++ linux/drivers/pcmcia/ds.c	2003-03-22 16:54:06.000000000 +0100
@@ -116,9 +116,6 @@
 /* Device driver ID passed to Card Services */
 static dev_info_t dev_info = "Driver Services";
 
-/* Linked list of all registered device drivers */
-static struct pcmcia_driver *root_driver = NULL;
-
 static int sockets = 0, major_dev = -1;
 static socket_info_t *socket_table = NULL;
 
@@ -135,13 +132,9 @@
     pcmcia_report_error(handle, &err);
 }
 
-/*======================================================================
+/*======================================================================*/
 
-    Register_pccard_driver() and unregister_pccard_driver() are used
-    tell Driver Services that a PC Card client driver is available to
-    be bound to sockets.
-    
-======================================================================*/
+static struct pcmcia_driver * get_pcmcia_driver (dev_info_t *dev_info);
 
 /**
  * pcmcia_register_driver - register a PCMCIA driver with the bus core
@@ -156,8 +149,6 @@
  	driver->use_count = 0;
  	driver->status = init_status;
 	driver->drv.bus = &pcmcia_bus_type;
-	driver->next = root_driver;
-	root_driver = driver;
 
 	return driver_register(&driver->drv);
 }
@@ -177,13 +168,13 @@
 		for (i = 0; i < sockets; i++)
 			for (b = socket_table[i].bind; b; b = b->next)
 				if (b->driver == driver) 
-				b->instance = NULL;
+					b->instance = NULL;
  	}
 
 	driver_unregister(&driver->drv);
 }
 EXPORT_SYMBOL(pcmcia_unregister_driver);
- 
+
 
 int register_pccard_driver(dev_info_t *dev_info,
 			   dev_link_t *(*attach)(void),
@@ -194,10 +185,7 @@
     int i;
 
     DEBUG(0, "ds: register_pccard_driver('%s')\n", (char *)dev_info);
-    for (driver = root_driver; driver; driver = driver->next)
-	if (strncmp((char *)dev_info, (char *)driver->drv.name,
-		    DEV_NAME_LEN) == 0)
-	    break;
+    driver = get_pcmcia_driver(dev_info);
     if (!driver) {
 	driver = kmalloc(sizeof(struct pcmcia_driver), GFP_KERNEL);
 	if (!driver) return -ENOMEM;
@@ -227,33 +215,45 @@
 
 int unregister_pccard_driver(dev_info_t *dev_info)
 {
-    struct pcmcia_driver **d = &root_driver;
-    
+    struct pcmcia_driver *driver;
+
     DEBUG(0, "ds: unregister_pccard_driver('%s')\n",
 	  (char *)dev_info);
-    while ((*d) && (strncmp((*d)->drv.name, (char *)dev_info,
-			    DEV_NAME_LEN) != 0))
-	d = &(*d)->next;
-    if (*d == NULL)
+
+    driver = get_pcmcia_driver(dev_info);
+    if (!driver)
 	return -ENODEV;
     
-    pcmcia_unregister_driver(*d);
-    kfree(*d);
+    pcmcia_unregister_driver(driver);
+    kfree(driver);
     return 0;
 } /* unregister_pccard_driver */
 
 /*====================================================================*/
 
 #ifdef CONFIG_PROC_FS
+static int proc_read_drivers_callback(struct device_driver *driver, void *d)
+{
+	char **p = d;
+	struct pcmcia_driver *p_dev = container_of(driver, 
+						   struct pcmcia_driver, drv);
+
+	*p += sprintf(*p, "%-24.24s %d %d\n", driver->name, p_dev->status,
+		     p_dev->use_count);
+	d = (void *) p;
+
+	return 0;
+}
+
 static int proc_read_drivers(char *buf, char **start, off_t pos,
 			     int count, int *eof, void *data)
 {
-    struct pcmcia_driver *d;
-    char *p = buf;
-    for (d = root_driver; d; d = d->next)
-	p += sprintf(p, "%-24.24s %d %d\n", d->drv.name,
-		     d->status, d->use_count);
-    return (p - buf);
+	char *p = buf;
+
+	bus_for_each_drv(&pcmcia_bus_type, NULL, 
+			 (void *) &p, proc_read_drivers_callback);
+
+	return (p - buf);
 }
 #endif
 
@@ -405,10 +405,7 @@
 
     DEBUG(2, "bind_request(%d, '%s')\n", i,
 	  (char *)bind_info->dev_info);
-    for (driver = root_driver; driver; driver = driver->next)
-	if (strcmp((char *)driver->drv.name,
-		   (char *)bind_info->dev_info) == 0)
-	    break;
+    driver = get_pcmcia_driver(&bind_info->dev_info);
     if (driver == NULL) {
 	driver = kmalloc(sizeof(struct pcmcia_driver), GFP_KERNEL);
 	if (!driver) return -ENOMEM;
@@ -555,15 +552,6 @@
     if (c->driver->detach) {
 	if (c->instance)
 	    c->driver->detach(c->instance);
-    } else {
-	if (c->driver->use_count == 0) {
-	    struct pcmcia_driver **d;
-	    for (d = &root_driver; *d; d = &((*d)->next))
-		if (c->driver == *d) break;
-	    *d = (*d)->next;
-	    pcmcia_unregister_driver(c->driver);
-	    kfree(c->driver);
-	}
     }
     *b = c->next;
     kfree(c);
@@ -1032,3 +1020,37 @@
 #endif
 
 module_exit(exit_pcmcia_ds);
+
+
+/* helpers for backwards-compatible functions */
+
+/* backwards-compatible accessing of driver --- by name! */
+
+struct cmp_data {
+	void *dev_info;
+	struct pcmcia_driver *drv;
+};
+
+static int cmp_drv_callback(struct device_driver *drv, void *data)
+{
+	struct cmp_data *cmp = data;
+	if (strncmp((char *)cmp->dev_info, (char *)drv->name,
+		    DEV_NAME_LEN) == 0) {
+		cmp->drv = container_of(drv, struct pcmcia_driver, drv);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static struct pcmcia_driver * get_pcmcia_driver (dev_info_t *dev_info)
+{
+	int ret;
+	struct cmp_data cmp = {
+		.dev_info = dev_info,
+	};
+	
+	ret = bus_for_each_drv(&pcmcia_bus_type, NULL, &cmp, cmp_drv_callback);
+	if (ret)
+		return cmp.drv;
+	return NULL;
+}
diff -ruN linux-original/include/pcmcia/ds.h linux/include/pcmcia/ds.h
--- linux-original/include/pcmcia/ds.h	2003-03-22 16:51:20.000000000 +0100
+++ linux/include/pcmcia/ds.h	2003-03-22 16:51:43.000000000 +0100
@@ -152,7 +152,6 @@
 	void			(*detach)(dev_link_t *);
 	struct module		*owner;
 	struct device_driver	drv;
-	struct pcmcia_driver	*next;
 };
 
 int pcmcia_register_driver(struct pcmcia_driver *driver);
