Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbQKKVR4>; Sat, 11 Nov 2000 16:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129047AbQKKVRr>; Sat, 11 Nov 2000 16:17:47 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:42505 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S129030AbQKKVRg>; Sat, 11 Nov 2000 16:17:36 -0500
Date: Sat, 11 Nov 2000 21:18:33 GMT
Message-Id: <200011112118.VAA32206@tepid.osl.fast.no>
Subject: [patch] patch-2.4.0-test10-irda13 (was: Re: The IrDA patches)
X-Mailer: Pygmy (v0.4.4pre)
Subject: [patch] patch-2.4.0-test10-irda13 (was: Re: The IrDA patches)
Cc: linux-kernel@vger.kernel.org
From: Dag Brattli <dagb@fast.no>
To: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here are the new IrDA patches for Linux-2.4.0-test10. Please apply them to
your latest 2.4 code. If you decide to apply them, then I suggest you start
with the first one (irda1.diff) and work your way to the last one 
(irda24.diff) since most of them are not commutative. 

The name of this patch is irda13.diff. 

(Many thanks to Jean Tourrilhes for splitting up the big patch)

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash
[OUPS   ] : Error that will be fixed in a later patch

irda13.diff :
-----------------
	o [CORRECT] More CONFIG_PROC_FS where needed
	o [CORRECT] Wait if receiving while discovery slot expired
	o [FEATURE] Cleanups

