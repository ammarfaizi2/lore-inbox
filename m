Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267324AbUH0TIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267324AbUH0TIU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 15:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267302AbUH0TIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 15:08:20 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:21415 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S267551AbUH0TEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 15:04:36 -0400
Message-ID: <412F85B7.1060804@us.ibm.com>
Date: Fri, 27 Aug 2004 14:04:23 -0500
From: Santiago Leon <santil@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] POWER5 Virtual Ethernet Checkum offload
Content-Type: multipart/mixed;
 boundary="------------030906070701020806010300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030906070701020806010300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew,

The following patch adds checksum offloading for the POWER5 Virtual 
Ethernet driver.  In the case where the OS in the partitions 
communicating support this feature (i.e. both partition have this patch 
applied), no checksum will be created because the link is reliable. 
However, in the case where one of the OS in a partition does support 
this feature and the other doesn't (i.e. linux with patch applied 
talking to AIX), then the hypervisor will generate the checksum.

Some levels of firmware will not support this feature but the code will 
figure it out and not enable it.

Applies against the latest mainline and -mm trees. Please apply.


Signed-off-by: Santiago Leon <santil@us.ibm.com>

-- 
Santiago A. Leon
Power Linux Development
IBM Linux Technology Center

--------------030906070701020806010300
Content-Type: text/plain;
 name="ibmveth_chkoff.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ibmveth_chkoff.patch"

===== drivers/net/ibmveth.c 1.17 vs edited =====
--- 1.17/drivers/net/ibmveth.c	Mon Aug 23 03:14:44 2004
+++ edited/drivers/net/ibmveth.c	Fri Aug 27 14:23:56 2004
@@ -49,6 +49,7 @@
 #include <linux/mm.h>
 #include <linux/ethtool.h>
 #include <linux/proc_fs.h>
+#include <linux/tcp.h>
 #include <asm/semaphore.h>
 #include <asm/hvcall.h>
 #include <asm/atomic.h>
@@ -104,7 +105,7 @@
 
 static const char ibmveth_driver_name[] = "ibmveth";
 static const char ibmveth_driver_string[] = "IBM i/pSeries Virtual Ethernet Driver";
-#define ibmveth_driver_version "1.02"
+#define ibmveth_driver_version "1.03"
 
 MODULE_AUTHOR("Santiago Leon <santil@us.ibm.com>");
 MODULE_DESCRIPTION("IBM i/pSeries Virtual Ethernet Driver");
@@ -132,6 +133,11 @@
 	return (adapter->rx_queue.queue_addr[adapter->rx_queue.index].length);
 }
 
