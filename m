Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030494AbWI0RuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030494AbWI0RuZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 13:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030496AbWI0RuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 13:50:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43949 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030494AbWI0RuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 13:50:22 -0400
Date: Wed, 27 Sep 2006 10:45:39 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Jay Cliburn <jacliburn@bellsouth.net>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] atl1: Attansic L1 Gigabit Ethernet driver
Message-ID: <20060927104539.639d2ece@freekitty>
In-Reply-To: <20060927132345.GC11922@osprey.hogchain.net>
References: <20060927132345.GC11922@osprey.hogchain.net>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.3; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh boy, another vendor driver to shred.

On Wed, 27 Sep 2006 08:23:45 -0500
Jay Cliburn <jacliburn@bellsouth.net> wrote:

> Full patch for the Attansic L1 gigabit ethernet driver.
> 
> Signed-off-by: Jay Cliburn <jacliburn@bellsouth.net>
> 
>  drivers/net/Kconfig     |    9 
>  drivers/net/Makefile    |    1 
>  drivers/net/atl1.c      | 5519 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/atl1.h      | 1598 ++++++++++++++
>  include/linux/pci_ids.h |    3 
>  5 files changed, 7130 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 6315477..b735b68 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -2248,6 +2248,15 @@ config SPIDER_NET
>  	  This driver supports the Gigabit Ethernet chips present on the
>  	  Cell Processor-Based Blades from IBM.
>  
> +config ATTANSIC_L1
> +        tristate "Attansic L1 gigabit ethernet support"
> +        depends on PCI
> +        help
> +          This driver supports the Attansic L1 gigabit Ethernet device.
> +
> +          To compile this driver as a module, choose M here: the module
> +          will be called atl1.  This is recommended.
> +
>  config GIANFAR
>  	tristate "Gianfar Ethernet"
>  	depends on 85xx || 83xx || PPC_86xx
> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> index f270bc4..e1fcb86 100644
> --- a/drivers/net/Makefile
> +++ b/drivers/net/Makefile
> @@ -69,6 +69,7 @@ obj-$(CONFIG_VIA_RHINE) += via-rhine.o
>  obj-$(CONFIG_VIA_VELOCITY) += via-velocity.o
>  obj-$(CONFIG_ADAPTEC_STARFIRE) += starfire.o
>  obj-$(CONFIG_RIONET) += rionet.o
> +obj-$(CONFIG_ATTANSIC_L1) += atl1.o
>  
>  #
>  # end link order section
> diff --git a/drivers/net/atl1.c b/drivers/net/atl1.c
> new file mode 100644
> index 0000000..ab87071
> --- /dev/null
> +++ b/drivers/net/atl1.c
> @@ -0,0 +1,5519 @@
> +/*
> + * atl1.c: Attansic L1 gigabit ethernet driver.
> + *
> + * This code is derived from the Attansic reference driver (copyright message
> + * below) provided to Jay Cliburn for addition to the Linux kernel.
> + *
> + * The code has been merged into one source file and cleaned up to follow
> + * Linux coding style.
> + *
> + * The changes are (c) Copyright 2006, Jay Cliburn (jacliburn@bellsouth.net)
> + *
> + * This source has not been verified for use in safety critical systems.
> + *
> + * Please direct inquiries about the revamped driver to the linux-kernel
> + * mail list, not to Attansic.
> + *
> + * Original code:
> + *
> + * Copyright (c) 1999-2005 Attansic Corporation (xiong_huang@attansic.com)
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> + * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> + * for more details.
> + *
> + * Author: Xiong Huang
> + *
> + * MODULE_LICENSE("GPL");


Why bury this in a comment?
> + *
> + */
> +
> +
> +#include <linux/module.h>
> +#include <linux/types.h>
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
> +#include <linux/string.h>
> +#include <asm/io.h>
> +#include <linux/reboot.h>
> +#include <linux/ethtool.h>
> +#include <linux/mii.h>
> +#include <linux/in.h>
> +#include <linux/ip.h>
> +#include <linux/tcp.h>
> +#include <linux/udp.h>
> +#include <linux/version.h>
> +
> +
> +/* The following header files were provided in the original
> + * source code, but apparently weren't needed for compilation.
> + * They're left here for posterity.
> + */
> +/* #include <linux/sched.h> */
> +/* #include <linux/pagemap.h> */
> +/* #include <linux/list.h> */
> +/* #include <linux/stddef.h> */
> +/* #include <linux/config.h> */
> +/* #include <linux/vmalloc.h> */
> +/* #include <linux/capability.h> */
> +/* #include <asm/byteorder.h> */
> +/* #include <asm/bitops.h> */
> +/* #include <asm/irq.h> */
> +/* #include <net/pkt_sched.h> */
> +
> +#include "atl1.h"
> +
> +#define RUN_REALTIME 0
> +#define DRV_VERSION "0.1.40.6"
> +
> +char at_driver_name[] = "atl1";
> +char at_driver_string[] = "Attansic L1 Ethernet Network Driver";
> +char at_driver_version[] = DRV_VERSION;
> +char at_copyright[] = "Copyright (C) 1999-2005 Attansic Corporation.";

