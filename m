Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262472AbSKTTcK>; Wed, 20 Nov 2002 14:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262469AbSKTTcK>; Wed, 20 Nov 2002 14:32:10 -0500
Received: from host194.steeleye.com ([66.206.164.34]:263 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S262803AbSKTTbY>; Wed, 20 Nov 2002 14:31:24 -0500
Message-Id: <200211201938.gAKJcHa03853@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com,
       Project MCA Team <mcalinux@acc.umu.se>,
       David Weinehall <tao@acc.umu.se>
Subject: [PATCH] MCA sysfs part II - bus abstraction
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_14444725580"
Date: Wed, 20 Nov 2002 13:38:17 -0600
From: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_14444725580
Content-Type: text/plain; charset=us-ascii

The attached patch applies on top of the previous MCA sysfs one.

This one introduces the new API for handling MCA devices and abstracts the 
actual MCA handling away from the hardware implementation (any raving lunatic 
want to try an RS6000 port?).

In order to do a SCSI driver test conversion, I'm going to need the dma_mask 
into struct device patch.

This is also available in a bitkeeper tree:

http://linux-voyager.bkbits.net/mca-sysfs-2.5

James


--==_Exmh_14444725580
Content-Type: text/plain ; name="mca-sysfs-II.diff"; charset=us-ascii
Content-Description: mca-sysfs-II.diff
Content-Disposition: attachment; filename="mca-sysfs-II.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.843   -> 1.844  
#	drivers/mca/mca-legacy.c	1.1     -> 1.2    
#	 include/linux/mca.h	1.2     -> 1.3    
#	arch/i386/kernel/mca.c	1.10    -> 1.11   
#	drivers/mca/Makefile	1.1     -> 1.2    
#	               (new)	        -> 1.1     include/asm-i386/mca.h
#	               (new)	        -> 1.1     drivers/mca/mca-device.c
#	               (new)	        -> 1.1     include/linux/mca-legacy.h
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/11/20	jejb@mulgrave.(none)	1.844
# MCA sysfs Part II - abstract out the hw specific pieces
# 
# Just in case some raving lunatic wants to add other platform
# support for MCA (like RS6000)
# 
# Abstract the hardware pieces from the general MCA bus handling
# Make all bus and pos accesses go through special accessor registers
# add transform functions for multiple MCA bus machines
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/mca.c b/arch/i386/kernel/mca.c
--- a/arch/i386/kernel/mca.c	Wed Nov 20 13:31:07 2002
+++ b/arch/i386/kernel/mca.c	Wed Nov 20 13:31:07 2002
@@ -158,6 +158,86 @@
 	return found;
 }
 