+static inline int ibmveth_rxq_frame_checksum_good(struct ibmveth_adapter *adapter)
+{
+	return (adapter->rx_queue.queue_addr[adapter->rx_queue.index].checksum_good);
+}
+
 /* setup the initial settings for a buffer pool */
 static void ibmveth_init_buffer_pool(struct ibmveth_buff_pool *pool, u32 pool_index, u32 pool_size, u32 buff_size)
 {
@@ -403,6 +409,11 @@
 
 static void ibmveth_cleanup(struct ibmveth_adapter *adapter)
 {
+	unsigned long chkoff_result, dummy;
+
+	h_illan_attributes(adapter->vdev->unit_address, CHECKSUM_OFFLOAD, 0, 
+		chkoff_result, dummy);
+
 	if(adapter->buffer_list_addr != NULL) {
 		if(!dma_mapping_error(adapter->buffer_list_dma)) {
 			vio_unmap_single(adapter->vdev, adapter->buffer_list_dma, 4096, DMA_BIDIRECTIONAL);
@@ -645,6 +656,12 @@
 					desc[0].fields.length, DMA_TO_DEVICE);
 	desc[0].fields.valid   = 1;
 
+	if (adapter->can_checksum_offload && skb->ip_summed == CHECKSUM_HW) {
+		desc[0].fields.no_checksum = 1;
+		desc[0].fields.checksum_good = 1;
+		skb->h.th->check = 0;
+	}
+
 	if(dma_mapping_error(desc[0].fields.address)) {
 		ibmveth_error_printk("tx: unable to map initial fragment\n");
 		adapter->tx_map_failed++;
@@ -743,6 +760,7 @@
 			} else {
 				int length = ibmveth_rxq_frame_length(adapter);
 				int offset = ibmveth_rxq_frame_offset(adapter);
+				int checksum_good = ibmveth_rxq_frame_checksum_good(adapter);
 				skb = ibmveth_rxq_get_buffer(adapter);
 
 				ibmveth_rxq_harvest_buffer(adapter);
@@ -751,6 +769,11 @@
 				skb_put(skb, length);
 				skb->dev = netdev;
 				skb->protocol = eth_type_trans(skb, netdev);
+				
+				if (checksum_good)
+					skb->ip_summed = CHECKSUM_UNNECESSARY;
+				else
+					skb->ip_summed = CHECKSUM_NONE;
 
 				netif_receive_skb(skb);	/* send it up */
 
@@ -878,7 +901,7 @@
 
 	unsigned char *mac_addr_p;
 	unsigned int *mcastFilterSize_p;
-
+	unsigned long chkoff_result, dummy;
 
 	ibmveth_debug_printk_no_adapter("entering ibmveth_probe for UA 0x%x\n", 
 					dev->unit_address);
@@ -926,6 +949,18 @@
 
 	adapter->liobn = dev->iommu_table->it_index;
 	
+	rc = h_illan_attributes(dev->unit_address, 0, CHECKSUM_OFFLOAD, 
+		chkoff_result, dummy);
+
+	if (rc == H_Success)
+		adapter->can_checksum_offload = 1;
+	else 
+		adapter->can_checksum_offload = 0;
+	
+	ibmveth_printk("Firmware %s checksum offload, result mask=%lu\n",
+			adapter->can_checksum_offload? "supports" : 
+			"does not support", chkoff_result);
+
 	netdev->irq = dev->irq;
 	netdev->open               = ibmveth_open;
 	netdev->poll               = ibmveth_poll;
@@ -937,6 +972,8 @@
 	netdev->do_ioctl           = ibmveth_ioctl;
 	netdev->ethtool_ops           = &netdev_ethtool_ops;
 	netdev->change_mtu         = ibmveth_change_mtu;
+	if (adapter->can_checksum_offload)
+		netdev->features           = NETIF_F_HW_CSUM; 
 	SET_NETDEV_DEV(netdev, &dev->dev);
 
 	memcpy(&netdev->dev_addr, &adapter->mac_addr, netdev->addr_len);
===== drivers/net/ibmveth.h 1.2 vs edited =====
--- 1.2/drivers/net/ibmveth.h	Mon Aug 23 03:14:44 2004
+++ edited/drivers/net/ibmveth.h	Fri Aug 27 14:21:15 2004
@@ -49,6 +49,7 @@
 #define H_SEND_LOGICAL_LAN       0x120
 #define H_MULTICAST_CTRL         0x130
 #define H_CHANGE_LOGICAL_LAN_MAC 0x14C
+#define H_ILLAN_ATTRIBUTES       0x244
 
 /* hcall macros */
 #define h_register_logical_lan(ua, buflst, rxq, fltlst, mac) \
@@ -69,6 +70,9 @@
 #define h_change_logical_lan_mac(ua, mac) \
   plpar_hcall_norets(H_CHANGE_LOGICAL_LAN_MAC, ua, mac)
 
+#define h_illan_attributes(ua, reset_mask, set_mask, result, dummy) \
+  plpar_hcall(H_ILLAN_ATTRIBUTES, ua, reset_mask, set_mask, 0, &result, &dummy, &dummy)
+
 #define IbmVethNumBufferPools 3
 #define IbmVethPool0DftSize (1024 * 2)
 #define IbmVethPool1DftSize (1024 * 4)
@@ -79,6 +83,8 @@
 
 #define IBM_VETH_INVALID_MAP ((u16)0xffff)
 
+#define CHECKSUM_OFFLOAD 0x6
+
 struct ibmveth_buff_pool {
     u32 size;
     u32 index;
@@ -115,6 +121,7 @@
     struct ibmveth_buff_pool rx_buff_pool[IbmVethNumBufferPools];
     struct ibmveth_rx_q rx_queue;
     atomic_t not_replenishing;
+    int can_checksum_offload;
 
     /* helper tasks */
     struct work_struct replenish_task;
@@ -136,7 +143,9 @@
 struct ibmveth_buf_desc_fields {	
     u32 valid : 1;
     u32 toggle : 1;
-    u32 reserved : 6;
+    u32 reserved : 4;
+    u32 no_checksum : 1;
+    u32 checksum_good :1;
     u32 length : 24;
     u32 address;
 };
@@ -149,7 +158,10 @@
 struct ibmveth_rx_q_entry {
     u16 toggle : 1;
     u16 valid : 1;
-    u16 reserved : 14;
+    u16 reserved : 4;
+    u16 no_checksum : 1;
+    u16 checksum_good : 1;
+    u16 reserved2 : 8;
     u16 offset;
     u32 length;
     u64 correlator;

--------------030906070701020806010300--
