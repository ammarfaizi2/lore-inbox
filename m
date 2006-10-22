Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWJVOQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWJVOQx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 10:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbWJVOQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 10:16:53 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:60894 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750856AbWJVOQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 10:16:52 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 22 Oct 2006 16:16:27 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [rfc patch] ieee1394: nodemgr: revise semaphore protection of driver
 core data
To: Ben Collins <bcollins@ubuntu.com>, Greg KH <gregkh@suse.de>
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>
Message-ID: <tkrat.2407a13c0fa37837@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - The list "struct class.children" is supposed to be protected by
   class.sem, not by class.subsys.rwsem.

 - nodemgr_remove_uds() iterated over nodemgr_ud_class.children without
   proper protection.  This was never observed as a bug since the code
   is usually only accessed by knodemgrd.  All knodemgrds are currently
   globally serialized.  But userspace can trigger this code too by
   writing to /sys/bus/ieee1394/destroy_node.

 - Clean up access to the FireWire bus type's subsys.rwsem:  Access it
   uniformly via ieee1394_bus_type.  Shrink rwsem protected regions
   where possible.  Expand them where necessary.  The latter wasn't a
   problem so far because knodemgr is globally serialized.

This should harden the interaction of ieee1394 with sysfs and lay ground
for deserialized operation of multiple knodemgrds and for implementation
of subthreads for parallelized scanning and probing.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---

This may or may not be related to
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=188140
(System freezes while hald is accessing FireWire sysfs data.)

I wonder if some of nodemgr's fw_show_/ fw_get_/ fw_set_/ functions to
read and write sysfs attributes need protection by the subsys.rwsem too.
At least fw_set_destroy_node() did but should be properly protected now.
But that one is of course never accessed by hald.


 drivers/ieee1394/nodemgr.c |  142 +++++++++++++++++++++++--------------
 1 files changed, 92 insertions(+), 50 deletions(-)

Patch is on top of latest 1394 stuff plus two unrelated nodemgr patches
from yesterday.  Dave, do you want me to rebase this on 2.6.18 for
testby the bug reporter?  This will require some of
http://me.in-berlin.de/~s5r6/linux1394/updates/2.6.18/patches/

Index: linux-2.6.19-rc2-extra/drivers/ieee1394/nodemgr.c
===================================================================
--- linux-2.6.19-rc2-extra.orig/drivers/ieee1394/nodemgr.c	2006-10-22 10:44:59.000000000 +0200
+++ linux-2.6.19-rc2-extra/drivers/ieee1394/nodemgr.c	2006-10-22 12:38:23.000000000 +0200
@@ -373,11 +373,11 @@ static ssize_t fw_set_ignore_driver(stru
 	int state = simple_strtoul(buf, NULL, 10);
 
 	if (state == 1) {
-		down_write(&dev->bus->subsys.rwsem);
-		device_release_driver(dev);
 		ud->ignore_driver = 1;
-		up_write(&dev->bus->subsys.rwsem);
-	} else if (!state)
+		down_write(&ieee1394_bus_type.subsys.rwsem);
+		device_release_driver(dev);
+		up_write(&ieee1394_bus_type.subsys.rwsem);
+	} else if (state == 0)
 		ud->ignore_driver = 0;
 
 	return count;
