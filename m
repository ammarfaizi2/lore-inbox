Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbVL3Wsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbVL3Wsa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 17:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbVL3WsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 17:48:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:54984 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964853AbVL3Wrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 17:47:45 -0500
Date: Fri, 30 Dec 2005 00:39:28 -0800
From: Greg KH <greg@kroah.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 8 of 20] ipath - core driver, part 1 of 4
Message-ID: <20051230083928.GD7438@kroah.com>
References: <patchbomb.1135816279@eng-12.pathscale.com> <ddd21709e12c0cd55bdc.1135816287@eng-12.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddd21709e12c0cd55bdc.1135816287@eng-12.pathscale.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2005 at 04:31:27PM -0800, Bryan O'Sullivan wrote:
> Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>
> 
> diff -r ffbd416f30d4 -r ddd21709e12c drivers/infiniband/hw/ipath/ipath_driver.c
> --- /dev/null	Thu Jan  1 00:00:00 1970 +0000
> +++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Wed Dec 28 14:19:42 2005 -0800
> @@ -0,0 +1,1879 @@
> +/*
> + * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
> + *
> + * This software is available to you under a choice of one of two
> + * licenses.  You may choose to be licensed under the terms of the GNU
> + * General Public License (GPL) Version 2, available from the file
> + * COPYING in the main directory of this source tree, or the
> + * OpenIB.org BSD license below:
> + *
> + *     Redistribution and use in source and binary forms, with or
> + *     without modification, are permitted provided that the following
> + *     conditions are met:
> + *
> + *      - Redistributions of source code must retain the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer.
> + *
> + *      - Redistributions in binary form must reproduce the above
> + *        copyright notice, this list of conditions and the following
> + *        disclaimer in the documentation and/or other materials
> + *        provided with the distribution.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> + * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
> + * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
> + * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> + * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
> + * SOFTWARE.
> + *
> + * Patent licenses, if any, provided herein do not apply to
> + * combinations of this program with other software, or any other
> + * product whatsoever.
> + */
> +
> +#include <linux/version.h>
> +#include <linux/pci.h>
> +#include <linux/delay.h>
> +#include <linux/swap.h>
> +#include <asm/mtrr.h>
> +#include <linux/netdevice.h>
> +
> +#include <linux/crc32.h>	/* we can generate our own crc's for testing */
> +
> +#include "ipath_kernel.h"
> +#include "ips_common.h"
> +#include "ipath_layer.h"
> +
> +/*
> + * Our LSB-assigned major number, so scripts can figure
> + * out how to make entry in /dev.
> + */
> +
> +static int ipath_major = 233;
> +
> +/*
> + * number of buffers reserved for driver (layered drivers and SMA send).
> + * Reserved at end of buffer list.
> + */
> +
> +static uint infinipath_kpiobufs = 32;
> +
> +/*
> + * number of ports we are configured to use (to allow for more pio
> + * buffers per port, etc.)  Zero means use chip value.
> + */
> +
> +static uint infinipath_cfgports;
> +
> +/*
> + * number of units we are configured to use (to allow for bringup on
> + * multi-chip systems)  Zero means use only one for now, but eventually
> + * will mean to use infinipath_max
> + */
> +
> +static uint infinipath_cfgunits;
> +
> +uint64_t ipath_dummy_val_for_testing;
> +
> +static __kernel_pid_t ipath_sma_alive;	/* PID of SMA, if it's running */
> +static spinlock_t ipath_sma_lock;	/* SMA receive */
> +
> +/* max SM received packets we'll queue; we keep the most recent packets. */
> +
> +#define IPATH_NUM_SMAPKTS  16
> +
> +#define IPATH_SMA_HDRSZ (8+12+8)	/* LRH+BTH+DETH */
> +
> +static struct _ipath_sma_rpkt {
> +	/* length of received packet; non-zero if queued */
> +	uint32_t len;
> +	/* unit number of interface packet was received from */
> +	uint32_t unit;
> +	uint8_t *buf;
> +} ipath_sma_data[IPATH_NUM_SMAPKTS];
> +
> +static unsigned ipath_sma_first; /* oldest sma packet index */
> +static unsigned ipath_sma_next;	/* next sma packet index to use */
> +
> +/*
> + * ipath_sma_data_bufs has one extra, pointed to by ipath_sma_data_spare,
> + * so we can exchange buffers to do copy_to_user, and not hold the lock
> + * across the copy_to_user().
> + */
> +
> +#define SMA_MAX_PKTSZ (IPATH_SMA_HDRSZ+256)	/* max len of an SMA packet */
> +
> +static uint8_t ipath_sma_data_bufs[IPATH_NUM_SMAPKTS + 1][SMA_MAX_PKTSZ];
> +static uint8_t *ipath_sma_data_spare;
> +/* sma waits globally on all units */
> +static wait_queue_head_t ipath_sma_wait;
> +static wait_queue_head_t ipath_sma_state_wait;
> +
> +struct infinipath_stats ipath_stats;
> +
> +/*
> + * this will only be used for diags, now that we have enabled the DMA
> + * of the sendpioavail regs to system memory.
> + */
> +
> +static inline uint64_t ipath_kget_sreg(const ipath_type stype,
> +					   ipath_sreg regno)
> +{
> +	uint64_t val;
> +	uint64_t *sbase;
> +
> +	sbase = (uint64_t *) (devdata[stype].ipath_sregbase
> +			      + (char *)devdata[stype].ipath_kregbase);
> +	val = sbase ? sbase[regno] : 0ULL;
> +	return val;
> +}
> +
> +static int ipath_do_user_init(struct ipath_portdata *,
> +			      struct ipath_user_info __user *);
> +static int ipath_get_baseinfo(struct ipath_portdata *,
> +			      struct ipath_base_info __user *);
> +static int ipath_get_units(void);
> +static int ipath_wr_eeprom(struct ipath_portdata *,
> +			   struct ipath_eeprom_req __user *);
> +static int ipath_wait_intr(struct ipath_portdata *, uint32_t);
> +static int ipath_tid_update(struct ipath_portdata *, struct _tidupd __user *);
> +static int ipath_tid_free(struct ipath_portdata *, struct _tidupd __user *);
> +static int ipath_get_counters(ipath_type, struct infinipath_counters __user *);
> +static int ipath_get_unit_counters(struct infinipath_getunitcounters __user *a);
> +static int ipath_get_stats(struct infinipath_stats __user *);
> +static int ipath_set_partkey(struct ipath_portdata *, uint16_t);
> +static int ipath_manage_rcvq(struct ipath_portdata *, uint16_t);
> +static void ipath_clean_partkey(struct ipath_portdata *,
> +				struct ipath_devdata *);
> +static void ipath_disarm_piobufs(const ipath_type, unsigned, unsigned);
> +static int ipath_create_user_egr(struct ipath_portdata *);
> +static int ipath_create_port0_egr(struct ipath_portdata *);
> +static int ipath_create_rcvhdrq(struct ipath_portdata *);
> +static void ipath_handle_errors(const ipath_type, uint64_t);
> +static void ipath_update_pio_bufs(const ipath_type);
> +static int ipath_shutdown_link(const ipath_type);
> +static int ipath_bringup_link(const ipath_type);
> +int ipath_bringup_serdes(const ipath_type);
> +static void ipath_get_faststats(unsigned long);
> +static int ipath_setup_htconfig(struct pci_dev *, uint64_t *, const ipath_type);
> +static struct page *ipath_nopage(struct vm_area_struct *, unsigned long, int *);
> +static irqreturn_t ipath_intr(int irq, void *devid, struct pt_regs *regs);
> +static void ipath_decode_err(char *, size_t, uint64_t);
> +void ipath_free_pddata(struct ipath_devdata *, uint32_t, int);
> +static void ipath_clear_tids(const ipath_type, unsigned);
> +static void ipath_get_guid(const ipath_type);
> +static int ipath_sma_ioctl(struct file *, unsigned int, unsigned long);
> +static int ipath_rcvsma_pkt(struct ipath_sendpkt __user *);
> +static int ipath_kset_lid(uint32_t);
> +static int ipath_kset_mlid(uint32_t);
> +static int ipath_get_mlid(uint32_t __user *);
> +static int ipath_get_devstatus(uint64_t __user *);
> +static int ipath_kset_guid(struct ipath_setguid __user *);
> +static int ipath_get_portinfo(uint32_t __user *);
> +static int ipath_get_nodeinfo(uint32_t __user *);
> +#ifdef _IPATH_EXTRA_DEBUG
> +static void ipath_dump_allregs(char *, ipath_type);
> +#endif
> +
> +static const char ipath_sma_name[] = "infinipath_SMA";
> +
> +/*
> + * is diags mode enabled?  if it is, then things like auto bringup of
> + * links is disabled
> + */
> +
> +int ipath_diags_enabled = 0;
> +
> +void ipath_chip_done(void)
> +{
> +}
> +
> +void ipath_chip_cleanup(struct ipath_devdata * dd)
> +{
> +}

