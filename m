Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267274AbTBXQNr>; Mon, 24 Feb 2003 11:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267224AbTBXQNr>; Mon, 24 Feb 2003 11:13:47 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:51423 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S267310AbTBXQNJ>; Mon, 24 Feb 2003 11:13:09 -0500
Date: Mon, 24 Feb 2003 17:22:59 +0100
From: Dominik Brodowski <linux@brodo.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC] pcmcia: bus pcmcia_bus_type, driver_socket as interface
Message-ID: <20030224162259.GA2277@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

Patch #1: pcmcia-2.5.62-bus_drivers-3
These patches add a new bus_type pcmcia_bus_type, and registers all pcmcia
drivers with this bus. This is still done using the "old" registration
calls; but over the long term this will move -- so that the pcmcia core
knows about module->owner, for example.

Patch #2: pcmcia-2.5.62-ds-1
This starts a change of "Driver Servies" to become a "interface" to
pcmcia_socket-class devices. The interface_add_data call is commented out
due to a driver model bug (deadlock) Patrick Mochel already knows about. Due
to this, removing a driver services module or a socket won't currently work.

	Dominik

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pcmcia-2.5.62-bus_drivers-3"

diff -ru linux-original/drivers/pcmcia/cs.c linux/drivers/pcmcia/cs.c
--- linux-original/drivers/pcmcia/cs.c	2003-02-23 22:12:42.000000000 +0100
+++ linux/drivers/pcmcia/cs.c	2003-02-23 22:24:59.000000000 +0100
@@ -2430,12 +2430,17 @@
 };
 EXPORT_SYMBOL(pcmcia_socket_class);
 
+struct bus_type pcmcia_bus_type = {
+	.name = "pcmcia",
+};
+EXPORT_SYMBOL(pcmcia_bus_type);
 
 static int __init init_pcmcia_cs(void)
 {
     printk(KERN_INFO "%s\n", release);
     printk(KERN_INFO "  %s\n", options);
     DEBUG(0, "%s\n", version);
+    bus_register(&pcmcia_bus_type);
     devclass_register(&pcmcia_socket_class);
     if (do_apm)
 	pm_register(PM_SYS_DEV, PM_SYS_PCMCIA, handle_pm_event);
@@ -2458,6 +2463,7 @@
 	pm_unregister_all(handle_pm_event);
     release_resource_db();
     devclass_unregister(&pcmcia_socket_class);
+    bus_unregister(&pcmcia_bus_type);
 }
 
 subsys_initcall(init_pcmcia_cs);
diff -ru linux-original/drivers/pcmcia/ds.c linux/drivers/pcmcia/ds.c
--- linux-original/drivers/pcmcia/ds.c	2003-02-23 22:12:42.000000000 +0100
+++ linux/drivers/pcmcia/ds.c	2003-02-23 22:24:59.000000000 +0100
@@ -77,19 +77,19 @@
 
 /*====================================================================*/
 
-typedef struct driver_info_t {
-    dev_info_t		dev_info;
-    int			use_count, status;
-    dev_link_t		*(*attach)(void);
-    void		(*detach)(dev_link_t *);
-    struct driver_info_t *next;
-} driver_info_t;
+struct pcmcia_driver {
+	int			use_count, status;
+	dev_link_t		*(*attach)(void);
+	void		(*detach)(dev_link_t *);
+	struct module		owner;
+	struct device_driver	drv;
+};
 
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
@@ -124,9 +124,6 @@
 /* Device driver ID passed to Card Services */
 static dev_info_t dev_info = "Driver Services";
 
-/* Linked list of all registered device drivers */
-static driver_info_t *root_driver = NULL;
-
 static int sockets = 0, major_dev = -1;
 static socket_info_t *socket_table = NULL;
 
@@ -143,6 +140,37 @@
     pcmcia_report_error(handle, &err);
 }
 
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
+
+
 /*======================================================================
 
     Register_pccard_driver() and unregister_pccard_driver() are used
@@ -151,87 +179,108 @@
     
 ======================================================================*/
 
