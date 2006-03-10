Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWCJAlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWCJAlt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWCJAgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:36:19 -0500
Received: from mx.pathscale.com ([64.160.42.68]:18062 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752158AbWCJAfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:35:51 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 20 of 20] ipath - ethernet emulation driver
X-Mercurial-Node: 7f00f404094f828829b5338815588aba8dc92aff
Message-Id: <7f00f404094f828829b5.1141950950@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1141950930@eng-12.pathscale.com>
Date: Thu,  9 Mar 2006 16:35:50 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ethernet emulation driver makes an eth* interface available.  It
uses Infiniband UD packets, but is not IPoIB compatible.  It provides
higher bandwidth and lower latency than IPoIB.

The driver is implemented using the ipath_layer code, as is the ipath
driver's OpenIB support.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r d5a8cb977923 -r 7f00f404094f drivers/infiniband/hw/ipath/Kconfig
--- a/drivers/infiniband/hw/ipath/Kconfig	Thu Mar  9 16:17:14 2006 -0800
+++ b/drivers/infiniband/hw/ipath/Kconfig	Thu Mar  9 16:17:14 2006 -0800
@@ -16,3 +16,10 @@ config INFINIBAND_IPATH
 	allows these devices to be used with both kernel upper level
 	protocols such as IP-over-InfiniBand as well as with userspace
 	applications (in conjunction with InfiniBand userspace access).
