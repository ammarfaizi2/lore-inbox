Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbVJYVgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVJYVgI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 17:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbVJYVgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 17:36:07 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:48784 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932401AbVJYVgF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 17:36:05 -0400
Subject: [PATCH] 2/5 ibmveth fix buffer pool management
From: Santiago Leon <santil@us.ibm.com>
To: netdev <netdev@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>
Content-Type: text/plain
Message-Id: <1130275527.11133.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 25 Oct 2005 16:34:51 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the way the ibmveth driver handles the receive
buffers.  The old code mallocs and maps all the buffers in the pools
regardless of MTU size and it also limits the number of buffer pools to
three. This patch makes the driver malloc and map the buffers necessary
to support the current MTU. It also changes the hardcoded names of the
buffer pool number, size, and elements to arrays to make it easier to
change (with the hope of making them runtime parameters in the future).


Signed-off-by: Santiago Leon <santil@us.ibm.com>
---
drivers/net/ibmveth.c |  102
++++++++++++++++++++++++++++++++++++--------------
drivers/net/ibmveth.h |   18 +++++---
2 files changed, 85 insertions(+), 35 deletions(-)
---
diff -urN a/drivers/net/ibmveth.c b/drivers/net/ibmveth.c
--- a/drivers/net/ibmveth.c 2005-10-17 11:59:57.000000000 -0500
+++ b/drivers/net/ibmveth.c 2005-10-17 12:02:03.000000000 -0500
@@ -97,6 +97,7 @@
static void ibmveth_proc_unregister_adapter(struct ibmveth_adapter
*adapter);
static irqreturn_t ibmveth_interrupt(int irq, void *dev_instance, struct
pt_regs *regs);
static inline void ibmveth_schedule_replenishing(struct
ibmveth_adapter*);
+static inline void ibmveth_rxq_harvest_buffer(struct ibmveth_adapter
*adapter);

#ifdef CONFIG_PROC_FS
#define IBMVETH_PROC_DIR "net/ibmveth"
@@ -181,6 +182,7 @@
atomic_set(&pool->available, 0);
pool->producer_index = 0;
pool->consumer_index = 0;
+ pool->active = 0;

return 0;
}
@@ -258,9 +260,14 @@
/* check if replenishing is needed.  */
static inline int ibmveth_is_replenishing_needed(struct ibmveth_adapter
*adapter)
{
- return ((atomic_read(&adapter->rx_buff_pool[0].available) <
adapter->rx_buff_pool[0].threshold) ||
- (atomic_read(&adapter->rx_buff_pool[1].available) <
adapter->rx_buff_pool[1].threshold) ||
- (atomic_read(&adapter->rx_buff_pool[2].available) <
adapter->rx_buff_pool[2].threshold));
+ int i;
+
+ for(i = 0; i < IbmVethNumBufferPools; i++)
+ if(adapter->rx_buff_pool[i].active &&
+   (atomic_read(&adapter->rx_buff_pool[i].available) <
+    adapter->rx_buff_pool[i].threshold))
+ return 1;
+ return 0;
}

/* kick the replenish tasklet if we need replenishing and it isn't
already running */
@@ -275,11 +282,14 @@
/* replenish tasklet routine */
static void ibmveth_replenish_task(struct ibmveth_adapter *adapter) 
{
+ int i;
+
adapter->replenish_task_cycles++;

- ibmveth_replenish_buffer_pool(adapter, &adapter->rx_buff_pool[0]);
- ibmveth_replenish_buffer_pool(adapter, &adapter->rx_buff_pool[1]);
- ibmveth_replenish_buffer_pool(adapter, &adapter->rx_buff_pool[2]);
+ for(i = 0; i < IbmVethNumBufferPools; i++)
+ if(adapter->rx_buff_pool[i].active)
+ ibmveth_replenish_buffer_pool(adapter, 
+      &adapter->rx_buff_pool[i]);

adapter->rx_no_buffer = *(u64*)(((char*)adapter->buffer_list_addr) +
4096 - 8);

@@ -321,6 +331,7 @@
kfree(pool->skbuff);
pool->skbuff = NULL;
}
+ pool->active = 0;
}

