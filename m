Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425024AbWLCHtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425024AbWLCHtN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 02:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425027AbWLCHtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 02:49:13 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23818 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1425025AbWLCHtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 02:49:12 -0500
Date: Sun, 3 Dec 2006 08:49:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, amitkale@netxen.com, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [-mm patch] drivers/net/netxen/: possible cleanups
Message-ID: <20061203074917.GB11084@stusta.de>
References: <20061128020246.47e481eb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061128020246.47e481eb.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2006 at 02:02:46AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-rc6-mm1:
>...
>  git-netdev-all.patch
>...
>  git trees
>...

This patch contains the following possible cleanups:
- make needlessly global code static
- #if 0 the following unused global functions:
  - netxen_nic_hw.c: netxen_crb_read_val()
  - netxen_nic_niu.c: netxen_niu_xgbe_clear_phy_interrupts()
  - netxen_nic_niu.c: netxen_niu_gbe_handle_phy_interrupt()
  - netxen_nic_niu.c: netxen_niu_macaddr_get()
  - netxen_nic_niu.c: netxen_niu_enable_gbe_port()
  - netxen_nic_niu.c: netxen_niu_xg_macaddr_get()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/netxen/netxen_nic.h      |   13 -------------
 drivers/net/netxen/netxen_nic_hw.c   |   13 +++++++------
 drivers/net/netxen/netxen_nic_hw.h   |    8 ++------
 drivers/net/netxen/netxen_nic_init.c |   21 +++++++++------------
 drivers/net/netxen/netxen_nic_isr.c  |   10 +++++-----
 drivers/net/netxen/netxen_nic_niu.c  |   22 ++++++++++++++++------
 6 files changed, 39 insertions(+), 48 deletions(-)

--- linux-2.6.19-rc6-mm2/drivers/net/netxen/netxen_nic_hw.c.old	2006-12-02 20:43:26.000000000 +0100
+++ linux-2.6.19-rc6-mm2/drivers/net/netxen/netxen_nic_hw.c	2006-12-02 20:45:07.000000000 +0100
@@ -51,9 +51,8 @@
 #define NETXEN_NIU_HDRSIZE	(0x1 << 6)
 #define NETXEN_NIU_TLRSIZE	(0x1 << 5)
 
-unsigned long netxen_nic_pci_set_window(void __iomem * pci_base,
-					unsigned long long addr);
-void netxen_free_hw_resources(struct netxen_adapter *adapter);
+static unsigned long netxen_nic_pci_set_window(void __iomem * pci_base,
+					       unsigned long long addr);
 
 int netxen_nic_set_mac(struct net_device *netdev, void *p)
 {
@@ -646,10 +645,10 @@
 	netxen_nic_pci_change_crbwindow(adapter, 1);
 }
 
-int netxen_pci_set_window_warning_count = 0;
+static int netxen_pci_set_window_warning_count = 0;
 
-unsigned long
-netxen_nic_pci_set_window(void __iomem * pci_base, unsigned long long addr)
+static unsigned long netxen_nic_pci_set_window(void __iomem * pci_base,
+					       unsigned long long addr)
 {
 	static int ddr_mn_window = -1;
 	static int qdr_sn_window = -1;
@@ -928,9 +927,11 @@
 		       fw_major, fw_minor);
 }
 
+#if 0
 int netxen_crb_read_val(struct netxen_adapter *adapter, unsigned long off)
 {
 	int data;
 	netxen_nic_hw_read_wx(adapter, off, &data, 4);
 	return data;
 }
