Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262998AbTC0P15>; Thu, 27 Mar 2003 10:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263002AbTC0P15>; Thu, 27 Mar 2003 10:27:57 -0500
Received: from fmr01.intel.com ([192.55.52.18]:14024 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S262998AbTC0P1K>;
	Thu, 27 Mar 2003 10:27:10 -0500
Date: Thu, 27 Mar 2003 17:38:02 +0200 (IST)
From: shmulik.hen@intel.com
X-X-Sender: hshmulik@jrslxjul4.npdj.intel.com
Reply-To: shmulik.hen@intel.com
To: bond-devel <bonding-devel@lists.sourceforge.net>,
       bond-announce <bonding-announce@lists.sourceforge.net>,
       linux-net <linux-net@vger.kernel.org>,
       linux-netdev <netdev@oss.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: [Bonding][patch] Adding Transmit load balancing mode to bonding
Message-ID: <Pine.LNX.4.44.0303271705580.7106-100000@jrslxjul4.npdj.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for Transmit Load Balancing policy. This mode
provides load sharing without any special support or configuration from
the switch (Ether-Channel, etc.). Every active slave with the highest
speed in the bond transmits (using its unique hw address) while the
current primary slave receives. If the "receiving" slave fails, another
slave takes over the MAC address of the failed receiving slave in order
not to confuse the switch. Balancing is connection oriented (e.g. by IPv4
destination address) so packet order is always kept. Traffic is rebalanced
periodically (every 10 sec by default) while taking into account previous
load on each slave. Some types of protocols (e.g. ARP) are always sent
through the current slave.
 
This patch is against bonding 2.4.20-20030317 and relies on the
application of the previous set of 9 patches (submitted on March 20th)  
because they contain all the features required for this mode's operation.


diff -Nuarp linux-2.4.20-bonding-20030317/Documentation/networking/bonding.txt linux-2.4.20-bonding-20030317-devel/Documentation/networking/bonding.txt
--- linux-2.4.20-bonding-20030317/Documentation/networking/bonding.txt	2003-03-27 17:00:05.000000000 +0200
+++ linux-2.4.20-bonding-20030317-devel/Documentation/networking/bonding.txt	2003-03-27 17:00:06.000000000 +0200
@@ -209,9 +209,9 @@ max_bonds
 
 mode
 
-	Specifies one of four bonding policies. The default is
-round-robin (balance-rr).  Possible values are (you can use either the
-text or numeric option):
+	Specifies one of four bonding policies. The default is 
+	round-robin (balance-rr).  Possible values are (you can use
+	either the text or numeric option):
  
 	balance-rr or 0
 		Round-robin policy: Transmit in a sequential order
@@ -226,7 +226,7 @@ text or numeric option):
 		to avoid confusing the switch.  This mode provides
 		fault tolerance.
  
-        balance-xor or 2
+	balance-xor or 2
 		XOR policy: Transmit based on [(source MAC address
 		XOR'd with destination MAC address) modula slave
 		count]. This selects the same slave for each
@@ -237,10 +237,22 @@ text or numeric option):
 		Broadcast policy: transmits everything on all slave
 		interfaces. This mode provides fault tolerance.
 
-    802.3ad or 4
-        IEEE 802.3ad Dynamic link aggregation. Creates aggregation
-        groups that share the same speed and duplex settings.
-        Transmits and receives on all slaves in the active aggregator.
+	802.3ad or 4
+		IEEE 802.3ad Dynamic link aggregation. Creates aggregation
+		groups that share the same speed and duplex settings.
+		Transmits and receives on all slaves in the active aggregator.
+		This mode requires Ethtool support in the base drivers for
+		retrieving the speed of each slave. 
+	
+	tlb or 5
+		Adaptive transmit load balancing: channel bonding that does
+		not require any special switch support. The outgoing traffic
+		is distributed according to the current load (computed relative
+		to the speed) on each slave. Incoming traffic is received by
+		the current slave. If the receiving slave fails, another slave
+		takes over the MAC address of the failed receiving slave.
+		This mode requires Ethtool support in the base drivers for
+		retrieving the speed of each slave. 
 
 miimon
  
@@ -550,7 +562,7 @@ Frequently Asked Questions
 	* Cisco 6500 series (look for lacp).
 	* Foundry Big Iron 4000
 
-	In active-backup mode, it should work with any Layer-II switche.
+	In active-backup and tlb modes, it should work with any Layer-II switch.
 
 
 8.  Where does a bonding device get its MAC address from?
@@ -605,7 +617,12 @@ Frequently Asked Questions
 
 	802.3ad, based on XOR but distributes traffic among all interfaces
 	in the active aggregator.
-
+	
+	Transmit load balancing balances the traffic according to the
+	current load on each slave. The balancing is clients based and the 
+	least loaded is slave is selected for a new client. The load of each
+	slave is calculated relative to its speed and enables load balancing
+	in mixed speed teams.    
 
 High Availability
 =================
@@ -841,10 +858,6 @@ The main limitations are :
     Use the arp_interval/arp_ip_target parameters to count incoming/outgoing
     frames.  
 
-  - A Transmit Load Balancing policy is not currently available. This mode 
-    allows every slave in the bond to transmit while only one receives. If 
-    the "receiving" slave fails, another slave takes over the MAC address of 
-    the failed receiving slave.
 
 
 Resources and Links