+
+config IPATH_ETHER
+	tristate "PathScale InfiniPath ethernet driver"
+	depends on IPATH_CORE
+	---help---
+	This is an ethernet emulator layer for the PathScale InfiniPath
+	host channel adapters (HCAs).
diff -r d5a8cb977923 -r 7f00f404094f drivers/infiniband/hw/ipath/ipath_eth.c
--- /dev/null	Thu Jan  1 00:00:00 1970 +0000
+++ b/drivers/infiniband/hw/ipath/ipath_eth.c	Thu Mar  9 16:17:14 2006 -0800
@@ -0,0 +1,1187 @@
+/*
+ * Copyright (c) 2003, 2004, 2005, 2006 PathScale, Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it is
+ * free of the rightful claim of any third person regarding infringement
+ * or the like.  Any license provided herein, whether implied or
+ * otherwise, applies only to this software file.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write the Free Software Foundation, Inc., 59
+ * Temple Place - Suite 330, Boston MA 02111-1307, USA.
+ */
+
+/*
+ * ipath_ether.c ethernet driver emulation over PathScale Infinipath
+ * for Linux.
+ */
+
+#define ipath_ether_ioctl_support
+
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
+
+#include "ipath_debug.h"
+#include "ips_common.h"
+#include "ipath_layer.h"
+
+/* Not static, because we don't want the compiler removing it */
+#define DRV_NAME        "ipath_ether"
+const char ipath_ether_version[] = DRV_NAME " " IPATH_IDSTR;
+#define DRV_VERSION     "1.0"
+
+#if _IPATH_DEBUGGING
+
+#define __IPATH_DBG_WHICH(which,fmt,...) \
+	do { \
+		if (unlikely(ipath_debug&(which))) \
+			printk(KERN_DEBUG DRV_NAME ": %s: " fmt, \
+			       __func__,##__VA_ARGS__); \
+	} while (0)
+
+#define ipath_eth_dbg(fmt,...) \
+	__IPATH_DBG_WHICH(__IPATH_IPATHDBG,fmt,##__VA_ARGS__)
+#define ipath_eth_cdbg(which,fmt,...) \
+	__IPATH_DBG_WHICH(__IPATH_##which##DBG,fmt,##__VA_ARGS__)
+#define ipath_eth_warn(fmt,...) \
+	__IPATH_DBG_WHICH(__IPATH_IPATHWARN,fmt,##__VA_ARGS__)
+#define ipath_eth_err(fmt,...) \
+	__IPATH_DBG_WHICH(__IPATH_IPATHERR ,fmt,##__VA_ARGS__)
+#define ipath_eth_table(fmt,...) \
+	__IPATH_DBG_WHICH(__IPATH_IPATHTABLE  ,fmt,##__VA_ARGS__)
+
+#else
+
+#define ipath_eth_dbg(fmt,...)
+#define ipath_eth_warn(fmt,...)
+#define ipath_eth_err(fmt,...)
+#define ipath_eth_table(fmt,...)
+
+#endif
+
+#define MAX_IPATH_LAYER_DEVICE 4
+#define ETHER_MAC_SIZE 6
+
+#define TX_TIMEOUT      2000
+
+#define BROADCAST_MASK 0x0001
+
+#define IPATH_LAYER_DOWN 0
+#define IPATH_LAYER_UP 1
+
+#define MAC_LENGTH 6
+
+#define MAX_HASH_ENTRIES 4129
+
+#define LID_ARP_REQUEST 1
+#define LID_ARP_RESPONSE 2
+
+#define ETH_ARP_PROTOCOL 0x0806	/* ARP protocol ID */
+
+#define HASH_ALLOC_ENTRIES 256
+
+#define priv_data(dev) ((struct ipath_ether_priv *)(dev)->priv)
+
+#define make_hash_key(mac) ((mac[0] + mac[1] + mac[2]) % MAX_HASH_ENTRIES)
+
+/* This structure is used to reassemble packets for large MTUs. */
+struct ipath_frag_state {
+	spinlock_t lock;
+	struct sk_buff *skb;
+	struct sk_buff *last_skb;
+	uint16_t lid;
+	uint8_t frag_num;	/* ips_message_header.unused */
+	uint8_t seq_num;	/* ips_message_header.tinylen */
+	uint32_t len;		/* ips_message_header.ack_seq_num */
+};
+
+struct ipath_ether_priv {
+	struct ipath_devdata *dd;
+	int device_id;
+	uint16_t my_lid;	/* set in network order */
+	uint16_t my_bcast;	/* set in network order */
+	uint16_t my_mac_addr[3];
+	int ipath_ether_if_stat;
+	struct net_device_stats ipath_ether_stats;
+	wait_queue_head_t lid_wait;	/* when waiting for LID at open */
+	struct copy_data_s cpc;
+	struct ipath_frag_state *fstate; /* Fragment reassembly table */
+	struct ether_header protocol_header;
+};
+
+struct ether_hash {		/* _ips_message_header  */
+	struct ether_hash *next;
+	uint16_t mac[3];
+	uint16_t lid;
+};
+
+static struct net_device *dev_ipath_ether[MAX_IPATH_LAYER_DEVICE];
+static struct ipath_ether_priv private_data[MAX_IPATH_LAYER_DEVICE];
+static int number_of_devices;
+
+static atomic_t send_continue;
+
+/*
+ * this will have to change to be per-device when we support
+ * multiple infinipath devices that aren't all on the saem fabric
+ */
+static struct ether_hash hash_table[MAX_HASH_ENTRIES];
+static struct ether_hash *all_hash_entries;
+static struct ether_hash *free_hash_entries;
+static DEFINE_SPINLOCK(ipath_ether_lock);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("PathScale <support@pathscale.com>");
+MODULE_DESCRIPTION("Pathscale InfiniPath ethernet driver");
+
+static struct net_device_stats *ipath_ether_get_stats(
+	struct net_device *dev);
+int ipath_ether_init(void);
+void ipath_ether_exit(void);
+
+module_init(ipath_ether_init);
+module_exit(ipath_ether_exit);
+
+static unsigned int ipath_fragtable_size = 1033;
+module_param_named(fragtable_size, ipath_fragtable_size, uint, S_IRUGO);
+MODULE_PARM_DESC(fragtable_size,
+		 "size of the fragment reassembly hash table (prime)");
+
+static int _send_lid_message(uint16_t * mac,
+			     uint8_t cmd,
+			     uint16_t dest_lid, struct net_device *dev)
+{
+	struct ether_header protocol_header;
+	uint32_t total_frame_size_in_words = sizeof(protocol_header) >> 2;
+
+	protocol_header.lrh[0] = htons(IPS_LRH_BTH);
+	protocol_header.lrh[1] = dest_lid;	/* DEST LID */
+	protocol_header.lrh[2] =
+		htons(total_frame_size_in_words + SIZE_OF_CRC);
+	protocol_header.lrh[3] =
+		priv_data(dev)->my_lid;	/* SRC LID */
+
+	protocol_header.bth[0] =
+		htonl((OPCODE_ITH4X << 24) + IPS_DEFAULT_P_KEY);
+	protocol_header.sub_opcode = OPCODE_LID_ARP;
+
+	protocol_header.bth[1] = htonl(IPATH_KD_QP);
+	protocol_header.bth[2] = 0;
+
+	/* port, version, and TID are already known to be in range, no
+	 * masking needed; offset in low INFINIPATH_I_OFFSET_MASK  bits */
+	protocol_header.iph.ver_port_tid_offset =
+		(IPS_PROTO_VERSION << INFINIPATH_I_VERS_SHIFT) +
+		(EAGER_TID_ID << INFINIPATH_I_TID_SHIFT);
+	/* port is zero */
+	/* offset is zero */
+
+	/* generate an interrupt on the receive side */
+	protocol_header.iph.pkt_flags = INFINIPATH_KPF_INTR;
+
+	protocol_header.iph.chksum =
+		(uint16_t) IPS_LRH_BTH +
+		(uint16_t) (total_frame_size_in_words + SIZE_OF_CRC) -
+		(uint16_t) ((protocol_header.iph.
+			     ver_port_tid_offset >> 16) & 0xFFFF) -
+		(uint16_t) (protocol_header.iph.ver_port_tid_offset &
+			    0xFFFF) -
+		(uint16_t) protocol_header.iph.pkt_flags;
+
+	protocol_header.cmd = cmd;
+	protocol_header.lid =
+		(cmd == LID_ARP_RESPONSE) ? priv_data(dev)->my_lid : 0;
+	protocol_header.mac[0] = mac[0];
+	protocol_header.mac[1] = mac[1];
+	protocol_header.mac[2] = mac[2];
+
+	return ipath_layer_send_hdr(priv_data(dev)->dd, &protocol_header);
+}
+
+/**
+ * _add_mac_lid - add a MAC LID
+ * @mac: the MAC
+ * @lid: the LID
+ @
+ * XXX problem? can grow to unbounded in size.
+ * NOTE: this should only be called from interrupt context.
+ */
+static int _add_mac_lid(uint16_t * mac, uint16_t lid)
+{
+	uint16_t hashkey = make_hash_key(mac);
+	struct ether_hash *hash_entry = &hash_table[hashkey];
+	struct ether_hash *last_entry = NULL;
+	struct ether_hash *index;
+	int counter;
+	int rc = 0;
+
+	/* spin_lock_irq(&ipath_ether_lock); */
+
+	if (!hash_entry->lid) {
+		memcpy(hash_entry->mac, mac, MAC_LENGTH);
+		hash_entry->lid = lid;
+		hash_entry->next = NULL;
+
+		goto _add_mac_lid_complete;
+	}
+
+	while (hash_entry) {
+		if ((hash_entry->mac[0] == mac[0]) &&
+		    (hash_entry->mac[1] == mac[1]) &&
+		    (hash_entry->mac[2] == mac[2])
+			) {
+			hash_entry->lid = lid;
+			goto _add_mac_lid_complete;
+		}
+
+		last_entry = hash_entry;
+		hash_entry = hash_entry->next;
+	}
+
+	/* MAC address was not found - so add it! */
+	if (!free_hash_entries) {
+		index = kmalloc(HASH_ALLOC_ENTRIES *
+				sizeof(struct ether_hash), GFP_ATOMIC);
+
+		if (!index) {
+			rc = -1;
+			goto _add_mac_lid_complete;
+		}
+
+		/*
+		 * The first entry is used to keep a list of all the
+		 * entries.
+		 */
+		index->next = all_hash_entries;
+		all_hash_entries = index;
+		free_hash_entries = ++index;
+
+		for (counter = 2; counter < HASH_ALLOC_ENTRIES; counter++) {
+			index->next = index + 1;
+			index++;
+		}
+
+		index->next = NULL;
+	}
+
+	hash_entry = free_hash_entries;
+	free_hash_entries = free_hash_entries->next;
+
+	/* Initialize the new entry before linking into the list. */
+	memcpy(hash_entry->mac, mac, MAC_LENGTH);
+	hash_entry->lid = lid;
+	hash_entry->next = NULL;
+
+	last_entry->next = hash_entry;
+
+_add_mac_lid_complete:
+	/* spin_unlock_irq(&ipath_ether_lock); */
+	return rc;
+}
+
+/**
+ * _lookup_lid - look up the LID for a MAC
+ * @mac: the MAC
+ * @dev: the network device
+ *
+ * LID '0' (zero) is returned when lookup failed.
+ * Since only one CPU can update the list at a time, we are
+ * careful to initialize the entry before linking into the list,
+ * and its a single linked list, the readers can safely walk the list
+ * without holding the lock.
+ */
+static uint16_t _lookup_lid(uint16_t * mac, struct net_device *dev)
+{
+	uint16_t hashkey = make_hash_key(mac);
+	struct ether_hash *hash_entry = &hash_table[hashkey];
+
+	while (hash_entry) {
+		if ((hash_entry->mac[0] == mac[0]) &&
+		    (hash_entry->mac[1] == mac[1]) &&
+		    (hash_entry->mac[2] == mac[2])
+			)
+			break;
+
+		hash_entry = hash_entry->next;
+	}
+
+	if (hash_entry) {
+		return hash_entry->lid;
+	} else {
+		_send_lid_message(mac, LID_ARP_REQUEST,
+				  priv_data(dev)->my_bcast, dev);
+
+		return 0;
+	}
+}
+
+static int ipath_ether_start_xmit(struct sk_buff *skb,
+				  struct net_device *dev)
+{
+	struct ether_header *protocol_header =
+		&priv_data(dev)->protocol_header;
+	int rc = 0;
+	uint16_t dest_lid;
+	static uint32_t jumboseq;
+
+	if (skb->data[0] & BROADCAST_MASK) {
+
+		ipath_eth_dbg("Dest MAC: %x:%x:%x:%x:%x:%x\n",
+			      ((uint8_t *)skb->data)[0],
+			      ((uint8_t *)skb->data)[1],
+			      ((uint8_t *)skb->data)[2],
+			      ((uint8_t *)skb->data)[3],
+			      ((uint8_t *)skb->data)[4],
+			      ((uint8_t *)skb->data)[5]);
+
+		dest_lid = priv_data(dev)->my_bcast;
+		if (!dest_lid) {
+			/*
+			 * Can't broadcast, broadcast LID isn't set yet.
+			 * not the best possible error, but reasonable
+			 */
+			dev_kfree_skb(skb);
+			priv_data(dev)->ipath_ether_stats.tx_dropped++;
+			/* just return 0. Old return was -ENOBUFS; */
+			return 0;
+		}
+	} else {
+		dest_lid = _lookup_lid((uint16_t *) skb->data, dev);
+		if (!dest_lid) {
+			dev_kfree_skb(skb);
+			priv_data(dev)->ipath_ether_stats.tx_dropped++;
+			/* just return 0. Old return was -ENOBUFS; */
+			return 0;
+		}
+	}
+
+	if (ipath_debug & __IPATH_IPATHPD) {
+		int loop_count;
+
+		printk("Send:\n");
+		for (loop_count = 0; loop_count < skb->len;
+		     loop_count++) {
+			if (!(loop_count % 16))
+				printk("\n");
+
+			printk("%02X ",
+			       ((uint8_t *) skb->data)[loop_count]);
+		}
+
+		printk("\n\n");
+	}
+
+	/* This is used as the sequence ID of a jumbo packet. */
+	protocol_header->seq_num = ++jumboseq;
+	/* This is the total length the receiver should expect. */
+	protocol_header->len = skb->len;
+	/*
+	 * This is used as the fragment number for segmented jumbo packets.
+	 */
+	protocol_header->frag_num = 0;
+
+	/*
+	 * Copy 2 bytes of the ethernet header into the infinipath header so
+	 * the rest of the data is 32-bit aligned.
+	 */
+	protocol_header->first_2_bytes = *((uint16_t *) skb->data);
+	skb_pull(skb, sizeof(uint16_t));
+
+	protocol_header->lrh[0] = htons(IPS_LRH_BTH);
+	protocol_header->lrh[1] = dest_lid;
+	protocol_header->lrh[3] =
+		priv_data(dev)->my_lid;	/* SRC LID */
+
+	protocol_header->bth[0] =
+		htonl((OPCODE_ITH4X << 24) + IPS_DEFAULT_P_KEY);
+	protocol_header->sub_opcode = OPCODE_ENCAP;
+
+	protocol_header->bth[1] = htonl(IPATH_KD_QP);
+
+	/* port, version, and TID are already known to be in range, no
+	 * masking needed; offset in low INFINIPATH_I_OFFSET_MASK  bits */
+	protocol_header->iph.ver_port_tid_offset =
+		(IPS_PROTO_VERSION << INFINIPATH_I_VERS_SHIFT) +
+		(EAGER_TID_ID << INFINIPATH_I_TID_SHIFT);
+	/* port is zero */
+	/* offset is zero */
+
+	protocol_header->flags = NETIF_F_SG;
+	if ((dev->features & NETIF_F_HW_CSUM) &&
+	    skb->ip_summed == CHECKSUM_HW)
+		protocol_header->flags |= NETIF_F_HW_CSUM;
+
+	/* init cpc */
+	priv_data(dev)->cpc.hdr = protocol_header;
+	priv_data(dev)->cpc.to = NULL;
+	priv_data(dev)->cpc.error = 0;
+	priv_data(dev)->cpc.extra = 0;
+	priv_data(dev)->cpc.len = skb->len;
+	priv_data(dev)->cpc.flen = 0;
+	priv_data(dev)->cpc.skb = skb;
+	priv_data(dev)->cpc.csum = 0;
+	priv_data(dev)->cpc.pos = 0;
+	priv_data(dev)->cpc.offset = 0;
+	priv_data(dev)->cpc.checksum_calc = 0;
+
+	rc = ipath_layer_send_skb(priv_data(dev)->dd, &priv_data(dev)->cpc);
+	if (rc == 0) {
+		priv_data(dev)->ipath_ether_stats.tx_packets++;
+		priv_data(dev)->ipath_ether_stats.tx_bytes += skb->len;
+
+		priv_data(dev)->cpc.skb = NULL;
+		dev_kfree_skb(skb);
+	} else {
+		netif_stop_queue(dev);
+
+		if (rc == -ENOBUFS)
+			priv_data(dev)->ipath_ether_stats.tx_fifo_errors++;
+
+		if (rc == -EBUSY) {
+			atomic_set(&send_continue, 1);
+			ipath_layer_set_piointbufavail_int(
+				priv_data(dev)->dd);
+			rc = 0;
+		}
+	}
+
+	return rc;
+}
+
+/**
+ * ipath_ether_process_lid_arp - process an ARP message for a LID
+ * @device: the network device
+ * @hdr: the message header
+ */
+static int ipath_ether_process_lid_arp(int device, void *hdr)
+{
+	struct ipath_ether_priv *priv = &private_data[device];
+	struct ether_header *ihdr = (struct ether_header *) hdr;
+
+	switch (ihdr->cmd) {
+	case LID_ARP_REQUEST:
+		if ((priv->my_mac_addr[0] == ihdr->mac[0]) &&
+		    (priv->my_mac_addr[1] == ihdr->mac[1]) &&
+		    (priv->my_mac_addr[2] == ihdr->mac[2])) {
+			_send_lid_message(priv->my_mac_addr,
+					  LID_ARP_RESPONSE,
+					  ihdr->lrh[3],
+					  dev_ipath_ether[device]);
+		}
+		break;
+
+	case LID_ARP_RESPONSE:
+		spin_lock_irq(&ipath_ether_lock);
+		_add_mac_lid(ihdr->mac, ihdr->lid);
+		spin_unlock_irq(&ipath_ether_lock);
+		break;
+	}
+
+	return 0;
+}
+
+/**
+ * get_state - get fragment state
+ * @table: the fragment state table
+ * @lid: the LID
+ *
+ * The purpose of the fragment reassembly hash table is to reduce the
+ * probability of losing state due to hash collisions.
+ * In order to add the least amount of overhead, there is no locking used
+ * on the lookup and a LID hashes to only one entry.
+ * Locking would be required if we tried to support removal of entries or
+ * dynamically growing the hash table.
+ */
+static inline struct ipath_frag_state *get_state(
+	struct ipath_frag_state *table, uint16_t lid)
+{
+	unsigned int probe = lid % ipath_fragtable_size;
+	struct ipath_frag_state *entry = table + probe;
+
+	return entry;
+}
+
+/**
+ * ipath_ether_rx - receive an ethernet packet
+ * @device: the network device
+ * @hdr: the packet header
+ * @skb: the sk_buff
+ *
+ * Callback handler called by the lower layer.
+ * Note that the skb is now our responsibility to either pass to the
+ * network stack or free it.
+ */
+static int ipath_ether_rx(int device, void *hdr, struct sk_buff *skb)
+{
+	struct ether_header *ihdr = (struct ether_header *) hdr;
+	struct ipath_ether_priv *priv = &private_data[device];
+	struct ipath_frag_state *fs = get_state(priv->fstate, ihdr->lrh[3]);
+	struct sk_buff *lskb;
+	uint16_t *h;
+
+	spin_lock_irq(&fs->lock);
+	lskb = fs->skb;
+	if (lskb != NULL) {
+		if (fs->lid != ihdr->lrh[3] ||
+		    fs->seq_num != ihdr->seq_num ||
+		    fs->frag_num != ihdr->frag_num) {
+
+			ipath_eth_warn("Drop %x %x, %u %u, %u %u, "
+				       "%u %u, %x\n", fs->lid,
+				       ihdr->lrh[3], fs->seq_num,
+				       ihdr->seq_num, fs->frag_num,
+				       ihdr->frag_num, fs->len,
+				       ihdr->len,
+				       ihdr->flags);	/* XXX */
+
+			dev_kfree_skb_irq(lskb);
+			fs->skb = NULL;
+			if (fs->lid != ihdr->lrh[3])
+				priv->ipath_ether_stats.collisions++;
+			else
+				priv->ipath_ether_stats.rx_dropped++;
+			goto restart;
+		}
+		fs->frag_num++;
+		/*
+		 * Linux network stack expects the last buff's next pointer
+		 * to be NULL.
+		 */
+		if (skb_shinfo(lskb)->frag_list == NULL)
+			skb_shinfo(lskb)->frag_list = skb;
+		else
+			fs->last_skb->next = skb;
+		fs->last_skb = skb;
+		lskb->len += skb->len;
+		lskb->data_len += skb->len;
+	} else {
+	restart:
+		/* Check to be sure this is the first fragment. */
+		if (ihdr->frag_num != 0) {
+			spin_unlock_irq(&fs->lock);
+			dev_kfree_skb_irq(skb);
+			priv->ipath_ether_stats.rx_dropped++;
+			return 0;
+		}
+		skb->dev = dev_ipath_ether[device];
+		skb->ip_summed = (ihdr->flags & NETIF_F_NO_CSUM) ?
+			CHECKSUM_UNNECESSARY : CHECKSUM_NONE;
+		fs->skb = skb;
+		fs->lid = ihdr->lrh[3];	/* src LID */
+		fs->len = ihdr->len;
+		fs->frag_num = 1;	/* next expected frag number */
+		fs->seq_num = ihdr->seq_num;
+		/*
+		 * Copy two bytes of the ethernet hdr from the infinipath
+		 * hdr
+		 */
+		h = (uint16_t *) skb_push(skb, 2);
+		*h = ihdr->first_2_bytes;
+
+		/*
+		 * Is this an ARP frame?
+		 * The data should now contain the 6 byte destination
+		 * ether address, the source ether address, and then
+		 * the protocol field.
+		 */
+		if (h[6] == htons(ETH_ARP_PROTOCOL))
+			_add_mac_lid(&h[3], ihdr->lrh[3]);
+	}
+
+	fs->len -= skb->len;
+	if (fs->len == 0) {
+		skb = fs->skb;
+		fs->skb = NULL;
+		spin_unlock_irq(&fs->lock);
+
+		/* Stuff the checksum back into the message. */
+		if (ihdr->flags & NETIF_F_HW_CSUM) {
+			/*
+			 * Check to be sure the offset is in the first
+			 * fragment.
+			 */
+			if (ihdr->csum_offset < skb_headlen(skb)) {
+				*((uint16_t *) (skb->data +
+						ihdr->csum_offset)) =
+					ihdr->csum;
+			} else {
+				/*
+				 * This should "never happen" so drop
+				 * packet to be safe.
+				 */
+				dev_kfree_skb_irq(skb);
+				priv->ipath_ether_stats.rx_dropped++;
+				return 0;
+			}
+		}
+
+		if (ipath_debug & __IPATH_IPATHPD) {
+			int loop_count;
+
+			printk("Recv:\n");
+			for (loop_count = 0; loop_count < skb->len;
+			     loop_count++) {
+				if (!(loop_count % 16))
+					printk("\n");
+
+				printk("%02X ", skb->data[loop_count]);
+			}
+
+			printk("\n\n");
+		}
+
+		priv->ipath_ether_stats.rx_packets++;
+		priv->ipath_ether_stats.rx_bytes += skb->len;
+		skb->protocol = eth_type_trans(skb, skb->dev);
+		netif_rx(skb);
+	} else
+		spin_unlock_irq(&fs->lock);
+	dev_ipath_ether[device]->last_rx = jiffies;
+
+	return 0;
+}
+
+/**
+ * ipath_ether_interrupt - ether driver interrupt handler
+ * @device: the infinipath device number
+ * @interrupts: the interrupt mask
+ */
+static int ipath_ether_interrupt(int device, uint32_t interrupts)
+{
+	struct ipath_ether_priv *priv = &private_data[device];
+	unsigned wakeup_needed = 0;
+	int rc = 0;
+
+	ipath_eth_cdbg(VERBOSE, "Took ipath_ether_interrupt\n");
+
+	/*
+	 * This can happen when hardware initialization fails in some way,
+	 * and may avoid other bugs as well.
+	 */
+	if ((uint32_t) device > MAX_IPATH_LAYER_DEVICE ||
+	    !dev_ipath_ether[device]) {
+		ipath_eth_warn("ipath device %u not initialized, "
+			       "ignoring interrupt\n", device);
+		return 0;
+	}
+
+	if (interrupts & IPATH_LAYER_INT_SEND_CONTINUE) {
+		if (atomic_dec_and_test(&send_continue)) {
+			if (priv->cpc.skb)
+				ipath_layer_send_skb(priv->dd, &priv->cpc);
+
+			if (priv->cpc.error == 0) {
+				if (priv->cpc.skb) {
+					dev_kfree_skb_any(priv->cpc.skb);
+					priv->cpc.skb = NULL;
+				}
+
+				netif_wake_queue(dev_ipath_ether[device]);
+			} else {
+				atomic_set(&send_continue, 1);
+
+				rc = 1;	/* don't clean the interrupt */
+			}
+		}
+	}
+
+	if (interrupts & IPATH_LAYER_INT_IF_DOWN) {
+		priv->ipath_ether_if_stat = IPATH_LAYER_DOWN;
+		dev_ipath_ether[device]->flags &= ~IFF_UP;
+		netif_stop_queue(dev_ipath_ether[device]);
+	}
+
+	if (interrupts & IPATH_LAYER_INT_LID) {
+		wakeup_needed = 1;
+
+		if (!priv->my_mac_addr[0] && !priv->my_mac_addr[1] &&
+		    !priv->my_mac_addr[2]) {
+			if (ipath_layer_get_mac
+			    (priv->dd, (uint8_t *) priv->my_mac_addr)) {
+				ipath_eth_warn("Fall back to default OUI, "
+					       "couldn't get MAC\n");
+				priv->my_mac_addr[0] = IPATH_SRC_OUI_1 |
+					(IPATH_SRC_OUI_2 << 8);
+				priv->my_mac_addr[1] = IPATH_SRC_OUI_3;
+			}
+		}
+
+		/* convert to network order */
+		priv->my_lid = htons(ipath_layer_get_lid(priv->dd));
+
+		memcpy(dev_ipath_ether[device]->dev_addr,
+		       priv->my_mac_addr,
+		       dev_ipath_ether[device]->addr_len);
+
+		/*
+		 * else get it below, after possible BCAST processing as
+		 * well or at open if mcast lid times out
+		 */
+	}
+
+	if (interrupts & IPATH_LAYER_INT_BCAST) {
+		wakeup_needed = 1;
+		/*
+		 * we may never get this, because some SMs don't support
+		 * multicast, so at open, we will do the same thing if the
+		 * wait for bcast times out
+		 */
+		priv->my_bcast = htons(ipath_layer_get_bcast(priv->dd));
+	}
+
+	if (interrupts & IPATH_LAYER_INT_IF_UP) {
+		/* after LID/MLID processing */
+		priv->ipath_ether_if_stat = IPATH_LAYER_UP;
+		/* in case we get both set as result of open */
+		if (priv->my_lid && priv->my_bcast) {
+			netif_wake_queue(dev_ipath_ether[device]);
+			dev_ipath_ether[device]->flags |= IFF_UP;
+		}
+	}
+
+	if (wakeup_needed) {
+		/*
+		 * arguably this should be waiting for lid and mlid,
+		 * but since mlid isn't the only possible path for now,
+		 * just wait for the lid.
+		 */
+		wake_up_interruptible(&priv->lid_wait);
+	}
+
+	return rc;
+}
+
+static int ipath_ether_open(struct net_device *dev)
+{
+	uint32_t mtu;
+	int rc;
+
+	rc = ipath_layer_open(priv_data(dev)->dd, &mtu);
+	if (rc != 0)
+		return rc;
+
+	/*
+	 * wait here until LID is set, otherwise "standard" networking
+	 * over ipath won't work, because we'll continue on through
+	 * starting up networking services, but ipath won't yet be usable,
+	 * since it takes up to 30 seconds for SM and sma to chat and get
+	 * our LID assigned.
+	 */
+	wait_event_interruptible_timeout(priv_data(dev)->lid_wait,
+					 priv_data(dev)->my_lid, 75 * HZ);
+
+	if (!priv_data(dev)->my_lid) {
+		ipath_eth_err("ipath_ether_open timed out waiting for LID -"
+			      " can't send packets\n");
+
+		return -EPERM;
+	}
+
+	wait_event_interruptible_timeout(priv_data(dev)->lid_wait,
+					 priv_data(dev)->my_bcast, 75 * HZ);
+
+	if (!priv_data(dev)->my_bcast) {
+		ipath_eth_err("ipath_ether_open timed out waiting for "
+			      "MLID - can't send packets\n");
+
+		return -EPERM;
+	}
+
+	_send_lid_message(priv_data(dev)->my_mac_addr,
+			  LID_ARP_RESPONSE, priv_data(dev)->my_bcast, dev);
+
+	dev->flags |= IFF_UP;
+	netif_wake_queue(dev);
+
+	return 0;
+}
+
+static int ipath_ether_close(struct net_device *dev)
+{
+	netif_stop_queue(dev);
+
+	return 0;
+}
+
+static struct net_device_stats *ipath_ether_get_stats(
+	struct net_device *dev)
+{
+	return &priv_data(dev)->ipath_ether_stats;
+}
+
+static int ipath_ether_change_mtu(struct net_device *dev, int new_mtu)
+{
+	/*
+	 * The MTU isn't really limited but we set an arbitrary limit of
+	 * 16 * 2108 - 12.  Which is 16 max infiniband sized packets minus
+	 * the ethernet header (except for the 2 bytes we put in the
+	 * ether_header header).
+	 */
+	if ((new_mtu < 68) || new_mtu > 33716 || (new_mtu & 3))
+		return -EINVAL;
+	dev->mtu = new_mtu;
+	return 0;
+}
+
+static void ipath_ether_set_multicast_list(struct net_device *dev)
+{
+	struct dev_mc_list *mc_mac_entry = dev->mc_list;
+
+	/*
+	 * No entries are really added but the can be displayed for debug
+	 * purpose
+	 */
+
+	while (mc_mac_entry) {
+		ipath_eth_table("Adding multicast MAC "
+				"[%02x:%02x:%02x:%02x:%02x:%02x]\n",
+				mc_mac_entry->dmi_addr[0],
+				mc_mac_entry->dmi_addr[1],
+				mc_mac_entry->dmi_addr[2],
+				mc_mac_entry->dmi_addr[3],
+				mc_mac_entry->dmi_addr[4],
+				mc_mac_entry->dmi_addr[5]);
+
+		mc_mac_entry = mc_mac_entry->next;
+	}
+}
+
+#ifdef ipath_ether_ioctl_support
+
+/**
+ * ipath_ether_get_settings - get ethernet device settings
+ * @dev: the network device
+ * @ecmd: the results are placed here
+ *
+ * This function is here to allow "ethtool eth<N>" to report something
+ * reasonable for infinipath.  We return values for 10Gb ethernet
+ * as being reasonably similar.
+ */
+static int ipath_ether_get_settings(struct net_device *dev,
+                                    struct ethtool_cmd *ecmd)
+{
+	ecmd->supported = SUPPORTED_10000baseT_Full;
+	ecmd->port = PORT_TP;
+	ecmd->transceiver = XCVR_INTERNAL;
+	ecmd->advertising = ADVERTISED_10000baseT_Full;
+	ecmd->speed = SPEED_10000;
+	ecmd->duplex = DUPLEX_FULL;
+	return 0;
+}
+
+static void ipath_ether_get_drvinfo(struct net_device *dev,
+				    struct ethtool_drvinfo *info)
+{
+	strcpy(info->driver, DRV_NAME);
+	strcpy(info->version, DRV_VERSION);
+	sprintf(info->bus_info, "InfiniPath");
+}
+
+static u32 ipath_ether_get_rx_csum(struct net_device *dev)
+{
+	return 0;
+}
+
+static u32 ipath_ether_get_tx_csum(struct net_device *dev)
+{
+	return (dev->features & NETIF_F_HW_CSUM) != 0;
+}
+
+static int ipath_ether_set_tx_csum(struct net_device *dev, u32 data)
+{
+	if (data)
+		dev->features |= NETIF_F_HW_CSUM;
+	else
+		dev->features &= ~NETIF_F_HW_CSUM;
+	return 0;
+}
+
+static int ipath_ether_get_tables(struct net_device *dev)
+{
+	int counter;
+	int index;
+	struct ether_hash *hash_entry;
+	uint8_t *mac_byte_ptr;
+	int num_of_entries = 0;
+
+	/* Only dump the hash table if the interface is up */
+	if (!(dev->flags & IFF_UP))
+		return 0;
+
+	ipath_eth_table("Dumping hash table ..\n");
+	for (counter = 0; counter < MAX_HASH_ENTRIES; counter++) {
+		hash_entry = &hash_table[counter];
+
+		if (hash_entry->lid == 0)
+			continue;
+
+		index = 1;
+		do {
+			num_of_entries++;
+
+			mac_byte_ptr = (uint8_t *) hash_entry->mac;
+			ipath_eth_table("%4d.%02d MAC = "
+					"%02x:%02x:%02x:%02x:%02x:%02x, "
+					"LID = %4d [0x%04x]\n",
+					counter, index++, mac_byte_ptr[0],
+					mac_byte_ptr[1], mac_byte_ptr[2],
+					mac_byte_ptr[3], mac_byte_ptr[4],
+					mac_byte_ptr[5],
+					ntohs(hash_entry->lid),
+					ntohs(hash_entry->lid));
+		} while ((hash_entry = hash_entry->next) != NULL);
+	}
+
+	ipath_eth_table("# of entries is %i\n", num_of_entries);
+
+	return 0;
+}
+
+static struct ethtool_ops ipath_ether_ethtool_ops = {
+	.get_settings = ipath_ether_get_settings,
+	.get_drvinfo = ipath_ether_get_drvinfo,
+	.get_rx_csum = ipath_ether_get_rx_csum,
+	.get_tx_csum = ipath_ether_get_tx_csum,
+	.set_tx_csum = ipath_ether_set_tx_csum,
+	.set_sg = ethtool_op_set_sg,
+	.get_sg = ethtool_op_get_sg,
+	.get_tso = ethtool_op_get_tso,
+	.get_stats_count = ipath_ether_get_tables
+};
+
+static int ipath_ether_ioctl(struct net_device *dev, struct ifreq *ifr,
+			     int cmd)
+{
+	switch (cmd) {
+
+	case SIOCGMIIPHY:	/* Get address of MII PHY in use. */
+		ipath_eth_dbg("Get address of MII PHY in use [%x]\n", cmd);
+		return 0;
+	case SIOCGMIIREG:	/* Read MII PHY register. */
+		ipath_eth_dbg("Read MII PHY register [%x]\n", cmd);
+		return 0;
+	case SIOCSMIIREG:	/* Write to MII PHY register. */
+		ipath_eth_dbg("Write to MII PHY register [%x]\n", cmd);
+		return 0;
+
+	case 0x8b01 /*SIOCGIWNAME*/:
+		/*
+		 * Wireless getname; see this on every startup, so
+		 * don't complain about it; don't want to include
+		 * wireless.h, so just use the value
+		 */
+		return -EOPNOTSUPP;
+
+	default:
+		/*
+		 * need to make this conditional, or remove it, some day
+		 * for now, we want to know about ioctls we get that we
+		 * don't support
+		 */
+		ipath_eth_dbg("got unsupported ipath_ether_ioctl with "
+			      "cmd = %x\n", cmd);
+		return -EOPNOTSUPP;
+	}
+}
+#endif
+
+int __init ipath_ether_probe(int device)
+{
+	struct ipath_devdata *dd;
+	int rc = -ENODEV;
+	unsigned int i;
+
+	/*
+	 * check for being able to register first, in case fewer infinipath
+	 * devices are present than are supported; we don't want to register
+	 * network devices for non-existent infinipath devices.
+	 */
+	rc = ipath_layer_register(device,
+				  ipath_ether_interrupt,
+				  ipath_ether_rx,
+				  OPCODE_ITH4X,
+				  ipath_ether_process_lid_arp, OPCODE_ITH4X,
+				  &dd);
+	if (rc < 0) {
+		ipath_eth_warn("Unable to register device %u: %d\n", device,
+			       -rc);
+		/*
+		 * this could be just fine, since we may have fewer than the
+		 * max supported chips present
+		 */
+		return -ENODEV;
+	}
+
+	dev_ipath_ether[device] = alloc_etherdev(32);
+	if (dev_ipath_ether[device] == NULL)
+		goto ipath_ether_probe_exit_level_0;
+
+	dev_ipath_ether[device]->priv = &private_data[device];
+
+	memset(&private_data[device], 0, sizeof(struct ipath_ether_priv));
+
+	SET_MODULE_OWNER(dev_ipath_ether[device]);
+
+	private_data[device].dd = dd;
+	private_data[device].device_id = device;
+	init_waitqueue_head(&private_data[device].lid_wait);
+
+	dev_ipath_ether[device]->flags &= ~IFF_UP;
+
+	dev_ipath_ether[device]->mtu = 16384;
+
+	/* The ipath_ether-specific entries in the device structure. */
+	dev_ipath_ether[device]->open = ipath_ether_open;
+	dev_ipath_ether[device]->hard_start_xmit = ipath_ether_start_xmit;
+	dev_ipath_ether[device]->stop = ipath_ether_close;
+	dev_ipath_ether[device]->get_stats = ipath_ether_get_stats;
+	dev_ipath_ether[device]->change_mtu = ipath_ether_change_mtu;
+	dev_ipath_ether[device]->set_multicast_list =
+		ipath_ether_set_multicast_list;
+	dev_ipath_ether[device]->tx_timeout = NULL;
+	dev_ipath_ether[device]->watchdog_timeo = TX_TIMEOUT;
+	dev_ipath_ether[device]->features |= NETIF_F_HW_CSUM | NETIF_F_SG |
+		NETIF_F_FRAGLIST | NETIF_F_HIGHDMA;
+
+#ifdef ipath_ether_ioctl_support
+	dev_ipath_ether[device]->do_ioctl = ipath_ether_ioctl;
+	dev_ipath_ether[device]->ethtool_ops = &ipath_ether_ethtool_ops;
+#else
+	dev_ipath_ether[device]->do_ioctl = NULL;
+#endif
+
+	private_data[device].fstate =
+		kzalloc(ipath_fragtable_size *
+			sizeof(struct ipath_frag_state), GFP_ATOMIC);
+
+	if (private_data[device].fstate == NULL) {
+		rc = -ENOMEM;
+		goto ipath_ether_probe_exit_level_0;
+	}
+
+	for (i = 0; i < ipath_fragtable_size; i++)
+		spin_lock_init(&private_data[device].fstate[i].lock);
+
+	/* make sure that the queue is inactive */
+	netif_stop_queue(dev_ipath_ether[device]);
+
+	/*
+	 * make an attempt to get our MAC address before registering with
+	 * the network layer.  This works as long as we are not overriding
+	 * the GUID or getting it from some method other than the flash.  It
+	 * increases the likelihood of SuSE network configuration working,
+	 * and is pretty much the right thing to do, in any case.
+	 */
+	(void)ipath_layer_get_mac(
+		private_data[device].dd,
+		(uint8_t *) private_data[device].my_mac_addr);
+	memcpy(dev_ipath_ether[device]->dev_addr,
+	       private_data[device].my_mac_addr,
+	       dev_ipath_ether[device]->addr_len);
+
+	strcpy(dev_ipath_ether[device]->name, "eth%d");
+	rc = register_netdev(dev_ipath_ether[device]);
+	if (rc != 0)
+		goto ipath_ether_probe_exit_level_1;
+
+	private_data[device].ipath_ether_stats.tx_fifo_errors = 0;
+	private_data[device].ipath_ether_stats.tx_carrier_errors = 0;
+
+	return 0;
+
+ipath_ether_probe_exit_level_1:
+	if (private_data[device].fstate != NULL) {
+		kfree(private_data[device].fstate);
+		private_data[device].fstate = NULL;
+	}
+
+	free_netdev(dev_ipath_ether[device]);
+
+ipath_ether_probe_exit_level_0:
+	return rc;
+}
+
+int __init ipath_ether_init(void)
+{
+	int counter, nfound = 0;
+	int rc, lasterr = 0;
+
+	/* safety checks */
+	if (!&ipath_debug) {
+		/*
+		 * This has occasionally been seen when the module load code
+		 * has errors loading dependent modules.  This prevents an
+		 * oops, and makes it more obvious what happened.  Have to
+		 * use printk() directly for this one
+		 */
+		printk(KERN_ERR "Module error, %s loading, but ipath_core "
+		       "not loaded!\n", DRV_NAME);
+		return -ENODEV;
+	}
+	if (sizeof(struct ips_message_header) !=
+	    sizeof(struct ether_header)) {
+		ipath_eth_err("FATAL ERROR (ipath_ether_init): header size "
+			      "is wrong [%i<>%i]!!!\n",
+			      (int)sizeof(struct ips_message_header),
+			      (int)sizeof(struct ether_header));
+		return -ENODEV;
+	}
+
+	number_of_devices = ipath_layer_get_num_of_dev();
+
+	for (counter = 0; counter < number_of_devices; counter++) {
+		rc = ipath_ether_probe(counter);
+		if (rc)
+			lasterr = rc;
+		else
+			nfound++;
+	}
+	if (!nfound)
+		return lasterr;	/* no usable devices were found */
+
+	return 0;
+}
+
+void __exit ipath_ether_exit(void)
+{
+	int counter, ninuse = 0;
+
+	for (counter = 0; counter < number_of_devices; counter++) {
+		ipath_layer_close(private_data[counter].dd);
+
+		if (!dev_ipath_ether[counter])
+			/*
+			 * never registered, probably infinipath device
+			 * not present
+			 */
+			continue;
+		ninuse++;
+		unregister_netdev(dev_ipath_ether[counter]);
+		free_netdev(dev_ipath_ether[counter]);
+
+		dev_ipath_ether[counter] = NULL;
+
+		if (private_data[counter].fstate != NULL) {
+			kfree(private_data[counter].fstate);
+			private_data[counter].fstate = NULL;
+		}
+	}
+
+	if (ninuse <= 1) {	/* only if none are in use */
+		while (all_hash_entries) {
+			struct ether_hash *next = all_hash_entries->next;
+
+			kfree(all_hash_entries);
+			all_hash_entries = next;
+		}
+	}
+}
