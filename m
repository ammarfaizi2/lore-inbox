Return-Path: <linux-kernel-owner+w=401wt.eu-S965214AbXATHBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965214AbXATHBS (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 02:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965225AbXATHAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 02:00:48 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:8229 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965133AbXATHAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 02:00:35 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=Wwsw45sDfAmW9KIxZvlQ6GEdeyTJkGJMMrJgSACc+GURrjaAPHN6TEkQ4SeFLAGcDdhmxx07F7b/Xzg8ToUTccmqbQao28lR259MdsxBICDbyYZSXOAN9eXGasfVvXwxNp44jHe1VAjb+Gqv26JWcETKuL62gCMyAXVF4u94OWg=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/7] devres: device resource management
In-Reply-To: <11692764262700-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Sat, 20 Jan 2007 16:00:26 +0900
Message-Id: <11692764264005-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: jgarzik@pobox.com, gregkh@suse.de, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       htejun@gmail.com
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement device resource management, in short, devres.  A device
driver can allocate arbirary size of devres data which is associated
with a release function.  On driver detach, release function is
invoked on the devres data, then, devres data is freed.

devreses are typed by associated release functions.  Some devreses are
better represented by single instance of the type while others need
multiple instances sharing the same release function.  Both usages are
supported.

devreses can be grouped using devres group such that a device driver
can easily release acquired resources halfway through initialization
or selectively release resources (e.g. resources for port 1 out of 4
ports).

This patch adds devres core including documentation and the following
managed interfaces.

* alloc/free	: devm_kzalloc(), devm_kzfree()
* IO region	: devm_request_region(), devm_release_region()
* IRQ		: devm_request_irq(), devm_free_irq()
* DMA		: dmam_alloc_coherent(), dmam_free_coherent(),
		  dmam_declare_coherent_memory(), dmam_pool_create(),
		  dmam_pool_destroy()
* PCI		: pcim_enable_device(), pcim_pin_device(), pci_is_managed()
* iomap		: devm_ioport_map(), devm_ioport_unmap(), devm_ioremap(),
		  devm_ioremap_nocache(), devm_iounmap(), pcim_iomap_table(),
		  pcim_iomap(), pcim_iounmap()

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 Documentation/driver-model/devres.txt |  268 ++++++++++++++
 drivers/base/Kconfig                  |   12 +
 drivers/base/Makefile                 |    1 +
 drivers/base/base.h                   |    1 +
 drivers/base/core.c                   |    2 +
 drivers/base/dd.c                     |    3 +
 drivers/base/devres.c                 |  644 +++++++++++++++++++++++++++++++++
 drivers/base/dma-mapping.c            |  218 +++++++++++
 drivers/base/dmapool.c                |   59 +++
 drivers/pci/pci.c                     |  127 +++++++-
 include/linux/device.h                |   38 ++
 include/linux/dma-mapping.h           |   29 ++-
 include/linux/dmapool.h               |    7 +
 include/linux/interrupt.h             |    6 +
 include/linux/io.h                    |   17 +
 include/linux/ioport.h                |   20 +
 include/linux/pci.h                   |    9 +
 kernel/irq/manage.c                   |   86 +++++
 kernel/resource.c                     |   62 ++++
 lib/Makefile                          |    3 +-
 lib/iomap.c                           |  246 +++++++++++++-
 21 files changed, 1853 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
new file mode 100644
index 0000000..5163b85
--- /dev/null
+++ b/Documentation/driver-model/devres.txt
@@ -0,0 +1,268 @@
+Devres - Managed Device Resource
+================================
+
+Tejun Heo	<teheo@suse.de>
+
+First draft	10 January 2007
+
+
+1. Intro			: Huh? Devres?
+2. Devres			: Devres in a nutshell
+3. Devres Group			: Group devres'es and release them together
+4. Details			: Life time rules, calling context, ...
+5. Overhead			: How much do we have to pay for this?
+6. List of managed interfaces	: Currently implemented managed interfaces
+
+
+  1. Intro
+  --------
+
+devres came up while trying to convert libata to use iomap.  Each
+iomapped address should be kept and unmapped on driver detach.  For
+example, a plain SFF ATA controller (that is, good old PCI IDE) in
+native mode makes use of 5 PCI BARs and all of them should be
+maintained.
+
+As with many other device drivers, libata low level drivers have
+sufficient bugs in ->remove and ->probe failure path.  Well, yes,
+that's probably because libata low level driver developers are lazy
+bunch, but aren't all low level driver developers?  After spending a
+day fiddling with braindamaged hardware with no document or
+braindamaged document, if it's finally working, well, it's working.
+
+For one reason or another, low level drivers don't receive as much
+attention or testing as core code, and bugs on driver detach or
+initilaization failure doesn't happen often enough to be noticeable.
+Init failure path is worse because it's much less travelled while
+needs to handle multiple entry points.
+
+So, many low level drivers end up leaking resources on driver detach
+and having half broken failure path implementation in ->probe() which
+would leak resources or even cause oops when failure occurs.  iomap
+adds more to this mix.  So do msi and msix.
+
+
+  2. Devres
+  ---------
+
+devres is basically linked list of arbitrarily sized memory areas
+associated with a struct device.  Each devres entry is associated with
+a release function.  A devres can be released in several ways.  No
+matter what, all devres entries are released on driver detach.  On
+release, the associated release function is invoked and then the
+devres entry is freed.
+
+Managed interface is created for resources commonly used by device
+drivers using devres.  For example, coherent DMA memory is acquired
+using dma_alloc_coherent().  The managed version is called
+dmam_alloc_coherent().  It is identical to dma_alloc_coherent() except
+for the DMA memory allocated using it is managed and will be
+automatically released on driver detach.  Implementation looks like
+the following.
+
+  struct dma_devres {
+	size_t		size;
+	void		*vaddr;
+	dma_addr_t	dma_handle;
+  };
+
+  static void dmam_coherent_release(struct device *dev, void *res)
+  {
+	struct dma_devres *this = res;
+
+	dma_free_coherent(dev, this->size, this->vaddr, this->dma_handle);
+  }
+
+  dmam_alloc_coherent(dev, size, dma_handle, gfp)
+  {
+	struct dma_devres *dr;
+	void *vaddr;
+
+	dr = devres_alloc(dmam_coherent_release, sizeof(*dr), gfp);
+	...
+
+	/* alloc DMA memory as usual */
+	vaddr = dma_alloc_coherent(...);
+	...
+
+	/* record size, vaddr, dma_handle in dr */
+	dr->vaddr = vaddr;
+	...
+
+	devres_add(dev, dr);
+
+	return vaddr;
+  }
+
+If a driver uses dmam_alloc_coherent(), the area is guaranteed to be
+freed whether initialization fails half-way or the device gets
+detached.  If most resources are acquired using managed interface, a
+driver can have much simpler init and exit code.  Init path basically
+looks like the following.
+
+  my_init_one()
+  {
+	struct mydev *d;
+
+	d = devm_kzalloc(dev, sizeof(*d), GFP_KERNEL);
+	if (!d)
+		return -ENOMEM;
+
+	d->ring = dmam_alloc_coherent(...);
+	if (!d->ring)
+		return -ENOMEM;
+
+	if (check something)
+		return -EINVAL;
+	...
+
+	return register_to_upper_layer(d);
+  }
+
+And exit path,
+
+  my_remove_one()
+  {
+	unregister_from_upper_layer(d);
+	shutdown_my_hardware();
+  }
+
+As shown above, low level drivers can be simplified a lot by using
+devres.  Complexity is shifted from less maintained low level drivers
+to better maintained higher layer.  Also, as init failure path is
+shared with exit path, both can get more testing.
+
+
+  3. Devres group
+  ---------------
+
+Devres entries can be grouped using devres group.  When a group is
+released, all contained normal devres entries and properly nested
+groups are released.  One usage is to rollback series of acquired
+resources on failure.  For example,
+
+  if (!devres_open_group(dev, NULL, GFP_KERNEL))
+	return -ENOMEM;
+
+  acquire A;
+  if (failed)
+	goto err;
+
+  acquire B;
+  if (failed)
+	goto err;
+  ...
+
+  devres_remove_group(dev, NULL);
+  return 0;
+
+ err:
+  devres_release_group(dev, NULL);
+  return err_code;
+
+As resource acquision failure usually means probe failure, constructs
+like above are usually useful in midlayer driver (e.g. libata core
+layer) where interface function shouldn't have side effect on failure.
+For LLDs, just returning error code suffices in most cases.
+
+Each group is identified by void *id.  It can either be explicitly
+specified by @id argument to devres_open_group() or automatically
+created by passing NULL as @id as in the above example.  In both
+cases, devres_open_group() returns the group's id.  The returned id
+can be passed to other devres functions to select the target group.
+If NULL is given to those functions, the latest open group is
+selected.
+
+For example, you can do something like the following.
+
+  int my_midlayer_create_something()
+  {
+	if (!devres_open_group(dev, my_midlayer_create_something, GFP_KERNEL))
+		return -ENOMEM;
+
+	...
+
+	devres_close_group(dev, my_midlayer_something);
+	return 0;
+  }
+
+  void my_midlayer_destroy_something()
+  {
+	devres_release_group(dev, my_midlayer_create_soemthing);
+  }
+
+
+  4. Details
+  ----------
+
+Lifetime of a devres entry begins on devres allocation and finishes
+when it is released or destroyed (removed and freed) - no reference
+counting.
+
+devres core guarantees atomicity to all basic devres operations and
+has support for single-instance devres types (atomic
+lookup-and-add-if-not-found).  Other than that, synchronizing
+concurrent accesses to allocated devres data is caller's
+responsibility.  This is usually non-issue because bus ops and
+resource allocations already do the job.
+
+For an example of single-instance devres type, read pcim_iomap_table()
+in lib/iomap.c.
+
+All devres interface functions can be called without context if the
+right gfp mask is given.
+
+
+  5. Overhead
+  -----------
+
+Each devres bookkeeping info is allocated together with requested data
+area.  With debug option turned off, bookkeeping info occupies 16
+bytes on 32bit machines and 24 bytes on 64bit (three pointers rounded
+up to ull alignment).  If singly linked list is used, it can be
+reduced to two pointers (8 bytes on 32bit, 16 bytes on 64bit).
+
+Each devres group occupies 8 pointers.  It can be reduced to 6 if
+singly linked list is used.
+
+Memory space overhead on ahci controller with two ports is between 300
+and 400 bytes on 32bit machine after naive conversion (we can
+certainly invest a bit more effort into libata core layer).
+
+
+  6. List of managed interfaces
+  -----------------------------
+
+IO region
+  devm_request_region()
+  devm_request_mem_region()
+  devm_release_region()
+  devm_release_mem_region()
+
+IRQ
+  devm_request_irq()
+  devm_free_irq()
+
+DMA
+  dmam_alloc_coherent()
+  dmam_free_coherent()
+  dmam_alloc_noncoherent()
+  dmam_free_noncoherent()
+  dmam_declare_coherent_memory()
+  dmam_pool_create()
+  dmam_pool_destroy()
+
+PCI
+  pcim_enable_device()	: after success, all PCI ops become managed
+  pcim_pin_device()	: keep PCI device enabled after release
+
+IOMAP
+  devm_ioport_map()
+  devm_ioport_unmap()
+  devm_ioremap()
+  devm_ioremap_nocache()
+  devm_iounmap()
+  pcim_iomap()
+  pcim_iounmap()
+  pcim_iomap_table()	: array of mapped addresses indexed by BAR
+  pcim_iomap_regions()	: do request_region() and iomap() on multiple BARs
diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 1429f3a..5d6312e 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -37,6 +37,18 @@ config DEBUG_DRIVER
 
 	  If you are unsure about this, say N here.
 
