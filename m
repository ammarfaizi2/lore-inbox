Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbTDVSVJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 14:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263379AbTDVSVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 14:21:09 -0400
Received: from siaab2ab.compuserve.com ([149.174.40.130]:13103 "EHLO
	siaab2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263336AbTDVSSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 14:18:33 -0400
Date: Tue, 22 Apr 2003 14:26:21 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [PATCH][ANNOUNCE] Linux 2.5.68-ce2
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304221430_MC3-1-357B-1D59@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is a collection of small fixes and enhancements for 2.5.68-release.

 Makefile                        |    2 +-
 arch/i386/kernel/entry.S        |    8 +++++---
 arch/i386/kernel/io_apic.c      |    2 +-
 drivers/char/keyboard.c         |    2 +-
 drivers/ide/ide-probe.c         |    2 +-
 drivers/isdn/tpam/tpam_queues.c |    1 +
 drivers/net/sis900.c            |    1 +
 drivers/net/wan/sdla_ppp.c      |    3 +--
 drivers/pci/bus.c               |    9 ++++++++-
 drivers/pci/probe.c             |    2 +-
 fs/ext3/super.c                 |   12 ++++++------
 fs/fat/inode.c                  |    1 +
 fs/fat/misc.c                   |    1 +
 include/linux/msdos_fs.h        |    3 +--
 mm/vmscan.c                     |   21 ++++++++++++++++++---
 net/ax25/af_ax25.c              |    2 ++
 net/ipv4/netfilter/ip_queue.c   |    8 ++++++--
 net/ipv6/netfilter/ip6_queue.c  |    6 +++++-
 net/irda/irttp.c                |    2 +-
 19 files changed, 62 insertions(+), 26 deletions(-)

extraversion.2.patch					(me)
	change extraversion to -ce2
checker.1.patch						(Muli Ben-Yehuda)
	6 checker fixes from lkml
irq_align.2.patch					(me)
	16-byte align interrupt entry points
pci_probe.1.patch					(?, from 2.5.68-mm1)
	1-line fix from mm1
pci_bus.1.patch						(me, from 2.5.68-mm1)
	fix global pci device list order
kbd.1.patch						(Chris Heath)
	fix SAK in raw mode
ide_probe.1.patch					(Manfred Spraul)
	fix ide probe return codes
ext3.1.patch						(Ernie Petrides)
	fix bug in ext3_orphan_cleanup()
fat.1.patch						(Bjvrn Stenberg)
	make fat use next_cluster field
io_apic.1.patch						(me, in 2.5.68-bk)
	fix overflow with large number of IRQ sources
via6103.1.patch						(Pedro A. Gracia Fajardo)
	add VIA 6103 PHY to sis900 driver
vmscan.1.patch						(Andrew Morton)
	fix vm accounting error

diff -u --exclude-from=/home/me/.exclude -r a/Makefile b/Makefile
--- a/Makefile	Sun Apr 20 06:26:50 2003
+++ b/Makefile	Tue Apr 22 04:56:49 2003
@ -1,7 +1,7 @
 VERSION = 2
 PATCHLEVEL = 5
 SUBLEVEL = 68
-EXTRAVERSION =
+EXTRAVERSION = -ce2
 
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"
diff -u --exclude-from=/home/me/.exclude -r a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Sat Mar 29 09:16:32 2003
+++ b/arch/i386/kernel/entry.S	Sun Apr 20 14:29:01 2003
@ -382,10 +382,11 @
 ENTRY(interrupt)
 .text
 
+	.align 16,0x90			# make ENTRY have correct address
 vector=0
 ENTRY(irq_entries_start)
 .rept NR_IRQS
-	ALIGN
+	.align 16,0x90			# should be cacheline-aligned?
 1:	pushl $vector-256
 	jmp common_interrupt
 .data
@ -394,17 +395,18 @
 vector=vector+1
 .endr
 
-	ALIGN
+	.align 16,0x90
 common_interrupt:
 	SAVE_ALL
 	call do_IRQ
 	jmp ret_from_intr
 
 #define BUILD_INTERRUPT(name, nr)	\
+	.align 16,0x90;			\
 ENTRY(name)				\
 	pushl $nr-256;			\
 	SAVE_ALL			\
-	call smp_/**/name;	\
+	call smp_/**/name;		\
 	jmp ret_from_intr;
 
 /* The include is where all of the SMP etc. interrupts come from */
diff -u --exclude-from=/home/me/.exclude -r a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	Sun Apr 20 06:26:50 2003
+++ b/arch/i386/kernel/io_apic.c	Sun Apr 20 17:41:22 2003
@ -1117,7 +1117,7 @
 	if (current_vector == SYSCALL_VECTOR)
 		goto next;
 
-	if (current_vector > FIRST_SYSTEM_VECTOR) {
+	if (current_vector >= FIRST_SYSTEM_VECTOR) {
 		offset = (offset + 1) & 7;
 		current_vector = FIRST_DEVICE_VECTOR + offset;
 	}
diff -u --exclude-from=/home/me/.exclude -r a/drivers/char/keyboard.c b/drivers/char/keyboard.c
--- a/drivers/char/keyboard.c	Tue Mar  4 22:29:17 2003
+++ b/drivers/char/keyboard.c	Sun Apr 20 14:46:11 2003
@ -601,7 +601,7 @
 		return;
 	if ((kbd->kbdmode == VC_RAW || 
 	     kbd->kbdmode == VC_MEDIUMRAW) && 
-	     value != K_SAK)
+	     value != KVAL(K_SAK))
 		return;		/* SAK is allowed even in raw mode */
 	fn_handler[value](vc, regs);
 }
