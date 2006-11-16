Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424475AbWKPUwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424475AbWKPUwl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 15:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424490AbWKPUwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 15:52:41 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:42981 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1424475AbWKPUwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 15:52:38 -0500
Date: Thu, 16 Nov 2006 14:52:10 -0600
To: Greg KH <greg@kroah.com>, akpm@osdl.org, Alan Cox <alan@redhat.com>,
       "Ryan S. Arnold" <rsa@us.ibm.com>,
       Michael Ellerman <michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2]: HVCS char driver janitoring: move block of code.
Message-ID: <20061116205210.GB23600@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a non-urgent two-part janitorial patch.  I'm not sure who
the upstream maintainer is. This patch obsoletes yesterday's
patch titled: 

Subject: [PATCH]: HVCS char driver janitoring: fix compile warnings

--linas

This patch is one of two parts. The second part removes an pair 
of irritating compiler warnings. The first part moves a block
of code from the bottom of the file to the top, which is needed
to enable the cleanup.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: Ryan S. Arnold <rsa@us.ibm.com>

----
 drivers/char/hvcs.c |  353 ++++++++++++++++++++++++++--------------------------
 1 file changed, 177 insertions(+), 176 deletions(-)

Index: linux-2.6.19-rc4-git3/drivers/char/hvcs.c
===================================================================
--- linux-2.6.19-rc4-git3.orig/drivers/char/hvcs.c	2006-11-16 14:28:57.000000000 -0600
+++ linux-2.6.19-rc4-git3/drivers/char/hvcs.c	2006-11-16 14:32:38.000000000 -0600
@@ -353,6 +353,183 @@ static void __exit hvcs_module_exit(void
 #define HVCS_TRY_WRITE	0x00000004
 #define HVCS_READ_MASK	(HVCS_SCHED_READ | HVCS_QUICK_READ)
 
+static inline struct hvcs_struct *from_vio_dev(struct vio_dev *viod)
+{
+	return viod->dev.driver_data;
+}
+/* The sysfs interface for the driver and devices */
+
+static ssize_t hvcs_partner_vtys_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct vio_dev *viod = to_vio_dev(dev);
+	struct hvcs_struct *hvcsd = from_vio_dev(viod);
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+	retval = sprintf(buf, "%X\n", hvcsd->p_unit_address);
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	return retval;
+}
+static DEVICE_ATTR(partner_vtys, S_IRUGO, hvcs_partner_vtys_show, NULL);
+
+static ssize_t hvcs_partner_clcs_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct vio_dev *viod = to_vio_dev(dev);
+	struct hvcs_struct *hvcsd = from_vio_dev(viod);
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+	retval = sprintf(buf, "%s\n", &hvcsd->p_location_code[0]);
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	return retval;
+}
+static DEVICE_ATTR(partner_clcs, S_IRUGO, hvcs_partner_clcs_show, NULL);
+
+static ssize_t hvcs_current_vty_store(struct device *dev, struct device_attribute *attr, const char * buf,
+		size_t count)
+{
+	/*
+	 * Don't need this feature at the present time because firmware doesn't
+	 * yet support multiple partners.
+	 */
+	printk(KERN_INFO "HVCS: Denied current_vty change: -EPERM.\n");
+	return -EPERM;
+}
+
+static ssize_t hvcs_current_vty_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct vio_dev *viod = to_vio_dev(dev);
+	struct hvcs_struct *hvcsd = from_vio_dev(viod);
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+	retval = sprintf(buf, "%s\n", &hvcsd->p_location_code[0]);
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	return retval;
+}
+
+static DEVICE_ATTR(current_vty,
+	S_IRUGO | S_IWUSR, hvcs_current_vty_show, hvcs_current_vty_store);
+
+static ssize_t hvcs_vterm_state_store(struct device *dev, struct device_attribute *attr, const char *buf,
+		size_t count)
+{
+	struct vio_dev *viod = to_vio_dev(dev);
+	struct hvcs_struct *hvcsd = from_vio_dev(viod);
+	unsigned long flags;
+
+	/* writing a '0' to this sysfs entry will result in the disconnect. */
+	if (simple_strtol(buf, NULL, 0) != 0)
+		return -EINVAL;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+
+	if (hvcsd->open_count > 0) {
+		spin_unlock_irqrestore(&hvcsd->lock, flags);
+		printk(KERN_INFO "HVCS: vterm state unchanged.  "
+				"The hvcs device node is still in use.\n");
+		return -EPERM;
+	}
+
+	if (hvcsd->connected == 0) {
+		spin_unlock_irqrestore(&hvcsd->lock, flags);
+		printk(KERN_INFO "HVCS: vterm state unchanged. The"
+				" vty-server is not connected to a vty.\n");
+		return -EPERM;
+	}
+
+	hvcs_partner_free(hvcsd);
+	printk(KERN_INFO "HVCS: Closed vty-server@%X and"
+			" partner vty@%X:%d connection.\n",
+			hvcsd->vdev->unit_address,
+			hvcsd->p_unit_address,
+			(uint32_t)hvcsd->p_partition_ID);
+
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	return count;
+}
+
+static ssize_t hvcs_vterm_state_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct vio_dev *viod = to_vio_dev(dev);
+	struct hvcs_struct *hvcsd = from_vio_dev(viod);
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+	retval = sprintf(buf, "%d\n", hvcsd->connected);
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	return retval;
+}
+static DEVICE_ATTR(vterm_state, S_IRUGO | S_IWUSR,
+		hvcs_vterm_state_show, hvcs_vterm_state_store);
+
+static ssize_t hvcs_index_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct vio_dev *viod = to_vio_dev(dev);
+	struct hvcs_struct *hvcsd = from_vio_dev(viod);
+	unsigned long flags;
+	int retval;
+
+	spin_lock_irqsave(&hvcsd->lock, flags);
+	retval = sprintf(buf, "%d\n", hvcsd->index);
+	spin_unlock_irqrestore(&hvcsd->lock, flags);
+	return retval;
+}
+
+static DEVICE_ATTR(index, S_IRUGO, hvcs_index_show, NULL);
+
+static struct attribute *hvcs_attrs[] = {
+	&dev_attr_partner_vtys.attr,
+	&dev_attr_partner_clcs.attr,
+	&dev_attr_current_vty.attr,
+	&dev_attr_vterm_state.attr,
+	&dev_attr_index.attr,
+	NULL,
+};
+
+static struct attribute_group hvcs_attr_group = {
+	.attrs = hvcs_attrs,
+};
+
+static void hvcs_create_device_attrs(struct hvcs_struct *hvcsd)
+{
+	struct vio_dev *vdev = hvcsd->vdev;
+	sysfs_create_group(&vdev->dev.kobj, &hvcs_attr_group);
+}
+
+static void hvcs_remove_device_attrs(struct vio_dev *vdev)
+{
+	sysfs_remove_group(&vdev->dev.kobj, &hvcs_attr_group);
+}
+
+static ssize_t hvcs_rescan_show(struct device_driver *ddp, char *buf)
+{
+	/* A 1 means it is updating, a 0 means it is done updating */
+	return snprintf(buf, PAGE_SIZE, "%d\n", hvcs_rescan_status);
+}
+
+static ssize_t hvcs_rescan_store(struct device_driver *ddp, const char * buf,
+		size_t count)
+{
+	if ((simple_strtol(buf, NULL, 0) != 1)
+		&& (hvcs_rescan_status != 0))
+		return -EINVAL;
+
+	hvcs_rescan_status = 1;
+	printk(KERN_INFO "HVCS: rescanning partner info for all"
+		" vty-servers.\n");
+	hvcs_rescan_devices_list();
+	hvcs_rescan_status = 0;
+	return count;
+}
+
+static DRIVER_ATTR(rescan,
+	S_IRUGO | S_IWUSR, hvcs_rescan_show, hvcs_rescan_store);
+
 static void hvcs_kick(void)
 {
 	hvcs_kicked = 1;
@@ -1457,182 +1634,6 @@ static void __exit hvcs_module_exit(void
 module_init(hvcs_module_init);
 module_exit(hvcs_module_exit);
 
-static inline struct hvcs_struct *from_vio_dev(struct vio_dev *viod)
-{
-	return viod->dev.driver_data;
-}
-/* The sysfs interface for the driver and devices */
-
-static ssize_t hvcs_partner_vtys_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct vio_dev *viod = to_vio_dev(dev);
-	struct hvcs_struct *hvcsd = from_vio_dev(viod);
-	unsigned long flags;
-	int retval;
-
-	spin_lock_irqsave(&hvcsd->lock, flags);
-	retval = sprintf(buf, "%X\n", hvcsd->p_unit_address);
-	spin_unlock_irqrestore(&hvcsd->lock, flags);
-	return retval;
-}
-static DEVICE_ATTR(partner_vtys, S_IRUGO, hvcs_partner_vtys_show, NULL);
-
-static ssize_t hvcs_partner_clcs_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct vio_dev *viod = to_vio_dev(dev);
-	struct hvcs_struct *hvcsd = from_vio_dev(viod);
-	unsigned long flags;
-	int retval;
-
-	spin_lock_irqsave(&hvcsd->lock, flags);
-	retval = sprintf(buf, "%s\n", &hvcsd->p_location_code[0]);
-	spin_unlock_irqrestore(&hvcsd->lock, flags);
-	return retval;
-}
-static DEVICE_ATTR(partner_clcs, S_IRUGO, hvcs_partner_clcs_show, NULL);
-
-static ssize_t hvcs_current_vty_store(struct device *dev, struct device_attribute *attr, const char * buf,
-		size_t count)
-{
-	/*
-	 * Don't need this feature at the present time because firmware doesn't
-	 * yet support multiple partners.
-	 */
-	printk(KERN_INFO "HVCS: Denied current_vty change: -EPERM.\n");
-	return -EPERM;
-}
-
-static ssize_t hvcs_current_vty_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct vio_dev *viod = to_vio_dev(dev);
-	struct hvcs_struct *hvcsd = from_vio_dev(viod);
-	unsigned long flags;
-	int retval;
-
-	spin_lock_irqsave(&hvcsd->lock, flags);
-	retval = sprintf(buf, "%s\n", &hvcsd->p_location_code[0]);
-	spin_unlock_irqrestore(&hvcsd->lock, flags);
-	return retval;
-}
-
-static DEVICE_ATTR(current_vty,
-	S_IRUGO | S_IWUSR, hvcs_current_vty_show, hvcs_current_vty_store);
-
-static ssize_t hvcs_vterm_state_store(struct device *dev, struct device_attribute *attr, const char *buf,
-		size_t count)
-{
-	struct vio_dev *viod = to_vio_dev(dev);
-	struct hvcs_struct *hvcsd = from_vio_dev(viod);
-	unsigned long flags;
-
-	/* writing a '0' to this sysfs entry will result in the disconnect. */
-	if (simple_strtol(buf, NULL, 0) != 0)
-		return -EINVAL;
-
-	spin_lock_irqsave(&hvcsd->lock, flags);
-
-	if (hvcsd->open_count > 0) {
-		spin_unlock_irqrestore(&hvcsd->lock, flags);
-		printk(KERN_INFO "HVCS: vterm state unchanged.  "
-				"The hvcs device node is still in use.\n");
-		return -EPERM;
-	}
-
-	if (hvcsd->connected == 0) {
-		spin_unlock_irqrestore(&hvcsd->lock, flags);
-		printk(KERN_INFO "HVCS: vterm state unchanged. The"
-				" vty-server is not connected to a vty.\n");
-		return -EPERM;
-	}
-
-	hvcs_partner_free(hvcsd);
-	printk(KERN_INFO "HVCS: Closed vty-server@%X and"
-			" partner vty@%X:%d connection.\n",
-			hvcsd->vdev->unit_address,
-			hvcsd->p_unit_address,
-			(uint32_t)hvcsd->p_partition_ID);
-
-	spin_unlock_irqrestore(&hvcsd->lock, flags);
-	return count;
-}
-
-static ssize_t hvcs_vterm_state_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct vio_dev *viod = to_vio_dev(dev);
-	struct hvcs_struct *hvcsd = from_vio_dev(viod);
-	unsigned long flags;
-	int retval;
-
-	spin_lock_irqsave(&hvcsd->lock, flags);
-	retval = sprintf(buf, "%d\n", hvcsd->connected);
-	spin_unlock_irqrestore(&hvcsd->lock, flags);
-	return retval;
-}
-static DEVICE_ATTR(vterm_state, S_IRUGO | S_IWUSR,
-		hvcs_vterm_state_show, hvcs_vterm_state_store);
-
-static ssize_t hvcs_index_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct vio_dev *viod = to_vio_dev(dev);
-	struct hvcs_struct *hvcsd = from_vio_dev(viod);
-	unsigned long flags;
-	int retval;
-
-	spin_lock_irqsave(&hvcsd->lock, flags);
-	retval = sprintf(buf, "%d\n", hvcsd->index);
-	spin_unlock_irqrestore(&hvcsd->lock, flags);
-	return retval;
-}
-
-static DEVICE_ATTR(index, S_IRUGO, hvcs_index_show, NULL);
-
-static struct attribute *hvcs_attrs[] = {
-	&dev_attr_partner_vtys.attr,
-	&dev_attr_partner_clcs.attr,
-	&dev_attr_current_vty.attr,
-	&dev_attr_vterm_state.attr,
-	&dev_attr_index.attr,
-	NULL,
-};
-
-static struct attribute_group hvcs_attr_group = {
-	.attrs = hvcs_attrs,
-};
-
-static void hvcs_create_device_attrs(struct hvcs_struct *hvcsd)
-{
-	struct vio_dev *vdev = hvcsd->vdev;
-	sysfs_create_group(&vdev->dev.kobj, &hvcs_attr_group);
-}
-
-static void hvcs_remove_device_attrs(struct vio_dev *vdev)
-{
-	sysfs_remove_group(&vdev->dev.kobj, &hvcs_attr_group);
-}
-
-static ssize_t hvcs_rescan_show(struct device_driver *ddp, char *buf)
-{
-	/* A 1 means it is updating, a 0 means it is done updating */
-	return snprintf(buf, PAGE_SIZE, "%d\n", hvcs_rescan_status);
-}
-
-static ssize_t hvcs_rescan_store(struct device_driver *ddp, const char * buf,
-		size_t count)
-{
-	if ((simple_strtol(buf, NULL, 0) != 1)
-		&& (hvcs_rescan_status != 0))
-		return -EINVAL;
-
-	hvcs_rescan_status = 1;
-	printk(KERN_INFO "HVCS: rescanning partner info for all"
-		" vty-servers.\n");
-	hvcs_rescan_devices_list();
-	hvcs_rescan_status = 0;
-	return count;
-}
-static DRIVER_ATTR(rescan,
-	S_IRUGO | S_IWUSR, hvcs_rescan_show, hvcs_rescan_store);
-
 static void hvcs_create_driver_attrs(void)
 {
 	struct device_driver *driverfs = &(hvcs_vio_driver.driver);
