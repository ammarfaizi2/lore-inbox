Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266356AbTBTRls>; Thu, 20 Feb 2003 12:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266408AbTBTRls>; Thu, 20 Feb 2003 12:41:48 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:10378 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S266356AbTBTRlX>; Thu, 20 Feb 2003 12:41:23 -0500
Date: Thu, 20 Feb 2003 12:51:20 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Message-Id: <200302201751.h1KHpKqA009567@locutus.cmf.nrl.navy.mil>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][ATM] cli() for net/atm/lec.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the bulk of the cli() -> spinlock() conversion was done by Mike Westall
<westall@cs.clemson.edu>.  i fixed a double locking issue and made the
following changes:

. renamed lec_arp_lock/lec_arp_unlock (since it seems confusing to have
LEC_ARP_LOCK and lec_arp_lock) to lec_arp_get/lec_arp_put since these
seem to be doing reference counting

. lec_arp_lock_var was renamed to lec_arp_users

. read lec_arp_lock_var with atomic_read()!

. the original lec_arp_put was renamed to lec_arp_add (so we have the
put/get and add/remove pairs)

this is just a start at cleaning up some of the lec client code. 
comments?

Index: linux/net/atm/lec.c
===================================================================
RCS file: /home/chas/CVSROOT/linux/net/atm/lec.c,v
retrieving revision 1.1.1.1
diff -u -d -b -w -r1.1.1.1 lec.c
--- linux/net/atm/lec.c	20 Feb 2003 13:46:30 -0000	1.1.1.1
+++ linux/net/atm/lec.c	20 Feb 2003 15:00:39 -0000
@@ -20,6 +20,7 @@
 #include <net/arp.h>
 #include <net/dst.h>
 #include <linux/proc_fs.h>
+#include <linux/spinlock.h>
 
 /* TokenRing if needed */
 #ifdef CONFIG_TR
@@ -54,7 +55,11 @@
 extern struct net_bridge_fdb_entry *(*br_fdb_get_hook)(struct net_bridge *br,
 	unsigned char *addr);
 extern void (*br_fdb_put_hook)(struct net_bridge_fdb_entry *ent);
+static spinlock_t lec_arp_spinlock = SPIN_LOCK_UNLOCKED;
+static unsigned long lec_arp_flags;
 
+#define LEC_ARP_LOCK()   spin_lock_irqsave(&lec_arp_spinlock, lec_arp_flags);
+#define LEC_ARP_UNLOCK() spin_unlock_irqrestore(&lec_arp_spinlock, lec_arp_flags);
 
 #define DUMP_PACKETS 0 /* 0 = None,
                         * 1 = 30 first bytes
@@ -634,6 +639,7 @@
         dev->get_stats = lec_get_stats;
         dev->set_multicast_list = NULL;
         dev->do_ioctl  = NULL;
+	spin_lock_init(&lec_arp_spinlock);
         printk("%s: Initialized!\n",dev->name);
         return;
 }
@@ -1044,15 +1050,15 @@
 #define HASH(ch) (ch & (LEC_ARP_TABLE_SIZE -1))
 
 static __inline__ void 
-lec_arp_lock(struct lec_priv *priv)
+lec_arp_get(struct lec_priv *priv)
 {
-        atomic_inc(&priv->lec_arp_lock_var);
+        atomic_inc(&priv->lec_arp_users);
 }
 
 static __inline__ void 
-lec_arp_unlock(struct lec_priv *priv)
+lec_arp_put(struct lec_priv *priv)
 {
-        atomic_dec(&priv->lec_arp_lock_var);
+        atomic_dec(&priv->lec_arp_users);
 }
 
 /*
@@ -1103,33 +1109,32 @@
  * LANE2: Add to the end of the list to satisfy 8.1.13
  */
 static __inline__ void 