+config DEBUG_DEVRES
+	bool "Managed device resources verbose debug messages"
+	depends on DEBUG_KERNEL
+	help
+	  This option enables kernel parameter devres.log. If set to
+	  non-zero, devres debug messages are printed. Select this if
+	  you are having a problem with devres or want to debug
+	  resource management for a managed device. devres.log can be
+	  switched on and off from sysfs node.
+
+	  If you are unsure about this, Say N here.
+
 config SYS_HYPERVISOR
 	bool
 	default n
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 7bbb9ee..e9eb738 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -3,6 +3,7 @@
 obj-y			:= core.o sys.o bus.o dd.o \
 			   driver.o class.o platform.o \
 			   cpu.o firmware.o init.o map.o dmapool.o \
+			   dma-mapping.o devres.o \
 			   attribute_container.o transport_class.o
 obj-y			+= power/
 obj-$(CONFIG_ISA)	+= isa.o
diff --git a/drivers/base/base.h b/drivers/base/base.h
index d26644a..de7e144 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -44,3 +44,4 @@ struct class_device_attribute *to_class_dev_attr(struct attribute *_attr)
 
 extern char *make_class_name(const char *name, struct kobject *kobj);
 
+extern void devres_release_all(struct device *dev);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 67b79a7..d1c94e3 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -385,6 +385,8 @@ void device_initialize(struct device *dev)
 	INIT_LIST_HEAD(&dev->dma_pools);
 	INIT_LIST_HEAD(&dev->node);
 	init_MUTEX(&dev->sem);
+	spin_lock_init(&dev->devres_lock);
+	INIT_LIST_HEAD(&dev->devres_head);
 	device_init_wakeup(dev, 0);
 	set_dev_node(dev, -1);
 }
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 510e788..437e046 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -108,6 +108,7 @@ static int really_probe(void *void_data)
 	atomic_inc(&probe_count);
 	pr_debug("%s: Probing driver %s with device %s\n",
 		 drv->bus->name, drv->name, dev->bus_id);
+	WARN_ON(!list_empty(&dev->devres_head));
 
 	dev->driver = drv;
 	if (driver_sysfs_add(dev)) {
@@ -133,6 +134,7 @@ static int really_probe(void *void_data)
 	goto done;
 
 probe_failed:
+	devres_release_all(dev);
 	driver_sysfs_remove(dev);
 	dev->driver = NULL;
 
@@ -324,6 +326,7 @@ static void __device_release_driver(struct device * dev)
 			dev->bus->remove(dev);
 		else if (drv->remove)
 			drv->remove(dev);
+		devres_release_all(dev);
 		dev->driver = NULL;
 		put_driver(drv);
 	}