-int register_pccard_driver(dev_info_t *dev_info,
-			   dev_link_t *(*attach)(void),
-			   void (*detach)(dev_link_t *))
+static int pcmcia_register_driver(struct pcmcia_driver *driver)
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
+
+static void pcmcia_unregister_driver(struct pcmcia_driver *driver)
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
+	}
+	
+	driver_unregister(&driver->drv);
+}
+
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
 	}
+
+	driver->attach = attach;
+	driver->detach = detach;
+	if (driver->use_count == 0) 
+		return 0;
     
-    return 0;
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
 } /* register_pccard_driver */
 
 /*====================================================================*/
 
 int unregister_pccard_driver(dev_info_t *dev_info)
 {
-    driver_info_t *target, **d = &root_driver;
-    socket_bind_t *b;
-    int i;
+	struct pcmcia_driver *driver;
     
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
+	DEBUG(0, "ds: unregister_pccard_driver('%s')\n",
+	      (char *)dev_info);
+	driver = get_pcmcia_driver(dev_info);
+	if (!driver)
+		return -ENODEV;
+
+	pcmcia_unregister_driver(driver);
+	kfree(driver);
+	return 0;
 } /* unregister_pccard_driver */
 
 /*====================================================================*/
 
 #ifdef CONFIG_PROC_FS
+static int proc_read_drivers_callback(struct device_driver *driver, void *d)
+{
+	char **p = d;
+	struct pcmcia_driver *p_dev = container_of(driver, struct pcmcia_driver, drv);
+	*p += sprintf(*p, "%-24.24s %d %d\n", driver->name, p_dev->status,
+		     p_dev->use_count);
+	d = (void *) p;
+	return 0;
+}
+
 static int proc_read_drivers(char *buf, char **start, off_t pos,
 			     int count, int *eof, void *data)
 {
-    driver_info_t *d;
     char *p = buf;
-    for (d = root_driver; d; d = d->next)
-	p += sprintf(p, "%-24.24s %d %d\n", d->dev_info,
-		     d->status, d->use_count);
+    bus_for_each_drv(&pcmcia_bus_type, NULL, (void *) &p, proc_read_drivers_callback);
     return (p - buf);
 }
 #endif