-lec_arp_put(struct lec_arp_table **lec_arp_tables, 
-            struct lec_arp_table *to_put)
+lec_arp_add(struct lec_arp_table **lec_arp_tables, 
+            struct lec_arp_table *to_add)
 {
         unsigned short place;
-        unsigned long flags;
         struct lec_arp_table *tmp;
 
-        save_flags(flags);
-        cli();
+        LEC_ARP_LOCK();
 
-        place = HASH(to_put->mac_addr[ETH_ALEN-1]);
+        place = HASH(to_add->mac_addr[ETH_ALEN-1]);
         tmp = lec_arp_tables[place];
-        to_put->next = NULL;
+        to_add->next = NULL;
         if (tmp == NULL)
-                lec_arp_tables[place] = to_put;
+                lec_arp_tables[place] = to_add;
   
         else {  /* add to the end */
                 while (tmp->next)
                         tmp = tmp->next;
-                tmp->next = to_put;
+                tmp->next = to_add;
         }
 
-        restore_flags(flags);
+        LEC_ARP_UNLOCK();
+
         DPRINTK("LEC_ARP: Added entry:%2.2x %2.2x %2.2x %2.2x %2.2x %2.2x\n",
-                0xff&to_put->mac_addr[0], 0xff&to_put->mac_addr[1],
-                0xff&to_put->mac_addr[2], 0xff&to_put->mac_addr[3],
-                0xff&to_put->mac_addr[4], 0xff&to_put->mac_addr[5]);
+                0xff&to_add->mac_addr[0], 0xff&to_add->mac_addr[1],
+                0xff&to_add->mac_addr[2], 0xff&to_add->mac_addr[3],
+                0xff&to_add->mac_addr[4], 0xff&to_add->mac_addr[5]);
 }
 
 /*
@@ -1141,14 +1146,12 @@
 {
         unsigned short place;
         struct lec_arp_table *tmp;
-        unsigned long flags;
         int remove_vcc=1;
 
-        save_flags(flags);
-        cli();
+        LEC_ARP_LOCK();
 
         if (!to_remove) {
-                restore_flags(flags);
+                LEC_ARP_UNLOCK();
                 return -1;
         }
         place = HASH(to_remove->mac_addr[ETH_ALEN-1]);
@@ -1160,7 +1163,7 @@
                         tmp = tmp->next;
                 }
                 if (!tmp) {/* Entry was not found */
-                        restore_flags(flags);
+                        LEC_ARP_UNLOCK();
                         return -1;
                 }
         }
@@ -1186,7 +1189,9 @@
                         lec_arp_clear_vccs(to_remove);
         }
         skb_queue_purge(&to_remove->tx_wait); /* FIXME: good place for this? */
