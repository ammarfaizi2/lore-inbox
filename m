Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQKKVY4>; Sat, 11 Nov 2000 16:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129047AbQKKVYq>; Sat, 11 Nov 2000 16:24:46 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:48905 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S129045AbQKKVYf>; Sat, 11 Nov 2000 16:24:35 -0500
Date: Sat, 11 Nov 2000 21:25:32 GMT
Message-Id: <200011112125.VAA32410@tepid.osl.fast.no>
Subject: [patch] patch-2.4.0-test10-irda15 (was: Re: The IrDA patches)
X-Mailer: Pygmy (v0.4.4pre)
Subject: [patch] patch-2.4.0-test10-irda15 (was: Re: The IrDA patches)
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

The name of this patch is irda15.diff. 

(Many thanks to Jean Tourrilhes for splitting up the big patch)

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash
[OUPS   ] : Error that will be fixed in a later patch

irda15.diff :
-----------------
	o [-OUPS  ] Missing a bit for -> module init change
	o [CRITICA] IrLAN update (was broken - various things)

diff -urpN old-linux/net/irda/af_irda.c linux/net/irda/af_irda.c
--- old-linux/net/irda/af_irda.c	Thu Nov  9 17:11:25 2000
+++ linux/net/irda/af_irda.c	Thu Nov  9 17:26:46 2000
@@ -2395,7 +2395,7 @@ module_init(irda_proto_init);
  *    Remove IrDA protocol layer
  *
  */
-void irda_proto_cleanup(void)
+void __exit irda_proto_cleanup(void)
 {
 	irda_packet_type.type = htons(ETH_P_IRDA);
 	dev_remove_pack(&irda_packet_type);
@@ -2403,6 +2403,5 @@ void irda_proto_cleanup(void)
 	unregister_netdevice_notifier(&irda_dev_notifier);
 	
 	sock_unregister(PF_IRDA);
-	
 }
 module_exit(irda_proto_cleanup);
