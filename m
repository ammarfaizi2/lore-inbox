Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266801AbUF3RRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266801AbUF3RRp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 13:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266779AbUF3RRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 13:17:12 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:33494 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S266786AbUF3RI0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 13:08:26 -0400
Date: Wed, 30 Jun 2004 19:08:51 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: network driver changes.
Message-ID: <20040630170851.GD3266@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: network driver changes.

From: Ursula Braun-Krahl <braunu@de.ibm.com>
From: Frank Pavlic <pavlic@de.ibm.com>
From: Thomas Spatzier <tspat@de.ibm.com>
From: Peter Tiedemann <ptiedem@de.ibm.com>

s390 network driver changes:
 - ctc: replace snprintf by strlcpy.
 - lcs: change info text for lcs cards from "OSA2 card" to "OSA LCS card".
 - lcs: fix alignment of lcs_cmd structure to get multicast pings working.
 - lcs: first call in_dev_put then register multicast addresses.
 - netiucv: remove unused device timer and unused flags field.
 - netiucv: include interrupt type in pathid mismatch message.
 - qeth: don't start a new kernel thread for every new ip address.
 - qeth: fix IP assist command sequence numbers.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/net/ctcmain.c   |   10 +++---
 drivers/s390/net/cu3088.c    |    4 +-
 drivers/s390/net/lcs.c       |    6 ++--
 drivers/s390/net/lcs.h       |    6 ++--
 drivers/s390/net/netiucv.c   |   20 +++----------
 drivers/s390/net/qeth.h      |    6 ++--
 drivers/s390/net/qeth_main.c |   63 +++++++++++++++++++++++--------------------
 drivers/s390/net/qeth_mpc.h  |    4 +-
 8 files changed, 57 insertions(+), 62 deletions(-)

diff -urN linux-2.6/drivers/s390/net/ctcmain.c linux-2.6-s390/drivers/s390/net/ctcmain.c
--- linux-2.6/drivers/s390/net/ctcmain.c	Wed Jun 16 07:19:13 2004
+++ linux-2.6-s390/drivers/s390/net/ctcmain.c	Wed Jun 30 17:06:37 2004
@@ -1,5 +1,5 @@
 /*
- * $Id: ctcmain.c,v 1.59 2004/04/21 17:10:13 ptiedem Exp $
+ * $Id: ctcmain.c,v 1.60 2004/06/18 15:13:51 ptiedem Exp $
  *
  * CTC / ESCON network driver
  *
@@ -36,7 +36,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.59 $
+ * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.60 $
  *
  */
 
@@ -319,7 +319,7 @@
 print_banner(void)
 {
 	static int printed = 0;
-	char vbuf[] = "$Revision: 1.59 $";
+	char vbuf[] = "$Revision: 1.60 $";
 	char *version = vbuf;
 
 	if (printed)
@@ -3052,9 +3052,9 @@
 	}
 
 	if (privptr->protocol == CTC_PROTO_LINUX_TTY)
-		snprintf(dev->name, 8, "ctctty%%d");
+		strlcpy(dev->name, "ctctty%d", IFNAMSIZ);
 	else
-		snprintf(dev->name, 8, "ctc%%d");
+		strlcpy(dev->name, "ctc%d", IFNAMSIZ);
 
 	for (direction = READ; direction <= WRITE; direction++) {
 		privptr->channel[direction] =
diff -urN linux-2.6/drivers/s390/net/cu3088.c linux-2.6-s390/drivers/s390/net/cu3088.c
--- linux-2.6/drivers/s390/net/cu3088.c	Wed Jun 16 07:19:10 2004
+++ linux-2.6-s390/drivers/s390/net/cu3088.c	Wed Jun 30 17:06:37 2004
@@ -1,5 +1,5 @@
 /*
- * $Id: cu3088.c,v 1.33 2003/10/14 12:10:19 cohuck Exp $
+ * $Id: cu3088.c,v 1.34 2004/06/15 13:16:27 pavlic Exp $
  *
  * CTC / LCS ccw_device driver
  *
@@ -38,7 +38,7 @@
 	"ESCON channel",
 	"FICON channel",
 	"P390 LCS card",
-	"OSA2 card",
+	"OSA LCS card",
 	"unknown channel type",
 	"unsupported channel type",
 };
diff -urN linux-2.6/drivers/s390/net/lcs.c linux-2.6-s390/drivers/s390/net/lcs.c
--- linux-2.6/drivers/s390/net/lcs.c	Wed Jun 16 07:18:58 2004
+++ linux-2.6-s390/drivers/s390/net/lcs.c	Wed Jun 30 17:06:37 2004
@@ -11,7 +11,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Martin Schwidefsky <schwidefsky@de.ibm.com>
  *
- *    $Revision: 1.81 $	 $Date: 2004/05/14 13:54:33 $
+ *    $Revision: 1.83 $	 $Date: 2004/06/30 12:48:14 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -58,7 +58,7 @@
 /**
  * initialization string for output
  */
-#define VERSION_LCS_C  "$Revision: 1.81 $"
+#define VERSION_LCS_C  "$Revision: 1.83 $"
 
 static char version[] __initdata = "LCS driver ("VERSION_LCS_C "/" VERSION_LCS_H ")";
 static char debug_buffer[255];
@@ -1046,8 +1046,8 @@
 	}
 	spin_unlock(&card->ipm_lock);
 	read_unlock(&in4_dev->lock);
