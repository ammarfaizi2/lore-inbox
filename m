Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263037AbTDBP42>; Wed, 2 Apr 2003 10:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263038AbTDBP42>; Wed, 2 Apr 2003 10:56:28 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:28151 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S263037AbTDBP4O>; Wed, 2 Apr 2003 10:56:14 -0500
Date: Wed, 2 Apr 2003 18:07:29 +0200
From: Dominik Brodowski <linux@brodo.de>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5] pcmcia: replace cardctl with in-kernel socketctl
Message-ID: <20030402160729.GA12109@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Socketctl can replace the userspace tool "cardctl" and provide the user with
many useful information in sysfs directories (one per socket) below the actual 
socket device. Also, "insert", "eject", "suspend", "resume" and "reset"
commands can be echo'ed into the file "status" in that directory.

As this does not depend on any other change, is a Good Thing IMO, and will
us enable to get rid of the ds.c ioctl after my devices/hotplug/matching changes
are merged.

	Dominik

 Kconfig     |    9 +
 Makefile    |    2
 socketctl.c |  448 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 459 insertions(+)

diff -ruN linux-original/drivers/pcmcia/Kconfig linux/drivers/pcmcia/Kconfig
--- linux-original/drivers/pcmcia/Kconfig	2003-04-02 16:19:39.000000000 +0200
+++ linux/drivers/pcmcia/Kconfig	2003-04-02 17:42:16.000000000 +0200
@@ -103,5 +103,14 @@
 	bool
 	default y if ISA && !ARCH_SA1100 && !ARCH_CLPS711X
 
+config PCMCIA_SOCKETCTL
+	tristate "Socket-Control"
+	depends on PCMCIA
+	help
+	  Say Y here for the new in-kernel functionality of the tool
+	  "cardctl". Specifically, you will be able to pass "insert",
+	  "eject", "suspend", "resume" and "reset" commands to the
+	  PCMCIA socket using a new sysfs interface. If unsure, say Y.
+
 endmenu
 
diff -ruN linux-original/drivers/pcmcia/Makefile linux/drivers/pcmcia/Makefile
--- linux-original/drivers/pcmcia/Makefile	2003-04-02 16:19:39.000000000 +0200
+++ linux/drivers/pcmcia/Makefile	2003-04-02 17:40:34.000000000 +0200
@@ -7,6 +7,8 @@
   obj-$(CONFIG_PCMCIA) 				+= yenta_socket.o
 endif
 
+obj-$(CONFIG_PCMCIA_SOCKETCTL)			+= socketctl.o
+
 obj-$(CONFIG_I82365)				+= i82365.o
 obj-$(CONFIG_I82092)				+= i82092.o
 obj-$(CONFIG_TCIC)				+= tcic.o