diff -urpN old-linux/include/net/irda/irlan_common.h linux/include/net/irda/irlan_common.h
--- old-linux/include/net/irda/irlan_common.h	Thu Nov  9 14:47:22 2000
+++ linux/include/net/irda/irlan_common.h	Thu Nov  9 17:09:43 2000
@@ -167,22 +167,20 @@ struct irlan_cb {
 	struct net_device dev;        /* Ethernet device structure*/
 	struct net_device_stats stats;
 
-	__u32 saddr;              /* Source device address */
-	__u32 daddr;              /* Destination device address */
-	int   netdev_registered;
-	int   notify_irmanager;
+	__u32 saddr;               /* Source device address */
+	__u32 daddr;               /* Destination device address */
+	int disconnect_reason;     /* Why we got disconnected */
 	
-	int media;                /* Media type */
-	__u8 version[2];          /* IrLAN version */
+	int media;                 /* Media type */
+	__u8 version[2];           /* IrLAN version */
 	
-	struct tsap_cb *tsap_data;
+	struct tsap_cb *tsap_data; /* Data TSAP */
 
-	int  master;              /* Master instance? */
-	int  use_udata;           /* Use Unit Data transfers */
+	int  use_udata;            /* Use Unit Data transfers */
 
-	__u8 stsap_sel_data;      /* Source data TSAP selector */
-	__u8 dtsap_sel_data;      /* Destination data TSAP selector */
-	__u8 dtsap_sel_ctrl;      /* Destination ctrl TSAP selector */
+	__u8 stsap_sel_data;       /* Source data TSAP selector */
+	__u8 dtsap_sel_data;       /* Destination data TSAP selector */
+	__u8 dtsap_sel_ctrl;       /* Destination ctrl TSAP selector */
 
 	struct irlan_client_cb   client;   /* Client specific fields */
 	struct irlan_provider_cb provider; /* Provider specific fields */
@@ -190,10 +188,11 @@ struct irlan_cb {
 	__u32 max_sdu_size;
 	__u8  max_header_size;
 	
+	wait_queue_head_t open_wait;
 	struct timer_list watchdog_timer;
 };
 
-struct irlan_cb *irlan_open(__u32 saddr, __u32 daddr, int netdev);
+struct irlan_cb *irlan_open(__u32 saddr, __u32 daddr);
 void irlan_close(struct irlan_cb *self);
 void irlan_close_tsaps(struct irlan_cb *self);
 void irlan_mod_inc_use_count(void);
diff -urpN old-linux/drivers/net/irda/w83977af_ir.c linux/drivers/net/irda/w83977af_ir.c
--- old-linux/drivers/net/irda/w83977af_ir.c	Thu Nov  9 17:09:30 2000
+++ linux/drivers/net/irda/w83977af_ir.c	Thu Nov  9 17:09:43 2000
@@ -255,13 +255,12 @@ int w83977af_open(int i, unsigned int io
 	dev->get_stats	     = w83977af_net_get_stats;
 
 	rtnl_lock();
-	err = register_netdev(dev);
+	err = register_netdevice(dev);
 	rtnl_unlock();
 	if (err) {
-		ERROR(__FUNCTION__ "(), register_netdev() failed!\n");
+		ERROR(__FUNCTION__ "(), register_netdevice() failed!\n");
 		return -1;
 	}
-
 	MESSAGE("IrDA: Registered device %s\n", dev->name);
 	
 	return 0;
diff -urpN old-linux/net/irda/af_irda.c linux/net/irda/af_irda.c
--- old-linux/net/irda/af_irda.c	Thu Nov  9 16:08:25 2000
+++ linux/net/irda/af_irda.c	Thu Nov  9 17:09:43 2000
@@ -2376,7 +2376,7 @@ static struct notifier_block irda_dev_no
  */
 static int __init irda_proto_init(void)
 {
-	MESSAGE("IrDA (tm) Protocols for Linux-2.3 (Dag Brattli)\n");
+	MESSAGE("IrDA (tm) Protocols for Linux-2.4 (Dag Brattli)\n");
 
         sock_register(&irda_family_ops);
 	
@@ -2403,5 +2403,6 @@ void irda_proto_cleanup(void)
 	unregister_netdevice_notifier(&irda_dev_notifier);
 	
 	sock_unregister(PF_IRDA);
+	
 }
 module_exit(irda_proto_cleanup);
diff -urpN old-linux/net/irda/ircomm/ircomm_tty.c linux/net/irda/ircomm/ircomm_tty.c
--- old-linux/net/irda/ircomm/ircomm_tty.c	Thu Nov  9 17:09:30 2000
+++ linux/net/irda/ircomm/ircomm_tty.c	Thu Nov  9 17:09:43 2000
@@ -69,9 +69,10 @@ static int ircomm_tty_control_indication
 					 struct sk_buff *skb);
 static void ircomm_tty_flow_indication(void *instance, void *sap, 
 				       LOCAL_FLOW cmd);
+#ifdef CONFIG_PROC_FS
 static int ircomm_tty_read_proc(char *buf, char **start, off_t offset, int len,
 				int *eof, void *unused);
-
+#endif /* CONFIG_PROC_FS */
 static struct tty_driver driver;
 static int ircomm_tty_refcount;       /* If we manage several devices */
 
@@ -126,8 +127,9 @@ int __init ircomm_tty_init(void)
 	driver.start           = ircomm_tty_start;
 	driver.hangup          = ircomm_tty_hangup;
 	driver.wait_until_sent = ircomm_tty_wait_until_sent;
+#ifdef CONFIG_PROC_FS
 	driver.read_proc       = ircomm_tty_read_proc;
-
+#endif /* CONFIG_PROC_FS */
 	if (tty_register_driver(&driver)) {
 		ERROR(__FUNCTION__ "Couldn't register serial driver\n");
 		return -1;
@@ -1319,6 +1321,7 @@ static int ircomm_tty_line_info(struct i
  *    
  *
  */
+#ifdef CONFIG_PROC_FS
 static int ircomm_tty_read_proc(char *buf, char **start, off_t offset, int len,
 				int *eof, void *unused)
 {
@@ -1349,7 +1352,7 @@ done:
         *start = buf + (offset-begin);
         return ((len < begin+count-offset) ? len : begin+count-offset);
 }
-
+#endif /* CONFIG_PROC_FS */
 
 #ifdef MODULE
 MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
diff -urpN old-linux/net/irda/irlap_event.c linux/net/irda/irlap_event.c
--- old-linux/net/irda/irlap_event.c	Thu Nov  9 14:51:15 2000
+++ linux/net/irda/irlap_event.c	Thu Nov  9 17:09:43 2000
@@ -9,8 +9,8 @@
  * Modified at:   Sat Dec 25 21:07:57 1999
  * Modified by:   Dag Brattli <dagb@cs.uit.no>
  * 
- *     Copyright (c) 1998-1999 Dag Brattli <dagb@cs.uit.no>,
- *                        Thomas Davis <ratbert@radiks.net>
+ *     Copyright (c) 1998-2000 Dag Brattli <dag@brattli.net>,
+ *     Copyright (c) 1998      Thomas Davis <ratbert@radiks.net>
  *     All Rights Reserved.
  *     
  *     This program is free software; you can redistribute it and/or 
@@ -375,6 +375,7 @@ static int irlap_state_ndm(struct irlap_
 		self->s = info->s;
 		irlap_send_discovery_xid_frame(self, info->S, info->s, TRUE,
 					       info->discovery);
+		self->frame_sent = FALSE;
 		self->s++;
 
 		irlap_start_slot_timer(self, self->slot_timeout);
@@ -385,12 +386,8 @@ static int irlap_state_ndm(struct irlap_
 
 		/* Assert that this is not the final slot */
 		if (info->s <= info->S) {
-			/* self->daddr = info->daddr;  */
 			self->slot = irlap_generate_rand_time_slot(info->S,
 								   info->s);
-			IRDA_DEBUG(4, "XID_CMD: S=%d, s=%d, slot %d\n", info->S, 
-			      info->s, self->slot);
-
 			if (self->slot == info->s) {
 				discovery_rsp = irlmp_get_discovery_response();
 				discovery_rsp->daddr = info->daddr;
@@ -496,6 +493,20 @@ static int irlap_state_query(struct irla
 
 		break;
 	case SLOT_TIMER_EXPIRED:
+		/*
+		 * Wait a little longer if we detect an incomming frame. This
+		 * is not mentioned in the spec, but is a good thing to do, 
+		 * since we want to work even with devices that violate the
+		 * timing requirements.
+		 */
+		if (irda_device_is_receiving(self->netdev)) {
+			IRDA_DEBUG(1, __FUNCTION__ 
+				   "(), device is slow to answer, "
+				   "waiting some more!\n");
+			irlap_start_slot_timer(self, MSECS_TO_JIFFIES(10));
+			return ret;
+		}
+
 		if (self->s < self->S) {
 			irlap_send_discovery_xid_frame(self, self->S, 
 						       self->s, TRUE,
@@ -560,9 +571,7 @@ static int irlap_state_reply(struct irla
 		break;
 	case RECV_DISCOVERY_XID_CMD:
 		ASSERT(info != NULL, return -1;);
-		/*
-		 *  Last frame?
-		 */
+		/* Last frame? */
 		if (info->s == 0xff) {
 			del_timer(&self->query_timer);
 			
@@ -841,7 +850,7 @@ static int irlap_state_xmit_p(struct irl
 				 *  that is not possible since we must be sure
 				 *  that we poll the other side. Since we have
 				 *  used up our time, the poll timer should
-				 *  trigger anyway now,so we just wait for it
+				 *  trigger anyway now, so we just wait for it
 				 *  DB
 				 */
 				return -EPROTO;
@@ -1386,7 +1395,7 @@ static int irlap_state_reset_wait(struct
 		irlap_next_state( self, LAP_PCLOSE);
 		break;
 	default:
-		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown event %s\n", 
+		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown event %s\n", 
 			   irlap_event[event]);
 
 		ret = -1;
@@ -1896,8 +1905,8 @@ static int irlap_state_nrm_s(struct irla
 
 		break;
 	case RECV_TEST_CMD:
-		/* Remove test frame header */
-		skb_pull(skb, sizeof(struct test_frame));
+		/* Remove test frame header (only LAP header in NRM) */
+		skb_pull(skb, LAP_ADDR_HEADER + LAP_CTRL_HEADER);
 
 		irlap_wait_min_turn_around(self, &self->qos_tx);
 		irlap_start_wd_timer(self, self->wd_timeout);
diff -urpN old-linux/net/irda/irlap_frame.c linux/net/irda/irlap_frame.c
--- old-linux/net/irda/irlap_frame.c	Thu Nov  9 14:51:15 2000
+++ linux/net/irda/irlap_frame.c	Thu Nov  9 17:09:43 2000
@@ -1204,7 +1204,7 @@ void irlap_send_test_frame(struct irlap_
 	struct test_frame *frame;
 	__u8 *info;
 
-	skb = dev_alloc_skb(32);
+	skb = dev_alloc_skb(cmd->len+sizeof(struct test_frame));
 	if (!skb)
 		return;
 
@@ -1217,10 +1217,10 @@ void irlap_send_test_frame(struct irlap_
 		frame->saddr = cpu_to_le32(self->saddr);
 		frame->daddr = cpu_to_le32(daddr);
 	} else
-		frame = (struct test_frame *) skb_put(skb, LAP_MAX_HEADER);
+		frame = (struct test_frame *) skb_put(skb, LAP_ADDR_HEADER + LAP_CTRL_HEADER);
 
 	frame->caddr = caddr;
-	frame->control = TEST_RSP;
+	frame->control = TEST_RSP | PF_BIT;
 
 	/* Copy info */
 	info = skb_put(skb, cmd->len);


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
