Return-Path: <linux-kernel-owner+w=401wt.eu-S932865AbXASDBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932865AbXASDBS (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 22:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932866AbXASDBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 22:01:18 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:47620 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932865AbXASDBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 22:01:16 -0500
Message-ID: <45B03468.5010107@garzik.org>
Date: Thu, 18 Jan 2007 22:00:56 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Jay Cliburn <jacliburn@bellsouth.net>
CC: shemminger@osdl.org, csnook@redhat.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, atl1-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/4] atl1: Ancillary C files for Attansic L1 driver
References: <20070111004316.GE2624@osprey.hogchain.net>
In-Reply-To: <20070111004316.GE2624@osprey.hogchain.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Cliburn wrote:
> +static u32 atl1_get_tx_csum(struct net_device *netdev)
> +{
> +	return (netdev->features & NETIF_F_HW_CSUM) != 0;
> +}
> +
> +static int atl1_set_tx_csum(struct net_device *netdev, u32 data)
> +{
> +	if (data)
> +		netdev->features |= NETIF_F_HW_CSUM;
> +	else
> +		netdev->features &= ~NETIF_F_HW_CSUM;
> +
> +	return 0;
> +}
> +
> +static int atl1_set_tso(struct net_device *netdev, u32 data)
> +{
> +	if (data)
> +		netdev->features |= NETIF_F_TSO;
> +	else
> +		netdev->features &= ~NETIF_F_TSO;
> +	return 0;
> +}

There should be generic functions covering this.

> +static u32 ether_crc_le(int length, unsigned char *data)
> +{
> +	u32 crc = ~0;		/* Initial value. */
> +	while (--length >= 0) {
> +		unsigned char current_octet = *data++;
> +		int bit;
> +		for (bit = 8; --bit >= 0; current_octet >>= 1) {
> +			if ((crc ^ current_octet) & 1) {
> +				crc >>= 1;
> +				crc ^= 0xedb88320;
> +			} else
> +				crc >>= 1;
> +		}
> +	}
> +	return ~crc;
> +}

this duplicates a library function