diff -u --exclude-from=/home/me/.exclude -r a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	Sun Apr 20 06:26:51 2003
+++ b/drivers/ide/ide-probe.c	Sun Apr 20 15:28:23 2003
@ -1214,7 +1214,7 @
 	spin_unlock_irq(&ide_lock);
 out_up:
 	up(&ide_cfg_sem);
-	return 0;
+	return 1;
 }
 
 static int ata_lock(dev_t dev, void *data)
diff -u --exclude-from=/home/me/.exclude -r a/drivers/isdn/tpam/tpam_queues.c b/drivers/isdn/tpam/tpam_queues.c
--- a/drivers/isdn/tpam/tpam_queues.c	Tue Mar  4 22:28:56 2003
+++ b/drivers/isdn/tpam/tpam_queues.c	Sun Apr 20 08:47:54 2003
@ -144,6 +144,7 @
 		do {
 			hpic = readl(card->bar0 + TPAM_HPIC_REGISTER);
 			if (waiting_too_long++ > 0xfffffff) {
+				kfree_skb(skb); 
 				spin_unlock(&card->lock);
 				printk(KERN_ERR "TurboPAM(tpam_irq): "
 						"waiting too long...\n");
diff -u --exclude-from=/home/me/.exclude -r a/drivers/net/sis900.c b/drivers/net/sis900.c
--- a/drivers/net/sis900.c	Sat Mar 29 09:16:22 2003
+++ b/drivers/net/sis900.c	Tue Apr 22 11:31:28 2003
@ -124,6 +124,7 @
 	{ "ICS LAN PHY",			0x0015, 0xF440, LAN },
 	{ "NS 83851 PHY",			0x2000, 0x5C20, MIX },
 	{ "Realtek RTL8201 PHY",		0x0000, 0x8200, LAN },
+	{ "VIA 6103 PHY",			0x0101, 0x8F20, LAN },
 	{0,},
 };
 
diff -u --exclude-from=/home/me/.exclude -r a/drivers/net/wan/sdla_ppp.c b/drivers/net/wan/sdla_ppp.c
--- a/drivers/net/wan/sdla_ppp.c	Sat Mar 29 09:16:22 2003
+++ b/drivers/net/wan/sdla_ppp.c	Sun Apr 20 08:47:54 2003
@ -1747,11 +1747,10 @
 					if (!test_bit(SEND_CRIT, &card->wandev.critical)){
 					 	ppp_send(card, skb->data, skb->len, htons(ETH_P_IPX));
 					}
-					dev_kfree_skb_any(skb);
-
 				} else {
 					++card->wandev.stats.rx_dropped;
 				}
