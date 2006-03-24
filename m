Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWCXJGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWCXJGL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 04:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWCXJGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 04:06:11 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:12186 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751453AbWCXJGI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 04:06:08 -0500
Date: Fri, 24 Mar 2006 10:07:16 +0100
From: Frank Pavlic <fpavlic@de.ibm.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RESEND patch 5/6] s390: remove tty support from ctc network device
 driver [1/2]
Message-ID: <20060324100716.39adc2b2@localhost.localdomain>
In-Reply-To: <4421FA37.4050703@pobox.com>
References: <20060322160339.4e6cf34e@localhost.localdomain>
	<4421FA37.4050703@pobox.com>
Organization: IBM
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 5/6] s390: remove tty support from ctc network device driver [1/2]

From: Peter Tiedemann <ptiedem@de.ibm.com>
	[1/2]: 
        tty support code will be removed from the ctc network device driver.
        Today we have a couple of alternatives which are performing much
        better. The second thing is that ctc should be a network 
	device driver only. 
	We should not mix tty and networking here.
        This first patch will remove the tty code from ctcmain.c .
       	It also removes the build entry from the Makefile as well as TTY 
	definitions from ctcmain.h.
        The second patch will remove two files, ctctty.c and ctctty.h.

Signed-off-by: Frank Pavlic <fpavlic@de.ibm.com>

diffstat:

 Makefile  |    3 ++-
 ctcmain.c |   45 +++++++++------------------------------------
 ctcmain.h |   12 +++++-------
 3 files changed, 16 insertions(+), 44 deletions(-)

diff -Naupr git-linux/drivers/s390/net/ctcmain.c git-patched/drivers/s390/net/ctcmain.c
--- git-linux/drivers/s390/net/ctcmain.c	2006-03-24 09:21:59.000000000 +0100
+++ git-patched/drivers/s390/net/ctcmain.c	2006-03-24 09:41:17.000000000 +0100
@@ -6,7 +6,7 @@
  * Fixes by : Jochen Röhrig (roehrig@de.ibm.com)
  *            Arnaldo Carvalho de Melo <acme@conectiva.com.br>
 	      Peter Tiedemann (ptiedem@de.ibm.com)
