Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbVLUFSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbVLUFSS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 00:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbVLUFSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 00:18:16 -0500
Received: from fmr17.intel.com ([134.134.136.16]:32223 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751111AbVLUFRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 00:17:42 -0500
Subject: [RFC][PATCH 2/5] I/OAT DMA support and TCP acceleration
From: Chris Leech <christopher.leech@intel.com>
To: lkml <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       "Ronciak, John" <john.ronciak@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Dec 2005 21:17:37 -0800
Message-Id: <1135142257.13781.19.camel@cleech-mobl>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
X-OriginalArrivalTime: 21 Dec 2005 05:17:41.0491 (UTC) FILETIME=[DDE6B430:01C605ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Setup the networking subsystem as a DMA client
Attempts to allocate per-CPU DMA channels

---
 dev.c |   97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 97 insertions(+)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -113,6 +113,7 @@
 #include <linux/wireless.h>		/* Note : will define WIRELESS_EXT */
 #include <net/iw_handler.h>
 #endif	/* CONFIG_NET_RADIO */
+#include <linux/dmaengine.h>
 #include <asm/current.h>
 
 /*
@@ -147,6 +148,12 @@ static DEFINE_SPINLOCK(ptype_lock);
 static struct list_head ptype_base[16];	/* 16 way hashed list */
 static struct list_head ptype_all;		/* Taps */
 
+#ifdef CONFIG_NET_DMA
+struct dma_client *net_dma_client;
+DEFINE_PER_CPU(struct dma_chan *, net_dma);
+static unsigned int net_dma_count;
+#endif
+
 /*
  * The @dev_base list is protected by @dev_base_lock and the rtln
  * semaphore.
@@ -1708,6 +1715,9 @@ static void net_rx_action(struct softirq
 	unsigned long start_time = jiffies;
 	int budget = netdev_budget;
 	void *have;
+#ifdef CONFIG_NET_DMA
+	struct dma_chan *chan;
+#endif
 
 	local_irq_disable();
 
@@ -1739,6 +1749,14 @@ static void net_rx_action(struct softirq
 		}
 	}
 out:
+#ifdef CONFIG_NET_DMA
+	/*
+	 * There may not be any more sk_buffs comming right now, so push
+	 * any pending DMA copies to hardware
+	 */
+	list_for_each_entry(chan, &net_dma_client->channels, client_node)
+		dma_async_memcpy_issue_pending(chan);
+#endif
 	local_irq_enable();
 	return;
 
@@ -3171,6 +3189,83 @@ static int dev_cpu_callback(struct notif
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
+#ifdef CONFIG_NET_DMA
+/**
+ * net_dma_reblance -
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
+			per_cpu(net_dma, cpu) = NULL;
+		unlock_cpu_hotplug();
+		return;
+	}
+
+	i = 0;
+	cpu = first_cpu(cpu_online_map);
+
+	list_for_each_entry(chan, &net_dma_client->channels, client_node) {
+		/* cpus_clear(chan->cpumask); */
+		n = ((num_online_cpus() / net_dma_count) + (i < (num_online_cpus() % net_dma_count) ? 1 : 0));
+
+		while(n) {
+			per_cpu(net_dma, cpu) = chan;
+			/* cpu_set(cpu, chan->cpumask); */
+			cpu = next_cpu(cpu, cpu_online_map);
+			n--;
+		}
+		i++;
+	}
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
+static void netdev_dma_event(struct dma_client *client, struct dma_chan *chan, enum dma_event event)
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
+ * netdev_dma_register - register the networking subsystem as a DMA client
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
@@ -3224,6 +3319,8 @@ static int __init net_dev_init(void)
 		atomic_set(&queue->backlog_dev.refcnt, 1);
 	}
 
+	netdev_dma_register();
+
 	dev_boot_phase = 0;
 
 	open_softirq(NET_TX_SOFTIRQ, net_tx_action, NULL);