diff --git a/drivers/base/devres.c b/drivers/base/devres.c
new file mode 100644
index 0000000..e177c95
--- /dev/null
+++ b/drivers/base/devres.c
@@ -0,0 +1,644 @@
+/*
+ * drivers/base/devres.c - device resource management
+ *
+ * Copyright (c) 2006  SUSE Linux Products GmbH
+ * Copyright (c) 2006  Tejun Heo <teheo@suse.de>
+ *
+ * This file is released under the GPLv2.
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+
+struct devres_node {
+	struct list_head		entry;
+	dr_release_t			release;
+#ifdef CONFIG_DEBUG_DEVRES
+	const char			*name;
+	size_t				size;
+#endif
+};
+
+struct devres {
+	struct devres_node		node;
+	/* -- 3 pointers */
+	unsigned long long		data[];	/* guarantee ull alignment */
+};
+
+struct devres_group {
+	struct devres_node		node[2];
+	void				*id;
+	int				color;
+	/* -- 8 pointers */
+};
+
+#ifdef CONFIG_DEBUG_DEVRES
+static int log_devres = 0;
+module_param_named(log, log_devres, int, S_IRUGO | S_IWUSR);
+
+static void set_node_dbginfo(struct devres_node *node, const char *name,
+			     size_t size)
+{
+	node->name = name;
+	node->size = size;
+}
+
+static void devres_log(struct device *dev, struct devres_node *node,
+		       const char *op)
+{
+	if (unlikely(log_devres))
+		dev_printk(KERN_ERR, dev, "DEVRES %3s %p %s (%lu bytes)\n",
+			   op, node, node->name, (unsigned long)node->size);
+}
+#else /* CONFIG_DEBUG_DEVRES */
+#define set_node_dbginfo(node, n, s)	do {} while (0)
+#define devres_log(dev, node, op)	do {} while (0)
+#endif /* CONFIG_DEBUG_DEVRES */
+
+/*
+ * Release functions for devres group.  These callbacks are used only
+ * for identification.
+ */
+static void group_open_release(struct device *dev, void *res)
+{
+	/* noop */
+}
+
+static void group_close_release(struct device *dev, void *res)
+{
+	/* noop */
+}
+
+static struct devres_group * node_to_group(struct devres_node *node)
+{
+	if (node->release == &group_open_release)
+		return container_of(node, struct devres_group, node[0]);
+	if (node->release == &group_close_release)
+		return container_of(node, struct devres_group, node[1]);
+	return NULL;
+}
+
+static __always_inline struct devres * alloc_dr(dr_release_t release,
+						size_t size, gfp_t gfp)
+{
+	size_t tot_size = sizeof(struct devres) + size;
+	struct devres *dr;
+
+	dr = kmalloc_track_caller(tot_size, gfp);
+	if (unlikely(!dr))
+		return NULL;
+
+	memset(dr, 0, tot_size);
+	INIT_LIST_HEAD(&dr->node.entry);
+	dr->node.release = release;
+	return dr;
+}
+
+static void add_dr(struct device *dev, struct devres_node *node)
+{
+	devres_log(dev, node, "ADD");
+	BUG_ON(!list_empty(&node->entry));
+	list_add_tail(&node->entry, &dev->devres_head);
+}
+
+/**
+ * devres_alloc - Allocate device resource data
+ * @release: Release function devres will be associated with
+ * @size: Allocation size
+ * @gfp: Allocation flags
+ *
+ * allocate devres of @size bytes.  The allocated area is zeroed, then
+ * associated with @release.  The returned pointer can be passed to
+ * other devres_*() functions.
+ *
+ * RETURNS:
+ * Pointer to allocated devres on success, NULL on failure.
+ */
+#ifdef CONFIG_DEBUG_DEVRES
+void * __devres_alloc(dr_release_t release, size_t size, gfp_t gfp,
+		      const char *name)
+{
+	struct devres *dr;
+
+	dr = alloc_dr(release, size, gfp);
+	if (unlikely(!dr))
+		return NULL;
+	set_node_dbginfo(&dr->node, name, size);
+	return dr->data;
+}
+EXPORT_SYMBOL_GPL(__devres_alloc);
+#else
+void * devres_alloc(dr_release_t release, size_t size, gfp_t gfp)
+{
+	struct devres *dr;
+
+	dr = alloc_dr(release, size, gfp);
+	if (unlikely(!dr))
+		return NULL;
+	return dr->data;
+}
+EXPORT_SYMBOL_GPL(devres_alloc);
+#endif
+
+/**
+ * devres_free - Free device resource data
+ * @res: Pointer to devres data to free
+ *
+ * Free devres created with devres_alloc().
+ */
+void devres_free(void *res)
+{
+	if (res) {
+		struct devres *dr = container_of(res, struct devres, data);
+
+		BUG_ON(!list_empty(&dr->node.entry));
+		kfree(dr);
+	}
+}
+EXPORT_SYMBOL_GPL(devres_free);
+
+/**
+ * devres_add - Register device resource
+ * @dev: Device to add resource to
+ * @res: Resource to register
+ *
+ * Register devres @res to @dev.  @res should have been allocated
+ * using devres_alloc().  On driver detach, the associated release
+ * function will be invoked and devres will be freed automatically.
+ */
+void devres_add(struct device *dev, void *res)
+{
+	struct devres *dr = container_of(res, struct devres, data);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->devres_lock, flags);
+	add_dr(dev, &dr->node);
+	spin_unlock_irqrestore(&dev->devres_lock, flags);
+}
+EXPORT_SYMBOL_GPL(devres_add);
+
+static struct devres *find_dr(struct device *dev, dr_release_t release,
+			      dr_match_t match, void *match_data)
+{
+	struct devres_node *node;
+
+	list_for_each_entry_reverse(node, &dev->devres_head, entry) {
+		struct devres *dr = container_of(node, struct devres, node);
+
+		if (node->release != release)
+			continue;
+		if (match && !match(dev, dr->data, match_data))
+			continue;
+		return dr;
+	}
+
+	return NULL;
+}
+
+/**
+ * devres_find - Find device resource
+ * @dev: Device to lookup resource from
+ * @release: Look for resources associated with this release function
+ * @match: Match function (optional)
+ * @match_data: Data for the match function
+ *
+ * Find the latest devres of @dev which is associated with @release
+ * and for which @match returns 1.  If @match is NULL, it's considered
+ * to match all.
+ *
+ * RETURNS:
+ * Pointer to found devres, NULL if not found.
+ */
+void * devres_find(struct device *dev, dr_release_t release,
+		   dr_match_t match, void *match_data)
+{
+	struct devres *dr;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->devres_lock, flags);
+	dr = find_dr(dev, release, match, match_data);
+	spin_unlock_irqrestore(&dev->devres_lock, flags);
+
+	if (dr)
+		return dr->data;
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(devres_find);
+
+/**
+ * devres_get - Find devres, if non-existent, add one atomically
+ * @dev: Device to lookup or add devres for
+ * @new_res: Pointer to new initialized devres to add if not found
+ * @match: Match function (optional)
+ * @match_data: Data for the match function
+ *
+ * Find the latest devres of @dev which has the same release function
+ * as @new_res and for which @match return 1.  If found, @new_res is
+ * freed; otherwise, @new_res is added atomically.
+ *
+ * RETURNS:
+ * Pointer to found or added devres.
+ */
+void * devres_get(struct device *dev, void *new_res,
+		  dr_match_t match, void *match_data)
+{
+	struct devres *new_dr = container_of(new_res, struct devres, data);
+	struct devres *dr;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->devres_lock, flags);
+	dr = find_dr(dev, new_dr->node.release, match, match_data);
+	if (!dr) {
+		add_dr(dev, &new_dr->node);
+		dr = new_dr;
+		new_dr = NULL;
+	}
+	spin_unlock_irqrestore(&dev->devres_lock, flags);
+	devres_free(new_dr);
+
+	return dr->data;
+}
+EXPORT_SYMBOL_GPL(devres_get);
+
+/**
+ * devres_remove - Find a device resource and remove it
+ * @dev: Device to find resource from
+ * @release: Look for resources associated with this release function
+ * @match: Match function (optional)
+ * @match_data: Data for the match function
+ *
+ * Find the latest devres of @dev associated with @release and for
+ * which @match returns 1.  If @match is NULL, it's considered to
+ * match all.  If found, the resource is removed atomically and
+ * returned.
+ *
+ * RETURNS:
+ * Pointer to removed devres on success, NULL if not found.
+ */
+void * devres_remove(struct device *dev, dr_release_t release,
+		     dr_match_t match, void *match_data)
+{
+	struct devres *dr;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->devres_lock, flags);
+	dr = find_dr(dev, release, match, match_data);
+	if (dr) {
+		list_del_init(&dr->node.entry);
+		devres_log(dev, &dr->node, "REM");
+	}
+	spin_unlock_irqrestore(&dev->devres_lock, flags);
+
+	if (dr)
+		return dr->data;
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(devres_remove);
+
+/**
+ * devres_destroy - Find a device resource and destroy it
+ * @dev: Device to find resource from
+ * @release: Look for resources associated with this release function
+ * @match: Match function (optional)
+ * @match_data: Data for the match function
+ *
+ * Find the latest devres of @dev associated with @release and for
+ * which @match returns 1.  If @match is NULL, it's considered to
+ * match all.  If found, the resource is removed atomically and freed.
+ *
+ * RETURNS:
+ * 0 if devres is found and freed, -ENOENT if not found.
+ */
+int devres_destroy(struct device *dev, dr_release_t release,
+		   dr_match_t match, void *match_data)
+{
+	void *res;
+
+	res = devres_remove(dev, release, match, match_data);
+	if (unlikely(!res))
+		return -ENOENT;
+
+	devres_free(res);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devres_destroy);
+
+static int remove_nodes(struct device *dev,
+			struct list_head *first, struct list_head *end,
+			struct list_head *todo)
+{
+	int cnt = 0, nr_groups = 0;
+	struct list_head *cur;
+
+	/* First pass - move normal devres entries to @todo and clear
+	 * devres_group colors.
+	 */
+	cur = first;
+	while (cur != end) {
+		struct devres_node *node;
+		struct devres_group *grp;
+
+		node = list_entry(cur, struct devres_node, entry);
+		cur = cur->next;
+
+		grp = node_to_group(node);
+		if (grp) {
+			/* clear color of group markers in the first pass */
+			grp->color = 0;
+			nr_groups++;
+		} else {
+			/* regular devres entry */
+			if (&node->entry == first)
+				first = first->next;
+			list_move_tail(&node->entry, todo);
+			cnt++;
+		}
+	}
+
+	if (!nr_groups)
+		return cnt;
+
+	/* Second pass - Scan groups and color them.  A group gets
+	 * color value of two iff the group is wholly contained in
+	 * [cur, end).  That is, for a closed group, both opening and
+	 * closing markers should be in the range, while just the
+	 * opening marker is enough for an open group.
+	 */
+	cur = first;
+	while (cur != end) {
+		struct devres_node *node;
+		struct devres_group *grp;
+
+		node = list_entry(cur, struct devres_node, entry);
+		cur = cur->next;
+
+		grp = node_to_group(node);
+		BUG_ON(!grp || list_empty(&grp->node[0].entry));
+
+		grp->color++;
+		if (list_empty(&grp->node[1].entry))
+			grp->color++;
+
+		BUG_ON(grp->color <= 0 || grp->color > 2);
+		if (grp->color == 2) {
+			/* No need to update cur or end.  The removed
+			 * nodes are always before both.
+			 */
+			list_move_tail(&grp->node[0].entry, todo);
+			list_del_init(&grp->node[1].entry);
+		}
+	}
+
+	return cnt;
+}
+
+static int release_nodes(struct device *dev, struct list_head *first,
+			 struct list_head *end, unsigned long flags)
+{
+	LIST_HEAD(todo);
+	int cnt;
+	struct devres *dr, *tmp;
+
+	cnt = remove_nodes(dev, first, end, &todo);
+
+	spin_unlock_irqrestore(&dev->devres_lock, flags);
+
+	/* Release.  Note that both devres and devres_group are
+	 * handled as devres in the following loop.  This is safe.
+	 */
+	list_for_each_entry_safe_reverse(dr, tmp, &todo, node.entry) {
+		devres_log(dev, &dr->node, "REL");
+		dr->node.release(dev, dr->data);
+		kfree(dr);
+	}
+
+	return cnt;
+}
+
+/**
+ * devres_release_all - Release all resources
+ * @dev: Device to release resources for
+ *
+ * Release all resources associated with @dev.  This function is
+ * called on driver detach.
+ */
+int devres_release_all(struct device *dev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->devres_lock, flags);
+	return release_nodes(dev, dev->devres_head.next, &dev->devres_head,
+			     flags);
+}
+
+/**
+ * devres_open_group - Open a new devres group
+ * @dev: Device to open devres group for
+ * @id: Separator ID
+ * @gfp: Allocation flags
+ *
+ * Open a new devres group for @dev with @id.  For @id, using a
+ * pointer to an object which won't be used for another group is
+ * recommended.  If @id is NULL, address-wise unique ID is created.
+ *
+ * RETURNS:
+ * ID of the new group, NULL on failure.
+ */
+void * devres_open_group(struct device *dev, void *id, gfp_t gfp)
+{
+	struct devres_group *grp;
+	unsigned long flags;
+
+	grp = kmalloc(sizeof(*grp), gfp);
+	if (unlikely(!grp))
+		return NULL;
+
+	grp->node[0].release = &group_open_release;
+	grp->node[1].release = &group_close_release;
+	INIT_LIST_HEAD(&grp->node[0].entry);
+	INIT_LIST_HEAD(&grp->node[1].entry);
+	set_node_dbginfo(&grp->node[0], "grp<", 0);
+	set_node_dbginfo(&grp->node[1], "grp>", 0);
+	grp->id = grp;
+	if (id)
+		grp->id = id;
+
+	spin_lock_irqsave(&dev->devres_lock, flags);
+	add_dr(dev, &grp->node[0]);
+	spin_unlock_irqrestore(&dev->devres_lock, flags);
+	return grp->id;
+}
+EXPORT_SYMBOL_GPL(devres_open_group);
+
+/* Find devres group with ID @id.  If @id is NULL, look for the latest. */
+static struct devres_group * find_group(struct device *dev, void *id)
+{
+	struct devres_node *node;
+
+	list_for_each_entry_reverse(node, &dev->devres_head, entry) {
+		struct devres_group *grp;
+
+		if (node->release != &group_open_release)
+			continue;
+
+		grp = container_of(node, struct devres_group, node[0]);
+
+		if (id) {
+			if (grp->id == id)
+				return grp;
+		} else if (list_empty(&grp->node[1].entry))
+			return grp;
+	}
+
+	return NULL;
+}
+
+/**
+ * devres_close_group - Close a devres group
+ * @dev: Device to close devres group for
+ * @id: ID of target group, can be NULL
+ *
+ * Close the group identified by @id.  If @id is NULL, the latest open
+ * group is selected.
+ */
+void devres_close_group(struct device *dev, void *id)
+{
+	struct devres_group *grp;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->devres_lock, flags);
+
+	grp = find_group(dev, id);
+	if (grp)
+		add_dr(dev, &grp->node[1]);
+	else
+		WARN_ON(1);
+
+	spin_unlock_irqrestore(&dev->devres_lock, flags);
+}
+EXPORT_SYMBOL_GPL(devres_close_group);
+
+/**
+ * devres_remove_group - Remove a devres group
+ * @dev: Device to remove group for
+ * @id: ID of target group, can be NULL
+ *
+ * Remove the group identified by @id.  If @id is NULL, the latest
+ * open group is selected.  Note that removing a group doesn't affect
+ * any other resources.
+ */
+void devres_remove_group(struct device *dev, void *id)
+{
+	struct devres_group *grp;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->devres_lock, flags);
+
+	grp = find_group(dev, id);
+	if (grp) {
+		list_del_init(&grp->node[0].entry);
+		list_del_init(&grp->node[1].entry);
+		devres_log(dev, &grp->node[0], "REM");
+	} else
+		WARN_ON(1);
+
+	spin_unlock_irqrestore(&dev->devres_lock, flags);
+
+	kfree(grp);
+}
+EXPORT_SYMBOL_GPL(devres_remove_group);
+
+/**
+ * devres_release_group - Release resources in a devres group
+ * @dev: Device to release group for
+ * @id: ID of target group, can be NULL
+ *
+ * Release all resources in the group identified by @id.  If @id is
+ * NULL, the latest open group is selected.  The selected group and
+ * groups properly nested inside the selected group are removed.
+ *
+ * RETURNS:
+ * The number of released non-group resources.
+ */
+int devres_release_group(struct device *dev, void *id)
+{
+	struct devres_group *grp;
+	unsigned long flags;
+	int cnt = 0;
+
+	spin_lock_irqsave(&dev->devres_lock, flags);
+
+	grp = find_group(dev, id);
+	if (grp) {
+		struct list_head *first = &grp->node[0].entry;
+		struct list_head *end = &dev->devres_head;
+
+		if (!list_empty(&grp->node[1].entry))
+			end = grp->node[1].entry.next;
+
+		cnt = release_nodes(dev, first, end, flags);
+	} else {
+		WARN_ON(1);
+		spin_unlock_irqrestore(&dev->devres_lock, flags);
+	}
+
+	return cnt;
+}
+EXPORT_SYMBOL_GPL(devres_release_group);
+
+/*
+ * Managed kzalloc/kfree
+ */
+static void devm_kzalloc_release(struct device *dev, void *res)
+{
+	/* noop */
+}
+
+static int devm_kzalloc_match(struct device *dev, void *res, void *data)
+{
+	return res == data;
+}
+
+/**
+ * devm_kzalloc - Managed kzalloc
+ * @dev: Device to allocate memory for
+ * @size: Allocation size
+ * @gfp: Allocation gfp flags
+ *
+ * Managed kzalloc.  Memory allocated with this function is
+ * automatically freed on driver detach.  Like all other devres
+ * resources, guaranteed alignment is unsigned long long.
+ *
+ * RETURNS:
+ * Pointer to allocated memory on success, NULL on failure.
+ */
+void * devm_kzalloc(struct device *dev, size_t size, gfp_t gfp)
+{
+	struct devres *dr;
+
+	/* use raw alloc_dr for kmalloc caller tracing */
+	dr = alloc_dr(devm_kzalloc_release, size, gfp);
+	if (unlikely(!dr))
+		return NULL;
+
+	set_node_dbginfo(&dr->node, "devm_kzalloc_release", size);
+	devres_add(dev, dr->data);
+	return dr->data;
+}
+EXPORT_SYMBOL_GPL(devm_kzalloc);
+
+/**
+ * devm_kfree - Managed kfree
+ * @dev: Device this memory belongs to
+ * @p: Memory to free
+ *
+ * Free memory allocated with dev_kzalloc().
+ */
+void devm_kfree(struct device *dev, void *p)
+{
+	int rc;
+
+	rc = devres_destroy(dev, devm_kzalloc_release, devm_kzalloc_match, p);
+	WARN_ON(rc);
+}
+EXPORT_SYMBOL_GPL(devm_kfree);
diff --git a/drivers/base/dma-mapping.c b/drivers/base/dma-mapping.c
new file mode 100644
index 0000000..ca9186f
--- /dev/null
+++ b/drivers/base/dma-mapping.c
@@ -0,0 +1,218 @@
+/*
+ * drivers/base/dma-mapping.c - arch-independent dma-mapping routines
+ *
+ * Copyright (c) 2006  SUSE Linux Products GmbH
+ * Copyright (c) 2006  Tejun Heo <teheo@suse.de>
+ *
+ * This file is released under the GPLv2.
+ */
+
+#include <linux/dma-mapping.h>
+
+/*
+ * Managed DMA API
+ */
+struct dma_devres {
+	size_t		size;
+	void		*vaddr;
+	dma_addr_t	dma_handle;
+};
+
+static void dmam_coherent_release(struct device *dev, void *res)
+{
+	struct dma_devres *this = res;
+
+	dma_free_coherent(dev, this->size, this->vaddr, this->dma_handle);
+}
+
+static void dmam_noncoherent_release(struct device *dev, void *res)
+{
+	struct dma_devres *this = res;
+
+	dma_free_noncoherent(dev, this->size, this->vaddr, this->dma_handle);
+}
+
+static int dmam_match(struct device *dev, void *res, void *match_data)
+{
+	struct dma_devres *this = res, *match = match_data;
+
+	if (this->vaddr == match->vaddr) {
+		WARN_ON(this->size != match->size ||
+			this->dma_handle != match->dma_handle);
+		return 1;
+	}
+	return 0;
+}
+
+/**
+ * dmam_alloc_coherent - Managed dma_alloc_coherent()
+ * @dev: Device to allocate coherent memory for
+ * @size: Size of allocation
+ * @dma_handle: Out argument for allocated DMA handle
+ * @gfp: Allocation flags
+ *
+ * Managed dma_alloc_coherent().  Memory allocated using this function
+ * will be automatically released on driver detach.
+ *
+ * RETURNS:
+ * Pointer to allocated memory on success, NULL on failure.
+ */
+void * dmam_alloc_coherent(struct device *dev, size_t size,
+			   dma_addr_t *dma_handle, gfp_t gfp)
+{
+	struct dma_devres *dr;
+	void *vaddr;
+
+	dr = devres_alloc(dmam_coherent_release, sizeof(*dr), gfp);
+	if (!dr)
+		return NULL;
+
+	vaddr = dma_alloc_coherent(dev, size, dma_handle, gfp);
+	if (!vaddr) {
+		devres_free(dr);
+		return NULL;
+	}
+
+	dr->vaddr = vaddr;
+	dr->dma_handle = *dma_handle;
+	dr->size = size;
+
+	devres_add(dev, dr);
+
+	return vaddr;
+}
+EXPORT_SYMBOL(dmam_alloc_coherent);
+
+/**
+ * dmam_free_coherent - Managed dma_free_coherent()
+ * @dev: Device to free coherent memory for
+ * @size: Size of allocation
+ * @vaddr: Virtual address of the memory to free
+ * @dma_handle: DMA handle of the memory to free
+ *
+ * Managed dma_free_coherent().
+ */
+void dmam_free_coherent(struct device *dev, size_t size, void *vaddr,
+			dma_addr_t dma_handle)
+{
+	struct dma_devres match_data = { size, vaddr, dma_handle };
+
+	dma_free_coherent(dev, size, vaddr, dma_handle);
+	WARN_ON(devres_destroy(dev, dmam_coherent_release, dmam_match,
+			       &match_data));
+}
+EXPORT_SYMBOL(dmam_free_coherent);
+
+/**
+ * dmam_alloc_non_coherent - Managed dma_alloc_non_coherent()
+ * @dev: Device to allocate non_coherent memory for
+ * @size: Size of allocation
+ * @dma_handle: Out argument for allocated DMA handle
+ * @gfp: Allocation flags
+ *
+ * Managed dma_alloc_non_coherent().  Memory allocated using this
+ * function will be automatically released on driver detach.
+ *
+ * RETURNS:
+ * Pointer to allocated memory on success, NULL on failure.
+ */
+void *dmam_alloc_noncoherent(struct device *dev, size_t size,
+			     dma_addr_t *dma_handle, gfp_t gfp)
+{
+	struct dma_devres *dr;
+	void *vaddr;
+
+	dr = devres_alloc(dmam_noncoherent_release, sizeof(*dr), gfp);
+	if (!dr)
+		return NULL;
+
+	vaddr = dma_alloc_noncoherent(dev, size, dma_handle, gfp);
+	if (!vaddr) {
+		devres_free(dr);
+		return NULL;
+	}
+
+	dr->vaddr = vaddr;
+	dr->dma_handle = *dma_handle;
+	dr->size = size;
+
+	devres_add(dev, dr);
+
+	return vaddr;
+}
+EXPORT_SYMBOL(dmam_alloc_noncoherent);
+
+/**
+ * dmam_free_coherent - Managed dma_free_noncoherent()
+ * @dev: Device to free noncoherent memory for
+ * @size: Size of allocation
+ * @vaddr: Virtual address of the memory to free
+ * @dma_handle: DMA handle of the memory to free
+ *
+ * Managed dma_free_noncoherent().
+ */
+void dmam_free_noncoherent(struct device *dev, size_t size, void *vaddr,
+			   dma_addr_t dma_handle)
+{
+	struct dma_devres match_data = { size, vaddr, dma_handle };
+
+	dma_free_noncoherent(dev, size, vaddr, dma_handle);
+	WARN_ON(!devres_destroy(dev, dmam_noncoherent_release, dmam_match,
+				&match_data));
+}
+EXPORT_SYMBOL(dmam_free_noncoherent);
+
+#ifdef ARCH_HAS_DMA_DECLARE_COHERENT_MEMORY
+
+static void dmam_coherent_decl_release(struct device *dev, void *res)
+{
+	dma_release_declared_memory(dev);
+}
+
+/**
+ * dmam_declare_coherent_memory - Managed dma_declare_coherent_memory()
+ * @dev: Device to declare coherent memory for
+ * @bus_addr: Bus address of coherent memory to be declared
+ * @device_addr: Device address of coherent memory to be declared
+ * @size: Size of coherent memory to be declared
+ * @flags: Flags
+ *
+ * Managed dma_declare_coherent_memory().
+ *
+ * RETURNS:
+ * 0 on success, -errno on failure.
+ */
+int dmam_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
+				 dma_addr_t device_addr, size_t size, int flags)
+{
+	void *res;
+	int rc;
+
+	res = devres_alloc(dmam_coherent_decl_release, 0, GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	rc = dma_declare_coherent_memory(dev, bus_addr, device_addr, size,
+					 flags);
+	if (rc == 0)
+		devres_add(dev, res);
+	else
+		devres_free(res);
+
+	return rc;
+}
+EXPORT_SYMBOL(dmam_declare_coherent_memory);
+
+/**
+ * dmam_release_declared_memory - Managed dma_release_declared_memory().
+ * @dev: Device to release declared coherent memory for
+ *
+ * Managed dmam_release_declared_memory().
+ */
+void dmam_release_declared_memory(struct device *dev)
+{
+	WARN_ON(devres_destroy(dev, dmam_coherent_decl_release, NULL, NULL));
+}
+EXPORT_SYMBOL(dmam_release_declared_memory);
+
+#endif
diff --git a/drivers/base/dmapool.c b/drivers/base/dmapool.c
index f95d502..cd467c9 100644
--- a/drivers/base/dmapool.c
+++ b/drivers/base/dmapool.c
@@ -415,8 +415,67 @@ dma_pool_free (struct dma_pool *pool, void *vaddr, dma_addr_t dma)
 	spin_unlock_irqrestore (&pool->lock, flags);
 }
 