+static unsigned char mca_pc_read_pos(struct mca_device *mca_dev, int reg)
+{
+	unsigned char byte;
+	unsigned long flags;
+
+	if(reg < 0 || reg >= 8)
+		return 0;
+
+	spin_lock_irqsave(&mca_lock, flags);
+	if(mca_dev->pos_register) {
+		/* Disable adapter setup, enable motherboard setup */
+
+		outb_p(0, MCA_ADAPTER_SETUP_REG);
+		outb_p(mca_dev->pos_register, MCA_MOTHERBOARD_SETUP_REG);
+
+		byte = inb_p(MCA_POS_REG(reg));
+		outb_p(0xff, MCA_MOTHERBOARD_SETUP_REG);
+	} else {
+
+		/* Make sure motherboard setup is off */
+
+		outb_p(0xff, MCA_MOTHERBOARD_SETUP_REG);
+
+		/* Read the appropriate register */
+
+		outb_p(0x8|(mca_dev->slot & 0xf), MCA_ADAPTER_SETUP_REG);
+		byte = inb_p(MCA_POS_REG(reg));
+		outb_p(0, MCA_ADAPTER_SETUP_REG);
+	}
+	spin_unlock_irqrestore(&mca_lock, flags);
+
+	mca_dev->pos[reg] = byte;
+
+	return byte;
+}
+
+static void mca_pc_write_pos(struct mca_device *mca_dev, int reg,
+			     unsigned char byte)
+{
+	unsigned long flags;
+
+	if(reg < 0 || reg >= 8)
+		return;
+
+	spin_lock_irqsave(&mca_lock, flags);
+
+	/* Make sure motherboard setup is off */
+
+	outb_p(0xff, MCA_MOTHERBOARD_SETUP_REG);
+
+	/* Read in the appropriate register */
+
+	outb_p(0x8|(mca_dev->slot&0xf), MCA_ADAPTER_SETUP_REG);
+	outb_p(byte, MCA_POS_REG(reg));
+	outb_p(0, MCA_ADAPTER_SETUP_REG);
+
+	spin_unlock_irqrestore(&mca_lock, flags);
+
+	/* Update the global register list, while we have the byte */
+
+	mca_dev->pos[reg] = byte;
+
+}
+
+/* for the primary MCA bus, we have identity transforms */
+static int mca_dummy_transform_irq(struct mca_device * mca_dev, int irq)
+{
+	return irq;
+}
+
+static int mca_dummy_transform_ioport(struct mca_device * mca_dev, int port)
+{
+	return port;
+}
+
+static void *mca_dummy_transform_memory(struct mca_device * mca_dev, void *mem)
+{
+	return mem;
+}
+
 
 static int __init mca_init(void)
 {
@@ -189,6 +269,11 @@
 	/* All MCA systems have at least a primary bus */
 	bus = mca_attach_bus(MCA_PRIMARY_BUS);
 	bus->default_dma_mask = 0xffffffffLL;
+	bus->f.mca_write_pos = mca_pc_write_pos;
+	bus->f.mca_read_pos = mca_pc_read_pos;
+	bus->f.mca_transform_irq = mca_dummy_transform_irq;
+	bus->f.mca_transform_ioport = mca_dummy_transform_ioport;
+	bus->f.mca_transform_memory = mca_dummy_transform_memory;
 
 	/* get the motherboard device */
 	mca_dev = kmalloc(sizeof(struct mca_device), GFP_KERNEL);
diff -Nru a/drivers/mca/Makefile b/drivers/mca/Makefile
--- a/drivers/mca/Makefile	Wed Nov 20 13:31:07 2002
+++ b/drivers/mca/Makefile	Wed Nov 20 13:31:07 2002
@@ -1,6 +1,6 @@
 # Makefile for the Linux MCA bus support
 
-obj-y	:= mca-bus.o mca-legacy.o
+obj-y	:= mca-bus.o mca-device.o mca-legacy.o
 
 obj-$(CONFIG_PROC_FS)	+= mca-proc.o
 
diff -Nru a/drivers/mca/mca-device.c b/drivers/mca/mca-device.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/mca/mca-device.c	Wed Nov 20 13:31:07 2002
@@ -0,0 +1,202 @@
+/* -*- mode: c; c-basic-offset: 8 -*- */
+
+/*
+ * MCA device support functions
+ *
+ * These functions support the ongoing device access API.
+ *
+ * (C) 2002 James Bottomley <James.Bottomley@HansenPartnership.com>
+ *
+**-----------------------------------------------------------------------------
+**  
+**  This program is free software; you can redistribute it and/or modify
+**  it under the terms of the GNU General Public License as published by
+**  the Free Software Foundation; either version 2 of the License, or
+**  (at your option) any later version.
+**
+**  This program is distributed in the hope that it will be useful,
+**  but WITHOUT ANY WARRANTY; without even the implied warranty of
+**  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+**  GNU General Public License for more details.
+**
+**  You should have received a copy of the GNU General Public License
+**  along with this program; if not, write to the Free Software
+**  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+**
+**-----------------------------------------------------------------------------
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/mca.h>
+
+/**
+ *	mca_device_read_stored_pos - read POS register from stored data
+ *	@mca_dev: device to read from
+ *	@reg:  register to read from
+ *
+ *	Fetch a POS value that was stored at boot time by the kernel
+ *	when it scanned the MCA space. The register value is returned.
+ *	Missing or invalid registers report 0.
+ */
+unsigned char mca_device_read_stored_pos(struct mca_device *mca_dev, int reg)
+{
+	if(reg < 0 || reg >= 8)
+		return 0;
+
+	return mca_dev->pos[reg];
+}
+EXPORT_SYMBOL(mca_device_read_stored_pos);
+
+/**
+ *	mca_device_read_pos - read POS register from card
+ *	@mca_dev: device to read from
+ *	@reg:  register to read from
+ *
+ *	Fetch a POS value directly from the hardware to obtain the
+ *	current value. This is much slower than
+ *	mca_device_read_stored_pos and may not be invoked from
+ *	interrupt context. It handles the deep magic required for
+ *	onboard devices transparently.
+ */
+unsigned char mca_device_read_pos(struct mca_device *mca_dev, int reg)
+{
+	struct mca_bus *mca_bus = to_mca_bus(mca_dev->dev.parent);
+
+	return mca_bus->f.mca_read_pos(mca_dev, reg);
+
+	return 	mca_dev->pos[reg];
+}
+EXPORT_SYMBOL(mca_device_read_pos);
+
+
+/**
+ *	mca_device_write_pos - read POS register from card
+ *	@mca_dev: device to write pos register to
+ *	@reg:  register to write to
+ *	@byte: byte to write to the POS registers
+ *
+ *	Store a POS value directly to the hardware. You should not
+ *	normally need to use this function and should have a very good
+ *	knowledge of MCA bus before you do so. Doing this wrongly can
+ *	damage the hardware.
+ *
+ *	This function may not be used from interrupt context.
+ *
+ */
+void mca_device_write_pos(struct mca_device *mca_dev, int reg,
+			  unsigned char byte)
+{
+	struct mca_bus *mca_bus = to_mca_bus(mca_dev->dev.parent);
+
+	mca_bus->f.mca_write_pos(mca_dev, reg, byte);
+}
+EXPORT_SYMBOL(mca_device_write_pos);
+
+/**
+ *	mca_device_transform_irq - transform the ADF obtained IRQ
+ *	@mca_device: device whose irq needs transforming
+ *	@irq: input irq from ADF
+ *
+ *	MCA Adapter Definition Files (ADF) contain irq, ioport, memory
+ *	etc. definitions.  In systems with more than one bus, these need
+ *	to be transformed through bus mapping functions to get the real
+ *	system global quantities.
+ *
+ *	This function transforms the interrupt number and returns the
+ *	transformed system global interrupt
+ */
+int mca_device_transform_irq(struct mca_device *mca_dev, int irq)
+{
+	struct mca_bus *mca_bus = to_mca_bus(mca_dev->dev.parent);
+
+	return mca_bus->f.mca_transform_irq(mca_dev, irq);
+}
+EXPORT_SYMBOL(mca_device_transform_irq);
+
+/**
+ *	mca_device_transform_ioport - transform the ADF obtained I/O port
+ *	@mca_device: device whose port needs transforming
+ *	@ioport: input I/O port from ADF
+ *
+ *	MCA Adapter Definition Files (ADF) contain irq, ioport, memory
+ *	etc. definitions.  In systems with more than one bus, these need
+ *	to be transformed through bus mapping functions to get the real
+ *	system global quantities.
+ *
+ *	This function transforms the I/O port number and returns the
+ *	transformed system global port number.
+ *
+ *	This transformation can be assumed to be linear for port ranges.
+ */
+int mca_device_transform_ioport(struct mca_device *mca_dev, int port)
+{
+	struct mca_bus *mca_bus = to_mca_bus(mca_dev->dev.parent);
+
+	return mca_bus->f.mca_transform_ioport(mca_dev, port);
+}
+EXPORT_SYMBOL(mca_device_transform_ioport);
+
+/**
+ *	mca_device_transform_memory - transform the ADF obtained memory
+ *	@mca_device: device whose memory region needs transforming
+ *	@mem: memory region start from ADF
+ *
+ *	MCA Adapter Definition Files (ADF) contain irq, ioport, memory
+ *	etc. definitions.  In systems with more than one bus, these need
+ *	to be transformed through bus mapping functions to get the real
+ *	system global quantities.
+ *
+ *	This function transforms the memory region start and returns the
+ *	transformed system global memory region (physical).
+ *
+ *	This transformation can be assumed to be linear for region ranges.
+ */
+void *mca_device_transform_memory(struct mca_device *mca_dev, void *mem)
+{
+	struct mca_bus *mca_bus = to_mca_bus(mca_dev->dev.parent);
+
+	return mca_bus->f.mca_transform_memory(mca_dev, mem);
+}
+EXPORT_SYMBOL(mca_device_transform_memory);
+
+
+/**
+ *	mca_device_claimed - check if claimed by driver
+ *	@mca_dev:	device to check
+ *
+ *	Returns 1 if the slot has been claimed by a driver
+ */
+
+int mca_device_claimed(struct mca_device *mca_dev)
+{
+	return mca_dev->driver_loaded;
+}
+EXPORT_SYMBOL(mca_device_claimed);
+
+/**
+ *	mca_device_set_claim - set the claim value of the driver
+ *	@mca_dev:	device to set value for
+ *	@val:		claim value to set (1 claimed, 0 unclaimed)
+ */
+void mca_device_set_claim(struct mca_device *mca_dev, int val)
+{
+	mca_dev->driver_loaded = val;
+}
+EXPORT_SYMBOL(mca_device_set_claim);
+
+/**
+ *	mca_device_status - get the status of the device
+ *	@mca_device:	device to get
+ *
+ *	returns an enumeration of the device status:
+ *
+ *	MCA_ADAPTER_NORMAL	adapter is OK.
+ *	MCA_ADAPTER_NONE	no adapter at device (should never happen).
+ *	MCA_ADAPTER_DISABLED	adapter is disabled.
+ *	MCA_ADAPTER_ERROR	adapter cannot be initialised.
+ */
+enum MCA_AdapterStatus mca_device_status(struct mca_device *mca_dev)
+{
+	return mca_dev->status;
+}
diff -Nru a/drivers/mca/mca-legacy.c b/drivers/mca/mca-legacy.c
--- a/drivers/mca/mca-legacy.c	Wed Nov 20 13:31:07 2002
+++ b/drivers/mca/mca-legacy.c	Wed Nov 20 13:31:07 2002
@@ -198,10 +198,7 @@
 	if(!mca_dev)
 		return 0;
 
-	if(reg < 0 || reg >= 8)
-		return 0;
-
-	return mca_dev->pos[reg];
+	return mca_device_read_stored_pos(mca_dev, reg);
 }
 EXPORT_SYMBOL(mca_read_stored_pos);
 
