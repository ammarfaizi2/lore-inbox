Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261521AbTCTPJ3>; Thu, 20 Mar 2003 10:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261532AbTCTPIe>; Thu, 20 Mar 2003 10:08:34 -0500
Received: from fmr01.intel.com ([192.55.52.18]:58069 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S261521AbTCTPG4>;
	Thu, 20 Mar 2003 10:06:56 -0500
Date: Thu, 20 Mar 2003 17:17:46 +0200 (IST)
From: Shmulik Hen <hshmulik@intel.com>
X-X-Sender: hshmulik@jrslxjul4.npdj.intel.com
To: Bonding Developement list <bonding-devel@lists.sourceforge.net>,
       Bonding Announce list <bonding-announce@lists.sourceforge.net>,
       Linux Net Mailing list <linux-net@vger.kernel.org>,
       Linux Kernel Mailing list <linux-kernel@vger.kernel.org>,
       Oss SGI Netdev list <netdev@oss.sgi.com>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: [patch] (7/8) Add 802.3ad support to bonding
Message-ID: <Pine.LNX.4.44.0303201655400.10351-100000@jrslxjul4.npdj.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the driver's private data types from 
include/linux/if_bonding.h to the local bonding.h.

This patch is against bonding 2.4.20-20030317.

diff -Nuarp linux-2.4.20-bonding-20030317/drivers/net/bonding/bonding.h linux-2.4.20-bonding-20030317-devel/drivers/net/bonding/bonding.h
--- linux-2.4.20-bonding-20030317/drivers/net/bonding/bonding.h	1970-01-01 02:00:00.000000000 +0200
+++ linux-2.4.20-bonding-20030317-devel/drivers/net/bonding/bonding.h	2003-03-18 17:03:31.000000000 +0200
@@ -0,0 +1,68 @@
+/*
+ * Bond several ethernet interfaces into a Cisco, running 'Etherchannel'.
+ * 
+ * Portions are (c) Copyright 1995 Simon "Guru Aleph-Null" Janes
+ * NCM: Network and Communications Management, Inc.
+ *
+ * BUT, I'm the one who modified it for ethernet, so:
+ * (c) Copyright 1999, Thomas Davis, tadavis@lbl.gov
+ *
+ *	This software may be used and distributed according to the terms
+ *	of the GNU Public License, incorporated herein by reference.
+ * 
+ */
+ 
+#ifndef _LINUX_BONDING_H
+#define _LINUX_BONDING_H
+
+#include <linux/timer.h>
+#include <linux/proc_fs.h>
+
+typedef struct slave {
+	struct slave *next;
+	struct slave *prev;
+	struct net_device *dev;
+	short  delay;
+	unsigned long jiffies;
+	char   link;    /* one of BOND_LINK_XXXX */
+	char   state;   /* one of BOND_STATE_XXXX */
+	unsigned short original_flags;
+	u32 link_failure_count;
+	u16    speed;
+	u8     duplex;
+	u8     perm_hwaddr[ETH_ALEN];
+} slave_t;
+
+/*
+ * Here are the locking policies for the two bonding locks:
+ *
+ * 1) Get bond->lock when reading/writing slave list.
+ * 2) Get bond->ptrlock when reading/writing bond->current_slave.
+ *    (It is unnecessary when the write-lock is put with bond->lock.)
+ * 3) When we lock with bond->ptrlock, we must lock with bond->lock
+ *    beforehand.
+ */
+typedef struct bonding {
+	slave_t *next;
+	slave_t *prev;
+	slave_t *current_slave;
+	slave_t *primary_slave;
+	slave_t *current_arp_slave;
+	__s32 slave_cnt;
+	rwlock_t lock;
+	rwlock_t ptrlock;
+	struct timer_list mii_timer;
+	struct timer_list arp_timer;
+	struct net_device_stats *stats;
+#ifdef CONFIG_PROC_FS
+	struct proc_dir_entry *bond_proc_dir;
+	struct proc_dir_entry *bond_proc_info_file;
+#endif /* CONFIG_PROC_FS */
+	struct bonding *next_bond;
+	struct net_device *device;
+	struct dev_mc_list *mc_list;
+	unsigned short flags;
+} bonding_t;
+
+#endif /* _LINUX_BONDING_H */
+
diff -Nuarp linux-2.4.20-bonding-20030317/drivers/net/bonding/bond_main.c linux-2.4.20-bonding-20030317-devel/drivers/net/bonding/bond_main.c
--- linux-2.4.20-bonding-20030317/drivers/net/bonding/bond_main.c	2003-03-18 17:03:30.000000000 +0200
+++ linux-2.4.20-bonding-20030317-devel/drivers/net/bonding/bond_main.c	2003-03-18 17:03:31.000000000 +0200
@@ -358,6 +358,7 @@
 #include <net/arp.h>
 #include <linux/mii.h>
 #include <linux/ethtool.h>
+#include "bonding.h"
 
 #define DRV_VERSION		"2.4.20-20030317"
 #define DRV_RELDATE		"March 17, 2003"
@@ -380,6 +381,11 @@ DRV_NAME ".c:v" DRV_VERSION " (" DRV_REL
 #define MAX_ARP_IP_TARGETS 16
 #endif
 
+struct bond_parm_tbl {
+	char *modename;
+	int mode;
+};
+
 static int arp_interval = BOND_LINK_ARP_INTERV;
 static char *arp_ip_target[MAX_ARP_IP_TARGETS] = { NULL, };
 static unsigned long arp_target[MAX_ARP_IP_TARGETS] = { 0, } ;
diff -Nuarp linux-2.4.20-bonding-20030317/include/linux/if_bonding.h linux-2.4.20-bonding-20030317-devel/include/linux/if_bonding.h
--- linux-2.4.20-bonding-20030317/include/linux/if_bonding.h	2003-03-18 17:03:30.000000000 +0200
+++ linux-2.4.20-bonding-20030317-devel/include/linux/if_bonding.h	2003-03-18 17:03:31.000000000 +0200
@@ -19,18 +19,18 @@
  *		Shmulik Hen <shmulik.hen at intel dot com>
  *	- Enable support of modes that need to use the unique mac address of
  *	  each slave.
+ *
+ * 2003/03/18 - Tsippy Mendelson <tsippy.mendelson at intel dot com> and
+ *		Amir Noam <amir.noam at intel dot com>
+ *	- Moved driver's private data types to bonding.h
  */
 
 #ifndef _LINUX_IF_BONDING_H
 #define _LINUX_IF_BONDING_H
 
-#ifdef __KERNEL__
-#include <linux/timer.h>
 #include <linux/if.h>
-#include <linux/proc_fs.h>
-#endif /* __KERNEL__ */
-
 #include <linux/types.h>
+#include <linux/if_ether.h>
 
 /*
  * We can remove these ioctl definitions in 2.5.  People should use the
@@ -66,11 +66,6 @@
 #define BOND_MULTICAST_ACTIVE   1
 #define BOND_MULTICAST_ALL      2
 
-struct bond_parm_tbl {
-	char *modename;
-	int mode;
-};
-
 typedef struct ifbond {
 	__s32 bond_mode;
 	__s32 num_slaves;
@@ -86,55 +81,7 @@ typedef struct ifslave
 	__u32  link_failure_count;
 } ifslave;
 
-#ifdef __KERNEL__
-typedef struct slave {
-	struct slave *next;
-	struct slave *prev;
-	struct net_device *dev;
-	short  delay;
-	unsigned long jiffies;	
-	char   link;    /* one of BOND_LINK_XXXX */
-	char   state;   /* one of BOND_STATE_XXXX */
-	unsigned short original_flags;
-	u32 link_failure_count;
-	u16    speed;
-	u8     duplex;
-	u8     perm_hwaddr[ETH_ALEN];
-} slave_t;
-
-/*
- * Here are the locking policies for the two bonding locks:
- *
- * 1) Get bond->lock when reading/writing slave list.
- * 2) Get bond->ptrlock when reading/writing bond->current_slave.
- *    (It is unnecessary when the write-lock is put with bond->lock.)
- * 3) When we lock with bond->ptrlock, we must lock with bond->lock
- *    beforehand.
- */
-typedef struct bonding {
-	slave_t *next;
-	slave_t *prev;
-	slave_t *current_slave;
-	slave_t *primary_slave;
-	slave_t *current_arp_slave;
-	__s32 slave_cnt;
-	rwlock_t lock;
-	rwlock_t ptrlock;
-	struct timer_list mii_timer;
-	struct timer_list arp_timer;
-	struct net_device_stats *stats;
-#ifdef CONFIG_PROC_FS
-	struct proc_dir_entry *bond_proc_dir;
-	struct proc_dir_entry *bond_proc_info_file;
-#endif /* CONFIG_PROC_FS */
-	struct bonding *next_bond;
-	struct net_device *device;
-	struct dev_mc_list *mc_list;
-	unsigned short flags;
-} bonding_t;
-#endif /* __KERNEL__ */
-
-#endif /* _LINUX_BOND_H */
+#endif /* _LINUX_IF_BONDING_H */
 
 /*
  * Local variables:

-- 
| Shmulik Hen                                    |
| Israel Design Center (Jerusalem)               |
| LAN Access Division                            |
| Intel Communications Group, Intel corp.        |
|                                                |
| Anti-Spam: shmulik dot hen at intel dot com    |