+/*
+ * Managed DMA pool
+ */
+static void dmam_pool_release(struct device *dev, void *res)
+{
+	struct dma_pool *pool = *(struct dma_pool **)res;
+
+	dma_pool_destroy(pool);
+}
+
+static int dmam_pool_match(struct device *dev, void *res, void *match_data)
+{
+	return *(struct dma_pool **)res == match_data;
+}
+
+/**
+ * dmam_pool_create - Managed dma_pool_create()
+ * @name: name of pool, for diagnostics
+ * @dev: device that will be doing the DMA
+ * @size: size of the blocks in this pool.
+ * @align: alignment requirement for blocks; must be a power of two
+ * @allocation: returned blocks won't cross this boundary (or zero)
+ *
+ * Managed dma_pool_create().  DMA pool created with this function is
+ * automatically destroyed on driver detach.
+ */
+struct dma_pool *dmam_pool_create(const char *name, struct device *dev,
+				  size_t size, size_t align, size_t allocation)
+{
+	struct dma_pool **ptr, *pool;
+
+	ptr = devres_alloc(dmam_pool_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	pool = *ptr = dma_pool_create(name, dev, size, align, allocation);
+	if (pool)
+		devres_add(dev, ptr);
+	else
+		devres_free(ptr);
+
+	return pool;
+}
+
+/**
+ * dmam_pool_destroy - Managed dma_pool_destroy()
+ * @pool: dma pool that will be destroyed
+ *
+ * Managed dma_pool_destroy().
+ */
+void dmam_pool_destroy(struct dma_pool *pool)
+{
+	struct device *dev = pool->dev;
+
+	dma_pool_destroy(pool);
+	WARN_ON(devres_destroy(dev, dmam_pool_release, dmam_pool_match, pool));
+}
 
 EXPORT_SYMBOL (dma_pool_create);
 EXPORT_SYMBOL (dma_pool_destroy);
 EXPORT_SYMBOL (dma_pool_alloc);
 EXPORT_SYMBOL (dma_pool_free);
+EXPORT_SYMBOL (dmam_pool_create);
+EXPORT_SYMBOL (dmam_pool_destroy);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 206c834..ba45538 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -745,6 +745,104 @@ int pci_enable_device(struct pci_dev *dev)
 	return result;
 }
 
