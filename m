Return-Path: <linux-kernel-owner+w=401wt.eu-S932790AbWLZVWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932790AbWLZVWn (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 16:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932791AbWLZVWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 16:22:43 -0500
Received: from havoc.gtf.org ([69.61.125.42]:56630 "EHLO havoc.gtf.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932790AbWLZVWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 16:22:42 -0500
Date: Tue, 26 Dec 2006 16:22:40 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [git patch] Remove NetXen private ioctl
Message-ID: <20061226212240.GA2053@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


IMO this should not make it out into general release, and most kernel
hackers seemed to agree.

Please pull from 'netxen-ioctl' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git netxen-ioctl

to receive the following updates:

 drivers/net/netxen/netxen_nic.h         |   11 --
 drivers/net/netxen/netxen_nic_ethtool.c |    5 +-
 drivers/net/netxen/netxen_nic_hw.c      |  294 -------------------------------
 drivers/net/netxen/netxen_nic_init.c    |  237 -------------------------
 drivers/net/netxen/netxen_nic_ioctl.h   |   77 --------
 drivers/net/netxen/netxen_nic_main.c    |   45 -----
 6 files changed, 1 insertions(+), 668 deletions(-)
 delete mode 100644 drivers/net/netxen/netxen_nic_ioctl.h

Stephen Hemminger (1):
    netxen: remove private ioctl
    
    The netxen driver includes a private ioctl that provides access
    to functionality that is already available in other ways. The PCI
    layer has application access hooks (see setpci), and the statistics
    are available in ethtool/netstats.
    
    Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
    Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/drivers/net/netxen/netxen_nic.h b/drivers/net/netxen/netxen_nic.h
index b5410be..b4c4fc0 100644
--- a/drivers/net/netxen/netxen_nic.h
+++ b/drivers/net/netxen/netxen_nic.h
@@ -1027,14 +1027,6 @@ int netxen_nic_hw_read_wx(struct netxen_adapter *adapter, u64 off, void *data,
 			  int len);
 int netxen_nic_hw_write_wx(struct netxen_adapter *adapter, u64 off, void *data,
 			   int len);
-int netxen_nic_hw_read_ioctl(struct netxen_adapter *adapter, u64 off,
-			     void *data, int len);
-int netxen_nic_hw_write_ioctl(struct netxen_adapter *adapter, u64 off,
-			      void *data, int len);
-int netxen_nic_pci_mem_write_ioctl(struct netxen_adapter *adapter,
-				   u64 off, void *data, int size);
-int netxen_nic_pci_mem_read_ioctl(struct netxen_adapter *adapter,
-				  u64 off, void *data, int size);
 void netxen_crb_writelit_adapter(struct netxen_adapter *adapter,
 				 unsigned long off, int data);
 
@@ -1067,9 +1059,6 @@ void netxen_tso_check(struct netxen_adapter *adapter,
 		      struct cmd_desc_type0 *desc, struct sk_buff *skb);
 int netxen_nic_hw_resources(struct netxen_adapter *adapter);
 void netxen_nic_clear_stats(struct netxen_adapter *adapter);
-int
-netxen_nic_do_ioctl(struct netxen_adapter *adapter, void *u_data,
-		    struct netxen_port *port);
 int netxen_nic_rx_has_work(struct netxen_adapter *adapter);
 int netxen_nic_tx_has_work(struct netxen_adapter *adapter);
 void netxen_watchdog_task(struct work_struct *work);
diff --git a/drivers/net/netxen/netxen_nic_ethtool.c b/drivers/net/netxen/netxen_nic_ethtool.c
index 2ab4885..3404461 100644
--- a/drivers/net/netxen/netxen_nic_ethtool.c
+++ b/drivers/net/netxen/netxen_nic_ethtool.c
@@ -42,7 +42,6 @@
 #include "netxen_nic_hw.h"
 #include "netxen_nic.h"
 #include "netxen_nic_phan_reg.h"
-#include "netxen_nic_ioctl.h"
 
 struct netxen_nic_stats {
 	char stat_string[ETH_GSTRING_LEN];
@@ -79,8 +78,7 @@ static const struct netxen_nic_stats netxen_nic_gstrings_stats[] = {
 	{"tx_bytes", NETXEN_NIC_STAT(stats.txbytes)},
 };
 
-#define NETXEN_NIC_STATS_LEN	\
-	sizeof(netxen_nic_gstrings_stats) / sizeof(struct netxen_nic_stats)
+#define NETXEN_NIC_STATS_LEN	ARRAY_SIZE(netxen_nic_gstrings_stats)
 
 static const char netxen_nic_gstrings_test[][ETH_GSTRING_LEN] = {
 	"Register_Test_offline", "EEPROM_Test_offline",
@@ -711,7 +709,6 @@ netxen_nic_get_ethtool_stats(struct net_device *dev,
 		    (netxen_nic_gstrings_stats[index].sizeof_stat ==
 		     sizeof(u64)) ? *(u64 *) p : *(u32 *) p;
 	}
-
 }
 
 struct ethtool_ops netxen_nic_ethtool_ops = {
diff --git a/drivers/net/netxen/netxen_nic_hw.c b/drivers/net/netxen/netxen_nic_hw.c
index 9147b60..5dac50c 100644
--- a/drivers/net/netxen/netxen_nic_hw.c
+++ b/drivers/net/netxen/netxen_nic_hw.c
@@ -997,297 +997,3 @@ void netxen_nic_flash_print(struct netxen_adapter *adapter)
 		       fw_major, fw_minor);
 }
 
-int netxen_crb_read_val(struct netxen_adapter *adapter, unsigned long off)
-{
-	int data;
-	netxen_nic_hw_read_wx(adapter, off, &data, 4);
-	return data;
-}
-
-int netxen_nic_hw_write_ioctl(struct netxen_adapter *adapter, u64 off,
-			      void *data, int len)
-{
-	void *addr;
-	u64 offset = off;
-	u8 *mem_ptr = NULL;
-	unsigned long mem_base;
-	unsigned long mem_page;
-
-	if (ADDR_IN_WINDOW1(off)) {
-		addr = NETXEN_CRB_NORMALIZE(adapter, off);
-		if (!addr) {
-			mem_base = pci_resource_start(adapter->ahw.pdev, 0);
-			offset = NETXEN_CRB_NORMAL(off);
-			mem_page = offset & PAGE_MASK;
-			if (mem_page != ((offset + len - 1) & PAGE_MASK))
-				mem_ptr =
-				    ioremap(mem_base + mem_page, PAGE_SIZE * 2);
-			else
-				mem_ptr =
-				    ioremap(mem_base + mem_page, PAGE_SIZE);
-			if (mem_ptr == 0UL) {
-				return 1;
-			}
-			addr = mem_ptr;
-			addr += offset & (PAGE_SIZE - 1);
-		}
-	} else {
-		addr = pci_base_offset(adapter, off);
-		if (!addr) {
-			mem_base = pci_resource_start(adapter->ahw.pdev, 0);
-			mem_page = off & PAGE_MASK;
-			if (mem_page != ((off + len - 1) & PAGE_MASK))
-				mem_ptr =
-				    ioremap(mem_base + mem_page, PAGE_SIZE * 2);
-			else
-				mem_ptr =
-				    ioremap(mem_base + mem_page, PAGE_SIZE);
-			if (mem_ptr == 0UL) {
-				return 1;
-			}
-			addr = mem_ptr;
-			addr += off & (PAGE_SIZE - 1);
-		}
-		netxen_nic_pci_change_crbwindow(adapter, 0);
-	}
-	switch (len) {
-	case 1:
-		writeb(*(u8 *) data, addr);
-		break;
-	case 2:
-		writew(*(u16 *) data, addr);
-		break;
-	case 4:
-		writel(*(u32 *) data, addr);
-		break;
-	case 8:
-		writeq(*(u64 *) data, addr);
-		break;
-	default:
-		DPRINTK(INFO,
-			"writing data %lx to offset %llx, num words=%d\n",
-			*(unsigned long *)data, off, (len >> 3));
-
-		netxen_nic_hw_block_write64((u64 __iomem *) data, addr,
-					    (len >> 3));
-		break;
-	}
-
-	if (!ADDR_IN_WINDOW1(off))
-		netxen_nic_pci_change_crbwindow(adapter, 1);
-	if (mem_ptr)
-		iounmap(mem_ptr);
-	return 0;
-}
-
-int netxen_nic_hw_read_ioctl(struct netxen_adapter *adapter, u64 off,
-			     void *data, int len)
-{
-	void *addr;
-	u64 offset;
-	u8 *mem_ptr = NULL;
-	unsigned long mem_base;
-	unsigned long mem_page;
-
-	if (ADDR_IN_WINDOW1(off)) {
-		addr = NETXEN_CRB_NORMALIZE(adapter, off);
-		if (!addr) {
-			mem_base = pci_resource_start(adapter->ahw.pdev, 0);
-			offset = NETXEN_CRB_NORMAL(off);
-			mem_page = offset & PAGE_MASK;
-			if (mem_page != ((offset + len - 1) & PAGE_MASK))
-				mem_ptr =
-				    ioremap(mem_base + mem_page, PAGE_SIZE * 2);
-			else
-				mem_ptr =
-				    ioremap(mem_base + mem_page, PAGE_SIZE);
-			if (mem_ptr == 0UL) {
-				*(u8 *) data = 0;
-				return 1;
-			}
-			addr = mem_ptr;
-			addr += offset & (PAGE_SIZE - 1);
-		}
-	} else {
-		addr = pci_base_offset(adapter, off);
-		if (!addr) {
-			mem_base = pci_resource_start(adapter->ahw.pdev, 0);
-			mem_page = off & PAGE_MASK;
-			if (mem_page != ((off + len - 1) & PAGE_MASK))
-				mem_ptr =
-				    ioremap(mem_base + mem_page, PAGE_SIZE * 2);
-			else
-				mem_ptr =
-				    ioremap(mem_base + mem_page, PAGE_SIZE);
-			if (mem_ptr == 0UL)
-				return 1;
-			addr = mem_ptr;
-			addr += off & (PAGE_SIZE - 1);
-		}
-		netxen_nic_pci_change_crbwindow(adapter, 0);
-	}
-	switch (len) {
-	case 1:
-		*(u8 *) data = readb(addr);
-		break;
-	case 2:
-		*(u16 *) data = readw(addr);
-		break;
-	case 4:
-		*(u32 *) data = readl(addr);
-		break;
-	case 8:
-		*(u64 *) data = readq(addr);
-		break;
-	default:
-		netxen_nic_hw_block_read64((u64 __iomem *) data, addr,
-					   (len >> 3));
-		break;
-	}
-	if (!ADDR_IN_WINDOW1(off))
-		netxen_nic_pci_change_crbwindow(adapter, 1);
-	if (mem_ptr)
-		iounmap(mem_ptr);
-	return 0;
-}
-
-int netxen_nic_pci_mem_write_ioctl(struct netxen_adapter *adapter, u64 off,
-				   void *data, int size)
-{
-	void *addr;
-	int ret = 0;
-	u8 *mem_ptr = NULL;
-	unsigned long mem_base;
-	unsigned long mem_page;
-
-	if (data == NULL || off > (128 * 1024 * 1024)) {
-		printk(KERN_ERR "%s: data: %p off:%llx\n",
-		       netxen_nic_driver_name, data, off);
-		return 1;
-	}
-	off = netxen_nic_pci_set_window(adapter, off);
-	/* Corner case : Malicious user tried to break the driver by reading
-	   last few bytes in ranges and tries to read further addresses.
-	 */
-	if (!pci_base(adapter, off + size - 1) && pci_base(adapter, off)) {
-		printk(KERN_ERR "%s: Invalid access to memory address range"
-		       " 0x%llx - 0x%llx\n", netxen_nic_driver_name, off,
-		       off + size);
-		return 1;
-	}
-	addr = pci_base_offset(adapter, off);
-	DPRINTK(INFO, "writing data %llx to offset %llx\n",
-		*(unsigned long long *)data, off);
-	if (!addr) {
-		mem_base = pci_resource_start(adapter->ahw.pdev, 0);
-		mem_page = off & PAGE_MASK;
-		/* Map two pages whenever user tries to access addresses in two
-		   consecutive pages.
-		 */
-		if (mem_page != ((off + size - 1) & PAGE_MASK))
-			mem_ptr = ioremap(mem_base + mem_page, PAGE_SIZE * 2);
-		else
-			mem_ptr = ioremap(mem_base + mem_page, PAGE_SIZE);
-		if (mem_ptr == 0UL) {
-			return 1;
-		}
-		addr = mem_ptr;
-		addr += off & (PAGE_SIZE - 1);
-	}
-	switch (size) {
-	case 1:
-		writeb(*(u8 *) data, addr);
-		break;
-	case 2:
-		writew(*(u16 *) data, addr);
-		break;
-	case 4:
-		writel(*(u32 *) data, addr);
-		break;
-	case 8:
-		writeq(*(u64 *) data, addr);
-		break;
-	default:
-		DPRINTK(INFO,
-			"writing data %lx to offset %llx, num words=%d\n",
-			*(unsigned long *)data, off, (size >> 3));
-
-		netxen_nic_hw_block_write64((u64 __iomem *) data, addr,
-					    (size >> 3));
-		break;
-	}
-
-	if (mem_ptr)
-		iounmap(mem_ptr);
-	DPRINTK(INFO, "wrote %llx\n", *(unsigned long long *)data);
-
-	return ret;
-}
-
-int netxen_nic_pci_mem_read_ioctl(struct netxen_adapter *adapter,
-				  u64 off, void *data, int size)
-{
-	void *addr;
-	int ret = 0;
-	u8 *mem_ptr = NULL;
-	unsigned long mem_base;
-	unsigned long mem_page;
-
-	if (data == NULL || off > (128 * 1024 * 1024)) {
-		printk(KERN_ERR "%s: data: %p off:%llx\n",
-		       netxen_nic_driver_name, data, off);
-		return 1;
-	}
-	off = netxen_nic_pci_set_window(adapter, off);
-	/* Corner case : Malicious user tried to break the driver by reading
-	   last few bytes in ranges and tries to read further addresses.
-	 */
-	if (!pci_base(adapter, off + size - 1) && pci_base(adapter, off)) {
-		printk(KERN_ERR "%s: Invalid access to memory address range"
-		       " 0x%llx - 0x%llx\n", netxen_nic_driver_name, off,
-		       off + size);
-		return 1;
-	}
-	addr = pci_base_offset(adapter, off);
-	if (!addr) {
-		mem_base = pci_resource_start(adapter->ahw.pdev, 0);
-		mem_page = off & PAGE_MASK;
-		/* Map two pages whenever user tries to access addresses in two
-		   consecutive pages.
-		 */
-		if (mem_page != ((off + size - 1) & PAGE_MASK))
-			mem_ptr = ioremap(mem_base + mem_page, PAGE_SIZE * 2);
-		else
-			mem_ptr = ioremap(mem_base + mem_page, PAGE_SIZE);
-		if (mem_ptr == 0UL) {
-			*(u8 *) data = 0;
-			return 1;
-		}
-		addr = mem_ptr;
-		addr += off & (PAGE_SIZE - 1);
-	}
-	switch (size) {
-	case 1:
-		*(u8 *) data = readb(addr);
-		break;
-	case 2:
-		*(u16 *) data = readw(addr);
-		break;
-	case 4:
-		*(u32 *) data = readl(addr);
-		break;
-	case 8:
-		*(u64 *) data = readq(addr);
-		break;
-	default:
-		netxen_nic_hw_block_read64((u64 __iomem *) data, addr,
-					   (size >> 3));
-		break;
-	}
-
-	if (mem_ptr)
-		iounmap(mem_ptr);
-	DPRINTK(INFO, "read %llx\n", *(unsigned long long *)data);
-
-	return ret;
-}
diff --git a/drivers/net/netxen/netxen_nic_init.c b/drivers/net/netxen/netxen_nic_init.c
index 869725f..deacc61 100644
--- a/drivers/net/netxen/netxen_nic_init.c
+++ b/drivers/net/netxen/netxen_nic_init.c
@@ -35,7 +35,6 @@
 #include <linux/delay.h>
 #include "netxen_nic.h"
 #include "netxen_nic_hw.h"
-#include "netxen_nic_ioctl.h"
 #include "netxen_nic_phan_reg.h"
 
 struct crb_addr_pair {
@@ -1273,52 +1272,6 @@ int netxen_nic_tx_has_work(struct netxen_adapter *adapter)
 	return 0;
 }
 
-int
-netxen_nic_fill_statistics(struct netxen_adapter *adapter,
-			   struct netxen_port *port,
-			   struct netxen_statistics *netxen_stats)
-{
-	void __iomem *addr;
-
-	if (adapter->ahw.board_type == NETXEN_NIC_XGBE) {
-		netxen_nic_pci_change_crbwindow(adapter, 0);
-		NETXEN_NIC_LOCKED_READ_REG(NETXEN_NIU_XGE_TX_BYTE_CNT,
-					   &(netxen_stats->tx_bytes));
-		NETXEN_NIC_LOCKED_READ_REG(NETXEN_NIU_XGE_TX_FRAME_CNT,
-					   &(netxen_stats->tx_packets));
-		NETXEN_NIC_LOCKED_READ_REG(NETXEN_NIU_XGE_RX_BYTE_CNT,
-					   &(netxen_stats->rx_bytes));
-		NETXEN_NIC_LOCKED_READ_REG(NETXEN_NIU_XGE_RX_FRAME_CNT,
-					   &(netxen_stats->rx_packets));
-		NETXEN_NIC_LOCKED_READ_REG(NETXEN_NIU_XGE_AGGR_ERROR_CNT,
-					   &(netxen_stats->rx_errors));
-		NETXEN_NIC_LOCKED_READ_REG(NETXEN_NIU_XGE_CRC_ERROR_CNT,
-					   &(netxen_stats->rx_crc_errors));
-		NETXEN_NIC_LOCKED_READ_REG(NETXEN_NIU_XGE_OVERSIZE_FRAME_ERR,
-					   &(netxen_stats->
-					     rx_long_length_error));
-		NETXEN_NIC_LOCKED_READ_REG(NETXEN_NIU_XGE_UNDERSIZE_FRAME_ERR,
-					   &(netxen_stats->
-					     rx_short_length_error));
-
-		netxen_nic_pci_change_crbwindow(adapter, 1);
-	} else {
-		spin_lock_bh(&adapter->tx_lock);
-		netxen_stats->tx_bytes = port->stats.txbytes;
-		netxen_stats->tx_packets = port->stats.xmitedframes +
-		    port->stats.xmitfinished;
-		netxen_stats->rx_bytes = port->stats.rxbytes;
-		netxen_stats->rx_packets = port->stats.no_rcv;
-		netxen_stats->rx_errors = port->stats.rcvdbadskb;
-		netxen_stats->tx_errors = port->stats.nocmddescriptor;
-		netxen_stats->rx_short_length_error = port->stats.uplcong;
-		netxen_stats->rx_long_length_error = port->stats.uphcong;
-		netxen_stats->rx_crc_errors = 0;
-		netxen_stats->rx_mac_errors = 0;
-		spin_unlock_bh(&adapter->tx_lock);
-	}
-	return 0;
-}
 
 void netxen_nic_clear_stats(struct netxen_adapter *adapter)
 {
@@ -1332,193 +1285,3 @@ void netxen_nic_clear_stats(struct netxen_adapter *adapter)
 	}
 }
 
-int
-netxen_nic_clear_statistics(struct netxen_adapter *adapter,
-			    struct netxen_port *port)
-{
-	int data = 0;
-
-	netxen_nic_pci_change_crbwindow(adapter, 0);
-
-	netxen_nic_locked_write_reg(adapter, NETXEN_NIU_XGE_TX_BYTE_CNT, &data);
-	netxen_nic_locked_write_reg(adapter, NETXEN_NIU_XGE_TX_FRAME_CNT,
-				    &data);
-	netxen_nic_locked_write_reg(adapter, NETXEN_NIU_XGE_RX_BYTE_CNT, &data);
-	netxen_nic_locked_write_reg(adapter, NETXEN_NIU_XGE_RX_FRAME_CNT,
-				    &data);
-	netxen_nic_locked_write_reg(adapter, NETXEN_NIU_XGE_AGGR_ERROR_CNT,
-				    &data);
-	netxen_nic_locked_write_reg(adapter, NETXEN_NIU_XGE_CRC_ERROR_CNT,
-				    &data);
-	netxen_nic_locked_write_reg(adapter, NETXEN_NIU_XGE_OVERSIZE_FRAME_ERR,
-				    &data);
-	netxen_nic_locked_write_reg(adapter, NETXEN_NIU_XGE_UNDERSIZE_FRAME_ERR,
-				    &data);
-
-	netxen_nic_pci_change_crbwindow(adapter, 1);
-	netxen_nic_clear_stats(adapter);
-	return 0;
-}
-
-int
-netxen_nic_do_ioctl(struct netxen_adapter *adapter, void *u_data,
-		    struct netxen_port *port)
-{
-	struct netxen_nic_ioctl_data data;
-	struct netxen_nic_ioctl_data *up_data;
-	int retval = 0;
-	struct netxen_statistics netxen_stats;
-
-	up_data = (void *)u_data;
-
-	DPRINTK(INFO, "doing ioctl for %p\n", adapter);
-	if (copy_from_user(&data, (void __user *)up_data, sizeof(data))) {
-		/* evil user tried to crash the kernel */
-		DPRINTK(ERR, "bad copy from userland: %d\n", (int)sizeof(data));
-		retval = -EFAULT;
-		goto error_out;
-	}
-
-	/* Shouldn't access beyond legal limits of  "char u[64];" member */
-	if (!data.ptr && (data.size > sizeof(data.u))) {
-		/* evil user tried to crash the kernel */
-		DPRINTK(ERR, "bad size: %d\n", data.size);
-		retval = -EFAULT;
-		goto error_out;
-	}
-
-	switch (data.cmd) {
-	case netxen_nic_cmd_pci_read:
-		if ((retval = netxen_nic_hw_read_ioctl(adapter, data.off,
-						       &(data.u), data.size)))
-			goto error_out;
-		if (copy_to_user
-		    ((void __user *)&(up_data->u), &(data.u), data.size)) {
-			DPRINTK(ERR, "bad copy to userland: %d\n",
-				(int)sizeof(data));
-			retval = -EFAULT;
-			goto error_out;
-		}
-		data.rv = 0;
-		break;
-
-	case netxen_nic_cmd_pci_write:
-		if ((retval = netxen_nic_hw_write_ioctl(adapter, data.off,
-							&(data.u), data.size)))
-			goto error_out;
-		data.rv = 0;
-		break;
-
-	case netxen_nic_cmd_pci_mem_read:
-		if (netxen_nic_pci_mem_read_ioctl(adapter, data.off, &(data.u),
-						  data.size)) {
-			DPRINTK(ERR, "Failed to read the data.\n");
-			retval = -EFAULT;
-			goto error_out;
-		}
-		if (copy_to_user
-		    ((void __user *)&(up_data->u), &(data.u), data.size)) {
-			DPRINTK(ERR, "bad copy to userland: %d\n",
-				(int)sizeof(data));
-			retval = -EFAULT;
-			goto error_out;
-		}
-		data.rv = 0;
-		break;
-
-	case netxen_nic_cmd_pci_mem_write:
-		if ((retval = netxen_nic_pci_mem_write_ioctl(adapter, data.off,
-							     &(data.u),
-							     data.size)))
-			goto error_out;
-		data.rv = 0;
-		break;
-
-	case netxen_nic_cmd_pci_config_read:
-		switch (data.size) {
-		case 1:
-			data.rv = pci_read_config_byte(adapter->ahw.pdev,
-						       data.off,
-						       (char *)&(data.u));
-			break;
-		case 2:
-			data.rv = pci_read_config_word(adapter->ahw.pdev,
-						       data.off,
-						       (short *)&(data.u));
-			break;
-		case 4:
-			data.rv = pci_read_config_dword(adapter->ahw.pdev,
-							data.off,
-							(u32 *) & (data.u));
-			break;
-		}
-		if (copy_to_user
-		    ((void __user *)&(up_data->u), &(data.u), data.size)) {
-			DPRINTK(ERR, "bad copy to userland: %d\n",
-				(int)sizeof(data));
-			retval = -EFAULT;
-			goto error_out;
-		}
-		break;
-
-	case netxen_nic_cmd_pci_config_write:
-		switch (data.size) {
-		case 1:
-			data.rv = pci_write_config_byte(adapter->ahw.pdev,
-							data.off,
-							*(char *)&(data.u));
-			break;
-		case 2:
-			data.rv = pci_write_config_word(adapter->ahw.pdev,
-							data.off,
-							*(short *)&(data.u));
-			break;
-		case 4:
-			data.rv = pci_write_config_dword(adapter->ahw.pdev,
-							 data.off,
-							 *(u32 *) & (data.u));
-			break;
-		}
-		break;
-
-	case netxen_nic_cmd_get_stats:
-		data.rv =
-		    netxen_nic_fill_statistics(adapter, port, &netxen_stats);
-		if (copy_to_user
-		    ((void __user *)(up_data->ptr), (void *)&netxen_stats,
-		     sizeof(struct netxen_statistics))) {
-			DPRINTK(ERR, "bad copy to userland: %d\n",
-				(int)sizeof(netxen_stats));
-			retval = -EFAULT;
-			goto error_out;
-		}
-		up_data->rv = data.rv;
-		break;
-
-	case netxen_nic_cmd_clear_stats:
-		data.rv = netxen_nic_clear_statistics(adapter, port);
-		up_data->rv = data.rv;
-		break;
-
-	case netxen_nic_cmd_get_version:
-		if (copy_to_user
-		    ((void __user *)&(up_data->u), NETXEN_NIC_LINUX_VERSIONID,
-		     sizeof(NETXEN_NIC_LINUX_VERSIONID))) {
-			DPRINTK(ERR, "bad copy to userland: %d\n",
-				(int)sizeof(data));
-			retval = -EFAULT;
-			goto error_out;
-		}
-		break;
-
-	default:
-		DPRINTK(INFO, "bad command %d for %p\n", data.cmd, adapter);
-		retval = -EOPNOTSUPP;
-		goto error_out;
-	}
-	put_user(data.rv, (&(up_data->rv)));
-	DPRINTK(INFO, "done ioctl for %p well.\n", adapter);
-
-      error_out:
-	return retval;
-}
diff --git a/drivers/net/netxen/netxen_nic_ioctl.h b/drivers/net/netxen/netxen_nic_ioctl.h
deleted file mode 100644
index 1221fa5..0000000
--- a/drivers/net/netxen/netxen_nic_ioctl.h
+++ /dev/null
@@ -1,77 +0,0 @@
-/*
- * Copyright (C) 2003 - 2006 NetXen, Inc.
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston,
- * MA  02111-1307, USA.
- *
- * The full GNU General Public License is included in this distribution
- * in the file called LICENSE.
- *
- * Contact Information:
- *    info@netxen.com
- * NetXen,
- * 3965 Freedom Circle, Fourth floor,
- * Santa Clara, CA 95054
- */
-
-#ifndef __NETXEN_NIC_IOCTL_H__
-#define __NETXEN_NIC_IOCTL_H__
-
-#include <linux/sockios.h>
-
-#define NETXEN_CMD_START	SIOCDEVPRIVATE
-#define NETXEN_NIC_CMD		(NETXEN_CMD_START + 1)
-#define NETXEN_NIC_NAME		(NETXEN_CMD_START + 2)
-#define NETXEN_NIC_NAME_LEN	16
-#define NETXEN_NIC_NAME_RSP	"NETXEN-UNM"
-
-typedef enum {
-	netxen_nic_cmd_none = 0,
-	netxen_nic_cmd_pci_read,
-	netxen_nic_cmd_pci_write,
-	netxen_nic_cmd_pci_mem_read,
-	netxen_nic_cmd_pci_mem_write,
-	netxen_nic_cmd_pci_config_read,
-	netxen_nic_cmd_pci_config_write,
-	netxen_nic_cmd_get_stats,
-	netxen_nic_cmd_clear_stats,
-	netxen_nic_cmd_get_version
-} netxen_nic_ioctl_cmd_t;
-
-struct netxen_nic_ioctl_data {
-	u32 cmd;
-	u32 unused1;
-	u64 off;
-	u32 size;
-	u32 rv;
-	char u[64];
-	void *ptr;
-};
-
-struct netxen_statistics {
-	u64 rx_packets;
-	u64 tx_packets;
-	u64 rx_bytes;
-	u64 rx_errors;
-	u64 tx_bytes;
-	u64 tx_errors;
-	u64 rx_crc_errors;
-	u64 rx_short_length_error;
-	u64 rx_long_length_error;
-	u64 rx_mac_errors;
-};
-
-#endif				/* __NETXEN_NIC_IOCTL_H_ */
diff --git a/drivers/net/netxen/netxen_nic_main.c b/drivers/net/netxen/netxen_nic_main.c
index 575b71b..1658ca1 100644
--- a/drivers/net/netxen/netxen_nic_main.c
+++ b/drivers/net/netxen/netxen_nic_main.c
@@ -38,7 +38,6 @@
 #include "netxen_nic.h"
 #define DEFINE_GLOBAL_RECV_CRB
 #include "netxen_nic_phan_reg.h"
-#include "netxen_nic_ioctl.h"
 
 #include <linux/dma-mapping.h>
 #include <linux/vmalloc.h>
@@ -75,8 +74,6 @@ static void netxen_tx_timeout(struct net_device *netdev);
 static void netxen_tx_timeout_task(struct work_struct *work);
 static void netxen_watchdog(unsigned long);
 static int netxen_handle_int(struct netxen_adapter *, struct net_device *);
-static int netxen_nic_ioctl(struct net_device *netdev,
-			    struct ifreq *ifr, int cmd);
 static int netxen_nic_poll(struct net_device *dev, int *budget);
 #ifdef CONFIG_NET_POLL_CONTROLLER
 static void netxen_nic_poll_controller(struct net_device *netdev);
@@ -383,7 +380,6 @@ netxen_nic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		netdev->set_multicast_list = netxen_nic_set_multi;
 		netdev->set_mac_address = netxen_nic_set_mac;
 		netdev->change_mtu = netxen_nic_change_mtu;
-		netdev->do_ioctl = netxen_nic_ioctl;
 		netdev->tx_timeout = netxen_tx_timeout;
 		netdev->watchdog_timeo = HZ;
 
@@ -1137,47 +1133,6 @@ static void netxen_nic_poll_controller(struct net_device *netdev)
 	enable_irq(adapter->irq);
 }
 #endif