-        restore_flags(flags);
+
+        LEC_ARP_UNLOCK();
+
         DPRINTK("LEC_ARP: Removed entry:%2.2x %2.2x %2.2x %2.2x %2.2x %2.2x\n",
                 0xff&to_remove->mac_addr[0], 0xff&to_remove->mac_addr[1],
                 0xff&to_remove->mac_addr[2], 0xff&to_remove->mac_addr[3],
@@ -1371,12 +1376,8 @@
 lec_arp_destroy(struct lec_priv *priv)
 {
         struct lec_arp_table *entry, *next;
-        unsigned long flags;
         int i;
 
-        save_flags(flags);
-        cli();
-
         del_timer(&priv->lec_arp_timer);
         
         /*
@@ -1419,7 +1420,6 @@
         priv->mcast_vcc = NULL;
         memset(priv->lec_arp_tables, 0, 
                sizeof(struct lec_arp_table*)*LEC_ARP_TABLE_SIZE);
-        restore_flags(flags);
 }
 
 
@@ -1436,18 +1436,18 @@
         DPRINTK("LEC_ARP: lec_arp_find :%2.2x %2.2x %2.2x %2.2x %2.2x %2.2x\n",
                 mac_addr[0]&0xff, mac_addr[1]&0xff, mac_addr[2]&0xff, 
                 mac_addr[3]&0xff, mac_addr[4]&0xff, mac_addr[5]&0xff);
-        lec_arp_lock(priv);
+        lec_arp_get(priv);
         place = HASH(mac_addr[ETH_ALEN-1]);
   
         to_return = priv->lec_arp_tables[place];
         while(to_return) {
                 if (memcmp(mac_addr, to_return->mac_addr, ETH_ALEN) == 0) {
-                        lec_arp_unlock(priv);
+                        lec_arp_put(priv);
                         return to_return;
                 }
                 to_return = to_return->next;
         }
-        lec_arp_unlock(priv);
+        lec_arp_put(priv);
         return NULL;
 }
 
@@ -1574,11 +1574,11 @@
         del_timer(&priv->lec_arp_timer);
 
         DPRINTK("lec_arp_check_expire %p,%d\n",priv,
-                priv->lec_arp_lock_var.counter);
+                atomic_read(&priv->lec_arp_users));
         DPRINTK("expire: eo:%p nf:%p\n",priv->lec_arp_empty_ones,
                 priv->lec_no_forward);
-        if (!priv->lec_arp_lock_var.counter) {
-                lec_arp_lock(priv);
+        if (!atomic_read(&priv->lec_arp_users)) {
+                lec_arp_get(priv);
                 now = jiffies;
                 for(i=0;i<LEC_ARP_TABLE_SIZE;i++) {
                         for(entry = lec_arp_tables[i];entry != NULL;) {
@@ -1624,7 +1624,7 @@
                                 }
                         }
                 }
-                lec_arp_unlock(priv);
+                lec_arp_put(priv);
         }
         priv->lec_arp_timer.expires = jiffies + LEC_ARP_REFRESH_INTERVAL;
         add_timer(&priv->lec_arp_timer);
@@ -1686,7 +1686,7 @@
                 if (!entry) {
                         return priv->mcast_vcc;
                 }
-                lec_arp_put(priv->lec_arp_tables, entry);
+                lec_arp_add(priv->lec_arp_tables, entry);
                 /* We want arp-request(s) to be sent */
                 entry->packets_flooded =1;
                 entry->status = ESI_ARP_PENDING;
@@ -1711,7 +1711,7 @@
         struct lec_arp_table *entry, *next;
         int i;
 
-        lec_arp_lock(priv);
+        lec_arp_get(priv);
         DPRINTK("lec_addr_delete\n");
         for(i=0;i<LEC_ARP_TABLE_SIZE;i++) {
                 for(entry=priv->lec_arp_tables[i];entry != NULL; entry=next) {
@@ -1722,11 +1722,11 @@
                                 lec_arp_remove(priv->lec_arp_tables, entry);
                                 kfree(entry);
                         }
-                        lec_arp_unlock(priv);
+                        lec_arp_put(priv);
                         return 0;
                 }
         }
-        lec_arp_unlock(priv);
+        lec_arp_put(priv);
         return -1;
 }
 
@@ -1751,7 +1751,7 @@
                 return;   /* LANE2: ignore targetless LE_ARPs for which
                            * we have no entry in the cache. 7.1.30
                            */
-        lec_arp_lock(priv);
+        lec_arp_get(priv);
         if (priv->lec_arp_empty_ones) {
                 entry = priv->lec_arp_empty_ones;
                 if (!memcmp(entry->atm_addr, atm_addr, ATM_ESA_LEN)) {
@@ -1785,13 +1785,13 @@
                                 entry->status = ESI_FORWARD_DIRECT;
                                 memcpy(entry->mac_addr, mac_addr, ETH_ALEN);
                                 entry->last_used = jiffies;
-                                lec_arp_put(priv->lec_arp_tables, entry);
+                                lec_arp_add(priv->lec_arp_tables, entry);
                         }
                         if (remoteflag)
                                 entry->flags|=LEC_REMOTE_FLAG;
                         else
                                 entry->flags&=~LEC_REMOTE_FLAG;
-                        lec_arp_unlock(priv);
+                        lec_arp_put(priv);
                         DPRINTK("After update\n");
                         dump_arp_table(priv);
                         return;
@@ -1801,11 +1801,11 @@
         if (!entry) {
                 entry = make_entry(priv, mac_addr);
                 if (!entry) {
-                        lec_arp_unlock(priv);
+                        lec_arp_put(priv);
                         return;
                 }
                 entry->status = ESI_UNKNOWN;
-                lec_arp_put(priv->lec_arp_tables, entry);
+                lec_arp_add(priv->lec_arp_tables, entry);
                 /* Temporary, changes before end of function */
         }
         memcpy(entry->atm_addr, atm_addr, ATM_ESA_LEN);
@@ -1840,7 +1840,7 @@
         }
         DPRINTK("After update2\n");
         dump_arp_table(priv);
