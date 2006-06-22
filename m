Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161115AbWFVNZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161115AbWFVNZr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 09:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161117AbWFVNZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 09:25:47 -0400
Received: from sun-email.corp.avocent.com ([65.217.42.16]:46223 "EHLO
	sun-email.corp.avocent.com") by vger.kernel.org with ESMTP
	id S1161115AbWFVNZp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 09:25:45 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [RFC][PATCH 12/13] Equinox SST driver: sysfs support
Date: Thu, 22 Jun 2006 09:25:44 -0400
Message-ID: <4821D5B6CD3C1B4880E6E94C6E70913E01B71115@sun-email.corp.avocent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC][PATCH 12/13] Equinox SST driver: sysfs support
Thread-Index: AcaV/11CyVwseC7mRGeU30ar3Jm7eA==
From: "Straub, Michael" <Michael.Straub@avocent.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds Equinox multi-port serial (SST) driver.

Part 12: new source file: drivers/char/eqnx/sst_sysfs.c.  Adds new sysfs
attribute files at both the board level and the TTY level.  These are
used
for status and diagnostic information.  Note that there are some binary
TTY
sysfs files.  This information is used by diagnostic utilities.  The
previous
version of the driver provided this same information via ioctls, using a
unique character device.

Signed-off-by: Mike Straub <michael.straub@avocent.com>

---
 sst_sysfs.c | 1379
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 1379 insertions(+)