diff -Nuarp linux-2.4.20-bonding-20030317/drivers/net/bonding/bond_alb.c linux-2.4.20-bonding-20030317-devel/drivers/net/bonding/bond_alb.c
--- linux-2.4.20-bonding-20030317/drivers/net/bonding/bond_alb.c	1970-01-01 02:00:00.000000000 +0200
+++ linux-2.4.20-bonding-20030317-devel/drivers/net/bonding/bond_alb.c	2003-03-27 17:00:06.000000000 +0200
@@ -0,0 +1,709 @@
+/****************************************************************************
+   Copyright(c) 1999 - 2003 Intel Corporation. All rights reserved.
+
+   This program is free software; you can redistribute it and/or modify it
+   under the terms of the GNU General Public License as published by the Free
+   Software Foundation; either version 2 of the License, or (at your option)
+   any later version.
+
+   This program is distributed in the hope that it will be useful, but WITHOUT
+   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+   FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+   more details.
+
+   You should have received a copy of the GNU General Public License along with
+   this program; if not, write to the Free Software Foundation, Inc., 59
+   Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+
+   The full GNU General Public License is included in this distribution in the
+   file called LICENSE.
+*****************************************************************************/
+
+#include <linux/skbuff.h>
+#include <linux/netdevice.h>
+#include <linux/pkt_sched.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/timer.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/if_arp.h>
+#include <linux/if_ether.h>
+#include <linux/if_bonding.h>
+#include <net/ipx.h>
+#include <net/arp.h>
+#include <asm/byteorder.h>
+#include "bonding.h"
+#include "bond_alb.h"
+
+
+#define ALB_TIMER_TICKS_PER_SEC	    10 //should be a divisor of HZ
+#define BOND_TLB_REBALANCE_INTERVAL 10 //seconds (used for division - never set to zero !!!)
+#define BOND_ALB_LP_INTERVAL        1  //seconds
+
+#define BOND_TLB_REBALANCE_TICKS_INTERVAL (BOND_TLB_REBALANCE_INTERVAL*ALB_TIMER_TICKS_PER_SEC)
+#define BOND_ALB_LP_TICKS_INTERVAL (BOND_ALB_LP_INTERVAL*ALB_TIMER_TICKS_PER_SEC)
+
+#define TLB_HASH_TABLE_SIZE 256	// The size of the clients hash table.
+				// Note that this value MUST NOT be smaller
+				// because the key to the hash table is of BYTE!
+
+
+#define TLB_NULL_INDEX		0xffffffff
+#define MAX_LP_RETRY		3
+
+#pragma pack(1)
+struct learning_pkt {
+	u8 mac_dst[ETH_ALEN];
+	u8 mac_src[ETH_ALEN];
+	u16 type;
+	u8 padding[ETH_ZLEN - (2*ETH_ALEN + 2)];
+};
+
+#pragma pack()
+
+static void alb_send_learning_packets(struct slave *slave, u8 mac_addr[]);
+static void alb_set_mac_addr(struct slave *slave, u8 addr[]);
+static void alb_swap_mac_addr(struct bonding *bond, struct slave *slave1, struct slave *slave2);
+static void alb_change_hw_addr_on_detach(struct bonding *bond, struct slave *slave);
+static void alb_handle_addr_collision_on_attach(struct bonding *bond, struct slave *slave);
+static struct slave* tlb_choose_channel(struct bonding *bond, u32 hash_index, u32 skb_len);
+static struct slave* tlb_get_least_loaded_slave(struct bonding *bond);
+
+static inline void _lock_tx_hashtbl(struct bonding *bond)
+{
+	spin_lock(&(BOND_ALB_INFO(bond).tx_hashtbl_lock));
+}
+
+static inline void _unlock_tx_hashtbl(struct bonding *bond)
+{
+	spin_unlock(&(BOND_ALB_INFO(bond).tx_hashtbl_lock));
+}
+
+//Caller must hold tx_hashtbl lock
+static inline void tlb_init_table_entry(struct bonding *bond, u8 index, u8 save_load)
+{
+	struct tlb_client_info *entry;
+
+	if (BOND_ALB_INFO(bond).tx_hashtbl == NULL) {
+		return;
+	}
+
+	entry = &(BOND_ALB_INFO(bond).tx_hashtbl[index]);
+
+	if (save_load) {
+		entry->load_history = 1 + entry->tx_bytes / BOND_TLB_REBALANCE_INTERVAL;
+	} else {
+		entry->load_history = 1;
+	}
+	entry->tx_slave = NULL;
+	entry->tx_bytes = 0;
+	entry->next = TLB_NULL_INDEX;
+	entry->prev = TLB_NULL_INDEX;
+}
+
+static inline void tlb_init_slave(struct slave *curr_slave, u8 save_load)
+{
+	struct tlb_slave_info *slave_info = &(SLAVE_TLB_INFO(curr_slave));
+
+	if (save_load) {
+		slave_info->load = slave_info->rx_bytes / BOND_TLB_REBALANCE_INTERVAL;
+	} else {
+		slave_info->load = 0;
+	}
+	slave_info->head = TLB_NULL_INDEX;
+	slave_info->rx_bytes = 0;
+}
+
+//must be locked with the bond read lock
+static inline void tlb_clear_slave(struct bonding *bond, struct slave *slave)
+{
+	struct tlb_client_info *tx_hash_table = NULL;
+	u32 index, next_index;
+
+	if (!slave) {
+		return;
+	}
+
+	//clear slave from tx_hashtbl
+	_lock_tx_hashtbl(bond);
+	tx_hash_table = BOND_ALB_INFO(bond).tx_hashtbl;
+
+	if (tx_hash_table) {
+		index = SLAVE_TLB_INFO(slave).head;
+		while (index != TLB_NULL_INDEX) {
+			next_index = tx_hash_table[index].next;
+			tlb_init_table_entry(bond, index, 1);
+			index = next_index;
+		}
+	}
+	_unlock_tx_hashtbl(bond);
+
+	tlb_init_slave(slave, 1);
+}
+
+static inline u8 _simple_hash(u8 *hash_start, int hash_size)
+{
+	int i;
+	u8 hash = 0;
+
+	for (i=0; i<hash_size; i++) {
+		hash ^= hash_start[i];
+	}
+
+	return hash;
+}
+
+int bond_alb_initialize(struct bonding *bond)
+{
+	struct alb_bond_info *bond_info = &(BOND_ALB_INFO(bond));
+	struct slave *slave = NULL;
+	unsigned long flags;
+	int i;
+	size_t size;
+
+#if(TLB_HASH_TABLE_SIZE != 256)
+	// Key to the hash table is byte wide. Check the size!
+	#error Hash Table size is wrong.
+#endif
+
+	spin_lock_init(&(bond_info->tx_hashtbl_lock));
+
+	_lock_tx_hashtbl(bond);
+	if (bond_info->tx_hashtbl != NULL) {
+		printk (KERN_ERR "%s: TLB hash table is not NULL\n", bond->device->name);
+		_unlock_tx_hashtbl(bond);
+		return -1;
+	}
+
+	size = TLB_HASH_TABLE_SIZE * sizeof(struct tlb_client_info);
+	bond_info->tx_hashtbl = kmalloc(size, GFP_KERNEL);
+	if (bond_info->tx_hashtbl == NULL) {
+		printk (KERN_ERR "%s: Failed to allocate TLB hash table\n", bond->device->name);
+		_unlock_tx_hashtbl(bond);
+		return -1;
+	}
+
+	for (i=0; i<TLB_HASH_TABLE_SIZE; i++) {
+		tlb_init_table_entry(bond, i, 0);
+	}
+	_unlock_tx_hashtbl(bond);
+
+	//initialize slave's lb info
+	read_lock_irqsave(&bond->lock, flags);
+	slave = bond->next;
+	while (slave && (slave != (struct slave *)bond)) {
+		tlb_init_slave(slave, 0);
+		slave = bond_get_next_slave(bond, slave);
+	}
+	read_unlock_irqrestore(&bond->lock, flags);
+
+	return 0;
+}
+
+int bond_alb_deinitialize(struct bonding *bond)
+{
+	struct alb_bond_info *bond_info = &(BOND_ALB_INFO(bond));
+
+	_lock_tx_hashtbl(bond);
+	if (bond_info->tx_hashtbl == NULL) {
+		_unlock_tx_hashtbl(bond);
+		return 0;
+	}
+	kfree(bond_info->tx_hashtbl);
+	bond_info->tx_hashtbl = NULL;
+	_unlock_tx_hashtbl(bond);
+
+	return 0;
+}
+
+int bond_alb_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct bonding *bond = (struct bonding *) dev->priv;
+	struct ethhdr *eth_data = (struct ethhdr *)skb->data;
+	struct alb_bond_info *bond_info = &(BOND_ALB_INFO(bond));
+	struct slave *tx_slave = NULL;
+	unsigned long flags;
+	char do_tx_balance = 1;
+	int hash_size = 0;
+	u32 hash_index = 0;
+	u8 *hash_start = NULL;
+	u8 mac_bcast[ETH_ALEN] = {0xff,0xff,0xff,0xff,0xff,0xff};
+
+	if (!IS_UP(dev)) { /* bond down */
+		dev_kfree_skb(skb);
+		return 0;
+	}
+
+	//make sure that the current_slave and the slaves list do not change during tx
+	read_lock_irqsave(&bond->lock, flags);
+
+	if (bond->slave_cnt == 0) {
+		/* no suitable interface, frame not sent */
+		dev_kfree_skb(skb);
+		read_unlock_irqrestore(&bond->lock, flags);
+		return 0;
+	}
+
+	read_lock(&bond->ptrlock);
+
+	switch (ntohs(skb->protocol)) {
+	case ETH_P_IP:
+		if ((memcmp(eth_data->h_dest, mac_bcast, ETH_ALEN) == 0) ||
+		    (skb->nh.iph->daddr == 0xffffffff)) {
+			do_tx_balance = 0;
+			break;
+		}
+		hash_start = (char*)&(skb->nh.iph->daddr);
+		hash_size = 4;
+		break;
+
+	case ETH_P_IPV6:
+		if (memcmp(eth_data->h_dest, mac_bcast, ETH_ALEN) == 0) {
+			do_tx_balance = 0;
+			break;
+		}
+
+		hash_start = (char*)&(skb->nh.ipv6h->daddr);
+		hash_size = 16;
+		break;
+
+	case ETH_P_IPX:
+		if (skb->nh.ipxh->ipx_checksum != __constant_htons(IPX_NO_CHECKSUM)) {
+			do_tx_balance = 0;
+			break;
+		}
+
+		if (skb->nh.ipxh->ipx_type != __constant_htons(IPX_TYPE_NCP)) {
+			do_tx_balance = 0;
+			break;
+		}
+
+		hash_start = (char*)eth_data->h_dest;
+		hash_size = ETH_ALEN;
+		break;
+
+	default:
+		do_tx_balance = 0;
+		break;
+	}
+
+	if (do_tx_balance) {
+		hash_index = _simple_hash(hash_start, hash_size);
+		tx_slave = tlb_choose_channel(bond, hash_index, skb->len);
+	}
+
+	if (!tx_slave) {
+		//unbalanced or unassigned, send through primary
+		tx_slave = bond->current_slave;
+		bond_info->unbalanced_load += skb->len;
+	}
+
+	if (tx_slave && SLAVE_IS_OK(tx_slave)) {
+		skb->dev = tx_slave->dev;
+		if (tx_slave != bond->current_slave) {
+			memcpy(eth_data->h_source, tx_slave->dev->dev_addr, ETH_ALEN);
+		}
+		dev_queue_xmit(skb);
+	} else {
+		// no suitable interface, frame not sent
+		if (tx_slave) {
+			tlb_clear_slave(bond, tx_slave);
+		}
+		dev_kfree_skb(skb);
+		//printk (KERN_ERR "no suitable channel found - freeing packet\n");
+	}
+
+	read_unlock(&bond->ptrlock);
+	read_unlock_irqrestore(&bond->lock, flags);
+	return 0;
+}
+
+void bond_alb_monitor(struct bonding *bond)
+{
+	struct alb_bond_info *bond_info = &(BOND_ALB_INFO(bond));
+	struct slave *slave = NULL;
+	unsigned long flags;
+
+	read_lock_irqsave(&bond->lock, flags);
+
+	if (bond->next == (struct slave*)bond) {
+		bond_info->tx_rebalance_counter = 0;
+		bond_info->lp_counter = 0;
+		goto out;
+	}
+
+	bond_info->tx_rebalance_counter++;
+	bond_info->lp_counter++;
+
+	//send learning packets
+	if (bond_info->lp_counter >= BOND_ALB_LP_TICKS_INTERVAL) {
+		slave = bond->next;
+		for (; slave && (slave != (struct slave *)bond); slave = bond_get_next_slave(bond, slave)) {
+			alb_send_learning_packets(slave, slave->dev->dev_addr);
+		}
+		bond_info->lp_counter = 0;
+	}
+
+	//rebalance tx traffic
+	if (bond_info->tx_rebalance_counter >= BOND_TLB_REBALANCE_TICKS_INTERVAL) {
+		slave = bond->next;
+		for (; slave && (slave != (struct slave *)bond); slave = bond_get_next_slave(bond, slave)) {
+			tlb_clear_slave(bond, slave);
+			read_lock(&bond->ptrlock);
+			if (slave == bond->current_slave) {
+				SLAVE_TLB_INFO(slave).load =
+					bond_info->unbalanced_load / BOND_TLB_REBALANCE_INTERVAL;
+				bond_info->unbalanced_load = 0;
+			}
+			read_unlock(&bond->ptrlock);
+		}
+		bond_info->tx_rebalance_counter = 0;
+	}
+
+out:
+	read_unlock_irqrestore(&bond->lock, flags);
+	// re-arm the timer
+	mod_timer(&(bond_info->alb_timer), jiffies + (HZ/ALB_TIMER_TICKS_PER_SEC));
+}
+
+void bond_alb_init_slave(struct bonding *bond, struct slave *slave)
+{
+	alb_set_mac_addr(slave, slave->perm_hwaddr);
+	tlb_init_slave(slave, 0);
+
+	if (bond->slave_cnt > 1) {
+		alb_handle_addr_collision_on_attach(bond, slave);
+	}
+
+	//order a rebalance ASAP
+	bond->alb_info.tx_rebalance_counter = BOND_TLB_REBALANCE_TICKS_INTERVAL;
+}
+
+//Must hold bond->lock for write
+//slave has already been detached from the list
+void bond_alb_deinit_slave(struct bonding *bond, struct slave *slave)
+{
+	if (bond->slave_cnt > 1) {
+		alb_change_hw_addr_on_detach(bond, slave);
+	}
+
+	tlb_clear_slave(bond, slave);
+}
+
+void bond_alb_handle_link_change(struct bonding *bond, struct slave *slave, char link)
+{
+	struct alb_bond_info *bond_info = &(BOND_ALB_INFO(bond));
+	if (slave == (struct slave *)bond) {
+		return;
+	}
+
+	if (link == BOND_LINK_FAIL) {
+		tlb_clear_slave(bond, slave);
+	}
+
+	if (link == BOND_LINK_UP) {
+		//order a rebalance ASAP
+		bond_info->tx_rebalance_counter = BOND_TLB_REBALANCE_TICKS_INTERVAL;
+	}
+}
+
+//Must hold write ptr lock
+struct slave* bond_alb_handle_active_change(struct bonding *bond, struct slave *new_slave)
+{
+	struct slave *old_slave=NULL, *swap_slave=NULL;
+
+	if (!new_slave || (bond->slave_cnt == 0)) {
+		return NULL;
+	}
+
+	swap_slave = old_slave = bond->current_slave;
+
+	if (old_slave == new_slave) {
+		return new_slave;
+	}
+
+	if (!old_slave) {
+		//find slave that is holding the bond's mac address
+		swap_slave = bond->next;
+		for (; swap_slave; swap_slave = bond_get_next_slave(bond, swap_slave)) {
+			if (memcmp(swap_slave->dev->dev_addr, bond->device->dev_addr, ETH_ALEN) == 0) {
+				break;
+			}
+		}
+	}
+
+	if (swap_slave) {
+		//swap mac address
+		alb_swap_mac_addr(bond, swap_slave, new_slave);
+	} else {
+		//set the new_slave to the bond mac address
+		alb_set_mac_addr(new_slave, bond->device->dev_addr);
+		//fasten bond mac on new current slave
+		alb_send_learning_packets(new_slave, bond->device->dev_addr);
+	}
+
+	return new_slave;
+}
+
+static void alb_send_learning_packets(struct slave *slave, u8 mac_addr[])
+{
+	struct sk_buff *skb = NULL;
+	struct learning_pkt pkt;
+	char *data = NULL;
+	int i;
+	unsigned int size = sizeof(struct learning_pkt);
+
+	memset(&pkt, 0, size);
+	memcpy(pkt.mac_dst, mac_addr, ETH_ALEN);
+	memcpy(pkt.mac_src, mac_addr, ETH_ALEN);
+	pkt.type = __constant_htons(ETH_P_LOOP);
+
+	for (i=0; i < MAX_LP_RETRY; i++) {
+		skb = NULL;
+		skb = dev_alloc_skb(size);
+		if (!skb) {
+			return;
+		}
+
+		data = skb_put(skb, size);
+		memcpy(data, &pkt, size);
+		skb->mac.raw = data;
+		skb->nh.raw = data + ETH_HLEN;
+		skb->protocol = pkt.type;
+		skb->priority = TC_PRIO_CONTROL;
+		skb->dev = slave->dev;
+		dev_queue_xmit(skb);
+	}
+}
+
+static void alb_set_mac_addr(struct slave *slave, u8 addr[])
+{
+	if (!slave) {
+		return;
+	}
+
+	memcpy(slave->dev->dev_addr, addr, ETH_ALEN);
+}
+
+//must be called under bond lock (must be sure that slaves cannot be removed during function exec)
+//and current primary lock
+static void alb_swap_mac_addr(struct bonding *bond, struct slave *slave1, struct slave *slave2)
+{
+	u8 tmp_mac_addr[ETH_ALEN];
+
+	if (!slave1 || !slave2) {
+		return;
+	}
+
+	memcpy(tmp_mac_addr, slave1->dev->dev_addr, ETH_ALEN);
+	alb_set_mac_addr(slave1, slave2->dev->dev_addr);
+	alb_set_mac_addr(slave2, tmp_mac_addr);
+
+	//fasten the change in the switch
+	if (SLAVE_IS_OK(slave1)) {
+		alb_send_learning_packets(slave1, slave1->dev->dev_addr);
+	}
+	if (SLAVE_IS_OK(slave2)) {
+		alb_send_learning_packets(slave2, slave2->dev->dev_addr);
+	}
+}
+
+/**
+ * alb_change_hw_addr_on_detach 
+ * @bond: bonding we're working on
+ * @slave: the slave that was just detached
+ *
+ * We assume that @slave was already detached from the slave list.
+ * 
+ * If @slave's permanent hw address is different both from its current address
+ * and from @bond's address, then somewhere in the bond there's a slave that has
+ * @slave's permanet address as its current address. We'll make sure that that 
+ * slave no longer uses @slave's permanent address.
+ * 
+ * Assumes bond->lock is held for writing. 
+ */
+static void alb_change_hw_addr_on_detach(struct bonding *bond, struct slave *slave)
+{
+	struct slave *tmp_slave;
+	int perm_curr_diff;
+	int perm_bond_diff;
+
+	perm_curr_diff = memcmp(slave->perm_hwaddr,
+				slave->dev->dev_addr,
+				ETH_ALEN);
+	perm_bond_diff = memcmp(slave->perm_hwaddr,
+				bond->device->dev_addr,
+				ETH_ALEN);
+	if (perm_curr_diff && perm_bond_diff) {
+		tmp_slave = bond->next;
+		for (; tmp_slave; tmp_slave = bond_get_next_slave(bond, tmp_slave)) {
+			if (memcmp(slave->perm_hwaddr,
+				   tmp_slave->dev->dev_addr,
+				   ETH_ALEN) == 0) {
+				break;
+			}
+		}
+		if (tmp_slave) {
+			alb_set_mac_addr(tmp_slave, slave->dev->dev_addr);
+			alb_send_learning_packets(tmp_slave, slave->dev->dev_addr);
+		}
+	}
+}
+
+/**
+ * alb_handle_addr_collision_on_attach
+ * @bond: bonding we're working on
+ * @slave: the slave that was just attached
+ *
+ * If the permanent hw address of @slave is @bond's hw address, we need to find
+ * a different hw address to give @slave, that isn't in use by any other slave
+ * in the bond. This address must be, of course, one of the premanent addresses
+ * of the other slaves.
+ * 
+ * We go over the slave list, and for each slave there we compare its permanent
+ * hw address with the current address of all the other slaves. If no match was
+ * found, then we've found a slave with a permanent address that isn't used by
+ * any other slave in the bond, so we can assign it to @slave. 
+ * 
+ * Assumes bond->lock is held for writing. 
+ */
+static void alb_handle_addr_collision_on_attach(struct bonding *bond, struct slave *slave)
+{
+	struct slave *tmp_slave1, *tmp_slave2;
+
+	if (memcmp(slave->perm_hwaddr, bond->device->dev_addr, ETH_ALEN)) {
+		return;
+	}
+
+	tmp_slave1 = bond->next;
+	for (; tmp_slave1; tmp_slave1 = bond_get_next_slave(bond, tmp_slave1)) {
+		if (tmp_slave1 == slave) {
+			continue;
+		}
+
+		tmp_slave2 = bond->next;
+		for (; tmp_slave2; tmp_slave2 = bond_get_next_slave(bond, tmp_slave2)) {
+			if (tmp_slave2 == slave) {
+				continue;
+			}
+
+			if (!memcmp(tmp_slave1->perm_hwaddr,
+				    tmp_slave2->dev->dev_addr,
+				    ETH_ALEN)) {
+
+				break;
+			}
+		}
+
+		if (!tmp_slave2) {
+			// no slave has tmp_slave1's perm addr as its curr addr
+			break;
+		}
+	}
+
+	if (tmp_slave1) {
+		alb_set_mac_addr(slave, tmp_slave1->perm_hwaddr);
+
+		printk(KERN_WARNING "bonding: Warning: the hw address " 
+		       "of slave %s is not unique; "
+		       "giving it the hw address of %s\n",
+		       slave->dev->name, tmp_slave1->dev->name);
+	} else {
+		printk(KERN_CRIT "bonding: Error: the hw address " 
+		       "of slave %s is not unique; "
+		       "couldn't find a slave with a free hw "
+		       "address to give it (this should not have "
+		       "happened)\n", slave->dev->name);
+		printk(KERN_CRIT "Communications may become unstable "
+		       "(confused switch). You might want to remove "
+		       "this slave\n");
+	}
+}
+
+//Must hold bond->lock (read)
+struct slave* tlb_choose_channel(struct bonding *bond, u32 hash_index, u32 skb_len)
+{
+	struct alb_bond_info *bond_info = &(BOND_ALB_INFO(bond));
+	struct tlb_client_info *hash_table = NULL;
+	struct slave *assigned_slave = NULL;
+
+	_lock_tx_hashtbl(bond);
+
+	hash_table = bond_info->tx_hashtbl;
+	if (hash_table == NULL) {
+		printk (KERN_ERR "%s: TLB hash table is NULL\n", bond->device->name);
+		_unlock_tx_hashtbl(bond);
+		return NULL;
+	}
+
+	assigned_slave = hash_table[hash_index].tx_slave;
+	if (!assigned_slave) {
+		assigned_slave = tlb_get_least_loaded_slave(bond);
+
+		if (assigned_slave) {
+			struct tlb_slave_info *slave_info = &(SLAVE_TLB_INFO(assigned_slave));
+			u32 next_index = slave_info->head;
+
+			hash_table[hash_index].tx_slave = assigned_slave;
+			hash_table[hash_index].next = next_index;
+			hash_table[hash_index].prev = TLB_NULL_INDEX;
+			hash_table[hash_index].tx_bytes += skb_len;
+
+			if (next_index != TLB_NULL_INDEX) {
+				hash_table[next_index].prev = hash_index;
+			}
+
+			slave_info->head = hash_index;
+			slave_info->load += hash_table[hash_index].load_history;
+		}
+	}
+
+	_unlock_tx_hashtbl(bond);
+
+	return assigned_slave;
+}
+
+//Must hold bond->lock
+static struct slave* tlb_get_least_loaded_slave(struct bonding *bond)
+{
+	struct slave *slave = bond->next;
+	struct slave *least_loaded;
+	u32 curr_gap, max_gap;
+
+	if (slave == (struct slave *)bond) {
+		return NULL;
+	}
+	
+	// Find the first enabled slave
+	while (slave && (slave != (struct slave *)bond)) {
+		if (SLAVE_IS_OK(slave)) {
+			break;
+		}
+		slave = bond_get_next_slave(bond, slave);
+	}
+
+	if (!slave) {
+		return NULL;
+	}
+
+	least_loaded = slave;
+	slave = bond_get_next_slave(bond, slave);
+	max_gap = (least_loaded->speed * 1000000) -
+		  (SLAVE_TLB_INFO(least_loaded).load * 8);
+
+	while (slave && (slave != (struct slave *)bond)) {
+		if (SLAVE_IS_OK(slave)) {
+			curr_gap = (slave->speed * 1000000) -
+				   (SLAVE_TLB_INFO(slave).load * 8);
+			if (max_gap < curr_gap) {
+				least_loaded = slave;
+				max_gap = curr_gap;
+			}
+		}
+		slave = bond_get_next_slave(bond, slave);
+	}
+
+	return least_loaded;
+}
+
diff -Nuarp linux-2.4.20-bonding-20030317/drivers/net/bonding/bond_alb.h linux-2.4.20-bonding-20030317-devel/drivers/net/bonding/bond_alb.h
--- linux-2.4.20-bonding-20030317/drivers/net/bonding/bond_alb.h	1970-01-01 02:00:00.000000000 +0200
+++ linux-2.4.20-bonding-20030317-devel/drivers/net/bonding/bond_alb.h	2003-03-27 17:00:06.000000000 +0200
@@ -0,0 +1,72 @@
+/****************************************************************************
+   Copyright(c) 1999 - 2003 Intel Corporation. All rights reserved.
+
+   This program is free software; you can redistribute it and/or modify it
+   under the terms of the GNU General Public License as published by the Free
+   Software Foundation; either version 2 of the License, or (at your option)
+   any later version.
+
+   This program is distributed in the hope that it will be useful, but WITHOUT
+   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+   FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+   more details.
+
+   You should have received a copy of the GNU General Public License along with
+   this program; if not, write to the Free Software Foundation, Inc., 59
+   Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+
+   The full GNU General Public License is included in this distribution in the
+   file called LICENSE.
+*****************************************************************************/
+
+#ifndef __BOND_ALB_H__
+#define __BOND_ALB_H__
+
+#include <linux/if_ether.h>
+
+
+#define BOND_ALB_INFO(bond)   ((bond)->alb_info)
+#define SLAVE_TLB_INFO(slave) ((slave)->tlb_info)
+
+struct tlb_client_info {
+	struct slave *tx_slave;	//A pointer to slave used for transmit packets to a Client
+				//that the Hash function gave this entry index.
+	u32 tx_bytes;		//Each Client acumulates the BytesTx that were tranmitted to it and
+				//after each CallBack the LoadHistory gets it devided to the balanceinterval
+	u32 load_history;	//This field contains the amount of Bytes that were transmitted to
+				//this client by the server on the previous balance interval in Bps.
+	u32 next;		//The next Hash table entry index, assigned to use the same adapter
+				//for transmit.
+	u32 prev;		//The previous Hash table entry index, assigned to use the same
+};
+
+struct tlb_slave_info {
+	u32 head;	// Index to the head of the bi-directional clients
+			// hash table entries list. The entries in the list
+			// are the entries that were assigned to use this
+			// slave for transmit.
+	u32 rx_bytes;	// The number of bytes received through this adapter.
+	u32 load;	// Each slave sums the loadHistory of all clients assigned to it
+	u8 rlb_promisc;	//slave is set to promiscuous if slave->dev->dev_addr != hw mac address
+};
+
+struct alb_bond_info {
+	struct timer_list       alb_timer;
+	struct tlb_client_info  *tx_hashtbl; //Dynamically allocated
+	spinlock_t              tx_hashtbl_lock;
+	u32                     unbalanced_load;
+	int                     tx_rebalance_counter;
+	int                     lp_counter;
+};
+
+int bond_alb_initialize(struct bonding *bond);
+int bond_alb_deinitialize(struct bonding *bond);
+int bond_alb_xmit(struct sk_buff *skb, struct net_device *dev);
+void bond_alb_monitor(struct bonding *bond);
+void bond_alb_init_slave(struct bonding *bond, struct slave *slave);
+void bond_alb_deinit_slave(struct bonding *bond, struct slave *slave);
+void bond_alb_handle_link_change(struct bonding *bond, struct slave *slave, char link);
+struct slave* bond_alb_handle_active_change(struct bonding *bond, struct slave *new_slave);
+
+#endif //__BOND_ALB_H__
+
diff -Nuarp linux-2.4.20-bonding-20030317/drivers/net/bonding/bonding.h linux-2.4.20-bonding-20030317-devel/drivers/net/bonding/bonding.h
--- linux-2.4.20-bonding-20030317/drivers/net/bonding/bonding.h	2003-03-27 17:00:05.000000000 +0200
+++ linux-2.4.20-bonding-20030317-devel/drivers/net/bonding/bonding.h	2003-03-27 17:00:06.000000000 +0200
@@ -23,6 +23,7 @@
 #include <linux/timer.h>
 #include <linux/proc_fs.h>
 #include "bond_3ad.h"
