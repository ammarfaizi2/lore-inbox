Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262299AbUKKRh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262299AbUKKRh0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 12:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUKKRYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 12:24:13 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:4084 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S262299AbUKKRQN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 12:16:13 -0500
Date: Thu, 11 Nov 2004 18:16:02 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 4/10] s390: network driver.
Message-ID: <20041111171602.GF4900@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 4/10] s390: network driver.

From: Thomas Spatzier <tspat@de.ibm.com>
From: Peter Tiedemann <ptiedem@de.ibm.com>

network driver changes:
 - qeth: return -EINVAL if an skb is too large.
 - qeth: don't call netif_stop_queue after cable pull. Drop the
   packets instead.
 - qeth: fix race between SET_IP and SET_MC kernel thread by removing
   SET_MC thread and let the SET_IP thread do multicast requests as well.
 - qeth: make it compile without CONFIG_VLAN.
 - ctc: avoid compiler warnings.
 - lcs: write package sequence number to skb->cb.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/net/ctcmain.c   |   22 ++-
 drivers/s390/net/lcs.c       |    6 -
 drivers/s390/net/lcs.h       |    3 
 drivers/s390/net/qeth.h      |    8 -
 drivers/s390/net/qeth_main.c |  253 +++++++++++++++++++++----------------------
 5 files changed, 154 insertions(+), 138 deletions(-)

diff -urN linux-2.6/drivers/s390/net/ctcmain.c linux-2.6-patched/drivers/s390/net/ctcmain.c
--- linux-2.6/drivers/s390/net/ctcmain.c	2004-11-11 15:06:39.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/ctcmain.c	2004-11-11 15:06:56.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: ctcmain.c,v 1.63 2004/07/28 12:27:54 ptiedem Exp $
+ * $Id: ctcmain.c,v 1.65 2004/10/27 09:12:48 mschwide Exp $
  *
  * CTC / ESCON network driver
  *
@@ -36,7 +36,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.63 $
+ * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.65 $
  *
  */
 
@@ -320,7 +320,7 @@
 print_banner(void)
 {
 	static int printed = 0;
-	char vbuf[] = "$Revision: 1.63 $";
+	char vbuf[] = "$Revision: 1.65 $";
 	char *version = vbuf;
 
 	if (printed)
@@ -1224,7 +1224,9 @@
 	fsm_deltimer(&ch->timer);
 	fsm_addtimer(&ch->timer, CTC_TIMEOUT_5SEC, CH_EVENT_TIMER, ch);
 	fsm_newstate(fi, CH_STATE_SETUPWAIT);
-	if (event == CH_EVENT_TIMER)
+	saveflags = 0;	/* avoids compiler warning with
+			   spin_unlock_irqrestore */
+	if (event == CH_EVENT_TIMER)	// only for timer not yet locked
 		spin_lock_irqsave(get_ccwdev_lock(ch->cdev), saveflags);
 	rc = ccw_device_start(ch->cdev, &ch->ccw[6], (unsigned long) ch, 0xff, 0);
 	if (event == CH_EVENT_TIMER)
@@ -1335,7 +1337,9 @@
 	DBF_TEXT(trace, 3, __FUNCTION__);
 	fsm_deltimer(&ch->timer);
 	fsm_addtimer(&ch->timer, CTC_TIMEOUT_5SEC, CH_EVENT_TIMER, ch);
-	if (event == CH_EVENT_STOP)
+	saveflags = 0;	/* avoids comp warning with
+			   spin_unlock_irqrestore */
+	if (event == CH_EVENT_STOP)	// only for STOP not yet locked
 		spin_lock_irqsave(get_ccwdev_lock(ch->cdev), saveflags);
 	oldstate = fsm_getstate(fi);
 	fsm_newstate(fi, CH_STATE_TERM);
@@ -1508,7 +1512,9 @@
 	fsm_addtimer(&ch->timer, CTC_TIMEOUT_5SEC, CH_EVENT_TIMER, ch);
 	oldstate = fsm_getstate(fi);
 	fsm_newstate(fi, CH_STATE_STARTWAIT);
-	if (event == CH_EVENT_TIMER)
+	saveflags = 0;	/* avoids compiler warning with
+			   spin_unlock_irqrestore */
+	if (event == CH_EVENT_TIMER)	// only for timer not yet locked
 		spin_lock_irqsave(get_ccwdev_lock(ch->cdev), saveflags);
 	rc = ccw_device_halt(ch->cdev, (unsigned long) ch);
 	if (event == CH_EVENT_TIMER)
@@ -1674,7 +1680,9 @@
 				return;
 			}
 			fsm_addtimer(&ch->timer, 1000, CH_EVENT_TIMER, ch);