@@ -435,7 +435,7 @@ static ssize_t fw_set_ignore_drivers(str
 
 	if (state == 1)
 		ignore_drivers = 1;
-	else if (!state)
+	else if (state == 0)
 		ignore_drivers = 0;
 
 	return count;
@@ -733,20 +733,65 @@ static int nodemgr_bus_match(struct devi
 }
 
 
+static DEFINE_MUTEX(nodemgr_serialize_remove_uds);
+
 static void nodemgr_remove_uds(struct node_entry *ne)
 {
-	struct class_device *cdev, *next;
-	struct unit_directory *ud;
+	struct class_device *cdev;
+	struct unit_directory *ud, **unreg;
+	size_t i, count;
 
-	list_for_each_entry_safe(cdev, next, &nodemgr_ud_class.children, node) {
-		ud = container_of(cdev, struct unit_directory, class_dev);
+	/*
+	 * This is awkward:
+	 * Iteration over nodemgr_ud_class.children has to be protected by
+	 * nodemgr_ud_class.sem, but class_device_unregister() will eventually
+	 * take nodemgr_ud_class.sem too. Therefore store all uds to be
+	 * unregistered in a temporary array, release the semaphore, and then
+	 * unregister the uds.
+	 *
+	 * Since nodemgr_remove_uds can also run in other contexts than the
+	 * knodemgrds (which are currently globally serialized), protect the
+	 * gap after release of the semaphore by nodemgr_serialize_remove_uds.
+	 */
 
-		if (ud->ne != ne)
-			continue;
+	mutex_lock(&nodemgr_serialize_remove_uds);
+
+	down(&nodemgr_ud_class.sem);
+	count = 0;
+	list_for_each_entry(cdev, &nodemgr_ud_class.children, node) {
+		ud = container_of(cdev, struct unit_directory, class_dev);
+		if (ud->ne == ne)
+			count++;
+	}
+	if (!count) {
+		up(&nodemgr_ud_class.sem);
+		mutex_unlock(&nodemgr_serialize_remove_uds);
+		return;
+	}
+	unreg = kcalloc(count, sizeof(*unreg), GFP_KERNEL);
+	if (!unreg) {
+		HPSB_ERR("NodeMgr: out of memory in nodemgr_remove_uds");
+		up(&nodemgr_ud_class.sem);
+		mutex_unlock(&nodemgr_serialize_remove_uds);
+		return;
+	}
+	i = 0;
+	list_for_each_entry(cdev, &nodemgr_ud_class.children, node) {
+		ud = container_of(cdev, struct unit_directory, class_dev);
+		if (ud->ne == ne) {
+			BUG_ON(i >= count);
+			unreg[i++] = ud;
+		}
+	}
+	up(&nodemgr_ud_class.sem);
 
-		class_device_unregister(&ud->class_dev);
-		device_unregister(&ud->device);
+	for (i = 0; i < count; i++) {
+		class_device_unregister(&unreg[i]->class_dev);
+		device_unregister(&unreg[i]->device);
 	}
+	kfree(unreg);
+
+	mutex_unlock(&nodemgr_serialize_remove_uds);
 }
 
 
@@ -879,12 +924,11 @@ fail_alloc:
 
 static struct node_entry *find_entry_by_guid(u64 guid)
 {
-	struct class *class = &nodemgr_ne_class;
 	struct class_device *cdev;
 	struct node_entry *ne, *ret_ne = NULL;
 
-	down_read(&class->subsys.rwsem);
-	list_for_each_entry(cdev, &class->children, node) {
+	down(&nodemgr_ne_class.sem);
+	list_for_each_entry(cdev, &nodemgr_ne_class.children, node) {
 		ne = container_of(cdev, struct node_entry, class_dev);
 
 		if (ne->guid == guid) {
@@ -892,20 +936,20 @@ static struct node_entry *find_entry_by_
 			break;
 		}
 	}
-	up_read(&class->subsys.rwsem);
+	up(&nodemgr_ne_class.sem);
 
         return ret_ne;
 }
 
 
-static struct node_entry *find_entry_by_nodeid(struct hpsb_host *host, nodeid_t nodeid)
+static struct node_entry *find_entry_by_nodeid(struct hpsb_host *host,
+					       nodeid_t nodeid)
 {
-	struct class *class = &nodemgr_ne_class;
 	struct class_device *cdev;
 	struct node_entry *ne, *ret_ne = NULL;
 
-	down_read(&class->subsys.rwsem);
-	list_for_each_entry(cdev, &class->children, node) {
+	down(&nodemgr_ne_class.sem);
+	list_for_each_entry(cdev, &nodemgr_ne_class.children, node) {
 		ne = container_of(cdev, struct node_entry, class_dev);
 
 		if (ne->host == host && ne->nodeid == nodeid) {
@@ -913,7 +957,7 @@ static struct node_entry *find_entry_by_
 			break;
 		}
 	}
-	up_read(&class->subsys.rwsem);
+	up(&nodemgr_ne_class.sem);
 
 	return ret_ne;
 }
@@ -1376,7 +1420,6 @@ static void nodemgr_node_scan(struct hos
 }
 
 
-/* Caller needs to hold nodemgr_ud_class.subsys.rwsem as reader. */
 static void nodemgr_suspend_ne(struct node_entry *ne)
 {
 	struct class_device *cdev;
@@ -1388,19 +1431,20 @@ static void nodemgr_suspend_ne(struct no
 	ne->in_limbo = 1;
 	WARN_ON(device_create_file(&ne->device, &dev_attr_ne_in_limbo));
 
-	down_write(&ne->device.bus->subsys.rwsem);
+	down(&nodemgr_ud_class.sem);
 	list_for_each_entry(cdev, &nodemgr_ud_class.children, node) {
 		ud = container_of(cdev, struct unit_directory, class_dev);
-
 		if (ud->ne != ne)
 			continue;
 
+		down_write(&ieee1394_bus_type.subsys.rwsem);
 		if (ud->device.driver &&
 		    (!ud->device.driver->suspend ||
 		      ud->device.driver->suspend(&ud->device, PMSG_SUSPEND)))
 			device_release_driver(&ud->device);
+		up_write(&ieee1394_bus_type.subsys.rwsem);
 	}
-	up_write(&ne->device.bus->subsys.rwsem);
+	up(&nodemgr_ud_class.sem);
 }
 
 
@@ -1412,45 +1456,47 @@ static void nodemgr_resume_ne(struct nod
 	ne->in_limbo = 0;
 	device_remove_file(&ne->device, &dev_attr_ne_in_limbo);
 
-	down_read(&nodemgr_ud_class.subsys.rwsem);
-	down_read(&ne->device.bus->subsys.rwsem);
+	down(&nodemgr_ud_class.sem);
 	list_for_each_entry(cdev, &nodemgr_ud_class.children, node) {
 		ud = container_of(cdev, struct unit_directory, class_dev);
-
 		if (ud->ne != ne)
 			continue;
 
+		down_read(&ieee1394_bus_type.subsys.rwsem);
 		if (ud->device.driver && ud->device.driver->resume)
 			ud->device.driver->resume(&ud->device);
+		up_read(&ieee1394_bus_type.subsys.rwsem);
 	}
-	up_read(&ne->device.bus->subsys.rwsem);
-	up_read(&nodemgr_ud_class.subsys.rwsem);
+	up(&nodemgr_ud_class.sem);
 
 	HPSB_DEBUG("Node resumed: ID:BUS[" NODE_BUS_FMT "]  GUID[%016Lx]",
 		   NODE_BUS_ARGS(ne->host, ne->nodeid), (unsigned long long)ne->guid);
 }
 
 
-/* Caller needs to hold nodemgr_ud_class.subsys.rwsem as reader. */
 static void nodemgr_update_pdrv(struct node_entry *ne)
 {
 	struct unit_directory *ud;
 	struct hpsb_protocol_driver *pdrv;
 	struct class_device *cdev;
 
+	down(&nodemgr_ud_class.sem);
 	list_for_each_entry(cdev, &nodemgr_ud_class.children, node) {
 		ud = container_of(cdev, struct unit_directory, class_dev);
-		if (ud->ne != ne || !ud->device.driver)
+		if (ud->ne != ne)
 			continue;
 
-		pdrv = container_of(ud->device.driver, struct hpsb_protocol_driver, driver);
-
-		if (pdrv->update && pdrv->update(ud)) {
-			down_write(&ud->device.bus->subsys.rwsem);
-			device_release_driver(&ud->device);
-			up_write(&ud->device.bus->subsys.rwsem);
+		down_write(&ieee1394_bus_type.subsys.rwsem);
+		if (ud->device.driver) {
+			pdrv = container_of(ud->device.driver,
+					    struct hpsb_protocol_driver,
+					    driver);
+			if (pdrv->update && pdrv->update(ud))
+				device_release_driver(&ud->device);
 		}
+		up_write(&ieee1394_bus_type.subsys.rwsem);
 	}
+	up(&nodemgr_ud_class.sem);
 }
 
 
@@ -1481,8 +1527,6 @@ static void nodemgr_irm_write_bc(struct 
 }
 
 
-/* Caller needs to hold nodemgr_ud_class.subsys.rwsem as reader because the
- * calls to nodemgr_update_pdrv() and nodemgr_suspend_ne() here require it. */
 static void nodemgr_probe_ne(struct host_info *hi, struct node_entry *ne, int generation)
 {
 	struct device *dev;
@@ -1515,7 +1559,6 @@ static void nodemgr_probe_ne(struct host
 static void nodemgr_node_probe(struct host_info *hi, int generation)
 {
 	struct hpsb_host *host = hi->host;
-	struct class *class = &nodemgr_ne_class;
 	struct class_device *cdev;
 	struct node_entry *ne;
 
@@ -1528,18 +1571,18 @@ static void nodemgr_node_probe(struct ho
 	 * while probes are time-consuming. (Well, those probes need some
 	 * improvement...) */
 
-	down_read(&class->subsys.rwsem);
-	list_for_each_entry(cdev, &class->children, node) {
+	down(&nodemgr_ne_class.sem);
+	list_for_each_entry(cdev, &nodemgr_ne_class.children, node) {
 		ne = container_of(cdev, struct node_entry, class_dev);
 		if (!ne->needs_probe)
 			nodemgr_probe_ne(hi, ne, generation);
 	}
-	list_for_each_entry(cdev, &class->children, node) {
+	list_for_each_entry(cdev, &nodemgr_ne_class.children, node) {
 		ne = container_of(cdev, struct node_entry, class_dev);
 		if (ne->needs_probe)
 			nodemgr_probe_ne(hi, ne, generation);
 	}
-        up_read(&class->subsys.rwsem);
+        up(&nodemgr_ne_class.sem);
 
 
 	/* If we had a bus reset while we were scanning the bus, it is
@@ -1751,19 +1794,18 @@ exit:
 
 int nodemgr_for_each_host(void *__data, int (*cb)(struct hpsb_host *, void *))
 {
-	struct class *class = &hpsb_host_class;
 	struct class_device *cdev;
 	struct hpsb_host *host;
 	int error = 0;
 
-	down_read(&class->subsys.rwsem);
-	list_for_each_entry(cdev, &class->children, node) {
+	down(&hpsb_host_class.sem);
+	list_for_each_entry(cdev, &hpsb_host_class.children, node) {
 		host = container_of(cdev, struct hpsb_host, class_dev);
 
 		if ((error = cb(host, __data)))
 			break;
 	}
-	up_read(&class->subsys.rwsem);
+	up(&hpsb_host_class.sem);
 
 	return error;
 }


