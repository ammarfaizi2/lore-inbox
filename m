Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752147AbWCJAg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbWCJAg7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150AbWCJAgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:36:53 -0500
Received: from mx.pathscale.com ([64.160.42.68]:13198 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752147AbWCJAfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:35:48 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 7 of 20] ipath - misc driver support code
X-Mercurial-Node: a9ed49ad489cfaf913e416b00c8d794333dddf30
Message-Id: <a9ed49ad489cfaf913e4.1141950937@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1141950930@eng-12.pathscale.com>
Date: Thu,  9 Mar 2006 16:35:37 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

EEPROM support, interrupt handling, statistics gathering, and write
combining management for x86_64.

A note regarding i2c: The Atmel EEPROM hardware we use looks like an
i2c device electrically, but is not i2c compliant at all from a
functional perspective.  We tried using the kernel's i2c support to
talk to it, but failed.

Normal i2c devices have a single 7-bit or 10-bit i2c address that they
respond to.  Valid 7-bit addresses range from 0x03 to 0x77.  Addresses
0x00 to 0x02 and 0x78 to 0x7F are special reserved addresses
(e.g. 0x00 is the "general call" address.)  The Atmel device, on the
other hand, responds to ALL addresses.  It's designed to be the only
device on a given i2c bus.  A given i2c device address corresponds to
the memory address within the i2c device itself.