-			if (event == CH_EVENT_TIMER)
+			saveflags = 0;	/* avoids compiler warning with
+					   spin_unlock_irqrestore */
+			if (event == CH_EVENT_TIMER) // only for TIMER not yet locked
 				spin_lock_irqsave(get_ccwdev_lock(ch->cdev),
 						  saveflags);
 			rc = ccw_device_start(ch->cdev, &ch->ccw[3],
diff -urN linux-2.6/drivers/s390/net/lcs.c linux-2.6-patched/drivers/s390/net/lcs.c
--- linux-2.6/drivers/s390/net/lcs.c	2004-11-11 15:06:39.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/lcs.c	2004-11-11 15:06:56.000000000 +0100
@@ -11,7 +11,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Martin Schwidefsky <schwidefsky@de.ibm.com>
  *
- *    $Revision: 1.94 $	 $Date: 2004/10/19 09:30:54 $
+ *    $Revision: 1.96 $	 $Date: 2004/11/11 13:42:33 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -59,7 +59,7 @@
 /**
  * initialization string for output
  */
-#define VERSION_LCS_C  "$Revision: 1.94 $"
+#define VERSION_LCS_C  "$Revision: 1.96 $"
 
 static char version[] __initdata = "LCS driver ("VERSION_LCS_C "/" VERSION_LCS_H ")";
 static char debug_buffer[255];
@@ -191,6 +191,7 @@
 		return NULL;
 	memset(card, 0, sizeof(struct lcs_card));
 	card->lan_type = LCS_FRAME_TYPE_AUTO;
+	card->pkt_seq = 0;
 	card->lancmd_timeout = LCS_LANCMD_TIMEOUT_DEFAULT;
 	/* Allocate io buffers for the read channel. */
 	rc = lcs_alloc_channel(&card->read);
@@ -1874,6 +1875,7 @@
 	skb->protocol =	card->lan_type_trans(skb, card->dev);
 	card->stats.rx_bytes += skb_len;
 	card->stats.rx_packets++;
+	*((__u32 *)skb->cb) = ++card->pkt_seq;
 	netif_rx(skb);
 }
 
diff -urN linux-2.6/drivers/s390/net/lcs.h linux-2.6-patched/drivers/s390/net/lcs.h
--- linux-2.6/drivers/s390/net/lcs.h	2004-10-18 23:54:40.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/lcs.h	2004-11-11 15:06:56.000000000 +0100
@@ -6,7 +6,7 @@
 #include <linux/workqueue.h>
 #include <asm/ccwdev.h>
 