+#include "bond_alb.h"
 
 #ifdef BONDING_DEBUG
 
@@ -67,6 +68,7 @@ typedef struct slave {
 	u8     duplex;
 	u8     perm_hwaddr[ETH_ALEN];
 	struct ad_slave_info ad_info; // HUGE struct. maybe alloc dynamically
+	struct tlb_slave_info tlb_info;
 } slave_t;
 
 /*
@@ -99,6 +101,7 @@ typedef struct bonding {
 	struct dev_mc_list *mc_list;
 	unsigned short flags;
 	struct ad_bond_info ad_info;
+	struct alb_bond_info alb_info;
 } bonding_t;
 
 void bond_set_slave_active_flags(slave_t *slave);
diff -Nuarp linux-2.4.20-bonding-20030317/drivers/net/bonding/bond_main.c linux-2.4.20-bonding-20030317-devel/drivers/net/bonding/bond_main.c
--- linux-2.4.20-bonding-20030317/drivers/net/bonding/bond_main.c	2003-03-27 17:00:05.000000000 +0200
+++ linux-2.4.20-bonding-20030317-devel/drivers/net/bonding/bond_main.c	2003-03-27 17:00:06.000000000 +0200
@@ -324,6 +324,14 @@
  *		Tsippy Mendelson <tsippy.mendelson at intel dot com> and
  *		Shmulik Hen <shmulik.hen at intel dot com>
  *	- Added support for IEEE 802.3ad Dynamic link aggregatoin mode.
+ *
+ * 2003/03/27 - Amir Noam <amir.noam at intel dot com>,
+ *		Tsippy Mendelson <tsippy.mendelson at intel dot com> and
+ *		Shmulik Hen <shmulik.hen at intel dot com>
+ *	- Added support for Transmit load balancing mode.
+ *	- Concentrate all assignments of current_slave to a single point
+ *	  so specific modes can take actions when the primary adapter is
+ *	  changed.
  */
 
 #include <linux/config.h>
