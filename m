Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263426AbTC2Oex>; Sat, 29 Mar 2003 09:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263427AbTC2Oex>; Sat, 29 Mar 2003 09:34:53 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:29101 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S263426AbTC2Oen>; Sat, 29 Mar 2003 09:34:43 -0500
Date: Sat, 29 Mar 2003 15:45:47 +0100
From: Dominik Brodowski <linux@brodo.de>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5] pcmcia: add struct pcmcia_device
Message-ID: <20030329144547.GA17956@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a struct pcmcia_device, and fills it with content for
every function of every pcmcia card inserted into the socket.

Unfortunately, information about the card can only be detected when
"cardmgr"[*] has told the pcmcia rsrc_mgr on what IO-ports and what
IO-mem is available for usage by the pcmcia core or drivers. So the
cards need to be re-scanned on completion of the pcmcia
initialization.

Re-starting cardmgr will not re-enable the resources.

      Dominik

 drivers/pcmcia/cistpl.c |    3
 drivers/pcmcia/ds.c     |  207 ++++++++++++++++++++++++++++++++++++++++++++++--
 include/pcmcia/ds.h     |   24 +++++
 3 files changed, 227 insertions(+), 7 deletions(-)


diff -ruN linux-original/drivers/pcmcia/cistpl.c linux/drivers/pcmcia/cistpl.c
--- linux-original/drivers/pcmcia/cistpl.c	2003-03-29 15:16:03.000000000 +0100
+++ linux/drivers/pcmcia/cistpl.c	2003-03-29 15:37:35.000000000 +0100
@@ -1392,6 +1392,7 @@
     ret = pcmcia_parse_tuple(handle, &tuple, parse);
     return ret;
 }
+EXPORT_SYMBOL(read_tuple);
 
 /*======================================================================
 
@@ -1451,4 +1452,4 @@
 
     return CS_SUCCESS;
 }
-
+EXPORT_SYMBOL(pcmcia_validate_cis);
diff -ruN linux-original/drivers/pcmcia/ds.c linux/drivers/pcmcia/ds.c
--- linux-original/drivers/pcmcia/ds.c	2003-03-29 15:22:14.000000000 +0100
+++ linux/drivers/pcmcia/ds.c	2003-03-29 15:37:35.000000000 +0100
@@ -108,11 +108,16 @@
 	struct device		*socket_dev;
 	struct list_head	socket_list;
 	unsigned int		socket_no; /* deprecated */
+	/* the PCMCIA devices connected to this socket (normally one, more
+	 * for multifunction devices: */
+	struct list_head	devices_list;
+	struct semaphore	devices_list_sem;
 };
 
 #define SOCKET_PRESENT		0x01
 #define SOCKET_BUSY		0x02
 #define SOCKET_REMOVAL_PENDING	0x10
+#define SOCKET_ADDING_PENDING	0x20
 
 /*====================================================================*/
 
@@ -121,6 +126,12 @@
 
 static int major_dev = -1;
 
+/* this is set to 1 when the iomem/ioport configuration of rsrc_mgr.c
+ * is completed -- only then it is possible to decode the name, manfid,
+ * prodid, etc. of the pcmcia card.
+ */
+static int resources_available = 0;
+
 /* list of all sockets registered with the pcmcia bus driver */
 static DECLARE_RWSEM(bus_socket_list_rwsem);
 static LIST_HEAD(bus_socket_list);
@@ -138,6 +149,10 @@
 
 /*======================================================================*/
 
+int validate_cis(client_handle_t handle, cisinfo_t *info);
+int read_tuple(client_handle_t handle, cisdata_t code, void *parse);
+
+
 static struct pcmcia_driver * get_pcmcia_driver (dev_info_t *dev_info);
 static struct pcmcia_bus_socket * get_socket_info_by_nr(unsigned int nr);
 
@@ -250,6 +265,152 @@
 }
 #endif
 
