Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263435AbTC2QIZ>; Sat, 29 Mar 2003 11:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263436AbTC2QIZ>; Sat, 29 Mar 2003 11:08:25 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:9098 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S263435AbTC2QIU>; Sat, 29 Mar 2003 11:08:20 -0500
Date: Sat, 29 Mar 2003 17:19:21 +0100
From: Dominik Brodowski <linux@brodo.de>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5] pcmcia: alternative setting of resources
Message-ID: <20030329161921.GA21793@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

With cardmgr being deprecated soon, there's a need for a different way to 
set the iomem/ioport/irq resources the PCMCIA drivers (and the PCMCIA core 
service) may use.

A sample new-style /etc/rc.d/pcmcia file which is based on
pcmcia-cs-3.2.3/etc/config.opts is attached. Don't rely on it yet, in-kernel
driver & device matching and hotplug support is not yet ready but will
follow soon.

	Dominik

 ds.c       |  160 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 rsrc_mgr.c |    3 -
 2 files changed, 160 insertions(+), 3 deletions(-)

diff -ruN linux-original/drivers/pcmcia/ds.c linux/drivers/pcmcia/ds.c
--- linux-original/drivers/pcmcia/ds.c	2003-03-29 15:41:01.000000000 +0100
+++ linux/drivers/pcmcia/ds.c	2003-03-29 16:38:23.000000000 +0100
@@ -1213,12 +1213,171 @@
 EXPORT_SYMBOL(pcmcia_bus_type);
 
 
