Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264134AbUFBU7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbUFBU7A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 16:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264132AbUFBU7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 16:59:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62390 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264134AbUFBU4r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 16:56:47 -0400
Message-ID: <40BE3F00.4090408@pobox.com>
Date: Wed, 02 Jun 2004 16:56:32 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: PATCH: Submission of via "velocity(tm)" series adapter driver
References: <20040602201315.GA10339@devserv.devel.redhat.com>
In-Reply-To: <20040602201315.GA10339@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> This driver now seems to be solid. It would benefit from performance work
> such as NAPI and scatter gather but those aren't critical to it being useful
> at all.

Thanks a bunch for doing this.  For the audience to know, I was sent 
this driver a while ago and never had time to clean it up.

As an aside, I am tempted to put together a "drivers/patches that need 
cleaning up" tarball, since there is other junk lurking about.



> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.6/drivers/net/Kconfig linux-2.6.6/drivers/net/Kconfig
> --- linux.vanilla-2.6.6/drivers/net/Kconfig	2004-05-10 03:33:13.000000000 +0100
> +++ linux-2.6.6/drivers/net/Kconfig	2004-05-25 11:01:44.000000000 +0100
> @@ -1712,6 +1712,17 @@
>  
>  	  If unsure, say Y.
>  
> +config VIA_VELOCITY
> +	tristate "VIA Velocity support"
> +	depends on NET_PCI && PCI
> +	select CRC32
> +	select MII
> +	help
> +	  If you have a VIA "Velocity" based network card say Y here.
> +
> +	  To compile this driver as a module, choose M here. The module
> +	  will be called via-velocity.

might help to mention 'gigabit'


>  config LAN_SAA9730
>  	bool "Philips SAA9730 Ethernet support (EXPERIMENTAL)"
>  	depends on NET_PCI && EXPERIMENTAL && MIPS
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.6/drivers/net/Makefile linux-2.6.6/drivers/net/Makefile
> --- linux.vanilla-2.6.6/drivers/net/Makefile	2004-05-10 03:32:26.000000000 +0100
> +++ linux-2.6.6/drivers/net/Makefile	2004-05-25 11:01:59.000000000 +0100
> @@ -54,6 +54,7 @@
>  obj-$(CONFIG_SK98LIN) += sk98lin/
>  obj-$(CONFIG_SKFP) += skfp/
>  obj-$(CONFIG_VIA_RHINE) += via-rhine.o
> +obj-$(CONFIG_VIA_VELOCITY) += via-velocity.o
>  obj-$(CONFIG_ADAPTEC_STARFIRE) += starfire.o
>  
>  #
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.6/drivers/net/via-velocity.c linux-2.6.6/drivers/net/via-velocity.c
> --- linux.vanilla-2.6.6/drivers/net/via-velocity.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.6/drivers/net/via-velocity.c	2004-06-02 20:50:37.001244664 +0100
> @@ -0,0 +1,3266 @@
> +/*
> + * This code is derived from the VIA reference driver (copyright message
> + * below) provided to Red Hat by VIA Networking Technologies, Inc. for
> + * addition to the Linux kernel.
> + *
> + * The code has been merged into one source file, cleaned up to follow
> + * Linux coding style,  ported to the Linux 2.6 kernel tree and cleaned
> + * for 64bit hardware platforms.
> + *
> + * TODO
> + *	Big-endian support
> + *	rx_copybreak/alignment
> + *	Scatter gather
> + *	More testing

I would prefer not to merge to mainline until big endian is working... 
certainly it can still receive wide testing in Andrew's -mm tree.


> + * The changes are (c) Copyright 2004, Red Hat Inc. <alan@redhat.com>
> + * Additional fixes and clean up: Francois Romieu
> + *
> + * This source has not been verified for use in safety critical systems.
> + *
> + * Please direct queries about the revamped driver to the linux-kernel
> + * list not VIA.
> + *
> + * Original code:
> + *
> + * Copyright (c) 1996, 2003 VIA Networking Technologies, Inc.
> + * All rights reserved.
> + *
> + * This software may be redistributed and/or modified under
> + * the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or
> + * any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> + * or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
> + * for more details.
> + *
> + * Author: Chuang Liang-Shing, AJ Jiang
> + *
> + * Date: Jan 24, 2003
> + *
> + * MODULE_LICENSE("GPL");
> + *
> + */
> +
> +
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/config.h>
> +#include <linux/init.h>
> +#include <linux/mm.h>
> +#include <linux/errno.h>
> +#include <linux/ioport.h>
> +#include <linux/pci.h>
> +#include <linux/kernel.h>
> +#include <linux/netdevice.h>
> +#include <linux/etherdevice.h>
> +#include <linux/skbuff.h>
> +#include <linux/delay.h>
> +#include <linux/timer.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/version.h>
> +#include <linux/string.h>
> +#include <linux/wait.h>
> +#include <asm/io.h>
> +#include <linux/if.h>
> +#include <linux/config.h>
> +#include <asm/uaccess.h>
> +#include <linux/proc_fs.h>
> +#include <linux/inetdevice.h>
> +#include <linux/reboot.h>
> +#include <linux/ethtool.h>
> +#include <linux/mii.h>
> +#include <linux/in.h>
> +#include <linux/if_arp.h>
> +#include <linux/ip.h>
> +#include <linux/tcp.h>
> +#include <linux/udp.h>
> +
> +#include "via-velocity.h"
> +
> +
> +static int velocity_nics = 0;
> +static int msglevel = MSG_LEVEL_INFO;
> +
> +
> +static int velocity_mii_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd);
> +static struct ethtool_ops velocity_ethtool_ops;
> +
> +/*
> +    Define module options
> +*/
> +
> +MODULE_AUTHOR("VIA Networking Technologies, Inc.");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("VIA Networking Velocity Family Gigabit Ethernet Adapter Driver");
> +
> +#define VELOCITY_PARAM(N,D) \
> +        static const int N[MAX_UNITS]=OPTION_DEFAULT;\
> +        MODULE_PARM(N, "1-" __MODULE_STRING(MAX_UNITS) "i");\
> +        MODULE_PARM_DESC(N, D);

new drivers should use type-safe module_param()


> +#define RX_DESC_MIN     64
> +#define RX_DESC_MAX     255
> +#define RX_DESC_DEF     64
> +VELOCITY_PARAM(RxDescriptors, "Number of receive descriptors");
> +
> +#define TX_DESC_MIN     16
> +#define TX_DESC_MAX     256
> +#define TX_DESC_DEF     64
> +VELOCITY_PARAM(TxDescriptors, "Number of transmit descriptors");
> +
> +#define VLAN_ID_MIN     0
> +#define VLAN_ID_MAX     4095
> +#define VLAN_ID_DEF     0
> +/* VID_setting[] is used for setting the VID of NIC.
> +   0: default VID.
> +   1-4094: other VIDs.
> +*/
> +VELOCITY_PARAM(VID_setting, "802.1Q VLAN ID");
> +
> +#define RX_THRESH_MIN   0
> +#define RX_THRESH_MAX   3
> +#define RX_THRESH_DEF   0
> +/* rx_thresh[] is used for controlling the receive fifo threshold.
> +   0: indicate the rxfifo threshold is 128 bytes.
> +   1: indicate the rxfifo threshold is 512 bytes.
> +   2: indicate the rxfifo threshold is 1024 bytes.
> +   3: indicate the rxfifo threshold is store & forward.
> +*/
> +VELOCITY_PARAM(rx_thresh, "Receive fifo threshold");
> +
> +#define DMA_LENGTH_MIN  0
> +#define DMA_LENGTH_MAX  7
> +#define DMA_LENGTH_DEF  0
> +
> +/* DMA_length[] is used for controlling the DMA length
> +   0: 8 DWORDs
> +   1: 16 DWORDs
> +   2: 32 DWORDs
> +   3: 64 DWORDs
> +   4: 128 DWORDs
> +   5: 256 DWORDs
> +   6: SF(flush till emply)
> +   7: SF(flush till emply)
> +*/
> +VELOCITY_PARAM(DMA_length, "DMA length");
> +
> +#define TAGGING_DEF     0
> +/* enable_tagging[] is used for enabling 802.1Q VID tagging.
> +   0: disable VID seeting(default).
> +   1: enable VID setting.
> +*/
> +VELOCITY_PARAM(enable_tagging, "Enable 802.1Q tagging");
> +
> +#define IP_ALIG_DEF     0
> +/* IP_byte_align[] is used for IP header DWORD byte aligned
> +   0: indicate the IP header won't be DWORD byte aligned.(Default) .
> +   1: indicate the IP header will be DWORD byte aligned.
> +      In some enviroment, the IP header should be DWORD byte aligned,
> +      or the packet will be droped when we receive it. (eg: IPVS)
> +*/
> +VELOCITY_PARAM(IP_byte_align, "Enable IP header dword aligned");
> +
> +#define TX_CSUM_DEF     1
> +/* txcsum_offload[] is used for setting the checksum offload ability of NIC.
> +   (We only support RX checksum offload now)
> +   0: disable csum_offload[checksum offload
> +   1: enable checksum offload. (Default)
> +*/
> +VELOCITY_PARAM(txcsum_offload, "Enable transmit packet checksum offload");
> +
> +#define FLOW_CNTL_DEF   1
> +#define FLOW_CNTL_MIN   1
> +#define FLOW_CNTL_MAX   5
> +
> +/* flow_control[] is used for setting the flow control ability of NIC.
> +   1: hardware deafult - AUTO (default). Use Hardware default value in ANAR.
> +   2: enable TX flow control.
> +   3: enable RX flow control.
> +   4: enable RX/TX flow control.
> +   5: disable
> +*/
> +VELOCITY_PARAM(flow_control, "Enable flow control ability");
> +
> +#define MED_LNK_DEF 0
> +#define MED_LNK_MIN 0
> +#define MED_LNK_MAX 4
> +/* speed_duplex[] is used for setting the speed and duplex mode of NIC.
> +   0: indicate autonegotiation for both speed and duplex mode
> +   1: indicate 100Mbps half duplex mode
> +   2: indicate 100Mbps full duplex mode
> +   3: indicate 10Mbps half duplex mode
> +   4: indicate 10Mbps full duplex mode
> +
> +   Note:
> +        if EEPROM have been set to the force mode, this option is ignored
> +            by driver.
> +*/
> +VELOCITY_PARAM(speed_duplex, "Setting the speed and duplex mode");
> +
> +#define VAL_PKT_LEN_DEF     0
> +/* ValPktLen[] is used for setting the checksum offload ability of NIC.
> +   0: Receive frame with invalid layer 2 length (Default)
> +   1: Drop frame with invalid layer 2 length
> +*/
> +VELOCITY_PARAM(ValPktLen, "Receiving or Drop invalid 802.3 frame");
> +
> +#define WOL_OPT_DEF     0
> +#define WOL_OPT_MIN     0
> +#define WOL_OPT_MAX     7
> +/* wol_opts[] is used for controlling wake on lan behavior.
> +   0: Wake up if recevied a magic packet. (Default)
> +   1: Wake up if link status is on/off.
> +   2: Wake up if recevied an arp packet.
> +   4: Wake up if recevied any unicast packet.
> +   Those value can be sumed up to support more than one option.
> +*/
> +VELOCITY_PARAM(wol_opts, "Wake On Lan options");
> +
> +#define INT_WORKS_DEF   20
> +#define INT_WORKS_MIN   10
> +#define INT_WORKS_MAX   64
> +
> +VELOCITY_PARAM(int_works, "Number of packets per interrupt services");
> +
> +static int velocity_found1(struct pci_dev *pdev, const struct pci_device_id *ent);
> +static void velocity_init_info(struct pci_dev *pdev, struct velocity_info *vptr, struct velocity_info_tbl *info);
> +static int velocity_get_pci_info(struct velocity_info *, struct pci_dev *pdev);
> +static void velocity_print_info(struct velocity_info *vptr);
> +static int velocity_open(struct net_device *dev);
> +static int velocity_change_mtu(struct net_device *dev, int mtu);
> +static int velocity_xmit(struct sk_buff *skb, struct net_device *dev);
> +static int velocity_intr(int irq, void *dev_instance, struct pt_regs *regs);
> +static void velocity_set_multi(struct net_device *dev);
> +static struct net_device_stats *velocity_get_stats(struct net_device *dev);
> +static int velocity_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
> +static int velocity_close(struct net_device *dev);
> +static int velocity_rx_srv(struct velocity_info *vptr, int status);
> +static int velocity_receive_frame(struct velocity_info *, int idx);
> +static int velocity_alloc_rx_buf(struct velocity_info *, int idx);
> +static void velocity_init_registers(struct velocity_info *vptr, enum velocity_init_type type);
> +static void velocity_free_rd_ring(struct velocity_info *vptr);
> +static void velocity_free_tx_buf(struct velocity_info *vptr, struct velocity_td_info *);
> +static int velocity_soft_reset(struct velocity_info *vptr);
> +static void mii_init(struct velocity_info *vptr, u32 mii_status);
> +static u32 velocity_get_opt_media_mode(struct velocity_info *vptr);
> +static void velocity_print_link_status(struct velocity_info *vptr);
> +static void safe_disable_mii_autopoll(struct mac_regs * regs);
> +static void velocity_shutdown(struct velocity_info *vptr);
> +static void enable_flow_control_ability(struct velocity_info *vptr);
> +static void enable_mii_autopoll(struct mac_regs * regs);
> +static int velocity_mii_read(struct mac_regs *, u8 byIdx, u16 * pdata);
> +static int velocity_mii_write(struct mac_regs *, u8 byMiiAddr, u16 data);
> +static int velocity_set_wol(struct velocity_info *vptr);
> +static void velocity_save_context(struct velocity_info *vptr, struct velocity_context *context);
> +static void velocity_restore_context(struct velocity_info *vptr, struct velocity_context *context);
> +static u32 mii_check_media_mode(struct mac_regs * regs);
> +static u32 check_connection_type(struct mac_regs * regs);
> +static void velocity_init_cam_filter(struct velocity_info *vptr);
> +static int velocity_set_media_mode(struct velocity_info *vptr, u32 mii_status);
> +
> +#ifdef CONFIG_PM
> +static int velocity_suspend(struct pci_dev *pdev, u32 state);
> +static int velocity_resume(struct pci_dev *pdev);
> +
> +static int velocity_netdev_event(struct notifier_block *nb, unsigned long notification, void *ptr);
> +
> +static struct notifier_block velocity_inetaddr_notifier = {
> +      notifier_call:velocity_netdev_event,
> +};
> +
> +#endif				/* CONFIG_PM */
> +
> +/*
> + *	Internal board variants. At the moment we have only one
> + */
> +
> +static struct velocity_info_tbl chip_info_table[] = {
> +	{CHIP_TYPE_VT6110, "VIA Networking Velocity Family Gigabit Ethernet Adapter", 256, 1, 0x00FFFFFFUL},
> +	{0, NULL}
> +};