+/*====================================================================*/
+
+static int pcmcia_add_card(struct pcmcia_bus_socket *s)
+{
+	struct pcmcia_device *p_dev;
+	int ret;
+	unsigned int has_cis = 0;
+	unsigned int func = 0, no_funcs = 1;
+
+	down(&s->devices_list_sem);
+
+ next_device:
+	p_dev = kmalloc(sizeof(struct pcmcia_device), GFP_KERNEL);
+	if (!p_dev) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	memset(p_dev, 0, sizeof(struct pcmcia_device));
+	p_dev->dev.bus = &pcmcia_bus_type;
+	p_dev->dev.parent = s->socket_dev;
+	p_dev->socket_no = s->socket_no;
+	p_dev->bus_sock = s;
+
+	/* first case: no resources are available, so we can't decode
+	 * any device information */
+	if (!resources_available) {
+		sprintf (p_dev->dev.bus_id, "pcmcia%d:%d.?", 
+			 s->socket_dev->class_num, s->socket_no);
+		sprintf (p_dev->dev.name, "unknown");
+		ret = device_register(&p_dev->dev);
+		if (ret) {
+			kfree(p_dev);
+			goto out;
+		}
+		list_add(&p_dev->socket_device_list, &s->devices_list);
+		goto out;
+	}
+
+	/* if we got here for the first time, we need to check whether
+	 * the CIS is valid etc. */
+	if (!func) {
+		cisinfo_t cisinfo;
+		ret = pcmcia_validate_cis(s->handle, &cisinfo);
+		if (ret || !cisinfo.Chains) {
+			printk(KERN_INFO "pcmcia: inserted card has invalid CIS.\n");
+		} else {
+			cistpl_longlink_mfc_t mfc;
+
+			has_cis = 1;
+			if (!read_tuple(s->handle, CISTPL_LONGLINK_MFC, &mfc))
+				no_funcs = mfc.nfn;
+			else
+				no_funcs = 1;
+		}
+	}
+
+	p_dev->func = func;
+	p_dev->has_cis = has_cis;
+
+	/* don't rely on this yet -- the second value will change from socket_no to
+	 * the number within the socket_dev */
+	sprintf (p_dev->dev.bus_id, "pcmcia%d:%d.%d", 
+		 s->socket_dev->class_num, s->socket_no, p_dev->func);
+
+	/* read out device name "vers_1" */
+	if (!has_cis || (read_tuple(s->handle, CISTPL_VERS_1, &p_dev->vers1)))
+		p_dev->vers1.ns = 0;
+
+	if (p_dev->vers1.ns) {
+		char name[255] = "\0";
+		int i = 0;
+		for (i=0; i < p_dev->vers1.ns; i++) {
+			strcat(name, (p_dev->vers1.str + p_dev->vers1.ofs[i]));
+			strcat(name, " ");
+		}
+		snprintf(p_dev->dev.name, DEVICE_NAME_SIZE, "%s", name);
+	} else
+		sprintf (p_dev->dev.name, "unknown");
+
+	/* read out manufacture ID */
+	if (has_cis && !(read_tuple(s->handle, CISTPL_MANFID, &p_dev->manfid)))
+		p_dev->has_manfid = 1;
+
+	/* read out function ID -- rule of thumb: cards with no FUNCID, but with 
+	 * common memory device geometry information, are probably memory cards */
+	if (has_cis && !(read_tuple(s->handle, CISTPL_FUNCID, &p_dev->funcid)))
+		p_dev->has_funcid = 1;
+	else {
+		cistpl_device_geo_t devgeo;
+		if (has_cis && !(read_tuple(s->handle, CISTPL_DEVICE_GEO, &devgeo))) {
+			p_dev->has_funcid = 1;
+			p_dev->funcid.func = CISTPL_FUNCID_MEMORY;
+		}
+	}
+
+	/* register it both with the driver model core and with the bus socket list */
+	ret = device_register(&p_dev->dev);
+	if (ret) {
+		kfree(p_dev);
+		goto out;
+	}
+	list_add(&p_dev->socket_device_list, &s->devices_list);
+
+	/* if we got a multifunction device, we need to register more devices,
+	 * so go back up */
+	func++;
+	if (no_funcs > func)
+		goto next_device;
+
+ out:
+	up(&s->devices_list_sem);
+	return ret;
+}
+
+static void pcmcia_remove_card(struct pcmcia_bus_socket *s)
+{
+	struct list_head *p1;
+	struct list_head *p2;
+
+	down(&s->devices_list_sem);
+	list_for_each_safe(p1, p2, &s->devices_list) {
+		struct pcmcia_device *p_dev = container_of(p1, struct pcmcia_device, socket_device_list);
+		device_unregister(&p_dev->dev);
+		list_del(&p_dev->socket_device_list);
+		kfree(p_dev);
+	}
+	up(&s->devices_list_sem);
+}
+
+static void pcmcia_rescan_cards(void)
+{
+	struct pcmcia_bus_socket *bus_sock;
+
+	down_read(&bus_socket_list_rwsem);
+
+	list_for_each_entry(bus_sock, &bus_socket_list, socket_list) {
+		if (list_empty(&bus_sock->devices_list))
+			continue;
+		pcmcia_remove_card(bus_sock);
+		pcmcia_add_card(bus_sock);
+	}			
+
+	up_read(&bus_socket_list_rwsem);
+}
+
+
 /*======================================================================
 
     These manage a ring buffer of events pending for one user process
@@ -303,10 +464,20 @@
 static void handle_removal(u_long sn)
 {
     struct pcmcia_bus_socket *s = get_socket_info_by_nr(sn);
+    pcmcia_remove_card(s);
     handle_event(s, CS_EVENT_CARD_REMOVAL);
     s->state &= ~SOCKET_REMOVAL_PENDING;
 }
 
+static void handle_adding(u_long sn)
+{
+    struct pcmcia_bus_socket *s = get_socket_info_by_nr(sn);
+    pcmcia_add_card(s);
+    s->state |= SOCKET_PRESENT;
+    handle_event(s, CS_EVENT_CARD_INSERTION);
+    s->state &= ~SOCKET_ADDING_PENDING;
+}
+
 /*======================================================================
 
     The card status event handler.
@@ -329,14 +500,20 @@
 	if (!(s->state & SOCKET_REMOVAL_PENDING)) {
 	    s->state |= SOCKET_REMOVAL_PENDING;
 	    init_timer(&s->removal);
+	    s->removal.function = &handle_removal;
 	    s->removal.expires = jiffies + HZ/10;
 	    add_timer(&s->removal);
 	}
 	break;
 	
     case CS_EVENT_CARD_INSERTION:
-	s->state |= SOCKET_PRESENT;
-	handle_event(s, event);
+	if (!(s->state & SOCKET_ADDING_PENDING)) {
+	    s->state |= SOCKET_ADDING_PENDING;
+	    init_timer(&s->removal);
+	    s->removal.function = &handle_adding;
+	    s->removal.expires = jiffies + HZ/10;
+	    add_timer(&s->removal);
+	}
 	break;
 
     case CS_EVENT_EJECTION_REQUEST:
@@ -569,7 +746,7 @@
 	else
 	    s->state |= SOCKET_BUSY;
     }
-    
+
     user = kmalloc(sizeof(user_info_t), GFP_KERNEL);
     if (!user) return -ENOMEM;
     user->event_tail = user->event_head = 0;
@@ -716,6 +893,7 @@
     u_int size;
     int ret, err;
     ds_ioctl_arg_t buf;
+    static int ioctl_resources_status = 0;
 
     DEBUG(2, "ds_ioctl(socket %d, %#x, %#lx)\n", i, cmd, arg);
     
@@ -749,10 +927,25 @@
     
     if (cmd & IOC_IN) copy_from_user((char *)&buf, (char *)arg, size);
     
+    if ((cmd != DS_ADJUST_RESOURCE_INFO) && (ioctl_resources_status)) {
+	    if (ioctl_resources_status == 1) {
+		    resources_available = 1;
+		    pcmcia_rescan_cards();
+	    }
+	    ioctl_resources_status = 0;
+    }
+
     switch (cmd) {
     case DS_ADJUST_RESOURCE_INFO:
-	ret = pcmcia_adjust_resource_info(s->handle, &buf.adjust);
-	break;
+	    if (resources_available) {
+		    /* gotta go */
+		    ioctl_resources_status = 2;
+		    resources_available = 0;
+		    pcmcia_rescan_cards();
+	    } else if (!ioctl_resources_status)
+		    ioctl_resources_status = 1;
+	    ret = pcmcia_adjust_resource_info(s->handle, &buf.adjust);
+	    break;
     case DS_GET_CARD_SERVICES_INFO:
 	ret = pcmcia_get_card_services_info(&buf.servinfo);
 	break;