diff -Naurp -X dontdiff linux-2.6.17/drivers/char/eqnx/sst_sysfs.c
linux-2.6.17.eqnx/drivers/char/eqnx/sst_sysfs.c
--- linux-2.6.17/drivers/char/eqnx/sst_sysfs.c	1969-12-31
19:00:00.000000000 -0500
+++ linux-2.6.17.eqnx/drivers/char/eqnx/sst_sysfs.c	2006-06-20
09:50:15.000000000 -0400
@@ -0,0 +1,1379 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+
+/*
+ * This driver supports the PCI models of the Equinox / Avocent SST
boards
+ * using SSP-4 and SSP-64 ASIC technology
+ * Boards supported:
+ * SSP-4P
+ * SSP-8P
+ * SSP-16P
+ * SSP-64P
+ * SSP-128P
+ *
+ * Currently maintained by mike straub <michael.straub@avocent.com>
+ */
+
+/*
+ * sysfs routines.
+ * provides diagnostic and some control functions at board and tty
level.
+ * each file is described below.
+ */
+
+#include <linux/config.h>
+#include <linux/version.h>
+
+#ifdef CONFIG_MODVERSIONS
+#define MODVERSIONS	1
+#endif
+
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/sysfs.h>
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/spinlock.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+
+#include "icp.h"
+#include "eqnx_def.h"
+#include "eqnx.h"
+
+/**********************************************************************
*****/
+/* module globals and defines
*/
+/**********************************************************************
*****/
+struct datascope eqnx_dscope[2];
+
+/**********************************************************************
*****/
+/* external variable and routines
*/
+/**********************************************************************
*****/
+extern struct mpdev eqnx_dev[MAXSSP];
+extern struct mpchan *eqnx_chan;
+extern int eqnx_nssps;
+
+extern u8 eqnx_get_signal_state(struct mpchan *);
+extern void eqnx_frame_wait(struct mpchan *, int);
+extern int eqnx_write_room(struct tty_struct *);
+
+/**********************************************************************
***
+ *
+ * board-level sysfs functions
+ *
+
************************************************************************
*/
+
+/*
+ * The following attribute files are provided in the device directory:
+ *
+ * board_number = internal board number
+ * name = SST board name
+ * driver_version = version number for eqnx driver
+ * asic = ASIC type
+ * port_count = total number of ports
+ * flags = relevant board flags
+ * status = alive, state and fail value
+ * lmx_count = count of LMXs
+ * lmx_index = index of LMX to get info from
+ * lmx_status = active, id and chan state
+ * lmx_rmt_status = remote active, remote id
+ */
+
+/*
+ * locate_mpd_by_dev(d)
+ * return the board structure (mpd) from device pointer
+ *
+ * d	= device pointer
+ */
+static struct mpdev *locate_mpd_by_dev(struct device *d)
+{
+	int i;
+	struct mpdev *mpd = NULL;
+
+	for (i = 0; i < eqnx_nssps; i++) {
+		if (eqnx_dev[i].dev == d)
+			mpd = &eqnx_dev[i];
+	}
+
+	return mpd;
+}
+
+/*
+ * show_board_number(d, attr, buf)
+ * return SST internal board number
+ *
+ * d	= device pointer
+ * attr	= attribute pointer
+ * buf	= return buffer
+ */
+static ssize_t show_board_number(struct device *d, struct
device_attribute
+				 *attr, char *buf)
+{
+	struct mpdev *mpd;
+
+	mpd = locate_mpd_by_dev(d);
+	if (mpd == NULL)
+		return 0;
+
+	return sprintf(buf, "0x%x\n", ((int) (mpd - eqnx_dev)) + 1);
+}
+
+static DEVICE_ATTR(board_number, S_IRUGO, show_board_number, NULL);
+
+/*
+ * show_name(d, attr, buf)
+ * return SST board name
+ *
+ * d	= device pointer
+ * attr	= attribute pointer
+ * buf	= return buffer
+ */
+static ssize_t show_name(struct device *d, struct device_attribute
*attr,
+			 char *buf)
+{
+	struct mpdev *mpd;
+
+	mpd = locate_mpd_by_dev(d);
+	if (mpd == NULL)
+		return 0;
+
+	return sprintf(buf, "%s\n", mpd->mpd_board_def->name);
+}
+
+static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
+
+/*
+ * show_driver_version(d, attr, buf)
+ * return eqnx driver version
+ *
+ * d	= device pointer
+ * attr	= attribute pointer
+ * buf	= return buffer
+ */
+static ssize_t show_driver_version(struct device *d,
+				   struct device_attribute *attr, char
*buf)
+{
+	return sprintf(buf, "%s\n", VERSNUM);
+}
+
+static DEVICE_ATTR(driver_version, S_IRUGO, show_driver_version, NULL);
+
+/*
+ * show_asic(d, attr, buf)
+ * return ASIC type
+ *
+ * d	= device pointer
+ * attr	= attribute pointer
+ * buf	= return buffer
+ */
+static ssize_t show_asic(struct device *d, struct device_attribute
*attr,
+			 char *buf)
+{
+	struct mpdev *mpd;
+
+	mpd = locate_mpd_by_dev(d);
+	if (mpd == NULL)
+		return 0;
+
+	return sprintf(buf, "0x%x\n", mpd->mpd_board_def->asic);
+}
+
+static DEVICE_ATTR(asic, S_IRUGO, show_asic, NULL);
+
+/*
+ * show_port_count(d, attr, buf)
+ * return total port count
+ *
+ * d	= device pointer
+ * attr	= attribute pointer
+ * buf	= return buffer
+ */
+static ssize_t show_port_count(struct device *d, struct
device_attribute *attr,
+			       char *buf)
+{
+	struct mpdev *mpd;
+
+	mpd = locate_mpd_by_dev(d);
+	if (mpd == NULL)
+		return 0;
+
+	return sprintf(buf, "0x%x\n",
mpd->mpd_board_def->number_of_ports);
+}
+
+static DEVICE_ATTR(port_count, S_IRUGO, show_port_count, NULL);
+
+/*
+ * show_flags(d, attr, buf)
+ * return board flags
+ *
+ * d	= device pointer
+ * attr	= attribute pointer
+ * buf	= return buffer
+ */
+static ssize_t show_flags(struct device *d, struct device_attribute
*attr,
+			  char *buf)
+{
+	struct mpdev *mpd;
+
+	mpd = locate_mpd_by_dev(d);
+	if (mpd == NULL)
+		return 0;
+
+	return sprintf(buf, "0x%x\n", mpd->mpd_board_def->flags);
+}
+
+static DEVICE_ATTR(flags, S_IRUGO, show_flags, NULL);
+
+/*
+ * show_status(d, attr, buf)
+ * return board status: alive, state and fail
+ *
+ * d	= device pointer
+ * attr	= attribute pointer
+ * buf	= return buffer
+ */
+static ssize_t show_status(struct device *d, struct device_attribute
*attr,
+			   char *buf)
+{
+	struct mpdev *mpd;
+	unsigned int status;
+
+	mpd = locate_mpd_by_dev(d);
+	if (mpd == NULL)
+		return 0;
+
+	status = mpd->mpd_alive;
+	status |= ((mpd->mpd_cnfg_state << 8) & 0xff00);
+	status |= ((mpd->mpd_cnfg_fail << 16) & 0xff0000);
+	return sprintf(buf, "0x%x\n", status);
+}
+
+static DEVICE_ATTR(status, S_IRUGO, show_status, NULL);
+
+/*
+ * show_lmx_count(d, attr, buf)
+ * return total lmx count
+ *
+ * d	= device pointer
+ * attr	= attribute pointer
+ * buf	= return buffer
+ */
+static ssize_t show_lmx_count(struct device *d, struct device_attribute
*attr,
+			      char *buf)
+{
+	struct mpdev *mpd;
+	int count;
+
+	mpd = locate_mpd_by_dev(d);
+	if (mpd == NULL)
+		return 0;
+
+	if (mpd->mpd_board_def->asic == SSP4)
+		count = 1;
+	else
+		count = mpd->mpd_board_def->number_of_asics * MAXLMX;
+
+	return sprintf(buf, "0x%x\n", count);
+}
+
+static DEVICE_ATTR(lmx_count, S_IRUGO, show_lmx_count, NULL);
+
+/*
+ * show_lmx_index(d, attr, buf)
+ * return lmx index
+ *
+ * d	= device pointer
+ * attr	= attribute pointer
+ * buf	= return buffer
+ */
+static ssize_t show_lmx_index(struct device *d, struct device_attribute
*attr,
+			      char *buf)
+{
+	struct mpdev *mpd;
+
+	mpd = locate_mpd_by_dev(d);
+	if (mpd == NULL)
+		return 0;
+
+	return sprintf(buf, "0x%x\n", mpd->mpd_lmx_index);
+}
+
+/*
+ * store_lmx_index(d, attr, buf, size)
+ * set lmx index
+ *
+ * d	= device pointer
+ * attr	= attribute pointer
+ * buf	= input buffer
+ * size	= input size
+ */
+static ssize_t store_lmx_index(struct device *d, struct
device_attribute *attr,
+			       const char *buf, size_t size)
+{
+	struct mpdev *mpd;
+	int index, max;
+
+	mpd = locate_mpd_by_dev(d);
+	if (mpd == NULL)
+		return 0;
+
+	if (mpd->mpd_board_def->asic == SSP4)
+		max = 1;
+	else
+		max = mpd->mpd_board_def->number_of_asics * MAXLMX;
+
+	index = simple_strtol(buf, NULL, 10);
+	if ((index >= 0) && (index < max))
+		mpd->mpd_lmx_index = index;
+
+	return size;
+}
+
+static DEVICE_ATTR(lmx_index, S_IRUSR | S_IWUSR, show_lmx_index,
+		   store_lmx_index);
+
+/*
+ * show_lmx_status(d, attr, buf)
+ * return lmx status: active, id and chan
+ *
+ * d	= device pointer
+ * attr	= attribute pointer
+ * buf	= return buffer
+ */
+static ssize_t show_lmx_status(struct device *d, struct
device_attribute *attr,
+			       char *buf)
+{
+	struct mpdev *mpd;
+	struct icp_struct *icp;
+	unsigned int status;
+	int index;
+
+	mpd = locate_mpd_by_dev(d);
+	if (mpd == NULL)
+		return 0;
+
+	index = mpd->mpd_lmx_index;
+	if (index >= MAXLMX) {
+		icp = &mpd->icp[1];
+		index -= 4;
+	} else
+		icp = &mpd->icp[0];
+
+	status = icp->lmx[index].lmx_active & 0xff;
+	status |= ((icp->lmx[index].lmx_id << 8) & 0xff00);
+	status |= ((icp->lmx[index].lmx_chan << 16) & 0xff0000);
+
+	return sprintf(buf, "0x%x\n", status);
+}
+
+static DEVICE_ATTR(lmx_status, S_IRUGO, show_lmx_status, NULL);
+
+/*
+ * show_lmx_rmt_status(d, attr, buf)
+ * return lmx rmt status: active and id
+ *
+ * d	= device pointer
+ * attr	= attribute pointer
+ * buf	= return buffer
+ */
+static ssize_t show_lmx_rmt_status(struct device *d, struct
device_attribute
+				   *attr, char *buf)
+{
+	struct mpdev *mpd;
+	struct icp_struct *icp;
+	unsigned int status;
+	int index;
+
+	mpd = locate_mpd_by_dev(d);
+	if (mpd == NULL)
+		return 0;
+
+	index = mpd->mpd_lmx_index;
+	if (index >= MAXLMX) {
+		icp = &mpd->icp[1];
+		index -= 4;
+	} else
+		icp = &mpd->icp[0];
+
+	status = icp->lmx[index].lmx_rmt_active & 0xff;
+	status |= ((icp->lmx[index].lmx_rmt_id << 8) & 0xff00);
+
+	return sprintf(buf, "0x%x\n", status);
+}
+
+static DEVICE_ATTR(lmx_rmt_status, S_IRUGO, show_lmx_rmt_status, NULL);
+
+static struct attribute *eqnx_sysfs_entries[] = {
+	&dev_attr_board_number.attr,
+	&dev_attr_name.attr,
+	&dev_attr_driver_version.attr,
+	&dev_attr_asic.attr,
+	&dev_attr_port_count.attr,
+	&dev_attr_flags.attr,
+	&dev_attr_status.attr,
+	&dev_attr_lmx_count.attr,
+	&dev_attr_lmx_index.attr,
+	&dev_attr_lmx_status.attr,
+	&dev_attr_lmx_rmt_status.attr,
+	NULL
+};
+
+static struct attribute_group eqnx_attribute_group = {
+	.name = NULL,
+	.attrs = eqnx_sysfs_entries,
+};
+
+/*
+ * eqnx_create_sysfs(d)
+ * create sysfs files and directories for selected device.
+ *
+ * d	= device pointer
+ */
+void eqnx_create_sysfs(struct device *d)
+{
+	int ret;
+
+	ret = sysfs_create_group(&d->kobj, &eqnx_attribute_group);
+	if (ret) {
+		printk(KERN_ERR
+		       "eqnx: failed to create sysfs device
attributes.\n");
+		sysfs_remove_group(&d->kobj, &eqnx_attribute_group);
+	}
+}
+
+/*
+ * eqnx_remove_sysfs(d)
+ * remove sysfs files and directories for selected device.
+ *
+ * d	= device pointer
+ */
+void eqnx_remove_sysfs(struct device *d)
+{
+	sysfs_remove_group(&d->kobj, &eqnx_attribute_group);
+}
+
+/**********************************************************************
***
+ *
+ * channel (port) level sysfs functions
+ *
+
************************************************************************
*/
+
+/*
+ * The following attribute files are provided in the tty directory:
+ *
+ * termios_i = termios iflag settings 
+ * termios_o = termios oflag settings 
+ * termios_c = termios cflag settings 
+ * termios_l = termios lflag settings 
+ * signals = port signals (inbound and outbound)
+ * bufstats = input / output buffer counts
+ * flow = flow control state
+ * input = input counter, may be cleared
+ * output = output counter, may be cleared
+ * parity = parity error counter, may be cleared
+ * framing = framing error counter, may be cleared
+ * break = break error counter, may be cleared
+ * flags = tty flags 
+ * openwaitcnt = openwaitcnt
+ * loopback = loopback state - can be set
+ * datascope = datascope state - can be set
+ *
+ * input_registers = ICP input registers (binary data)
+ * output_registers = ICP output registers (binary data)
+ * datascope_input = datascope input data (binary data)
+ * datascope_output = datascope output data (binary data)
+ */
+
+/*
+ * locate_mpc_by_class(c)
+ * return the channel structure (mpc) from class device pointer
+ *
+ * c	= class device pointer
+ */
+static struct mpchan *locate_mpc_by_dev(struct class_device *c)
+{
+	int i;
+	struct mpchan *mpc = NULL;
+
+	for (i = 0; i < (eqnx_nssps * MAXCHNL_BRD); i++) {
+		if (eqnx_chan[i].cdev == c)
+			mpc = &eqnx_chan[i];
+	}
+
+	return mpc;
+}
+
+/*
+ * show_termios_i(c, buf)
+ * return tty termios iflag settings
+ *
+ * c	= class device pointer
+ * buf	= return buffer
+ */
+static ssize_t show_termios_i(struct class_device *c, char *buf)
+{
+	struct mpchan *mpc;
+
+	mpc = locate_mpc_by_dev(c);
+	if (mpc == NULL)
+		return 0;
+
+	if ((mpc->flags & ASYNC_INITIALIZED) && (mpc->mpc_tty) &&
+	    (mpc->mpc_tty->termios))
+		return sprintf(buf, "0x%x\n",
mpc->mpc_tty->termios->c_iflag);
+	else
+		return sprintf(buf, "0x0\n");
+}
+
+static CLASS_DEVICE_ATTR(termios_i, S_IRUSR, show_termios_i, NULL);
+
+/*
+ * show_termios_o(c, buf)
+ * return tty termios oflag settings
+ *
+ * c	= class device pointer
+ * buf	= return buffer
+ */
+static ssize_t show_termios_o(struct class_device *c, char *buf)
+{
+	struct mpchan *mpc;
+
+	mpc = locate_mpc_by_dev(c);
+	if (mpc == NULL)
+		return 0;
+
+	if ((mpc->flags & ASYNC_INITIALIZED) && (mpc->mpc_tty) &&
+	    (mpc->mpc_tty->termios))
+		return sprintf(buf, "0x%x\n",
mpc->mpc_tty->termios->c_oflag);
+	else
+		return sprintf(buf, "0x0\n");
+}
+
+static CLASS_DEVICE_ATTR(termios_o, S_IRUSR, show_termios_o, NULL);
+
+/*
+ * show_termios_c(c, buf)
+ * return tty termios cflag settings
+ *
+ * c	= class device pointer
+ * buf	= return buffer
+ */
+static ssize_t show_termios_c(struct class_device *c, char *buf)
+{
+	struct mpchan *mpc;
+
+	mpc = locate_mpc_by_dev(c);
+	if (mpc == NULL)
+		return 0;
+
+	if ((mpc->flags & ASYNC_INITIALIZED) && (mpc->mpc_tty) &&
+	    (mpc->mpc_tty->termios))
+		return sprintf(buf, "0x%x\n",
mpc->mpc_tty->termios->c_cflag);
+	else
+		return sprintf(buf, "0x0\n");
+}
+
+static CLASS_DEVICE_ATTR(termios_c, S_IRUSR, show_termios_c, NULL);
+
+/*
+ * show_termios_l(c, buf)
+ * return tty termios lflag settings
+ *
+ * c	= class device pointer
+ * buf	= return buffer
+ */
+static ssize_t show_termios_l(struct class_device *c, char *buf)
+{
+	struct mpchan *mpc;
+
+	mpc = locate_mpc_by_dev(c);
+	if (mpc == NULL)
+		return 0;
+
+	if ((mpc->flags & ASYNC_INITIALIZED) && (mpc->mpc_tty) &&
+	    (mpc->mpc_tty->termios))
+		return sprintf(buf, "0x%x\n",
mpc->mpc_tty->termios->c_lflag);
+	else
+		return sprintf(buf, "0x0\n");
+}
+
+static CLASS_DEVICE_ATTR(termios_l, S_IRUSR, show_termios_l, NULL);
+
+/*
+ * show_signals(c, buf)
+ * return tty signal settings
+ *
+ * c	= class device pointer
+ * buf	= return buffer
+ */
+static ssize_t show_signals(struct class_device *c, char *buf)
+{
+	struct mpchan *mpc;
+
+	mpc = locate_mpc_by_dev(c);
+	if (mpc == NULL)
+		return 0;
+
+	return sprintf(buf, "0x%x\n", eqnx_get_signal_state(mpc));
+
+}
+
+static CLASS_DEVICE_ATTR(signals, S_IRUSR, show_signals, NULL);
+
+/*
+ * show_bufstats(c, buf)
+ * return tty input / output buffer counts
+ *
+ * c	= class device pointer
+ * buf	= return buffer
+ */
+static ssize_t show_bufstats(struct class_device *c, char *buf)
+{
+	struct mpchan *mpc;
+	volatile struct icp_in_struct *icpi;
+	volatile struct cin_bnk_struct *icpb;
+	volatile struct cout_que_struct *icpq;
+	unsigned int counts;
+
+	mpc = locate_mpc_by_dev(c);
+	if (mpc == NULL)
+		return 0;
+
+	icpi = mpc->mpc_icpi;
+	icpb = (icpi->cin_locks & LOCK_A) ? &icpi->cin_bank_b :
+	    &icpi->cin_bank_a;
+	if (!(SSTRD16(icpb->bank_events) & EV_REG_UPDT))
+		/* make sure regs are valid */
+		eqnx_frame_wait(mpc, 2);
+	icpq = (volatile struct cout_que_struct
*)&mpc->mpc_icpo->cout_q0;
+
+	/*
+	 * returned input buffered count and output buffered count
+	 */
+	counts = SSTRD16(icpb->bank_num_chars);
+	counts |= ((SSTRD16(icpq->q_data_count) << 16) & 0xffff0000);
+	return (sprintf(buf, "0x%x ", counts));
+}
+
+static CLASS_DEVICE_ATTR(bufstats, S_IRUSR, show_bufstats, NULL);
+
+/*
+ * show_flow(c, buf)
+ * return tty input / output flow control state
+ *
+ * c	= class device pointer
+ * buf	= return buffer
+ */
+static ssize_t show_flow(struct class_device *c, char *buf)
+{
+	struct mpchan *mpc;
+	volatile struct icp_in_struct *icpi;
+	volatile struct cin_bnk_struct *icpb;
+	unsigned int flow;
+
+	mpc = locate_mpc_by_dev(c);
+	if (mpc == NULL)
+		return 0;
+
+	icpi = mpc->mpc_icpi;
+	icpb = (icpi->cin_locks & LOCK_A) ? &icpi->cin_bank_b :
+	    &icpi->cin_bank_a;
+	if (!(SSTRD16(icpb->bank_events) & EV_REG_UPDT))
+		/* make sure regs are valid */
+		eqnx_frame_wait(mpc, 2);
+
+	/*
+	 * return input flow control state and output flow control state
+	 */
+	flow = 0;
+	if ((mpc->mpc_block) || (mpc->mpc_icpi->cin_intern_flgs &
IN_BUF_OVFL))
+		flow = 0;
+	else
+		flow = 1;
+	if (!(mpc->mpc_icpi->cin_intern_flgs & DAT_OUT_SUSP))
+		flow |= 0x10000;
+
+	return (sprintf(buf, "0x%x ", flow));
+}
+
+static CLASS_DEVICE_ATTR(flow, S_IRUSR, show_flow, NULL);
+
+/*
+ * show_input(c, buf)
+ * return tty input count
+ *
+ * c	= class device pointer
+ * buf	= return buffer
+ */
+static ssize_t show_input(struct class_device *c, char *buf)
+{
+	struct mpchan *mpc;
+
+	mpc = locate_mpc_by_dev(c);
+	if (mpc == NULL)
+		return 0;
+
+	return sprintf(buf, "0x%x\n", mpc->mpc_input);
+}
+
+/*
+ * store_input(c, buf, size)
+ * set (clear) tty input count
+ *
+ * c	= class device pointer
+ * buf	= input buffer
+ * size	= input size
+ */
+static ssize_t store_input(struct class_device *c, const char *buf,
size_t size)
+{
+	struct mpchan *mpc;
+
+	mpc = locate_mpc_by_dev(c);
+	if (mpc == NULL)
+		return 0;
+
+	mpc->mpc_input = 0;
+
+	return size;
+}
+
+static CLASS_DEVICE_ATTR(input, S_IRUSR | S_IWUSR, show_input,
store_input);
+
+/*
+ * show_output(c, buf)
+ * return tty output count
+ *
+ * c	= class device pointer
+ * buf	= return buffer
+ */
+static ssize_t show_output(struct class_device *c, char *buf)
+{
+	struct mpchan *mpc;
+
+	mpc = locate_mpc_by_dev(c);
+	if (mpc == NULL)
+		return 0;
+
+	return sprintf(buf, "0x%x\n", mpc->mpc_output);
+}
+
+/*
+ * store_output(c, buf, size)
+ * set (clear) tty output count
+ *
+ * c	= class device pointer
+ * buf	= input buffer
+ * size	= input size
+ */
+static ssize_t store_output(struct class_device *c, const char *buf,
+			    size_t size)
+{
+	struct mpchan *mpc;
+
+	mpc = locate_mpc_by_dev(c);
+	if (mpc == NULL)
+		return 0;
+
+	mpc->mpc_output = 0;
+
+	return size;
+}
+
+static CLASS_DEVICE_ATTR(output, S_IRUSR | S_IWUSR, show_output,
store_output);
+
+/*
+ * show_parity(c, buf)
+ * return tty parity error count
+ *
+ * c	= class device pointer
+ * buf	= return buffer
+ */
+static ssize_t show_parity(struct class_device *c, char *buf)
+{
+	struct mpchan *mpc;
+
+	mpc = locate_mpc_by_dev(c);
+	if (mpc == NULL)
+		return 0;
+
+	return sprintf(buf, "0x%x\n", mpc->mpc_parity_err_cnt);
+}
+
+/*
+ * store_parity(c, buf, size)
+ * set (clear) tty parity error count
+ *
+ * c	= class device pointer
+ * buf	= input buffer
+ * size	= input size
+ */
+static ssize_t store_parity(struct class_device *c, const char *buf,
+			    size_t size)
+{
+	struct mpchan *mpc;
+
+	mpc = locate_mpc_by_dev(c);
+	if (mpc == NULL)
+		return 0;
+
+	mpc->mpc_parity_err_cnt = 0;
+
+	return size;
+}
+
+static CLASS_DEVICE_ATTR(parity, S_IRUSR | S_IWUSR, show_parity,
store_parity);
+
+/*
+ * show_framing(c, buf)
+ * return tty framing error count
+ *
+ * c	= class device pointer
+ * buf	= return buffer
+ */
+static ssize_t show_framing(struct class_device *c, char *buf)
+{
+	struct mpchan *mpc;
+
+	mpc = locate_mpc_by_dev(c);
+	if (mpc == NULL)
+		return 0;
+
+	return sprintf(buf, "0x%x\n", mpc->mpc_framing_err_cnt);
+}
+
+/*
+ * store_framing(c, buf, size)
+ * set (clear) tty framing error count
+ *
+ * c	= class device pointer
+ * buf	= input buffer
+ * size	= input size
+ */
+static ssize_t store_framing(struct class_device *c, const char *buf,
+			     size_t size)
+{
+	struct mpchan *mpc;
+
+	mpc = locate_mpc_by_dev(c);
+	if (mpc == NULL)
+		return 0;
+
+	mpc->mpc_parity_err_cnt = 0;
+
+	return size;
+}
+
+static CLASS_DEVICE_ATTR(framing, S_IRUSR | S_IWUSR, show_framing,
+			 store_framing);
+
+/*
+ * show_break(c, buf)
+ * return tty break count
+ *
+ * c	= class device pointer
+ * buf	= return buffer
+ */
+static ssize_t show_break(struct class_device *c, char *buf)
+{
+	struct mpchan *mpc;
+
+	mpc = locate_mpc_by_dev(c);
+	if (mpc == NULL)
+		return 0;
+
+	return sprintf(buf, "0x%x\n", mpc->mpc_break_cnt);
+}
+
+/*
+ * store_break(c, buf, size)
+ * set (clear) tty break count
+ *
+ * c	= class device pointer
+ * buf	= input buffer
+ * size	= input size
+ */
+static ssize_t store_break(struct class_device *c, const char *buf,
size_t size)
+{
+	struct mpchan *mpc;
+
+	mpc = locate_mpc_by_dev(c);
+	if (mpc == NULL)
+		return 0;
+
+	mpc->mpc_break_cnt = 0;
+
+	return size;
+}
+
+static CLASS_DEVICE_ATTR(break, S_IRUSR | S_IWUSR, show_break,
store_break);
+
+/*
+ * show_tty_flags(c, buf)
+ * return tty flags
+ *
+ * c	= class device pointer
+ * buf	= return buffer
+ */
+static ssize_t show_tty_flags(struct class_device *c, char *buf)
+{
+	struct mpchan *mpc;
+
+	mpc = locate_mpc_by_dev(c);
+	if (mpc == NULL)
+		return 0;
+
+	return sprintf(buf, "0x%x\n", mpc->mpc_flags);
+}
+
+static CLASS_DEVICE_ATTR(tty_flags, S_IRUSR, show_tty_flags, NULL);
+
+/*
+ * show_openwaitcnt(c, buf)
+ * return tty openwaitcnt
+ *
+ * c	= class device pointer
+ * buf	= return buffer
+ */
+static ssize_t show_openwaitcnt(struct class_device *c, char *buf)
+{
+	struct mpchan *mpc;
+
+	mpc = locate_mpc_by_dev(c);
+	if (mpc == NULL)
+		return 0;
+
+	return sprintf(buf, "0x%x\n", mpc->openwaitcnt);
+}
+
+static CLASS_DEVICE_ATTR(openwaitcnt, S_IRUSR, show_openwaitcnt, NULL);
+
+/*
+ * show_loopback(c, buf)
+ * return tty loopback state
+ *
+ * c	= class device pointer
+ * buf	= return buffer
+ */
+static ssize_t show_loopback(struct class_device *c, char *buf)
+{
+	struct mpchan *mpc;
+
+	mpc = locate_mpc_by_dev(c);
+	if (mpc == NULL)
+		return 0;
+
+	if (mpc->mpc_flags & MPC_LOOPBACK)
+		return sprintf(buf, "0x1\n");
+	else
+		return sprintf(buf, "0x0\n");
+}
+
+/*
+ * store_loopback(c, buf, size)
+ * set tty loopback state
+ *
+ * c	= class device pointer
+ * buf	= input buffer
+ * size	= input size
+ */
+static ssize_t store_loopback(struct class_device *c, const char *buf,
+			      size_t size)
+{
+	struct mpchan *mpc;
+
+	mpc = locate_mpc_by_dev(c);
+	if (mpc == NULL)
+		return 0;
+
+	if (simple_strtol(buf, NULL, 10)) {
+		mpc->mpc_icpo->cout_lmx_command |=
+		    (TX_INTR_LB | TX_XTRN_LB | TX_LMX_CMD_EN);
+		eqnx_frame_wait(mpc, 6);
+		mpc->mpc_icpo->cout_lmx_command &= ~TX_LMX_CMD_EN;
+		mpc->mpc_flags |= MPC_LOOPBACK;
+	} else {
+		mpc->mpc_icpo->cout_lmx_command &= ~(TX_INTR_LB |
TX_XTRN_LB);
+		mpc->mpc_icpo->cout_lmx_command |= TX_LMX_CMD_EN;
+		eqnx_frame_wait(mpc, 6);
+		mpc->mpc_icpo->cout_lmx_command &= ~TX_LMX_CMD_EN;
+		mpc->mpc_flags &= ~MPC_LOOPBACK;
+	}
+
+	return size;
+}
+
+static CLASS_DEVICE_ATTR(loopback, S_IRUSR | S_IWUSR, show_loopback,
+			 store_loopback);
+
+/*
+ * show_datascope(c, buf)
+ * return tty datascope state
+ *
+ * c	= class device pointer
+ * buf	= return buffer
+ */
+static ssize_t show_datascope(struct class_device *c, char *buf)
+{
+	struct mpchan *mpc;
+	int index, val = 0;
+
+	mpc = locate_mpc_by_dev(c);
+	if (mpc == NULL)
+		return 0;
+
+	index = mpc - eqnx_chan;
+	if (!(eqnx_dscope[0].open))
+		return sprintf(buf, "0x0\n");
+	if (eqnx_dscope[0].chan != index)
+		return sprintf(buf, "0xFF\n");
+	if (mpc->mpc_flags & MPC_DSCOPER)
+		val += 0x1;
+	if (mpc->mpc_flags & MPC_DSCOPEW)
+		val += 0x2;
+	return sprintf(buf, "0x%x\n", val);
+}
+
+/*
+ * store_datascope(c, buf, size)
+ * set tty datascope state
+ *
+ * c	= class device pointer
+ * buf	= input buffer
+ * size	= input size
+ */
+static ssize_t store_datascope(struct class_device *c, const char *buf,
+			       size_t size)
+{
+	struct mpchan *mpc;
+	int val, index, i;
+
+	mpc = locate_mpc_by_dev(c);
+	if (mpc == NULL)
+		return 0;
+
+	val = simple_strtol(buf, NULL, 10);
+	if ((val < 0) || (val > 3))
+		return size;
+
+	index = mpc - eqnx_chan;
+
+	/* check for shutdown */
+	if ((val == 0) && (eqnx_dscope[0].open) &&
+	    (eqnx_dscope[0].chan == index)) {
+		eqnx_dscope[0].chan = -1;
+		eqnx_dscope[1].chan = -1;
+		eqnx_dscope[0].open = false;
+		eqnx_dscope[1].open = false;
+		mpc->mpc_flags &= ~(MPC_DSCOPER | MPC_DSCOPEW);
+		return size;
+	}
+
+	/* open for read and or write */
+	if (eqnx_dscope[0].open)
+		return size;
+
+	for (i = 0; i < 2; i++) {
+		eqnx_dscope[i].chan = index;
+		eqnx_dscope[i].open = true;
+		eqnx_dscope[i].q.q_addr = eqnx_dscope[i].buffer;
+		eqnx_dscope[i].q.q_begin = 0;
+		eqnx_dscope[i].q.q_end = DSQMASK;
+		eqnx_dscope[i].q.q_ptr = eqnx_dscope[i].q.q_begin;
+		eqnx_dscope[i].next = eqnx_dscope[i].q.q_begin;
+		eqnx_dscope[i].scope_wait_wait = 0;
+		init_waitqueue_head(&eqnx_dscope[i].scope_wait);
+	}
+
+	if (val & 0x1)
+		mpc->mpc_flags |= MPC_DSCOPER;
+	if (val & 0x2)
+		mpc->mpc_flags |= MPC_DSCOPEW;
+
+	return size;
+}
+
+static CLASS_DEVICE_ATTR(datascope, S_IRUSR | S_IWUSR, show_datascope,
+			 store_datascope);
+
+static struct attribute *eqnx_sysfs_tty_entries[] = {
+	&class_device_attr_termios_i.attr,
+	&class_device_attr_termios_o.attr,
+	&class_device_attr_termios_c.attr,
+	&class_device_attr_termios_l.attr,
+	&class_device_attr_signals.attr,
+	&class_device_attr_bufstats.attr,
+	&class_device_attr_flow.attr,
+	&class_device_attr_input.attr,
+	&class_device_attr_output.attr,
+	&class_device_attr_parity.attr,
+	&class_device_attr_framing.attr,
+	&class_device_attr_break.attr,
+	&class_device_attr_tty_flags.attr,
+	&class_device_attr_openwaitcnt.attr,
+	&class_device_attr_loopback.attr,
+	&class_device_attr_datascope.attr,
+	NULL
+};
+
+static struct attribute_group eqnx_tty_attribute_group = {
+	.name = NULL,
+	.attrs = eqnx_sysfs_tty_entries,
+};
+
+static inline struct class_device * kobj_to_class(struct kobject *kobj)
+{
+	return container_of(kobj, struct class_device, kobj);
+}
+
+/*
+ * show_input_registers(kobj, buf, off, count)
+ * return ICP input registers
+ *
+ * kobj	= kernel object pointer
+ * buf	= return buffer
+ */
+static ssize_t show_input_registers(struct kobject *kobj, char *buf,
+				    loff_t off, size_t count)
+{
+	struct class_device *c;
+	struct mpchan *mpc;
+
+	c = kobj_to_class(kobj);
+	mpc = locate_mpc_by_dev(c);
+	if (mpc == NULL) 
+		return 0;
+
+	memcpy(buf, (unsigned char *)mpc->mpc_icpi,
+	       sizeof(struct icp_in_struct));
+	return (sizeof(struct icp_in_struct));
+}
+
+static struct bin_attribute eqnx_tty_input_registers = {
+	.attr = {
+		.name = "input_registers",
+		.mode = S_IRUGO,
+		.owner = THIS_MODULE,
+	},
+	.size = sizeof(struct icp_in_struct),
+	.read = show_input_registers,
+};
+
+/*
+ * show_output_registers(kobj, buf, off, count)
+ * return ICP output registers
+ *
+ * kobj	= kernel object pointer
+ * buf	= return buffer
+ */
+static ssize_t show_output_registers(struct kobject *kobj, char *buf,
+				     loff_t off, size_t count)
+{
+	struct class_device *c;
+	struct mpchan *mpc;
+
+	c = kobj_to_class(kobj);
+	mpc = locate_mpc_by_dev(c);
+	if (mpc == NULL)
+		return 0;
+
+	memcpy(buf, (unsigned char *)mpc->mpc_icpo,
+	       sizeof(struct icp_out_struct));
+	return (sizeof(struct icp_out_struct));
+}
+
+static struct bin_attribute eqnx_tty_output_registers = {
+	.attr = {
+		.name = "output_registers",
+		.mode = S_IRUGO,
+		.owner = THIS_MODULE,
+	},
+	.size = sizeof(struct icp_out_struct),
+	.read = show_output_registers,
+};
+
+/*
+ * show_datascope_input(kobj, buf, off, count)
+ * return contents of input datascope buffer
+ *
+ * kobj	= kernel object pointer
+ * buf	= return buffer
+ */
+static ssize_t show_datascope_input(struct kobject *kobj, char *buf,
+				    loff_t off, size_t count)
+{
+	struct class_device *c;
+	struct mpchan *mpc;
+	int cnt, end, index;
+
+	c = kobj_to_class(kobj);
+	mpc = locate_mpc_by_dev(c);
+	if (mpc == NULL)
+		return 0;
+
+	index = mpc - eqnx_chan;
+	if (index != eqnx_dscope[0].chan)
+		return 0;
+
+	cnt = (eqnx_dscope[0].next - eqnx_dscope[0].q.q_ptr) & DSQMASK;
+	end = eqnx_dscope[0].q.q_end - eqnx_dscope[0].q.q_ptr + 1;
+	cnt = MIN(cnt, end);
+	cnt = MIN(cnt, 4096);
+
+	if (cnt) {
+		memcpy(buf, (unsigned char *)(eqnx_dscope[0].q.q_addr +
+					      eqnx_dscope[0].q.q_ptr),
cnt);
+		eqnx_dscope[0].q.q_ptr += cnt;
+		if (eqnx_dscope[0].q.q_ptr > eqnx_dscope[0].q.q_end)
+			eqnx_dscope[0].q.q_ptr =
eqnx_dscope[0].q.q_begin;
+	}
+
+	return cnt;
+}
+
+static struct bin_attribute eqnx_tty_datascope_input = {
+	.attr = {
+		.name = "datascope_input",
+		.mode = S_IRUGO,
+		.owner = THIS_MODULE,
+	},
+	.size = 4096,
+	.read = show_datascope_input,
+};
+
+/*
+ * show_datascope_outut(kobj, buf, off, count)
+ * return contents of output datascope buffer
+ *
+ * kobj	= kernel object pointer
+ * buf	= return buffer
+ */
+static ssize_t show_datascope_output(struct kobject *kobj, char *buf,
+				    loff_t off, size_t count)
+{
+	struct class_device *c;
+	struct mpchan *mpc;
+	int cnt, end, index;
+
+	c = kobj_to_class(kobj);
+	mpc = locate_mpc_by_dev(c);
+	if (mpc == NULL)
+		return 0;
+
+	index = mpc - eqnx_chan;
+	if (index != eqnx_dscope[1].chan)
+		return 0;
+
+	cnt = (eqnx_dscope[1].next - eqnx_dscope[1].q.q_ptr) & DSQMASK;
+	end = eqnx_dscope[1].q.q_end - eqnx_dscope[1].q.q_ptr + 1;
+	cnt = MIN(cnt, end);
+	cnt = MIN(cnt, 4096);
+
+	if (cnt) {
+		memcpy(buf, (unsigned char *)(eqnx_dscope[1].q.q_addr +
+					      eqnx_dscope[1].q.q_ptr),
cnt);
+		eqnx_dscope[1].q.q_ptr += cnt;
+		if (eqnx_dscope[1].q.q_ptr > eqnx_dscope[1].q.q_end)
+			eqnx_dscope[1].q.q_ptr =
eqnx_dscope[1].q.q_begin;
+	}
+
+	return cnt;
+}
+
+static struct bin_attribute eqnx_tty_datascope_output = {
+	.attr = {
+		.name = "datascope_output",
+		.mode = S_IRUGO,
+		.owner = THIS_MODULE,
+	},
+	.size = 4096,
+	.read = show_datascope_output,
+};
+
+/*
+ * eqnx_create_tty_sysfs(c)
+ * create sysfs tty files for selected class device.
+ *
+ * c	= class device pointer
+ */
+void eqnx_create_tty_sysfs(struct class_device *c)
+{
+	int ret;
+
+	ret = sysfs_create_group(&c->kobj, &eqnx_tty_attribute_group);
+	if (ret) {
+		printk(KERN_ERR "eqnx: failed to create sysfs tty device
"
+		       "attributes.\n");
+		sysfs_remove_group(&c->kobj, &eqnx_tty_attribute_group);
+		return;
+	}
+
+	ret = sysfs_create_bin_file(&c->kobj,
&eqnx_tty_input_registers);
+	if (ret < 0) {
+		printk(KERN_ERR "eqnx: failed to create sysfs tty device
"
+			"attributes.\n");
+		sysfs_remove_group(&c->kobj, &eqnx_tty_attribute_group);
+		sysfs_remove_bin_file(&c->kobj,
&eqnx_tty_input_registers);
+		return;
+	}
+
+	ret = sysfs_create_bin_file(&c->kobj,
&eqnx_tty_output_registers);
+	if (ret < 0) {
+		printk(KERN_ERR "eqnx: failed to create sysfs tty device
"
+			"attributes.\n");
+		sysfs_remove_group(&c->kobj, &eqnx_tty_attribute_group);
+		sysfs_remove_bin_file(&c->kobj,
&eqnx_tty_input_registers);
+		sysfs_remove_bin_file(&c->kobj,
&eqnx_tty_output_registers);
+		return;
+	}
+
+	ret = sysfs_create_bin_file(&c->kobj,
&eqnx_tty_datascope_input);
+	if (ret < 0) {
+		printk(KERN_ERR "eqnx: failed to create sysfs tty device
"
+			"attributes.\n");
+		sysfs_remove_group(&c->kobj, &eqnx_tty_attribute_group);
+		sysfs_remove_bin_file(&c->kobj,
&eqnx_tty_input_registers);
+		sysfs_remove_bin_file(&c->kobj,
&eqnx_tty_output_registers);
+		sysfs_remove_bin_file(&c->kobj,
&eqnx_tty_datascope_input);
+		return;
+	}
+
+	ret = sysfs_create_bin_file(&c->kobj,
&eqnx_tty_datascope_output);
+	if (ret < 0) {
+		printk(KERN_ERR "eqnx: failed to create sysfs tty device
"
+			"attributes.\n");
+		sysfs_remove_group(&c->kobj, &eqnx_tty_attribute_group);
+		sysfs_remove_bin_file(&c->kobj,
&eqnx_tty_input_registers);
+		sysfs_remove_bin_file(&c->kobj,
&eqnx_tty_output_registers);
+		sysfs_remove_bin_file(&c->kobj,
&eqnx_tty_datascope_input);
+		sysfs_remove_bin_file(&c->kobj,
&eqnx_tty_datascope_output);
+		return;
+	}
+}
+
+/*
+ * eqnx_remove_tty_sysfs(c)
+ * remove sysfs tty files for selected class device.
+ *
+ * c	= device pointer
+ */
+void eqnx_remove_tty_sysfs(struct class_device *c)
+{
+	sysfs_remove_group(&c->kobj, &eqnx_tty_attribute_group);
+	sysfs_remove_bin_file(&c->kobj, &eqnx_tty_input_registers);
+	sysfs_remove_bin_file(&c->kobj, &eqnx_tty_output_registers);
+	sysfs_remove_bin_file(&c->kobj, &eqnx_tty_datascope_input);
+	sysfs_remove_bin_file(&c->kobj, &eqnx_tty_datascope_output);
+}