What are these two empty functions for?

> +/*
> + * cache aligned location
> + *
> + * where port 0 rcvhdrtail register is written back; also want
> + * nothing else sharing the cache line, so make it a cache line in size
> + * used for all units
> + *
> + * This is volatile as it's the target of a DMA from the chip.
> + */
> +
> +static volatile uint64_t ipath_port0_rcvhdrtail[512]
> +    __attribute__ ((aligned(4096)));
> +
> +#define MODNAME "ipath_core"
> +#define DRIVER_LOAD_MSG "PathScale " MODNAME " loaded: "
> +#define PFX MODNAME ": "
> +
> +/*
> + * min buffers we want to have per port, after driver
> + */
> +
> +#define IPATH_MIN_USER_PORT_BUFCNT 8
> +
> +/* The size has to be longer than this string, so we can
> + * append board/chip information to it in the init code.
> + */
> +static char ipath_core_version[192] = IPATH_IDSTR;
> +static char *chip_driver_version;
> +static int chip_driver_size;
> +
> +/* mylid and lidbase are to deal with LIDs in "fabric", until SM is working */
> +
> +module_param(infinipath_debug, uint, 0644);
> +module_param(infinipath_kpiobufs, uint, 0644);
> +module_param(infinipath_cfgports, uint, 0644);
> +module_param(infinipath_cfgunits, uint, 0644);
> +
> +MODULE_PARM_DESC(infinipath_debug, "mask for debug prints");
> +MODULE_PARM_DESC(infinipath_cfgports, "Set max number of ports to use");
> +MODULE_PARM_DESC(infinipath_cfgunits, "Set max number of devices to use");
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("PathScale <infinipath-support@pathscale.com>");
> +MODULE_DESCRIPTION("Pathscale InfiniPath driver");
> +
> +#ifdef IPATH_DIAG
> +static __kernel_pid_t ipath_diag_alive;	/* PID of diags, if running */
> +int ipath_diags_ioctl(struct file *, unsigned, unsigned long);
> +static int ipath_opendiag(struct inode *, struct file *);
> +#endif
> +
> +#if __IPATH_INFO || __IPATH_DBG
> +static const char *ipath_ibcstatus_str[] = {
> +	"Disabled",
> +	"LinkUp",
> +	"PollActive",
> +	"PollQuiet",
> +	"SleepDelay",
> +	"SleepQuiet",
> +	"LState6",		/* unused */
> +	"LState7",		/* unused */
> +	"CfgDebounce",
> +	"CfgRcvfCfg",
> +	"CfgWaitRmt",
> +	"CfgIdle",
> +	"RecovRetrain",
> +	"LState0xD",		/* unused */
> +	"RecovWaitRmt",
> +	"RecovIdle",
> +};
> +#endif
> +
> +static ssize_t show_version(struct device_driver *dev, char *buf)
> +{
> +	return snprintf(buf, PAGE_SIZE, "%s", ipath_core_version);
> +}
> +
> +static ssize_t show_status(struct device *dev,
> +			   struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct ipath_devdata *dd = dev_get_drvdata(dev);
> +
> +	if (!dd)
> +		return -EINVAL;
> +
> +	if (!dd->ipath_statusp)
> +		return -EINVAL;
> +
> +	return snprintf(buf, PAGE_SIZE, "%llx\n", *(dd->ipath_statusp));
> +}
> +
> +static const char *ipath_status_str[] = {
> +	"Initted",
> +	"Disabled",
> +	"4",                    /* unused */
> +	"OIB_SMA",
> +	"SMA",
> +	"Present",
> +	"IB_link_up",
> +	"IB_configured",
> +	"NoIBcable",
> +	"Fatal_Hardware_Error",
> +	NULL,
> +};
> +
> +static ssize_t show_status_str(struct device *dev,
> +			   struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct ipath_devdata *dd = dev_get_drvdata(dev);
> +	int i, any;
> +	uint64_t s;
> +
> +	if (!dd)
> +		return -EINVAL;
> +
> +	if (!dd->ipath_statusp)
> +		return -EINVAL;
> +
> +	s = *(dd->ipath_statusp);
> +	*buf = '\0';
> +	for (any = i = 0; s && ipath_status_str[i]; i++) {
> +		if (s & 1) {
> +			if (any && strlcat(buf, " ", PAGE_SIZE) >= PAGE_SIZE)
> +				/* overflow */
> +				break;
> +			if (strlcat(buf, ipath_status_str[i],
> +				    PAGE_SIZE) >= PAGE_SIZE)
> +				break;
> +			any = 1;
> +		}
> +		s >>= 1;
> +	}
> +	if (any)
> +		strlcat(buf, "\n", PAGE_SIZE);
> +
> +	return strlen(buf);
> +}

