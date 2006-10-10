Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWJJQGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWJJQGo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 12:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWJJQGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 12:06:44 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:10369 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S932176AbWJJQGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 12:06:42 -0400
Subject: [patch 2/2] round_jiffies users
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, akpm@osdl.org, mingo@elte.hu
In-Reply-To: <1160496210.3000.310.camel@laptopd505.fenrus.org>
References: <1160496165.3000.308.camel@laptopd505.fenrus.org>
	 <1160496210.3000.310.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 10 Oct 2006 18:04:23 +0200
Message-Id: <1160496263.3000.312.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@linux.intel.com>
Subject: round_jiffies users
CC: jgarzik@pobox.com
CC: netdev@vger.kernel.org

This patch introduces users of the round_jiffies() function.
These timers all were of the "about once a second" or "about once every X seconds" 
variety and several showed up in the "what wakes the cpu up" profiles that
the tickless patches provide.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

Index: linux-2.6.19-rc1-git6/mm/slab.c
===================================================================
--- linux-2.6.19-rc1-git6.orig/mm/slab.c
+++ linux-2.6.19-rc1-git6/mm/slab.c
@@ -926,7 +926,7 @@ static void __devinit start_cpu_timer(in
 	if (keventd_up() && reap_work->func == NULL) {
 		init_reap_node(cpu);
 		INIT_WORK(reap_work, cache_reap, NULL);
-		schedule_delayed_work_on(cpu, reap_work, HZ + 3 * cpu);
+		schedule_delayed_work_on(cpu, reap_work, __round_jiffies_relative(HZ, cpu));
 	}
 }
 
@@ -3821,7 +3821,7 @@ static void cache_reap(void *unused)
 	if (!mutex_trylock(&cache_chain_mutex)) {
 		/* Give up. Setup the next iteration. */
 		schedule_delayed_work(&__get_cpu_var(reap_work),
-				      REAPTIMEOUT_CPUC);
+				      round_jiffies_relative(REAPTIMEOUT_CPUC));
 		return;
 	}
 
@@ -3867,7 +3867,8 @@ next:
 	next_reap_node();
 	refresh_cpu_vm_stats(smp_processor_id());
 	/* Set up the next iteration */
-	schedule_delayed_work(&__get_cpu_var(reap_work), REAPTIMEOUT_CPUC);
+	schedule_delayed_work(&__get_cpu_var(reap_work),
+		round_jiffies_relative(REAPTIMEOUT_CPUC));
 }
 
 #ifdef CONFIG_PROC_FS
Index: linux-2.6.19-rc1-git6/fs/jbd/transaction.c
===================================================================
--- linux-2.6.19-rc1-git6.orig/fs/jbd/transaction.c
+++ linux-2.6.19-rc1-git6/fs/jbd/transaction.c
@@ -53,7 +53,7 @@ get_transaction(journal_t *journal, tran
 	spin_lock_init(&transaction->t_handle_lock);
 
 	/* Set up the commit timer for the new transaction. */
-	journal->j_commit_timer.expires = transaction->t_expires;
+	journal->j_commit_timer.expires = round_jiffies(transaction->t_expires);
 	add_timer(&journal->j_commit_timer);
 
 	J_ASSERT(journal->j_running_transaction == NULL);
Index: linux-2.6.19-rc1-git6/drivers/ata/libata-scsi.c
===================================================================
--- linux-2.6.19-rc1-git6.orig/drivers/ata/libata-scsi.c
+++ linux-2.6.19-rc1-git6/drivers/ata/libata-scsi.c
@@ -3094,7 +3094,8 @@ void ata_scsi_hotplug(void *data)
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
 		if (ata_dev_enabled(dev) && !dev->sdev) {
-			queue_delayed_work(ata_aux_wq, &ap->hotplug_task, HZ);
+			queue_delayed_work(ata_aux_wq, &ap->hotplug_task,
+				round_jiffies_relative(HZ));
 			break;
 		}
 	}