At least one reason why the linux core i2c stuff won't work for this
is that it prohibits access to reserved addresses like 0x00, which are
really valid addresses on the Atmel devices.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 696ba12283f4 -r a9ed49ad489c drivers/infiniband/hw/ipath/ipath_eeprom.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_eeprom.c	Thu Mar  9 16:15:49 2006 -0800
@@ -0,0 +1,587 @@
+/*
+ * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/vmalloc.h>
+
+#include "ipath_kernel.h"
+
+/*
+ * InfiniPath I2C driver for a serial eeprom.  This is not a generic
+ * I2C interface.  For a start, the device we're using (Atmel AT24C11)
+ * doesn't work like a regular I2C device.  It looks like one
+ * electrically, but not logically.  Normal I2C devices have a single
+ * 7-bit or 10-bit I2C address that they respond to.  Valid 7-bit
+ * addresses range from 0x03 to 0x77.  Addresses 0x00 to 0x02 and 0x78
+ * to 0x7F are special reserved addresses (e.g. 0x00 is the "general
+ * call" address.)  The Atmel device, on the other hand, responds to ALL
+ * 7-bit addresses.  It's designed to be the only device on a given I2C
+ * bus.  A 7-bit address corresponds to the memory address within the
+ * Atmel device itself.
+ *
+ * Also, the timing requirements mean more than simple software
+ * bitbanging, with readbacks from chip to ensure timing (simple udelay
+ * is not enough).
+ *
+ * This all means that accessing the device is specialized enough
+ * that using the standard kernel I2C bitbanging interface would be
+ * impossible.  For example, the core I2C eeprom driver expects to find
+ * a device at one or more of a limited set of addresses only.  It doesn't
+ * allow writing to an eeprom.  It also doesn't provide any means of
+ * accessing eeprom contents from within the kernel, only via sysfs.
+ */
+
+enum i2c_type {
+	i2c_line_scl = 0,
+	i2c_line_sda
+};
+
+enum i2c_state {
+	i2c_line_low = 0,
+	i2c_line_high
+};
+
+#define READ_CMD 1
+#define WRITE_CMD 0
+
+static int eeprom_init;
+
+/*
+ * The gpioval manipulation really should be protected by spinlocks
+ * or be converted to use atomic operations.
+ */
+
+/**
+ * i2c_gpio_set - set a GPIO line
+ * @dd: the infinipath device
+ * @line: the line to set
+ * @new_line_state: the state to set
+ *
+ * Returns 0 if the line was set to the new state successfully, non-zero
+ * on error.
+ */
+static int i2c_gpio_set(struct ipath_devdata *dd,
+			enum i2c_type line,
+			enum i2c_state new_line_state)
+{
+	u64 read_val, write_val, mask, *gpioval;
+
+	gpioval = &dd->ipath_gpio_out;
+	read_val = ipath_read_kreg64(dd, dd->ipath_kregs->kr_extctrl);
+	if (line == i2c_line_scl)
+		mask = ipath_gpio_scl;
+	else
+		mask = ipath_gpio_sda;
+
+	if (new_line_state == i2c_line_high)
+		/* tri-state the output rather than force high */
+		write_val = read_val & ~mask;
+	else
+		/* config line to be an output */
+		write_val = read_val | mask;
+	ipath_write_kreg(dd, dd->ipath_kregs->kr_extctrl, write_val);
+
+	/* set high and verify */
+	if (new_line_state == i2c_line_high)
+		write_val = 0x1UL;
+	else
+		write_val = 0x0UL;
+
+	if (line == i2c_line_scl) {
+		write_val <<= ipath_gpio_scl_num;
+		*gpioval = *gpioval & ~(1UL << ipath_gpio_scl_num);
+		*gpioval |= write_val;
+	} else {
+		write_val <<= ipath_gpio_sda_num;
+		*gpioval = *gpioval & ~(1UL << ipath_gpio_sda_num);
+		*gpioval |= write_val;
+	}
+	ipath_write_kreg(dd, dd->ipath_kregs->kr_gpio_out, *gpioval);
+
+	return 0;
+}
+
+/**
+ * i2c_gpio_get - get a GPIO line state
+ * @dd: the infinipath device
+ * @line: the line to get
+ * @curr_statep: where to put the line state
+ *
+ * Returns 0 if the line was set to the new state successfully, non-zero
+ * on error.  curr_state is not set on error.
+ */
+static int i2c_gpio_get(struct ipath_devdata *dd,
+			enum i2c_type line,
+			enum i2c_state *curr_statep)
+{
+	u64 read_val, write_val, mask;
+
+	/* check args */
+	if (curr_statep == NULL)
+		return 1;
+
+	read_val = ipath_read_kreg64(dd, dd->ipath_kregs->kr_extctrl);
+	/* config line to be an input */
+	if (line == i2c_line_scl)
+		mask = ipath_gpio_scl;
+	else
+		mask = ipath_gpio_sda;
+	write_val = read_val & ~mask;
+	ipath_write_kreg(dd, dd->ipath_kregs->kr_extctrl, write_val);
+	read_val = ipath_read_kreg64(dd, dd->ipath_kregs->kr_extstatus);
+
+	if (read_val & mask)
+		*curr_statep = i2c_line_high;
+	else
+		*curr_statep = i2c_line_low;
+
+	return 0;
+}
+
+/**
+ * i2c_wait_for_writes - wait for a write
+ * @dd: the infinipath device
+ *
+ * We use this instead of udelay directly, so we can make sure
+ * that previous register writes have been flushed all the way
+ * to the chip.  Since we are delaying anyway, the cost doesn't
+ * hurt, and makes the bit twiddling more regular
+ */
+static void i2c_wait_for_writes(struct ipath_devdata *dd)
+{
+	(void)ipath_read_kreg32(dd, dd->ipath_kregs->kr_scratch);
+}
+
+static void scl_out(struct ipath_devdata *dd, u8 bit)
+{
+	i2c_gpio_set(dd, i2c_line_scl, bit ? i2c_line_high : i2c_line_low);
+
+	i2c_wait_for_writes(dd);
+}
+
+static void sda_out(struct ipath_devdata *dd, u8 bit)
+{
+	i2c_gpio_set(dd, i2c_line_sda, bit ? i2c_line_high : i2c_line_low);
+
+	i2c_wait_for_writes(dd);
+}
+
+static u8 sda_in(struct ipath_devdata *dd, int wait)
+{
+	enum i2c_state bit;
+
+	if (i2c_gpio_get(dd, i2c_line_sda, &bit))
+		ipath_dbg("get bit failed!\n");
+
+	if (wait)
+		i2c_wait_for_writes(dd);
+
+	return bit == i2c_line_high ? 1U : 0;
+}
+
+/**
+ * i2c_ackrcv - see if ack following write is true
+ * @dd: the infinipath device
+ */
+static int i2c_ackrcv(struct ipath_devdata *dd)
+{
+	u8 ack_received;
+
+	/* AT ENTRY SCL = LOW */
+	/* change direction, ignore data */
+	ack_received = sda_in(dd, 1);
+	scl_out(dd, i2c_line_high);
+	ack_received = sda_in(dd, 1) == 0;
+	scl_out(dd, i2c_line_low);
+	return ack_received;
+}
+
+/**
+ * wr_byte - write a byte, one bit at a time
+ * @dd: the infinipath device
+ * @data: the byte to write
+ *
+ * Returns 0 if we got the following ack, otherwise 1
+ */
+static int wr_byte(struct ipath_devdata *dd, u8 data)
+{
+	int bit_cntr;
+	u8 bit;
+
+	for (bit_cntr = 7; bit_cntr >= 0; bit_cntr--) {
+		bit = (data >> bit_cntr) & 1;
+		sda_out(dd, bit);
+		scl_out(dd, i2c_line_high);
+		scl_out(dd, i2c_line_low);
+	}
+	if (!i2c_ackrcv(dd))
+		return 1;
+	return 0;
+}
+
+static void send_ack(struct ipath_devdata *dd)
+{
+	sda_out(dd, i2c_line_low);
+	scl_out(dd, i2c_line_high);
+	scl_out(dd, i2c_line_low);
+	sda_out(dd, i2c_line_high);
+}
+
+/**
+ * i2c_startcmd - transmit the start condition, followed by address/cmd
+ * @dd: the infinipath device
+ * @offset_dir: direction byte
+ *
+ *      (both clock/data high, clock high, data low while clock is high)
+ */
+static int i2c_startcmd(struct ipath_devdata *dd, u8 offset_dir)
+{
+	int res;
+
+	/* issue start sequence */
+	sda_out(dd, i2c_line_high);
+	scl_out(dd, i2c_line_high);
+	sda_out(dd, i2c_line_low);
+	scl_out(dd, i2c_line_low);
+
+	/* issue length and direction byte */
+	res = wr_byte(dd, offset_dir);
+
+	if (res)
+		ipath_cdbg(VERBOSE, "No ack to complete start\n");
+	return res;
+}
+
+/**
+ * stop_cmd - transmit the stop condition
+ * @dd: the infinipath device
+ *
+ * (both clock/data low, clock high, data high while clock is high)
+ */
+static void stop_cmd(struct ipath_devdata *dd)
+{
+	scl_out(dd, i2c_line_low);
+	sda_out(dd, i2c_line_low);
+	scl_out(dd, i2c_line_high);
+	sda_out(dd, i2c_line_high);
+	udelay(2);
+}
+
+/**
+ * eeprom_reset - reset I2C communication
+ * @dd: the infinipath device
+ */
+
+static int eeprom_reset(struct ipath_devdata *dd)
+{
+	int clock_cycles_left = 9;
+	u64 *gpioval = &dd->ipath_gpio_out;
+
+	eeprom_init = 1;
+	*gpioval = ipath_read_kreg64(dd, dd->ipath_kregs->kr_gpio_out);
+	ipath_cdbg(VERBOSE, "Resetting i2c eeprom; initial gpioout reg "
+		   "is %llx\n", (unsigned long long) *gpioval);
+
+	/*
+	 * This is to get the i2c into a known state, by first going low,
+	 * then tristate sda (and then tristate scl as first thing
+	 * in loop)
+	 */
+	scl_out(dd, i2c_line_low);
+	sda_out(dd, i2c_line_high);
+
+	while (clock_cycles_left--) {
+		scl_out(dd, i2c_line_high);
+
+		if (sda_in(dd, 0)) {
+			sda_out(dd, i2c_line_low);
+			scl_out(dd, i2c_line_low);
+			return 0;
+		}
+
+		scl_out(dd, i2c_line_low);
+	}
+
+	return 1;
+}
+
+/**
+ * ipath_eeprom_read - receives bytes from the eeprom via I2C
+ * @dd: the infinipath device
+ * @eeprom_offset: address to read from
+ * @buffer: where to store result
+ * @len: number of bytes to receive
+ */
+
+int ipath_eeprom_read(struct ipath_devdata *dd, u8 eeprom_offset,
+		      void *buffer, int len)
+{
+	/* compiler complains unless initialized */
+	u8 single_byte = 0;
+	int bit_cntr;
+
+	if (!eeprom_init)
+		eeprom_reset(dd);
+
+	eeprom_offset = (eeprom_offset << 1) | READ_CMD;
+
+	if (i2c_startcmd(dd, eeprom_offset)) {
+		ipath_dbg("Failed startcmd\n");
+		stop_cmd(dd);
+		return 1;
+	}
+
+	/*
+	 * eeprom keeps clocking data out as long as we ack, automatically
+	 * incrementing the address.
+	 */
+	while (len-- > 0) {
+		/* get data */
+		single_byte = 0;
+		for (bit_cntr = 8; bit_cntr; bit_cntr--) {
+			u8 bit;
+			scl_out(dd, i2c_line_high);
+			bit = sda_in(dd, 0);
+			single_byte |= bit << (bit_cntr - 1);
+			scl_out(dd, i2c_line_low);
+		}
+
+		/* send ack if not the last byte */
+		if (len)
+			send_ack(dd);
+
+		*((u8 *) buffer) = single_byte;
+		buffer++;
+	}
+
+	stop_cmd(dd);
+
+	return 0;
+}
+
+/**
+ * ipath_eeprom_write - writes data to the eeprom via I2C
+ * @dd: the infinipath device
+ * @eeprom_offset: where to place data
+ * @buffer: data to write
+ * @len: number of bytes to write
+ */
+int ipath_eeprom_write(struct ipath_devdata *dd, u8 eeprom_offset,
+		       const void *buffer, int len)
+{
+	u8 single_byte;
+	int sub_len;
+	const u8 *bp = buffer;
+	int max_wait_time, i;
+
+	if (!eeprom_init)
+		eeprom_reset(dd);
+
+	while (len > 0) {
+		if (i2c_startcmd(dd, (eeprom_offset << 1) | WRITE_CMD)) {
+			ipath_dbg("Failed to start cmd offset %u\n",
+				  eeprom_offset);
+			goto failed_write;
+		}
+
+		sub_len = min(len, 4);
+		eeprom_offset += sub_len;
+		len -= sub_len;
+
+		for (i = 0; i < sub_len; i++) {
+			if (wr_byte(dd, *bp++)) {
+				ipath_dbg("no ack after byte %u/%u (%u "
+					  "total remain)\n", i, sub_len,
+					  len + sub_len - i);
+				goto failed_write;
+			}
+		}
+
+		stop_cmd(dd);
+
+		/*
+		 * wait for write complete by waiting for a successful
+		 * read (the chip replies with a zero after the write
+		 * cmd completes, and before it writes to the eeprom.
+		 * The startcmd for the read will fail the ack until
+		 * the writes have completed.   We do this inline to avoid
+		 * the debug prints that are in the real read routine
+		 * if the startcmd fails.
+		 */
+		max_wait_time = 100;
+		while (i2c_startcmd(dd, READ_CMD)) {
+			stop_cmd(dd);
+			if (!--max_wait_time) {
+				ipath_dbg("Did not get successful read to "
+					  "complete write\n");
+				goto failed_write;
+			}
+		}
+		/* now read the zero byte */
+		for (i = single_byte = 0; i < 8; i++) {
+			u8 bit;
+			scl_out(dd, i2c_line_high);
+			bit = sda_in(dd, 0);
+			scl_out(dd, i2c_line_low);
+			single_byte <<= 1;
+			single_byte |= bit;
+		}
+		stop_cmd(dd);
+	}
+
+	return 0;
+
+      failed_write:
+	stop_cmd(dd);
+	return 1;
+}
+
+static u8 flash_csum(struct ipath_flash *ifp, int adjust)
+{
+	u8 *ip = (u8 *) ifp;
+	u8 csum = 0, len;
+
+	for (len = 0; len < ifp->if_length; len++)
+		csum += *ip++;
+	csum -= ifp->if_csum;
+	csum = ~csum;
+	if (adjust)
+		ifp->if_csum = csum;
+	return csum;
+}
+
+/**
+ * ipath_get_guid - get the GUID from the i2c device
+ * @dd: the infinipath device
+ *
+ * When we add the multi-chip support, we will probably have to add
+ * the ability to use the number of guids field, and get the guid from
+ * the first chip's flash, to use for all of them.
+ */
+void ipath_get_guid(struct ipath_devdata *dd)
+{
+	void *buf;
+	struct ipath_flash *ifp;
+	u64 guid;
+	int len;
+	u8 csum, *bguid;
+	int t = dd->ipath_unit;
+	struct ipath_devdata *dd0 = ipath_lookup(0);
+
+	if (t && dd0->ipath_nguid > 1 && t <= dd0->ipath_nguid) {
+		u8 *bguid, oguid;
+		dd->ipath_guid = dd0->ipath_guid;
+		bguid = (u8 *) & dd->ipath_guid;
+
+		oguid = bguid[7];
+		bguid[7] += t;
+		if (oguid > bguid[7]) {
+			if (bguid[6] == 0xff) {
+				if (bguid[5] == 0xff) {
+					ipath_dev_err(dd,
+						"Can't set %s GUID from "
+						"base GUID, wraps to OUI!\n",
+						ipath_get_unit_name(t));
+					dd->ipath_guid = 0;
+					return;
+				}
+				bguid[5]++;
+			}
+			bguid[6]++;
+		}
+		dd->ipath_nguid = 1;
+
+		ipath_dbg("nguid %u, so adding %u to device 0 guid, "
+			  "for %llx (big-endian)\n",
+			  dd0->ipath_nguid, t,
+			  (unsigned long long) dd->ipath_guid);
+		return;
+	}
+
+	len = offsetof(struct ipath_flash, if_future);
+	buf = vmalloc(len);
+	if (!buf) {
+		ipath_dev_err(dd,
+				 "Couldn't allocate memory to read %u bytes "
+				 "from eeprom for GUID\n", len);
+		return;
+	}
+
+	if (ipath_eeprom_read(dd, 0, buf, len)) {
+		ipath_dev_err(dd, "Failed reading GUID from eeprom\n");
+		goto done;
+	}
+	ifp = (struct ipath_flash *)buf;
+
+	csum = flash_csum(ifp, 0);
+	if (csum != ifp->if_csum) {
+		dev_info(&dd->pcidev->dev, "Bad I2C flash checksum: "
+			 "0x%x, not 0x%x\n", csum, ifp->if_csum);
+		goto done;
+	}
+	if (*(u64 *) ifp->if_guid == 0ULL || *(u64 *) ifp->if_guid == -1LL) {
+		ipath_dev_err(dd, "Invalid GUID %llx from flash; ignoring\n",
+				 *(unsigned long long *) ifp->if_guid);
+		goto done;	/* don't allow GUID if all 0 or all 1's */
+	}
+
+	/* complain, but allow it */
+	if (*(u64 *) ifp->if_guid == 0x100007511000000ULL)
+		dev_info(&dd->pcidev->dev, "Warning, GUID %llx is "
+			 "default, probably not correct!\n",
+			 *(unsigned long long *) ifp->if_guid);
+
+	bguid = ifp->if_guid;
+	if (!bguid[0] && !bguid[1] && !bguid[2]) {
+		/* original incorrect GUID format in flash; fix in
+		 * core copy, by shifting up 2 octets; don't need to
+		 * change top octet, since both it and shifted are
+		 * 0.. */
+		bguid[1] = bguid[3];
+		bguid[2] = bguid[4];
+		bguid[3] = bguid[4] = 0;
+		guid = *(u64 *) ifp->if_guid;
+		ipath_cdbg(VERBOSE, "Old GUID format in flash, top 3 zero, "
+			   "shifting 2 octets\n");
+	} else
+		guid = *(u64 *) ifp->if_guid;
+	dd->ipath_guid = guid;
+	dd->ipath_nguid = ifp->if_numguid;
+	memcpy(dd->ipath_serial, ifp->if_serial,
+	       sizeof(ifp->if_serial));
+	ipath_cdbg(VERBOSE, "Initted GUID to %llx (big-endian) from i2c "
+		   "flash\n", (unsigned long long) dd->ipath_guid);
+
+done:
+	vfree(buf);
+}
diff -r 696ba12283f4 -r a9ed49ad489c drivers/infiniband/hw/ipath/ipath_intr.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_intr.c	Thu Mar  9 16:15:49 2006 -0800
@@ -0,0 +1,762 @@
+/*
+ * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <linux/pci.h>
+
+#include "ipath_kernel.h"
+#include "ips_common.h"
+#include "ipath_layer.h"
+
+#define E_SUM_PKTERRS \
+	(INFINIPATH_E_RHDRLEN | INFINIPATH_E_RBADTID | \
+	 INFINIPATH_E_RBADVERSION | INFINIPATH_E_RHDR | \
+	 INFINIPATH_E_RLONGPKTLEN | INFINIPATH_E_RSHORTPKTLEN | \
+	 INFINIPATH_E_RMAXPKTLEN | INFINIPATH_E_RMINPKTLEN | \
+	 INFINIPATH_E_RFORMATERR | INFINIPATH_E_RUNSUPVL | \
+	 INFINIPATH_E_RUNEXPCHAR | INFINIPATH_E_REBP)
+
+#define E_SUM_ERRS \
+	(INFINIPATH_E_SPIOARMLAUNCH | INFINIPATH_E_SUNEXPERRPKTNUM | \
+	 INFINIPATH_E_SDROPPEDDATAPKT | INFINIPATH_E_SDROPPEDSMPPKT | \
+	 INFINIPATH_E_SMAXPKTLEN | INFINIPATH_E_SUNSUPVL | \
+	 INFINIPATH_E_SMINPKTLEN | INFINIPATH_E_SPKTLEN | \
+	 INFINIPATH_E_INVALIDADDR)
+
+static u64 handle_e_sum_errs(struct ipath_devdata *dd, ipath_err_t errs)
+{
+	unsigned long sbuf[4];
+	u64 ignore_this_time = 0;
+	u32 piobcnt;
+
+	/* if possible that sendbuffererror could be valid */
+	piobcnt = dd->ipath_piobcnt2k + dd->ipath_piobcnt4k;
+	/* read these before writing errorclear */
+	sbuf[0] = ipath_read_kreg64(dd, dd->ipath_kregs->kr_sendbuffererror);
+	sbuf[1] = ipath_read_kreg64(dd,
+				    dd->ipath_kregs->kr_sendbuffererror + 1);
+	if (piobcnt > 128) {
+		sbuf[2] = ipath_read_kreg64(dd,
+				dd->ipath_kregs->kr_sendbuffererror + 2);
+		sbuf[3] = ipath_read_kreg64(dd,
+				dd->ipath_kregs->kr_sendbuffererror + 3);
+	}
+
+	if (sbuf[0] || sbuf[1] || (piobcnt > 128 && (sbuf[2] || sbuf[3]))) {
+		int i;
+
+		ipath_cdbg(PKT, "SendbufErrs %lx %lx ", sbuf[0], sbuf[1]);
+		if (ipath_debug & __IPATH_PKTDBG && piobcnt > 128)
+			printk("%lx %lx ", sbuf[2], sbuf[3]);
+		for (i = 0; i < piobcnt; i++) {
+			if (test_bit(i, sbuf)) {
+				u32 __iomem *piobuf;
+				if (i < dd->ipath_piobcnt2k)
+					piobuf = (u32 __iomem *) (dd->ipath_pio2kbase + i * dd->ipath_palign);
+				else
+					piobuf = (u32 __iomem *) (dd->ipath_pio4kbase + (i - dd->ipath_piobcnt2k) * dd->ipath_4kalign);
+
+				ipath_cdbg(PKT, "PIObuf[%u] @%p pbc is %x; ",
+					   i, piobuf, readl(piobuf));
+
+				ipath_disarm_piobufs(dd, i, 1);
+			}
+		}
+		if (ipath_debug & __IPATH_PKTDBG)
+			printk("\n");
+	}
+	if ((errs & (INFINIPATH_E_SDROPPEDDATAPKT |
+		     INFINIPATH_E_SDROPPEDSMPPKT | INFINIPATH_E_SMINPKTLEN)) &&
+	    !(dd->ipath_flags & IPATH_LINKACTIVE)) {
+		/*
+		 * This can happen when SMA is trying to bring the link
+		 * up, but the IB link changes state at the "wrong" time.
+		 * The IB logic then complains that the packet isn't
+		 * valid.  We don't want to confuse people, so we just
+		 * don't print them, except at debug
+		 */
+		ipath_dbg("Ignoring pktsend errors %llx, because not "
+			  "yet active\n", (unsigned long long) errs);
+		ignore_this_time = INFINIPATH_E_SDROPPEDDATAPKT |
+			INFINIPATH_E_SDROPPEDSMPPKT | INFINIPATH_E_SMINPKTLEN;
+	}
+
+	return ignore_this_time;
+}
+
+static void handle_e_ibstatuschanged(struct ipath_devdata *dd,
+				     ipath_err_t errs, int noprint)
+{
+	u64 val;
+	u32 ltstate, lstate;
+
+	/*
+	 * even if diags are enabled, we want to notice LINKINIT, etc.
+	 * We just don't want to change the LED state, or
+	 * dd->ipath_kregs->kr_ibcctrl
+	 */
+
+	val = ipath_read_kreg64(dd, dd->ipath_kregs->kr_ibcstatus);
+	lstate = val & IPATH_IBSTATE_MASK;
+	if (lstate == IPATH_IBSTATE_INIT || lstate == IPATH_IBSTATE_ARM
+	    || lstate == IPATH_IBSTATE_ACTIVE)
+		ipath_dbg("Link unit %u state changed to 0x%x, last "
+			  "was 0x%llx\n", dd->ipath_unit, lstate,
+			  (unsigned long long) dd->ipath_lastibcstat);
+	else {
+		lstate = dd->ipath_lastibcstat & IPATH_IBSTATE_MASK;
+		if (lstate == IPATH_IBSTATE_INIT
+		    || lstate == IPATH_IBSTATE_ARM
+		    || lstate == IPATH_IBSTATE_ACTIVE)
+			ipath_dbg("Link unit %u state changed to down "
+				  "state 0x%llx, from 0x%llx\n",
+				  dd->ipath_unit, (unsigned long long) val,
+				  (unsigned long long) dd->ipath_lastibcstat);
+		else
+			ipath_cdbg(VERBOSE, "Link unit %u state changed "
+				   "to 0x%llx from down\n",
+				   dd->ipath_unit, (unsigned long long) val);
+	}
+	ltstate = (val >> INFINIPATH_IBCS_LINKTRAININGSTATE_SHIFT) &
+		INFINIPATH_IBCS_LINKTRAININGSTATE_MASK;
+	lstate = (val >> INFINIPATH_IBCS_LINKSTATE_SHIFT) &
+		INFINIPATH_IBCS_LINKSTATE_MASK;
+
+	if (ltstate == INFINIPATH_IBCS_LT_STATE_POLLACTIVE ||
+	    ltstate == INFINIPATH_IBCS_LT_STATE_POLLQUIET) {
+		u32 last_ltstate;
+
+		/*
+		 * Ignore cycling back and forth from Polling.Active
+		 * to Polling.Quiet while waiting for the other end of
+		 * the link to come up. We will cycle back and forth
+		 * between them if no cable is plugged in,
+		 * the other device is powered off or disabled, etc.
+		 */
+		last_ltstate = (dd->ipath_lastibcstat >>
+				INFINIPATH_IBCS_LINKTRAININGSTATE_SHIFT)
+			& INFINIPATH_IBCS_LINKTRAININGSTATE_MASK;
+		if (last_ltstate == INFINIPATH_IBCS_LT_STATE_POLLACTIVE
+		    || last_ltstate ==
+		    INFINIPATH_IBCS_LT_STATE_POLLQUIET) {
+			if (dd->ipath_ibpollcnt > 40) {
+				dd->ipath_flags |= IPATH_NOCABLE;
+				*dd->ipath_statusp |=
+					IPATH_STATUS_IB_NOCABLE;
+			} else
+				dd->ipath_ibpollcnt++;
+			goto skip_ibchange;
+		}
+	}
+	dd->ipath_ibpollcnt = 0;	/* some state other than 2 or 3 */
+	ipath_stats.sps_iblink++;
+	if (ltstate != INFINIPATH_IBCS_LT_STATE_LINKUP) {
+		dd->ipath_flags |= IPATH_LINKDOWN;
+		dd->ipath_flags &= ~(IPATH_LINKUNK | IPATH_LINKINIT
+				     | IPATH_LINKACTIVE |
+				     IPATH_LINKARMED);
+		*dd->ipath_statusp &= ~IPATH_STATUS_IB_READY;
+		if (!noprint) {
+			if (((dd->ipath_lastibcstat >>
+			      INFINIPATH_IBCS_LINKSTATE_SHIFT) &
+			     INFINIPATH_IBCS_LINKSTATE_MASK)
+			    == INFINIPATH_IBCS_L_STATE_ACTIVE)
+				/* if from up to down be more vocal */
+				ipath_dbg("Link unit %u is now down (%s)\n",
+					  dd->ipath_unit,
+					  ipath_ibcstatus_str[ltstate]);
+			else
+				ipath_cdbg(VERBOSE, "Link unit %u is "
+					   "down (%s)\n", dd->ipath_unit,
+					   ipath_ibcstatus_str[ltstate]);
+		}
+
+		dd->ipath_f_setextled(dd, lstate, ltstate);
+	} else if ((val & IPATH_IBSTATE_MASK) == IPATH_IBSTATE_ACTIVE) {
+		if (!noprint)
+			ipath_dbg("Link unit %u is now in active state\n",
+				  dd->ipath_unit);
+		dd->ipath_flags |= IPATH_LINKACTIVE;
+		dd->ipath_flags &=
+			~(IPATH_LINKUNK | IPATH_LINKINIT | IPATH_LINKDOWN |
+			  IPATH_LINKARMED | IPATH_NOCABLE);
+		*dd->ipath_statusp &= ~IPATH_STATUS_IB_NOCABLE;
+		*dd->ipath_statusp |=
+			IPATH_STATUS_IB_READY | IPATH_STATUS_IB_CONF;
+		dd->ipath_f_setextled(dd, lstate, ltstate);
+
+		if (dd->ipath_layer.l_intr)
+			dd->ipath_layer.l_intr(dd->ipath_unit,
+					       IPATH_LAYER_INT_IF_UP);
+	} else if ((val & IPATH_IBSTATE_MASK) == IPATH_IBSTATE_INIT) {
+		/*
+		 * set INIT and DOWN.  Down is checked by most of the other
+		 * code, but INIT is useful to know in a few places.
+		 */
+		dd->ipath_flags |= IPATH_LINKINIT | IPATH_LINKDOWN;
+		dd->ipath_flags &=
+			~(IPATH_LINKUNK | IPATH_LINKACTIVE | IPATH_LINKARMED
+			  | IPATH_NOCABLE);
+		*dd->ipath_statusp &= ~(IPATH_STATUS_IB_NOCABLE
+					| IPATH_STATUS_IB_READY);
+
+		dd->ipath_f_setextled(dd, lstate, ltstate);
+	} else if ((val & IPATH_IBSTATE_MASK) == IPATH_IBSTATE_ARM) {
+		dd->ipath_flags |= IPATH_LINKARMED;
+		dd->ipath_flags &=
+			~(IPATH_LINKUNK | IPATH_LINKDOWN | IPATH_LINKINIT |
+			  IPATH_LINKACTIVE | IPATH_NOCABLE);
+		*dd->ipath_statusp &= ~(IPATH_STATUS_IB_NOCABLE
+					| IPATH_STATUS_IB_READY);
+		dd->ipath_f_setextled(dd, lstate, ltstate);
+	} else {
+		if (!noprint)
+			ipath_dbg("IBstatuschange unit %u: %s\n",
+				  dd->ipath_unit,
+				  ipath_ibcstatus_str[ltstate]);
+	}
+skip_ibchange:
+	dd->ipath_lastibcstat = val;
+}
+
+static unsigned handle_frequent_errors(struct ipath_devdata *dd,
+				       ipath_err_t errs, char msg[512],
+				       int *noprint)
+{
+	cycles_t nc;
+	static cycles_t nextmsg_time;
+	static unsigned nmsgs, supp_msgs;
+
+	/*
+	 * throttle back "fast" messages to no more than 10 per 5 seconds
+	 * (1.4-2GHz clock).  This isn't perfect, but it's a reasonable
+	 * heuristic. If we get more than 10, give a 5x longer delay
+	 */
+	nc = get_cycles();
+	if (nmsgs > 10) {
+		if (nc < nextmsg_time) {
+			*noprint = 1;
+			if (!supp_msgs++)
+				nextmsg_time = nc + 50000000000ULL;
+		} else if (supp_msgs) {
+			/*
+			 * Print the message unless it's ibc status
+			 * change only, which happens so often we never
+			 * want to count it.
+			 */
+			if (dd->ipath_lasterror & ~INFINIPATH_E_IBSTATUSCHANGED) {
+				ipath_decode_err(msg, sizeof msg,
+						 dd->ipath_lasterror &
+						 ~INFINIPATH_E_IBSTATUSCHANGED);
+				if (dd->
+				    ipath_lasterror & ~(INFINIPATH_E_RRCVEGRFULL
+							|
+							INFINIPATH_E_RRCVHDRFULL))
+					ipath_dev_err(dd,
+						      "Suppressed %u messages for fast-repeating errors (%s) (%llx)\n",
+						      supp_msgs, msg,
+						      (unsigned long long) dd->ipath_lasterror);
+				else {
+					/*
+					 * rcvegrfull and rcvhdrqfull are
+					 * "normal", for some types of
+					 * processes (mostly benchmarks)
+					 * that send huge numbers of
+					 * messages, while not processing
+					 * them. So only complain about
+					 * these at debug level.
+					 */
+					ipath_dbg("Suppressed %u messages "
+						  "for %s\n", supp_msgs, msg);
+				}
+			}
+			supp_msgs = 0;
+			nmsgs = 0;
+		}
+	}
+	else if (!nmsgs++ || nc > nextmsg_time)	/* start timer */
+		nextmsg_time = nc + 10000000000ULL;
+
+	return supp_msgs;
+}
+
+static void handle_errors(struct ipath_devdata *dd, ipath_err_t errs)
+{
+	char msg[512];
+	u64 ignore_this_time = 0;
+	int i;
+	int chkerrpkts = 0, noprint = 0;
+	unsigned supp_msgs;
+
+	supp_msgs = handle_frequent_errors(dd, errs, msg, &noprint);
+
+	/*
+	 * don't report errors that are masked (includes those always
+	 * ignored)
+	 */
+	errs &= ~dd->ipath_maskederrs;
+
+	/* do these first, they are most important */
+	if (errs & INFINIPATH_E_HARDWARE) {
+		/* reuse same msg buf */
+		dd->ipath_f_handle_hwerrors(dd, msg, sizeof msg);
+	}
+
+	if (!noprint && (errs & ~infinipath_e_bitsextant))
+		ipath_dev_err(dd,
+			      "error interrupt with unknown errors %llx set\n",
+			      (unsigned long long) (errs & ~infinipath_e_bitsextant));
+
+	if (errs & E_SUM_ERRS)
+		ignore_this_time = handle_e_sum_errs(dd, errs);
+
+	if (supp_msgs == 250000) {
+		/*
+		 * It's not entirely reasonable assuming that the errors
+		 * set in the last clear period are all responsible for
+		 * the problem, but the alternative is to assume it's the only
+		 * ones on this particular interrupt, which also isn't great
+		 */
+		dd->ipath_maskederrs |= dd->ipath_lasterror | errs;
+		ipath_write_kreg(dd, dd->ipath_kregs->kr_errormask,
+				 ~dd->ipath_maskederrs);
+		ipath_decode_err(msg, sizeof msg,
+				 (dd->ipath_maskederrs & ~dd->
+				  ipath_ignorederrs));
+
+		if ((dd->ipath_maskederrs & ~dd->ipath_ignorederrs)
+		    & ~(INFINIPATH_E_RRCVEGRFULL | INFINIPATH_E_RRCVHDRFULL))
+			ipath_dev_err(dd,
+				      "Disabling error(s) %llx because occuring too frequently (%s)\n",
+				      (unsigned long long) (dd->ipath_maskederrs & ~dd->
+							    ipath_ignorederrs), msg);
+		else {
+			/*
+			 * rcvegrfull and rcvhdrqfull are "normal",
+			 * for some types of processes (mostly benchmarks)
+			 * that send huge numbers of messages, while not
+			 * processing them.  So only complain about
+			 * these at debug level.
+			 */
+			ipath_dbg("Disabling frequent queue full errors (%s)\n",
+				  msg);
+		}
+
+		/*
+		 * re-enable the masked errors after around 3 minutes.
+		 * in ipath_get_faststats().  If we have a series of
+		 * fast repeating but different errors, the interval will keep
+		 * stretching out, but that's OK, as that's pretty catastrophic.
+		 */
+		dd->ipath_unmasktime = get_cycles() + 400000000000ULL;
+	}
+
+	ipath_write_kreg(dd, dd->ipath_kregs->kr_errorclear, errs);
+	if (ignore_this_time)
+		errs &= ~ignore_this_time;
+	if (errs & ~dd->ipath_lasterror) {
+		errs &= ~dd->ipath_lasterror;
+		/* never suppress duplicate hwerrors or ibstatuschange */
+		dd->ipath_lasterror |= errs &
+			~(INFINIPATH_E_HARDWARE | INFINIPATH_E_IBSTATUSCHANGED);
+	}
+	if (!errs)
+		return;
+
+	if (!noprint)
+		/* the ones we mask off are handled specially below or above */
+		ipath_decode_err(msg, sizeof msg,
+				 errs & ~(INFINIPATH_E_IBSTATUSCHANGED |
+					  INFINIPATH_E_RRCVEGRFULL |
+					  INFINIPATH_E_RRCVHDRFULL |
+					  INFINIPATH_E_HARDWARE));
+	else
+		*msg = 0; /* so we don't need if(!noprint) at strlcat's below */
+
+	if (errs & E_SUM_PKTERRS) {
+		ipath_stats.sps_pkterrs++;
+		chkerrpkts = 1;
+	}
+	if (errs & E_SUM_ERRS)
+		ipath_stats.sps_errs++;
+
+	if (errs & (INFINIPATH_E_RICRC | INFINIPATH_E_RVCRC)) {
+		ipath_stats.sps_crcerrs++;
+		chkerrpkts = 1;
+	}
+
+	/*
+	 * We don't want to print these two as they happen, or we can make
+	 * the situation even worse, because it takes so long to print messages.
+	 * to serial consoles.  kernel ports get printed from fast_stats, no
+	 * more than every 5 seconds, user ports get printed on close
+	 */
+	if (errs & INFINIPATH_E_RRCVHDRFULL) {
+		int any;
+		u32 hd, tl;
+		ipath_stats.sps_hdrqfull++;
+		for (any = i = 0; i < dd->ipath_cfgports; i++) {
+			if (i == 0) {
+				hd = dd->ipath_port0head;
+				tl = (uint32_t)__le64_to_cpu(*dd->ipath_hdrqtailptr);
+			} else if (dd->ipath_pd[i] &&
+				   dd->ipath_pd[i]->port_cnt &&
+				   dd->ipath_pd[i]->port_rcvhdrtail_kvaddr) {
+				/*
+				 * don't report same point multiple times,
+				 * except kernel
+				 */
+				tl = (u32)
+				    * dd->ipath_pd[i]->port_rcvhdrtail_kvaddr;
+				if (tl == dd->ipath_lastrcvhdrqtails[i])
+					continue;
+				hd = ipath_read_ureg32(dd, ur_rcvhdrhead, i);
+			} else
+				continue;
+			if (hd == (tl + 1) ||
+			    (!hd && tl == dd->ipath_hdrqlast)) {
+				dd->ipath_lastrcvhdrqtails[i] = tl;
+				dd->ipath_pd[i]->port_hdrqfull++;
+				if (i == 0)
+					chkerrpkts = 1;
+			}
+		}
+	}
+	if (errs & INFINIPATH_E_RRCVEGRFULL) {
+		/*
+		 * since this is of less importance and not likely to
+		 * happen without also getting hdrfull, only count
+		 * occurrences; don't check each port (or even the kernel
+		 * vs user)
+		 */
+		ipath_stats.sps_etidfull++;
+		if (dd->ipath_port0head !=
+		    (uint32_t)__le64_to_cpu(*dd->ipath_hdrqtailptr))
+			chkerrpkts = 1;
+	}
+
+	/*
+	 * do this before IBSTATUSCHANGED, in case both bits set in a single
+	 * interrupt; we want the STATUSCHANGE to "win", so we do our
+	 * internal copy of state machine correctly
+	 */
+	if (errs & INFINIPATH_E_RIBLOSTLINK) {
+		/*
+		 * force through block below
+		 */
+		errs |= INFINIPATH_E_IBSTATUSCHANGED;
+		ipath_stats.sps_iblink++;
+		dd->ipath_flags |= IPATH_LINKDOWN;
+		dd->ipath_flags &= ~(IPATH_LINKUNK | IPATH_LINKINIT
+				     | IPATH_LINKARMED | IPATH_LINKACTIVE);
+		*dd->ipath_statusp &= ~IPATH_STATUS_IB_READY;
+		if (!noprint)
+			ipath_dbg("Lost link, link now down (%s)\n",
+				ipath_ibcstatus_str[ipath_read_kreg64(dd, dd->ipath_kregs->kr_ibcstatus) & 0xf]);
+	}
+	if (errs & INFINIPATH_E_IBSTATUSCHANGED)
+		handle_e_ibstatuschanged(dd, errs, noprint);
+
+	if (errs & INFINIPATH_E_RESET) {
+		if (!noprint)
+			ipath_dev_err(dd,
+				      "Got reset, requires re-initialization (unload and reload driver)\n");
+		dd->ipath_flags &= ~IPATH_INITTED;	/* needs re-init */
+		/* mark as having had error */
+		*dd->ipath_statusp |= IPATH_STATUS_HWERROR;
+		*dd->ipath_statusp &= ~IPATH_STATUS_IB_CONF;
+	}
+
+	if (!noprint && *msg)
+		ipath_dev_err(dd, "%s error\n", msg);
+	if (dd->ipath_sma_state_wanted & dd->ipath_flags) {
+		ipath_cdbg(VERBOSE, "sma wanted state %x, iflags now %x, "
+			   "waking\n", dd->ipath_sma_state_wanted,
+			   dd->ipath_flags);
+		wake_up_interruptible(&ipath_sma_state_wait);
+	}
+
+	if (chkerrpkts)
+		ipath_kreceive(dd); /* process possible error packets in hdrq */
+}
+
+/* this is separate to allow for better optimization of ipath_intr() */
+
+static void ipath_bad_intr(struct ipath_devdata *dd, u32 * unexpectp)
+{
+	/*
+	 * sometimes happen during driver init and unload, don't want
+	 * to process any interrupts at that point
+	 */
+
+	/* this is just a bandaid, not a fix, if something goes badly wrong */
+	if (++*unexpectp > 100) {
+		if (++*unexpectp > 105) {
+			/*
+			 * ok, we must be taking somebody else's interrupts,
+			 * due to a messed up mptable and/or PIRQ table, so
+			 * unregister the interrupt.  We've seen this
+			 * during linuxbios development work, and it
+			 * may happen in the future again.
+			 */
+			if (dd->pcidev && dd->pcidev->irq) {
+				ipath_dev_err(dd,
+					      "Now %u unexpected interrupts, unregistering interrupt handler\n",
+					      *unexpectp);
+				ipath_dbg("free_irq of irq %x\n",
+					  dd->pcidev->irq);
+				free_irq(dd->pcidev->irq, dd);
+			}
+		}
+		if (ipath_read_kreg32(dd, dd->ipath_kregs->kr_intmask)) {
+			ipath_dev_err(dd,
+				      "%u unexpected interrupts, disabling interrupts completely\n",
+				      *unexpectp);
+			/* disable all interrupts, something is very wrong */
+			ipath_write_kreg(dd, dd->ipath_kregs->kr_intmask, 0ULL);
+		}
+	} else if (*unexpectp > 1)
+		ipath_dbg("Interrupt when not ready, should not happen, "
+			  "ignoring\n");
+}
+
+static void ipath_bad_regread(struct ipath_devdata *dd)
+{
+	static int allbits;
+
+	/* separate routine, for better optimization of ipath_intr() */
+
+	/*
+	 * We print the message and disable interrupts, in hope of
+	 * having a better chance of debugging the problem.
+	 */
+	ipath_dev_err(dd,
+		      "Read of interrupt status failed (all bits set)\n");
+	if (allbits++) {	/* disable all interrupts, something is very wrong */
+		ipath_write_kreg(dd, dd->ipath_kregs->kr_intmask, 0ULL);
+		if (allbits == 2) {
+			ipath_dev_err(dd,
+				      "Still bad interrupt status, unregistering interrupt\n");
+			free_irq(dd->pcidev->irq, dd);
+		} else if (allbits > 2) {
+			if ((allbits % 10000) == 0)
+				printk(".");
+		} else
+			ipath_dev_err(dd,
+				      "Disabling interrupts, multiple errors\n");
+	}
+}
+
+irqreturn_t ipath_intr(int irq, void *data, struct pt_regs *regs)
+{
+	struct ipath_devdata *dd = data;
+	u32 istat = ipath_read_kreg32(dd, dd->ipath_kregs->kr_intstatus);
+	ipath_err_t estat = 0;
+	static unsigned unexpected = 0;
+
+	if (unlikely(!istat)) {
+		ipath_stats.sps_nullintr++;
+		return IRQ_NONE; /* not our interrupt, or already handled */
+	}
+	if (unlikely(istat == -1)) {
+		ipath_bad_regread(dd);
+		return IRQ_NONE; /* don't know if it was our interrupt or not */
+	}
+
+	ipath_stats.sps_ints++;
+
+	/*
+	 * this needs to be flags&initted, not statusp, so we keep
+	 * taking interrupts even after link goes down, etc.
+	 * Also, we *must* clear the interrupt at some point, or we won't
+	 * take it again, which can be real bad for errors, etc...
+	 */
+
+	if (!(dd->ipath_flags & IPATH_INITTED)) {
+		ipath_bad_intr(dd, &unexpected);
+		return IRQ_NONE;
+	}
+	if (unexpected)
+		unexpected = 0;
+
+	ipath_cdbg(VERBOSE, "intr stat=0x%x\n", istat);
+
+	if (istat & ~infinipath_i_bitsextant)
+		ipath_dev_err(dd,
+			      "interrupt with unknown interrupts %x set\n",
+			      istat & (u32) ~ infinipath_i_bitsextant);
+
+	if (istat & INFINIPATH_I_ERROR) {
+		ipath_stats.sps_errints++;
+		estat = ipath_read_kreg64(dd, dd->ipath_kregs->kr_errorstatus);
+		if (!estat)
+			dev_info(&dd->pcidev->dev, "error interrupt (%x), "
+				 "but no error bits set!\n", istat);
+		else if (estat == -1LL)
+			/*
+			 * should we try clearing all, or hope next read
+			 * works?
+			 */
+			ipath_dev_err(dd,
+				      "Read of error status failed (all bits set); ignoring\n");
+		else
+			handle_errors(dd, estat);
+	}
+
+	if (istat & INFINIPATH_I_GPIO) {
+		if (unlikely(!(dd->ipath_flags & IPATH_GPIO_INTR))) {
+			u32 gpiostatus;
+			gpiostatus = ipath_read_kreg32(dd,
+				dd->ipath_kregs->kr_gpio_status);
+			ipath_dbg("Unexpected GPIO interrupt bits %x\n",
+				  gpiostatus);
+			ipath_write_kreg(dd, dd->ipath_kregs->kr_gpio_clear,
+					 gpiostatus);
+		}
+		else {
+			/* Clear GPIO status bit 2 */
+			ipath_write_kreg(dd, dd->ipath_kregs->kr_gpio_clear,
+					 (u64) (1 << 2));
+
+			/*
+			 * Packets are available in the port 0 rcv queue.
+			 * Eventually this needs to be generalized to check
+			 * IPATH_GPIO_INTR, and the specific GPIO bit, if
+			 * GPIO interrupts are used for anything else.
+			 */
+			ipath_kreceive(dd);
+		}
+	}
+
+	/*
+	 * clear the ones we will deal with on this round
+	 * We clear it early, mostly for receive interrupts, so we
+	 * know the chip will have seen this by the time we process
+	 * the queue, and will re-interrupt if necessary.  The processor
+	 * itself won't take the interrupt again until we return.
+	 */
+	ipath_write_kreg(dd, dd->ipath_kregs->kr_intclear, istat);
+
+	if (istat & INFINIPATH_I_SPIOBUFAVAIL) {
+		clear_bit(IPATH_S_PIOINTBUFAVAIL, &dd->ipath_sendctrl);
+		ipath_write_kreg(dd, dd->ipath_kregs->kr_sendctrl,
+				 dd->ipath_sendctrl);
+
+		if (dd->ipath_portpiowait) {
+			u32 i;
+			/*
+			 * start from port 1, since for now port 0  is never using
+			 * wait_event for PIO
+			 */
+			for (i = 1;
+			     dd->ipath_portpiowait && i < dd->ipath_cfgports;
+			     i++) {
+				if (dd->ipath_pd[i] && dd->ipath_pd[i]->port_cnt
+				    && dd->ipath_portpiowait & (1U << i)) {
+					clear_bit(i, &dd->ipath_portpiowait);
+					if (test_bit(IPATH_PORT_WAITING_PIO,
+						     &dd->ipath_pd[i]->port_flag)) {
+						clear_bit(IPATH_PORT_WAITING_PIO,
+							  &dd->ipath_pd[i]->port_flag);
+						wake_up_interruptible(&dd->
+								      ipath_pd
+								      [i]->
+								      port_wait);
+					}
+				}
+			}
+		}
+
+		if (dd->ipath_layer.l_intr) {
+			if (dd->ipath_layer.l_intr(dd->ipath_unit,
+						   IPATH_LAYER_INT_SEND_CONTINUE))
+			{
+				set_bit(IPATH_S_PIOINTBUFAVAIL,
+					&dd->ipath_sendctrl);
+				ipath_write_kreg(dd, dd->ipath_kregs->kr_sendctrl,
+						 dd->ipath_sendctrl);
+			}
+		}
+
+		if (dd->verbs_layer.l_piobufavail) {
+			if (!dd->verbs_layer.l_piobufavail(dd->ipath_unit)) {
+				set_bit(IPATH_S_PIOINTBUFAVAIL,
+					&dd->ipath_sendctrl);
+				ipath_write_kreg(dd, dd->ipath_kregs->kr_sendctrl,
+						 dd->ipath_sendctrl);
+			}
+		}
+	}
+
+	/*
+	 * we check for both transition from empty to non-empty, and urgent
+	 * packets (those with the interrupt bit set in the header)
+	 */
+
+	if (istat & ((infinipath_i_rcvavail_mask << INFINIPATH_I_RCVAVAIL_SHIFT)
+		     | (infinipath_i_rcvurg_mask << INFINIPATH_I_RCVURG_SHIFT))) {
+		u64 portr;
+		int i;
+		int rcvdint = 0;
+
+		portr = ((istat >> INFINIPATH_I_RCVAVAIL_SHIFT) &
+			 infinipath_i_rcvavail_mask)
+			| ((istat >> INFINIPATH_I_RCVURG_SHIFT) &
+			   infinipath_i_rcvurg_mask);
+		for (i = 0; i < dd->ipath_cfgports; i++) {
+			if (portr & (1 << i) && dd->ipath_pd[i] &&
+			    dd->ipath_pd[i]->port_cnt) {
+				if (i == 0)
+					ipath_kreceive(dd);
+				else if (test_bit(IPATH_PORT_WAITING_RCV,
+						  &dd->ipath_pd[i]->port_flag)) {
+					clear_bit(IPATH_PORT_WAITING_RCV,
+						  &dd->ipath_pd[i]->port_flag);
+					clear_bit(1UL << (i+INFINIPATH_R_INTRAVAIL_SHIFT),
+						  &dd->ipath_rcvctrl);
+					wake_up_interruptible(&dd->ipath_pd[i]->
+							      port_wait);
+					rcvdint = 1;
+				}
+			}
+		}
+		if (rcvdint) {
+			/* only want to take one interrupt, so turn off the rcv interrupt
+			 * for all the ports that we did the wakeup on (but never for
+			 * kernel port)
+			 */
+			ipath_write_kreg(dd, dd->ipath_kregs->kr_rcvctrl,
+					 dd->ipath_rcvctrl);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
diff -r 696ba12283f4 -r a9ed49ad489c drivers/infiniband/hw/ipath/ipath_stats.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_stats.c	Thu Mar  9 16:15:49 2006 -0800
@@ -0,0 +1,274 @@
+/*
+ * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#include <linux/pci.h>
+
+#include "ipath_kernel.h"
+
+struct infinipath_stats ipath_stats;
+
+/**
+ * ipath_snap_cntr - snapshot a chip counter
+ * @dd: the infinipath device
+ * @creg: the counter to snapshot
+ *
+ * called from add_timer and user counter read calls, to deal with
+ * counters that wrap in "human time".  The words sent and received, and
+ * the packets sent and received are all that we worry about.  For now,
+ * at least, we don't worry about error counters, because if they wrap
+ * that quickly, we probably don't care.  We may eventually just make this
+ * handle all the counters.  word counters can wrap in about 20 seconds
+ * of full bandwidth traffic, packet counters in a few hours.
+ */
+
+u64 ipath_snap_cntr(struct ipath_devdata *dd, ipath_creg creg)
+{
+	u32 val, reg64 = 0;
+	u64 val64;
+	unsigned long t0, t1;
+
+	t0 = jiffies;
+	/* If fast increment counters are only 32 bits, snapshot them,
+	 * and maintain them as 64bit values in the driver */
+	if (!(dd->ipath_flags & IPATH_32BITCOUNTERS) &&
+	    (creg == dd->ipath_cregs->cr_wordsendcnt ||
+	     creg == dd->ipath_cregs->cr_wordrcvcnt ||
+	     creg == dd->ipath_cregs->cr_pktsendcnt ||
+	     creg == dd->ipath_cregs->cr_pktrcvcnt)) {
+		val64 = ipath_read_creg(dd, creg);
+		val = val64 == ~0ULL ? ~0U : 0;
+		reg64 = 1;
+	} else			/* val64 just to keep gcc quiet... */
+		val64 = val = ipath_read_creg32(dd, creg);
+	/*
+	 * See if a second has passed.  This is just a way to detect
+	 * things that are quite broken.  Normally this should take
+	 * just a few cycles (the check is for long enough that we
+	 * don't care if we get pre-empted.)  An Opteron HT O read
+	 * timeout is 4 seconds with normal NB values
+	 */
+	t1 = jiffies;
+	if (time_before(t0 + HZ, t1) && val == -1) {
+		ipath_dev_err(dd, "Error!  Reading counter 0x%x timed out\n",
+			      creg);
+		return 0ULL;
+	}
+	if (reg64)
+		return val64;
+
+	if (creg == dd->ipath_cregs->cr_wordsendcnt) {
+		if (val != dd->ipath_lastsword) {
+			dd->ipath_sword += val - dd->ipath_lastsword;
+			dd->ipath_lastsword = val;
+		}
+		val64 = dd->ipath_sword;
+	} else if (creg == dd->ipath_cregs->cr_wordrcvcnt) {
+		if (val != dd->ipath_lastrword) {
+			dd->ipath_rword += val - dd->ipath_lastrword;
+			dd->ipath_lastrword = val;
+		}
+		val64 = dd->ipath_rword;
+	} else if (creg == dd->ipath_cregs->cr_pktsendcnt) {
+		if (val != dd->ipath_lastspkts) {
+			dd->ipath_spkts += val - dd->ipath_lastspkts;
+			dd->ipath_lastspkts = val;
+		}
+		val64 = dd->ipath_spkts;
+	} else if (creg == dd->ipath_cregs->cr_pktrcvcnt) {
+		if (val != dd->ipath_lastrpkts) {
+			dd->ipath_rpkts += val - dd->ipath_lastrpkts;
+			dd->ipath_lastrpkts = val;
+		}
+		val64 = dd->ipath_rpkts;
+	} else
+		val64 = (u64) val;
+
+	return val64;
+}
+
+/**
+ * ipath_qcheck - print the delta of egrfull/hdrqfull errors for kernel ports
+ * @dd: the infinipath device
+ *
+ * print the delta of egrfull/hdrqfull errors for kernel ports no more
+ * than every 5 seconds.  User processes are printed at close, but kernel
+ * doesn't close, so...  Separate routine so may call from other places
+ * someday, and so function name when printed by _IPATH_INFO is meaningfull
+ */
+static void ipath_qcheck(struct ipath_devdata *dd)
+{
+	static u64 last_tot_hdrqfull;
+	size_t blen = 0;
+	char buf[128];
+
+	*buf = 0;
+	if (dd->ipath_pd[0]->port_hdrqfull != dd->ipath_p0_hdrqfull) {
+		blen = snprintf(buf, sizeof buf, "port 0 hdrqfull %u",
+				dd->ipath_pd[0]->port_hdrqfull -
+				dd->ipath_p0_hdrqfull);
+		dd->ipath_p0_hdrqfull = dd->ipath_pd[0]->port_hdrqfull;
+	}
+	if (ipath_stats.sps_etidfull != dd->ipath_last_tidfull) {
+		blen +=
+			snprintf(buf + blen, sizeof buf - blen, "%srcvegrfull %llu",
+				 blen ? ", " : "",
+				 (unsigned long long) (ipath_stats.sps_etidfull - dd->ipath_last_tidfull));
+		dd->ipath_last_tidfull = ipath_stats.sps_etidfull;
+	}
+
+	/*
+	 * this is actually the number of hdrq full interrupts, not actual
+	 * events, but at the moment that's mostly what I'm interested in.
+	 * Actual count, etc. is in the counters, if needed.  For production
+	 * users this won't ordinarily be printed.
+	 */
+
+	if ((ipath_debug & (__IPATH_PKTDBG | __IPATH_DBG)) &&
+	    ipath_stats.sps_hdrqfull != last_tot_hdrqfull) {
+		blen +=
+			snprintf(buf + blen, sizeof buf - blen,
+				 "%shdrqfull %llu (all ports)", blen ? ", " : "",
+				 (unsigned long long) (ipath_stats.sps_hdrqfull - last_tot_hdrqfull));
+		last_tot_hdrqfull = ipath_stats.sps_hdrqfull;
+	}
+	if (blen)
+		ipath_dbg("%s\n", buf);
+
+	if (dd->ipath_port0head !=
+	    (uint32_t)__le64_to_cpu(*dd->ipath_hdrqtailptr)) {
+		if (dd->ipath_lastport0rcv_cnt == ipath_stats.sps_port0pkts) {
+			ipath_cdbg(PKT, "missing rcv interrupts? port0 hd=%llx tl=%x; port0pkts %llx\n",
+				   (unsigned long long) __le64_to_cpu(*dd->ipath_hdrqtailptr),
+				   dd->ipath_port0head,
+				   (unsigned long long) ipath_stats.sps_port0pkts);
+			ipath_kreceive(dd);
+		}
+		dd->ipath_lastport0rcv_cnt = ipath_stats.sps_port0pkts;
+	}
+}
+
+/**
+ * ipath_get_faststats - get word counters from chip before they can overflow
+ * @opaque - contains a pointer to the infinipath device ipath_devdata
+ *
+ * called from add_timer
+ */
+void ipath_get_faststats(unsigned long opaque)
+{
+	struct ipath_devdata *dd = (struct ipath_devdata *) opaque;
+	u32 val;
+	static unsigned cnt;
+
+	/* don't access the chip while running diags, or memory diags can fail */
+	if (!dd->ipath_kregbase || !(dd->ipath_flags & IPATH_PRESENT) ||
+	    ipath_diag_alive)
+		/* but re-arm the timer, for diags case; won't hurt other */
+		goto done;
+
+	if (dd->ipath_flags & IPATH_32BITCOUNTERS) {
+		ipath_snap_cntr(dd, dd->ipath_cregs->cr_wordsendcnt);
+		ipath_snap_cntr(dd, dd->ipath_cregs->cr_wordrcvcnt);
+		ipath_snap_cntr(dd, dd->ipath_cregs->cr_pktsendcnt);
+		ipath_snap_cntr(dd, dd->ipath_cregs->cr_pktrcvcnt);
+	}
+
+	ipath_qcheck(dd);
+
+	/*
+	 * deal with repeat error suppression.  Doesn't really matter if
+	 * last error was almost a full interval ago, or just a few usecs
+	 * ago; still won't get more than 2 per interval.  We may want
+	 * longer intervals for this eventually, could do with mod, counter
+	 * or separate timer.  Also see code in ipath_handle_errors() and
+	 * ipath_handle_hwerrors().
+	 */
+
+	if (dd->ipath_lasterror)
+		dd->ipath_lasterror = 0;
+	if (dd->ipath_lasthwerror)
+		dd->ipath_lasthwerror = 0;
+	if ((dd->ipath_maskederrs & ~dd->ipath_ignorederrs)
+	    && get_cycles() > dd->ipath_unmasktime) {
+		char ebuf[256];
+		ipath_decode_err(ebuf, sizeof ebuf,
+				 (dd->ipath_maskederrs & ~dd->
+				  ipath_ignorederrs));
+		if ((dd->ipath_maskederrs & ~dd->
+		     ipath_ignorederrs)
+		    & ~(INFINIPATH_E_RRCVEGRFULL | INFINIPATH_E_RRCVHDRFULL)) {
+			ipath_dev_err(dd, "Re-enabling masked errors (%s)\n",
+				      ebuf);
+		} else {
+			/*
+			 * rcvegrfull and rcvhdrqfull are "normal", for some types of
+			 * processes (mostly benchmarks) that send huge numbers
+			 * of messages, while not processing them.  So only complain
+			 * about these at debug level.
+			 */
+			ipath_dbg("Disabling frequent queue full errors (%s)\n",
+				  ebuf);
+		}
+		dd->ipath_maskederrs = dd->ipath_ignorederrs;
+		ipath_write_kreg(dd, dd->ipath_kregs->kr_errormask,
+				 ~dd->ipath_maskederrs);
+	}
+
+	/* limit qfull messages to ~one per minute per port */
+	if ((++cnt & 0x10)) {
+		for (val = dd->ipath_cfgports - 1; ((int)val) >= 0;
+		     val--) {
+			if (dd->ipath_lastegrheads[val] != -1)
+				dd->ipath_lastegrheads[val] = -1;
+			if (dd->ipath_lastrcvhdrqtails[val] != -1)
+				dd->ipath_lastrcvhdrqtails[val] = -1;
+		}
+	}
+
+	if (dd->ipath_nosma_bufs) {
+		dd->ipath_nosma_secs += 5;
+		if (dd->ipath_nosma_secs >= 30) {
+			ipath_cdbg(SMA, "No SMA bufs avail %u seconds; cancelling pending sends\n",
+				   dd->ipath_nosma_secs);
+			ipath_disarm_piobufs(dd,
+					     dd->ipath_lastport_piobuf,
+					     dd->ipath_piobcnt2k +
+					     dd->ipath_piobcnt4k -
+					     dd->ipath_lastport_piobuf);
+			dd->ipath_nosma_secs = 0;	/* start again, if necessary */
+		} else
+			ipath_cdbg(SMA, "No SMA bufs avail %u tries, after %u seconds\n",
+				   dd->ipath_nosma_bufs, dd->ipath_nosma_secs);
+	}
+
+done:
+	mod_timer(&dd->ipath_stats_timer, jiffies + HZ * 5);
+}
diff -r 696ba12283f4 -r a9ed49ad489c drivers/infiniband/hw/ipath/ipath_wc_x86_64.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_wc_x86_64.c	Thu Mar  9 16:15:49 2006 -0800
@@ -0,0 +1,155 @@
+/*
+ * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+/*
+ * This file is conditionally built on x86_64 only.  Otherwise weak symbol
+ * versions of the functions exported from here are used.
+ */
+
+#include <linux/pci.h>
+#include <asm/mtrr.h>
+#include <asm/processor.h>
+
+#include "ipath_kernel.h"
+
+/**
+ * ipath_enable_wc - enable write combining for MMIO writes to the device
+ * @dd: infinipath device
+ *
+ * This routine is x86_64-specific; it twiddles the CPU's MTRRs to enable
+ * write combining.
+ */
+int ipath_enable_wc(struct ipath_devdata *dd)
+{
+	int ret = 0;
+	u64 pioaddr, piolen;
+	unsigned bits;
+	const unsigned long addr = pci_resource_start(dd->pcidev, 0);
+	const size_t len = pci_resource_len(dd->pcidev, 0);
+
+	/*
+	 * Set the PIO buffers to be WCCOMB, so we get HT bursts to the
+	 * chip.  Linux (possibly the hardware) requires it to be on a power
+	 * of 2 address matching the length (which has to be a power of 2).
+	 * For rev1, that means the base address, for rev2, it will be just
+	 * the PIO buffers themselves.
+	 */
+	pioaddr = addr + dd->ipath_piobufbase;
+	piolen = (dd->ipath_piobcnt2k +
+		  dd->ipath_piobcnt4k) *
+		ALIGN(dd->ipath_piobcnt2k +
+		      dd->ipath_piobcnt4k, dd->ipath_palign);
+
+	for (bits = 0; !(piolen & (1ULL << bits)); bits++)
+		/* do nothing */ ;
+
+	if (piolen != (1ULL << bits)) {
+		piolen >>= bits;
+		while (piolen >>= 1)
+			bits++;
+		piolen = 1ULL << (bits + 1);
+	}
+	if (pioaddr & (piolen - 1)) {
+		u64 atmp;
+		ipath_dbg("pioaddr %llx not on right boundary for size "
+			  "%llx, fixing\n",
+			  (unsigned long long) pioaddr,
+			  (unsigned long long) piolen);
+		atmp = pioaddr & ~(piolen - 1);
+		if (atmp < addr || (atmp + piolen) > (addr + len)) {
+			ipath_dev_err(dd, "No way to align address/size "
+				      "(%llx/%llx), no WC mtrr\n",
+				      (unsigned long long) atmp,
+				      (unsigned long long) piolen << 1);
+			ret = -ENODEV;
+		} else {
+			ipath_dbg("changing WC base from %llx to %llx, "
+				  "len from %llx to %llx\n",
+				  (unsigned long long) pioaddr,
+				  (unsigned long long) atmp,
+				  (unsigned long long) piolen,
+				  (unsigned long long) piolen << 1);
+			pioaddr = atmp;
+			piolen <<= 1;
+		}
+	}
+
+	if (!ret) {
+		int cookie;
+		ipath_cdbg(VERBOSE, "Setting mtrr for chip to WC "
+			   "(addr %llx, len=0x%llx)\n",
+			   (unsigned long long) pioaddr,
+			   (unsigned long long) piolen);
+		cookie = mtrr_add(pioaddr, piolen, MTRR_TYPE_WRCOMB, 0);
+		if (cookie < 0) {
+			dev_info(&dd->pcidev->dev,
+				 "mtrr_add(%llx,0x%llx,WC,0) failed "
+				 "(%d)\n", (unsigned long long) pioaddr,
+				 (unsigned long long) piolen, cookie);
+			ret = -EINVAL;
+		} else {
+			ipath_cdbg(VERBOSE, "Set mtrr for chip to WC, "
+				   "cookie is %d\n", cookie);
+			dd->ipath_wc_cookie = cookie;
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * ipath_disable_wc - disable write combining for MMIO writes to the device
+ * @dd: infinipath device
+ */
+void ipath_disable_wc(struct ipath_devdata *dd)
+{
+	if (dd->ipath_wc_cookie) {
+		ipath_cdbg(VERBOSE, "undoing WCCOMB on pio buffers\n");
+		mtrr_del(dd->ipath_wc_cookie, 0, 0);
+		dd->ipath_wc_cookie = 0;
+	}
+}
+
+/**
+ * ipath_unordered_wc - indicate whether write combining is ordered
+ *
+ * Because our performance depends on our ability to do write combining mmio
+ * writes in the most efficient way, we need to know if we are on an Intel
+ * or AMD x86_64 processor.  AMD x86_64 processors flush WC buffers out in
+ * the order completed, and so no special flushing is required to get
+ * correct ordering.  Intel processors, however, will flush write buffers
+ * out in "random" orders, and so explict ordering is needed at times.
+ */
+int ipath_unordered_wc(void)
+{
+	return boot_cpu_data.x86_vendor == X86_VENDOR_INTEL;
+}
