Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262791AbTCVPwr>; Sat, 22 Mar 2003 10:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262802AbTCVPvv>; Sat, 22 Mar 2003 10:51:51 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:27572 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262796AbTCVPvc>; Sat, 22 Mar 2003 10:51:32 -0500
Date: Sat, 22 Mar 2003 17:00:50 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5] pcmcia (3/5): register drivers with bus
Message-ID: <20030322160050.GC12342@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Register all pcmcia drivers with the pcmcia bus within the old
register_pccard_driver() function. Alternatively, a new
registration function "pcmcia_register_driver()" (and its
counterpart,  "pcmcia_unregister_driver()") can be used.

diff -ruN linux-original/drivers/pcmcia/ds.c linux/drivers/pcmcia/ds.c
--- linux-original/drivers/pcmcia/ds.c	2003-03-22 16:48:49.000000000 +0100
+++ linux/drivers/pcmcia/ds.c	2003-03-22 16:50:43.000000000 +0100
@@ -77,16 +77,8 @@
 
 /*====================================================================*/
 
-typedef struct driver_info_t {
-    dev_info_t		dev_info;
-    int			use_count, status;
-    dev_link_t		*(*attach)(void);
-    void		(*detach)(dev_link_t *);
-    struct driver_info_t *next;
-} driver_info_t;
-
 typedef struct socket_bind_t {
-    driver_info_t	*driver;
+    struct pcmcia_driver	*driver;
     u_char		function;
     dev_link_t		*instance;
     struct socket_bind_t *next;
@@ -125,7 +117,7 @@
 static dev_info_t dev_info = "Driver Services";
 
 /* Linked list of all registered device drivers */
-static driver_info_t *root_driver = NULL;
+static struct pcmcia_driver *root_driver = NULL;
 
 static int sockets = 0, major_dev = -1;
 static socket_info_t *socket_table = NULL;
@@ -151,27 +143,67 @@
     
 ======================================================================*/
 
+/**
+ * pcmcia_register_driver - register a PCMCIA driver with the bus core
+ *
+ * Registers a PCMCIA driver with the PCMCIA bus core.
+ */
+int pcmcia_register_driver(struct pcmcia_driver *driver)
+{
+	if (!driver)
+		return -EINVAL;
+
+ 	driver->use_count = 0;
+ 	driver->status = init_status;
+	driver->drv.bus = &pcmcia_bus_type;
+	driver->next = root_driver;
+	root_driver = driver;
+
+	return driver_register(&driver->drv);
+}
+EXPORT_SYMBOL(pcmcia_register_driver);
+
+/**
+ * pcmcia_unregister_driver - unregister a PCMCIA driver with the bus core
+ */
+void pcmcia_unregister_driver(struct pcmcia_driver *driver)
+{
+	socket_bind_t *b;
+	int i;
+
+	if (driver->use_count > 0) {
+		/* Blank out any left-over device instances */
+		driver->attach = NULL; driver->detach = NULL;
+		for (i = 0; i < sockets; i++)
+			for (b = socket_table[i].bind; b; b = b->next)
+				if (b->driver == driver) 
+				b->instance = NULL;
+ 	}
+
+	driver_unregister(&driver->drv);
+}
+EXPORT_SYMBOL(pcmcia_unregister_driver);
+ 
+
 int register_pccard_driver(dev_info_t *dev_info,
 			   dev_link_t *(*attach)(void),
 			   void (*detach)(dev_link_t *))
 {
-    driver_info_t *driver;
+    struct pcmcia_driver *driver;
     socket_bind_t *b;
     int i;
 
     DEBUG(0, "ds: register_pccard_driver('%s')\n", (char *)dev_info);
     for (driver = root_driver; driver; driver = driver->next)
-	if (strncmp((char *)dev_info, (char *)driver->dev_info,
+	if (strncmp((char *)dev_info, (char *)driver->drv.name,
 		    DEV_NAME_LEN) == 0)
 	    break;
     if (!driver) {
-	driver = kmalloc(sizeof(driver_info_t), GFP_KERNEL);
+	driver = kmalloc(sizeof(struct pcmcia_driver), GFP_KERNEL);
 	if (!driver) return -ENOMEM;
-	strncpy(driver->dev_info, (char *)dev_info, DEV_NAME_LEN);
-	driver->use_count = 0;
-	driver->status = init_status;
-	driver->next = root_driver;
-	root_driver = driver;
+	memset(driver, 0, sizeof(struct pcmcia_driver));
+	driver->drv.name = (char *)dev_info;
+	pcmcia_register_driver(driver);
     }
 
     driver->attach = attach;
@@ -185,7 +217,7 @@
 	    b->instance = driver->attach();
 	    if (b->instance == NULL)
 		printk(KERN_NOTICE "ds: unable to create instance "
-		       "of '%s'!\n", driver->dev_info);
+		       "of '%s'!\n", driver->drv.name);
 	}
     
     return 0;
@@ -195,29 +227,18 @@
 
 int unregister_pccard_driver(dev_info_t *dev_info)
 {
-    driver_info_t *target, **d = &root_driver;
-    socket_bind_t *b;
-    int i;
+    struct pcmcia_driver **d = &root_driver;
     
     DEBUG(0, "ds: unregister_pccard_driver('%s')\n",
 	  (char *)dev_info);
-    while ((*d) && (strncmp((*d)->dev_info, (char *)dev_info,
+    while ((*d) && (strncmp((*d)->drv.name, (char *)dev_info,
 			    DEV_NAME_LEN) != 0))
 	d = &(*d)->next;
     if (*d == NULL)
 	return -ENODEV;
     
-    target = *d;
-    if (target->use_count == 0) {
-	*d = target->next;
-	kfree(target);
-    } else {
-	/* Blank out any left-over device instances */
-	target->attach = NULL; target->detach = NULL;
-	for (i = 0; i < sockets; i++)
-	    for (b = socket_table[i].bind; b; b = b->next)
-		if (b->driver == target) b->instance = NULL;
-    }
+    pcmcia_unregister_driver(*d);
+    kfree(*d);
     return 0;
 } /* unregister_pccard_driver */
 
@@ -227,10 +248,10 @@
 static int proc_read_drivers(char *buf, char **start, off_t pos,
 			     int count, int *eof, void *data)
 {
-    driver_info_t *d;
+    struct pcmcia_driver *d;
     char *p = buf;
     for (d = root_driver; d; d = d->next)
-	p += sprintf(p, "%-24.24s %d %d\n", d->dev_info,
+	p += sprintf(p, "%-24.24s %d %d\n", d->drv.name,
 		     d->status, d->use_count);
     return (p - buf);
 }
@@ -376,7 +397,7 @@
 
 static int bind_request(int i, bind_info_t *bind_info)
 {
-    struct driver_info_t *driver;
+    struct pcmcia_driver *driver;
     socket_bind_t *b;
     bind_req_t bind_req;
     socket_info_t *s = &socket_table[i];
@@ -385,17 +406,15 @@
     DEBUG(2, "bind_request(%d, '%s')\n", i,
 	  (char *)bind_info->dev_info);
     for (driver = root_driver; driver; driver = driver->next)
-	if (strcmp((char *)driver->dev_info,
+	if (strcmp((char *)driver->drv.name,
 		   (char *)bind_info->dev_info) == 0)
 	    break;
     if (driver == NULL) {
-	driver = kmalloc(sizeof(driver_info_t), GFP_KERNEL);
+	driver = kmalloc(sizeof(struct pcmcia_driver), GFP_KERNEL);
 	if (!driver) return -ENOMEM;
-	strncpy(driver->dev_info, bind_info->dev_info, DEV_NAME_LEN);
-	driver->use_count = 0;
-	driver->next = root_driver;
-	driver->attach = NULL; driver->detach = NULL;
-	root_driver = driver;
+	memset(driver, 0, sizeof(struct pcmcia_driver));
+	driver->drv.name = bind_info->dev_info;
+	pcmcia_register_driver(driver);
     }
 
     for (b = s->bind; b; b = b->next)
@@ -409,7 +428,7 @@
 
     bind_req.Socket = i;
     bind_req.Function = bind_info->function;
-    bind_req.dev_info = &driver->dev_info;
+    bind_req.dev_info = (dev_info_t *) driver->drv.name;
     ret = pcmcia_bind_device(&bind_req);
     if (ret != CS_SUCCESS) {
 	cs_error(NULL, BindDevice, ret);
@@ -490,7 +509,7 @@
 #endif
 
     for (b = s->bind; b; b = b->next)
-	if ((strcmp((char *)b->driver->dev_info,
+	if ((strcmp((char *)b->driver->drv.name,
 		    (char *)bind_info->dev_info) == 0) &&
 	    (b->function == bind_info->function))
 	    break;
@@ -524,7 +543,7 @@
     DEBUG(2, "unbind_request(%d, '%s')\n", i,
 	  (char *)bind_info->dev_info);
     for (b = &s->bind; *b; b = &(*b)->next)
-	if ((strcmp((char *)(*b)->driver->dev_info,
+	if ((strcmp((char *)(*b)->driver->drv.name,
 		    (char *)bind_info->dev_info) == 0) &&
 	    ((*b)->function == bind_info->function))
 	    break;
@@ -538,10 +557,11 @@
 	    c->driver->detach(c->instance);
     } else {
 	if (c->driver->use_count == 0) {
-	    driver_info_t **d;
+	    struct pcmcia_driver **d;
 	    for (d = &root_driver; *d; d = &((*d)->next))
 		if (c->driver == *d) break;
 	    *d = (*d)->next;
+	    pcmcia_unregister_driver(c->driver);
 	    kfree(c->driver);
 	}
     }
diff -ruN linux-original/include/pcmcia/ds.h linux/include/pcmcia/ds.h
--- linux-original/include/pcmcia/ds.h	2003-03-22 16:48:49.000000000 +0100
+++ linux/include/pcmcia/ds.h	2003-03-22 16:46:21.000000000 +0100
@@ -146,6 +146,18 @@
 
 extern struct bus_type pcmcia_bus_type;
 
+struct pcmcia_driver {
+	int			use_count, status;
+	dev_link_t		*(*attach)(void);
+	void			(*detach)(dev_link_t *);
+	struct module		*owner;
+	struct device_driver	drv;
+	struct pcmcia_driver	*next;
+};
+
+int pcmcia_register_driver(struct pcmcia_driver *driver);
+void pcmcia_unregister_driver(struct pcmcia_driver *driver);
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_DS_H */