+/*
+ * Managed PCI resources.  This manages device on/off, intx/msi/msix
+ * on/off and BAR regions.  pci_dev itself records msi/msix status, so
+ * there's no need to track it separately.  pci_devres is initialized
+ * when a device is enabled using managed PCI device enable interface.
+ */
+struct pci_devres {
+	unsigned int disable:1;
+	unsigned int orig_intx:1;
+	unsigned int restore_intx:1;
+	u32 region_mask;
+};
+
+static void pcim_release(struct device *gendev, void *res)
+{
+	struct pci_dev *dev = container_of(gendev, struct pci_dev, dev);
+	struct pci_devres *this = res;
+	int i;
+
+	if (dev->msi_enabled)
+		pci_disable_msi(dev);
+	if (dev->msix_enabled)
+		pci_disable_msix(dev);
+
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
+		if (this->region_mask & (1 << i))
+			pci_release_region(dev, i);
+
+	if (this->restore_intx)
+		pci_intx(dev, this->orig_intx);
+
+	if (this->disable)
+		pci_disable_device(dev);
+}
+
+static struct pci_devres * get_pci_dr(struct pci_dev *pdev)
+{
+	struct pci_devres *dr, *new_dr;
+
+	dr = devres_find(&pdev->dev, pcim_release, NULL, NULL);
+	if (dr)
+		return dr;
+
+	new_dr = devres_alloc(pcim_release, sizeof(*new_dr), GFP_KERNEL);
+	if (!new_dr)
+		return NULL;
+	return devres_get(&pdev->dev, new_dr, NULL, NULL);
+}
+
+static struct pci_devres * find_pci_dr(struct pci_dev *pdev)
+{
+	if (pci_is_managed(pdev))
+		return devres_find(&pdev->dev, pcim_release, NULL, NULL);
+	return NULL;
+}
+
+/**
+ * pcim_enable_device - Managed pci_enable_device()
+ * @pdev: PCI device to be initialized
+ *
+ * Managed pci_enable_device().
+ */
+int pcim_enable_device(struct pci_dev *pdev)
+{
+	struct pci_devres *dr;
+	int rc;
+
+	dr = get_pci_dr(pdev);
+	if (unlikely(!dr))
+		return -ENOMEM;
+	WARN_ON(!!dr->disable);
+
+	rc = pci_enable_device(pdev);
+	if (!rc) {
+		pdev->is_managed = 1;
+		dr->disable = 1;
+	}
+	return rc;
+}
+
+/**
+ * pcim_pin_device - Pin managed PCI device
+ * @pdev: PCI device to pin
+ *
+ * Pin managed PCI device @pdev.  Pinned device won't be disabled on
+ * driver detach.  @pdev must have been enabled with
+ * pcim_enable_device().
+ */
+void pcim_pin_device(struct pci_dev *pdev)
+{
+	struct pci_devres *dr;
+
+	dr = find_pci_dr(pdev);
+	WARN_ON(!dr || !dr->disable);
+	if (dr)
+		dr->disable = 0;
+}
+
 /**
  * pcibios_disable_device - disable arch specific PCI resources for device dev
  * @dev: the PCI device to disable
@@ -768,8 +866,13 @@ void __attribute__ ((weak)) pcibios_disable_device (struct pci_dev *dev) {}
 void
 pci_disable_device(struct pci_dev *dev)
 {
+	struct pci_devres *dr;
 	u16 pci_command;
 
+	dr = find_pci_dr(dev);
+	if (dr)
+		dr->disable = 0;
+
 	if (atomic_sub_return(1, &dev->enable_cnt) != 0)
 		return;
 
@@ -868,6 +971,8 @@ pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge)
  */
 void pci_release_region(struct pci_dev *pdev, int bar)
 {
+	struct pci_devres *dr;
+
 	if (pci_resource_len(pdev, bar) == 0)
 		return;
 	if (pci_resource_flags(pdev, bar) & IORESOURCE_IO)
@@ -876,6 +981,10 @@ void pci_release_region(struct pci_dev *pdev, int bar)
 	else if (pci_resource_flags(pdev, bar) & IORESOURCE_MEM)
 		release_mem_region(pci_resource_start(pdev, bar),
 				pci_resource_len(pdev, bar));
+
+	dr = find_pci_dr(pdev);
+	if (dr)
+		dr->region_mask &= ~(1 << bar);
 }
 
 /**
@@ -894,6 +1003,8 @@ void pci_release_region(struct pci_dev *pdev, int bar)
  */
 int pci_request_region(struct pci_dev *pdev, int bar, const char *res_name)
 {
+	struct pci_devres *dr;
+
 	if (pci_resource_len(pdev, bar) == 0)
 		return 0;
 		
@@ -907,7 +1018,11 @@ int pci_request_region(struct pci_dev *pdev, int bar, const char *res_name)
 				        pci_resource_len(pdev, bar), res_name))
 			goto err_out;
 	}
