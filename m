Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269035AbTCAV1O>; Sat, 1 Mar 2003 16:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269036AbTCAV1O>; Sat, 1 Mar 2003 16:27:14 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:38391 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S269035AbTCAV1F>; Sat, 1 Mar 2003 16:27:05 -0500
Date: Sat, 1 Mar 2003 22:33:28 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [UPDATED PATCH] pcmcia: add bus_type pcmcia_bus_type, struct pcmcia_driver
Message-ID: <20030301213328.GA4480@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new bus_type pcmcia_bus_type, and registers all pcmcia
drivers with this bus within the old register_pccard_driver()
function. 

Alternatively, a new registration function "pcmcia_register_driver()"
(and its counterpart,  "pcmcia_unregister_driver()") can be used --
the pcnet_cs.c driver is converted as an example.

This updated version fixes the compilation breakage seen with gcc-2.95.3
because of incompatible C99 initializers (sorry, Russell). 

Please apply,
       Dominik

 drivers/net/pcmcia/pcnet_cs.c |   13 ++
 drivers/pcmcia/ds.c           |  224 +++++++++++++++++++++++++++---------------
 include/pcmcia/ds.h           |   15 ++
 3 files changed, 175 insertions(+), 77 deletions(-)


diff -ruN linux-original/drivers/net/pcmcia/pcnet_cs.c linux/drivers/net/pcmcia/pcnet_cs.c
--- linux-original/drivers/net/pcmcia/pcnet_cs.c	2003-03-01 21:48:59.000000000 +0100
+++ linux/drivers/net/pcmcia/pcnet_cs.c	2003-03-01 21:50:47.000000000 +0100
@@ -1617,6 +1617,15 @@
 
 /*====================================================================*/
 
+static struct pcmcia_driver pcnet_driver = {
+	.drv		= {
+		.name	= "pcnet_cs",
+	},
+	.attach		= pcnet_attach,
+	.detach		= pcnet_detach,
+	.owner		= THIS_MODULE,
+};
+
 static int __init init_pcnet_cs(void)
 {
     servinfo_t serv;
@@ -1627,14 +1636,14 @@
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
--- linux-original/drivers/pcmcia/ds.c	2003-03-01 21:49:03.000000000 +0100
+++ linux/drivers/pcmcia/ds.c	2003-03-01 22:14:30.000000000 +0100
@@ -86,7 +86,7 @@
 } driver_info_t;
 
 typedef struct socket_bind_t {
-    driver_info_t	*driver;
+    struct pcmcia_driver *driver;
     u_char		function;
     dev_link_t		*instance;
     struct socket_bind_t *next;
@@ -124,9 +124,6 @@
 /* Device driver ID passed to Card Services */
 static dev_info_t dev_info = "Driver Services";
 
-/* Linked list of all registered device drivers */
-static driver_info_t *root_driver = NULL;
-
 static int sockets = 0, major_dev = -1;
 static socket_info_t *socket_table = NULL;
 
@@ -143,35 +140,65 @@
     pcmcia_report_error(handle, &err);
 }
 
-/*======================================================================
 
-    Register_pccard_driver() and unregister_pccard_driver() are used
-    tell Driver Services that a PC Card client driver is available to
-    be bound to sockets.
-    
-======================================================================*/
+static struct pcmcia_driver * get_pcmcia_driver (dev_info_t *dev_info);
+
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
+					b->instance = NULL;
+ 	}
+	
+	driver_unregister(&driver->drv);
+}
+EXPORT_SYMBOL(pcmcia_unregister_driver);
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
-    for (driver = root_driver; driver; driver = driver->next)
-	if (strncmp((char *)dev_info, (char *)driver->dev_info,
-		    DEV_NAME_LEN) == 0)
-	    break;
+    driver = get_pcmcia_driver(dev_info);
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
@@ -185,7 +212,7 @@
 	    b->instance = driver->attach();
 	    if (b->instance == NULL)
 		printk(KERN_NOTICE "ds: unable to create instance "
-		       "of '%s'!\n", driver->dev_info);
+		       "of '%s'!\n", driver->drv.name);
 	}
     
     return 0;
