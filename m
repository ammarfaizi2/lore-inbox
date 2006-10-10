Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWJJTTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWJJTTh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 15:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbWJJTTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 15:19:36 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:8898 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1030217AbWJJTTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 15:19:35 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Tue, 10 Oct 2006 21:19:21 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.19-rc1 3/3] ieee1394: handle sysfs errors
To: linux1394-devel@lists.sourceforge.net
cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.1904a2df7d282ffa@s5r6.in-berlin.de>
Message-ID: <tkrat.e44d79b8aa1375e5@s5r6.in-berlin.de>
References: <20061010064805.GA21310@havoc.gtf.org>
 <452B5BEE.4050407@s5r6.in-berlin.de> <452B979C.9030001@garzik.org>
 <tkrat.f3f45c410340f9b2@s5r6.in-berlin.de>
 <tkrat.1904a2df7d282ffa@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Handle driver core errors with as much care as appropriate.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---

Supersedes patch "firewire: handle sysfs errors" by Jeff Garzik,
posted on from 2006-10-10.

 drivers/ieee1394/hosts.c   |   18 ++--
 drivers/ieee1394/nodemgr.c |  149 ++++++++++++++++++++++++++-----------
 2 files changed, 118 insertions(+), 49 deletions(-)

Index: linux-2.6.19-rc1/drivers/ieee1394/hosts.c
===================================================================
--- linux-2.6.19-rc1.orig/drivers/ieee1394/hosts.c	2006-10-10 19:33:51.000000000 +0200
+++ linux-2.6.19-rc1/drivers/ieee1394/hosts.c	2006-10-10 21:16:11.000000000 +0200
@@ -130,10 +130,8 @@ struct hpsb_host *hpsb_alloc_host(struct
 		return NULL;
 
 	h->csr.rom = csr1212_create_csr(&csr_bus_ops, CSR_BUS_INFO_SIZE, h);
-	if (!h->csr.rom) {
-		kfree(h);
-		return NULL;
-	}
+	if (!h->csr.rom)
+		goto fail;
 
 	h->hostdata = h + 1;
 	h->driver = drv;
@@ -172,11 +170,19 @@ struct hpsb_host *hpsb_alloc_host(struct
 	h->class_dev.class = &hpsb_host_class;
 	snprintf(h->class_dev.class_id, BUS_ID_SIZE, "fw-host%d", h->id);
 
-	device_register(&h->device);
-	class_device_register(&h->class_dev);
+	if (device_register(&h->device))
+		goto fail;
+	if (class_device_register(&h->class_dev)) {
+		device_unregister(&h->device);
+		goto fail;
+	}
 	get_device(&h->device);
 
 	return h;
+
+fail:
+	kfree(h);
+	return NULL;
 }
 
 int hpsb_add_host(struct hpsb_host *host)
Index: linux-2.6.19-rc1/drivers/ieee1394/nodemgr.c
===================================================================
--- linux-2.6.19-rc1.orig/drivers/ieee1394/nodemgr.c	2006-10-10 19:05:51.000000000 +0200
+++ linux-2.6.19-rc1/drivers/ieee1394/nodemgr.c	2006-10-10 21:02:51.000000000 +0200
@@ -412,11 +412,14 @@ static ssize_t fw_get_destroy_node(struc
 static BUS_ATTR(destroy_node, S_IWUSR | S_IRUGO, fw_get_destroy_node, fw_set_destroy_node);
 
 
-static ssize_t fw_set_rescan(struct bus_type *bus, const char *buf, size_t count)
+static ssize_t fw_set_rescan(struct bus_type *bus, const char *buf,
+			     size_t count)
 {
+	int error = 0;
+
 	if (simple_strtoul(buf, NULL, 10) == 1)
-		bus_rescan_devices(&ieee1394_bus_type);
-	return count;
+		error = bus_rescan_devices(&ieee1394_bus_type);
+	return error ? error : count;
 }
 static ssize_t fw_get_rescan(struct bus_type *bus, char *buf)
 {
@@ -582,7 +585,11 @@ static void nodemgr_create_drv_files(str
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(fw_drv_attrs); i++)
-		driver_create_file(drv, fw_drv_attrs[i]);
+		if (driver_create_file(drv, fw_drv_attrs[i]))
+			goto fail;
+	return;
+fail:
+	HPSB_ERR("Failed to add sysfs attribute for driver %s", driver->name);
 }
 
 
@@ -602,7 +609,12 @@ static void nodemgr_create_ne_dev_files(
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(fw_ne_attrs); i++)
-		device_create_file(dev, fw_ne_attrs[i]);
+		if (device_create_file(dev, fw_ne_attrs[i]))
+			goto fail;
+	return;
+fail:
+	HPSB_ERR("Failed to add sysfs attribute for node %016Lx",
+		 (unsigned long long)ne->guid);
 }
 
 
@@ -612,11 +624,16 @@ static void nodemgr_create_host_dev_file
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(fw_host_attrs); i++)
-		device_create_file(dev, fw_host_attrs[i]);
+		if (device_create_file(dev, fw_host_attrs[i]))
+			goto fail;
+	return;
+fail:
+	HPSB_ERR("Failed to add sysfs attribute for host %d", host->id);
 }
 
 
