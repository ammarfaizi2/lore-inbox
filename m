Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVCEN7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVCEN7k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 08:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVCEN7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 08:59:39 -0500
Received: from tempo.di-net.ru ([213.248.12.5]:50693 "EHLO tempo.di-net.ru")
	by vger.kernel.org with ESMTP id S261315AbVCEN6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 08:58:02 -0500
Date: Sat, 5 Mar 2005 16:57:13 +0300
From: Leo Yuriev <leo@yuriev.ru>
X-Mailer: The Bat! (v3.0.1.33) Professional
Reply-To: "leo.yuriev.ru" <leo@yuriev.ru>
X-Priority: 3 (Normal)
Message-ID: <1199527299.20050305165713@yuriev.ru>
To: Lennert Buytenhek <buytenh@gnu.org>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] ethernet-bridge: update skb->priority in case forwarded frame has VLAN-header
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-1.6 (tempo.di-net.ru [213.248.12.5]); Sat, 05 Mar 2005 16:57:26 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.6 (2.6.11)

When ethernet-bridge forward a packet and such ethernet-frame has
VLAN-tag, bridge should update skb->prioriry for properly QoS
handling.

This small patch does this. Currently vlan_TCI-priority directly
mapped to skb->priority, but this looks enough.

Patch-by: Leo Yuriev <leo@yuriev.ru>


-- net/bridge/br_input.c.orig   2005-03-02 10:37:50.000000000 +0300
+++ net/bridge/br_input.c       2005-03-05 16:11:00.000000000 +0300
@@ -5,6 +5,10 @@
  *     Authors:
  *     Lennert Buytenhek               <buytenh@gnu.org>
  *
+ *     Changes:
+ *             03/Mar/2005: Leo Yuriev <leo@yuriev.ru>
+ *             Update skb->priority for packets with VLAN-tag.
+ *
  *     $Id: br_input.c,v 1.10 2001/12/24 04:50:20 davem Exp $
  *
  *     This program is free software; you can redistribute it and/or
@@ -17,6 +21,9 @@
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
 #include <linux/netfilter_bridge.h>
+#ifdef CONFIG_NET_SCHED
+#      include <linux/if_vlan.h>
+#endif /* CONFIG_NET_SCHED*/
 #include "br_private.h"
 
 const unsigned char bridge_ula[6] = { 0x01, 0x80, 0xc2, 0x00, 0x00, 0x00 };
@@ -45,6 +52,40 @@ static void br_pass_frame_up(struct net_
                        br_pass_frame_up_finish);
 }
 
+
+#ifdef CONFIG_NET_SCHED
+/*
+ *   Leo Yuriev: Just update skb->priority for properly QoS handling in case
+ *               frame in the skb is contain VLAN-header.
+ *
+ *  SANITY NOTE: We are referencing to the VLAN_HDR frields, which MAY be
+ *               stored UNALIGNED in the memory.
+ *               According to Dave Miller & Alexey, it will always be aligned,
+ *               so there doesn't need to be any of the unaligned stuff.
+ *
+ */
+static __inline__ void br_update_skb_priority_if_vlan(struct sk_buff *skb)
+{
+       unsigned short vlan_TCI;
+       struct vlan_hdr *vhdr;
+
+       if (skb->protocol == __constant_htons(ETH_P_8021Q)) {
+               vhdr = (struct vlan_hdr *)(skb->data);
+               /* vlan_TCI = ntohs(get_unaligned(&vhdr->h_vlan_TCI)); */
+               vlan_TCI = ntohs(vhdr->h_vlan_TCI);
+#ifdef VLAN_DEBUG
+               printk(VLAN_DBG "%s: skb: %p vlan_id: %hx\n",
+                       __FUNCTION__, skb, (vlan_TCI & VLAN_VID_MASK));
+#endif
+               /*
+                *   We map VLAN_TCI priority (0..7) to skb->priority (0..15) 
+                *   most similarly e.g. 0->0, 1->1, .., 7->7
+                */
+               skb->priority = (vlan_TCI >> 13) & 7;
+       }
+}
+#endif /* CONFIG_NET_SCHED */
+
 /* note: already called with rcu_read_lock (preempt_disabled) */
 int br_handle_frame_finish(struct sk_buff *skb)
 {
@@ -54,6 +95,10 @@ int br_handle_frame_finish(struct sk_buf
        struct net_bridge_fdb_entry *dst;
        int passedup = 0;
 
+#ifdef CONFIG_NET_SCHED
+       br_update_skb_priority_if_vlan(skb);
+#endif /* CONFIG_NET_SCHED*/
+
        if (br->dev->flags & IFF_PROMISC) {
                struct sk_buff *skb2;


