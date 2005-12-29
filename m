Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932566AbVL2Am2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbVL2Am2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 19:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbVL2AjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 19:39:24 -0500
Received: from mx.pathscale.com ([64.160.42.68]:50920 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932574AbVL2AjJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 19:39:09 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 8 of 20] ipath - core driver, part 1 of 4
X-Mercurial-Node: ddd21709e12c0cd55bdc2695749082730b12702a
Message-Id: <ddd21709e12c0cd55bdc.1135816287@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1135816279@eng-12.pathscale.com>
Date: Wed, 28 Dec 2005 16:31:27 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r ffbd416f30d4 -r ddd21709e12c drivers/infiniband/hw/ipath/ipath_driver.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Wed Dec 28 14:19:42 2005 -0800
@@ -0,0 +1,1879 @@
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
+ *
+ * Patent licenses, if any, provided herein do not apply to
+ * combinations of this program with other software, or any other
+ * product whatsoever.
+ */
+
+#include <linux/version.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/swap.h>
+#include <asm/mtrr.h>
+#include <linux/netdevice.h>
+
+#include <linux/crc32.h>	/* we can generate our own crc's for testing */
+
+#include "ipath_kernel.h"
+#include "ips_common.h"
+#include "ipath_layer.h"
+
+/*
+ * Our LSB-assigned major number, so scripts can figure
+ * out how to make entry in /dev.
+ */
+
+static int ipath_major = 233;
+
+/*
+ * number of buffers reserved for driver (layered drivers and SMA send).
+ * Reserved at end of buffer list.
+ */
+
+static uint infinipath_kpiobufs = 32;
+
+/*
+ * number of ports we are configured to use (to allow for more pio
+ * buffers per port, etc.)  Zero means use chip value.
+ */
+
+static uint infinipath_cfgports;
+
+/*
+ * number of units we are configured to use (to allow for bringup on
+ * multi-chip systems)  Zero means use only one for now, but eventually
+ * will mean to use infinipath_max
+ */
+
+static uint infinipath_cfgunits;
+
+uint64_t ipath_dummy_val_for_testing;
+
+static __kernel_pid_t ipath_sma_alive;	/* PID of SMA, if it's running */
+static spinlock_t ipath_sma_lock;	/* SMA receive */
+
+/* max SM received packets we'll queue; we keep the most recent packets. */
+
+#define IPATH_NUM_SMAPKTS  16
+
+#define IPATH_SMA_HDRSZ (8+12+8)	/* LRH+BTH+DETH */
+
+static struct _ipath_sma_rpkt {
+	/* length of received packet; non-zero if queued */
+	uint32_t len;
+	/* unit number of interface packet was received from */
+	uint32_t unit;
+	uint8_t *buf;
+} ipath_sma_data[IPATH_NUM_SMAPKTS];
+
+static unsigned ipath_sma_first; /* oldest sma packet index */
+static unsigned ipath_sma_next;	/* next sma packet index to use */
+
+/*
+ * ipath_sma_data_bufs has one extra, pointed to by ipath_sma_data_spare,
+ * so we can exchange buffers to do copy_to_user, and not hold the lock
+ * across the copy_to_user().
+ */
+
+#define SMA_MAX_PKTSZ (IPATH_SMA_HDRSZ+256)	/* max len of an SMA packet */
+
+static uint8_t ipath_sma_data_bufs[IPATH_NUM_SMAPKTS + 1][SMA_MAX_PKTSZ];
+static uint8_t *ipath_sma_data_spare;
+/* sma waits globally on all units */
+static wait_queue_head_t ipath_sma_wait;
+static wait_queue_head_t ipath_sma_state_wait;
+
+struct infinipath_stats ipath_stats;
+
+/*
+ * this will only be used for diags, now that we have enabled the DMA
+ * of the sendpioavail regs to system memory.
+ */
+
+static inline uint64_t ipath_kget_sreg(const ipath_type stype,
+					   ipath_sreg regno)
+{
+	uint64_t val;
+	uint64_t *sbase;
+
+	sbase = (uint64_t *) (devdata[stype].ipath_sregbase
+			      + (char *)devdata[stype].ipath_kregbase);
+	val = sbase ? sbase[regno] : 0ULL;
+	return val;
+}
+
+static int ipath_do_user_init(struct ipath_portdata *,
+			      struct ipath_user_info __user *);
+static int ipath_get_baseinfo(struct ipath_portdata *,
+			      struct ipath_base_info __user *);
+static int ipath_get_units(void);
+static int ipath_wr_eeprom(struct ipath_portdata *,
+			   struct ipath_eeprom_req __user *);
+static int ipath_wait_intr(struct ipath_portdata *, uint32_t);
+static int ipath_tid_update(struct ipath_portdata *, struct _tidupd __user *);
+static int ipath_tid_free(struct ipath_portdata *, struct _tidupd __user *);
+static int ipath_get_counters(ipath_type, struct infinipath_counters __user *);
+static int ipath_get_unit_counters(struct infinipath_getunitcounters __user *a);
+static int ipath_get_stats(struct infinipath_stats __user *);
+static int ipath_set_partkey(struct ipath_portdata *, uint16_t);
+static int ipath_manage_rcvq(struct ipath_portdata *, uint16_t);
+static void ipath_clean_partkey(struct ipath_portdata *,
+				struct ipath_devdata *);
+static void ipath_disarm_piobufs(const ipath_type, unsigned, unsigned);
+static int ipath_create_user_egr(struct ipath_portdata *);
+static int ipath_create_port0_egr(struct ipath_portdata *);
+static int ipath_create_rcvhdrq(struct ipath_portdata *);
+static void ipath_handle_errors(const ipath_type, uint64_t);
+static void ipath_update_pio_bufs(const ipath_type);
+static int ipath_shutdown_link(const ipath_type);
+static int ipath_bringup_link(const ipath_type);
+int ipath_bringup_serdes(const ipath_type);
+static void ipath_get_faststats(unsigned long);
+static int ipath_setup_htconfig(struct pci_dev *, uint64_t *, const ipath_type);
+static struct page *ipath_nopage(struct vm_area_struct *, unsigned long, int *);
+static irqreturn_t ipath_intr(int irq, void *devid, struct pt_regs *regs);
+static void ipath_decode_err(char *, size_t, uint64_t);
+void ipath_free_pddata(struct ipath_devdata *, uint32_t, int);
+static void ipath_clear_tids(const ipath_type, unsigned);
+static void ipath_get_guid(const ipath_type);
+static int ipath_sma_ioctl(struct file *, unsigned int, unsigned long);
+static int ipath_rcvsma_pkt(struct ipath_sendpkt __user *);
+static int ipath_kset_lid(uint32_t);
+static int ipath_kset_mlid(uint32_t);
+static int ipath_get_mlid(uint32_t __user *);
+static int ipath_get_devstatus(uint64_t __user *);
+static int ipath_kset_guid(struct ipath_setguid __user *);
+static int ipath_get_portinfo(uint32_t __user *);
+static int ipath_get_nodeinfo(uint32_t __user *);
+#ifdef _IPATH_EXTRA_DEBUG
+static void ipath_dump_allregs(char *, ipath_type);
+#endif
+
+static const char ipath_sma_name[] = "infinipath_SMA";
+
+/*
+ * is diags mode enabled?  if it is, then things like auto bringup of
+ * links is disabled
+ */
+
+int ipath_diags_enabled = 0;
+
+void ipath_chip_done(void)
+{
+}
+
+void ipath_chip_cleanup(struct ipath_devdata * dd)
+{
+}
+
+/*
+ * cache aligned location
+ *
+ * where port 0 rcvhdrtail register is written back; also want
+ * nothing else sharing the cache line, so make it a cache line in size
+ * used for all units
+ *
+ * This is volatile as it's the target of a DMA from the chip.
+ */
+
+static volatile uint64_t ipath_port0_rcvhdrtail[512]
+    __attribute__ ((aligned(4096)));
+
+#define MODNAME "ipath_core"
+#define DRIVER_LOAD_MSG "PathScale " MODNAME " loaded: "
+#define PFX MODNAME ": "
+
+/*
+ * min buffers we want to have per port, after driver
+ */
+
+#define IPATH_MIN_USER_PORT_BUFCNT 8
+
+/* The size has to be longer than this string, so we can
+ * append board/chip information to it in the init code.
+ */
+static char ipath_core_version[192] = IPATH_IDSTR;
+static char *chip_driver_version;
+static int chip_driver_size;
+
+/* mylid and lidbase are to deal with LIDs in "fabric", until SM is working */
+
+module_param(infinipath_debug, uint, 0644);
+module_param(infinipath_kpiobufs, uint, 0644);
+module_param(infinipath_cfgports, uint, 0644);
+module_param(infinipath_cfgunits, uint, 0644);
+
+MODULE_PARM_DESC(infinipath_debug, "mask for debug prints");
+MODULE_PARM_DESC(infinipath_cfgports, "Set max number of ports to use");
+MODULE_PARM_DESC(infinipath_cfgunits, "Set max number of devices to use");
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("PathScale <infinipath-support@pathscale.com>");
+MODULE_DESCRIPTION("Pathscale InfiniPath driver");
+
+#ifdef IPATH_DIAG
+static __kernel_pid_t ipath_diag_alive;	/* PID of diags, if running */
+int ipath_diags_ioctl(struct file *, unsigned, unsigned long);
+static int ipath_opendiag(struct inode *, struct file *);
+#endif
+
+#if __IPATH_INFO || __IPATH_DBG
+static const char *ipath_ibcstatus_str[] = {
+	"Disabled",
+	"LinkUp",
+	"PollActive",
+	"PollQuiet",
+	"SleepDelay",
+	"SleepQuiet",
+	"LState6",		/* unused */
+	"LState7",		/* unused */
+	"CfgDebounce",
+	"CfgRcvfCfg",
+	"CfgWaitRmt",
+	"CfgIdle",
+	"RecovRetrain",
+	"LState0xD",		/* unused */
+	"RecovWaitRmt",
+	"RecovIdle",
+};
+#endif
+
+static ssize_t show_version(struct device_driver *dev, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%s", ipath_core_version);
+}
+
+static ssize_t show_status(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+
+	if (!dd)
+		return -EINVAL;
+
+	if (!dd->ipath_statusp)
+		return -EINVAL;
+
+	return snprintf(buf, PAGE_SIZE, "%llx\n", *(dd->ipath_statusp));
+}
+
+static const char *ipath_status_str[] = {
+	"Initted",
+	"Disabled",
+	"4",                    /* unused */
+	"OIB_SMA",
+	"SMA",
+	"Present",
+	"IB_link_up",
+	"IB_configured",
+	"NoIBcable",
+	"Fatal_Hardware_Error",
+	NULL,
+};
+
+static ssize_t show_status_str(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	int i, any;
+	uint64_t s;
+
+	if (!dd)
+		return -EINVAL;
+
+	if (!dd->ipath_statusp)
+		return -EINVAL;
+
+	s = *(dd->ipath_statusp);
+	*buf = '\0';
+	for (any = i = 0; s && ipath_status_str[i]; i++) {
+		if (s & 1) {
+			if (any && strlcat(buf, " ", PAGE_SIZE) >= PAGE_SIZE)
+				/* overflow */
+				break;
+			if (strlcat(buf, ipath_status_str[i],
+				    PAGE_SIZE) >= PAGE_SIZE)
+				break;
+			any = 1;
+		}
+		s >>= 1;
+	}
+	if (any)
+		strlcat(buf, "\n", PAGE_SIZE);
+
+	return strlen(buf);
+}
+
+static ssize_t show_lid(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+
+	if (!dd)
+		return -EINVAL;
+
+	return snprintf(buf, PAGE_SIZE, "%x\n", dd->ipath_lid);
+}
+
+static ssize_t show_mlid(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+
+	if (!dd)
+		return -EINVAL;
+
+	return snprintf(buf, PAGE_SIZE, "%x\n", dd->ipath_mlid);
+}
+
+static ssize_t show_guid(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+	uint8_t *guid;
+
+	if (!dd)
+		return -EINVAL;
+
+	guid = (uint8_t *)&(dd->ipath_guid);
+
+	return snprintf(buf, PAGE_SIZE, "%x:%x:%x:%x:%x:%x:%x:%x\n",
+			guid[0], guid[1], guid[2], guid[3], guid[4], guid[5],
+			guid[6], guid[7]);
+}
+
+static ssize_t show_nguid(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+
+	if (!dd)
+		return -EINVAL;
+
+	return snprintf(buf, PAGE_SIZE, "%u\n", dd->ipath_nguid);
+}
+
+static ssize_t show_serial(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+
+	if (!dd)
+		return -EINVAL;
+
+	buf[sizeof dd->ipath_serial] = '\0';
+	memcpy(buf, dd->ipath_serial, sizeof dd->ipath_serial);
+	strcat(buf, "\n");
+	return strlen(buf);
+}
+
+static ssize_t show_unit(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
+{
+	struct ipath_devdata *dd = dev_get_drvdata(dev);
+
+	if (!dd)
+		return -EINVAL;
+
+	snprintf(buf, PAGE_SIZE, "%u\n", dd->ipath_unit);
+	return strlen(buf);
+}
+
+static DRIVER_ATTR(version, S_IRUGO, show_version, NULL);
+static DEVICE_ATTR(status, S_IRUGO, show_status, NULL);
+static DEVICE_ATTR(status_str, S_IRUGO, show_status_str, NULL);
+static DEVICE_ATTR(lid, S_IRUGO, show_lid, NULL);
+static DEVICE_ATTR(mlid, S_IRUGO, show_mlid, NULL);
+static DEVICE_ATTR(guid, S_IRUGO, show_guid, NULL);
+static DEVICE_ATTR(nguid, S_IRUGO, show_nguid, NULL);
+static DEVICE_ATTR(serial, S_IRUGO, show_serial, NULL);
+static DEVICE_ATTR(unit, S_IRUGO, show_unit, NULL);
+
+/*
+ * called from add_timer and user counter read calls, to deal with
+ * counters that wrap in "human time".  The words sent and received, and
+ * the packets sent and received are all that we worry about.  For now,
+ * at least, we don't worry about error counters, because if they wrap
+ * that quickly, we probably don't care.  We may eventually just make this
+ * handle all the counters.  word counters can wrap in about 20 seconds
+ * of full bandwidth traffic, packet counters in a few hours.
+ */
+
+uint64_t ipath_snap_cntr(const ipath_type t, ipath_creg creg)
+{
+	uint32_t val;
+	uint64_t val64, t0, t1;
+	struct ipath_devdata *dd = &devdata[t];
+	static uint64_t one_sec_in_cycles;
+	extern uint32_t _ipath_pico_per_cycle;
+
+	if (!one_sec_in_cycles && _ipath_pico_per_cycle)
+		one_sec_in_cycles = 1000000000000UL / _ipath_pico_per_cycle;
+
+	t0 = get_cycles();
+	val = ipath_kget_creg32(t, creg);
+	t1 = get_cycles();
+	if ((t1 - t0) > one_sec_in_cycles && val == -1) {
+		/*
+		 * This is just a way to detect things that are quite broken.
+		 * Normally this should take just a few cycles (the check is
+		 * for long enough that we don't care if we get pre-empted.)
+		 * An Opteron HT O read timeout is 4 seconds with normal
+		 * NB values
+		 */
+
+		_IPATH_UNIT_ERROR(t, "Error!  Reading counter 0x%x timed out\n",
+				  creg);
+		return 0ULL;
+	}
+
+	if (creg == cr_wordsendcnt) {
+		if (val != dd->ipath_lastsword) {
+			dd->ipath_sword += val - dd->ipath_lastsword;
+			dd->ipath_lastsword = val;
+		}
+		val64 = dd->ipath_sword;
+	} else if (creg == cr_wordrcvcnt) {
+		if (val != dd->ipath_lastrword) {
+			dd->ipath_rword += val - dd->ipath_lastrword;
+			dd->ipath_lastrword = val;
+		}
+		val64 = dd->ipath_rword;
+	} else if (creg == cr_pktsendcnt) {
+		if (val != dd->ipath_lastspkts) {
+			dd->ipath_spkts += val - dd->ipath_lastspkts;
+			dd->ipath_lastspkts = val;
+		}
+		val64 = dd->ipath_spkts;
+	} else if (creg == cr_pktrcvcnt) {
+		if (val != dd->ipath_lastrpkts) {
+			dd->ipath_rpkts += val - dd->ipath_lastrpkts;
+			dd->ipath_lastrpkts = val;
+		}
+		val64 = dd->ipath_rpkts;
+	} else
+		val64 = (uint64_t) val;
+
+	return val64;
+}
+
+/*
+ * print the delta of egrfull/hdrqfull errors for kernel ports no more
+ * than every 5 seconds.  User processes are printed at close, but kernel
+ * doesn't close, so...  Separate routine so may call from other places
+ * someday, and so function name when printed by _IPATH_INFO is meaningfull
+ */
+
+static void ipath_qcheck(const ipath_type t)
+{
+	static uint64_t last_tot_hdrqfull;
+	size_t blen = 0;
+	struct ipath_devdata *dd = &devdata[t];
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
+		    snprintf(buf + blen, sizeof buf - blen, "%srcvegrfull %llu",
+			     blen ? ", " : "",
+			     ipath_stats.sps_etidfull - dd->ipath_last_tidfull);
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
+	if ((infinipath_debug & (__IPATH_PKTDBG | __IPATH_DBG)) &&
+	    ipath_stats.sps_hdrqfull != last_tot_hdrqfull) {
+		blen +=
+		    snprintf(buf + blen, sizeof buf - blen,
+			     "%shdrqfull %llu (all ports)", blen ? ", " : "",
+			     ipath_stats.sps_hdrqfull - last_tot_hdrqfull);
+		last_tot_hdrqfull = ipath_stats.sps_hdrqfull;
+	}
+	if (blen)
+		_IPATH_DBG("%s\n", buf);
+
+	if (*dd->ipath_hdrqtailptr != dd->ipath_port0head) {
+		if (dd->ipath_lastport0rcv_cnt == ipath_stats.sps_port0pkts) {
+			_IPATH_PDBG("missing rcv interrupts? port0 hd=%llx tl=%x; port0pkts %llx\n",
+				*dd->ipath_hdrqtailptr, dd->ipath_port0head,ipath_stats.sps_port0pkts);
+			ipath_kreceive(t);
+		}
+		dd->ipath_lastport0rcv_cnt = ipath_stats.sps_port0pkts;
+	}
+}
+
+/*
+ * called from add_timer to get word counters from chip before they
+ * can overflow
+ */
+
+static void ipath_get_faststats(unsigned long t)
+{
+	uint32_t val;
+	struct ipath_devdata *dd = &devdata[t];
+	static unsigned cnt;
+
+	/*
+	 * don't access the chip while running diags, or memory diags
+	 * can fail
+	 */
+	if (!dd->ipath_kregbase || !(dd->ipath_flags & IPATH_PRESENT) ||
+	    ipath_diags_enabled) {
+		/* but re-arm the timer, for diags case; won't hurt other */
+		goto done;
+	}
+
+	ipath_snap_cntr((ipath_type) t, cr_wordsendcnt);
+	ipath_snap_cntr((ipath_type) t, cr_wordrcvcnt);
+	ipath_snap_cntr((ipath_type) t, cr_pktsendcnt);
+	ipath_snap_cntr((ipath_type) t, cr_pktrcvcnt);
+
+	ipath_qcheck(t);
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
+	if ((devdata[t].ipath_maskederrs & ~devdata[t].ipath_ignorederrs)
+	    && get_cycles() > devdata[t].ipath_unmasktime) {
+		char ebuf[256];
+		ipath_decode_err(ebuf, sizeof ebuf,
+				 (devdata[t].ipath_maskederrs & ~devdata[t].
+				  ipath_ignorederrs));
+		if ((devdata[t].ipath_maskederrs & ~devdata[t].
+		     ipath_ignorederrs)
+		    & ~(INFINIPATH_E_RRCVEGRFULL | INFINIPATH_E_RRCVHDRFULL)) {
+			_IPATH_UNIT_ERROR(t, "Re-enabling masked errors (%s)\n",
+					  ebuf);
+		} else {
+			/*
+			 * rcvegrfull and rcvhdrqfull are "normal",
+			 * for some types of processes (mostly benchmarks)
+			 * that send huge numbers of messages, while
+			 * not processing them.  So only complain about
+			 * these at debug level.
+			 */
+			_IPATH_DBG
+			    ("Disabling frequent queue full errors (%s)\n",
+			     ebuf);
+		}
+		devdata[t].ipath_maskederrs = devdata[t].ipath_ignorederrs;
+		ipath_kput_kreg(t, kr_errormask, ~devdata[t].ipath_maskederrs);
+	}
+
+	if (dd->ipath_flags & IPATH_LINK_SLEEPING) {
+		uint64_t ibc;
+		_IPATH_VDBG("linkinitcmd SLEEP, move to POLL\n");
+		dd->ipath_flags &= ~IPATH_LINK_SLEEPING;
+		ibc = dd->ipath_ibcctrl;
+		/*
+		 * don't put linkinitcmd in ipath_ibcctrl, want that to
+		 * stay a NOP
+		 */
+		ibc |=
+		    INFINIPATH_IBCC_LINKINITCMD_POLL <<
+		    INFINIPATH_IBCC_LINKINITCMD_SHIFT;
+		ipath_kput_kreg(t, kr_ibcctrl, ibc);
+	}
+
+	/* limit qfull messages to ~one per minute per port */
+	if ((++cnt & 0x10)) {
+		for (val = devdata[t].ipath_cfgports - 1; ((int)val) >= 0;
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
+			_IPATH_SMADBG("No SMA bufs avail %u seconds; cancelling pending sends\n",
+				dd->ipath_nosma_secs);
+			ipath_disarm_piobufs(t, dd->ipath_lastport_piobuf,
+				dd->ipath_piobcnt - dd->ipath_lastport_piobuf);
+			dd->ipath_nosma_secs = 0; /* start again, if necessary */
+		}
+		else
+			_IPATH_SMADBG("No SMA bufs avail %u tries, after %u seconds\n",
+				dd->ipath_nosma_bufs, dd->ipath_nosma_secs);
+	}
+
+done:
+	mod_timer(&dd->ipath_stats_timer, jiffies + HZ * 5);
+}
+
+
+static void __devexit infinipath_remove_one(struct pci_dev *);
+static int infinipath_init_one(struct pci_dev *, const struct pci_device_id *);
+
+/* Only needed for registration, nothing else needs this info */
+#define PCI_VENDOR_ID_PATHSCALE 0x1fc1
+#define PCI_DEVICE_ID_PATHSCALE_INFINIPATH_HT 0xd
+
+const struct pci_device_id infinipath_pci_tbl[] = {
+	{
+	 PCI_VENDOR_ID_PATHSCALE, PCI_DEVICE_ID_PATHSCALE_INFINIPATH_HT,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{0,}
+};
+
+MODULE_DEVICE_TABLE(pci, infinipath_pci_tbl);
+
+static struct pci_driver infinipath_driver = {
+	.name = MODNAME,
+	.driver.owner = THIS_MODULE,
+	.probe = infinipath_init_one,
+	.remove = __devexit_p(infinipath_remove_one),
+	.id_table = infinipath_pci_tbl,
+};
+
+#if defined (pgprot_writecombine) && defined(_PAGE_MA_WC)
+int remap_area_pages(unsigned long address, unsigned long phys_addr,
+		     unsigned long size, unsigned long flags);
+#endif
+
+static int infinipath_init_one(struct pci_dev *pdev,
+			       const struct pci_device_id *ent)
+{
+	int ret, len, j;
+	static int chip_idx = -1;
+	unsigned long addr;
+	uint64_t intconfig;
+	uint8_t rev;
+	ipath_type dev;
+
+	/*
+	 * XXX: Right now, we have a hardcoded array of devices.  We'll
+	 * change this in a future release, but not just yet.  For the
+	 * moment, we're limited to 4 infinipath devices per system.
+	 */
+
+	dev = ++chip_idx;
+
+	_IPATH_VDBG("initializing unit #%u\n", dev);
+	if ((!infinipath_cfgunits && (dev >= 1)) ||
+	    (infinipath_cfgunits && (dev >= infinipath_cfgunits)) ||
+	    (dev >= infinipath_max)) {
+		_IPATH_ERROR("Trying to initialize unit %u, max is %u\n",
+			     dev, infinipath_max - 1);
+		return -EINVAL;
+	}
+
+	devdata[dev].pci_registered = 1;
+	devdata[dev].ipath_unit = dev;
+
+	if ((ret = pci_enable_device(pdev))) {
+		_IPATH_DBG("pci_enable unit %u failed: %x\n", dev, ret);
+	}
+
+	if ((ret = pci_request_regions(pdev, MODNAME)))
+		_IPATH_INFO("pci_request_regions unit %u fails: %d\n", dev,
+			    ret);
+
+	if ((ret = pci_set_dma_mask(pdev, DMA_64BIT_MASK)) != 0)
+		_IPATH_INFO("pci_set_dma_mask unit %u fails: %d\n", dev, ret);
+
+	pci_set_master(pdev);	/* probably not be needed for HT */
+
+	addr = pci_resource_start(pdev, 0);
+	len = pci_resource_len(pdev, 0);
+	_IPATH_VDBG
+	    ("regbase (0) %lx len %d irq %x, vend %x/%x driver_data %lx\n",
+	     addr, len, pdev->irq, ent->vendor, ent->device, ent->driver_data);
+	devdata[dev].ipath_deviceid = ent->device;	/* save for later use */
+	devdata[dev].ipath_vendorid = ent->vendor;
+	for (j = 0; j < 6; j++) {
+		if (!pdev->resource[j].start)
+			continue;
+		_IPATH_VDBG("BAR %d start %lx, end %lx, len %lx\n",
+			    j, pdev->resource[j].start,
+			    pdev->resource[j].end, pci_resource_len(pdev, j));
+	}
+
+	if (!addr) {
+		_IPATH_UNIT_ERROR(dev, "No valid address in BAR 0!\n");
+		return -ENODEV;
+	}
+
+	if ((ret = pci_read_config_byte(pdev, PCI_REVISION_ID, &rev))) {
+		_IPATH_UNIT_ERROR(dev,
+				  "Failed to read PCI revision ID unit %u: %d\n",
+				  dev, ret);
+		return ret;	/* shouldn't ever happen */
+	} else
+		devdata[dev].ipath_pcirev = rev;
+
+	devdata[dev].ipath_kregbase = ioremap_nocache(addr, len);
+#if defined (pgprot_writecombine) && defined(_PAGE_MA_WC)
+	printk("Remapping pages WC\n");
+	remap_area_pages((unsigned long) devdata[dev].ipath_kregbase +
+			 1024 * 1024, addr + 1024 * 1024, 1024 * 1024,
+			 _PAGE_MA_WC);
+	/* devdata[dev].ipath_kregbase = __ioremap(addr, len, _PAGE_MA_WC); */
+#endif
+
+	if (!devdata[dev].ipath_kregbase) {
+		_IPATH_DBG("Unable to map io addr %lx to kvirt, failing\n",
+			   addr);
+		ret = -ENOMEM;
+		goto fail;
+	}
+	devdata[dev].ipath_kregend = (uint64_t __iomem *)
+		((void __iomem *) devdata[dev].ipath_kregbase + len);
+	devdata[dev].ipath_physaddr = addr;	/* used for io_remap, etc. */
+	/* for user mmap */
+	devdata[dev].ipath_kregvirt = (uint64_t __iomem *) phys_to_virt(addr);
+	_IPATH_VDBG("mapped io addr %lx to kregbase %p kregvirt %p\n", addr,
+		    devdata[dev].ipath_kregbase, devdata[dev].ipath_kregvirt);
+
+	/*
+	 * set these up before registering the interrupt handler, just
+	 * in case
+	 */
+	devdata[dev].pcidev = pdev;
+	pci_set_drvdata(pdev, &(devdata[dev]));
+
+	/*
+	 * set up our interrupt handler; SA_SHIRQ probably not needed,
+	 * but won't  hurt for now.
+	 */
+
+	if (!pdev->irq) {
+		_IPATH_UNIT_ERROR(dev, "irq is 0, failing init\n");
+		ret = -EINVAL;
+		goto fail;
+	}
+	if ((ret = request_irq(pdev->irq, ipath_intr,
+			       SA_SHIRQ, MODNAME, &devdata[dev]))) {
+		_IPATH_UNIT_ERROR(dev,
+				  "Couldn't setup interrupt handler, irq=%u: %d\n",
+				  pdev->irq, ret);
+		goto fail;
+	}
+
+	/*
+	 * clear ipath_flags here instead of in ipath_init_chip as it is set
+	 * by ipath_setup_htconfig.
+	 */
+	devdata[dev].ipath_flags = 0;
+	if (ipath_setup_htconfig(pdev, &intconfig, dev))
+		_IPATH_DBG
+		    ("Failed to setup HT config, continuing anyway for now\n");
+
+	ret = ipath_init_chip(dev);	/* do the chip-specific init */
+	if (!ret) {
+#ifdef CONFIG_MTRR
+		uint64_t pioaddr, piolen;
+		unsigned bits;
+		/*
+		 * Set the PIO buffers to be WCCOMB, so we get HT bursts
+		 * to the chip.  Linux (possibly the hardware) requires
+		 * it to be on a power of 2 address matching the length
+		 * (which has to be a power of 2).  For rev1, that means
+		 * the base address, for rev2, it will be just the PIO
+		 * buffers themselves.
+		 */
+		pioaddr = addr + devdata[dev].ipath_piobufbase;
+		piolen = devdata[dev].ipath_piobcnt *
+		    ALIGN(devdata[dev].ipath_piosize,
+			  devdata[dev].ipath_palign);
+
+		for (bits = 0; !(piolen & (1ULL << bits)); bits++)
+			/* do nothing */;
+
+		if (piolen != (1ULL << bits)) {
+			_IPATH_DBG("piolen 0x%llx not power of 2, bits=%u\n",
+				   piolen, bits);
+			piolen >>= bits;
+			while (piolen >>= 1)
+				bits++;
+			piolen = 1ULL << (bits + 1);
+			_IPATH_DBG("Changed piolen to 0x%llx bits=%u\n", piolen,
+				   bits);
+		}
+		if (pioaddr & (piolen - 1)) {
+			uint64_t atmp;
+			_IPATH_DBG
+			    ("pioaddr %llx not on right boundary for size %llx, fixing\n",
+			     pioaddr, piolen);
+			atmp = pioaddr & ~(piolen - 1);
+			if (atmp < addr || (atmp + piolen) > (addr + len)) {
+				_IPATH_UNIT_ERROR(dev,
+						  "No way to align address/size (%llx/%llx), no WC mtrr\n",
+						  atmp, piolen << 1);
+				ret = -ENODEV;
+			} else {
+				_IPATH_DBG
+				    ("changing WC base from %llx to %llx, len from %llx to %llx\n",
+				     pioaddr, atmp, piolen, piolen << 1);
+				pioaddr = atmp;
+				piolen <<= 1;
+			}
+		}
+
+		if (!ret) {
+			int cookie;
+			_IPATH_VDBG
+			    ("Setting mtrr for chip to WC (addr %llx, len=0x%llx)\n",
+			     pioaddr, piolen);
+			cookie = mtrr_add(pioaddr, piolen, MTRR_TYPE_WRCOMB, 0);
+			if (cookie < 0) {
+				_IPATH_INFO
+				    ("mtrr_add(%llx,0x%llx,WC,0) failed (%d)\n",
+				     pioaddr, piolen, cookie);
+				ret = -EINVAL;
+			} else {
+				_IPATH_VDBG
+				    ("Set mtrr for chip to WC, cookie is %d\n",
+				     cookie);
+				devdata[dev].ipath_mtrr = (uint32_t) cookie;
+			}
+		}
+#endif				/* CONFIG_MTRR */
+	}
+
+	if (!ret && devdata[dev].ipath_kregbase && (devdata[dev].ipath_flags
+					    & IPATH_PRESENT)) {
+		/*
+		 * for the hardware, enable interrupts only after
+		 * kr_interruptconfig is written, if we could set it up
+		 */
+		if (intconfig) {
+			/* interrupt address */
+			ipath_kput_kreg(dev, kr_interruptconfig, intconfig);
+			/* enable all interrupts */
+			ipath_kput_kreg(dev, kr_intmask, -1LL);
+			/* force re-interrupt of any pending interrupts. */
+			ipath_kput_kreg(dev, kr_intclear, 0ULL);
+			/* OK, the chip is usable, marked it as initialized */
+			*devdata[dev].ipath_statusp |= IPATH_STATUS_INITTED;
+		} else
+			_IPATH_UNIT_ERROR(dev,
+					  "No interrupts enabled, couldn't setup interrupt address\n");
+	} else if (ret != -EPERM)
+		_IPATH_INFO("Not configuring unit %u interrupts, init failed\n",
+			    dev);
+
+	device_create_file(&(pdev->dev), &dev_attr_status);
+	device_create_file(&(pdev->dev), &dev_attr_status_str);
+	device_create_file(&(pdev->dev), &dev_attr_lid);
+	device_create_file(&(pdev->dev), &dev_attr_mlid);
+	device_create_file(&(pdev->dev), &dev_attr_guid);
+	device_create_file(&(pdev->dev), &dev_attr_nguid);
+	device_create_file(&(pdev->dev), &dev_attr_serial);
+	device_create_file(&(pdev->dev), &dev_attr_unit);
+
+	/*
+	 * We used to cleanup here, with pci_release_regions, etc. but that
+	 * can cause other problems if we want to run diags, etc., so instead
+	 * defer that until driver unload.
+	 */
+
+fail:	/* after we've done at least some of the pci setup */
+	if (ret == -EPERM) /* disabled device, don't want module load error;
+		* just want to carry status through to this point */
+		ret = 0;
+
+	return ret;
+}
+
+
+
+#define HT_CAPABILITY_ID   0x08 /* HT capabilities not defined in kernel */
+#define HT_INTR_DISC_CONFIG  0x80 /* HT interrupt and discovery cap */
+#define HT_INTR_REG_INDEX    2 /* intconfig requires indirect accesses */
+
+/*
+ * setup the interruptconfig register from the HT config info.
+ * Also clear CRC errors in HT linkcontrol, if necessary.
+ * This is done only for the real hardware.  It is done before
+ * chip address space is initted, so can't touch infinipath registers
+ */
+
+static int ipath_setup_htconfig(struct pci_dev *pdev, uint64_t * iaddr,
+				const ipath_type t)
+{
+	uint8_t cap_type;
+	uint32_t int_handler_addr_lower;
+	uint32_t int_handler_addr_upper;
+	uint64_t ihandler = 0;
+	int i, pos, ret = 0;
+
+	*iaddr = 0ULL;		/* init to zero in case not able to configure */
+
+	/*
+	 * Read the capability info to find the interrupt info, and also
+	 * handle clearing CRC errors in linkctrl register if necessary.
+	 * We do this early, before we ever enable errors or hardware errors,
+	 * mostly to avoid causing the chip to enter freeze mode.
+	 */
+	if (!(pos = pci_find_capability(pdev, HT_CAPABILITY_ID))) {
+		_IPATH_UNIT_ERROR(t,
+		    "Couldn't find HyperTransport capability; no interrupts\n");
+		return -ENODEV;
+	}
+	do {
+	    	/* the HT capability type byte is 3 bytes after the
+		 * capability byte.
+		 */
+		if (pci_read_config_byte(pdev, pos+3, &cap_type)) {
+			_IPATH_INFO
+			    ("Couldn't read config command @ %d\n", pos);
+			continue;
+		}
+		if (!(cap_type & 0xE0)) {
+			/* bits 13-15 of command==0 is slave/primary block.
+			 * Clear any HT CRC errors.  We only bother to
+			 * do this at load time, because it's OK if it
+			 * happened before we were loaded (first time
+			 * after boot/reset), but any time after that,
+			 * it's fatal anyway.  Also need to not check for
+			 * for upper byte errors if we are in 8 bit mode,
+			 * so figure out our width.  For now, at least,
+			 * also complain if it's 8 bit.
+			 */
+			uint8_t linkwidth = 0, linkerr, link_a_b_off, link_off;
+			uint16_t linkctrl = 0;
+
+			devdata[t].ipath_ht_slave_off = pos;
+			/* command word, master_host bit */
+			if ((cap_type >> 2) & 1) /* master host || slave */
+				link_a_b_off = 4;
+			else
+				link_a_b_off = 0;
+			_IPATH_VDBG("HT%u (Link %c) connected to processor\n",
+				    link_a_b_off ? 1 : 0,
+				    link_a_b_off ? 'B' : 'A');
+
+			link_a_b_off += pos;
+
+			/*
+			 * check both link control registers; clear both
+			 * HT CRC sets if necessary.
+			 */
+
+			for (i = 0; i < 2; i++) {
+				link_off = pos + i * 4 + 0x4;
+				if (pci_read_config_word
+				    (pdev, link_off, &linkctrl))
+					_IPATH_UNIT_ERROR(t,
+					  "Couldn't read HT link control%d register\n",
+					  i);
+				else if (linkctrl & (0xf << 8)) {
+					_IPATH_VDBG
+					    ("Clear linkctrl%d CRC Error bits %x\n",
+					     i, linkctrl & (0xf << 8));
+					/*
+					 * now write them back to clear
+					 * the error.
+					 */
+					pci_write_config_byte(pdev, link_off,
+							      linkctrl & (0xf <<
+									  8));
+				}
+			}
+
+			/*
+			 * As with HT CRC bits, same for protocol errors
+			 * that might occur during boot.
+			 */
+
+			for (i = 0; i < 2; i++) {
+				link_off = pos + i * 4 + 0xd;
+				if (pci_read_config_byte
+				    (pdev, link_off, &linkerr))
+					_IPATH_INFO
+					    ("Couldn't read linkerror%d of HT slave/primary block\n",
+					     i);
+				else if (linkerr & 0xf0) {
+					_IPATH_VDBG
+					    ("HT linkerr%d bits 0x%x set, clearing\n",
+					     linkerr >> 4, i);
+					/*
+					 * writing the linkerr bits that
+					 * are set will clear them
+					 */
+					if (pci_write_config_byte
+					    (pdev, link_off, linkerr))
+						_IPATH_DBG
+						    ("Failed write to clear HT linkerror%d\n",
+						     i);
+					if (pci_read_config_byte
+					    (pdev, link_off, &linkerr))
+						_IPATH_INFO
+						    ("Couldn't reread linkerror%d of HT slave/primary block\n",
+						     i);
+					else if (linkerr & 0xf0)
+						_IPATH_INFO
+						    ("HT linkerror%d bits 0x%x couldn't be cleared\n",
+						     i, linkerr >> 4);
+				}
+			}
+
+			/*
+			 * this is just for our link to the host, not
+			 * devices connected through tunnel.
+			 */
+
+			if (pci_read_config_byte
+			    (pdev, link_a_b_off + 7, &linkwidth))
+				_IPATH_UNIT_ERROR(t,
+						  "Couldn't read HT link width config register\n");
+			else {
+				uint32_t width;
+				switch (linkwidth & 7) {
+				case 5:
+					width = 4;
+					break;
+				case 4:
+					width = 2;
+					break;
+				case 3:
+					width = 32;
+					break;
+				case 1:
+					width = 16;
+					break;
+				case 0:
+				default:	/* if wrong, assume 8 bit */
+					width = 8;
+					break;
+				}
+				((struct ipath_devdata *) pci_get_drvdata(pdev))->ipath_htwidth = width;
+
+				if (linkwidth != 0x11) {
+					_IPATH_UNIT_ERROR(t,
+							  "Not configured for 16 bit HT (%x)\n",
+							  linkwidth);
+					if (!(linkwidth & 0xf)) {
+						_IPATH_DBG
+						    ("Will ignore HT lane1 errors\n");
+						((struct ipath_devdata *) pci_get_drvdata(pdev))->ipath_flags |= IPATH_8BIT_IN_HT0;
+					}
+				}
+			}
+
+			/*
+			 * this is just for our link to the host, not
+			 * devices connected through tunnel.
+			 */
+
+			if (pci_read_config_byte
+			    (pdev, link_a_b_off + 0xd, &linkwidth))
+				_IPATH_UNIT_ERROR(t,
+						  "Couldn't read HT link frequency config register\n");
+			else {
+				uint32_t speed;
+				switch (linkwidth & 0xf) {
+				case 6:
+					speed = 1000;
+					break;
+				case 5:
+					speed = 800;
+					break;
+				case 4:
+					speed = 600;
+					break;
+				case 3:
+					speed = 500;
+					break;
+				case 2:
+					speed = 400;
+					break;
+				case 1:
+					speed = 300;
+					break;
+				default:
+					/*
+					 * assume reserved and
+					 * vendor-specific are 200...
+					 */
+				case 0:
+					speed = 200;
+					break;
+				}
+				((struct ipath_devdata *) pci_get_drvdata(pdev))->ipath_htspeed = speed;
+			}
+		} else if (cap_type == HT_INTR_DISC_CONFIG) {
+		    	/* use indirection register to get the intr handler */
+			uint32_t intvec;
+			pci_write_config_byte(pdev, pos + HT_INTR_REG_INDEX,
+					      0x10);
+			pci_read_config_dword(pdev, pos + 4,
+					      &int_handler_addr_lower);
+
+			pci_write_config_byte(pdev, pos + HT_INTR_REG_INDEX,
+					      0x11);
+			pci_read_config_dword(pdev, pos + 4,
+					      &int_handler_addr_upper);
+
+			ihandler = (uint64_t) int_handler_addr_lower |
+				((uint64_t) int_handler_addr_upper << 32);
+
+			/*
+			 * I'm unable to find an exported API to get
+			 * the the actual vector, either from the PCI
+			 * infrastructure, or from the APIC
+			 * infrastructure.  This heuristic seems to be
+			 * valid for Opteron on 2.6.x kernels, for irq's > 2.
+			 * It may not be universally true... Bug 2338
+			 *
+			 * Oh well; the heuristic doesn't work for the
+			 * AMI/Iwill BIOS...  But the good news is,
+			 * somewhere by 2.6.9, when CONFIG_PCI_MSI is
+			 * enabled, the irq field actually turned into
+			 * the vector number
+			 * We therefore require that MSI be enabled...
+			 */
+
+			intvec = pdev->irq;
+			/*
+			 * clear any bits there; normally not set but
+			 * we'll overload this for some debug purposes
+			 * (setting the HTC debug register value from
+			 * software, rather than GPIOs), so it might be
+			 * set on a driver reload.
+			 */
+
+			ihandler &= ~0xff0000;
+			/* x86 vector goes in intrinfo[23:16] */
+			ihandler |= intvec << 16;
+			_IPATH_VDBG
+			    ("ihandler lower %x, upper %x, intvec %x, interruptconfig %llx\n",
+			     int_handler_addr_lower, int_handler_addr_upper,
+			     intvec, ihandler);
+
+			/* return to caller, can't program yet. */
+			*iaddr = ihandler;
+			/*
+			 * no break, have to be sure we find link control
+			 * stuff also
+			 */
+		}
+
+	} while ((pos=pci_find_next_capability(pdev, pos, HT_CAPABILITY_ID)));
+
+	if (!ihandler) {
+		_IPATH_UNIT_ERROR(t,
+			"Couldn't find interrupt handler in config space\n");
+		ret = -ENODEV;
+	}
+	return ret;
+}
+
+/*
+ * get the GUID from the i2c device
+ * When we add the multi-chip support, we will probably have to add
+ * the ability to use the number of guids field, and get the guid from
+ * the first chip's flash, to use for all of them.
+ */
+
+static void ipath_get_guid(const ipath_type t)
+{
+	void *buf;
+	struct ipath_flash *ifp;
+	uint64_t guid;
+	int len;
+	uint8_t csum, *bguid;
+
+	if (t && devdata[0].ipath_nguid > 1 && t <= devdata[0].ipath_nguid) {
+		uint8_t oguid;
+		devdata[t].ipath_guid = devdata[0].ipath_guid;
+		bguid = (uint8_t *) & devdata[t].ipath_guid;
+
+		oguid = bguid[7];
+		bguid[7] += t;
+		if (oguid > bguid[7]) {
+			if (bguid[6] == 0xff) {
+				if (bguid[5] == 0xff) {
+					_IPATH_UNIT_ERROR(t,
+							  "Can't set %s GUID from base GUID, wraps to OUI!\n",
+							  ipath_get_unit_name
+							  (t));
+					devdata[t].ipath_guid = 0;
+					return;
+				}
+				bguid[5]++;
+			}
+			bguid[6]++;
+		}
+		devdata[t].ipath_nguid = 1;
+
+		_IPATH_DBG
+		    ("nguid %u, so adding %u to device 0 guid, for %llx (big-endian)\n",
+		     devdata[0].ipath_nguid, t, devdata[t].ipath_guid);
+		return;
+	}
+
+	len = offsetof(struct ipath_flash, if_future);
+	if (!(buf = vmalloc(len))) {
+		_IPATH_UNIT_ERROR(t,
+				  "Couldn't allocate memory to read %u bytes from eeprom for GUID\n",
+				  len);
+		return;
+	}
+
+	if (ipath_eeprom_read(t, 0, buf, len)) {
+		_IPATH_UNIT_ERROR(t, "Failed reading GUID from eeprom\n");
+		goto done;
+	}
+	ifp = (struct ipath_flash *)buf;
+
+	csum = ipath_flash_csum(ifp, 0);
+	if (csum != ifp->if_csum) {
+		_IPATH_INFO("Bad I2C flash checksum: 0x%x, not 0x%x\n",
+			    csum, ifp->if_csum);
+		goto done;
+	}
+	if (*(uint64_t *) ifp->if_guid == 0ULL
+	    || *(uint64_t *) ifp->if_guid == -1LL) {
+		_IPATH_UNIT_ERROR(t, "Invalid GUID %llx from flash; ignoring\n",
+				  *(uint64_t *) ifp->if_guid);
+		goto done;	/* don't allow GUID if all 0 or all 1's */
+	}
+
+	/* complain, but allow it */
+	if (*(uint64_t *) ifp->if_guid == 0x100007511000000ULL)
+		_IPATH_INFO
+		    ("Warning, GUID %llx is default, probabaly not correct!\n",
+		     *(uint64_t *) ifp->if_guid);
+
+	bguid = ifp->if_guid;
+	if (!bguid[0] && !bguid[1] && !bguid[2]) {
+		/* original incorrect GUID format in flash; fix in core copy, by
+		 * shifting up 2 octets; don't need to change top octet, since both
+		 * it and shifted are 0.. */
+		bguid[1] = bguid[3];
+		bguid[2] = bguid[4];
+		bguid[3] = bguid[4] = 0;
+		guid = *(uint64_t *)ifp->if_guid;
+		_IPATH_VDBG("Old GUID format in flash, top 3 zero, shifting 2 octets\n");
+	}
+	else
+		guid = *(uint64_t *)ifp->if_guid;
+	devdata[t].ipath_guid = guid;
+	devdata[t].ipath_nguid = ifp->if_numguid;
+	memcpy(devdata[t].ipath_serial, ifp->if_serial, sizeof(ifp->if_serial));
+	_IPATH_VDBG("Initted GUID to %llx (big-endian) from i2c flash\n",
+		    devdata[t].ipath_guid);
+
+done:
+	vfree(buf);
+}
+
+static void __devexit infinipath_remove_one(struct pci_dev *pdev)
+{
+	struct ipath_devdata *dd;
+
+	_IPATH_VDBG("pci_release, pdev=%p\n", pdev);
+	if (pdev) {
+		device_remove_file(&(pdev->dev), &dev_attr_status);
+		device_remove_file(&(pdev->dev), &dev_attr_status_str);
+		device_remove_file(&(pdev->dev), &dev_attr_lid);
+		device_remove_file(&(pdev->dev), &dev_attr_mlid);
+		device_remove_file(&(pdev->dev), &dev_attr_guid);
+		device_remove_file(&(pdev->dev), &dev_attr_nguid);
+		device_remove_file(&(pdev->dev), &dev_attr_serial);
+		device_remove_file(&(pdev->dev), &dev_attr_unit);
+		dd = pci_get_drvdata(pdev);
+		pci_set_drvdata(pdev, NULL);
+		_IPATH_VDBG
+		    ("Releasing pci memory regions, devdata %p, unit %u\n", dd,
+		     (uint32_t) (dd - devdata));
+		if (dd && dd->ipath_kregbase) {
+			_IPATH_VDBG("Unmapping kregbase %p\n",
+				    dd->ipath_kregbase);
+			iounmap((volatile void __iomem *) dd->ipath_kregbase);
+			dd->ipath_kregbase = NULL;
+		}
+		pci_release_regions(pdev);
+		_IPATH_VDBG("calling pci_disable_device\n");
+		pci_disable_device(pdev);
+	}
+}
+
+int ipath_open(struct inode *, struct file *);
+static int ipath_opensma(struct inode *, struct file *);
+int ipath_close(struct inode *, struct file *);
+static unsigned int ipath_poll(struct file *, struct poll_table_struct *);
+long ipath_ioctl(struct file *, unsigned int, unsigned long);
+static loff_t ipath_llseek(struct file *, loff_t, int);
+static int ipath_mmap(struct file *, struct vm_area_struct *);
+
+static struct file_operations ipath_fops = {
+	.owner = THIS_MODULE,
+	.open = ipath_open,
+	.release = ipath_close,
+	.poll = ipath_poll,
+	/*
+	 * all of ours are completely compatible and don't require the
+	 * kernel lock
+	 */
+	.compat_ioctl = ipath_ioctl,
+	/* we don't need kernel lock for our ioctls */
+	.unlocked_ioctl = ipath_ioctl,
+	.llseek = ipath_llseek,
+	.mmap = ipath_mmap
+};
+
+static DECLARE_MUTEX(ipath_mutex);	/* general driver use */
+spinlock_t ipath_pioavail_lock;
+
+/*
+ * For now, at least (and probably forever), we don't require root
+ * or equivalent permissions to use the device.
+ */
+
+int ipath_open(struct inode *in, struct file *fp)
+{
+	int ret = 0, minor, i, prefunit=-1, devmax;
+	int maxofallports, npresent = 0, notup = 0;
+	ipath_type ndev;
+
+	down(&ipath_mutex);
+
+	minor = iminor(in);
+	_IPATH_VDBG("open on dev %lx (minor %d)\n", (long)in->i_rdev, minor);
+
+	/* This code is present to allow a knowledgeable person to specify the
+	 * layout of processes to processors before opening this driver, and
+	 * then we'll assign the process to the "closest" HT-400 to
+	 * that processor * (we assume reasonable connectivity, for now).
+	 * This code assumes that if affinity has been set before this
+	 * point, that at most one cpu is set; for now this is reasonable.
+	 * I check for both cpus_empty() and cpus_full(), in case some
+	 * kernel variant sets none of the bits when no affinity is set.
+	 * 2.6.11 and 12 kernels have all present cpus set.
+	 * Some day we'll have to fix it up further to handle a cpu subset.
+	 * This algorithm fails for two HT-400's connected in tunnel fashion.
+	 * Eventually this needs real topology information.
+	 * There may be some issues with dual core numbering as well.  This
+	 * needs more work prior to release.
+	 */
+	if (minor != IPATH_SMA
+#ifdef IPATH_DIAG
+		&& minor != IPATH_DIAG
+#endif
+		&& minor != IPATH_CTRL
+		&& !cpus_empty(current->cpus_allowed)
+		&& !cpus_full(current->cpus_allowed)) {
+		int ncpus = num_online_cpus(), curcpu = -1;
+		for (i=0; i<ncpus; i++)
+			if (cpu_isset(i, current->cpus_allowed)) {
+				_IPATH_PRDBG("%s[%u] affinity set for cpu %d\n",
+					current->comm, current->pid, i);
+				curcpu = i;
+			}
+		if (curcpu != -1) {
+			for (ndev = 0; ndev < infinipath_max; ndev++)
+				if ((devdata[ndev].ipath_flags & IPATH_PRESENT)
+				    && devdata[ndev].ipath_kregbase)
+					npresent++;
+			if (npresent) {
+				prefunit = curcpu/(ncpus/npresent);
+				_IPATH_DBG("%s[%u] %d chips, %d cpus, "
+					   "%d cpus/chip, select unit %d\n",
+					   current->comm, current->pid,
+					   npresent, ncpus, ncpus/npresent,
+					   prefunit);
+			}
+		}
+	}
+
+	if (minor == IPATH_SMA) {
+		ret = ipath_opensma(in, fp);
+		/* for ipath_ioctl */
+		fp->private_data = (void *)(unsigned long)minor;
+		goto done;
+	}
+#ifdef IPATH_DIAG
+	else if (minor == IPATH_DIAG) {
+		ret = ipath_opendiag(in, fp);
+		/* for ipath_ioctl */
+		fp->private_data = (void *)(unsigned long)minor;
+		goto done;
+	}
+#endif
+	else if (minor == IPATH_CTRL) {
+		/* for ipath_ioctl */
+		fp->private_data = (void *)(unsigned long)minor;
+		ret = 0;
+		goto done;
+	}
+	else if (minor) {
+		/*
+		 * minor number 0 is used for all chips, we choose available
+		 * chip ourselves, it isn't based on what they open.
+		 */
+
+		_IPATH_DBG("open on invalid minor %u\n", minor);
+		ret = -ENXIO;
+		goto done;
+	}
+
+	/*
+	 * for now, we use all ports on one, then all ports on the
+	 * next, etc.  Eventually we want to tweak this to be cpu/chip
+	 * topology aware, and round-robin across chips that are
+	 * configured and connected, placing processes on the closest
+	 * available processor that isn't already over-allocated.
+	 * multi-HT400 topology could be better handled
+	 */
+
+	npresent = maxofallports = 0;
+	for (ndev = 0; ndev < infinipath_max; ndev++) {
+		if (!(devdata[ndev].ipath_flags & IPATH_PRESENT) ||
+		    !devdata[ndev].ipath_kregbase)
+			continue;
+		npresent++;
+		if ((devdata[ndev].
+		     ipath_flags & (IPATH_LINKDOWN | IPATH_LINKUNK))) {
+			_IPATH_VDBG("unit %u present, but link not ready\n",
+				    ndev);
+			notup++;
+			continue;
+		} else if (!devdata[ndev].ipath_lid) {
+			_IPATH_VDBG
+			    ("unit %u present, but LID not assigned, down\n",
+			     ndev);
+			notup++;
+			continue;
+		}
+		if (devdata[ndev].ipath_cfgports > maxofallports)
+			maxofallports = devdata[ndev].ipath_cfgports;
+	}
+
+	/*
+	 * user ports start at 1, kernel port is 0
+	 * For now, we do round-robin access across all chips
+	 */
+
+	devmax = prefunit!=-1 ? prefunit+1 : infinipath_max;
+recheck:
+	for (i = 1; i < maxofallports; i++) {
+		for (ndev = prefunit!=-1?prefunit:0; ndev < devmax; ndev++) {
+			if (!(devdata[ndev].ipath_flags & IPATH_PRESENT) ||
+			    !devdata[ndev].ipath_kregbase
+			    || !devdata[ndev].ipath_lid
+			    || (devdata[ndev].
+				ipath_flags & (IPATH_LINKDOWN | IPATH_LINKUNK)))
+				break;	/* can't use this chip */
+			if (i >= devdata[ndev].ipath_cfgports)
+				break;	/* max'ed out on users of this chip */
+			if (!devdata[ndev].ipath_pd[i]) {
+				void *p, *ptmp;
+				p = kmalloc(sizeof(struct ipath_portdata),
+					    GFP_KERNEL);
+
+				/*
+				 * allocate memory for use in
+				 * ipath_tid_update() just once at open,
+				 * not per call.  Reduces cost of expected
+				 * send setup
+				 */
+
+				ptmp =
+				    kmalloc(devdata[ndev].ipath_rcvtidcnt *
+					    sizeof(uint16_t)
+					    +
+					    devdata[ndev].ipath_rcvtidcnt *
+					    sizeof(struct page **), GFP_KERNEL);
+				if (!p || !ptmp) {
+					_IPATH_UNIT_ERROR(ndev,
+							  "Unable to allocate portdata memory, failing open\n");
+					ret = -ENOMEM;
+					kfree(p);
+					kfree(ptmp);
+					goto done;
+				}
+				memset(p, 0, sizeof(struct ipath_portdata));
+				devdata[ndev].ipath_pd[i] = p;
+				devdata[ndev].ipath_pd[i]->port_port = i;
+				devdata[ndev].ipath_pd[i]->port_unit = ndev;
+				devdata[ndev].ipath_pd[i]->port_tid_pg_list =
+				    ptmp;
+				init_waitqueue_head(&devdata[ndev].ipath_pd[i]->
+						    port_wait);
+			}
+			if (!devdata[ndev].ipath_pd[i]->port_cnt) {
+				devdata[ndev].ipath_pd[i]->port_cnt = 1;
+				fp->private_data =
+				    (void *)devdata[ndev].ipath_pd[i];
+				_IPATH_PRDBG("%s[%u] opened unit:port %u:%u\n",
+					     current->comm, current->pid, ndev,
+					     i);
+				devdata[ndev].ipath_pd[i]->port_pid =
+				    current->pid;
+				strncpy(devdata[ndev].ipath_pd[i]->port_comm,
+					current->comm,
+					sizeof(devdata[ndev].ipath_pd[i]->
+					       port_comm));
+				ipath_stats.sps_ports++;
+				goto done;
+			}
+		}
+	}
+
+	if (npresent) {
+		if (notup) {
+			ret = -ENETDOWN;
+			_IPATH_DBG
+			    ("No ports available (none initialized and ready)\n");
+		} else {
+			if (prefunit > 0) { /* if we started above unit 0, retry from 0 */
+				_IPATH_PRDBG("%s[%u] no ports on prefunit %d, clear and re-check\n",
+					current->comm, current->pid, prefunit);
+				devmax = infinipath_max;
+				prefunit = -1;
+				goto recheck;
+			}
+			ret = -EBUSY;
+			_IPATH_DBG("No ports available\n");
+		}
+	} else {
+		ret = -ENXIO;
+		_IPATH_DBG("No boards found\n");
+	}
+
+done:
+	up(&ipath_mutex);
+	return ret;
+}
+
+static int ipath_opensma(struct inode *in, struct file *fp)
+{
+	ipath_type s;
+
+	if (ipath_sma_alive) {
+		_IPATH_DBG("SMA already running (pid %u), failing\n",
+			   ipath_sma_alive);
+		return -EBUSY;
+	}
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;	/* all SMA functions are root-only */
+
+	for (s = 0; s < infinipath_max; s++) {
+		/* we need at least one infinipath device to be initialized. */
+		if (devdata[s].ipath_flags & IPATH_INITTED) {
+			ipath_sma_alive = current->pid;
+			*devdata[s].ipath_statusp |= IPATH_STATUS_SMA;
+			*devdata[s].ipath_statusp &= ~IPATH_STATUS_OIB_SMA;
+		}
+	}
+	if (ipath_sma_alive) {
+		_IPATH_SMADBG
+			("SMA device now open, SMA active as PID %u\n",
+			 ipath_sma_alive);
+		return 0;
+	}
+	_IPATH_DBG("No hardware yet found and initted, failing\n");
+	return -ENODEV;
+}
+
+
+#ifdef IPATH_DIAG
+static int ipath_opendiag(struct inode *in, struct file *fp)
+{
+	ipath_type s;
+
+	if (ipath_diag_alive) {
+		_IPATH_DBG("Diags already running (pid %u), failing\n",
+			   ipath_diag_alive);
+		return -EBUSY;
+	}
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;	/* all diags functions are root-only */
+
+	for (s = 0; s < infinipath_max; s++)
+		/*
+		 * we need at least one infinipath device to be present
+		 * (don't use INITTED, because we want to be able to open
+		 * even if device is in freeze mode, which cleared INITTED.
+		 * There is s small amount of risk to this, which is
+		 * why we also verify kregbase is set.
+		 */
+
+		if ((devdata[s].ipath_flags & IPATH_PRESENT)
+		    && devdata[s].ipath_kregbase) {
+			ipath_diag_alive = current->pid;
+			_IPATH_DBG("diag device now open, active as PID %u\n",
+				   ipath_diag_alive);
+			return 0;
+		}
+	_IPATH_DBG("No hardware yet found and initted, failing diags\n");
+	return -ENODEV;
+}
+#endif
+
+/*
+ * clear all TID entries for a port, expected and eager.
+ * Used from ipath_close(), and at chip initialization.
+ */
+
+static void ipath_clear_tids(const ipath_type t, unsigned port)
+{
+	uint64_t __iomem *tidbase;
+	int i;
+	struct ipath_devdata *dd;
+	uint64_t tidval;
+	dd = &devdata[t];
+
+	if (!dd->ipath_kregbase)
+		return;
+
+	/*
+	 * chip errata bug 7358, try to work around it by marking invalid
+	 * tids as having max length
+	 */
+
+	tidval =
+	    (-1LL & INFINIPATH_RT_BUFSIZE_MASK) << INFINIPATH_RT_BUFSIZE_SHIFT;
+
+	/*
+	 * need to invalidate all of the expected TID entries for this
+	 * port, so we don't have valid entries that might somehow get
+	 * used (early in next use of this port, or through some bug)
+	 * We don't bother with the eager, because they are initialized
+	 * each time before receives are enabled; expected aren't
+	 */
+
+	tidbase = (uint64_t __iomem *) ((char __iomem *)(dd->ipath_kregbase) +
+					dd->ipath_rcvtidbase +
+					port * dd->ipath_rcvtidcnt *
+					sizeof(*tidbase));
+	_IPATH_VDBG("Invalidate expected TIDs for port %u, tidbase=%p\n", port,
+		    tidbase);
+	for (i = 0; i < dd->ipath_rcvtidcnt; i++)
+		ipath_kput_memq(t, &tidbase[i], tidval);
+	yield();		/* don't hog the cpu */
+
+	/* zero the eager TID entries */
+	tidbase = (uint64_t __iomem *)((char __iomem *)(dd->ipath_kregbase) +
+				       dd->ipath_rcvegrbase +
+				       port * dd->ipath_rcvegrcnt *
+				       sizeof(*tidbase));
+
+	for (i = 0; i < dd->ipath_rcvegrcnt; i++)
+		ipath_kput_memq(t, &tidbase[i], tidval);
+	yield();		/* don't hog the cpu */
+}
+
+int ipath_close(struct inode *in, struct file *fp)
+{
+	int ret = 0;
+	struct ipath_portdata *pd;
+
+	_IPATH_VDBG("close on dev %lx, private data %p\n", (long)in->i_rdev,
+		    fp->private_data);
+
+	down(&ipath_mutex);
+	if (iminor(in) == IPATH_SMA) {
+		ipath_type s;
+
+		ipath_sma_alive = 0;
+		_IPATH_SMADBG("Closing SMA device\n");
+		for (s = 0; s < infinipath_max; s++) {
+			if (!(devdata[s].ipath_flags & IPATH_INITTED))
+				continue;
+			*devdata[s].ipath_statusp &= ~IPATH_STATUS_SMA;
+			if (devdata[s].verbs_layer.l_flags &
+			    IPATH_VERBS_KERNEL_SMA)
+				*devdata[s].ipath_statusp |=
+				    IPATH_STATUS_OIB_SMA;
+		}
+	}
+#ifdef IPATH_DIAG
+	else if (iminor(in) == IPATH_DIAG) {
+		ipath_diag_alive = 0;
+		_IPATH_DBG("Closing DIAG device\n");
+	}
+#endif
+	else if (fp->private_data && 255UL < (unsigned long)fp->private_data) {
+		ipath_type t;
+		unsigned port;
+		struct ipath_devdata *dd;
+
+		pd = (struct ipath_portdata *) fp->private_data;
+		port = pd->port_port;
+		fp->private_data = NULL;
+		t = pd->port_unit;
+		if (t > infinipath_max) {
+			_IPATH_ERROR
+			    ("closing, fp %p, pd %p, but unit %x not valid!\n",
+			     fp, pd, t);
+			goto done;
+		}
+		dd = &devdata[t];
+
+		if (pd->port_hdrqfull) {
+			_IPATH_PRDBG
+			    ("%s[%u] had %u rcvhdrqfull errors during run\n",
+			     pd->port_comm, pd->port_pid, pd->port_hdrqfull);
+			pd->port_hdrqfull = 0;
+		}
+
+		if (pd->port_rcvwait_to || pd->port_piowait_to
+		    || pd->port_rcvnowait || pd->port_pionowait) {
+			_IPATH_VDBG
+			    ("port%u, %u rcv, %u pio wait timeo; %u rcv %u, pio already\n",
+			     pd->port_port, pd->port_rcvwait_to,
+			     pd->port_piowait_to, pd->port_rcvnowait,
+			     pd->port_pionowait);
+			pd->port_rcvwait_to = pd->port_piowait_to =
+			    pd->port_rcvnowait = pd->port_pionowait = 0;
+		}
+		if (pd->port_flag) {
+			_IPATH_DBG("port %u port_flag still set to 0x%x\n",
+				   pd->port_port, pd->port_flag);
+			pd->port_flag = 0;
+		}
+
+		if (devdata[t].ipath_kregbase) {
+			if (pd->port_rcvhdrtail_uaddr) {
+				pd->port_rcvhdrtail_uaddr = 0;
+				pd->port_rcvhdrtail_kvaddr = NULL;
+				ipath_putpages(1, &pd->port_rcvhdrtail_pagep);
+				pd->port_rcvhdrtail_pagep = NULL;
+				ipath_stats.sps_pageunlocks++;
+			}
+			ipath_kput_kreg_port(t, kr_rcvhdrtailaddr, port, 0ULL);
+			ipath_kput_kreg_port(pd->port_unit, kr_rcvhdraddr,
+					     pd->port_port, 0);
+
+			/* clean up the pkeys for this port user */
+			ipath_clean_partkey(pd, dd);
+
+			if (port < dd->ipath_cfgports) {
+				int i = dd->ipath_pbufsport * (port - 1);
+				ipath_disarm_piobufs(t, i, dd->ipath_pbufsport);
+
+				/* atomically clear receive enable port. */
+				atomic_clear_mask(1U <<
+						  (INFINIPATH_R_PORTENABLE_SHIFT
+						   + port),
+						  &devdata[t].ipath_rcvctrl);
+				ipath_kput_kreg(t, kr_rcvctrl,
+						devdata[t].ipath_rcvctrl);
+
+				if (dd->ipath_pageshadow) {
+					/*
+					 * unlock any expected TID
+					 * entries port still had in use
+					 */
+					int port_tidbase =
+					    pd->port_port * dd->ipath_rcvtidcnt;
+					int i, cnt = 0, maxtid =
+					    port_tidbase + dd->ipath_rcvtidcnt;
+
+					_IPATH_VDBG
+					    ("Port %u unlocking any locked expTID pages\n",
+					     pd->port_port);
+					for (i = port_tidbase; i < maxtid; i++) {
+						if (dd->ipath_pageshadow[i]) {
+							ipath_putpages(1,
+								      &dd->
+								      ipath_pageshadow
+								      [i]);
+							dd->ipath_pageshadow[i]
+							    = NULL;
+							cnt++;
+							ipath_stats.
+							    sps_pageunlocks++;
+						}
+					}
+					if (cnt)
+						_IPATH_VDBG
+						    ("Port %u had %u expTID entries locked\n",
+						     pd->port_port, cnt);
+					if (ipath_stats.sps_pagelocks
+					    || ipath_stats.sps_pageunlocks)
+						_IPATH_VDBG
+						    ("%llu pages locked, %llu unlocked with"
+						     " ipath_m{un}lock\n",
+						     ipath_stats.sps_pagelocks,
+						     ipath_stats.
+						     sps_pageunlocks);
+				}
+				ipath_stats.sps_ports--;
+				_IPATH_PRDBG("%s[%u] closed port %u:%u\n",
+					     pd->port_comm, pd->port_pid, t,
+					     port);
+			}
+		}
+
+		pd->port_cnt = 0;
+		pd->port_pid = 0;
+
+		ipath_clear_tids(t, pd->port_port);
+
+		ipath_free_pddata(dd, pd->port_port, 0);
+	}
+
+done:
+	up(&ipath_mutex);
+
+	return ret;
+}
