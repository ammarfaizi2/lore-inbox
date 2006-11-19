Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933199AbWKSUbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933199AbWKSUbA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933172AbWKSUa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:30:59 -0500
Received: from imf21aec.mail.bellsouth.net ([205.152.59.69]:9698 "EHLO
	imf21aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S933196AbWKSUaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:30:55 -0500
Date: Sun, 19 Nov 2006 14:30:50 -0600
From: Jay Cliburn <jacliburn@bellsouth.net>
To: jeff@garzik.org
Cc: shemminger@osdl.org, romieu@fr.zoreil.com, csnook@redhat.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] atl1: Main C file for Attansic L1 driver
Message-ID: <20061119203050.GD29736@osprey.hogchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jay Cliburn <jacliburn@bellsouth.net>

This patch contains the main C file for the Attansic L1 gigabit ethernet
adapter driver.

Signed-off-by: Jay Cliburn <jacliburn@bellsouth.net>
---

 atl1_main.c | 2551
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 2551 insertions(+)

diff --git a/drivers/net/atl1/atl1_main.c b/drivers/net/atl1/atl1_main.c
new file mode 100644
index 0000000..167e28c
--- /dev/null
+++ b/drivers/net/atl1/atl1_main.c
@@ -0,0 +1,2551 @@
+/** atl1_main.c - atl1 driver
+
+Copyright(c) 2005 - 2006 Attansic Corporation. All rights reserved.
+Copyright(c) 2006 Chris Snook <csnook@redhat.com>
+Copyright(c) 2006 Jay Cliburn <jcliburn@gmail.com>
+
+Derived from Intel e1000 driver
+Copyright(c) 1999 - 2005 Intel Corporation. All rights reserved.
+
+This program is free software; you can redistribute it and/or modify it
+under the terms of the GNU General Public License as published by the Free
+Software Foundation; either version 2 of the License, or (at your option)
+any later version.
+
+This program is distributed in the hope that it will be useful, but WITHOUT
+ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+more details.
+
+You should have received a copy of the GNU General Public License along with
+this program; if not, write to the Free Software Foundation, Inc., 59
+Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+
+The full GNU General Public License is included in this distribution in the
+file called COPYING.
+
+Contact Information:
+Xiong Huang <xiong_huang@attansic.com>
+Attansic Technology Corp. 3F 147, Xianzheng 9th Road, Zhubei,
+Xinzhu  302, TAIWAN, REPUBLIC OF CHINA
+
+Chris Snook <csnook@redhat.com>
+Jay Cliburn <jcliburn@gmail.com>
+
+This version is adapted from the Attansic reference driver for
+inclusion in the Linux kernel.  It is currently under heavy development.
+A very incomplete list of things that need to be dealt with:
+
+TODO:
+le/be annotations (some are done - jkc 20061118)
+Add more ethtool functions.
+
+COMPLETED:
+Remove MODULE_LICENSE from comment.  DONE!
+Change char decls for at_driver_whatever to static const char.  DONE!
+Use PCI_DEVICE macro instead of pci_device_id at_pci_tbl[].  DONE!
+Make all local functions private (static).  DONE!
+Don't use C99 types; use kernel types instead (u32, s32, ...).  DONE!
+Where possible, change int32_t to just int.  DONE!
+Get rid of forward declarations by reordering code.  DONE!
+Run through Lindent.  DONE! 
+Change to C-style comments.  DONE! 
+use 2.6.19 interrupt API - done jkc 20061108
+use 2.6.19 bool - done jkc 20061110
+fix includes - done jkc 20061109
+remove mixed case - done jkc 200621110
+lots of compat/debug code removal - done jkc 20061111
+Changed to DMA_{64,32}BIT_MASK - done jkc 20061112
+Do not use own ethtool ioctl; use ethtool ops instead. - done jkc 20061115
+SIOCDEVPRIVATE removal (unless we really want this) - done jkc 20061117
+Code moduleparam directly; no AT_PARAM macro - done jkc 20061118
+iomem annotations -- done jkc 20061118, needs verification
+Reduce number of module options; use ethtool - done jkc 20061118
+likely/unlikely annotations - done jkc 20061118, needs verification
+Converted/removed all typedefs - done jkc 20061118
+check with sparse - done jkc 20061118; some uncorrectable warnings remain
+Remove reboot notifier if possible - done jkc 20061119
+
+BUGS:
+TSO is glacially slow (perhaps one packet per jiffy?)
+twiddling ring parameters causes an OOPS (sometimes - jkc 20061117)
+doesn't work under xen (may be a xen/chipset interrupt problem)
+
+NEEDS TESTING:
+VLAN
+WOL
+multicast
+promiscuous mode
+interrupt coalescing
+SMP torture testing
+*/
+
+#include <linux/netdevice.h>
+#include <linux/pci.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/skbuff.h>
+#include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
+#include <linux/irqreturn.h>
+#include <linux/workqueue.h>
+#include <linux/timer.h>
+#include <linux/jiffies.h>
+#include <linux/hardirq.h>
+#include <linux/interrupt.h>
+#include <linux/irqflags.h>
+#include <linux/net.h>
+#include <linux/pm.h>
+#include <linux/in.h>
+#include <linux/ip.h>
+#include <linux/tcp.h>
+#include <linux/compiler.h>
+
+#include <asm/atomic.h>
+#include <asm/page.h>
+#include <asm/byteorder.h>
+#include <asm/system.h>
+#include <asm/checksum.h>
+
+#include "atl1.h"
+
+#define RUN_REALTIME 0
+#define DRV_VERSION "2.0.2"
+
+char at_driver_name[] = "atl1";
+static const char at_driver_string[] = "Attansic(R) L1 Ethernet Network Driver";
+const char at_driver_version[] = DRV_VERSION;
+static const char at_copyright[] =
+    "Copyright(c) 2005-2006 Attansic Corporation.";
+
+MODULE_AUTHOR
+    ("Attansic Corporation <xiong_huang@attansic.com>, Chris Snook <csnook@redhat.com>, Jay Cliburn <jcliburn@gmail.com>");
+MODULE_DESCRIPTION("Attansic 1000M Ethernet Network Driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
+
+/*
+ * at_pci_tbl - PCI Device ID Table
+ */
+static const struct pci_device_id at_pci_tbl[] = {
+	{PCI_DEVICE(0x1969, 0x1048)},
+	/* required last entry */
+	{0,}
+};
+
+MODULE_DEVICE_TABLE(pci, at_pci_tbl);
+
+extern s32 at_read_mac_addr(struct at_hw *hw);
+extern s32 at_init_hw(struct at_hw *hw);
+extern s32 at_get_speed_and_duplex(struct at_hw *hw, u16 * speed, u16 * duplex);
+extern s32 at_set_speed_and_duplex(struct at_hw *hw, u16 speed, u16 duplex);
+extern u32 at_auto_get_fc(struct at_adapter *adapter, u16 duplex);
+extern u32 at_hash_mc_addr(struct at_hw *hw, u8 * mc_addr);
+extern void at_hash_set(struct at_hw *hw, u32 hash_value);
+extern s32 at_read_phy_reg(struct at_hw *hw, u16 reg_addr, u16 * phy_data);
+extern s32 at_write_phy_reg(struct at_hw *hw, u32 reg_addr, u16 phy_data);
+extern s32 at_validate_mdi_setting(struct at_hw *hw);
+extern void set_mac_addr(struct at_hw *hw);
+extern int get_permanent_address(struct at_hw *hw);
+extern s32 at_phy_enter_power_saving(struct at_hw *hw);
+extern s32 at_reset_hw(struct at_hw *hw);
+extern void at_check_options(struct at_adapter *adapter);
+void at_set_ethtool_ops(struct net_device *netdev);
+
+/**
+ * at_sw_init - Initialize general software structures (struct at_adapter)
+ * @adapter: board private structure to initialize
+ *
+ * at_sw_init initializes the Adapter private data structure.
+ * Fields are initialized based on PCI device information and
+ * OS network device settings (MTU size).
+ **/
+static int __devinit at_sw_init(struct at_adapter *adapter)
+{
+	struct at_hw *hw = &adapter->hw;
+	struct net_device *netdev = adapter->netdev;
+	struct pci_dev *pdev = adapter->pdev;
+
+	/* PCI config space info */
+	hw->vendor_id = pdev->vendor;
+	hw->device_id = pdev->device;
+	hw->subsystem_vendor_id = pdev->subsystem_vendor;
+	hw->subsystem_id = pdev->subsystem_device;
+
+	pci_read_config_byte(pdev, PCI_REVISION_ID, &hw->revision_id);
+	pci_read_config_word(pdev, PCI_COMMAND, &hw->pci_cmd_word);
+
+	hw->max_frame_size = netdev->mtu + ENET_HEADER_SIZE + ETHERNET_FCS_SIZE;
+	hw->min_frame_size = MINIMUM_ETHERNET_FRAME_SIZE;
+
+	adapter->wol = 0;
+
+	adapter->rx_buffer_len = (hw->max_frame_size + 7) & ~7;
+	adapter->ict = 50000;	/* 100ms */
+
+	adapter->link_speed = SPEED_0;	/* hardware init */
+	adapter->link_duplex = FULL_DUPLEX;
+
+	hw->phy_configured = false;
+	hw->preamble_len = 7;
+	hw->ipgt = 0x60;
+	hw->min_ifg = 0x50;
+	hw->ipgr1 = 0x40;
+	hw->ipgr2 = 0x60;
+	hw->max_retry = 0xf;
+	hw->lcol = 0x37;
+	hw->jam_ipg = 7;
+	hw->rfd_burst = 8;
+	hw->rrd_burst = 8;
+	hw->rfd_fetch_gap = 1;
+	hw->rx_jumbo_th = adapter->rx_buffer_len / 8;
+	hw->rx_jumbo_lkah = 1;
+	hw->rrd_ret_timer = 16;
+	hw->tpd_burst = 4;
+	hw->tpd_fetch_th = 16;
+	hw->txf_burst = 0x100;
+	hw->tx_jumbo_task_th = (hw->max_frame_size + 7) >> 3;
+	hw->tpd_fetch_gap = 1;
+	hw->rcb_value = at_rcb_64;
+	hw->dma_ord = at_dma_ord_enh;
+	hw->dmar_block = at_dma_req_256;
+	hw->dmaw_block = at_dma_req_256;
+	hw->cmb_rrd = 4;
+	hw->cmb_tpd = 4;
+	hw->cmb_rx_timer = 1;	/* about 2us */
+	hw->cmb_tx_timer = 1;	/* about 2us */
+	hw->smb_timer = 100000;	/* about 200ms */
+
+	atomic_set(&adapter->irq_sem, 0);
+	spin_lock_init(&adapter->stats_lock);
+	spin_lock_init(&adapter->tx_lock);
+	spin_lock_init(&adapter->mb_lock);
+
+	return 0;
+}
+
+/**
+ * at_setup_mem_resources - allocate Tx / RX descriptor resources 
+ * @adapter: board private structure
+ *
+ * Return 0 on success, negative on failure
+ **/
+s32 at_setup_ring_resources(struct at_adapter * adapter)
+{
+	struct at_tpd_ring *tpd_ring = &adapter->tpd_ring;
+	struct at_rfd_ring *rfd_ring = &adapter->rfd_ring;
+	struct at_rrd_ring *rrd_ring = &adapter->rrd_ring;
+	struct at_ring_header *ring_header = &adapter->ring_header;
+	struct pci_dev *pdev = adapter->pdev;
+	int size;
+	u8 offset = 0;
+
+	size = sizeof(struct at_buffer) * (tpd_ring->count + rfd_ring->count);
+	tpd_ring->buffer_info = kmalloc(size, GFP_KERNEL);
+	if (unlikely(!tpd_ring->buffer_info)) {
+		printk(KERN_WARNING "%s: kmalloc failed , size = D%d\n", 
+			at_driver_name, size);
+		return -ENOMEM;
+	}
+	rfd_ring->buffer_info =
+	    (struct at_buffer *)(tpd_ring->buffer_info + tpd_ring->count);
+
+	memset(tpd_ring->buffer_info, 0, size);
+
+	/* real ring DMA buffer */
+	ring_header->size = size = sizeof(struct tx_packet_desc) * tpd_ring->count
+	    + sizeof(struct rx_free_desc) * rfd_ring->count
+	    + sizeof(struct rx_return_desc) * rrd_ring->count
+	    + sizeof(struct coals_msg_block)
+	    + sizeof(struct stats_msg_block)
+	    + 40;		/* "40: for 8 bytes align" huh? -- CHS */
+
+	ring_header->desc =
+	    pci_alloc_consistent(pdev, ring_header->size, &ring_header->dma);
+	if (unlikely(!ring_header->desc)) {
+		kfree(tpd_ring->buffer_info);
+		printk(KERN_WARNING 
+			"%s: pci_alloc_consistent failed, size = D%d\n", 
+			at_driver_name, size);
+		return -ENOMEM;
+	}
+
+	if (adapter->pci_using_64) {	/* test whether HIDWORD dma buffer is not cross boundary */
+		if (unlikely(((ring_header->dma & 0xffffffff00000000ULL) >> 32)
+		    != (((ring_header->dma + size) & 0xffffffff00000000ULL) >>
+			32))) {
+			kfree(tpd_ring->buffer_info);
+			pci_free_consistent(pdev, ring_header->size,
+					    ring_header->desc,
+					    ring_header->dma);
+			printk(KERN_DEBUG 
+				"%s: memory allocated cross 32bit boundary\n", 
+				at_driver_name);
+			return -ENOMEM;
+		}
+	}
+
+	memset(ring_header->desc, 0, ring_header->size);
+
+	/* init TPD ring */
+	tpd_ring->dma = ring_header->dma;
+	offset = (tpd_ring->dma & 0x7) ? (8 - (ring_header->dma & 0x7)) : 0;
+	tpd_ring->dma += offset;
+	tpd_ring->desc = (u8 *) ring_header->desc + offset;
+	tpd_ring->size = sizeof(struct tx_packet_desc) * tpd_ring->count;
+	atomic_set(&tpd_ring->next_to_use, 0);
+	atomic_set(&tpd_ring->next_to_clean, 0);
+
+	/* init RFD ring */
+	rfd_ring->dma = tpd_ring->dma + tpd_ring->size;
+	offset = (rfd_ring->dma & 0x7) ? (8 - (rfd_ring->dma & 0x7)) : 0;
+	rfd_ring->dma += offset;
+	rfd_ring->desc = (u8 *) tpd_ring->desc + (tpd_ring->size + offset);
+	rfd_ring->size = sizeof(struct rx_free_desc) * rfd_ring->count;
+	rfd_ring->next_to_clean = 0;
+	/* rfd_ring->next_to_use = rfd_ring->count - 1; */
+	atomic_set(&rfd_ring->next_to_use, 0);
+
+	/* init RRD ring */
+	rrd_ring->dma = rfd_ring->dma + rfd_ring->size;
+	offset = (rrd_ring->dma & 0x7) ? (8 - (rrd_ring->dma & 0x7)) : 0;
+	rrd_ring->dma += offset;
+	rrd_ring->desc = (u8 *) rfd_ring->desc + (rfd_ring->size + offset);
+	rrd_ring->size = sizeof(struct rx_return_desc) * rrd_ring->count;
+	rrd_ring->next_to_use = 0;
+	atomic_set(&rrd_ring->next_to_clean, 0);
+
+	/* init CMB */
+	adapter->cmb.dma = rrd_ring->dma + rrd_ring->size;
+	offset = (adapter->cmb.dma & 0x7) ? (8 - (adapter->cmb.dma & 0x7)) : 0;
+	adapter->cmb.dma += offset;
+	adapter->cmb.cmb =
+	    (struct coals_msg_block *) ((u8 *) rrd_ring->desc +
+				   (rrd_ring->size + offset));
+
+	/* init SMB */
+	adapter->smb.dma = adapter->cmb.dma + sizeof(struct coals_msg_block);
+	offset = (adapter->smb.dma & 0x7) ? (8 - (adapter->smb.dma & 0x7)) : 0;
+	adapter->smb.dma += offset;
+	adapter->smb.smb = (struct stats_msg_block *)
+	    ((u8 *) adapter->cmb.cmb + (sizeof(struct coals_msg_block) + offset));
+
+	return AT_SUCCESS;
+}
+
+/**
+ * at_irq_enable - Enable default interrupt generation settings
+ * @adapter: board private structure
+ **/
+static inline void at_irq_enable(struct at_adapter *adapter)
+{
+	if (likely(0 == atomic_dec_and_test(&adapter->irq_sem))) {
+		AT_WRITE_REG(&adapter->hw, REG_IMR, IMR_NORMAL_MASK);
+	}
+}
+
+static inline void at_clear_phy_int(struct at_adapter *adapter)
+{
+	u16 phy_data;
+	spin_lock(&adapter->stats_lock);
+	at_read_phy_reg(&adapter->hw, 19, &phy_data);
+	spin_unlock(&adapter->stats_lock);
+}
+
+static void at_inc_smb(struct at_adapter *adapter)
+{
+	struct stats_msg_block *smb = adapter->smb.smb;
+
+	/* Fill out the OS statistics structure */
+	adapter->soft_stats.rx_packets += smb->rx_ok;
+	adapter->soft_stats.tx_packets += smb->tx_ok;
+	adapter->soft_stats.rx_bytes += smb->rx_byte_cnt;
+	adapter->soft_stats.tx_bytes += smb->tx_byte_cnt;
+	adapter->soft_stats.multicast += smb->rx_mcast;
+	adapter->soft_stats.collisions += (smb->tx_1_col +
+					   smb->tx_2_col * 2 +
+					   smb->tx_late_col +
+					   smb->tx_abort_col *
+					   adapter->hw.max_retry);
+
+	/* Rx Errors */
+	adapter->soft_stats.rx_errors += (smb->rx_frag +
+					  smb->rx_fcs_err +
+					  smb->rx_len_err +
+					  smb->rx_sz_ov +
+					  smb->rx_rxf_ov +
+					  smb->rx_rrd_ov + smb->rx_align_err);
+	adapter->soft_stats.rx_fifo_errors += smb->rx_rxf_ov;
+	adapter->soft_stats.rx_length_errors += smb->rx_len_err;
+	adapter->soft_stats.rx_crc_errors += smb->rx_fcs_err;
+	adapter->soft_stats.rx_frame_errors += smb->rx_align_err;
+	adapter->soft_stats.rx_missed_errors += (smb->rx_rrd_ov +
+						 smb->rx_rxf_ov);
+
+	adapter->soft_stats.rx_pause += smb->rx_pause;
+	adapter->soft_stats.rx_rrd_ov += smb->rx_rrd_ov;
+	adapter->soft_stats.rx_trunc += smb->rx_sz_ov;
+
+	/* Tx Errors */
+	adapter->soft_stats.tx_errors += (smb->tx_late_col +
+					  smb->tx_abort_col +
+					  smb->tx_underrun + smb->tx_trunc);
+	adapter->soft_stats.tx_fifo_errors += smb->tx_underrun;
+	adapter->soft_stats.tx_aborted_errors += smb->tx_abort_col;
+	adapter->soft_stats.tx_window_errors += smb->tx_late_col;
+
+	adapter->soft_stats.excecol += smb->tx_abort_col;
+	adapter->soft_stats.deffer += smb->tx_defer;
+	adapter->soft_stats.scc += smb->tx_1_col;
+	adapter->soft_stats.mcc += smb->tx_2_col;
+	adapter->soft_stats.latecol += smb->tx_late_col;
+	adapter->soft_stats.tx_underun += smb->tx_underrun;
+	adapter->soft_stats.tx_trunc += smb->tx_trunc;
+	adapter->soft_stats.tx_pause += smb->tx_pause;
+
+	adapter->net_stats.rx_packets = adapter->soft_stats.rx_packets;
+	adapter->net_stats.tx_packets = adapter->soft_stats.tx_packets;
+	adapter->net_stats.rx_bytes = adapter->soft_stats.rx_bytes;
+	adapter->net_stats.tx_bytes = adapter->soft_stats.tx_bytes;
+	adapter->net_stats.multicast = adapter->soft_stats.multicast;
+	adapter->net_stats.collisions = adapter->soft_stats.collisions;
+	adapter->net_stats.rx_errors = adapter->soft_stats.rx_errors;
+	adapter->net_stats.rx_over_errors =
+	    adapter->soft_stats.rx_missed_errors;
+	adapter->net_stats.rx_length_errors =
+	    adapter->soft_stats.rx_length_errors;
+	adapter->net_stats.rx_crc_errors = adapter->soft_stats.rx_crc_errors;
+	adapter->net_stats.rx_frame_errors =
+	    adapter->soft_stats.rx_frame_errors;
+	adapter->net_stats.rx_fifo_errors = adapter->soft_stats.rx_fifo_errors;
+	adapter->net_stats.rx_missed_errors =
+	    adapter->soft_stats.rx_missed_errors;
+	adapter->net_stats.tx_errors = adapter->soft_stats.tx_errors;
+	adapter->net_stats.tx_fifo_errors = adapter->soft_stats.tx_fifo_errors;
+	adapter->net_stats.tx_aborted_errors =
+	    adapter->soft_stats.tx_aborted_errors;
+	adapter->net_stats.tx_window_errors =
+	    adapter->soft_stats.tx_window_errors;
+	adapter->net_stats.tx_carrier_errors =
+	    adapter->soft_stats.tx_carrier_errors;
+}
+
+static inline void at_rx_checksum(struct at_adapter *adapter,
+				  struct rx_return_desc * rrd, struct sk_buff *skb)
+{
+	skb->ip_summed = CHECKSUM_NONE;
+
+	if (unlikely(rrd->pkt_flg & PACKET_FLAG_ERR)) {
+		if (rrd->err_flg & (ERR_FLAG_CRC | ERR_FLAG_TRUNC | 
+					ERR_FLAG_CODE | ERR_FLAG_OV)) {
+			adapter->hw_csum_err++;
+			printk(KERN_DEBUG "%s: rx checksum error\n", 
+				at_driver_name);
+			return;
+		}
+	}
+
+	/* not IPv4 */
+	if (!(rrd->pkt_flg & PACKET_FLAG_IPV4)) {
+		/* checksum is invalid, but it's not an IPv4 pkt, so ok */
+		return;
+	}
+
+	/* IPv4 packet */
+	if (likely(!(rrd->err_flg & 
+		(ERR_FLAG_IP_CHKSUM | ERR_FLAG_L4_CHKSUM)))) {
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		adapter->hw_csum_good++;
+		return;
+	}
+
+	/* IPv4, but hardware think it's checksum is wrong */
+	printk(KERN_DEBUG "%s: hw csum wrong pkt_flag:%x, err_flag:%x\n", 
+		at_driver_name, rrd->pkt_flg, rrd->err_flg);
+	skb->ip_summed = CHECKSUM_COMPLETE;
+	skb->csum = htons(rrd->xsz.xsum_sz.rx_chksum);
+	adapter->hw_csum_err++;
+	return;
+}
+
+/**
+ * at_alloc_rx_buffers - Replace used receive buffers
+ * @adapter: address of board private structure
+ **/
+static u16 at_alloc_rx_buffers(struct at_adapter *adapter)
+{
+	struct at_rfd_ring *rfd_ring = &adapter->rfd_ring;
+	struct net_device *netdev = adapter->netdev;
+	struct pci_dev *pdev = adapter->pdev;
+	struct page *page;
+	unsigned long offset;
+	struct at_buffer *buffer_info, *next_info;
+	struct sk_buff *skb;
+	u16 num_alloc = 0;
+	u16 rfd_next_to_use, next_next;
+	struct rx_free_desc *rfd_desc;
+
+	next_next = rfd_next_to_use = (u16) atomic_read(&rfd_ring->next_to_use);
+	if (++next_next == rfd_ring->count)
+		next_next = 0;
+	buffer_info = &rfd_ring->buffer_info[rfd_next_to_use];
+	next_info = &rfd_ring->buffer_info[next_next];
+
+	while (!buffer_info->alloced && !next_info->alloced) {
+		if (NULL != buffer_info->skb) {
+			buffer_info->alloced = 1;
+			goto next;
+		}
+
+		rfd_desc = AT_RFD_DESC(rfd_ring, rfd_next_to_use);
+
+		skb = dev_alloc_skb(adapter->rx_buffer_len + NET_IP_ALIGN);
+		if (unlikely(!skb)) {	/* Better luck next round */
+			adapter->net_stats.rx_dropped++;
+			break;
+		}
+
+		/* Make buffer alignment 2 beyond a 16 byte boundary
+		 * this will result in a 16 byte aligned IP header after
+		 * the 14 byte MAC header is removed */
+		skb_reserve(skb, NET_IP_ALIGN);
+		skb->dev = netdev;
+
+		buffer_info->alloced = 1;
+		buffer_info->skb = skb;
+		buffer_info->length = (u16) adapter->rx_buffer_len;
+		page = virt_to_page(skb->data);
+		offset = (unsigned long)skb->data & ~PAGE_MASK;
+		buffer_info->dma = pci_map_page(pdev, page, offset,
+						adapter->rx_buffer_len,
+						PCI_DMA_FROMDEVICE);
+		rfd_desc->buffer_addr = cpu_to_le64(buffer_info->dma);
+		rfd_desc->buf_len = cpu_to_le16(adapter->rx_buffer_len);
+		rfd_desc->coalese = 0;
+
+	      next:
+		rfd_next_to_use = next_next;
+		if (unlikely(++next_next == rfd_ring->count))
+			next_next = 0;
+
+		buffer_info = &rfd_ring->buffer_info[rfd_next_to_use];
+		next_info = &rfd_ring->buffer_info[next_next];
+		num_alloc++;
+	}
+
+	if (0 != num_alloc) {
+		/* Force memory writes to complete before letting h/w
+		 * know there are new descriptors to fetch.  (Only
+		 * applicable for weak-ordered memory model archs,
+		 * such as IA-64). */
+		wmb();
+		atomic_set(&rfd_ring->next_to_use, (int)rfd_next_to_use);
+	}
+	return num_alloc;
+}
+
+static void at_intr_rx(struct at_adapter *adapter)
+{
+	int i, count;
+	u16 length; 
+	u16 rrd_next_to_clean;
+	struct at_rfd_ring *rfd_ring = &adapter->rfd_ring;
+	struct at_rrd_ring *rrd_ring = &adapter->rrd_ring;
+	struct at_buffer *buffer_info;
+	struct rx_return_desc *rrd;
+	struct sk_buff *skb;
+
+	count = 0;
+
+	rrd_next_to_clean = (u16) atomic_read(&rrd_ring->next_to_clean);
+
+	while (1) {
+		rrd = AT_RRD_DESC(rrd_ring, rrd_next_to_clean);
+		i = 1;
+		if (likely(rrd->xsz.valid)) {	/* packet valid */
+		      chk_rrd:
+			/* check rrd status */
+			if (likely(rrd->num_buf == 1)) {
+				goto rrd_ok;
+			}
+
+			/* rrd seems to be bad */
+			if (unlikely(i-- > 0)) { 
+				/* rrd may not be DMAed completely */
+				printk(KERN_DEBUG 
+					"%s: RRD may not be DMAed completely\n", 
+					at_driver_name);
+				usec_delay(1);
+				goto chk_rrd;
+			}
+			/* bad rrd */
+			printk(KERN_DEBUG "%s: bad RRD\n", at_driver_name);
+			/* see if update RFD index */
+			if (rrd->num_buf > 1) {
+				u16 num_buf;
+				num_buf =
+				    (rrd->xsz.xsum_sz.pkt_size +
+				     adapter->rx_buffer_len -
+				     1) / adapter->rx_buffer_len;
+				if (rrd->num_buf == num_buf) {
+					/* clean alloc flag for bad rrd */
+					while (rfd_ring->next_to_clean !=
+					       (rrd->buf_indx + num_buf)) {
+						rfd_ring->buffer_info[rfd_ring->
+								      next_to_clean].alloced = 0;
+						if (++rfd_ring->next_to_clean ==
+						    rfd_ring->count) {
+							rfd_ring->
+							    next_to_clean = 0;
+						}
+					}
+				}
+			}
+
+			/* update rrd */
+			rrd->xsz.valid = 0;
+			if (++rrd_next_to_clean == rrd_ring->count)
+				rrd_next_to_clean = 0;
+			count++;
+			continue;
+		} else {	/* current rrd still not be updated */
+
+			break;
+		}
+	      rrd_ok:
+		/* printk(KERN_INFO "%s: receving packet\n", at_driver_name); */
+		/* clean alloc flag for bad rrd */
+		while (rfd_ring->next_to_clean != rrd->buf_indx) {
+			rfd_ring->buffer_info[rfd_ring->next_to_clean].alloced =
+			    0;
+			if (++rfd_ring->next_to_clean == rfd_ring->count) {
+				rfd_ring->next_to_clean = 0;
+			}
+		}
+
+		buffer_info = &rfd_ring->buffer_info[rrd->buf_indx];
+		if (++rfd_ring->next_to_clean == rfd_ring->count) {
+			rfd_ring->next_to_clean = 0;
+		}
+
+		/* update rrd next to clean */
+		if (++rrd_next_to_clean == rrd_ring->count)
+			rrd_next_to_clean = 0;
+		count++;
+
+		if (unlikely(rrd->pkt_flg & PACKET_FLAG_ERR)) {
+			if (!(rrd->err_flg & 
+				(ERR_FLAG_IP_CHKSUM | ERR_FLAG_L4_CHKSUM
+				| ERR_FLAG_LEN))) {
+				/* packet error, don't need upstream */
+				buffer_info->alloced = 0;
+				rrd->xsz.valid = 0;
+				continue;
+			}
+		}
+
+		/* Good Receive */
+		pci_unmap_page(adapter->pdev, buffer_info->dma,
+			       buffer_info->length, PCI_DMA_FROMDEVICE);
+		skb = buffer_info->skb;
+		length = le16_to_cpu(rrd->xsz.xsum_sz.pkt_size);
+
+		skb_put(skb, length - ETHERNET_FCS_SIZE);
+
+		/* Receive Checksum Offload */
+		at_rx_checksum(adapter, rrd, skb);
+		skb->protocol = eth_type_trans(skb, adapter->netdev);
+
+#ifdef NETIF_F_HW_VLAN_TX
+		if (adapter->vlgrp && (rrd->pkt_flg & PACKET_FLAG_VLAN_INS)) {
+			u16 vlan_tag = (rrd->vlan_tag >> 4) |
+			    		((rrd->vlan_tag & 7) << 13) | 
+					((rrd->vlan_tag & 8) << 9);
+			vlan_hwaccel_rx(skb, adapter->vlgrp, vlan_tag);
+		} else
+#endif
+			netif_rx(skb);
+
+		/* let protocol layer free skb */
+		buffer_info->skb = NULL;
+		buffer_info->alloced = 0;
+		rrd->xsz.valid = 0;
+
+		adapter->netdev->last_rx = jiffies;
+	}
+
+	atomic_set(&rrd_ring->next_to_clean, rrd_next_to_clean);
+
+	at_alloc_rx_buffers(adapter);
+
+	/* update mailbox ? */
+	if (0 != count) {
+		u32 tpd_next_to_use;
+		u32 rfd_next_to_use;
+		u32 rrd_next_to_clean;
+
+		spin_lock(&adapter->mb_lock);
+
+		tpd_next_to_use = atomic_read(&adapter->tpd_ring.next_to_use);
+		rfd_next_to_use =
+		    (u32) atomic_read(&adapter->rfd_ring.next_to_use);
+		rrd_next_to_clean =
+		    (u32) atomic_read(&adapter->rrd_ring.next_to_clean);
+		AT_WRITE_REG(&adapter->hw, REG_MAILBOX,
+			     ((rfd_next_to_use & MB_RFD_PROD_INDX_MASK) <<
+			      MB_RFD_PROD_INDX_SHIFT) | ((rrd_next_to_clean &
+							  MB_RRD_CONS_INDX_MASK)
+							 <<
+							 MB_RRD_CONS_INDX_SHIFT)
+			     | ((tpd_next_to_use & MB_TPD_PROD_INDX_MASK) <<
+				MB_TPD_PROD_INDX_SHIFT));
+
+		spin_unlock(&adapter->mb_lock);
+	}
+}
+
+static void at_intr_tx(struct at_adapter *adapter)
+{
+	struct at_tpd_ring *tpd_ring = &adapter->tpd_ring;
+	struct at_buffer *buffer_info;
+	u16 sw_tpd_next_to_clean;
+	u16 cmb_tpd_next_to_clean;
+	u8 update = 0;
+
+	sw_tpd_next_to_clean = (u16) atomic_read(&tpd_ring->next_to_clean);
+	cmb_tpd_next_to_clean = le16_to_cpu(adapter->cmb.cmb->tpd_cons_idx);
+
+	while (cmb_tpd_next_to_clean != sw_tpd_next_to_clean) {
+		struct tx_packet_desc *tpd;
+		update = 1;
+		tpd = AT_TPD_DESC(tpd_ring, sw_tpd_next_to_clean);
+		buffer_info = &tpd_ring->buffer_info[sw_tpd_next_to_clean];
+		if (buffer_info->dma) {
+			pci_unmap_page(adapter->pdev, buffer_info->dma,
+				       buffer_info->length, PCI_DMA_TODEVICE);
+			buffer_info->dma = 0;
+		}
+
+		if (buffer_info->skb) {
+			dev_kfree_skb_irq(buffer_info->skb);
+			buffer_info->skb = NULL;
+		}
+		tpd->buffer_addr = 0;
+		tpd->desc.data = 0;
+
+		if (++sw_tpd_next_to_clean == tpd_ring->count)
+			sw_tpd_next_to_clean = 0;
+	}
+	atomic_set(&tpd_ring->next_to_clean, sw_tpd_next_to_clean);
+
+	if (netif_queue_stopped(adapter->netdev)
+	    && netif_carrier_ok(adapter->netdev))
+		netif_wake_queue(adapter->netdev);
+}
+
+static void at_check_for_link(struct at_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	u16 phy_data = 0;
+
+	spin_lock(&adapter->stats_lock);
+	adapter->phy_timer_pending = false;
+	at_read_phy_reg(&adapter->hw, MII_BMSR, &phy_data);
+	at_read_phy_reg(&adapter->hw, MII_BMSR, &phy_data);
+	spin_unlock(&adapter->stats_lock);
+
+	/* notify upper layer link down ASAP */
+	if (!(phy_data & BMSR_LSTATUS)) {	/* Link Down */
+		if (netif_carrier_ok(netdev)) {	/* old link state: Up */
+			printk(KERN_INFO "%s: %s link is down\n",
+			       at_driver_name, netdev->name);
+			adapter->link_speed = SPEED_0;
+			netif_carrier_off(netdev);
+			netif_stop_queue(netdev);
+		}
+	}
+	schedule_work(&adapter->link_chg_task);
+}
+
+/**
+ * at_intr - Interrupt Handler
+ * @irq: interrupt number
+ * @data: pointer to a network interface device structure
+ * @pt_regs: CPU registers structure
+ **/
+static irqreturn_t at_intr(int irq, void *data)
+{
+	struct at_adapter *adapter = ((struct net_device *)data)->priv;
+	u32 status;
+	u8 update_rx;
+	int max_ints = 10;
+
+	if (0 == (status = adapter->cmb.cmb->int_stats))
+		return IRQ_NONE;
+
+	update_rx = 0;
+
+	do {
+		/* clear CMB interrupt status at once */
+		adapter->cmb.cmb->int_stats = 0;
+
+		if (status & ISR_GPHY) {	/* clear phy status */
+			at_clear_phy_int(adapter);
+		}
+		/* clear ISR status, and Enable CMB DMA/Disable Interrupt */
+		AT_WRITE_REG(&adapter->hw, REG_ISR, status | ISR_DIS_INT);
+
+		/* check if SMB intr */
+		if (status & ISR_SMB) {
+			at_inc_smb(adapter);
+		}
+
+		/* check if PCIE PHY Link down */
+		if (status & ISR_PHY_LINKDOWN) {
+			printk(KERN_DEBUG "%s: pcie phy link down %x\n", 
+				at_driver_name, status);
+			if (netif_running(adapter->netdev)) {	// reset MAC
+				AT_WRITE_REG(&adapter->hw, REG_IMR, 0);
+				schedule_work(&adapter->pcie_dma_to_rst_task);
+				return IRQ_HANDLED;
+			}
+		}
+
+		/* check if DMA read/write error ? */
+		if (status & (ISR_DMAR_TO_RST | ISR_DMAW_TO_RST)) {
+			printk(KERN_DEBUG 
+				"%s: pcie DMA r/w error (status = 0x%x)\n", 
+				at_driver_name, status);
+			/* AT_WRITE_REG(&adapter->hw, REG_MASTER_CTRL, MASTER_CTRL_SOFT_RST); */
+			AT_WRITE_REG(&adapter->hw, REG_IMR, 0);
+			schedule_work(&adapter->pcie_dma_to_rst_task);
+			return IRQ_HANDLED;
+		}
+
+		/* link event */
+		if (status & ISR_GPHY) {
+			adapter->soft_stats.tx_carrier_errors++;
+			at_check_for_link(adapter);
+		}
+
+		/* transmit event */
+		if (status & ISR_CMB_TX)
+			at_intr_tx(adapter);
+
+		/* rx exception */
+		if (unlikely(status & (ISR_RXF_OV | ISR_RFD_UNRUN | 
+				ISR_RRD_OV | ISR_HOST_RFD_UNRUN | 
+				ISR_HOST_RRD_OV | ISR_CMB_RX))) {
+			/* Why is this done twice? */
+			if (status &
+			    (ISR_RXF_OV | ISR_RFD_UNRUN | ISR_RRD_OV |
+			     ISR_HOST_RFD_UNRUN | ISR_HOST_RRD_OV)) {
+				printk(KERN_INFO
+					"%s: rx exception: status = 0x%x\n",
+ 					at_driver_name, status);
+			}
+			at_intr_rx(adapter);
+		}
+
+		if (--max_ints < 0)
+			break;
+
+	} while ((status = adapter->cmb.cmb->int_stats));
+
+	/* re-enable Interrupt */
+	AT_WRITE_REG(&adapter->hw, REG_ISR, ISR_DIS_SMB | ISR_DIS_DMA);
+	return IRQ_HANDLED;
+}
+
+/**
+ * at_set_multi - Multicast and Promiscuous mode set
+ * @netdev: network interface device structure
+ *
+ * The set_multi entry point is called whenever the multicast address
+ * list or the network interface flags are updated.  This routine is
+ * responsible for configuring the hardware for proper multicast,
+ * promiscuous mode, and all-multi behavior.
+ **/
+static void at_set_multi(struct net_device *netdev)
+{
+	struct at_adapter *adapter = netdev_priv(netdev);
+	struct at_hw *hw = &adapter->hw;
+	struct dev_mc_list *mc_ptr;
+	u32 rctl;
+	u32 hash_value;
+
+	/* Check for Promiscuous and All Multicast modes */
+	rctl = AT_READ_REG(hw, REG_MAC_CTRL);
+	if (netdev->flags & IFF_PROMISC) {
+		rctl |= MAC_CTRL_PROMIS_EN;
+	} else if (netdev->flags & IFF_ALLMULTI) {
+		rctl |= MAC_CTRL_MC_ALL_EN;
+		rctl &= ~MAC_CTRL_PROMIS_EN;
+	} else {
+		rctl &= ~(MAC_CTRL_PROMIS_EN | MAC_CTRL_MC_ALL_EN);
+	}
+
+	AT_WRITE_REG(hw, REG_MAC_CTRL, rctl);
+
+	/* clear the old settings from the multicast hash table */
+	AT_WRITE_REG(hw, REG_RX_HASH_TABLE, 0);
+	AT_WRITE_REG_ARRAY(hw, REG_RX_HASH_TABLE, 1, 0);
+
+	/* compute mc addresses' hash value ,and put it into hash table */
+	for (mc_ptr = netdev->mc_list; mc_ptr; mc_ptr = mc_ptr->next) {
+		hash_value = at_hash_mc_addr(hw, mc_ptr->dmi_addr);
+		at_hash_set(hw, hash_value);
+	}
+}
+
+static inline void at_setup_mac_ctrl(struct at_adapter *adapter)
+{
+	u32 value;
+	struct at_hw *hw = &adapter->hw;
+	struct net_device *netdev = adapter->netdev;
+	/* Config MAC CTRL Register */
+	value = MAC_CTRL_TX_EN | MAC_CTRL_RX_EN;
+	/* duplex */
+	if (FULL_DUPLEX == adapter->link_duplex)
+		value |= MAC_CTRL_DUPLX;
+	/* speed */
+	value |= ((u32) ((SPEED_1000 == adapter->link_speed) ?
+			 MAC_CTRL_SPEED_1000 : MAC_CTRL_SPEED_10_100) <<
+		  MAC_CTRL_SPEED_SHIFT);
+	/* flow control */
+	value |= (MAC_CTRL_TX_FLOW | MAC_CTRL_RX_FLOW);
+	/* PAD & CRC */
+	value |= (MAC_CTRL_ADD_CRC | MAC_CTRL_PAD);
+	/* preamble length */
+	value |= (((u32) adapter->hw.preamble_len
+		   & MAC_CTRL_PRMLEN_MASK) << MAC_CTRL_PRMLEN_SHIFT);
+	/* vlan */
+	if (adapter->vlgrp)
+		value |= MAC_CTRL_RMV_VLAN;
+	/* rx checksum
+	   if (adapter->rx_csum)
+	   value |= MAC_CTRL_RX_CHKSUM_EN;
+	 */
+	/* filter mode */
+	value |= MAC_CTRL_BC_EN;
+	if (netdev->flags & IFF_PROMISC)
+		value |= MAC_CTRL_PROMIS_EN;
+	else if (netdev->flags & IFF_ALLMULTI)
+		value |= MAC_CTRL_MC_ALL_EN;
+	/* value |= MAC_CTRL_LOOPBACK; */
+	AT_WRITE_REG(hw, REG_MAC_CTRL, value);
+}
+
+static u32 at_check_link(struct at_adapter *adapter)
+{
+	struct at_hw *hw = &adapter->hw;
+	struct net_device *netdev = adapter->netdev;
+	u32 ret_val;
+	u16 speed, duplex, phy_data;
+	int reconfig = 0;
+
+	/* MII_BMSR must read twise */
+	at_read_phy_reg(hw, MII_BMSR, &phy_data);
+	at_read_phy_reg(hw, MII_BMSR, &phy_data);
+	if (!(phy_data & BMSR_LSTATUS)) {	/* link down */
+		if (netif_carrier_ok(netdev)) {	/* old link state: Up */
+			printk(KERN_INFO "%s: link is down\n", at_driver_name);
+			adapter->link_speed = SPEED_0;
+			netif_carrier_off(netdev);
+			netif_stop_queue(netdev);
+		}
+		return AT_SUCCESS;
+	}
+
+	/* Link Up */
+	ret_val = at_get_speed_and_duplex(hw, &speed, &duplex);
+	if (ret_val)
+		return ret_val;
+
+	switch (hw->media_type) {
+	case MEDIA_TYPE_1000M_FULL:
+		if (speed != SPEED_1000 || duplex != FULL_DUPLEX)
+			reconfig = 1;
+		break;
+	case MEDIA_TYPE_100M_FULL:
+		if (speed != SPEED_100 || duplex != FULL_DUPLEX)
+			reconfig = 1;
+		break;
+	case MEDIA_TYPE_100M_HALF:
+		if (speed != SPEED_100 || duplex != HALF_DUPLEX)
+			reconfig = 1;
+		break;
+	case MEDIA_TYPE_10M_FULL:
+		if (speed != SPEED_10 || duplex != FULL_DUPLEX)
+			reconfig = 1;
+		break;
+	case MEDIA_TYPE_10M_HALF:
+		if (speed != SPEED_10 || duplex != HALF_DUPLEX)
+			reconfig = 1;
+		break;
+	}
+
+	/* link result is our setting */
+	if (0 == reconfig) {
+		if (adapter->link_speed != speed
+		    || adapter->link_duplex != duplex) {
+			adapter->link_speed = speed;
+			adapter->link_duplex = duplex;
+			at_setup_mac_ctrl(adapter);
+			printk(KERN_INFO "%s: %s link is up %d Mbps %s\n",
+			       at_driver_name, netdev->name,
+			       adapter->link_speed,
+			       adapter->link_duplex ==
+			       FULL_DUPLEX ? "full duplex" : "half duplex");
+		}
+		if (!netif_carrier_ok(netdev)) {	/* Link down -> Up */
+			netif_carrier_on(netdev);
+			netif_wake_queue(netdev);
+		}
+		return AT_SUCCESS;
+	}
+
+	/* change orignal link status */
+	if (netif_carrier_ok(netdev)) {
+		adapter->link_speed = SPEED_0;
+		netif_carrier_off(netdev);
+		netif_stop_queue(netdev);
+	}
+
+	if (hw->media_type != MEDIA_TYPE_AUTO_SENSOR &&
+	    hw->media_type != MEDIA_TYPE_1000M_FULL) {
+		switch (hw->media_type) {
+		case MEDIA_TYPE_100M_FULL:
+			phy_data = MII_CR_FULL_DUPLEX | MII_CR_SPEED_100 |
+			           MII_CR_RESET;
+			break;
+		case MEDIA_TYPE_100M_HALF:
+			phy_data = MII_CR_SPEED_100 | MII_CR_RESET;
+			break;
+		case MEDIA_TYPE_10M_FULL:
+			phy_data =
+			    MII_CR_FULL_DUPLEX | MII_CR_SPEED_10 | MII_CR_RESET;
+			break;
+		default:	/* MEDIA_TYPE_10M_HALF: */
+			phy_data = MII_CR_SPEED_10 | MII_CR_RESET;
+			break;
+		}
+		at_write_phy_reg(hw, MII_BMCR, phy_data);
+		return AT_SUCCESS;
+	}
+
+	/* auto-neg, insert timer to re-config phy */
+	if (!adapter->phy_timer_pending) {
+		adapter->phy_timer_pending = true;
+		mod_timer(&adapter->phy_config_timer, jiffies + 3 * HZ);
+	}
+
+	return AT_SUCCESS;
+}
+
+static inline void set_flow_ctrl_old(struct at_adapter *adapter)
+{
+	u32 hi, lo, value;
+
+	/* RFD Flow Control */
+	value = adapter->rfd_ring.count;
+	hi = value / 16;
+	if (hi < 2) {
+		hi = 2;
+	}
+	lo = value * 7 / 8;
+
+	value = ((hi & RXQ_RXF_PAUSE_TH_HI_MASK) << RXQ_RXF_PAUSE_TH_HI_SHIFT) |
+	    ((lo & RXQ_RXF_PAUSE_TH_LO_MASK) << RXQ_RXF_PAUSE_TH_LO_SHIFT);
+	AT_WRITE_REG(&adapter->hw, REG_RXQ_RXF_PAUSE_THRESH, value);
+
+	/* RRD Flow Control */
+	value = adapter->rrd_ring.count;
+	lo = value / 16;
+	hi = value * 7 / 8;
+	if (lo < 2) {
+		lo = 2;
+	}
+	value = ((hi & RXQ_RRD_PAUSE_TH_HI_MASK) << RXQ_RRD_PAUSE_TH_HI_SHIFT) |
+	    ((lo & RXQ_RRD_PAUSE_TH_LO_MASK) << RXQ_RRD_PAUSE_TH_LO_SHIFT);
+	AT_WRITE_REG(&adapter->hw, REG_RXQ_RRD_PAUSE_THRESH, value);
+}
+
+static inline void set_flow_ctrl_new(struct at_hw *hw)
+{
+	u32 hi, lo, value;
+
+	/* RXF Flow Control */
+	value = AT_READ_REG(hw, REG_SRAM_RXF_LEN);
+	lo = value / 16;
+	if (lo < 192) {
+		lo = 192;
+	}
+	hi = value * 7 / 8;
+	if (hi < lo) {
+		hi = lo + 16;
+	}
+	value = ((hi & RXQ_RXF_PAUSE_TH_HI_MASK) << RXQ_RXF_PAUSE_TH_HI_SHIFT) |
+	    ((lo & RXQ_RXF_PAUSE_TH_LO_MASK) << RXQ_RXF_PAUSE_TH_LO_SHIFT);
+	AT_WRITE_REG(hw, REG_RXQ_RXF_PAUSE_THRESH, value);
+
+	/* RRD Flow Control */
+	value = AT_READ_REG(hw, REG_SRAM_RRD_LEN);
+	lo = value / 8;
+	hi = value * 7 / 8;
+	if (lo < 2) {
+		lo = 2;
+	}
+	if (hi < lo) {
+		hi = lo + 3;
+	}
+	value = ((hi & RXQ_RRD_PAUSE_TH_HI_MASK) << RXQ_RRD_PAUSE_TH_HI_SHIFT) |
+	    ((lo & RXQ_RRD_PAUSE_TH_LO_MASK) << RXQ_RRD_PAUSE_TH_LO_SHIFT);
+	AT_WRITE_REG(hw, REG_RXQ_RRD_PAUSE_THRESH, value);
+}
+
+/**
+ * at_configure - Configure Transmit&Receive Unit after Reset
+ * @adapter: board private structure
+ *
+ * Configure the Tx /Rx unit of the MAC after a reset.
+ **/
+static u32 at_configure(struct at_adapter *adapter)
+{
+	struct at_hw *hw = &adapter->hw;
+	u32 value;
+
+	/* clear interrupt status */
+	AT_WRITE_REG(&adapter->hw, REG_ISR, 0xffffffff);
+
+	/* set MAC Address */
+	value = (((u32) hw->mac_addr[2]) << 24) |
+	    (((u32) hw->mac_addr[3]) << 16) |
+	    (((u32) hw->mac_addr[4]) << 8) | (((u32) hw->mac_addr[5]));
+	AT_WRITE_REG(hw, REG_MAC_STA_ADDR, value);
+	value = (((u32) hw->mac_addr[0]) << 8) | (((u32) hw->mac_addr[1]));
+	AT_WRITE_REG(hw, (REG_MAC_STA_ADDR + 4), value);
+
+	/* tx / rx ring */
+
+	/* HI base address */
+	AT_WRITE_REG(hw, REG_DESC_BASE_ADDR_HI,
+		     (u32) ((adapter->tpd_ring.
+			     dma & 0xffffffff00000000ULL) >> 32));
+	/* LO base address */
+	AT_WRITE_REG(hw, REG_DESC_RFD_ADDR_LO,
+		     (u32) (adapter->rfd_ring.dma & 0x00000000ffffffffULL));
+	AT_WRITE_REG(hw, REG_DESC_RRD_ADDR_LO,
+		     (u32) (adapter->rrd_ring.dma & 0x00000000ffffffffULL));
+	AT_WRITE_REG(hw, REG_DESC_TPD_ADDR_LO,
+		     (u32) (adapter->tpd_ring.dma & 0x00000000ffffffffULL));
+	AT_WRITE_REG(hw, REG_DESC_CMB_ADDR_LO,
+		     (u32) (adapter->cmb.dma & 0x00000000ffffffffULL));
+	AT_WRITE_REG(hw, REG_DESC_SMB_ADDR_LO,
+		     (u32) (adapter->smb.dma & 0x00000000ffffffffULL));
+
+	/* element count */
+	value = adapter->rrd_ring.count;
+	value <<= 16;
+	value += adapter->rfd_ring.count;
+	AT_WRITE_REG(hw, REG_DESC_RFD_RRD_RING_SIZE, value);
+	AT_WRITE_REG(hw, REG_DESC_TPD_RING_SIZE, adapter->tpd_ring.count);
+
+/* FIXME: use or remove -- CHS
+    // config SRAM
+    // add RXF 256*8 bytes   
+    value = ((2795 + 256) << 16) | 432;
+    AT_WRITE_REG(hw, REG_SRAM_RXF_ADDR, value);
+    value = 2364 + 256;
+    AT_WRITE_REG(hw, REG_SRAM_RXF_LEN, value);
+    // sub TXF 256*8 bytes
+    value = (4075 << 16) | (2796 + 256);
+    AT_WRITE_REG(hw, REG_SRAM_TXF_ADDR, value);
+    value = 1280 - 256;
+    AT_WRITE_REG(hw, REG_SRAM_TXF_LEN, value);
+*/
+	/* Load Ptr */
+	AT_WRITE_REG(hw, REG_LOAD_PTR, 1);
+
+	/* config Mailbox */
+	value = (((u32) atomic_read(&adapter->tpd_ring.next_to_use)
+		  & MB_TPD_PROD_INDX_MASK) << MB_TPD_PROD_INDX_SHIFT) |
+	    (((u32) atomic_read(&adapter->rrd_ring.next_to_clean)
+	      & MB_RRD_CONS_INDX_MASK) << MB_RRD_CONS_INDX_SHIFT) |
+	    (((u32) atomic_read(&adapter->rfd_ring.next_to_use)
+	      & MB_RFD_PROD_INDX_MASK) << MB_RFD_PROD_INDX_SHIFT);
+	AT_WRITE_REG(hw, REG_MAILBOX, value);
+
+	/* config IPG/IFG */
+	value = (((u32) hw->ipgt & MAC_IPG_IFG_IPGT_MASK)
+		 << MAC_IPG_IFG_IPGT_SHIFT) |
+	    (((u32) hw->min_ifg & MAC_IPG_IFG_MIFG_MASK)
+	     << MAC_IPG_IFG_MIFG_SHIFT) |
+	    (((u32) hw->ipgr1 & MAC_IPG_IFG_IPGR1_MASK)
+	     << MAC_IPG_IFG_IPGR1_SHIFT) |
+	    (((u32) hw->ipgr2 & MAC_IPG_IFG_IPGR2_MASK)
+	     << MAC_IPG_IFG_IPGR2_SHIFT);
+	AT_WRITE_REG(hw, REG_MAC_IPG_IFG, value);
+
+	/* config  Half-Duplex Control */
+	value = ((u32) hw->lcol & MAC_HALF_DUPLX_CTRL_LCOL_MASK) |
+	    (((u32) hw->max_retry & MAC_HALF_DUPLX_CTRL_RETRY_MASK)
+	     << MAC_HALF_DUPLX_CTRL_RETRY_SHIFT) |
+	    MAC_HALF_DUPLX_CTRL_EXC_DEF_EN |
+	    (0xa << MAC_HALF_DUPLX_CTRL_ABEBT_SHIFT) |
+	    (((u32) hw->jam_ipg & MAC_HALF_DUPLX_CTRL_JAMIPG_MASK)
+	     << MAC_HALF_DUPLX_CTRL_JAMIPG_SHIFT);
+	AT_WRITE_REG(hw, REG_MAC_HALF_DUPLX_CTRL, value);
+
+	/* set Interrupt Moderator Timer */
+	AT_WRITE_REGW(hw, REG_IRQ_MODU_TIMER_INIT, adapter->imt);
+	AT_WRITE_REG(hw, REG_MASTER_CTRL, MASTER_CTRL_ITIMER_EN);
+
+	/* set Interrupt Clear Timer */
+	AT_WRITE_REGW(hw, REG_CMBDISDMA_TIMER, adapter->ict);
+
+	/* set MTU, 4 : VLAN */
+	AT_WRITE_REG(hw, REG_MTU, hw->max_frame_size + 4);
+
+	/* jumbo size & rrd retirement timer */
+	value = (((u32) hw->rx_jumbo_th & RXQ_JMBOSZ_TH_MASK)
+		 << RXQ_JMBOSZ_TH_SHIFT) |
+	    (((u32) hw->rx_jumbo_lkah & RXQ_JMBO_LKAH_MASK)
+	     << RXQ_JMBO_LKAH_SHIFT) |
+	    (((u32) hw->rrd_ret_timer & RXQ_RRD_TIMER_MASK)
+	     << RXQ_RRD_TIMER_SHIFT);
+	AT_WRITE_REG(hw, REG_RXQ_JMBOSZ_RRDTIM, value);
+
+	/* Flow Control */
+	switch (hw->dev_rev) {
+	case 0x8001:
+	case 0x9001:
+	case 0x9002:
+	case 0x9003:
+		set_flow_ctrl_old(adapter);
+		break;
+	default:
+		set_flow_ctrl_new(hw);
+		break;
+	}
+
+	/* config TXQ */
+	value = (((u32) hw->tpd_burst & TXQ_CTRL_TPD_BURST_NUM_MASK)
+		 << TXQ_CTRL_TPD_BURST_NUM_SHIFT) |
+	    (((u32) hw->txf_burst & TXQ_CTRL_TXF_BURST_NUM_MASK)
+	     << TXQ_CTRL_TXF_BURST_NUM_SHIFT) |
+	    (((u32) hw->tpd_fetch_th & TXQ_CTRL_TPD_FETCH_TH_MASK)
+	     << TXQ_CTRL_TPD_FETCH_TH_SHIFT) | TXQ_CTRL_ENH_MODE | TXQ_CTRL_EN;
+	AT_WRITE_REG(hw, REG_TXQ_CTRL, value);
+
+	/* min tpd fetch gap & tx jumbo packet size threshold for taskoffload */
+	value = (((u32) hw->tx_jumbo_task_th & TX_JUMBO_TASK_TH_MASK)
+		 << TX_JUMBO_TASK_TH_SHIFT) |
+	    (((u32) hw->tpd_fetch_gap & TX_TPD_MIN_IPG_MASK)
+	     << TX_TPD_MIN_IPG_SHIFT);
+	AT_WRITE_REG(hw, REG_TX_JUMBO_TASK_TH_TPD_IPG, value);
+
+	/* config RXQ */
+	value = (((u32) hw->rfd_burst & RXQ_CTRL_RFD_BURST_NUM_MASK)
+		 << RXQ_CTRL_RFD_BURST_NUM_SHIFT) |
+	    (((u32) hw->rrd_burst & RXQ_CTRL_RRD_BURST_THRESH_MASK)
+	     << RXQ_CTRL_RRD_BURST_THRESH_SHIFT) |
+	    (((u32) hw->rfd_fetch_gap & RXQ_CTRL_RFD_PREF_MIN_IPG_MASK)
+	     << RXQ_CTRL_RFD_PREF_MIN_IPG_SHIFT) |
+	    RXQ_CTRL_CUT_THRU_EN | RXQ_CTRL_EN;
+	AT_WRITE_REG(hw, REG_RXQ_CTRL, value);
+
+	/* config DMA Engine */
+	value = ((((u32) hw->dmar_block) & DMA_CTRL_DMAR_BURST_LEN_MASK)
+		 << DMA_CTRL_DMAR_BURST_LEN_SHIFT) |
+	    ((((u32) hw->dmaw_block) & DMA_CTRL_DMAR_BURST_LEN_MASK)
+	     << DMA_CTRL_DMAR_BURST_LEN_SHIFT) |
+	    DMA_CTRL_DMAR_EN | DMA_CTRL_DMAW_EN;
+	value |= (u32) hw->dma_ord;
+	if (at_rcb_128 == hw->rcb_value)
+		value |= DMA_CTRL_RCB_VALUE;
+	AT_WRITE_REG(hw, REG_DMA_CTRL, value);
+
+	/* config CMB / SMB */
+	value = hw->cmb_rrd | ((u32) hw->cmb_tpd << 16);
+	AT_WRITE_REG(hw, REG_CMB_WRITE_TH, value);
+	value = hw->cmb_rx_timer | ((u32) hw->cmb_tx_timer << 16);
+	AT_WRITE_REG(hw, REG_CMB_WRITE_TIMER, value);
+	AT_WRITE_REG(hw, REG_SMB_TIMER, hw->smb_timer);
+
+	/* --- enable CMB / SMB */
+	value = CSMB_CTRL_CMB_EN | CSMB_CTRL_SMB_EN;
+	AT_WRITE_REG(hw, REG_CSMB_CTRL, value);
+
+	value = AT_READ_REG(&adapter->hw, REG_ISR);
+	if (unlikely((value & ISR_PHY_LINKDOWN) != 0)) {
+		value = 1;	/* config failed */
+	} else {
+		value = 0;
+	}
+	/* clear all interrupt status */
+	AT_WRITE_REG(&adapter->hw, REG_ISR, 0x3fffffff);
+	AT_WRITE_REG(&adapter->hw, REG_ISR, 0);
+	return value;
+}
+
+/**
+ * at_irq_disable - Mask off interrupt generation on the NIC
+ * @adapter: board private structure
+ **/
+inline void at_irq_disable(struct at_adapter *adapter)
+{
+	atomic_inc(&adapter->irq_sem);
+	AT_WRITE_REG(&adapter->hw, REG_IMR, 0);
+	synchronize_irq(adapter->pdev->irq);
+}
+
+#ifdef NETIF_F_HW_VLAN_TX
+static void at_vlan_rx_register(struct net_device *netdev,
+				struct vlan_group *grp)
+{
+	struct at_adapter *adapter = netdev_priv(netdev);
+	u32 ctrl;
+
+	at_irq_disable(adapter);
+	adapter->vlgrp = grp;
+
+	if (grp) {
+		/* enable VLAN tag insert/strip */
+		ctrl = AT_READ_REG(&adapter->hw, REG_MAC_CTRL);
+		ctrl |= MAC_CTRL_RMV_VLAN;
+		AT_WRITE_REG(&adapter->hw, REG_MAC_CTRL, ctrl);
+	} else {
+		/* disable VLAN tag insert/strip */
+		ctrl = AT_READ_REG(&adapter->hw, REG_MAC_CTRL);
+		ctrl &= ~MAC_CTRL_RMV_VLAN;
+		AT_WRITE_REG(&adapter->hw, REG_MAC_CTRL, ctrl);
+	}
+
+	at_irq_enable(adapter);
+}
+
+/** FIXME: justify or remove -- CHS */
+static void at_vlan_rx_add_vid(struct net_device *netdev, u16 vid)
+{
+	/* We don't do Vlan filtering */
+	return;
+}
+
+/** FIXME: this looks wrong too -- CHS */
+static void at_vlan_rx_kill_vid(struct net_device *netdev, u16 vid)
+{
+	struct at_adapter *adapter = netdev_priv(netdev);
+	at_irq_disable(adapter);
+	if (adapter->vlgrp) {
+		adapter->vlgrp->vlan_devices[vid] = NULL;
+	}
+	at_irq_enable(adapter);
+	/* We don't do Vlan filtering */
+	return;
+}
+
+static void at_restore_vlan(struct at_adapter *adapter)
+{
+	at_vlan_rx_register(adapter->netdev, adapter->vlgrp);
+	if (adapter->vlgrp) {
+		u16 vid;
+		for (vid = 0; vid < VLAN_GROUP_ARRAY_LEN; vid++) {
+			if (!adapter->vlgrp->vlan_devices[vid])
+				continue;
+			at_vlan_rx_add_vid(adapter->netdev, vid);
+		}
+	}
+}
+#endif				/* NETIF_F_HW_VLAN_TX */
+
+static inline u16 tpd_avail(struct at_tpd_ring *tpd_ring)
+{
+	u16 next_to_clean = (u16) atomic_read(&tpd_ring->next_to_clean);
+	u16 next_to_use = (u16) atomic_read(&tpd_ring->next_to_use);
+	return ((next_to_clean >
+		 next_to_use) ? next_to_clean - next_to_use -
+		1 : tpd_ring->count + next_to_clean - next_to_use - 1);
+}
+
+static inline int at_tso(struct at_adapter *adapter, struct sk_buff *skb,
+			 struct tso_param * tso)
+{
+#ifdef NETIF_F_TSO
+	u8 ipofst;
+	int err;
+
+	if (skb_shinfo(skb)->gso_size) {
+		if (skb_header_cloned(skb)) {
+			err = pskb_expand_head(skb, 0, 0, GFP_ATOMIC);
+			if (unlikely(err))
+				return err;
+		}
+
+		if (skb->protocol == ntohs(ETH_P_IP)) {
+			skb->nh.iph->tot_len = 0;
+			skb->nh.iph->check = 0;
+			skb->h.th->check =
+			    ~csum_tcpudp_magic(skb->nh.iph->saddr,
+					       skb->nh.iph->daddr, 0,
+					       IPPROTO_TCP, 0);
+			ipofst = skb->nh.raw - skb->data;
+			if (14 != ipofst)	/* 802.3 frame */
+				tso->eth_type = 1;
+
+			tso->iphl = skb->nh.iph->ihl;
+			tso->tcp_hdrlen = skb->h.th->doff << 2;
+			tso->mss = skb_shinfo(skb)->gso_size;
+			tso->ip_chksum = 1;
+			tso->tcp_chksum = 1;
+			tso->segment = 1;
+			return true;
+		}
+	}
+#endif				/* NETIF_F_TSO */
+	return false;
+}
+
+static inline int at_tx_csum(struct at_adapter *adapter, struct sk_buff *skb,
+			     struct csum_param * csum)
+{
+	u8 css, cso;
+
+	if (likely(skb->ip_summed == CHECKSUM_PARTIAL)) {
+		cso = skb->h.raw - skb->data;
+		css = (skb->h.raw + skb->csum) - skb->data;
+		if (unlikely(cso & 0x1)) {
+			printk(KERN_DEBUG "%s: payload offset != even number\n",
+				at_driver_name);
+			return -1;
+		}
+		csum->payload_offset = cso;
+		csum->xsum_offset = css;
+		csum->custom_chksum = 1;
+		return true;
+	}
+
+	return true;
+}
+
+static inline void at_tx_map(struct at_adapter *adapter, struct sk_buff *skb,
+			     bool tcp_seg)
+{
+	struct at_tpd_ring *tpd_ring = &adapter->tpd_ring;
+	struct at_buffer *buffer_info;
+	u16 first_buf_len = skb->len;
+	struct page *page;
+	unsigned long offset;
+	u16 tpd_next_to_use;
+#ifdef NETIF_F_TSO
+	u16 proto_hdr_len;
+#endif
+#ifdef MAX_SKB_FRAGS
+	unsigned int nr_frags;
+	unsigned int f;
+	first_buf_len -= skb->data_len;
+	nr_frags = skb_shinfo(skb)->nr_frags;
+#endif
+	tpd_next_to_use = (u16) atomic_read(&tpd_ring->next_to_use);
+	buffer_info = &tpd_ring->buffer_info[tpd_next_to_use];
+	if (unlikely(buffer_info->skb)) {
+		BUG();
+	}
+	buffer_info->skb = NULL;	/* put skb in last TPD */
+#ifdef NETIF_F_TSO
+	if (tcp_seg) {
+		proto_hdr_len =
+		    ((skb->h.raw - skb->data) + (skb->h.th->doff << 2));
+		buffer_info->length = proto_hdr_len;
+		page = virt_to_page(skb->data);
+		offset = (unsigned long)skb->data & ~PAGE_MASK;
+		buffer_info->dma = pci_map_page(adapter->pdev, page,
+						offset, proto_hdr_len,
+						PCI_DMA_TODEVICE);
+
+		if (++tpd_next_to_use == tpd_ring->count)
+			tpd_next_to_use = 0;
+
+		if (first_buf_len > proto_hdr_len) {
+			u16 len12 = first_buf_len - proto_hdr_len;
+			u16 i, m =
+			    (len12 + MAX_TX_BUF_LEN - 1) / MAX_TX_BUF_LEN;
+			for (i = 0; i < m; i++) {
+				buffer_info =
+				    &tpd_ring->buffer_info[tpd_next_to_use];
+				buffer_info->skb = NULL;
+				buffer_info->length =
+				    (MAX_TX_BUF_LEN >=
+				     len12) ? MAX_TX_BUF_LEN : len12;
+				len12 -= buffer_info->length;
+				page =
+				    virt_to_page(skb->data +
+						 (proto_hdr_len +
+						  i * MAX_TX_BUF_LEN));
+				offset =
+				    (unsigned long)(skb->data +
+						    (proto_hdr_len +
+						     i *
+						     MAX_TX_BUF_LEN)) &
+				    ~PAGE_MASK;
+				buffer_info->dma =
+				    pci_map_page(adapter->pdev, page, offset,
+						 buffer_info->length,
+						 PCI_DMA_TODEVICE);
+				if (++tpd_next_to_use == tpd_ring->count)
+					tpd_next_to_use = 0;
+			}
+		}
+	} else {
+#endif	/* NETIF_F_TSO */
+		buffer_info->length = first_buf_len;
+		page = virt_to_page(skb->data);
+		offset = (unsigned long)skb->data & ~PAGE_MASK;
+		buffer_info->dma = pci_map_page(adapter->pdev, page,
+						offset, first_buf_len,
+						PCI_DMA_TODEVICE);
+		if (++tpd_next_to_use == tpd_ring->count)
+			tpd_next_to_use = 0;
+#ifdef NETIF_F_TSO
+	}
+#endif	/* NETIF_F_TSO */
+
+#ifdef MAX_SKB_FRAGS
+	for (f = 0; f < nr_frags; f++) {
+		struct skb_frag_struct *frag;
+		u16 lenf, i, m;
+
+		frag = &skb_shinfo(skb)->frags[f];
+		lenf = frag->size;
+
+		m = (lenf + MAX_TX_BUF_LEN - 1) / MAX_TX_BUF_LEN;
+		for (i = 0; i < m; i++) {
+			buffer_info = &tpd_ring->buffer_info[tpd_next_to_use];
+			if (unlikely(buffer_info->skb)) {
+				BUG();
+			}
+			buffer_info->skb = NULL;
+			buffer_info->length =
+			    (lenf > MAX_TX_BUF_LEN) ? MAX_TX_BUF_LEN : lenf;
+			lenf -= buffer_info->length;
+			buffer_info->dma =
+			    pci_map_page(adapter->pdev, frag->page,
+					 frag->page_offset + i * MAX_TX_BUF_LEN,
+					 buffer_info->length, PCI_DMA_TODEVICE);
+
+			if (++tpd_next_to_use == tpd_ring->count)
+				tpd_next_to_use = 0;
+		}
+	}
+#endif	/* MAX_SKB_FRAGS */
+	/* last tpd's buffer-info */
+	buffer_info->skb = skb;
+}
+
+static inline void at_tx_queue(struct at_adapter *adapter, int count,
+			       union tpd_descr * descr)
+{
+	struct at_tpd_ring *tpd_ring = &adapter->tpd_ring;
+	int j;
+	struct at_buffer *buffer_info;
+	struct tx_packet_desc *tpd;
+	u16 tpd_next_to_use = (u16) atomic_read(&tpd_ring->next_to_use);
+
+	for (j = 0; j < count; j++) {
+		buffer_info = &tpd_ring->buffer_info[tpd_next_to_use];
+		tpd = AT_TPD_DESC(&adapter->tpd_ring, tpd_next_to_use);
+		tpd->buffer_addr = cpu_to_le64(buffer_info->dma);
+		tpd->desc.data = descr->data;
+		tpd->desc.csum.buf_len = cpu_to_le16(buffer_info->length);
+#ifdef NETIF_F_TSO
+		if ((descr->tso.segment) && (0 == j))
+			tpd->desc.tso.hdr_flg = 1;
+#endif
+		if (j == (count - 1))
+			tpd->desc.csum.eop = 1;
+		if (++tpd_next_to_use == tpd_ring->count)
+			tpd_next_to_use = 0;
+	}
+	/* Force memory writes to complete before letting h/w
+	 * know there are new descriptors to fetch.  (Only
+	 * applicable for weak-ordered memory model archs,
+	 * such as IA-64). */
+	wmb();
+
+	atomic_set(&tpd_ring->next_to_use, (int)tpd_next_to_use);
+}
+
+static inline void at_update_mailbox(struct at_adapter *adapter)
+{
+	unsigned long flags;
+	u32 tpd_next_to_use;
+	u32 rfd_next_to_use;
+	u32 rrd_next_to_clean;
+
+	spin_lock_irqsave(&adapter->mb_lock, flags);
+
+	tpd_next_to_use = atomic_read(&adapter->tpd_ring.next_to_use);
+	rfd_next_to_use = (u32) atomic_read(&adapter->rfd_ring.next_to_use);
+	rrd_next_to_clean = (u32) atomic_read(&adapter->rrd_ring.next_to_clean);
+
+	AT_WRITE_REG(&adapter->hw, REG_MAILBOX,
+		     ((rfd_next_to_use & MB_RFD_PROD_INDX_MASK) <<
+		      MB_RFD_PROD_INDX_SHIFT) | ((rrd_next_to_clean &
+						  MB_RRD_CONS_INDX_MASK) <<
+		      MB_RRD_CONS_INDX_SHIFT) | ((tpd_next_to_use &
+ 						  MB_TPD_PROD_INDX_MASK) <<
+		      MB_TPD_PROD_INDX_SHIFT));
+
+	spin_unlock_irqrestore(&adapter->mb_lock, flags);
+}
+
+static int at_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct at_adapter *adapter = netdev_priv(netdev);
+	unsigned int len = skb->len;
+	unsigned long flags;
+	unsigned int nr_frags = 0;
+	int tso;
+	int count = 1;
+	union tpd_descr param;
+
+#ifdef NETIF_F_TSO
+	unsigned int mss = 0;
+#endif
+#ifdef MAX_SKB_FRAGS
+	unsigned int f;
+	len -= skb->data_len;
+#endif
+	if (unlikely(skb->len <= 0)) {
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+	param.data = 0;
+#ifdef MAX_SKB_FRAGS
+	nr_frags = skb_shinfo(skb)->nr_frags;
+	for (f = 0; f < nr_frags; f++) {
+		u16 fg_size = skb_shinfo(skb)->frags[f].size;
+		if (fg_size) {
+			count +=
+			    (fg_size + MAX_TX_BUF_LEN - 1) / MAX_TX_BUF_LEN;
+		}
+	}
+#endif	/* MAX_SKB_FRAGS */
+#ifdef NETIF_F_TSO
+	mss = skb_shinfo(skb)->gso_size;
+	/* first buffer must be large(or equal) than protocol header length. */
+	if (mss) {
+		unsigned int proto_hdr_len;
+		if (skb->protocol == ntohs(ETH_P_IP)) {
+			proto_hdr_len =
+			    ((skb->h.raw - skb->data) + (skb->h.th->doff << 2));
+			if (unlikely(proto_hdr_len > len)) {
+				printk(KERN_WARNING
+				       "%s: protocol header length = 0x%x, buffer header length = 0x%x\n", at_driver_name, proto_hdr_len, len);
+				dev_kfree_skb_any(skb);
+				return NETDEV_TX_OK;
+			}
+			/* need additional TPD ? */
+			if (proto_hdr_len != len) {
+				count +=
+				    (len - proto_hdr_len + MAX_TX_BUF_LEN -
+				     1) / MAX_TX_BUF_LEN;
+			}
+		}
+	}
+#endif				/* NETIF_F_TSO */
+#ifdef NETIF_F_LLTX
+	local_irq_save(flags);
+	if (!spin_trylock(&adapter->tx_lock)) {
+		/* Collision - tell upper layer to requeue */
+		local_irq_restore(flags);
+		return NETDEV_TX_LOCKED;
+	}
+#else
+	spin_lock_irqsave(&adapter->tx_lock, flags);
+#endif
+	if (tpd_avail(&adapter->tpd_ring) < count) {
+		/* no enough descriptor */
+		netif_stop_queue(netdev);
+		spin_unlock_irqrestore(&adapter->tx_lock, flags);
+		return NETDEV_TX_BUSY;
+	}
+#ifndef NETIF_F_LLTX
+	spin_unlock_irqrestore(&adapter->tx_lock, flags);
+#endif
+	param.data = 0;
+#ifdef NETIF_F_HW_VLAN_TX
+	if (adapter->vlgrp && vlan_tx_tag_present(skb)) {
+		u16 vlan_tag = vlan_tx_tag_get(skb);
+		vlan_tag =
+		    (vlan_tag << 4) | (vlan_tag >> 13) | ((vlan_tag >> 9) &
+							  0x8);
+		param.csum.ins_vlag = 1;
+		param.csum.valan_tag = vlan_tag;
+	}
+#endif
+	tso = at_tso(adapter, skb, &param.tso);
+	if (tso < 0) {
+#ifdef NETIF_F_LLTX
+		spin_unlock_irqrestore(&adapter->tx_lock, flags);
+#endif
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
+	if (!tso) {
+		if (at_tx_csum(adapter, skb, &param.csum) < 0) {
+			spin_unlock_irqrestore(&adapter->tx_lock, flags);
+			dev_kfree_skb_any(skb);
+			return NETDEV_TX_OK;
+		}
+	}
+
+	at_tx_map(adapter, skb, 1 == param.csum.segment);
+	at_tx_queue(adapter, count, &param);
+
+	netdev->trans_start = jiffies;
+#ifdef NETIF_F_LLTX
+	spin_unlock_irqrestore(&adapter->tx_lock, flags);
+#endif
+	/* update mailbox */
+	at_update_mailbox(adapter);
+
+	return NETDEV_TX_OK;
+}
+
+/**
+ * at_get_stats - Get System Network Statistics
+ * @netdev: network interface device structure
+ *
+ * Returns the address of the device statistics structure.
+ * The statistics are actually updated from the timer callback.
+ **/
+static struct net_device_stats *at_get_stats(struct net_device *netdev)
+{
+	struct at_adapter *adapter = netdev_priv(netdev);
+	return &adapter->net_stats;
+}
+
+/**
+ * at_clean_rx_ring - Free RFD Buffers
+ * @adapter: board private structure
+ **/
+static void at_clean_rx_ring(struct at_adapter *adapter)
+{
+	struct at_rfd_ring *rfd_ring = &adapter->rfd_ring;
+	struct at_rrd_ring *rrd_ring = &adapter->rrd_ring;
+	struct at_buffer *buffer_info;
+	struct pci_dev *pdev = adapter->pdev;
+	unsigned long size;
+	unsigned int i;
+
+	/* Free all the Rx ring sk_buffs */
+	for (i = 0; i < rfd_ring->count; i++) {
+		buffer_info = &rfd_ring->buffer_info[i];
+		if (buffer_info->dma) {
+			pci_unmap_page(pdev, 
+					buffer_info->dma,
+					buffer_info->length, 
+					PCI_DMA_FROMDEVICE);
+			buffer_info->dma = 0;
+		}
+		if (buffer_info->skb) {
+			dev_kfree_skb(buffer_info->skb);
+			buffer_info->skb = NULL;
+		}
+	}
+
+	size = sizeof(struct at_buffer) * rfd_ring->count;
+	memset(rfd_ring->buffer_info, 0, size);
+
+	/* Zero out the descriptor ring */
+	memset(rfd_ring->desc, 0, rfd_ring->size);
+
+	rfd_ring->next_to_clean = 0;
+	atomic_set(&rfd_ring->next_to_use, 0);
+
+	rrd_ring->next_to_use = 0;
+	atomic_set(&rrd_ring->next_to_clean, 0);
+}
+
+/**
+ * at_clean_tx_ring - Free Tx Buffers
+ * @adapter: board private structure
+ **/
+static void at_clean_tx_ring(struct at_adapter *adapter)
+{
+	struct at_tpd_ring *tpd_ring = &adapter->tpd_ring;
+	struct at_buffer *buffer_info;
+	struct pci_dev *pdev = adapter->pdev;
+	unsigned long size;
+	unsigned int i;
+
+	/* Free all the Tx ring sk_buffs */
+	for (i = 0; i < tpd_ring->count; i++) {
+		buffer_info = &tpd_ring->buffer_info[i];
+		if (buffer_info->dma) {
+			pci_unmap_page(pdev, buffer_info->dma,
+				       buffer_info->length, PCI_DMA_TODEVICE);
+			buffer_info->dma = 0;
+		}
+	}
+
+	for (i = 0; i < tpd_ring->count; i++) {
+		buffer_info = &tpd_ring->buffer_info[i];
+		if (buffer_info->skb) {
+			dev_kfree_skb_any(buffer_info->skb);
+			buffer_info->skb = NULL;
+		}
+	}
+
+	size = sizeof(struct at_buffer) * tpd_ring->count;
+	memset(tpd_ring->buffer_info, 0, size);
+
+	/* Zero out the descriptor ring */
+	memset(tpd_ring->desc, 0, tpd_ring->size);
+
+	atomic_set(&tpd_ring->next_to_use, 0);
+	atomic_set(&tpd_ring->next_to_clean, 0);
+}
+
+/**
+ * at_free_ring_resources - Free Tx / RX descriptor Resources
+ * @adapter: board private structure
+ *
+ * Free all transmit software resources
+ **/
+void at_free_ring_resources(struct at_adapter *adapter)
+{
+	struct pci_dev *pdev = adapter->pdev;
+	struct at_tpd_ring *tpd_ring = &adapter->tpd_ring;
+	struct at_rfd_ring *rfd_ring = &adapter->rfd_ring;
+	struct at_rrd_ring *rrd_ring = &adapter->rrd_ring;
+	struct at_ring_header *ring_header = &adapter->ring_header;
+
+	at_clean_tx_ring(adapter);
+	at_clean_rx_ring(adapter);
+
+	kfree(tpd_ring->buffer_info);
+	pci_free_consistent(pdev, ring_header->size, ring_header->desc,
+			    ring_header->dma);
+
+	tpd_ring->buffer_info = NULL;
+	tpd_ring->desc = NULL;
+	tpd_ring->dma = 0;
+
+	rfd_ring->buffer_info = NULL;
+	rfd_ring->desc = NULL;
+	rfd_ring->dma = 0;
+
+	rrd_ring->desc = NULL;
+	rrd_ring->dma = 0;
+}
+
+s32 at_up(struct at_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	int err;
+
+	/* hardware has been reset, we need to reload some things */
+	at_set_multi(netdev);
+#ifdef NETIF_F_HW_VLAN_TX
+	at_restore_vlan(adapter);
+#endif
+	err = at_alloc_rx_buffers(adapter);
+	if (unlikely(0 == err))		/* no RX BUFFER allocated */
+		return -ENOMEM;
+
+	if (unlikely(at_configure(adapter))) {
+		err = -EIO;
+		goto err_up;
+	}
+
+	if (unlikely((err = request_irq(adapter->pdev->irq, &at_intr,
+			       IRQF_SHARED | IRQF_SAMPLE_RANDOM, netdev->name,
+			       netdev))))
+		goto err_up;
+
+	mod_timer(&adapter->watchdog_timer, jiffies);
+	at_irq_enable(adapter);
+	at_check_link(adapter);
+	return 0;
+
+	/* FIXME: unreachable code! -- CHS */
+	/* free irq disable any interrupt */
+	AT_WRITE_REG(&adapter->hw, REG_IMR, 0);
+	free_irq(adapter->pdev->irq, netdev);
+
+      err_up:
+	/* free rx_buffers */
+	at_clean_rx_ring(adapter);
+	return err;
+}
+
+void at_down(struct at_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+
+	del_timer_sync(&adapter->watchdog_timer);
+	del_timer_sync(&adapter->phy_config_timer);
+	adapter->phy_timer_pending = false;
+
+	at_irq_disable(adapter);
+	free_irq(adapter->pdev->irq, netdev);
+	at_reset_hw(&adapter->hw);
+	adapter->cmb.cmb->int_stats = 0;
+
+	adapter->link_speed = SPEED_0;
+	adapter->link_duplex = -1;
+	netif_carrier_off(netdev);
+	netif_stop_queue(netdev);
+
+	at_clean_tx_ring(adapter);
+	at_clean_rx_ring(adapter);
+}
+
+/**
+ * at_change_mtu - Change the Maximum Transfer Unit
+ * @netdev: network interface device structure
+ * @new_mtu: new value for maximum frame size
+ *
+ * Returns 0 on success, negative on failure
+ **/
+static int at_change_mtu(struct net_device *netdev, int new_mtu)
+{
+	struct at_adapter *adapter = netdev_priv(netdev);
+	int old_mtu = netdev->mtu;
+	int max_frame = new_mtu + ENET_HEADER_SIZE + ETHERNET_FCS_SIZE;
+
+	if ((max_frame < MINIMUM_ETHERNET_FRAME_SIZE) ||
+	    (max_frame > MAX_JUMBO_FRAME_SIZE)) {
+		printk(KERN_WARNING "%s: invalid MTU setting\n", at_driver_name);
+		return -EINVAL;
+	}
+
+	adapter->hw.max_frame_size = max_frame;
+	adapter->hw.tx_jumbo_task_th = (max_frame + 7) >> 3;
+	adapter->rx_buffer_len = (max_frame + 7) & ~7;
+	adapter->hw.rx_jumbo_th = adapter->rx_buffer_len / 8;
+
+	netdev->mtu = new_mtu;
+	if ((old_mtu != new_mtu) && netif_running(netdev)) {
+		at_down(adapter);
+		at_up(adapter);
+	}
+
+	return 0;
+}
+
+/**
+ * at_set_mac - Change the Ethernet Address of the NIC
+ * @netdev: network interface device structure
+ * @p: pointer to an address structure
+ *
+ * Returns 0 on success, negative on failure
+ **/
+static int at_set_mac(struct net_device *netdev, void *p)
+{
+	struct at_adapter *adapter = netdev_priv(netdev);
+	struct sockaddr *addr = p;
+
+	if (netif_running(netdev))
+		return -EBUSY;
+
+	if (!is_valid_ether_addr(addr->sa_data))
+		return -EADDRNOTAVAIL;
+
+	memcpy(netdev->dev_addr, addr->sa_data, netdev->addr_len);
+	memcpy(adapter->hw.mac_addr, addr->sa_data, netdev->addr_len);
+
+	set_mac_addr(&adapter->hw);
+	return 0;
+}
+
+/**
+ * at_watchdog - Timer Call-back
+ * @data: pointer to netdev cast into an unsigned long
+ **/
+static void at_watchdog(unsigned long data)
+{
+	struct at_adapter *adapter = (struct at_adapter *)data;
+
+	/* Reset the timer */
+	mod_timer(&adapter->watchdog_timer, jiffies + 2 * HZ);
+}
+
+#ifdef SIOCGMIIPHY
+/**
+ * at_mii_ioctl -
+ * @netdev:
+ * @ifreq:
+ * @cmd:
+ **/
+static int at_mii_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
+{
+	struct at_adapter *adapter = netdev_priv(netdev);
+/*	struct mii_ioctl_data *data = (struct mii_ioctl_data *)&ifr->ifr_data;*/
+	struct mii_ioctl_data *data = if_mii(ifr);
+	unsigned long flags;
+
+	switch (cmd) {
+	case SIOCGMIIPHY:
+		data->phy_id = 0;
+		break;
+	case SIOCGMIIREG:
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
+		spin_lock_irqsave(&adapter->stats_lock, flags);
+		if (at_read_phy_reg
+		    (&adapter->hw, data->reg_num & 0x1F, &data->val_out)) {
+			spin_unlock_irqrestore(&adapter->stats_lock, flags);
+			return -EIO;
+		}
+		spin_unlock_irqrestore(&adapter->stats_lock, flags);
+		break;
+	case SIOCSMIIREG:
+		if (!capable(CAP_NET_ADMIN))
+			return -EPERM;
+		if (data->reg_num & ~(0x1F))
+			return -EFAULT;
+		spin_lock_irqsave(&adapter->stats_lock, flags);
+		printk(KERN_DEBUG "%s: at_mii_ioctl write %x %x\n", 
+			at_driver_name, data->reg_num,
+			  data->val_in);
+		if (at_write_phy_reg(&adapter->hw, data->reg_num, data->val_in)) {
+			spin_unlock_irqrestore(&adapter->stats_lock, flags);
+			return -EIO;
+		}
+		spin_unlock_irqrestore(&adapter->stats_lock, flags);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	return AT_SUCCESS;
+}
+#endif				/* SIOCGMIIPHY */
+
+/**
+ * at_ioctl -
+ * @netdev:
+ * @ifreq:
+ * @cmd:
+ **/
+static int at_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
+{
+	switch (cmd) {
+#ifdef SIOCGMIIPHY
+	case SIOCGMIIPHY:
+	case SIOCGMIIREG:
+	case SIOCSMIIREG:
+		return at_mii_ioctl(netdev, ifr, cmd);
+#endif
+	case SIOCETHTOOL:
+		at_set_ethtool_ops(netdev);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+/**
+ * at_tx_timeout - Respond to a Tx Hang
+ * @netdev: network interface device structure
+ **/
+static void at_tx_timeout(struct net_device *netdev)
+{
+	struct at_adapter *adapter = netdev_priv(netdev);
+	/* Do the reset outside of interrupt context */
+	schedule_work(&adapter->tx_timeout_task);
+}
+
+/**
+ * at_phy_config - Timer Call-back
+ * @data: pointer to netdev cast into an unsigned long
+ **/
+static void at_phy_config(unsigned long data)
+{
+	struct at_adapter *adapter = (struct at_adapter *)data;
+	struct at_hw *hw = &adapter->hw;
+	unsigned long flags;
+
+	spin_lock_irqsave(&adapter->stats_lock, flags);
+	adapter->phy_timer_pending = false;
+	at_write_phy_reg(hw, MII_ADVERTISE, hw->mii_autoneg_adv_reg);
+	at_write_phy_reg(hw, MII_AT001_CR, hw->mii_1000t_ctrl_reg);
+	at_write_phy_reg(hw, MII_BMCR, MII_CR_RESET | MII_CR_AUTO_NEG_EN);
+	spin_unlock_irqrestore(&adapter->stats_lock, flags);
+}
+
+int at_reset(struct at_adapter *adapter)
+{
+	int ret;
+	if (AT_SUCCESS != (ret = at_reset_hw(&adapter->hw)))
+		return ret;
+	return at_init_hw(&adapter->hw);
+}
+
+/**
+ * at_open - Called when a network interface is made active
+ * @netdev: network interface device structure
+ *
+ * Returns 0 on success, negative value on failure
+ *
+ * The open entry point is called when a network interface is made
+ * active by the system (IFF_UP).  At this point all resources needed
+ * for transmit and receive operations are allocated, the interrupt
+ * handler is registered with the OS, the watchdog timer is started,
+ * and the stack is notified that the interface is ready.
+ **/
+static int at_open(struct net_device *netdev)
+{
+	struct at_adapter *adapter = netdev_priv(netdev);
+	int err;
+
+	/* allocate transmit descriptors */
+	if ((err = at_setup_ring_resources(adapter)))
+		return err;
+	if ((err = at_up(adapter)))
+		goto err_up;
+
+	return 0;
+
+      err_up:
+	at_reset(adapter);
+	return err;
+}
+
+/**
+ * at_close - Disables a network interface
+ * @netdev: network interface device structure
+ *
+ * Returns 0, this is not allowed to fail
+ *
+ * The close entry point is called when an interface is de-activated
+ * by the OS.  The hardware is still under the drivers control, but
+ * needs to be disabled.  A global MAC reset is issued to stop the
+ * hardware, and all transmit and receive resources are freed.
+ **/
+static int at_close(struct net_device *netdev)
+{
+	struct at_adapter *adapter = netdev_priv(netdev);
+	at_down(adapter);
+	at_free_ring_resources(adapter);
+	return 0;
+}
+
+/**
+ * If TPD Buffer size equal to 0, PCIE DMAR_TO_INT
+ * will assert. We do soft reset <0x1400=1> according 
+ * with the SPEC. BUT, it seemes that PCIE or DMA 
+ * state-machine will not be reset. DMAR_TO_INT will
+ * assert again and again.
+ */
+static void at_tx_timeout_task(struct net_device *netdev)
+{
+	struct at_adapter *adapter = netdev_priv(netdev);
+	netif_device_detach(netdev);
+	at_down(adapter);
+	at_up(adapter);
+	netif_device_attach(netdev);
+}
+
+/**
+ * at_link_chg_task - deal with link change event Out of interrupt context
+ * @netdev: network interface device structure
+ **/
+static void at_link_chg_task(struct net_device *netdev)
+{
+	struct at_adapter *adapter = netdev_priv(netdev);
+	unsigned long flags;
+	spin_lock_irqsave(&adapter->stats_lock, flags);
+	at_check_link(adapter);
+	spin_unlock_irqrestore(&adapter->stats_lock, flags);
+}
+
+/**
+ * at_pcie_patch - Patch for PCIE module
+ **/
+static void at_pcie_patch(struct at_adapter *adapter)
+{
+	u32 value;
+	value = 0x6500;
+	AT_WRITE_REG(&adapter->hw, 0x12FC, value);
+	/* pcie flow control mode change */
+	value = AT_READ_REG(&adapter->hw, 0x1008);
+	value |= 0x8000;
+	AT_WRITE_REG(&adapter->hw, 0x1008, value);
+}
+
+/**
+ * When ACPI resume on some VIA MotherBoard, the Interrupt Disable bit/0x400
+ * on PCI Command register is disable.
+ * The function enable this bit.
+ * Brackett, 2006/03/15
+ */
+static void at_via_workaround(struct at_adapter *adapter)
+{
+	unsigned long value;
+	value = AT_READ_REGW(&adapter->hw, PCI_COMMAND);
+	if (value & PCI_COMMAND_INTX_DISABLE) {
+		value &= ~PCI_COMMAND_INTX_DISABLE;
+	}
+
+	AT_WRITE_REG(&adapter->hw, PCI_COMMAND, value);
+}
+
+/**
+ * at_probe - Device Initialization Routine
+ * @pdev: PCI device information struct
+ * @ent: entry in at_pci_tbl
+ *
+ * Returns 0 on success, negative on failure
+ *
+ * at_probe initializes an adapter identified by a pci_dev structure.
+ * The OS initialization, configuring of the adapter private structure,
+ * and a hardware reset occur.
+ **/
+static int __devinit at_probe(struct pci_dev *pdev,
+			      const struct pci_device_id *ent)
+{
+	struct net_device *netdev;
+	struct at_adapter *adapter;
+	static int cards_found = 0;
+	unsigned long mmio_start;
+	int mmio_len;
+	bool pci_using_64 = true;
+	int err;
+	/* u16 eeprom_data; */
+
+	if ((err = pci_enable_device(pdev)))
+		return err;
+	if ((err = pci_set_dma_mask(pdev, DMA_64BIT_MASK))) {
+		if ((err = pci_set_dma_mask(pdev, DMA_32BIT_MASK))) {
+			printk(KERN_DEBUG 
+				"%s: no usable DMA configuration, aborting\n",
+ 				at_driver_name);
+			return err;
+		}
+		pci_using_64 = false;
+	}
+	/* Mark all PCI regions associated with PCI device 
+	 * pdev as being reserved by owner at_driver_name */
+	if ((err = pci_request_regions(pdev, at_driver_name)))
+		return err;
+	/* Enables bus-mastering on the device and calls 
+	 * pcibios_set_master to do the needed arch specific settings */
+	pci_set_master(pdev);
+
+	netdev = alloc_etherdev(sizeof(struct at_adapter));
+	if (!netdev) {
+		err = -ENOMEM;
+		goto err_alloc_etherdev;
+	}
+	SET_MODULE_OWNER(netdev);
+	SET_NETDEV_DEV(netdev, &pdev->dev);
+
+	pci_set_drvdata(pdev, netdev);
+	adapter = netdev_priv(netdev);
+	adapter->netdev = netdev;
+	adapter->pdev = pdev;
+	adapter->hw.back = adapter;
+
+	mmio_start = pci_resource_start(pdev, BAR_0);
+	mmio_len = pci_resource_len(pdev, BAR_0);
+
+	adapter->hw.mem_rang = (u32) mmio_len;
+	adapter->hw.hw_addr = ioremap_nocache(mmio_start, mmio_len);
+	if (!adapter->hw.hw_addr) {
+		err = -EIO;
+		goto err_ioremap;
+	}
+	/* get device revision number */
+	adapter->hw.dev_rev = AT_READ_REGW(&adapter->hw, (REG_MASTER_CTRL + 2));
+
+	/* set default ring resource counts */
+	adapter->rfd_ring.count = adapter->rrd_ring.count = AT_DEFAULT_RFD;
+	adapter->tpd_ring.count = AT_DEFAULT_TPD;
+
+	netdev->open = &at_open;
+	netdev->stop = &at_close;
+	netdev->hard_start_xmit = &at_xmit_frame;
+	netdev->get_stats = &at_get_stats;
+	netdev->set_multicast_list = &at_set_multi;
+	netdev->set_mac_address = &at_set_mac;
+	netdev->change_mtu = &at_change_mtu;
+	netdev->do_ioctl = &at_ioctl;
+#ifdef HAVE_TX_TIMEOUT
+	netdev->tx_timeout = &at_tx_timeout;
+	netdev->watchdog_timeo = 5 * HZ;
+#endif
+#ifdef NETIF_F_HW_VLAN_TX
+	netdev->vlan_rx_register = at_vlan_rx_register;
+	netdev->vlan_rx_add_vid = at_vlan_rx_add_vid;
+	netdev->vlan_rx_kill_vid = at_vlan_rx_kill_vid;
+#endif
+	netdev->mem_start = mmio_start;
+	netdev->mem_end = mmio_start + mmio_len;
+	/* netdev->base_addr = adapter->io_base; */
+	adapter->bd_number = cards_found;
+	adapter->pci_using_64 = pci_using_64;
+
+	/* setup the private structure */
+	if ((err = at_sw_init(adapter)))
+		goto err_sw_init;
+	netdev->features = NETIF_F_HW_CSUM;
+
+#ifdef MAX_SKB_FRAGS
+	netdev->features |= NETIF_F_SG;
+#endif
+
+#ifdef NETIF_F_HW_VLAN_TX
+	netdev->features |= (NETIF_F_HW_VLAN_TX | NETIF_F_HW_VLAN_RX);
+#endif
+
+#ifdef NETIF_F_TSO
+	netdev->features |= NETIF_F_TSO;
+#endif				/*NETIF_F_TSO */
+
+	if (pci_using_64) {
+		netdev->features |= NETIF_F_HIGHDMA;
+	}
+#ifdef NETIF_F_LLTX
+	netdev->features |= NETIF_F_LLTX;
+#endif
+	/* patch for some L1 of old version,
+	 * the final version of L1 may not need these
+	 * patches */
+	/* at_pcie_patch(adapter); */
+
+	/* really reset GPHY core */
+	AT_WRITE_REGW(&adapter->hw, REG_GPHY_ENABLE, 0);
+
+	/* reset the controller to
+	 * put the device in a known good starting state */
+	if (at_reset_hw(&adapter->hw)) {
+		err = -EIO;
+		goto err_reset;
+	}
+
+	/* copy the MAC address out of the EEPROM */
+	at_read_mac_addr(&adapter->hw);
+	memcpy(netdev->dev_addr, adapter->hw.mac_addr, netdev->addr_len);
+
+	if (!is_valid_ether_addr(netdev->dev_addr)) {
+		err = -EIO;
+		goto err_eeprom;
+	}
+
+	at_check_options(adapter);
+
+	/* pre-init the MAC, and setup link */
+	if ((err = at_init_hw(&adapter->hw))) {
+		err = -EIO;
+		goto err_init_hw;
+	}
+
+	at_pcie_patch(adapter);
+	/* assume we have no link for now */
+	netif_carrier_off(netdev);
+	netif_stop_queue(netdev);
+
+	init_timer(&adapter->watchdog_timer);
+	adapter->watchdog_timer.function = &at_watchdog;
+	adapter->watchdog_timer.data = (unsigned long)adapter;
+
+	init_timer(&adapter->phy_config_timer);
+	adapter->phy_config_timer.function = &at_phy_config;
+	adapter->phy_config_timer.data = (unsigned long)adapter;
+	adapter->phy_timer_pending = false;
+
+	INIT_WORK(&adapter->tx_timeout_task,
+		  (void (*)(void *))at_tx_timeout_task, netdev);
+
+	INIT_WORK(&adapter->link_chg_task, (void (*)(void *))at_link_chg_task,
+		  netdev);
+
+	INIT_WORK(&adapter->pcie_dma_to_rst_task,
+		  (void (*)(void *))at_tx_timeout_task, netdev);
+
+	if ((err = register_netdev(netdev)))
+		goto err_register;
+
+	cards_found++;
+	at_via_workaround(adapter);
+	return 0;
+
+      err_init_hw:
+      err_reset:
+      err_register:
+      err_sw_init:
+      err_eeprom:
+	iounmap(adapter->hw.hw_addr);
+      err_ioremap:
+	free_netdev(netdev);
+      err_alloc_etherdev:
+	pci_release_regions(pdev);
+	return err;
+}
+
+/**
+ * at_remove - Device Removal Routine
+ * @pdev: PCI device information struct
+ *
+ * at_remove is called by the PCI subsystem to alert the driver
+ * that it should release a PCI device.  The could be caused by a
+ * Hot-Plug event, or because the driver is going to be removed from
+ * memory.
+ **/
+static void __devexit at_remove(struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct at_adapter *adapter;
+	/* Device not available. Return. */
+	if (!netdev)
+		return;
+
+	adapter = netdev_priv(netdev);
+	AT_WRITE_REGW(&adapter->hw, REG_GPHY_ENABLE, 0);
+	unregister_netdev(netdev);
+	iounmap(adapter->hw.hw_addr);
+	pci_release_regions(pdev);
+	free_netdev(netdev);
+}
+
+static int at_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct at_adapter *adapter = netdev_priv(netdev);
+	struct at_hw *hw = &adapter->hw;
+	u32 ctrl = 0;
+	u32 wufc = adapter->wol;
+
+	netif_device_detach(netdev);
+	if (netif_running(netdev))
+		at_down(adapter);
+
+	at_read_phy_reg(hw, MII_BMSR, (u16 *) & ctrl);
+	at_read_phy_reg(hw, MII_BMSR, (u16 *) & ctrl);
+	if (ctrl & BMSR_LSTATUS)
+		wufc &= ~AT_WUFC_LNKC;
+
+	/* reduce speed to 10/100M */
+	if (wufc) {
+		at_phy_enter_power_saving(hw);
+		/* if resume, let driver to re- setup link */
+		hw->phy_configured = false;
+		set_mac_addr(hw);
+		at_set_multi(netdev);
+
+		ctrl = 0;
+		/* turn on magic packet wol */
+		if (wufc & AT_WUFC_MAG) {
+			ctrl = WOL_MAGIC_EN | WOL_MAGIC_PME_EN;
+		}
+		/* turn on Link change WOL */
+		if (wufc & AT_WUFC_LNKC) {
+			ctrl |= (WOL_LINK_CHG_EN | WOL_LINK_CHG_PME_EN);
+		}
+		AT_WRITE_REG(hw, REG_WOL_CTRL, ctrl);
+
+		/* turn on all-multi mode if wake on multicast is enabled */
+		ctrl = AT_READ_REG(hw, REG_MAC_CTRL);
+		ctrl &= ~MAC_CTRL_DBG;
+		ctrl &= ~MAC_CTRL_PROMIS_EN;
+		if (wufc & AT_WUFC_MC) {
+			ctrl |= MAC_CTRL_MC_ALL_EN;
+		} else {
+			ctrl &= ~MAC_CTRL_MC_ALL_EN;
+		}
+		/* turn on broadcast mode if wake on-BC is enabled */
+		if (wufc & AT_WUFC_BC) {
+			ctrl |= MAC_CTRL_BC_EN;
+		} else {
+			ctrl &= ~MAC_CTRL_BC_EN;
+		}
+		/* enable RX */
+		ctrl |= MAC_CTRL_RX_EN;
+		AT_WRITE_REG(hw, REG_MAC_CTRL, ctrl);
+		pci_enable_wake(pdev, PCI_D3hot, 1);
+		pci_enable_wake(pdev, PCI_D3cold, 1);	/* 4 == D3 cold */
+	} else {
+		AT_WRITE_REG(hw, REG_WOL_CTRL, 0);
+		pci_enable_wake(pdev, PCI_D3hot, 0);
+		pci_enable_wake(pdev, PCI_D3cold, 0);	/* 4 == D3 cold */
+	}
+
+	pci_save_state(pdev);
+	pci_disable_device(pdev);
+
+	pci_set_power_state(pdev, PCI_D3hot);
+
+	return 0;
+}
+
+static int at_resume(struct pci_dev *pdev)
+{
+	struct net_device *netdev = pci_get_drvdata(pdev);
+	struct at_adapter *adapter = netdev_priv(netdev);
+	u32 ret_val;
+
+	pci_set_power_state(pdev, 0);
+	pci_restore_state(pdev);
+
+	ret_val = pci_enable_device(pdev);
+	pci_enable_wake(pdev, PCI_D3hot, 0);
+	pci_enable_wake(pdev, PCI_D3cold, 0);
+
+	AT_WRITE_REG(&adapter->hw, REG_WOL_CTRL, 0);
+	at_reset(adapter);
+
+	if (netif_running(netdev))
+		at_up(adapter);
+	netif_device_attach(netdev);
+
+	at_via_workaround(adapter);
+
+	return 0;
+}
+
+static struct pci_driver at_driver = {
+	.name = at_driver_name,
+	.id_table = at_pci_tbl,
+	.probe = at_probe,
+	.remove = __devexit_p(at_remove),
+	/* Power Managment Hooks */
+	/* probably broken right now -- CHS */
+#ifdef CONFIG_PM
+	.suspend = at_suspend,
+	.resume = at_resume
+#endif
+};
+
+/**
+ * at_exit_module - Driver Exit Cleanup Routine
+ *
+ * at_exit_module is called just before the driver is removed
+ * from memory.
+ **/
+static void __exit at_exit_module(void)
+{
+	pci_unregister_driver(&at_driver);
+}
+
+/**
+ * at_init_module - Driver Registration Routine
+ *
+ * at_init_module is the first routine called when the driver is
+ * loaded. All it does is register with the PCI subsystem.
+ **/
+static int __init at_init_module(void)
+{
+	int ret;
+	printk(KERN_INFO "%s - version %s\n", at_driver_string, DRV_VERSION);
+	printk(KERN_INFO "%s\n", at_copyright);
+	ret = pci_module_init(&at_driver);
+
+	return ret;
+}
+
+module_init(at_init_module);
+module_exit(at_exit_module);