> +/**
> + * Reset the transmit and receive units; mask and clear all interrupts.
> + * hw - Struct containing variables accessed by shared code
> + * return : ATL1_SUCCESS  or  idle status (if error)
> + **/
> +s32 atl1_reset_hw(struct atl1_hw * hw)
> +{
> +	u32 icr;
> +	u16 pci_cfg_cmd_word;
> +	int i;
> +
> +	/* Workaround for PCI problem when BIOS sets MMRBC incorrectly. */
> +	atl1_read_pci_cfg(hw, PCI_REG_COMMAND, &pci_cfg_cmd_word);
> +	if ((pci_cfg_cmd_word &
> +	     (CMD_IO_SPACE | CMD_MEMORY_SPACE | CMD_BUS_MASTER))
> +	    != (CMD_IO_SPACE | CMD_MEMORY_SPACE | CMD_BUS_MASTER)) {
> +		pci_cfg_cmd_word |=
> +		    (CMD_IO_SPACE | CMD_MEMORY_SPACE | CMD_BUS_MASTER);
> +		atl1_write_pci_cfg(hw, PCI_REG_COMMAND, &pci_cfg_cmd_word);
> +	}

This duplicates bits set by pci_enable_device() and pci_set_master()


> +	/** 
> +	 * Clear Interrupt mask to stop board from generating
> +	 * interrupts & Clear any pending interrupt events 
> +	 **/
> +	/**
> +	 * atl1_write32(hw, REG_IMR, 0);
> +	 * atl1_write32(hw, REG_ISR, 0xffffffff);
> +	 **/
> +
> +	/**
> +	 * Issue Soft Reset to the MAC.  This will reset the chip's
> +	 * transmit, receive, DMA.  It will not effect
> +	 * the current PCI configuration.  The global reset bit is self-
> +	 * clearing, and should clear within a microsecond.
> +	 **/
> +	/*atl1_write32(hw, REG_MASTER_CTRL, MASTER_CTRL_SOFT_RST);*/
> +	atl1_write32(hw, REG_MASTER_CTRL, MASTER_CTRL_SOFT_RST);
> +	wmb();

PCI posting (need to read a register before delaying to guarantee flush; 
probably makes wmb superfluous)


> +	atl1_write16(hw, REG_GPHY_ENABLE, 1);
> +
> +	msec_delay(1);		/* delay about 1ms */

ditto


> +	/* Wait at least 10ms for All module to be Idle */
> +	for (i = 0; i < 10; i++) {
> +		icr = atl1_read32(hw, REG_IDLE_STATUS);
> +		if (!icr)
> +			break;
> +		msec_delay(1);	/* delay 1 ms */
> +		cpu_relax();	/* FIXME: is this still the right way to do this? */
> +	}
> +
> +	if (icr)
> +		return icr;
> +
> +	return ATL1_SUCCESS;
> +}
> +
> +static inline bool atl1_eth_address_valid(u8 * p_addr)
> +{
> +	/* Invalid PermanentAddress ? */
> +	if (((p_addr[0] == 0) &&
> +	     (p_addr[1] == 0) &&
> +	     (p_addr[2] == 0) &&
> +	     (p_addr[3] == 0) && (p_addr[4] == 0) && (p_addr[5] == 0)
> +	    ) || (p_addr[0] & 1)) 
> +		/* Multicast address or Broadcast Address */
> +		return false;
> +
> +	return true;

look at is_valid_ether_addr() lib function


> +	if (atl1_get_permanent_address(hw)) {
> +		hw->perm_mac_addr[0] = 0x00;
> +		hw->perm_mac_addr[1] = 0x13;
> +		hw->perm_mac_addr[2] = 0x74;
> +		hw->perm_mac_addr[3] = 0x00;
> +		hw->perm_mac_addr[4] = 0x5c;
> +		hw->perm_mac_addr[5] = 0x38;
> +	}

standard technique is to use random bytes, not a fixed address like 
this, when MAC address is otherwise unavailable.  consider what happens 
when two MACs are present.



> +	for (i = 0; i < NODE_ADDRESS_SIZE; i++)
> +		hw->mac_addr[i] = hw->perm_mac_addr[i];
> +	return ATL1_SUCCESS;
> +}
> +
> +/**
> + * Hashes an address to determine its location in the multicast table
> + * hw - Struct containing variables accessed by shared code
> + * mc_addr - the multicast address to hash
> + *
> + * atl1_hash_mc_addr
> + *  purpose
> + *      set hash value for a multicast address
> + *      hash calcu processing :
> + *          1. calcu 32bit CRC for multicast address
> + *          2. reverse crc with MSB to LSB
> + **/
> +u32 atl1_hash_mc_addr(struct atl1_hw * hw, u8 * mc_addr)
> +{
> +	u32 crc32, value = 0;
> +	int i;
> +
> +	crc32 = ether_crc_le(6, mc_addr);
> +	crc32 = ~crc32;
> +	for (i = 0; i < 32; i++)
> +		value |= (((crc32 >> i) & 1) << (31 - i));
> +
> +	return value;
> +}
> +
> +/**
> + * Sets the bit in the multicast table corresponding to the hash value.
> + * hw - Struct containing variables accessed by shared code
> + * hash_value - Multicast address hash value
> + **/
> +void atl1_hash_set(struct atl1_hw *hw, u32 hash_value)
> +{
> +	u32 hash_bit, hash_reg;
> +	u32 mta;
> +
> +	/**
> +	 * The HASH Table  is a register array of 2 32-bit registers.
> +	 * It is treated like an array of 64 bits.  We want to set
> +	 * bit BitArray[hash_value]. So we figure out what register
> +	 * the bit is in, read it, OR in the new bit, then write
> +	 * back the new value.  The register is determined by the
> +	 * upper 7 bits of the hash value and the bit within that
> +	 * register are determined by the lower 5 bits of the value.
> +	 **/
> +	hash_reg = (hash_value >> 31) & 0x1;
> +	hash_bit = (hash_value >> 26) & 0x1F;
> +
> +	mta = atl1_read32_array(hw, REG_RX_HASH_TABLE, hash_reg);
> +
> +	mta |= (1 << hash_bit);
> +
> +	atl1_write32_array(hw, REG_RX_HASH_TABLE, hash_reg, mta);
> +}
> +
> +/**
> + * Writes a value to a PHY register
> + * hw - Struct containing variables accessed by shared code
> + * reg_addr - address of the PHY register to write
> + * data - data to write to the PHY
> + **/
> +s32 atl1_write_phy_reg(struct atl1_hw *hw, u32 reg_addr, u16 phy_data)
> +{
> +	int i;
> +	u32 val;
> +
> +	val = ((u32) (phy_data & MDIO_DATA_MASK)) << MDIO_DATA_SHIFT |
> +	    (reg_addr & MDIO_REG_ADDR_MASK) << MDIO_REG_ADDR_SHIFT |
> +	    MDIO_SUP_PREAMBLE |
> +	    MDIO_START | MDIO_CLK_25_4 << MDIO_CLK_SEL_SHIFT;
> +	atl1_write32(hw, REG_MDIO_CTRL, val);
> +
> +	wmb();

wmb == attempt at PCI posting?


> +	for (i = 0; i < MDIO_WAIT_TIMES; i++) {
> +		usec_delay(2);
> +		val = atl1_read32(hw, REG_MDIO_CTRL);
> +		if (!(val & (MDIO_START | MDIO_BUSY)))
> +			break;
> +		wmb();

ditto


> +	}
> +
> +	if (!(val & (MDIO_START | MDIO_BUSY)))
> +		return ATL1_SUCCESS;
> +
> +	return ATL1_ERR_PHY;
> +}
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
> +	if ((ret = atl1_write_phy_reg(hw, 29, 0x0029)))
> +		return ret;
> +	return atl1_write_phy_reg(hw, 30, 0);
> +}
> +
> +/**
> + *TODO: do something or get rid of this
> + **/
> +s32 atl1_phy_enter_power_saving(struct atl1_hw * hw)
> +{
> +/*    s32 ret_val;
> + *    u16 phy_data;
> + */
> +
> +/*
> +    ret_val = atl1_write_phy_reg(hw, ...);
> +    ret_val = atl1_write_phy_reg(hw, ...);
> +    ....
> +*/
> +	return ATL1_SUCCESS;
> +}
> +
> +/**
> + * Resets the PHY and make all config validate
> + * hw - Struct containing variables accessed by shared code
> + *
> + * Sets bit 15 and 12 of the MII Control regiser (for F001 bug)
> + **/
> +static s32 atl1_phy_reset(struct atl1_hw *hw)
> +{
> +	s32 ret_val;
> +	u16 phy_data;
> +
> +	if (hw->media_type == MEDIA_TYPE_AUTO_SENSOR ||
> +	    hw->media_type == MEDIA_TYPE_1000M_FULL) {
> +		phy_data = MII_CR_RESET | MII_CR_AUTO_NEG_EN;
> +	} else {
> +		switch (hw->media_type) {
> +		case MEDIA_TYPE_100M_FULL:
> +			phy_data =
> +			    MII_CR_FULL_DUPLEX | MII_CR_SPEED_100 |
> +			    MII_CR_RESET;
> +			break;
> +		case MEDIA_TYPE_100M_HALF:
> +			phy_data = MII_CR_SPEED_100 | MII_CR_RESET;
> +			break;
> +		case MEDIA_TYPE_10M_FULL:
> +			phy_data =
> +			    MII_CR_FULL_DUPLEX | MII_CR_SPEED_10 | MII_CR_RESET;
> +			break;
> +		default:	/* MEDIA_TYPE_10M_HALF: */
> +			phy_data = MII_CR_SPEED_10 | MII_CR_RESET;
> +			break;
> +		}
> +	}
> +
> +	ret_val = atl1_write_phy_reg(hw, MII_BMCR, phy_data);
> +	if (ret_val) {
> +		u32 val;
> +		int i;
> +		/**************************************
> +		 * pcie serdes link may be down !
> +		 **************************************/
> +		printk(KERN_DEBUG "%s: autoneg caused pcie phy link down\n", 
> +			atl1_driver_name);
> +
> +		for (i = 0; i < 25; i++) {
> +			msec_delay(1);
> +			val = atl1_read32(hw, REG_MDIO_CTRL);
> +			if (!(val & (MDIO_START | MDIO_BUSY)))
> +				break;
> +		}
> +
> +		if (0 != (val & (MDIO_START | MDIO_BUSY))) {
> +			printk(KERN_WARNING 
> +				"%s: pcie link down at least for 25ms\n", 
> +				atl1_driver_name);
> +			return ret_val;
> +		}
> +	}
> +	return ATL1_SUCCESS;
> +}
> +
> +/**
> + * Configures PHY autoneg and flow control advertisement settings
> + * hw - Struct containing variables accessed by shared code
> + **/
> +s32 atl1_phy_setup_autoneg_adv(struct atl1_hw * hw)
> +{
> +	s32 ret_val;
> +	s16 mii_autoneg_adv_reg;
> +	s16 mii_1000t_ctrl_reg;
> +
> +	/* Read the MII Auto-Neg Advertisement Register (Address 4). */
> +	mii_autoneg_adv_reg = MII_AR_DEFAULT_CAP_MASK;
> +
> +	/* Read the MII 1000Base-T Control Register (Address 9). */
> +	mii_1000t_ctrl_reg = MII_AT001_CR_1000T_DEFAULT_CAP_MASK;
> +
> +	/**
> +	 * First we clear all the 10/100 mb speed bits in the Auto-Neg
> +	 * Advertisement Register (Address 4) and the 1000 mb speed bits in
> +	 * the  1000Base-T Control Register (Address 9).
> +	 **/
> +	mii_autoneg_adv_reg &= ~MII_AR_SPEED_MASK;
> +	mii_1000t_ctrl_reg &= ~MII_AT001_CR_1000T_SPEED_MASK;
> +
> +	/**
> +	 * Need to parse media_type  and set up
> +	 * the appropriate PHY registers.
> +	 **/
> +	switch (hw->media_type) {
> +	case MEDIA_TYPE_AUTO_SENSOR:
> +		mii_autoneg_adv_reg |= (MII_AR_10T_HD_CAPS |
> +					MII_AR_10T_FD_CAPS |
> +					MII_AR_100TX_HD_CAPS |
> +					MII_AR_100TX_FD_CAPS);
> +		mii_1000t_ctrl_reg |= MII_AT001_CR_1000T_FD_CAPS;
> +		break;
> +
> +	case MEDIA_TYPE_1000M_FULL:
> +		mii_1000t_ctrl_reg |= MII_AT001_CR_1000T_FD_CAPS;
> +		break;
> +
> +	case MEDIA_TYPE_100M_FULL:
> +		mii_autoneg_adv_reg |= MII_AR_100TX_FD_CAPS;
> +		break;
> +
> +	case MEDIA_TYPE_100M_HALF:
> +		mii_autoneg_adv_reg |= MII_AR_100TX_HD_CAPS;
> +		break;
> +
> +	case MEDIA_TYPE_10M_FULL:
> +		mii_autoneg_adv_reg |= MII_AR_10T_FD_CAPS;
> +		break;
> +
> +	default:
> +		mii_autoneg_adv_reg |= MII_AR_10T_HD_CAPS;
> +		break;
> +	}
> +
> +	/* flow control fixed to enable all */
> +	mii_autoneg_adv_reg |= (MII_AR_ASM_DIR | MII_AR_PAUSE);
> +
> +	hw->mii_autoneg_adv_reg = mii_autoneg_adv_reg;
> +	hw->mii_1000t_ctrl_reg = mii_1000t_ctrl_reg;
> +
> +	ret_val = atl1_write_phy_reg(hw, MII_ADVERTISE, mii_autoneg_adv_reg);
> +	if (ret_val)
> +		return ret_val;
> +
> +	ret_val = atl1_write_phy_reg(hw, MII_AT001_CR, mii_1000t_ctrl_reg);
> +	if (ret_val)
> +		return ret_val;
> +
> +	return ATL1_SUCCESS;
> +}
> +
> +/**
> + * Configures link settings.
> + * hw - Struct containing variables accessed by shared code
> + * Assumes the hardware has previously been reset and the
> + * transmitter and receiver are not enabled.
> + **/
> +static s32 atl1_setup_link(struct atl1_hw *hw)
> +{
> +	s32 ret_val;
> +
> +	/**
> +	 * Options:
> +	 *  PHY will advertise value(s) parsed from
> +	 *  autoneg_advertised and fc
> +	 *  no matter what autoneg is , We will not wait link result.
> +	 **/
> +	ret_val = atl1_phy_setup_autoneg_adv(hw);
> +	if (ret_val) {
> +		printk(KERN_DEBUG "%s: error setting up autonegotiation\n", 
> +			atl1_driver_name);
> +		return ret_val;
> +	}
> +	/* SW.Reset , En-Auto-Neg if needed */
> +	ret_val = atl1_phy_reset(hw);
> +	if (ret_val) {
> +		printk(KERN_DEBUG "%s: error resetting the phy\n", atl1_driver_name);
> +		return ret_val;
> +	}
> +	hw->phy_configured = true;
> +	return ret_val;
> +}
> +
> +struct atl1_spi_flash_dev flash_table[] = {
> +/*	MFR_NAME  WRSR  READ  PRGM  WREN  WRDI  RDSR  RDID  SECTOR_ERASE CHIP_ERASE */
> +	{"Atmel", 0x00, 0x03, 0x02, 0x06, 0x04, 0x05, 0x15, 0x52,        0x62},
> +	{"SST",   0x01, 0x03, 0x02, 0x06, 0x04, 0x05, 0x90, 0x20,        0x60},
> +	{"ST",    0x01, 0x03, 0x02, 0x06, 0x04, 0x05, 0xAB, 0xD8,        0xC7},
> +};
> +
> +static void atl1_init_flash_opcode(struct atl1_hw *hw)
> +{
> +	if (hw->flash_vendor >= sizeof(flash_table) / sizeof(flash_table[0]))
> +		hw->flash_vendor = 0;	/* ATMEL */
> +
> +	/* Init OP table */
> +	atl1_write8(hw, REG_SPI_FLASH_OP_PROGRAM,
> +		      flash_table[hw->flash_vendor].cmd_program);
> +	atl1_write8(hw, REG_SPI_FLASH_OP_SC_ERASE,
> +		      flash_table[hw->flash_vendor].cmd_sector_erase);
> +	atl1_write8(hw, REG_SPI_FLASH_OP_CHIP_ERASE,
> +		      flash_table[hw->flash_vendor].cmd_chip_erase);
> +	atl1_write8(hw, REG_SPI_FLASH_OP_RDID,
> +		      flash_table[hw->flash_vendor].cmd_rdid);
> +	atl1_write8(hw, REG_SPI_FLASH_OP_WREN,
> +		      flash_table[hw->flash_vendor].cmd_wren);
> +	atl1_write8(hw, REG_SPI_FLASH_OP_RDSR,
> +		      flash_table[hw->flash_vendor].cmd_rdsr);
> +	atl1_write8(hw, REG_SPI_FLASH_OP_WRSR,
> +		      flash_table[hw->flash_vendor].cmd_wrsr);
> +	atl1_write8(hw, REG_SPI_FLASH_OP_READ,
> +		      flash_table[hw->flash_vendor].cmd_read);
> +}
> +
> +/**
> + * Performs basic configuration of the adapter.
> + * hw - Struct containing variables accessed by shared code
> + * Assumes that the controller has previously been reset and is in a
> + * post-reset uninitialized state. Initializes multicast table, 
> + * and  Calls routines to setup link
> + * Leaves the transmit and receive units disabled and uninitialized.
> + **/
> +s32 atl1_init_hw(struct atl1_hw *hw)
> +{
> +	u32 ret_val = 0;
> +
> +	/* Zero out the Multicast HASH table */
> +	atl1_write32(hw, REG_RX_HASH_TABLE, 0);
> +	/* clear the old settings from the multicast hash table */
> +	atl1_write32_array(hw, REG_RX_HASH_TABLE, 1, 0);
> +
> +	atl1_init_flash_opcode(hw);
> +
> +	if (!hw->phy_configured) {
> +		/* enable GPHY LinkChange Interrrupt */
> +		ret_val = atl1_write_phy_reg(hw, 18, 0xC00);
> +		if (ret_val)
> +			return ret_val;
> +		/* make PHY out of power-saving state */
> +		ret_val = atl1_phy_leave_power_saving(hw);
> +		if (ret_val)
> +			return ret_val;
> +		/* Call a subroutine to configure the link */
> +		ret_val = atl1_setup_link(hw);
> +	}
> +	return ret_val;
> +}
> +
> +/**
> + * Detects the current speed and duplex settings of the hardware.
> + * hw - Struct containing variables accessed by shared code
> + * speed - Speed of the connection
> + * duplex - Duplex setting of the connection
> + **/
> +s32 atl1_get_speed_and_duplex(struct atl1_hw * hw, u16 * speed, u16 * duplex)
> +{
> +	s32 ret_val;
> +	u16 phy_data;
> +
> +	/* ; --- Read   PHY Specific Status Register (17) */
> +	ret_val = atl1_read_phy_reg(hw, MII_AT001_PSSR, &phy_data);
> +	if (ret_val)
> +		return ret_val;
> +
> +	if (!(phy_data & MII_AT001_PSSR_SPD_DPLX_RESOLVED))
> +		return ATL1_ERR_PHY_RES;
> +
> +	switch (phy_data & MII_AT001_PSSR_SPEED) {
> +	case MII_AT001_PSSR_1000MBS:
> +		*speed = SPEED_1000;
> +		break;
> +	case MII_AT001_PSSR_100MBS:
> +		*speed = SPEED_100;
> +		break;
> +	case MII_AT001_PSSR_10MBS:
> +		*speed = SPEED_10;
> +		break;
> +	default:
> +		printk(KERN_DEBUG "%s: error getting speed\n", 
> +			atl1_driver_name);
> +		return ATL1_ERR_PHY_SPEED;
> +		break;
> +	}
> +	if (phy_data & MII_AT001_PSSR_DPLX)
> +		*duplex = FULL_DUPLEX;
> +	else
> +		*duplex = HALF_DUPLEX;
> +
> +	return ATL1_SUCCESS;
> +}
> +
> +void atl1_set_mac_addr(struct atl1_hw *hw)
> +{
> +	u32 value;
> +	/**
> +	 * 00-0B-6A-F6-00-DC
> +	 * 0:  6AF600DC   1: 000B
> +	 * low dword
> +	 **/
> +	value = (((u32) hw->mac_addr[2]) << 24) |
> +	    (((u32) hw->mac_addr[3]) << 16) |
> +	    (((u32) hw->mac_addr[4]) << 8) | (((u32) hw->mac_addr[5]));
> +	atl1_write32_array(hw, REG_MAC_STA_ADDR, 0, value);
> +	/* hight dword */
> +	value = (((u32) hw->mac_addr[0]) << 8) | (((u32) hw->mac_addr[1]));
> +	atl1_write32_array(hw, REG_MAC_STA_ADDR, 1, value);
> +}
> +
> diff --git a/drivers/net/atl1/atl1_param.c b/drivers/net/atl1/atl1_param.c
> new file mode 100644
> index 0000000..ed3098e
> --- /dev/null
> +++ b/drivers/net/atl1/atl1_param.c
> @@ -0,0 +1,223 @@
> +/**
> + * atl1_param.c - atl1 parameter parsing
> + * 
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
> +#include <linux/moduleparam.h>
> +#include "atl1.h"
> +
> +extern char atl1_driver_name[];
> +
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
> +
> +#define DEFAULT_INT_MOD_CNT	100	/* 200us */
> +#define MAX_INT_MOD_CNT		65000
> +#define MIN_INT_MOD_CNT		50
> +
> +#define FLASH_VENDOR_DEFAULT	0
> +#define FLASH_VENDOR_MIN	0
> +#define FLASH_VENDOR_MAX	2
> +
> +struct atl1_option {
> +	enum { enable_option, range_option, list_option } type;
> +	char *name;
> +	char *err;
> +	int def;
> +	union {
> +		struct {	/* range_option info */
> +			int min;
> +			int max;
> +		} r;
> +		struct {	/* list_option info */
> +			int nr;
> +			struct atl1_opt_list {
> +				int i;
> +				char *str;
> +			} *p;
> +		} l;
> +	} arg;
> +};
> +
> +static int __devinit atl1_validate_option(int *value, struct atl1_option *opt)
> +{
> +	if (*value == OPTION_UNSET) {
> +		*value = opt->def;
> +		return 0;
> +	}
> +
> +	switch (opt->type) {
> +	case enable_option:
> +		switch (*value) {
> +		case OPTION_ENABLED:
> +			printk(KERN_INFO "%s: %s Enabled\n", atl1_driver_name, 
> +				opt->name);
> +			return 0;
> +		case OPTION_DISABLED:
> +			printk(KERN_INFO "%s: %s Disabled\n", atl1_driver_name, 
> +				opt->name);
> +			return 0;
> +		}
> +		break;
> +	case range_option:
> +		if (*value >= opt->arg.r.min && *value <= opt->arg.r.max) {
> +			printk(KERN_INFO "%s: %s set to %i\n", 
> +				atl1_driver_name, opt->name, *value);
> +			return 0;
> +		}
> +		break;
> +	case list_option:{
> +			int i;
> +			struct atl1_opt_list *ent;
> +
> +			for (i = 0; i < opt->arg.l.nr; i++) {
> +				ent = &opt->arg.l.p[i];
> +				if (*value == ent->i) {
> +					if (ent->str[0] != '\0')
> +						printk(KERN_INFO "%s: %s\n",
> +						       atl1_driver_name, ent->str);
> +					return 0;
> +				}
> +			}
> +		}
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	printk(KERN_INFO "%s: invalid %s specified (%i) %s\n",
> +	       atl1_driver_name, opt->name, *value, opt->err);
> +	*value = opt->def;
> +	return -1;
> +}
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
> +void __devinit atl1_check_options(struct atl1_adapter *adapter)
> +{
> +	int bd = adapter->bd_number;
> +	if (bd >= ATL1_MAX_NIC) {
> +		printk(KERN_NOTICE "%s: warning: no configuration for board #%i\n", 
> +			atl1_driver_name, bd);
> +		printk(KERN_NOTICE "%s: using defaults for all values\n", 
> +			atl1_driver_name);
> +	}
> +	{			/* Interrupt Moderate Timer */
> +		struct atl1_option opt = {
> +			.type = range_option,
> +			.name = "Interrupt Moderator Timer",
> +			.err = "using default of " 
> +				__MODULE_STRING(DEFAULT_INT_MOD_CNT),
> +			.def = DEFAULT_INT_MOD_CNT,
> +			.arg = {.r =
> +				{.min = MIN_INT_MOD_CNT,.max = MAX_INT_MOD_CNT}}
> +		};
> +		int val;
> +		if (num_int_mod_timer > bd) {
> +			val = int_mod_timer[bd];
> +			atl1_validate_option(&val, &opt);
> +			adapter->imt = (u16) val;
> +		} else {
> +			adapter->imt = (u16) (opt.def);
> +		}
> +	}
> +
> +	{			/* Flash Vendor */
> +		struct atl1_option opt = {
> +			.type = range_option,
> +			.name = "SPI Flash Vendor",
> +			.err = "using default of "
> +			    	__MODULE_STRING(FLASH_VENDOR_DEFAULT),
> +			.def = DEFAULT_INT_MOD_CNT,
> +			.arg = {.r =
> +				{.min = FLASH_VENDOR_MIN,.max =
> +				 FLASH_VENDOR_MAX}}
> +		};
> +		int val;
> +		if (num_flash_vendor > bd) {
> +			val = flash_vendor[bd];
> +			atl1_validate_option(&val, &opt);
> +			adapter->hw.flash_vendor = (u8) val;
> +		} else {
> +			adapter->hw.flash_vendor = (u8) (opt.def);
> +		}
> +	}
> +
> +	{			/* PCI MSI usage */
> +
> +#ifdef CONFIG_PCI_MSI
> +		adapter->enable_msi = enable_msi;
> +#else
> +		adapter->enable_msi = 0;
> +#endif
> +	}
> +}
> 

