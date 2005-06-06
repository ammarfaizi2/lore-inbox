Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbVFFXOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVFFXOx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 19:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVFFXOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 19:14:53 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:28693 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S261782AbVFFWki convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 18:40:38 -0400
Cc: gregkh@kroah.com, linuxppc-embedded@ozlabs.org
Subject: [PATCH][2/5] RapidIO support: core includes
In-Reply-To: <11180976062000@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 6 Jun 2005 15:40:15 -0700
Message-Id: <11180976152959@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Matt Porter <mporter@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Matt Porter <mporter@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add RapidIO core include files.

The core code implements enumeration/discovery, management of
devices/resources, and interfaces for RIO drivers.

Signed-off-by: Matt Porter <mporter@kernel.crashing.org>

diff --git a/include/linux/rio.h b/include/linux/rio.h
new file mode 100644
--- /dev/null
+++ b/include/linux/rio.h
@@ -0,0 +1,321 @@
+/*
+ * RapidIO interconnect services
+ * (RapidIO Interconnect Specification, http://www.rapidio.org)
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
+#ifndef LINUX_RIO_H
+#define LINUX_RIO_H
+
+#ifdef __KERNEL__
+
+#include <linux/types.h>
+#include <linux/config.h>
+#include <linux/ioport.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/device.h>
+#include <linux/rio_regs.h>
+
+#define RIO_ANY_DESTID		0xff
+#define RIO_NO_HOPCOUNT		-1
+
+#define RIO_MAX_MPORT_RESOURCES	16
+#define RIO_MAX_DEV_RESOURCES	16
+
+#define RIO_GLOBAL_TABLE	0xff	/* Indicates access of a switch's
+					   global routing table if it
+					   has multiple (or per port)
+					   tables */
+
+#define RIO_INVALID_ROUTE	0xff	/* Indicates that a route table
+					   entry is invalid (no route
+					   exists for the device ID) */
+
+#ifdef CONFIG_RAPIDIO_8_BIT_TRANSPORT
+#define RIO_MAX_ROUTE_ENTRIES	(1 << 8)
+#else
+#define RIO_MAX_ROUTE_ENTRIES	(1 << 16)
+#endif
+
+#define RIO_MAX_MBOX		4
+#define RIO_MAX_MSG_SIZE	0x1000
+
+/*
+ * Error values that may be returned by RIO functions.
+ */
+#define RIO_SUCCESSFUL			0x00
+#define RIO_BAD_SIZE			0x81
+
+/*
+ * For RIO devices, the region numbers are assigned this way:
+ *
+ *	0	RapidIO outbound doorbells
+ *      1-15	RapidIO memory regions
+ *
+ * For RIO master ports, the region number are assigned this way:
+ *
+ *	0	RapidIO inbound doorbells
+ *	1	RapidIO inbound mailboxes
+ *	1	RapidIO outbound mailboxes
+ */
+#define RIO_DOORBELL_RESOURCE	0
+#define RIO_INB_MBOX_RESOURCE	1
+#define RIO_OUTB_MBOX_RESOURCE	2
+
+extern struct bus_type rio_bus_type;
+extern struct list_head rio_devices;	/* list of all devices */
+
+struct rio_mport;
+
+/**
+ * struct rio_dev - RIO device info
+ * @global_list: Node in list of all RIO devices
+ * @net_list: Node in list of RIO devices in a network
+ * @net: Network this device is a part of
+ * @did: Device ID
+ * @vid: Vendor ID
+ * @device_rev: Device revision
+ * @asm_did: Assembly device ID
+ * @asm_vid: Assembly vendor ID
+ * @asm_rev: Assembly revision
+ * @efptr: Extended feature pointer
+ * @pef: Processing element features
+ * @swpinfo: Switch port info
+ * @src_ops: Source operation capabilities
+ * @dst_ops: Destination operation capabilities
+ * @rswitch: Pointer to &struct rio_switch if valid for this device
+ * @driver: Driver claiming this device
+ * @dev: Device model device
+ * @riores: RIO resources this device owns
+ * @destid: Network destination ID
+ */
+struct rio_dev {
+	struct list_head global_list;	/* node in list of all RIO devices */
+	struct list_head net_list;	/* node in per net list */
+	struct rio_net *net;	/* RIO net this device resides in */
+	u16 did;
+	u16 vid;
+	u32 device_rev;
+	u16 asm_did;
+	u16 asm_vid;
+	u16 asm_rev;
+	u16 efptr;
+	u32 pef;
+	u32 swpinfo;		/* Only used for switches */
+	u32 src_ops;
+	u32 dst_ops;
+	struct rio_switch *rswitch;	/* RIO switch info */
+	struct rio_driver *driver;	/* RIO driver claiming this device */
+	struct device dev;	/* LDM device structure */
+	struct resource riores[RIO_MAX_DEV_RESOURCES];
+	u16 destid;
+};
+
+#define rio_dev_g(n) list_entry(n, struct rio_dev, global_list)
+#define rio_dev_f(n) list_entry(n, struct rio_dev, net_list)
+#define	to_rio_dev(n) container_of(n, struct rio_dev, dev)
+
+/**
+ * struct rio_msg - RIO message event
+ * @res: Mailbox resource
+ * @mcback: Message event callback
+ */
+struct rio_msg {
+	struct resource *res;
+	void (*mcback) (struct rio_mport * mport, int mbox, int slot);
+};
+
+/**
+ * struct rio_dbell - RIO doorbell event
+ * @node: Node in list of doorbell events
+ * @res: Doorbell resource
+ * @dinb: Doorbell event callback
+ */
+struct rio_dbell {
+	struct list_head node;
+	struct resource *res;
+	void (*dinb) (struct rio_mport * mport, u16 src, u16 dst, u16 info);
+};
+
+/**
+ * struct rio_mport - RIO master port info
+ * @dbells: List of doorbell events 
+ * @node: Node in global list of master ports
+ * @nnode: Node in network list of master ports
+ * @iores: I/O mem resource that this master port interface owns
+ * @riores: RIO resources that this master port interfaces owns
+ * @inb_msg: RIO inbound message event descriptors
+ * @outb_msg: RIO outbound message event descriptors
+ * @host_deviceid: Host device ID associated with this master port
+ * @ops: configuration space functions
+ * @id: Port ID, unique among all ports
+ * @index: Port index, unique among all port interfaces of the same type
+ * @name: Port name string
+ */
+struct rio_mport {
+	struct list_head dbells;	/* list of doorbell events */
+	struct list_head node;	/* node in global list of ports */
+	struct list_head nnode;	/* node in net list of ports */
+	struct resource iores;
+	struct resource riores[RIO_MAX_MPORT_RESOURCES];
+	struct rio_msg inb_msg[RIO_MAX_MBOX];
+	struct rio_msg outb_msg[RIO_MAX_MBOX];
+	int host_deviceid;	/* Host device ID */
+	struct rio_ops *ops;	/* maintenance transaction functions */
+	unsigned char id;	/* port ID, unique among all ports */
+	unsigned char index;	/* port index, unique among all port
+				   interfaces of the same type */
+	unsigned char name[40];
+};
+
+/**
+ * struct rio_net - RIO network info
+ * @node: Node in global list of RIO networks
+ * @devices: List of devices in this network
+ * @mports: List of master ports accessing this network
+ * @hport: Default port for accessing this network
+ * @id: RIO network ID
+ */
+struct rio_net {
+	struct list_head node;	/* node in list of networks */
+	struct list_head devices;	/* list of devices in this net */
+	struct list_head mports;	/* list of ports accessing net */
+	struct rio_mport *hport;	/* primary port for accessing net */
+	unsigned char id;	/* RIO network ID */
+};
+
+/**
+ * struct rio_switch - RIO switch info
+ * @node: Node in global list of switches
+ * @switchid: Switch ID that is unique across a network
+ * @hopcount: Hopcount to this switch
+ * @destid: Associated destid in the path
+ * @route_table: Copy of switch routing table
+ * @add_entry: Callback for switch-specific route add function
+ * @get_entry: Callback for switch-specific route get function
+ */
+struct rio_switch {
+	struct list_head node;
+	u16 switchid;
+	u16 hopcount;
+	u16 destid;
+	u8 route_table[RIO_MAX_ROUTE_ENTRIES];
+	int (*add_entry) (struct rio_mport * mport, u16 destid, u8 hopcount,
+			  u16 table, u16 route_destid, u8 route_port);
+	int (*get_entry) (struct rio_mport * mport, u16 destid, u8 hopcount,
+			  u16 table, u16 route_destid, u8 * route_port);
+};
+
+/* Low-level architecture-dependent routines */
+
+/**
+ * struct rio_ops - Low-level RIO configuration space operations
+ * @lcread: Callback to perform local (master port) read of config space.
+ * @lcwrite: Callback to perform local (master port) write of config space.
+ * @cread: Callback to perform network read of config space.
+ * @cwrite: Callback to perform network write of config space.
+ * @dsend: Callback to send a doorbell message.
+ */
+struct rio_ops {
+	int (*lcread) (int index, u32 offset, int len, u32 * data);
+	int (*lcwrite) (int index, u32 offset, int len, u32 data);
+	int (*cread) (int index, u16 destid, u8 hopcount, u32 offset, int len,
+		      u32 * data);
+	int (*cwrite) (int index, u16 destid, u8 hopcount, u32 offset, int len,
+		       u32 data);
+	int (*dsend) (int index, u16 destid, u16 data);
+};
+
+#define RIO_RESOURCE_MEM	0x00000100
+#define RIO_RESOURCE_DOORBELL	0x00000200
+#define RIO_RESOURCE_MAILBOX	0x00000400
+
+#define RIO_RESOURCE_CACHEABLE	0x00010000
+#define RIO_RESOURCE_PCI	0x00020000
+
+#define RIO_RESOURCE_BUSY	0x80000000
+
+/**
+ * struct rio_driver - RIO driver info
+ * @node: Node in list of drivers
+ * @name: RIO driver name
+ * @id_table: RIO device ids to be associated with this driver
+ * @probe: RIO device inserted
+ * @remove: RIO device removed
+ * @suspend: RIO device suspended
+ * @resume: RIO device awakened
+ * @enable_wake: RIO device enable wake event
+ * @driver: LDM driver struct
+ *
+ * Provides info on a RIO device driver for insertion/removal and
+ * power management purposes.
+ */
+struct rio_driver {
+	struct list_head node;
+	char *name;
+	const struct rio_device_id *id_table;
+	int (*probe) (struct rio_dev * dev, const struct rio_device_id * id);
+	void (*remove) (struct rio_dev * dev);
+	int (*suspend) (struct rio_dev * dev, u32 state);
+	int (*resume) (struct rio_dev * dev);
+	int (*enable_wake) (struct rio_dev * dev, u32 state, int enable);
+	struct device_driver driver;
+};
+
+#define	to_rio_driver(drv) container_of(drv,struct rio_driver, driver)
+
+/**
+ * struct rio_device_id - RIO device identifier
+ * @did: RIO device ID
+ * @vid: RIO vendor ID
+ * @asm_did: RIO assembly device ID
+ * @asm_vid: RIO assembly vendor ID
+ *
+ * Identifies a RIO device based on both the device/vendor IDs and
+ * the assembly device/vendor IDs.
+ */
+struct rio_device_id {
+	u16 did, vid;
+	u16 asm_did, asm_vid;
+};
+
+/**
+ * struct rio_route_ops - Per-switch route operations
+ * @vid: RIO vendor ID
+ * @did: RIO device ID
+ * @add_hook: Callback that adds a route entry
+ * @get_hook: Callback that gets a route entry
+ *
+ * Defines the operations that are necessary to manipulate the route
+ * tables for a particular RIO switch device.
+ */
+struct rio_route_ops {
+	u16 vid, did;
+	int (*add_hook) (struct rio_mport * mport, u16 destid, u8 hopcount,
+			 u16 table, u16 route_destid, u8 route_port);
+	int (*get_hook) (struct rio_mport * mport, u16 destid, u8 hopcount,
+			 u16 table, u16 route_destid, u8 * route_port);
+};
+
+/* Architecture and hardware-specific functions */
+extern int rio_init_mports(void);
+extern void rio_register_mport(struct rio_mport *);
+extern int rio_hw_add_outb_message(struct rio_mport *, struct rio_dev *, int,
+				   void *, size_t);
+extern int rio_hw_add_inb_buffer(struct rio_mport *, int, void *);
+extern void *rio_hw_get_inb_message(struct rio_mport *, int);
+extern int rio_open_inb_mbox(struct rio_mport *, int, int);
+extern void rio_close_inb_mbox(struct rio_mport *, int);
+extern int rio_open_outb_mbox(struct rio_mport *, int, int);
+extern void rio_close_outb_mbox(struct rio_mport *, int);
+
+#endif				/* __KERNEL__ */
+#endif				/* LINUX_RIO_H */
diff --git a/include/linux/rio_drv.h b/include/linux/rio_drv.h
new file mode 100644
--- /dev/null
+++ b/include/linux/rio_drv.h
@@ -0,0 +1,469 @@
+/*
+ * RapidIO driver services
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
+#ifndef LINUX_RIO_DRV_H
+#define LINUX_RIO_DRV_H
+
+#ifdef __KERNEL__
+
+#include <linux/types.h>
+#include <linux/config.h>
+#include <linux/ioport.h>
+#include <linux/list.h>
+#include <linux/errno.h>
+#include <linux/device.h>
+#include <linux/rio.h>
+
+extern int __rio_local_read_config_32(struct rio_mport *port, u32 offset,
+				      u32 * data);
+extern int __rio_local_write_config_32(struct rio_mport *port, u32 offset,
+				       u32 data);
+extern int __rio_local_read_config_16(struct rio_mport *port, u32 offset,
+				      u16 * data);
+extern int __rio_local_write_config_16(struct rio_mport *port, u32 offset,
+				       u16 data);
+extern int __rio_local_read_config_8(struct rio_mport *port, u32 offset,
+				     u8 * data);
+extern int __rio_local_write_config_8(struct rio_mport *port, u32 offset,
+				      u8 data);
+
+extern int rio_mport_read_config_32(struct rio_mport *port, u16 destid,
+				    u8 hopcount, u32 offset, u32 * data);
+extern int rio_mport_write_config_32(struct rio_mport *port, u16 destid,
+				     u8 hopcount, u32 offset, u32 data);
+extern int rio_mport_read_config_16(struct rio_mport *port, u16 destid,
+				    u8 hopcount, u32 offset, u16 * data);
+extern int rio_mport_write_config_16(struct rio_mport *port, u16 destid,
+				     u8 hopcount, u32 offset, u16 data);
+extern int rio_mport_read_config_8(struct rio_mport *port, u16 destid,
+				   u8 hopcount, u32 offset, u8 * data);
+extern int rio_mport_write_config_8(struct rio_mport *port, u16 destid,
+				    u8 hopcount, u32 offset, u8 data);
+
+/**
+ * rio_local_read_config_32 - Read 32 bits from local configuration space
+ * @port: Master port
+ * @offset: Offset into local configuration space
+ * @data: Pointer to read data into
+ * 
+ * Reads 32 bits of data from the specified offset within the local
+ * device's configuration space.
+ */
+static inline int rio_local_read_config_32(struct rio_mport *port, u32 offset,
+					   u32 * data)
+{
+	return __rio_local_read_config_32(port, offset, data);
+}
+
+/**
+ * rio_local_write_config_32 - Write 32 bits to local configuration space
+ * @port: Master port
+ * @offset: Offset into local configuration space
+ * @data: Data to be written 
+ * 
+ * Writes 32 bits of data to the specified offset within the local
+ * device's configuration space.
+ */
+static inline int rio_local_write_config_32(struct rio_mport *port, u32 offset,
+					    u32 data)
+{
+	return __rio_local_write_config_32(port, offset, data);
+}
+
+/**
+ * rio_local_read_config_16 - Read 16 bits from local configuration space
+ * @port: Master port
+ * @offset: Offset into local configuration space
+ * @data: Pointer to read data into
+ * 
+ * Reads 16 bits of data from the specified offset within the local
+ * device's configuration space.
+ */
+static inline int rio_local_read_config_16(struct rio_mport *port, u32 offset,
+					   u16 * data)
+{
+	return __rio_local_read_config_16(port, offset, data);
+}
+
+/**
+ * rio_local_write_config_16 - Write 16 bits to local configuration space
+ * @port: Master port
+ * @offset: Offset into local configuration space
+ * @data: Data to be written 
+ * 
+ * Writes 16 bits of data to the specified offset within the local
+ * device's configuration space.
+ */
+
+static inline int rio_local_write_config_16(struct rio_mport *port, u32 offset,
+					    u16 data)
+{
+	return __rio_local_write_config_16(port, offset, data);
+}
+
+/**
+ * rio_local_read_config_8 - Read 8 bits from local configuration space
+ * @port: Master port
+ * @offset: Offset into local configuration space
+ * @data: Pointer to read data into
+ * 
+ * Reads 8 bits of data from the specified offset within the local
+ * device's configuration space.
+ */
+static inline int rio_local_read_config_8(struct rio_mport *port, u32 offset,
+					  u8 * data)
+{
+	return __rio_local_read_config_8(port, offset, data);
+}
+
+/**
+ * rio_local_write_config_8 - Write 8 bits to local configuration space
+ * @port: Master port
+ * @offset: Offset into local configuration space
+ * @data: Data to be written 
+ * 
+ * Writes 8 bits of data to the specified offset within the local
+ * device's configuration space.
+ */
+static inline int rio_local_write_config_8(struct rio_mport *port, u32 offset,
+					   u8 data)
+{
+	return __rio_local_write_config_8(port, offset, data);
+}
+
+/**
+ * rio_read_config_32 - Read 32 bits from configuration space
+ * @rdev: RIO device
+ * @offset: Offset into device configuration space
+ * @data: Pointer to read data into
+ * 
+ * Reads 32 bits of data from the specified offset within the
+ * RIO device's configuration space.
+ */
+static inline int rio_read_config_32(struct rio_dev *rdev, u32 offset,
+				     u32 * data)
+{
+	u8 hopcount = 0xff;
+	u16 destid = rdev->destid;
+
+	if (rdev->rswitch) {
+		destid = rdev->rswitch->destid;
+		hopcount = rdev->rswitch->hopcount;
+	}
+
+	return rio_mport_read_config_32(rdev->net->hport, destid, hopcount,
+					offset, data);
+};
+
+/**
+ * rio_write_config_32 - Write 32 bits to configuration space
+ * @rdev: RIO device
+ * @offset: Offset into device configuration space
+ * @data: Data to be written
+ * 
+ * Writes 32 bits of data to the specified offset within the
+ * RIO device's configuration space.
+ */
+static inline int rio_write_config_32(struct rio_dev *rdev, u32 offset,
+				      u32 data)
+{
+	u8 hopcount = 0xff;
+	u16 destid = rdev->destid;
+
+	if (rdev->rswitch) {
+		destid = rdev->rswitch->destid;
+		hopcount = rdev->rswitch->hopcount;
+	}
+
+	return rio_mport_write_config_32(rdev->net->hport, destid, hopcount,
+					 offset, data);
+};
+
+/**
+ * rio_read_config_16 - Read 16 bits from configuration space
+ * @rdev: RIO device
+ * @offset: Offset into device configuration space
+ * @data: Pointer to read data into
+ * 
+ * Reads 16 bits of data from the specified offset within the
+ * RIO device's configuration space.
+ */
+static inline int rio_read_config_16(struct rio_dev *rdev, u32 offset,
+				     u16 * data)
+{
+	u8 hopcount = 0xff;
+	u16 destid = rdev->destid;
+
+	if (rdev->rswitch) {
+		destid = rdev->rswitch->destid;
+		hopcount = rdev->rswitch->hopcount;
+	}
+
+	return rio_mport_read_config_16(rdev->net->hport, destid, hopcount,
+					offset, data);
+};
+
+/**
+ * rio_write_config_16 - Write 16 bits to configuration space
+ * @rdev: RIO device
+ * @offset: Offset into device configuration space
+ * @data: Data to be written
+ * 
+ * Writes 16 bits of data to the specified offset within the
+ * RIO device's configuration space.
+ */
+static inline int rio_write_config_16(struct rio_dev *rdev, u32 offset,
+				      u16 data)
+{
+	u8 hopcount = 0xff;
+	u16 destid = rdev->destid;
+
+	if (rdev->rswitch) {
+		destid = rdev->rswitch->destid;
+		hopcount = rdev->rswitch->hopcount;
+	}
+
+	return rio_mport_write_config_16(rdev->net->hport, destid, hopcount,
+					 offset, data);
+};
+
+/**
+ * rio_read_config_8 - Read 8 bits from configuration space
+ * @rdev: RIO device
+ * @offset: Offset into device configuration space
+ * @data: Pointer to read data into
+ * 
+ * Reads 8 bits of data from the specified offset within the
+ * RIO device's configuration space.
+ */
+static inline int rio_read_config_8(struct rio_dev *rdev, u32 offset, u8 * data)
+{
+	u8 hopcount = 0xff;
+	u16 destid = rdev->destid;
+
+	if (rdev->rswitch) {
+		destid = rdev->rswitch->destid;
+		hopcount = rdev->rswitch->hopcount;
+	}
+
+	return rio_mport_read_config_8(rdev->net->hport, destid, hopcount,
+				       offset, data);
+};
+
+/**
+ * rio_write_config_8 - Write 8 bits to configuration space
+ * @rdev: RIO device
+ * @offset: Offset into device configuration space
+ * @data: Data to be written
+ * 
+ * Writes 8 bits of data to the specified offset within the
+ * RIO device's configuration space.
+ */
+static inline int rio_write_config_8(struct rio_dev *rdev, u32 offset, u8 data)
+{
+	u8 hopcount = 0xff;
+	u16 destid = rdev->destid;
+
+	if (rdev->rswitch) {
+		destid = rdev->rswitch->destid;
+		hopcount = rdev->rswitch->hopcount;
+	}
+
+	return rio_mport_write_config_8(rdev->net->hport, destid, hopcount,
+					offset, data);
+};
+
+extern int rio_mport_send_doorbell(struct rio_mport *mport, u16 destid,
+				   u16 data);
+
+/**
+ * rio_send_doorbell - Send a doorbell message to a device
+ * @rdev: RIO device
+ * @data: Doorbell message data
+ * 
+ * Send a doorbell message to a RIO device. The doorbell message
+ * has a 16-bit info field provided by the @data argument.
+ */
+static inline int rio_send_doorbell(struct rio_dev *rdev, u16 data)
+{
+	return rio_mport_send_doorbell(rdev->net->hport, rdev->destid, data);
+};
+
+/**
+ * rio_init_mbox_res - Initialize a RIO mailbox resource
+ * @res: resource struct
+ * @start: start of mailbox range
+ * @end: end of mailbox range
+ *
+ * This function is used to initialize the fields of a resource
+ * for use as a mailbox resource.  It initializes a range of
+ * mailboxes using the start and end arguments.
+ */
+static inline void rio_init_mbox_res(struct resource *res, int start, int end)
+{
+	memset(res, 0, sizeof(struct resource));
+	res->start = start;
+	res->end = end;
+	res->flags = RIO_RESOURCE_MAILBOX;
+}
+
+/**
+ * rio_init_dbell_res - Initialize a RIO doorbell resource
+ * @res: resource struct
+ * @start: start of doorbell range
+ * @end: end of doorbell range
+ *
+ * This function is used to initialize the fields of a resource
+ * for use as a doorbell resource.  It initializes a range of
+ * doorbell messages using the start and end arguments.
+ */
+static inline void rio_init_dbell_res(struct resource *res, u16 start, u16 end)
+{
+	memset(res, 0, sizeof(struct resource));
+	res->start = start;
+	res->end = end;
+	res->flags = RIO_RESOURCE_DOORBELL;
+}
+
+/**
+ * RIO_DEVICE - macro used to describe a specific RIO device
+ * @vid: the 16 bit RIO vendor ID
+ * @did: the 16 bit RIO device ID
+ *
+ * This macro is used to create a struct rio_device_id that matches a
+ * specific device.  The assembly vendor and assembly device fields
+ * will be set to %RIO_ANY_ID.
+ */
+#define RIO_DEVICE(dev,ven) \
+	.did = (dev), .vid = (ven), \
+	.asm_did = RIO_ANY_ID, .asm_vid = RIO_ANY_ID
+
+/* Mailbox management */
+extern int rio_request_outb_mbox(struct rio_mport *, int, int,
+				 void (*)(struct rio_mport *, int, int));
+extern int rio_release_outb_mbox(struct rio_mport *, int);
+
+/**
+ * rio_add_outb_message - Add RIO message to an outbound mailbox queue
+ * @mport: RIO master port containing the outbound queue
+ * @rdev: RIO device the message is be sent to
+ * @mbox: The outbound mailbox queue
+ * @buffer: Pointer to the message buffer
+ * @len: Length of the message buffer
+ *
+ * Adds a RIO message buffer to an outbound mailbox queue for
+ * transmission. Returns 0 on success.
+ */
+static inline int rio_add_outb_message(struct rio_mport *mport,
+				       struct rio_dev *rdev, int mbox,
+				       void *buffer, size_t len)
+{
+	return rio_hw_add_outb_message(mport, rdev, mbox, buffer, len);
+}
+
+extern int rio_request_inb_mbox(struct rio_mport *, int, int,
+				void (*)(struct rio_mport *, int, int));
+extern int rio_release_inb_mbox(struct rio_mport *, int);
+
+/**
+ * rio_add_inb_buffer - Add buffer to an inbound mailbox queue
+ * @mport: Master port containing the inbound mailbox
+ * @mbox: The inbound mailbox number
+ * @buffer: Pointer to the message buffer
+ *
+ * Adds a buffer to an inbound mailbox queue for reception. Returns
+ * 0 on success.
+ */
+static inline int rio_add_inb_buffer(struct rio_mport *mport, int mbox,
+				     void *buffer)
+{
+	return rio_hw_add_inb_buffer(mport, mbox, buffer);
+}
+
+/**
+ * rio_get_inb_message - Get A RIO message from an inbound mailbox queue
+ * @mport: Master port containing the inbound mailbox
+ * @mbox: The inbound mailbox number
+ * @buffer: Pointer to the message buffer
+ *
+ * Get a RIO message from an inbound mailbox queue. Returns 0 on success.
+ */
+static inline void *rio_get_inb_message(struct rio_mport *mport, int mbox)
+{
+	return rio_hw_get_inb_message(mport, mbox);
+}
+
+/* Doorbell management */
+extern int rio_request_inb_dbell(struct rio_mport *, u16, u16,
+				 void (*)(struct rio_mport *, u16, u16, u16));
+extern int rio_release_inb_dbell(struct rio_mport *, u16, u16);
+extern struct resource *rio_request_outb_dbell(struct rio_dev *, u16, u16);
+extern int rio_release_outb_dbell(struct rio_dev *, struct resource *);
+
+/* Memory region management */
+int rio_claim_resource(struct rio_dev *, int);
+int rio_request_regions(struct rio_dev *, char *);
+void rio_release_regions(struct rio_dev *);
+int rio_request_region(struct rio_dev *, int, char *);
+void rio_release_region(struct rio_dev *, int);
+
+/* LDM support */
+int rio_register_driver(struct rio_driver *);
+void rio_unregister_driver(struct rio_driver *);
+struct rio_dev *rio_dev_get(struct rio_dev *);
+void rio_dev_put(struct rio_dev *);
+
+/**
+ * rio_name - Get the unique RIO device identifier
+ * @rdev: RIO device
+ *
+ * Get the unique RIO device identifier. Returns the device
+ * identifier string.
+ */
+static inline char *rio_name(struct rio_dev *rdev)
+{
+	return rdev->dev.bus_id;
+}
+
+/**
+ * rio_get_drvdata - Get RIO driver specific data
+ * @rdev: RIO device
+ *
+ * Get RIO driver specific data. Returns a pointer to the
+ * driver specific data.
+ */
+static inline void *rio_get_drvdata(struct rio_dev *rdev)
+{
+	return dev_get_drvdata(&rdev->dev);
+}
+
+/**
+ * rio_set_drvdata - Set RIO driver specific data
+ * @rdev: RIO device
+ * @data: Pointer to driver specific data
+ *
+ * Set RIO driver specific data. device struct driver data pointer
+ * is set to the @data argument.
+ */
+static inline void rio_set_drvdata(struct rio_dev *rdev, void *data)
+{
+	dev_set_drvdata(&rdev->dev, data);
+}
+
+/* Misc driver helpers */
+extern u16 rio_local_get_device_id(struct rio_mport *port);
+extern struct rio_dev *rio_get_device(u16 vid, u16 did, struct rio_dev *from);
+extern struct rio_dev *rio_get_asm(u16 vid, u16 did, u16 asm_vid, u16 asm_did,
+				   struct rio_dev *from);
+
+#endif				/* __KERNEL__ */
+#endif				/* LINUX_RIO_DRV_H */
diff --git a/include/linux/rio_ids.h b/include/linux/rio_ids.h
new file mode 100644
--- /dev/null
+++ b/include/linux/rio_ids.h
@@ -0,0 +1,24 @@
+/*
+ * RapidIO devices
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
+#ifndef LINUX_RIO_IDS_H
+#define LINUX_RIO_IDS_H
+
+#define RIO_ANY_ID			0xffff
+
+#define RIO_VID_FREESCALE		0x0002
+#define RIO_DID_MPC8560			0x0003
+
+#define RIO_VID_TUNDRA			0x000d
+#define RIO_DID_TSI500			0x0500
+
+#endif				/* LINUX_RIO_IDS_H */
diff --git a/include/linux/rio_regs.h b/include/linux/rio_regs.h
new file mode 100644
--- /dev/null
+++ b/include/linux/rio_regs.h
@@ -0,0 +1,202 @@
+/*
+ * RapidIO register definitions
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
+#ifndef LINUX_RIO_REGS_H
+#define LINUX_RIO_REGS_H
+
+/*
+ * In RapidIO, each device has a 2MB configuration space that is
+ * accessed via maintenance transactions.  Portions of configuration
+ * space are standardized and/or reserved.
+ */
+#define RIO_DEV_ID_CAR		0x00	/* [I] Device Identity CAR */
+#define RIO_DEV_INFO_CAR	0x04	/* [I] Device Information CAR */
+#define RIO_ASM_ID_CAR		0x08	/* [I] Assembly Identity CAR */
+#define  RIO_ASM_ID_MASK		0xffff0000	/* [I] Asm ID Mask */
+#define  RIO_ASM_VEN_ID_MASK		0x0000ffff	/* [I] Asm Vend Mask */
+
+#define RIO_ASM_INFO_CAR	0x0c	/* [I] Assembly Information CAR */
+#define  RIO_ASM_REV_MASK		0xffff0000	/* [I] Asm Rev Mask */
+#define  RIO_EXT_FTR_PTR_MASK		0x0000ffff	/* [I] EF_PTR Mask */
+
+#define RIO_PEF_CAR		0x10	/* [I] Processing Element Features CAR */
+#define  RIO_PEF_BRIDGE			0x80000000	/* [I] Bridge */
+#define  RIO_PEF_MEMORY			0x40000000	/* [I] MMIO */
+#define  RIO_PEF_PROCESSOR		0x20000000	/* [I] Processor */
+#define  RIO_PEF_SWITCH			0x10000000	/* [I] Switch */
+#define  RIO_PEF_INB_MBOX		0x00f00000	/* [II] Mailboxes */
+#define  RIO_PEF_INB_MBOX0		0x00800000	/* [II] Mailbox 0 */
+#define  RIO_PEF_INB_MBOX1		0x00400000	/* [II] Mailbox 1 */
+#define  RIO_PEF_INB_MBOX2		0x00200000	/* [II] Mailbox 2 */
+#define  RIO_PEF_INB_MBOX3		0x00100000	/* [II] Mailbox 3 */
+#define  RIO_PEF_INB_DOORBELL		0x00080000	/* [II] Doorbells */
+#define  RIO_PEF_CTLS			0x00000010	/* [III] CTLS */
+#define  RIO_PEF_EXT_FEATURES		0x00000008	/* [I] EFT_PTR valid */
+#define  RIO_PEF_ADDR_66		0x00000004	/* [I] 66 bits */
+#define  RIO_PEF_ADDR_50		0x00000002	/* [I] 50 bits */
+#define  RIO_PEF_ADDR_34		0x00000001	/* [I] 34 bits */
+
+#define RIO_SWP_INFO_CAR	0x14	/* [I] Switch Port Information CAR */
+#define  RIO_SWP_INFO_PORT_TOTAL_MASK	0x0000ff00	/* [I] Total number of ports */
+#define  RIO_SWP_INFO_PORT_NUM_MASK	0x000000ff	/* [I] Maintenance transaction port number */
+#define  RIO_GET_TOTAL_PORTS(x)		((x & RIO_SWP_INFO_PORT_TOTAL_MASK) >> 8)
+
+#define RIO_SRC_OPS_CAR		0x18	/* [I] Source Operations CAR */
+#define  RIO_SRC_OPS_READ		0x00008000	/* [I] Read op */
+#define  RIO_SRC_OPS_WRITE		0x00004000	/* [I] Write op */
+#define  RIO_SRC_OPS_STREAM_WRITE	0x00002000	/* [I] Str-write op */
+#define  RIO_SRC_OPS_WRITE_RESPONSE	0x00001000	/* [I] Write/resp op */
+#define  RIO_SRC_OPS_DATA_MSG		0x00000800	/* [II] Data msg op */
+#define  RIO_SRC_OPS_DOORBELL		0x00000400	/* [II] Doorbell op */
+#define  RIO_SRC_OPS_ATOMIC_TST_SWP	0x00000100	/* [I] Atomic TAS op */
+#define  RIO_SRC_OPS_ATOMIC_INC		0x00000080	/* [I] Atomic inc op */
+#define  RIO_SRC_OPS_ATOMIC_DEC		0x00000040	/* [I] Atomic dec op */
+#define  RIO_SRC_OPS_ATOMIC_SET		0x00000020	/* [I] Atomic set op */
+#define  RIO_SRC_OPS_ATOMIC_CLR		0x00000010	/* [I] Atomic clr op */
+#define  RIO_SRC_OPS_PORT_WRITE		0x00000004	/* [I] Port-write op */
+
+#define RIO_DST_OPS_CAR		0x1c	/* Destination Operations CAR */
+#define  RIO_DST_OPS_READ		0x00008000	/* [I] Read op */
+#define  RIO_DST_OPS_WRITE		0x00004000	/* [I] Write op */
+#define  RIO_DST_OPS_STREAM_WRITE	0x00002000	/* [I] Str-write op */
+#define  RIO_DST_OPS_WRITE_RESPONSE	0x00001000	/* [I] Write/resp op */
+#define  RIO_DST_OPS_DATA_MSG		0x00000800	/* [II] Data msg op */
+#define  RIO_DST_OPS_DOORBELL		0x00000400	/* [II] Doorbell op */
+#define  RIO_DST_OPS_ATOMIC_TST_SWP	0x00000100	/* [I] Atomic TAS op */
+#define  RIO_DST_OPS_ATOMIC_INC		0x00000080	/* [I] Atomic inc op */
+#define  RIO_DST_OPS_ATOMIC_DEC		0x00000040	/* [I] Atomic dec op */
+#define  RIO_DST_OPS_ATOMIC_SET		0x00000020	/* [I] Atomic set op */
+#define  RIO_DST_OPS_ATOMIC_CLR		0x00000010	/* [I] Atomic clr op */
+#define  RIO_DST_OPS_PORT_WRITE		0x00000004	/* [I] Port-write op */
+
+					/* 0x20-0x3c *//* Reserved */
+
+#define RIO_MBOX_CSR		0x40	/* [II] Mailbox CSR */
+#define  RIO_MBOX0_AVAIL		0x80000000	/* [II] Mbox 0 avail */
+#define  RIO_MBOX0_FULL			0x40000000	/* [II] Mbox 0 full */
+#define  RIO_MBOX0_EMPTY		0x20000000	/* [II] Mbox 0 empty */
+#define  RIO_MBOX0_BUSY			0x10000000	/* [II] Mbox 0 busy */
+#define  RIO_MBOX0_FAIL			0x08000000	/* [II] Mbox 0 fail */
+#define  RIO_MBOX0_ERROR		0x04000000	/* [II] Mbox 0 error */
+#define  RIO_MBOX1_AVAIL		0x00800000	/* [II] Mbox 1 avail */
+#define  RIO_MBOX1_FULL			0x00200000	/* [II] Mbox 1 full */
+#define  RIO_MBOX1_EMPTY		0x00200000	/* [II] Mbox 1 empty */
+#define  RIO_MBOX1_BUSY			0x00100000	/* [II] Mbox 1 busy */
+#define  RIO_MBOX1_FAIL			0x00080000	/* [II] Mbox 1 fail */
+#define  RIO_MBOX1_ERROR		0x00040000	/* [II] Mbox 1 error */
+#define  RIO_MBOX2_AVAIL		0x00008000	/* [II] Mbox 2 avail */
+#define  RIO_MBOX2_FULL			0x00004000	/* [II] Mbox 2 full */
+#define  RIO_MBOX2_EMPTY		0x00002000	/* [II] Mbox 2 empty */
+#define  RIO_MBOX2_BUSY			0x00001000	/* [II] Mbox 2 busy */
+#define  RIO_MBOX2_FAIL			0x00000800	/* [II] Mbox 2 fail */
+#define  RIO_MBOX2_ERROR		0x00000400	/* [II] Mbox 2 error */
+#define  RIO_MBOX3_AVAIL		0x00000080	/* [II] Mbox 3 avail */
+#define  RIO_MBOX3_FULL			0x00000040	/* [II] Mbox 3 full */
+#define  RIO_MBOX3_EMPTY		0x00000020	/* [II] Mbox 3 empty */
+#define  RIO_MBOX3_BUSY			0x00000010	/* [II] Mbox 3 busy */
+#define  RIO_MBOX3_FAIL			0x00000008	/* [II] Mbox 3 fail */
+#define  RIO_MBOX3_ERROR		0x00000004	/* [II] Mbox 3 error */
+
+#define RIO_WRITE_PORT_CSR	0x44	/* [I] Write Port CSR */
+#define RIO_DOORBELL_CSR	0x44	/* [II] Doorbell CSR */
+#define  RIO_DOORBELL_AVAIL		0x80000000	/* [II] Doorbell avail */
+#define  RIO_DOORBELL_FULL		0x40000000	/* [II] Doorbell full */
+#define  RIO_DOORBELL_EMPTY		0x20000000	/* [II] Doorbell empty */
+#define  RIO_DOORBELL_BUSY		0x10000000	/* [II] Doorbell busy */
+#define  RIO_DOORBELL_FAILED		0x08000000	/* [II] Doorbell failed */
+#define  RIO_DOORBELL_ERROR		0x04000000	/* [II] Doorbell error */
+#define  RIO_WRITE_PORT_AVAILABLE	0x00000080	/* [I] Write Port Available */
+#define  RIO_WRITE_PORT_FULL		0x00000040	/* [I] Write Port Full */
+#define  RIO_WRITE_PORT_EMPTY		0x00000020	/* [I] Write Port Empty */
+#define  RIO_WRITE_PORT_BUSY		0x00000010	/* [I] Write Port Busy */
+#define  RIO_WRITE_PORT_FAILED		0x00000008	/* [I] Write Port Failed */
+#define  RIO_WRITE_PORT_ERROR		0x00000004	/* [I] Write Port Error */
+
+					/* 0x48 *//* Reserved */
+
+#define RIO_PELL_CTRL_CSR	0x4c	/* [I] PE Logical Layer Control CSR */
+#define   RIO_PELL_ADDR_66		0x00000004	/* [I] 66-bit addr */
+#define   RIO_PELL_ADDR_50		0x00000002	/* [I] 50-bit addr */
+#define   RIO_PELL_ADDR_34		0x00000001	/* [I] 34-bit addr */
+
+					/* 0x50-0x54 *//* Reserved */
+
+#define RIO_LCSH_BA		0x58	/* [I] LCS High Base Address */
+#define RIO_LCSL_BA		0x5c	/* [I] LCS Base Address */
+
+#define RIO_DID_CSR		0x60	/* [III] Base Device ID CSR */
+
+					/* 0x64 *//* Reserved */
+
+#define RIO_HOST_DID_LOCK_CSR	0x68	/* [III] Host Base Device ID Lock CSR */
+#define RIO_COMPONENT_TAG_CSR	0x6c	/* [III] Component Tag CSR */
+
+					/* 0x70-0xf8 *//* Reserved */
+					/* 0x100-0xfff8 *//* [I] Extended Features Space */
+					/* 0x10000-0xfffff8 *//* [I] Implementation-defined Space */
+
+/*
+ * Extended Features Space is a configuration space area where
+ * functionality is mapped into extended feature blocks via a
+ * singly linked list of extended feature pointers (EFT_PTR).
+ *
+ * Each extended feature block can be identified/located in
+ * Extended Features Space by walking the extended feature
+ * list starting with the Extended Feature Pointer located
+ * in the Assembly Information CAR.
+ *
+ * Extended Feature Blocks (EFBs) are identified with an assigned
+ * EFB ID. Extended feature block offsets in the definitions are
+ * relative to the offset of the EFB within the  Extended Features
+ * Space.
+ */
+
+/* Helper macros to parse the Extended Feature Block header */
+#define RIO_EFB_PTR_MASK	0xffff0000
+#define RIO_EFB_ID_MASK		0x0000ffff
+#define RIO_GET_BLOCK_PTR(x)	((x & RIO_EFB_PTR_MASK) >> 16)
+#define RIO_GET_BLOCK_ID(x)	(x & RIO_EFB_ID_MASK)
+
+/* Extended Feature Block IDs */
+#define RIO_EFB_PAR_EP_ID	0x0001	/* [IV] LP/LVDS EP Devices */
+#define RIO_EFB_PAR_EP_REC_ID	0x0002	/* [IV] LP/LVDS EP Recovery Devices */
+#define RIO_EFB_PAR_EP_FREE_ID	0x0003	/* [IV] LP/LVDS EP Free Devices */
+#define RIO_EFB_SER_EP_ID	0x0004	/* [VI] LP/Serial EP Devices */
+#define RIO_EFB_SER_EP_REC_ID	0x0005	/* [VI] LP/Serial EP Recovery Devices */
+#define RIO_EFB_SER_EP_FREE_ID	0x0006	/* [VI] LP/Serial EP Free Devices */
+
+/*
+ * Physical 8/16 LP-LVDS
+ * ID=0x0001, Generic End Point Devices
+ * ID=0x0002, Generic End Point Devices, software assisted recovery option
+ * ID=0x0003, Generic End Point Free Devices
+ *
+ * Physical LP-Serial
+ * ID=0x0004, Generic End Point Devices
+ * ID=0x0005, Generic End Point Devices, software assisted recovery option
+ * ID=0x0006, Generic End Point Free Devices
+ */
+#define RIO_PORT_MNT_HEADER		0x0000
+#define RIO_PORT_REQ_CTL_CSR		0x0020
+#define RIO_PORT_RSP_CTL_CSR		0x0024	/* 0x0001/0x0002 */
+#define RIO_PORT_GEN_CTL_CSR		0x003c
+#define  RIO_PORT_GEN_HOST		0x80000000
+#define  RIO_PORT_GEN_MASTER		0x40000000
+#define  RIO_PORT_GEN_DISCOVERED	0x20000000
+#define RIO_PORT_N_MNT_REQ_CSR(x)	(0x0040 + x*0x20)	/* 0x0002 */
+#define RIO_PORT_N_MNT_RSP_CSR(x)	(0x0044 + x*0x20)	/* 0x0002 */
+#define RIO_PORT_N_ACK_STS_CSR(x)	(0x0048 + x*0x20)	/* 0x0002 */
+#define RIO_PORT_N_ERR_STS_CSR(x)	(0x58 + x*0x20)
+#define PORT_N_ERR_STS_PORT_OK	0x00000002
+#define RIO_PORT_N_CTL_CSR(x)		(0x5c + x*0x20)
+
+#endif				/* LINUX_RIO_REGS_H */