+				dev_kfree_skb_any(skb);
 			} else {
 				/* Pass data up the protocol stack */
 	    			skb->dev = dev;
diff -u --exclude-from=/home/me/.exclude -r a/drivers/pci/bus.c b/drivers/pci/bus.c
--- a/drivers/pci/bus.c	Sat Mar 29 09:16:22 2003
+++ b/drivers/pci/bus.c	Sun Apr 20 11:55:24 2003
@ -75,7 +75,8 @
  * Add newly discovered PCI devices (which are on the bus->devices
  * list) to the global PCI device list, add the sysfs and procfs
  * entries.  Where a bridge is found, add the discovered bus to
- * the parents list of child buses, and recurse.
+ * the parents list of child buses, and recurse (breadth-first
+ * to be compatible with 2.4)
  *
  * Call hotplug for each new devices.
  */
@ -98,6 +99,12 @
 #endif
 		pci_create_sysfs_dev_files(dev);
 
+	}
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+
+		BUG_ON(list_empty(&dev->global_list));
+
 		/*
 		 * If there is an unattached subordinate bus, attach
 		 * it and then scan for unattached PCI devices.
diff -u --exclude-from=/home/me/.exclude -r a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Sat Mar 29 09:16:22 2003
+++ b/drivers/pci/probe.c	Sun Apr 20 11:55:33 2003
@ -173,7 +173,7 @
 		limit |= (io_limit_hi << 16);
 	}
 
-	if (base && base <= limit) {
+	if (base <= limit) {
 		res->flags = (io_base_lo & PCI_IO_RANGE_TYPE_MASK) | IORESOURCE_IO;
 		res->start = base;
 		res->end = limit + 0xfff;
diff -u --exclude-from=/home/me/.exclude -r a/fs/ext3/super.c b/fs/ext3/super.c
--- a/fs/ext3/super.c	Sun Apr 20 06:26:52 2003
+++ b/fs/ext3/super.c	Tue Apr 22 11:07:42 2003
@ -982,12 +982,6 @
 		return;
 	}
 
-	if (s_flags & MS_RDONLY) {
-		printk(KERN_INFO "EXT3-fs: %s: orphan cleanup on readonly fs\n",
-		       sb->s_id);
-		sb->s_flags &= ~MS_RDONLY;
-	}
-
 	if (EXT3_SB(sb)->s_mount_state & EXT3_ERROR_FS) {
 		if (es->s_last_orphan)
 			jbd_debug(1, "Errors on filesystem, "
@ -997,6 +991,12 @
 		return;
 	}
 
+	if (s_flags & MS_RDONLY) {
+		printk(KERN_INFO "EXT3-fs: %s: orphan cleanup on readonly fs\n",
+		       sb->s_id);
+		sb->s_flags &= ~MS_RDONLY;
+	}
+
 	while (es->s_last_orphan) {
 		struct inode *inode;
 
diff -u --exclude-from=/home/me/.exclude -r a/fs/fat/inode.c b/fs/fat/inode.c
--- a/fs/fat/inode.c	Sun Apr 20 06:26:23 2003
+++ b/fs/fat/inode.c	Tue Apr 22 10:57:28 2003
@ -898,6 +898,7 @
 			       sbi->fsinfo_sector);
 		} else {
 			sbi->free_clusters = CF_LE_L(fsinfo->free_clusters);
+			sbi->prev_free = CF_LE_L(fsinfo->next_cluster);
 		}
 
 		brelse(fsinfo_bh);
diff -u --exclude-from=/home/me/.exclude -r a/fs/fat/misc.c b/fs/fat/misc.c
--- a/fs/fat/misc.c	Tue Mar  4 22:29:34 2003
+++ b/fs/fat/misc.c	Tue Apr 22 10:57:28 2003
@ -74,6 +74,7 @
 		       MSDOS_SB(sb)->fsinfo_sector);
 	} else {
 		fsinfo->free_clusters = CF_LE_L(MSDOS_SB(sb)->free_clusters);
+		fsinfo->next_cluster = CF_LE_L(MSDOS_SB(sb)->prev_free);
 		mark_buffer_dirty(bh);
 	}
 	brelse(bh);
diff -u --exclude-from=/home/me/.exclude -r a/include/linux/msdos_fs.h b/include/linux/msdos_fs.h
--- a/include/linux/msdos_fs.h	Tue Mar  4 22:29:33 2003
+++ b/include/linux/msdos_fs.h	Tue Apr 22 10:57:28 2003
@ -146,8 +146,7 @
 	__u32   reserved1[120];	/* Nothing as far as I can tell */
 	__u32   signature2;	/* 0x61417272L */
 	__u32   free_clusters;	/* Free cluster count.  -1 if unknown */
