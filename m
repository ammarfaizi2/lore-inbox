Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWCaAOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWCaAOl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 19:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWCaAOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 19:14:41 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:8888 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1751114AbWCaAOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 19:14:40 -0500
Message-ID: <442C8069.507@wolfmountaingroup.com>
Date: Thu, 30 Mar 2006 18:05:45 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
CC: john.ronciak@intel.com, jesse.brandeburg@intel.com,
       jeffrey.t.kirsher@intel.com, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH]: e1000: prevent statistics from getting garbled during
 reset.
References: <20060330213928.GQ2172@austin.ibm.com> <20060331000208.GS2172@austin.ibm.com>
In-Reply-To: <20060331000208.GS2172@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linas Vepstas wrote:

>On Thu, Mar 30, 2006 at 03:39:28PM -0600, Linas Vepstas wrote:
>  
>
>>Please review, sign-off/ack, and forward upstream.
>>--linas
>>    
>>
>
>Per feedback, here's a slightly more human-readable version.
>--linas
>
>[PATCH]: e1000: prevent statistics from getting garbled during reset.
>
>If a PCI bus error/fault triggers a PCI bus reset, attempts to get the
>ethernet packet count statistics from the hardware will fail, returning
>garbage data upstream.  This patch skips statistics data collection
>if the PCI device is not on the bus. 
>
>This patch presumes that an earlier patch,
>[PATCH] PCI Error Recovery: e1000 network device driver
>has already been applied.
>
>Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
>
>----
> drivers/net/e1000/e1000_main.c |    6 +++++-
> 1 files changed, 5 insertions(+), 1 deletion(-)
>
>Index: linux-2.6.16-git6/drivers/net/e1000/e1000_main.c
>===================================================================
>--- linux-2.6.16-git6.orig/drivers/net/e1000/e1000_main.c	2006-03-30 17:51:37.924162779 -0600
>+++ linux-2.6.16-git6/drivers/net/e1000/e1000_main.c	2006-03-30 17:54:07.659188391 -0600
>@@ -3069,14 +3069,18 @@ void
> e1000_update_stats(struct e1000_adapter *adapter)
> {
> 	struct e1000_hw *hw = &adapter->hw;
>+	struct pci_dev *pdev = adapter->pdev;
> 	unsigned long flags;
> 	uint16_t phy_tmp;
> 
> #define PHY_IDLE_ERROR_COUNT_MASK 0x00FF
> 
>-	/* Prevent stats update while adapter is being reset */
>+	/* Prevent stats update while adapter is being reset,
>+	 * or if the pci connection is down. */
> 	if (adapter->link_speed == 0)
> 		return;
>+   if (pdev->error_state && pdev->error_state != pci_channel_io_normal)
>+		return;
> 
> 	spin_lock_irqsave(&adapter->stats_lock, flags);
> 
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

The driver also needs to be fixed to allow clearing of the stats (like 
all the other adapter drivers). At present, when I run performance
and packet drop counts on the cards, I cannot reset the stats with this 
code because the driver stores them in the e100_adapter
structure. This is busted.

This function:

int clear_network_device_stats(BYTE *name)
{
register int i;

i = get_dev_index_by_name(name);
if (i != -1)
{
if (ndevs[i])
{
struct net_device_stats *stats;

stats = (ndevs[i]->get_stats)(ndevs[i]);
if (stats)
{
stats->rx_packets = 0;
stats->tx_packets = 0;
stats->rx_bytes = 0;
stats->tx_bytes = 0;
stats->multicast = 0;
stats->collisions = 0;
stats->rx_errors = 0;
stats->rx_length_errors = 0;
stats->rx_crc_errors = 0;
stats->rx_frame_errors = 0;
stats->rx_fifo_errors = 0;
stats->rx_missed_errors = 0;
stats->tx_errors = 0;
stats->tx_aborted_errors = 0;
stats->tx_window_errors = 0;
stats->tx_carrier_errors = 0;
P_Print("solera: stats cleared for %s\n", ndevs[i]->name);
return 0;
}
}
return 0;
}
return -1;
}

does not work on e1000 due to this section of code:


void
e1000_update_stats(struct e1000_adapter *adapter)
{
struct e1000_hw *hw = &adapter->hw;
unsigned long flags;
uint16_t phy_tmp;

#define PHY_IDLE_ERROR_COUNT_MASK 0x00FF

spin_lock_irqsave(&adapter->stats_lock, flags);

/* these counters are modified from e1000_adjust_tbi_stats,
* called from the interrupt context, so they must only
* be written while holding adapter->stats_lock
*/

adapter->stats.crcerrs += E1000_READ_REG(hw, CRCERRS);
adapter->stats.gprc += E1000_READ_REG(hw, GPRC);
adapter->stats.gorcl += E1000_READ_REG(hw, GORCL);
adapter->stats.gorch += E1000_READ_REG(hw, GORCH);
adapter->stats.bprc += E1000_READ_REG(hw, BPRC);
adapter->stats.mprc += E1000_READ_REG(hw, MPRC);
adapter->stats.roc += E1000_READ_REG(hw, ROC);
adapter->stats.prc64 += E1000_READ_REG(hw, PRC64);
adapter->stats.prc127 += E1000_READ_REG(hw, PRC127);
adapter->stats.prc255 += E1000_READ_REG(hw, PRC255);
adapter->stats.prc511 += E1000_READ_REG(hw, PRC511);
adapter->stats.prc1023 += E1000_READ_REG(hw, PRC1023);
adapter->stats.prc1522 += E1000_READ_REG(hw, PRC1522);

adapter->stats.symerrs += E1000_READ_REG(hw, SYMERRS);
adapter->stats.mpc += E1000_READ_REG(hw, MPC);
adapter->stats.scc += E1000_READ_REG(hw, SCC);
adapter->stats.ecol += E1000_READ_REG(hw, ECOL);
adapter->stats.mcc += E1000_READ_REG(hw, MCC);
adapter->stats.latecol += E1000_READ_REG(hw, LATECOL);
adapter->stats.dc += E1000_READ_REG(hw, DC);
adapter->stats.sec += E1000_READ_REG(hw, SEC);
adapter->stats.rlec += E1000_READ_REG(hw, RLEC);
adapter->stats.xonrxc += E1000_READ_REG(hw, XONRXC);
adapter->stats.xontxc += E1000_READ_REG(hw, XONTXC);
adapter->stats.xoffrxc += E1000_READ_REG(hw, XOFFRXC);
adapter->stats.xofftxc += E1000_READ_REG(hw, XOFFTXC);
adapter->stats.fcruc += E1000_READ_REG(hw, FCRUC);
adapter->stats.gptc += E1000_READ_REG(hw, GPTC);
adapter->stats.gotcl += E1000_READ_REG(hw, GOTCL);
adapter->stats.gotch += E1000_READ_REG(hw, GOTCH);
adapter->stats.rnbc += E1000_READ_REG(hw, RNBC);
adapter->stats.ruc += E1000_READ_REG(hw, RUC);
adapter->stats.rfc += E1000_READ_REG(hw, RFC);
adapter->stats.rjc += E1000_READ_REG(hw, RJC);
adapter->stats.torl += E1000_READ_REG(hw, TORL);
adapter->stats.torh += E1000_READ_REG(hw, TORH);
adapter->stats.totl += E1000_READ_REG(hw, TOTL);
adapter->stats.toth += E1000_READ_REG(hw, TOTH);
adapter->stats.tpr += E1000_READ_REG(hw, TPR);
adapter->stats.ptc64 += E1000_READ_REG(hw, PTC64);
adapter->stats.ptc127 += E1000_READ_REG(hw, PTC127);
adapter->stats.ptc255 += E1000_READ_REG(hw, PTC255);
adapter->stats.ptc511 += E1000_READ_REG(hw, PTC511);
adapter->stats.ptc1023 += E1000_READ_REG(hw, PTC1023);
adapter->stats.ptc1522 += E1000_READ_REG(hw, PTC1522);
adapter->stats.mptc += E1000_READ_REG(hw, MPTC);
adapter->stats.bptc += E1000_READ_REG(hw, BPTC);

//NOTE These stats need to be stored in the stats structure so they can 
be cleared by
statistics monitoring programs.

/* used for adaptive IFS */

hw->tx_packet_delta = E1000_READ_REG(hw, TPT);
adapter->stats.tpt += hw->tx_packet_delta;
hw->collision_delta = E1000_READ_REG(hw, COLC);
adapter->stats.colc += hw->collision_delta;

if(hw->mac_type >= e1000_82543) {
adapter->stats.algnerrc += E1000_READ_REG(hw, ALGNERRC);
adapter->stats.rxerrc += E1000_READ_REG(hw, RXERRC);
adapter->stats.tncrs += E1000_READ_REG(hw, TNCRS);
adapter->stats.cexterr += E1000_READ_REG(hw, CEXTERR);
adapter->stats.tsctc += E1000_READ_REG(hw, TSCTC);
adapter->stats.tsctfc += E1000_READ_REG(hw, TSCTFC);
}

/* Fill out the OS statistics structure */

adapter->net_stats.rx_packets = adapter->stats.gprc;
adapter->net_stats.tx_packets = adapter->stats.gptc;
adapter->net_stats.rx_bytes = adapter->stats.gorcl;
adapter->net_stats.tx_bytes = adapter->stats.gotcl;
adapter->net_stats.multicast = adapter->stats.mprc;
adapter->net_stats.collisions = adapter->stats.colc;

/* Rx Errors */

adapter->net_stats.rx_errors = adapter->stats.rxerrc +
adapter->stats.crcerrs + adapter->stats.algnerrc +
adapter->stats.rlec + adapter->stats.rnbc +
adapter->stats.mpc + adapter->stats.cexterr;
adapter->net_stats.rx_dropped = adapter->stats.rnbc;
adapter->net_stats.rx_length_errors = adapter->stats.rlec;
adapter->net_stats.rx_crc_errors = adapter->stats.crcerrs;
adapter->net_stats.rx_frame_errors = adapter->stats.algnerrc;
adapter->net_stats.rx_fifo_errors = adapter->stats.mpc;
adapter->net_stats.rx_missed_errors = adapter->stats.mpc;

/* Tx Errors */

adapter->net_stats.tx_errors = adapter->stats.ecol +
adapter->stats.latecol;
adapter->net_stats.tx_aborted_errors = adapter->stats.ecol;
adapter->net_stats.tx_window_errors = adapter->stats.latecol;
adapter->net_stats.tx_carrier_errors = adapter->stats.tncrs;

/* Tx Dropped needs to be maintained elsewhere */

/* Phy Stats */

if(hw->media_type == e1000_media_type_copper) {
if((adapter->link_speed == SPEED_1000) &&
(!e1000_read_phy_reg(hw, PHY_1000T_STATUS, &phy_tmp))) {
phy_tmp &= PHY_IDLE_ERROR_COUNT_MASK;
adapter->phy_stats.idle_errors += phy_tmp;
}

if((hw->mac_type <= e1000_82546) &&
(hw->phy_type == e1000_phy_m88) &&
!e1000_read_phy_reg(hw, M88E1000_RX_ERR_CNTR, &phy_tmp))
adapter->phy_stats.receive_errors += phy_tmp;
}

spin_unlock_irqrestore(&adapter->stats_lock, flags);
}

