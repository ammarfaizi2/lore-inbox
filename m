Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267892AbUHFCct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267892AbUHFCct (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 22:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbUHFCct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 22:32:49 -0400
Received: from c3-1d224.neo.lrun.com ([24.93.233.224]:19842 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S267892AbUHFCcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 22:32:31 -0400
Date: Thu, 5 Aug 2004 22:20:26 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: rmk@arm.linux.org.uk
Cc: linux@dominikbrodowski.de, akpm@osdl.org, rml@ximian.com,
       linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Subject: [PATCH] pcmcia driver model support [1/5]
Message-ID: <20040805222026.GA11641@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, rmk@arm.linux.org.uk,
	linux@dominikbrodowski.de, akpm@osdl.org, rml@ximian.com,
	linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch set is an updated version from the last and is against 2.6.8-rc3.  It
includes suggestions from Dominik and an independent pcmcia bugfix.  I would
appreciate any comments.

Thanks,
Adam


[PCMCIA] implement driver model support

This patch adds driver model support to the pcmcia bus driver.

--- a/drivers/pcmcia/cs_internal.h	2004-08-05 13:05:45.000000000 +0000
+++ b/drivers/pcmcia/cs_internal.h	2004-08-05 13:08:38.000000000 +0000
@@ -33,6 +33,7 @@
 typedef struct client_t {
     u_short		client_magic;
     struct pcmcia_socket *Socket;
+    struct device      *device;
     u_char		Function;
     dev_info_t		dev_info;
     u_int		Attributes;
--- a/drivers/pcmcia/cs.c	2004-08-05 13:05:45.000000000 +0000
+++ b/drivers/pcmcia/cs.c	2004-08-05 13:08:38.000000000 +0000
@@ -1160,6 +1160,22 @@
 
 #endif
 
+/*=====================================================================
+
+    Return the driver model device associated with a card..
+
+======================================================================*/
+
+struct device *pcmcia_lookup_device(client_handle_t handle)
+{
+	if (CHECK_HANDLE(handle))
+		return NULL;
+
+	return handle->device;
+}
+
+EXPORT_SYMBOL(pcmcia_lookup_device);
+
 /*======================================================================
 
     Get the current socket state bits.  We don't support the latched
@@ -2154,6 +2170,7 @@
 EXPORT_SYMBOL(pcmcia_suspend_card);
 EXPORT_SYMBOL(pcmcia_validate_cis);
 EXPORT_SYMBOL(pcmcia_write_memory);
+EXPORT_SYMBOL(read_tuple);
 
 EXPORT_SYMBOL(dead_socket);
 EXPORT_SYMBOL(MTDHelperEntry);
--- a/drivers/pcmcia/ds.c	2004-08-05 13:05:45.000000000 +0000
+++ b/drivers/pcmcia/ds.c	2004-08-05 13:12:03.000000000 +0000
@@ -119,6 +119,8 @@
 	struct work_struct	removal;
 	socket_bind_t		*bind;
 	struct pcmcia_socket	*parent;
+	struct list_head	devices;
+	struct semaphore	device_mutex;
 };
 
 #define DS_SOCKET_PRESENT		0x01
@@ -164,6 +166,7 @@
 	client->client_magic = CLIENT_MAGIC;
 	strlcpy(client->dev_info, (char *)req->dev_info, DEV_NAME_LEN);
 	client->Socket = s;
+	client->device = &req->device->dev;
 	client->Function = req->Function;
 	client->state = CLIENT_UNBOUND;
 	client->erase_busy.next = &client->erase_busy;
@@ -354,6 +357,8 @@
 
 /*======================================================================*/
 
+static struct pcmcia_device * get_pcmcia_device (struct pcmcia_bus_socket *s, int function);
+static void put_pcmcia_device(struct pcmcia_device *dev);
 static struct pcmcia_driver * get_pcmcia_driver (dev_info_t *dev_info);
 static struct pcmcia_bus_socket * get_socket_info_by_nr(unsigned int nr);
 
@@ -430,6 +435,150 @@
 
 /*======================================================================
 
+    sysfs support
+
+======================================================================*/
+
+static ssize_t
+pcmcia_show_product_string(struct pcmcia_device *dev, char *buf, int index)
+{
+	char *str = buf;
+
+	if (dev->id_mask & DEVICE_HAS_VERSION_INFO && index < dev->vers_1.ns)
+		str += sprintf(str,"%s\n",
+			       dev->vers_1.str+dev->vers_1.ofs[index]);
+	else
+		str += sprintf(str,"\n");
+	return (str - buf);
+}
+
+#define pcmcia_prod_str_attr(field, index)				\
+static ssize_t								\
+show_##field (struct device *dmdev, char *buf)				\
+{									\
+	struct pcmcia_device *dev;					\
+									\
+	dev = to_pcmcia_device (dmdev);					\
+	return pcmcia_show_product_string(dev,buf,index);		\
+}									\
+static DEVICE_ATTR(field, S_IRUGO, show_##field, NULL);
+
+pcmcia_prod_str_attr(prod_str0,0);
+pcmcia_prod_str_attr(prod_str1,1);
+pcmcia_prod_str_attr(prod_str2,2);
+pcmcia_prod_str_attr(prod_str3,3);
+
+static ssize_t
+pcmcia_show_manfid(struct device *dmdev, char *buf)
+{
+	struct pcmcia_device *dev = to_pcmcia_device(dmdev);
+	char *str = buf;
+
+	if (dev->id_mask & DEVICE_HAS_MANF_INFO)
+		str += sprintf(str,"0x%04x, 0x%04x\n",
+			       dev->manfid.manf,
+			       dev->manfid.card);
+	else
+		str += sprintf(str,"\n");
+	return (str - buf);
+}
+
+static DEVICE_ATTR(manfid,S_IRUGO,pcmcia_show_manfid,NULL);
+
+static void pcmcia_sysfs_attach(struct pcmcia_device *dev)
+{
+	device_create_file (&dev->dev, &dev_attr_prod_str0);
+	device_create_file (&dev->dev, &dev_attr_prod_str1);
+	device_create_file (&dev->dev, &dev_attr_prod_str2);
+	device_create_file (&dev->dev, &dev_attr_prod_str3);
+	device_create_file (&dev->dev, &dev_attr_manfid);
+}
+
+/*======================================================================
+
+    device addition, removal, and hotplug functions for the driver model
+
+======================================================================*/
+
+static void pcmcia_bus_release_device(struct device *pdev)
+{
+	struct pcmcia_device *dev = to_pcmcia_device(pdev);
+	kfree(dev);
+}
+
+static int pcmcia_bus_insert_card(struct pcmcia_bus_socket *s)
+{
+	struct pcmcia_device *dev;
+	int i, ret, function_count = 0, has_cis = 0;
+	cisinfo_t cisinfo;
+
+	if (!(s->state & DS_SOCKET_PRESENT))
+		return CS_NO_CARD;
+
+	down(&s->device_mutex);
+	if (!list_empty(&s->devices)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ret = pcmcia_validate_cis(s->handle, &cisinfo);
+	if (ret)
+		goto out;
+
+	if (cisinfo.Chains) {
+		cistpl_longlink_mfc_t mfc;
+
+		has_cis = 1;
+		if (!read_tuple(s->handle, CISTPL_LONGLINK_MFC, &mfc))
+			function_count = mfc.nfn;
+	}
+
+	for (i=0; i<=function_count; i++) {
+		dev = kmalloc(sizeof(struct pcmcia_device), GFP_KERNEL);
+		if (!dev)
+			continue;
+
+		memset(dev, 0, sizeof(struct pcmcia_device));
+		dev->socket = s;
+		dev->dev.parent = s->parent->dev.dev;
+		dev->dev.bus = &pcmcia_bus_type;
+		dev->dev.release = &pcmcia_bus_release_device;
+		snprintf(dev->dev.bus_id, BUS_ID_SIZE, "%u:%u", s->parent->sock, i);
+
+		dev->function = i;
+		if (has_cis) {
+			if (!read_tuple(s->handle, CISTPL_VERS_1, &dev->vers_1))
+				dev->id_mask |= DEVICE_HAS_VERSION_INFO;
+			if (!read_tuple(s->handle, CISTPL_MANFID, &dev->manfid))
+				dev->id_mask |= DEVICE_HAS_MANF_INFO;
+		}
+
+		ret = device_register(&dev->dev);
+		if (!ret) {
+			list_add_tail(&dev->device_list, &s->devices);
+			pcmcia_sysfs_attach(dev);
+		} else
+			kfree(dev);
+	}
+
+out:
+	up(&s->device_mutex);
+	return ret;
+}
+
+static void pcmcia_bus_remove_card(struct pcmcia_bus_socket *s)
+{
+	struct pcmcia_device *dev, *tmp;
+	down(&s->device_mutex);
+	list_for_each_entry_safe(dev, tmp, &s->devices, device_list) {
+		list_del(&dev->device_list);
+		device_unregister(&dev->dev);
+	}
+	up(&s->device_mutex);
+}
+
+/*======================================================================
+
     These manage a ring buffer of events pending for one user process
     
 ======================================================================*/
@@ -501,6 +650,7 @@
 	
     case CS_EVENT_CARD_REMOVAL:
 	s->state &= ~DS_SOCKET_PRESENT;
+	pcmcia_bus_remove_card(s);
 	if (!(s->state & DS_SOCKET_REMOVAL_PENDING)) {
 		s->state |= DS_SOCKET_REMOVAL_PENDING;
 		schedule_delayed_work(&s->removal,  HZ/10);
@@ -562,6 +712,7 @@
 static int bind_request(struct pcmcia_bus_socket *s, bind_info_t *bind_info)
 {
     struct pcmcia_driver *driver;
+    struct pcmcia_device *device;
     socket_bind_t *b;
     bind_req_t bind_req;
     int ret;
@@ -587,7 +738,12 @@
     if (!try_module_get(driver->owner))
 	    return -EINVAL;
 
+    device = get_pcmcia_device(s, bind_info->function);
+    if (!device)
+	    return -EINVAL;
+
     bind_req.Socket = s->parent;
+    bind_req.device = device;
     bind_req.Function = bind_info->function;
     bind_req.dev_info = (dev_info_t *) driver->drv.name;
     ret = pcmcia_bind_device(&bind_req);
@@ -614,16 +770,25 @@
     b->next = s->bind;
     s->bind = b;
     
+    down_write(&device->dev.bus->subsys.rwsem);
+    device->dev.driver = &driver->drv;
+
     if (driver->attach) {
 	b->instance = driver->attach();
 	if (b->instance == NULL) {
 	    printk(KERN_NOTICE "ds: unable to create instance "
 		   "of '%s'!\n", (char *)bind_info->dev_info);
 	    module_put(driver->owner);
+	    device->dev.driver = NULL;
+	    up_write(&device->dev.bus->subsys.rwsem);
 	    return -ENODEV;
 	}
     }
     
+    device_bind_driver(&device->dev);
+    up_write(&device->dev.bus->subsys.rwsem);
+    put_pcmcia_device(device);
+
     return 0;
 } /* bind_request */
 
@@ -699,6 +864,7 @@
 static int unbind_request(struct pcmcia_bus_socket *s, bind_info_t *bind_info)
 {
     socket_bind_t **b, *c;
+    struct pcmcia_device *device;
 
     ds_dbg(2, "unbind_request(%d, '%s')\n", s->parent->sock,
 	  (char *)bind_info->dev_info);
@@ -710,6 +876,14 @@
     if (*b == NULL)
 	return -ENODEV;
     
+    device = get_pcmcia_device(s, bind_info->function);
+    if (device) {
+	    down_write(&device->dev.bus->subsys.rwsem);
+	    device_release_driver(&device->dev);
+	    up_write(&device->dev.bus->subsys.rwsem);
+	    put_pcmcia_device(device);
+    }
+
     c = *b;
     c->driver->use_count--;
     if (c->driver->detach) {
@@ -1005,6 +1179,7 @@
 	break;
     case DS_BIND_REQUEST:
 	if (!capable(CAP_SYS_ADMIN)) return -EPERM;
+	pcmcia_bus_insert_card(s);
 	err = bind_request(s, &buf.bind_info);
 	break;
     case DS_GET_DEVICE_INFO:
@@ -1087,6 +1262,8 @@
 	init_waitqueue_head(&s->request);
 
 	/* initialize data */
+	INIT_LIST_HEAD(&s->devices);
+	init_MUTEX(&s->device_mutex);
 	INIT_WORK(&s->removal, handle_removal, s);
 	s->parent = socket;
 
@@ -1135,6 +1312,8 @@
 
 	pcmcia_deregister_client(socket->pcmcia->handle);
 
+	pcmcia_bus_remove_card(socket->pcmcia);
+
 	socket->pcmcia->state |= DS_SOCKET_DEAD;
 	pcmcia_put_bus_socket(socket->pcmcia);
 	socket->pcmcia = NULL;
@@ -1154,6 +1333,7 @@
 struct bus_type pcmcia_bus_type = {
 	.name = "pcmcia",
 };
+
 EXPORT_SYMBOL(pcmcia_bus_type);
 
 
@@ -1186,7 +1366,6 @@
 
 static void __exit exit_pcmcia_bus(void)
 {
-	class_interface_unregister(&pcmcia_bus_interface);
 
 #ifdef CONFIG_PROC_FS
 	if (proc_pccard) {
@@ -1197,6 +1376,7 @@
 	if (major_dev != -1)
 		unregister_chrdev(major_dev, "pcmcia");
 
+	class_interface_unregister(&pcmcia_bus_interface);
 	bus_unregister(&pcmcia_bus_type);
 }
 module_exit(exit_pcmcia_bus);
@@ -1244,3 +1424,24 @@
 		return cmp.drv;
 	return NULL;
 }
+
+static struct pcmcia_device * get_pcmcia_device (struct pcmcia_bus_socket *s, int function)
+{
+	struct pcmcia_device *dev, *tmp;
+	down(&s->device_mutex);
+	list_for_each_entry_safe(dev, tmp, &s->devices, device_list) {
+		if (dev->function == function) {
+			if (!get_device(&dev->dev))
+				break;
+			up(&s->device_mutex);
+			return dev;
+		}
+	}
+	up(&s->device_mutex);
+	return NULL;
+}
+
+static void put_pcmcia_device(struct pcmcia_device *dev)
+{
+	put_device(&dev->dev);
+}
--- a/include/pcmcia/cs.h	2004-08-05 13:02:07.000000000 +0000
+++ b/include/pcmcia/cs.h	2004-08-05 13:08:38.000000000 +0000
@@ -318,6 +318,7 @@
 /* Special stuff for binding drivers to sockets */
 typedef struct bind_req_t {
     struct pcmcia_socket	*Socket;
+    struct pcmcia_device	*device;
     u_char	Function;
     dev_info_t	*dev_info;
 } bind_req_t;
@@ -452,6 +453,7 @@
 int pcmcia_set_event_mask(client_handle_t handle, eventmask_t *mask);
 int pcmcia_report_error(client_handle_t handle, error_info_t *err);
 struct pci_bus *pcmcia_lookup_bus(client_handle_t handle);
+struct device *pcmcia_lookup_device(client_handle_t handle);
 
 /* rsrc_mgr.c */
 int pcmcia_adjust_resource_info(client_handle_t handle, adjust_t *adj);
--- a/include/pcmcia/ds.h	2004-08-05 13:02:07.000000000 +0000
+++ b/include/pcmcia/ds.h	2004-08-05 13:08:38.000000000 +0000
@@ -151,6 +151,21 @@
 	struct device_driver	drv;
 };
 
+struct pcmcia_device {
+	struct device dev;
+	struct pcmcia_bus_socket *socket;
+	struct list_head device_list;
+	int function;
+	int id_mask;
+	cistpl_vers_1_t vers_1;
+	cistpl_manfid_t manfid;
+};
+
+#define	to_pcmcia_device(n) container_of(n, struct pcmcia_device, dev)
+
+#define DEVICE_HAS_VERSION_INFO		0x0001
+#define DEVICE_HAS_MANF_INFO		0x0002
+
 /* driver registration */
 int pcmcia_register_driver(struct pcmcia_driver *driver);
 void pcmcia_unregister_driver(struct pcmcia_driver *driver);
