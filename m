Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751518AbWCCVkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbWCCVkX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 16:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbWCCVkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 16:40:21 -0500
Received: from [198.78.49.142] ([198.78.49.142]:49924 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1751512AbWCCVkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 16:40:17 -0500
From: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH 3/8] [I/OAT] Setup the networking subsystem as a DMA client
Date: Fri, 03 Mar 2006 13:42:25 -0800
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <20060303214224.11908.67754.stgit@gitlost.site>
In-Reply-To: <20060303214036.11908.10499.stgit@gitlost.site>
References: <20060303214036.11908.10499.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attempts to allocate per-CPU DMA channels

Signed-off-by: Chris Leech <christopher.leech@intel.com>
---

 drivers/dma/Kconfig       |   12 +++++
 include/linux/netdevice.h |    6 +++
 include/net/netdma.h      |   36 ++++++++++++++++
 net/core/dev.c            |  102 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 156 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 0f15e76..30d021d 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -10,6 +10,18 @@ config DMA_ENGINE
 	  DMA engines offload copy operations from the CPU to dedicated
 	  hardware, allowing the copies to happen asynchronously.
 
+comment "DMA Clients"
+
+config NET_DMA
+	bool "Network: TCP receive copy offload"
+	depends on DMA_ENGINE && NET
+	default y
+	---help---
+	  This enables the use of DMA engines in the network stack to
+	  offload receive copy-to-user operations, freeing CPU cycles.
+	  Since this is the main user of the DMA engine, it should be enabled;
+	  say Y here.
+
 comment "DMA Devices"
 
 config INTEL_IOATDMA
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b825be2..ecbde56 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -37,6 +37,9 @@
 #include <linux/config.h>
 #include <linux/device.h>
 #include <linux/percpu.h>
+#ifdef CONFIG_NET_DMA
+#include <linux/dmaengine.h>
+#endif
 
 struct divert_blk;
 struct vlan_group;
@@ -592,6 +595,9 @@ struct softnet_data
 	struct sk_buff		*completion_queue;
 
 	struct net_device	backlog_dev;	/* Sorry. 8) */
+#ifdef CONFIG_NET_DMA
+	struct dma_chan		*net_dma;
+#endif
 };
 
 DECLARE_PER_CPU(struct softnet_data,softnet_data);
diff --git a/include/net/netdma.h b/include/net/netdma.h
new file mode 100644
index 0000000..3cd9e6d
--- /dev/null
+++ b/include/net/netdma.h
@@ -0,0 +1,36 @@
+/*****************************************************************************
+Copyright(c) 2004 - 2006 Intel Corporation. All rights reserved.
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
+file called LICENSE.
+*****************************************************************************/
+#ifndef NETDMA_H
+#define NETDMA_H
+#include <linux/dmaengine.h>
+
+static inline struct dma_chan *get_softnet_dma(void)
+{
+	struct dma_chan *chan;
+	rcu_read_lock();
+	chan = rcu_dereference(__get_cpu_var(softnet_data.net_dma));
+	if (chan)
+		dma_chan_get(chan);
+	rcu_read_unlock();
+	return chan;
+}
+
+#endif /* NETDMA_H */
diff --git a/net/core/dev.c b/net/core/dev.c
index 7ca47bf..b54e5f3 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -114,6 +114,7 @@
 #include <linux/wireless.h>		/* Note : will define WIRELESS_EXT */
 #include <net/iw_handler.h>
 #endif	/* CONFIG_NET_RADIO */
+#include <linux/dmaengine.h>
 #include <asm/current.h>
 
 /*
@@ -148,6 +149,11 @@ static DEFINE_SPINLOCK(ptype_lock);
 static struct list_head ptype_base[16];	/* 16 way hashed list */
 static struct list_head ptype_all;		/* Taps */
 
