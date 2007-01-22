Return-Path: <linux-kernel-owner+w=401wt.eu-S1751875AbXAVChs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbXAVChs (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 21:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbXAVChs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 21:37:48 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:30459 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbXAVChr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 21:37:47 -0500
Date: Sun, 21 Jan 2007 18:31:51 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Jay Cliburn <jacliburn@bellsouth.net>
Cc: jeff@garzik.org, shemminger@osdl.org, csnook@redhat.com, hch@infradead.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       atl1-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/4] atl1: Ancillary C files for Attansic L1 driver
Message-Id: <20070121183151.4be61ebf.randy.dunlap@oracle.com>
In-Reply-To: <20070121210737.GE2702@osprey.hogchain.net>
References: <20070121210737.GE2702@osprey.hogchain.net>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jan 2007 15:07:37 -0600 Jay Cliburn wrote:

> This patch contains auxiliary C files for the Attansic L1 gigabit ethernet
> adapter driver.
> 
> Signed-off-by: Jay Cliburn <jacliburn@bellsouth.net>
> Signed-off-by: Chris Snook <csnook@redhat.com>
> ---
> 
>  atl1_ethtool.c |  436 ++++++++++++++++++++++++++++++++++
>  atl1_hw.c      |  728 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  atl1_param.c   |  223 +++++++++++++++++
>  3 files changed, 1387 insertions(+)
> 
> diff --git a/drivers/net/atl1/atl1_ethtool.c b/drivers/net/atl1/atl1_ethtool.c
> new file mode 100644
> index 0000000..4c6e505
> --- /dev/null
> +++ b/drivers/net/atl1/atl1_ethtool.c
> @@ -0,0 +1,436 @@
> +/**

Please use "/**" _only_ to begin kernel-doc comments
(and this is not a kernel-doc comment).
(occurs at multiple other places in this and the other patches)

> + * Copyright(c) 2005 - 2006 Attansic Corporation. All rights reserved.
> + * Copyright(c) 2006 Chris Snook <csnook@redhat.com>
> + * Copyright(c) 2006 Jay Cliburn <jcliburn@gmail.com>
> + * 
> + * Derived from Intel e1000 driver
> + * Copyright(c) 1999 - 2005 Intel Corporation. All rights reserved.
> + * 
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the Free
> + * Software Foundation; either version 2 of the License, or (at your option)
> + * any later version.
> + * 
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + * 
> + * You should have received a copy of the GNU General Public License along with
> + * this program; if not, write to the Free Software Foundation, Inc., 59
> + * Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> + **/
> +
> +
> +static int atl1_get_settings(struct net_device *netdev, struct ethtool_cmd *ecmd)
> +{
> +	struct atl1_adapter *adapter = netdev_priv(netdev);
> +	struct atl1_hw *hw = &adapter->hw;
> +
> +	ecmd->supported = (SUPPORTED_10baseT_Half |
> +			   SUPPORTED_10baseT_Full |
> +			   SUPPORTED_100baseT_Half |
> +			   SUPPORTED_100baseT_Full |
> +			   SUPPORTED_1000baseT_Full |
> +			   SUPPORTED_Autoneg | SUPPORTED_TP);
> +	ecmd->advertising = ADVERTISED_TP;
> +	if (hw->media_type == MEDIA_TYPE_AUTO_SENSOR ||
> +	    hw->media_type == MEDIA_TYPE_1000M_FULL) {
> +		ecmd->advertising |= ADVERTISED_Autoneg;
> +		if (hw->media_type == MEDIA_TYPE_AUTO_SENSOR) {
> +			ecmd->advertising |= ADVERTISED_Autoneg;
> +			ecmd->advertising |=
> +			    (ADVERTISED_10baseT_Half |
> +			     ADVERTISED_10baseT_Full |
> +			     ADVERTISED_100baseT_Half |
> +			     ADVERTISED_100baseT_Full |
> +			     ADVERTISED_1000baseT_Full);
> +		} else {
> +			ecmd->advertising |= (ADVERTISED_1000baseT_Full);

Kernel coding style is not to use braces around one-statement "blocks."
(occurs in multiple other places)

> +		}
> +	}
> +	ecmd->port = PORT_TP;
> +	ecmd->phy_address = 0;
> +	ecmd->transceiver = XCVR_INTERNAL;
> +
> +	if (netif_carrier_ok(adapter->netdev)) {
> +		u16 link_speed, link_duplex;
> +		atl1_get_speed_and_duplex(hw, &link_speed, &link_duplex);
> +		ecmd->speed = link_speed;
> +		if (link_duplex == FULL_DUPLEX)
> +			ecmd->duplex = DUPLEX_FULL;
> +		else
> +			ecmd->duplex = DUPLEX_HALF;
> +	} else {
> +		ecmd->speed = -1;
> +		ecmd->duplex = -1;
> +	}
> +	if (hw->media_type == MEDIA_TYPE_AUTO_SENSOR ||
> +	    hw->media_type == MEDIA_TYPE_1000M_FULL) {
> +		ecmd->autoneg = AUTONEG_ENABLE;
> +	} else {
> +		ecmd->autoneg = AUTONEG_DISABLE;
> +	}
> +	
> +	return 0;
> +}
> +
> +static int atl1_set_settings(struct net_device *netdev, struct ethtool_cmd *ecmd)
> +{
> +	struct atl1_adapter *adapter = netdev_priv(netdev);
> +	struct atl1_hw *hw = &adapter->hw;
> +	u16 phy_data;
> +	int ret_val = 0;
> +	u16 old_media_type = hw->media_type;
> +
> +	if (netif_running(adapter->netdev)) {
> +		printk(KERN_DEBUG "%s: ethtool shutting down link adapter\n", 

What's a "link adapter"?

> +			atl1_driver_name);
> +		atl1_down(adapter);
> +	}
> +
> +	if (ecmd->autoneg == AUTONEG_ENABLE) {
> +		hw->media_type = MEDIA_TYPE_AUTO_SENSOR;
> +	} else {
> +		if (ecmd->speed == SPEED_1000) {
> +			if (ecmd->duplex != DUPLEX_FULL) {
> +				printk(KERN_WARNING
> +				       "%s: can't force to 1000M half duplex\n",
> +					atl1_driver_name);
> +				ret_val = -EINVAL;
> +				goto exit_sset;
> +			}
> +			hw->media_type = MEDIA_TYPE_1000M_FULL;
> +		} else if (ecmd->speed == SPEED_100) {
> +			if (ecmd->duplex == DUPLEX_FULL) {
> +				hw->media_type = MEDIA_TYPE_100M_FULL;
> +			} else {
> +				hw->media_type = MEDIA_TYPE_100M_HALF;
> +			}
> +		} else {
> +			if (ecmd->duplex == DUPLEX_FULL) {
> +				hw->media_type = MEDIA_TYPE_10M_FULL;
> +			} else {
> +				hw->media_type = MEDIA_TYPE_10M_HALF;
> +			}
> +		}
> +	}

...

> +}
> +
> +static void atl1_get_drvinfo(struct net_device *netdev,
> +				struct ethtool_drvinfo *drvinfo)
> +{
> +	struct atl1_adapter *adapter = netdev_priv(netdev);
> +
> +	strncpy(drvinfo->driver, atl1_driver_name, 32);
> +	strncpy(drvinfo->version, atl1_driver_version, 32);
> +	strncpy(drvinfo->fw_version, "N/A", 32);
> +	strncpy(drvinfo->bus_info, pci_name(adapter->pdev), 32);

Use sizeof(drvinfo->driver) etc. above instead of "32".

> +	drvinfo->eedump_len = 48;
> +}
> +
> +