/* remove a buffer from a pool */
@@ -379,6 +390,12 @@
ibmveth_assert(pool < IbmVethNumBufferPools);
ibmveth_assert(index < adapter->rx_buff_pool[pool].size);

+ if(!adapter->rx_buff_pool[pool].active) {
+ ibmveth_rxq_harvest_buffer(adapter);
+ ibmveth_free_buffer_pool(adapter, &adapter->rx_buff_pool[pool]);
+ return;
+ }
+
desc.desc = 0;
desc.fields.valid = 1;
desc.fields.length = adapter->rx_buff_pool[pool].buff_size;
@@ -409,6 +426,8 @@

static void ibmveth_cleanup(struct ibmveth_adapter *adapter)
{
+ int i;
+
if(adapter->buffer_list_addr != NULL) {
if(!dma_mapping_error(adapter->buffer_list_dma)) {
dma_unmap_single(&adapter->vdev->dev,
@@ -443,26 +462,24 @@
adapter->rx_queue.queue_addr = NULL;
}

- ibmveth_free_buffer_pool(adapter, &adapter->rx_buff_pool[0]);
- ibmveth_free_buffer_pool(adapter, &adapter->rx_buff_pool[1]);
- ibmveth_free_buffer_pool(adapter, &adapter->rx_buff_pool[2]);
+ for(i = 0; i<IbmVethNumBufferPools; i++)
+ ibmveth_free_buffer_pool(adapter, &adapter->rx_buff_pool[i]);
}

static int ibmveth_open(struct net_device *netdev)
{
struct ibmveth_adapter *adapter = netdev->priv;
u64 mac_address = 0;
- int rxq_entries;
+ int rxq_entries = 1;
unsigned long lpar_rc;
int rc;
union ibmveth_buf_desc rxq_desc;
+ int i;

ibmveth_debug_printk("open starting\n");

- rxq_entries =
- adapter->rx_buff_pool[0].size +
- adapter->rx_buff_pool[1].size +
- adapter->rx_buff_pool[2].size + 1;
+ for(i = 0; i<IbmVethNumBufferPools; i++)
+ rxq_entries += adapter->rx_buff_pool[i].size;
     
adapter->buffer_list_addr = (void*) get_zeroed_page(GFP_KERNEL);
adapter->filter_list_addr = (void*) get_zeroed_page(GFP_KERNEL);
@@ -502,14 +519,8 @@
adapter->rx_queue.num_slots = rxq_entries;
adapter->rx_queue.toggle = 1;

- if(ibmveth_alloc_buffer_pool(&adapter->rx_buff_pool[0]) ||
-    ibmveth_alloc_buffer_pool(&adapter->rx_buff_pool[1]) ||
-    ibmveth_alloc_buffer_pool(&adapter->rx_buff_pool[2]))
- {
- ibmveth_error_printk("unable to allocate buffer pools\n");
- ibmveth_cleanup(adapter);
- return -ENOMEM;
- }
+ /* call change_mtu to init the buffer pools based in initial mtu */
+ ibmveth_change_mtu(netdev, netdev->mtu);

memcpy(&mac_address, netdev->dev_addr, netdev->addr_len);
mac_address = mac_address >> 16;
@@ -885,17 +896,52 @@

static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
{
- if ((new_mtu < 68) || (new_mtu > (1<<20)))
+ struct ibmveth_adapter *adapter = dev->priv;
+ int i;
+ int prev_smaller = 1;
+
+ if ((new_mtu < 68) || 
+     (new_mtu > (pool_size[IbmVethNumBufferPools-1]) -
IBMVETH_BUFF_OH))
return -EINVAL;
+
+ for(i = 0; i<IbmVethNumBufferPools; i++) {
+ int activate = 0;
+ if (new_mtu > (pool_size[i]  - IBMVETH_BUFF_OH)) { 
+ activate = 1;
+ prev_smaller= 1;
+ } else {
+ if (prev_smaller)
+ activate = 1;
+ prev_smaller= 0;
+ }
+
+ if (activate && !adapter->rx_buff_pool[i].active) {
+ struct ibmveth_buff_pool *pool = 
+ &adapter->rx_buff_pool[i];
+ if(ibmveth_alloc_buffer_pool(pool)) {
+ ibmveth_error_printk("unable to alloc pool\n");
+ return -ENOMEM;
+ }
+ adapter->rx_buff_pool[i].active = 1;
+ } else if (!activate && adapter->rx_buff_pool[i].active) {
+ adapter->rx_buff_pool[i].active = 0;
+ h_free_logical_lan_buffer(adapter->vdev->unit_address,
+   (u64)pool_size[i]);
+ }
+
+ }
+
+
+ ibmveth_schedule_replenishing(adapter);
dev->mtu = new_mtu;
return 0; 
}

static int __devinit ibmveth_probe(struct vio_dev *dev, const struct
vio_device_id *id)
{
- int rc;
+ int rc, i;
struct net_device *netdev;
- struct ibmveth_adapter *adapter;
+ struct ibmveth_adapter *adapter = NULL;

unsigned char *mac_addr_p;
unsigned int *mcastFilterSize_p;
@@ -965,9 +1011,9 @@

memcpy(&netdev->dev_addr, &adapter->mac_addr, netdev->addr_len);

- ibmveth_init_buffer_pool(&adapter->rx_buff_pool[0], 0,
IbmVethPool0DftCnt, IbmVethPool0DftSize);
- ibmveth_init_buffer_pool(&adapter->rx_buff_pool[1], 1,
IbmVethPool1DftCnt, IbmVethPool1DftSize);
- ibmveth_init_buffer_pool(&adapter->rx_buff_pool[2], 2,
IbmVethPool2DftCnt, IbmVethPool2DftSize);
+ for(i = 0; i<IbmVethNumBufferPools; i++)
+ ibmveth_init_buffer_pool(&adapter->rx_buff_pool[i], i, 
+ pool_count[i], pool_size[i]);

ibmveth_debug_printk("adapter @ 0x%p\n", adapter);

diff -urN a/drivers/net/ibmveth.h b/drivers/net/ibmveth.h
--- a/drivers/net/ibmveth.h 2005-06-17 14:48:29.000000000 -0500
+++ b/drivers/net/ibmveth.h 2005-10-17 12:00:25.000000000 -0500
@@ -49,6 +49,7 @@
#define H_SEND_LOGICAL_LAN       0x120
#define H_MULTICAST_CTRL         0x130
#define H_CHANGE_LOGICAL_LAN_MAC 0x14C
+#define H_FREE_LOGICAL_LAN_BUFFER 0x1D4

/* hcall macros */
#define h_register_logical_lan(ua, buflst, rxq, fltlst, mac) \
@@ -69,13 +70,15 @@
#define h_change_logical_lan_mac(ua, mac) \
   plpar_hcall_norets(H_CHANGE_LOGICAL_LAN_MAC, ua, mac)

-#define IbmVethNumBufferPools 3
-#define IbmVethPool0DftSize (1024 * 2)
-#define IbmVethPool1DftSize (1024 * 4)
-#define IbmVethPool2DftSize (1024 * 10)
-#define IbmVethPool0DftCnt  256
-#define IbmVethPool1DftCnt  256
-#define IbmVethPool2DftCnt  256
+#define h_free_logical_lan_buffer(ua, bufsize) \
+  plpar_hcall_norets(H_FREE_LOGICAL_LAN_BUFFER, ua, bufsize)
+
+#define IbmVethNumBufferPools 5
+#define IBMVETH_BUFF_OH 22 /* Overhead: 14 ethernet header + 8 opaque
handle */
+
+/* pool_size should be sorted */
+static int pool_size[] = { 512, 1024 * 2, 1024 * 16, 1024 * 32, 1024 *
64 };
+static int pool_count[] = { 256, 768, 256, 256, 256 };

#define IBM_VETH_INVALID_MAP ((u16)0xffff)

@@ -90,6 +93,7 @@
     u16 *free_map;
     dma_addr_t *dma_addr;
     struct sk_buff **skbuff;
+    int active;
};

struct ibmveth_rx_q {


-- 
Santiago A. Leon
Power Linux Development
IBM Linux Technology Center