@@ -924,8 +1117,9 @@
 	/* initialize data */
 	s->socket_dev = dev;
 	s->removal.data = s->socket_no;
-	s->removal.function = &handle_removal;
 	init_timer(&s->removal);
+	init_MUTEX(&s->devices_list_sem);
+	INIT_LIST_HEAD(&s->devices_list);
     
 	/* Set up hotline to Card Services */
 	client_reg.dev_info = bind.dev_info = &dev_info;
@@ -991,6 +1185,7 @@
 	list_for_each_safe(list_loop, tmp_storage, &bus_socket_list) {
 		struct pcmcia_bus_socket *bus_sock = container_of(list_loop, struct pcmcia_bus_socket, socket_list);
 		if (bus_sock->socket_dev == dev) {
+			pcmcia_remove_card(bus_sock);
 			pcmcia_deregister_client(bus_sock->handle);
 			list_del(&bus_sock->socket_list);
 			kfree(bus_sock);
diff -ruN linux-original/include/pcmcia/ds.h linux/include/pcmcia/ds.h
--- linux-original/include/pcmcia/ds.h	2003-03-29 15:22:14.000000000 +0100
+++ linux/include/pcmcia/ds.h	2003-03-29 15:37:35.000000000 +0100
@@ -165,5 +165,29 @@
 /* error reporting */
 void cs_error(client_handle_t handle, int func, int ret);
 
+struct pcmcia_bus_socket;
+
+struct pcmcia_device {
+	unsigned int			socket_no; /* deprecated */
+	struct pcmcia_bus_socket	*bus_sock;
+	struct list_head		socket_device_list;
+	unsigned int			func;
+
+	/* cis information */
+	unsigned int			has_cis;
+	cistpl_vers_1_t			vers1;
+
+	unsigned int			has_manfid;
+	cistpl_manfid_t			manfid;
+
+	unsigned int			has_funcid;
+	cistpl_funcid_t			funcid;
+
+	struct device			dev;
+};
+
+#define to_pcmcia_dev(n) container_of(n, struct pcmcia_device, dev)
+#define to_pcmcia_drv(n) container_of(n, struct pcmcia_driver, drv)
+
 #endif /* __KERNEL__ */
 #endif /* _LINUX_DS_H */
