Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263274AbTCYT1p>; Tue, 25 Mar 2003 14:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263278AbTCYT1o>; Tue, 25 Mar 2003 14:27:44 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:13233 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S263274AbTCYT0s>; Tue, 25 Mar 2003 14:26:48 -0500
Date: Tue, 25 Mar 2003 20:37:03 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia: "driver services" socket add/remove abstraction
Message-ID: <20030325193703.GA15319@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, "Driver Services" could only be called when the socket
drivers were initialized earlier. This caused an awful lot of
problems, especially when modprobe tried to load ds.ko and a pcmcia
card driver at once.

As all socket devices are registered with the driver model core as
being of "class_type pcmcia_socket_class", we can take use of that and
register them with "Driver Services" upon detection or upon
module loading of ds.c.

Also, the "I-need-two-initcalls-in-a-module"-tweak can go away.

Unfortunately, this patch reportedly breaks some RedHat pcmcia init
scritps - they relied on the failed loading of ds.c to detect that no
socket driver was loaded previously. To properly detect this, you
should take a look at the /sys/class/pcmcia_socket/devices directory.

 ds.c |  363 +++++++++++++++++++++++++++++++++++++++++--------------------------
 1 files changed, 223 insertions(+), 140 deletions(-)

diff -ruN linux-original/drivers/pcmcia/ds.c linux/drivers/pcmcia/ds.c
--- linux-original/drivers/pcmcia/ds.c	2003-03-25 18:26:53.000000000 +0100
+++ linux/drivers/pcmcia/ds.c	2003-03-25 19:48:00.000000000 +0100
@@ -48,6 +48,7 @@
 #include <linux/proc_fs.h>
 #include <linux/poll.h>
 #include <linux/pci.h>
+#include <linux/list.h>
 
 #include <pcmcia/version.h>
 #include <pcmcia/cs_types.h>
@@ -55,6 +56,7 @@
 #include <pcmcia/bulkmem.h>
 #include <pcmcia/cistpl.h>
 #include <pcmcia/ds.h>
+#include <pcmcia/ss.h>
 
 /*====================================================================*/
 
@@ -105,6 +107,9 @@
     wait_queue_head_t	queue, request;
     struct timer_list	removal;
     socket_bind_t	*bind;
+	struct device		*socket_dev;
+	struct list_head	socket_list;
+	unsigned int		socket_no; /* deprecated */
 } socket_info_t;
 
 #define SOCKET_PRESENT		0x01
@@ -116,8 +121,11 @@
 /* Device driver ID passed to Card Services */
 static dev_info_t dev_info = "Driver Services";
 
-static int sockets = 0, major_dev = -1;
-static socket_info_t *socket_table = NULL;
+static int major_dev = -1;
+
+/* list of all sockets registered with the pcmcia bus driver */
+static DECLARE_RWSEM(bus_socket_list_rwsem);
+static LIST_HEAD(bus_socket_list);
 
 extern struct proc_dir_entry *proc_pccard;
 
@@ -135,6 +143,7 @@
 /*======================================================================*/
 
 static struct pcmcia_driver * get_pcmcia_driver (dev_info_t *dev_info);
+static socket_info_t * get_socket_info_by_nr(unsigned int nr);
 
 /**
  * pcmcia_register_driver - register a PCMCIA driver with the bus core
@@ -160,17 +169,19 @@
 void pcmcia_unregister_driver(struct pcmcia_driver *driver)
 {
 	socket_bind_t *b;
-	int i;
+	socket_info_t *bus_sock;
 
 	if (driver->use_count > 0) {
 		/* Blank out any left-over device instances */
 		driver->attach = NULL; driver->detach = NULL;
-		for (i = 0; i < sockets; i++)
-			for (b = socket_table[i].bind; b; b = b->next)
+		down_read(&bus_socket_list_rwsem);
+		list_for_each_entry(bus_sock, &bus_socket_list, socket_list) {
+			for (b = bus_sock->bind; b; b = b->next)
 				if (b->driver == driver) 
 					b->instance = NULL;
- 	}
-
+		}
+		up_read(&bus_socket_list_rwsem);
+	}
 	driver_unregister(&driver->drv);
 }
 EXPORT_SYMBOL(pcmcia_unregister_driver);