-#define VERSION_LCS_H "$Revision: 1.18 $"
+#define VERSION_LCS_H "$Revision: 1.19 $"
 
 #define LCS_DBF_TEXT(level, name, text) \
 	do { \
@@ -309,6 +309,7 @@
 	__u16 ip_assists_supported;
 	__u16 ip_assists_enabled;
 	__s8 lan_type;
+	__u32 pkt_seq;
 	__u16 sequence_no;
 	__s16 portno;
 	/* Some info copied from probeinfo */
diff -urN linux-2.6/drivers/s390/net/qeth.h linux-2.6-patched/drivers/s390/net/qeth.h
--- linux-2.6/drivers/s390/net/qeth.h	2004-11-11 15:06:39.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth.h	2004-11-11 15:06:56.000000000 +0100
@@ -24,7 +24,7 @@
 
 #include "qeth_mpc.h"
 
-#define VERSION_QETH_H 		"$Revision: 1.116 $"
+#define VERSION_QETH_H 		"$Revision: 1.123 $"
 
 #ifdef CONFIG_QETH_IPV6
 #define QETH_VERSION_IPV6 	":IPv6"
@@ -557,6 +557,7 @@
 	QETH_IP_TYPE_NORMAL,
 	QETH_IP_TYPE_VIPA,
 	QETH_IP_TYPE_RXIP,
+	QETH_IP_TYPE_DEL_ALL_MC,
 };
 
 enum qeth_cmd_buffer_state {
@@ -713,8 +714,7 @@
  */
 enum qeth_threads {
 	QETH_SET_IP_THREAD  = 1,
-	QETH_SET_MC_THREAD  = 2,
-	QETH_RECOVER_THREAD = 4,
+	QETH_RECOVER_THREAD = 2,
 };
 
 struct qeth_card {
@@ -748,7 +748,7 @@
 	volatile unsigned long thread_running_mask;
 	spinlock_t ip_lock;
 	struct list_head ip_list;
-	struct list_head ip_tbd_list;
+	struct list_head *ip_tbd_list;
 	struct qeth_ipato ipato;
 	struct list_head cmd_waiter_list;
 	/* QDIO buffer handling */
diff -urN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-patched/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	2004-11-11 15:06:39.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/qeth_main.c	2004-11-11 15:06:56.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.155 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.168 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.155 $	 $Date: 2004/10/21 13:27:46 $
+ *    $Revision: 1.168 $	 $Date: 2004/11/08 15:55:12 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -78,7 +78,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-#define VERSION_QETH_C "$Revision: 1.155 $"
+#define VERSION_QETH_C "$Revision: 1.168 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -160,6 +160,9 @@
 qeth_get_addr_buffer(enum qeth_prot_versions);
 
 static void
+qeth_set_multicast_list(struct net_device *);
+
+static void
 qeth_notify_processes(void)
 {
 	/*notify all  registered processes */
@@ -249,6 +252,7 @@
 		free_netdev(card->dev);
 	qeth_clear_ip_list(card, 0, 0);
 	qeth_clear_ipato_list(card);
+	kfree(card->ip_tbd_list);
 	qeth_free_qdio_buffers(card);
 	kfree(card);
 }
@@ -660,7 +664,10 @@
 	struct qeth_ipaddr *tmp, *t;
 	int found = 0;
 
-	list_for_each_entry_safe(tmp, t, &card->ip_tbd_list, entry) {
+	list_for_each_entry_safe(tmp, t, card->ip_tbd_list, entry) {
+		if ((addr->type == QETH_IP_TYPE_DEL_ALL_MC) &&
+		    (tmp->type == QETH_IP_TYPE_DEL_ALL_MC))
+			return 0;
 		if ((tmp->proto        == QETH_PROT_IPV4)     &&
 		    (addr->proto       == QETH_PROT_IPV4)     &&
 		    (tmp->type         == addr->type)         &&
@@ -692,14 +699,18 @@
 		}
 		return 0;
 	} else {
-		if (addr->users == 0)
-			addr->users += add? 1:-1;
-		if (add && (addr->type == QETH_IP_TYPE_NORMAL) &&
-		    qeth_is_addr_covered_by_ipato(card, addr)){
-			QETH_DBF_TEXT(trace, 2, "tkovaddr");
-			addr->set_flags |= QETH_IPA_SETIP_TAKEOVER_FLAG;
+		if (addr->type == QETH_IP_TYPE_DEL_ALL_MC)
+			list_add(&addr->entry, card->ip_tbd_list);
+		else {
+			if (addr->users == 0)
+				addr->users += add? 1:-1;
+			if (add && (addr->type == QETH_IP_TYPE_NORMAL) &&
+			    qeth_is_addr_covered_by_ipato(card, addr)){
+				QETH_DBF_TEXT(trace, 2, "tkovaddr");
+				addr->set_flags |= QETH_IPA_SETIP_TAKEOVER_FLAG;
+			}
+			list_add_tail(&addr->entry, card->ip_tbd_list);
 		}
-		list_add_tail(&addr->entry, &card->ip_tbd_list);
 		return 1;
 	}
 }
@@ -717,8 +728,8 @@
 	if (addr->proto == QETH_PROT_IPV4)
 		QETH_DBF_HEX(trace,4,&addr->u.a4.addr,4);
 	else {
-		QETH_DBF_HEX(trace,4,&addr->u.a6.addr,4);
-		QETH_DBF_HEX(trace,4,((char *)&addr->u.a6.addr)+4,4);
+		QETH_DBF_HEX(trace,4,&addr->u.a6.addr,8);
+		QETH_DBF_HEX(trace,4,((char *)&addr->u.a6.addr)+8,8);
 	}
 	spin_lock_irqsave(&card->ip_lock, flags);
 	rc = __qeth_insert_ip_todo(card, addr, 0);
@@ -736,8 +747,8 @@
 	if (addr->proto == QETH_PROT_IPV4)
 		QETH_DBF_HEX(trace,4,&addr->u.a4.addr,4);
 	else {
-		QETH_DBF_HEX(trace,4,&addr->u.a6.addr,4);
-		QETH_DBF_HEX(trace,4,((char *)&addr->u.a6.addr)+4,4);
+		QETH_DBF_HEX(trace,4,&addr->u.a6.addr,8);
+		QETH_DBF_HEX(trace,4,((char *)&addr->u.a6.addr)+8,8);
 	}
 	spin_lock_irqsave(&card->ip_lock, flags);
 	rc = __qeth_insert_ip_todo(card, addr, 1);
@@ -745,19 +756,21 @@
 	return rc;
 }
 
-static void
-qeth_reinsert_todos(struct qeth_card *card, struct list_head *todos)
+static inline void
+__qeth_delete_all_mc(struct qeth_card *card, unsigned long *flags)
 {
-	struct qeth_ipaddr *todo, *tmp;
+	struct qeth_ipaddr *addr, *tmp;
+	int rc;
 
-	list_for_each_entry_safe(todo, tmp, todos, entry){
-		list_del_init(&todo->entry);
-		if (todo->users < 0) {
-			if (!qeth_delete_ip(card, todo))
-				kfree(todo);
-		} else {
-			if (!qeth_add_ip(card, todo))
-				kfree(todo);
+	list_for_each_entry_safe(addr, tmp, &card->ip_list, entry) {
+		if (addr->is_multicast) {
+			spin_unlock_irqrestore(&card->ip_lock, *flags);
+			rc = qeth_deregister_addr_entry(card, addr);
+			spin_lock_irqsave(&card->ip_lock, *flags);
+			if (!rc) {
+				list_del(&addr->entry);
+				kfree(addr);
+			}
 		}
 	}
 }
@@ -765,7 +778,7 @@
 static void
 qeth_set_ip_addr_list(struct qeth_card *card)
 {
-	struct list_head failed_todos;
+	struct list_head *tbd_list;
 	struct qeth_ipaddr *todo, *addr;
 	unsigned long flags;
 	int rc;
@@ -773,13 +786,25 @@
 	QETH_DBF_TEXT(trace, 2, "sdiplist");
 	QETH_DBF_HEX(trace, 2, &card, sizeof(void *));
 
-	INIT_LIST_HEAD(&failed_todos);
-
 	spin_lock_irqsave(&card->ip_lock, flags);
-	while (!list_empty(&card->ip_tbd_list)) {
-		todo = list_entry(card->ip_tbd_list.next,
-				  struct qeth_ipaddr, entry);
-		list_del_init(&todo->entry);
+	tbd_list = card->ip_tbd_list;
+	card->ip_tbd_list = kmalloc(sizeof(struct list_head), GFP_ATOMIC);
+	if (!card->ip_tbd_list) {
+		QETH_DBF_TEXT(trace, 0, "silnomem");
+		card->ip_tbd_list = tbd_list;
+		spin_unlock_irqrestore(&card->ip_lock, flags);
+		return;
+	} else
+		INIT_LIST_HEAD(card->ip_tbd_list);
+
+	while (!list_empty(tbd_list)){
+		todo = list_entry(tbd_list->next, struct qeth_ipaddr, entry);
+		list_del(&todo->entry);
+		if (todo->type == QETH_IP_TYPE_DEL_ALL_MC){
+			__qeth_delete_all_mc(card, &flags);
+			kfree(todo);
+			continue;
+		}
 		rc = __qeth_ref_ip_on_card(card, todo, &addr);
 		if (rc == 0) {
 			/* nothing to be done; only adjusted refcount */
@@ -792,24 +817,22 @@
 			if (!rc)
 				list_add_tail(&todo->entry, &card->ip_list);
 			else
-				list_add_tail(&todo->entry, &failed_todos);
+				kfree(todo);
 		} else if (rc == -1) {
 			/* on-card entry to be removed */
 			list_del_init(&addr->entry);
 			spin_unlock_irqrestore(&card->ip_lock, flags);
 			rc = qeth_deregister_addr_entry(card, addr);
 			spin_lock_irqsave(&card->ip_lock, flags);
-			if (!rc) {
+			if (!rc)
 				kfree(addr);
-				kfree(todo);
-			} else {
+			else
 				list_add_tail(&addr->entry, &card->ip_list);
-				list_add_tail(&todo->entry, &failed_todos);
-			}
+			kfree(todo);
 		}
 	}
 	spin_unlock_irqrestore(&card->ip_lock, flags);
-	qeth_reinsert_todos(card, &failed_todos);
+	kfree(tbd_list);
 }
 
 static void qeth_delete_mc_addresses(struct qeth_card *);
@@ -887,28 +910,7 @@
 }
 
 static int
-qeth_register_mc_addresses(void *ptr)
-{
-	struct qeth_card *card;
-
-	card = (struct qeth_card *) ptr;
-	daemonize("qeth_reg_mcaddrs");
-	QETH_DBF_TEXT(trace,4,"regmcth1");
-	if (!qeth_do_run_thread(card, QETH_SET_MC_THREAD))
-		return 0;
-	QETH_DBF_TEXT(trace,4,"regmcth2");
-	qeth_delete_mc_addresses(card);
-	qeth_add_multicast_ipv4(card);
-#ifdef CONFIG_QETH_IPV6
-	qeth_add_multicast_ipv6(card);
-#endif
-	qeth_set_ip_addr_list(card);
-	qeth_clear_thread_running_bit(card, QETH_SET_MC_THREAD);
-	return 0;
-}
-
-static int
-qeth_register_ip_address(void *ptr)
+qeth_register_ip_addresses(void *ptr)
 {
 	struct qeth_card *card;
 
@@ -988,9 +990,7 @@
 		return;
 
 	if (qeth_do_start_thread(card, QETH_SET_IP_THREAD))
-		kernel_thread(qeth_register_ip_address, (void *) card, SIGCHLD);
-	if (qeth_do_start_thread(card, QETH_SET_MC_THREAD))
-		kernel_thread(qeth_register_mc_addresses, (void *)card,SIGCHLD);
+		kernel_thread(qeth_register_ip_addresses, (void *)card,SIGCHLD);
 	if (qeth_do_start_thread(card, QETH_RECOVER_THREAD))
 		kernel_thread(qeth_recover, (void *) card, SIGCHLD);
 }
@@ -1041,7 +1041,12 @@
 	INIT_WORK(&card->kernel_thread_starter,
 		  (void *)qeth_start_kernel_thread,card);
 	INIT_LIST_HEAD(&card->ip_list);
-	INIT_LIST_HEAD(&card->ip_tbd_list);
+	card->ip_tbd_list = kmalloc(sizeof(struct list_head), GFP_KERNEL);
+	if (!card->ip_tbd_list) {
+		QETH_DBF_TEXT(setup, 0, "iptbdnom");
+		return -ENOMEM;
+	}
+	INIT_LIST_HEAD(card->ip_tbd_list);
 	INIT_LIST_HEAD(&card->cmd_waiter_list);
 	init_waitqueue_head(&card->wait_q);
 	/* intial options */
@@ -1575,9 +1580,8 @@
 	QETH_DBF_TEXT(trace, 2, "rstipadd");
 
 	qeth_clear_ip_list(card, 0, 1);
-	if ( (qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD) == 0) ||
-	     (qeth_set_thread_start_bit(card, QETH_SET_MC_THREAD) == 0) )
-		schedule_work(&card->kernel_thread_starter);
+	/* this function will also schedule the SET_IP_THREAD */
+	qeth_set_multicast_list(card->dev);
 }
 
 static struct qeth_ipa_cmd *
@@ -1600,10 +1604,7 @@
 					   card->info.if_name,
 					   card->info.chpid);
 				card->lan_online = 0;
-				if (netif_carrier_ok(card->dev)) {
-					netif_carrier_off(card->dev);
-					netif_stop_queue(card->dev);
-				}
+				netif_carrier_off(card->dev);
 				return NULL;
 			case IPA_CMD_STARTLAN:
 				PRINT_INFO("Link reestablished on %s "
@@ -1612,10 +1613,7 @@
 					   card->info.if_name,
 					   card->info.chpid);
 				card->lan_online = 1;
-				if (!netif_carrier_ok(card->dev)) {
-					netif_carrier_on(card->dev);
-					netif_wake_queue(card->dev);
-				}
+				netif_carrier_on(card->dev);
 				qeth_reset_ip_addresses(card);
 				return NULL;
 			case IPA_CMD_REGISTER_LOCAL_ADDR:
@@ -2807,7 +2805,8 @@
 	}
 	atomic_sub(count, &queue->used_buffers);
 	/* check if we need to do something on this outbound queue */
