Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262413AbVE0JTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbVE0JTu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 05:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbVE0JTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 05:19:23 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:49614 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S262399AbVE0JBW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 05:01:22 -0400
Date: Fri, 27 May 2005 11:02:59 +0200
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: [patch 5/10] s390: ctc code cleanup
Message-ID: <20050527090259.GE8213@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Frank Pavlic <pavlic@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch 5/10] s390: ctc code cleanup.

From: Peter Tiedemann <ptiedem@de.ibm.com>

ctc network driver changes:
 - Some code cleanup.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/net/ctcdbug.h |   12 
 drivers/s390/net/ctcmain.c |  616 +++++++++++++++------------------------------
 drivers/s390/net/ctcmain.h |  276 ++++++++++++++++++++
 3 files changed, 490 insertions(+), 414 deletions(-)

diff -urpN linux-2.6/drivers/s390/net/ctcdbug.h linux-2.6-patched/drivers/s390/net/ctcdbug.h
--- linux-2.6/drivers/s390/net/ctcdbug.h	2005-03-02 08:38:07.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/ctcdbug.h	2005-05-06 11:26:19.000000000 +0200
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/ctcdbug.h ($Revision: 1.4 $)
+ * linux/drivers/s390/net/ctcdbug.h ($Revision: 1.5 $)
  *
  * CTC / ESCON network driver - s390 dbf exploit.
  *
@@ -9,7 +9,7 @@
  *    Author(s): Original Code written by
  *			  Peter Tiedemann (ptiedem@de.ibm.com)
  *
- *    $Revision: 1.4 $	 $Date: 2004/10/15 09:26:58 $
+ *    $Revision: 1.5 $	 $Date: 2005/02/27 19:46:44 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -25,9 +25,11 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
-
+#ifndef _CTCDBUG_H_
+#define _CTCDBUG_H_
 
 #include <asm/debug.h>
+#include "ctcmain.h"
 /**
  * Debug Facility stuff
  */
@@ -41,7 +43,7 @@
 #define CTC_DBF_DATA_LEN 128
 #define CTC_DBF_DATA_INDEX 3
 #define CTC_DBF_DATA_NR_AREAS 1
-#define CTC_DBF_DATA_LEVEL 2
+#define CTC_DBF_DATA_LEVEL 3
 
 #define CTC_DBF_TRACE_NAME "ctc_trace"
 #define CTC_DBF_TRACE_LEN 16
@@ -121,3 +123,5 @@ hex_dump(unsigned char *buf, size_t len)
 	printk("\n");
 }
 
+
+#endif
diff -urpN linux-2.6/drivers/s390/net/ctcmain.c linux-2.6-patched/drivers/s390/net/ctcmain.c
--- linux-2.6/drivers/s390/net/ctcmain.c	2005-05-06 11:25:57.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/ctcmain.c	2005-05-06 11:26:19.000000000 +0200
@@ -1,5 +1,5 @@
 /*
- * $Id: ctcmain.c,v 1.72 2005/03/17 10:51:52 ptiedem Exp $
+ * $Id: ctcmain.c,v 1.74 2005/03/24 09:04:17 mschwide Exp $
  *
  * CTC / ESCON network driver
  *
@@ -37,12 +37,11 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.72 $
+ * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.74 $
  *
  */
 
 #undef DEBUG
-
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -74,288 +73,13 @@
 #include "ctctty.h"
 #include "fsm.h"
 #include "cu3088.h"
+
 #include "ctcdbug.h"
+#include "ctcmain.h"
 
 MODULE_AUTHOR("(C) 2000 IBM Corp. by Fritz Elfert (felfert@millenux.com)");
 MODULE_DESCRIPTION("Linux for S/390 CTC/Escon Driver");
 MODULE_LICENSE("GPL");