@@ -220,40 +217,11 @@
 unsigned char mca_read_pos(int slot, int reg)
 {
 	struct mca_device *mca_dev = mca_find_device_by_slot(slot);
-	char byte;
-	unsigned long flags;
 
 	if(!mca_dev)
 		return 0;
 
-	if(reg < 0 || reg >= 8)
-		return 0;
-
-	spin_lock_irqsave(&mca_lock, flags);
-	if(mca_dev->pos_register) {
-		/* Disable adapter setup, enable motherboard setup */
-
-		outb_p(0, MCA_ADAPTER_SETUP_REG);
-		outb_p(mca_dev->pos_register, MCA_MOTHERBOARD_SETUP_REG);
-
-		byte = inb_p(MCA_POS_REG(reg));
-		outb_p(0xff, MCA_MOTHERBOARD_SETUP_REG);
-	} else {
-
-		/* Make sure motherboard setup is off */
-
-		outb_p(0xff, MCA_MOTHERBOARD_SETUP_REG);
-
-		/* Read the appropriate register */
-
-		outb_p(0x8|(mca_dev->slot & 0xf), MCA_ADAPTER_SETUP_REG);
-		byte = inb_p(MCA_POS_REG(reg));
-		outb_p(0, MCA_ADAPTER_SETUP_REG);
-	}
-	spin_unlock_irqrestore(&mca_lock, flags);
-	mca_dev->pos[reg] = byte;
-
-	return byte;
+	return mca_device_read_pos(mca_dev, reg);
 }
 EXPORT_SYMBOL(mca_read_pos);
 