static const char...

> +
> +MODULE_AUTHOR("Attansic Corporation");
> +MODULE_DESCRIPTION("Attansic L1 1000M Ethernet Network Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION(DRV_VERSION);
> +
> +static struct pci_device_id at_pci_tbl[] = {
> +	{ PCI_VENDOR_ID_ATTANSIC, PCI_DEVICE_ID_ATTANSIC_L1,
> +	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
> +	{0,}
> +};

use PCI_DEVICE macro

> +
> +MODULE_DEVICE_TABLE(pci, at_pci_tbl);
> +
> +/* This is the only thing that needs to be changed to adjust the
> + * maximum number of ports that the driver can manage.
> + */
> +
> +#define AT_MAX_NIC 32
> +#define OPTION_UNSET    -1
> +#define OPTION_DISABLED 0
> +#define OPTION_ENABLED  1
> +
> +/* All parameters are treated the same, as an integer array of values.
> + * This macro just reduces the need to repeat the same declaration code
> + * over and over (plus this helps to avoid typo bugs).
> + */
> +#define AT_PARAM_INIT { [0 ... AT_MAX_NIC] = OPTION_UNSET }
> +#ifndef module_param_array
> +
> +/* Module Parameters are always initialized to -1, so that the driver
> + * can tell the difference between no user specified value or the
> + * user asking for the default value.
> + * The true default values are loaded in when e1000_check_options is called.
> + *
> + * This is a GCC extension to ANSI C.
> + * See the item "Labeled Elements in Initializers" in the section
> + * "Extensions to the C Language Family" of the GCC documentation.
> + */
> +
> +#define AT_PARAM(X, desc) \
> +	static const int __devinitdata X[AT_MAX_NIC+1] = AT_PARAM_INIT; \
> +	MODULE_PARM(X, "1-" __MODULE_STRING(AT_MAX_NIC) "i"); \
> +	MODULE_PARM_DESC(X, desc);
> +#else
> +#define AT_PARAM(X, desc) \
> +	static int __devinitdata X[AT_MAX_NIC+1] = AT_PARAM_INIT; \
> +	static int num_##X = 0; \
> +	module_param_array_named(X, X, int, &num_##X, 0); \
> +	MODULE_PARM_DESC(X, desc);
> +#endif

moduleparam is always in 2.6. So this macro can be eliminated and
just code directly.


> +
> +/* Transmit Descriptor Count
> + *
> + * Valid Range: 64-2048
> + *
> + * Default Value: 128
> + */
> +AT_PARAM(TxDescriptors, "Number of transmit descriptors");
> +
> +/* Receive Descriptor Count
> + *
> + * Valid Range: 64-4096
> + *
> + * Default Value: 256
> + */
> +AT_PARAM(RxDescriptors, "Number of receive descriptors");
> +
> +/* User Specified MediaType Override
> + *
> + * Valid Range: 0-5
> + *  - 0    - auto-negotiate at all supported speeds
> + *  - 1    - only link at 1000Mbps Full Duplex
> + *  - 2    - only link at 100Mbps Full Duplex
> + *  - 3    - only link at 100Mbps Half Duplex
> + *  - 4    - only link at 10Mbps Full Duplex
> + *  - 5    - only link at 10Mbps Half Duplex
> + * Default Value: 0
> + */
> +AT_PARAM(MediaType, "MediaType Select");
> +
> +/* Interrupt Moderate Timer in units of 2 us
> + *
> + * Valid Range: 10-65535
> + *
> + * Default Value: 45000(90ms)
> + */
> +AT_PARAM(IntModTimer, "Interrupt Moderator Timer");
> +
> +/* FlashVendor
> + * Valid Range: 0-2
> + * 0 - Atmel
> + * 1 - SST
> + * 2 - ST
> + */
> +AT_PARAM(FlashVendor, "SPI Flash Vendor");
> +
> +#define AUTONEG_ADV_DEFAULT  0x2F
> +#define AUTONEG_ADV_MASK     0x2F
> +#define FLOW_CONTROL_DEFAULT FLOW_CONTROL_FULL
> +
> +#define DEFAULT_INT_MOD_CNT             100 // 200us
> +#define MAX_INT_MOD_CNT                 65000
> +#define MIN_INT_MOD_CNT                 50
> +
> +#define FLASH_VENDOR_DEFAULT    0
> +#define FLASH_VENDOR_MIN        0
> +#define FLASH_VENDOR_MAX        2
> +
> +/* function prototypes */
> +
> +int32_t at_reset_hw(struct at_hw* hw);

Need to make all local functions private (static).
Don't use C99 types, in kernel (int32_t) instead use kernel types:
	u32, s32, ...

I suspect most of these int32_t should just be int.


> +int32_t at_read_mac_addr(struct at_hw* hw);
> +int32_t at_init_hw(struct at_hw* hw);
> +int32_t at_phy_setup_autoneg_adv(struct at_hw *hw);
> +int32_t at_phy_reset(struct at_hw *hw);
> +int32_t at_get_speed_and_duplex(struct at_hw *hw, uint16_t *speed, uint16_t *duplex);
> +int32_t at_set_speed_and_duplex(struct at_hw *hw, uint16_t speed, uint16_t duplex);
> +uint32_t at_auto_get_fc(struct at_adapter* adapter, uint16_t duplex);
> +uint32_t at_hash_mc_addr(struct at_hw *hw, uint8_t *mc_addr);
> +void at_hash_set(struct at_hw *hw, uint32_t hash_value);
> +int32_t at_read_phy_reg(struct at_hw *hw, uint16_t reg_addr, uint16_t *phy_data);
> +int32_t at_write_phy_reg(struct at_hw *hw, uint32_t reg_addr, uint16_t phy_data);
> +void at_read_pci_cfg(struct at_hw*  hw, uint32_t reg, uint16_t *value);
> +void at_write_pci_cfg(struct at_hw* hw, uint32_t reg, uint16_t *value);
> +int32_t at_validate_mdi_setting(struct at_hw* hw);
> +int32_t at_setup_link(struct at_hw* hw);
> +void set_mac_addr(struct at_hw* hw);
> +int get_permanent_address(struct at_hw* hw);
> +boolean_t read_eeprom(struct at_hw* hw, uint32_t Offset, uint32_t* pValue);
> +void init_flash_opcode(struct at_hw* hw);
> +boolean_t spi_read(struct at_hw* hw, uint32_t addr, uint32_t* buf);
> +int32_t at_phy_enter_power_saving(struct at_hw* hw);
> +int32_t at_phy_leave_power_saving(struct at_hw* hw);
> +int32_t at_up(struct at_adapter* adapter);
> +void at_down(struct at_adapter* adapter);
> +int at_reset(struct at_adapter* adapter);
> +int32_t at_setup_ring_resources(struct at_adapter* adapter);
> +void at_free_ring_resources(struct at_adapter* adapter);
> +char at_driver_name[];
> +char at_driver_version[];


Get rid of having lots of forward declarations, by just
reordering the code, it's simpler.

> +
> +#ifdef SIOCGMIIPHY
> +int at_set_spd_dplx(struct at_adapter* adapter,uint16_t spddplx);
> +#endif
> +
> +static int at_init_module(void);
> +static void at_exit_module(void);
> +static int at_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
> +static void __devexit at_remove(struct pci_dev *pdev);
> +static int at_sw_init(struct at_adapter *adapter);
> +static int at_open(struct net_device *netdev);
> +static int at_close(struct net_device *netdev);
> +static int at_xmit_frame(struct sk_buff *skb, struct net_device *netdev);
> +static struct net_device_stats * at_get_stats(struct net_device *netdev);
> +static int at_change_mtu(struct net_device *netdev, int new_mtu);
> +static void at_set_multi(struct net_device *netdev);
> +static int at_set_mac(struct net_device *netdev, void *p);
> +static int at_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd);
> +static void at_tx_timeout(struct net_device *dev);
> +static irqreturn_t at_intr(int irq, void *data, struct pt_regs *regs);
> +static void at_inc_smb(struct at_adapter * adapter);
> +static void at_intr_rx(struct at_adapter* adapter);
> +static void at_intr_tx(struct at_adapter* adapter);
> +static void at_watchdog(unsigned long data);
> +static void at_phy_config(unsigned long data);
> +static void at_tx_timeout_task(struct net_device *netdev);
> +static void at_check_for_link(struct at_adapter* adapter);
> +static void at_link_chg_task(struct net_device* netdev);
> +static uint32_t at_check_link(struct at_adapter* adapter);
> +static void at_clean_tx_ring(struct at_adapter *adapter);
> +static uint16_t at_alloc_rx_buffers(struct at_adapter *adapter);
> +static uint32_t at_configure(struct at_adapter *adapter);
> +static void at_pcie_patch(struct at_adapter *adapter);
> +
> +#ifdef SIOCGMIIPHY
> +static int at_mii_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd);
> +#endif
> +
> +#ifdef NETIF_F_HW_VLAN_TX
> +static void at_vlan_rx_register(struct net_device *netdev, struct vlan_group *grp);
> +static void at_vlan_rx_add_vid(struct net_device *netdev, uint16_t vid);
> +static void at_vlan_rx_kill_vid(struct net_device *netdev, uint16_t vid);
> +static void at_restore_vlan(struct at_adapter *adapter);
> +#endif
> +
> +static int at_notify_reboot(struct notifier_block *nb, unsigned long event, void *p);
> +//static int at_suspend(struct pci_dev *pdev, uint32_t state);
> +static int at_suspend(struct pci_dev *pdev, pm_message_t state);
> +
> +#ifdef CONFIG_PM
> +static int at_resume(struct pci_dev *pdev);
> +#endif
> +
> +static void at_via_workaround(struct at_adapter * adapter);
> +
> +struct notifier_block at_notifier_reboot = {
> +    .notifier_call  = at_notify_reboot,
> +    .next       = NULL,
> +    .priority   = 0
> +};

Don't initialize fields that can just be zero.
Do you really need a reboot notifier at all?


> +void at_check_options(struct at_adapter *adapter);
> +int at_ethtool_ioctl(struct net_device *netdev, struct ifreq *ifr);
> +
> +#ifdef SIOCDEVPRIVATE
> +int at_priv_ioctl(struct net_device* netdev, struct ifreq* ifr);
> +#endif
> +
> +struct at_option {
> +	enum { enable_option, range_option, list_option } type;
> +	char *name;
> +	char *err;
> +	int  def;
> +	union {
> +		struct { /* range_option info */
> +			int min;
> +			int max;
> +		} r;
> +		struct { /* list_option info */
> +			int nr;
> +			struct at_opt_list { int i; char *str; } *p;
> +		} l;
> +	} arg;
> +};
> +
> +static int __devinit at_validate_option(int *value, struct at_option *opt)
> +{
> +	if(*value == OPTION_UNSET) {
> +		*value = opt->def;
> +		return 0;
> +	}
> +
> +	switch (opt->type) {
> +	case enable_option:
> +		switch (*value) {
> +		case OPTION_ENABLED:
> +			printk(KERN_INFO "%s Enabled\n", opt->name);
> +			return 0;
> +		case OPTION_DISABLED:
> +			printk(KERN_INFO "%s Disabled\n", opt->name);
> +			return 0;
> +		}
> +		break;

Indentation does not match kernel style,
run through scripts/Lindent.

> +	case range_option:
> +		if (*value >= opt->arg.r.min && *value <= opt->arg.r.max) {
> +			printk(KERN_INFO "%s set to %i\n", opt->name, *value);
> +			return 0;
> +		}
> +		break;
> +
> +	case list_option: {
> +		int i;
> +		struct at_opt_list *ent;
> +
> +		for (i = 0; i < opt->arg.l.nr; i++) {
> +			ent = &opt->arg.l.p[i];
> +			if (*value == ent->i) {
> +				if (ent->str[0] != '\0')
> +					printk(KERN_INFO "%s\n", ent->str);
> +				return 0;
> +			}
> +		}
> +		break;
> +	}
> +
> +	default:
> +		BUG();
> +	}
> +
> +	printk(KERN_INFO "Invalid %s specified (%i) %s\n",
> +	       opt->name, *value, opt->err);
> +	*value = opt->def;
> +	return -1;
> +}
> +
> +/**
> + * at_check_options - Range Checking for Command Line Parameters
> + * @adapter: board private structure
> + *
> + * This routine checks all command line parameters for valid user
> + * input.  If an invalid value is given, or if no user specified
> + * value exists, a default value is used.  The final value is stored
> + * in a variable in the adapter structure.
> + **/
> +
> +void __devinit at_check_options(struct at_adapter *adapter)
> +{
> +	int bd = adapter->bd_number;
> +	if (bd >= AT_MAX_NIC) {
> +		printk(KERN_NOTICE
> +		       "Warning: no configuration for board #%i\n", bd);
> +		printk(KERN_NOTICE "Using defaults for all values\n");
> +#ifndef module_param_array
> +		bd = AT_MAX_NIC;
> +#endif
> +	}
> +
> +	{ /* Transmit Descriptor Count */
> +		struct at_option opt = {
> +			.type = range_option,
> +			.name = "Transmit Descriptors",
> +			.err  = "using default of "
> +				__MODULE_STRING(AT_DEFAULT_TPD),
> +			.def  = AT_DEFAULT_TPD,
> +			.arg  = { .r = { .min = AT_MIN_TPD, .max = AT_MAX_TPD }}
> +		};
> +		struct at_tpd_ring *tpd_ring = &adapter->tpd_ring;
> +		int val;
> +#ifdef module_param_array
> +		if (num_TxDescriptors > bd) {
> +#endif
> +			val = TxDescriptors[bd];
> +			at_validate_option(&val, &opt);
> +			tpd_ring->count = ((uint16_t) val)&~1;
> +#ifdef module_param_array
> +		} else {
> +			tpd_ring->count = (uint16_t)opt.def;
> +		}
> +#endif
> +	}
> +
> +	{ /* Receive Descriptor Count */
> +		struct at_option opt = {
> +			.type = range_option,
> +			.name = "Receive Descriptors",
> +			.err  = "using default of "
> +				__MODULE_STRING(AT_DEFAULT_RFD),
> +			.def  = AT_DEFAULT_RFD,
> +			.arg  = { .r = { .min = AT_MIN_RFD, .max = AT_MAX_RFD }}
> +		};
> +		struct at_rfd_ring *rfd_ring = &adapter->rfd_ring;
> +        	struct at_rrd_ring * rrd_ring = &adapter->rrd_ring;
> +		int val;
> +#ifdef module_param_array
> +		if (num_RxDescriptors > bd) {
> +#endif
> +			val = RxDescriptors[bd];
> +			at_validate_option(&val, &opt);
> +			rrd_ring->count = rfd_ring->count = ((uint16_t)val)&~1;
> +				// even number
> +#ifdef module_param_array
> +		} else {
> +			rfd_ring->count = rrd_ring->count = (uint16_t)opt.def;
> +		}
> +#endif
> +	}
> +
> +	{ /* Interrupt Moderate Timer */
> +	    struct at_option opt = {
> +	        .type = range_option,
> +	        .name = "Interrupt Moderate Timer",
> +	        .err  = "using default of " __MODULE_STRING(DEFAULT_INT_MOD_CNT),
> +	        .def  = DEFAULT_INT_MOD_CNT,
> +	        .arg  = { .r = { .min = MIN_INT_MOD_CNT, .max = MAX_INT_MOD_CNT }}
> +	    } ;
> +        int val;
> +#ifdef module_param_array
> +		if (num_IntModTimer > bd) {
> +#endif
> +			val = IntModTimer[bd];
> +			at_validate_option(&val, &opt);
> +			adapter->imt = (uint16_t) val;
> +#ifdef module_param_array
> +		} else {
> +			adapter->imt = (uint16_t)(opt.def);
> +		}
> +#endif
> +	}
> +
> +	{ /* Flash Vendor */
> +	    struct at_option opt = {
> +	        .type = range_option,
> +	        .name = "SPI Flash Vendor",
> +	        .err  = "using default of " __MODULE_STRING(FLASH_VENDOR_DEFAULT),
> +	        .def  = DEFAULT_INT_MOD_CNT,
> +	        .arg  = { .r = { .min = FLASH_VENDOR_MIN, .max = FLASH_VENDOR_MAX }}
> +	    } ;
> +        int val;
> +#ifdef module_param_array
> +		if (num_FlashVendor > bd) {
> +#endif
> +			val = FlashVendor[bd];
> +			at_validate_option(&val, &opt);
> +			adapter->hw.flash_vendor = (uint8_t) val;
> +#ifdef module_param_array
> +		} else {
> +			adapter->hw.flash_vendor = (uint8_t)(opt.def);
> +		}
> +#endif
> +	}
> +
> +	{ /* MediaType */
> +	    struct at_option opt = {
> +	        .type = range_option,
> +	        .name = "Speed/Duplex Selection",
> +	        .err  = "using default of " __MODULE_STRING(MEDIA_TYPE_AUTO_SENSOR),
> +	        .def  = MEDIA_TYPE_AUTO_SENSOR,
> +	        .arg  = { .r = { .min = MEDIA_TYPE_AUTO_SENSOR, .max = MEDIA_TYPE_10M_HALF }}
> +	    } ;
> +        int val;
> +#ifdef module_param_array
> +		if (num_MediaType > bd) {
> +#endif
> +			val = MediaType[bd];
> +			at_validate_option(&val, &opt);
> +			adapter->hw.MediaType = (uint16_t) val;
> +#ifdef module_param_array
> +		} else {
> +			adapter->hw.MediaType = (uint16_t)(opt.def);
> +		}
> +#endif
> +	}
> +}
> +

This complexity is an argument for not using lots of module
options, and just use ethtool to change stuff.

> +
> +#ifdef SIOCDEVPRIVATE
> +#include <asm/uaccess.h>
> +
> +// set rfd buffer size. do not support !

/* C style comments are preferred */


..
> +int at_ethtool_ioctl(struct net_device *netdev, struct ifreq *ifr)
> +{
> +	struct at_adapter *adapter = netdev->priv;
> +	void *addr = ifr->ifr_data;
> +	uint32_t cmd;
> +
> +	if (get_user(cmd, (uint32_t *) addr))
> +		return -EFAULT;
> +

Do not do your own ethtool ioctl processing, to easy to get
wrong. Use ethtool_ops instead.


> +/* Removed large chunk of kcompat stuff -- JKC 09/2006 */
> +
> +/**
> + * at_probe - Device Initialization Routine
> + * @pdev: PCI device information struct
> + * @ent: entry in at_pci_tbl
> + *
> + * Returns 0 on success, negative on failure
> + *
> + * at_probe initializes an adapter identified by a pci_dev structure.
> + * The OS initialization, configuring of the adapter private structure,
> + * and a hardware reset occur.
> + **/
> +
> +static int __devinit
> +at_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> +{
> +	struct net_device *netdev;
> +	struct at_adapter *adapter;
> +	static int cards_found = 0;
> +	unsigned long mmio_start;
> +	int mmio_len;
> +	boolean_t pci_using_64 = TRUE;
> +	int err;
> +//	uint16_t eeprom_data;
> +
> +	DEBUGFUNC("at_probe !");
> +
> +	if ((err = pci_enable_device(pdev)))
> +		return err;
> +
> +	if ((err = pci_set_dma_mask(pdev, PCI_DMA_64BIT))) {
> +		if ((err = pci_set_dma_mask(pdev, PCI_DMA_32BIT))) {
> +			AT_ERR("No usable DMA configuration, aborting\n");
> +			return err;
> +		}
> +		pci_using_64 = FALSE;
> +	}
> +
> +
> +	// Mark all PCI regions associated with PCI device
> +	// pdev as being reserved by owner at_driver_name
> +	if ((err = pci_request_regions(pdev, at_driver_name)))
> +		return err;
> +
> +	// Enables bus-mastering on the device and calls
> +	// pcibios_set_master to do the needed arch specific settings
> +	pci_set_master(pdev);
> +
> +	netdev = alloc_etherdev(sizeof(struct at_adapter));
> +	if (!netdev) {
> +		err = -ENOMEM;
> +		goto err_alloc_etherdev;
> +	}
> +
> +	SET_MODULE_OWNER(netdev);
> +	SET_NETDEV_DEV(netdev, &pdev->dev);
> +
> +	pci_set_drvdata(pdev, netdev);
> +	adapter = netdev_priv(netdev);
> +	adapter->netdev = netdev;
> +	adapter->pdev = pdev;
> +	adapter->hw.back = adapter;
> +
> +	mmio_start = pci_resource_start(pdev, BAR_0);
> +	mmio_len = pci_resource_len(pdev, BAR_0);
> +
> +	/* AT_DBG("base memory = %lx memory length = %x \n",
> +	mmio_start, mmio_len); FIXME */
> +	adapter->hw.mem_rang = (uint32_t)mmio_len;
> +	adapter->hw.hw_addr = ioremap_nocache(mmio_start, mmio_len);
> +	if (!adapter->hw.hw_addr) {
> +		err = -EIO;
> +		goto err_ioremap;
> +	}
> +	/* get device reversion number */
> +	adapter->hw.dev_rev = AT_READ_REGW(&adapter->hw, (REG_MASTER_CTRL+2));
> +
> +	netdev->open = &at_open;
> +	netdev->stop = &at_close;
> +	netdev->hard_start_xmit = &at_xmit_frame;
> +	netdev->get_stats = &at_get_stats;
> +	netdev->set_multicast_list = &at_set_multi;
> +	netdev->set_mac_address = &at_set_mac;
> +	netdev->change_mtu = &at_change_mtu;
> +	netdev->do_ioctl = &at_ioctl;
> +#ifdef HAVE_TX_TIMEOUT
> +	netdev->tx_timeout = &at_tx_timeout;
> +	netdev->watchdog_timeo = 5 * HZ;
> +#endif
> +#ifdef NETIF_F_HW_VLAN_TX
> +	netdev->vlan_rx_register = at_vlan_rx_register;
> +	netdev->vlan_rx_add_vid = at_vlan_rx_add_vid;
> +	netdev->vlan_rx_kill_vid = at_vlan_rx_kill_vid;
> +#endif
> +
> +	netdev->mem_start = mmio_start;
> +	netdev->mem_end = mmio_start + mmio_len;
> +	//netdev->base_addr = adapter->io_base;
> +	adapter->bd_number = cards_found;
> +	adapter->pci_using_64 = pci_using_64;
> +
> +	/* setup the private structure */
> +
> +	if ((err = at_sw_init(adapter)))
> +		goto err_sw_init;
> +
> +	netdev->features = NETIF_F_HW_CSUM;
> +
> +#ifdef MAX_SKB_FRAGS
> +	netdev->features |= NETIF_F_SG;
> +#endif
> +#ifdef NETIF_F_HW_VLAN_TX
> +	netdev->features |= NETIF_F_HW_VLAN_TX | NETIF_F_HW_VLAN_RX;
> +#endif
> +#ifdef NETIF_F_TSO
> +	netdev->features |= NETIF_F_TSO;
> +#endif/*NETIF_F_TSO*/
> +
> +	if (pci_using_64) {
> +		netdev->features |= NETIF_F_HIGHDMA;
> +		/* AT_DBG("pci using 64bit address\n"); FIXME */
> +	}
> +#ifdef NETIF_F_LLTX
> +	netdev->features |= NETIF_F_LLTX;
> +#endif
> +
> +	/* patch for some L1 of old version,
> +	 * the final version of L1 may not need these
> +	 * patches
> +	 */
> +	at_pcie_patch(adapter);
> +
> +	/* really reset GPHY core */
> +	AT_WRITE_REGW(&adapter->hw, REG_GPHY_ENABLE, 0);
> +
> +	/* reset the controller to
> +	 * put the device in a known good starting state */
> +
> +	if (at_reset_hw(&adapter->hw)) {
> +		err = -EIO;
> +		goto err_reset;
> +	}
> +
> +	/* copy the MAC address out of the EEPROM */
> +
> +	at_read_mac_addr(&adapter->hw);
> +	memcpy(netdev->dev_addr, adapter->hw.mac_addr, netdev->addr_len);
> +
> +	if (!is_valid_ether_addr(netdev->dev_addr)) {
> +		err = -EIO;
> +		goto err_eeprom;
> +	}
> +
> +	/*
> +	AT_DBG("mac address : %02x-%02x-%02x-%02x-%02x-%02x\n",
> +		adapter->hw.mac_addr[0],
> +		adapter->hw.mac_addr[1],
> +		adapter->hw.mac_addr[2],
> +		adapter->hw.mac_addr[3],
> +		adapter->hw.mac_addr[4],
> +		adapter->hw.mac_addr[5] );
> +	*/
> +
> +	at_check_options(adapter);
> +
> +	/* pre-init the MAC, and setup link */
> +
> +	if ((err = at_init_hw(&adapter->hw))) {
> +		err = -EIO;
> +		goto err_init_hw;
> +	}
> +
> +	/* assume we have no link for now */
> +
> +	netif_carrier_off(netdev);
> +	netif_stop_queue(netdev);
> +
> +	init_timer(&adapter->watchdog_timer);
> +	adapter->watchdog_timer.function = &at_watchdog;
> +	adapter->watchdog_timer.data = (unsigned long) adapter;
> +
> +	init_timer(&adapter->phy_config_timer);
> +	adapter->phy_config_timer.function = &at_phy_config;
> +	adapter->phy_config_timer.data = (unsigned long) adapter;
> +	adapter->phy_timer_pending = FALSE;
> +
> +	INIT_WORK(&adapter->tx_timeout_task,
> +		 (void (*)(void *))at_tx_timeout_task, netdev);
> +
> +	INIT_WORK(&adapter->link_chg_task,
> +        	 (void (*)(void *))at_link_chg_task, netdev);
> +
> +	INIT_WORK(&adapter->pcie_dma_to_rst_task,
> +        	 (void (*)(void *))at_tx_timeout_task, netdev);
> +
> +	if ((err = register_netdev(netdev)))
> +		goto err_register;
> +
> +    	cards_found++;
> +	at_via_workaround(adapter);
> +
> +	return 0;
> +
> +err_init_hw:
> +err_reset:
> +err_register:
> +err_sw_init:
> +err_eeprom:
> +	iounmap(adapter->hw.hw_addr);
> +err_ioremap:
> +	free_netdev(netdev);
> +err_alloc_etherdev:
> +	pci_release_regions(pdev);
> +	return err;
> +}
...

> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 6a1e098..1eb6f80 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2042,6 +2042,9 @@ #define PCI_VENDOR_ID_TOPSPIN		0x1867
>  #define PCI_VENDOR_ID_TDI               0x192E
>  #define PCI_DEVICE_ID_TDI_EHCI          0x0101
>  
> +#define PCI_VENDOR_ID_ATTANSIC		0x1969
> +#define PCI_DEVICE_ID_ATTANSIC_L1	0x1048
> +
>  #define PCI_VENDOR_ID_JMICRON		0x197B
>  #define PCI_DEVICE_ID_JMICRON_JMB360	0x2360
>  #define PCI_DEVICE_ID_JMICRON_JMB361	0x2361

Don't bother with PCI id's update, for each sub device.
Vendor is probably useful.

-- 
Stephen Hemminger <shemminger@osdl.org>
