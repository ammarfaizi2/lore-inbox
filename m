Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbUCITPx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:15:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbUCITPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:15:52 -0500
Received: from palrel12.hp.com ([156.153.255.237]:13538 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262135AbUCITOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:14:08 -0500
Date: Tue, 9 Mar 2004 11:14:05 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] (11/14) irda_device inlines and symbols
Message-ID: <20040309191405.GL14543@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir264_irsyms_11_device-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
(11/14) irda_device inlines and symbols   

Make irda_get_mtt, et all inline's not #defines for better
type checking.

irda_device_setup can now be static only called from alloc_irdadev


diff -u -p -r linux/include/net/irda.sA/irda_device.h linux/include/net/irda/irda_device.h
--- linux/include/net/irda.sA/irda_device.h	Wed Mar  3 17:02:52 2004
+++ linux/include/net/irda/irda_device.h	Mon Mar  8 19:44:34 2004
@@ -227,7 +227,6 @@ static inline int irda_device_txqueue_em
 int  irda_device_set_raw_mode(struct net_device* self, int status);
 int  irda_device_set_dtr_rts(struct net_device *dev, int dtr, int rts);
 int  irda_device_change_speed(struct net_device *dev, __u32 speed);
-void irda_device_setup(struct net_device *dev);
 struct net_device *alloc_irdadev(int sizeof_priv);
 
 /* Dongle interface */
@@ -253,28 +252,11 @@ void irda_task_next_state(struct irda_ta
  *    Utility function for getting the minimum turnaround time out of 
  *    the skb, where it has been hidden in the cb field.
  */
-#define irda_get_mtt(skb) (                                                 \
-        IRDA_MIN(10000,                                                     \
-                  (((struct irda_skb_cb *) skb->cb)->magic == LAP_MAGIC) ?  \
-                          ((struct irda_skb_cb *)(skb->cb))->mtt : 10000    \
-                 )							    \
-)
-
-#if 0
-extern inline __u16 irda_get_mtt(struct sk_buff *skb)
+static inline __u16 irda_get_mtt(const struct sk_buff *skb)
 {
-	__u16 mtt;
-
-	if (((struct irda_skb_cb *)(skb->cb))->magic != LAP_MAGIC)
-		mtt = 10000;
-	else
-		mtt = ((struct irda_skb_cb *)(skb->cb))->mtt;
-
-	ASSERT(mtt <= 10000, return 10000;);
-	
-	return mtt;
+	const struct irda_skb_cb *cb = (const struct irda_skb_cb *) skb->cb;
+	return (cb->magic == LAP_MAGIC) ? cb->mtt : 10000;
 }
-#endif
 
 /*
  * Function irda_get_next_speed (skb)
@@ -283,24 +265,11 @@ extern inline __u16 irda_get_mtt(struct 
  *
  * Note : return -1 for user space frames
  */
-#define irda_get_next_speed(skb) (	                                        \
-	(((struct irda_skb_cb*) skb->cb)->magic == LAP_MAGIC) ? 	\
-                  ((struct irda_skb_cb *)(skb->cb))->next_speed : -1 	\
-)
-
-#if 0
-extern inline __u32 irda_get_next_speed(struct sk_buff *skb)
+static inline __u32 irda_get_next_speed(const struct sk_buff *skb)
 {
-	__u32 speed;
-
-	if (((struct irda_skb_cb *)(skb->cb))->magic != LAP_MAGIC)
-		speed = -1;
-	else
-		speed = ((struct irda_skb_cb *)(skb->cb))->next_speed;
-
-	return speed;
+	const struct irda_skb_cb *cb = (const struct irda_skb_cb *) skb->cb;
+	return (cb->magic == LAP_MAGIC) ? cb->next_speed : -1;
 }
-#endif
 
 /*
  * Function irda_get_next_xbofs (skb)
@@ -309,10 +278,11 @@ extern inline __u32 irda_get_next_speed(
  *
  * Note : default to 10 for user space frames
  */
-#define irda_get_xbofs(skb) (	                                        \
-	(((struct irda_skb_cb*) skb->cb)->magic == LAP_MAGIC) ? 	\
-                  ((struct irda_skb_cb *)(skb->cb))->xbofs : 10 	\
-)
+static inline __u16 irda_get_xbofs(const struct sk_buff *skb)
+{
+	const struct irda_skb_cb *cb = (const struct irda_skb_cb *) skb->cb;
+	return (cb->magic == LAP_MAGIC) ? cb->xbofs : 10;
+}
 
 /*
  * Function irda_get_next_xbofs (skb)
@@ -321,11 +291,11 @@ extern inline __u32 irda_get_next_speed(
  *
  * Note : return -1 for user space frames
  */