-        lec_arp_unlock(priv);
+        lec_arp_put(priv);
 }
 
 /*
@@ -1854,7 +1854,7 @@
         struct lec_arp_table *entry;
         int i, found_entry=0;
 
-        lec_arp_lock(priv);
+        lec_arp_get(priv);
         if (ioc_data->receive == 2) {
                 /* Vcc for Multicast Forward. No timer, LANEv2 7.1.20 and 2.3.5.3 */
 
@@ -1863,7 +1863,7 @@
                 entry = lec_arp_find(priv, bus_mac);
                 if (!entry) {
                         printk("LEC_ARP: Multicast entry not found!\n");
-                        lec_arp_unlock(priv);
+                        lec_arp_put(priv);
                         return;
                 }
                 memcpy(entry->atm_addr, ioc_data->atm_addr, ATM_ESA_LEN);
@@ -1872,7 +1872,7 @@
 #endif
                 entry = make_entry(priv, bus_mac);
                 if (entry == NULL) {
-                        lec_arp_unlock(priv);
+                        lec_arp_put(priv);
                         return;
                 }
                 del_timer(&entry->timer);
@@ -1881,7 +1881,7 @@
                 entry->old_recv_push = old_push;
                 entry->next = priv->mcast_fwds;
                 priv->mcast_fwds = entry;
-                lec_arp_unlock(priv);
+                lec_arp_put(priv);
                 return;
         } else if (ioc_data->receive == 1) {
                 /* Vcc which we don't want to make default vcc, attach it
@@ -1899,7 +1899,7 @@
                         ioc_data->atm_addr[18],ioc_data->atm_addr[19]);
                 entry = make_entry(priv, bus_mac);
                 if (entry == NULL) {
-                        lec_arp_unlock(priv);
+                        lec_arp_put(priv);
                         return;
                 }
                 memcpy(entry->atm_addr, ioc_data->atm_addr, ATM_ESA_LEN);
@@ -1912,7 +1912,7 @@
                 add_timer(&entry->timer);
                 entry->next = priv->lec_no_forward;
                 priv->lec_no_forward = entry;
-                lec_arp_unlock(priv);
+                lec_arp_put(priv);
 		dump_arp_table(priv);
                 return;
         }
@@ -1971,7 +1971,7 @@
                 }
         }
         if (found_entry) {
-                lec_arp_unlock(priv);
+                lec_arp_put(priv);
                 DPRINTK("After vcc was added\n");
                 dump_arp_table(priv);
                 return;
@@ -1980,7 +1980,7 @@
            this vcc */
         entry = make_entry(priv, bus_mac);
         if (!entry) {
-                lec_arp_unlock(priv);
+                lec_arp_put(priv);
                 return;
         }
         entry->vcc = vcc;
@@ -1993,7 +1993,7 @@
         entry->timer.expires = jiffies + priv->vcc_timeout_period;
         entry->timer.function = lec_arp_expire_vcc;
         add_timer(&entry->timer);
-        lec_arp_unlock(priv);
+        lec_arp_put(priv);
         DPRINTK("After vcc was added\n");
 	dump_arp_table(priv);
 }
@@ -2039,10 +2039,10 @@
                 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
         struct lec_arp_table *to_add;
   
-        lec_arp_lock(priv);
+        lec_arp_get(priv);
         to_add = make_entry(priv, mac_addr);
         if (!to_add) {
-                lec_arp_unlock(priv);
+                lec_arp_put(priv);
                 return -ENOMEM;
         }
         memcpy(to_add->atm_addr, vcc->remote.sas_addr.prv, ATM_ESA_LEN);
@@ -2052,8 +2052,8 @@
         to_add->old_push = vcc->push;
         vcc->push = lec_push;
         priv->mcast_vcc = vcc;
-        lec_arp_put(priv->lec_arp_tables, to_add);
-        lec_arp_unlock(priv);
+        lec_arp_add(priv->lec_arp_tables, to_add);
+        lec_arp_put(priv);
         return 0;
 }
 