-static struct node_entry *find_entry_by_nodeid(struct hpsb_host *host, nodeid_t nodeid);
+static struct node_entry *find_entry_by_nodeid(struct hpsb_host *host,
+					       nodeid_t nodeid);
 
 static void nodemgr_update_host_dev_links(struct hpsb_host *host)
 {
@@ -627,12 +644,18 @@ static void nodemgr_update_host_dev_link
 	sysfs_remove_link(&dev->kobj, "busmgr_id");
 	sysfs_remove_link(&dev->kobj, "host_id");
 
-	if ((ne = find_entry_by_nodeid(host, host->irm_id)))
-		sysfs_create_link(&dev->kobj, &ne->device.kobj, "irm_id");
-	if ((ne = find_entry_by_nodeid(host, host->busmgr_id)))
-		sysfs_create_link(&dev->kobj, &ne->device.kobj, "busmgr_id");
-	if ((ne = find_entry_by_nodeid(host, host->node_id)))
-		sysfs_create_link(&dev->kobj, &ne->device.kobj, "host_id");
+	if ((ne = find_entry_by_nodeid(host, host->irm_id)) &&
+	    sysfs_create_link(&dev->kobj, &ne->device.kobj, "irm_id"))
+		goto fail;
+	if ((ne = find_entry_by_nodeid(host, host->busmgr_id)) &&
+	    sysfs_create_link(&dev->kobj, &ne->device.kobj, "busmgr_id"))
+		goto fail;
+	if ((ne = find_entry_by_nodeid(host, host->node_id)) &&
+	    sysfs_create_link(&dev->kobj, &ne->device.kobj, "host_id"))
+		goto fail;
+	return;
+fail:
+	HPSB_ERR("Failed to update sysfs attributes for host %d", host->id);
 }
 
 static void nodemgr_create_ud_dev_files(struct unit_directory *ud)
@@ -641,25 +664,32 @@ static void nodemgr_create_ud_dev_files(
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(fw_ud_attrs); i++)
-		device_create_file(dev, fw_ud_attrs[i]);
-
+		if (device_create_file(dev, fw_ud_attrs[i]))
+			goto fail;
 	if (ud->flags & UNIT_DIRECTORY_SPECIFIER_ID)
-		device_create_file(dev, &dev_attr_ud_specifier_id);
-
+		if (device_create_file(dev, &dev_attr_ud_specifier_id))
+			goto fail;
 	if (ud->flags & UNIT_DIRECTORY_VERSION)
-		device_create_file(dev, &dev_attr_ud_version);
-
+		if (device_create_file(dev, &dev_attr_ud_version))
+			goto fail;
 	if (ud->flags & UNIT_DIRECTORY_VENDOR_ID) {
-		device_create_file(dev, &dev_attr_ud_vendor_id);
-		if (ud->vendor_name_kv)
-			device_create_file(dev, &dev_attr_ud_vendor_name_kv);
+		if (device_create_file(dev, &dev_attr_ud_vendor_id))
+			goto fail;
+		if (ud->vendor_name_kv &&
+		    device_create_file(dev, &dev_attr_ud_vendor_name_kv))
+			goto fail;
 	}
-
 	if (ud->flags & UNIT_DIRECTORY_MODEL_ID) {
-		device_create_file(dev, &dev_attr_ud_model_id);
-		if (ud->model_name_kv)
-			device_create_file(dev, &dev_attr_ud_model_name_kv);
+		if (device_create_file(dev, &dev_attr_ud_model_id))
+			goto fail;
+		if (ud->model_name_kv &&
+		    device_create_file(dev, &dev_attr_ud_model_name_kv))
+			goto fail;
 	}
+	return;
+fail:
+	HPSB_ERR("Failed to add sysfs attributes for unit %s",
+		 ud->device.bus_id);
 }
 
 
