Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265815AbTB0SKW>; Thu, 27 Feb 2003 13:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbTB0SKW>; Thu, 27 Feb 2003 13:10:22 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:2778 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S265815AbTB0SKO>; Thu, 27 Feb 2003 13:10:14 -0500
Date: Thu, 27 Feb 2003 19:19:10 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH UPDATED] pcmcia: bus_type pcmcia_bus_type, pcmcia-drivers
Message-ID: <20030227181910.GA12770@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new bus_type pcmcia_bus_type, and registers all pcmcia
drivers with this bus. Alternatively, new registration functions,
"pcmcia_register_driver()" and "pcmcia_unregister_driver()", are offered.
The pcnet_cs.c driver is converted as an example.

Please apply,

	Dominik

diff -ruN linux-original/drivers/net/pcmcia/pcnet_cs.c linux/drivers/net/pcmcia/pcnet_cs.c
--- linux-original/drivers/net/pcmcia/pcnet_cs.c	2003-02-27 18:55:06.000000000 +0100
+++ linux/drivers/net/pcmcia/pcnet_cs.c	2003-02-27 19:03:57.000000000 +0100
@@ -1617,6 +1617,13 @@
 
 /*====================================================================*/
 
+static struct pcmcia_driver pcnet_driver = {
+	.drv.name	= "pcnet_cs",
+	.attach		= pcnet_attach,
+	.detach		= pcnet_detach,
+	.owner		= THIS_MODULE,
+};
+
 static int __init init_pcnet_cs(void)
 {
     servinfo_t serv;
@@ -1627,14 +1634,14 @@
 	       "does not match!\n");
 	return -EINVAL;
     }
-    register_pccard_driver(&dev_info, &pcnet_attach, &pcnet_detach);
+    pcmcia_register_driver(&pcnet_driver);
     return 0;
 }
 
 static void __exit exit_pcnet_cs(void)
 {
     DEBUG(0, "pcnet_cs: unloading\n");
-    unregister_pccard_driver(&dev_info);
+    pcmcia_unregister_driver(&pcnet_driver);
     while (dev_list != NULL)
 	pcnet_detach(dev_list);
 }
diff -ruN linux-original/drivers/pcmcia/ds.c linux/drivers/pcmcia/ds.c
--- linux-original/drivers/pcmcia/ds.c	2003-02-27 18:55:16.000000000 +0100
+++ linux/drivers/pcmcia/ds.c	2003-02-27 19:12:44.000000000 +0100
@@ -77,19 +77,11 @@
 
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
-    u_char		function;
-    dev_link_t		*instance;
-    struct socket_bind_t *next;
+	struct pcmcia_driver	*driver;
+	u_char			function;
+	dev_link_t		*instance;
+	struct socket_bind_t *next;
 } socket_bind_t;
 
 /* Device user information */
@@ -124,9 +116,6 @@
 /* Device driver ID passed to Card Services */
 static dev_info_t dev_info = "Driver Services";
 
-/* Linked list of all registered device drivers */
-static driver_info_t *root_driver = NULL;
-
 static int sockets = 0, major_dev = -1;
 static socket_info_t *socket_table = NULL;
 
@@ -143,96 +132,74 @@
     pcmcia_report_error(handle, &err);
 }
 
-/*======================================================================
+static struct pcmcia_driver * get_pcmcia_driver (dev_info_t *dev_info);
 
-    Register_pccard_driver() and unregister_pccard_driver() are used
-    tell Driver Services that a PC Card client driver is available to
-    be bound to sockets.
-    
-======================================================================*/
 
-int register_pccard_driver(dev_info_t *dev_info,
-			   dev_link_t *(*attach)(void),
-			   void (*detach)(dev_link_t *))
+/**
+ * pcmcia_register_driver - register a PCMCIA driver with the bus core
+ *
+ * Registers a PCMCIA driver with the PCMCIA bus core.
+ */
+int pcmcia_register_driver(struct pcmcia_driver *driver)
 {
-    driver_info_t *driver;
-    socket_bind_t *b;
-    int i;
-
-    DEBUG(0, "ds: register_pccard_driver('%s')\n", (char *)dev_info);
-    for (driver = root_driver; driver; driver = driver->next)
-	if (strncmp((char *)dev_info, (char *)driver->dev_info,
-		    DEV_NAME_LEN) == 0)
-	    break;
-    if (!driver) {
-	driver = kmalloc(sizeof(driver_info_t), GFP_KERNEL);
-	if (!driver) return -ENOMEM;
-	strncpy(driver->dev_info, (char *)dev_info, DEV_NAME_LEN);
+	if (!driver)
+		return -EINVAL;
 	driver->use_count = 0;
 	driver->status = init_status;
-	driver->next = root_driver;
-	root_driver = driver;
-    }
+	driver->drv.bus = &pcmcia_bus_type;
 
-    driver->attach = attach;
-    driver->detach = detach;
-    if (driver->use_count == 0) return 0;
-    
-    /* Instantiate any already-bound devices */
-    for (i = 0; i < sockets; i++)
-	for (b = socket_table[i].bind; b; b = b->next) {
-	    if (b->driver != driver) continue;
-	    b->instance = driver->attach();
-	    if (b->instance == NULL)
-		printk(KERN_NOTICE "ds: unable to create instance "
-		       "of '%s'!\n", driver->dev_info);
+	return driver_register(&driver->drv);
+}
+EXPORT_SYMBOL(pcmcia_register_driver);
+
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
+					b->instance = NULL;
 	}