probably can be killed...  may not be worth the effort though.


> +/*
> + *	Describe the PCI device identifiers that we support in this
> + *	device driver. Used for hotplug autoloading.
> + */
> +
> +static struct pci_device_id velocity_id_table[] __devinitdata = {
> +	{0x1106, 0x3119, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (unsigned long) &chip_info_table[0]},
> +	{0,}
> +};
> +
> +MODULE_DEVICE_TABLE(pci, velocity_id_table);
> +
> +/**
> + *	get_chip_name	- 	identifier to name
> + *	@id: chip identifier
> + *
> + *	Given a chip identifier return a suitable description. Returns
> + *	a pointer a static string valid while the driver is loaded.
> + */
> +
> +static char __devinit *get_chip_name(enum chip_type chip_id)
> +{
> +	int i;
> +	for (i = 0; chip_info_table[i].name != NULL; i++)
> +		if (chip_info_table[i].chip_id == chip_id)
> +			break;
> +	return chip_info_table[i].name;
> +}

should just index the table, no need for this


> +/**
> + *	velocity_remove1	-	device unplug
> + *	@pdev: PCI device being removed
> + *
> + *	Device unload callback. Called on an unplug or on module
> + *	unload for each active device that is present. Disconnects
> + *	the device from the network layer and frees all the resources
> + */
> +
> +static void __devexit velocity_remove1(struct pci_dev *pdev)
> +{
> +	struct net_device *dev = pci_get_drvdata(pdev);
> +	struct velocity_info *vptr = dev->priv;
> +
> +	unregister_netdev(dev);
> +	iounmap(vptr->mac_regs);
> +	pci_release_regions(pdev);
> +	pci_disable_device(pdev);
> +	pci_set_drvdata(pdev, NULL);
> +	free_netdev(dev);
> +}
> +
> +/**
> + *	velocity_set_int_opt	-	parser for integer options
> + *	@opt: pointer to option value
> + *	@val: value the user requested (or -1 for default)
> + *	@min: lowest value allowed
> + *	@max: highest value allowed
> + *	@def: default value
> + *	@name: property name
> + *	@dev: device name
> + *
> + *	Set an integer property in the module options. This function does
> + *	all the verification and checking as well as reporting so that
> + *	we don't duplicate code for each option.
> + */
> +
> +static void __devinit velocity_set_int_opt(int *opt, int val, int min, int max, int def, char *name, char *devname)
> +{
> +	if (val == -1)
> +		*opt = def;
> +	else if (val < min || val > max) {
> +		VELOCITY_PRT(MSG_LEVEL_INFO, KERN_NOTICE "%s: the value of parameter %s is invalid, the valid range is (%d-%d)\n",
> +					devname, name, min, max);
> +		*opt = def;
> +	} else {
> +		VELOCITY_PRT(MSG_LEVEL_INFO, KERN_INFO "%s: set value of parameter %s to %d\n",
> +					devname, name, val);
> +		*opt = val;
> +	}
> +}
> +
> +/**
> + *	velocity_set_bool_opt	-	parser for boolean options
> + *	@opt: pointer to option value
> + *	@val: value the user requested (or -1 for default)
> + *	@def: default value (yes/no)
> + *	@flag: numeric value to set for true.
> + *	@name: property name
> + *	@dev: device name
> + *
> + *	Set a boolean property in the module options. This function does
> + *	all the verification and checking as well as reporting so that
> + *	we don't duplicate code for each option.
> + */
> +
> +static void __devinit velocity_set_bool_opt(u32 * opt, int val, int def, u32 flag, char *name, char *devname)
> +{
> +	(*opt) &= (~flag);
> +	if (val == -1)
> +		*opt |= (def ? flag : 0);
> +	else if (val < 0 || val > 1) {
> +		printk(KERN_NOTICE "%s: the value of parameter %s is invalid, the valid range is (0-1)\n", 
> +			devname, name);
> +		*opt |= (def ? flag : 0);
> +	} else {
> +		printk(KERN_INFO "%s: set parameter %s to %s\n", 
> +			devname, name, val ? "TRUE" : "FALSE");
> +		*opt |= (val ? flag : 0);
> +	}
> +}
> +
> +/**
> + *	velocity_get_options	-	set options on device
> + *	@opts: option structure for the device
> + *	@index: index of option to use in module options array
> + *	@devname: device name
> + *
> + *	Turn the module and command options into a single structure
> + *	for the current device
> + */
> +
> +static void __devinit velocity_get_options(struct velocity_opt *opts, int index, char *devname)
> +{
> +
> +	velocity_set_int_opt(&opts->rx_thresh, rx_thresh[index], RX_THRESH_MIN, RX_THRESH_MAX, RX_THRESH_DEF, "rx_thresh", devname);
> +	velocity_set_int_opt(&opts->DMA_length, DMA_length[index], DMA_LENGTH_MIN, DMA_LENGTH_MAX, DMA_LENGTH_DEF, "DMA_length", devname);
> +	velocity_set_int_opt(&opts->numrx, RxDescriptors[index], RX_DESC_MIN, RX_DESC_MAX, RX_DESC_DEF, "RxDescriptors", devname);
> +	velocity_set_int_opt(&opts->numtx, TxDescriptors[index], TX_DESC_MIN, TX_DESC_MAX, TX_DESC_DEF, "TxDescriptors", devname);
> +	velocity_set_int_opt(&opts->vid, VID_setting[index], VLAN_ID_MIN, VLAN_ID_MAX, VLAN_ID_DEF, "VID_setting", devname);
> +	velocity_set_bool_opt(&opts->flags, enable_tagging[index], TAGGING_DEF, VELOCITY_FLAGS_TAGGING, "enable_tagging", devname);
> +	velocity_set_bool_opt(&opts->flags, txcsum_offload[index], TX_CSUM_DEF, VELOCITY_FLAGS_TX_CSUM, "txcsum_offload", devname);
> +	velocity_set_int_opt(&opts->flow_cntl, flow_control[index], FLOW_CNTL_MIN, FLOW_CNTL_MAX, FLOW_CNTL_DEF, "flow_control", devname);
> +	velocity_set_bool_opt(&opts->flags, IP_byte_align[index], IP_ALIG_DEF, VELOCITY_FLAGS_IP_ALIGN, "IP_byte_align", devname);
> +	velocity_set_bool_opt(&opts->flags, ValPktLen[index], VAL_PKT_LEN_DEF, VELOCITY_FLAGS_VAL_PKT_LEN, "ValPktLen", devname);
> +	velocity_set_int_opt((int *) &opts->spd_dpx, speed_duplex[index], MED_LNK_MIN, MED_LNK_MAX, MED_LNK_DEF, "Media link mode", devname);
> +	velocity_set_int_opt((int *) &opts->wol_opts, wol_opts[index], WOL_OPT_MIN, WOL_OPT_MAX, WOL_OPT_DEF, "Wake On Lan options", devname);
> +	velocity_set_int_opt((int *) &opts->int_works, int_works[index], INT_WORKS_MIN, INT_WORKS_MAX, INT_WORKS_DEF, "Interrupt service works", devname);
> +	opts->numrx = (opts->numrx & ~3);
> +}
> +
> +/**
> + *	velocity_init_cam_filter	-	initialise CAM
> + *	@vptr: velocity to program
> + *
> + *	Initialize the content addressable memory used for filters. Load
> + *	appropriately according to the presence of VLAN
> + */
> +
> +static void velocity_init_cam_filter(struct velocity_info *vptr)
> +{
> +	struct mac_regs * regs = vptr->mac_regs;
> +
> +	/* T urn on MCFG_PQEN, turn off MCFG_RTGOPT */
> +	WORD_REG_BITS_SET(MCFG_PQEN, MCFG_RTGOPT, &regs->MCFG);
> +	WORD_REG_BITS_ON(MCFG_VIDFR, &regs->MCFG);
> +
> +	/* Disable all CAMs */
> +	memset(vptr->vCAMmask, 0, sizeof(u8) * 8);
> +	memset(vptr->mCAMmask, 0, sizeof(u8) * 8);
> +	mac_set_cam_mask(regs, vptr->vCAMmask, VELOCITY_VLAN_ID_CAM);
> +	mac_set_cam_mask(regs, vptr->mCAMmask, VELOCITY_MULTICAST_CAM);
> +
> +	/* Enable first VCAM */
> +	if (vptr->flags & VELOCITY_FLAGS_TAGGING) {
> +		/* If Tagging option is enabled and VLAN ID is not zero, then
> +		   turn on MCFG_RTGOPT also */
> +		if (vptr->options.vid != 0)
> +			WORD_REG_BITS_ON(MCFG_RTGOPT, &regs->MCFG);
> +
> +		mac_set_cam(regs, 0, (u8 *) & (vptr->options.vid), VELOCITY_VLAN_ID_CAM);
> +		vptr->vCAMmask[0] |= 1;
> +		mac_set_cam_mask(regs, vptr->vCAMmask, VELOCITY_VLAN_ID_CAM);
> +	} else {
> +		u16 temp = 0;
> +		mac_set_cam(regs, 0, (u8 *) &temp, VELOCITY_VLAN_ID_CAM);
> +		temp = 1;
> +		mac_set_cam_mask(regs, (u8 *) &temp, VELOCITY_VLAN_ID_CAM);
> +	}
> +}
> +
> +/**
> + *	velocity_rx_reset	-	handle a receive reset
> + *	@vptr: velocity we are resetting
> + *
> + *	Reset the ownership and status for the receive ring side.
> + *	Hand all the receive queue to the NIC.
> + */
> +
> +static void velocity_rx_reset(struct velocity_info *vptr)
> +{
> +
> +	struct mac_regs * regs = vptr->mac_regs;
> +	int i;
> +
> +	vptr->rd_used = vptr->rd_curr = 0;
> +
> +	/*
> +	 *	Init state, all RD entries belong to the NIC
> +	 */
> +	for (i = 0; i < vptr->options.numrx; ++i)
> +		vptr->rd_ring[i].rdesc0.owner = cpu_to_le32(OWNED_BY_NIC);
> +
> +	writew(vptr->options.numrx, &regs->RBRDU);
> +	writel(vptr->rd_pool_dma, &regs->RDBaseLo);
> +	writew(0, &regs->RDIdx);
> +	writew(vptr->options.numrx - 1, &regs->RDCSize);
> +}
> +
> +/**
> + *	velocity_init_registers	-	initialise MAC registers
> + *	@vptr: velocity to init
> + *	@type: type of initialisation (hot or cold)
> + *
> + *	Initialise the MAC on a reset or on first set up on the
> + *	hardware.
> + */
> +
> +static void velocity_init_registers(struct velocity_info *vptr, 
> +				    enum velocity_init_type type)
> +{
> +	struct mac_regs * regs = vptr->mac_regs;
> +	int i, mii_status;
> +
> +	mac_wol_reset(regs);
> +
> +	switch (type) {
> +	case VELOCITY_INIT_RESET:
> +	case VELOCITY_INIT_WOL:
> +
> +		netif_stop_queue(vptr->dev);
> +
> +		/*
> +		 *	Reset RX to prevent RX pointer not on the 4X location
> +		 */
> +		velocity_rx_reset(vptr);
> +		mac_rx_queue_run(regs);
> +		mac_rx_queue_wake(regs);
> +
> +		mii_status = velocity_get_opt_media_mode(vptr);
> +		if (velocity_set_media_mode(vptr, mii_status) != VELOCITY_LINK_CHANGE) {
> +			velocity_print_link_status(vptr);
> +			if (!(vptr->mii_status & VELOCITY_LINK_FAIL))
> +				netif_wake_queue(vptr->dev);
> +		}
> +
> +		enable_flow_control_ability(vptr);
> +
> +		mac_clear_isr(regs);
> +		writel(CR0_STOP, &regs->CR0Clr);
> +		writel((CR0_DPOLL | CR0_TXON | CR0_RXON | CR0_STRT), 
> +							&regs->CR0Set);
> +
> +		break;
> +
> +	case VELOCITY_INIT_COLD:
> +	default:
> +		/*
> +		 *	Do reset
> +		 */
> +		velocity_soft_reset(vptr);
> +		mdelay(5);
> +
> +		mac_eeprom_reload(regs);
> +		for (i = 0; i < 6; i++) {
> +			writeb(vptr->dev->dev_addr[i], &(regs->PAR[i]));
> +		}
> +		/*
> +		 *	clear Pre_ACPI bit.
> +		 */
> +		BYTE_REG_BITS_OFF(CFGA_PACPI, &(regs->CFGA));
> +		mac_set_rx_thresh(regs, vptr->options.rx_thresh);
> +		mac_set_dma_length(regs, vptr->options.DMA_length);
> +
> +		writeb(WOLCFG_SAM | WOLCFG_SAB, &regs->WOLCFGSet);
> +		/*
> +		 *	Bback off algorithm use original IEEE standard
> +		 */
> +		BYTE_REG_BITS_SET(CFGB_OFSET, (CFGB_CRANDOM | CFGB_CAP | CFGB_MBA | CFGB_BAKOPT), &regs->CFGB);
> +
> +		/*
> +		 *	Set packet filter: Receive directed and broadcast address
> +		 */
> +		velocity_set_multi(vptr->dev);
> +
> +		/*
> +		 *	Enable MII auto-polling
> +		 */
> +		enable_mii_autopoll(regs);
> +
> +		vptr->int_mask = INT_MASK_DEF;
> +
> +		writel(cpu_to_le32(vptr->rd_pool_dma), &regs->RDBaseLo);
> +		writew(vptr->options.numrx - 1, &regs->RDCSize);
> +		mac_rx_queue_run(regs);
> +		mac_rx_queue_wake(regs);
> +
> +		writew(vptr->options.numtx - 1, &regs->TDCSize);
> +
> +		for (i = 0; i < vptr->num_txq; i++) {
> +			writel(cpu_to_le32(vptr->td_pool_dma[i]), &(regs->TDBaseLo[i]));
> +			mac_tx_queue_run(regs, i);
> +		}
> +
> +		velocity_init_cam_filter(vptr);
> +
> +		init_flow_control_register(vptr);
> +
> +		writel(CR0_STOP, &regs->CR0Clr);
> +		writel((CR0_DPOLL | CR0_TXON | CR0_RXON | CR0_STRT), &regs->CR0Set);
> +
> +		mii_status = velocity_get_opt_media_mode(vptr);
> +		netif_stop_queue(vptr->dev);
> +		mac_clear_isr(regs);
> +
> +		mii_init(vptr, mii_status);
> +
> +		if (velocity_set_media_mode(vptr, mii_status) != VELOCITY_LINK_CHANGE) {
> +			velocity_print_link_status(vptr);
> +			if (!(vptr->mii_status & VELOCITY_LINK_FAIL))
> +				netif_wake_queue(vptr->dev);
> +		}
> +
> +		enable_flow_control_ability(vptr);
> +		mac_hw_mibs_init(regs);
> +		mac_write_int_mask(vptr->int_mask, regs);
> +		mac_clear_isr(regs);
> +
> +	}
> +}
> +
> +/**
> + *	velocity_soft_reset	-	soft reset
> + *	@vptr: velocity to reset
> + *
> + *	Kick off a soft reset of the velocity adapter and then poll
> + *	until the reset sequence has completed before returning.
> + */
> +
> +static int velocity_soft_reset(struct velocity_info *vptr)
> +{
> +	struct mac_regs * regs = vptr->mac_regs;
> +	int i = 0;
> +
> +	writel(CR0_SFRST, &regs->CR0Set);
> +
> +	for (i = 0; i < W_MAX_TIMEOUT; i++) {
> +		udelay(5);
> +		if (!DWORD_REG_BITS_IS_ON(CR0_SFRST, &regs->CR0Set))
> +			break;
> +	}
> +
> +	if (i == W_MAX_TIMEOUT) {
> +		writel(CR0_FORSRST, &regs->CR0Set);
> +		/* FIXME: PCI POSTING */
> +		/* delay 2ms */
> +		mdelay(2);
> +	}
> +	return 0;
> +}
> +
> +/**
> + *	velocity_found1		-	set up discovered velocity card
> + *	@pdev: PCI device
> + *	@ent: PCI device table entry that matched
> + *
> + *	Configure a discovered adapter from scratch. Return a negative
> + *	errno error code on failure paths.
> + */
> +
> +static int __devinit velocity_found1(struct pci_dev *pdev, const struct pci_device_id *ent)
> +{
> +	static int first = 1;
> +	struct net_device *dev;
> +	int i;
> +	struct velocity_info_tbl *info = (struct velocity_info_tbl *) ent->driver_data;
> +	struct velocity_info *vptr;
> +	struct mac_regs * regs;
> +	int ret = -ENOMEM;
> +
> +	if (velocity_nics++ >= MAX_UNITS) {
> +		printk(KERN_NOTICE VELOCITY_NAME ": already found %d NICs.\n", 
> +				velocity_nics);
> +		return -ENODEV;
> +	}

no need for this limit


> +	dev = alloc_etherdev(sizeof(struct velocity_info));
> +
> +	if (dev == NULL) {
> +		printk(KERN_ERR VELOCITY_NAME ": allocate net device failed.\n");
> +		goto out;
> +	}
> +	
> +	/* Chain it all together */
> +	
> +	SET_MODULE_OWNER(dev);
> +	SET_NETDEV_DEV(dev, &pdev->dev);
> +	vptr = dev->priv;
> +
> +
> +	if (first) {
> +		printk(KERN_INFO "%s Ver. %s\n", 
> +			VELOCITY_FULL_DRV_NAM, VELOCITY_VERSION);
> +		printk(KERN_INFO "Copyright (c) 2002, 2003 VIA Networking Technologies, Inc.\n");
> +		printk(KERN_INFO "Copyright (c) 2004 Red Hat Inc.\n");
> +		first = 0;
> +	}

move copyright strings up to the top of the file?


> +	velocity_init_info(pdev, vptr, info);
> +
> +	vptr->dev = dev;
> +
> +	dev->priv = vptr;
> +	dev->irq = pdev->irq;
> +
> +	ret = pci_enable_device(pdev);
> +	if (ret < 0) 
> +		goto err_free_dev;
> +
> +	ret = velocity_get_pci_info(vptr, pdev);
> +	if (ret < 0) {
> +		printk(KERN_ERR VELOCITY_NAME ": Failed to find PCI device.\n");
> +		goto err_disable;
> +	}
> +
> +	ret = pci_request_regions(pdev, VELOCITY_NAME);
> +	if (ret < 0) {
> +		printk(KERN_ERR VELOCITY_NAME ": Failed to find PCI device.\n");
> +		goto err_disable;
> +	}
> +
> +	regs = ioremap(vptr->memaddr, vptr->io_size);
> +	if (regs == NULL) {
> +		ret = -EIO;
> +		goto err_release_res;
> +	}
> +
> +	vptr->mac_regs = regs;
> +
> +	mac_wol_reset(regs);
> +
> +	dev->base_addr = vptr->ioaddr;
> +
> +	for (i = 0; i < 6; i++)
> +		dev->dev_addr[i] = readb(&regs->PAR[i]);
> +
> +
> +	velocity_get_options(&vptr->options, velocity_nics - 1, dev->name);
> +
> +	/* 
> +	 *	Mask out the options cannot be set to the chip
> +	 */
> +	 
> +	vptr->options.flags &= info->flags;
> +
> +	/*
> +	 *	Enable the chip specified capbilities
> +	 */
> +	 
> +	vptr->flags = vptr->options.flags | (info->flags & 0xFF000000UL);
> +
> +	vptr->wol_opts = vptr->options.wol_opts;
> +	vptr->flags |= VELOCITY_FLAGS_WOL_ENABLED;
> +
> +	vptr->phy_id = MII_GET_PHY_ID(vptr->mac_regs);
> +
> +	dev->irq = pdev->irq;
> +	dev->open = velocity_open;
> +	dev->hard_start_xmit = velocity_xmit;
> +	dev->stop = velocity_close;
> +	dev->get_stats = velocity_get_stats;
> +	dev->set_multicast_list = velocity_set_multi;
> +	dev->do_ioctl = velocity_ioctl;
> +	dev->ethtool_ops = &velocity_ethtool_ops;
> +	dev->change_mtu = velocity_change_mtu;
> +#ifdef  VELOCITY_ZERO_COPY_SUPPORT
> +	dev->features |= NETIF_F_SG;
> +#endif

> +	if (vptr->flags & VELOCITY_FLAGS_TX_CSUM) {
> +		dev->features |= NETIF_F_HW_CSUM;
> +	}

NETIF_F_SG should not be enabled/disabled independently of the _CSUM 
flag.  confusion results.


> +	ret = register_netdev(dev);
> +	if (ret < 0)
> +		goto err_iounmap;
> +
> +	velocity_print_info(vptr);
> +	pci_set_drvdata(pdev, dev);
> +	
> +	/* and leave the chip powered down */
> +	
> +	pci_set_power_state(pdev, 3);
> +out:
> +	return ret;
> +
> +err_iounmap:
> +	iounmap(regs);
> +err_release_res:
> +	pci_release_regions(pdev);
> +err_disable:
> +	pci_disable_device(pdev);
> +err_free_dev:
> +	free_netdev(dev);
> +	goto out;
> +}
> +
> +/**
> + *	velocity_print_info	-	per driver data
> + *	@vptr: velocity
> + *
> + *	Print per driver data as the kernel driver finds Velocity
> + *	hardware
> + */
> +
> +static void __devinit velocity_print_info(struct velocity_info *vptr)
> +{
> +	struct net_device *dev = vptr->dev;
> +
> +	printk(KERN_INFO "%s: %s\n", dev->name, get_chip_name(vptr->chip_id));
> +	printk(KERN_INFO "%s: Ethernet Address: %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X\n", 
> +		dev->name, 
> +		dev->dev_addr[0], dev->dev_addr[1], dev->dev_addr[2], 
> +		dev->dev_addr[3], dev->dev_addr[4], dev->dev_addr[5]);
> +}
> +
> +/**
> + *	velocity_init_info	-	init private data
> + *	@pdev: PCI device
> + *	@vptr: Velocity info
> + *	@info: Board type
> + *
> + *	Set up the initial velocity_info struct for the device that has been
> + *	discovered.
> + */
> +
> +static void __devinit velocity_init_info(struct pci_dev *pdev, struct velocity_info *vptr, struct velocity_info_tbl *info)
> +{
> +	memset(vptr, 0, sizeof(struct velocity_info));
> +
> +	vptr->pdev = pdev;
> +	vptr->chip_id = info->chip_id;
> +	vptr->io_size = info->io_size;
> +	vptr->num_txq = info->txqueue;
> +	vptr->multicast_limit = MCAM_SIZE;
> +
> +	spin_lock_init(&vptr->lock);
> +	spin_lock_init(&vptr->xmit_lock);
> +}
> +
> +/**
> + *	velocity_get_pci_info	-	retrieve PCI info for device
> + *	@vptr: velocity device
> + *	@pdev: PCI device it matches
> + *
> + *	Retrieve the PCI configuration space data that interests us from
> + *	the kernel PCI layer
> + */
> +
> +static int __devinit velocity_get_pci_info(struct velocity_info *vptr, struct pci_dev *pdev)
> +{
> +
> +	if(pci_read_config_byte(pdev, PCI_REVISION_ID, &vptr->rev_id) < 0)
> +		return -EIO;
> +		
> +	pci_set_master(pdev);
> +
> +	vptr->ioaddr = pci_resource_start(pdev, 0);
> +	vptr->memaddr = pci_resource_start(pdev, 1);
> +	
> +	if(!(pci_resource_flags(pdev, 0) & IORESOURCE_IO))
> +	{
> +		printk(KERN_ERR "%s: region #0 is not an I/O resource, aborting.\n",
> +				pci_name(pdev));
> +		return -EINVAL;
> +	}
> +
> +	if((pci_resource_flags(pdev, 1) & IORESOURCE_IO))
> +	{
> +		printk(KERN_ERR "%s: region #1 is an I/O resource, aborting.\n",
> +				pci_name(pdev));
> +		return -EINVAL;
> +	}
> +
> +	if(pci_resource_len(pdev, 1) < 256)
> +	{
> +		printk(KERN_ERR "%s: region #1 is too small.\n", 
> +				pci_name(pdev));
> +		return -EINVAL;
> +	}
> +	vptr->pdev = pdev;
> +
> +	return 0;
> +}
> +
> +/**
> + *	velocity_init_rings	-	set up DMA rings
> + *	@vptr: Velocity to set up
> + *
> + *	Allocate PCI mapped DMA rings for the receive and transmit layer
> + *	to use.
> + */
> +
> +static int velocity_init_rings(struct velocity_info *vptr)
> +{
> +	int i;
> +	unsigned int psize;
> +	unsigned int tsize;
> +	dma_addr_t pool_dma;
> +	u8 *pool;
> +
> +	/*
> +	 *	Allocate all RD/TD rings a single pool 
> +	 */
> +	 
> +	psize = vptr->options.numrx * sizeof(struct rx_desc) + 
> +		vptr->options.numtx * sizeof(struct tx_desc) * vptr->num_txq;
> +
> +	/*
> +	 * pci_alloc_consistent() fulfills the requirement for 64 bytes
> +	 * alignment
> +	 */
> +	pool = pci_alloc_consistent(vptr->pdev, psize, &pool_dma);
> +
> +	if (pool == NULL) {
> +		printk(KERN_ERR "%s : DMA memory allocation failed.\n", 
> +					vptr->dev->name);
> +		return -ENOMEM;
> +	}
> +
> +	memset(pool, 0, psize);
> +
> +	vptr->rd_ring = (struct rx_desc *) pool;
> +
> +	vptr->rd_pool_dma = pool_dma;
> +
> +	tsize = vptr->options.numtx * PKT_BUF_SZ * vptr->num_txq;
> +	vptr->tx_bufs = pci_alloc_consistent(vptr->pdev, tsize, 
> +						&vptr->tx_bufs_dma);
> +
> +	if (vptr->tx_bufs == NULL) {
> +		printk(KERN_ERR "%s: DMA memory allocation failed.\n", 
> +					vptr->dev->name);
> +		pci_free_consistent(vptr->pdev, psize, pool, pool_dma);
> +		return -ENOMEM;
> +	}
> +
> +	memset(vptr->tx_bufs, 0, vptr->options.numtx * PKT_BUF_SZ * vptr->num_txq);
> +
> +	i = vptr->options.numrx * sizeof(struct rx_desc);
> +	pool += i;
> +	pool_dma += i;
> +	for (i = 0; i < vptr->num_txq; i++) {
> +		int offset = vptr->options.numtx * sizeof(struct tx_desc);
> +
> +		vptr->td_pool_dma[i] = pool_dma;
> +		vptr->td_rings[i] = (struct tx_desc *) pool;
> +		pool += offset;
> +		pool_dma += offset;
> +	}
> +	return 0;
> +}
> +
> +/**
> + *	velocity_free_rings	-	free PCI ring pointers
> + *	@vptr: Velocity to free from
> + *
> + *	Clean up the PCI ring buffers allocated to this velocity.
> + */
> +
> +static void velocity_free_rings(struct velocity_info *vptr)
> +{
> +	int size;
> +
> +	size = vptr->options.numrx * sizeof(struct rx_desc) + 
> +	       vptr->options.numtx * sizeof(struct tx_desc) * vptr->num_txq;
> +
> +	pci_free_consistent(vptr->pdev, size, vptr->rd_ring, vptr->rd_pool_dma);
> +
> +	size = vptr->options.numtx * PKT_BUF_SZ * vptr->num_txq;
> +
> +	pci_free_consistent(vptr->pdev, size, vptr->tx_bufs, vptr->tx_bufs_dma);
> +}
> +
> +/**
> + *	velocity_init_rd_ring	-	set up receive ring
> + *	@vptr: velocity to configure
> + *
> + *	Allocate and set up the receive buffers for each ring slot and
> + *	assign them to the network adapter.
> + */
> +
> +static int velocity_init_rd_ring(struct velocity_info *vptr)
> +{
> +	int i, ret = -ENOMEM;
> +	struct rx_desc *rd;
> +	struct velocity_rd_info *rd_info;
> +	unsigned int rsize = sizeof(struct velocity_rd_info) * 
> +					vptr->options.numrx;
> +
> +	vptr->rd_info = kmalloc(rsize, GFP_KERNEL);
> +	if(vptr->rd_info == NULL)
> +		goto out;
> +	memset(vptr->rd_info, 0, rsize);
> +
> +	/* Init the RD ring entries */
> +	for (i = 0; i < vptr->options.numrx; i++) {
> +		rd = &(vptr->rd_ring[i]);
> +		rd_info = &(vptr->rd_info[i]);
> +
> +		ret = velocity_alloc_rx_buf(vptr, i);
> +		if (ret < 0) {
> +			VELOCITY_PRT(MSG_LEVEL_ERR, KERN_ERR
> +				"%s: failed to allocate RX buffer.\n", 
> +				vptr->dev->name);
> +			velocity_free_rd_ring(vptr);
> +			goto out;
> +		}
> +		rd->rdesc0.owner = OWNED_BY_NIC;
> +	}
> +	vptr->rd_used = vptr->rd_curr = 0;
> +out:
> +	return ret;
> +}
> +
> +/**
> + *	velocity_free_rd_ring	-	set up receive ring
> + *	@vptr: velocity to clean up
> + *
> + *	Free the receive buffers for each ring slot and any
> + *	attached socket buffers that need to go away.
> + */
> +
> +static void velocity_free_rd_ring(struct velocity_info *vptr)
> +{
> +	int i;
> +
> +	if (vptr->rd_info == NULL)
> +		return;
> +
> +	for (i = 0; i < vptr->options.numrx; i++) {
> +		struct velocity_rd_info *rd_info = &(vptr->rd_info[i]);
> +
> +		if (!rd_info->skb_dma)
> +			continue;
> +		pci_unmap_single(vptr->pdev, rd_info->skb_dma, vptr->rx_buf_sz,
> +				 PCI_DMA_FROMDEVICE);
> +		rd_info->skb_dma = (dma_addr_t) NULL;
> +
> +		dev_kfree_skb(rd_info->skb);
> +		rd_info->skb = NULL;
> +	}
> +
> +	kfree(vptr->rd_info);
> +	vptr->rd_info = NULL;
> +}
> +
> +/**
> + *	velocity_init_td_ring	-	set up transmit ring
> + *	@vptr:	velocity
> + *
> + *	Set up the transmit ring and chain the ring pointers together.
> + *	Returns zero on success or a negative posix errno code for
> + *	failure.
> + */
> + 
> +static int velocity_init_td_ring(struct velocity_info *vptr)
> +{
> +	int i, j;
> +	dma_addr_t curr;
> +	struct tx_desc *td;
> +	struct velocity_td_info *td_info;
> +	unsigned int tsize = sizeof(struct velocity_td_info) * 
> +					vptr->options.numtx;
> +
> +	/* Init the TD ring entries */
> +	for (j = 0; j < vptr->num_txq; j++) {
> +		curr = vptr->td_pool_dma[j];
> +
> +		vptr->td_infos[j] = kmalloc(tsize, GFP_KERNEL);
> +		if(vptr->td_infos[j] == NULL)
> +		{
> +			while(--j >= 0)
> +				kfree(vptr->td_infos[j]);
> +			return -ENOMEM;
> +		}
> +		memset(vptr->td_infos[j], 0, tsize);
> +
> +		for (i = 0; i < vptr->options.numtx; i++, curr += sizeof(struct tx_desc)) {
> +			td = &(vptr->td_rings[j][i]);
> +			td_info = &(vptr->td_infos[j][i]);
> +			td_info->buf = vptr->tx_bufs + (i + j) * PKT_BUF_SZ;
> +			td_info->buf_dma = vptr->tx_bufs_dma + (i + j) * PKT_BUF_SZ;
> +		}
> +		vptr->td_tail[j] = vptr->td_curr[j] = vptr->td_used[j] = 0;
> +	}
> +	return 0;
> +}
> +
> +/*
> + *	FIXME: could we merge this with velocity_free_tx_buf ?
> + */
> +
> +static void velocity_free_td_ring_entry(struct velocity_info *vptr,
> +							 int q, int n)
> +{
> +	struct velocity_td_info * td_info = &(vptr->td_infos[q][n]);
> +	int i;
> +	
> +	if (td_info == NULL)
> +		return;
> +		
> +	if (td_info->skb) {
> +		for (i = 0; i < td_info->nskb_dma; i++)
> +		{
> +			if (td_info->skb_dma[i]) {
> +				pci_unmap_single(vptr->pdev, td_info->skb_dma[i], 
> +					td_info->skb->len, PCI_DMA_TODEVICE);
> +				td_info->skb_dma[i] = (dma_addr_t) NULL;
> +			}
> +		}
> +		dev_kfree_skb(td_info->skb);
> +		td_info->skb = NULL;
> +	}
> +}
> +
> +/**
> + *	velocity_free_td_ring	-	free td ring
> + *	@vptr: velocity
> + *
> + *	Free up the transmit ring for this particular velocity adapter.
> + *	We free the ring contents but not the ring itself.
> + */
> + 
> +static void velocity_free_td_ring(struct velocity_info *vptr)
> +{
> +	int i, j;
> +
> +	for (j = 0; j < vptr->num_txq; j++) {
> +		if (vptr->td_infos[j] == NULL)
> +			continue;
> +		for (i = 0; i < vptr->options.numtx; i++) {
> +			velocity_free_td_ring_entry(vptr, j, i);
> +
> +		}
> +		if (vptr->td_infos[j]) {
> +			kfree(vptr->td_infos[j]);
> +			vptr->td_infos[j] = NULL;
> +		}
> +	}
> +}
> +
> +/**
> + *	velocity_rx_srv		-	service RX interrupt
> + *	@vptr: velocity
> + *	@status: adapter status (unused)
> + *
> + *	Walk the receive ring of the velocity adapter and remove
> + *	any received packets from the receive queue. Hand the ring
> + *	slots back to the adapter for reuse.
> + */
> + 
> +static int velocity_rx_srv(struct velocity_info *vptr, int status)
> +{
> +	struct rx_desc *rd;
> +	struct net_device_stats *stats = &vptr->stats;
> +	struct mac_regs * regs = vptr->mac_regs;
> +	int rd_curr = vptr->rd_curr;
> +	int works = 0;
> +
> +	while (1) {
> +
> +		rd = &(vptr->rd_ring[rd_curr]);
> +
> +		if ((vptr->rd_info[rd_curr]).skb == NULL) {
> +			if (velocity_alloc_rx_buf(vptr, rd_curr) < 0)
> +				break;
> +		}
> +
> +		if (works++ > 15)
> +			break;
> +
> +		if (rd->rdesc0.owner == OWNED_BY_NIC)
> +			break;
> +
> +		/*
> +		 *	Don't drop CE or RL error frame although RXOK is off
> +		 *	FIXME: need to handle copybreak
> +		 */
> +		if ((rd->rdesc0.RSR & RSR_RXOK) || (!(rd->rdesc0.RSR & RSR_RXOK) && (rd->rdesc0.RSR & (RSR_CE | RSR_RL)))) {
> +			if (velocity_receive_frame(vptr, rd_curr) == 0) {
> +				if (velocity_alloc_rx_buf(vptr, rd_curr) < 0) {
> +					VELOCITY_PRT(MSG_LEVEL_ERR, KERN_ERR "%s: can not allocate rx buf\n", vptr->dev->name);
> +					break;
> +				}
> +			} else {
> +				stats->rx_dropped++;
> +			}
> +		} else {
> +			if (rd->rdesc0.RSR & RSR_CRC)
> +				stats->rx_crc_errors++;
> +			if (rd->rdesc0.RSR & RSR_FAE)
> +				stats->rx_frame_errors++;
> +
> +			stats->rx_dropped++;
> +		}
> +
> +		rd->inten = 1;
> +
> +		if (++vptr->rd_used >= 4) {
> +			int i, rd_prev = rd_curr;
> +			for (i = 0; i < 4; i++) {
> +				if (--rd_prev < 0)
> +					rd_prev = vptr->options.numrx - 1;
> +
> +				rd = &(vptr->rd_ring[rd_prev]);
> +				rd->rdesc0.owner = OWNED_BY_NIC;
> +			}
> +			writew(4, &(regs->RBRDU));
> +			vptr->rd_used -= 4;
> +		}
> +
> +		vptr->dev->last_rx = jiffies;
> +
> +		rd_curr++;
> +		if (rd_curr >= vptr->options.numrx)
> +			rd_curr = 0;
> +	}
> +	vptr->rd_curr = rd_curr;
> +	VAR_USED(stats);
> +	return works;
> +}
> +
> +/**
> + *	velocity_rx_csum	-	checksum process
> + *	@rd: receive packet descriptor
> + *	@skb: network layer packet buffer
> + *
> + *	Process the status bits for the received packet and determine
> + *	if the checksum was computed and verified by the hardware
> + */
> + 
> +static inline void velocity_rx_csum(struct rx_desc *rd, struct sk_buff *skb)
> +{
> +	skb->ip_summed = CHECKSUM_NONE;
> +
> +	if (rd->rdesc1.CSM & CSM_IPKT) {
> +		if (rd->rdesc1.CSM & CSM_IPOK) {
> +			if ((rd->rdesc1.CSM & CSM_TCPKT) || 
> +					(rd->rdesc1.CSM & CSM_UDPKT)) {
> +				if (!(rd->rdesc1.CSM & CSM_TUPOK)) {
> +					return;
> +				}
> +			}
> +			skb->ip_summed = CHECKSUM_UNNECESSARY;
> +		}
> +	}
> +}
> +
> +/**
> + *	velocity_receive_frame	-	received packet processor
> + *	@vptr: velocity we are handling
> + *	@idx: ring index
> + *	
> + *	A packet has arrived. We process the packet and if appropriate
> + *	pass the frame up the network stack
> + */
> + 
> +static int velocity_receive_frame(struct velocity_info *vptr, int idx)
> +{
> +	struct net_device_stats *stats = &vptr->stats;
> +	struct velocity_rd_info *rd_info = &(vptr->rd_info[idx]);
> +	struct rx_desc *rd = &(vptr->rd_ring[idx]);
> +	struct sk_buff *skb;
> +
> +	if (rd->rdesc0.RSR & (RSR_STP | RSR_EDP)) {
> +		VELOCITY_PRT(MSG_LEVEL_VERBOSE, KERN_ERR " %s : the received frame span multple RDs.\n", vptr->dev->name);
> +		stats->rx_length_errors++;
> +		return -EINVAL;
> +	}
> +
> +	if (rd->rdesc0.RSR & RSR_MAR)
> +		vptr->stats.multicast++;
> +
> +	skb = rd_info->skb;
> +	skb->dev = vptr->dev;
> +
> +	pci_unmap_single(vptr->pdev, rd_info->skb_dma, vptr->rx_buf_sz, 
> +							PCI_DMA_FROMDEVICE);
> +	rd_info->skb_dma = (dma_addr_t) NULL;
> +	rd_info->skb = NULL;
> +
> +	/* FIXME - memmove ? */
> +	if (vptr->flags & VELOCITY_FLAGS_IP_ALIGN) {
> +		int i;
> +		for (i = rd->rdesc0.len + 4; i >= 0; i--)
> +			*(skb->data + i + 2) = *(skb->data + i);
> +		skb->data += 2;
> +		skb->tail += 2;
> +	}
> +
> +	skb_put(skb, (rd->rdesc0.len - 4));
> +	skb->protocol = eth_type_trans(skb, skb->dev);
> +
> +	/*
> +	 *	Drop frame not meeting IEEE 802.3
> +	 */
> +	 
> +	if (vptr->flags & VELOCITY_FLAGS_VAL_PKT_LEN) {
> +		if (rd->rdesc0.RSR & RSR_RL) {
> +			stats->rx_length_errors++;
> +			return -EINVAL;
> +		}
> +	}
> +
> +	velocity_rx_csum(rd, skb);
> +	
> +	/*
> +	 *	FIXME: need rx_copybreak handling
> +	 */
> +
> +	stats->rx_bytes += skb->len;
> +	netif_rx(skb);

any interest in netif_rx() return value?


> +	return 0;
> +}
> +
> +/**
> + *	velocity_alloc_rx_buf	-	allocate aligned receive buffer
> + *	@vptr: velocity
> + *	@idx: ring index
> + *
> + *	Allocate a new full sized buffer for the reception of a frame and
> + *	map it into PCI space for the hardware to use. The hardware
> + *	requires *64* byte alignment of the buffer which makes life
> + *	less fun than would be ideal.
> + */
> + 
> +static int velocity_alloc_rx_buf(struct velocity_info *vptr, int idx)
> +{
> +	struct rx_desc *rd = &(vptr->rd_ring[idx]);
> +	struct velocity_rd_info *rd_info = &(vptr->rd_info[idx]);
> +
> +	rd_info->skb = dev_alloc_skb(vptr->rx_buf_sz + 64);
> +	if (rd_info->skb == NULL)
> +		return -ENOMEM;
> +
> +	/*
> +	 *	Do the gymnastics to get the buffer head for data at
> +	 *	64byte alignment.
> +	 */
> +	skb_reserve(rd_info->skb, (unsigned long) rd_info->skb->tail & 63);
> +	rd_info->skb->dev = vptr->dev;
> +	rd_info->skb_dma = pci_map_single(vptr->pdev, rd_info->skb->tail, vptr->rx_buf_sz, PCI_DMA_FROMDEVICE);
> +	
> +	/*
> +	 *	Fill in the descriptor to match
> + 	 */	
> + 	 
> +	*((u32 *) & (rd->rdesc0)) = 0;
> +	rd->len = cpu_to_le32(vptr->rx_buf_sz);
> +	rd->inten = 1;
> +	rd->pa_low = cpu_to_le32(rd_info->skb_dma);
> +	rd->pa_high = 0;
> +	return 0;
> +}
> +
> +/**
> + *	tx_srv		-	transmit interrupt service
> + *	@vptr; Velocity
> + *	@status:
> + *
> + *	Scan the queues looking for transmitted packets that
> + *	we can complete and clean up. Update any statistics as
> + *	neccessary/
> + */
> + 
> +static int velocity_tx_srv(struct velocity_info *vptr, u32 status)
> +{
> +	struct tx_desc *td;
> +	int qnum;
> +	int full = 0;
> +	int idx;
> +	int works = 0;
> +	struct velocity_td_info *tdinfo;
> +	struct net_device_stats *stats = &vptr->stats;
> +
> +	for (qnum = 0; qnum < vptr->num_txq; qnum++) {
> +		for (idx = vptr->td_tail[qnum]; vptr->td_used[qnum] > 0; 
> +			idx = (idx + 1) % vptr->options.numtx) {
> +
> +			/*
> +			 *	Get Tx Descriptor
> +			 */
> +			td = &(vptr->td_rings[qnum][idx]);
> +			tdinfo = &(vptr->td_infos[qnum][idx]);
> +
> +			if (td->tdesc0.owner == OWNED_BY_NIC)
> +				break;
> +
> +			if ((works++ > 15))
> +				break;
> +
> +			if (td->tdesc0.TSR & TSR0_TERR) {
> +				stats->tx_errors++;
> +				stats->tx_dropped++;
> +				if (td->tdesc0.TSR & TSR0_CDH)
> +					stats->tx_heartbeat_errors++;
> +				if (td->tdesc0.TSR & TSR0_CRS)
> +					stats->tx_carrier_errors++;
> +				if (td->tdesc0.TSR & TSR0_ABT)
> +					stats->tx_aborted_errors++;
> +				if (td->tdesc0.TSR & TSR0_OWC)
> +					stats->tx_window_errors++;
> +			} else {
> +				stats->tx_packets++;
> +				stats->tx_bytes += tdinfo->skb->len;
> +			}
> +			velocity_free_tx_buf(vptr, tdinfo);
> +			vptr->td_used[qnum]--;
> +		}
> +		vptr->td_tail[qnum] = idx;
> +
> +		if (AVAIL_TD(vptr, qnum) < 1) {
> +			full = 1;
> +		}
> +	}
> +	/*
> +	 *	Look to see if we should kick the transmit network
> +	 *	layer for more work.
> +	 */
> +	if (netif_queue_stopped(vptr->dev) && (full == 0)
> +	    && (!(vptr->mii_status & VELOCITY_LINK_FAIL))) {
> +		netif_wake_queue(vptr->dev);
> +	}
> +	return works;
> +}


