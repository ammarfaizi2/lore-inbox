Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267471AbTBXSUN>; Mon, 24 Feb 2003 13:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267466AbTBXSSx>; Mon, 24 Feb 2003 13:18:53 -0500
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:12286 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S267306AbTBXSKO> convert rfc822-to-8bit; Mon, 24 Feb 2003 13:10:14 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (8/13): iucv network driver.
Date: Mon, 24 Feb 2003 19:11:15 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200302241911.15621.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

clean up the IUCV driver

diff -urN linux-2.5.62/drivers/s390/net/netiucv.c linux-2.5.62-s390/drivers/s390/net/netiucv.c
--- linux-2.5.62/drivers/s390/net/netiucv.c	Mon Feb 17 23:56:16 2003
+++ linux-2.5.62-s390/drivers/s390/net/netiucv.c	Mon Feb 24 18:24:29 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: netiucv.c,v 1.12 2002/11/26 16:00:54 mschwide Exp $
+ * $Id: netiucv.c,v 1.16 2003/02/18 09:15:14 mschwide Exp $
  *
  * IUCV network driver
  *
@@ -30,7 +30,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV network driver $Revision: 1.12 $
+ * RELEASE-TAG: IUCV network driver $Revision: 1.16 $
  *
  */
 
@@ -65,25 +65,15 @@
 
 #undef DEBUG
 
-#ifdef MODULE
 MODULE_AUTHOR
     ("(C) 2001 IBM Corporation by Fritz Elfert (felfert@millenux.com)");
 MODULE_DESCRIPTION ("Linux for S/390 IUCV network driver");
-MODULE_PARM (iucv, "1s");
-MODULE_PARM_DESC (iucv,
-		  "Specify the initial remote userids for iucv0 .. iucvn:\n"
-		  "iucv=userid0:userid1:...:useridN");
-#endif
-
-static char *iucv = "";
-
-typedef struct net_device net_device;
 
 
 /**
  * Per connection profiling data
  */
-typedef struct connection_profile_t {
+struct connection_profile {
 	unsigned long maxmulti;
 	unsigned long maxcqueue;
 	unsigned long doios_single;
@@ -91,56 +81,76 @@
 	unsigned long txlen;
 	unsigned long tx_time;
 	struct timespec send_stamp;
-} connection_profile;
+};
 
 /**
  * Representation of one iucv connection
  */
-typedef struct iucv_connection_t {
-	struct iucv_connection_t *next;
-	iucv_handle_t            handle;
-	__u16                    pathid;
-	struct sk_buff           *rx_buff;
-	struct sk_buff           *tx_buff;
-	struct sk_buff_head      collect_queue;
-	spinlock_t               collect_lock;
-	int                      collect_len;
-	int                      max_buffsize;
-	int                      flags;
-	fsm_timer                timer;
-	int                      retry;
-	fsm_instance             *fsm;
-	net_device               *netdev;
-	connection_profile       prof;
-	char                     userid[9];
-} iucv_connection;
+struct iucv_connection {
+	struct iucv_connection    *next;
+	iucv_handle_t             handle;
+	__u16                     pathid;
+	struct sk_buff            *rx_buff;
+	struct sk_buff            *tx_buff;
+	struct sk_buff_head       collect_queue;
+	spinlock_t                collect_lock;
+	int                       collect_len;
+	int                       max_buffsize;
+	int                       flags;
+	fsm_timer                 timer;
+	int                       retry;
+	fsm_instance              *fsm;
+	struct net_device         *netdev;
+	struct connection_profile prof;
+	char                      userid[9];
+};
 
 #define CONN_FLAGS_BUFSIZE_CHANGED 1
 
 /**
  * Linked list of all connection structs.
  */
-static iucv_connection *connections;
+static struct iucv_connection *connections;
+
+/* Keep track of interfaces. */
+static int ifno;
+
+static int
+iucv_bus_match (struct device *dev, struct device_driver *drv)
+{
+	return 0;
+}
+
+/* Hm - move to iucv.c and export? - CH */
+static struct bus_type iucv_bus = {
+	.name = "iucv",
+	.match = iucv_bus_match,
+};	
+
+static struct device iucv_root = {
+	.name   = "IUCV",
+	.bus_id = "iucv",
+};
 
 /**
  * Representation of event-data for the
  * connection state machine.
  */
-typedef struct iucv_event_t {
-	iucv_connection *conn;
-	void            *data;
-} iucv_event;
+struct iucv_event {
+	struct iucv_connection *conn;
+	void                   *data;
+};
 
 /**
  * Private part of the network device structure
  */
-typedef struct netiucv_priv_t {
+struct netiucv_priv {
 	struct net_device_stats stats;
 	unsigned long           tbusy;
 	fsm_instance            *fsm;
-        iucv_connection         *conn;
-	struct platform_device  pldev;
-} netiucv_priv;
+        struct iucv_connection  *conn;
+	struct device           dev;
+};
 
 /**
  * Link level header for a packet.
@@ -161,16 +171,16 @@
  * Compatibility macros for busy handling
  * of network devices.
  */
-static __inline__ void netiucv_clear_busy(net_device *dev)
+static __inline__ void netiucv_clear_busy(struct net_device *dev)
 {
-	clear_bit(0, &(((netiucv_priv *)dev->priv)->tbusy));
+	clear_bit(0, &(((struct netiucv_priv *)dev->priv)->tbusy));
 	netif_wake_queue(dev);
 }
 