@@ -285,31 +253,11 @@
 void mca_write_pos(int slot, int reg, unsigned char byte)
 {
 	struct mca_device *mca_dev = mca_find_device_by_slot(slot);
-	unsigned long flags;
 
 	if(!mca_dev)
 		return;
 
-	if(reg < 0 || reg >= 8)
-		return;
-
-	spin_lock_irqsave(&mca_lock, flags);
-
-	/* Make sure motherboard setup is off */
-
-	outb_p(0xff, MCA_MOTHERBOARD_SETUP_REG);
-
-	/* Read in the appropriate register */
-
-	outb_p(0x8|(slot&0xf), MCA_ADAPTER_SETUP_REG);
-	outb_p(byte, MCA_POS_REG(reg));
-	outb_p(0, MCA_ADAPTER_SETUP_REG);
-
-	spin_unlock_irqrestore(&mca_lock, flags);
-
-	/* Update the global register list, while we have the byte */
-
-	mca_dev->pos[reg] = byte;
+	mca_device_write_pos(mca_dev, reg, byte);
 }
 EXPORT_SYMBOL(mca_write_pos);
 
@@ -368,7 +316,7 @@
 	if(!mca_dev)
 		return 0;
 
-	return mca_dev->driver_loaded;
+	return mca_device_claimed(mca_dev);
 }
 EXPORT_SYMBOL(mca_is_adapter_used);
 