diff -urpN old-linux/net/irda/irlan/irlan_client.c linux/net/irda/irlan/irlan_client.c
--- old-linux/net/irda/irlan/irlan_client.c	Thu Nov  9 13:27:10 2000
+++ linux/net/irda/irlan/irlan_client.c	Thu Nov  9 17:20:01 2000
@@ -104,8 +104,6 @@ void irlan_client_start_kick_timer(struc
  */
 void irlan_client_wakeup(struct irlan_cb *self, __u32 saddr, __u32 daddr)
 {
-	struct irmanager_event mgr_event;
-
 	IRDA_DEBUG(1, __FUNCTION__ "()\n");
 
 	ASSERT(self != NULL, return;);
@@ -117,41 +115,24 @@ void irlan_client_wakeup(struct irlan_cb
 	 */
 	if ((self->client.state != IRLAN_IDLE) || 
 	    (self->provider.access_type == ACCESS_DIRECT))
-		return;
+	{
+			IRDA_DEBUG(0, __FUNCTION__ "(), already awake!\n");
+			return;
+	}
 
-	/* saddr may have changed! */
+	/* Address may have changed! */
 	self->saddr = saddr;
-	
-	/* Before we try to connect, we check if network device is up. If it
-	 * is up, that means that the "user" really wants to connect. If not
-	 * we notify the user about the possibility of an IrLAN connection
-	 */
-	if (netif_running(&self->dev)) {
-		/* Open TSAPs */
-		irlan_client_open_ctrl_tsap(self);
- 		irlan_open_data_tsap(self);
-		
-		irlan_do_client_event(self, IRLAN_DISCOVERY_INDICATION, NULL);
-	} else if (self->notify_irmanager) {
-		/* 
-		 * Tell irmanager that the device can now be 
-		 * configured but only if the device was not taken
-		 * down by the user
-		 */
-		mgr_event.event = EVENT_IRLAN_START;
-		strcpy(mgr_event.devname, self->dev.name);
-		irmanager_notify(&mgr_event);
-		
-		/* 
-		 * We set this so that we only notify once, since if 
-		 * configuration of the network device fails, the user
-		 * will have to sort it out first anyway. No need to 
-		 * try again.
-		 */
-		self->notify_irmanager = FALSE;
+
+	if (self->disconnect_reason == LM_USER_REQUEST) {
+			IRDA_DEBUG(0, __FUNCTION__ "(), still stopped by user\n");
+			return;
 	}
-	/* Restart watchdog timer */
-	irlan_start_watchdog_timer(self, IRLAN_TIMEOUT);
+
+	/* Open TSAPs */
+	irlan_client_open_ctrl_tsap(self);
+	irlan_open_data_tsap(self);
+
+	irlan_do_client_event(self, IRLAN_DISCOVERY_INDICATION, NULL);
 	
 	/* Start kick timer */
 	irlan_client_start_kick_timer(self, 2*HZ);
@@ -176,29 +157,16 @@ void irlan_client_discovery_indication(d
 	saddr = discovery->saddr;
 	daddr = discovery->daddr;
 
-	/* 
-	 *  Check if we already dealing with this provider.
-	 */
-	self = (struct irlan_cb *) hashbin_find(irlan, daddr, NULL);
-      	if (self) {
+	/* Find instance */
+	self = (struct irlan_cb *) hashbin_get_first(irlan);
+    if (self) {
 		ASSERT(self->magic == IRLAN_MAGIC, return;);
 
 		IRDA_DEBUG(1, __FUNCTION__ "(), Found instance (%08x)!\n",
 		      daddr);
 		
 		irlan_client_wakeup(self, saddr, daddr);
-
-		return;
 	}
-	
-	/* 
-	 * We have no instance for daddr, so start a new one
-	 */
-	IRDA_DEBUG(1, __FUNCTION__ "(), starting new instance!\n");
-	self = irlan_open(saddr, daddr, TRUE);
-
-	/* Restart watchdog timer */
-	irlan_start_watchdog_timer(self, IRLAN_TIMEOUT);
 }
 	
 /*
@@ -449,9 +417,7 @@ static void irlan_check_response_param(s
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRLAN_MAGIC, return;);
 
-	/*
-	 *  Media type
-	 */
+	/* Media type */
 	if (strcmp(param, "MEDIA") == 0) {
 		if (strcmp(value, "802.3") == 0)
 			self->media = MEDIA_802_3;
@@ -487,9 +453,7 @@ static void irlan_check_response_param(s
 			IRDA_DEBUG(2, __FUNCTION__ "(), unknown access type!\n");
 		}
 	}
-	/*
-	 *  IRLAN version
-	 */
+	/* IRLAN version */
 	if (strcmp(param, "IRLAN_VER") == 0) {
 		IRDA_DEBUG(4, "IrLAN version %d.%d\n", (__u8) value[0], 
 		      (__u8) value[1]);
@@ -498,9 +462,7 @@ static void irlan_check_response_param(s
 		self->version[1] = value[1];
 		return;
 	}
-	/*
-	 *  Which remote TSAP to use for data channel
-	 */
+	/* Which remote TSAP to use for data channel */
 	if (strcmp(param, "DATA_CHAN") == 0) {
 		self->dtsap_sel_data = value[0];
 		IRDA_DEBUG(4, "Data TSAP = %02x\n", self->dtsap_sel_data);
@@ -521,9 +483,7 @@ static void irlan_check_response_param(s
 			   self->client.max_frame);
 	}
 	 
-	/*
-	 *  RECONNECT_KEY, in case the link goes down!
-	 */
+	/* RECONNECT_KEY, in case the link goes down! */
 	if (strcmp(param, "RECONNECT_KEY") == 0) {
 		IRDA_DEBUG(4, "Got reconnect key: ");
 		/* for (i = 0; i < val_len; i++) */
@@ -532,9 +492,7 @@ static void irlan_check_response_param(s
 		self->client.key_len = val_len;
 		IRDA_DEBUG(4, "\n");
 	}
-	/*
-	 *  FILTER_ENTRY, have we got an ethernet address?
-	 */
+	/* FILTER_ENTRY, have we got an ethernet address? */
 	if (strcmp(param, "FILTER_ENTRY") == 0) {
 		bytes = value;
 		IRDA_DEBUG(4, "Ethernet address = %02x:%02x:%02x:%02x:%02x:%02x\n",
diff -urpN old-linux/net/irda/irlan/irlan_common.c linux/net/irda/irlan/irlan_common.c
--- old-linux/net/irda/irlan/irlan_common.c	Thu Nov  9 17:09:30 2000
+++ linux/net/irda/irlan/irlan_common.c	Thu Nov  9 17:20:01 2000
@@ -50,6 +50,14 @@
 #include <net/irda/irlan_eth.h>
 #include <net/irda/irlan_filter.h>
 
+
+/* 
+ * Send gratuitous ARP when connected to a new AP or not. May be a clever
+ * thing to do, but for some reason the machine crashes if you use DHCP. So
+ * lets not use it by default.
+ */
+#undef CONFIG_IRLAN_SEND_GRATUITOUS_ARP
+
 /* extern char sysctl_devname[]; */
 
 /*
@@ -104,59 +112,6 @@ extern struct proc_dir_entry *proc_irda;
 #endif /* CONFIG_PROC_FS */
 
 /*
- * Function irlan_watchdog_timer_expired (data)
- *
- *    Something has gone wrong during the connection establishment
- *
- */
-void irlan_watchdog_timer_expired(void *data)
-{
-	struct irmanager_event mgr_event;
-	struct irlan_cb *self;
-	
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
-
-	self = (struct irlan_cb *) data;
-
-	ASSERT(self != NULL, return;);
-	ASSERT(self->magic == IRLAN_MAGIC, return;);
-
-	/* Check if device still configured */
-	if (netif_running(&self->dev)) {
-		IRDA_DEBUG(0, __FUNCTION__ 
-		      "(), notifying irmanager to stop irlan!\n");
-		mgr_event.event = EVENT_IRLAN_STOP;
-		sprintf(mgr_event.devname, "%s", self->dev.name);
-		irmanager_notify(&mgr_event);
-
-		/*
-		 *  We set this to false, so that irlan_dev_close known that
-		 *  notify_irmanager should actually be set to TRUE again 
-		 *  instead of FALSE, since this close has not been initiated
-		 *  by the user.
-		 */
-		self->notify_irmanager = FALSE;
-	} else {
-		IRDA_DEBUG(0, __FUNCTION__ "(), closing instance!\n");
-		/*irlan_close(self);*/
-	}
-}
-
-/*
- * Function irlan_start_watchdog_timer (self, timeout)
- *
- *    
- *
- */
-void irlan_start_watchdog_timer(struct irlan_cb *self, int timeout)
-{
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
-	
-	irda_start_timer(&self->watchdog_timer, timeout, (void *) self,
-			 irlan_watchdog_timer_expired);
-}
-
-/*
  * Function irlan_init (void)
  *
  *    Initialize IrLAN layer
@@ -167,8 +122,6 @@ int __init irlan_init(void)
 	struct irlan_cb *new;
 	__u16 hints;
 
-	IRDA_DEBUG(4, __FUNCTION__"()\n");
-
 	/* Allocate master structure */
 	irlan = hashbin_new(HB_LOCAL); 
 	if (irlan == NULL) {
@@ -180,7 +133,6 @@ int __init irlan_init(void)
 #endif /* CONFIG_PROC_FS */
 
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
-	
 	hints = irlmp_service_to_hint(S_LAN);
 
 	/* Register with IrLMP as a client */
@@ -190,12 +142,11 @@ int __init irlan_init(void)
 	/* Register with IrLMP as a service */
  	skey = irlmp_register_service(hints);
 
-	/* Start the master IrLAN instance */
- 	new = irlan_open(DEV_ADDR_ANY, DEV_ADDR_ANY, FALSE);
+	/* Start the master IrLAN instance (the only one for now) */
+ 	new = irlan_open(DEV_ADDR_ANY, DEV_ADDR_ANY);
 
 	/* The master will only open its (listen) control TSAP */
 	irlan_provider_open_ctrl_tsap(new);
-	new->master = TRUE;
 
 	/* Do some fast discovery! */
 	irlmp_discovery_request(DISCOVERY_DEFAULT_SLOTS);
@@ -208,7 +159,6 @@ void irlan_cleanup(void) 
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
 
 	irlmp_unregister_client(ckey);
-
 	irlmp_unregister_service(skey);
 
 #ifdef CONFIG_PROC_FS
@@ -244,8 +194,6 @@ int irlan_register_netdev(struct irlan_c
 		IRDA_DEBUG(2, __FUNCTION__ "(), register_netdev() failed!\n");
 		return -1;
 	}
-	self->netdev_registered = TRUE;
-	
 	return 0;
 }
 
@@ -255,7 +203,7 @@ int irlan_register_netdev(struct irlan_c
  *    Open new instance of a client/provider, we should only register the 
  *    network device if this instance is ment for a particular client/provider
  */
-struct irlan_cb *irlan_open(__u32 saddr, __u32 daddr, int netdev)
+struct irlan_cb *irlan_open(__u32 saddr, __u32 daddr)
 {
 	struct irlan_cb *self;
 
@@ -289,11 +237,10 @@ struct irlan_cb *irlan_open(__u32 saddr,
 	/* Provider access can only be PEER, DIRECT, or HOSTED */
 	self->provider.access_type = access;
 	self->media = MEDIA_802_3;
-
-	self->notify_irmanager = TRUE;
-
+	self->disconnect_reason = LM_USER_REQUEST;
 	init_timer(&self->watchdog_timer);
 	init_timer(&self->client.kick_timer);
+	init_waitqueue_head(&self->open_wait);	
 
 	hashbin_insert(irlan, (irda_queue_t *) self, daddr, NULL);
 	
@@ -302,19 +249,16 @@ struct irlan_cb *irlan_open(__u32 saddr,
 	irlan_next_client_state(self, IRLAN_IDLE);
 	irlan_next_provider_state(self, IRLAN_IDLE);
 
-	/* Register network device now, or wait until some later time? */
-	if (netdev)
-		irlan_register_netdev(self);
+	irlan_register_netdev(self);
 
 	return self;
 }
 /*
- * Function irlan_close (self)
+ * Function __irlan_close (self)
  *
  *    This function closes and deallocates the IrLAN client instances. Be 
  *    aware that other functions which calles client_close() must call 
  *    hashbin_remove() first!!!
- *
  */
 static void __irlan_close(struct irlan_cb *self)
 {
@@ -335,49 +279,13 @@ static void __irlan_close(struct irlan_c
 		iriap_close(self->client.iriap);
 
 	/* Remove frames queued on the control channel */
-	while ((skb = skb_dequeue(&self->client.txq))) {
+	while ((skb = skb_dequeue(&self->client.txq)))
 		dev_kfree_skb(skb);
-	}
 
-	if (self->netdev_registered) {
-		unregister_netdev(&self->dev);
-		self->netdev_registered = FALSE;
-	}
+	unregister_netdev(&self->dev);
 	
 	self->magic = 0;
- 	kfree(self);
-}
-
-/*
- * Function irlan_close (self)
- *
- *    Close instance
- *
- */
-void irlan_close(struct irlan_cb *self)
-{
-	struct irlan_cb *entry;
-
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
-
-        ASSERT(self != NULL, return;);
-	ASSERT(self->magic == IRLAN_MAGIC, return;);
-
-	/* Check if device is still configured */
-	if (netif_running(&self->dev)) {
-		IRDA_DEBUG(0, __FUNCTION__ 
-		       "(), Device still configured, closing later!\n");
-
-		/* Give it a chance to reconnect */
-		irlan_start_watchdog_timer(self, IRLAN_TIMEOUT);
-		return;
-	}
-	IRDA_DEBUG(2, __FUNCTION__ "(), daddr=%08x\n", self->daddr);
-	entry = hashbin_remove(irlan, self->daddr, NULL);
-
-	ASSERT(entry == self, return;);
-	
-        __irlan_close(self);
+	kfree(self);
 }
 
 /*
@@ -421,7 +329,7 @@ void irlan_connect_indication(void *inst
 		irlan_open_unicast_addr(self);
 	}
 	/* Ready to transfer Ethernet frames (at last) */
-	netif_start_queue(&self->dev);
+	netif_start_queue(&self->dev); /* Clear reason */
 }
 
 void irlan_connect_confirm(void *instance, void *sap, struct qos_info *qos, 
@@ -456,7 +364,11 @@ void irlan_connect_confirm(void *instanc
 
 	/* Ready to transfer Ethernet frames */
 	netif_start_queue(&self->dev);
+	self->disconnect_reason = 0; /* Clear reason */
+#ifdef CONFIG_IRLAN_SEND_GRATUITOUS_ARP
 	irlan_eth_send_gratuitous_arp(&self->dev);
+#endif
+	wake_up_interruptible(&self->open_wait);
 }
 
 /*
@@ -485,28 +397,34 @@ void irlan_disconnect_indication(void *i
 
 	IRDA_DEBUG(2, "IrLAN, data channel disconnected by peer!\n");
 
-	switch(reason) {
+	/* Save reason so we know if we should try to reconnect or not */
+	self->disconnect_reason = reason;
+	
+	switch (reason) {
 	case LM_USER_REQUEST: /* User request */
-		irlan_close(self);
+		IRDA_DEBUG(2, __FUNCTION__ "(), User requested\n");
 		break;
 	case LM_LAP_DISCONNECT: /* Unexpected IrLAP disconnect */
-		irlan_start_watchdog_timer(self, IRLAN_TIMEOUT);
+		IRDA_DEBUG(2, __FUNCTION__ "(), Unexpected IrLAP disconnect\n");
 		break;
 	case LM_CONNECT_FAILURE: /* Failed to establish IrLAP connection */
-		IRDA_DEBUG(2, __FUNCTION__ "(), LM_CONNECT_FAILURE not impl\n");
+		IRDA_DEBUG(2, __FUNCTION__ "(), IrLAP connect failed\n");
 		break;
 	case LM_LAP_RESET:  /* IrLAP reset */
-		IRDA_DEBUG(2, __FUNCTION__ "(), LM_CONNECT_FAILURE not impl\n");
+		IRDA_DEBUG(2, __FUNCTION__ "(), IrLAP reset\n");
 		break;
 	case LM_INIT_DISCONNECT:
-		IRDA_DEBUG(2, __FUNCTION__ "(), LM_CONNECT_FAILURE not impl\n");
+		IRDA_DEBUG(2, __FUNCTION__ "(), IrLMP connect failed\n");
 		break;
 	default:
+		ERROR(__FUNCTION__ "(), Unknown disconnect reason\n");
 		break;
 	}
 	
 	irlan_do_client_event(self, IRLAN_LMP_DISCONNECT, NULL);
 	irlan_do_provider_event(self, IRLAN_LMP_DISCONNECT, NULL);
+	
+	wake_up_interruptible(&self->open_wait);
 }
 
 void irlan_open_data_tsap(struct irlan_cb *self)
@@ -555,9 +473,7 @@ void irlan_close_tsaps(struct irlan_cb *
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRLAN_MAGIC, return;);
 
-	/* 
-	 *  Disconnect and close all open TSAP connections
-	 */
+	/* Disconnect and close all open TSAP connections */
 	if (self->tsap_data) {
 		irttp_disconnect_request(self->tsap_data, NULL, P_NORMAL);
 		irttp_close_tsap(self->tsap_data);
@@ -575,6 +491,7 @@ void irlan_close_tsaps(struct irlan_cb *
 		irttp_close_tsap(self->provider.tsap_ctrl);
 		self->provider.tsap_ctrl = NULL;
 	}
+	self->disconnect_reason = LM_USER_REQUEST;
 }
 
 /*
@@ -641,7 +558,7 @@ int irlan_run_ctrl_tx_queue(struct irlan
 {
 	struct sk_buff *skb;
 
-	IRDA_DEBUG(3, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, __FUNCTION__ "()\n");
 
 	if (irda_lock(&self->client.tx_busy) == FALSE)
 		return -EBUSY;
@@ -660,7 +577,7 @@ int irlan_run_ctrl_tx_queue(struct irlan
 		dev_kfree_skb(skb);
 		return -1;
 	}
-	IRDA_DEBUG(3, __FUNCTION__ "(), sending ...\n");
+	IRDA_DEBUG(2, __FUNCTION__ "(), sending ...\n");
 
 	return irttp_data_request(self->client.tsap_ctrl, skb);
 }
@@ -749,7 +666,6 @@ void irlan_open_data_channel(struct irla
 
 /* 	self->use_udata = TRUE; */
 
-	/* irttp_data_request(self->client.tsap_ctrl, skb); */
 	irlan_ctrl_data_request(self, skb);
 }
 
@@ -818,7 +734,6 @@ void irlan_open_unicast_addr(struct irla
  	irlan_insert_string_param(skb, "FILTER_TYPE", "DIRECTED");
  	irlan_insert_string_param(skb, "FILTER_MODE", "FILTER"); 
 	
-	/* irttp_data_request(self->client.tsap_ctrl, skb); */
 	irlan_ctrl_data_request(self, skb);
 }
 
@@ -860,7 +775,6 @@ void irlan_set_broadcast_filter(struct i
 	else
 		irlan_insert_string_param(skb, "FILTER_MODE", "NONE"); 
 
-	/* irttp_data_request(self->client.tsap_ctrl, skb); */
 	irlan_ctrl_data_request(self, skb);
 }
 
@@ -900,7 +814,6 @@ void irlan_set_multicast_filter(struct i
 	else
 		irlan_insert_string_param(skb, "FILTER_MODE", "NONE"); 
 
-	/* irttp_data_request(self->client.tsap_ctrl, skb); */
 	irlan_ctrl_data_request(self, skb);
 }
 
@@ -938,7 +851,6 @@ void irlan_get_unicast_addr(struct irlan
  	irlan_insert_string_param(skb, "FILTER_TYPE", "DIRECTED");
  	irlan_insert_string_param(skb, "FILTER_OPERATION", "DYNAMIC"); 
 	
-	/* irttp_data_request(self->client.tsap_ctrl, skb); */
 	irlan_ctrl_data_request(self, skb);
 }
 
@@ -973,8 +885,6 @@ void irlan_get_media_char(struct irlan_c
 	frame[1] = 0x01; /* One parameter */
 	
 	irlan_insert_string_param(skb, "MEDIA", "802.3");
-	
-	/* irttp_data_request(self->client.tsap_ctrl, skb); */
 	irlan_ctrl_data_request(self, skb);
 }
 
@@ -1177,35 +1087,32 @@ static int irlan_proc_read(char *buf, ch
 	while (self != NULL) {
 		ASSERT(self->magic == IRLAN_MAGIC, return len;);
 		
-		/* Don't display the master server */
-		if (self->master == 0) {
-			len += sprintf(buf+len, "ifname: %s,\n",
-				       self->dev.name);
-			len += sprintf(buf+len, "client state: %s, ",
-				       irlan_state[ self->client.state]);
-			len += sprintf(buf+len, "provider state: %s,\n",
-				       irlan_state[ self->provider.state]);
-			len += sprintf(buf+len, "saddr: %#08x, ",
-				       self->saddr);
-			len += sprintf(buf+len, "daddr: %#08x\n",
-				       self->daddr);
-			len += sprintf(buf+len, "version: %d.%d,\n",
-				       self->version[1], self->version[0]);
-			len += sprintf(buf+len, "access type: %s\n", 
-				       irlan_access[self->client.access_type]);
-			len += sprintf(buf+len, "media: %s\n", 
-				       irlan_media[self->media]);
-			
-			len += sprintf(buf+len, "local filter:\n");
-			len += sprintf(buf+len, "remote filter: ");
-			len += irlan_print_filter(self->client.filter_type, 
-						  buf+len);
+		len += sprintf(buf+len, "ifname: %s,\n",
+			       self->dev.name);
+		len += sprintf(buf+len, "client state: %s, ",
+			       irlan_state[ self->client.state]);
+		len += sprintf(buf+len, "provider state: %s,\n",
+			       irlan_state[ self->provider.state]);
+		len += sprintf(buf+len, "saddr: %#08x, ",
+			       self->saddr);
+		len += sprintf(buf+len, "daddr: %#08x\n",
+			       self->daddr);
+		len += sprintf(buf+len, "version: %d.%d,\n",
+			       self->version[1], self->version[0]);
+		len += sprintf(buf+len, "access type: %s\n", 
+			       irlan_access[self->client.access_type]);
+		len += sprintf(buf+len, "media: %s\n", 
+			       irlan_media[self->media]);
+		
+		len += sprintf(buf+len, "local filter:\n");
+		len += sprintf(buf+len, "remote filter: ");
+		len += irlan_print_filter(self->client.filter_type, 
+					  buf+len);
 			
-			len += sprintf(buf+len, "tx busy: %s\n", 
-				       netif_queue_stopped(&self->dev) ? "TRUE" : "FALSE");
+		len += sprintf(buf+len, "tx busy: %s\n", 
+			       netif_queue_stopped(&self->dev) ? "TRUE" : "FALSE");
 			
-			len += sprintf(buf+len, "\n");
-		}
+		len += sprintf(buf+len, "\n");
 
 		self = (struct irlan_cb *) hashbin_get_next(irlan);
  	} 
diff -urpN old-linux/net/irda/irlan/irlan_eth.c linux/net/irda/irlan/irlan_eth.c
--- old-linux/net/irda/irlan/irlan_eth.c	Tue Jul 11 11:12:24 2000
+++ linux/net/irda/irlan/irlan_eth.c	Thu Nov  9 17:20:01 2000
@@ -48,7 +48,6 @@
  */
 int irlan_eth_init(struct net_device *dev)
 {
-	struct irmanager_event mgr_event;
 	struct irlan_cb *self;
 
 	IRDA_DEBUG(2, __FUNCTION__"()\n");
@@ -85,22 +84,6 @@ int irlan_eth_init(struct net_device *de
 		get_random_bytes(dev->dev_addr+5, 1);
 	}
 
-	/* 
-	 * Network device has now been registered, so tell irmanager about
-	 * it, so it can be configured with network parameters
-	 */
-	mgr_event.event = EVENT_IRLAN_START;
-	sprintf(mgr_event.devname, "%s", self->dev.name);
-	irmanager_notify(&mgr_event);
-
-	/* 
-	 * We set this so that we only notify once, since if 
-	 * configuration of the network device fails, the user
-	 * will have to sort it out first anyway. No need to 
-	 * try again.
-	 */
-	self->notify_irmanager = FALSE;
-
 	return 0;
 }
 
@@ -123,14 +106,16 @@ int irlan_eth_open(struct net_device *de
 	ASSERT(self != NULL, return -1;);
 
 	/* Ready to play! */
-/* 	netif_start_queue(dev) */ /* Wait until data link is ready */
-
-	self->notify_irmanager = TRUE;
+ 	netif_stop_queue(dev); /* Wait until data link is ready */
 
 	/* We are now open, so time to do some work */
+	self->disconnect_reason = 0;
 	irlan_client_wakeup(self, self->saddr, self->daddr);
 
 	irlan_mod_inc_use_count();
+
+	/* Make sure we have a hardware address before we return, so DHCP clients gets happy */
+	interruptible_sleep_on(&self->open_wait);
 	
 	return 0;
 }
@@ -146,7 +131,8 @@ int irlan_eth_open(struct net_device *de
 int irlan_eth_close(struct net_device *dev)
 {
 	struct irlan_cb *self = (struct irlan_cb *) dev->priv;
-
+	struct sk_buff *skb;
+	
 	IRDA_DEBUG(2, __FUNCTION__ "()\n");
 	
 	/* Stop device */
@@ -155,20 +141,17 @@ int irlan_eth_close(struct net_device *d
 	irlan_mod_dec_use_count();
 
 	irlan_close_data_channel(self);
-
 	irlan_close_tsaps(self);
 
 	irlan_do_client_event(self, IRLAN_LMP_DISCONNECT, NULL);
 	irlan_do_provider_event(self, IRLAN_LMP_DISCONNECT, NULL);	
 	
-	irlan_start_watchdog_timer(self, IRLAN_TIMEOUT);
-
-	/* Device closed by user! */
-	if (self->notify_irmanager)
-		self->notify_irmanager = FALSE;
-	else
-		self->notify_irmanager = TRUE;
+	/* Remove frames queued on the control channel */
+	while ((skb = skb_dequeue(&self->client.txq)))
+			dev_kfree_skb(skb);
 
+	self->client.tx_busy = 0;
+	
 	return 0;
 }
 
diff -urpN old-linux/net/irda/irlan/irlan_provider.c linux/net/irda/irlan/irlan_provider.c
--- old-linux/net/irda/irlan/irlan_provider.c	Tue Nov  2 17:07:55 1999
+++ linux/net/irda/irlan/irlan_provider.c	Thu Nov  9 17:20:01 2000
@@ -116,16 +116,16 @@ static int irlan_provider_data_indicatio
 /*
  * Function irlan_provider_connect_indication (handle, skb, priv)
  *
- *    Got connection from peer IrLAN layer
+ *    Got connection from peer IrLAN client
  *
  */
 static void irlan_provider_connect_indication(void *instance, void *sap, 
 					      struct qos_info *qos,
 					      __u32 max_sdu_size, 
 					      __u8 max_header_size,
-					       struct sk_buff *skb)
+					      struct sk_buff *skb)
 {
-	struct irlan_cb *self, *new;
+	struct irlan_cb *self;
 	struct tsap_cb *tsap;
 	__u32 saddr, daddr;
 
@@ -137,82 +137,24 @@ static void irlan_provider_connect_indic
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IRLAN_MAGIC, return;);
 	
-	self->provider.max_sdu_size = max_sdu_size;
-	self->provider.max_header_size = max_header_size;
-
 	ASSERT(tsap == self->provider.tsap_ctrl,return;);
 	ASSERT(self->provider.state == IRLAN_IDLE, return;);
 
 	daddr = irttp_get_daddr(tsap);
 	saddr = irttp_get_saddr(tsap);
+	self->provider.max_sdu_size = max_sdu_size;
+	self->provider.max_header_size = max_header_size;
 
-	/* Check if we already dealing with this client or peer */
-	new = (struct irlan_cb *) hashbin_find(irlan, daddr, NULL);
-      	if (new) {
-		ASSERT(new->magic == IRLAN_MAGIC, return;);
-		IRDA_DEBUG(0, __FUNCTION__ "(), found instance!\n");
-
-		/* Update saddr, since client may have moved to a new link */
-		new->saddr = saddr;
-		IRDA_DEBUG(2, __FUNCTION__ "(), saddr=%08x\n", new->saddr);
-
-		/* Make sure that any old provider control TSAP is removed */
-		if ((new != self) && new->provider.tsap_ctrl) {
-			irttp_disconnect_request(new->provider.tsap_ctrl, 
-						 NULL, P_NORMAL);
-			irttp_close_tsap(new->provider.tsap_ctrl);
-			new->provider.tsap_ctrl = NULL;
-		}
-	} else {
-		/* This must be the master instance, so start a new instance */
-		IRDA_DEBUG(0, __FUNCTION__ "(), starting new provider!\n");
-
-		new = irlan_open(saddr, daddr, TRUE); 
-	}
-
-	/*  
-	 * Check if the connection came in on the master server, or the
-	 * slave server. If it came on the slave, then everything is
-	 * really, OK (reconnect), if not we need to dup the connection and
-	 * hand it over to the slave.  
-	 */
-	if (new != self) {
-				
-		/* Now attach up the new "socket" */
-		new->provider.tsap_ctrl = irttp_dup(self->provider.tsap_ctrl, 
-						    new);
-		if (!new->provider.tsap_ctrl) {
-			IRDA_DEBUG(0, __FUNCTION__ "(), dup failed!\n");
-			return;
-		}
-		
-		/* new->stsap_sel = new->tsap->stsap_sel; */
-		new->dtsap_sel_ctrl = new->provider.tsap_ctrl->dtsap_sel;
-
-		/* Clean up the original one to keep it in listen state */
-		self->provider.tsap_ctrl->dtsap_sel = LSAP_ANY;
-		self->provider.tsap_ctrl->lsap->dlsap_sel = LSAP_ANY;
-		self->provider.tsap_ctrl->lsap->lsap_state = LSAP_DISCONNECTED;
-		
-		/* 
-		 * Use the new instance from here instead of the master
-		 * struct! 
-		 */
-		self = new;
-	}
-	/* Check if network device has been registered */
-	if (!self->netdev_registered)
-		irlan_register_netdev(self);
-	
 	irlan_do_provider_event(self, IRLAN_CONNECT_INDICATION, NULL);
 
 	/*  
 	 * If we are in peer mode, the client may not have got the discovery
 	 * indication it needs to make progress. If the client is still in 
-	 * IDLE state, we must kick it to 
+	 * IDLE state, we must kick it. 
 	 */
 	if ((self->provider.access_type == ACCESS_PEER) && 
-	    (self->client.state == IRLAN_IDLE)) {
+	    (self->client.state == IRLAN_IDLE)) 
+	{
 		irlan_client_wakeup(self, self->saddr, self->daddr);
 	}
 }
@@ -231,11 +173,6 @@ void irlan_provider_connect_response(str
 
 	/* Just accept */
 	irttp_connect_response(tsap, IRLAN_MTU, NULL);
-
-	/* Check if network device has been registered */
-	if (!self->netdev_registered)
-		irlan_register_netdev(self);
-		
 }
 
 void irlan_provider_disconnect_indication(void *instance, void *sap, 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