-/*
- * netxen_nic_ioctl ()    We provide the tcl/phanmon support through these
- * ioctls.
- */
-static int
-netxen_nic_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
-{
-	int err = 0;
-	unsigned long nr_bytes = 0;
-	struct netxen_port *port = netdev_priv(netdev);
-	struct netxen_adapter *adapter = port->adapter;
-	char dev_name[NETXEN_NIC_NAME_LEN];
-
-	DPRINTK(INFO, "doing ioctl for %s\n", netdev->name);
-	switch (cmd) {
-	case NETXEN_NIC_CMD:
-		err = netxen_nic_do_ioctl(adapter, (void *)ifr->ifr_data, port);
-		break;
-
-	case NETXEN_NIC_NAME:
-		DPRINTK(INFO, "ioctl cmd for NetXen\n");
-		if (ifr->ifr_data) {
-			sprintf(dev_name, "%s-%d", NETXEN_NIC_NAME_RSP,
-				port->portnum);
-			nr_bytes =
-			    copy_to_user((char __user *)ifr->ifr_data, dev_name,
-					 NETXEN_NIC_NAME_LEN);
-			if (nr_bytes)
-				err = -EIO;
-
-		}
-		break;
-
-	default:
-		DPRINTK(INFO, "ioctl cmd %x not supported\n", cmd);
-		err = -EOPNOTSUPP;
-		break;
-	}
-
-	return err;
-}
 
 static struct pci_driver netxen_driver = {
 	.name = netxen_nic_driver_name,