- * Driver Model stuff by : Cornelia Huck <huckc@de.ibm.com>
+ * Driver Model stuff by : Cornelia Huck <cornelia.huck@de.ibm.com>
  *
  * Documentation used:
  *  - Principles of Operation (IBM doc#: SA22-7201-06)
@@ -65,7 +65,6 @@
 
 #include <asm/idals.h>
 
-#include "ctctty.h"
 #include "fsm.h"
 #include "cu3088.h"
 
@@ -479,10 +478,7 @@ ctc_unpack_skb(struct channel *ch, struc
 		skb->dev = pskb->dev;
 		skb->protocol = pskb->protocol;
 		pskb->ip_summed = CHECKSUM_UNNECESSARY;
-		if (ch->protocol == CTC_PROTO_LINUX_TTY)
-			ctc_tty_netif_rx(skb);
-		else
-			netif_rx_ni(skb);
+		netif_rx_ni(skb);
 		/**
 		 * Successful rx; reset logflags
 		 */
@@ -557,8 +553,7 @@ ccw_unit_check(struct channel *ch, unsig
 	DBF_TEXT(trace, 5, __FUNCTION__);
 	if (sense & SNS0_INTERVENTION_REQ) {
 		if (sense & 0x01) {
-			if (ch->protocol != CTC_PROTO_LINUX_TTY)
-				ctc_pr_debug("%s: Interface disc. or Sel. reset "
+			ctc_pr_debug("%s: Interface disc. or Sel. reset "
 					"(remote)\n", ch->id);
 			fsm_event(ch->fsm, CH_EVENT_UC_RCRESET, ch);
 		} else {
@@ -2034,7 +2029,6 @@ static void
 dev_action_chup(fsm_instance * fi, int event, void *arg)
 {
 	struct net_device *dev = (struct net_device *) arg;
-	struct ctc_priv *privptr = dev->priv;
 
 	DBF_TEXT(trace, 3, __FUNCTION__);
 	switch (fsm_getstate(fi)) {
@@ -2049,8 +2043,6 @@ dev_action_chup(fsm_instance * fi, int e
 				fsm_newstate(fi, DEV_STATE_RUNNING);
 				ctc_pr_info("%s: connected with remote side\n",
 					    dev->name);
-				if (privptr->protocol == CTC_PROTO_LINUX_TTY)
-					ctc_tty_setcarrier(dev, 1);
 				ctc_clear_busy(dev);
 			}
 			break;
@@ -2059,8 +2051,6 @@ dev_action_chup(fsm_instance * fi, int e
 				fsm_newstate(fi, DEV_STATE_RUNNING);
 				ctc_pr_info("%s: connected with remote side\n",
 					    dev->name);
-				if (privptr->protocol == CTC_PROTO_LINUX_TTY)
-					ctc_tty_setcarrier(dev, 1);
 				ctc_clear_busy(dev);
 			}
 			break;
@@ -2086,14 +2076,10 @@ dev_action_chup(fsm_instance * fi, int e
 static void
 dev_action_chdown(fsm_instance * fi, int event, void *arg)
 {
-	struct net_device *dev = (struct net_device *) arg;
-	struct ctc_priv *privptr = dev->priv;
 
 	DBF_TEXT(trace, 3, __FUNCTION__);
 	switch (fsm_getstate(fi)) {
 		case DEV_STATE_RUNNING:
-			if (privptr->protocol == CTC_PROTO_LINUX_TTY)
-				ctc_tty_setcarrier(dev, 0);
 			if (event == DEV_EVENT_TXDOWN)
 				fsm_newstate(fi, DEV_STATE_STARTWAIT_TX);
 			else
@@ -2397,8 +2383,6 @@ ctc_tx(struct sk_buff *skb, struct net_d
 	 */
 	if (fsm_getstate(privptr->fsm) != DEV_STATE_RUNNING) {
 		fsm_event(privptr->fsm, DEV_EVENT_START, dev);
-		if (privptr->protocol == CTC_PROTO_LINUX_TTY)
-			return -EBUSY;
 		dev_kfree_skb(skb);
 		privptr->stats.tx_dropped++;
 		privptr->stats.tx_errors++;
@@ -2608,20 +2592,13 @@ ctc_netdev_unregister(struct net_device 
 	if (!dev)
 		return;
 	privptr = (struct ctc_priv *) dev->priv;
-	if (privptr->protocol != CTC_PROTO_LINUX_TTY)
-		unregister_netdev(dev);
-	else
-		ctc_tty_unregister_netdev(dev);
+	unregister_netdev(dev);
 }
 
 static int
 ctc_netdev_register(struct net_device * dev)
 {
-	struct ctc_priv *privptr = (struct ctc_priv *) dev->priv;
-	if (privptr->protocol != CTC_PROTO_LINUX_TTY)
-		return register_netdev(dev);
-	else
-		return ctc_tty_register_netdev(dev);
+	return register_netdev(dev);
 }
 
 static void
@@ -2667,7 +2644,9 @@ ctc_proto_store(struct device *dev, stru
 	if (!priv)
 		return -ENODEV;
 	sscanf(buf, "%u", &value);
-	if ((value < 0) || (value > CTC_PROTO_MAX))
+	if (!((value == CTC_PROTO_S390)  ||
+	      (value == CTC_PROTO_LINUX) ||
+	      (value == CTC_PROTO_OS390)))
 		return -EINVAL;
 	priv->protocol = value;
 
@@ -2897,10 +2876,7 @@ ctc_new_device(struct ccwgroup_device *c
 		goto out;
 	}
 
-	if (privptr->protocol == CTC_PROTO_LINUX_TTY)
-		strlcpy(dev->name, "ctctty%d", IFNAMSIZ);
-	else
-		strlcpy(dev->name, "ctc%d", IFNAMSIZ);
+	strlcpy(dev->name, "ctc%d", IFNAMSIZ);
 
 	for (direction = READ; direction <= WRITE; direction++) {
 		privptr->channel[direction] =
@@ -3046,7 +3022,6 @@ ctc_exit(void)
 {
 	DBF_TEXT(setup, 3, __FUNCTION__);
 	unregister_cu3088_discipline(&ctc_group_driver);
-	ctc_tty_cleanup();
 	ctc_unregister_dbf_views();
 	ctc_pr_info("CTC driver unloaded\n");
 }
@@ -3073,10 +3048,8 @@ ctc_init(void)
 		ctc_pr_crit("ctc_init failed with ctc_register_dbf_views rc = %d\n", ret);
 		return ret;
 	}
-	ctc_tty_init();
 	ret = register_cu3088_discipline(&ctc_group_driver);
 	if (ret) {
-		ctc_tty_cleanup();
 		ctc_unregister_dbf_views();
 	}
 	return ret;
diff -Naupr git-linux/drivers/s390/net/ctcmain.h git-patched/drivers/s390/net/ctcmain.h
--- git-linux/drivers/s390/net/ctcmain.h	2006-03-24 09:21:59.000000000 +0100
+++ git-patched/drivers/s390/net/ctcmain.h	2006-03-24 09:41:17.000000000 +0100
@@ -35,7 +35,9 @@
 #include <asm/ccwdev.h>
 #include <asm/ccwgroup.h>
 
-#include "ctctty.h"
+#include <linux/skbuff.h>
+#include <linux/netdevice.h>
+
 #include "fsm.h"
 #include "cu3088.h"
 
@@ -50,9 +52,7 @@
 
 #define CTC_PROTO_S390          0
 #define CTC_PROTO_LINUX         1
-#define CTC_PROTO_LINUX_TTY     2
 #define CTC_PROTO_OS390         3
-#define CTC_PROTO_MAX           3
 
 #define CTC_BUFSIZE_LIMIT       65535
 #define CTC_BUFSIZE_DEFAULT     32768
@@ -257,15 +257,13 @@ static __inline__ void
 ctc_clear_busy(struct net_device * dev)
 {
 	clear_bit(0, &(((struct ctc_priv *) dev->priv)->tbusy));
-	if (((struct ctc_priv *)dev->priv)->protocol != CTC_PROTO_LINUX_TTY)
-		netif_wake_queue(dev);
+	netif_wake_queue(dev);
 }
 
 static __inline__ int
 ctc_test_and_set_busy(struct net_device * dev)
 {
-	if (((struct ctc_priv *)dev->priv)->protocol != CTC_PROTO_LINUX_TTY)
-		netif_stop_queue(dev);
+	netif_stop_queue(dev);
 	return test_and_set_bit(0, &((struct ctc_priv *) dev->priv)->tbusy);
 }
 
diff -Naupr git-linux/drivers/s390/net/Makefile git-patched/drivers/s390/net/Makefile
--- git-linux/drivers/s390/net/Makefile	2006-03-24 09:21:59.000000000 +0100
+++ git-patched/drivers/s390/net/Makefile	2006-03-24 09:41:17.000000000 +0100
@@ -2,7 +2,7 @@
 # S/390 network devices
 #
 
-ctc-objs := ctcmain.o ctctty.o ctcdbug.o
+ctc-objs := ctcmain.o ctcdbug.o
 
 obj-$(CONFIG_IUCV) += iucv.o
 obj-$(CONFIG_NETIUCV) += netiucv.o fsm.o
@@ -10,6 +10,7 @@ obj-$(CONFIG_SMSGIUCV) += smsgiucv.o
 obj-$(CONFIG_CTC) += ctc.o fsm.o cu3088.o
 obj-$(CONFIG_LCS) += lcs.o cu3088.o
 obj-$(CONFIG_CLAW) += claw.o cu3088.o
+obj-$(CONFIG_MPC) += ctcmpc.o fsm.o cu3088.o
 qeth-y := qeth_main.o qeth_mpc.o qeth_sys.o qeth_eddp.o 
 qeth-$(CONFIG_PROC_FS) += qeth_proc.o
 obj-$(CONFIG_QETH) += qeth.o