+#endif  /*  0  */
--- linux-2.6.19-rc6-mm2/drivers/net/netxen/netxen_nic_init.c.old	2006-12-02 20:45:27.000000000 +0100
+++ linux-2.6.19-rc6-mm2/drivers/net/netxen/netxen_nic_init.c	2006-12-02 20:47:44.000000000 +0100
@@ -239,7 +239,7 @@
  * netxen_decode_crb_addr(0 - utility to translate from internal Phantom CRB
  * address to external PCI CRB address.
  */
-unsigned long netxen_decode_crb_addr(unsigned long addr)
+static unsigned long netxen_decode_crb_addr(unsigned long addr)
 {
 	int i;
 	unsigned long base_addr, offset, pci_base;
@@ -304,7 +304,7 @@
 
 }
 
-int netxen_wait_rom_done(struct netxen_adapter *adapter)
+static int netxen_wait_rom_done(struct netxen_adapter *adapter)
 {
 	long timeout = 0;
 	long done = 0;
@@ -582,9 +582,8 @@
  * and if the number of receives exceeds RX_BUFFERS_REFILL, then we
  * invoke the routine to send more rx buffers to the Phantom...
  */
-void
-netxen_process_rcv(struct netxen_adapter *adapter, int ctxid,
-		   struct status_desc *desc)
+static void netxen_process_rcv(struct netxen_adapter *adapter, int ctxid,
+			       struct status_desc *desc)
 {
 	struct netxen_port *port = adapter->port[STATUS_DESC_PORT(desc)];
 	struct pci_dev *pdev = port->pdev;
@@ -919,10 +918,9 @@
 	return 0;
 }
 
-int
-netxen_nic_fill_statistics(struct netxen_adapter *adapter,
-			   struct netxen_port *port,
-			   struct netxen_statistics *netxen_stats)
+static int netxen_nic_fill_statistics(struct netxen_adapter *adapter,
+				      struct netxen_port *port,
+				      struct netxen_statistics *netxen_stats)
 {
 	void __iomem *addr;
 
@@ -978,9 +976,8 @@
 	}
 }
 
-int
-netxen_nic_clear_statistics(struct netxen_adapter *adapter,
-			    struct netxen_port *port)
+static int netxen_nic_clear_statistics(struct netxen_adapter *adapter,
+				       struct netxen_port *port)
 {
 	int data = 0;
 
--- linux-2.6.19-rc6-mm2/drivers/net/netxen/netxen_nic.h.old	2006-12-02 20:48:02.000000000 +0100
+++ linux-2.6.19-rc6-mm2/drivers/net/netxen/netxen_nic.h	2006-12-02 20:54:30.000000000 +0100
@@ -793,16 +793,8 @@
 					   int port);
 int netxen_niu_gbe_disable_phy_interrupts(struct netxen_adapter *adapter,
 					  int port);
-int netxen_niu_xgbe_clear_phy_interrupts(struct netxen_adapter *adapter,
-					 int port);
-int netxen_niu_gbe_clear_phy_interrupts(struct netxen_adapter *adapter,
-					int port);
 void netxen_nic_xgbe_handle_phy_intr(struct netxen_adapter *adapter);
 void netxen_nic_gbe_handle_phy_intr(struct netxen_adapter *adapter);
-void netxen_niu_gbe_set_mii_mode(struct netxen_adapter *adapter, int port,
-				 long enable);
-void netxen_niu_gbe_set_gmii_mode(struct netxen_adapter *adapter, int port,
-				  long enable);
 int netxen_niu_gbe_phy_read(struct netxen_adapter *adapter, long phy, long reg,
 			    __le32 * readval);
 int netxen_niu_gbe_phy_write(struct netxen_adapter *adapter, long phy,
@@ -834,11 +826,6 @@
 int netxen_rom_fast_read(struct netxen_adapter *adapter, int addr, int *valp);
 
 /* Functions from netxen_nic_isr.c */
-void netxen_nic_isr_other(struct netxen_adapter *adapter);
-void netxen_indicate_link_status(struct netxen_adapter *adapter, u32 port,
-				 u32 link);
-void netxen_handle_port_int(struct netxen_adapter *adapter, u32 port,
-			    u32 enable);
 void netxen_nic_stop_all_ports(struct netxen_adapter *adapter);
 void netxen_initialize_adapter_sw(struct netxen_adapter *adapter);
 void netxen_initialize_adapter_hw(struct netxen_adapter *adapter);
--- linux-2.6.19-rc6-mm2/drivers/net/netxen/netxen_nic_isr.c.old	2006-12-02 20:48:15.000000000 +0100
+++ linux-2.6.19-rc6-mm2/drivers/net/netxen/netxen_nic_isr.c	2006-12-02 20:49:36.000000000 +0100
@@ -65,8 +65,8 @@
 	return stats;
 }
 
-void netxen_indicate_link_status(struct netxen_adapter *adapter, u32 portno,
-				 u32 link)
+static void netxen_indicate_link_status(struct netxen_adapter *adapter,
+					u32 portno, u32 link)
 {
 	struct netxen_port *pport = adapter->port[portno];
 	struct net_device *netdev = pport->netdev;
@@ -77,8 +77,8 @@
 		netif_carrier_off(netdev);
 }
 
-void netxen_handle_port_int(struct netxen_adapter *adapter, u32 portno,
-			    u32 enable)
+static void netxen_handle_port_int(struct netxen_adapter *adapter, u32 portno,
+				   u32 enable)
 {
 	__le32 int_src;
 	struct netxen_port *port;
@@ -147,7 +147,7 @@
 		adapter->ops->enable_phy_interrupts(adapter, portno);
 }
 
-void netxen_nic_isr_other(struct netxen_adapter *adapter)
+static void netxen_nic_isr_other(struct netxen_adapter *adapter)
 {
 	u32 enable, portno;
 	u32 i2qhi;
--- linux-2.6.19-rc6-mm2/drivers/net/netxen/netxen_nic_hw.h.old	2006-12-02 20:52:48.000000000 +0100
+++ linux-2.6.19-rc6-mm2/drivers/net/netxen/netxen_nic_hw.h	2006-12-02 20:53:51.000000000 +0100
@@ -457,15 +457,11 @@
 int netxen_niu_xg_set_promiscuous_mode(struct netxen_adapter *adapter,
 				       int port, netxen_niu_prom_mode_t mode);
 
-/* get/set the MAC address for a given MAC */
-int netxen_niu_macaddr_get(struct netxen_adapter *adapter, int port,
-			   netxen_ethernet_macaddr_t * addr);
+/* set the MAC address for a given MAC */
 int netxen_niu_macaddr_set(struct netxen_port *port,
 			   netxen_ethernet_macaddr_t addr);
 
-/* XG versons */
-int netxen_niu_xg_macaddr_get(struct netxen_adapter *adapter, int port,
-			      netxen_ethernet_macaddr_t * addr);
+/* XG verson */
 int netxen_niu_xg_macaddr_set(struct netxen_port *port,
 			      netxen_ethernet_macaddr_t addr);
 
--- linux-2.6.19-rc6-mm2/drivers/net/netxen/netxen_nic_niu.c.old	2006-12-02 20:49:50.000000000 +0100
+++ linux-2.6.19-rc6-mm2/drivers/net/netxen/netxen_nic_niu.c	2006-12-02 20:54:43.000000000 +0100
@@ -262,15 +262,17 @@
 	return result;
 }
 
+#if 0
 int netxen_niu_xgbe_clear_phy_interrupts(struct netxen_adapter *adapter,
 					 int port)
 {
 	netxen_crb_writelit_adapter(adapter, NETXEN_NIU_ACTIVE_INT, -1);
 	return 0;
 }
+#endif  /*  0  */
 
-int netxen_niu_gbe_clear_phy_interrupts(struct netxen_adapter *adapter,
-					int port)
+static int netxen_niu_gbe_clear_phy_interrupts(struct netxen_adapter *adapter,
+					       int port)
 {
 	int result = 0;
 	if (0 !=
@@ -286,8 +288,8 @@
  * netxen_niu_gbe_set_mii_mode- Set 10/100 Mbit Mode for GbE MAC
  *
  */
-void netxen_niu_gbe_set_mii_mode(struct netxen_adapter *adapter,
-				 int port, long enable)
+static void netxen_niu_gbe_set_mii_mode(struct netxen_adapter *adapter,
+					int port, long enable)
 {
 	netxen_crb_writelit_adapter(adapter, NETXEN_NIU_MODE, 0x2);
 	netxen_crb_writelit_adapter(adapter, NETXEN_NIU_GB_MAC_CONFIG_0(port),
@@ -324,8 +326,8 @@
 /* 
  * netxen_niu_gbe_set_gmii_mode- Set GbE Mode for GbE MAC
  */
-void netxen_niu_gbe_set_gmii_mode(struct netxen_adapter *adapter,
-				  int port, long enable)
+static void netxen_niu_gbe_set_gmii_mode(struct netxen_adapter *adapter,
+					 int port, long enable)
 {
 	netxen_crb_writelit_adapter(adapter, NETXEN_NIU_MODE, 0x2);
 	netxen_crb_writelit_adapter(adapter, NETXEN_NIU_GB_MAC_CONFIG_0(port),
@@ -407,6 +409,8 @@
 	return result;
 }
 
+#if 0
+
 /* 
  * netxen_niu_gbe_handle_phy_interrupt - Handles GbE PHY interrupts
  * @param enable 0 means don't enable the port
@@ -530,6 +534,8 @@
 	return 0;
 }
 
+#endif  /*  0  */
+
 /*
  * Set the station MAC address.
  * Note that the passed-in value must already be in network byte order.
@@ -557,6 +563,7 @@
 	return 0;
 }
 
+#if 0
 /* Enable a GbE interface */
 int netxen_niu_enable_gbe_port(struct netxen_adapter *adapter,
 			       int port, netxen_niu_gbe_ifmode_t mode)
@@ -634,6 +641,7 @@
 		return -EIO;
 	return 0;
 }
+#endif  /*  0  */
 
 /* Disable a GbE interface */
 int netxen_niu_disable_gbe_port(struct netxen_adapter *adapter, int port)
@@ -749,6 +757,7 @@
 	return 0;
 }
 
+#if 0
 /*
  * Return the current station MAC address.
  * Note that the passed-in value must already be in network byte order.
@@ -778,6 +787,7 @@
 
 	return 0;
 }
+#endif  /*  0  */
 
 int netxen_niu_xg_set_promiscuous_mode(struct netxen_adapter *adapter,
 				       int port, netxen_niu_prom_mode_t mode)


