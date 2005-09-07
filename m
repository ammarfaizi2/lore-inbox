Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVIGSKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVIGSKI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 14:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVIGSKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 14:10:08 -0400
Received: from mail.cs.umn.edu ([128.101.35.202]:42645 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id S1750756AbVIGSKF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 14:10:05 -0400
Date: Wed, 7 Sep 2005 13:09:59 -0500
From: Dave C Boutcher <sleddog@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [Patch 2/4] [RFC] Resend SCSI target for IBM Power5 LPAR
Message-ID: <20050907180959.GC12904@cs.umn.edu>
Reply-To: boutcher@cs.umn.edu
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <20050907180333.GA12904@cs.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050907180333.GA12904@cs.umn.edu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sysfs configuration interfaces

Signed-off-by: Dave Boutcher <boutcher@us.ibm.com>
Signed-off-by: Santiago Leon <santil@us.ibm.com>
Signed-off-by: Linda Xie <lxie@us.ibm.com>

--- linux-2.6.13-rc7a/drivers/scsi/ibmvscsi/ibmvscsis.c	2005-09-07 12:47:49.938952591 -0500
+++ linux-2.6.13-rc7-ibmvscsis/drivers/scsi/ibmvscsi/ibmvscsis.c	2005-09-07 12:48:13.076195417 -0500
@@ -2961,6 +2961,607 @@
 }
 
 /* ==============================================================
+ * Shared Device Management
+ * ==============================================================
+ */
+/*
+ * Add a block device as a SCSI LUN
+ */
+static int activate_device(struct vdev *vdev)
+{
+	struct block_device *bdev;
+	char *name = vdev->device_name;
+	int ro = vdev->b.ro;
+	unsigned long flags;
+	struct scsi_dev_node *tmp_sdn;
+
+	bdev = open_bdev_excl(name, ro, activate_device);
+	if (IS_ERR(bdev))
+		return PTR_ERR(bdev);;
+
+	spin_lock_irqsave(&sdev_list_lock, flags);
+	list_for_each_entry(tmp_sdn, &scsi_dev_list, node) {
+		struct scsi_device *sdev = tmp_sdn->sdev;
+		/* if the block device is a known scsi_device and
+		   device is not a partition */
+		if (sdev->request_queue == bdev->bd_disk->queue &&
+		    bdev == bdev->bd_contains) {
+			vdev->s.sdev = sdev;
+			tmp_sdn->vdev = vdev;
+			spin_unlock_irqrestore(&sdev_list_lock, flags);
+			close_bdev_excl(bdev);
+			vdev->direct_scsi = (char)1;
+			vdev->disabled = 0;
+			info("Activating %s (scsi %d:%d:%d:%d) as LUN 0x%lx\n",
+			     name, sdev->host->host_no, sdev->channel,
+			     sdev->id, sdev->lun, vdev->lun);
+			return 0;
+		}
+	}
+	spin_unlock_irqrestore(&sdev_list_lock, flags);
+
+	vdev->direct_scsi = 0;
+	vdev->b.bdev = bdev;
+	vdev->disabled = 0;
+	vdev->b.sectsize = bdev_hardsect_size(bdev);
+	vdev->b.blocksize = bdev->bd_block_size;
+	if (bdev->bd_disk->flags & GENHD_FL_CD)
+		vdev->b.scsi_type = TYPE_ROM; /* CD/DVD */
+	else
+		vdev->b.scsi_type = TYPE_DISK; /* disk */
+
+	if (bdev->bd_disk->flags & GENHD_FL_REMOVABLE) {
+		vdev->b.removable = 1; /* rmb bit of inquiry */
+		vdev->b.changed = 1;
+	} else
+		vdev->b.removable = 0;
+
+	info("Activating block device %s as %s %s LUN 0x%lx sector size %ld\n",
+	     name, ro ? "read only " : "",
+	     vdev->b.scsi_type ? "CD" : "disk", vdev->lun,
+	     vdev->b.sectsize);
+
+	return 0;
+}
+
+static void deactivate_scsi_device(struct vdev *vdev)
+{
+	struct scsi_dev_node *tmp_sdn;
+
+	vdev->disabled = 1;
+	vdev->s.sdev = NULL;
+
+	list_for_each_entry(tmp_sdn, &scsi_dev_list, node)
+		if (tmp_sdn->vdev == vdev)
+			tmp_sdn->vdev = NULL;
+}
+
+static void deactivate_device(struct vdev *vdev)
+{
+	info("Deactivating block device, LUN 0x%lx\n", vdev->lun);
+
+	/* Wait while any users of this device finish.  Note there should
+	 * be no new users, since we have marked this disabled
+	 *
+	 * We just poll here, since we are blocking write
+	 */
+	while (atomic_read(&vdev->refcount)) {
+		msleep(REFCOUNT_TIMEOUT_MS);
+	}
+
+	vdev->disabled = 1;
+
+	if (!vdev->direct_scsi)
+		close_bdev_excl(vdev->b.bdev);
+	else
+		deactivate_scsi_device(vdev);
+}
+
+/*
+ * Callback when a scsi_device gets added to the system
+ */
+static int add_scsi_device(struct class_device *cdev)
+{
+	struct scsi_device *sdev = to_scsi_device(cdev->dev);
+	struct scsi_dev_node * sdevnode =
+			kmalloc(sizeof(struct scsi_dev_node), GFP_ATOMIC);
+	unsigned long flags;
+
+	dbg("add_scsi_device got %p, %d:%d:%d:%d, sdn=%p\n", sdev,
+	    sdev->host->host_no, sdev->channel, sdev->id, sdev->lun, sdevnode);
+
+	sdevnode->sdev = sdev;
+	sdevnode->vdev = NULL;
+
+	spin_lock_irqsave(&sdev_list_lock, flags);
+	list_add_tail(&sdevnode->node, &scsi_dev_list);
+	spin_unlock_irqrestore(&sdev_list_lock, flags);
+	return 0;
+}
+
+/*
+ * Callback when a scsi_device gets removed from the system
+ */
+static void rem_scsi_device(struct class_device *cdev)
+{
+	struct scsi_dev_node *tmp_sdn;
+	struct scsi_device *sdev = to_scsi_device(cdev->dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&sdev_list_lock, flags);
+	list_for_each_entry(tmp_sdn, &scsi_dev_list, node) {
+		if (sdev == tmp_sdn->sdev) {
+			if (tmp_sdn->vdev && !tmp_sdn->vdev->disabled)
+				deactivate_scsi_device(tmp_sdn->vdev);
+			list_del(&tmp_sdn->node);
+			kfree(tmp_sdn);
+			goto out;
+		}
+	}
+
+	warn("rem_scsi_device: Couldn't find scsi_device %p %d:%d:%d:%d\n",
+		sdev, sdev->host->host_no, sdev->channel, sdev->id, sdev->lun);
+out:	spin_unlock_irqrestore(&sdev_list_lock, flags);
+	return;
+}
+
+/* ==============================================================
+ * SYSFS Routines
+ * ==============================================================
+ */
+static struct class_interface vscsis_interface = {
+	.add = add_scsi_device,
+	.remove = rem_scsi_device,
+};
+
+static struct kobj_type ktype_vscsi_target;
+static struct kobj_type ktype_vscsi_bus;
+static struct kobj_type ktype_vscsi_stats;
+
+static void vscsi_target_release(struct kobject *kobj) {
+	struct vdev *tmpdev =
+		container_of(kobj,struct vdev,kobj);
+	kfree(tmpdev);
+}
+
+static void vscsi_bus_release(struct kobject *kobj) {
+	struct vbus *tmpbus =
+		container_of(kobj,struct vbus,kobj);
+	kfree(tmpbus);
+}
+
+static void set_num_targets(struct vbus* vbus, long value)
+{
+	struct device *dev =
+		container_of(vbus->kobj.parent, struct device , kobj);
+	struct server_adapter *adapter =
+				(struct server_adapter *)dev->driver_data;
+	int cur_num_targets = atomic_read(&vbus->num_targets);
+	unsigned long flags;
+	struct vdev *tmpdev;
+
+	/* Growing */
+	if (cur_num_targets < value) {
+		int i;
+		for (i = cur_num_targets; i < value; i++) {
+			tmpdev = (struct vdev *)kmalloc(sizeof(struct vdev),
+							GFP_KERNEL);
+			if (!tmpdev) {
+				err("Couldn't allocate target memory %d\n", i);
+				return;
+			}
+			memset(tmpdev, 0, sizeof(struct vdev));
+
+			tmpdev->lun = make_lun(vbus->bus_num, i, 0);
+			tmpdev->b.blocksize = PAGE_CACHE_SIZE;
+			tmpdev->b.sectsize = 512;
+			tmpdev->disabled = 1;
+
+			tmpdev->kobj.parent = &vbus->kobj;
+			sprintf(tmpdev->kobj.name, "target%d", i);
+			tmpdev->kobj.ktype = &ktype_vscsi_target;
+			kobject_register(&tmpdev->kobj);
+
+			spin_lock_irqsave(&adapter->lock, flags);
+			if (vbus->vdev[i]) {
+				/* Race!!! */
+				spin_unlock_irqrestore(&adapter->lock, flags);
+				kobject_unregister(&tmpdev->kobj);
+				continue;
+			}
+
+			adapter->nvdevs++;
+			atomic_inc(&vbus->num_targets);
+			vbus->vdev[i] = tmpdev;
+			spin_unlock_irqrestore(&adapter->lock, flags);
+		}
+	} else { /* shrinking */
+		int i;
+		for (i = cur_num_targets - 1; i >= value; i--)
+		{
+			if (!vbus->vdev[i]->disabled) {
+				err("Can't remove active target %d\n", i);
+				return;
+			}
+
+			spin_lock_irqsave(&adapter->lock, flags);
+			tmpdev = vbus->vdev[i];
+			vbus->vdev[i] = NULL;
+			spin_unlock_irqrestore(&adapter->lock, flags);
+
+			if (tmpdev)
+				kobject_unregister(&tmpdev->kobj);
+
+			adapter->nvdevs--;
+			atomic_dec(&vbus->num_targets);
+		}
+	}
+}
+
+static void set_num_buses(struct device *dev, long value)
+{
+	struct server_adapter *adapter =
+				(struct server_adapter *)dev->driver_data;
+	int cur_num_buses = atomic_read(&adapter->num_buses);
+	unsigned long flags;
+	struct vbus *tmpbus;
+
+	if (cur_num_buses < value) { /* growing */
+		int i;
+		for (i = cur_num_buses; i < value; i++) {
+			tmpbus = (struct vbus *) kmalloc(sizeof(struct vbus),
+							 GFP_KERNEL);
+			if (!tmpbus) {
+				err("Couldn't allocate bus %d memory\n", i);
+				return;
+			}
+
+			memset(tmpbus, 0, sizeof(struct vbus));
+			tmpbus->bus_num = i;
+			tmpbus->kobj.parent = &dev->kobj;
+			sprintf(tmpbus->kobj.name, "bus%d", i);
+			tmpbus->kobj.ktype = &ktype_vscsi_bus;
+			kobject_register(&tmpbus->kobj);
+
+			spin_lock_irqsave(&adapter->lock, flags);
+
+			if (adapter->vbus[i] != NULL) {
+				/* Race condition! */
+				spin_unlock_irqrestore(&adapter->lock, flags);
+				kobject_unregister(&tmpbus->kobj);
+				continue;
+			}
+
+			adapter->vbus[i] = tmpbus;
+
+			atomic_inc(&adapter->num_buses);
+			spin_unlock_irqrestore(&adapter->lock, flags);
+
+			set_num_targets(adapter->vbus[i], 1);
+		}
+
+	} else if (cur_num_buses > value) { /* shrinking */
+		int i, j, active_target;
+		for (i = cur_num_buses - 1; i >= value; i--) {
+			active_target = -1;
+			for (j = 0; j < TARGETS_PER_BUS; j++) {
+				if (adapter->vbus[i]->vdev[j] &&
+				    !adapter->vbus[i]->vdev[j]->disabled) {
+					active_target = j;
+					break;
+				}
+			}
+			if (active_target != -1) {
+				err("Can't remove bus%d, target%d active\n",
+					i, active_target);
+				return ;
+			}
+
+			set_num_targets(adapter->vbus[i], 0);
+
+			spin_lock_irqsave(&adapter->lock, flags);
+			atomic_dec(&adapter->num_buses);
+			tmpbus = adapter->vbus[i];
+			adapter->vbus[i] = NULL;
+			spin_unlock_irqrestore(&adapter->lock, flags);
+
+			/* If we race this could already be NULL */
+			if (tmpbus)
+				kobject_unregister(&tmpbus->kobj);
+		}
+	}
+}
+
+/* Target sysfs stuff */
+static ATTR(target, device, 0644);
+static ATTR(target, active, 0644);
+static ATTR(target, ro, 0644);
+
+static ssize_t vscsi_target_show(struct kobject * kobj,
+				 struct attribute * attr, char * buf)
+{
+	struct vdev *vdev = container_of(kobj, struct vdev, kobj);
+	struct device *dev = container_of(kobj->parent->parent,
+					  struct device, kobj);
+	struct server_adapter *adapter =
+				(struct server_adapter *)dev->driver_data;
+	unsigned long flags;
+	ssize_t returned;
+
+	spin_lock_irqsave(&adapter->lock, flags);
+
+	if (attr == &vscsi_target_device_attr)
+		returned = sprintf(buf, "%s\n", vdev->device_name);
+	else if (attr == &vscsi_target_active_attr)
+		returned = sprintf(buf, "%d\n", !vdev->disabled);
+	else if (attr == &vscsi_target_ro_attr)
+		returned = sprintf(buf, "%d\n", vdev->b.ro);
+	else {
+		returned = -EFAULT;
+		BUG();
+	}
+
+	spin_unlock_irqrestore(&adapter->lock, flags);
+
+	return returned;
+}
+
+static ssize_t vscsi_target_store(struct kobject * kobj,
+				  struct attribute * attr,
+				  const char * buf, size_t count)
+{
+	struct vdev *vdev = container_of(kobj, struct vdev, kobj);
+	struct device *dev = container_of(kobj->parent->parent,
+					  struct device, kobj);
+	struct server_adapter *adapter =
+				(struct server_adapter *)dev->driver_data;
+	long flags;
+	long value = simple_strtol(buf, NULL, 10);
+
+	if (attr != &vscsi_target_active_attr && !vdev->disabled) {
+		err("Error: Can't modify properties while target is active.\n");
+		return -EPERM;
+	}
+
+	if (attr == &vscsi_target_device_attr) {
+		int i;
+		spin_lock_irqsave(&adapter->lock, flags);
+		i  = strlcpy(vdev->device_name, buf, TARGET_MAX_NAME_LEN);
+		for (; i >= 0; i--)
+			if (vdev->device_name[i] == '\n')
+				vdev->device_name[i] = '\0';
+		spin_unlock_irqrestore(&adapter->lock, flags);
+	} else if (attr == &vscsi_target_active_attr) {
+		if (value) {
+			int rc;
+			if (!vdev->disabled) {
+				warn("Warning: Target was already active\n");
+				return -EINVAL;
+			}
+			rc = activate_device(vdev);
+			if (rc) {
+				err("Error opening device=%d\n", rc);
+				return rc;
+			}
+		} else {
+			if (!vdev->disabled)
+				deactivate_device(vdev);
+		}
+	} else if (attr == &vscsi_target_ro_attr)
+		vdev->b.ro = value > 0 ? 1 : 0;
+	else
+		BUG();
+
+	return count;
+}
+
+static struct attribute * vscsi_target_attrs[] = {
+	&vscsi_target_device_attr,
+	&vscsi_target_active_attr,
+	&vscsi_target_ro_attr,
+	NULL,
+};
+
+static struct sysfs_ops vscsi_target_ops = {
+	.show	= vscsi_target_show,
+	.store	= vscsi_target_store,
+};
+
+static struct kobj_type ktype_vscsi_target = {
+	.release	= vscsi_target_release,
+	.sysfs_ops	= &vscsi_target_ops,
+	.default_attrs	= vscsi_target_attrs,
+};
+
+
+
+/* Bus sysfs stuff */
+static ssize_t vscsi_bus_show(struct kobject * kobj,
+			      struct attribute * attr, char * buf)
+{
+	struct vbus *vbus = container_of(kobj, struct vbus, kobj);
+	return sprintf(buf, "%d\n", atomic_read(&vbus->num_targets));
+}
+
+static ssize_t vscsi_bus_store(struct kobject * kobj, struct attribute * attr,
+const char * buf, size_t count)
+{
+	struct vbus *vbus = container_of(kobj, struct vbus, kobj);
+	long value = simple_strtol(buf, NULL, 10);
+
+	if (value < 0 || value > TARGETS_PER_BUS)
+		return -EINVAL;
+
+	set_num_targets(vbus, value);
+
+	return count;
+}
+
+
+static ATTR(bus, num_targets, 0644);
+
+static struct attribute * vscsi_bus_attrs[] = {
+	&vscsi_bus_num_targets_attr,
+	NULL,
+};
+
+static struct sysfs_ops vscsi_bus_ops = {
+	.show	= vscsi_bus_show,
+	.store	= vscsi_bus_store,
+};
+
+static struct kobj_type ktype_vscsi_bus = {
+	.release	= vscsi_bus_release,
+	.sysfs_ops	= &vscsi_bus_ops,
+	.default_attrs	= vscsi_bus_attrs,
+};
+
+
+/* Device attributes */
+static ssize_t vscsi_dev_bus_show(struct device * dev,
+				  struct device_attribute *attr,
+				  char * buf)
+{
+	struct server_adapter *adapter =
+				(struct server_adapter *)dev->driver_data;
+
+	return sprintf(buf, "%d\n", atomic_read(&adapter->num_buses));
+}
+
+static ssize_t vscsi_dev_sector_show(struct device * dev,
+				     struct device_attribute *attr,
+				     char * buf)
+{
+	struct server_adapter *adapter =
+				(struct server_adapter *)dev->driver_data;
+
+	return sprintf(buf, "%d\n", adapter->max_sectors);
+}
+
+static ssize_t vscsi_dev_bus_store(struct device * dev,
+				   struct device_attribute *attr,
+				   const char * buf, size_t count)
+{
+	long value = simple_strtol(buf, NULL, 10);
+
+	if (value < 0 || value > BUS_PER_ADAPTER)
+		return -EINVAL;
+
+	set_num_buses(dev, value);
+	return count;
+}
+
+static ssize_t vscsi_dev_sector_store(struct device * dev,
+				      struct device_attribute *attr,
+				      const char * buf, size_t count)
+{
+	long value = simple_strtol(buf, NULL, 10);
+	struct server_adapter *adapter =
+				(struct server_adapter *)dev->driver_data;
+
+	if (value <= 8 || value > SCSI_DEFAULT_MAX_SECTORS)
+		return -EINVAL;
+
+	adapter->max_sectors = value;
+
+	return count;
+}
+
+static ssize_t vscsi_dev_debug_store(struct device * dev,
+				     struct device_attribute *attr,
+				     const char * buf, size_t count)
+{
+	long value = simple_strtol(buf, NULL, 10);
+
+	ibmvscsis_debug = value;
+	return count;
+}
+
+static ssize_t vscsi_dev_debug_show(struct device * dev,
+				    struct device_attribute *attr,
+				    char * buf)
+{
+	return sprintf(buf, "%d\n", ibmvscsis_debug);
+}
+
+static DEVICE_ATTR(debug, 0644, vscsi_dev_debug_show, vscsi_dev_debug_store);
+static DEVICE_ATTR(num_buses, 0644, vscsi_dev_bus_show, vscsi_dev_bus_store);
+static DEVICE_ATTR(max_sectors, 0644, vscsi_dev_sector_show,
+		   vscsi_dev_sector_store);
+
+
+/* Stats kobj stuff */
+
+static ATTR(stats, interrupts, 0444);
+static ATTR(stats, read_ops, 0444);
+static ATTR(stats, write_ops, 0444);
+static ATTR(stats, crq_msgs, 0444);
+static ATTR(stats, iu_allocs, 0444);
+static ATTR(stats, bio_allocs, 0444);
+static ATTR(stats, buf_allocs, 0444);
+static ATTR(stats, errors, 0444);
+
+static struct attribute * vscsi_stats_attrs[] = {
+	&vscsi_stats_interrupts_attr,
+	&vscsi_stats_read_ops_attr,
+	&vscsi_stats_write_ops_attr,
+	&vscsi_stats_crq_msgs_attr,
+	&vscsi_stats_iu_allocs_attr,
+	&vscsi_stats_bio_allocs_attr,
+	&vscsi_stats_buf_allocs_attr,
+	&vscsi_stats_errors_attr,
+	NULL,
+};
+
+
+static ssize_t vscsi_stats_show(struct kobject * kobj,
+				struct attribute * attr, char * buf)
+{
+	struct server_adapter *adapter= container_of(kobj,
+						     struct server_adapter,
+						     stats_kobj);
+	if (attr == &vscsi_stats_interrupts_attr)
+		return sprintf(buf, "%d\n",
+		 atomic_read(&adapter->interrupts));
+	if (attr == &vscsi_stats_read_ops_attr)
+		return sprintf(buf, "%d\n",
+		 atomic_read(&adapter->read_processed));
+	if (attr == &vscsi_stats_write_ops_attr)
+		return sprintf(buf, "%d\n",
+		 atomic_read(&adapter->write_processed));
+	if (attr == &vscsi_stats_crq_msgs_attr)
+		return sprintf(buf, "%d\n",
+		 atomic_read(&adapter->crq_processed));
+	if (attr == &vscsi_stats_iu_allocs_attr)
+		return sprintf(buf, "%d\n",
+		 atomic_read(&adapter->iu_count));
+	if (attr == &vscsi_stats_bio_allocs_attr)
+		return sprintf(buf, "%d\n",
+		 atomic_read(&adapter->bio_count));
+	if (attr == &vscsi_stats_buf_allocs_attr)
+		return sprintf(buf, "%d\n",
+		 atomic_read(&adapter->buffers_allocated));
+	if (attr == &vscsi_stats_errors_attr)
+		return sprintf(buf, "%d\n",
+		 atomic_read(&adapter->errors));
+
+	BUG();
+	return 0;
+}
+
+static struct sysfs_ops vscsi_stats_ops = {
+	.show	= vscsi_stats_show,
+	.store	= NULL,
+};
+
+static struct kobj_type ktype_vscsi_stats = {
+	.release	= NULL,
+	.sysfs_ops	= &vscsi_stats_ops,
+	.default_attrs	= vscsi_stats_attrs,
+};
+
+
+/* ==============================================================
  * Module load and unload
  * ==============================================================
  */