-	
+
+	dr = find_pci_dr(pdev);
+	if (dr)
+		dr->region_mask |= 1 << bar;
+
 	return 0;
 
 err_out:
@@ -1118,7 +1233,15 @@ pci_intx(struct pci_dev *pdev, int enable)
 	}
 
 	if (new != pci_command) {
+		struct pci_devres *dr;
+
 		pci_write_config_word(pdev, PCI_COMMAND, new);
+
+		dr = find_pci_dr(pdev);
+		if (dr && !dr->restore_intx) {
+			dr->restore_intx = 1;
+			dr->orig_intx = !enable;
+		}
 	}
 }
 
@@ -1190,6 +1313,8 @@ EXPORT_SYMBOL(isa_bridge);
 EXPORT_SYMBOL_GPL(pci_restore_bars);
 EXPORT_SYMBOL(pci_enable_device_bars);
 EXPORT_SYMBOL(pci_enable_device);
+EXPORT_SYMBOL(pcim_enable_device);
+EXPORT_SYMBOL(pcim_pin_device);
 EXPORT_SYMBOL(pci_disable_device);
 EXPORT_SYMBOL(pci_find_capability);
 EXPORT_SYMBOL(pci_bus_find_capability);
diff --git a/include/linux/device.h b/include/linux/device.h
index f44247f..6c83917 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -346,6 +346,41 @@ extern int __must_check device_create_bin_file(struct device *dev,
 					       struct bin_attribute *attr);
 extern void device_remove_bin_file(struct device *dev,
 				   struct bin_attribute *attr);