@@ -747,7 +777,7 @@ static int __nodemgr_remove_host_dev(str
 
 static void nodemgr_remove_host_dev(struct device *dev)
 {
-	device_for_each_child(dev, NULL, __nodemgr_remove_host_dev);
+	WARN_ON(device_for_each_child(dev, NULL, __nodemgr_remove_host_dev));
 	sysfs_remove_link(&dev->kobj, "irm_id");
 	sysfs_remove_link(&dev->kobj, "busmgr_id");
 	sysfs_remove_link(&dev->kobj, "host_id");
@@ -791,7 +821,7 @@ static struct node_entry *nodemgr_create
 
 	ne = kzalloc(sizeof(*ne), GFP_KERNEL);
 	if (!ne)
-		return NULL;
+		goto fail_alloc;
 
 	ne->host = host;
 	ne->nodeid = nodeid;
@@ -814,12 +844,15 @@ static struct node_entry *nodemgr_create
 	snprintf(ne->class_dev.class_id, BUS_ID_SIZE, "%016Lx",
 		 (unsigned long long)(ne->guid));
 
-	device_register(&ne->device);
-	class_device_register(&ne->class_dev);
+	if (device_register(&ne->device))
+		goto fail_devreg;
+	if (class_device_register(&ne->class_dev))
+		goto fail_classdevreg;
 	get_device(&ne->device);
 
-	if (ne->guid_vendor_oui)
-		device_create_file(&ne->device, &dev_attr_ne_guid_vendor_oui);
+	if (ne->guid_vendor_oui &&
+	    device_create_file(&ne->device, &dev_attr_ne_guid_vendor_oui))
+		goto fail_addoiu;
 	nodemgr_create_ne_dev_files(ne);
 
 	nodemgr_update_bus_options(ne);
@@ -829,6 +862,18 @@ static struct node_entry *nodemgr_create
 		   NODE_BUS_ARGS(host, nodeid), (unsigned long long)guid);
 
 	return ne;
+
+fail_addoiu:
+	put_device(&ne->device);
+fail_classdevreg:
+	device_unregister(&ne->device);
+fail_devreg:
+	kfree(ne);
+fail_alloc:
+	HPSB_ERR("Failed to create node ID:BUS[" NODE_BUS_FMT "]  GUID[%016Lx]",
+		 NODE_BUS_ARGS(host, nodeid), (unsigned long long)guid);
+
+	return NULL;
 }
 
 
@@ -890,13 +935,25 @@ static void nodemgr_register_device(stru
 	snprintf(ud->class_dev.class_id, BUS_ID_SIZE, "%s-%u",
 		 ne->device.bus_id, ud->id);
 
-	device_register(&ud->device);
-	class_device_register(&ud->class_dev);
+	if (device_register(&ud->device))
+		goto fail_devreg;
+	if (class_device_register(&ud->class_dev))
+		goto fail_classdevreg;
 	get_device(&ud->device);
 
-	if (ud->vendor_oui)
-		device_create_file(&ud->device, &dev_attr_ud_vendor_oui);
+	if (ud->vendor_oui &&
+	    device_create_file(&ud->device, &dev_attr_ud_vendor_oui))
+		goto fail_addoui;
 	nodemgr_create_ud_dev_files(ud);
+
+	return;
+
+fail_addoui:
+	put_device(&ud->device);
+fail_classdevreg:
+	device_unregister(&ud->device);
+fail_devreg:
+	HPSB_ERR("Failed to create unit %s", ud->device.bus_id);
 }	
 
 
@@ -1093,10 +1150,16 @@ static void nodemgr_process_root_directo
 		last_key_id = kv->key.id;
 	}
 
-	if (ne->vendor_oui)
-		device_create_file(&ne->device, &dev_attr_ne_vendor_oui);
-	if (ne->vendor_name_kv)
-		device_create_file(&ne->device, &dev_attr_ne_vendor_name_kv);
+	if (ne->vendor_oui &&
+	    device_create_file(&ne->device, &dev_attr_ne_vendor_oui))
+		goto fail;
+	if (ne->vendor_name_kv &&
+	    device_create_file(&ne->device, &dev_attr_ne_vendor_name_kv))
+		goto fail;
+	return;
+fail:
+	HPSB_ERR("Failed to add sysfs attribute for node %016Lx",
+		 (unsigned long long)ne->guid);
 }
 
 #ifdef CONFIG_HOTPLUG
@@ -1169,7 +1232,7 @@ int hpsb_register_protocol(struct hpsb_p
 	if (!ret)
 		nodemgr_create_drv_files(driver);
 
-	return ret;
+	return 0;
 }
 
 void hpsb_unregister_protocol(struct hpsb_protocol_driver *driver)
@@ -1326,7 +1389,7 @@ static void nodemgr_suspend_ne(struct no
 		   NODE_BUS_ARGS(ne->host, ne->nodeid), (unsigned long long)ne->guid);
 
 	ne->in_limbo = 1;
-	device_create_file(&ne->device, &dev_attr_ne_in_limbo);
+	WARN_ON(device_create_file(&ne->device, &dev_attr_ne_in_limbo));
 
 	down_write(&ne->device.bus->subsys.rwsem);
 	list_for_each_entry(cdev, &nodemgr_ud_class.children, node) {
@@ -1497,7 +1560,7 @@ static void nodemgr_node_probe(struct ho
 	 * just removed.  */
 
 	if (generation == get_hpsb_generation(host))
-		bus_rescan_devices(&ieee1394_bus_type);
+		WARN_ON(bus_rescan_devices(&ieee1394_bus_type));
 
 	return;
 }


