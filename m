Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030431AbWJDNF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030431AbWJDNF5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 09:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030436AbWJDNF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 09:05:56 -0400
Received: from havoc.gtf.org ([69.61.125.42]:31115 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030431AbWJDNF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 09:05:56 -0400
Date: Wed, 4 Oct 2006 09:05:54 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/base: error handling fixes
Message-ID: <20061004130554.GA25974@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/base/class:
- class_device_rename(): function basically shat itself if anything
  failed, leaving things in an indeterminant state.  If kmalloc() ever
  failed, it would dereference ERR_PTR(-ENOMEM).  Fix a bunch of bugs,
  over and above sysfs_create_link() error handling.

- class_device_add(): add missing sysfs_remove_link() [fix leak] to error path
- class_device_add(): handle sysfs_create_link() failure

drivers/base/dmapool:
- kmalloc() takes a GFP_xxx argument
- handle device_create_file() failure

drivers/base/platform:
- properly handle errors (fix leak-on-err) in platform_bus_init()

drivers/base/topology:
- return sysfs error via NOTIFY_BAD

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/base/class.c    |   56 ++++++++++++++++++++++++++++++++++++++++++------
 drivers/base/dmapool.c  |    8 +++++-
 drivers/base/platform.c |   10 ++++++--
 drivers/base/topology.c |   11 ++++-----
 4 files changed, 69 insertions(+), 16 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index b32b77f..673db14 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -562,7 +562,9 @@ int class_device_add(struct class_device
 		goto out2;
 
 	/* add the needed attributes to this device */
-	sysfs_create_link(&class_dev->kobj, &parent_class->subsys.kset.kobj, "subsystem");
+	error = sysfs_create_link(&class_dev->kobj, &parent_class->subsys.kset.kobj, "subsystem");
+	if (error)
+		goto out2_5;
 	class_dev->uevent_attr.attr.name = "uevent";
 	class_dev->uevent_attr.attr.mode = S_IWUSR;
 	class_dev->uevent_attr.attr.owner = parent_class->owner;
@@ -639,6 +641,8 @@ int class_device_add(struct class_device
  out4:
 	class_device_remove_file(class_dev, &class_dev->uevent_attr);
  out3:
+	sysfs_remove_link(&class_dev->kobj, "subsystem");
+ out2_5:
 	kobject_del(&class_dev->kobj);
  out2:
 	if(parent_class_dev)
@@ -791,36 +795,76 @@ void class_device_destroy(struct class *
 
 int class_device_rename(struct class_device *class_dev, char *new_name)
 {
-	int error = 0;
+	int error = 0, err2;
 	char *old_class_name = NULL, *new_class_name = NULL;
+	char *old_name;
 
 	class_dev = class_device_get(class_dev);
 	if (!class_dev)
 		return -EINVAL;
 
-	pr_debug("CLASS: renaming '%s' to '%s'\n", class_dev->class_id,
+	old_name = kstrdup(class_dev->class_id, GFP_KERNEL);
+	if (!old_name) {
+		error = -ENOMEM;
+		goto err_out;
+	}
+
+	pr_debug("CLASS: renaming '%s' to '%s'\n", old_name,
 		 new_name);
 
-	if (class_dev->dev)
+	if (class_dev->dev) {
 		old_class_name = make_class_name(class_dev->class->name,
 						 &class_dev->kobj);
+		if (IS_ERR(old_class_name)) {
+			error = PTR_ERR(old_class_name);
+			goto err_out_oname;
+		}
+	}
 
 	strlcpy(class_dev->class_id, new_name, KOBJ_NAME_LEN);
 
 	error = kobject_rename(&class_dev->kobj, new_name);
+	if (error)
+		goto err_out_nameset;
 
 	if (class_dev->dev) {
 		new_class_name = make_class_name(class_dev->class->name,
 						 &class_dev->kobj);
-		sysfs_create_link(&class_dev->dev->kobj, &class_dev->kobj,
-				  new_class_name);
+		if (IS_ERR(new_class_name)) {
+			error = PTR_ERR(new_class_name);
+			goto err_out_rename;
+		}
+
+		error = sysfs_create_link(&class_dev->dev->kobj,
+					  &class_dev->kobj, new_class_name);
+		if (error)
+			goto err_out_new_class;
+
 		sysfs_remove_link(&class_dev->dev->kobj, old_class_name);
 	}
+
 	class_device_put(class_dev);
 
+	kfree(old_name);
 	kfree(old_class_name);
 	kfree(new_class_name);
 
+	return 0;
+
+err_out_new_class:
+	kfree(new_class_name);
+err_out_rename:
+	err2 = kobject_rename(&class_dev->kobj, old_name);
+	if (err2)
+		printk(KERN_ERR "Error %d while undoing kobject_rename('%s') failure... ruh roh, raggy\n",
+			err2, new_name);
+err_out_nameset:
+	strlcpy(class_dev->class_id, old_name, KOBJ_NAME_LEN);
+	kfree(old_class_name);
+err_out_oname:
+	kfree(old_name);
+err_out:
+	class_device_put(class_dev);
 	return error;
 }
 
diff --git a/drivers/base/dmapool.c b/drivers/base/dmapool.c
index 33c5cce..b418b6b 100644
--- a/drivers/base/dmapool.c
+++ b/drivers/base/dmapool.c
@@ -126,7 +126,7 @@ dma_pool_create (const char *name, struc
 	} else if (allocation < size)
 		return NULL;
 
-	if (!(retval = kmalloc (sizeof *retval, SLAB_KERNEL)))
+	if (!(retval = kmalloc (sizeof *retval, GFP_KERNEL)))
 		return retval;
 
 	strlcpy (retval->name, name, sizeof retval->name);
@@ -143,7 +143,11 @@ dma_pool_create (const char *name, struc
 	if (dev) {
 		down (&pools_lock);
 		if (list_empty (&dev->dma_pools))
-			device_create_file (dev, &dev_attr_pools);
+			if (device_create_file (dev, &dev_attr_pools)) {
+				up (&pools_lock);
+				kfree(retval);
+				return NULL;
+			}
 		/* note:  not currently insisting "name" be unique */
 		list_add (&retval->pools, &dev->dma_pools);
 		up (&pools_lock);
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 940ce41..3b6b758 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -563,8 +563,14 @@ EXPORT_SYMBOL_GPL(platform_bus_type);
 
 int __init platform_bus_init(void)
 {
-	device_register(&platform_bus);
-	return bus_register(&platform_bus_type);
+	int err = device_register(&platform_bus);
+	if (err)
+		return err;
+
+	err = bus_register(&platform_bus_type);
+	if (err)
+		device_unregister(&platform_bus);
+	return err;
 }
 
 #ifndef ARCH_HAS_DMA_GET_REQUIRED_MASK
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 3ef9d51..2d0c965 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -97,14 +97,12 @@ static struct attribute_group topology_a
 /* Add/Remove cpu_topology interface for CPU device */
 static int __cpuinit topology_add_dev(struct sys_device * sys_dev)
 {
-	sysfs_create_group(&sys_dev->kobj, &topology_attr_group);
-	return 0;
+	return sysfs_create_group(&sys_dev->kobj, &topology_attr_group);
 }
 
-static int __cpuinit topology_remove_dev(struct sys_device * sys_dev)
+static void __cpuinit topology_remove_dev(struct sys_device * sys_dev)
 {
 	sysfs_remove_group(&sys_dev->kobj, &topology_attr_group);
-	return 0;
 }
 
 static int __cpuinit topology_cpu_callback(struct notifier_block *nfb,
@@ -112,17 +110,18 @@ static int __cpuinit topology_cpu_callba
 {
 	unsigned int cpu = (unsigned long)hcpu;
 	struct sys_device *sys_dev;
+	int rc = 0;
 
 	sys_dev = get_cpu_sysdev(cpu);
 	switch (action) {
 	case CPU_ONLINE:
-		topology_add_dev(sys_dev);
+		rc = topology_add_dev(sys_dev);
 		break;
 	case CPU_DEAD:
 		topology_remove_dev(sys_dev);
 		break;
 	}
-	return NOTIFY_OK;
+	return rc ? NOTIFY_BAD : NOTIFY_OK;
 }
 
 static struct notifier_block __cpuinitdata topology_cpu_notifier =