@@ -365,6 +373,7 @@
 #include <linux/ethtool.h>
 #include "bonding.h"
 #include "bond_3ad.h"
+#include "bond_alb.h"
 
 #define DRV_VERSION		"2.4.20-20030317"
 #define DRV_RELDATE		"March 17, 2003"
@@ -416,6 +425,7 @@ static struct bond_parm_tbl bond_mode_tb
 {	"balance-xor",		BOND_MODE_XOR},
 {	"broadcast",		BOND_MODE_BROADCAST},
 {	"802.3ad",		BOND_MODE_8023AD},
+{	"tlb",			BOND_MODE_TLB},
 {	NULL,			-1},
 };
 
@@ -484,6 +494,19 @@ static int bond_sethwaddr(struct net_dev
  */
 static int bond_get_info(char *buf, char **start, off_t offset, int length);
 
+/* Caller must hold bond->ptrlock for write */
+static inline struct slave*
+bond_assign_current_slave(struct bonding *bond,struct slave *newslave)
+{
+	if (bond_mode == BOND_MODE_TLB) {
+		bond->current_slave = bond_alb_handle_active_change(bond, newslave);
+	} else {
+		bond->current_slave = newslave;
+	}
+
+	return bond->current_slave;
+}
+
 /* #define BONDING_DEBUG 1 */
 
 /* several macros */
@@ -514,7 +537,9 @@ bond_mode_name(void)
 		return "fault-tolerance (broadcast)";
 	case BOND_MODE_8023AD:
 		return "IEEE 802.3ad Dynamic link aggregation";
-	default :
+	case BOND_MODE_TLB:
+		return "transmit load balancing";
+	default:
 		return "unknown";
 	}
 }
