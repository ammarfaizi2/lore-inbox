Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129171AbQKKVas>; Sat, 11 Nov 2000 16:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129208AbQKKVai>; Sat, 11 Nov 2000 16:30:38 -0500
Received: from tepid.osl.fast.no ([213.188.9.130]:53513 "EHLO
	tepid.osl.fast.no") by vger.kernel.org with ESMTP
	id <S129171AbQKKVaY>; Sat, 11 Nov 2000 16:30:24 -0500
Date: Sat, 11 Nov 2000 21:31:22 GMT
Message-Id: <200011112131.VAA32571@tepid.osl.fast.no>
Subject: [patch] patch-2.4.0-test10-irda18 (was: Re: The IrDA patches)
X-Mailer: Pygmy (v0.4.4pre)
Subject: [patch] patch-2.4.0-test10-irda18 (was: Re: The IrDA patches)
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

The name of this patch is irda18.diff. 

(Many thanks to Jean Tourrilhes for splitting up the big patch)

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash
[OUPS   ] : Error that will be fixed in a later patch

irda18.diff :
-----------------
	o [CRITICA] Prevent out of bound access in QoS arrays
	o [CORRECT] Properly disable link broken warning when disc time = 3s
	o [FEATURE] Propagate link status indication to higher layers
	o [FEATURE] Allow to set max IrDA speed in sysctl
	o [FEATURE] Allow to set max IrDA inactive time in sysctl

diff -urpN old-linux/include/net/irda/irda.h linux/include/net/irda/irda.h
--- old-linux/include/net/irda/irda.h	Thu Nov  9 13:27:10 2000
+++ linux/include/net/irda/irda.h	Thu Nov  9 17:45:53 2000
@@ -242,6 +242,8 @@ typedef struct {
 	void (*disconnect_indication)(void *instance, void *sap, 
 				      LM_REASON reason, struct sk_buff *);
 	void (*flow_indication)(void *instance, void *sap, LOCAL_FLOW flow);
+	void (*status_indication)(void *instance,
+				  LINK_STATUS link, LOCK_STATUS lock);
 	void *instance; /* Layer instance pointer */
 	char name[16];  /* Name of layer */
 } notify_t;
diff -urpN old-linux/include/net/irda/irlap.h linux/include/net/irda/irlap.h
--- old-linux/include/net/irda/irlap.h	Thu Nov  9 14:47:22 2000
+++ linux/include/net/irda/irlap.h	Thu Nov  9 17:45:53 2000
@@ -214,7 +214,7 @@ void irlap_unitdata_indication(struct ir
 void irlap_disconnect_request(struct irlap_cb *);
 void irlap_disconnect_indication(struct irlap_cb *, LAP_REASON reason);
 
-void irlap_status_indication(int quality_of_link);
+void irlap_status_indication(struct irlap_cb *, int quality_of_link);
 
 void irlap_test_request(__u8 *info, int len);
 
diff -urpN old-linux/include/net/irda/irlmp.h linux/include/net/irda/irlmp.h
--- old-linux/include/net/irda/irlmp.h	Thu Nov  9 17:41:49 2000
+++ linux/include/net/irda/irlmp.h	Thu Nov  9 17:45:53 2000
@@ -233,7 +233,7 @@ void irlmp_connless_data_indication(stru
 #endif /* CONFIG_IRDA_ULTRA */
 
 void irlmp_status_request(void);
-void irlmp_status_indication(LINK_STATUS link, LOCK_STATUS lock);
+void irlmp_status_indication(struct lap_cb *, LINK_STATUS link, LOCK_STATUS lock);
 
 int  irlmp_slsap_inuse(__u8 slsap);
 __u8 irlmp_find_free_slsap(void);
diff -urpN old-linux/include/net/irda/irttp.h linux/include/net/irda/irttp.h
--- old-linux/include/net/irda/irttp.h	Thu Nov  9 14:47:22 2000
+++ linux/include/net/irda/irttp.h	Thu Nov  9 17:45:53 2000
@@ -129,6 +129,8 @@ int irttp_connect_response(struct tsap_c
 int irttp_disconnect_request(struct tsap_cb *self, struct sk_buff *skb,
 			     int priority);
 void irttp_flow_request(struct tsap_cb *self, LOCAL_FLOW flow);
+void irttp_status_indication(void *instance,
+			     LINK_STATUS link, LOCK_STATUS lock);
 struct tsap_cb *irttp_dup(struct tsap_cb *self, void *instance);
 
 static __inline __u32 irttp_get_saddr(struct tsap_cb *self)
diff -urpN old-linux/include/net/irda/qos.h linux/include/net/irda/qos.h
--- old-linux/include/net/irda/qos.h	Tue Oct 31 11:18:17 2000
+++ linux/include/net/irda/qos.h	Thu Nov  9 17:45:53 2000
@@ -86,6 +86,9 @@ struct qos_info {
 #endif
 };
 
+extern int sysctl_max_baud_rate;
+extern int sysctl_max_inactive_time;
+
 extern __u32 baud_rates[];
 extern __u32 data_sizes[];
 extern __u32 min_turn_times[];
@@ -100,10 +103,6 @@ __u32 irlap_requested_line_capacity(stru
 __u32 irlap_min_turn_time_in_bytes(__u32 speed, __u32 min_turn_time);
 
 int msb_index(__u16 byte);
-int value_index(__u32 value, __u32 *array);
-__u32 byte_value(__u8 byte, __u32 *array);
-__u32 index_value(int index, __u32 *array);
-
 void irda_qos_bits_to_value(struct qos_info *qos);
 
 #endif
diff -urpN old-linux/net/irda/irlap.c linux/net/irda/irlap.c
--- old-linux/net/irda/irlap.c	Thu Nov  9 16:08:25 2000
+++ linux/net/irda/irlap.c	Thu Nov  9 17:45:53 2000
@@ -617,7 +617,7 @@ void irlap_discovery_indication(struct i
  *    
  *
  */
-void irlap_status_indication(int quality_of_link) 
+void irlap_status_indication(struct irlap_cb *self, int quality_of_link) 
 {
 	switch (quality_of_link) {
 	case STATUS_NO_ACTIVITY:
@@ -629,7 +629,8 @@ void irlap_status_indication(int quality
 	default:
 		break;
 	}
-	irlmp_status_indication(quality_of_link, LOCK_NO_CHANGE);
+	irlmp_status_indication(self->notify.instance,
+				quality_of_link, LOCK_NO_CHANGE);
 }
 
 /*
@@ -985,8 +986,8 @@ void irlap_init_qos_capabilities(struct 
 	/* Set data size */
 	/*self->qos_rx.data_size.bits &= 0x03;*/
 
-	/* Set disconnect time */
-	self->qos_rx.link_disc_time.bits &= 0x07;
+	/* Set disconnect time -> done properly in qos.c */
+	/*self->qos_rx.link_disc_time.bits &= 0x07;*/
 
 	irda_qos_bits_to_value(&self->qos_rx);
 }
@@ -1083,7 +1084,11 @@ void irlap_apply_connection_parameters(s
 	 */
 	ASSERT(self->qos_tx.max_turn_time.value != 0, return;);
 	if (self->qos_tx.link_disc_time.value == 3)
-		self->N1 = 0;
+		/*self->N1 = 0;*/
+		/* If we set N1 to 0, it will trigger immediately, which is
+		 * *not* what we want. What we really want is to disable it,
+		 * so we set it to -10 ;-) Jean II */
+		self->N1 = -10;
 	else
 		self->N1 = 3000 / self->qos_tx.max_turn_time.value;
 	
diff -urpN old-linux/net/irda/irlap_event.c linux/net/irda/irlap_event.c
--- old-linux/net/irda/irlap_event.c	Thu Nov  9 17:39:46 2000
+++ linux/net/irda/irlap_event.c	Thu Nov  9 17:45:53 2000
@@ -1326,7 +1326,7 @@ static int irlap_state_nrm_p(struct irla
 				   " retry_count=%d\n", self->retry_count);
 			/* Keep state */
 		} else if (self->retry_count == self->N1) {
-			irlap_status_indication(STATUS_NO_ACTIVITY);
+			irlap_status_indication(self, STATUS_NO_ACTIVITY);
 			irlap_wait_min_turn_around(self, &self->qos_tx);
 			irlap_send_rr_frame(self, CMD_FRAME);
 			
@@ -1896,7 +1896,7 @@ static int irlap_state_nrm_s(struct irla
 			irlap_start_wd_timer(self, self->wd_timeout);
 			self->retry_count++;		
 		} else if (self->retry_count == (self->N1/2)) {
-			irlap_status_indication(STATUS_NO_ACTIVITY);
+			irlap_status_indication(self, STATUS_NO_ACTIVITY);
 			irlap_start_wd_timer(self, self->wd_timeout);
 			self->retry_count++;
 		} else if (self->retry_count >= self->N2/2) {
diff -urpN old-linux/net/irda/irlmp.c linux/net/irda/irlmp.c
--- old-linux/net/irda/irlmp.c	Thu Nov  9 17:41:49 2000
+++ linux/net/irda/irlmp.c	Thu Nov  9 17:45:53 2000
@@ -1111,9 +1111,35 @@ void irlmp_status_request(void) 
 	IRDA_DEBUG(0, __FUNCTION__ "(), Not implemented\n");
 }
 
-void irlmp_status_indication(LINK_STATUS link, LOCK_STATUS lock) 
+/*
+ * Propagate status indication from LAP to LSAPs (via LMP)
+ * This don't trigger any change of state in lap_cb, lmp_cb or lsap_cb,
+ * and the event is stateless, therefore we can bypass both state machines
+ * and send the event direct to the LSAP user.
+ * Jean II
+ */
+void irlmp_status_indication(struct lap_cb *self,
+			     LINK_STATUS link, LOCK_STATUS lock) 
 {
-	IRDA_DEBUG(1, __FUNCTION__ "(), Not implemented\n");
+	struct lsap_cb *next;
+	struct lsap_cb *curr;
+
+	/* Send status_indication to all LSAPs using this link */
+	next = (struct lsap_cb *) hashbin_get_first( self->lsaps);
+	while (next != NULL ) {
+		curr = next;
+		next = (struct lsap_cb *) hashbin_get_next(self->lsaps);
+
+		ASSERT(curr->magic == LMP_LSAP_MAGIC, return;);
+		/*
+		 *  Inform service user if he has requested it
+		 */
+		if (curr->notify.status_indication != NULL)
+			curr->notify.status_indication(curr->notify.instance, 
+						       link, lock);
+		else
+			IRDA_DEBUG(2, __FUNCTION__ "(), no handler\n");
+	}
 }
 
 /*
diff -urpN old-linux/net/irda/irmod.c linux/net/irda/irmod.c
--- old-linux/net/irda/irmod.c	Thu Nov  9 17:39:46 2000
+++ linux/net/irda/irmod.c	Thu Nov  9 17:45:53 2000
@@ -314,6 +314,7 @@ void irda_notify_init(notify_t *notify)
 	notify->connect_indication = NULL;
 	notify->disconnect_indication = NULL;
 	notify->flow_indication = NULL;
+	notify->status_indication = NULL;
 	notify->instance = NULL;
 	strncpy(notify->name, "Unknown", NOTIFY_MAX_NAME);
 }
diff -urpN old-linux/net/irda/irsysctl.c linux/net/irda/irsysctl.c
--- old-linux/net/irda/irsysctl.c	Thu Nov  9 16:08:25 2000
+++ linux/net/irda/irsysctl.c	Thu Nov  9 17:45:53 2000
@@ -33,7 +33,7 @@
 
 #define NET_IRDA 412 /* Random number */
 enum { DISCOVERY=1, DEVNAME, COMPRESSION, DEBUG, SLOTS, DISCOVERY_TIMEOUT, 
-       SLOT_TIMEOUT };
+       SLOT_TIMEOUT, MAX_BAUD_RATE, MAX_INACTIVE_TIME };
 
 extern int  sysctl_discovery;
 extern int  sysctl_discovery_slots;
@@ -42,6 +42,8 @@ extern int  sysctl_slot_timeout;
 extern int  sysctl_fast_poll_increase;
 int         sysctl_compression = 0;
 extern char sysctl_devname[];
+extern int  sysctl_max_baud_rate;
+extern int  sysctl_max_inactive_time;
 
 #ifdef CONFIG_IRDA_DEBUG
 extern unsigned int irda_debug;
@@ -84,6 +86,10 @@ static ctl_table irda_table[] = {
 	{ DISCOVERY_TIMEOUT, "discovery_timeout", &sysctl_discovery_timeout,
 	  sizeof(int), 0644, NULL, &proc_dointvec },
 	{ SLOT_TIMEOUT, "slot_timeout", &sysctl_slot_timeout,
+	  sizeof(int), 0644, NULL, &proc_dointvec },
+	{ MAX_BAUD_RATE, "max_baud_rate", &sysctl_max_baud_rate,
+	  sizeof(int), 0644, NULL, &proc_dointvec },
+	{ MAX_INACTIVE_TIME, "max_inactive_time", &sysctl_max_inactive_time,
 	  sizeof(int), 0644, NULL, &proc_dointvec },
 	{ 0 }
 };
diff -urpN old-linux/net/irda/irttp.c linux/net/irda/irttp.c
--- old-linux/net/irda/irttp.c	Thu Nov  9 14:47:22 2000
+++ linux/net/irda/irttp.c	Thu Nov  9 17:45:53 2000
@@ -156,6 +156,8 @@ struct tsap_cb *irttp_open_tsap(__u8 sts
 	ttp_notify.disconnect_indication = irttp_disconnect_indication;
 	ttp_notify.data_indication = irttp_data_indication;
 	ttp_notify.udata_indication = irttp_udata_indication;
+	if(notify->status_indication != NULL)
+		ttp_notify.status_indication = irttp_status_indication;
 	ttp_notify.instance = self;
 	strncpy(ttp_notify.name, notify->name, NOTIFY_MAX_NAME);
 
@@ -605,6 +607,34 @@ static int irttp_data_indication(void *i
 		irttp_start_todo_timer(self, 0);
 	}
 	return 0;
+}
+
+/*
+ * Function irttp_status_indication (self, reason)
+ *
+ *    Status_indication, just pass to the higher layer...
+ *
+ */
+void irttp_status_indication(void *instance,
+			     LINK_STATUS link, LOCK_STATUS lock)
+{
+	struct tsap_cb *self;
+
+	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+
+	self = (struct tsap_cb *) instance;
+	
+	ASSERT(self != NULL, return;);
+	ASSERT(self->magic == TTP_TSAP_MAGIC, return;);
+	
+	/*
+	 *  Inform service user if he has requested it
+	 */
+	if (self->notify.status_indication != NULL)
+		self->notify.status_indication(self->notify.instance, 
+					       link, lock);
+	else
+		IRDA_DEBUG(2, __FUNCTION__ "(), no handler\n");
 }
 
 /*
diff -urpN old-linux/net/irda/qos.c linux/net/irda/qos.c
--- old-linux/net/irda/qos.c	Tue Mar 21 11:17:28 2000
+++ linux/net/irda/qos.c	Thu Nov  9 17:45:53 2000
@@ -43,6 +43,21 @@
 #define CI_BZIP2  27 /* Random pick */
 #endif
 
+/*
+ * Maximum values of the baud rate we negociate with the other end.
+ * Most often, you don't have to change that, because Linux-IrDA will
+ * use the maximum offered by the link layer, which usually works fine.
+ * In some very rare cases, you may want to limit it to lower speeds...
+ */
+int sysctl_max_baud_rate = 16000000;
+/*
+ * Maximum value of the lap disconnect timer we negociate with the other end.
+ * Most often, the value below represent the best compromise, but some user
+ * may want to keep the LAP alive longuer or shorter in case of link failure.
+ * Remember that the threshold time (early warning) is fixed to 3s...
+ */
+int sysctl_max_inactive_time = 12;
+
 static int irlap_param_baud_rate(void *instance, irda_param_t *param, int get);
 static int irlap_param_link_disconnect(void *instance, irda_param_t *parm, 
 				       int get);
@@ -55,6 +70,10 @@ static int irlap_param_additional_bofs(v
 				       int get);
 static int irlap_param_min_turn_time(void *instance, irda_param_t *param, 
 				     int get);
+static int value_index(__u32 value, __u32 *array, int size);
+static __u32 byte_value(__u8 byte, __u32 *array);
+static __u32 index_value(int index, __u32 *array);
+static int value_lower_bits(__u32 value, __u32 *array, int size, __u16 *field);
 
 __u32 min_turn_times[]  = { 10000, 5000, 1000, 500, 100, 50, 10, 0 }; /* us */
 __u32 baud_rates[]      = { 2400, 9600, 19200, 38400, 57600, 115200, 576000, 
@@ -147,19 +166,31 @@ void irda_qos_compute_intersection(struc
  */
 void irda_init_max_qos_capabilies(struct qos_info *qos)
 {
+	int i;
 	/* 
 	 *  These are the maximum supported values as specified on pages
 	 *  39-43 in IrLAP
 	 */
 
+	/* Use sysctl to set some configurable values... */
+	/* Set configured max speed */
+	i = value_lower_bits(sysctl_max_baud_rate, baud_rates, 10,
+			     &qos->baud_rate.bits);
+	sysctl_max_baud_rate = index_value(i, baud_rates);
+
+	/* Set configured max disc time */
+	i = value_lower_bits(sysctl_max_inactive_time, link_disc_times, 8,
+			     &qos->link_disc_time.bits);
+	sysctl_max_inactive_time = index_value(i, link_disc_times);
+
 	/* LSB is first byte, MSB is second byte */
-	qos->baud_rate.bits     = 0x01ff; 
+	qos->baud_rate.bits    &= 0x01ff;	/* Mask out 16 Mb/s ??? */
 
 	qos->window_size.bits     = 0x7f;
 	qos->min_turn_time.bits   = 0xff;
 	qos->max_turn_time.bits   = 0x0f;
 	qos->data_size.bits       = 0x3f;
-	qos->link_disc_time.bits  = 0xff;
+	qos->link_disc_time.bits &= 0xff;
 	qos->additional_bofs.bits = 0xff;
 
 #ifdef CONFIG_IRDA_COMPRESSION	
@@ -197,7 +228,7 @@ void irlap_adjust_qos_settings(struct qo
 	 * The data size must be adjusted according to the baud rate and max 
 	 * turn time
 	 */
-	index = value_index(qos->data_size.value, data_sizes);
+	index = value_index(qos->data_size.value, data_sizes, 6);
 	line_capacity = irlap_max_line_capacity(qos->baud_rate.value, 
 						qos->max_turn_time.value);
 
@@ -537,8 +568,8 @@ __u32 irlap_max_line_capacity(__u32 spee
 	IRDA_DEBUG(2, __FUNCTION__ "(), speed=%d, max_turn_time=%d\n",
 		   speed, max_turn_time);
 
-	i = value_index(speed, baud_rates);
-	j = value_index(max_turn_time, max_turn_times);
+	i = value_index(speed, baud_rates, 10);
+	j = value_index(max_turn_time, max_turn_times, 4);
 
 	ASSERT(((i >=0) && (i <=10)), return 0;);
 	ASSERT(((j >=0) && (j <=4)), return 0;);
@@ -574,7 +605,7 @@ __u32 irlap_min_turn_time_in_bytes(__u32
 	return bytes;
 }
 
-__u32 byte_value(__u8 byte, __u32 *array) 
+static __u32 byte_value(__u8 byte, __u32 *array) 
 {
 	int index;
 
@@ -607,15 +638,15 @@ int msb_index (__u16 word) 
 }
 
 /*
- * Function value_index (value, array)
+ * Function value_index (value, array, size)
  *
  *    Returns the index to the value in the specified array
  */
-int value_index(__u32 value, __u32 *array) 
+static int value_index(__u32 value, __u32 *array, int size)
 {
 	int i;
 	
-	for (i=0;i<8;i++)
+	for (i=0; i < size; i++)
 		if (array[i] == value)
 			break;
 	return i;
@@ -627,11 +658,38 @@ int value_index(__u32 value, __u32 *arra
  *    Returns value to index in array, easy!
  *
  */
-__u32 index_value(int index, __u32 *array) 
+static __u32 index_value(int index, __u32 *array) 
 {
 	return array[index];
 }
 
+/*
+ * Function value_lower_bits (value, array)
+ *
+ *    Returns a bit field marking all possibility lower than value.
+ *    We may need a "value_higher_bits" in the future...
+ */
+static int value_lower_bits(__u32 value, __u32 *array, int size, __u16 *field)
+{
+	int	i;
+	__u16	mask = 0x1;
+	__u16	result = 0x0;
+
+	for (i=0; i < size; i++) {
+		/* Add the current value to the bit field, shift mask */
+		result |= mask;
+		mask <<= 1;
+		/* Finished ? */
+		if (array[i] >= value)
+			break;
+	}
+	/* Send back a valid index */
+	if(i >= size)
+	  i = size - 1;	/* Last item */
+	*field = result;
+	return i;
+}
+
 void irda_qos_bits_to_value(struct qos_info *qos)
 {
 	int index;
@@ -667,10 +725,3 @@ void irda_qos_bits_to_value(struct qos_i
 		qos->compression.value = 0;
 #endif
 }
-
-
-
-
-
-
-


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