-#define irda_get_next_xbofs(skb) (	                                        \
-	(((struct irda_skb_cb*) skb->cb)->magic == LAP_MAGIC) ? 	\
-                  ((struct irda_skb_cb *)(skb->cb))->next_xbofs : -1 	\
-)
-
+static inline __u16 irda_get_next_xbofs(const struct sk_buff *skb)
+{
+	const struct irda_skb_cb *cb = (const struct irda_skb_cb *) skb->cb;
+	return (cb->magic == LAP_MAGIC) ? cb->next_xbofs : -1;
+}
 #endif /* IRDA_DEVICE_H */
 
 
diff -u -p -r linux/net/irda.sA/irda_device.c linux/net/irda/irda_device.c
--- linux/net/irda.sA/irda_device.c	Wed Mar  3 17:02:54 2004
+++ linux/net/irda/irda_device.c	Mon Mar  8 19:45:39 2004
@@ -140,6 +140,8 @@ void irda_device_set_media_busy(struct n
 		irlap_stop_mbusy_timer(self);
 	}
 }
+EXPORT_SYMBOL(irda_device_set_media_busy);
+
 
 int irda_device_set_dtr_rts(struct net_device *dev, int dtr, int rts)
 {
@@ -214,6 +216,7 @@ void irda_task_next_state(struct irda_ta
 
 	task->state = state;
 }
+EXPORT_SYMBOL(irda_task_next_state);
 
 static void __irda_task_delete(struct irda_task *task)
 {
@@ -320,7 +323,6 @@ struct irda_task *irda_task_execute(void
 				    struct irda_task *parent, void *param)
 {
 	struct irda_task *task;
-	int ret;
 
 	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
@@ -342,12 +344,9 @@ struct irda_task *irda_task_execute(void
 	hashbin_insert(tasks, (irda_queue_t *) task, (long) task, NULL);
 
 	/* No time to waste, so lets get going! */
-	ret = irda_task_kick(task);
-	if (ret)
-		return NULL;
-	else
-		return task;
+	return irda_task_kick(task) ? NULL : task;
 }
+EXPORT_SYMBOL(irda_task_execute);
 
 /*
  * Function irda_task_timer_expired (data)
@@ -395,6 +394,7 @@ struct net_device *alloc_irdadev(int siz
 {
 	return alloc_netdev(sizeof_priv, "irda%d", irda_device_setup);
 }
+EXPORT_SYMBOL(alloc_irdadev);
 
 /*
  * Function irda_device_init_dongle (self, type, qos)
@@ -446,6 +446,7 @@ dongle_t *irda_device_dongle_init(struct
 	spin_unlock(&dongles->hb_spinlock);
 	return dongle;
 }
+EXPORT_SYMBOL(irda_device_dongle_init);
 
 /*
  * Function irda_device_dongle_cleanup (dongle)
@@ -460,6 +461,7 @@ int irda_device_dongle_cleanup(dongle_t 
 
 	return 0;
 }
+EXPORT_SYMBOL(irda_device_dongle_cleanup);
 
 /*
  * Function irda_device_register_dongle (dongle)
@@ -479,6 +481,7 @@ int irda_device_register_dongle(struct d
 
         return 0;
 }
+EXPORT_SYMBOL(irda_device_register_dongle);
 
 /*
  * Function irda_device_unregister_dongle (dongle)
@@ -496,6 +499,7 @@ void irda_device_unregister_dongle(struc
 		ERROR("%s: dongle not found!\n", __FUNCTION__);
 	spin_unlock(&dongles->hb_spinlock);
 }
+EXPORT_SYMBOL(irda_device_unregister_dongle);
 
 /*
  * Function irda_device_set_mode (self, mode)
diff -u -p -r linux/net/irda.sA/irsyms.c linux/net/irda/irsyms.c
--- linux/net/irda.sA/irsyms.c	Mon Mar  8 19:18:01 2004
+++ linux/net/irda/irsyms.c	Mon Mar  8 19:20:34 2004
@@ -82,18 +82,6 @@ EXPORT_SYMBOL(irda_param_unpack);
 /* IrLAP */
 EXPORT_SYMBOL(irda_init_max_qos_capabilies);
 EXPORT_SYMBOL(irda_qos_bits_to_value);
-EXPORT_SYMBOL(irda_device_setup);
-EXPORT_SYMBOL(alloc_irdadev);
-EXPORT_SYMBOL(irda_device_set_media_busy);
-EXPORT_SYMBOL(irda_device_txqueue_empty);
-
-EXPORT_SYMBOL(irda_device_dongle_init);
-EXPORT_SYMBOL(irda_device_dongle_cleanup);
-EXPORT_SYMBOL(irda_device_register_dongle);
-EXPORT_SYMBOL(irda_device_unregister_dongle);
-EXPORT_SYMBOL(irda_task_execute);
-EXPORT_SYMBOL(irda_task_next_state);
-EXPORT_SYMBOL(irda_task_delete);
 
 
 #ifdef CONFIG_IRDA_DEBUG