Index: linux-2.6.19-rc1-git6/net/core/dst.c
===================================================================
--- linux-2.6.19-rc1-git6.orig/net/core/dst.c
+++ linux-2.6.19-rc1-git6/net/core/dst.c
@@ -99,7 +99,14 @@ static void dst_run_gc(unsigned long dum
 	printk("dst_total: %d/%d %ld\n",
 	       atomic_read(&dst_total), delayed,  dst_gc_timer_expires);
 #endif
-	mod_timer(&dst_gc_timer, jiffies + dst_gc_timer_expires);
+	/* if the next desired timer is more than 4 seconds in the future
+	 * then round the timer to whole seconds
+	 */
+	if (dst_gc_timer_expires > 4*HZ)
+		mod_timer(&dst_gc_timer,
+			round_jiffies(jiffies + dst_gc_timer_expires));
+	else
+		mod_timer(&dst_gc_timer, jiffies + dst_gc_timer_expires);
 
 out:
 	spin_unlock(&dst_lock);
Index: linux-2.6.19-rc1-git6/net/core/neighbour.c
===================================================================
--- linux-2.6.19-rc1-git6.orig/net/core/neighbour.c
+++ linux-2.6.19-rc1-git6/net/core/neighbour.c
@@ -695,7 +695,10 @@ next_elt:
 	if (!expire)
 		expire = 1;
 
- 	mod_timer(&tbl->gc_timer, now + expire);
+	if (expire>HZ)
+		mod_timer(&tbl->gc_timer, round_jiffies(now + expire));
+	else
+	 	mod_timer(&tbl->gc_timer, now + expire);
 
 	write_unlock(&tbl->lock);
 }
Index: linux-2.6.19-rc1-git6/net/sched/sch_generic.c
===================================================================
--- linux-2.6.19-rc1-git6.orig/net/sched/sch_generic.c
+++ linux-2.6.19-rc1-git6/net/sched/sch_generic.c
@@ -209,7 +209,7 @@ static void dev_watchdog(unsigned long a
 				       dev->name);
 				dev->tx_timeout(dev);
 			}
-			if (!mod_timer(&dev->watchdog_timer, jiffies + dev->watchdog_timeo))
+			if (!mod_timer(&dev->watchdog_timer, round_jiffies(jiffies + dev->watchdog_timeo)))
 				dev_hold(dev);
 		}
 	}
Index: linux-2.6.19-rc1-git6/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.19-rc1-git6.orig/drivers/net/e1000/e1000_main.c
+++ linux-2.6.19-rc1-git6/drivers/net/e1000/e1000_main.c
@@ -483,7 +483,7 @@ e1000_up(struct e1000_adapter *adapter)
 
 	clear_bit(__E1000_DOWN, &adapter->flags);
 
-	mod_timer(&adapter->watchdog_timer, jiffies + 2 * HZ);
+	mod_timer(&adapter->watchdog_timer, round_jiffies(jiffies + 2 * HZ));
 	return 0;
 }
 
@@ -2493,7 +2493,7 @@ e1000_watchdog(unsigned long data)
 
 			netif_carrier_on(netdev);
 			netif_wake_queue(netdev);
-			mod_timer(&adapter->phy_info_timer, jiffies + 2 * HZ);
+			mod_timer(&adapter->phy_info_timer, round_jiffies(jiffies + 2 * HZ));
 			adapter->smartspeed = 0;
 		}
 	} else {
@@ -2503,7 +2503,7 @@ e1000_watchdog(unsigned long data)
 			DPRINTK(LINK, INFO, "NIC Link is Down\n");
 			netif_carrier_off(netdev);
 			netif_stop_queue(netdev);
-			mod_timer(&adapter->phy_info_timer, jiffies + 2 * HZ);
+			mod_timer(&adapter->phy_info_timer, round_jiffies(jiffies + 2 * HZ));
 
 			/* 80003ES2LAN workaround--
 			 * For packet buffer work-around on link down event;
@@ -2568,7 +2568,7 @@ e1000_watchdog(unsigned long data)
 		e1000_rar_set(&adapter->hw, adapter->hw.mac_addr, 0);
 
 	/* Reset the timer */
-	mod_timer(&adapter->watchdog_timer, jiffies + 2 * HZ);
+	mod_timer(&adapter->watchdog_timer, round_jiffies(jiffies + 2 * HZ));
 }
 
 #define E1000_TX_FLAGS_CSUM		0x00000001

