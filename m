Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268315AbUHQPjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268315AbUHQPjr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 11:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268313AbUHQPjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 11:39:32 -0400
Received: from fep02fe.ttnet.net.tr ([212.156.4.132]:4574 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S268294AbUHQPTI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 11:19:08 -0400
Message-ID: <412221B8.2020706@ttnet.net.tr>
Date: Tue, 17 Aug 2004 18:18:16 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com
Subject: [PATCH] [2.4.28-pre1] more gcc3.4 inline fixes [10/10]
Content-Type: multipart/mixed;
	boundary="------------000301080506020409010107"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000301080506020409010107
Content-Type: text/plain;
	charset=ISO-8859-9;
	format=flowed
Content-Transfer-Encoding: 7bit


--------------000301080506020409010107
Content-Type: text/plain;
	name="gcc34_inline_10.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="gcc34_inline_10.diff"

--- 28p1/net/appletalk/ddp.c~	2004-08-16 20:13:04.000000000 +0300
+++ 28p1/net/appletalk/ddp.c	2004-08-17 15:39:59.000000000 +0300
@@ -106,8 +106,8 @@
 #endif /* APPLETALK_DEBUG */
 
 #ifdef CONFIG_SYSCTL
-extern inline void atalk_register_sysctl(void);
-extern inline void atalk_unregister_sysctl(void);
+extern void atalk_register_sysctl(void);
+extern void atalk_unregister_sysctl(void);
 #endif /* CONFIG_SYSCTL */
 
 struct datalink_proto *ddp_dl, *aarp_dl;
--- 28p1/net/atm/lec.c~	2004-08-08 02:26:06.000000000 +0300
+++ 28p1/net/atm/lec.c	2004-08-17 15:46:21.000000000 +0300
@@ -71,9 +71,9 @@
 static int lec_close(struct net_device *dev);
 static struct net_device_stats *lec_get_stats(struct net_device *dev);
 static void lec_init(struct net_device *dev);
-static inline struct lec_arp_table* lec_arp_find(struct lec_priv *priv,
+static struct lec_arp_table* lec_arp_find(struct lec_priv *priv,
                                                      unsigned char *mac_addr);
-static inline int lec_arp_remove(struct lec_priv *priv,
+static int lec_arp_remove(struct lec_priv *priv,
 				     struct lec_arp_table *to_remove);
 /* LANE2 functions */
 static void lane2_associate_ind (struct net_device *dev, u8 *mac_address,
@@ -1137,7 +1137,7 @@
 /*
  * Remove entry from lec_arp_table
  */
-static inline int 
+static int 
 lec_arp_remove(struct lec_priv *priv,
                struct lec_arp_table *to_remove)
 {
@@ -1424,7 +1424,7 @@
 /* 
  * Find entry by mac_address
  */
-static inline struct lec_arp_table*
+static struct lec_arp_table*
 lec_arp_find(struct lec_priv *priv,
              unsigned char *mac_addr)
 {
--- 28p1/net/bluetooth/l2cap.c~	2004-08-08 02:26:06.000000000 +0300
+++ 28p1/net/bluetooth/l2cap.c	2004-08-17 15:54:38.000000000 +0300
@@ -70,7 +70,7 @@
 
 static int l2cap_conn_del(struct hci_conn *conn, int err);
 
-static inline void l2cap_chan_add(struct l2cap_conn *conn, struct sock *sk, struct sock *parent);
+static void __l2cap_chan_add(struct l2cap_conn *conn, struct sock *sk, struct sock *parent);
 static void l2cap_chan_del(struct sock *sk, int err);
 static int  l2cap_chan_send(struct sock *sk, struct msghdr *msg, int len);
 
@@ -420,6 +420,14 @@
 	return err;
 }
 
+static inline void l2cap_chan_add(struct l2cap_conn *conn, struct sock *sk, struct sock *parent)
+{
+	struct l2cap_chan_list *l = &conn->chan_list;
+	write_lock(&l->lock);
+	__l2cap_chan_add(conn, sk, parent);
+	write_unlock(&l->lock);
+}
+
 static int l2cap_do_connect(struct sock *sk)
 {
 	bdaddr_t *src = &bluez_pi(sk)->src;
@@ -897,14 +905,6 @@
 		bluez_accept_enqueue(parent, sk);
 }
 
-static inline void l2cap_chan_add(struct l2cap_conn *conn, struct sock *sk, struct sock *parent)
-{
-	struct l2cap_chan_list *l = &conn->chan_list;
-	write_lock(&l->lock);
-	__l2cap_chan_add(conn, sk, parent);
-	write_unlock(&l->lock);
-}
-
 /* Delete channel. 
  * Must be called on the locked socket. */
 static void l2cap_chan_del(struct sock *sk, int err)
--- 28p1/net/bluetooth/sco.c~	2003-08-25 14:44:44.000000000 +0300
+++ 28p1/net/bluetooth/sco.c	2004-08-17 16:01:52.000000000 +0300
@@ -67,9 +67,8 @@
 	lock: RW_LOCK_UNLOCKED
 };
 
-static inline int sco_chan_add(struct sco_conn *conn, struct sock *sk, struct sock *parent);
+static void __sco_chan_add(struct sco_conn *conn, struct sock *sk, struct sock *parent);
 static void sco_chan_del(struct sock *sk, int err);
-static inline struct sock * sco_chan_get(struct sco_conn *conn);
 
 static int  sco_conn_del(struct hci_conn *conn, int err);
 
@@ -150,6 +149,15 @@
 	return conn;
 }
 
+static inline struct sock * sco_chan_get(struct sco_conn *conn)
+{
+	struct sock *sk = NULL;
+	sco_conn_lock(conn);
+	sk = conn->sk;
+	sco_conn_unlock(conn);
+	return sk;
+}
+
 static int sco_conn_del(struct hci_conn *hcon, int err)
 {
 	struct sco_conn *conn;
@@ -176,6 +184,20 @@
 	return 0;
 }
 
+static inline int sco_chan_add(struct sco_conn *conn, struct sock *sk, struct sock *parent)
+{
+	int err = 0;
+
+	sco_conn_lock(conn);
+	if (conn->sk) {
+		err = -EBUSY;
+	} else {
+		__sco_chan_add(conn, sk, parent);
+	}
+	sco_conn_unlock(conn);
+	return err;
+}
+
 int sco_connect(struct sock *sk)
 {
 	bdaddr_t *src = &bluez_pi(sk)->src;
@@ -743,29 +765,6 @@
 		bluez_accept_enqueue(parent, sk);
 }
 
-static inline int sco_chan_add(struct sco_conn *conn, struct sock *sk, struct sock *parent)
-{
-	int err = 0;
-
-	sco_conn_lock(conn);
-	if (conn->sk) {
-		err = -EBUSY;
-	} else {
-		__sco_chan_add(conn, sk, parent);
-	}
-	sco_conn_unlock(conn);
-	return err;
-}
-
-static inline struct sock * sco_chan_get(struct sco_conn *conn)
-{
-	struct sock *sk = NULL;
-	sco_conn_lock(conn);
-	sk = conn->sk;
-	sco_conn_unlock(conn);
-	return sk;
-}
-
 /* Delete channel. 
  * Must be called on the locked socket. */
 static void sco_chan_del(struct sock *sk, int err)
--- 28p1/net/ipv4/netfilter/ip_nat_snmp_basic.c~	2003-11-28 20:26:21.000000000 +0200
+++ 28p1/net/ipv4/netfilter/ip_nat_snmp_basic.c	2004-08-17 16:09:44.000000000 +0300
@@ -862,6 +862,77 @@
 	return 1;
 }
 
+/* 
+ * Fast checksum update for possibly oddly-aligned UDP byte, from the
+ * code example in the draft.
+ */
+static void fast_csum(unsigned char *csum,
+                      const unsigned char *optr,
+                      const unsigned char *nptr,
+                      int odd)
+{
+	long x, old, new;
+	
+	x = csum[0] * 256 + csum[1];
+	
+	x =~ x & 0xFFFF;
+	
+	if (odd) old = optr[0] * 256;
+	else old = optr[0];
+	
+	x -= old & 0xFFFF;
+	if (x <= 0) {
+		x--;
+		x &= 0xFFFF;
+	}
+	
+	if (odd) new = nptr[0] * 256;
+	else new = nptr[0];
+	
+	x += new & 0xFFFF;
+	if (x & 0x10000) {
+		x++;
+		x &= 0xFFFF;
+	}
+	
+	x =~ x & 0xFFFF;
+	csum[0] = x / 256;
+	csum[1] = x & 0xFF;
+}
+
+/* 
+ * Mangle IP address.
+ * 	- begin points to the start of the snmp messgae
+ *      - addr points to the start of the address
+ */
+static void inline mangle_address(unsigned char *begin,
+                                  unsigned char *addr,
+                                  const struct oct1_map *map,
+                                  u_int16_t *check)
+{
+	if (map->from == NOCT1(*addr)) {
+		u_int32_t old;
+		
+		if (debug)
+			memcpy(&old, (unsigned char *)addr, sizeof(old));
+			
+		*addr = map->to;
+		
+		/* Update UDP checksum if being used */
+		if (*check) {
+			unsigned char odd = !((addr - begin) % 2);
+			
+			fast_csum((unsigned char *)check,
+			          &map->from, &map->to, odd);
+			          
+		}
+		
+		if (debug)
+			printk(KERN_DEBUG "bsalg: mapped %u.%u.%u.%u to "
+			       "%u.%u.%u.%u\n", NIPQUAD(old), NIPQUAD(*addr));
+	}
+}
+
 static unsigned char snmp_trap_decode(struct asn1_ctx *ctx,
                                       struct snmp_v1_trap *trap,
                                       const struct oct1_map *map,
@@ -952,77 +1023,6 @@
 	printk("\n");
 }
 
-/* 
- * Fast checksum update for possibly oddly-aligned UDP byte, from the
- * code example in the draft.
- */
-static void fast_csum(unsigned char *csum,
-                      const unsigned char *optr,
-                      const unsigned char *nptr,
-                      int odd)
-{
-	long x, old, new;
-	
-	x = csum[0] * 256 + csum[1];
-	
-	x =~ x & 0xFFFF;
-	
-	if (odd) old = optr[0] * 256;
-	else old = optr[0];
-	
-	x -= old & 0xFFFF;
-	if (x <= 0) {
-		x--;
-		x &= 0xFFFF;
-	}
-	
-	if (odd) new = nptr[0] * 256;
-	else new = nptr[0];
-	
-	x += new & 0xFFFF;
-	if (x & 0x10000) {
-		x++;
-		x &= 0xFFFF;
-	}
-	
-	x =~ x & 0xFFFF;
-	csum[0] = x / 256;
-	csum[1] = x & 0xFF;
-}
-
-/* 
- * Mangle IP address.
- * 	- begin points to the start of the snmp messgae
- *      - addr points to the start of the address
- */
-static void inline mangle_address(unsigned char *begin,
-                                  unsigned char *addr,
-                                  const struct oct1_map *map,
-                                  u_int16_t *check)
-{
-	if (map->from == NOCT1(*addr)) {
-		u_int32_t old;
-		
-		if (debug)
-			memcpy(&old, (unsigned char *)addr, sizeof(old));
-			
-		*addr = map->to;
-		
-		/* Update UDP checksum if being used */
-		if (*check) {
-			unsigned char odd = !((addr - begin) % 2);
-			
-			fast_csum((unsigned char *)check,
-			          &map->from, &map->to, odd);
-			          
-		}
-		
-		if (debug)
-			printk(KERN_DEBUG "bsalg: mapped %u.%u.%u.%u to "
-			       "%u.%u.%u.%u\n", NIPQUAD(old), NIPQUAD(*addr));
-	}
-}
-
 /*
  * Parse and mangle SNMP message according to mapping.
  * (And this is the fucking 'basic' method).
--- 28p1/include/net/irda/timer.h~	2004-08-17 13:12:05.000000000 +0300
+++ 28p1/include/net/irda/timer.h	2004-08-17 16:20:00.000000000 +0300
@@ -72,21 +72,21 @@
 void irda_start_timer(struct timer_list *ptimer, int timeout, void* data,
 		      TIMER_CALLBACK callback);
 
-inline void irlap_start_slot_timer(struct irlap_cb *self, int timeout);
-inline void irlap_start_query_timer(struct irlap_cb *self, int timeout);
-inline void irlap_start_final_timer(struct irlap_cb *self, int timeout);
-inline void irlap_start_wd_timer(struct irlap_cb *self, int timeout);
-inline void irlap_start_backoff_timer(struct irlap_cb *self, int timeout);
+void irlap_start_slot_timer(struct irlap_cb *self, int timeout);
+void irlap_start_query_timer(struct irlap_cb *self, int timeout);
+void irlap_start_final_timer(struct irlap_cb *self, int timeout);
+void irlap_start_wd_timer(struct irlap_cb *self, int timeout);
+void irlap_start_backoff_timer(struct irlap_cb *self, int timeout);
 
 void irlap_start_mbusy_timer(struct irlap_cb *self, int timeout);
 void irlap_stop_mbusy_timer(struct irlap_cb *);
 
 struct lsap_cb;
 struct lap_cb;
-inline void irlmp_start_watchdog_timer(struct lsap_cb *, int timeout);
-inline void irlmp_start_discovery_timer(struct irlmp_cb *, int timeout);
-inline void irlmp_start_idle_timer(struct lap_cb *, int timeout);
-inline void irlmp_stop_idle_timer(struct lap_cb *self); 
+void irlmp_start_watchdog_timer(struct lsap_cb *, int timeout);
+void irlmp_start_discovery_timer(struct irlmp_cb *, int timeout);
+void irlmp_start_idle_timer(struct lap_cb *, int timeout);
+void irlmp_stop_idle_timer(struct lap_cb *self); 
 
 #endif
 
--- 28p1/include/net/irda/irlmp_frame.h~	2004-08-17 13:12:06.000000000 +0300
+++ 28p1/include/net/irda/irlmp_frame.h	2004-08-17 16:25:35.000000000 +0300
@@ -40,7 +40,7 @@
 
 #define CONTROL_BIT    0x80
 
-inline void irlmp_send_data_pdu(struct lap_cb *self, __u8 dlsap, __u8 slsap, 
+void irlmp_send_data_pdu(struct lap_cb *self, __u8 dlsap, __u8 slsap, 
 				int expedited, struct sk_buff *skb);
 void irlmp_send_lcf_pdu(struct lap_cb *self, __u8 dlsap, __u8 slsap, 
 			__u8 opcode, struct sk_buff *skb);
--- 28p1/net/irda/wrapper.c~	2003-11-28 20:26:21.000000000 +0200
+++ 28p1/net/irda/wrapper.c	2004-08-17 16:34:04.000000000 +0300
@@ -37,8 +37,6 @@
 #include <net/irda/irlap_frame.h>
 #include <net/irda/irda_device.h>
 
-static inline int stuff_byte(__u8 byte, __u8 *buf);
-
 static void state_outside_frame(struct net_device *dev, 
 				struct net_device_stats *stats, 
 				iobuff_t *rx_buff, __u8 byte);
@@ -62,6 +60,32 @@
 };
 
 /*
+ * Function stuff_byte (byte, buf)
+ *
+ *    Byte stuff one single byte and put the result in buffer pointed to by
+ *    buf. The buffer must at all times be able to have two bytes inserted.
+ * 
+ */
+static inline int stuff_byte(__u8 byte, __u8 *buf) 
+{
+	switch (byte) {
+	case BOF: /* FALLTHROUGH */
+	case EOF: /* FALLTHROUGH */
+	case CE:
+		/* Insert transparently coded */
+		buf[0] = CE;               /* Send link escape */
+		buf[1] = byte^IRDA_TRANS;    /* Complement bit 5 */
+		return 2;
+		/* break; */
+	default:
+		 /* Non-special value, no transparency required */
+		buf[0] = byte;
+		return 1;
+		/* break; */
+	}
+}
+
+/*
  * Function async_wrap (skb, *tx_buff, buffsize)
  *
  *    Makes a new buffer with wrapping and stuffing, should check that 
@@ -140,32 +164,6 @@
 }
 
 /*
- * Function stuff_byte (byte, buf)
- *
- *    Byte stuff one single byte and put the result in buffer pointed to by
- *    buf. The buffer must at all times be able to have two bytes inserted.
- * 
- */
-static inline int stuff_byte(__u8 byte, __u8 *buf) 
-{
-	switch (byte) {
-	case BOF: /* FALLTHROUGH */
-	case EOF: /* FALLTHROUGH */
-	case CE:
-		/* Insert transparently coded */
-		buf[0] = CE;               /* Send link escape */
-		buf[1] = byte^IRDA_TRANS;    /* Complement bit 5 */
-		return 2;
-		/* break; */
-	default:
-		 /* Non-special value, no transparency required */
-		buf[0] = byte;
-		return 1;
-		/* break; */
-	}
-}
-
-/*
  * Function async_bump (buf, len, stats)
  *
  *    Got a frame, make a copy of it, and pass it up the stack! We can try

--------------000301080506020409010107--