@@ -182,7 +193,7 @@
 {
     struct pcmcia_driver *driver;
     socket_bind_t *b;
-    int i;
+    socket_info_t *bus_sock;
 
     DEBUG(0, "ds: register_pccard_driver('%s')\n", (char *)dev_info);
     driver = get_pcmcia_driver(dev_info);
@@ -199,15 +210,17 @@
     if (driver->use_count == 0) return 0;
     
     /* Instantiate any already-bound devices */
-    for (i = 0; i < sockets; i++)
-	for (b = socket_table[i].bind; b; b = b->next) {
+    down_read(&bus_socket_list_rwsem);
+    list_for_each_entry(bus_sock, &bus_socket_list, socket_list) {
+	for (b = bus_sock->bind; b; b = b->next) {
 	    if (b->driver != driver) continue;
 	    b->instance = driver->attach();
 	    if (b->instance == NULL)
 		printk(KERN_NOTICE "ds: unable to create instance "
 		       "of '%s'!\n", driver->drv.name);
 	}
-    
+    }
+    up_read(&bus_socket_list_rwsem);
     return 0;
 } /* register_pccard_driver */
 
@@ -309,7 +322,7 @@
 
 static void handle_removal(u_long sn)
 {
-    socket_info_t *s = &socket_table[sn];
+    socket_info_t *s = get_socket_info_by_nr(sn);
     handle_event(s, CS_EVENT_CARD_REMOVAL);
     s->state &= ~SOCKET_REMOVAL_PENDING;
 }
@@ -329,7 +342,7 @@
     DEBUG(1, "ds: ds_event(0x%06x, %d, 0x%p)\n",
 	  event, priority, args->client_handle);
     s = args->client_data;
-    i = s - socket_table;
+    i = s->socket_no;
     
     switch (event) {
 	
@@ -400,9 +413,12 @@
     struct pcmcia_driver *driver;
     socket_bind_t *b;
     bind_req_t bind_req;
-    socket_info_t *s = &socket_table[i];
+    socket_info_t *s = get_socket_info_by_nr(i);
     int ret;
 
+    if (!s)
+	    return -EINVAL;
+
     DEBUG(2, "bind_request(%d, '%s')\n", i,
 	  (char *)bind_info->dev_info);
     driver = get_pcmcia_driver(&bind_info->dev_info);
@@ -464,7 +480,7 @@
 
 static int get_device_info(int i, bind_info_t *bind_info, int first)
 {
-    socket_info_t *s = &socket_table[i];
+    socket_info_t *s = get_socket_info_by_nr(i);
     socket_bind_t *b;
     dev_node_t *node;
 
@@ -534,7 +550,7 @@
 
 static int unbind_request(int i, bind_info_t *bind_info)
 {
-    socket_info_t *s = &socket_table[i];
+    socket_info_t *s = get_socket_info_by_nr(i);
     socket_bind_t **b, *c;
 
     DEBUG(2, "unbind_request(%d, '%s')\n", i,
@@ -572,9 +588,11 @@
     user_info_t *user;
 
     DEBUG(0, "ds_open(socket %d)\n", i);
-    if ((i >= sockets) || (sockets == 0))
-	return -ENODEV;
-    s = &socket_table[i];
+
+    s = get_socket_info_by_nr(i);
+    if (!s)
+	    return -ENODEV;
+
     if ((file->f_flags & O_ACCMODE) != O_RDONLY) {
 	if (s->state & SOCKET_BUSY)
 	    return -EBUSY;
@@ -604,9 +622,11 @@
     user_info_t *user, **link;
 
     DEBUG(0, "ds_release(socket %d)\n", i);
-    if ((i >= sockets) || (sockets == 0))
-	return 0;
-    s = &socket_table[i];
+
+    s = get_socket_info_by_nr(i);
+    if (!s)
+	    return 0;
+
     user = file->private_data;
     if (CHECK_USER(user))
 	goto out;
@@ -637,11 +657,13 @@
 
     DEBUG(2, "ds_read(socket %d)\n", i);
     
-    if ((i >= sockets) || (sockets == 0))
-	return -ENODEV;
     if (count < 4)
 	return -EINVAL;
-    s = &socket_table[i];
+
+    s = get_socket_info_by_nr(i);
+    if (!s)
+	    return -ENODEV;
+
     user = file->private_data;
     if (CHECK_USER(user))
 	return -EIO;
@@ -666,13 +688,15 @@
 
     DEBUG(2, "ds_write(socket %d)\n", i);
     
-    if ((i >= sockets) || (sockets == 0))
-	return -ENODEV;
     if (count != 4)
 	return -EINVAL;
     if ((file->f_flags & O_ACCMODE) == O_RDONLY)
 	return -EBADF;
-    s = &socket_table[i];
+
+    s = get_socket_info_by_nr(i);
+    if (!s)
+	    return -ENODEV;
+
     user = file->private_data;
     if (CHECK_USER(user))
 	return -EIO;
@@ -699,9 +723,10 @@
 
     DEBUG(2, "ds_poll(socket %d)\n", i);
     
-    if ((i >= sockets) || (sockets == 0))
-	return POLLERR;
-    s = &socket_table[i];
+    s = get_socket_info_by_nr(i);
+    if (!s)
+	    return POLLERR;
+
     user = file->private_data;
     if (CHECK_USER(user))
 	return POLLERR;
@@ -724,9 +749,9 @@
 
     DEBUG(2, "ds_ioctl(socket %d, %#x, %#lx)\n", i, cmd, arg);
     
-    if ((i >= sockets) || (sockets == 0))
-	return -ENODEV;
-    s = &socket_table[i];
+    s = get_socket_info_by_nr(i);
+    if (!s)
+	    return -ENODEV;
     
     size = (cmd & IOCSIZE_MASK) >> IOCSIZE_SHIFT;
     if (size > sizeof(ds_ioctl_arg_t)) return -EINVAL;
@@ -889,141 +914,199 @@
 
 /*====================================================================*/
 
-struct bus_type pcmcia_bus_type = {
-	.name = "pcmcia",
-};
-EXPORT_SYMBOL(pcmcia_bus_type);
-
-static int __init init_pcmcia_bus(void)
+static int __devinit pcmcia_bus_add_socket(struct device *dev, unsigned int socket_nr)
 {
-	bus_register(&pcmcia_bus_type);
-	return 0;
-}
+	client_reg_t client_reg;
+	bind_req_t bind;
+	socket_info_t *s, *tmp_s;
+	int ret;
+	int i;
 
-static int __init init_pcmcia_ds(void)
-{
-    client_reg_t client_reg;
-    servinfo_t serv;
-    bind_req_t bind;
-    socket_info_t *s;
-    int i, ret;
-    
-    DEBUG(0, "%s\n", version);
- 
-    /*
-     * Ugly. But we want to wait for the socket threads to have started up.
-     * We really should let the drivers themselves drive some of this..
-     */
-    current->state = TASK_INTERRUPTIBLE;
-    schedule_timeout(HZ/4);
+	s = kmalloc(sizeof(socket_info_t), GFP_KERNEL);
+	if(!s)
+		return -ENOMEM;
+	memset(s, 0, sizeof(socket_info_t));
+    
+	/*
+	 * Ugly. But we want to wait for the socket threads to have started up.
+	 * We really should let the drivers themselves drive some of this..
+	 */
+	current->state = TASK_INTERRUPTIBLE;
+	schedule_timeout(HZ/4);
 
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
 	init_waitqueue_head(&s->queue);
 	init_waitqueue_head(&s->request);
-	s->handle = NULL;
-	init_timer(&s->removal);
-	s->removal.data = i;
+
+	/* find the lowest, unused socket no. Please note that this is a
+	 * temporary workaround until "struct pcmcia_socket" is introduced
+	 * into cs.c which will include this number, and which will be
+	 * accessible to ds.c directly */
+	i = 0;
+ next_try:
+	list_for_each_entry(tmp_s, &bus_socket_list, socket_list) {
+		if (tmp_s->socket_no == i) {
+			i++;
+			goto next_try;
+		}
+	}
+	s->socket_no = i;
+
+	/* initialize data */
+	s->socket_dev = dev;
+	s->removal.data = s->socket_no;
 	s->removal.function = &handle_removal;
-	s->bind = NULL;
-    }
+	init_timer(&s->removal);
     
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
+	/* Set up hotline to Card Services */
+	client_reg.dev_info = bind.dev_info = &dev_info;
+
+	bind.Socket = s->socket_no;
 	bind.Function = BIND_FN_ALL;
 	ret = pcmcia_bind_device(&bind);
 	if (ret != CS_SUCCESS) {
-	    cs_error(NULL, BindDevice, ret);
-	    break;
+		cs_error(NULL, BindDevice, ret);
+		kfree(s);
+		return -EINVAL;
 	}
-	client_reg.event_callback_args.client_data = &socket_table[i];
-	ret = pcmcia_register_client(&socket_table[i].handle,
-			   &client_reg);
+
+	client_reg.Attributes = INFO_MASTER_CLIENT;
+	client_reg.EventMask =
+		CS_EVENT_CARD_INSERTION | CS_EVENT_CARD_REMOVAL |
+		CS_EVENT_RESET_PHYSICAL | CS_EVENT_CARD_RESET |
+		CS_EVENT_EJECTION_REQUEST | CS_EVENT_INSERTION_REQUEST |
+		CS_EVENT_PM_SUSPEND | CS_EVENT_PM_RESUME;
+	client_reg.event_handler = &ds_event;
+	client_reg.Version = 0x0210;
+	client_reg.event_callback_args.client_data = s;
+	ret = pcmcia_register_client(&s->handle, &client_reg);
 	if (ret != CS_SUCCESS) {
-	    cs_error(NULL, RegisterClient, ret);
-	    break;
+		cs_error(NULL, RegisterClient, ret);
+		kfree(s);
+		return -EINVAL;
 	}
-    }
-    
-    /* Set up character device for user mode clients */
-    i = register_chrdev(0, "pcmcia", &ds_fops);
-    if (i == -EBUSY)
-	printk(KERN_NOTICE "unable to find a free device # for "
-	       "Driver Services\n");
-    else
-	major_dev = i;
 
-#ifdef CONFIG_PROC_FS
-    if (proc_pccard)
-	create_proc_read_entry("drivers",0,proc_pccard,proc_read_drivers,NULL);
-    init_status = 0;
-#endif
-    return 0;
+	list_add(&s->socket_list, &bus_socket_list);
+
+	return 0;
 }
 
 
-static void __exit exit_pcmcia_ds(void)
+static int __devinit pcmcia_bus_add_socket_dev(struct device *dev)
 {
-    int i;
+	struct pcmcia_socket_class_data *cls_d = dev->class_data;
+	unsigned int i;
+	unsigned int ret = 0;
+
+	if (!cls_d)
+		return -ENODEV;
+
+	down_write(&bus_socket_list_rwsem);
+        for (i = 0; i < cls_d->nsock; i++)
+		ret += pcmcia_bus_add_socket(dev, i);
+	up_write(&bus_socket_list_rwsem);
+
+	return ret;
+}
+
+static int __devexit pcmcia_bus_remove_socket_dev(struct device *dev)
+{
+	struct pcmcia_socket_class_data *cls_d = dev->class_data;
+	struct list_head *list_loop;
+	struct list_head *tmp_storage;
+
+	if (!cls_d)
+		return -ENODEV;
+
+	down_write(&bus_socket_list_rwsem);
+	list_for_each_safe(list_loop, tmp_storage, &bus_socket_list) {
+		socket_info_t *bus_sock = container_of(list_loop, socket_info_t, socket_list);
+		if (bus_sock->socket_dev == dev) {
+			pcmcia_deregister_client(bus_sock->handle);
+			list_del(&bus_sock->socket_list);
+			kfree(bus_sock);
+		}
+	}
+	up_write(&bus_socket_list_rwsem);
+	return 0;
+}
+
+
+/* the pcmcia_bus_interface is used to handle pcmcia socket devices */
+static struct device_interface pcmcia_bus_interface = {
+	.name = "pcmcia-bus",
+	.devclass = &pcmcia_socket_class,
+	.add_device = &pcmcia_bus_add_socket_dev,
+	.remove_device = __devexit_p(&pcmcia_bus_remove_socket_dev),
+	.kset = { .subsys = &pcmcia_socket_class.subsys, },
+	.devnum = 0,
+};
+
+
+struct bus_type pcmcia_bus_type = {
+	.name = "pcmcia",
+};
+EXPORT_SYMBOL(pcmcia_bus_type);
+
+
+static int __init init_pcmcia_bus(void)
+{
+	int i;
+
+	bus_register(&pcmcia_bus_type);
+	interface_register(&pcmcia_bus_interface);
+
+	/* Set up character device for user mode clients */
+	i = register_chrdev(0, "pcmcia", &ds_fops);
+	if (i == -EBUSY)
+		printk(KERN_NOTICE "unable to find a free device # for "
+		       "Driver Services\n");
+	else
+		major_dev = i;
+
 #ifdef CONFIG_PROC_FS
-    if (proc_pccard)
-	remove_proc_entry("drivers", proc_pccard);
+	if (proc_pccard)
+		create_proc_read_entry("drivers",0,proc_pccard,proc_read_drivers,NULL);
 #endif
-    if (major_dev != -1)
-	unregister_chrdev(major_dev, "pcmcia");
-    for (i = 0; i < sockets; i++)
-	pcmcia_deregister_client(socket_table[i].handle);
-    sockets = 0;
-    kfree(socket_table);
-    bus_unregister(&pcmcia_bus_type);
+
+	return 0;
 }
+fs_initcall(init_pcmcia_bus); /* one level after subsys_initcall so that 
+			       * pcmcia_socket_class is already registered */
 
-#ifdef MODULE
 
-/* init_pcmcia_bus must be done early, init_pcmcia_ds late. If we load this 
- * as a module, we can only specify one initcall, though... 
- */
-static int __init init_pcmcia_module(void) {
-	init_pcmcia_bus();
-	return init_pcmcia_ds();
-}
-module_init(init_pcmcia_module);
-
-#else /* !MODULE */
-subsys_initcall(init_pcmcia_bus);
-late_initcall(init_pcmcia_ds);
+static void __exit exit_pcmcia_bus(void)
+{
+	interface_unregister(&pcmcia_bus_interface);
+
+#ifdef CONFIG_PROC_FS
+	if (proc_pccard)
+		remove_proc_entry("drivers", proc_pccard);
 #endif
+	if (major_dev != -1)
+		unregister_chrdev(major_dev, "pcmcia");
+
+	bus_unregister(&pcmcia_bus_type);
+}
+module_exit(exit_pcmcia_bus);
 
-module_exit(exit_pcmcia_ds);
 
 
 /* helpers for backwards-compatible functions */
 
+
+static socket_info_t * get_socket_info_by_nr(unsigned int nr)
+{
+	socket_info_t * s;
+	down_read(&bus_socket_list_rwsem);
+	list_for_each_entry(s, &bus_socket_list, socket_list)
+		if (s->socket_no == nr) {
+			up_read(&bus_socket_list_rwsem);
+			return s;
+		}
+	up_read(&bus_socket_list_rwsem);
+	return NULL;
+}
+
 /* backwards-compatible accessing of driver --- by name! */
 
 struct cmp_data {