@@ -592,20 +617,11 @@ bond_detach_slave(bonding_t *bond, slave
 
 	if (bond->next == slave) {  /* is the slave at the head ? */
 		if (bond->prev == slave) {  /* is the slave alone ? */
-			write_lock(&bond->ptrlock);
-			bond->current_slave = NULL; /* no slave anymore */
-			write_unlock(&bond->ptrlock);
 			bond->prev = bond->next = (slave_t *)bond;
 		} else { /* not alone */
 			bond->next        = slave->next;
 			slave->next->prev = (slave_t *)bond;
 			bond->prev->next  = slave->next;
-
-			write_lock(&bond->ptrlock);
-			if (bond->current_slave == slave) {
-				bond->current_slave = slave->next;
-			}
-			write_unlock(&bond->ptrlock);
 		}
 	} else {
 		slave->prev->next = slave->next;
@@ -614,15 +630,16 @@ bond_detach_slave(bonding_t *bond, slave
 		} else {
 			slave->next->prev = slave->prev;
 		}
-
-		write_lock(&bond->ptrlock);
-		if (bond->current_slave == slave) {
-			bond->current_slave = slave->next;
-		}
-		write_unlock(&bond->ptrlock);
 	}
 
 	update_slave_cnt(bond, -1);
+	write_lock(&bond->ptrlock);
+	if (bond->next != (slave_t *)bond) {  /* found one slave */
+		bond_assign_current_slave(bond, bond->next);
+	} else {
+		bond_assign_current_slave(bond, NULL);
+	}
+	write_unlock(&bond->ptrlock);
 
 	return slave;
 }
