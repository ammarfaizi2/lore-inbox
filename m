Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266114AbSL2BQd>; Sat, 28 Dec 2002 20:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266116AbSL2BQd>; Sat, 28 Dec 2002 20:16:33 -0500
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.224]:30694 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S266114AbSL2BQb>; Sat, 28 Dec 2002 20:16:31 -0500
Date: Sat, 28 Dec 2002 20:17:19 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@linux-dev
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.53 : net/atm/lec.c
Message-ID: <Pine.LNX.4.44.0212282007210.952-100000@linux-dev>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following patch swaps the save_flags/cli/restore_flags for a 
spinlock. Please review. 

Regards,
Frank

--- linux/net/atm/lec.c.old	Sat Oct 19 12:08:19 2002
+++ linux/net/atm/lec.c	Sat Dec 28 20:14:50 2002
@@ -20,7 +20,7 @@
 #include <net/arp.h>
 #include <net/dst.h>
 #include <linux/proc_fs.h>
-
+#include <linux/spinlock.h>
 /* TokenRing if needed */
 #ifdef CONFIG_TR
 #include <linux/trdevice.h>
@@ -63,6 +63,7 @@
 
 #define LEC_UNRES_QUE_LEN 8 /* number of tx packets to queue for a
                                single destination while waiting for SVC */
+static spinlock_t lec_lock = SPIN_LOCK_UNLOCKED;
 
 static int lec_open(struct net_device *dev);
 static int lec_send_packet(struct sk_buff *skb, struct net_device *dev);
@@ -1110,8 +1111,7 @@
         unsigned long flags;
         struct lec_arp_table *tmp;
 
-        save_flags(flags);
-        cli();
+        spin_lock_irqsave(&lec_lock, flags);
 
         place = HASH(to_put->mac_addr[ETH_ALEN-1]);
         tmp = lec_arp_tables[place];
@@ -1125,7 +1125,7 @@
                 tmp->next = to_put;
         }
 
-        restore_flags(flags);
+        spin_unlock_irqrestore(&lec_lock, flags);
         DPRINTK("LEC_ARP: Added entry:%2.2x %2.2x %2.2x %2.2x %2.2x %2.2x\n",
                 0xff&to_put->mac_addr[0], 0xff&to_put->mac_addr[1],
                 0xff&to_put->mac_addr[2], 0xff&to_put->mac_addr[3],
@@ -1144,11 +1144,10 @@
         unsigned long flags;
         int remove_vcc=1;
 
-        save_flags(flags);
-        cli();
+        spin_lock_irqsave(&lec_lock, flags);
 
         if (!to_remove) {
-                restore_flags(flags);
+                spin_unlock_irqrestore(&lec_lock, flags);
                 return -1;
         }
         place = HASH(to_remove->mac_addr[ETH_ALEN-1]);
@@ -1160,7 +1159,7 @@
                         tmp = tmp->next;
                 }
                 if (!tmp) {/* Entry was not found */
-                        restore_flags(flags);
+                        spin_unlock_irqrestore(&lec_lock, flags);
                         return -1;
                 }
         }
@@ -1186,7 +1185,7 @@
                         lec_arp_clear_vccs(to_remove);
         }
         skb_queue_purge(&to_remove->tx_wait); /* FIXME: good place for this? */
-        restore_flags(flags);
+        spin_unlock_irqrestore(&lec_lock, flags);
         DPRINTK("LEC_ARP: Removed entry:%2.2x %2.2x %2.2x %2.2x %2.2x %2.2x\n",
                 0xff&to_remove->mac_addr[0], 0xff&to_remove->mac_addr[1],
                 0xff&to_remove->mac_addr[2], 0xff&to_remove->mac_addr[3],
@@ -1374,8 +1373,7 @@
         unsigned long flags;
         int i;
 
-        save_flags(flags);
-        cli();
+        spin_lock_irqsave(&lec_lock, flags);
 
         del_timer(&priv->lec_arp_timer);
         
@@ -1419,7 +1417,7 @@
         priv->mcast_vcc = NULL;
         memset(priv->lec_arp_tables, 0, 
                sizeof(struct lec_arp_table*)*LEC_ARP_TABLE_SIZE);
-        restore_flags(flags);
+        spin_unlock_irqrestore(&lec_lock, flags);
 }
 
 
@@ -2150,14 +2148,13 @@
         lec_arp_lock(priv);
         entry = priv->lec_arp_empty_ones;
         if (vcc == entry->vcc) {
-                save_flags(flags);
-                cli();
+                spin_lock_irqsave(&lec_lock, flags);
                 del_timer(&entry->timer);
                 memcpy(entry->mac_addr, src, ETH_ALEN);
                 entry->status = ESI_FORWARD_DIRECT;
                 entry->last_used = jiffies;
                 priv->lec_arp_empty_ones = entry->next;
-                restore_flags(flags);
+                spin_unlock_irqrestore(&lec_lock, flags);
                 /* We might have got an entry */
                 if ((prev=lec_arp_find(priv,src))) {
                         lec_arp_remove(priv->lec_arp_tables, prev);
@@ -2178,14 +2175,13 @@
                 lec_arp_unlock(priv);
                 return;
         }
-        save_flags(flags);
-        cli();
+        spin_lock_irqsave(&lec_lock, flags);
         del_timer(&entry->timer);
         memcpy(entry->mac_addr, src, ETH_ALEN);
         entry->status = ESI_FORWARD_DIRECT;
         entry->last_used = jiffies;
         prev->next = entry->next;
-        restore_flags(flags);
+        spin_unlock_irqresore(&lec_lock, flags);
         if ((prev = lec_arp_find(priv, src))) {
                 lec_arp_remove(priv->lec_arp_tables,prev);
                 kfree(prev);