-	qeth_check_outbound_queue(queue);
+	if (card->info.type != QETH_CARD_TYPE_IQD)
+		qeth_check_outbound_queue(queue);
 
 	netif_wake_queue(card->dev);
 #ifdef CONFIG_QETH_PERF_STATS
@@ -3381,13 +3380,16 @@
 	if (skb==NULL) {
 		card->stats.tx_dropped++;
 		card->stats.tx_errors++;
-		return -EIO;
+		/* return OK; otherwise ksoftirqd goes to 100% */
+		return NETDEV_TX_OK;
 	}
-	if ((card->state != CARD_STATE_UP) || !netif_carrier_ok(dev)) {
+	if ((card->state != CARD_STATE_UP) || !card->lan_online) {
 		card->stats.tx_dropped++;
 		card->stats.tx_errors++;
 		card->stats.tx_carrier_errors++;
-		return -EIO;
+		dev_kfree_skb_any(skb);
+		/* return OK; otherwise ksoftirqd goes to 100% */
+		return NETDEV_TX_OK;
 	}
 #ifdef CONFIG_QETH_PERF_STATS
 	card->perf_stats.outbound_cnt++;
@@ -3398,8 +3400,18 @@
 	 * got our own synchronization on queues we can keep the stack's
 	 * queue running.
 	 */
-	if ((rc = qeth_send_packet(card, skb)))
-		netif_stop_queue(dev);
+	if ((rc = qeth_send_packet(card, skb))){
+		if (rc == -EBUSY) {
+			netif_stop_queue(dev);
+			rc = NETDEV_TX_BUSY;
+		} else {
+			card->stats.tx_errors++;
+			card->stats.tx_dropped++;
+			dev_kfree_skb_any(skb);
+			/* set to OK; otherwise ksoftirqd goes to 100% */
+			rc = NETDEV_TX_OK;
+		}
+	}
 
 #ifdef CONFIG_QETH_PERF_STATS
 	card->perf_stats.outbound_time += qeth_get_micros() -
@@ -3503,7 +3515,6 @@
 	if (!card->lan_online){
 		if (netif_carrier_ok(dev))
 			netif_carrier_off(dev);
-		netif_stop_queue(dev);
 	}
 	return 0;
 }