+#define add_MANAGED_RESOURCE ADD_MANAGED_RESOURCE
+#define remove_MANAGED_RESOURCE REMOVE_MANAGED_RESOURCE
+
+#define store_iomem(action)						\
+static ssize_t store_iomem_##action (const char *buf, size_t count)	\
+{									\
+	ssize_t ret = -EINVAL;						\
+	unsigned long from, to;						\
+	adjust_t adj;							\
+									\
+	ret = sscanf (buf, "0x%lx-0x%lx", &from, &to);			\
+	if (ret != 2)							\
+		return -EINVAL;						\
+									\
+	if (to <= from) 						\
+		return -EINVAL;						\
+									\
+	adj.Action = action##_MANAGED_RESOURCE;				\
+	adj.Resource = RES_MEMORY_RANGE;				\
+	adj.resource.memory.Base = from;				\
+	adj.resource.memory.Size = to - from + 1;			\
+									\
+	ret = pcmcia_adjust_resource_info(0, &adj);			\
+									\
+	return ret ? ret : count;					\
+}
+store_iomem(add);
+store_iomem(remove);
+
+#define store_ioport(action)						\
+static ssize_t store_ioport_##action (const char *buf, size_t count)	\
+{									\
+	ssize_t ret = -EINVAL;						\
+	unsigned int from, to, addr_lines;				\
+	adjust_t adj;							\
+									\
+	ret = sscanf (buf, "0x%x-0x%x:0x%x", &from, &to, &addr_lines);	\
+	if ((ret != 2) && (ret != 3))					\
+		return -EINVAL;						\
+									\
+	if ((to <= from) || ( to > 0xffff))				\
+		return -EINVAL;						\
+									\
+	adj.Action = action##_MANAGED_RESOURCE;				\
+	adj.Resource = RES_IO_RANGE;					\
+	adj.resource.io.BasePort = from;				\
+	adj.resource.io.NumPorts = to - from + 1;			\
+	if (ret == 3)							\
+		adj.resource.io.IOAddrLines = addr_lines;		\
+	else								\
+		adj.resource.io.IOAddrLines = 0;			\
+									\
+	ret = pcmcia_adjust_resource_info(0, &adj);			\
+									\
+	return ret ? ret : count;					\
+}
+store_ioport(add);
+store_ioport(remove);
+
+#define store_irq(action)						\
+static ssize_t store_irq_##action (const char *buf, size_t count)	\
+{									\
+	ssize_t ret = -EINVAL;						\
+	unsigned int irq, attr;						\
+	adjust_t adj;							\
+									\
+	ret = sscanf (buf, "0x%u:0x%x", &irq, &attr);			\
+	if ((ret != 1) && (ret != 2))					\
+		return -EINVAL;						\
+									\
+	adj.Action = action##_MANAGED_RESOURCE;				\
+	adj.Resource = RES_IRQ;						\
+	adj.resource.irq.IRQ = irq;					\
+	if (ret == 2)							\
+		adj.Attributes = attr;					\
+	else								\
+		adj.Attributes = 0;					\
+									\
+	ret = pcmcia_adjust_resource_info(0, &adj);			\
+									\
+	return ret ? ret : count;					\
+}
+store_irq(add);
+store_irq(remove);
+
+static ssize_t store_resources_done (const char * buf, size_t count)
+{
+	ssize_t ret = -EINVAL;
+	unsigned int value;
+
+	ret = sscanf (buf, "%u", &value);
+	if ((ret != 1) || (value > 1))
+		return -EINVAL;
+	if (value == resources_available)
+		return count;
+	resources_available = value;
+	pcmcia_rescan_cards();
+	return count;
+}
+
+struct res_attr {
+	struct attribute attr;
+	ssize_t (*store)(const char *, size_t count);
+};
+
+#define define_one_w(_name) \
+struct res_attr _name = { \
+	.attr = { .name = __stringify(_name), .mode = 0200 }, \
+	.store = store_##_name, \
+}
+define_one_w(iomem_add);
+define_one_w(iomem_remove);
+define_one_w(ioport_add);
+define_one_w(ioport_remove);
+define_one_w(irq_add);
+define_one_w(irq_remove);
+define_one_w(resources_done);
+
+static struct attribute * default_attrs[] = {
+	&iomem_add.attr,
+	&iomem_remove.attr,
+	&ioport_add.attr,
+	&ioport_remove.attr,
+	&irq_add.attr,
+	&irq_remove.attr,
+	&resources_done.attr,
+	NULL
+};
+
+static ssize_t show(struct kobject * kobj, struct attribute * attr ,char * buf)
+{
+	return 0;
+}
+
+static ssize_t store(struct kobject * kobj, struct attribute * attr, 
+		     const char * buf, size_t count)
+{
+	struct res_attr * rattr = container_of(attr, struct res_attr, attr);
+	rattr->store ? rattr->store(buf,count) : 0;
+	return count;
+}
+
+static struct sysfs_ops sysfs_ops = {
+	.show	= show,
+	.store	= store,
+};
+
+static struct kobj_type ktype_pcmcia_resources = {
+	.sysfs_ops	= &sysfs_ops,
+	.default_attrs	= default_attrs,
+};
+
+static struct kobject pcmcia_resource_kobj = {
+	.name = "resources",
+	.parent = &pcmcia_bus_type.subsys.kset.kobj,
+	.ktype = &ktype_pcmcia_resources,
+};
+
 static int __init init_pcmcia_bus(void)
 {
 	int i;
 
 	bus_register(&pcmcia_bus_type);
 	interface_register(&pcmcia_bus_interface);
+	kobject_register(&pcmcia_resource_kobj);
 
 	/* Set up character device for user mode clients */
 	i = register_chrdev(0, "pcmcia", &ds_fops);
@@ -1241,6 +1400,7 @@
 
 static void __exit exit_pcmcia_bus(void)
 {
+	kobject_unregister(&pcmcia_resource_kobj);
 	interface_unregister(&pcmcia_bus_interface);
 
 #ifdef CONFIG_PROC_FS
diff -ruN linux-original/drivers/pcmcia/rsrc_mgr.c linux/drivers/pcmcia/rsrc_mgr.c
--- linux-original/drivers/pcmcia/rsrc_mgr.c	2003-03-29 15:16:03.000000000 +0100
+++ linux/drivers/pcmcia/rsrc_mgr.c	2003-03-29 16:38:23.000000000 +0100
@@ -848,9 +848,6 @@
 
 int pcmcia_adjust_resource_info(client_handle_t handle, adjust_t *adj)
 {
-    if (CHECK_HANDLE(handle))
-	return CS_BAD_HANDLE;
-    
     switch (adj->Resource) {
     case RES_MEMORY_RANGE:
 	return adjust_memory(adj);

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rc.d.pcmcia"

#! /bin/sh
# place this rc.d script _after_ the hotplug script, please.
. /etc/rc.status
rc_reset

echo -n "Setting up resources for PCMCIA (16-bit): "

if [ $UID != 0 ]; then
    echo " only allowed for root"
    rc_failed 4
    rc_status -v
    rc_exit
fi

case "$1" in
    start)
	if [ ! -d /sys/bus/pcmcia/resources ]; then
	    echo "No 2.5. pcmcia subsystem found"
	    rc_failed 4
	    rc_status -v
	    rc_exit
	fi
	echo -n "0x100-0x4ff" > /sys/bus/pcmcia/resources/ioport_add
	echo -n "0x800-0x8ff" > /sys/bus/pcmcia/resources/ioport_add
	echo -n "0xc00-0xcff" > /sys/bus/pcmcia/resources/ioport_add
	echo -n "0xc0000-0xfffff"  > /sys/bus/pcmcia/resources/iomem_add
	echo -n "0xa0000000-0xa0ffffff" > /sys/bus/pcmcia/resources/iomem_add
	echo -n "0x60000000-0x60ffffff" > /sys/bus/pcmcia/resources/iomem_add
	# High port numbers do not always work...
	# echo -n "0x1000-0x17ff" > /sys/bus/pcmcia/resources/ioport_add
	# Extra port range for IBM Token Ring
	# echo -n "0xa00-0xaff" > /sys/bus/pcmcia/resources/ioport_add
	# Resources we should not use, even if they appear to be available
	# First built-in serial port
	echo -n "4" > /sys/bus/pcmcia/resources/irq_remove
	# Second built-in serial port
	# echo -n "3" > /sys/bus/pcmcia/resources/irq_remove
	# First built-in parallel port
	# echo -n "7" > /sys/bus/pcmcia/resources/irq_remove
	# start in-kernel matching
	echo -n "1" > /sys/bus/pcmcia/resources/resources_done
	rc_failed 0
	;;
    stop)
	echo -n "0" > /sys/bus/pcmcia/resources/resources_done
	sleep 1
	echo -n "0x100-0x4ff" > /sys/bus/pcmcia/resources/ioport_remove
	echo -n "0x800-0x8ff" > /sys/bus/pcmcia/resources/ioport_remove
	echo -n "0xc00-0xcff" > /sys/bus/pcmcia/resources/ioport_remove
	echo -n "0xc0000-0xfffff"  > /sys/bus/pcmcia/resources/iomem_remove
	echo -n "0xa0000000-0xa0ffffff" >  /sys/bus/pcmcia/resources/iomem_remove
	echo -n "0x60000000-0x60ffffff" > /sys/bus/pcmcia/resources/iomem_remove
	# Extra port range for IBM Token Ring
	echo -n "0xa00-0xaff" > /sys/bus/pcmcia/resources/ioport_remove
	# Resources we should not use, even if they appear to be available
	# First built-in serial port
	echo -n "4" > /sys/bus/pcmcia/resources/irq_add
	# Second built-in serial port
	# echo -n "3" > /sys/bus/pcmcia/resources/irq_add
	# First built-in parallel port
	echo -n "7" > /sys/bus/pcmcia/resources/irq_add
	;;
    *)
	echo "Usage: $0 {start|stop|status|restart|reload}"
	;;
esac

rc_status -v
rc_exit

--SUOF0GtieIMvvwua--