> diff --git a/drivers/net/atl1/atl1_hw.c b/drivers/net/atl1/atl1_hw.c
> new file mode 100644
> index 0000000..4062abd
> --- /dev/null
> +++ b/drivers/net/atl1/atl1_hw.c
> @@ -0,0 +1,728 @@
> +
> +extern char atl1_driver_name[];

Externs should be in header files.

> +/**
> + * Reset the transmit and receive units; mask and clear all interrupts.
> + * hw - Struct containing variables accessed by shared code
> + * return : ATL1_SUCCESS  or  idle status (if error)
> + **/

This function comment block is almost kernel-doc...
It would be good to make it so.

> +s32 atl1_reset_hw(struct atl1_hw * hw)

                                    *hw)


> +{
...
> +}
> +
> +/** function about EEPROM
> + *
> + * check_eeprom_exist
> + * return 0 if eeprom exist
> + **/

Use kernel-doc format or don't begin comment block with /**.
See Documentation/kernel-doc-nano-HOWTO.txt for info.
(multiple places)

> +static int atl1_check_eeprom_exist(struct atl1_hw *hw)
> +{
> +	u32 value;
> +	value = ioread32(hw->hw_addr + REG_SPI_FLASH_CTRL);
> +	if (value & SPI_FLASH_CTRL_EN_VPD) {
> +		value &= ~SPI_FLASH_CTRL_EN_VPD;
> +		iowrite32(value, hw->hw_addr + REG_SPI_FLASH_CTRL);
> +	}
> +
> +	value = ioread16(hw->hw_addr + REG_PCIE_CAP_LIST);
> +	return ((value & 0xFF00) == 0x6C00) ? 0 : 1;

Are there defines or enums for these?
Fewer magic numbers would be nice/helpful/readable.

> +}
> +
> +static bool atl1_read_eeprom(struct atl1_hw *hw, u32 offset, u32 * p_value)

                                                                    *p_value)

> +{
...
> +}
> +
> +/**
> + * Reads the value from a PHY register
> + * hw - Struct containing variables accessed by shared code
> + * reg_addr - address of the PHY register to read
> + **/

kernel-doc

> +s32 atl1_read_phy_reg(struct atl1_hw * hw, u16 reg_addr, u16 * phy_data)

CodingStyle:  *hw, ... *phy_data)