+#ifdef CONFIG_NET_DMA
+static struct dma_client *net_dma_client;
+static unsigned int net_dma_count;
+#endif
+
 /*
  * The @dev_base list is protected by @dev_base_lock and the rtln
  * semaphore.
@@ -1719,6 +1725,9 @@ static void net_rx_action(struct softirq
 	unsigned long start_time = jiffies;
 	int budget = netdev_budget;
 	void *have;
+#ifdef CONFIG_NET_DMA
+	struct dma_chan *chan;
+#endif
 
 	local_irq_disable();
 
@@ -1750,6 +1759,18 @@ static void net_rx_action(struct softirq
 		}
 	}
 out:
+#ifdef CONFIG_NET_DMA
+	/*
+	 * There may not be any more sk_buffs coming right now, so push
+	 * any pending DMA copies to hardware
+	 */
+	if (net_dma_client) {
+		rcu_read_lock();
+		list_for_each_entry_rcu(chan, &net_dma_client->channels, client_node)
+			dma_async_memcpy_issue_pending(chan);
+		rcu_read_unlock();
+	}
+#endif
 	local_irq_enable();
 	return;
 
@@ -3205,6 +3226,85 @@ static int dev_cpu_callback(struct notif
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
+#ifdef CONFIG_NET_DMA
+/**
+ * net_dma_rebalance -
+ * This is called when the number of channels allocated to the net_dma_client
+ * changes.  The net_dma_client tries to have one DMA channel per CPU.
+ */
+static void net_dma_rebalance(void)
+{
+	unsigned int cpu, i, n;
+	struct dma_chan *chan;
+
+	lock_cpu_hotplug();
+
+	if (net_dma_count == 0) {
+		for_each_online_cpu(cpu)
+			rcu_assign_pointer(per_cpu(softnet_data.net_dma, cpu), NULL);
+		unlock_cpu_hotplug();
+		return;
+	}
+
+	i = 0;
+	cpu = first_cpu(cpu_online_map);
+
+	rcu_read_lock();
+	list_for_each_entry(chan, &net_dma_client->channels, client_node) {
+		n = ((num_online_cpus() / net_dma_count)
+		   + (i < (num_online_cpus() % net_dma_count) ? 1 : 0));
+
+		while(n) {
+			per_cpu(softnet_data.net_dma, cpu) = chan;
+			cpu = next_cpu(cpu, cpu_online_map);
+			n--;
+		}
+		i++;
+	}
+	rcu_read_unlock();
+
+	unlock_cpu_hotplug();
+}
+
+/**
+ * netdev_dma_event - event callback for the net_dma_client
+ * @client: should always be net_dma_client
+ * @chan:
+ * @event:
+ */
+static void netdev_dma_event(struct dma_client *client, struct dma_chan *chan,
+	enum dma_event event)
+{
+	switch (event) {
+	case DMA_RESOURCE_ADDED:
+		net_dma_count++;
+		net_dma_rebalance();
+		break;
+	case DMA_RESOURCE_REMOVED:
+		net_dma_count--;
+		net_dma_rebalance();
+		break;
+	default:
+		break;
+	}
+}
+
+/**
+ * netdev_dma_regiser - register the networking subsystem as a DMA client
+ */
+static int __init netdev_dma_register(void)
+{
+	net_dma_client = dma_async_client_register(netdev_dma_event);
+	if (net_dma_client == NULL)
+		return -ENOMEM;
+
+	dma_async_client_chan_request(net_dma_client, num_online_cpus());
+	return 0;
+}
+
+#else
+static int __init netdev_dma_register(void) { return -ENODEV; }
+#endif /* CONFIG_NET_DMA */
 
 /*
  *	Initialize the DEV module. At boot time this walks the device list and
@@ -3258,6 +3358,8 @@ static int __init net_dev_init(void)
 		atomic_set(&queue->backlog_dev.refcnt, 1);
 	}
 
+	netdev_dma_register();
+
 	dev_boot_phase = 0;
 
 	open_softirq(NET_TX_SOFTIRQ, net_tx_action, NULL);