+
+/* device resource management */
+typedef void (*dr_release_t)(struct device *dev, void *res);
+typedef int (*dr_match_t)(struct device *dev, void *res, void *match_data);
+
+#ifdef CONFIG_DEBUG_DEVRES
+extern void * __devres_alloc(dr_release_t release, size_t size, gfp_t gfp,
+			     const char *name);
+#define devres_alloc(release, size, gfp) \
+	__devres_alloc(release, size, gfp, #release)
+#else
+extern void * devres_alloc(dr_release_t release, size_t size, gfp_t gfp);
+#endif
+extern void devres_free(void *res);
+extern void devres_add(struct device *dev, void *res);
+extern void * devres_find(struct device *dev, dr_release_t release,
+			  dr_match_t match, void *match_data);
+extern void * devres_get(struct device *dev, void *new_res,
+			 dr_match_t match, void *match_data);
+extern void * devres_remove(struct device *dev, dr_release_t release,
+			    dr_match_t match, void *match_data);
+extern int devres_destroy(struct device *dev, dr_release_t release,
+			  dr_match_t match, void *match_data);
+
+/* devres group */
+extern void * __must_check devres_open_group(struct device *dev, void *id,
+					     gfp_t gfp);
+extern void devres_close_group(struct device *dev, void *id);
+extern void devres_remove_group(struct device *dev, void *id);
+extern int devres_release_group(struct device *dev, void *id);
+
+/* managed kzalloc/kfree for device drivers, no kmalloc, always use kzalloc */
+extern void *devm_kzalloc(struct device *dev, size_t size, gfp_t gfp);
+extern void devm_kfree(struct device *dev, void *p);
+
 struct device {
 	struct klist		klist_children;
 	struct klist_node	knode_parent;		/* node in sibling list */
@@ -388,6 +423,9 @@ struct device {
 	/* arch specific additions */
 	struct dev_archdata	archdata;
 
+	spinlock_t		devres_lock;
+	struct list_head	devres_head;
+
 	/* class_device migration path */
 	struct list_head	node;
 	struct class		*class;		/* optional*/
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index ff203c4..9a663c6 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -66,6 +66,33 @@ dma_mark_declared_memory_occupied(struct device *dev,
 }
 #endif
 
-#endif
+/*
+ * Managed DMA API
+ */
+extern void *dmam_alloc_coherent(struct device *dev, size_t size,
+				 dma_addr_t *dma_handle, gfp_t gfp);
+extern void dmam_free_coherent(struct device *dev, size_t size, void *vaddr,
+			       dma_addr_t dma_handle);
+extern void *dmam_alloc_noncoherent(struct device *dev, size_t size,
+				    dma_addr_t *dma_handle, gfp_t gfp);
+extern void dmam_free_noncoherent(struct device *dev, size_t size, void *vaddr,
+				  dma_addr_t dma_handle);
+#ifdef ARCH_HAS_DMA_DECLARE_COHERENT_MEMORY
+extern int dmam_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
+					dma_addr_t device_addr, size_t size,
+					int flags);
+extern void dmam_release_declared_memory(struct device *dev);
+#else /* ARCH_HAS_DMA_DECLARE_COHERENT_MEMORY */
+static inline int dmam_declare_coherent_memory(struct device *dev,
+				dma_addr_t bus_addr, dma_addr_t device_addr,
+				size_t size, gfp_t gfp)
+{
+	return 0;
+}
 
+static inline void dmam_release_declared_memory(struct device *dev)
+{
+}
+#endif /* ARCH_HAS_DMA_DECLARE_COHERENT_MEMORY */
 
+#endif
diff --git a/include/linux/dmapool.h b/include/linux/dmapool.h
index 76f12f4..022e34f 100644
--- a/include/linux/dmapool.h
+++ b/include/linux/dmapool.h
@@ -24,5 +24,12 @@ void *dma_pool_alloc(struct dma_pool *pool, gfp_t mem_flags,
 
 void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t addr);
 
+/*
+ * Managed DMA pool
+ */
+struct dma_pool *dmam_pool_create(const char *name, struct device *dev,
+				  size_t size, size_t align, size_t allocation);
+void dmam_pool_destroy(struct dma_pool *pool);
+
 #endif
 
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index e36e86c..5a8ba0b 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/irqflags.h>
 #include <linux/bottom_half.h>
+#include <linux/device.h>
 #include <asm/atomic.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
@@ -83,6 +84,11 @@ extern int request_irq(unsigned int, irq_handler_t handler,
 		       unsigned long, const char *, void *);
 extern void free_irq(unsigned int, void *);
 
+extern int devm_request_irq(struct device *dev, unsigned int irq,
+			    irq_handler_t handler, unsigned long irqflags,
+			    const char *devname, void *dev_id);
+extern void devm_free_irq(struct device *dev, unsigned int irq, void *dev_id);
+
 /*
  * On lockdep we dont want to enable hardirqs in hardirq
  * context. Use local_irq_enable_in_hardirq() to annotate
diff --git a/include/linux/io.h b/include/linux/io.h
index 81877ea..f5edf9c 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -28,6 +28,23 @@ void __iowrite64_copy(void __iomem *to, const void *from, size_t count);
 int ioremap_page_range(unsigned long addr, unsigned long end,
 		       unsigned long phys_addr, pgprot_t prot);
 
+/*
+ * Managed iomap interface
+ */
+void __iomem * devm_ioport_map(struct device *dev, unsigned long port,
+			       unsigned int nr);
+void devm_ioport_unmap(struct device *dev, void __iomem *addr);
+
+void __iomem * devm_ioremap(struct device *dev, unsigned long offset,
+			    unsigned long size);
+void __iomem * devm_ioremap_nocache(struct device *dev, unsigned long offset,
+				    unsigned long size);
+void devm_iounmap(struct device *dev, void __iomem *addr);
+
+void __iomem * pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
+void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
+void __iomem * const * pcim_iomap_table(struct pci_dev *pdev);
+
 /**
  *	check_signature		-	find BIOS signatures
  *	@io_addr: mmio address to check
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 15228d7..6859a3b 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -137,4 +137,24 @@ static inline int __deprecated check_region(resource_size_t s,
 {
 	return __check_region(&ioport_resource, s, n);
 }
+
+/* Wrappers for managed devices */
+struct device;
+#define devm_request_region(dev,start,n,name) \
+	__devm_request_region(dev, &ioport_resource, (start), (n), (name))
+#define devm_request_mem_region(dev,start,n,name) \
+	__devm_request_region(dev, &iomem_resource, (start), (n), (name))
+
+extern struct resource * __devm_request_region(struct device *dev,
+				struct resource *parent, resource_size_t start,
+				resource_size_t n, const char *name);
+
+#define devm_release_region(start,n) \
+	__devm_release_region(dev, &ioport_resource, (start), (n))
+#define devm_release_mem_region(start,n) \
+	__devm_release_region(dev, &iomem_resource, (start), (n))
+
+extern void __devm_release_region(struct device *dev, struct resource *parent,
+				  resource_size_t start, resource_size_t n);
+
 #endif	/* _LINUX_IOPORT_H */
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f3c617e..1f82eb9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -167,6 +167,7 @@ struct pci_dev {
 	unsigned int	broken_parity_status:1;	/* Device generates false positive parity */
 	unsigned int 	msi_enabled:1;
 	unsigned int	msix_enabled:1;
+	unsigned int	is_managed:1;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
 	u32		saved_config_space[16]; /* config space saved at suspend time */
@@ -521,6 +522,14 @@ static inline int pci_write_config_dword(struct pci_dev *dev, int where, u32 val
 
 int __must_check pci_enable_device(struct pci_dev *dev);
 int __must_check pci_enable_device_bars(struct pci_dev *dev, int mask);
+int __must_check pcim_enable_device(struct pci_dev *pdev);
+void pcim_pin_device(struct pci_dev *pdev);
+
+static inline int pci_is_managed(struct pci_dev *pdev)
+{
+	return pdev->is_managed;
+}
+
 void pci_disable_device(struct pci_dev *dev);
 void pci_set_master(struct pci_dev *dev);
 #define HAVE_PCI_SET_MWI
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index b385878..9aa6544 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -479,3 +479,89 @@ int request_irq(unsigned int irq, irq_handler_t handler,
 	return retval;
 }
 EXPORT_SYMBOL(request_irq);
+
+/*
+ * Device resource management aware IRQ request/free implementation.
+ */
+struct irq_devres {
+	unsigned int irq;
+	void *dev_id;
+};
+
+static void devm_irq_release(struct device *dev, void *res)
+{
+	struct irq_devres *this = res;
+
+	free_irq(this->irq, this->dev_id);
+}
+
+static int devm_irq_match(struct device *dev, void *res, void *data)
+{
+	struct irq_devres *this = res, *match = data;
+
+	return this->irq == match->irq && this->dev_id == match->dev_id;
+}
+
+/**
+ *	devm_request_irq - allocate an interrupt line for a managed device
+ *	@dev: device to request interrupt for
+ *	@irq: Interrupt line to allocate
+ *	@handler: Function to be called when the IRQ occurs
+ *	@irqflags: Interrupt type flags
+ *	@devname: An ascii name for the claiming device
+ *	@dev_id: A cookie passed back to the handler function
+ *
+ *	Except for the extra @dev argument, this function takes the
+ *	same arguments and performs the same function as
+ *	request_irq().  IRQs requested with this function will be
+ *	automatically freed on driver detach.
+ *
+ *	If an IRQ allocated with this function needs to be freed
+ *	separately, dev_free_irq() must be used.
+ */
+int devm_request_irq(struct device *dev, unsigned int irq,
+		     irq_handler_t handler, unsigned long irqflags,
+		     const char *devname, void *dev_id)
+{
+	struct irq_devres *dr;
+	int rc;
+
+	dr = devres_alloc(devm_irq_release, sizeof(struct irq_devres),
+			  GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
+
+	rc = request_irq(irq, handler, irqflags, devname, dev_id);
+	if (rc) {
+		kfree(dr);
+		return rc;
+	}
+
+	dr->irq = irq;
+	dr->dev_id = dev_id;
+	devres_add(dev, dr);
+
+	return 0;
+}
+EXPORT_SYMBOL(devm_request_irq);
+
+/**
+ *	devm_free_irq - free an interrupt
+ *	@dev: device to free interrupt for
+ *	@irq: Interrupt line to free
+ *	@dev_id: Device identity to free
+ *
+ *	Except for the extra @dev argument, this function takes the
+ *	same arguments and performs the same function as free_irq().
+ *	This function instead of free_irq() should be used to manually
+ *	free IRQs allocated with dev_request_irq().
+ */
+void devm_free_irq(struct device *dev, unsigned int irq, void *dev_id)
+{
+	struct irq_devres match_data = { irq, dev_id };
+
+	free_irq(irq, dev_id);
+	WARN_ON(devres_destroy(dev, devm_irq_release, devm_irq_match,
+			       &match_data));
+}
+EXPORT_SYMBOL(devm_free_irq);
diff --git a/kernel/resource.c b/kernel/resource.c
index 7b9a497..2a3f886 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -17,6 +17,7 @@
 #include <linux/fs.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/device.h>
 #include <asm/io.h>
 
 
@@ -618,6 +619,67 @@ void __release_region(struct resource *parent, resource_size_t start,
 EXPORT_SYMBOL(__release_region);
 
 /*
+ * Managed region resource
+ */
+struct region_devres {
+	struct resource *parent;
+	resource_size_t start;
+	resource_size_t n;
+};
+
+static void devm_region_release(struct device *dev, void *res)
+{
+	struct region_devres *this = res;
+
+	__release_region(this->parent, this->start, this->n);
+}
+
+static int devm_region_match(struct device *dev, void *res, void *match_data)
+{
+	struct region_devres *this = res, *match = match_data;
+
+	return this->parent == match->parent &&
+		this->start == match->start && this->n == match->n;
+}
+
+struct resource * __devm_request_region(struct device *dev,
+				struct resource *parent, resource_size_t start,
+				resource_size_t n, const char *name)
+{
+	struct region_devres *dr = NULL;
+	struct resource *res;
+
+	dr = devres_alloc(devm_region_release, sizeof(struct region_devres),
+			  GFP_KERNEL);
+	if (!dr)
+		return NULL;
+
+	dr->parent = parent;
+	dr->start = start;
+	dr->n = n;
+
+	res = __request_region(parent, start, n, name);
+	if (res)
+		devres_add(dev, dr);
+	else
+		devres_free(dr);
+
+	return res;
+}
+EXPORT_SYMBOL(__devm_request_region);
+
+void __devm_release_region(struct device *dev, struct resource *parent,
+			   resource_size_t start, resource_size_t n)
+{
+	struct region_devres match_data = { parent, start, n };
+
+	__release_region(parent, start, n);
+	WARN_ON(devres_destroy(dev, devm_region_release, devm_region_match,
+			       &match_data));
+}
+EXPORT_SYMBOL(__devm_release_region);
+
+/*
  * Called from init/main.c to reserve IO ports.
  */
 #define MAXRESERVE 4
diff --git a/lib/Makefile b/lib/Makefile
index 77b4bad..29b2e99 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -5,7 +5,7 @@
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o irq_regs.o reciprocal_div.o
+	 sha1.o irq_regs.o reciprocal_div.o iomap.o
 
 lib-$(CONFIG_MMU) += ioremap.o
 lib-$(CONFIG_SMP) += cpumask.o
@@ -41,7 +41,6 @@ obj-$(CONFIG_CRC_CCITT)	+= crc-ccitt.o
 obj-$(CONFIG_CRC16)	+= crc16.o
 obj-$(CONFIG_CRC32)	+= crc32.o
 obj-$(CONFIG_LIBCRC32C)	+= libcrc32c.o
-obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
 obj-$(CONFIG_GENERIC_ALLOCATOR) += genalloc.o
 
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
diff --git a/lib/iomap.c b/lib/iomap.c
index d6ccdd8..3214028 100644
--- a/lib/iomap.c
+++ b/lib/iomap.c
@@ -4,8 +4,10 @@
  * (C) Copyright 2004 Linus Torvalds
  */
 #include <linux/pci.h>
+#include <linux/io.h>
+
+#ifdef CONFIG_GENERIC_IOMAP
 #include <linux/module.h>
-#include <asm/io.h>
 
 /*
  * Read/write from/to an (offsettable) iomem cookie. It might be a PIO
@@ -254,3 +256,245 @@ void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
 }
 EXPORT_SYMBOL(pci_iomap);
 EXPORT_SYMBOL(pci_iounmap);
+
+#endif /* CONFIG_GENERIC_IOMAP */
+
+/*
+ * Generic iomap devres
+ */
+static void devm_ioport_map_release(struct device *dev, void *res)
+{
+	ioport_unmap(*(void __iomem **)res);
+}
+
+static int devm_ioport_map_match(struct device *dev, void *res,
+				 void *match_data)
+{
+	return *(void **)res == match_data;
+}
+
+/**
+ * devm_ioport_map - Managed ioport_map()
+ * @dev: Generic device to map ioport for
+ * @port: Port to map
+ * @nr: Number of ports to map
+ *
+ * Managed ioport_map().  Map is automatically unmapped on driver
+ * detach.
+ */
+void __iomem * devm_ioport_map(struct device *dev, unsigned long port,
+			       unsigned int nr)
+{
+	void __iomem **ptr, *addr;
+
+	ptr = devres_alloc(devm_ioport_map_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	addr = ioport_map(port, nr);
+	if (addr) {
+		*ptr = addr;
+		devres_add(dev, ptr);
+	} else
+		devres_free(ptr);
+
+	return addr;
+}
+EXPORT_SYMBOL(devm_ioport_map);
+
+/**
+ * devm_ioport_unmap - Managed ioport_unmap()
+ * @dev: Generic device to unmap for
+ * @addr: Address to unmap
+ *
+ * Managed ioport_unmap().  @addr must have been mapped using
+ * devm_ioport_map().
+ */
+void devm_ioport_unmap(struct device *dev, void __iomem *addr)
+{
+	ioport_unmap(addr);
+	WARN_ON(devres_destroy(dev, devm_ioport_map_release,
+			       devm_ioport_map_match, (void *)addr));
+}
+EXPORT_SYMBOL(devm_ioport_unmap);
+
+static void devm_ioremap_release(struct device *dev, void *res)
+{
+	iounmap(*(void __iomem **)res);
+}
+
+static int devm_ioremap_match(struct device *dev, void *res, void *match_data)
+{
+	return *(void **)res == match_data;
+}
+
+/**
+ * devm_ioremap - Managed ioremap()
+ * @dev: Generic device to remap IO address for
+ * @offset: BUS offset to map
+ * @size: Size of map
+ *
+ * Managed ioremap().  Map is automatically unmapped on driver detach.
+ */
+void __iomem *devm_ioremap(struct device *dev, unsigned long offset,
+			   unsigned long size)
+{
+	void __iomem **ptr, *addr;
+
+	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	addr = ioremap(offset, size);
+	if (addr) {
+		*ptr = addr;
+		devres_add(dev, ptr);
+	} else
+		devres_free(ptr);
+
+	return addr;
+}
+EXPORT_SYMBOL(devm_ioremap);
+
+/**
+ * devm_ioremap_nocache - Managed ioremap_nocache()
+ * @dev: Generic device to remap IO address for
+ * @offset: BUS offset to map
+ * @size: Size of map
+ *
+ * Managed ioremap_nocache().  Map is automatically unmapped on driver
+ * detach.
+ */
+void __iomem *devm_ioremap_nocache(struct device *dev, unsigned long offset,
+				   unsigned long size)
+{
+	void __iomem **ptr, *addr;
+
+	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	addr = ioremap_nocache(offset, size);
+	if (addr) {
+		*ptr = addr;
+		devres_add(dev, ptr);
+	} else
+		devres_free(ptr);
+
+	return addr;
+}
+EXPORT_SYMBOL(devm_ioremap_nocache);
+
+/**
+ * devm_iounmap - Managed iounmap()
+ * @dev: Generic device to unmap for
+ * @addr: Address to unmap
+ *
+ * Managed iounmap().  @addr must have been mapped using devm_ioremap*().
+ */
+void devm_iounmap(struct device *dev, void __iomem *addr)
+{
+	iounmap(addr);
+	WARN_ON(devres_destroy(dev, devm_ioremap_release, devm_ioremap_match,
+			       (void *)addr));
+}
+EXPORT_SYMBOL(devm_iounmap);
+
+/*
+ * PCI iomap devres
+ */
+#define PCIM_IOMAP_MAX	PCI_ROM_RESOURCE
+
+struct pcim_iomap_devres {
+	void __iomem *table[PCIM_IOMAP_MAX];
+};
+
+static void pcim_iomap_release(struct device *gendev, void *res)
+{
+	struct pci_dev *dev = container_of(gendev, struct pci_dev, dev);
+	struct pcim_iomap_devres *this = res;
+	int i;
+
+	for (i = 0; i < PCIM_IOMAP_MAX; i++)
+		if (this->table[i])
+			pci_iounmap(dev, this->table[i]);
+}
+
+/**
+ * pcim_iomap_table - access iomap allocation table
+ * @pdev: PCI device to access iomap table for
+ *
+ * Access iomap allocation table for @dev.  If iomap table doesn't
+ * exist and @pdev is managed, it will be allocated.  All iomaps
+ * recorded in the iomap table are automatically unmapped on driver
+ * detach.
+ *
+ * This function might sleep when the table is first allocated but can
+ * be safely called without context and guaranteed to succed once
+ * allocated.
+ */
+void __iomem * const * pcim_iomap_table(struct pci_dev *pdev)
+{
+	struct pcim_iomap_devres *dr, *new_dr;
+
+	dr = devres_find(&pdev->dev, pcim_iomap_release, NULL, NULL);
+	if (dr)
+		return dr->table;
+
+	new_dr = devres_alloc(pcim_iomap_release, sizeof(*new_dr), GFP_KERNEL);
+	if (!new_dr)
+		return NULL;
+	dr = devres_get(&pdev->dev, new_dr, NULL, NULL);
+	return dr->table;
+}
+EXPORT_SYMBOL(pcim_iomap_table);
+
+/**
+ * pcim_iomap - Managed pcim_iomap()
+ * @pdev: PCI device to iomap for
+ * @bar: BAR to iomap
+ * @maxlen: Maximum length of iomap
+ *
+ * Managed pci_iomap().  Map is automatically unmapped on driver
+ * detach.
+ */
+void __iomem * pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen)
+{
+	void __iomem **tbl;
+
+	BUG_ON(bar >= PCIM_IOMAP_MAX);
+
+	tbl = (void __iomem **)pcim_iomap_table(pdev);
+	if (!tbl || tbl[bar])	/* duplicate mappings not allowed */
+		return NULL;
+
+	tbl[bar] = pci_iomap(pdev, bar, maxlen);
+	return tbl[bar];
+}
+EXPORT_SYMBOL(pcim_iomap);
+
+/**
+ * pcim_iounmap - Managed pci_iounmap()
+ * @pdev: PCI device to iounmap for
+ * @addr: Address to unmap
+ *
+ * Managed pci_iounmap().  @addr must have been mapped using pcim_iomap().
+ */
+void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr)
+{
+	void __iomem **tbl;
+	int i;
+
+	pci_iounmap(pdev, addr);
+
+	tbl = (void __iomem **)pcim_iomap_table(pdev);
+	BUG_ON(!tbl);
+
+	for (i = 0; i < PCIM_IOMAP_MAX; i++)
+		if (tbl[i] == addr) {
+			tbl[i] = NULL;
+			return;
+		}
+	WARN_ON(1);
+}
+EXPORT_SYMBOL(pcim_iounmap);
-- 
1.4.4.4


