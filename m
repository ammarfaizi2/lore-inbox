Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVD3Tbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVD3Tbq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 15:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVD3Tbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 15:31:46 -0400
Received: from mx1.mail.ru ([194.67.23.121]:62276 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S261374AbVD3TbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 15:31:23 -0400
Date: Sat, 30 Apr 2005 23:34:42 +0000
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Christoph Lameter <christoph@graphe.net>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc3-mm1 (a-new-10gb-ethernet-driver-by-chelsio-communications.patch)
Message-ID: <20050430233442.GA27460@mipter.zuzino.mipt.ru>
Mail-Followup-To: Christoph Lameter <christoph@graphe.net>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
	Andrew Morton <akpm@osdl.org>
References: <20050429231653.32d2f091.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <20050429231653.32d2f091.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="chelsio.txt"

> --- /dev/null
> +++ 25-akpm/drivers/net/chelsio/common.h

> +#define DIMOF(x) (sizeof(x)/sizeof(x[0]))

ARRAY_SIZE in include/linux/kernel.h

> --- /dev/null
>+++ 25-akpm/drivers/net/chelsio/cpl5_cmd.h

> +struct cpl_tx_pkt {
> +	__u16 vlan;

__be16.

> +struct cpl_tx_pkt_lso {
> +	__u32 len;

__be32

> +	__u16 eth_type_mss;

__be16

> +struct cpl_rx_pkt {
> +	__u16 vlan;

_be16 really. You do ntohs(p->vlan).

If any other fields of these structs are in network order I'd mark them as
such.

> --- /dev/null
> +++ 25-akpm/drivers/net/chelsio/cxgb2.c

> +#if BITS_PER_LONG == 64 && !defined(CONFIG_X86_64)
> +# define FMT64 "l"
> +#else
> +# define FMT64 "ll"
> +#endif

FMT64 is unused.

> +#define PCI_DMA_64BIT ~0ULL
> +#define PCI_DMA_32BIT 0xffffffffULL

In include/linux/dma-mapping.h DMA_64BIT_MASK and DMA_32BIT_MASK, respectively.

> +static const char pci_speed[][4] = {
> +	"33", "66", "100", "133"
> +};

Unused.

> +static void get_stats(struct net_device *dev, struct ethtool_stats *stats,
> +		      u64 *data)
> +{

> +	*data++ = s->TxOctetsOK;
> +	*data++ = s->TxOctetsBad;
> +	*data++ = s->TxUnicastFramesOK;
> +	*data++ = s->TxMulticastFramesOK;
> +	*data++ = s->TxBroadcastFramesOK;
> +	*data++ = s->TxPauseFrames;
> +	*data++ = s->TxFramesWithDeferredXmissions;
> +	*data++ = s->TxLateCollisions;
> +	*data++ = s->TxTotalCollisions;
> +	*data++ = s->TxFramesAbortedDueToXSCollisions;
> +	*data++ = s->TxUnderrun;
> +	*data++ = s->TxLengthErrors;
> +	*data++ = s->TxInternalMACXmitError;
> +	*data++ = s->TxFramesWithExcessiveDeferral;
> +	*data++ = s->TxFCSErrors;
> +
> +	*data++ = s->RxOctetsOK;
> +	*data++ = s->RxOctetsBad;
> +	*data++ = s->RxUnicastFramesOK;
> +	*data++ = s->RxMulticastFramesOK;
> +	*data++ = s->RxBroadcastFramesOK;
> +	*data++ = s->RxPauseFrames;
> +	*data++ = s->RxFCSErrors;
> +	*data++ = s->RxAlignErrors;
> +	*data++ = s->RxSymbolErrors;
> +	*data++ = s->RxDataErrors;
> +	*data++ = s->RxSequenceErrors;
> +	*data++ = s->RxRuntErrors;
> +	*data++ = s->RxJabberErrors;
> +	*data++ = s->RxInternalMACRcvError;
> +	*data++ = s->RxInRangeLengthErrors;
> +	*data++ = s->RxOutOfRangeLengthField;
> +	*data++ = s->RxFrameTooLongErrors;

It seems you want one big memcpy.

> +static int ethtool_ioctl(struct net_device *dev, void *useraddr)

void __user *addr. To make sparse happy.

> +{

> +	if (copy_from_user(&cmd, useraddr, sizeof(cmd)))

> +static int __devinit init_one(struct pci_dev *pdev,
> +			      const struct pci_device_id *ent)
> +{

> +	if (!pci_set_dma_mask(pdev, PCI_DMA_64BIT)) {

DMA_64BIT_MASK

> +		if (pci_set_consistent_dma_mask(pdev, PCI_DMA_64BIT)) {

DMA_64BIT_MASK

> +	} else if ((err = pci_set_dma_mask(pdev, PCI_DMA_32BIT)) != 0) {

DMA_32BIT_MASK

> --- /dev/null
> +++ 25-akpm/drivers/net/chelsio/cxgb2.h

> +struct adapter {
> +	u8 *regs;

void __iomem *regs; You do ->regs = ioremap(...);

> --- /dev/null
> +++ 25-akpm/drivers/net/chelsio/espi.c

> +/* 1. Deassert rx_reset_core. */
> +/* 2. Program TRICN_CNFG registers. */
> +/* 3. Deassert rx_reset_link */
> +static int tricn_init(adapter_t *adapter)
> +{

> +	/* 1 */
> +	timeout=1000;

> +	/* 2 */
> +	if (sme) {

> +	/* 3 */
> +	t1_write_reg_4(adapter, A_ESPI_RX_RESET, 0x3);

So move comments where they should be. ;-)

> +/* T2 Init part --  */
> +/* 1. Set T_ESPI_MISCCTRL_ADDR */
> +/* 2. Init ESPI registers. */
> +/* 3. Init TriCN Hard Macro */
> +int t1_espi_init(struct peespi *espi, int mac_type, int nports)
> +{

> --- /dev/null
> +++ 25-akpm/drivers/net/chelsio/mv88x201x.c

> +	if (do_enable & LINK_ENABLE_BIT) {
> +		led |= LINK_ENABLE_BIT;
> +		mdio_write(cphy, 0x1, 0x7, led);
> +	} else {
> +		led &= ~LINK_ENABLE_BIT;
> +		mdio_write(cphy, 0x1, 0x7, led);
> +	}

Common mdio_write line.

> --- /dev/null
> +++ 25-akpm/drivers/net/chelsio/pm3393.c

> +static int pm3393_macaddress_set(struct cmac *cmac, u8 ma[6])
> +{
> +	u32 val, lo, mid, hi

> +	 * MAC addr: 00:07:43:00:13:09
> +	 *
> +	 * ma[5] = 0x09
> +	 * ma[4] = 0x13
> +	 * ma[3] = 0x00
> +	 * ma[2] = 0x43
> +	 * ma[1] = 0x07
> +	 * ma[0] = 0x00
> +	 *
> +	 * The PM3393 requires byte swapping and reverse order entry
> +	 * when programming MAC addresses:
> +	 *
> +	 * low_bits[15:0]    = ma[1]:ma[0]
> +	 * mid_bits[31:16]   = ma[3]:ma[2]
> +	 * high_bits[47:32]  = ma[5]:ma[4]

> +	lo = ((u32) ma[1] << 8) | (u32) ma[0];
> +	mid = ((u32) ma[3] << 8) | (u32) ma[2];
> +	hi = ((u32) ma[5] << 8) | (u32) ma[4];

This is

	lo  = (u32) le16_to_cpu((__le16 *) &ma[0]);
	mid = (u32) le16_to_cpu((__le16 *) &ma[2]);
	hi  = (u32) le16_to_cpu((__le16 *) &ma[4]);

Right?

> +	/* The following steps are required to properly reset
> +	 * the PM3393. This information is provided in the
> +	 * PM3393 datasheet (Issue 2: November 2002)
> +	 * section 13.1 -- Device Reset.
> +	 *
> +	 * The PM3393 has three types of components that are
> +	 * individually reset:
> +	 *
> +	 * DRESETB      - Digital circuitry
> +	 * PL4_ARESETB  - PL4 analog circuitry
> +	 * XAUI_ARESETB - XAUI bus analog circuitry
> +	 *
> +	 * Steps to reset PM3393 using RSTB pin:
> +	 *
> +	 * 1. Assert RSTB pin low ( write 0 )
> +	 * 2. Wait at least 1ms to initiate a complete initialization of device.
> +	 * 3. Wait until all external clocks and REFSEL are stable.
> +	 * 4. Wait minimum of 1ms. (after external clocks and REFEL are stable)
> +	 * 5. De-assert RSTB ( write 1 )
> +	 * 6. Wait until internal timers to expires after ~14ms.
> +	 *    - Allows analog clock synthesizer(PL4CSU) to stabilize to
> +	 *      selected reference frequency before allowing the digital
> +	 *      portion of the device to operate.
> +	 * 7. Wait at least 200us for XAUI interface to stabilize.
> +	 * 8. Verify the PM3393 came out of reset successfully.
> +	 *    Set successful reset flag if everything worked else try again
> +	 *    a few more times.

Same comment about comments.

--- /dev/null
+++ 25-akpm/drivers/net/chelsio/regs.h

> +/* Do not edit this file */

OK.

--- /dev/null
+++ 25-akpm/drivers/net/chelsio/subr.c

> +static struct board_info t1_board[] = {
> +
> +{ CHBT_BOARD_N110, 1/*ports#*/,
> +  SUPPORTED_10000baseT_Full | SUPPORTED_FIBRE /*caps*/, CHBT_TERM_T1,
> +  CHBT_MAC_PM3393, CHBT_PHY_88X2010,
> +  125000000/*clk-core*/, 0/*clk-mc3*/, 0/*clk-mc4*/,
> +  1/*espi-ports*/, 0/*clk-cspi*/, 44/*clk-elmer0*/, 0/*mdien*/,
> +  0/*mdiinv*/, 1/*mdc*/, 0/*phybaseaddr*/, &t1_pm3393_ops,
> +  &t1_mv88x201x_ops, &mi1_mdio_ext_ops,
> +  "Chelsio N110 1x10GBaseX NIC" },
> +
> +{ CHBT_BOARD_N210, 1/*ports#*/,
> +  SUPPORTED_10000baseT_Full | SUPPORTED_FIBRE /*caps*/, CHBT_TERM_T2,
> +  CHBT_MAC_PM3393, CHBT_PHY_88X2010,
> +  125000000/*clk-core*/, 0/*clk-mc3*/, 0/*clk-mc4*/,
> +  1/*espi-ports*/, 0/*clk-cspi*/, 44/*clk-elmer0*/, 0/*mdien*/,
> +  0/*mdiinv*/, 1/*mdc*/, 0/*phybaseaddr*/, &t1_pm3393_ops,
> +  &t1_mv88x201x_ops, &mi1_mdio_ext_ops,
> +  "Chelsio N210 1x10GBaseX NIC" },
> +
> +};

That's what C99 initializers are for:

	static struct board_info t1_board[] = {
		{
			.board = CHBT_BOARD_N110,
			.port_number = 1,
			.caps = SUPPORTED_10000baseT_Full | SUPPORTED_FIBRE,
			.chip_term = CHBT_TERM_T1,
				...
		}, {
				...
		},
	};

> +const struct board_info *t1_get_board_info(unsigned int board_id)
> +{
> +	return board_id < DIMOF(t1_board) ? &t1_board[board_id] : NULL;

ARRAY_SIZE

--tThc/1wpZn/ma/RB--

