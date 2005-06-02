Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVFBVdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVFBVdx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 17:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVFBVdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 17:33:43 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:29906 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261328AbVFBVTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 17:19:52 -0400
Date: Thu, 2 Jun 2005 14:19:46 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: torvalds@osdl.org, akpm@osdl.org, greg@kroah.com
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH][3/5] RapidIO support: enumeration
Message-ID: <20050602141946.D24818@cox.net>
References: <20050602140359.B24818@cox.net> <20050602141247.C24818@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050602141247.C24818@cox.net>; from mporter@kernel.crashing.org on Thu, Jun 02, 2005 at 02:12:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds RapidIO enumeration/discovery.

The core code implements enumeration/discovery, management of
devices/resources, and interfaces for RIO drivers.
 
Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

Index: drivers/rio/rio-scan.c
===================================================================
--- /dev/null  (tree:8d5a02e2174e1dad478b22653de9f2a346e1c996)
+++ b4a27e4c90f11413fa6828321141c43cb9ad6c12/drivers/rio/rio-scan.c  (mode:100644)
@@ -0,0 +1,960 @@
+/*
+ * RapidIO enumeration and discovery support
+ *
+ * Copyright 2005 MontaVista Software, Inc.
+ * Matt Porter <mporter@kernel.crashing.org>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/rio.h>
+#include <linux/rio_drv.h>
+#include <linux/rio_ids.h>
+#include <linux/rio_regs.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/timer.h>
+
+#include "rio.h"
+
+LIST_HEAD(rio_devices);
+static LIST_HEAD(rio_switches);
+
+#define RIO_ENUM_CMPL_MAGIC	0xdeadbeef
+
+static void rio_enum_timeout(unsigned long);
+
+spinlock_t rio_global_list_lock = SPIN_LOCK_UNLOCKED;
+static int next_destid = 0;
+static int next_switchid = 0;
+static int next_net = 0;
+
+static struct timer_list rio_enum_timer =
+TIMER_INITIALIZER(rio_enum_timeout, 0, 0);
+
+static int rio_mport_phys_table[] = {
+	RIO_EFB_PAR_EP_ID,
+	RIO_EFB_PAR_EP_REC_ID,
+	RIO_EFB_SER_EP_ID,
+	RIO_EFB_SER_EP_REC_ID,
+	-1,
+};
+
+static int rio_sport_phys_table[] = {
+	RIO_EFB_PAR_EP_FREE_ID,
+	RIO_EFB_SER_EP_FREE_ID,
+	-1,
+};
+
+extern struct rio_route_ops __start_rio_route_ops[];
+extern struct rio_route_ops __end_rio_route_ops[];
+
+/**
+ * rio_get_device_id - Get the base/extended device id for a device
+ * @port: RIO master port 
+ * @destid: Destination ID of device
+ * @hopcount: Hopcount to device
+ *
+ * Reads the base/extended device id from a device. Returns the
+ * 8/16-bit device ID.
+ */
+static u16 rio_get_device_id(struct rio_mport *port, u16 destid, u8 hopcount)
+{
+	u32 result;
+
+	rio_mport_read_config_32(port, destid, hopcount, RIO_DID_CSR, &result);
+
+	return RIO_GET_DID(result);
+}
+
+/**
+ * rio_set_device_id - Set the base/extended device id for a device
+ * @port: RIO master port 
+ * @destid: Destination ID of device
+ * @hopcount: Hopcount to device
+ * @did: Device ID value to be written
+ *
+ * Writes the base/extended device id from a device.
+ */
+static void
+rio_set_device_id(struct rio_mport *port, u16 destid, u8 hopcount, u16 did)
+{
+	rio_mport_write_config_32(port, destid, hopcount, RIO_DID_CSR,
+				  RIO_SET_DID(did));
+}
+
+/**
+ * rio_local_set_device_id - Set the base/extended device id for a port
+ * @port: RIO master port 
+ * @did: Device ID value to be written
+ *
+ * Writes the base/extended device id from a device.
+ */
+static void rio_local_set_device_id(struct rio_mport *port, u16 did)
+{
+	rio_local_write_config_32(port, RIO_DID_CSR, RIO_SET_DID(did));
+}
+
+/**
+ * rio_clear_locks- Release all host locks and signal enumeration complete
+ * @port: Master port to issue transaction
+ *
+ * Marks the component tag CSR on each device with the enumeration
+ * complete flag. When complete, it then release the host locks on
+ * each device. Returns 0 on success or %-EINVAL on failure.
+ */
+static int rio_clear_locks(struct rio_mport *port)
+{
+	struct rio_dev *rdev;
+	u32 result;
+	int ret = 0;
+
+	/* Write component tag CSR magic complete value */
+	rio_local_write_config_32(port, RIO_COMPONENT_TAG_CSR,
+				  RIO_ENUM_CMPL_MAGIC);
+	list_for_each_entry(rdev, &rio_devices, global_list)
+	    rio_write_config_32(rdev, RIO_COMPONENT_TAG_CSR,
+				RIO_ENUM_CMPL_MAGIC);
+
+	/* Release host device id locks */
+	rio_local_write_config_32(port, RIO_HOST_DID_LOCK_CSR,
+				  port->host_deviceid);
+	rio_local_read_config_32(port, RIO_HOST_DID_LOCK_CSR, &result);
+	if ((result & 0xffff) != 0xffff) {
+		printk(KERN_INFO
+		       "RIO: badness when releasing host lock on master port, result %8.8x\n",
+		       result);
+		ret = -EINVAL;
+	}
+	list_for_each_entry(rdev, &rio_devices, global_list) {
+		rio_write_config_32(rdev, RIO_HOST_DID_LOCK_CSR,
+				    port->host_deviceid);
+		rio_read_config_32(rdev, RIO_HOST_DID_LOCK_CSR, &result);
+		if ((result & 0xffff) != 0xffff) {
+			printk(KERN_INFO
+			       "RIO: badness when releasing host lock on vid %4.4x did %4.4x\n",
+			       rdev->vid, rdev->did);
+			ret = -EINVAL;
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * rio_enum_host- Set host lock and initialize host destination ID
+ * @port: Master port to issue transaction
+ *
+ * Sets the local host master port lock and destination ID register
+ * with the host device ID value. The host device ID value is provided
+ * by the platform. Returns %0 on success or %-1 on failure.
+ */
+static int rio_enum_host(struct rio_mport *port)
+{
+	u32 result;
+
+	/* Set master port host device id lock */
+	rio_local_write_config_32(port, RIO_HOST_DID_LOCK_CSR,
+				  port->host_deviceid);
+
+	rio_local_read_config_32(port, RIO_HOST_DID_LOCK_CSR, &result);
+	if ((result & 0xffff) != port->host_deviceid)
+		return -1;
+
+	/* Set master port destid and init destid ctr */
+	rio_local_set_device_id(port, port->host_deviceid);
+
+	if (next_destid == port->host_deviceid)
+		next_destid++;
+
+	return 0;
+}
+
+/**
+ * rio_device_has_destid- Test if a device contains a destination ID register
+ * @port: Master port to issue transaction
+ * @src_ops: RIO device source operations
+ * @dst_ops: RIO device destination operations
+ *
+ * Checks the provided @src_ops and @dst_ops for the necessary transaction
+ * capabilities that indicate whether or not a device will implement a
+ * destination ID register. Returns 1 if true or 0 if false.
+ */
+static int rio_device_has_destid(struct rio_mport *port, int src_ops,
+				 int dst_ops)
+{
+	if (((src_ops & RIO_SRC_OPS_READ) ||
+	     (src_ops & RIO_SRC_OPS_WRITE) ||
+	     (src_ops & RIO_SRC_OPS_ATOMIC_TST_SWP) ||
+	     (src_ops & RIO_SRC_OPS_ATOMIC_INC) ||
+	     (src_ops & RIO_SRC_OPS_ATOMIC_DEC) ||
+	     (src_ops & RIO_SRC_OPS_ATOMIC_SET) ||
+	     (src_ops & RIO_SRC_OPS_ATOMIC_CLR)) &&
+	    ((dst_ops & RIO_DST_OPS_READ) ||
+	     (dst_ops & RIO_DST_OPS_WRITE) ||
+	     (dst_ops & RIO_DST_OPS_ATOMIC_TST_SWP) ||
+	     (dst_ops & RIO_DST_OPS_ATOMIC_INC) ||
+	     (dst_ops & RIO_DST_OPS_ATOMIC_DEC) ||
+	     (dst_ops & RIO_DST_OPS_ATOMIC_SET) ||
+	     (dst_ops & RIO_DST_OPS_ATOMIC_CLR))) {
+		return 1;
+	} else
+		return 0;
+}
+
+/**
+ * rio_release_dev- Frees a RIO device struct
+ * @dev: LDM device associated with a RIO device struct
+ *
+ * Gets the RIO device struct associated a RIO device struct.
+ * The RIO device struct is freed.
+ */
+static void rio_release_dev(struct device *dev)
+{
+	struct rio_dev *rdev;
+
+	rdev = to_rio_dev(dev);
+	kfree(rdev);
+}
+
+/**
+ * rio_is_switch- Tests if a RIO device has switch capabilities
+ * @rdev: RIO device
+ *
+ * Gets the RIO device Processing Element Features register
+ * contents and tests for switch capabilities. Returns 1 if
+ * the device is a switch or 0 if it is not a switch.
+ * The RIO device struct is freed.
+ */
+static int rio_is_switch(struct rio_dev *rdev)
+{
+	if (rdev->pef & RIO_PEF_SWITCH)
+		return 1;
+	return 0;
+}
+
+/**
+ * rio_route_set_ops- Sets routing operations for a particular vendor switch
+ * @rdev: RIO device
+ *
+ * Searches the RIO route ops table for known switch types. If the vid
+ * and did match a switch table entry, then set the add_entry() and
+ * get_entry() ops to the table entry values.
+ */
+static void rio_route_set_ops(struct rio_dev *rdev)
+{
+	struct rio_route_ops *cur = __start_rio_route_ops;
+	struct rio_route_ops *end = __end_rio_route_ops;
+
+	while (cur < end) {
+		if ((cur->vid == rdev->vid) && (cur->did == rdev->did)) {
+			pr_debug("RIO: adding routing ops for %s\n", rio_name(rdev));
+			rdev->rswitch->add_entry = cur->add_hook;
+			rdev->rswitch->get_entry = cur->get_hook;
+		}
+		cur++;
+	}
+
+	if (!rdev->rswitch->add_entry || !rdev->rswitch->get_entry)
+		printk(KERN_ERR "RIO: missing routing ops for %s\n",
+		       rio_name(rdev));
+}
+
+/**
+ * rio_add_device- Adds a RIO device to the device model
+ * @rdev: RIO device
+ *
+ * Adds the RIO device to the global device list and adds the RIO
+ * device to the RIO device list.  Creates the generic sysfs nodes
+ * for an RIO device.
+ */
+static void __devinit rio_add_device(struct rio_dev *rdev)
+{
+	device_add(&rdev->dev);
+
+	spin_lock(&rio_global_list_lock);
+	list_add_tail(&rdev->global_list, &rio_devices);
+	spin_unlock(&rio_global_list_lock);
+
+	rio_create_sysfs_dev_files(rdev);
+}
+
+/**
+ * rio_setup_device- Allocates and sets up a RIO device
+ * @net: RIO network
+ * @port: Master port to send transactions
+ * @destid: Current destination ID
+ * @hopcount: Current hopcount
+ * @do_enum: Enumeration/Discovery mode flag
+ *
+ * Allocates a RIO device and configures fields based on configuration
+ * space contents. If device has a destination ID register, a destination
+ * ID is either assigned in enumeration mode or read from configuration
+ * space in discovery mode.  If the device has switch capabilities, then
+ * a switch is allocated and configured appropriately. Returns a pointer
+ * to a RIO device on success or NULL on failure.
+ *
+ */
+static struct rio_dev *rio_setup_device(struct rio_net *net,
+					struct rio_mport *port, u16 destid,
+					u8 hopcount, int do_enum)
+{
+	struct rio_dev *rdev;
+	struct rio_switch *rswitch;
+	int result, rdid;
+
+	rdev = kmalloc(sizeof(struct rio_dev), GFP_KERNEL);
+	if (!rdev)
+		goto out;
+
+	memset(rdev, 0, sizeof(struct rio_dev));
+	rdev->net = net;
+	rio_mport_read_config_32(port, destid, hopcount, RIO_DEV_ID_CAR,
+				 &result);
+	rdev->did = result >> 16;
+	rdev->vid = result & 0xffff;
+	rio_mport_read_config_32(port, destid, hopcount, RIO_DEV_INFO_CAR,
+				 &rdev->device_rev);
+	rio_mport_read_config_32(port, destid, hopcount, RIO_ASM_ID_CAR,
+				 &result);
+	rdev->asm_did = result >> 16;
+	rdev->asm_vid = result & 0xffff;
+	rio_mport_read_config_32(port, destid, hopcount, RIO_ASM_INFO_CAR,
+				 &result);
+	rdev->asm_rev = result >> 16;
+	rio_mport_read_config_32(port, destid, hopcount, RIO_PEF_CAR,
+				 &rdev->pef);
+	if (rdev->pef & RIO_PEF_EXT_FEATURES)
+		rdev->efptr = result & 0xffff;
+
+	rio_mport_read_config_32(port, destid, hopcount, RIO_SRC_OPS_CAR,
+				 &rdev->src_ops);
+	rio_mport_read_config_32(port, destid, hopcount, RIO_DST_OPS_CAR,
+				 &rdev->dst_ops);
+
+	if (rio_device_has_destid(port, rdev->src_ops, rdev->dst_ops)
+	    && do_enum) {
+		rio_set_device_id(port, destid, hopcount, next_destid);
+		rdev->destid = next_destid++;
+		if (next_destid == port->host_deviceid)
+			next_destid++;
+	} else
+		rdev->destid = rio_get_device_id(port, destid, hopcount);
+
+	/* If a PE has both switch and other functions, show it as a switch */
+	if (rio_is_switch(rdev)) {
+		rio_mport_read_config_32(port, destid, hopcount,
+					 RIO_SWP_INFO_CAR, &rdev->swpinfo);
+		rswitch = kmalloc(sizeof(struct rio_switch), GFP_KERNEL);
+		if (!rswitch) {
+			kfree(rdev);
+			rdev = NULL;
+			goto out;
+		}
+		rswitch->switchid = next_switchid;
+		rswitch->hopcount = hopcount;
+		rswitch->destid = 0xffff;
+		/* Initialize switch route table */
+		for (rdid = 0; rdid < RIO_MAX_ROUTE_ENTRIES; rdid++)
+			rswitch->route_table[rdid] = RIO_INVALID_ROUTE;
+		rdev->rswitch = rswitch;
+		sprintf(rio_name(rdev), "%02x:s:%04x", rdev->net->id,
+			rdev->rswitch->switchid);
+		rio_route_set_ops(rdev);
+
+		list_add_tail(&rswitch->node, &rio_switches);
+
+	} else
+		sprintf(rio_name(rdev), "%02x:e:%04x", rdev->net->id,
+			rdev->destid);
+
+	rdev->dev.bus = &rio_bus_type;
+
+	device_initialize(&rdev->dev);
+	rdev->dev.release = rio_release_dev;
+	rio_dev_get(rdev);
+
+	rdev->dev.dma_mask = (u64 *) 0xffffffff;
+	rdev->dev.coherent_dma_mask = 0xffffffffULL;
+
+	if ((rdev->pef & RIO_PEF_INB_DOORBELL) &&
+	    (rdev->dst_ops & RIO_DST_OPS_DOORBELL))
+		rio_init_dbell_res(&rdev->riores[RIO_DOORBELL_RESOURCE],
+				   0, 0xffff);
+
+	rio_add_device(rdev);
+
+      out:
+	return rdev;
+}
+
+/**
+ * rio_sport_is_active- Tests if a switch port has an active connection.
+ * @port: Master port to send transaction
+ * @destid: Associated destination ID for switch
+ * @hopcount: Hopcount to reach switch
+ * @sport: Switch port number
+ *
+ * Reads the port error status CSR for a particular switch port to
+ * determine if the port has an active link.  Returns
+ * %PORT_N_ERR_STS_PORT_OK if the port is active or %0 if it is
+ * inactive.
+ */
+static int
+rio_sport_is_active(struct rio_mport *port, u16 destid, u8 hopcount, int sport)
+{
+	u32 result;
+	u32 ext_ftr_ptr;
+
+	int *entry = rio_sport_phys_table;
+
+	do {
+		if ((ext_ftr_ptr =
+		     rio_mport_get_feature(port, 0, destid, hopcount, *entry)))
+
+			break;
+	} while (*++entry >= 0);
+
+	if (ext_ftr_ptr)
+		rio_mport_read_config_32(port, destid, hopcount,
+					 ext_ftr_ptr +
+					 RIO_PORT_N_ERR_STS_CSR(sport),
+					 &result);
+
+	return (result & PORT_N_ERR_STS_PORT_OK);
+}
+
+/**
+ * rio_route_add_entry- Add a route entry to a switch routing table
+ * @mport: Master port to send transaction
+ * @rdev: Switch device
+ * @table: Routing table ID
+ * @route_destid: Destination ID to be routed
+ * @route_port: Port number to be routed
+ *
+ * Calls the switch specific add_entry() method to add a route entry
+ * on a switch. The route table can be specified using the @table
+ * argument if a switch has per port routing tables or the normal
+ * use is to specific all tables (or the global table) by passing
+ * %RIO_GLOBAL_TABLE in @table. Returns %0 on success or %-EINVAL
+ * on failure.
+ */
+static int rio_route_add_entry(struct rio_mport *mport, struct rio_dev *rdev,
+			       u16 table, u16 route_destid, u8 route_port)
+{
+	return rdev->rswitch->add_entry(mport, rdev->rswitch->destid,
+					rdev->rswitch->hopcount, table,
+					route_destid, route_port);
+}
+
+/**
+ * rio_route_get_entry- Read a route entry in a switch routing table
+ * @mport: Master port to send transaction
+ * @rdev: Switch device
+ * @table: Routing table ID
+ * @route_destid: Destination ID to be routed
+ * @route_port: Pointer to read port number into
+ *
+ * Calls the switch specific get_entry() method to read a route entry
+ * in a switch. The route table can be specified using the @table
+ * argument if a switch has per port routing tables or the normal
+ * use is to specific all tables (or the global table) by passing
+ * %RIO_GLOBAL_TABLE in @table. Returns %0 on success or %-EINVAL
+ * on failure.
+ */
+static int
+rio_route_get_entry(struct rio_mport *mport, struct rio_dev *rdev, u16 table,
+		    u16 route_destid, u8 * route_port)
+{
+	return rdev->rswitch->get_entry(mport, rdev->rswitch->destid,
+					rdev->rswitch->hopcount, table,
+					route_destid, route_port);
+}
+
+/**
+ * rio_get_host_deviceid_lock- Reads the Host Device ID Lock CSR on a device
+ * @port: Master port to send transaction
+ * @hopcount: Number of hops to the device
+ *
+ * Used during enumeration to read the Host Device ID Lock CSR on a
+ * RIO device. Returns the value of the lock register.
+ */
+static u16 rio_get_host_deviceid_lock(struct rio_mport *port, u8 hopcount)
+{
+	u32 result;
+
+	rio_mport_read_config_32(port, RIO_ANY_DESTID, hopcount,
+				 RIO_HOST_DID_LOCK_CSR, &result);
+
+	return (u16) (result & 0xffff);
+}
+
+/**
+ * rio_get_swpinfo_inport- Gets the ingress port number 
+ * @mport: Master port to send transaction
+ * @destid: Destination ID associated with the switch
+ * @hopcount: Number of hops to the device
+ *
+ * Returns port number being used to access the switch device.
+ */
+static u8
+rio_get_swpinfo_inport(struct rio_mport *mport, u16 destid, u8 hopcount)
+{
+	u32 result;
+
+	rio_mport_read_config_32(mport, destid, hopcount, RIO_SWP_INFO_CAR,
+				 &result);
+
+	return (u8) (result & 0xff);
+}
+
+/**
+ * rio_get_swpinfo_tports- Gets total number of ports on the switch
+ * @mport: Master port to send transaction
+ * @destid: Destination ID associated with the switch
+ * @hopcount: Number of hops to the device
+ *
+ * Returns total numbers of ports implemented by the switch device.
+ */
+static u8 rio_get_swpinfo_tports(struct rio_mport *mport, u16 destid,
+				 u8 hopcount)
+{
+	u32 result;
+
+	rio_mport_read_config_32(mport, destid, hopcount, RIO_SWP_INFO_CAR,
+				 &result);
+
+	return RIO_GET_TOTAL_PORTS(result);
+}
+
+/**
+ * rio_net_add_mport- Add a master port to a RIO network
+ * @net: RIO network
+ * @port: Master port to add
+ *
+ * Adds a master port to the network list of associated master
+ * ports..
+ */
+static void rio_net_add_mport(struct rio_net *net, struct rio_mport *port)
+{
+	spin_lock(&rio_global_list_lock);
+	list_add_tail(&port->nnode, &net->mports);
+	spin_unlock(&rio_global_list_lock);
+}
+
+/**
+ * rio_enum_peer- Recursively enumerate a RIO network through a master port
+ * @net: RIO network being enumerated
+ * @port: Master port to send transactions
+ * @hopcount: Number of hops into the network
+ *
+ * Recursively enumerates a RIO network.  Transactions are sent via the
+ * master port passed in @port.
+ */
+static int rio_enum_peer(struct rio_net *net, struct rio_mport *port,
+			 u8 hopcount)
+{
+	int port_num;
+	int num_ports;
+	int cur_destid;
+	struct rio_dev *rdev;
+	u16 destid;
+	int tmp;
+
+	if (rio_get_host_deviceid_lock(port, hopcount) == port->host_deviceid) {
+		pr_debug("RIO: PE already discovered by this host\n");
+		/*
+		 * Already discovered by this host. Add it as another
+		 * master port for the current network.
+		 */
+		rio_net_add_mport(net, port);
+		return 0;
+	}
+
+	/* Attempt to acquire device lock */
+	rio_mport_write_config_32(port, RIO_ANY_DESTID, hopcount,
+				  RIO_HOST_DID_LOCK_CSR, port->host_deviceid);
+	while ((tmp = rio_get_host_deviceid_lock(port, hopcount))
+	       < port->host_deviceid) {
+		/* Delay a bit */
+		mdelay(1);
+		/* Attempt to acquire device lock again */
+		rio_mport_write_config_32(port, RIO_ANY_DESTID, hopcount,
+					  RIO_HOST_DID_LOCK_CSR,
+					  port->host_deviceid);
+	}
+
+	if (rio_get_host_deviceid_lock(port, hopcount) > port->host_deviceid) {
+		pr_debug(
+		    "RIO: PE locked by a higher priority host...retreating\n");
+		return -1;
+	}
+
+	/* Setup new RIO device */
+	if ((rdev = rio_setup_device(net, port, RIO_ANY_DESTID, hopcount, 1))) {
+		/* Add device to the global and bus/net specific list. */
+		list_add_tail(&rdev->net_list, &net->devices);
+	} else
+		return -1;
+
+	if (rio_is_switch(rdev)) {
+		next_switchid++;
+
+		for (destid = 0; destid < next_destid; destid++) {
+			rio_route_add_entry(port, rdev, RIO_GLOBAL_TABLE,
+					    destid, rio_get_swpinfo_inport(port,
+									   RIO_ANY_DESTID,
+									   hopcount));
+			rdev->rswitch->route_table[destid] =
+			    rio_get_swpinfo_inport(port, RIO_ANY_DESTID,
+						   hopcount);
+		}
+
+		num_ports =
+		    rio_get_swpinfo_tports(port, RIO_ANY_DESTID, hopcount);
+		pr_debug(
+		    "RIO: found %s (vid %4.4x did %4.4x) with %d ports\n",
+		    rio_name(rdev), rdev->vid, rdev->did, num_ports);
+		for (port_num = 0; port_num < num_ports; port_num++) {
+			if (rio_get_swpinfo_inport
+			    (port, RIO_ANY_DESTID, hopcount) == port_num)
+				continue;
+
+			cur_destid = next_destid;
+
+			if (rio_sport_is_active
+			    (port, RIO_ANY_DESTID, hopcount, port_num)) {
+				pr_debug(
+				    "RIO: scanning device on port %d\n",
+				    port_num);
+				rio_route_add_entry(port, rdev,
+						    RIO_GLOBAL_TABLE,
+						    RIO_ANY_DESTID, port_num);
+
+				if (rio_enum_peer(net, port, hopcount + 1) < 0)
+					return -1;
+
+				/* Update routing tables */
+				if (next_destid > cur_destid) {
+					for (destid = cur_destid;
+					     destid < next_destid; destid++) {
+						rio_route_add_entry(port, rdev,
+								    RIO_GLOBAL_TABLE,
+								    destid,
+								    port_num);
+						rdev->rswitch->
+						    route_table[destid] =
+						    port_num;
+					}
+					rdev->rswitch->destid = cur_destid;
+				}
+			}
+		}
+	} else
+		pr_debug("RIO: found %s (vid %4.4x did %4.4x)\n",
+		    rio_name(rdev), rdev->vid, rdev->did);
+
+	return 0;
+}
+
+/**
+ * rio_enum_complete- Tests if enumeration of a network is complete
+ * @port: Master port to send transaction
+ *
+ * Tests the Component Tag CSR for presence of the magic enumeration
+ * complete flag. Return %1 if enumeration is complete or %0 if
+ * enumeration is incomplete.
+ */
+static int rio_enum_complete(struct rio_mport *port)
+{
+	u32 tag_csr;
+	int ret = 0;
+
+	rio_local_read_config_32(port, RIO_COMPONENT_TAG_CSR, &tag_csr);
+
+	if (tag_csr == RIO_ENUM_CMPL_MAGIC)
+		ret = 1;
+
+	return ret;
+}
+
+/**
+ * rio_disc_peer- Recursively discovers a RIO network through a master port
+ * @net: RIO network being discovered
+ * @port: Master port to send transactions
+ * @destid: Current destination ID in network
+ * @hopcount: Number of hops into the network
+ *
+ * Recursively discovers a RIO network.  Transactions are sent via the
+ * master port passed in @port.
+ */
+static int
+rio_disc_peer(struct rio_net *net, struct rio_mport *port, u16 destid,
+	      u8 hopcount)
+{
+	u8 port_num, route_port;
+	int num_ports;
+	struct rio_dev *rdev;
+	u16 ndestid;
+
+	/* Setup new RIO device */
+	if ((rdev = rio_setup_device(net, port, destid, hopcount, 0))) {
+		/* Add device to the global and bus/net specific list. */
+		list_add_tail(&rdev->net_list, &net->devices);
+	} else
+		return -1;
+
+	if (rio_is_switch(rdev)) {
+		next_switchid++;
+
+		/* Associated destid is how we accessed this switch */
+		rdev->rswitch->destid = destid;
+
+		num_ports = rio_get_swpinfo_tports(port, destid, hopcount);
+		pr_debug(
+		    "RIO: found %s (vid %4.4x did %4.4x) with %d ports\n",
+		    rio_name(rdev), rdev->vid, rdev->did, num_ports);
+		for (port_num = 0; port_num < num_ports; port_num++) {
+			if (rio_get_swpinfo_inport(port, destid, hopcount) ==
+			    port_num)
+				continue;
+
+			if (rio_sport_is_active
+			    (port, destid, hopcount, port_num)) {
+				pr_debug(
+				    "RIO: scanning device on port %d\n",
+				    port_num);
+				for (ndestid = 0; ndestid < RIO_ANY_DESTID;
+				     ndestid++) {
+					rio_route_get_entry(port, rdev,
+							    RIO_GLOBAL_TABLE,
+							    ndestid,
+							    &route_port);
+					if (route_port == port_num)
+						break;
+				}
+
+				if (rio_disc_peer
+				    (net, port, ndestid, hopcount + 1) < 0)
+					return -1;
+			}
+		}
+	} else
+		pr_debug("RIO: found %s (vid %4.4x did %4.4x)\n",
+		    rio_name(rdev), rdev->vid, rdev->did);
+
+	return 0;
+}
+
+/**
+ * rio_mport_is_active- Tests if master port link is active
+ * @port: Master port to test
+ *
+ * Reads the port error status CSR for the master port to
+ * determine if the port has an active link.  Returns
+ * %PORT_N_ERR_STS_PORT_OK if the  master port is active
+ * or %0 if it is inactive.
+ */
+static int rio_mport_is_active(struct rio_mport *port)
+{
+	u32 result = 0;
+	u32 ext_ftr_ptr;
+	int *entry = rio_mport_phys_table;
+
+	do {
+		if ((ext_ftr_ptr =
+		     rio_mport_get_feature(port, 1, 0, 0, *entry)))
+			break;
+	} while (*++entry >= 0);
+
+	if (ext_ftr_ptr)
+		rio_local_read_config_32(port,
+					 ext_ftr_ptr +
+					 RIO_PORT_N_ERR_STS_CSR(port->index),
+					 &result);
+
+	return (result & PORT_N_ERR_STS_PORT_OK);
+}
+
+/**
+ * rio_alloc_net- Allocate and configure a new RIO network
+ * @port: Master port associated with the RIO network
+ *
+ * Allocates a RIO network structure, initializes per-network
+ * list heads, and adds the associated master port to the
+ * network list of associated master ports. Returns a
+ * RIO network pointer on success or %NULL on failure.
+ */
+static struct rio_net __devinit *rio_alloc_net(struct rio_mport *port)
+{
+	struct rio_net *net;
+
+	net = kmalloc(sizeof(struct rio_net), GFP_KERNEL);
+	if (net) {
+		memset(net, 0, sizeof(struct rio_net));
+		INIT_LIST_HEAD(&net->node);
+		INIT_LIST_HEAD(&net->devices);
+		INIT_LIST_HEAD(&net->mports);
+		list_add_tail(&port->nnode, &net->mports);
+		net->hport = port;
+		net->id = next_net++;
+	}
+	return net;
+}
+
+/**
+ * rio_enum_mport- Start enumeration through a master port
+ * @mport: Master port to send transactions
+ *
+ * Starts the enumeration process. If somebody has enumerated our
+ * master port device, then give up. If not and we have an active
+ * link, then start recursive peer enumeration. Returns %0 if
+ * enumeration succeeds or %-EBUSY if enumeration fails.
+ */
+int rio_enum_mport(struct rio_mport *mport)
+{
+	struct rio_net *net = NULL;
+	int rc = 0;
+
+	printk(KERN_INFO "RIO: enumerate master port %d, %s\n", mport->id,
+	       mport->name);
+	/* If somebody else enumerated our master port device, bail. */
+	if (rio_enum_host(mport) < 0) {
+		printk(KERN_INFO
+		       "RIO: master port %d device has been enumerated by a remote host\n",
+		       mport->id);
+		rc = -EBUSY;
+		goto out;
+	}
+
+	/* If master port has an active link, allocate net and enum peers */
+	if (rio_mport_is_active(mport)) {
+		if (!(net = rio_alloc_net(mport))) {
+			printk(KERN_ERR "RIO: failed to allocate new net\n");
+			rc = -ENOMEM;
+			goto out;
+		}
+		if (rio_enum_peer(net, mport, 0) < 0) {
+			/* A higher priority host won enumeration, bail. */
+			printk(KERN_INFO
+			       "RIO: master port %d device has lost enumeration to a remote host\n",
+			       mport->id);
+			rio_clear_locks(mport);
+			rc = -EBUSY;
+			goto out;
+		}
+		rio_clear_locks(mport);
+	} else {
+		printk(KERN_INFO "RIO: master port %d link inactive\n",
+		       mport->id);
+		rc = -EINVAL;
+	}
+
+      out:
+	return rc;
+}
+
+/**
+ * rio_build_route_tables- Generate route tables from switch route entries
+ *
+ * For each switch device, generate a route table by copying existing
+ * route entries from the switch.
+ */
+static void rio_build_route_tables(void)
+{
+	struct rio_dev *rdev;
+	int i;
+	u8 sport;
+
+	list_for_each_entry(rdev, &rio_devices, global_list)
+	    if (rio_is_switch(rdev))
+		for (i = 0; i < RIO_MAX_ROUTE_ENTRIES; i++) {
+			if (rio_route_get_entry
+			    (rdev->net->hport, rdev, RIO_GLOBAL_TABLE, i,
+			     &sport) < 0)
+				continue;
+			rdev->rswitch->route_table[i] = sport;
+		}
+}
+
+/**
+ * rio_enum_timeout- Signal that enumeration timed out
+ * @data: Address of timeout flag.
+ *
+ * When the enumeration complete timer expires, set a flag that
+ * signals to the discovery process that enumeration did not
+ * complete in a sane amount of time.
+ */
+static void rio_enum_timeout(unsigned long data)
+{
+	/* Enumeration timed out, set flag */
+	*(int *)data = 1;
+}
+
+/**
+ * rio_disc_mport- Start discovery through a master port
+ * @mport: Master port to send transactions
+ *
+ * Starts the discovery process. If we have an active link,
+ * then wait for the signal that enumeration is complete.
+ * When enumeration completion is signaled, start recursive
+ * peer discovery. Returns %0 if discovery succeeds or %-EBUSY
+ * on failure.
+ */
+int rio_disc_mport(struct rio_mport *mport)
+{
+	struct rio_net *net = NULL;
+	int enum_timeout_flag = 0;
+
+	printk(KERN_INFO "RIO: discover master port %d, %s\n", mport->id,
+	       mport->name);
+
+	/* If master port has an active link, allocate net and discover peers */
+	if (rio_mport_is_active(mport)) {
+		if (!(net = rio_alloc_net(mport))) {
+			printk(KERN_ERR "RIO: Failed to allocate new net\n");
+			goto bail;
+		}
+
+		pr_debug("RIO: wait for enumeration complete...");
+
+		rio_enum_timer.expires =
+		    jiffies + CONFIG_RAPIDIO_DISC_TIMEOUT * HZ;
+		rio_enum_timer.data = (unsigned long)&enum_timeout_flag;
+		add_timer(&rio_enum_timer);
+		while (!rio_enum_complete(mport)) {
+			mdelay(1);
+			if (enum_timeout_flag) {
+				del_timer_sync(&rio_enum_timer);
+				goto timeout;
+			}
+		}
+		del_timer_sync(&rio_enum_timer);
+
+		pr_debug("done\n");
+		if (rio_disc_peer(net, mport, RIO_ANY_DESTID, 0) < 0) {
+			printk(KERN_INFO
+			       "RIO: master port %d device has failed discovery\n",
+			       mport->id);
+			goto bail;
+		}
+
+		rio_build_route_tables();
+	}
+
+	return 0;
+
+      timeout:
+	pr_debug("timeout\n");
+      bail:
+	return -EBUSY;
+}
Index: drivers/rio/switches/Makefile
===================================================================
--- /dev/null  (tree:8d5a02e2174e1dad478b22653de9f2a346e1c996)
+++ b4a27e4c90f11413fa6828321141c43cb9ad6c12/drivers/rio/switches/Makefile  (mode:100644)
@@ -0,0 +1,5 @@
+#
+# Makefile for RIO switches
+#
+
+obj-$(CONFIG_RAPIDIO)	+= tsi500.o
Index: drivers/rio/switches/tsi500.c
===================================================================
--- /dev/null  (tree:8d5a02e2174e1dad478b22653de9f2a346e1c996)
+++ b4a27e4c90f11413fa6828321141c43cb9ad6c12/drivers/rio/switches/tsi500.c  (mode:100644)
@@ -0,0 +1,60 @@
+/*
+ * RapidIO Tsi500 switch support
+ *
+ * Copyright 2005 MontaVista Software, Inc.
+ * Matt Porter <mporter@kernel.crashing.org>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/rio.h>
+#include <linux/rio_drv.h>
+#include <linux/rio_ids.h>
+#include "../rio.h"
+
+static int
+tsi500_route_add_entry(struct rio_mport *mport, u16 destid, u8 hopcount, u16 table, u16 route_destid, u8 route_port)
+{
+	int i;
+	u32 offset = 0x10000 + 0xa00 + ((route_destid / 2)&~0x3);
+	u32 result;
+
+	if (table == 0xff) {
+		rio_mport_read_config_32(mport, destid, hopcount, offset, &result);
+		result &= ~(0xf << (4*(route_destid & 0x7)));
+		for (i=0;i<4;i++)
+			rio_mport_write_config_32(mport, destid, hopcount, offset + (0x20000*i), result | (route_port << (4*(route_destid & 0x7))));
+	}
+	else {
+		rio_mport_read_config_32(mport, destid, hopcount, offset + (0x20000*table), &result);
+		result &= ~(0xf << (4*(route_destid & 0x7)));
+		rio_mport_write_config_32(mport, destid, hopcount, offset + (0x20000*table), result | (route_port << (4*(route_destid & 0x7))));
+	}
+
+	return 0;
+}
+
+static int
+tsi500_route_get_entry(struct rio_mport *mport, u16 destid, u8 hopcount, u16 table, u16 route_destid, u8 *route_port)
+{
+	int ret = 0;
+	u32 offset = 0x10000 + 0xa00 + ((route_destid / 2)&~0x3);
+	u32 result;
+
+	if (table == 0xff)
+		rio_mport_read_config_32(mport, destid, hopcount, offset, &result);
+	else
+		rio_mport_read_config_32(mport, destid, hopcount, offset + (0x20000*table), &result);
+
+	result &= 0xf << (4*(route_destid & 0x7));
+	*route_port = result >> (4*(route_destid & 0x7));
+	if (*route_port > 3)
+		ret = -1;
+
+	return ret;
+}
+
+DECLARE_RIO_ROUTE_OPS(RIO_VID_TUNDRA, RIO_DID_TSI500, tsi500_route_add_entry, tsi500_route_get_entry);