@@ -391,10 +339,10 @@
 		/* FIXME: this is actually a severe error */
 		return 1;
 
-	if(mca_dev->driver_loaded)
+	if(mca_device_claimed(mca_dev))
 		return 1;
 
-	mca_dev->driver_loaded = 1;
+	mca_device_set_claim(mca_dev, 1);
 
 	return 0;
 }
@@ -414,7 +362,7 @@
 	if(!mca_dev)
 		return;
 
-	mca_dev->driver_loaded = 0;
+	mca_device_set_claim(mca_dev, 0);
 }
 EXPORT_SYMBOL(mca_mark_as_unused);
 
@@ -429,12 +377,15 @@
 int mca_isadapter(int slot)
 {
 	struct mca_device *mca_dev = mca_find_device_by_slot(slot);
+	enum MCA_AdapterStatus status;
 
 	if(!mca_dev)
 		return 0;
 
-	return mca_dev->status == MCA_ADAPTER_NORMAL
-		|| mca_dev->status == MCA_ADAPTER_DISABLED;
+	status = mca_device_status(mca_dev);
+
+	return status == MCA_ADAPTER_NORMAL
+		|| status == MCA_ADAPTER_DISABLED;
 }
 EXPORT_SYMBOL(mca_isadapter);
 
@@ -453,5 +404,5 @@
 	if(!mca_dev)
 		return 0;
 
-	return mca_dev->status == MCA_ADAPTER_NORMAL;
+	return mca_device_status(mca_dev) == MCA_ADAPTER_NORMAL;
 }