> +{
...
> +}
> +
> +#define CUSTOM_SPI_CS_SETUP	2
> +#define CUSTOM_SPI_CLK_HI	2
> +#define CUSTOM_SPI_CLK_LO	2
> +#define CUSTOM_SPI_CS_HOLD	2
> +#define CUSTOM_SPI_CS_HI	3
> +
> +static bool atl1_spi_read(struct atl1_hw *hw, u32 addr, u32 * buf)
> +{
...
> +}
> +
> +/**
> + * get_permanent_address
> + * return 0 if get valid mac address, 
> + **/

kernel-doc

> +int atl1_get_permanent_address(struct atl1_hw *hw)
> +{
> +	u32 addr[2];
> +	u32 i, control;
> +	u16 reg;
> +	u8 eth_addr[NODE_ADDRESS_SIZE];

Use ETH_ALEN from if_ether.h instead of your own NODE_ADDRESS_SIZE.

> +	bool key_valid;
> +
> +	if (is_valid_ether_addr(hw->perm_mac_addr))
> +		return 0;
> +	}
...
> +}
> +
> +
> +/**
> + * Make L001's PHY out of Power Saving State (bug)
> + * hw - Struct containing variables accessed by shared code
> + * when power on, L001's PHY always on Power saving State
> + * (Gigabit Link forbidden)
> + **/
> +static s32 atl1_phy_leave_power_saving(struct atl1_hw *hw)
> +{
> +	s32 ret;
> +	ret = atl1_write_phy_reg(hw, 29, 0x0029);

Fewer magic numbers?

> +	if (ret)
> +		return ret;
> +	return atl1_write_phy_reg(hw, 30, 0);
> +}

> diff --git a/drivers/net/atl1/atl1_param.c b/drivers/net/atl1/atl1_param.c
> new file mode 100644
> index 0000000..4732f43
> --- /dev/null
> +++ b/drivers/net/atl1/atl1_param.c
> @@ -0,0 +1,223 @@
> +
> +#include <linux/types.h>
> +#include <linux/pci.h>
> +#include <linux/moduleparam.h>
> +#include "atl1.h"
> +
> +extern char atl1_driver_name[];

in a header file, please.

> +/**
> + * This is the only thing that needs to be changed to adjust the
> + * maximum number of ports that the driver can manage.
> + **/
> +#define ATL1_MAX_NIC 4
> +
> +#define OPTION_UNSET    -1
> +#define OPTION_DISABLED 0
> +#define OPTION_ENABLED  1
> +
> +#define ATL1_PARAM_INIT { [0 ... ATL1_MAX_NIC] = OPTION_UNSET }
> +
> +/**
> + * Interrupt Moderate Timer in units of 2 us
> + *
> + * Valid Range: 10-65535
> + *
> + * Default Value: 100 (200us)
> + **/
> +static int __devinitdata int_mod_timer[ATL1_MAX_NIC+1] = ATL1_PARAM_INIT;
> +static int num_int_mod_timer = 0;
> +module_param_array_named(int_mod_timer, int_mod_timer, int, &num_int_mod_timer, 0);
> +MODULE_PARM_DESC(int_mod_timer, "Interrupt moderator timer");
> +
> +/**
> + * flash_vendor
> + *
> + * Valid Range: 0-2
> + *
> + * 0 - Atmel
> + * 1 - SST
> + * 2 - ST
> + *
> + * Default Value: 0
> + **/
> +static int __devinitdata flash_vendor[ATL1_MAX_NIC+1] = ATL1_PARAM_INIT;
> +static int num_flash_vendor = 0;
> +module_param_array_named(flash_vendor, flash_vendor, int, &num_flash_vendor, 0);
> +MODULE_PARM_DESC(flash_vendor, "SPI flash vendor");
> +
> +int enable_msi;
> +module_param(enable_msi, int, 0444);
> +MODULE_PARM_DESC(enable_msi, "Enable PCI MSI");

Hm, I thought that we didn't want individual drivers having MSI config
options...

> +
> +#define DEFAULT_INT_MOD_CNT	100	/* 200us */
> +#define MAX_INT_MOD_CNT		65000
> +#define MIN_INT_MOD_CNT		50
> +
> +#define FLASH_VENDOR_DEFAULT	0
> +#define FLASH_VENDOR_MIN	0
> +#define FLASH_VENDOR_MAX	2
> +
> +
> +
> +/**
> + * atl1_check_options - Range Checking for Command Line Parameters
> + * @adapter: board private structure
> + *
> + * This routine checks all command line parameters for valid user
> + * input.  If an invalid value is given, or if no user specified
> + * value exists, a default value is used.  The final value is stored
> + * in a variable in the adapter structure.
> + **/

Hey, it's kernel-doc. :)

> +void __devinit atl1_check_options(struct atl1_adapter *adapter)
> +{
> +
...
> +	{			/* PCI MSI usage */
> +
> +#ifdef CONFIG_PCI_MSI
> +		adapter->enable_msi = enable_msi;
> +#else
> +		adapter->enable_msi = 0;
> +#endif
> +	}
> +}
> -

---
~Randy