-	lcs_fix_multicast_list(card);
 	in_dev_put(in4_dev);
+	lcs_fix_multicast_list(card);
 	return 0;
 }
 /**
diff -urN linux-2.6/drivers/s390/net/lcs.h linux-2.6-s390/drivers/s390/net/lcs.h
--- linux-2.6/drivers/s390/net/lcs.h	Wed Jun 16 07:19:43 2004
+++ linux-2.6-s390/drivers/s390/net/lcs.h	Wed Jun 30 17:06:38 2004
@@ -6,7 +6,7 @@
 #include <linux/workqueue.h>
 #include <asm/ccwdev.h>
 
-#define VERSION_LCS_H "$Revision: 1.16 $"
+#define VERSION_LCS_H "$Revision: 1.17 $"
 
 #define LCS_DBF_TEXT(level, name, text) \
 	do { \
@@ -221,8 +221,8 @@
 				struct lcs_ip_mac_pair
 				ip_mac_pair[32];
 				__u32	  response_data;
-			} lcs_ipass_ctlmsg;
-		} lcs_qipassist;
+			} lcs_ipass_ctlmsg __attribute ((packed));
+		} lcs_qipassist __attribute__ ((packed));
 #endif /*CONFIG_IP_MULTICAST */
 	} cmd __attribute__ ((packed));
 }  __attribute__ ((packed));
diff -urN linux-2.6/drivers/s390/net/netiucv.c linux-2.6-s390/drivers/s390/net/netiucv.c
--- linux-2.6/drivers/s390/net/netiucv.c	Wed Jun 16 07:19:36 2004
+++ linux-2.6-s390/drivers/s390/net/netiucv.c	Wed Jun 30 17:06:38 2004
@@ -1,5 +1,5 @@
 /*
- * $Id: netiucv.c,v 1.54 2004/05/28 08:04:14 braunu Exp $
+ * $Id: netiucv.c,v 1.57 2004/06/30 09:26:40 braunu Exp $
  *
  * IUCV network driver
  *
@@ -30,7 +30,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV network driver $Revision: 1.54 $
+ * RELEASE-TAG: IUCV network driver $Revision: 1.57 $
  *
  */
 
@@ -98,7 +98,6 @@
 	spinlock_t                collect_lock;
 	int                       collect_len;
 	int                       max_buffsize;
-	int                       flags;
 	fsm_timer                 timer;
 	fsm_instance              *fsm;
 	struct net_device         *netdev;
@@ -106,8 +105,6 @@
 	char                      userid[9];
 };
 
-#define CONN_FLAGS_BUFSIZE_CHANGED 1
-
 /**
  * Linked list of all connection structs.
  */
@@ -131,7 +128,6 @@
 	fsm_instance            *fsm;
         struct iucv_connection  *conn;
 	struct device           *dev;
-	fsm_timer               timer;
 };
 
 /**
@@ -232,7 +228,6 @@
 	DEV_EVENT_STOP,
 	DEV_EVENT_CONUP,
 	DEV_EVENT_CONDOWN,
-	DEV_EVENT_TIMER,
 	/**
 	 * MUST be always the last element!!
 	 */
@@ -244,7 +239,6 @@
 	"Stop",
 	"Connection up",
 	"Connection down",