how big can this "status string" be?  If it's even getting close to
PAGE_SIZE, this doesn't need to be a sysfs attribute, but you should
break it up into its individual pieces.

Based on the table above, this function can get much simpler...

> +
> +static ssize_t show_lid(struct device *dev,
> +			   struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct ipath_devdata *dd = dev_get_drvdata(dev);
> +
> +	if (!dd)
> +		return -EINVAL;
> +
> +	return snprintf(buf, PAGE_SIZE, "%x\n", dd->ipath_lid);
> +}
> +
> +static ssize_t show_mlid(struct device *dev,
> +			   struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct ipath_devdata *dd = dev_get_drvdata(dev);
> +
> +	if (!dd)
> +		return -EINVAL;
> +
> +	return snprintf(buf, PAGE_SIZE, "%x\n", dd->ipath_mlid);
> +}
> +
> +static ssize_t show_guid(struct device *dev,
> +			   struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct ipath_devdata *dd = dev_get_drvdata(dev);
> +	uint8_t *guid;
> +
> +	if (!dd)
> +		return -EINVAL;
> +
> +	guid = (uint8_t *)&(dd->ipath_guid);
> +
> +	return snprintf(buf, PAGE_SIZE, "%x:%x:%x:%x:%x:%x:%x:%x\n",
> +			guid[0], guid[1], guid[2], guid[3], guid[4], guid[5],
> +			guid[6], guid[7]);
> +}
> +
> +static ssize_t show_nguid(struct device *dev,
> +			   struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct ipath_devdata *dd = dev_get_drvdata(dev);
> +
> +	if (!dd)
> +		return -EINVAL;
> +
> +	return snprintf(buf, PAGE_SIZE, "%u\n", dd->ipath_nguid);
> +}
> +
> +static ssize_t show_serial(struct device *dev,
> +			   struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct ipath_devdata *dd = dev_get_drvdata(dev);
> +
> +	if (!dd)
> +		return -EINVAL;
> +
> +	buf[sizeof dd->ipath_serial] = '\0';
> +	memcpy(buf, dd->ipath_serial, sizeof dd->ipath_serial);
> +	strcat(buf, "\n");
> +	return strlen(buf);
> +}
> +
> +static ssize_t show_unit(struct device *dev,
> +			   struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct ipath_devdata *dd = dev_get_drvdata(dev);
> +
> +	if (!dd)
> +		return -EINVAL;

Don't you mean -ENODEV?

> +
> +	snprintf(buf, PAGE_SIZE, "%u\n", dd->ipath_unit);
> +	return strlen(buf);

return the snprintf() call instead of calling strlen() all the time
please.

> +}
> +
> +static DRIVER_ATTR(version, S_IRUGO, show_version, NULL);
> +static DEVICE_ATTR(status, S_IRUGO, show_status, NULL);
> +static DEVICE_ATTR(status_str, S_IRUGO, show_status_str, NULL);
> +static DEVICE_ATTR(lid, S_IRUGO, show_lid, NULL);
> +static DEVICE_ATTR(mlid, S_IRUGO, show_mlid, NULL);
> +static DEVICE_ATTR(guid, S_IRUGO, show_guid, NULL);
> +static DEVICE_ATTR(nguid, S_IRUGO, show_nguid, NULL);
> +static DEVICE_ATTR(serial, S_IRUGO, show_serial, NULL);
> +static DEVICE_ATTR(unit, S_IRUGO, show_unit, NULL);
> +
> +/*
> + * called from add_timer and user counter read calls, to deal with
> + * counters that wrap in "human time".  The words sent and received, and
> + * the packets sent and received are all that we worry about.  For now,
> + * at least, we don't worry about error counters, because if they wrap
> + * that quickly, we probably don't care.  We may eventually just make this
> + * handle all the counters.  word counters can wrap in about 20 seconds
> + * of full bandwidth traffic, packet counters in a few hours.
> + */
> +
> +uint64_t ipath_snap_cntr(const ipath_type t, ipath_creg creg)
> +{
> +	uint32_t val;
> +	uint64_t val64, t0, t1;
> +	struct ipath_devdata *dd = &devdata[t];
> +	static uint64_t one_sec_in_cycles;
> +	extern uint32_t _ipath_pico_per_cycle;
> +
> +	if (!one_sec_in_cycles && _ipath_pico_per_cycle)
> +		one_sec_in_cycles = 1000000000000UL / _ipath_pico_per_cycle;
> +
> +	t0 = get_cycles();
> +	val = ipath_kget_creg32(t, creg);
> +	t1 = get_cycles();
> +	if ((t1 - t0) > one_sec_in_cycles && val == -1) {
> +		/*
> +		 * This is just a way to detect things that are quite broken.
> +		 * Normally this should take just a few cycles (the check is
> +		 * for long enough that we don't care if we get pre-empted.)
> +		 * An Opteron HT O read timeout is 4 seconds with normal
> +		 * NB values
> +		 */
> +
> +		_IPATH_UNIT_ERROR(t, "Error!  Reading counter 0x%x timed out\n",
> +				  creg);
> +		return 0ULL;
> +	}
> +
> +	if (creg == cr_wordsendcnt) {
> +		if (val != dd->ipath_lastsword) {
> +			dd->ipath_sword += val - dd->ipath_lastsword;
> +			dd->ipath_lastsword = val;
> +		}
> +		val64 = dd->ipath_sword;
> +	} else if (creg == cr_wordrcvcnt) {
> +		if (val != dd->ipath_lastrword) {
> +			dd->ipath_rword += val - dd->ipath_lastrword;
> +			dd->ipath_lastrword = val;
> +		}
> +		val64 = dd->ipath_rword;
> +	} else if (creg == cr_pktsendcnt) {
> +		if (val != dd->ipath_lastspkts) {
> +			dd->ipath_spkts += val - dd->ipath_lastspkts;
> +			dd->ipath_lastspkts = val;
> +		}
> +		val64 = dd->ipath_spkts;
> +	} else if (creg == cr_pktrcvcnt) {
> +		if (val != dd->ipath_lastrpkts) {
> +			dd->ipath_rpkts += val - dd->ipath_lastrpkts;
> +			dd->ipath_lastrpkts = val;
> +		}
> +		val64 = dd->ipath_rpkts;
> +	} else
> +		val64 = (uint64_t) val;
> +
> +	return val64;
> +}
> +
> +/*
> + * print the delta of egrfull/hdrqfull errors for kernel ports no more
> + * than every 5 seconds.  User processes are printed at close, but kernel
> + * doesn't close, so...  Separate routine so may call from other places
> + * someday, and so function name when printed by _IPATH_INFO is meaningfull
> + */
> +
> +static void ipath_qcheck(const ipath_type t)
> +{
> +	static uint64_t last_tot_hdrqfull;
> +	size_t blen = 0;
> +	struct ipath_devdata *dd = &devdata[t];
> +	char buf[128];
> +
> +	*buf = 0;
> +	if (dd->ipath_pd[0]->port_hdrqfull != dd->ipath_p0_hdrqfull) {
> +		blen = snprintf(buf, sizeof buf, "port 0 hdrqfull %u",
> +				dd->ipath_pd[0]->port_hdrqfull -
> +				dd->ipath_p0_hdrqfull);
> +		dd->ipath_p0_hdrqfull = dd->ipath_pd[0]->port_hdrqfull;
> +	}
> +	if (ipath_stats.sps_etidfull != dd->ipath_last_tidfull) {
> +		blen +=
> +		    snprintf(buf + blen, sizeof buf - blen, "%srcvegrfull %llu",
> +			     blen ? ", " : "",
> +			     ipath_stats.sps_etidfull - dd->ipath_last_tidfull);
> +		dd->ipath_last_tidfull = ipath_stats.sps_etidfull;
> +	}
> +
> +	/*
> +	 * this is actually the number of hdrq full interrupts, not actual
> +	 * events, but at the moment that's mostly what I'm interested in.
> +	 * Actual count, etc. is in the counters, if needed.  For production
> +	 * users this won't ordinarily be printed.
> +	 */
> +
> +	if ((infinipath_debug & (__IPATH_PKTDBG | __IPATH_DBG)) &&
> +	    ipath_stats.sps_hdrqfull != last_tot_hdrqfull) {
> +		blen +=
> +		    snprintf(buf + blen, sizeof buf - blen,
> +			     "%shdrqfull %llu (all ports)", blen ? ", " : "",
> +			     ipath_stats.sps_hdrqfull - last_tot_hdrqfull);
> +		last_tot_hdrqfull = ipath_stats.sps_hdrqfull;
> +	}
> +	if (blen)
> +		_IPATH_DBG("%s\n", buf);
> +
> +	if (*dd->ipath_hdrqtailptr != dd->ipath_port0head) {
> +		if (dd->ipath_lastport0rcv_cnt == ipath_stats.sps_port0pkts) {
> +			_IPATH_PDBG("missing rcv interrupts? port0 hd=%llx tl=%x; port0pkts %llx\n",
> +				*dd->ipath_hdrqtailptr, dd->ipath_port0head,ipath_stats.sps_port0pkts);
> +			ipath_kreceive(t);
> +		}
> +		dd->ipath_lastport0rcv_cnt = ipath_stats.sps_port0pkts;
> +	}
> +}
> +
> +/*
> + * called from add_timer to get word counters from chip before they
> + * can overflow
> + */
> +
> +static void ipath_get_faststats(unsigned long t)
> +{
> +	uint32_t val;
> +	struct ipath_devdata *dd = &devdata[t];
> +	static unsigned cnt;
> +
> +	/*
> +	 * don't access the chip while running diags, or memory diags
> +	 * can fail
> +	 */
> +	if (!dd->ipath_kregbase || !(dd->ipath_flags & IPATH_PRESENT) ||
> +	    ipath_diags_enabled) {
> +		/* but re-arm the timer, for diags case; won't hurt other */
> +		goto done;
> +	}
> +
> +	ipath_snap_cntr((ipath_type) t, cr_wordsendcnt);
> +	ipath_snap_cntr((ipath_type) t, cr_wordrcvcnt);
> +	ipath_snap_cntr((ipath_type) t, cr_pktsendcnt);
> +	ipath_snap_cntr((ipath_type) t, cr_pktrcvcnt);
> +
> +	ipath_qcheck(t);
> +
> +	/*
> +	 * deal with repeat error suppression.  Doesn't really matter if
> +	 * last error was almost a full interval ago, or just a few usecs
> +	 * ago; still won't get more than 2 per interval.  We may want
> +	 * longer intervals for this eventually, could do with mod, counter
> +	 * or separate timer.  Also see code in ipath_handle_errors() and
> +	 * ipath_handle_hwerrors().
> +	 */
> +
> +	if (dd->ipath_lasterror)
> +		dd->ipath_lasterror = 0;
> +	if (dd->ipath_lasthwerror)
> +		dd->ipath_lasthwerror = 0;
> +	if ((devdata[t].ipath_maskederrs & ~devdata[t].ipath_ignorederrs)
> +	    && get_cycles() > devdata[t].ipath_unmasktime) {
> +		char ebuf[256];
> +		ipath_decode_err(ebuf, sizeof ebuf,
> +				 (devdata[t].ipath_maskederrs & ~devdata[t].
> +				  ipath_ignorederrs));
> +		if ((devdata[t].ipath_maskederrs & ~devdata[t].
> +		     ipath_ignorederrs)
> +		    & ~(INFINIPATH_E_RRCVEGRFULL | INFINIPATH_E_RRCVHDRFULL)) {
> +			_IPATH_UNIT_ERROR(t, "Re-enabling masked errors (%s)\n",
> +					  ebuf);
> +		} else {
> +			/*
> +			 * rcvegrfull and rcvhdrqfull are "normal",
> +			 * for some types of processes (mostly benchmarks)
> +			 * that send huge numbers of messages, while
> +			 * not processing them.  So only complain about
> +			 * these at debug level.
> +			 */
> +			_IPATH_DBG
> +			    ("Disabling frequent queue full errors (%s)\n",
> +			     ebuf);
> +		}
> +		devdata[t].ipath_maskederrs = devdata[t].ipath_ignorederrs;
> +		ipath_kput_kreg(t, kr_errormask, ~devdata[t].ipath_maskederrs);
> +	}
> +
> +	if (dd->ipath_flags & IPATH_LINK_SLEEPING) {
> +		uint64_t ibc;
> +		_IPATH_VDBG("linkinitcmd SLEEP, move to POLL\n");
> +		dd->ipath_flags &= ~IPATH_LINK_SLEEPING;
> +		ibc = dd->ipath_ibcctrl;
> +		/*
> +		 * don't put linkinitcmd in ipath_ibcctrl, want that to
> +		 * stay a NOP
> +		 */
> +		ibc |=
> +		    INFINIPATH_IBCC_LINKINITCMD_POLL <<
> +		    INFINIPATH_IBCC_LINKINITCMD_SHIFT;
> +		ipath_kput_kreg(t, kr_ibcctrl, ibc);
> +	}
> +
> +	/* limit qfull messages to ~one per minute per port */
> +	if ((++cnt & 0x10)) {
> +		for (val = devdata[t].ipath_cfgports - 1; ((int)val) >= 0;
> +		     val--) {
> +			if (dd->ipath_lastegrheads[val] != -1)
> +				dd->ipath_lastegrheads[val] = -1;
> +			if (dd->ipath_lastrcvhdrqtails[val] != -1)
> +				dd->ipath_lastrcvhdrqtails[val] = -1;
> +		}
> +	}
> +
> +	if (dd->ipath_nosma_bufs) {
> +		dd->ipath_nosma_secs += 5;
> +		if (dd->ipath_nosma_secs >= 30) {
> +			_IPATH_SMADBG("No SMA bufs avail %u seconds; cancelling pending sends\n",
> +				dd->ipath_nosma_secs);
> +			ipath_disarm_piobufs(t, dd->ipath_lastport_piobuf,
> +				dd->ipath_piobcnt - dd->ipath_lastport_piobuf);
> +			dd->ipath_nosma_secs = 0; /* start again, if necessary */
> +		}
> +		else
> +			_IPATH_SMADBG("No SMA bufs avail %u tries, after %u seconds\n",
> +				dd->ipath_nosma_bufs, dd->ipath_nosma_secs);
> +	}
> +
> +done:
> +	mod_timer(&dd->ipath_stats_timer, jiffies + HZ * 5);
> +}
> +
> +
> +static void __devexit infinipath_remove_one(struct pci_dev *);
> +static int infinipath_init_one(struct pci_dev *, const struct pci_device_id *);
> +
> +/* Only needed for registration, nothing else needs this info */
> +#define PCI_VENDOR_ID_PATHSCALE 0x1fc1
> +#define PCI_DEVICE_ID_PATHSCALE_INFINIPATH_HT 0xd
> +
> +const struct pci_device_id infinipath_pci_tbl[] = {
> +	{
> +	 PCI_VENDOR_ID_PATHSCALE, PCI_DEVICE_ID_PATHSCALE_INFINIPATH_HT,
> +	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},

PCI_DEVICE() instead?

> +	{0,}

  {},
is all that is needed here.

> +};
> +
> +MODULE_DEVICE_TABLE(pci, infinipath_pci_tbl);
> +
> +static struct pci_driver infinipath_driver = {
> +	.name = MODNAME,
> +	.driver.owner = THIS_MODULE,

This line is not needed, you can remove it.

> +	.probe = infinipath_init_one,
> +	.remove = __devexit_p(infinipath_remove_one),
> +	.id_table = infinipath_pci_tbl,
> +};
> +
> +#if defined (pgprot_writecombine) && defined(_PAGE_MA_WC)
> +int remap_area_pages(unsigned long address, unsigned long phys_addr,
> +		     unsigned long size, unsigned long flags);
> +#endif
> +
> +static int infinipath_init_one(struct pci_dev *pdev,
> +			       const struct pci_device_id *ent)
> +{
> +	int ret, len, j;
> +	static int chip_idx = -1;
> +	unsigned long addr;
> +	uint64_t intconfig;
> +	uint8_t rev;
> +	ipath_type dev;
> +
> +	/*
> +	 * XXX: Right now, we have a hardcoded array of devices.  We'll
> +	 * change this in a future release, but not just yet.  For the
> +	 * moment, we're limited to 4 infinipath devices per system.
> +	 */
> +
> +	dev = ++chip_idx;
> +
> +	_IPATH_VDBG("initializing unit #%u\n", dev);
> +	if ((!infinipath_cfgunits && (dev >= 1)) ||
> +	    (infinipath_cfgunits && (dev >= infinipath_cfgunits)) ||
> +	    (dev >= infinipath_max)) {
> +		_IPATH_ERROR("Trying to initialize unit %u, max is %u\n",
> +			     dev, infinipath_max - 1);
> +		return -EINVAL;
> +	}
> +
> +	devdata[dev].pci_registered = 1;
> +	devdata[dev].ipath_unit = dev;
> +
> +	if ((ret = pci_enable_device(pdev))) {
> +		_IPATH_DBG("pci_enable unit %u failed: %x\n", dev, ret);
> +	}

{} not needed here.

> +
> +	if ((ret = pci_request_regions(pdev, MODNAME)))
> +		_IPATH_INFO("pci_request_regions unit %u fails: %d\n", dev,
> +			    ret);
> +
> +	if ((ret = pci_set_dma_mask(pdev, DMA_64BIT_MASK)) != 0)
> +		_IPATH_INFO("pci_set_dma_mask unit %u fails: %d\n", dev, ret);
> +
> +	pci_set_master(pdev);	/* probably not be needed for HT */
> +
> +	addr = pci_resource_start(pdev, 0);
> +	len = pci_resource_len(pdev, 0);
> +	_IPATH_VDBG
> +	    ("regbase (0) %lx len %d irq %x, vend %x/%x driver_data %lx\n",
> +	     addr, len, pdev->irq, ent->vendor, ent->device, ent->driver_data);
> +	devdata[dev].ipath_deviceid = ent->device;	/* save for later use */
> +	devdata[dev].ipath_vendorid = ent->vendor;
> +	for (j = 0; j < 6; j++) {
> +		if (!pdev->resource[j].start)
> +			continue;
> +		_IPATH_VDBG("BAR %d start %lx, end %lx, len %lx\n",
> +			    j, pdev->resource[j].start,
> +			    pdev->resource[j].end, pci_resource_len(pdev, j));
> +	}
> +
> +	if (!addr) {
> +		_IPATH_UNIT_ERROR(dev, "No valid address in BAR 0!\n");
> +		return -ENODEV;
> +	}
> +
> +	if ((ret = pci_read_config_byte(pdev, PCI_REVISION_ID, &rev))) {
> +		_IPATH_UNIT_ERROR(dev,
> +				  "Failed to read PCI revision ID unit %u: %d\n",
> +				  dev, ret);
> +		return ret;	/* shouldn't ever happen */
> +	} else
> +		devdata[dev].ipath_pcirev = rev;
> +
> +	devdata[dev].ipath_kregbase = ioremap_nocache(addr, len);
> +#if defined (pgprot_writecombine) && defined(_PAGE_MA_WC)
> +	printk("Remapping pages WC\n");

No KERN_ level?

> +	remap_area_pages((unsigned long) devdata[dev].ipath_kregbase +
> +			 1024 * 1024, addr + 1024 * 1024, 1024 * 1024,
> +			 _PAGE_MA_WC);
> +	/* devdata[dev].ipath_kregbase = __ioremap(addr, len, _PAGE_MA_WC); */
> +#endif
> +
> +	if (!devdata[dev].ipath_kregbase) {
> +		_IPATH_DBG("Unable to map io addr %lx to kvirt, failing\n",
> +			   addr);
> +		ret = -ENOMEM;
> +		goto fail;
> +	}
> +	devdata[dev].ipath_kregend = (uint64_t __iomem *)
> +		((void __iomem *) devdata[dev].ipath_kregbase + len);
> +	devdata[dev].ipath_physaddr = addr;	/* used for io_remap, etc. */
> +	/* for user mmap */
> +	devdata[dev].ipath_kregvirt = (uint64_t __iomem *) phys_to_virt(addr);
> +	_IPATH_VDBG("mapped io addr %lx to kregbase %p kregvirt %p\n", addr,
> +		    devdata[dev].ipath_kregbase, devdata[dev].ipath_kregvirt);
> +
> +	/*
> +	 * set these up before registering the interrupt handler, just
> +	 * in case
> +	 */
> +	devdata[dev].pcidev = pdev;
> +	pci_set_drvdata(pdev, &(devdata[dev]));

It's not a "just in case" type thing, you have to do this before you
register that interrupt handler, as you can be instantly called here.

Are you sure everything else is set up properly here before calling that
function?

> +
> +	/*
> +	 * set up our interrupt handler; SA_SHIRQ probably not needed,
> +	 * but won't  hurt for now.
> +	 */
> +
> +	if (!pdev->irq) {
> +		_IPATH_UNIT_ERROR(dev, "irq is 0, failing init\n");
> +		ret = -EINVAL;
> +		goto fail;
> +	}
> +	if ((ret = request_irq(pdev->irq, ipath_intr,
> +			       SA_SHIRQ, MODNAME, &devdata[dev]))) {
> +		_IPATH_UNIT_ERROR(dev,
> +				  "Couldn't setup interrupt handler, irq=%u: %d\n",
> +				  pdev->irq, ret);
> +		goto fail;
> +	}
> +
> +	/*
> +	 * clear ipath_flags here instead of in ipath_init_chip as it is set
> +	 * by ipath_setup_htconfig.
> +	 */
> +	devdata[dev].ipath_flags = 0;
> +	if (ipath_setup_htconfig(pdev, &intconfig, dev))
> +		_IPATH_DBG
> +		    ("Failed to setup HT config, continuing anyway for now\n");
> +
> +	ret = ipath_init_chip(dev);	/* do the chip-specific init */
> +	if (!ret) {
> +#ifdef CONFIG_MTRR
> +		uint64_t pioaddr, piolen;
> +		unsigned bits;
> +		/*
> +		 * Set the PIO buffers to be WCCOMB, so we get HT bursts
> +		 * to the chip.  Linux (possibly the hardware) requires
> +		 * it to be on a power of 2 address matching the length
> +		 * (which has to be a power of 2).  For rev1, that means
> +		 * the base address, for rev2, it will be just the PIO
> +		 * buffers themselves.
> +		 */
> +		pioaddr = addr + devdata[dev].ipath_piobufbase;
> +		piolen = devdata[dev].ipath_piobcnt *
> +		    ALIGN(devdata[dev].ipath_piosize,
> +			  devdata[dev].ipath_palign);
> +
> +		for (bits = 0; !(piolen & (1ULL << bits)); bits++)
> +			/* do nothing */;
> +
> +		if (piolen != (1ULL << bits)) {
> +			_IPATH_DBG("piolen 0x%llx not power of 2, bits=%u\n",
> +				   piolen, bits);
> +			piolen >>= bits;
> +			while (piolen >>= 1)
> +				bits++;
> +			piolen = 1ULL << (bits + 1);
> +			_IPATH_DBG("Changed piolen to 0x%llx bits=%u\n", piolen,
> +				   bits);
> +		}
> +		if (pioaddr & (piolen - 1)) {
> +			uint64_t atmp;
> +			_IPATH_DBG
> +			    ("pioaddr %llx not on right boundary for size %llx, fixing\n",
> +			     pioaddr, piolen);
> +			atmp = pioaddr & ~(piolen - 1);
> +			if (atmp < addr || (atmp + piolen) > (addr + len)) {
> +				_IPATH_UNIT_ERROR(dev,
> +						  "No way to align address/size (%llx/%llx), no WC mtrr\n",
> +						  atmp, piolen << 1);
> +				ret = -ENODEV;
> +			} else {
> +				_IPATH_DBG
> +				    ("changing WC base from %llx to %llx, len from %llx to %llx\n",
> +				     pioaddr, atmp, piolen, piolen << 1);
> +				pioaddr = atmp;
> +				piolen <<= 1;
> +			}
> +		}
> +
> +		if (!ret) {
> +			int cookie;
> +			_IPATH_VDBG
> +			    ("Setting mtrr for chip to WC (addr %llx, len=0x%llx)\n",
> +			     pioaddr, piolen);
> +			cookie = mtrr_add(pioaddr, piolen, MTRR_TYPE_WRCOMB, 0);
> +			if (cookie < 0) {
> +				_IPATH_INFO
> +				    ("mtrr_add(%llx,0x%llx,WC,0) failed (%d)\n",
> +				     pioaddr, piolen, cookie);
> +				ret = -EINVAL;
> +			} else {
> +				_IPATH_VDBG
> +				    ("Set mtrr for chip to WC, cookie is %d\n",
> +				     cookie);
> +				devdata[dev].ipath_mtrr = (uint32_t) cookie;
> +			}
> +		}
> +#endif				/* CONFIG_MTRR */
> +	}
> +
> +	if (!ret && devdata[dev].ipath_kregbase && (devdata[dev].ipath_flags
> +					    & IPATH_PRESENT)) {
> +		/*
> +		 * for the hardware, enable interrupts only after
> +		 * kr_interruptconfig is written, if we could set it up
> +		 */
> +		if (intconfig) {
> +			/* interrupt address */
> +			ipath_kput_kreg(dev, kr_interruptconfig, intconfig);
> +			/* enable all interrupts */
> +			ipath_kput_kreg(dev, kr_intmask, -1LL);
> +			/* force re-interrupt of any pending interrupts. */
> +			ipath_kput_kreg(dev, kr_intclear, 0ULL);
> +			/* OK, the chip is usable, marked it as initialized */
> +			*devdata[dev].ipath_statusp |= IPATH_STATUS_INITTED;
> +		} else
> +			_IPATH_UNIT_ERROR(dev,
> +					  "No interrupts enabled, couldn't setup interrupt address\n");
> +	} else if (ret != -EPERM)
> +		_IPATH_INFO("Not configuring unit %u interrupts, init failed\n",
> +			    dev);
> +
> +	device_create_file(&(pdev->dev), &dev_attr_status);
> +	device_create_file(&(pdev->dev), &dev_attr_status_str);
> +	device_create_file(&(pdev->dev), &dev_attr_lid);
> +	device_create_file(&(pdev->dev), &dev_attr_mlid);
> +	device_create_file(&(pdev->dev), &dev_attr_guid);
> +	device_create_file(&(pdev->dev), &dev_attr_nguid);
> +	device_create_file(&(pdev->dev), &dev_attr_serial);
> +	device_create_file(&(pdev->dev), &dev_attr_unit);

Why not use an attribute array?  Makes for proper error handling if one
of those calls does not work...

> +	/*
> +	 * We used to cleanup here, with pci_release_regions, etc. but that
> +	 * can cause other problems if we want to run diags, etc., so instead
> +	 * defer that until driver unload.
> +	 */

So memory leaks are acceptable?

> +fail:	/* after we've done at least some of the pci setup */
> +	if (ret == -EPERM) /* disabled device, don't want module load error;
> +		* just want to carry status through to this point */
> +		ret = 0;

Module load error does not happen no matter what kind of return value
you send back from this function.  So the comment is wrong, and the fact
that you failed initializing the device is also wrong, please don't do
this.

thanks,

greg k-h