@@ -3021,6 +3622,17 @@
 		return rc;
 	}
 
+	set_num_buses(&dev->dev, 1);
+	adapter->max_sectors = MAX_SECTORS;
+	device_create_file(&dev->dev, &dev_attr_debug);
+	device_create_file(&dev->dev, &dev_attr_num_buses);
+	device_create_file(&dev->dev, &dev_attr_max_sectors);
+
+	adapter->stats_kobj.parent = &dev->dev.kobj;
+	strcpy(adapter->stats_kobj.name, "stats");
+	adapter->stats_kobj.ktype = & ktype_vscsi_stats;
+	kobject_register(&adapter->stats_kobj);
+
 	return 0;
 }
 
@@ -3032,12 +3644,40 @@
 	struct server_adapter *adapter =
 	    (struct server_adapter *)dev->dev.driver_data;
 
+	spin_lock_irqsave(&adapter->lock, flags);
+
+	/*
+	 * Loop through the bus
+	 */
+	for (bus = 0; bus < BUS_PER_ADAPTER; bus++) {
+		/* If this bus exists */
+		if (adapter->vbus[bus]) {
+			/* loop through the targets */
+			for (target = 0; target < TARGETS_PER_BUS; target++) {
+				/* If the target exists */
+				struct vdev *vdev =
+					       adapter->vbus[bus]->vdev[target];
+				if (vdev && !vdev ->disabled)
+					deactivate_device(vdev);
+			}
+			spin_unlock_irqrestore(&adapter->lock, flags);
+			set_num_targets(adapter->vbus[bus], 0);
+			spin_lock_irqsave(&adapter->lock, flags);
+		}
+	}
+
+	spin_unlock_irqrestore(&adapter->lock, flags);
+	set_num_buses(adapter->dev, 0);
 	release_crq_queue(&adapter->queue, adapter);
 
 	release_iu_pool(adapter);
 
 	release_data_buffer(adapter);
 
+	kobject_unregister(&adapter->stats_kobj);
+	device_remove_file(&dev->dev, &dev_attr_debug);
+	device_remove_file(&dev->dev, &dev_attr_num_buses);
+	device_remove_file(&dev->dev, &dev_attr_max_sectors);
 
 	kfree(adapter);
 
@@ -3097,6 +3737,11 @@
 		return rc;
 	}
 
+	rc = scsi_register_interface(&vscsis_interface);
+
+	if (rc)
+		warn("rc %d from scsi_register_interface\n", rc);
+
 	return rc;
 }
 
@@ -3104,6 +3749,7 @@
 {
 	info("terminated\n");
 
+	scsi_unregister_interface(&vscsis_interface);
 	vio_unregister_driver(&ibmvscsis_driver);
 }
 