-	"Timer",
 };
 
 /**
@@ -701,7 +695,7 @@
 	iucv_sever(eib->ippathid, udata);
 	if (eib->ippathid != conn->pathid) {
 		printk(KERN_INFO
-			"%s: IR pathid %d does not match original pathid %d\n",
+			"%s: IR Connection Pending; pathid %d does not match original pathid %d\n",
 			netdev->name, eib->ippathid, conn->pathid);
 		iucv_sever(conn->pathid, udata);
 	}
@@ -722,7 +716,7 @@
 	fsm_newstate(fi, CONN_STATE_IDLE);
 	if (eib->ippathid != conn->pathid) {
 		printk(KERN_INFO
-			"%s: IR pathid %d does not match original pathid %d\n",
+			"%s: IR Connection Complete; pathid %d does not match original pathid %d\n",
 			netdev->name, eib->ippathid, conn->pathid);
 		conn->pathid = eib->ippathid;
 	}
@@ -1372,7 +1366,6 @@
 	priv->conn->max_buffsize = bs1;
 	if (!(ndev->flags & IFF_RUNNING))
 		ndev->mtu = bs1 - NETIUCV_HDRLEN - NETIUCV_HDRLEN;
-	priv->conn->flags |= CONN_FLAGS_BUFSIZE_CHANGED;
 
 	return count;
 
@@ -1756,8 +1749,6 @@
 
 	privptr = (struct netiucv_priv *)dev->priv;
 	if (privptr) {
-		if (privptr->fsm)
-			fsm_deltimer(&privptr->timer);
 		if (privptr->conn)
 			netiucv_remove_connection(privptr->conn);
 		if (privptr->fsm)
@@ -1819,7 +1810,6 @@
 		free_netdev(dev);
 		return NULL;
 	}
-	fsm_settimer(privptr->fsm, &privptr->timer);
 	fsm_newstate(privptr->fsm, DEV_STATE_STOPPED);
 
 	return dev;
@@ -1949,7 +1939,7 @@
 static void
 netiucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.54 $";
+	char vbuf[] = "$Revision: 1.57 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
diff -urN linux-2.6/drivers/s390/net/qeth.h linux-2.6-s390/drivers/s390/net/qeth.h
--- linux-2.6/drivers/s390/net/qeth.h	Wed Jun 16 07:18:52 2004
+++ linux-2.6-s390/drivers/s390/net/qeth.h	Wed Jun 30 17:06:38 2004
@@ -23,7 +23,7 @@
 
 #include "qeth_mpc.h"
 
-#define VERSION_QETH_H 		"$Revision: 1.110 $"
+#define VERSION_QETH_H 		"$Revision: 1.111 $"
 
 #ifdef CONFIG_QETH_IPV6
 #define QETH_VERSION_IPV6 	":IPv6"
@@ -610,14 +610,14 @@
 	__u32 trans_hdr;
 	__u32 pdu_hdr;
 	__u32 pdu_hdr_ack;
-	__u32 ipa;
+	__u16 ipa;
 };
 
 struct qeth_reply {
 	struct list_head list;
 	wait_queue_head_t wait_q;
 	int (*callback)(struct qeth_card *,struct qeth_reply *,unsigned long);
- 	int seqno;
+ 	u32 seqno;
 	unsigned long offset;
 	int received;
 	int rc;
diff -urN linux-2.6/drivers/s390/net/qeth_main.c linux-2.6-s390/drivers/s390/net/qeth_main.c
--- linux-2.6/drivers/s390/net/qeth_main.c	Wed Jun 16 07:19:23 2004
+++ linux-2.6-s390/drivers/s390/net/qeth_main.c	Wed Jun 30 17:06:38 2004
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.121 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.125 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.121 $	 $Date: 2004/06/11 16:32:15 $
+ *    $Revision: 1.125 $	 $Date: 2004/06/29 17:28:24 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -78,7 +78,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-#define VERSION_QETH_C "$Revision: 1.121 $"
+#define VERSION_QETH_C "$Revision: 1.125 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -818,14 +818,20 @@
 static void qeth_add_multicast_ipv6(struct qeth_card *);
 #endif
 
-static void
+static inline int
 qeth_set_thread_start_bit(struct qeth_card *card, unsigned long thread)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&card->thread_mask_lock, flags);
+	if ( !(card->thread_allowed_mask & thread) ||
+	      (card->thread_start_mask & thread) ) {
+		spin_unlock_irqrestore(&card->thread_mask_lock, flags);
+		return -EPERM;
+	}
 	card->thread_start_mask |= thread;
 	spin_unlock_irqrestore(&card->thread_mask_lock, flags);
+	return 0;
 }
 
 static void
@@ -952,8 +958,8 @@
 {
 	QETH_DBF_TEXT(trace,2,"startrec");
 
-	qeth_set_thread_start_bit(card, QETH_RECOVER_THREAD);
-	schedule_work(&card->kernel_thread_starter);
+	if (qeth_set_thread_start_bit(card, QETH_RECOVER_THREAD) == 0)
+		schedule_work(&card->kernel_thread_starter);
 }
 
 static int
@@ -1568,9 +1574,9 @@
 	QETH_DBF_TEXT(trace, 2, "rstipadd");
 
 	qeth_clear_ip_list(card, 0, 1);
-	qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD);
-	qeth_set_thread_start_bit(card, QETH_SET_MC_THREAD);
-	schedule_work(&card->kernel_thread_starter);
+	if ( (qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD) == 0) ||
+	     (qeth_set_thread_start_bit(card, QETH_SET_MC_THREAD) == 0) )
+		schedule_work(&card->kernel_thread_starter);
 }
 
 static struct qeth_ipa_cmd *
@@ -4718,10 +4724,9 @@
 	if (card->vlangrp)
 		card->vlangrp->vlan_devices[vid] = NULL;
 	spin_unlock_irqrestore(&card->vlanlock, flags);
-	qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD);
-	/* delete mc addresses for this vlan dev */
-	qeth_set_thread_start_bit(card, QETH_SET_MC_THREAD);
-	schedule_work(&card->kernel_thread_starter);
+ 	if ( (qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD) == 0) ||
+	     (qeth_set_thread_start_bit(card, QETH_SET_MC_THREAD) == 0) )
+		schedule_work(&card->kernel_thread_starter);
 }
 #endif
 