@@ -2065,7 +2065,7 @@
 
         DPRINTK("LEC_ARP: lec_vcc_close vpi:%d vci:%d\n",vcc->vpi,vcc->vci);
         dump_arp_table(priv);
-        lec_arp_lock(priv);
+        lec_arp_get(priv);
         for(i=0;i<LEC_ARP_TABLE_SIZE;i++) {
                 for(entry = priv->lec_arp_tables[i];entry; entry=next) {
                         next = entry->next;
@@ -2127,7 +2127,7 @@
                 entry = next;
         }
 
-        lec_arp_unlock(priv);
+        lec_arp_put(priv);
 	dump_arp_table(priv);
 }
 
@@ -2137,7 +2137,6 @@
 {
         struct lec_arp_table *entry, *prev;
         struct lecdatahdr_8023 *hdr = (struct lecdatahdr_8023 *)skb->data;
-        unsigned long flags;
         unsigned char *src;
 #ifdef CONFIG_TR
         struct lecdatahdr_8025 *tr_hdr = (struct lecdatahdr_8025 *)skb->data;
@@ -2147,24 +2146,23 @@
 #endif
         src = hdr->h_source;
 
-        lec_arp_lock(priv);
+        lec_arp_get(priv);
         entry = priv->lec_arp_empty_ones;
         if (vcc == entry->vcc) {
-                save_flags(flags);
-                cli();
+                LEC_ARP_LOCK();
                 del_timer(&entry->timer);
                 memcpy(entry->mac_addr, src, ETH_ALEN);
                 entry->status = ESI_FORWARD_DIRECT;
                 entry->last_used = jiffies;
                 priv->lec_arp_empty_ones = entry->next;
-                restore_flags(flags);
+                LEC_ARP_UNLOCK();
                 /* We might have got an entry */
                 if ((prev=lec_arp_find(priv,src))) {
                         lec_arp_remove(priv->lec_arp_tables, prev);
                         kfree(prev);
                 }
-                lec_arp_put(priv->lec_arp_tables, entry);
-                lec_arp_unlock(priv);
+                lec_arp_add(priv->lec_arp_tables, entry);
+                lec_arp_put(priv);
                 return;
         }
         prev = entry;
@@ -2175,22 +2173,21 @@
         }
         if (!entry) {
                 DPRINTK("LEC_ARP: Arp_check_empties: entry not found!\n");
-                lec_arp_unlock(priv);
+                lec_arp_put(priv);
                 return;
         }
-        save_flags(flags);
-        cli();
+        LEC_ARP_LOCK();
         del_timer(&entry->timer);
         memcpy(entry->mac_addr, src, ETH_ALEN);
         entry->status = ESI_FORWARD_DIRECT;
         entry->last_used = jiffies;
         prev->next = entry->next;
-        restore_flags(flags);
+        LEC_ARP_UNLOCK();
         if ((prev = lec_arp_find(priv, src))) {
                 lec_arp_remove(priv->lec_arp_tables,prev);
                 kfree(prev);
         }
-        lec_arp_put(priv->lec_arp_tables,entry);
-        lec_arp_unlock(priv);  
+        lec_arp_add(priv->lec_arp_tables,entry);
+        lec_arp_put(priv);  
 }
 MODULE_LICENSE("GPL");
Index: linux/net/atm/lec.h
===================================================================
RCS file: /home/chas/CVSROOT/linux/net/atm/lec.h,v
retrieving revision 1.1.1.1
diff -u -d -b -w -r1.1.1.1 lec.h
--- linux/net/atm/lec.h	20 Feb 2003 13:46:30 -0000	1.1.1.1
+++ linux/net/atm/lec.h	20 Feb 2003 14:55:55 -0000
@@ -98,7 +98,7 @@
            establishes multiple Multicast Forward VCCs to us. This list
            collects all those VCCs. LANEv1 client has only one item in this
            list. These entries are not aged out. */
-        atomic_t lec_arp_lock_var;
+        atomic_t lec_arp_users;
         struct atm_vcc *mcast_vcc; /* Default Multicast Send VCC */
         struct atm_vcc *lecd;
         struct timer_list lec_arp_timer;