-	__u32   next_cluster;	/* Most recently allocated cluster.
-				 * Unused under Linux. */
+	__u32   next_cluster;	/* Most recently allocated cluster */
 	__u32   reserved2[4];
 };
 
diff -u --exclude-from=/home/me/.exclude -r a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Sun Apr 20 06:26:52 2003
+++ b/mm/vmscan.c	Tue Apr 22 05:37:51 2003
@ -558,6 +558,7 @
 refill_inactive_zone(struct zone *zone, const int nr_pages_in,
 			struct page_state *ps, int priority)
 {
+	int pgmoved;
 	int pgdeactivate = 0;
 	int nr_pages = nr_pages_in;
 	LIST_HEAD(l_hold);	/* The pages which were snipped off */
@ -571,6 +572,7 @
 	long swap_tendency;
 
 	lru_add_drain();
+	pgmoved = 0;
 	spin_lock_irq(&zone->lru_lock);
 	while (nr_pages && !list_empty(&zone->active_list)) {
 		page = list_entry(zone->active_list.prev, struct page, lru);
@ -585,9 +587,12 @
 		} else {
 			page_cache_get(page);
 			list_add(&page->lru, &l_hold);
+			pgmoved++;
 		}
 		nr_pages--;
 	}
+	zone->nr_active   -= pgmoved;
+	zone->nr_inactive += pgmoved;
 	spin_unlock_irq(&zone->lru_lock);
 
 	/*
@ -647,10 +652,10 @
 			continue;
 		}
 		list_add(&page->lru, &l_inactive);
-		pgdeactivate++;
 	}
 
 	pagevec_init(&pvec, 1);
+	pgmoved = 0;
 	spin_lock_irq(&zone->lru_lock);
 	while (!list_empty(&l_inactive)) {
 		page = list_entry(l_inactive.prev, struct page, lru);
@ -660,19 +665,27 @
 		if (!TestClearPageActive(page))
 			BUG();
 		list_move(&page->lru, &zone->inactive_list);
+		pgmoved++;
 		if (!pagevec_add(&pvec, page)) {
+			zone->nr_inactive += pgmoved;
 			spin_unlock_irq(&zone->lru_lock);
+			pgdeactivate += pgmoved;
+			pgmoved = 0;
 			if (buffer_heads_over_limit)
 				pagevec_strip(&pvec);
 			__pagevec_release(&pvec);
 			spin_lock_irq(&zone->lru_lock);
 		}
 	}
+	zone->nr_inactive += pgmoved;
+	pgdeactivate += pgmoved;
 	if (buffer_heads_over_limit) {
 		spin_unlock_irq(&zone->lru_lock);
 		pagevec_strip(&pvec);
 		spin_lock_irq(&zone->lru_lock);
 	}
+
+	pgmoved = 0;
 	while (!list_empty(&l_active)) {
 		page = list_entry(l_active.prev, struct page, lru);
 		prefetchw_prev_lru_page(page, &l_active, flags);
@ -680,14 +693,16 @
 			BUG();
 		BUG_ON(!PageActive(page));
 		list_move(&page->lru, &zone->active_list);
+		pgmoved++;
 		if (!pagevec_add(&pvec, page)) {
+			zone->nr_active += pgmoved;
+			pgmoved = 0;
 			spin_unlock_irq(&zone->lru_lock);
 			__pagevec_release(&pvec);
 			spin_lock_irq(&zone->lru_lock);
 		}
 	}
-	zone->nr_active -= pgdeactivate;
-	zone->nr_inactive += pgdeactivate;
+	zone->nr_active += pgmoved;
 	spin_unlock_irq(&zone->lru_lock);
 	pagevec_release(&pvec);
 
diff -u --exclude-from=/home/me/.exclude -r a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
--- a/net/ax25/af_ax25.c	Sat Mar 29 09:16:22 2003
+++ b/net/ax25/af_ax25.c	Sun Apr 20 08:47:54 2003
@ -1202,6 +1202,8 @
 		ax25_insert_socket(ax25);
 	} else {
 		if (ax25->ax25_dev == NULL) {
+			if (digi != NULL)
+				kfree(digi);
 			err = -EHOSTUNREACH;
 			goto out;
 		}
diff -u --exclude-from=/home/me/.exclude -r a/net/ipv4/netfilter/ip_queue.c b/net/ipv4/netfilter/ip_queue.c
--- a/net/ipv4/netfilter/ip_queue.c	Sun Apr 20 06:26:24 2003
+++ b/net/ipv4/netfilter/ip_queue.c	Sun Apr 20 08:47:54 2003
@ -298,10 +298,11 @
 		goto err_out_free;
 		
 	write_lock_bh(&queue_lock);
-	
+
 	if (!peer_pid)
-		goto err_out_unlock;
+		goto err_out_free_nskb; 
 
+	/* netlink_unicast will either free the nskb or attach it to a socket */ 
 	status = netlink_unicast(ipqnl, nskb, peer_pid, MSG_DONTWAIT);
 	if (status < 0)
 		goto err_out_unlock;