diff -Nru a/include/asm-i386/mca.h b/include/asm-i386/mca.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/mca.h	Wed Nov 20 13:31:07 2002
@@ -0,0 +1,46 @@
+/* -*- mode: c; c-basic-offset: 8 -*- */
+
+/* Platform specific MCA defines */
+#ifndef _ASM_MCA_H
+#define _ASM_MCA_H
+
+/* Maximal number of MCA slots - actually, some machines have less, but
+ * they all have sufficient number of POS registers to cover 8.
+ */
+#define MCA_MAX_SLOT_NR  8
+
+/* Most machines have only one MCA bus.  The only multiple bus machines
+ * I know have at most two */
+#define MAX_MCA_BUSSES 2
+
+#define MCA_PRIMARY_BUS		0
+#define MCA_SECONDARY_BUS	1
+
+/* Dummy slot numbers on primary MCA for integrated functions */
+#define MCA_INTEGSCSI	(MCA_MAX_SLOT_NR)
+#define MCA_INTEGVIDEO	(MCA_MAX_SLOT_NR+1)
+#define MCA_MOTHERBOARD (MCA_MAX_SLOT_NR+2)
+
+/* Dummy POS values for integrated functions */
+#define MCA_DUMMY_POS_START	0x10000
+#define MCA_INTEGSCSI_POS	(MCA_DUMMY_POS_START+1)
+#define MCA_INTEGVIDEO_POS	(MCA_DUMMY_POS_START+2)
+#define MCA_MOTHERBOARD_POS	(MCA_DUMMY_POS_START+3)
+
+/* MCA registers */
+
+#define MCA_MOTHERBOARD_SETUP_REG	0x94
+#define MCA_ADAPTER_SETUP_REG		0x96
+#define MCA_POS_REG(n)			(0x100+(n))
+
+#define MCA_ENABLED	0x01	/* POS 2, set if adapter enabled */
+
+/* Max number of adapters, including both slots and various integrated
+ * things.
+ */
+#define MCA_NUMADAPTERS (MCA_MAX_SLOT_NR+3)
+
+/* lock to protect access to the MCA registers */
+extern spinlock_t mca_lock;
+
+#endif
diff -Nru a/include/linux/mca-legacy.h b/include/linux/mca-legacy.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/mca-legacy.h	Wed Nov 20 13:31:07 2002
@@ -0,0 +1,81 @@
+/* -*- mode: c; c-basic-offset: 8 -*- */
+
+/* This is the function prototypes for the old legacy MCA interface
+ *
+ * Please move your driver to the new sysfs based one instead */
+
+#ifndef _LINUX_MCA_LEGACY_H
+#define _LINUX_MCA_LEGACY_H
+
+/* MCA_NOTFOUND is an error condition.  The other two indicate
+ * motherboard POS registers contain the adapter.  They might be
+ * returned by the mca_find_adapter() function, and can be used as
+ * arguments to mca_read_stored_pos().  I'm not going to allow direct
+ * access to the motherboard registers until we run across an adapter
+ * that requires it.  We don't know enough about them to know if it's
+ * safe.
+ *
+ * See Documentation/mca.txt or one of the existing drivers for
+ * more information.
+ */
+#define MCA_NOTFOUND	(-1)
+
+
+
+/* Returns the slot of the first enabled adapter matching id.  User can
+ * specify a starting slot beyond zero, to deal with detecting multiple
+ * devices.  Returns MCA_NOTFOUND if id not found.  Also checks the
+ * integrated adapters.
+ */
+extern int mca_find_adapter(int id, int start);
+extern int mca_find_unused_adapter(int id, int start);
+
+/* adapter state info - returns 0 if no */
+extern int mca_isadapter(int slot);
+extern int mca_isenabled(int slot);
+
+extern int mca_is_adapter_used(int slot);
+extern int mca_mark_as_used(int slot);
+extern void mca_mark_as_unused(int slot);
+
+/* gets a byte out of POS register (stored in memory) */
+extern unsigned char mca_read_stored_pos(int slot, int reg);
+
+/* This can be expanded later.  Right now, it gives us a way of
+ * getting meaningful information into the MCA_info structure,
+ * so we can have a more interesting /proc/mca.
+ */
+extern void mca_set_adapter_name(int slot, char* name);
+extern char* mca_get_adapter_name(int slot);
+
+/* These routines actually mess with the hardware POS registers.  They
+ * temporarily disable the device (and interrupts), so make sure you know
+ * what you're doing if you use them.  Furthermore, writing to a POS may
+ * result in two devices trying to share a resource, which in turn can
+ * result in multiple devices sharing memory spaces, IRQs, or even trashing
+ * hardware.  YOU HAVE BEEN WARNED.
+ *
+ * You can only access slots with this.  Motherboard registers are off
+ * limits.
+ */
+
+/* read a byte from the specified POS register. */
+extern unsigned char mca_read_pos(int slot, int reg);
+
+/* write a byte to the specified POS register. */
+extern void mca_write_pos(int slot, int reg, unsigned char byte);
+
+#ifdef CONFIG_PROC_FS
+extern void mca_do_proc_init(void);
+extern void mca_set_adapter_procfn(int slot, MCA_ProcFn, void* dev);
+#else
+static inline void mca_do_proc_init(void)
+{
+}
+
+static inline void mca_set_adapter_procfn(int slot, MCA_ProcFn *fn, void* dev)
+{
+}
+#endif
+
+#endif
diff -Nru a/include/linux/mca.h b/include/linux/mca.h
--- a/include/linux/mca.h	Wed Nov 20 13:31:07 2002
+++ b/include/linux/mca.h	Wed Nov 20 13:31:07 2002
@@ -11,6 +11,9 @@
  * are sorted out */
 #include <linux/device.h>
 