-    
-    return 0;
-} /* register_pccard_driver */
+	
+	driver_unregister(&driver->drv);
+}
+EXPORT_SYMBOL(pcmcia_unregister_driver);
+
 
 /*====================================================================*/
 
-int unregister_pccard_driver(dev_info_t *dev_info)
+#ifdef CONFIG_PROC_FS
+static int proc_read_drivers_callback(struct device_driver *driver, void *d)
 {
-    driver_info_t *target, **d = &root_driver;
-    socket_bind_t *b;
-    int i;
-    
-    DEBUG(0, "ds: unregister_pccard_driver('%s')\n",
-	  (char *)dev_info);
-    while ((*d) && (strncmp((*d)->dev_info, (char *)dev_info,
-			    DEV_NAME_LEN) != 0))
-	d = &(*d)->next;
-    if (*d == NULL)
-	return -ENODEV;
-    
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
-    return 0;
-} /* unregister_pccard_driver */
+	char **p = d;
+	struct pcmcia_driver *p_dev = container_of(driver, 
+						   struct pcmcia_driver, drv);
+
+	*p += sprintf(*p, "%-24.24s %d %d\n", driver->name, p_dev->status,
+		     p_dev->use_count);
+	d = (void *) p;
 
-/*====================================================================*/
+	return 0;
+}
 