@@ -4988,12 +4999,28 @@
 	spin_unlock_irqrestore(&card->vlanlock, flags);
 	if (card->options.layer2)
 		qeth_layer2_send_setdelvlan(card, vid, IPA_CMD_DELVLAN);
- 	if ( (qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD) == 0) ||
-	     (qeth_set_thread_start_bit(card, QETH_SET_MC_THREAD) == 0) )
-		schedule_work(&card->kernel_thread_starter);
+	qeth_set_multicast_list(card->dev);
 }
 #endif
 
+/**
+ * set multicast address on card
+ */
+static void
+qeth_set_multicast_list(struct net_device *dev)
+{
+	struct qeth_card *card = (struct qeth_card *) dev->priv;
+
+	QETH_DBF_TEXT(trace,3,"setmulti");
+	qeth_delete_mc_addresses(card);
+	qeth_add_multicast_ipv4(card);
+#ifdef CONFIG_QETH_IPV6
+	qeth_add_multicast_ipv6(card);
+#endif
+ 	if (qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD) == 0)
+		schedule_work(&card->kernel_thread_starter);
+}
+
 static int
 qeth_neigh_setup(struct net_device *dev, struct neigh_parms *np)
 {
@@ -5049,24 +5076,19 @@
 static void
 qeth_delete_mc_addresses(struct qeth_card *card)
 {
-	struct qeth_ipaddr *ipm, *iptodo;
+	struct qeth_ipaddr *iptodo;
 	unsigned long flags;
 
 	QETH_DBF_TEXT(trace,4,"delmc");
-	spin_lock_irqsave(&card->ip_lock, flags);
-	list_for_each_entry(ipm, &card->ip_list, entry){
-		if (!ipm->is_multicast)
-			continue;
-		iptodo = qeth_get_addr_buffer(ipm->proto);
-		if (!iptodo) {
-			QETH_DBF_TEXT(trace, 2, "dmcnomem");
-			continue;
-		}
-		memcpy(iptodo, ipm, sizeof(struct qeth_ipaddr));
-		iptodo->users = iptodo->users * -1;
-		if (!__qeth_insert_ip_todo(card, iptodo, 0))
-			kfree(iptodo);
+	iptodo = qeth_get_addr_buffer(QETH_PROT_IPV4);
+	if (!iptodo) {
+		QETH_DBF_TEXT(trace, 2, "dmcnomem");
+		return;
 	}
+	iptodo->type = QETH_IP_TYPE_DEL_ALL_MC;
+	spin_lock_irqsave(&card->ip_lock, flags);
+	if (!__qeth_insert_ip_todo(card, iptodo, 0))
+		kfree(iptodo);
 	spin_unlock_irqrestore(&card->ip_lock, flags);
 }
 
@@ -5277,20 +5299,6 @@
 
 	return rc;
 }
-/**
- * set multicast address on card
- */
-static void
-qeth_set_multicast_list(struct net_device *dev)
-{
-	struct qeth_card *card;
-
-	QETH_DBF_TEXT(trace,3,"setmulti");
-	card = (struct qeth_card *) dev->priv;
-
-	if (qeth_set_thread_start_bit(card, QETH_SET_MC_THREAD) == 0)
-		schedule_work(&card->kernel_thread_starter);
-}
 
 static void
 qeth_fill_ipacmd_header(struct qeth_card *card, struct qeth_ipa_cmd *cmd,
@@ -6635,7 +6643,7 @@
 	QETH_DBF_TEXT(trace,4,"clearip");
 	spin_lock_irqsave(&card->ip_lock, flags);
 	/* clear todo list */
-	list_for_each_entry_safe(addr, tmp, &card->ip_tbd_list, entry){
+	list_for_each_entry_safe(addr, tmp, card->ip_tbd_list, entry){
 		list_del(&addr->entry);
 		kfree(addr);
 	}
@@ -6653,7 +6661,7 @@
 			kfree(addr);
 			continue;
 		}
-		list_add_tail(&addr->entry, &card->ip_tbd_list);
+		list_add_tail(&addr->entry, card->ip_tbd_list);
 	}
 	spin_unlock_irqrestore(&card->ip_lock, flags);
 }