@ -312,6 +313,9 @
 
 	write_unlock_bh(&queue_lock);
 	return status;
+
+err_out_free_nskb:
+	kfree_skb(nskb); 
 	
 err_out_unlock:
 	write_unlock_bh(&queue_lock);
diff -u --exclude-from=/home/me/.exclude -r a/net/ipv6/netfilter/ip6_queue.c b/net/ipv6/netfilter/ip6_queue.c
--- a/net/ipv6/netfilter/ip6_queue.c	Sun Apr 20 06:26:24 2003
+++ b/net/ipv6/netfilter/ip6_queue.c	Sun Apr 20 08:47:54 2003
@ -304,8 +304,9 @
 	write_lock_bh(&queue_lock);
 	
 	if (!peer_pid)
-		goto err_out_unlock;
+		goto err_out_free_nskb; 
 
+ 	/* netlink_unicast will either free the nskb or attach it to a socket */ 
 	status = netlink_unicast(ipqnl, nskb, peer_pid, MSG_DONTWAIT);
 	if (status < 0)
 		goto err_out_unlock;
@ -317,6 +318,9 @
 	write_unlock_bh(&queue_lock);
 	return status;
 	
+err_out_free_nskb:
+	kfree_skb(nskb); 
+	
 err_out_unlock:
 	write_unlock_bh(&queue_lock);
 
diff -u --exclude-from=/home/me/.exclude -r a/net/irda/irttp.c b/net/irda/irttp.c
--- a/net/irda/irttp.c	Tue Mar  4 22:29:23 2003
+++ b/net/irda/irttp.c	Sun Apr 20 08:47:54 2003
@ -263,7 +263,7 @
 
 	IRDA_DEBUG(2, "%s(), rx_sdu_size=%d\n",  __FUNCTION__,
 		   self->rx_sdu_size);
-	ASSERT(n <= self->rx_sdu_size, return NULL;);
+	ASSERT(n <= self->rx_sdu_size, {dev_kfree_skb(skb); return NULL;});
 
 	/* Set the new length */
 	skb_trim(skb, n);


------
 Chuck