diff -ruN linux-original/drivers/pcmcia/socketctl.c linux/drivers/pcmcia/socketctl.c
--- linux-original/drivers/pcmcia/socketctl.c	1970-01-01 01:00:00.000000000 +0100
+++ linux/drivers/pcmcia/socketctl.c	2003-04-02 17:45:09.000000000 +0200
@@ -0,0 +1,448 @@
+/*
+ * linux/drivers/pcmcia/socketctl.c
+ *
+ * Copyright (C) 2003 Dominik Brodowski 
+ *           (C) 1999 David A. Hinds
+ * license : GPL v. 2
+ * based on the cardctl tool by David A. Hinds
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/proc_fs.h>
+
+#include <pcmcia/version.h>
+#include <pcmcia/cs_types.h>
+#include <pcmcia/cs.h>
+#include <pcmcia/ss.h>
+
+static struct device_interface socketctl_interface;
+
+struct socketctl_data {
+	struct list_head	socket_list;
+	struct kobject		kobj;
+	int			socket_no;
+	client_handle_t		handle;
+};
+
+static LIST_HEAD(socketctl_socket_list);
+static DECLARE_MUTEX		(socketctl_sem);
+
+
+static dev_info_t dev_info = "socketctl";
+
+/* Voltage information */
+
+#define show_one_voltage(object)	 				\
+static ssize_t show_##object 						\
+(struct socketctl_data * data, char *buf)				\
+{									\
+	config_info_t config;	 					\
+	int ret = -EINVAL;	 					\
+	config.Function = 0;	 					\
+	ret = pcmcia_get_configuration_info(data->handle, &config);	\
+	if (ret)	 						\
+		return 0;	 					\
+	return sprintf (buf, "%d.%1dV\n", 	 			\
+			config.object/10, config.object%10);	 	\
+}
+
+show_one_voltage(Vcc);
+show_one_voltage(Vpp1);
+show_one_voltage(Vpp2);
+
+
+/* IRQ information */
+
+static ssize_t show_irq (struct socketctl_data * data, char *buf)
+{
+	config_info_t config;
+	int ret = -EINVAL;
+
+	config.Function = 0;
+	ret = pcmcia_get_configuration_info(data->handle, &config);
+	if (ret)
+		return 0;
+	if (!(config.Attributes & CONF_VALID_CLIENT))
+		config.AssignedIRQ = 0;
+	return sprintf(buf, "%d\n", config.AssignedIRQ);
+}
+
+static ssize_t show_irq_type (struct socketctl_data * data, char *buf)
+{
+	config_info_t config;
+	int ret = -EINVAL;
+
+	config.Function = 0;
+	ret = pcmcia_get_configuration_info(data->handle, &config);
+	if (ret)
+		return 0;
+	if ((config.AssignedIRQ == 0) || !(config.Attributes & CONF_VALID_CLIENT))
+		return sprintf(buf, "n/a\n");
+
+	switch (config.IRQAttributes & IRQ_TYPE) {
+	case IRQ_TYPE_EXCLUSIVE:
+		return sprintf(buf, "exclusive\n");
+	case IRQ_TYPE_TIME:
+		return sprintf(buf, "multiplexed\n");
+	case IRQ_TYPE_DYNAMIC_SHARING:
+		return sprintf(buf, "shared\n"); 
+	}
+	return 0;
+}
+
+static ssize_t show_irq_mode (struct socketctl_data * data, char *buf)
+{
+	config_info_t config;
+	int ret = -EINVAL;
+
+	config.Function = 0;
+	ret = pcmcia_get_configuration_info(data->handle, &config);
+	if (ret)
+		return 0;
+	if ((config.AssignedIRQ == 0) || !(config.Attributes & CONF_VALID_CLIENT))
+		return sprintf(buf, "n/a\n");
+
+
+	if (config.IRQAttributes & IRQ_PULSE_ALLOCATED)
+		return sprintf(buf, "pulse\n");
+	else
+	        return sprintf(buf, "level\n");
+}
+
+#define show_one_enabled(file_name, bit)				\
+static ssize_t show_##file_name						\
+(struct socketctl_data * data, char *buf)				\
+{									\
+	config_info_t config;	 					\
+	int ret = -EINVAL;	 					\
+	config.Function = 0;	 					\
+	ret = pcmcia_get_configuration_info(data->handle, &config);	\
+	if (ret)	 						\
+		return 0;	 					\
+	if (config.AssignedIRQ == 0)					\
+		config.Attributes &= ~CONF_ENABLE_IRQ;			\
+	if (!(config.Attributes & CONF_VALID_CLIENT))			\
+		config.Attributes = 0;					\
+	if (config.Attributes & CONF_ENABLE_##bit)			\
+		return sprintf (buf, "enabled\n");			\
+	else								\
+		return sprintf(buf, "disabled\n");			\
+}
+
+show_one_enabled(irq_enabled, IRQ);
+
+
+/* card-specific info */
+
+static ssize_t show_card_voltage (struct socketctl_data * data, char *buf)
+{
+	cs_status_t status;
+	int ret;
+
+	status.Function = 0;
+	ret = pcmcia_get_status(data->handle, &status);
+	if (ret == -ENODEV)
+		return sprintf(buf, "no card\n");
+	else if (ret)
+		return 0;
+
+	if (status.CardState & CS_EVENT_3VCARD)
+		return sprintf(buf, "3.3V\n");
+	else if (status.CardState & CS_EVENT_XVCARD)
+		return sprintf(buf, "X.XV\n");
+	else
+		return sprintf(buf, "5V\n");
+}
+
+static ssize_t show_card_type (struct socketctl_data * data, char *buf)
+{
+	cs_status_t status;
+	int ret;
+
+	status.Function = 0;
+	ret = pcmcia_get_status(data->handle, &status);
+	if (ret == -ENODEV)
+		return sprintf(buf, "no card\n");
+	else if (ret)
+		return 0;
+
+	if (status.CardState & CS_EVENT_CB_DETECT)
+		return sprintf(buf, "CardBus card\n");
+	else if (status.CardState & CS_EVENT_CARD_DETECT)
+		return sprintf(buf, "16-bit PC Card\n");
+	else
+		return sprintf(buf, "no card\n");
+}
+
+show_one_enabled(DMA, DMA);
+show_one_enabled(speaker, SPKR);
+
+
+/* status */
+
+static ssize_t show_status (struct socketctl_data * data, char *buf)
+{
+	cs_status_t status;
+	int ret;
+
+	status.Function = 0;
+	ret = pcmcia_get_status(data->handle, &status);
+	if (ret == -ENODEV)
+		return sprintf(buf, "no card\n");
+	else if (ret)
+		return 0;
+
+	if (status.CardState & CS_EVENT_PM_SUSPEND)
+		return sprintf(buf, "suspended\n");
+
+	return sprintf(buf, "present\n");
+}
+
+static ssize_t store_status(struct socketctl_data *data, const char *buf, size_t count)
+{
+	int ret = -EINVAL;
+	client_req_t req;
+
+	if (!strnicmp(buf, "suspend", 7)) {
+		ret = pcmcia_suspend_card(data->handle, &req);
+		goto out;
+	}
+
+	if (!strnicmp(buf, "resume", 6)) {
+		ret = pcmcia_resume_card(data->handle, &req);
+		goto out;
+	}
+
+	if (!strnicmp(buf, "reset", 5)) {
+		ret = pcmcia_reset_card(data->handle, &req);
+		goto out;
+	}
+
+	if (!strnicmp(buf, "insert", 6)) {
+		ret = pcmcia_insert_card(data->handle, &req);
+		goto out;
+	}
+
+	if (!strnicmp(buf, "eject", 5)) {
+		ret = pcmcia_eject_card(data->handle, &req);
+		goto out;
+	}
+
+ out:
+	if (ret)
+		return 0;
+	else
+		return count;
+};
+
+
+/* general #defines */
+
+struct socketctl_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct socketctl_data *, char *);
+	ssize_t (*store)(struct socketctl_data *, const char *, size_t count);
+};
+
+#define define_one_ro(_name) \
+struct socketctl_attr _name = { \
+	.attr = { .name = __stringify(_name), .mode = 0444 }, \
+	.show = show_##_name, \
+}
+
+#define define_one_rw(_name) \
+struct socketctl_attr _name = { \
+	.attr = { .name = __stringify(_name), .mode = 0644 }, \
+	.show = show_##_name, \
+	.store = store_##_name, \
+}
+
+define_one_ro(Vcc);
+define_one_ro(Vpp1);
+define_one_ro(Vpp2);
+
+define_one_ro(irq);
+define_one_ro(irq_type);
+define_one_ro(irq_mode);
+define_one_ro(irq_enabled);
+
+define_one_ro(card_type);
+define_one_ro(card_voltage);
+define_one_ro(DMA);
+define_one_ro(speaker);
+
+define_one_rw(status);
+
+static struct attribute * default_attrs[] = {
+	&Vcc.attr,
+	&Vpp1.attr,
+	&Vpp2.attr,
+	&irq.attr,
+	&irq_type.attr,
+	&irq_mode.attr,
+	&irq_enabled.attr,
+	&card_type.attr,
+	&card_voltage.attr,
+	&DMA.attr,
+	&speaker.attr,
+	&status.attr,
+	NULL
+};
+
+#define to_data(k) container_of(k,struct socketctl_data,kobj)
+#define to_attr(a) container_of(a,struct socketctl_attr,attr)
+
+static ssize_t show(struct kobject * kobj, struct attribute * attr ,char * buf)
+{
+	struct socketctl_data * data = to_data(kobj);
+	struct socketctl_attr * sattr = to_attr(attr);
+	return sattr->show ? sattr->show(data,buf) : 0;
+}
+
+static ssize_t store(struct kobject * kobj, struct attribute * attr, 
+		     const char * buf, size_t count)
+{
+	struct socketctl_data * data = to_data(kobj);
+	struct socketctl_attr * sattr = to_attr(attr);
+	return sattr->store ? sattr->store(data,buf,count) : 0;
+}
+
+static struct sysfs_ops sysfs_ops = {
+	.show	= show,
+	.store	= store,
+};
+
+static struct kobj_type ktype_socketctl = {
+	.sysfs_ops	= &sysfs_ops,
+	.default_attrs	= default_attrs,
+};
+
+static int socketctl_add_socket(struct device *dev, unsigned int socket_nr)
+{
+	struct socketctl_data *socketctl;
+	unsigned int i;
+	struct socketctl_data *tmp_d;
+	client_reg_t client_reg;
+	bind_req_t bind;
+	int ret;
+
+	socketctl = kmalloc(sizeof(struct socketctl_data), GFP_KERNEL);
+	if (!socketctl)
+		return -ENOMEM;
+	memset(socketctl, 0, (sizeof(struct socketctl_data)));
+
+	snprintf(socketctl->kobj.name, KOBJ_NAME_LEN, "socketctl%u", socket_nr);
+	socketctl->kobj.parent = &dev->kobj;
+	socketctl->kobj.ktype = &ktype_socketctl;
+
+	/* find the lowest, unused socket no. Please note that this is a
+	 * temporary workaround until "struct pcmcia_socket" is introduced
+	 * into cs.c which will include this number, and which will be
+	 * accessible to socketctl.c directly */
+	i = 0;
+	next_try:
+	list_for_each_entry(tmp_d, &socketctl_socket_list, socket_list) {
+		if (tmp_d->socket_no == i) {
+			i++;
+			goto next_try;
+		}
+	}
+	socketctl->socket_no = i;
+
+	client_reg.dev_info = bind.dev_info = &dev_info;
+	bind.Socket = socketctl->socket_no;
+	bind.Function = BIND_FN_ALL;
+	ret = pcmcia_bind_device(&bind);
+	if (ret != CS_SUCCESS) {
+		kfree(socketctl);
+		return -EINVAL;
+	}
+
+	client_reg.Attributes = 0;
+	client_reg.EventMask = 0;
+	client_reg.event_handler = NULL;
+	client_reg.Version = 0x0210;
+	client_reg.event_callback_args.client_data = NULL;
+	ret = pcmcia_register_client(&socketctl->handle, &client_reg);
+	if (ret != CS_SUCCESS) {
+		kfree(socketctl);
+		return -EINVAL;
+	}
+	list_add(&socketctl->socket_list,&socketctl_socket_list);
+	kobject_register(&socketctl->kobj);
+
+	return 0;
+}
+
+static int socketctl_add(struct device *dev)
+{
+	struct pcmcia_socket_class_data *cls_d;
+	int i;
+	unsigned int ret = ~0;
+
+	cls_d = dev->class_data;
+	if (!cls_d || !cls_d->nsock) {
+		kset_put(&socketctl_interface.kset);
+		return -EINVAL;
+	}
+
+	down(&socketctl_sem);
+	for (i=0; i<cls_d->nsock; i++) {
+		ret &= socketctl_add_socket(dev, i);
+	}
+	up(&socketctl_sem);
+
+	return (ret);
+}
+
+static int socketctl_remove(struct device *dev)
+{
+	struct socketctl_data *socketctl;
+	struct list_head *tmp;
+	struct list_head *tmp_s;
+	int found = 0;
+
+	down(&socketctl_sem);
+	list_for_each_safe(tmp_s, tmp, &socketctl_socket_list) {
+		socketctl = container_of(tmp_s, struct socketctl_data, socket_list);
+		if (socketctl->kobj.parent == &dev->kobj) {
+			kobject_unregister(&socketctl->kobj);
+			list_del(&socketctl->socket_list);
+			found++;
+		}
+	}
+	up(&socketctl_sem);
+
+	return (!found);
+}
+
+
+static struct device_interface socketctl_interface = {
+        .name = "socketctl",
+	.devclass = &pcmcia_socket_class,
+	.add_device = &socketctl_add,
+	.remove_device = &socketctl_remove,
+	.kset = { .subsys = &pcmcia_socket_class.subsys, },
+	.devnum = 0,
+};
+
+static int __init socketctl_init(void)
+{
+	return interface_register(&socketctl_interface);
+}
+
+static void __exit socketctl_exit(void)
+{
+	interface_unregister(&socketctl_interface);
+}
+
+module_init(socketctl_init);
+module_exit(socketctl_exit);
+
+MODULE_AUTHOR ("Dominik Brodowski <linux@brodo.de>");
+MODULE_DESCRIPTION ("Socket control module for PCMCIA/CardBus sockets");
+MODULE_LICENSE ("GPL");