@@ -195,44 +222,43 @@
 
 int unregister_pccard_driver(dev_info_t *dev_info)
 {
-    driver_info_t *target, **d = &root_driver;
-    socket_bind_t *b;
-    int i;
+    struct pcmcia_driver *driver;
     
     DEBUG(0, "ds: unregister_pccard_driver('%s')\n",
 	  (char *)dev_info);
-    while ((*d) && (strncmp((*d)->dev_info, (char *)dev_info,
-			    DEV_NAME_LEN) != 0))
-	d = &(*d)->next;
-    if (*d == NULL)
+    driver = get_pcmcia_driver(dev_info);
+    if (!driver)
 	return -ENODEV;
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
 
@@ -376,7 +402,7 @@
 
 static int bind_request(int i, bind_info_t *bind_info)
 {
-    struct driver_info_t *driver;
+    struct pcmcia_driver *driver;
     socket_bind_t *b;
     bind_req_t bind_req;
     socket_info_t *s = &socket_table[i];
@@ -384,18 +410,14 @@
 
     DEBUG(2, "bind_request(%d, '%s')\n", i,
 	  (char *)bind_info->dev_info);
-    for (driver = root_driver; driver; driver = driver->next)
-	if (strcmp((char *)driver->dev_info,
-		   (char *)bind_info->dev_info) == 0)
-	    break;
+    driver = get_pcmcia_driver(&bind_info->dev_info);
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
+
+	driver->drv.name = bind_info->dev_info;
+	pcmcia_register_driver(driver);
     }
 
     for (b = s->bind; b; b = b->next)
@@ -409,7 +431,7 @@
 
     bind_req.Socket = i;
     bind_req.Function = bind_info->function;
-    bind_req.dev_info = &driver->dev_info;
+    bind_req.dev_info = (dev_info_t *) driver->drv.name;
     ret = pcmcia_bind_device(&bind_req);
     if (ret != CS_SUCCESS) {
 	cs_error(NULL, BindDevice, ret);
@@ -490,7 +512,7 @@
 #endif
 
     for (b = s->bind; b; b = b->next)
-	if ((strcmp((char *)b->driver->dev_info,
+	if ((strcmp((char *)b->driver->drv.name,
 		    (char *)bind_info->dev_info) == 0) &&
 	    (b->function == bind_info->function))
 	    break;
@@ -524,7 +546,7 @@
     DEBUG(2, "unbind_request(%d, '%s')\n", i,
 	  (char *)bind_info->dev_info);
     for (b = &s->bind; *b; b = &(*b)->next)
-	if ((strcmp((char *)(*b)->driver->dev_info,
+	if ((strcmp((char *)(*b)->driver->drv.name,
 		    (char *)bind_info->dev_info) == 0) &&
 	    ((*b)->function == bind_info->function))
 	    break;
@@ -536,14 +558,6 @@
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
@@ -881,7 +895,18 @@
 
 /*====================================================================*/
 
-int __init init_pcmcia_ds(void)
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
+static int __init init_pcmcia_ds(void)
 {
     client_reg_t client_reg;
     servinfo_t serv;
@@ -967,11 +992,7 @@
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
@@ -984,6 +1005,59 @@
 	pcmcia_deregister_client(socket_table[i].handle);
     sockets = 0;
     kfree(socket_table);
+    bus_unregister(&pcmcia_bus_type);
 }
 
+#ifdef MODULE
+
+/* init_pcmcia_bus must be done early, init_pcmcia_ds late. If we load this 
+ * as a module, we can only specify one initcall, though... 
+ */
+static int __init init_pcmcia_module(void) {
+	init_pcmcia_bus();
+	return init_pcmcia_ds();
+}
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
+
+
diff -ruN linux-original/include/pcmcia/ds.h linux/include/pcmcia/ds.h
--- linux-original/include/pcmcia/ds.h	2003-03-01 21:49:10.000000000 +0100
+++ linux/include/pcmcia/ds.h	2003-03-01 22:13:19.000000000 +0100
@@ -32,6 +32,7 @@
 
 #include <pcmcia/driver_ops.h>
 #include <pcmcia/bulkmem.h>
+#include <linux/device.h>
 
 typedef struct tuple_parse_t {
     tuple_t		tuple;
@@ -143,6 +144,20 @@
 #define register_pcmcia_driver register_pccard_driver
 #define unregister_pcmcia_driver unregister_pccard_driver
 
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
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_DS_H */