@@ -376,7 +425,7 @@
 
 static int bind_request(int i, bind_info_t *bind_info)
 {
-    struct driver_info_t *driver;
+    struct pcmcia_driver *driver;
     socket_bind_t *b;
     bind_req_t bind_req;
     socket_info_t *s = &socket_table[i];
@@ -384,18 +433,15 @@
 
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
@@ -409,7 +455,7 @@
 
     bind_req.Socket = i;
     bind_req.Function = bind_info->function;
-    bind_req.dev_info = &driver->dev_info;
+    bind_req.dev_info = (dev_info_t *) driver->drv.name;
     ret = pcmcia_bind_device(&bind_req);
     if (ret != CS_SUCCESS) {
 	cs_error(NULL, BindDevice, ret);
@@ -490,7 +536,7 @@
 #endif
 
     for (b = s->bind; b; b = b->next)
-	if ((strcmp((char *)b->driver->dev_info,
+	if ((strcmp((char *)b->driver->drv.name,
 		    (char *)bind_info->dev_info) == 0) &&
 	    (b->function == bind_info->function))
 	    break;
@@ -524,7 +570,7 @@
     DEBUG(2, "unbind_request(%d, '%s')\n", i,
 	  (char *)bind_info->dev_info);
     for (b = &s->bind; *b; b = &(*b)->next)
-	if ((strcmp((char *)(*b)->driver->dev_info,
+	if ((strcmp((char *)(*b)->driver->drv.name,
 		    (char *)bind_info->dev_info) == 0) &&
 	    ((*b)->function == bind_info->function))
 	    break;
@@ -536,14 +582,6 @@
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
diff -ru linux-original/include/pcmcia/cs.h linux/include/pcmcia/cs.h
--- linux-original/include/pcmcia/cs.h	2003-02-23 22:12:46.000000000 +0100
+++ linux/include/pcmcia/cs.h	2003-02-23 22:17:57.000000000 +0100
@@ -30,6 +30,10 @@
 #ifndef _LINUX_CS_H
 #define _LINUX_CS_H
 
+#include <linux/device.h>
+
+extern struct bus_type pcmcia_bus_type;
+
 /* For AccessConfigurationRegister */
 typedef struct conf_reg_t {
     u_char	Function;

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pcmcia-2.5.62-ds-4"

diff -ru linux-original/drivers/pcmcia/cs.c linux/drivers/pcmcia/cs.c
--- linux-original/drivers/pcmcia/cs.c	2003-02-23 22:27:58.000000000 +0100
+++ linux/drivers/pcmcia/cs.c	2003-02-23 22:26:16.000000000 +0100
@@ -345,6 +345,7 @@
 
 		s->ss_entry = cls_d->ops;
 		s->sock = i + cls_d->sock_offset;
+		s->s_dev = dev;
 
 		/* base address = 0, map = 0 */
 		s->cis_mem.flags = 0;
@@ -359,6 +360,7 @@
 		socket_table[j] = s;
 		if (j == sockets) sockets++;
 
+		s->socket_table_entry = j;
 		init_socket(s);
 		s->ss_entry->inquire_socket(s->sock, &s->cap);
 #ifdef CONFIG_PROC_FS
diff -ru linux-original/drivers/pcmcia/cs_internal.h linux/drivers/pcmcia/cs_internal.h
--- linux-original/drivers/pcmcia/cs_internal.h	2003-02-23 22:12:42.000000000 +0100
+++ linux/drivers/pcmcia/cs_internal.h	2003-02-23 22:26:16.000000000 +0100
@@ -158,7 +158,11 @@
 #ifdef CONFIG_PROC_FS
     struct proc_dir_entry	*proc;
 #endif
-    int				use_bus_pm;
+	int			use_bus_pm;
+	struct device		*s_dev;
+	/* TBD: integrate the following contents fully into this struct */
+	void			*ds_info; /* ds_socket_info */
+	int			socket_table_entry;
 } socket_info_t;
 
 /* Flags in config state */
diff -ru linux-original/drivers/pcmcia/ds.c linux/drivers/pcmcia/ds.c
--- linux-original/drivers/pcmcia/ds.c	2003-02-23 22:27:58.000000000 +0100
+++ linux/drivers/pcmcia/ds.c	2003-02-23 22:26:16.000000000 +0100
@@ -48,6 +48,7 @@
 #include <linux/proc_fs.h>
 #include <linux/poll.h>
 #include <linux/pci.h>
+#include <linux/device.h>
 
 #include <pcmcia/version.h>
 #include <pcmcia/cs_types.h>
@@ -55,6 +56,11 @@
 #include <pcmcia/bulkmem.h>
 #include <pcmcia/cistpl.h>
 #include <pcmcia/ds.h>
+#include <pcmcia/cisreg.h>
+#include <pcmcia/bus_ops.h>
+#include <pcmcia/ss.h>
+
+#include "cs_internal.h"
 
 /*====================================================================*/
 
@@ -68,11 +74,8 @@
 
 #ifdef PCMCIA_DEBUG
 INT_MODULE_PARM(pc_debug, PCMCIA_DEBUG);
-#define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
 static const char *version =
 "ds.c 1.112 2001/10/13 00:08:28 (David Hinds)";
-#else
-#define DEBUG(n, args...)
 #endif
 
 /*====================================================================*/
@@ -105,7 +108,7 @@
 } user_info_t;
 
 /* Socket state information */
-typedef struct socket_info_t {
+struct ds_socket_info {
     client_handle_t	handle;
     int			state;
     user_info_t		*user;
@@ -113,9 +116,11 @@
     wait_queue_head_t	queue, request;
     struct timer_list	removal;
     socket_bind_t	*bind;
-} socket_info_t;
+};
 
-#define SOCKET_PRESENT		0x01
+#ifndef SOCKET_PRESENT
+#define SOCKET_PRESENT		0x08
+#endif
 #define SOCKET_BUSY		0x02
 #define SOCKET_REMOVAL_PENDING	0x10
 
@@ -124,8 +129,7 @@
 /* Device driver ID passed to Card Services */
 static dev_info_t dev_info = "Driver Services";
 
-static int sockets = 0, major_dev = -1;
-static socket_info_t *socket_table = NULL;
+static int major_dev = -1;
 
 extern struct proc_dir_entry *proc_pccard;
 
@@ -193,15 +197,20 @@
 static void pcmcia_unregister_driver(struct pcmcia_driver *driver)
 {
 	socket_bind_t *b;
+	struct ds_socket_info *ds;
 	int i;
 
 	if (driver->use_count > 0) {
 		/* Blank out any left-over device instances */
 		driver->attach = NULL; driver->detach = NULL;
-		for (i = 0; i < sockets; i++)
-			for (b = socket_table[i].bind; b; b = b->next)
+		for (i = 0; i < sockets; i++) {
+			if (!socket_table[i] || !socket_table[i]->ds_info)
+				continue;
+			ds = socket_table[i]->ds_info;
+			for (b = ds->bind; b; b = b->next)
 				if (b->driver == driver) 
 					b->instance = NULL;
+		}
 	}
 	
 	driver_unregister(&driver->drv);
@@ -213,6 +222,7 @@
 			   void (*detach)(dev_link_t *))
 {
 	struct pcmcia_driver *driver;
+	struct ds_socket_info *ds;
 	socket_bind_t *b;
 	int i;
 
@@ -233,16 +243,19 @@
 		return 0;
     
 	/* Instantiate any already-bound devices */
-	for (i = 0; i < sockets; i++)
-		for (b = socket_table[i].bind; b; b = b->next) {
-			if (b->driver != driver) 
+	for (i = 0; i < sockets; i++) {
+		if (!socket_table[i] || !socket_table[i]->ds_info)
+			continue;
+		ds = socket_table[i]->ds_info;
+		for (b = ds->bind; b; b = b->next) {
+			if (b->driver != driver)
 				continue;
 			b->instance = driver->attach();
 			if (b->instance == NULL)
 				printk(KERN_NOTICE "ds: unable to create instance "
 				       "of '%s'!\n", driver->drv.name);
 		}
-
+	}
 	return 0;
 } /* register_pccard_driver */
 
@@ -310,7 +323,7 @@
     user->event[user->event_head] = event;
 }
 
-static void handle_event(socket_info_t *s, event_t event)
+static void handle_event(struct ds_socket_info *s, event_t event)
 {
     user_info_t *user;
     for (user = s->user; user; user = user->next)
@@ -318,7 +331,7 @@
     wake_up_interruptible(&s->queue);
 }
 
-static int handle_request(socket_info_t *s, event_t event)
+static int handle_request(struct ds_socket_info *s, event_t event)
 {
     if (s->req_pending != 0)
 	return CS_IN_USE;
@@ -337,7 +350,9 @@
 
 static void handle_removal(u_long sn)
 {
-    socket_info_t *s = &socket_table[sn];
+    struct ds_socket_info *s = socket_table[sn]->ds_info;
+    if (!s)
+	    return;
     handle_event(s, CS_EVENT_CARD_REMOVAL);
     s->state &= ~SOCKET_REMOVAL_PENDING;
 }
@@ -351,37 +366,39 @@
 static int ds_event(event_t event, int priority,
 		    event_callback_args_t *args)
 {
-    socket_info_t *s;
-    int i;
+	socket_info_t *s;
+	struct ds_socket_info *ds;
 
-    DEBUG(1, "ds: ds_event(0x%06x, %d, 0x%p)\n",
-	  event, priority, args->client_handle);
-    s = args->client_data;
-    i = s - socket_table;
+	DEBUG(1, "ds: ds_event(0x%06x, %d, 0x%p)\n",
+	      event, priority, args->client_handle);
+	s = args->client_data;
+	if (!s || !s->ds_info)
+		return -EINVAL;
+	ds = s->ds_info;
     
-    switch (event) {
+	switch (event) {
 	
     case CS_EVENT_CARD_REMOVAL:
-	s->state &= ~SOCKET_PRESENT;
-	if (!(s->state & SOCKET_REMOVAL_PENDING)) {
-	    s->state |= SOCKET_REMOVAL_PENDING;
-	    init_timer(&s->removal);
-	    s->removal.expires = jiffies + HZ/10;
-	    add_timer(&s->removal);
+	ds->state &= ~SOCKET_PRESENT;
+	if (!(ds->state & SOCKET_REMOVAL_PENDING)) {
+	    ds->state |= SOCKET_REMOVAL_PENDING;
+	    init_timer(&ds->removal);
+	    ds->removal.expires = jiffies + HZ/10;
+	    add_timer(&ds->removal);
 	}
 	break;
 	
     case CS_EVENT_CARD_INSERTION:
-	s->state |= SOCKET_PRESENT;
-	handle_event(s, event);
+	ds->state |= SOCKET_PRESENT;
+	handle_event(ds, event);
 	break;
 
     case CS_EVENT_EJECTION_REQUEST:
-	return handle_request(s, event);
+	return handle_request(ds, event);
 	break;
 	
     default:
-	handle_event(s, event);
+	handle_event(ds, event);
 	break;
     }
 
@@ -428,9 +445,12 @@
     struct pcmcia_driver *driver;
     socket_bind_t *b;
     bind_req_t bind_req;
-    socket_info_t *s = &socket_table[i];
+    struct ds_socket_info *s = socket_table[i]->ds_info;
     int ret;
 
+    if (!s)
+	    return -ENODEV;
+
     DEBUG(2, "bind_request(%d, '%s')\n", i,
 	  (char *)bind_info->dev_info);
     driver = get_pcmcia_driver(&bind_info->dev_info);
@@ -494,10 +514,13 @@
 
 static int get_device_info(int i, bind_info_t *bind_info, int first)
 {
-    socket_info_t *s = &socket_table[i];
+    struct ds_socket_info *s = socket_table[i]->ds_info;
     socket_bind_t *b;
     dev_node_t *node;
 
+    if (!s)
+	    return -ENODEV;
+
 #ifdef CONFIG_CARDBUS
     /*
      * Some unbelievably ugly code to associate the PCI cardbus
@@ -564,7 +587,7 @@
 
 static int unbind_request(int i, bind_info_t *bind_info)
 {
-    socket_info_t *s = &socket_table[i];
+    struct ds_socket_info *s = socket_table[i]->ds_info;
     socket_bind_t **b, *c;
 
     DEBUG(2, "unbind_request(%d, '%s')\n", i,
@@ -598,13 +621,15 @@
 static int ds_open(struct inode *inode, struct file *file)
 {
     socket_t i = minor(inode->i_rdev);
-    socket_info_t *s;
+    struct ds_socket_info *s;
     user_info_t *user;
 
     DEBUG(0, "ds_open(socket %d)\n", i);
     if ((i >= sockets) || (sockets == 0))
 	return -ENODEV;
-    s = &socket_table[i];
+    s = socket_table[i]->ds_info;
+    if (!s)
+	    return -ENODEV;
     if ((file->f_flags & O_ACCMODE) != O_RDONLY) {
 	if (s->state & SOCKET_BUSY)
 	    return -EBUSY;
@@ -630,13 +655,15 @@
 static int ds_release(struct inode *inode, struct file *file)
 {
     socket_t i = minor(inode->i_rdev);
-    socket_info_t *s;
+    struct ds_socket_info *s;
     user_info_t *user, **link;
 
     DEBUG(0, "ds_release(socket %d)\n", i);
     if ((i >= sockets) || (sockets == 0))
 	return 0;
-    s = &socket_table[i];
+    s = socket_table[i]->ds_info;
+    if (!s)
+	    return -ENODEV;
     user = file->private_data;
     if (CHECK_USER(user))
 	goto out;
@@ -662,7 +689,7 @@
 		       size_t count, loff_t *ppos)
 {
     socket_t i = minor(file->f_dentry->d_inode->i_rdev);
-    socket_info_t *s;
+    struct ds_socket_info *s;
     user_info_t *user;
 
     DEBUG(2, "ds_read(socket %d)\n", i);
@@ -671,7 +698,9 @@
 	return -ENODEV;
     if (count < 4)
 	return -EINVAL;
-    s = &socket_table[i];
+    s = socket_table[i]->ds_info;
+    if (!s)
+	    return -ENODEV;
     user = file->private_data;
     if (CHECK_USER(user))
 	return -EIO;
@@ -691,7 +720,7 @@
 			size_t count, loff_t *ppos)
 {
     socket_t i = minor(file->f_dentry->d_inode->i_rdev);
-    socket_info_t *s;
+    struct ds_socket_info *s;
     user_info_t *user;
 
     DEBUG(2, "ds_write(socket %d)\n", i);
@@ -702,7 +731,9 @@
 	return -EINVAL;
     if ((file->f_flags & O_ACCMODE) == O_RDONLY)
 	return -EBADF;
-    s = &socket_table[i];
+    s = socket_table[i]->ds_info;
+    if (!s)
+	    return -ENODEV;
     user = file->private_data;
     if (CHECK_USER(user))
 	return -EIO;
@@ -724,14 +755,16 @@
 static u_int ds_poll(struct file *file, poll_table *wait)
 {
     socket_t i = minor(file->f_dentry->d_inode->i_rdev);
-    socket_info_t *s;
+    struct ds_socket_info *s;
     user_info_t *user;
 
     DEBUG(2, "ds_poll(socket %d)\n", i);
     
     if ((i >= sockets) || (sockets == 0))
 	return POLLERR;
-    s = &socket_table[i];
+    s = socket_table[i]->ds_info;
+    if (!s)
+	    return -ENODEV;
     user = file->private_data;
     if (CHECK_USER(user))
 	return POLLERR;
@@ -747,7 +780,7 @@
 		    u_int cmd, u_long arg)
 {
     socket_t i = minor(inode->i_rdev);
-    socket_info_t *s;
+    struct ds_socket_info *s;
     u_int size;
     int ret, err;
     ds_ioctl_arg_t buf;
@@ -756,7 +789,7 @@
     
     if ((i >= sockets) || (sockets == 0))
 	return -ENODEV;
-    s = &socket_table[i];
+    s = socket_table[i]->ds_info;
     
     size = (cmd & IOCSIZE_MASK) >> IOCSIZE_SHIFT;
     if (size > sizeof(ds_ioctl_arg_t)) return -EINVAL;
@@ -919,109 +952,184 @@
 
 /*====================================================================*/
 
-int __init init_pcmcia_ds(void)
+static int ds_pcmcia_socket_add(socket_info_t *socket)
 {
-    client_reg_t client_reg;
-    servinfo_t serv;
-    bind_req_t bind;
-    socket_info_t *s;
-    int i, ret;
+	struct ds_socket_info *ds;
+	client_reg_t client_reg;
+	bind_req_t bind;
+	int ret;
     
-    DEBUG(0, "%s\n", version);
- 
-    /*
-     * Ugly. But we want to wait for the socket threads to have started up.
-     * We really should let the drivers themselves drive some of this..
-     */
-    current->state = TASK_INTERRUPTIBLE;
-    schedule_timeout(HZ/4);
+	ds = kmalloc(sizeof(struct ds_socket_info), GFP_KERNEL);
+	if (!ds)
+		return -ENOMEM;
+	memset(ds, 0, sizeof(struct ds_socket_info));
+
+	socket->ds_info = ds;
+
+	init_waitqueue_head(&ds->queue);
+	init_waitqueue_head(&ds->request);
+	init_timer(&ds->removal);
+	ds->removal.data = socket->socket_table_entry;
+	ds->removal.function = &handle_removal;
 
-    pcmcia_get_card_services_info(&serv);
-    if (serv.Revision != CS_RELEASE_CODE) {
-	printk(KERN_NOTICE "ds: Card Services release does not match!\n");
-	return -1;
-    }
-    if (serv.Count == 0) {
-	printk(KERN_NOTICE "ds: no socket drivers loaded!\n");
-	return -1;
-    }
-    
-    sockets = serv.Count;
-    socket_table = kmalloc(sockets*sizeof(socket_info_t), GFP_KERNEL);
-    if (!socket_table) return -1;
-    for (i = 0, s = socket_table; i < sockets; i++, s++) {
-	s->state = 0;
-	s->user = NULL;
-	s->req_pending = 0;
-	init_waitqueue_head(&s->queue);
-	init_waitqueue_head(&s->request);
-	s->handle = NULL;
-	init_timer(&s->removal);
-	s->removal.data = i;
-	s->removal.function = &handle_removal;
-	s->bind = NULL;
-    }
-    
-    /* Set up hotline to Card Services */
-    client_reg.dev_info = bind.dev_info = &dev_info;
-    client_reg.Attributes = INFO_MASTER_CLIENT;
-    client_reg.EventMask =
-	CS_EVENT_CARD_INSERTION | CS_EVENT_CARD_REMOVAL |
-	CS_EVENT_RESET_PHYSICAL | CS_EVENT_CARD_RESET |
-	CS_EVENT_EJECTION_REQUEST | CS_EVENT_INSERTION_REQUEST |
-        CS_EVENT_PM_SUSPEND | CS_EVENT_PM_RESUME;
-    client_reg.event_handler = &ds_event;
-    client_reg.Version = 0x0210;
-    for (i = 0; i < sockets; i++) {
-	bind.Socket = i;
+	bind.Socket = socket->socket_table_entry;
 	bind.Function = BIND_FN_ALL;
+	client_reg.dev_info = bind.dev_info = &dev_info;
+
 	ret = pcmcia_bind_device(&bind);
 	if (ret != CS_SUCCESS) {
-	    cs_error(NULL, BindDevice, ret);
-	    break;
+		cs_error(NULL, BindDevice, ret);
+		return -EINVAL;
 	}
-	client_reg.event_callback_args.client_data = &socket_table[i];
-	ret = pcmcia_register_client(&socket_table[i].handle,
+
+	/* Set up hotline to Card Services */
+	client_reg.Attributes = INFO_MASTER_CLIENT;
+	client_reg.EventMask =
+		CS_EVENT_CARD_INSERTION | CS_EVENT_CARD_REMOVAL |
+		CS_EVENT_RESET_PHYSICAL | CS_EVENT_CARD_RESET |
+		CS_EVENT_EJECTION_REQUEST | CS_EVENT_INSERTION_REQUEST |
+		CS_EVENT_PM_SUSPEND | CS_EVENT_PM_RESUME;
+	client_reg.event_handler = &ds_event;
+	client_reg.Version = 0x0210;
+
+	client_reg.event_callback_args.client_data = socket;
+	ret = pcmcia_register_client(&ds->handle,
 			   &client_reg);
 	if (ret != CS_SUCCESS) {
-	    cs_error(NULL, RegisterClient, ret);
-	    break;
+		cs_error(NULL, RegisterClient, ret);
+		return -EINVAL;
 	}
-    }
+
+	return 0;
+}
+
+static int ds_pcmcia_socket_remove(socket_info_t *socket)
+{
+	struct ds_socket_info *ds = socket->ds_info;
+	if (ds) {
+		pcmcia_deregister_client(ds->handle);
+		kfree(ds);
+	}
+	return 0;
+}
+
+static struct device_interface ds_interface;
+
+static int ds_pcmcia_s_dev_add(struct device *dev)
+{
+	struct pcmcia_socket_class_data *cls_d = dev->class_data;
+	socket_info_t *s;
+	unsigned int i;
+	unsigned int ret = 0;
+
+	if (!cls_d)
+		return -ENODEV;
+	s = (socket_info_t *) cls_d->s_info;
+	if (!s)
+		return -ENODEV;
+
+        for (i = 0; i < cls_d->nsock; i++) {
+		ds_pcmcia_socket_add(s);
+		s++;
+	}
+	cls_d->ds_intf.dev  = dev;
+	cls_d->ds_intf.intf = &ds_interface;
+	strncpy(cls_d->ds_intf.kobj.name, ds_interface.name, KOBJ_NAME_LEN);
+	cls_d->ds_intf.kobj.parent = &(dev->kobj);
+	cls_d->ds_intf.kobj.kset = &(ds_interface.kset);
+
+        /* add interface */
+        /* currently commented out due to deadlock */
+        //ret = interface_add_data(&(cls_d->ds_intf));
+	if (ret) {
+		s = (socket_info_t *) cls_d->s_info;
+		for (i = 0; i < cls_d->nsock; i++) {
+			ds_pcmcia_socket_remove(s);
+			s++;
+		}		
+	}
+
+	return ret;
+}
+
+static int ds_pcmcia_s_dev_remove(struct intf_data *intf)
+{
+	struct pcmcia_socket_class_data *cls_d = intf->dev->class_data;
+	socket_info_t *s;
+	unsigned int i;
+
+	if (!cls_d)
+		return -ENODEV;
+	s = (socket_info_t *) cls_d->s_info;
+	if (!s)
+		return -ENODEV;
+
+        for (i = 0; i < cls_d->nsock; i++) {
+		ds_pcmcia_socket_remove(s);
+		s++;
+	}
+
+	return 0;
+}
+
+
+static struct device_interface ds_interface = {
+        .name = "Driver Services",
+        .devclass = &pcmcia_socket_class,
+        .add_device = &ds_pcmcia_s_dev_add,
+        .remove_device = &ds_pcmcia_s_dev_remove,
+	.kset = { .subsys = &pcmcia_socket_class.subsys, },
+        .devnum = 0,
+};
+
+int __init init_pcmcia_ds(void)
+{
+	servinfo_t serv;
+	int i;
     
-    /* Set up character device for user mode clients */
-    i = register_chrdev(0, "pcmcia", &ds_fops);
-    if (i == -EBUSY)
-	printk(KERN_NOTICE "unable to find a free device # for "
+	DEBUG(0, "%s\n", version);
+
+	/*
+	 * Ugly. But we want to wait for the socket threads to have started up.
+	 * We really should let the drivers themselves drive some of this..
+	 */
+	current->state = TASK_INTERRUPTIBLE;
+	schedule_timeout(HZ/4);
+	
+	pcmcia_get_card_services_info(&serv);
+	if (serv.Revision != CS_RELEASE_CODE) {
+		printk(KERN_NOTICE "ds: Card Services release does not match!\n");
+		return -1;
+	}
+
+        interface_register(&ds_interface);
+
+	/* Set up character device for user mode clients */
+	i = register_chrdev(0, "pcmcia", &ds_fops);
+	if (i == -EBUSY)
+		printk(KERN_NOTICE "unable to find a free device # for "
 	       "Driver Services\n");
-    else
-	major_dev = i;
+	else
+		major_dev = i;
 
 #ifdef CONFIG_PROC_FS
-    if (proc_pccard)
-	create_proc_read_entry("drivers",0,proc_pccard,proc_read_drivers,NULL);
-    init_status = 0;
+	if (proc_pccard)
+		create_proc_read_entry("drivers",0,proc_pccard,proc_read_drivers,NULL);
+	init_status = 0;
 #endif
-    return 0;
+	return 0;
 }
-
 late_initcall(init_pcmcia_ds);
 
-#ifdef MODULE
 
-void __exit cleanup_module(void)
+void __exit exit_pcmcia_ds(void)
 {
-    int i;
 #ifdef CONFIG_PROC_FS
-    if (proc_pccard)
-	remove_proc_entry("drivers", proc_pccard);
+	if (proc_pccard)
+		remove_proc_entry("drivers", proc_pccard);
 #endif
-    if (major_dev != -1)
-	unregister_chrdev(major_dev, "pcmcia");
-    for (i = 0; i < sockets; i++)
-	pcmcia_deregister_client(socket_table[i].handle);
-    sockets = 0;
-    kfree(socket_table);
+	if (major_dev != -1)
+		unregister_chrdev(major_dev, "pcmcia");
+        interface_unregister(&ds_interface);
 }
-
-#endif
+module_exit(exit_pcmcia_ds);
diff -ru linux-original/include/pcmcia/ss.h linux/include/pcmcia/ss.h
--- linux-original/include/pcmcia/ss.h	2003-02-23 22:12:46.000000000 +0100
+++ linux/include/pcmcia/ss.h	2003-02-23 22:26:16.000000000 +0100
@@ -152,6 +152,7 @@
 	struct pccard_operations *ops;		/* see above */
 	void *s_info;				/* socket_info_t */
 	unsigned int use_bus_pm;
+	struct intf_data ds_intf;		/* intf data for driver services */
 };
 
 extern struct device_class pcmcia_socket_class;

--VbJkn9YxBvnuCH5J--