@@ -878,6 +895,18 @@ static int bond_open(struct net_device *
 		bond_register_lacpdu(bond);
 	}
 
+	if (bond_mode == BOND_MODE_TLB) {
+		struct timer_list *alb_timer = &(BOND_ALB_INFO(bond).alb_timer);
+		if (bond_alb_initialize(bond)) {
+			return -1;
+		}
+		init_timer(alb_timer);
+		alb_timer->expires  = jiffies + 1;
+		alb_timer->data     = (unsigned long)bond;
+		alb_timer->function = (void *)&bond_alb_monitor;
+		add_timer(alb_timer);
+	}
+
 	return 0;
 }
 
@@ -906,6 +935,12 @@ static int bond_close(struct net_device 
 		bond_unregister_lacpdu(bond);
 	}
 
+	if (bond_mode == BOND_MODE_TLB) {
+		del_timer_sync(&(BOND_ALB_INFO(bond).alb_timer));
+
+		bond_alb_deinitialize(bond);
+	}
+
 	if (bond->next != (struct slave *) bond) {
 		/* Release the bonded slaves */
 		bond_release_all(master);
@@ -1384,7 +1419,7 @@ static int bond_enslave(struct net_devic
 #endif
 			/* first slave or no active slave yet, and this link
 			   is OK, so make this interface the active one */
-			bond->current_slave = new_slave;
+			bond_assign_current_slave(bond, new_slave);
 			bond_set_slave_active_flags(new_slave);
 			bond_mc_update(bond, new_slave, NULL);
 		}
@@ -1421,6 +1456,17 @@ static int bond_enslave(struct net_devic
 		}
 
 		bond_3ad_bind_slave(new_slave);
+	} else if (bond_mode == BOND_MODE_TLB) {
+		new_slave->state = BOND_STATE_ACTIVE;
+		if ((bond->current_slave == NULL) && (new_slave->link == BOND_LINK_UP)) {
+			/*
+			 * first slave or no active slave yet, and this link
+			 * is OK, so make this interface the active one
+			 */
+			bond_assign_current_slave(bond, new_slave);
+		}
+
+		bond_alb_init_slave(bond, new_slave);
 	} else {
 #ifdef BONDING_DEBUG
 		printk(KERN_CRIT "This slave is always active in trunk mode\n");
@@ -1428,7 +1474,7 @@ static int bond_enslave(struct net_devic
 		/* always active in trunk mode */
 		new_slave->state = BOND_STATE_ACTIVE;
 		if (bond->current_slave == NULL) 
-			bond->current_slave = new_slave;
+			bond_assign_current_slave(bond, new_slave);
 	}
 
 	write_unlock_irqrestore(&bond->lock, flags);
@@ -1499,7 +1545,7 @@ static int bond_change_active(struct net
 		bond_set_slave_inactive_flags(oldactive);
 		bond_set_slave_active_flags(newactive);
 		bond_mc_update(bond, newactive, oldactive);
-		bond->current_slave = newactive;
+		bond_assign_current_slave(bond, newactive);
 		printk("%s : activate %s(old : %s)\n",
 			master_dev->name, newactive->dev->name, 
 			oldactive->dev->name);
@@ -1536,14 +1582,14 @@ slave_t *change_active_interface(bonding
 	if (newslave == NULL) { /* there were no active slaves left */
 		if (bond->next != (slave_t *)bond) {  /* found one slave */
 			write_lock(&bond->ptrlock);
-			newslave = bond->current_slave = bond->next;
+			newslave = bond_assign_current_slave(bond, bond->next);
 			write_unlock(&bond->ptrlock);
 		} else {
 
 			printk (" but could not find any %s interface.\n",
 				(bond_mode == BOND_MODE_ACTIVEBACKUP) ? "backup":"other");
 			write_lock(&bond->ptrlock);
-			bond->current_slave = (slave_t *)NULL;
+			bond_assign_current_slave(bond, NULL);
 			write_unlock(&bond->ptrlock);
 			return NULL; /* still no slave, return NULL */
 		}
@@ -1588,7 +1634,7 @@ slave_t *change_active_interface(bonding
 				}
 
 				write_lock(&bond->ptrlock);
-				bond->current_slave = newslave;
+				bond_assign_current_slave(bond, newslave);
 				write_unlock(&bond->ptrlock);
 				return newslave;
 			}
@@ -1618,7 +1664,7 @@ slave_t *change_active_interface(bonding
 		bond_set_slave_active_flags(bestslave);
 		bond_mc_update(bond, bestslave, oldslave);
 		write_lock(&bond->ptrlock);
-		bond->current_slave = bestslave;
+		bond_assign_current_slave(bond, bestslave);
 		write_unlock(&bond->ptrlock);
 		return bestslave;
 	}
@@ -1643,7 +1689,7 @@ slave_t *change_active_interface(bonding
 	
 	/* absolutely nothing found. let's return NULL */
 	write_lock(&bond->ptrlock);
-	bond->current_slave = (slave_t *)NULL;
+	bond_assign_current_slave(bond, NULL);
 	write_unlock(&bond->ptrlock);
 	return NULL;
 }
@@ -1685,8 +1731,30 @@ static int bond_release(struct net_devic
 	old_current = bond->current_slave;
 	while ((our_slave = our_slave->prev) != (slave_t *)bond) {
 		if (our_slave->dev == slave) {
+			int mac_addr_differ = memcmp(bond->device->dev_addr,
+						 our_slave->perm_hwaddr,
+						 ETH_ALEN);
+			if (!mac_addr_differ && (bond->slave_cnt > 1)) {
+				printk(KERN_WARNING "WARNING: the permanent HWaddr of %s "
+				"- %02X:%02X:%02X:%02X:%02X:%02X - "
+				"is still in use by %s. Set the HWaddr "
+				"of %s to a different address "
+				"to avoid conflicts.\n",
+				       slave->name,
+				       slave->dev_addr[0],
+				       slave->dev_addr[1],
+				       slave->dev_addr[2],
+				       slave->dev_addr[3],
+				       slave->dev_addr[4],
+				       slave->dev_addr[5],
+				       bond->device->name,
+				       slave->name);
+			}
+
 			/* Inform AD package of unbinding of slave. */
 			if (bond_mode == BOND_MODE_8023AD) {
+				//must be called before the slave is
+				//detached from the list
 				bond_3ad_unbind_slave(our_slave);
 			}
 
@@ -1715,6 +1783,13 @@ static int bond_release(struct net_devic
 				bond->primary_slave = NULL;
 			}
 
+			if (bond_mode == BOND_MODE_TLB) {
+				/* must be called only after the slave has been
+				 * detached from the list
+				 */
+				bond_alb_deinit_slave(bond, our_slave);
+			}
+
 			break;
 		}
 
@@ -1791,7 +1866,7 @@ static int bond_release_all(struct net_d
 
 	bond = (struct bonding *) master->priv;
 	bond->current_arp_slave = NULL;
-	bond->current_slave = NULL;
+	bond_assign_current_slave(bond, NULL);
 	bond->primary_slave = NULL;
 
 	while ((our_slave = bond->prev) != (slave_t *)bond) {
@@ -1804,6 +1879,10 @@ static int bond_release_all(struct net_d
 		slave_dev = our_slave->dev;
 		bond_detach_slave(bond, our_slave);
 
+		if (bond_mode == BOND_MODE_TLB) {
+			bond_alb_deinit_slave(bond, our_slave);
+		}
+
 		if (multicast_mode == BOND_MULTICAST_ALL 
 		    || (multicast_mode == BOND_MULTICAST_ACTIVE 
 			&& bond->current_slave == our_slave)) {
@@ -1944,6 +2023,10 @@ static void bond_mii_monitor(struct net_
 						bond_3ad_link_status_changed(slave, 0);
 					}
 
+					if (bond_mode == BOND_MODE_TLB) {
+						bond_alb_handle_link_change(bond, slave, BOND_LINK_FAIL);
+					}
+
 					read_lock(&bond->ptrlock);
 					if (slave == bond->current_slave) {
 						read_unlock(&bond->ptrlock);
@@ -2037,7 +2120,11 @@ static void bond_mii_monitor(struct net_
 					if (bond_mode == BOND_MODE_8023AD) {
 						bond_3ad_link_status_changed(slave, 1);
 					}
-					
+
+					if (bond_mode == BOND_MODE_TLB) {
+						bond_alb_handle_link_change(bond, slave, BOND_LINK_UP);
+					}
+
 					if ( (bond->primary_slave != NULL)	
 					  && (slave == bond->primary_slave) )
 						change_active_interface(bond); 
@@ -2104,6 +2191,10 @@ static void bond_mii_monitor(struct net_
 				if (bond_mode == BOND_MODE_8023AD) {
 					bond_3ad_link_status_changed(bestslave, 1);
 				}
+
+				if (bond_mode == BOND_MODE_TLB) {
+					bond_alb_handle_link_change(bond, bestslave, BOND_LINK_UP);
+				}
 			}
 
 			if (bond_mode == BOND_MODE_ACTIVEBACKUP) {
@@ -2113,7 +2204,7 @@ static void bond_mii_monitor(struct net_
 				bestslave->state = BOND_STATE_ACTIVE;
 			}
 			write_lock(&bond->ptrlock);
-			bond->current_slave = bestslave;
+			bond_assign_current_slave(bond, bestslave);
 			write_unlock(&bond->ptrlock);
 		} else if (slave_died) {
 			/* print this message only once a slave has just died */
@@ -2315,7 +2406,7 @@ static void activebackup_arp_monitor(str
 				if ((bond->current_slave == NULL) &&
 				    ((jiffies - slave->dev->trans_start) <=
 				     the_delta_in_ticks)) {
-					bond->current_slave = slave;
+					bond_assign_current_slave(bond, slave);
 					bond_set_slave_active_flags(slave);
 			                bond_mc_update(bond, slave, NULL);
 					bond->current_arp_slave = NULL;
@@ -2427,7 +2518,7 @@ static void activebackup_arp_monitor(str
 			bond_set_slave_inactive_flags(slave);
 			bond_mc_update(bond, bond->primary_slave, slave);
 			write_lock(&bond->ptrlock);
-			bond->current_slave = bond->primary_slave;
+			bond_assign_current_slave(bond, bond->primary_slave);
 			write_unlock(&bond->ptrlock);
 			slave = bond->primary_slave;
 			bond_set_slave_active_flags(slave);
@@ -2849,7 +2940,7 @@ static int bond_xmit_roundrobin(struct s
 			dev_queue_xmit(skb);
 
 			write_lock(&bond->ptrlock);
-			bond->current_slave = slave->next;
+			bond_assign_current_slave(bond, slave->next);
 			write_unlock(&bond->ptrlock);
 
 			read_unlock_irqrestore(&bond->lock, flags);
@@ -3236,7 +3327,7 @@ static int __init bond_init(struct net_d
 	memset(bond->stats, 0, sizeof(struct net_device_stats));
 
 	bond->next = bond->prev = (slave_t *)bond;
-	bond->current_slave = NULL;
+	bond_assign_current_slave(bond, NULL);
 	bond->current_arp_slave = NULL;
 	bond->device = dev;
 	dev->priv = bond;
@@ -3258,6 +3349,9 @@ static int __init bond_init(struct net_d
 	case BOND_MODE_8023AD:
 		dev->hard_start_xmit = bond_3ad_xmit_xor;
 		break;
+	case BOND_MODE_TLB:
+		dev->hard_start_xmit = bond_alb_xmit;
+		break;
 	default:
 		printk(KERN_ERR "Unknown bonding mode %d\n", bond_mode);
 		kfree(bond->stats);
@@ -3450,8 +3544,7 @@ static int __init bonding_init(void)
 		if (arp_interval != 0) {
 			printk(KERN_WARNING "bonding_init(): ARP monitoring"
 			       "can't be used simultaneously with 802.3ad, "
-			       "disabling ARP monitoring\n"
-			       );
+			       "disabling ARP monitoring\n");
 			arp_interval = 0;
 		}
 		
@@ -3460,20 +3553,41 @@ static int __init bonding_init(void)
 			       "bonding_init(): miimon must be specified, "
 			       "otherwise bonding will not detect link failure, "
 			       "speed and duplex which are essential "
-			       "for 802.3ad operation"
-			       "Forcing miimon to 100msec\n");
+			       "for 802.3ad operation\n");
+			printk(KERN_ERR "Forcing miimon to 100msec\n");
 			miimon = 100;
 		}
 		
 		if (multicast_mode != BOND_MULTICAST_ALL) {
 			printk(KERN_ERR
 			       "bonding_init(): Multicast mode must "
-			       "be set to ALL for 802.3ad, "
-			       "Forcing Multicast mode to ALL\n");
+			       "be set to ALL for 802.3ad\n");
+			printk(KERN_ERR "Forcing Multicast mode to ALL\n");
 			multicast_mode = BOND_MULTICAST_ALL;
 		}
 	}
-	
+
+	/* reset values for TLB */
+	if (bond_mode == BOND_MODE_TLB) {
+		if (miimon == 0) {
+			printk(KERN_ERR
+			       "bonding_init(): miimon must be specified, "
+			       "otherwise bonding will not detect link failure "
+			       "and link speed which are essential "
+			       "for TLB load balancing\n");
+			printk(KERN_ERR "Forcing miimon to 100msec\n");
+			miimon = 100;
+		}
+
+		if (multicast_mode != BOND_MULTICAST_ACTIVE) {
+			printk(KERN_ERR
+			       "bonding_init(): Multicast mode must "
+			       "be set to ACTIVE for TLB\n");
+			printk(KERN_ERR "Forcing Multicast mode to ACTIVE\n");
+			multicast_mode = BOND_MULTICAST_ACTIVE;
+		}
+	}
+
 	if (miimon == 0) {
 		if ((updelay != 0) || (downdelay != 0)) {
 			/* just warn the user the up/down delay will have
diff -Nuarp linux-2.4.20-bonding-20030317/drivers/net/bonding/Makefile linux-2.4.20-bonding-20030317-devel/drivers/net/bonding/Makefile
--- linux-2.4.20-bonding-20030317/drivers/net/bonding/Makefile	2003-03-27 17:00:05.000000000 +0200
+++ linux-2.4.20-bonding-20030317-devel/drivers/net/bonding/Makefile	2003-03-27 17:00:06.000000000 +0200
@@ -5,7 +5,8 @@
 O_TARGET := bonding.o
 
 obj-y	 := bond_main.o \
-            bond_3ad.o
+            bond_3ad.o  \
+	    bond_alb.o
 
 obj-m	 := $(O_TARGET)
 
diff -Nuarp linux-2.4.20-bonding-20030317/include/linux/if_bonding.h linux-2.4.20-bonding-20030317-devel/include/linux/if_bonding.h
--- linux-2.4.20-bonding-20030317/include/linux/if_bonding.h	2003-03-27 17:00:05.000000000 +0200
+++ linux-2.4.20-bonding-20030317-devel/include/linux/if_bonding.h	2003-03-27 17:00:06.000000000 +0200
@@ -55,6 +55,7 @@
 #define BOND_MODE_XOR		2
 #define BOND_MODE_BROADCAST	3
 #define BOND_MODE_8023AD        4
+#define BOND_MODE_TLB           5
 
 /* each slave's link has 4 states */
 #define BOND_LINK_UP    0           /* link is up and running */

-- 
| Shmulik Hen                             |
| Israel Design Center (Jerusalem)        |
| LAN Access Division                     |
| Intel Communications Group, Intel corp. |