-static __inline__ int netiucv_test_and_set_busy(net_device *dev)
+static __inline__ int netiucv_test_and_set_busy(struct net_device *dev)
 {
 	netif_stop_queue(dev);
-	return test_and_set_bit(0, &((netiucv_priv *)dev->priv)->tbusy);
+	return test_and_set_bit(0, &((struct netiucv_priv *)dev->priv)->tbusy);
 }
 
 #define SET_DEVICE_START(device, value)
@@ -387,8 +397,8 @@
 static void
 netiucv_callback_rx(iucv_MessagePending *eib, void *pgm_data)
 {
-	iucv_connection *conn = (iucv_connection *)pgm_data;
-	iucv_event ev;
+	struct iucv_connection *conn = (struct iucv_connection *)pgm_data;
+	struct iucv_event ev;
 
 	ev.conn = conn;
 	ev.data = (void *)eib;
@@ -399,8 +409,8 @@
 static void
 netiucv_callback_txdone(iucv_MessageComplete *eib, void *pgm_data)
 {
-	iucv_connection *conn = (iucv_connection *)pgm_data;
-	iucv_event ev;
+	struct iucv_connection *conn = (struct iucv_connection *)pgm_data;
+	struct iucv_event ev;
 
 	ev.conn = conn;
 	ev.data = (void *)eib;
@@ -410,8 +420,8 @@
 static void
 netiucv_callback_connack(iucv_ConnectionComplete *eib, void *pgm_data)
 {
-	iucv_connection *conn = (iucv_connection *)pgm_data;
-	iucv_event ev;
+	struct iucv_connection *conn = (struct iucv_connection *)pgm_data;
+	struct iucv_event ev;
 
 	ev.conn = conn;
 	ev.data = (void *)eib;
@@ -421,8 +431,8 @@
 static void
 netiucv_callback_connreq(iucv_ConnectionPending *eib, void *pgm_data)
 {
-	iucv_connection *conn = (iucv_connection *)pgm_data;
-	iucv_event ev;
+	struct iucv_connection *conn = (struct iucv_connection *)pgm_data;
+	struct iucv_event ev;
 
 	ev.conn = conn;
 	ev.data = (void *)eib;
@@ -432,8 +442,8 @@
 static void
 netiucv_callback_connrej(iucv_ConnectionSevered *eib, void *pgm_data)
 {
-	iucv_connection *conn = (iucv_connection *)pgm_data;
-	iucv_event ev;
+	struct iucv_connection *conn = (struct iucv_connection *)pgm_data;
+	struct iucv_event ev;
 
 	ev.conn = conn;
 	ev.data = (void *)eib;
@@ -443,8 +453,8 @@
 static void
 netiucv_callback_connsusp(iucv_ConnectionQuiesced *eib, void *pgm_data)
 {
-	iucv_connection *conn = (iucv_connection *)pgm_data;
-	iucv_event ev;
+	struct iucv_connection *conn = (struct iucv_connection *)pgm_data;
+	struct iucv_event ev;
 
 	ev.conn = conn;
 	ev.data = (void *)eib;
@@ -454,8 +464,8 @@
 static void
 netiucv_callback_connres(iucv_ConnectionResumed *eib, void *pgm_data)
 {
-	iucv_connection *conn = (iucv_connection *)pgm_data;
-	iucv_event ev;
+	struct iucv_connection *conn = (struct iucv_connection *)pgm_data;
+	struct iucv_event ev;
 
 	ev.conn = conn;
 	ev.data = (void *)eib;
@@ -494,10 +504,10 @@
  */
 //static __inline__ void
 static void
-netiucv_unpack_skb(iucv_connection *conn, struct sk_buff *pskb)
+netiucv_unpack_skb(struct iucv_connection *conn, struct sk_buff *pskb)
 {
-	net_device     *dev = conn->netdev;
-	netiucv_priv   *privptr = (netiucv_priv *)dev->priv;
+	struct net_device     *dev = conn->netdev;
+	struct netiucv_priv   *privptr = (struct netiucv_priv *)dev->priv;
 	__u16          offset = 0;
 
 	skb_put(pskb, NETIUCV_HDRLEN);
@@ -518,7 +528,8 @@
 		header->next -= NETIUCV_HDRLEN;
 		if (skb_tailroom(pskb) < header->next) {
 			printk(KERN_WARNING
-			       "%s: Illegal next field in iucv header: %d > %d\n",
+			       "%s: Illegal next field in iucv header: "
+			       "%d > %d\n",
 			       dev->name, header->next, skb_tailroom(pskb));
 			return;
 		}
@@ -549,17 +560,16 @@
 static void
 conn_action_rx(fsm_instance *fi, int event, void *arg)
 {
-	iucv_event *ev = (iucv_event *)arg;
-	iucv_connection *conn = ev->conn;
+	struct iucv_event *ev = (struct iucv_event *)arg;
+	struct iucv_connection *conn = ev->conn;
 	iucv_MessagePending *eib = (iucv_MessagePending *)ev->data;
-	netiucv_priv *privptr = (netiucv_priv *)conn->netdev->priv;
+	struct netiucv_priv *privptr = (struct netiucv_priv *)conn->netdev->priv;
 
 	__u16 msglen = eib->ln1msg2.ipbfln1f;
 	int rc;
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "%s() called\n", __FUNCTION__);
-#endif
+	pr_debug("%s() called\n", __FUNCTION__);
+
 	if (!conn->netdev) {
 		/* FRITZ: How to tell iucv LL to drop the msg? */
 		printk(KERN_WARNING
@@ -585,10 +595,10 @@
 static void
 conn_action_txdone(fsm_instance *fi, int event, void *arg)
 {
-	iucv_event *ev = (iucv_event *)arg;
-	iucv_connection *conn = ev->conn;
+	struct iucv_event *ev = (struct iucv_event *)arg;
+	struct iucv_connection *conn = ev->conn;
 	iucv_MessageComplete *eib = (iucv_MessageComplete *)ev->data;
-	netiucv_priv *privptr = NULL;
+	struct netiucv_priv *privptr = NULL;
 			         /* Shut up, gcc! skb is always below 2G. */
 	struct sk_buff *skb = (struct sk_buff *)(unsigned long)eib->ipmsgtag;
 	__u32 txbytes = 0;
@@ -597,12 +607,11 @@
 	unsigned long saveflags;
 	ll_header header;
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "%s() called\n", __FUNCTION__);
-#endif
+	pr_debug("%s() called\n", __FUNCTION__);
+
 	fsm_deltimer(&conn->timer);
 	if (conn && conn->netdev && conn->netdev->priv)
-		privptr = (netiucv_priv *)conn->netdev->priv;
+		privptr = (struct netiucv_priv *)conn->netdev->priv;
 	if (skb) {
 		if (privptr) {
 			privptr->stats.tx_packets++;
@@ -663,18 +672,17 @@
 static void
 conn_action_connaccept(fsm_instance *fi, int event, void *arg)
 {
-	iucv_event *ev = (iucv_event *)arg;
-	iucv_connection *conn = ev->conn;
+	struct iucv_event *ev = (struct iucv_event *)arg;
+	struct iucv_connection *conn = ev->conn;
 	iucv_ConnectionPending *eib = (iucv_ConnectionPending *)ev->data;
-	net_device *netdev = conn->netdev;
-	netiucv_priv *privptr = (netiucv_priv *)netdev->priv;
+	struct net_device *netdev = conn->netdev;
+	struct netiucv_priv *privptr = (struct netiucv_priv *)netdev->priv;
 	int rc;
 	__u16 msglimit;
 	__u8 udata[16];
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "%s() called\n", __FUNCTION__);
-#endif
+	pr_debug("%s() called\n", __FUNCTION__);
+
 	rc = iucv_accept(eib->ippathid, NETIUCV_QUEUELEN_DEFAULT, udata, 0,
 			 conn->handle, conn, NULL, &msglimit);
 	if (rc != 0) {
@@ -692,29 +700,27 @@
 static void
 conn_action_connreject(fsm_instance *fi, int event, void *arg)
 {
-	iucv_event *ev = (iucv_event *)arg;
-	// iucv_connection *conn = ev->conn;
+	struct iucv_event *ev = (struct iucv_event *)arg;
+	// struct iucv_connection *conn = ev->conn;
 	iucv_ConnectionPending *eib = (iucv_ConnectionPending *)ev->data;
 	__u8 udata[16];
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "%s() called\n", __FUNCTION__);
-#endif
+	pr_debug("%s() called\n", __FUNCTION__);
+
 	iucv_sever(eib->ippathid, udata);
 }
 
 static void
 conn_action_connack(fsm_instance *fi, int event, void *arg)
 {
-	iucv_event *ev = (iucv_event *)arg;
-	iucv_connection *conn = ev->conn;
+	struct iucv_event *ev = (struct iucv_event *)arg;
+	struct iucv_connection *conn = ev->conn;
 	iucv_ConnectionComplete *eib = (iucv_ConnectionComplete *)ev->data;
-	net_device *netdev = conn->netdev;
-	netiucv_priv *privptr = (netiucv_priv *)netdev->priv;
+	struct net_device *netdev = conn->netdev;
+	struct netiucv_priv *privptr = (struct netiucv_priv *)netdev->priv;
+
+	pr_debug("%s() called\n", __FUNCTION__);
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "%s() called\n", __FUNCTION__);
-#endif
 	fsm_newstate(fi, CONN_STATE_IDLE);
 	conn->pathid = eib->ippathid;
 	netdev->tx_queue_len = eib->ipmsglim;
@@ -724,16 +730,15 @@
 static void
 conn_action_connsever(fsm_instance *fi, int event, void *arg)
 {
-	iucv_event *ev = (iucv_event *)arg;
-	iucv_connection *conn = ev->conn;
+	struct iucv_event *ev = (struct iucv_event *)arg;
+	struct iucv_connection *conn = ev->conn;
 	// iucv_ConnectionSevered *eib = (iucv_ConnectionSevered *)ev->data;
-	net_device *netdev = conn->netdev;
-	netiucv_priv *privptr = (netiucv_priv *)netdev->priv;
+	struct net_device *netdev = conn->netdev;
+	struct netiucv_priv *privptr = (struct netiucv_priv *)netdev->priv;
 	int state = fsm_getstate(fi);
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "%s() called\n", __FUNCTION__);
-#endif
+	pr_debug("%s() called\n", __FUNCTION__);
+
 	switch (state) {
 		case CONN_STATE_IDLE:
 		case CONN_STATE_TX:
@@ -751,14 +756,13 @@
 static void
 conn_action_start(fsm_instance *fi, int event, void *arg)
 {
-	iucv_event *ev = (iucv_event *)arg;
-	iucv_connection *conn = ev->conn;
+	struct iucv_event *ev = (struct iucv_event *)arg;
+	struct iucv_connection *conn = ev->conn;
 
 	int rc;
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "%s() called\n", __FUNCTION__);
-#endif
+	pr_debug("%s() called\n", __FUNCTION__);
+
 	if (conn->handle == 0) {
 		conn->handle =
 			iucv_register_program(iucvMagic, conn->userid, mask,
@@ -769,15 +773,14 @@
 			conn->handle = 0;
 			return;
 		}
-#ifdef DEBUG
-		printk(KERN_DEBUG "%s('%s'): registered successfully\n",
-		       conn->netdev->name, conn->userid);
-#endif
-	}
-#ifdef DEBUG
-	printk(KERN_DEBUG "%s('%s'): connecting ...\n",
-	       conn->netdev->name, conn->userid);
-#endif
+
+		pr_debug("%s('%s'): registered successfully\n",
+			 conn->netdev->name, conn->userid);
+	}
+
+	pr_debug("%s('%s'): connecting ...\n",
+		 conn->netdev->name, conn->userid);
+
 	rc = iucv_connect(&(conn->pathid), NETIUCV_QUEUELEN_DEFAULT, iucvMagic,
 			  conn->userid, iucv_host, 0, NULL, NULL, conn->handle,
 			  conn);
@@ -843,14 +846,13 @@
 static void
 conn_action_stop(fsm_instance *fi, int event, void *arg)
 {
-	iucv_event *ev = (iucv_event *)arg;
-	iucv_connection *conn = ev->conn;
-	net_device *netdev = conn->netdev;
-	netiucv_priv *privptr = (netiucv_priv *)netdev->priv;
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "%s() called\n", __FUNCTION__);
-#endif
+	struct iucv_event *ev = (struct iucv_event *)arg;
+	struct iucv_connection *conn = ev->conn;
+	struct net_device *netdev = conn->netdev;
+	struct netiucv_priv *privptr = (struct netiucv_priv *)netdev->priv;
+
+	pr_debug("%s() called\n", __FUNCTION__);
+
 	fsm_newstate(fi, CONN_STATE_STOPPED);
 	netiucv_purge_skb_queue(&conn->collect_queue);
 	if (conn->handle)
@@ -862,9 +864,9 @@
 static void
 conn_action_inval(fsm_instance *fi, int event, void *arg)
 {
-	iucv_event *ev = (iucv_event *)arg;
-	iucv_connection *conn = ev->conn;
-	net_device *netdev = conn->netdev;
+	struct iucv_event *ev = (struct iucv_event *)arg;
+	struct iucv_connection *conn = ev->conn;
+	struct net_device *netdev = conn->netdev;
 
 	printk(KERN_WARNING
 	       "%s: Cannot connect without username\n",
@@ -913,18 +915,17 @@
  *
  * @param fi    An instance of an interface statemachine.
  * @param event The event, just happened.
- * @param arg   Generic pointer, casted from net_device * upon call.
+ * @param arg   Generic pointer, casted from struct net_device * upon call.
  */
 static void
 dev_action_start(fsm_instance *fi, int event, void *arg)
 {
-	net_device   *dev = (net_device *)arg;
-	netiucv_priv *privptr = dev->priv;
-	iucv_event   ev;
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "%s() called\n", __FUNCTION__);
-#endif
+	struct net_device   *dev = (struct net_device *)arg;
+	struct netiucv_priv *privptr = dev->priv;
+	struct iucv_event   ev;
+
+	pr_debug("%s() called\n", __FUNCTION__);
+
 	ev.conn = privptr->conn;
 	fsm_newstate(fi, DEV_STATE_STARTWAIT);
 	fsm_event(privptr->conn->fsm, CONN_EVENT_START, &ev);
@@ -935,18 +936,17 @@
  *
  * @param fi    An instance of an interface statemachine.
  * @param event The event, just happened.
- * @param arg   Generic pointer, casted from net_device * upon call.
+ * @param arg   Generic pointer, casted from struct net_device * upon call.
  */
 static void
 dev_action_stop(fsm_instance *fi, int event, void *arg)
 {
-	net_device   *dev = (net_device *)arg;
-	netiucv_priv *privptr = dev->priv;
-	iucv_event   ev;
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "%s() called\n", __FUNCTION__);
-#endif
+	struct net_device   *dev = (struct net_device *)arg;
+	struct netiucv_priv *privptr = dev->priv;
+	struct iucv_event   ev;
+
+	pr_debug("%s() called\n", __FUNCTION__);
+
 	ev.conn = privptr->conn;
 
 	fsm_newstate(fi, DEV_STATE_STOPWAIT);
@@ -959,16 +959,15 @@
  *
  * @param fi    An instance of an interface statemachine.
  * @param event The event, just happened.
- * @param arg   Generic pointer, casted from net_device * upon call.
+ * @param arg   Generic pointer, casted from struct net_device * upon call.
  */
 static void
 dev_action_connup(fsm_instance *fi, int event, void *arg)
 {
-	net_device   *dev = (net_device *)arg;
+	struct net_device   *dev = (struct net_device *)arg;
+
+	pr_debug("%s() called\n", __FUNCTION__);
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "%s() called\n", __FUNCTION__);
-#endif
 	switch (fsm_getstate(fi)) {
 		case DEV_STATE_STARTWAIT:
 			fsm_newstate(fi, DEV_STATE_RUNNING);
@@ -990,18 +989,17 @@
  *
  * @param fi    An instance of an interface statemachine.
  * @param event The event, just happened.
- * @param arg   Generic pointer, casted from net_device * upon call.
+ * @param arg   Generic pointer, casted from struct net_device * upon call.
  */
 static void
 dev_action_conndown(fsm_instance *fi, int event, void *arg)
 {
-	net_device   *dev = (net_device *)arg;
-	netiucv_priv *privptr = dev->priv;
-	iucv_event   ev;
-
-#ifdef DEBUG
-	printk(KERN_DEBUG "%s() called\n", __FUNCTION__);
-#endif
+	struct net_device   *dev = (struct net_device *)arg;
+	struct netiucv_priv *privptr = dev->priv;
+	struct iucv_event   ev;
+
+	pr_debug("%s() called\n", __FUNCTION__);
+
 	switch (fsm_getstate(fi)) {
 		case DEV_STATE_RUNNING:
 			fsm_newstate(fi, DEV_STATE_STARTWAIT);
@@ -1045,7 +1043,7 @@
  * @return 0 on success, -ERRNO on failure. (Never fails.)
  */
 static int
-netiucv_transmit_skb(iucv_connection *conn, struct sk_buff *skb) {
+netiucv_transmit_skb(struct iucv_connection *conn, struct sk_buff *skb) {
 	unsigned long saveflags;
 	ll_header header;
 	int       rc = 0;
@@ -1141,10 +1139,10 @@
  * @return 0 on success, -ERRNO on failure. (Never fails.)
  */
 static int
-netiucv_open(net_device *dev) {
+netiucv_open(struct net_device *dev) {
 	MOD_INC_USE_COUNT;
 	SET_DEVICE_START(dev, 1);
-	fsm_event(((netiucv_priv *)dev->priv)->fsm, DEV_EVENT_START, dev);
+	fsm_event(((struct netiucv_priv *)dev->priv)->fsm, DEV_EVENT_START, dev);
 	return 0;
 }
 
@@ -1157,9 +1155,9 @@
  * @return 0 on success, -ERRNO on failure. (Never fails.)
  */
 static int
-netiucv_close(net_device *dev) {
+netiucv_close(struct net_device *dev) {
 	SET_DEVICE_START(dev, 0);
-	fsm_event(((netiucv_priv *)dev->priv)->fsm, DEV_EVENT_STOP, dev);
+	fsm_event(((struct netiucv_priv *)dev->priv)->fsm, DEV_EVENT_STOP, dev);
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
@@ -1175,10 +1173,10 @@
  *         Note: If we return !0, then the packet is free'd by
  *               the generic network layer.
  */
-static int netiucv_tx(struct sk_buff *skb, net_device *dev)
+static int netiucv_tx(struct sk_buff *skb, struct net_device *dev)
 {
 	int          rc = 0;
-	netiucv_priv *privptr = (netiucv_priv *)dev->priv;
+	struct netiucv_priv *privptr = (struct netiucv_priv *)dev->priv;
 
 	/**
 	 * Some sanity checks ...
@@ -1230,9 +1228,9 @@
  * @return Pointer to stats struct of this interface.
  */
 static struct net_device_stats *
-netiucv_stats (net_device * dev)
+netiucv_stats (struct net_device * dev)
 {
-	return &((netiucv_priv *)dev->priv)->stats;
+	return &((struct netiucv_priv *)dev->priv)->stats;
 }
 
 /**
@@ -1245,7 +1243,7 @@
  *         (valid range is 576 .. NETIUCV_MTU_MAX).
  */
 static int
-netiucv_change_mtu (net_device * dev, int new_mtu)
+netiucv_change_mtu (struct net_device * dev, int new_mtu)
 {
 	if ((new_mtu < 576) || (new_mtu > NETIUCV_MTU_MAX))
 		return -EINVAL;
@@ -1259,65 +1257,19 @@
 #define CTRL_BUFSIZE 40
 
 static ssize_t
-user_show (struct device *dev, char *buf)
-{
-	netiucv_priv *priv = dev->driver_data;
-
-	return snprintf(buf, PAGE_SIZE, "%s\n", 
-			netiucv_printname(priv->conn->userid));
-}
-
-static ssize_t
-user_write (struct device *dev, const char *buf, size_t count)
-{
-	netiucv_priv *priv = dev->driver_data;
-	struct net_device *ndev = container_of((void *)priv, struct net_device, priv);
-	int          i;
-	char         *p;
-	char         tmp[CTRL_BUFSIZE];
-	char         user[9];
-
-	if (count >= 39)
-		return -EINVAL;
-
-	if (copy_from_user(tmp, buf, count))
-		return -EFAULT;
-	tmp[count+1] = '\0';
-
-	memset(user, ' ', sizeof(user));
-	user[8] = '\0';
-	for (p = tmp, i = 0; *p && (!isspace(*p)); p++) {
-		if (i > 7)
-			return -EINVAL;
-		user[i++] = *p;
-	}
-
-	if (memcmp(user, priv->conn->userid, 8) != 0) {
-		/* username changed */
-		if (ndev->flags & IFF_RUNNING)
-			return -EBUSY;
-	}
-	memcpy(priv->conn->userid, user, 9);
-	return count;
-
-}
-
-static DEVICE_ATTR(user, 0644, user_show, user_write);
-
-static ssize_t
 buffer_show (struct device *dev, char *buf)
 {
-	netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev->driver_data;
 
-	return sprintf(buf, "%d\n", 
-		       priv->conn->max_buffsize);
+	return sprintf(buf, "%d\n", priv->conn->max_buffsize);
 }
 
 static ssize_t
 buffer_write (struct device *dev, const char *buf, size_t count)
 {
-	netiucv_priv *priv = dev->driver_data;
-	struct net_device *ndev = container_of((void *)priv, struct net_device, priv);
+	struct netiucv_priv *priv = dev->driver_data;
+	struct net_device *ndev =
+		container_of((void *)priv, struct net_device, priv);
 	char         *e;
 	int          bs1;
 	char         tmp[CTRL_BUFSIZE];
@@ -1354,10 +1306,9 @@
 static ssize_t
 dev_fsm_show (struct device *dev, char *buf)
 {
-	netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev->driver_data;
 	
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-			fsm_getstate_str(priv->fsm));
+	return sprintf(buf, "%s\n", fsm_getstate_str(priv->fsm));
 }
 
 static DEVICE_ATTR(device_fsm_state, 0444, dev_fsm_show, NULL);
@@ -1365,10 +1316,9 @@
 static ssize_t
 conn_fsm_show (struct device *dev, char *buf)
 {
-	netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev->driver_data;
 	
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-			fsm_getstate_str(priv->conn->fsm));
+	return sprintf(buf, "%s\n", fsm_getstate_str(priv->conn->fsm));
 }
 
 static DEVICE_ATTR(connection_fsm_state, 0444, conn_fsm_show, NULL);
@@ -1376,7 +1326,7 @@
 static ssize_t
 maxmulti_show (struct device *dev, char *buf)
 {
-	netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev->driver_data;
 	
 	return sprintf(buf, "%ld\n", priv->conn->prof.maxmulti);
 }
@@ -1384,7 +1334,7 @@
 static ssize_t
 maxmulti_write (struct device *dev, const char *buf, size_t count)
 {
-	netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev->driver_data;
 	
 	priv->conn->prof.maxmulti = 0;
 	return count;
@@ -1395,7 +1345,7 @@
 static ssize_t
 maxcq_show (struct device *dev, char *buf)
 {
-	netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev->driver_data;
 	
 	return sprintf(buf, "%ld\n", priv->conn->prof.maxcqueue);
 }
@@ -1403,7 +1353,7 @@
 static ssize_t
 maxcq_write (struct device *dev, const char *buf, size_t count)
 {
-	netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev->driver_data;
 	
 	priv->conn->prof.maxcqueue = 0;
 	return count;
@@ -1414,7 +1364,7 @@
 static ssize_t
 sdoio_show (struct device *dev, char *buf)
 {
-	netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev->driver_data;
 	
 	return sprintf(buf, "%ld\n", priv->conn->prof.doios_single);
 }
@@ -1422,7 +1372,7 @@
 static ssize_t
 sdoio_write (struct device *dev, const char *buf, size_t count)
 {
-	netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev->driver_data;
 	
 	priv->conn->prof.doios_single = 0;
 	return count;
@@ -1433,7 +1383,7 @@
 static ssize_t
 mdoio_show (struct device *dev, char *buf)
 {
-	netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev->driver_data;
 	
 	return sprintf(buf, "%ld\n", priv->conn->prof.doios_multi);
 }
@@ -1441,7 +1391,7 @@
 static ssize_t
 mdoio_write (struct device *dev, const char *buf, size_t count)
 {
-	netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev->driver_data;
 	
 	priv->conn->prof.doios_multi = 0;
 	return count;
@@ -1452,7 +1402,7 @@
 static ssize_t
 txlen_show (struct device *dev, char *buf)
 {
-	netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev->driver_data;
 	
 	return sprintf(buf, "%ld\n", priv->conn->prof.txlen);
 }
@@ -1460,7 +1410,7 @@
 static ssize_t
 txlen_write (struct device *dev, const char *buf, size_t count)
 {
-	netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev->driver_data;
 	
 	priv->conn->prof.txlen = 0;
 	return count;
@@ -1471,7 +1421,7 @@
 static ssize_t
 txtime_show (struct device *dev, char *buf)
 {
-	netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev->driver_data;
 	
 	return sprintf(buf, "%ld\n", priv->conn->prof.tx_time);
 }
@@ -1479,7 +1429,7 @@
 static ssize_t
 txtime_write (struct device *dev, const char *buf, size_t count)
 {
-	netiucv_priv *priv = dev->driver_data;
+	struct netiucv_priv *priv = dev->driver_data;
 	
 	priv->conn->prof.tx_time = 0;
 	return count;
@@ -1492,8 +1442,7 @@
 {
 	int ret = 0;
 
-	if ((ret = device_create_file(dev, &dev_attr_user)) ||
-	    (ret = device_create_file(dev, &dev_attr_buffer)) ||
+	if ((ret = device_create_file(dev, &dev_attr_buffer)) ||
 	    (ret = device_create_file(dev, &dev_attr_device_fsm_state)) ||
 	    (ret = device_create_file(dev, &dev_attr_connection_fsm_state)) ||
 	    (ret = device_create_file(dev, &dev_attr_max_tx_buffer_used)) ||
@@ -1510,7 +1459,6 @@
 		device_remove_file(dev, &dev_attr_connection_fsm_state);
 		device_remove_file(dev, &dev_attr_device_fsm_state);
 		device_remove_file(dev, &dev_attr_buffer);
-		device_remove_file(dev, &dev_attr_user);
 	}
 	return ret;
 }
@@ -1518,53 +1466,53 @@
 static int
 netiucv_register_device(struct net_device *ndev, int ifno)
 {
-	netiucv_priv *priv = ndev->priv;
-	struct platform_device *pldev = &priv->pldev;
+	struct netiucv_priv *priv = ndev->priv;
+	struct device *dev = &priv->dev;
 	int ret;
 	char *str = "netiucv";
 
-	snprintf(pldev->dev.name, DEVICE_NAME_SIZE, 
-		 "%s%x", str, ifno);
-	pldev->name = str;
-	pldev->id = ifno;
+	snprintf(dev->name, DEVICE_NAME_SIZE, "%s", priv->conn->userid);
+	snprintf(dev->bus_id, BUS_ID_SIZE, "%s%x", str, ifno);
+	dev->bus = &iucv_bus;
+	dev->parent = &iucv_root;
 
-	ret = platform_device_register(pldev);
+	ret = device_register(dev);
 
 	if (ret)
 		return ret;
 
-	ret = netiucv_add_files(&pldev->dev);
+	ret = netiucv_add_files(dev);
 
 	if (ret) 
-		platform_device_unregister(pldev);
+		device_unregister(dev);
 	else
-		pldev->dev.driver_data = priv;
+		dev->driver_data = priv;
 	return ret;
 }
 
-#ifdef MODULE
 static void
 netiucv_unregister_device(struct net_device *ndev)
 {
-	netiucv_priv *priv = (netiucv_priv*)ndev->priv;
-	struct platform_device *pldev = &priv->pldev;
+	struct netiucv_priv *priv = (struct netiucv_priv*)ndev->priv;
+	struct device *dev = &priv->dev;
 	
-	platform_device_unregister(pldev);
+	device_unregister(dev);
 }
-#endif
 
 /**
  * Allocate and initialize a new connection structure.
  * Add it to the list of connections;
  */
-static iucv_connection *
-netiucv_new_connection(net_device *dev, char *username)
+static struct iucv_connection *
+netiucv_new_connection(struct net_device *dev, char *username)
 {
-	iucv_connection **clist = &connections;
-	iucv_connection *conn =
-		(iucv_connection *)kmalloc(sizeof(iucv_connection), GFP_KERNEL);
+	struct iucv_connection **clist = &connections;
+	struct iucv_connection *conn =
+		(struct iucv_connection *)
+		kmalloc(sizeof(struct iucv_connection), GFP_KERNEL);
+
 	if (conn) {
-		memset(conn, 0, sizeof(iucv_connection));
+		memset(conn, 0, sizeof(struct iucv_connection));
 		skb_queue_head_init(&conn->collect_queue);
 		conn->max_buffsize = NETIUCV_BUFSIZE_DEFAULT;
 		conn->netdev = dev;
@@ -1609,9 +1557,9 @@
  * list of connections.
  */
 static void
-netiucv_remove_connection(iucv_connection *conn)
+netiucv_remove_connection(struct iucv_connection *conn)
 {
-	iucv_connection **clist = &connections;
+	struct iucv_connection **clist = &connections;
 
 	if (conn == NULL)
 		return;
@@ -1635,26 +1583,26 @@
 /**
  * Allocate and initialize everything of a net device.
  */
-static net_device *
+static struct net_device *
 netiucv_init_netdevice(int ifno, char *username)
 {
-	netiucv_priv *privptr;
+	struct netiucv_priv *privptr;
 	int          priv_size;
 
-	net_device *dev = kmalloc(sizeof(net_device), GFP_KERNEL);
+	struct net_device *dev = kmalloc(sizeof(struct net_device), GFP_KERNEL);
 	if (!dev)
 		return NULL;
-	memset(dev, 0, sizeof(net_device));
+	memset(dev, 0, sizeof(struct net_device));
 	sprintf(dev->name, "iucv%d", ifno);
 
-	priv_size = sizeof(netiucv_priv);
+	priv_size = sizeof(struct netiucv_priv);
 	dev->priv = kmalloc(priv_size, GFP_KERNEL);
 	if (dev->priv == NULL) {
 		kfree(dev);
 		return NULL;
 	}
         memset(dev->priv, 0, priv_size);
-        privptr = (netiucv_priv *)dev->priv;
+        privptr = (struct netiucv_priv *)dev->priv;
 	privptr->fsm = init_fsm("netiucvdev", dev_state_names,
 				dev_event_names, NR_DEV_STATES, NR_DEV_EVENTS,
 				dev_fsm, DEV_FSM_LEN, GFP_KERNEL);
@@ -1691,14 +1639,14 @@
  * Allocate and initialize everything of a net device.
  */
 static void
-netiucv_free_netdevice(net_device *dev)
+netiucv_free_netdevice(struct net_device *dev)
 {
-	netiucv_priv *privptr;
+	struct netiucv_priv *privptr;
 
 	if (!dev)
 		return;
 
-	privptr = (netiucv_priv *)dev->priv;
+	privptr = (struct netiucv_priv *)dev->priv;
 	if (privptr) {
 		if (privptr->conn)
 			netiucv_remove_connection(privptr->conn);
@@ -1709,10 +1657,67 @@
 	kfree(dev);
 }
 
+static ssize_t
+conn_write(struct device_driver *drv, const char *buf, size_t count)
+{
+	char *p;
+	char username[10];
+	int i;
+	struct net_device *dev;
+
+	if (count>9) {
+		printk(KERN_WARNING
+		       "netiucv: username too long (%d)!\n", (int)count);
+		return -EINVAL;
+	}
+
+	for (i=0, p=(char *)buf; i<8 && *p; i++, p++) {
+		if (isalnum(*p))
+			username[i]= *p;
+		else if (*p == '\n') {
+			/* trailing lf, grr */
+			break;
+		} else {
+			printk(KERN_WARNING
+			       "netiucv: Invalid character in username!\n");
+			return -EINVAL;
+		}
+	}
+	while (i<9)
+		username[i++] = ' ';
+	username[9] = '\0';
+	dev = netiucv_init_netdevice(ifno, username);
+	if (!dev) {
+		printk(KERN_WARNING
+		       "netiucv: Could not allocate network device structure "
+		       "for user '%s'\n", netiucv_printname(username));
+		return -ENODEV;
+	}
+	
+	if (register_netdev(dev)) {
+		printk(KERN_WARNING
+		       "netiucv: Could not register '%s'\n", dev->name);
+		netiucv_free_netdevice(dev);
+		return -ENODEV;
+	}
+	printk(KERN_INFO "%s: '%s'\n", dev->name, netiucv_printname(username));
+	netiucv_register_device(dev, ifno);
+	ifno++;
+	
+	return count;
+}
+
+DRIVER_ATTR(connection, 0200, NULL, conn_write);
+
+static struct device_driver netiucv_driver = {
+	.name = "NETIUCV",
+	.bus  = &iucv_bus,
+};
+
 static void
 netiucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.12 $";
+	char vbuf[] = "$Revision: 1.16 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
@@ -1724,101 +1729,65 @@
 	printk(KERN_INFO "NETIUCV driver Version%s initialized\n", version);
 }
 
-#ifndef MODULE
-static int __init
-iucv_setup(char *param)
-{
-	/**
-	* We do not parse parameters here because at the time of
-	* calling iucv_setup(), the kernel does not yet have
-	* memory management running. We delay this until probing
-	* is called.
-	*/
-	iucv = param;
-	return 1;
-}
-
-__setup ("iucv=", iucv_setup);
-
-#else
-
 static void __exit
 netiucv_exit(void)
 {
 	while (connections) {
-		net_device *dev = connections->netdev;
+		struct net_device *dev = connections->netdev;
 		unregister_netdev(dev);
 		netiucv_unregister_device(dev);
 		netiucv_free_netdevice(dev);
 	}
 
+	driver_remove_file(&netiucv_driver, &driver_attr_connection);
+	driver_unregister(&netiucv_driver);
+	bus_unregister(&iucv_bus);
+
 	printk(KERN_INFO "NETIUCV driver unloaded\n");
 	return;
 }
 
-module_exit(netiucv_exit);
-#endif
-
 static int __init
 netiucv_init(void)
 {
-	char *p = iucv;
-	int ifno = 0;
-	int i = 0;
-	char username[10];
+	int ret;
+	
+	/* Move the bus stuff to iucv.c? - CH */
+	ret = bus_register(&iucv_bus);
+	if (ret != 0) {
+		printk(KERN_ERR "NETIUCV: failed to register bus.\n");
+		return ret;
+	}
 
-	while (p) {
-		if (isalnum(*p)) {
-			username[i++] = *p++;
-			username[i] = '\0';
-			if (i > 8) {
-				printk(KERN_WARNING
-				       "netiucv: Invalid user name '%s'\n",
-				       username);
-				while (*p && (*p != ':') && (*p != ','))
-					p++;
-			}
-		} else {
-			if (*p && (*p != ':') && (*p != ',')) {
-				printk(KERN_WARNING
-				       "netiucv: Invalid delimiter '%c'\n",
-				       *p);
-				while (*p && (*p != ':') && (*p != ','))
-					p++;
-			} else {
-				if (i) {
-					net_device *dev;
+	ret = driver_register(&netiucv_driver);
+	if (ret != 0) {
+		printk(KERN_ERR "NETIUCV: failed to register driver.\n");
+		bus_unregister(&iucv_bus);
+		return ret;
+	}
 
-					while (i < 9)
-						username[i++] = ' ';
-					username[9] = '\0';
-					dev = netiucv_init_netdevice(ifno,
-								     username);
-					if (!dev)
-						printk(KERN_WARNING
-						       "netiucv: Could not allocate network device structure for user '%s'\n", netiucv_printname(username));
-					else {
-						if (register_netdev(dev)) {
-							printk(KERN_WARNING
-							       "netiucv: Could not register '%s'\n", dev->name);
-							netiucv_free_netdevice(dev);
-						} else {
-							printk(KERN_INFO "%s: '%s'\n", dev->name, netiucv_printname(username));
-							netiucv_register_device(dev, ifno);
-							ifno++;
-						}
-					}						
-				}
-				if (!(*p))
-					break;
-				i = 0;
-				p++;
-			}
-		}
+	ret = device_register(&iucv_root);
+	if (ret != 0) {
+		printk(KERN_ERR "NETIUCV: failed to register iucv root.\n");
+		driver_unregister(&netiucv_driver);
+		bus_unregister(&iucv_bus);
+		return ret;
 	}
-	netiucv_banner();
-	return 0;
-}
 
+	/* Add entry for specifying connections. */
+	ret = driver_create_file(&netiucv_driver, &driver_attr_connection);
+
+	if (ret == 0)
+		netiucv_banner();
+	else {
+		printk(KERN_ERR "NETIUCV: failed to add driver attribute.\n");
+		device_unregister(&iucv_root);
+		driver_unregister(&netiucv_driver);
+		bus_unregister(&iucv_bus);
+	}
+	return ret;
+}
+	
 module_init(netiucv_init);
+module_exit(netiucv_exit);
 MODULE_LICENSE("GPL");