@@ -4950,8 +4955,8 @@
 	QETH_DBF_TEXT(trace,3,"setmulti");
 	card = (struct qeth_card *) dev->priv;
 
-	qeth_set_thread_start_bit(card, QETH_SET_MC_THREAD);
-	schedule_work(&card->kernel_thread_starter);
+	if (qeth_set_thread_start_bit(card, QETH_SET_MC_THREAD) == 0)
+		schedule_work(&card->kernel_thread_starter);
 }
 
 static void
@@ -6422,8 +6427,8 @@
 	rtnl_lock();
 	dev_open(card->dev);
 	rtnl_unlock();
-	qeth_set_thread_start_bit(card, QETH_SET_MC_THREAD);
-	schedule_work(&card->kernel_thread_starter);
+ 	if (qeth_set_thread_start_bit(card, QETH_SET_MC_THREAD) == 0)
+		schedule_work(&card->kernel_thread_starter);
 }
 
 static int
@@ -6809,8 +6814,8 @@
 	}
 	if (!qeth_add_ip(card, ipaddr))
 		kfree(ipaddr);
-	qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD);
-	schedule_work(&card->kernel_thread_starter);
+ 	if (qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD) == 0)
+		schedule_work(&card->kernel_thread_starter);
 	return rc;
 }
 
@@ -6838,8 +6843,8 @@
 		return;
 	if (!qeth_delete_ip(card, ipaddr))
 		kfree(ipaddr);
-	qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD);
-	schedule_work(&card->kernel_thread_starter);
+ 	if (qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD) == 0)
+		schedule_work(&card->kernel_thread_starter);
 }
 
 /*
@@ -6882,8 +6887,8 @@
 	}
 	if (!qeth_add_ip(card, ipaddr))
 		kfree(ipaddr);
-	qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD);
-	schedule_work(&card->kernel_thread_starter);
+ 	if (qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD) == 0)
+		schedule_work(&card->kernel_thread_starter);
 	return 0;
 }
 
@@ -6911,8 +6916,8 @@
 		return;
 	if (!qeth_delete_ip(card, ipaddr))
 		kfree(ipaddr);
-	qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD);
-	schedule_work(&card->kernel_thread_starter);
+ 	if (qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD) == 0)
+		schedule_work(&card->kernel_thread_starter);
 }
 
 /**
@@ -6952,8 +6957,8 @@
 	default:
 		break;
 	}
-	qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD);
-	schedule_work(&card->kernel_thread_starter);
+ 	if (qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD) == 0)
+		schedule_work(&card->kernel_thread_starter);
 out:
 	return NOTIFY_DONE;
 }
@@ -7005,8 +7010,8 @@
 	default:
 		break;
 	}
-	qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD);
-	schedule_work(&card->kernel_thread_starter);
+ 	if (qeth_set_thread_start_bit(card, QETH_SET_IP_THREAD) == 0)
+		schedule_work(&card->kernel_thread_starter);
 out:
 	return NOTIFY_DONE;
 }
diff -urN linux-2.6/drivers/s390/net/qeth_mpc.h linux-2.6-s390/drivers/s390/net/qeth_mpc.h
--- linux-2.6/drivers/s390/net/qeth_mpc.h	Wed Jun 16 07:19:22 2004
+++ linux-2.6-s390/drivers/s390/net/qeth_mpc.h	Wed Jun 30 17:06:38 2004
@@ -14,7 +14,7 @@
 
 #include <asm/qeth.h>
 
-#define VERSION_QETH_MPC_H "$Revision: 1.35 $"
+#define VERSION_QETH_MPC_H "$Revision: 1.36 $"
 
 extern const char *VERSION_QETH_MPC_C;
 
@@ -36,7 +36,7 @@
 
 #define QETH_TIMEOUT 		(10 * HZ)
 #define QETH_IPA_TIMEOUT 	(45 * HZ)
-#define QETH_IDX_COMMAND_SEQNO 	-1
+#define QETH_IDX_COMMAND_SEQNO 	0xffff0000
 #define SR_INFO_LEN		16
 
 #define QETH_CLEAR_CHANNEL_PARM	-10