> +/**
> + *	velocity_print_link_status	-	link status reporting
> + *	@vptr: velocity to report on
> + *
> + *	Turn the link status of the velocity card into a kernel log
> + *	description of the new link state, detailing speed and duplex
> + *	status
> + */
> +
> +static void velocity_print_link_status(struct velocity_info *vptr)
> +{
> +
> +	if (vptr->mii_status & VELOCITY_LINK_FAIL) {
> +		VELOCITY_PRT(MSG_LEVEL_INFO, KERN_NOTICE "%s: failed to detect cable link\n", vptr->dev->name);
> +	} else if (vptr->options.spd_dpx == SPD_DPX_AUTO) {
> +		VELOCITY_PRT(MSG_LEVEL_INFO, KERN_NOTICE "%s: Link autonegation", vptr->dev->name);
> +
> +		if (vptr->mii_status & VELOCITY_SPEED_1000)
> +			VELOCITY_PRT(MSG_LEVEL_INFO, " speed 1000M bps");
> +		else if (vptr->mii_status & VELOCITY_SPEED_100)
> +			VELOCITY_PRT(MSG_LEVEL_INFO, " speed 100M bps");
> +		else
> +			VELOCITY_PRT(MSG_LEVEL_INFO, " speed 10M bps");
> +
> +		if (vptr->mii_status & VELOCITY_DUPLEX_FULL)
> +			VELOCITY_PRT(MSG_LEVEL_INFO, " full duplex\n");
> +		else
> +			VELOCITY_PRT(MSG_LEVEL_INFO, " half duplex\n");
> +	} else {
> +		VELOCITY_PRT(MSG_LEVEL_INFO, KERN_NOTICE "%s: Link forced", vptr->dev->name);
> +		switch (vptr->options.spd_dpx) {
> +		case SPD_DPX_100_HALF:
> +			VELOCITY_PRT(MSG_LEVEL_INFO, " speed 100M bps half duplex\n");
> +			break;
> +		case SPD_DPX_100_FULL:
> +			VELOCITY_PRT(MSG_LEVEL_INFO, " speed 100M bps full duplex\n");
> +			break;
> +		case SPD_DPX_10_HALF:
> +			VELOCITY_PRT(MSG_LEVEL_INFO, " speed 10M bps half duplex\n");
> +			break;
> +		case SPD_DPX_10_FULL:
> +			VELOCITY_PRT(MSG_LEVEL_INFO, " speed 10M bps full duplex\n");
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +}
> +
> +/**
> + *	velocity_error	-	handle error from controller
> + *	@vptr: velocity
> + *	@status: card status
> + *
> + *	Process an error report from the hardware and attempt to recover
> + *	the card itself. At the moment we cannot recover from some 
> + *	theoretically impossible errors but this could be fixed using
> + *	the pci_device_failed logic to bounce the hardware
> + *
> + */
> + 
> +static void velocity_error(struct velocity_info *vptr, int status)
> +{
> +
> +	if (status & ISR_TXSTLI) {
> +		struct mac_regs * regs = vptr->mac_regs;
> +
> +		printk(KERN_ERR "TD structure errror TDindex=%hx\n", readw(&regs->TDIdx[0]));
> +		BYTE_REG_BITS_ON(TXESR_TDSTR, &regs->TXESR);
> +		writew(TRDCSR_RUN, &regs->TDCSRClr);
> +		netif_stop_queue(vptr->dev);
> +		
> +		/* FIXME: port over the pci_device_failed code and use it
> +		   here */
> +	}
> +
> +	if (status & ISR_SRCI) {
> +		struct mac_regs * regs = vptr->mac_regs;
> +		int linked;
> +
> +		if (vptr->options.spd_dpx == SPD_DPX_AUTO) {
> +			vptr->mii_status = check_connection_type(regs);
> +
> +			/*
> +			 *	If it is a 3119, disable frame bursting in 
> +			 *	halfduplex mode and enable it in fullduplex
> +			 *	 mode
> +			 */
> +			if (vptr->rev_id < REV_ID_VT3216_A0) {
> +				if (vptr->mii_status | VELOCITY_DUPLEX_FULL)
> +					BYTE_REG_BITS_ON(TCR_TB2BDIS, &regs->TCR);
> +				else
> +					BYTE_REG_BITS_OFF(TCR_TB2BDIS, &regs->TCR);
> +			}
> +			/*
> +			 *	Only enable CD heart beat counter in 10HD mode
> +			 */
> +			if (!(vptr->mii_status & VELOCITY_DUPLEX_FULL) && (vptr->mii_status & VELOCITY_SPEED_10)) {
> +				BYTE_REG_BITS_OFF(TESTCFG_HBDIS, &regs->TESTCFG);
> +			} else {
> +				BYTE_REG_BITS_ON(TESTCFG_HBDIS, &regs->TESTCFG);
> +			}
> +		}
> +		/*
> +		 *	Get link status from PHYSR0
> +		 */
> +		linked = readb(&regs->PHYSR0) & PHYSR0_LINKGD;
> +
> +		if (linked) {
> +			vptr->mii_status &= ~VELOCITY_LINK_FAIL;
> +		} else {
> +			vptr->mii_status |= VELOCITY_LINK_FAIL;
> +		}
> +
> +		velocity_print_link_status(vptr);
> +		enable_flow_control_ability(vptr);
> +
> +		/*
> +		 *	Re-enable auto-polling because SRCI will disable 
> +		 *	auto-polling
> +		 */
> +		 
> +		enable_mii_autopoll(regs);
> +
> +		if (vptr->mii_status & VELOCITY_LINK_FAIL)
> +			netif_stop_queue(vptr->dev);
> +		else
> +			netif_wake_queue(vptr->dev);

are you 100% certain there is available TX room, when netif_wake_queue() 
is called?  if not, it should be conditional...


> +	};
> +	if (status & ISR_MIBFI)
> +		velocity_update_hw_mibs(vptr);
> +	if (status & ISR_LSTEI)
> +		mac_rx_queue_wake(vptr->mac_regs);
> +}
> +
> +/**
> + *	velocity_free_tx_buf	-	free transmit buffer
> + *	@vptr: velocity
> + *	@tdinfo: buffer
> + *
> + *	Release an transmit buffer. If the buffer was preallocated then
> + *	recycle it, if not then unmap the buffer.
> + */
> + 
> +static void velocity_free_tx_buf(struct velocity_info *vptr, struct velocity_td_info *tdinfo)
> +{
> +	struct sk_buff *skb = tdinfo->skb;
> +	int i;
> +
> +	/*
> +	 *	Don't unmap the pre-allocated tx_bufs
> +	 */
> +	if (tdinfo->skb_dma && (tdinfo->skb_dma[0] != tdinfo->buf_dma)) {
> +
> +		for (i = 0; i < tdinfo->nskb_dma; i++) {
> +#ifdef VELOCITY_ZERO_COPY_SUPPORT
> +			pci_unmap_single(vptr->pdev, tdinfo->skb_dma[i], td->tdesc1.len, PCI_DMA_TODEVICE);
> +#else
> +			pci_unmap_single(vptr->pdev, tdinfo->skb_dma[i], skb->len, PCI_DMA_TODEVICE);
> +#endif
> +			tdinfo->skb_dma[i] = 0;
> +		}
> +	}
> +	dev_kfree_skb_irq(skb);
> +	tdinfo->skb = NULL;
> +}
> +
> +/**
> + *	velocity_open		-	interface activation callback
> + *	@dev: network layer device to open
> + *
> + *	Called when the network layer brings the interface up. Returns
> + *	a negative posix error code on failure, or zero on success.
> + *
> + *	All the ring allocation and set up is done on open for this
> + *	adapter to minimise memory usage when inactive
> + */
> + 
> +static int velocity_open(struct net_device *dev)
> +{
> +	struct velocity_info *vptr = dev->priv;
> +	int ret;
> +
> +	vptr->rx_buf_sz = (dev->mtu <= 1504 ? PKT_BUF_SZ : dev->mtu + 32);
> +
> +	ret = velocity_init_rings(vptr);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = velocity_init_rd_ring(vptr);
> +	if (ret < 0)
> +		goto err_free_desc_rings;
> +
> +	ret = velocity_init_td_ring(vptr);
> +	if (ret < 0)
> +		goto err_free_rd_ring;
> +	
> +	/* Ensure chip is running */	
> +	pci_set_power_state(vptr->pdev, 0);
> +	
> +	velocity_init_registers(vptr, VELOCITY_INIT_COLD);
> +
> +	ret = request_irq(vptr->pdev->irq, &velocity_intr, SA_SHIRQ,
> +			  dev->name, dev);
> +	if (ret < 0) {
> +		/* Power down the chip */
> +		pci_set_power_state(vptr->pdev, 3);
> +		goto err_free_td_ring;
> +	}
> +
> +	mac_enable_int(vptr->mac_regs);
> +	netif_start_queue(dev);
> +	vptr->flags |= VELOCITY_FLAGS_OPENED;
> +out:
> +	return ret;
> +
> +err_free_td_ring:
> +	velocity_free_td_ring(vptr);
> +err_free_rd_ring:
> +	velocity_free_rd_ring(vptr);
> +err_free_desc_rings:
> +	velocity_free_rings(vptr);
> +	goto out;
> +}
> +
> +/** 
> + *	velocity_change_mtu	-	MTU change callback
> + *	@dev: network device
> + *	@new_mtu: desired MTU
> + *
> + *	Handle requests from the networking layer for MTU change on
> + *	this interface. It gets called on a change by the network layer.
> + *	Return zero for success or negative posix error code.
> + */
> + 
> +static int velocity_change_mtu(struct net_device *dev, int new_mtu)
> +{
> +	struct velocity_info *vptr = dev->priv;
> +	unsigned long flags;
> +	int oldmtu = dev->mtu;
> +	int ret = 0;
> +
> +	if ((new_mtu < VELOCITY_MIN_MTU) || new_mtu > (VELOCITY_MAX_MTU)) {
> +		VELOCITY_PRT(MSG_LEVEL_ERR, KERN_NOTICE "%s: Invalid MTU.\n", 
> +				vptr->dev->name);
> +		return -EINVAL;
> +	}
> +
> +	if (new_mtu != oldmtu) {
> +		spin_lock_irqsave(&vptr->lock, flags);
> +
> +		netif_stop_queue(dev);
> +		velocity_shutdown(vptr);
> +
> +		velocity_free_td_ring(vptr);
> +		velocity_free_rd_ring(vptr);
> +
> +		dev->mtu = new_mtu;
> +		if (new_mtu > 8192)
> +			vptr->rx_buf_sz = 9 * 1024;
> +		else if (new_mtu > 4096)
> +			vptr->rx_buf_sz = 8192;
> +		else
> +			vptr->rx_buf_sz = 4 * 1024;
> +
> +		ret = velocity_init_rd_ring(vptr);
> +		if (ret < 0)
> +			goto out_unlock;
> +
> +		ret = velocity_init_td_ring(vptr);
> +		if (ret < 0)
> +			goto out_unlock;
> +
> +		velocity_init_registers(vptr, VELOCITY_INIT_COLD);
> +
> +		mac_enable_int(vptr->mac_regs);
> +		netif_start_queue(dev);
> +out_unlock:
> +		spin_unlock_irqrestore(&vptr->lock, flags);
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + *	velocity_shutdown	-	shut down the chip
> + *	@vptr: velocity to deactivate
> + *
> + *	Shuts down the internal operations of the velocity and
> + *	disables interrupts, autopolling, transmit and receive
> + */
> + 
> +static void velocity_shutdown(struct velocity_info *vptr)
> +{
> +	struct mac_regs * regs = vptr->mac_regs;
> +	mac_disable_int(regs);
> +	writel(CR0_STOP, &regs->CR0Set);
> +	writew(0xFFFF, &regs->TDCSRClr);
> +	writeb(0xFF, &regs->RDCSRClr);
> +	safe_disable_mii_autopoll(regs);
> +	mac_clear_isr(regs);
> +}
> +
> +/**
> + *	velocity_close		-	close adapter callback
> + *	@dev: network device
> + *
> + *	Callback from the network layer when the velocity is being
> + *	deactivated by the network layer
> + */
> +
> +static int velocity_close(struct net_device *dev)
> +{
> +	struct velocity_info *vptr = dev->priv;
> +
> +	netif_stop_queue(dev);
> +	velocity_shutdown(vptr);
> +
> +	if (vptr->flags & VELOCITY_FLAGS_WOL_ENABLED)
> +		velocity_get_ip(vptr);
> +	if (dev->irq != 0)
> +		free_irq(dev->irq, dev);
> +		
> +	/* Power down the chip */
> +	pci_set_power_state(vptr->pdev, 3);
> +	
> +	/* Free the resources */
> +	velocity_free_td_ring(vptr);
> +	velocity_free_rd_ring(vptr);
> +	velocity_free_rings(vptr);
> +
> +	vptr->flags &= (~VELOCITY_FLAGS_OPENED);
> +	return 0;
> +}
> +
> +/**
> + *	velocity_xmit		-	transmit packet callback
> + *	@skb: buffer to transmit
> + *	@dev: network device
> + *
> + *	Called by the networ layer to request a packet is queued to
> + *	the velocity. Returns zero on success.
> + */
> + 
> +static int velocity_xmit(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct velocity_info *vptr = dev->priv;
> +	int qnum = 0;
> +	struct tx_desc *td_ptr;
> +	struct velocity_td_info *tdinfo;
> +	unsigned long flags;
> +	int index;
> +
> +	int pktlen = skb->len;
> +
> +	spin_lock_irqsave(&vptr->lock, flags);
> +
> +	index = vptr->td_curr[qnum];
> +	td_ptr = &(vptr->td_rings[qnum][index]);
> +	tdinfo = &(vptr->td_infos[qnum][index]);
> +
> +	td_ptr->tdesc1.TCPLS = TCPLS_NORMAL;
> +	td_ptr->tdesc1.TCR = TCR0_TIC;
> +	td_ptr->td_buf[0].queue = 0;
> +
> +	/*
> +	 *	Pad short frames. 
> +	 */
> +	if (pktlen < ETH_ZLEN) {
> +		/* Cannot occur until ZC support */
> +		if(skb_linearize(skb, GFP_ATOMIC))
> +			return 0; 
> +		pktlen = ETH_ZLEN;
> +		memcpy(tdinfo->buf, skb->data, skb->len);
> +		memset(tdinfo->buf + skb->len, 0, ETH_ZLEN - skb->len);
> +		tdinfo->skb = skb;
> +		tdinfo->skb_dma[0] = tdinfo->buf_dma;
> +		td_ptr->tdesc0.pktsize = pktlen;
> +		td_ptr->td_buf[0].pa_low = cpu_to_le32(tdinfo->skb_dma[0]);
> +		td_ptr->td_buf[0].pa_high = 0;
> +		td_ptr->td_buf[0].bufsize = td_ptr->tdesc0.pktsize;
> +		tdinfo->nskb_dma = 1;
> +		td_ptr->tdesc1.CMDZ = 2;
> +	} else
> +#ifdef VELOCITY_ZERO_COPY_SUPPORT
> +	if (skb_shinfo(skb)->nr_frags > 0) {
> +		int nfrags = skb_shinfo(skb)->nr_frags;
> +		tdinfo->skb = skb;
> +		if (nfrags > 6) {
> +			skb_linearize(skb, GFP_ATOMIC);
> +			memcpy(tdinfo->buf, skb->data, skb->len);
> +			tdinfo->skb_dma[0] = tdinfo->buf_dma;
> +			td_ptr->tdesc0.pktsize = 
> +			td_ptr->td_buf[0].pa_low = cpu_to_le32(tdinfo->skb_dma[0]);
> +			td_ptr->td_buf[0].pa_high = 0;
> +			td_ptr->td_buf[0].bufsize = td_ptr->tdesc0.pktsize;
> +			tdinfo->nskb_dma = 1;
> +			td_ptr->tdesc1.CMDZ = 2;
> +		} else {
> +			int i = 0;
> +			tdinfo->nskb_dma = 0;
> +			tdinfo->skb_dma[i] = pci_map_single(vptr->pdev, skb->data, skb->len - skb->data_len, PCI_DMA_TODEVICE);
> +
> +			td_ptr->tdesc0.pktsize = pktlen;
> +
> +			/* FIXME: support 48bit DMA later */
> +			td_ptr->td_buf[i].pa_low = cpu_to_le32(tdinfo->skb_dma);
> +			td_ptr->td_buf[i].pa_high = 0;
> +			td_ptr->td_buf[i].bufsize = skb->len->skb->data_len;
> +
> +			for (i = 0; i < nfrags; i++) {
> +				skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
> +				void *addr = ((void *) page_address(frag->page + frag->page_offset));
> +
> +				tdinfo->skb_dma[i + 1] = pci_map_single(vptr->pdev, addr, frag->size, PCI_DMA_TODEVICE);
> +
> +				td_ptr->td_buf[i + 1].pa_low = cpu_to_le32(tdinfo->skb_dma[i + 1]);
> +				td_ptr->td_buf[i + 1].pa_high = 0;
> +				td_ptr->td_buf[i + 1].bufsize = frag->size;
> +			}
> +			tdinfo->nskb_dma = i - 1;
> +			td_ptr->tdesc1.CMDZ = i;
> +		}
> +
> +	} else
> +#endif
> +	{
> +		/*
> +		 *	Map the linear network buffer into PCI space and
> +		 *	add it to the transmit ring.
> +		 */
> +		tdinfo->skb = skb;
> +		tdinfo->skb_dma[0] = pci_map_single(vptr->pdev, skb->data, pktlen, PCI_DMA_TODEVICE);
> +		td_ptr->tdesc0.pktsize = pktlen;
> +		td_ptr->td_buf[0].pa_low = cpu_to_le32(tdinfo->skb_dma[0]);
> +		td_ptr->td_buf[0].pa_high = 0;
> +		td_ptr->td_buf[0].bufsize = td_ptr->tdesc0.pktsize;
> +		tdinfo->nskb_dma = 1;
> +		td_ptr->tdesc1.CMDZ = 2;
> +	}
> +
> +	if (vptr->flags & VELOCITY_FLAGS_TAGGING) {
> +		td_ptr->tdesc1.pqinf.VID = (vptr->options.vid & 0xfff);
> +		td_ptr->tdesc1.pqinf.priority = 0;
> +		td_ptr->tdesc1.pqinf.CFI = 0;
> +		td_ptr->tdesc1.TCR |= TCR0_VETAG;
> +	}
> +
> +	/*
> +	 *	Handle hardware checksum
> +	 */
> +	if ((vptr->flags & VELOCITY_FLAGS_TX_CSUM)
> +				 && (skb->ip_summed == CHECKSUM_HW)) {
> +		struct iphdr *ip = skb->nh.iph;
> +		if (ip->protocol == IPPROTO_TCP)
> +			td_ptr->tdesc1.TCR |= TCR0_TCPCK;
> +		else if (ip->protocol == IPPROTO_UDP)
> +			td_ptr->tdesc1.TCR |= (TCR0_UDPCK);
> +		td_ptr->tdesc1.TCR |= TCR0_IPCK;
> +	}
> +	{
> +
> +		int prev = index - 1;
> +
> +		if (prev < 0)
> +			prev = vptr->options.numtx - 1;
> +		td_ptr->tdesc0.owner = OWNED_BY_NIC;
> +		vptr->td_used[qnum]++;
> +		vptr->td_curr[qnum] = (index + 1) % vptr->options.numtx;
> +
> +		if (AVAIL_TD(vptr, qnum) < 1)
> +			netif_stop_queue(dev);
> +
> +		td_ptr = &(vptr->td_rings[qnum][prev]);
> +		td_ptr->td_buf[0].queue = 1;
> +		mac_tx_queue_wake(vptr->mac_regs, qnum);
> +	}
> +	dev->trans_start = jiffies;
> +	spin_unlock_irqrestore(&vptr->lock, flags);
> +	return 0;
> +}
> +
> +/**
> + *	velocity_intr		-	interrupt callback
> + *	@irq: interrupt number
> + *	@dev_instance: interrupting device
> + *	@pt_regs: CPU register state at interrupt
> + *
> + *	Called whenever an interrupt is generated by the velocity
> + *	adapter IRQ line. We may not be the source of the interrupt
> + *	and need to identify initially if we are, and if not exit as
> + *	efficiently as possible.
> + */
> + 
> +static int velocity_intr(int irq, void *dev_instance, struct pt_regs *regs)
> +{
> +	struct net_device *dev = dev_instance;
> +	struct velocity_info *vptr = dev->priv;
> +	u32 isr_status;
> +	int max_count = 0;
> +
> +
> +	spin_lock(&vptr->lock);
> +	isr_status = mac_read_isr(vptr->mac_regs);
> +
> +	/* Not us ? */
> +	if (isr_status == 0) {
> +		spin_unlock(&vptr->lock);
> +		return IRQ_NONE;
> +	}

also bail if 0xffffffff (hardware fault / hardware unplugged)


> +	mac_disable_int(vptr->mac_regs);
> +
> +	/*
> +	 *	Keep processing the ISR until we have completed
> +	 *	processing and the isr_status becomes zero
> +	 */
> +	 
> +	while (isr_status != 0) {
> +		mac_write_isr(vptr->mac_regs, isr_status);
> +		if (isr_status & (~(ISR_PRXI | ISR_PPRXI | ISR_PTXI | ISR_PPTXI)))
> +			velocity_error(vptr, isr_status);
> +		if (isr_status & (ISR_PRXI | ISR_PPRXI))
> +			max_count += velocity_rx_srv(vptr, isr_status);
> +		if (isr_status & (ISR_PTXI | ISR_PPTXI))
> +			max_count += velocity_tx_srv(vptr, isr_status);
> +		isr_status = mac_read_isr(vptr->mac_regs);
> +		if (max_count > vptr->options.int_works)
> +		{
> +			printk(KERN_WARNING "%s: excessive work at interrupt.\n", 
> +				dev->name);
> +			max_count = 0;

No 'break;' ?


> +		}
> +	}
> +	spin_unlock(&vptr->lock);
> +	mac_enable_int(vptr->mac_regs);
> +	return IRQ_HANDLED;
> +
> +}
> +
> +
> +/**
> + *	ether_crc	-	ethernet CRC function
> + *
> + *	Compute an ethernet CRC hash of the data block provided. This
> + *	is not performance optimised but is not needed in performance
> + *	critical code paths.
> + *
> + *	FIXME: could we use shared code here ?

> +static inline u32 ether_crc(int length, unsigned char *data)

Your guess is correct, this code is 100% boilerplate.


> +/**
> + *	velocity_set_multi	-	filter list change callback
> + *	@dev: network device
> + *
> + *	Called by the network layer when the filter lists need to change
> + *	for a velocity adapter. Reload the CAMs with the new address
> + *	filter ruleset.
> + */
> + 
> +static void velocity_set_multi(struct net_device *dev)
> +{
> +	struct velocity_info *vptr = dev->priv;
> +	struct mac_regs * regs = vptr->mac_regs;
> +	u8 rx_mode;
> +	int i;
> +	struct dev_mc_list *mclist;
> +
> +	if (dev->flags & IFF_PROMISC) {	/* Set promiscuous. */
> +		/* Unconditionally log net taps. */
> +		printk(KERN_NOTICE "%s: Promiscuous mode enabled.\n", dev->name);
> +		writel(0xffffffff, &regs->MARCAM[0]);
> +		writel(0xffffffff, &regs->MARCAM[4]);
> +		rx_mode = (RCR_AM | RCR_AB | RCR_PROM);
> +	} else if ((dev->mc_count > vptr->multicast_limit)
> +		   || (dev->flags & IFF_ALLMULTI)) {
> +		writel(0xffffffff, &regs->MARCAM[0]);
> +		writel(0xffffffff, &regs->MARCAM[4]);
> +		rx_mode = (RCR_AM | RCR_AB);
> +	} else {
> +		int offset = MCAM_SIZE - vptr->multicast_limit;

Isn't multicast_limit a hardware limit, not a user-settable one?


> +		mac_get_cam_mask(regs, vptr->mCAMmask, VELOCITY_MULTICAST_CAM);
> +
> +		for (i = 0, mclist = dev->mc_list; mclist && i < dev->mc_count; i++, mclist = mclist->next) {
> +			mac_set_cam(regs, i + offset, mclist->dmi_addr, VELOCITY_MULTICAST_CAM);
> +			vptr->mCAMmask[(offset + i) / 8] |= 1 << ((offset + i) & 7);
> +		}
> +
> +		mac_set_cam_mask(regs, vptr->mCAMmask, VELOCITY_MULTICAST_CAM);
> +		rx_mode = (RCR_AM | RCR_AB);
> +	}
> +	if (dev->mtu > 1500)
> +		rx_mode |= RCR_AL;
> +
> +	BYTE_REG_BITS_ON(rx_mode, &regs->RCR);
> +
> +}
> +
> +/**
> + *	velocity_get_status	-	statistics callback
> + *	@dev: network device
> + *
> + *	Callback from the network layer to allow driver statistics
> + *	to be resynchronized with hardware collected state. In the
> + *	case of the velocity we need to pull the MIB counters from
> + *	the hardware into the counters before letting the network
> + *	layer display them.
> + */
> + 
> +static struct net_device_stats *velocity_get_stats(struct net_device *dev)
> +{
> +	struct velocity_info *vptr = dev->priv;
> +	
> +	/* If the hardware is down, don't touch MII */
> +	if(!netif_running(dev))
> +		return &vptr->stats;
> +
> +	spin_lock_irq(&vptr->lock);
> +	velocity_update_hw_mibs(vptr);
> +	spin_unlock_irq(&vptr->lock);
> +
> +	vptr->stats.rx_packets = vptr->mib_counter[HW_MIB_ifRxAllPkts];
> +	vptr->stats.rx_errors = vptr->mib_counter[HW_MIB_ifRxErrorPkts];
> +	vptr->stats.rx_length_errors = vptr->mib_counter[HW_MIB_ifInRangeLengthErrors];
> +
> +//  unsigned long   rx_dropped;     /* no space in linux buffers    */
> +	vptr->stats.collisions = vptr->mib_counter[HW_MIB_ifTxEtherCollisions];
> +	/* detailed rx_errors: */
> +//  unsigned long   rx_length_errors;
> +//  unsigned long   rx_over_errors;     /* receiver ring buff overflow  */
> +	vptr->stats.rx_crc_errors = vptr->mib_counter[HW_MIB_ifRxPktCRCE];
> +//  unsigned long   rx_frame_errors;    /* recv'd frame alignment error */
> +//  unsigned long   rx_fifo_errors;     /* recv'r fifo overrun      */
> +//  unsigned long   rx_missed_errors;   /* receiver missed packet   */
> +
> +	/* detailed tx_errors */
> +//  unsigned long   tx_fifo_errors;
> +
> +	return &vptr->stats;
> +}
> +
> +
> +/**
> + *	velocity_ioctl		-	ioctl entry point
> + *	@dev: network device
> + *	@rq: interface request ioctl
> + *	@cmd: command code
> + *
> + *	Called when the user issues an ioctl request to the network
> + *	device in question. The velocity interface supports MII.
> + */
> + 
> +static int velocity_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
> +{
> +	struct velocity_info *vptr = dev->priv;
> +	int ret;
> +
> +	/* If we are asked for information and the device is power
> +	   saving then we need to bring the device back up to talk to it */
> +	   	
> +	if(!netif_running(dev))
> +		pci_set_power_state(vptr->pdev, 0);
> +		
> +	switch (cmd) {
> +	case SIOCGMIIPHY:	/* Get address of MII PHY in use. */
> +	case SIOCGMIIREG:	/* Read MII PHY register. */
> +	case SIOCSMIIREG:	/* Write to MII PHY register. */
> +		ret = velocity_mii_ioctl(dev, rq, cmd);
> +		break;
> +
> +	default:
> +		ret = -EOPNOTSUPP;
> +	}
> +	if(!netif_running(dev))
> +		pci_set_power_state(vptr->pdev, 3);

FWIW, we really want to implement a timer for this, in this and other 
net drivers.  i.e. the normal mode of operation becomes

	go to D3 (probe)
	immediately go back to D0 (if up)
	start using it
	go to D3 (if down)

Ideally we should wait 30 seconds or so before powering down the interface.


> +	return ret;
> +}
> +
> +/*
> + *	Definition for our device driver. The PCI layer interface
> + *	uses this to handle all our card discover and plugging
> + */
> + 
> +static struct pci_driver velocity_driver = {
> +      name:VELOCITY_NAME,
> +      id_table:velocity_id_table,
> +      probe:velocity_found1,
> +      remove:velocity_remove1,
> +#ifdef CONFIG_PM
> +      suspend:velocity_suspend,
> +      resume:velocity_resume,
> +#endif
> +};
> +
> +/**
> + *	velocity_init_module	-	load time function
> + *
> + *	Called when the velocity module is loaded. The PCI driver
> + *	is registered with the PCI layer, and in turn will call
> + *	the probe functions for each velocity adapter installed
> + *	in the system.
> + */
> + 
> +static int __init velocity_init_module(void)
> +{
> +	int ret;
> +	ret = pci_module_init(&velocity_driver);
> +
> +#ifdef CONFIG_PM
> +	register_inetaddr_notifier(&velocity_inetaddr_notifier);
> +#endif

check ret for error before registering?



> +	switch (cmd) {
> +	case SIOCGMIIPHY:
> +		miidata->phy_id = readb(&regs->MIIADR) & 0x1f;
> +		break;
> +	case SIOCGMIIREG:
> +		if (!capable(CAP_NET_ADMIN))
> +			return -EPERM;
> +		if(velocity_mii_read(vptr->mac_regs, miidata->reg_num & 0x1f, &(miidata->val_out)) < 0)
> +			return -ETIMEDOUT;
> +		break;
> +	case SIOCSMIIREG:
> +		if (!capable(CAP_NET_ADMIN))
> +			return -EPERM;
> +		spin_lock_irqsave(&vptr->lock, flags);
> +		err = velocity_mii_write(vptr->mac_regs, miidata->reg_num & 0x1f, miidata->val_in);
> +		spin_unlock_irqrestore(&vptr->lock, flags);
> +		check_connection_type(vptr->mac_regs);

I need to triple-check, but I'm pretty the requisite security checks 
occur at a higher level, before the driver-local ioctl is called.

This was needed in the SIOCDEVPRIVATE days, but not for the known and 
specified SIOC*MII*



> +#define PKT_BUF_SZ          1540

Use 1536 like the other drives, not 1540.

This has nothing to do with VLAN, and is simply an allocation standard 
to keep the net drivers pulling from the same slab(s).


> +#define MAX_UNITS           8
> +#define OPTION_DEFAULT      { [0 ... MAX_UNITS-1] = -1}
> +
> +#define REV_ID_VT6110       (0)
> +#define DEVICE_ID           (0x3119)

pci_ids.h ?


> +#define BYTE_REG_BITS_ON(x,p)       do { writeb(readb((p))|(x),(p));} while (0)
> +#define WORD_REG_BITS_ON(x,p)       do { writew(readw((p))|(x),(p));} while (0)
> +#define DWORD_REG_BITS_ON(x,p)      do { writel(readl((p))|(x),(p));} while (0)
> +
> +#define BYTE_REG_BITS_IS_ON(x,p)    (readb((p)) & (x))
> +#define WORD_REG_BITS_IS_ON(x,p)    (readw((p)) & (x))
> +#define DWORD_REG_BITS_IS_ON(x,p)   (readl((p)) & (x))
> +
> +#define BYTE_REG_BITS_OFF(x,p)      do { writeb(readb((p)) & (~(x)),(p));} while (0)
> +#define WORD_REG_BITS_OFF(x,p)      do { writew(readw((p)) & (~(x)),(p));} while (0)
> +#define DWORD_REG_BITS_OFF(x,p)     do { writel(readl((p)) & (~(x)),(p));} while (0)
> +
> +#define BYTE_REG_BITS_SET(x,m,p)    do { writeb( (readb((p)) & (~(m))) |(x),(p));} while (0)
> +#define WORD_REG_BITS_SET(x,m,p)    do { writew( (readw((p)) & (~(m))) |(x),(p));} while (0)
> +#define DWORD_REG_BITS_SET(x,m,p)   do { writel( (readl((p)) & (~(m)))|(x),(p));}  while (0)
> +
> +#define VAR_USED(p)     do {(p)=(p);} while (0)
> +

> +/*
> + *	Receive descriptor
> + */
> +
> +struct rdesc0 {
> +	u16 RSR;		/* Receive status */
> +	u16 len:14;		/* Received packet length */
> +	u16 reserved:1;
> +	u16 owner:1;		/* Who owns this buffer ? */
> +};

part of the endian-ness problems, I suppose...


> +struct rdesc1 {
> +	u16 PQTAG;
> +	u8 CSM;
> +	u8 IPKT;
> +};
> +
> +struct rx_desc {
> +	struct rdesc0 rdesc0;
> +	struct rdesc1 rdesc1;
> +	u32 pa_low;		/* Low 32 bit PCI address */
> +	u16 pa_high;		/* Next 16 bit PCI address (48 total) */
> +	u16 len:15;		/* Frame size */
> +	u16 inten:1;		/* Enable interrupt */
> +} __attribute__ ((__packed__));

ditto


> +/*
> + *	Transmit descriptor
> + */
> +
> +struct tdesc0 {
> +	u16 TSR;		/* Transmit status register */
> +	u16 pktsize:14;		/* Size of frame */
> +	u16 reserved:1;
> +	u16 owner:1;		/* Who owns the buffer */
> +};

ditto


> +struct pqinf {			/* Priority queue info */
> +	u16 VID:12;
> +	u16 CFI:1;
> +	u16 priority:3;
> +} __attribute__ ((__packed__));
> +
> +struct tdesc1 {
> +	struct pqinf pqinf;
> +	u8 TCR;
> +	u8 TCPLS:2;
> +	u8 reserved:2;
> +	u8 CMDZ:4;
> +} __attribute__ ((__packed__));
> +
> +struct td_buf {
> +	u32 pa_low;
> +	u16 pa_high;
> +	u16 bufsize:14;	
> +	u16 reserved:1;
> +	u16 queue:1;
> +} __attribute__ ((__packed__));

ditto x 3


> +struct tx_desc {
> +	struct tdesc0 tdesc0;
> +	struct tdesc1 tdesc1;
> +	struct td_buf td_buf[7];
> +};
> +
> +struct velocity_rd_info {
> +	struct sk_buff *skb;
> +	dma_addr_t skb_dma;
> +};
> +

> +struct mac_regs {
> +	volatile u8 PAR[6];		/* 0x00 */
> +	volatile u8 RCR;
> +	volatile u8 TCR;
> +
> +	volatile u32 CR0Set;		/* 0x08 */
> +	volatile u32 CR0Clr;		/* 0x0C */
> +
> +	volatile u8 MARCAM[8];		/* 0x10 */
> +
> +	volatile u32 DecBaseHi;		/* 0x18 */
> +	volatile u16 DbfBaseHi;		/* 0x1C */
> +	volatile u16 reserved_1E;
> +
> +	volatile u16 ISRCTL;		/* 0x20 */
> +	volatile u8 TXESR;
> +	volatile u8 RXESR;
> +
> +	volatile u32 ISR;		/* 0x24 */
> +	volatile u32 IMR;
> +
> +	volatile u32 TDStatusPort;	/* 0x2C */
> +
> +	volatile u16 TDCSRSet;		/* 0x30 */
> +	volatile u8 RDCSRSet;
> +	volatile u8 reserved_33;
> +	volatile u16 TDCSRClr;
> +	volatile u8 RDCSRClr;
> +	volatile u8 reserved_37;
> +
> +	volatile u32 RDBaseLo;		/* 0x38 */
> +	volatile u16 RDIdx;		/* 0x3C */
> +	volatile u16 reserved_3E;
> +
> +	volatile u32 TDBaseLo[4];	/* 0x40 */
> +
> +	volatile u16 RDCSize;		/* 0x50 */
> +	volatile u16 TDCSize;		/* 0x52 */
> +	volatile u16 TDIdx[4];		/* 0x54 */
> +	volatile u16 tx_pause_timer;	/* 0x5C */
> +	volatile u16 RBRDU;		/* 0x5E */
> +
> +	volatile u32 FIFOTest0;		/* 0x60 */
> +	volatile u32 FIFOTest1;		/* 0x64 */
> +
> +	volatile u8 CAMADDR;		/* 0x68 */
> +	volatile u8 CAMCR;		/* 0x69 */
> +	volatile u8 GFTEST;		/* 0x6A */
> +	volatile u8 FTSTCMD;		/* 0x6B */
> +
> +	volatile u8 MIICFG;		/* 0x6C */
> +	volatile u8 MIISR;
> +	volatile u8 PHYSR0;
> +	volatile u8 PHYSR1;
> +	volatile u8 MIICR;
> +	volatile u8 MIIADR;
> +	volatile u16 MIIDATA;
> +
> +	volatile u16 SoftTimer0;	/* 0x74 */
> +	volatile u16 SoftTimer1;
> +
> +	volatile u8 CFGA;		/* 0x78 */
> +	volatile u8 CFGB;
> +	volatile u8 CFGC;
> +	volatile u8 CFGD;
> +
> +	volatile u16 DCFG;		/* 0x7C */
> +	volatile u16 MCFG;
> +
> +	volatile u8 TBIST;		/* 0x80 */
> +	volatile u8 RBIST;
> +	volatile u8 PMCPORT;
> +	volatile u8 STICKHW;
> +
> +	volatile u8 MIBCR;		/* 0x84 */
> +	volatile u8 reserved_85;
> +	volatile u8 rev_id;
> +	volatile u8 PORSTS;
> +
> +	volatile u32 MIBData;		/* 0x88 */
> +
> +	volatile u16 EEWrData;
> +
> +	volatile u8 reserved_8E;
> +	volatile u8 BPMDWr;
> +	volatile u8 BPCMD;
> +	volatile u8 BPMDRd;
> +
> +	volatile u8 EECHKSUM;		/* 0x92 */
> +	volatile u8 EECSR;
> +
> +	volatile u16 EERdData;		/* 0x94 */
> +	volatile u8 EADDR;
> +	volatile u8 EMBCMD;
> +
> +
> +	volatile u8 JMPSR0;		/* 0x98 */
> +	volatile u8 JMPSR1;
> +	volatile u8 JMPSR2;
> +	volatile u8 JMPSR3;
> +	volatile u8 CHIPGSR;		/* 0x9C */
> +	volatile u8 TESTCFG;
> +	volatile u8 DEBUG;
> +	volatile u8 CHIPGCR;
> +
> +	volatile u16 WOLCRSet;		/* 0xA0 */
> +	volatile u8 PWCFGSet;
> +	volatile u8 WOLCFGSet;
> +
> +	volatile u16 WOLCRClr;		/* 0xA4 */
> +	volatile u8 PWCFGCLR;
> +	volatile u8 WOLCFGClr;
> +
> +	volatile u16 WOLSRSet;		/* 0xA8 */
> +	volatile u16 reserved_AA;
> +
> +	volatile u16 WOLSRClr;		/* 0xAC */
> +	volatile u16 reserved_AE;
> +
> +	volatile u16 PatternCRC[8];	/* 0xB0 */
> +	volatile u32 ByteMask[4][4];	/* 0xC0 */
> +} __attribute__ ((__packed__));

kill the 'volatile', this driver uses {read,write}[bwl] correctly



> +/*
> + *	MII registers.
> + */

wants to use include/linux/mii.h



> +enum velocity_msg_level {
> +	MSG_LEVEL_ERR = 0,	//Errors that will cause abnormal operation.
> +	MSG_LEVEL_NOTICE = 1,	//Some errors need users to be notified.
> +	MSG_LEVEL_INFO = 2,	//Normal message.
> +	MSG_LEVEL_VERBOSE = 3,	//Will report all trival errors.
> +	MSG_LEVEL_DEBUG = 4	//Only for debug purpose.
> +};

lame... we have NETIF_MSG_ :)



> +struct velocity_info {
> +	struct velocity_info *next;
> +	struct velocity_info *prev;
> +
> +	struct pci_dev *pdev;
> +	struct net_device *dev;
> +	struct net_device_stats stats;
> +
> +#if CONFIG_PM
> +	u32 pci_state[16];
> +#endif
> +
> +	dma_addr_t rd_pool_dma;
> +	dma_addr_t td_pool_dma[TX_QUEUE_NO];
> +
> +	dma_addr_t tx_bufs_dma;
> +	u8 *tx_bufs;
> +
> +	u8 ip_addr[4];
> +	enum chip_type chip_id;
> +
> +	struct mac_regs * mac_regs;
> +	unsigned long memaddr;
> +	unsigned long ioaddr;
> +	u32 io_size;
> +
> +	u8 rev_id;
> +
> +#define AVAIL_TD(p,q)   ((p)->options.numtx-((p)->td_used[(q)]))
> +
> +	int num_txq;
> +
> +	volatile int td_used[TX_QUEUE_NO];

volatile