-
-/**
- * CCW commands, used in this driver.
- */
-#define CCW_CMD_WRITE		0x01
-#define CCW_CMD_READ		0x02
-#define CCW_CMD_SET_EXTENDED	0xc3
-#define CCW_CMD_PREPARE		0xe3
-
-#define CTC_PROTO_S390          0
-#define CTC_PROTO_LINUX         1
-#define CTC_PROTO_LINUX_TTY     2
-#define CTC_PROTO_OS390         3
-#define CTC_PROTO_MAX           3
-
-#define CTC_BUFSIZE_LIMIT       65535
-#define CTC_BUFSIZE_DEFAULT     32768
-
-#define CTC_TIMEOUT_5SEC        5000
-
-#define CTC_INITIAL_BLOCKLEN    2
-
-#define READ			0
-#define WRITE			1
-
-#define CTC_ID_SIZE             BUS_ID_SIZE+3
-
-
-struct ctc_profile {
-	unsigned long maxmulti;
-	unsigned long maxcqueue;
-	unsigned long doios_single;
-	unsigned long doios_multi;
-	unsigned long txlen;
-	unsigned long tx_time;
-	struct timespec send_stamp;
-};
-
-/**
- * Definition of one channel
- */
-struct channel {
-
-	/**
-	 * Pointer to next channel in list.
-	 */
-	struct channel *next;
-	char id[CTC_ID_SIZE];
-	struct ccw_device *cdev;
-
-	/**
-	 * Type of this channel.
-	 * CTC/A or Escon for valid channels.
-	 */
-	enum channel_types type;
-
-	/**
-	 * Misc. flags. See CHANNEL_FLAGS_... below
-	 */
-	__u32 flags;
-
-	/**
-	 * The protocol of this channel
-	 */
-	__u16 protocol;
-
-	/**
-	 * I/O and irq related stuff
-	 */
-	struct ccw1 *ccw;
-	struct irb *irb;
-
-	/**
-	 * RX/TX buffer size
-	 */
-	int max_bufsize;
-
-	/**
-	 * Transmit/Receive buffer.
-	 */
-	struct sk_buff *trans_skb;
-
-	/**
-	 * Universal I/O queue.
-	 */
-	struct sk_buff_head io_queue;
-
-	/**
-	 * TX queue for collecting skb's during busy.
-	 */
-	struct sk_buff_head collect_queue;
-
-	/**
-	 * Amount of data in collect_queue.
-	 */
-	int collect_len;
-
-	/**
-	 * spinlock for collect_queue and collect_len
-	 */
-	spinlock_t collect_lock;
-
-	/**
-	 * Timer for detecting unresposive
-	 * I/O operations.
-	 */
-	fsm_timer timer;
-
-	/**
-	 * Retry counter for misc. operations.
-	 */
-	int retry;
-
-	/**
-	 * The finite state machine of this channel
-	 */
-	fsm_instance *fsm;
-
-	/**
-	 * The corresponding net_device this channel
-	 * belongs to.
-	 */
-	struct net_device *netdev;
-
-	struct ctc_profile prof;
-
-	unsigned char *trans_skb_data;
-
-	__u16 logflags;
-};
-
-#define CHANNEL_FLAGS_READ            0
-#define CHANNEL_FLAGS_WRITE           1
-#define CHANNEL_FLAGS_INUSE           2
-#define CHANNEL_FLAGS_BUFSIZE_CHANGED 4
-#define CHANNEL_FLAGS_FAILED          8
-#define CHANNEL_FLAGS_WAITIRQ        16
-#define CHANNEL_FLAGS_RWMASK 1
-#define CHANNEL_DIRECTION(f) (f & CHANNEL_FLAGS_RWMASK)
-
-#define LOG_FLAG_ILLEGALPKT  1
-#define LOG_FLAG_ILLEGALSIZE 2
-#define LOG_FLAG_OVERRUN     4
-#define LOG_FLAG_NOMEM       8
-
-#define CTC_LOGLEVEL_INFO     1
-#define CTC_LOGLEVEL_NOTICE   2
-#define CTC_LOGLEVEL_WARN     4
-#define CTC_LOGLEVEL_EMERG    8
-#define CTC_LOGLEVEL_ERR     16
-#define CTC_LOGLEVEL_DEBUG   32
-#define CTC_LOGLEVEL_CRIT    64
-
-#define CTC_LOGLEVEL_DEFAULT \
-(CTC_LOGLEVEL_INFO | CTC_LOGLEVEL_NOTICE | CTC_LOGLEVEL_WARN | CTC_LOGLEVEL_CRIT)
-
-#define CTC_LOGLEVEL_MAX     ((CTC_LOGLEVEL_CRIT<<1)-1)
-
-static int loglevel = CTC_LOGLEVEL_DEFAULT;
-
-#define ctc_pr_debug(fmt, arg...) \
-do { if (loglevel & CTC_LOGLEVEL_DEBUG) printk(KERN_DEBUG fmt,##arg); } while (0)
-
-#define ctc_pr_info(fmt, arg...) \
-do { if (loglevel & CTC_LOGLEVEL_INFO) printk(KERN_INFO fmt,##arg); } while (0)
-
-#define ctc_pr_notice(fmt, arg...) \
-do { if (loglevel & CTC_LOGLEVEL_NOTICE) printk(KERN_NOTICE fmt,##arg); } while (0)
-
-#define ctc_pr_warn(fmt, arg...) \
-do { if (loglevel & CTC_LOGLEVEL_WARN) printk(KERN_WARNING fmt,##arg); } while (0)
-
-#define ctc_pr_emerg(fmt, arg...) \
-do { if (loglevel & CTC_LOGLEVEL_EMERG) printk(KERN_EMERG fmt,##arg); } while (0)
-
-#define ctc_pr_err(fmt, arg...) \
-do { if (loglevel & CTC_LOGLEVEL_ERR) printk(KERN_ERR fmt,##arg); } while (0)
-
-#define ctc_pr_crit(fmt, arg...) \
-do { if (loglevel & CTC_LOGLEVEL_CRIT) printk(KERN_CRIT fmt,##arg); } while (0)
-
-/**
- * Linked list of all detected channels.
- */
-static struct channel *channels = NULL;
-
-struct ctc_priv {
-	struct net_device_stats stats;
-	unsigned long tbusy;
-	/**
-	 * The finite state machine of this interface.
-	 */
-	fsm_instance *fsm;
-	/**
-	 * The protocol of this device
-	 */
-	__u16 protocol;
- 	/**
- 	 * Timer for restarting after I/O Errors
- 	 */
- 	fsm_timer               restart_timer;
-
-	int buffer_size;
-
-	struct channel *channel[2];
-};
-
-/**
- * Definition of our link level header.
- */
-struct ll_header {
-	__u16 length;
-	__u16 type;
-	__u16 unused;
-};
-#define LL_HEADER_LENGTH (sizeof(struct ll_header))
-
-/**
- * Compatibility macros for busy handling
- * of network devices.
- */
-static __inline__ void
-ctc_clear_busy(struct net_device * dev)
-{
-	clear_bit(0, &(((struct ctc_priv *) dev->priv)->tbusy));
-	if (((struct ctc_priv *)dev->priv)->protocol != CTC_PROTO_LINUX_TTY)
-		netif_wake_queue(dev);
-}
-
-static __inline__ int
-ctc_test_and_set_busy(struct net_device * dev)
-{
-	if (((struct ctc_priv *)dev->priv)->protocol != CTC_PROTO_LINUX_TTY)
-		netif_stop_queue(dev);
-	return test_and_set_bit(0, &((struct ctc_priv *) dev->priv)->tbusy);
-}
-
-/**
- * Print Banner.
- */
-static void
-print_banner(void)
-{
-	static int printed = 0;
-	char vbuf[] = "$Revision: 1.72 $";
-	char *version = vbuf;
-
-	if (printed)
-		return;
-	if ((version = strchr(version, ':'))) {
-		char *p = strchr(version + 1, '$');
-		if (p)
-			*p = '\0';
-	} else
-		version = " ??? ";
-	printk(KERN_INFO "CTC driver Version%s"
-#ifdef DEBUG
-		    " (DEBUG-VERSION, " __DATE__ __TIME__ ")"
-#endif
-		    " initialized\n", version);
-	printed = 1;
-}
-
-/**
- * Return type of a detected device.
- */
-static enum channel_types
-get_channel_type(struct ccw_device_id *id)
-{
-	enum channel_types type = (enum channel_types) id->driver_info;
-
-	if (type == channel_type_ficon)
-		type = channel_type_escon;
-
-	return type;
-}
-
 /**
  * States of the interface statemachine.
  */
@@ -371,7 +95,7 @@ enum dev_states {
 	/**
 	 * MUST be always the last element!!
 	 */
-	NR_DEV_STATES
+	CTC_NR_DEV_STATES
 };
 
 static const char *dev_state_names[] = {
@@ -399,7 +123,7 @@ enum dev_events {
 	/**
 	 * MUST be always the last element!!
 	 */
-	NR_DEV_EVENTS
+	CTC_NR_DEV_EVENTS
 };
 
 static const char *dev_event_names[] = {
@@ -476,40 +200,6 @@ enum ch_events {
 	NR_CH_EVENTS,
 };
 
-static const char *ch_event_names[] = {
-	"ccw_device success",
-	"ccw_device busy",
-	"ccw_device enodev",
-	"ccw_device ioerr",
-	"ccw_device unknown",
-
-	"Status ATTN & BUSY",
-	"Status ATTN",
-	"Status BUSY",
-
-	"Unit check remote reset",
-	"Unit check remote system reset",
-	"Unit check TX timeout",
-	"Unit check TX parity",
-	"Unit check Hardware failure",
-	"Unit check RX parity",
-	"Unit check ZERO",
-	"Unit check Unknown",
-
-	"SubChannel check Unknown",
-
-	"Machine check failure",
-	"Machine check operational",
-
-	"IRQ normal",
-	"IRQ final",
-
-	"Timer",
-
-	"Start",
-	"Stop",
-};
-
 /**
  * States of the channel statemachine.
  */
@@ -545,6 +235,87 @@ enum ch_states {
 	NR_CH_STATES,
 };
 
+static int loglevel = CTC_LOGLEVEL_DEFAULT;
+
+/**
+ * Linked list of all detected channels.
+ */
+static struct channel *channels = NULL;
+
+/**
+ * Print Banner.
+ */
+static void
+print_banner(void)
+{
+	static int printed = 0;
+	char vbuf[] = "$Revision: 1.74 $";
+	char *version = vbuf;
+
+	if (printed)
+		return;
+	if ((version = strchr(version, ':'))) {
+		char *p = strchr(version + 1, '$');
+		if (p)
+			*p = '\0';
+	} else
+		version = " ??? ";
+	printk(KERN_INFO "CTC driver Version%s"
+#ifdef DEBUG
+		    " (DEBUG-VERSION, " __DATE__ __TIME__ ")"
+#endif
+		    " initialized\n", version);
+	printed = 1;
+}
+
+/**
+ * Return type of a detected device.
+ */
+static enum channel_types
+get_channel_type(struct ccw_device_id *id)
+{
+	enum channel_types type = (enum channel_types) id->driver_info;
+
+	if (type == channel_type_ficon)
+		type = channel_type_escon;
+
+	return type;
+}
+
+static const char *ch_event_names[] = {
+	"ccw_device success",
+	"ccw_device busy",
+	"ccw_device enodev",
+	"ccw_device ioerr",
+	"ccw_device unknown",
+
+	"Status ATTN & BUSY",
+	"Status ATTN",
+	"Status BUSY",
+
+	"Unit check remote reset",
+	"Unit check remote system reset",
+	"Unit check TX timeout",
+	"Unit check TX parity",
+	"Unit check Hardware failure",
+	"Unit check RX parity",
+	"Unit check ZERO",
+	"Unit check Unknown",
+
+	"SubChannel check Unknown",
+
+	"Machine check failure",
+	"Machine check operational",
+
+	"IRQ normal",
+	"IRQ final",
+
+	"Timer",
+
+	"Start",
+	"Stop",
+};
+
 static const char *ch_state_names[] = {
 	"Idle",
 	"Stopped",
@@ -1934,7 +1705,6 @@ add_channel(struct ccw_device *cdev, enu
 	ch->cdev = cdev;
 	snprintf(ch->id, CTC_ID_SIZE, "ch-%s", cdev->dev.bus_id);
 	ch->type = type;
-	loglevel = CTC_LOGLEVEL_DEFAULT;
 	ch->fsm = init_fsm(ch->id, ch_state_names,
 			   ch_event_names, NR_CH_STATES, NR_CH_EVENTS,
 			   ch_fsm, CH_FSM_LEN, GFP_KERNEL);
@@ -2697,6 +2467,7 @@ ctc_stats(struct net_device * dev)
 /*
  * sysfs attributes
  */
+
 static ssize_t
 buffer_show(struct device *dev, char *buf)
 {
@@ -2715,57 +2486,61 @@ buffer_write(struct device *dev, const c
 	struct ctc_priv *priv;
 	struct net_device *ndev;
 	int bs1;
+	char buffer[16];
 
 	DBF_TEXT(trace, 3, __FUNCTION__);
+	DBF_TEXT(trace, 3, buf);
 	priv = dev->driver_data;
-	if (!priv)
+	if (!priv) {
+		DBF_TEXT(trace, 3, "bfnopriv");
 		return -ENODEV;
+	}
+
+	sscanf(buf, "%u", &bs1);
+	if (bs1 > CTC_BUFSIZE_LIMIT)
+		goto einval;
+	if (bs1 < (576 + LL_HEADER_LENGTH + 2))
+		goto einval;
+	priv->buffer_size = bs1;	// just to overwrite the default
+
 	ndev = priv->channel[READ]->netdev;
-	if (!ndev)
+	if (!ndev) {
+		DBF_TEXT(trace, 3, "bfnondev");
 		return -ENODEV;
-	sscanf(buf, "%u", &bs1);
+	}
 
-	if (bs1 > CTC_BUFSIZE_LIMIT)
-		return -EINVAL;
 	if ((ndev->flags & IFF_RUNNING) &&
 	    (bs1 < (ndev->mtu + LL_HEADER_LENGTH + 2)))
-		return -EINVAL;
-	if (bs1 < (576 + LL_HEADER_LENGTH + 2))
-		return -EINVAL;
+		goto einval;
 
-	priv->buffer_size = bs1;
-	priv->channel[READ]->max_bufsize =
-	    priv->channel[WRITE]->max_bufsize = bs1;
+	priv->channel[READ]->max_bufsize = bs1;
+	priv->channel[WRITE]->max_bufsize = bs1;
 	if (!(ndev->flags & IFF_RUNNING))
 		ndev->mtu = bs1 - LL_HEADER_LENGTH - 2;
 	priv->channel[READ]->flags |= CHANNEL_FLAGS_BUFSIZE_CHANGED;
 	priv->channel[WRITE]->flags |= CHANNEL_FLAGS_BUFSIZE_CHANGED;
 
+	sprintf(buffer, "%d",priv->buffer_size);
+	DBF_TEXT(trace, 3, buffer);
 	return count;
 
+einval:
+	DBF_TEXT(trace, 3, "buff_err");
+	return -EINVAL;
 }
 
 static ssize_t
 loglevel_show(struct device *dev, char *buf)
 {
-	struct ctc_priv *priv;
-
-	priv = dev->driver_data;
-	if (!priv)
-		return -ENODEV;
 	return sprintf(buf, "%d\n", loglevel);
 }
 
 static ssize_t
 loglevel_write(struct device *dev, const char *buf, size_t count)
 {
-	struct ctc_priv *priv;
 	int ll1;
 
 	DBF_TEXT(trace, 5, __FUNCTION__);
-	priv = dev->driver_data;
-	if (!priv)
-		return -ENODEV;
 	sscanf(buf, "%i", &ll1);
 
 	if ((ll1 > CTC_LOGLEVEL_MAX) || (ll1 < 0))
@@ -2835,27 +2610,6 @@ stats_write(struct device *dev, const ch
 	return count;
 }
 
-static DEVICE_ATTR(buffer, 0644, buffer_show, buffer_write);
-static DEVICE_ATTR(loglevel, 0644, loglevel_show, loglevel_write);
-static DEVICE_ATTR(stats, 0644, stats_show, stats_write);
-
-static int
-ctc_add_attributes(struct device *dev)
-{
-//	device_create_file(dev, &dev_attr_buffer);
-	device_create_file(dev, &dev_attr_loglevel);
-	device_create_file(dev, &dev_attr_stats);
-	return 0;
-}
-
-static void
-ctc_remove_attributes(struct device *dev)
-{
-	device_remove_file(dev, &dev_attr_stats);
-	device_remove_file(dev, &dev_attr_loglevel);
-//	device_remove_file(dev, &dev_attr_buffer);
-}
-
 
 static void
 ctc_netdev_unregister(struct net_device * dev)
@@ -2899,52 +2653,6 @@ ctc_free_netdevice(struct net_device * d
 #endif
 }
 
-/**
- * Initialize everything of the net device except the name and the
- * channel structs.
- */
-static struct net_device *
-ctc_init_netdevice(struct net_device * dev, int alloc_device, 
-		   struct ctc_priv *privptr)
-{
-	if (!privptr)
-		return NULL;
-
-	DBF_TEXT(setup, 3, __FUNCTION__);
-	if (alloc_device) {
-		dev = kmalloc(sizeof (struct net_device), GFP_KERNEL);
-		if (!dev)
-			return NULL;
-		memset(dev, 0, sizeof (struct net_device));
-	}
-
-	dev->priv = privptr;
-	privptr->fsm = init_fsm("ctcdev", dev_state_names,
-				dev_event_names, NR_DEV_STATES, NR_DEV_EVENTS,
-				dev_fsm, DEV_FSM_LEN, GFP_KERNEL);
-	if (privptr->fsm == NULL) {
-		if (alloc_device)
-			kfree(dev);
-		return NULL;
-	}
-	fsm_newstate(privptr->fsm, DEV_STATE_STOPPED);
-	fsm_settimer(privptr->fsm, &privptr->restart_timer);
-	if (dev->mtu == 0)
-		dev->mtu = CTC_BUFSIZE_DEFAULT - LL_HEADER_LENGTH - 2;
-	dev->hard_start_xmit = ctc_tx;
-	dev->open = ctc_open;
-	dev->stop = ctc_close;
-	dev->get_stats = ctc_stats;
-	dev->change_mtu = ctc_change_mtu;
-	dev->hard_header_len = LL_HEADER_LENGTH + 2;
-	dev->addr_len = 0;
-	dev->type = ARPHRD_SLIP;
-	dev->tx_queue_len = 100;
-	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
-	SET_MODULE_OWNER(dev);
-	return dev;
-}
-
 static ssize_t
 ctc_proto_show(struct device *dev, char *buf)
 {
@@ -2977,7 +2685,6 @@ ctc_proto_store(struct device *dev, cons
 	return count;
 }
 
-static DEVICE_ATTR(protocol, 0644, ctc_proto_show, ctc_proto_store);
 
 static ssize_t
 ctc_type_show(struct device *dev, char *buf)
@@ -2991,8 +2698,13 @@ ctc_type_show(struct device *dev, char *
 	return sprintf(buf, "%s\n", cu3088_type[cgdev->cdev[0]->id.driver_info]);
 }
 
+static DEVICE_ATTR(buffer, 0644, buffer_show, buffer_write);
+static DEVICE_ATTR(protocol, 0644, ctc_proto_show, ctc_proto_store);
 static DEVICE_ATTR(type, 0444, ctc_type_show, NULL);
 
+static DEVICE_ATTR(loglevel, 0644, loglevel_show, loglevel_write);
+static DEVICE_ATTR(stats, 0644, stats_show, stats_write);
+
 static struct attribute *ctc_attr[] = {
 	&dev_attr_protocol.attr,
 	&dev_attr_type.attr,
@@ -3005,6 +2717,21 @@ static struct attribute_group ctc_attr_g
 };
 
 static int
+ctc_add_attributes(struct device *dev)
+{
+	device_create_file(dev, &dev_attr_loglevel);
+	device_create_file(dev, &dev_attr_stats);
+	return 0;
+}
+
+static void
+ctc_remove_attributes(struct device *dev)
+{
+	device_remove_file(dev, &dev_attr_stats);
+	device_remove_file(dev, &dev_attr_loglevel);
+}
+
+static int
 ctc_add_files(struct device *dev)
 {
 	pr_debug("%s() called\n", __FUNCTION__);
@@ -3028,15 +2755,15 @@ ctc_remove_files(struct device *dev)
  *
  * @returns 0 on success, !0 on failure.
  */
-
 static int
 ctc_probe_device(struct ccwgroup_device *cgdev)
 {
 	struct ctc_priv *priv;
 	int rc;
+	char buffer[16];
 
 	pr_debug("%s() called\n", __FUNCTION__);
-	DBF_TEXT(trace, 3, __FUNCTION__);
+	DBF_TEXT(setup, 3, __FUNCTION__);
 
 	if (!get_device(&cgdev->dev))
 		return -ENODEV;
@@ -3060,10 +2787,70 @@ ctc_probe_device(struct ccwgroup_device 
 	cgdev->cdev[1]->handler = ctc_irq_handler;
 	cgdev->dev.driver_data = priv;
 
+	sprintf(buffer, "%p", priv);
+	DBF_TEXT(data, 3, buffer);
+
+	sprintf(buffer, "%u", (unsigned int)sizeof(struct ctc_priv));
+	DBF_TEXT(data, 3, buffer);
+
+	sprintf(buffer, "%p", &channels);
+	DBF_TEXT(data, 3, buffer);
+
+	sprintf(buffer, "%u", (unsigned int)sizeof(struct channel));
+	DBF_TEXT(data, 3, buffer);
+
 	return 0;
 }
 
 /**
+ * Initialize everything of the net device except the name and the
+ * channel structs.
+ */
+static struct net_device *
+ctc_init_netdevice(struct net_device * dev, int alloc_device,
+		   struct ctc_priv *privptr)
+{
+	if (!privptr)
+		return NULL;
+
+	DBF_TEXT(setup, 3, __FUNCTION__);
+
+	if (alloc_device) {
+		dev = kmalloc(sizeof (struct net_device), GFP_KERNEL);
+		if (!dev)
+			return NULL;
+		memset(dev, 0, sizeof (struct net_device));
+	}
+
+	dev->priv = privptr;
+	privptr->fsm = init_fsm("ctcdev", dev_state_names,
+				dev_event_names, CTC_NR_DEV_STATES, CTC_NR_DEV_EVENTS,
+				dev_fsm, DEV_FSM_LEN, GFP_KERNEL);
+	if (privptr->fsm == NULL) {
+		if (alloc_device)
+			kfree(dev);
+		return NULL;
+	}
+	fsm_newstate(privptr->fsm, DEV_STATE_STOPPED);
+	fsm_settimer(privptr->fsm, &privptr->restart_timer);
+	if (dev->mtu == 0)
+		dev->mtu = CTC_BUFSIZE_DEFAULT - LL_HEADER_LENGTH - 2;
+	dev->hard_start_xmit = ctc_tx;
+	dev->open = ctc_open;
+	dev->stop = ctc_close;
+	dev->get_stats = ctc_stats;
+	dev->change_mtu = ctc_change_mtu;
+	dev->hard_header_len = LL_HEADER_LENGTH + 2;
+	dev->addr_len = 0;
+	dev->type = ARPHRD_SLIP;
+	dev->tx_queue_len = 100;
+	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
+	SET_MODULE_OWNER(dev);
+	return dev;
+}
+
+
+/**
  *
  * Setup an interface.
  *
@@ -3081,6 +2868,7 @@ ctc_new_device(struct ccwgroup_device *c
 	struct ctc_priv *privptr;
 	struct net_device *dev;
 	int ret;
+	char buffer[16];
 
 	pr_debug("%s() called\n", __FUNCTION__);
 	DBF_TEXT(setup, 3, __FUNCTION__);
@@ -3089,6 +2877,9 @@ ctc_new_device(struct ccwgroup_device *c
 	if (!privptr)
 		return -ENODEV;
 
+	sprintf(buffer, "%d", privptr->buffer_size);
+	DBF_TEXT(setup, 3, buffer);
+
 	type = get_channel_type(&cgdev->cdev[0]->id);
 	
 	snprintf(read_id, CTC_ID_SIZE, "ch-%s", cgdev->cdev[0]->dev.bus_id);
@@ -3177,9 +2968,10 @@ ctc_shutdown_device(struct ccwgroup_devi
 	struct ctc_priv *priv;
 	struct net_device *ndev;
 		
-	DBF_TEXT(trace, 3, __FUNCTION__);
+	DBF_TEXT(setup, 3, __FUNCTION__);
 	pr_debug("%s() called\n", __FUNCTION__);
 
+
 	priv = cgdev->dev.driver_data;
 	ndev = NULL;
 	if (!priv)
@@ -3215,7 +3007,6 @@ ctc_shutdown_device(struct ccwgroup_devi
 		channel_remove(priv->channel[READ]);
 	if (priv->channel[WRITE])
 		channel_remove(priv->channel[WRITE]);
-	
 	priv->channel[READ] = priv->channel[WRITE] = NULL;
 
 	return 0;
@@ -3228,7 +3019,7 @@ ctc_remove_device(struct ccwgroup_device
 	struct ctc_priv *priv;
 
 	pr_debug("%s() called\n", __FUNCTION__);
-	DBF_TEXT(trace, 3, __FUNCTION__);
+	DBF_TEXT(setup, 3, __FUNCTION__);
 
 	priv = cgdev->dev.driver_data;
 	if (!priv)
@@ -3265,6 +3056,7 @@ static struct ccwgroup_driver ctc_group_
 static void __exit
 ctc_exit(void)
 {
+	DBF_TEXT(setup, 3, __FUNCTION__);
 	unregister_cu3088_discipline(&ctc_group_driver);
 	ctc_tty_cleanup();
 	ctc_unregister_dbf_views();
@@ -3282,6 +3074,10 @@ ctc_init(void)
 {
 	int ret = 0;
 
+	loglevel = CTC_LOGLEVEL_DEFAULT;
+
+	DBF_TEXT(setup, 3, __FUNCTION__);
+
 	print_banner();
 
 	ret = ctc_register_dbf_views();
diff -urpN linux-2.6/drivers/s390/net/ctcmain.h linux-2.6-patched/drivers/s390/net/ctcmain.h
--- linux-2.6/drivers/s390/net/ctcmain.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/ctcmain.h	2005-05-06 11:26:19.000000000 +0200
@@ -0,0 +1,276 @@
+/*
+ * $Id: ctcmain.h,v 1.4 2005/03/24 09:04:17 mschwide Exp $
+ *
+ * CTC / ESCON network driver
+ *
+ * Copyright (C) 2001 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ * Author(s): Fritz Elfert (elfert@de.ibm.com, felfert@millenux.com)
+	      Peter Tiedemann (ptiedem@de.ibm.com)
+ *
+ *
+ * Documentation used:
+ *  - Principles of Operation (IBM doc#: SA22-7201-06)
+ *  - Common IO/-Device Commands and Self Description (IBM doc#: SA22-7204-02)
+ *  - Common IO/-Device Commands and Self Description (IBM doc#: SN22-5535)
+ *  - ESCON Channel-to-Channel Adapter (IBM doc#: SA22-7203-00)
+ *  - ESCON I/O Interface (IBM doc#: SA22-7202-029
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.4 $
+ *
+ */
+
+#ifndef _CTCMAIN_H_
+#define _CTCMAIN_H_
+
+#include <asm/ccwdev.h>
+#include <asm/ccwgroup.h>
+
+#include "ctctty.h"
+#include "fsm.h"
+#include "cu3088.h"
+
+
+/**
+ * CCW commands, used in this driver.
+ */
+#define CCW_CMD_WRITE		0x01
+#define CCW_CMD_READ		0x02
+#define CCW_CMD_SET_EXTENDED	0xc3
+#define CCW_CMD_PREPARE		0xe3
+
+#define CTC_PROTO_S390          0
+#define CTC_PROTO_LINUX         1
+#define CTC_PROTO_LINUX_TTY     2
+#define CTC_PROTO_OS390         3
+#define CTC_PROTO_MAX           3
+
+#define CTC_BUFSIZE_LIMIT       65535
+#define CTC_BUFSIZE_DEFAULT     32768
+
+#define CTC_TIMEOUT_5SEC        5000
+
+#define CTC_INITIAL_BLOCKLEN    2
+
+#define READ			0
+#define WRITE			1
+
+#define CTC_ID_SIZE             BUS_ID_SIZE+3
+
+
+struct ctc_profile {
+	unsigned long maxmulti;
+	unsigned long maxcqueue;
+	unsigned long doios_single;
+	unsigned long doios_multi;
+	unsigned long txlen;
+	unsigned long tx_time;
+	struct timespec send_stamp;
+};
+
+/**
+ * Definition of one channel
+ */
+struct channel {
+
+	/**
+	 * Pointer to next channel in list.
+	 */
+	struct channel *next;
+	char id[CTC_ID_SIZE];
+	struct ccw_device *cdev;
+
+	/**
+	 * Type of this channel.
+	 * CTC/A or Escon for valid channels.
+	 */
+	enum channel_types type;
+
+	/**
+	 * Misc. flags. See CHANNEL_FLAGS_... below
+	 */
+	__u32 flags;
+
+	/**
+	 * The protocol of this channel
+	 */
+	__u16 protocol;
+
+	/**
+	 * I/O and irq related stuff
+	 */
+	struct ccw1 *ccw;
+	struct irb *irb;
+
+	/**
+	 * RX/TX buffer size
+	 */
+	int max_bufsize;
+
+	/**
+	 * Transmit/Receive buffer.
+	 */
+	struct sk_buff *trans_skb;
+
+	/**
+	 * Universal I/O queue.
+	 */
+	struct sk_buff_head io_queue;
+
+	/**
+	 * TX queue for collecting skb's during busy.
+	 */
+	struct sk_buff_head collect_queue;
+
+	/**
+	 * Amount of data in collect_queue.
+	 */
+	int collect_len;
+
+	/**
+	 * spinlock for collect_queue and collect_len
+	 */
+	spinlock_t collect_lock;
+
+	/**
+	 * Timer for detecting unresposive
+	 * I/O operations.
+	 */
+	fsm_timer timer;
+
+	/**
+	 * Retry counter for misc. operations.
+	 */
+	int retry;
+
+	/**
+	 * The finite state machine of this channel
+	 */
+	fsm_instance *fsm;
+
+	/**
+	 * The corresponding net_device this channel
+	 * belongs to.
+	 */
+	struct net_device *netdev;
+
+	struct ctc_profile prof;
+
+	unsigned char *trans_skb_data;
+
+	__u16 logflags;
+};
+
+#define CHANNEL_FLAGS_READ            0
+#define CHANNEL_FLAGS_WRITE           1
+#define CHANNEL_FLAGS_INUSE           2
+#define CHANNEL_FLAGS_BUFSIZE_CHANGED 4
+#define CHANNEL_FLAGS_FAILED          8
+#define CHANNEL_FLAGS_WAITIRQ        16
+#define CHANNEL_FLAGS_RWMASK 1
+#define CHANNEL_DIRECTION(f) (f & CHANNEL_FLAGS_RWMASK)
+
+#define LOG_FLAG_ILLEGALPKT  1
+#define LOG_FLAG_ILLEGALSIZE 2
+#define LOG_FLAG_OVERRUN     4
+#define LOG_FLAG_NOMEM       8
+
+#define CTC_LOGLEVEL_INFO     1
+#define CTC_LOGLEVEL_NOTICE   2
+#define CTC_LOGLEVEL_WARN     4
+#define CTC_LOGLEVEL_EMERG    8
+#define CTC_LOGLEVEL_ERR     16
+#define CTC_LOGLEVEL_DEBUG   32
+#define CTC_LOGLEVEL_CRIT    64
+
+#define CTC_LOGLEVEL_DEFAULT \
+(CTC_LOGLEVEL_INFO | CTC_LOGLEVEL_NOTICE | CTC_LOGLEVEL_WARN | CTC_LOGLEVEL_CRIT)
+
+#define CTC_LOGLEVEL_MAX     ((CTC_LOGLEVEL_CRIT<<1)-1)
+
+#define ctc_pr_debug(fmt, arg...) \
+do { if (loglevel & CTC_LOGLEVEL_DEBUG) printk(KERN_DEBUG fmt,##arg); } while (0)
+
+#define ctc_pr_info(fmt, arg...) \
+do { if (loglevel & CTC_LOGLEVEL_INFO) printk(KERN_INFO fmt,##arg); } while (0)
+
+#define ctc_pr_notice(fmt, arg...) \
+do { if (loglevel & CTC_LOGLEVEL_NOTICE) printk(KERN_NOTICE fmt,##arg); } while (0)
+
+#define ctc_pr_warn(fmt, arg...) \
+do { if (loglevel & CTC_LOGLEVEL_WARN) printk(KERN_WARNING fmt,##arg); } while (0)
+
+#define ctc_pr_emerg(fmt, arg...) \
+do { if (loglevel & CTC_LOGLEVEL_EMERG) printk(KERN_EMERG fmt,##arg); } while (0)
+
+#define ctc_pr_err(fmt, arg...) \
+do { if (loglevel & CTC_LOGLEVEL_ERR) printk(KERN_ERR fmt,##arg); } while (0)
+
+#define ctc_pr_crit(fmt, arg...) \
+do { if (loglevel & CTC_LOGLEVEL_CRIT) printk(KERN_CRIT fmt,##arg); } while (0)
+
+struct ctc_priv {
+	struct net_device_stats stats;
+	unsigned long tbusy;
+	/**
+	 * The finite state machine of this interface.
+	 */
+	fsm_instance *fsm;
+	/**
+	 * The protocol of this device
+	 */
+	__u16 protocol;
+ 	/**
+ 	 * Timer for restarting after I/O Errors
+ 	 */
+ 	fsm_timer               restart_timer;
+
+	int buffer_size;
+
+	struct channel *channel[2];
+};
+
+/**
+ * Definition of our link level header.
+ */
+struct ll_header {
+	__u16 length;
+	__u16 type;
+	__u16 unused;
+};
+#define LL_HEADER_LENGTH (sizeof(struct ll_header))
+
+/**
+ * Compatibility macros for busy handling
+ * of network devices.
+ */
+static __inline__ void
+ctc_clear_busy(struct net_device * dev)
+{
+	clear_bit(0, &(((struct ctc_priv *) dev->priv)->tbusy));
+	if (((struct ctc_priv *)dev->priv)->protocol != CTC_PROTO_LINUX_TTY)
+		netif_wake_queue(dev);
+}
+
+static __inline__ int
+ctc_test_and_set_busy(struct net_device * dev)
+{
+	if (((struct ctc_priv *)dev->priv)->protocol != CTC_PROTO_LINUX_TTY)
+		netif_stop_queue(dev);
+	return test_and_set_bit(0, &((struct ctc_priv *) dev->priv)->tbusy);
+}
+
+#endif