-#ifdef CONFIG_PROC_FS
 static int proc_read_drivers(char *buf, char **start, off_t pos,
 			     int count, int *eof, void *data)
 {
-    driver_info_t *d;
-    char *p = buf;
-    for (d = root_driver; d; d = d->next)
-	p += sprintf(p, "%-24.24s %d %d\n", d->dev_info,
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
 
@@ -376,7 +343,7 @@
 
 static int bind_request(int i, bind_info_t *bind_info)
 {
-    struct driver_info_t *driver;
+    struct pcmcia_driver *driver;
     socket_bind_t *b;
     bind_req_t bind_req;
     socket_info_t *s = &socket_table[i];
@@ -384,18 +351,15 @@
 
     DEBUG(2, "bind_request(%d, '%s')\n", i,
 	  (char *)bind_info->dev_info);
-    for (driver = root_driver; driver; driver = driver->next)
-	if (strcmp((char *)driver->dev_info,
-		   (char *)bind_info->dev_info) == 0)
-	    break;
+    driver = get_pcmcia_driver(&bind_info->dev_info);
     if (driver == NULL) {
-	driver = kmalloc(sizeof(driver_info_t), GFP_KERNEL);
-	if (!driver) return -ENOMEM;
-	strncpy(driver->dev_info, bind_info->dev_info, DEV_NAME_LEN);
-	driver->use_count = 0;
-	driver->next = root_driver;
-	driver->attach = NULL; driver->detach = NULL;
-	root_driver = driver;
+	    driver = kmalloc(sizeof(struct pcmcia_driver), GFP_KERNEL);
+	    if (!driver) 
+		    return -ENOMEM;
+	    memset(driver, 0, sizeof(struct pcmcia_driver));
+
+	    driver->drv.name = bind_info->dev_info;
+	    pcmcia_register_driver(driver);
     }
 
     for (b = s->bind; b; b = b->next)
@@ -409,7 +373,7 @@
 
     bind_req.Socket = i;
     bind_req.Function = bind_info->function;
-    bind_req.dev_info = &driver->dev_info;
+    bind_req.dev_info = (dev_info_t *) driver->drv.name;
     ret = pcmcia_bind_device(&bind_req);
     if (ret != CS_SUCCESS) {
 	cs_error(NULL, BindDevice, ret);
@@ -490,7 +454,7 @@
 #endif
 
     for (b = s->bind; b; b = b->next)
-	if ((strcmp((char *)b->driver->dev_info,
+	if ((strcmp((char *)b->driver->drv.name,
 		    (char *)bind_info->dev_info) == 0) &&
 	    (b->function == bind_info->function))
 	    break;
@@ -524,7 +488,7 @@
     DEBUG(2, "unbind_request(%d, '%s')\n", i,
 	  (char *)bind_info->dev_info);
     for (b = &s->bind; *b; b = &(*b)->next)
-	if ((strcmp((char *)(*b)->driver->dev_info,
+	if ((strcmp((char *)(*b)->driver->drv.name,
 		    (char *)bind_info->dev_info) == 0) &&
 	    ((*b)->function == bind_info->function))
 	    break;
@@ -536,14 +500,6 @@
     if (c->driver->detach) {
 	if (c->instance)
 	    c->driver->detach(c->instance);
-    } else {
-	if (c->driver->use_count == 0) {
-	    driver_info_t **d;
-	    for (d = &root_driver; *d; d = &((*d)->next))
-		if (c->driver == *d) break;
-	    *d = (*d)->next;
-	    kfree(c->driver);
-	}
     }
     *b = c->next;
     kfree(c);
@@ -876,11 +832,20 @@
 	.poll		= ds_poll,
 };
 
-EXPORT_SYMBOL(register_pccard_driver);
-EXPORT_SYMBOL(unregister_pccard_driver);
 
 /*====================================================================*/
 
+struct bus_type pcmcia_bus_type = {
+	.name = "pcmcia",
+};
+EXPORT_SYMBOL(pcmcia_bus_type);
+
+static int __init init_pcmcia_bus(void)
+{
+	bus_register(&pcmcia_bus_type);
+	return 0;
+}
+
 int __init init_pcmcia_ds(void)
 {
     client_reg_t client_reg;
@@ -967,11 +932,7 @@
     return 0;
 }
 
-late_initcall(init_pcmcia_ds);
-
-#ifdef MODULE
-
-void __exit cleanup_module(void)
+static void __exit exit_pcmcia_ds(void)
 {
     int i;
 #ifdef CONFIG_PROC_FS
@@ -984,6 +945,109 @@
 	pcmcia_deregister_client(socket_table[i].handle);
     sockets = 0;
     kfree(socket_table);
+    bus_unregister(&pcmcia_bus_type);
 }
 
+#ifdef MODULE
+
+static int __init init_pcmcia_module(void) {
+	init_pcmcia_bus();
+	return init_pcmcia_ds();
+}
+
+module_init(init_pcmcia_module);
+
+#else
+subsys_initcall(init_pcmcia_bus);
+late_initcall(init_pcmcia_ds);
 #endif
+
+module_exit(exit_pcmcia_ds);
+
+
+/* backwards-compatible functions */
+
+int register_pccard_driver(dev_info_t *dev_info,
+			   dev_link_t *(*attach)(void),
+			   void (*detach)(dev_link_t *))
+{
+	struct pcmcia_driver *driver;
+	socket_bind_t *b;
+	int i;
+
+	DEBUG(0, "ds: register_pccard_driver('%s')\n", (char *)dev_info);
+	driver = get_pcmcia_driver(dev_info);
+	if (!driver) {
+		driver = kmalloc(sizeof(struct pcmcia_driver), GFP_KERNEL);
+		if (!driver) 
+			return -ENOMEM;
+		memset(driver, 0, sizeof(struct pcmcia_driver));
+		driver->drv.name = (char *)dev_info;
+		pcmcia_register_driver(driver);
+	}
+
+	driver->attach = attach;
+	driver->detach = detach;
+	if (driver->use_count == 0) 
+		return 0;
+    
+	/* Instantiate any already-bound devices */
+	for (i = 0; i < sockets; i++)
+		for (b = socket_table[i].bind; b; b = b->next) {
+			if (b->driver != driver) 
+				continue;
+			b->instance = driver->attach();
+			if (b->instance == NULL)
+				printk(KERN_NOTICE "ds: unable to create instance "
+				       "of '%s'!\n", driver->drv.name);
+		}
+
+	return 0;
+} /* register_pccard_driver */
+EXPORT_SYMBOL(register_pccard_driver);
+
+int unregister_pccard_driver(dev_info_t *dev_info)
+{
+	struct pcmcia_driver *driver;
+    
+	DEBUG(0, "ds: unregister_pccard_driver('%s')\n",
+	      (char *)dev_info);
+	driver = get_pcmcia_driver(dev_info);
+	if (!driver)
+		return -ENODEV;
+
+	pcmcia_unregister_driver(driver);
+	kfree(driver);
+	return 0;
+} /* unregister_pccard_driver */
+EXPORT_SYMBOL(unregister_pccard_driver);
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
+	struct cmp_data cmp;
+	cmp.dev_info = dev_info;
+
+	ret = bus_for_each_drv(&pcmcia_bus_type, NULL, &cmp, cmp_drv_callback);
+	if (ret)
+		return cmp.drv;
+	return NULL;
+}
diff -ruN linux-original/include/pcmcia/ds.h linux/include/pcmcia/ds.h
--- linux-original/include/pcmcia/ds.h	2003-02-27 18:55:19.000000000 +0100
+++ linux/include/pcmcia/ds.h	2003-02-27 19:03:57.000000000 +0100
@@ -143,6 +143,22 @@
 #define register_pcmcia_driver register_pccard_driver
 #define unregister_pcmcia_driver unregister_pccard_driver
 
+#include <linux/device.h>
+
+extern struct bus_type pcmcia_bus_type;
+
+struct pcmcia_driver {
+	int			use_count, status;
+	dev_link_t		*(*attach)(void);
+	void			(*detach)(dev_link_t *);
+	struct module		*owner;
+	struct device_driver	drv;
+};
+
+int pcmcia_register_driver(struct pcmcia_driver *driver);
+void pcmcia_unregister_driver(struct pcmcia_driver *driver);
+
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_DS_H */