@@ -6893,8 +6901,7 @@
 	rtnl_lock();
 	dev_open(card->dev);
 	rtnl_unlock();
- 	if (qeth_set_thread_start_bit(card, QETH_SET_MC_THREAD) == 0)
-		schedule_work(&card->kernel_thread_starter);
+	qeth_set_multicast_list(card->dev);
 }
 
 
@@ -7008,9 +7015,7 @@
 /*maybe it was set offline without ifconfig down
  * we can also use this state for recovery purposes*/
 	if (card->options.layer2)
-		qeth_set_allowed_threads(card,
-					 QETH_RECOVER_THREAD |
-					 QETH_SET_MC_THREAD,0);
+		qeth_set_allowed_threads(card, QETH_RECOVER_THREAD, 0);
 	else
 		qeth_set_allowed_threads(card, 0xffffffff, 0);
 	if (recover_flag == CARD_STATE_RECOVER)
@@ -7339,7 +7344,7 @@
 		return -ENOMEM;
 	spin_lock_irqsave(&card->ip_lock, flags);
 	if (__qeth_address_exists_in_list(&card->ip_list, ipaddr, 0) ||
-	    __qeth_address_exists_in_list(&card->ip_tbd_list, ipaddr, 0))
+	    __qeth_address_exists_in_list(card->ip_tbd_list, ipaddr, 0))
 		rc = -EEXIST;
 	spin_unlock_irqrestore(&card->ip_lock, flags);
 	if (rc){
@@ -7412,7 +7417,7 @@
 		return -ENOMEM;
 	spin_lock_irqsave(&card->ip_lock, flags);
 	if (__qeth_address_exists_in_list(&card->ip_list, ipaddr, 0) ||
-	    __qeth_address_exists_in_list(&card->ip_tbd_list, ipaddr, 0))
+	    __qeth_address_exists_in_list(card->ip_tbd_list, ipaddr, 0))
 		rc = -EEXIST;
 	spin_unlock_irqrestore(&card->ip_lock, flags);
 	if (rc){