+/* get the platform specific defines */
+#include <asm/mca.h>
+
 /* The detection of MCA bus is done in the real mode (using BIOS).
  * The information is exported to the protected code, where this
  * variable is set to one in case MCA bus was detected.
@@ -19,79 +22,6 @@
 extern int  MCA_bus;
 #endif
 
-/* Maximal number of MCA slots - actually, some machines have less, but
- * they all have sufficient number of POS registers to cover 8.
- */
-#define MCA_MAX_SLOT_NR  8
-
-/* Most machines have only one MCA bus.  The only multiple bus machines
- * I know have at most two */
-#define MAX_MCA_BUSSES 2
-
-#define MCA_PRIMARY_BUS		0
-#define MCA_SECONDARY_BUS	1
-
-/* MCA_NOTFOUND is an error condition.  The other two indicate
- * motherboard POS registers contain the adapter.  They might be
- * returned by the mca_find_adapter() function, and can be used as
- * arguments to mca_read_stored_pos().  I'm not going to allow direct
- * access to the motherboard registers until we run across an adapter
- * that requires it.  We don't know enough about them to know if it's
- * safe.
- *
- * See Documentation/mca.txt or one of the existing drivers for
- * more information.
- */
-#define MCA_NOTFOUND	(-1)
-#define MCA_INTEGSCSI	(MCA_MAX_SLOT_NR)
-#define MCA_INTEGVIDEO	(MCA_MAX_SLOT_NR+1)
-#define MCA_MOTHERBOARD (MCA_MAX_SLOT_NR+2)
-
-#define MCA_DUMMY_POS_START	0x10000
-#define MCA_INTEGSCSI_POS	(MCA_DUMMY_POS_START+1)
-#define MCA_INTEGVIDEO_POS	(MCA_DUMMY_POS_START+2)
-#define MCA_MOTHERBOARD_POS	(MCA_DUMMY_POS_START+3)
-
-
-/* MCA registers */
-
-#define MCA_MOTHERBOARD_SETUP_REG	0x94
-#define MCA_ADAPTER_SETUP_REG		0x96
-#define MCA_POS_REG(n)			(0x100+(n))
-
-#define MCA_ENABLED	0x01	/* POS 2, set if adapter enabled */
-
-/* Max number of adapters, including both slots and various integrated
- * things.
- */
-#define MCA_NUMADAPTERS (MCA_MAX_SLOT_NR+3)
-
-/* Returns the slot of the first enabled adapter matching id.  User can
- * specify a starting slot beyond zero, to deal with detecting multiple
- * devices.  Returns MCA_NOTFOUND if id not found.  Also checks the
- * integrated adapters.
- */
-extern int mca_find_adapter(int id, int start);
-extern int mca_find_unused_adapter(int id, int start);
-
-/* adapter state info - returns 0 if no */
-extern int mca_isadapter(int slot);
-extern int mca_isenabled(int slot);
-
-extern int mca_is_adapter_used(int slot);
-extern int mca_mark_as_used(int slot);
-extern void mca_mark_as_unused(int slot);
-
-/* gets a byte out of POS register (stored in memory) */
-extern unsigned char mca_read_stored_pos(int slot, int reg);
-
-/* This can be expanded later.  Right now, it gives us a way of
- * getting meaningful information into the MCA_info structure,
- * so we can have a more interesting /proc/mca.
- */
-extern void mca_set_adapter_name(int slot, char* name);
-extern char* mca_get_adapter_name(int slot);
-
 /* This sets up an information callback for /proc/mca/slot?.  The
  * function is called with the buffer, slot, and device pointer (or
  * some equally informative context information, or nothing, if you
@@ -105,23 +35,6 @@
  */
 typedef int (*MCA_ProcFn)(char* buf, int slot, void* dev);
 
-/* These routines actually mess with the hardware POS registers.  They
- * temporarily disable the device (and interrupts), so make sure you know
- * what you're doing if you use them.  Furthermore, writing to a POS may
- * result in two devices trying to share a resource, which in turn can
- * result in multiple devices sharing memory spaces, IRQs, or even trashing
- * hardware.  YOU HAVE BEEN WARNED.
- *
- * You can only access slots with this.  Motherboard registers are off
- * limits.
- */
-
-/* read a byte from the specified POS register. */
-extern unsigned char mca_read_pos(int slot, int reg);
-
-/* write a byte to the specified POS register. */
-extern void mca_write_pos(int slot, int reg, unsigned char byte);
-
 /* Should only be called by the NMI interrupt handler, this will do some
  * fancy stuff to figure out what might have generated a NMI.
  */
@@ -134,13 +47,6 @@
 	MCA_ADAPTER_ERROR = 3
 };
 
-struct mca_bus {
-	u64			default_dma_mask;
-	int			number;
-	struct device		dev;
-};
-#define to_mca_bus(mdev) container_of(mdev, struct mca_bus, dev)
-
 struct mca_device {
 	u64			dma_mask;
 	int			pos_id;
@@ -167,34 +73,55 @@
 };
 #define to_mca_device(mdev) container_of(mdev, struct mca_device, dev)
 
+struct mca_bus_accessor_functions {
+	unsigned char	(*mca_read_pos)(struct mca_device *, int reg);
+	void		(*mca_write_pos)(struct mca_device *, int reg,
+					 unsigned char byte);
+	int		(*mca_transform_irq)(struct mca_device *, int irq);
+	int		(*mca_transform_ioport)(struct mca_device *,
+						  int region);
+	void *		(*mca_transform_memory)(struct mca_device *,
+						void *memory);
+};
+
+struct mca_bus {
+	u64			default_dma_mask;
+	int			number;
+	struct mca_bus_accessor_functions f;
+	struct device		dev;
+};
+#define to_mca_bus(mdev) container_of(mdev, struct mca_bus, dev)
+
 struct mca_driver {
 	const short		*id_table;
 	struct device_driver	driver;
 };
 #define to_mca_driver(mdriver) container_of(mdriver, struct mca_driver, driver)
 
+/* Ongoing supported API functions */
 extern int mca_driver_register(struct mca_driver *);
 extern int mca_register_device(int bus, struct mca_device *);
 extern struct mca_device *mca_find_device_by_slot(int slot);
 extern int mca_system_init(void);
 extern struct mca_bus *mca_attach_bus(int);
 
-
-extern spinlock_t mca_lock;
+extern unsigned char mca_device_read_stored_pos(struct mca_device *mca_dev,
+						int reg);
+extern unsigned char mca_device_read_pos(struct mca_device *mca_dev, int reg);
+extern void mca_device_write_pos(struct mca_device *mca_dev, int reg,
+				 unsigned char byte);
+extern int mca_device_transform_irq(struct mca_device *mca_dev, int irq);
+extern int mca_device_transform_ioport(struct mca_device *mca_dev, int port);
+extern void *mca_device_transform_memory(struct mca_device *mca_dev,
+					 void *mem);
+extern int mca_device_claimed(struct mca_device *mca_dev);
+extern void mca_device_set_claim(struct mca_device *mca_dev, int val);
+extern enum MCA_AdapterStatus mca_device_status(struct mca_device *mca_dev);
 
 extern struct bus_type mca_bus_type;
 
-#ifdef CONFIG_PROC_FS
-extern void mca_do_proc_init(void);
-extern void mca_set_adapter_procfn(int slot, MCA_ProcFn, void* dev);
-#else
-static inline void mca_do_proc_init(void)
-{
-}
-
-static inline void mca_set_adapter_procfn(int slot, MCA_ProcFn *fn, void* dev)
-{
-}
-#endif
+/* for now, include the legacy API */
+#include <linux/mca-legacy.h>
+
 
 #endif /* _LINUX_MCA_H */

--==_Exmh_14444725580--


