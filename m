Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbTH2RRi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 13:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbTH2RPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 13:15:47 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:31719 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261529AbTH2RLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 13:11:25 -0400
Date: Fri, 29 Aug 2003 19:10:56 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (7/8): s390 network driver.
Message-ID: <20030829171056.GH1242@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Add type attribute to ctc and lcs driver.
- Add user attribute to netiucv driver.
- Remove initialization of device.name from ctc, lcs and qeth.
- Some qeth bug fixes:
  + Call qeth_free_card on removal.
  + Remove async hsi.
  + Remove contig memusage.
  + Add check for -EFAULT to copy_from_user/copy_to_user.
  + Some inlining.
  + vlan header fixes.
  + Replace atomic_return_sub with atomic_add_return.

diffstat:
 drivers/s390/net/ctcmain.c |   32 +++-
 drivers/s390/net/cu3088.c  |    5 
 drivers/s390/net/lcs.c     |   25 +++
 drivers/s390/net/netiucv.c |   20 ++-
 drivers/s390/net/qeth.c    |  298 ++++++++++++++-------------------------------
 drivers/s390/net/qeth.h    |   26 ---
 6 files changed, 160 insertions(+), 246 deletions(-)

diff -urN linux-2.6/drivers/s390/net/ctcmain.c linux-2.6-s390/drivers/s390/net/ctcmain.c
--- linux-2.6/drivers/s390/net/ctcmain.c	Sat Aug 23 01:54:23 2003
+++ linux-2.6-s390/drivers/s390/net/ctcmain.c	Fri Aug 29 18:55:12 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: ctcmain.c,v 1.43 2003/05/27 11:34:23 mschwide Exp $
+ * $Id: ctcmain.c,v 1.45 2003/08/28 16:22:40 mschwide Exp $
  *
  * CTC / ESCON network driver
  *
@@ -36,7 +36,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.43 $
+ * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.45 $
  *
  */
 
@@ -272,7 +272,7 @@
 print_banner(void)
 {
 	static int printed = 0;
-	char vbuf[] = "$Revision: 1.43 $";
+	char vbuf[] = "$Revision: 1.45 $";
 	char *version = vbuf;
 
 	if (printed)
@@ -2786,16 +2786,38 @@
 
 static DEVICE_ATTR(protocol, 0644, ctc_proto_show, ctc_proto_store);
 
+static ssize_t
+ctc_type_show(struct device *dev, char *buf)
+{
+	struct ccwgroup_device *cgdev;
+
+	cgdev = to_ccwgroupdev(dev);
+	if (!cgdev)
+		return -ENODEV;
+
+	return sprintf(buf, "%s\n", cu3088_type[cgdev->cdev[0]->id.driver_info]);
+}
+
+static DEVICE_ATTR(type, 0444, ctc_type_show, NULL);
+
 static int
 ctc_add_files(struct device *dev)
 {
-	return device_create_file(dev, &dev_attr_protocol);
+	int rc;
 
+	rc = device_create_file(dev, &dev_attr_protocol);
+	if (rc)
+		return rc;
+	rc = device_create_file(dev, &dev_attr_type);
+	if (rc)
+		device_remove_file(dev, &dev_attr_protocol);
+	return rc;
 }
 
 static void
 ctc_remove_files(struct device *dev)
 {
+	device_remove_file(dev, &dev_attr_type);
 	device_remove_file(dev, &dev_attr_protocol);
 
 }
@@ -2838,8 +2860,6 @@
 	cgdev->dev.driver_data = priv;
 	cgdev->cdev[0]->dev.driver_data = priv;
 	cgdev->cdev[1]->dev.driver_data = priv;
-	snprintf(cgdev->dev.name, DEVICE_NAME_SIZE, "%s",
-		 cu3088_type[cgdev->cdev[0]->id.driver_info]);
 
 	return 0;
 }
diff -urN linux-2.6/drivers/s390/net/cu3088.c linux-2.6-s390/drivers/s390/net/cu3088.c
--- linux-2.6/drivers/s390/net/cu3088.c	Sat Aug 23 01:53:53 2003
+++ linux-2.6-s390/drivers/s390/net/cu3088.c	Fri Aug 29 18:55:12 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: cu3088.c,v 1.26 2003/01/17 13:46:13 cohuck Exp $
+ * $Id: cu3088.c,v 1.30 2003/08/28 11:14:11 cohuck Exp $
  *
  * CTC / LCS ccw_device driver
  *
@@ -56,7 +56,6 @@
 static struct ccw_driver cu3088_driver;
 
 struct device cu3088_root_dev = {
-	.name   = "CU3088 Devices",
 	.bus_id = "cu3088",
 };
 
@@ -79,7 +78,7 @@
 
 		if (!(end = strchr(start, delim[i])))
 			return count;
-		len = min_t(ptrdiff_t, BUS_ID_SIZE, end - start);
+		len = min_t(ptrdiff_t, BUS_ID_SIZE, end - start + 1);
 		strlcpy (bus_ids[i], start, len);
 		argv[i] = bus_ids[i];
 		start = end + 1;
diff -urN linux-2.6/drivers/s390/net/lcs.c linux-2.6-s390/drivers/s390/net/lcs.c
--- linux-2.6/drivers/s390/net/lcs.c	Sat Aug 23 01:52:19 2003
+++ linux-2.6-s390/drivers/s390/net/lcs.c	Fri Aug 29 18:55:12 2003
@@ -11,7 +11,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Martin Schwidefsky <schwidefsky@de.ibm.com>
  *
- *    $Revision: 1.53 $	 $Date: 2003/06/17 11:36:45 $
+ *    $Revision: 1.55 $	 $Date: 2003/08/28 11:14:11 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -58,7 +58,7 @@
 /**
  * initialization string for output
  */
-#define VERSION_LCS_C  "$Revision: 1.53 $"
+#define VERSION_LCS_C  "$Revision: 1.55 $"
 
 static char version[] __initdata = "LCS driver ("VERSION_LCS_C "/" VERSION_LCS_H ")";
 
@@ -1675,6 +1675,20 @@
 
 static DEVICE_ATTR(portno, 0644, lcs_portno_show, lcs_portno_store);
 
+static ssize_t
+lcs_type_show(struct device *dev, char *buf)
+{
+	struct ccwgroup_device *cgdev;
+
+	cgdev = to_ccwgroupdev(dev);
+	if (!cgdev)
+		return -ENODEV;
+
+	return sprintf(buf, "%s\n", cu3088_type[cgdev->cdev[0]->id.driver_info]);
+}
+
+static DEVICE_ATTR(type, 0444, lcs_type_show, NULL);
+
 /**
  * lcs_probe_device is called on establishing a new ccwgroup_device.
  */
@@ -1695,15 +1709,16 @@
                 return -ENOMEM;
         }
 	ret = device_create_file(&ccwgdev->dev, &dev_attr_portno);
+	if (!ret)
+		ret = device_create_file(&ccwgdev->dev, &dev_attr_type);
 	if (ret) {
                 PRINT_ERR("Creating attributes failed");
+		device_remove_file(&ccwgdev->dev, &dev_attr_portno);
 		lcs_free_card(card);
 		put_device(&ccwgdev->dev);
 		return ret;
         }
 	ccwgdev->dev.driver_data = card;
-	snprintf(ccwgdev->dev.name, DEVICE_NAME_SIZE, "%s",
-		 cu3088_type[ccwgdev->cdev[0]->id.driver_info]);
 	ccwgdev->cdev[0]->dev.driver_data = card;
 	ccwgdev->cdev[0]->handler = lcs_irq;
 	ccwgdev->cdev[1]->dev.driver_data = card;
@@ -1826,6 +1841,8 @@
 	card = (struct lcs_card *)ccwgdev->dev.driver_data;
 	if (!card)
 		return 0;
+	device_remove_file(&ccwgdev->dev, &dev_attr_type);
+	device_remove_file(&ccwgdev->dev, &dev_attr_portno);
 	lcs_cleanup_card(card);
 	lcs_free_card(card);
 	put_device(&ccwgdev->dev);
diff -urN linux-2.6/drivers/s390/net/netiucv.c linux-2.6-s390/drivers/s390/net/netiucv.c
--- linux-2.6/drivers/s390/net/netiucv.c	Sat Aug 23 01:56:36 2003
+++ linux-2.6-s390/drivers/s390/net/netiucv.c	Fri Aug 29 18:55:12 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: netiucv.c,v 1.20 2003/05/27 11:34:24 mschwide Exp $
+ * $Id: netiucv.c,v 1.22 2003/08/28 16:22:40 mschwide Exp $
  *
  * IUCV network driver
  *
@@ -30,7 +30,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: IUCV network driver $Revision: 1.20 $
+ * RELEASE-TAG: IUCV network driver $Revision: 1.22 $
  *
  */
 
@@ -128,7 +128,6 @@
 };	
 
 static struct device iucv_root = {
-	.name   = "IUCV",
 	.bus_id = "iucv",
 };
 
@@ -1255,6 +1254,16 @@
 #define CTRL_BUFSIZE 40
 
 static ssize_t
+user_show (struct device *dev, char *buf)
+{
+	struct netiucv_priv *priv = dev->driver_data;
+
+	return sprintf(buf, "%s\n", netiucv_printname(priv->conn->userid));
+}
+
+static DEVICE_ATTR(user, 0444, user_show, NULL);
+
+static ssize_t
 buffer_show (struct device *dev, char *buf)
 {
 	struct netiucv_priv *priv = dev->driver_data;
@@ -1441,6 +1450,7 @@
 	int ret = 0;
 
 	if ((ret = device_create_file(dev, &dev_attr_buffer)) ||
+	    (ret = device_create_file(dev, &dev_attr_user)) ||
 	    (ret = device_create_file(dev, &dev_attr_device_fsm_state)) ||
 	    (ret = device_create_file(dev, &dev_attr_connection_fsm_state)) ||
 	    (ret = device_create_file(dev, &dev_attr_max_tx_buffer_used)) ||
@@ -1456,6 +1466,7 @@
 		device_remove_file(dev, &dev_attr_max_tx_buffer_used);
 		device_remove_file(dev, &dev_attr_connection_fsm_state);
 		device_remove_file(dev, &dev_attr_device_fsm_state);
+		device_remove_file(dev, &dev_attr_user);
 		device_remove_file(dev, &dev_attr_buffer);
 	}
 	return ret;
@@ -1469,7 +1480,6 @@
 	int ret;
 	char *str = "netiucv";
 
-	snprintf(dev->name, DEVICE_NAME_SIZE, "%s", priv->conn->userid);
 	snprintf(dev->bus_id, BUS_ID_SIZE, "%s%x", str, ifno);
 	dev->bus = &iucv_bus;
 	dev->parent = &iucv_root;
@@ -1717,7 +1727,7 @@
 static void
 netiucv_banner(void)
 {
-	char vbuf[] = "$Revision: 1.20 $";
+	char vbuf[] = "$Revision: 1.22 $";
 	char *version = vbuf;
 
 	if ((version = strchr(version, ':'))) {
diff -urN linux-2.6/drivers/s390/net/qeth.c linux-2.6-s390/drivers/s390/net/qeth.c
--- linux-2.6/drivers/s390/net/qeth.c	Fri Aug 29 18:55:10 2003
+++ linux-2.6-s390/drivers/s390/net/qeth.c	Fri Aug 29 18:55:12 2003
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth.c ($Revision: 1.126 $)
+ * linux/drivers/s390/net/qeth.c ($Revision: 1.139 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -219,9 +219,9 @@
 /* thought I could get along without forward declarations...
  * just lazyness here */
 static int qeth_reinit_thread(void *);
-static void qeth_schedule_recovery(struct qeth_card *card);
+static inline void qeth_schedule_recovery(struct qeth_card *card);
 
-inline static int
+static inline int
 QETH_IP_VERSION(struct sk_buff *skb)
 {
 	switch (skb->protocol) {
@@ -649,10 +649,6 @@
 	case 1:
 		return 0;
 	case 4:
-		if ((card->can_do_async_iqd) &&
-		    (card->options.async_iqd == ASYNC_IQD)) {
-			return card->no_queues - 1;
-		}
 		if (card->is_multicast_different) {
 			if (multicast) {
 				return card->is_multicast_different &
@@ -1274,9 +1270,6 @@
 			goto nomem;
 	}
 
-	if (card->easy_copy_cap)
-		memcpy(skb_put(skb, length), data_ptr, length);
-
 	QETH_DBF_HEX6(0, trace, &data_ptr, sizeof (void *));
 	QETH_DBF_HEX6(0, trace, &skb, sizeof (void *));
 
@@ -1303,8 +1296,7 @@
 			dev_kfree_skb_irq(skb);
 			return NULL;
 		}
-		if (!card->easy_copy_cap)
-			memcpy(skb_put(skb, step), data_ptr, step);
+		memcpy(skb_put(skb, step), data_ptr, step);
 		len_togo -= step;
 		if (len_togo) {
 			pos_in_el = 0;
@@ -1604,11 +1596,14 @@
 #ifdef QETH_VLAN
 	struct qeth_card *card;
 
-	/* before we're going to overwrite this location with next hop ip */
+	/* 
+	 * before we're going to overwrite this location with next hop ip.
+	 * v6 uses passthrough, v4 sets the tag in the QDIO header.
+	 */
 	card = (struct qeth_card *) skb->dev->priv;
-	if ((card->vlangrp != NULL) &&
-	    vlan_tx_tag_present(skb) && (version == 4)) {
-		hdr->ext_flags = QETH_EXT_HEADER_VLAN_FRAME;
+	if ((card->vlangrp != NULL) && vlan_tx_tag_present(skb)) {
+		hdr->ext_flags = (version == 4) ? QETH_EXT_HEADER_VLAN_FRAME :
+			QETH_EXT_HEADER_INCLUDE_VLAN_TAG;
 		hdr->vlan_id = vlan_tx_tag_get(skb);
 	}
 #endif
@@ -1685,7 +1680,9 @@
 			    skb->dev->broadcast, 6)) {   /* broadcast? */
 			hdr->flags = QETH_CAST_BROADCAST | QETH_HEADER_PASSTHRU;
 		} else {
-			hdr->flags = QETH_CAST_UNICAST | QETH_HEADER_PASSTHRU;
+ 			hdr->flags = (multicast == RTN_MULTICAST) ?
+ 				QETH_CAST_MULTICAST | QETH_HEADER_PASSTHRU :
+ 				QETH_CAST_UNICAST | QETH_HEADER_PASSTHRU;
 		}
 	}
 	sprintf(dbf_text, "filhdr%2x", version);
@@ -2357,14 +2354,6 @@
 		}
 }
 
-static __inline__ int
-atomic_return_sub(int i, atomic_t * v)
-{
-	int old_val, new_val;
-	__CS_LOOP(old_val, new_val, v, i, "sr");
-	return old_val;
-}
-
 static inline void
 __qeth_dump_packet_info(struct qeth_card *card, int version, int multicast,
 			int queue)
@@ -3228,8 +3217,9 @@
 		result = IPA_REPLY_SUCCESS;
 		memcpy(((char *) (card->ioctl_data_buffer)) + sizeof (__u16),
 		       &(card->number_of_entries), sizeof (int));
-		copy_to_user(req->ifr_ifru.ifru_data,
-			     card->ioctl_data_buffer, data_size);
+		if (copy_to_user(req->ifr_ifru.ifru_data,
+			     	card->ioctl_data_buffer, data_size))
+				result = -EFAULT;
 	}
 	card->ioctl_buffer_pointer = NULL;
 	vfree(card->ioctl_data_buffer);
@@ -3297,13 +3287,17 @@
 		goto snmp_out;
 	}
 	if (result == ARP_RETURNCODE_ERROR) {
-		copy_to_user(req->ifr_ifru.ifru_data + SNMP_REQUEST_DATA_OFFSET,
-			     card->ioctl_data_buffer, card->ioctl_buffersize);
 		result = IPA_REPLY_FAILED;
+		if (copy_to_user(req->ifr_ifru.ifru_data + 
+			     SNMP_REQUEST_DATA_OFFSET, card->ioctl_data_buffer,
+			     card->ioctl_buffersize))
+			result = -EFAULT;
 	} else {
-		copy_to_user(req->ifr_ifru.ifru_data + SNMP_REQUEST_DATA_OFFSET,
-			     card->ioctl_data_buffer, card->ioctl_buffersize);
 		result = IPA_REPLY_SUCCESS;
+		if (copy_to_user(req->ifr_ifru.ifru_data +
+				 SNMP_REQUEST_DATA_OFFSET, card->ioctl_data_buffer,
+				 card->ioctl_buffersize))
+			result = -EFAULT;
 	}
 snmp_out:
 	card->number_of_entries = 0;
@@ -4388,7 +4382,8 @@
 
 #define QETH_STANDARD_RETVALS \
 		ret_val=-EIO; \
-		if (result==IPA_REPLY_SUCCESS) ret_val=0; \
+		if (result == -EFAULT) ret_val = -EFAULT; \
+                if (result==IPA_REPLY_SUCCESS) ret_val=0; \
 		if (result==IPA_REPLY_FAILED) ret_val=-EIO; \
 		if (result==IPA_REPLY_OPNOTSUPP) ret_val=-EOPNOTSUPP
 
@@ -4414,7 +4409,8 @@
 
 	if ((cmd < SIOCDEVPRIVATE) || (cmd > SIOCDEVPRIVATE + 5))
 		return -EOPNOTSUPP;
-	copy_from_user(buff, rq->ifr_ifru.ifru_data, sizeof (buff));
+	if (copy_from_user(buff, rq->ifr_ifru.ifru_data, sizeof (buff)))
+		return -EFAULT;
 	data = buff;
 
 	if ((!atomic_read(&card->is_registered)) ||
@@ -5958,7 +5954,7 @@
 	}
 }
 
-static void
+static inline void
 qeth_schedule_recovery(struct qeth_card *card)
 {
 	if (card) {
@@ -6173,8 +6169,9 @@
 		}
 	}
 
-	buffers_used = atomic_return_sub(count,
-					 &card->outbound_used_buffers[queue]);
+	buffers_used = atomic_add_return(-count,
+					 &card->outbound_used_buffers[queue])
+		       + count;
 
 	switch (card->send_state[queue]) {
 	case SEND_STATE_PACK:
@@ -6206,7 +6203,7 @@
 		PRINT_WARN("timeout on device %s\n", cdev->dev.bus_id);
 		break;
 	default:
-		PRINT_WARN("unknown error %d on device %s\n", PTR_ERR(irb),
+		PRINT_WARN("unknown error %ld on device %s\n", PTR_ERR(irb),
 			   cdev->dev.bus_id);
 	}
 	return PTR_ERR(irb);
@@ -6649,7 +6646,6 @@
 qeth_free_card(struct qeth_card *card)
 {
 	int i, j;
-	int element_count;
 	struct qeth_vipa_entry *e, *e2;
 
 	if (!card)
@@ -6669,10 +6665,8 @@
 	}
 	write_unlock(&card->vipa_list_lock);
 
-	element_count = (card->options.memusage == MEMUSAGE_DISCONTIG) ?
-	    BUFFER_MAX_ELEMENTS : 1;
 	for (i = 0; i < card->options.inbound_buffer_count; i++) {
-		for (j = 0; j < element_count; j++) {
+		for (j = 0; j < BUFFER_MAX_ELEMENTS; j++) {
 			if (card->inbound_buffer_pool_entry[i][j]) {
 				kfree(card->inbound_buffer_pool_entry[i][j]);
 				card->inbound_buffer_pool_entry[i][j] = NULL;
@@ -6904,6 +6898,8 @@
 }
 
 /* returns last four digits of bus_id */
+/* FIXME: device driver shouldn't be aware of bus_id format - but don't know
+   what else to use... (CH) */
 static inline __u16
 __raw_devno_from_bus_id(char *id)
 {
@@ -7077,7 +7073,7 @@
 	memcpy(QETH_IDX_ACT_FUNC_LEVEL(card->dma_stuff->sendbuf),
 	       &card->func_level, 2);
 
-	temp = _ccw_device_get_device_number(card->ddev);
+	temp = __raw_devno_from_bus_id(card->ddev->dev.bus_id);
 	memcpy(QETH_IDX_ACT_QDIO_DEV_CUA(card->dma_stuff->sendbuf), &temp, 2);
 	temp = (card->cula << 8) + card->unit_addr2;
 	memcpy(QETH_IDX_ACT_QDIO_DEV_REALADDR(card->dma_stuff->sendbuf),
@@ -7346,7 +7342,7 @@
 	memcpy(QETH_ULP_SETUP_FILTER_TOKEN(card->send_buf),
 	       &card->token.ulp_filter_r, QETH_MPC_TOKEN_LENGTH);
 
-	temp = _ccw_device_get_device_number(card->ddev);
+	temp = __raw_devno_from_bus_id(card->ddev->dev.bus_id);
 	memcpy(QETH_ULP_SETUP_CUA(card->send_buf), &temp, 2);
 	temp = (card->cula << 8) + card->unit_addr2;
 	memcpy(QETH_ULP_SETUP_REAL_DEVADDR(card->send_buf), &temp, 2);
@@ -8225,11 +8221,6 @@
 
 		card->dev->init = qeth_init_dev;
 
-		if (card->options.memusage == MEMUSAGE_CONTIG) {
-			card->easy_copy_cap =
-			    qeth_determine_easy_copy_cap(card->type);
-		} else
-			card->easy_copy_cap = 0;
 		card->ipa_timeout = qeth_get_ipa_timeout(card->type);
 	}
 
@@ -8493,14 +8484,12 @@
 	card->options.default_queue = QETH_DEFAULT_QUEUE;
 	card->options.inbound_buffer_count = DEFAULT_BUFFER_COUNT;
 	card->options.polltime = QETH_MAX_INPUT_THRESHOLD;
-	card->options.memusage = MEMUSAGE_DISCONTIG;
 	card->options.macaddr_mode = MACADDR_NONCANONICAL;
 	card->options.broadcast_mode = BROADCAST_ALLRINGS;
 	card->options.fake_broadcast = DONT_FAKE_BROADCAST;
 	card->options.ena_ipat = ENABLE_TAKEOVER;
 	card->options.add_hhlen = DEFAULT_ADD_HHLEN;
 	card->options.fake_ll = DONT_FAKE_LL;
-	card->options.async_iqd = SYNC_IQD;
 }
 
 static struct qeth_card *
@@ -8635,66 +8624,41 @@
 qeth_init_ringbuffers2(struct qeth_card *card)
 {
 	int i, j;
-	int failed = 0;
-	int discont_mem, element_count;
-	long alloc_size;
 
 	QETH_DBF_TEXT3(0, trace, "irb2");
 	QETH_DBF_TEXT3(0, trace, card->rdev->dev.bus_id);
 
-	discont_mem = (card->options.memusage == MEMUSAGE_DISCONTIG);
-	element_count = (discont_mem) ? BUFFER_MAX_ELEMENTS : 1;
-	alloc_size = (discont_mem) ? PAGE_SIZE : BUFFER_SIZE;
-	if (discont_mem) {
-		for (i = 0; i < card->options.inbound_buffer_count; i++) {
-			for (j = 0; j < element_count; j++) {
-				card->inbound_buffer_pool_entry[i][j] =
-				    kmalloc(alloc_size, GFP_KERNEL);
-				if (!card->inbound_buffer_pool_entry[i][j]) {
-					failed = 1;
-					goto out;
-				}
+	for (i = 0; i < card->options.inbound_buffer_count; i++) {
+		for (j = 0; j < BUFFER_MAX_ELEMENTS; j++) {
+			card->inbound_buffer_pool_entry[i][j] =
+				kmalloc(PAGE_SIZE, GFP_KERNEL);
+			if (!card->inbound_buffer_pool_entry[i][j]) {
+				goto out;
 			}
-			card->inbound_buffer_pool_entry_used[i] = BUFFER_UNUSED;
-		}
-	} else {
-		for (i = 0; i < card->options.inbound_buffer_count; i++) {
-			card->inbound_buffer_pool_entry[i][0] =
-			    kmalloc(alloc_size, GFP_KERNEL);
-			if (!card->inbound_buffer_pool_entry[i][0])
-				failed = 1;
-			for (j = 1; j < element_count; j++)
-				card->inbound_buffer_pool_entry[i][j] =
-				    card->inbound_buffer_pool_entry[i][0] +
-				    PAGE_SIZE * j;
-			card->inbound_buffer_pool_entry_used[i] = BUFFER_UNUSED;
 		}
+		card->inbound_buffer_pool_entry_used[i] = BUFFER_UNUSED;
 	}
 
+	spin_lock_init(&card->requeue_input_lock);
+
+	return 0;
 out:
-	if (failed) {
-		for (i = 0; i < card->options.inbound_buffer_count; i++) {
-			for (j = 0; j < QDIO_MAX_ELEMENTS_PER_BUFFER; j++) {
-				if (card->inbound_buffer_pool_entry[i][j]) {
-					if (j < element_count)
-						kfree(card->
-						      inbound_buffer_pool_entry
-						      [i][j]);
-					card->inbound_buffer_pool_entry
-					    [i][j] = NULL;
-				}
+	for (i = 0; i < card->options.inbound_buffer_count; i++) {
+		for (j = 0; j < QDIO_MAX_ELEMENTS_PER_BUFFER; j++) {
+			if (card->inbound_buffer_pool_entry[i][j]) {
+				if (j < BUFFER_MAX_ELEMENTS)
+					kfree(card->
+					      inbound_buffer_pool_entry[i][j]);
+				card->inbound_buffer_pool_entry[i][j] = NULL;
 			}
 		}
-		for (i = 0; i < card->no_queues; i++) {
-			vfree(card->outbound_ringbuffer[i]);
-			card->outbound_ringbuffer[i] = NULL;
-		}
-		return -ENOMEM;
 	}
+	for (i = 0; i < card->no_queues; i++) {
+		vfree(card->outbound_ringbuffer[i]);
+		card->outbound_ringbuffer[i] = NULL;
+	}
+	return -ENOMEM;
 
-	spin_lock_init(&card->requeue_input_lock);
-
-	return 0;
 }
 
 /* also locked from outside (setup_lock) */
@@ -9093,11 +9057,11 @@
 	length += sprintf(buffer + length,
 			  "devices            CHPID     "
 			  "device     cardtype port chksum prio-q'ing "
-			  "rtr fsz C cnt\n");
+			  "rtr fsz cnt\n");
 	length += sprintf(buffer + length,
 			  "-------------------- --- ----"
 			  "------ -------------- --     -- ---------- "
-			  "--- --- - ---\n");
+			  "--- --- ---\n");
 	card = firstcard;
 	while (card) {
 		strcpy(checksum_str,
@@ -9213,7 +9177,7 @@
 		} else {
 			length += sprintf(buffer + length,
 					  "%s/%s/%s x%02X %10s %14s %2i"
-					  "     %2s %10s %3s %3s %c %3i\n",
+					  "     %2s %10s %3s %3s %3i\n",
 					  card->rdev->dev.bus_id,
 					  card->wdev->dev.bus_id,
 					  card->ddev->dev.bus_id,
@@ -9223,8 +9187,6 @@
 					   card->is_guest_lan),
 					  card->options.portno, checksum_str,
 					  queueing_str, router_str, bufsize_str,
-					  (card->options.memusage ==
-					   MEMUSAGE_CONTIG) ? 'c' : ' ',
 					  card->options.inbound_buffer_count);
 		}
 		card = card->next;
@@ -9663,7 +9625,8 @@
 	qeth_version = 0;
 	number_of_devices = 0;
 
-	copy_from_user((void *) parms, (void *) arg, sizeof (parms));
+	if (copy_from_user((void *) parms, (void *) arg, sizeof (parms)))
+		return -EFAULT;
 	memcpy(&data_size, parms, sizeof (__u32));
 
 	if (!(data_size > 0))
@@ -9726,7 +9689,8 @@
 	       sizeof (__u32));
 	memcpy(((char *) buffer_pointer) + (3 * sizeof (__u32)),
 	       &number_of_devices, sizeof (__u32));
-	copy_to_user((char *) arg, buffer, data_len);
+	if (copy_to_user((char *) arg, buffer, data_len))
+		result = -EFAULT;
 	vfree(buffer);
 out:
 	read_unlock(&list_lock);
@@ -10018,7 +9982,6 @@
 };
 
 static struct device qeth_root_dev = {
-	.name = "QETH Devices",
 	.bus_id = "qeth",
 };
 
@@ -10468,44 +10431,6 @@
 static DEVICE_ATTR(portno, 0644, qeth_portno_show, qeth_portno_store);
 
 static ssize_t
-qeth_contig_show(struct device *dev, char *buf)
-{
-	struct qeth_card *card = dev->driver_data;
-
-	if (!card)
-		return -EINVAL;
-
-	return sprintf(buf, "%s\n",
-		       (card->options.memusage == MEMUSAGE_CONTIG)?"yes":"no");
-}
-
-static ssize_t
-qeth_contig_store(struct device *dev, const char *buf, size_t count)
-{
-	struct qeth_card *card = dev->driver_data;
-	int i;
-	char *tmp;
-
-	if (!card)
-		return count;
-
-	if (atomic_read(&card->is_hardsetup))
-		return -EPERM;
-
-	i = simple_strtoul(buf, &tmp, 16);
-	if (i == 0)
-		card->options.memusage = MEMUSAGE_DISCONTIG;
-	else if (i == 1)
-		card->options.memusage = MEMUSAGE_CONTIG;
-	else
-		return -EINVAL;
-
-	return count;
-}
-
-static DEVICE_ATTR(contig, 0644, qeth_contig_show, qeth_contig_store);
-
-static ssize_t
 qeth_polltime_show(struct device *dev, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
@@ -10730,44 +10655,6 @@
 static DEVICE_ATTR(fake_ll, 0644, qeth_fakell_show, qeth_fakell_store);
 
 static ssize_t
-qeth_hsi_show(struct device *dev, char *buf)
-{
-	struct qeth_card *card = dev->driver_data;
-
-	if (!card)
-		return -EINVAL;
-
-	return sprintf(buf, "%s\n",
-		       (card->options.async_iqd == ASYNC_IQD)?"async":"sync");
-}
-
-static ssize_t
-qeth_hsi_store(struct device *dev, const char *buf, size_t count)
-{
-	struct qeth_card *card = dev->driver_data;
-	int i;
-	char *tmp;
-
-	if (!card)
-		return count;
-
-	if (atomic_read(&card->is_hardsetup))
-		return -EPERM;
-
-	i = simple_strtoul(buf, &tmp, 16);
-	if (i == 0)
-		card->options.async_iqd = SYNC_IQD;
-	else if (i == 1)
-		card->options.async_iqd = ASYNC_IQD;
-	else
-		return -EINVAL;
-
-	return count;
-}
-
-static DEVICE_ATTR(async_hsi, 0644, qeth_hsi_show, qeth_hsi_store);
-
-static ssize_t
 qeth_broadcast_show(struct device *dev, char *buf)
 {
 	struct qeth_card *card = dev->driver_data;
@@ -10831,6 +10718,24 @@
 
 static DEVICE_ATTR(recover, 0200, 0, qeth_recover_store);
 
+static ssize_t
+qeth_card_type_show(struct device *dev, char *buf)
+{
+	struct qeth_card *card = dev->driver_data;
+
+	if (!card)
+		return -EINVAL;
+
+	if (!atomic_read(&card->is_softsetup))
+		return sprintf(buf, "n/a\n");
+
+	return sprintf(buf, "%s\n",
+		       qeth_get_cardname_short(card->type, card->link_type,
+					       card->is_guest_lan));
+}
+
+static DEVICE_ATTR(card_type, 0444, qeth_card_type_show, NULL);
+
 static inline int
 __qeth_create_attributes(struct device *dev)
 {
@@ -10864,10 +10769,6 @@
 	if (ret != 0)
 		goto out_noportno;
 
-	ret = device_create_file(dev, &dev_attr_contig);
-	if (ret != 0)
-		goto out_nocontig;
-
 	ret = device_create_file(dev, &dev_attr_polltime);
 	if (ret != 0)
 		goto out_nopolltime;
@@ -10892,10 +10793,6 @@
 	if (ret != 0)
 		goto out_nofakell;
 
-	ret = device_create_file(dev, &dev_attr_async_hsi);
-	if (ret != 0)
-		goto out_nohsi;
-
 	ret = device_create_file(dev, &dev_attr_broadcast_mode);
 	if (ret != 0)
 		goto out_nobrmode;
@@ -10904,13 +10801,16 @@
 	if (ret != 0)
 		goto out_norecover;
 
-	return 0;
+	ret = device_create_file(dev, &dev_attr_card_type);
+	if (ret != 0)
+		goto out_nocardtype;
 
+	return 0;
+out_nocardtype:
+	device_remove_file(dev, &dev_attr_card_type);
 out_norecover:
 	device_remove_file(dev, &dev_attr_broadcast_mode);
 out_nobrmode:
-	device_remove_file(dev, &dev_attr_async_hsi);
-out_nohsi:
 	device_remove_file(dev, &dev_attr_fake_ll);
 out_nofakell:
 	device_remove_file(dev, &dev_attr_fake_broadcast);
@@ -10923,8 +10823,6 @@
 out_nohhlen:
 	device_remove_file(dev, &dev_attr_polltime);
 out_nopolltime:
-	device_remove_file(dev, &dev_attr_contig);
-out_nocontig:
 	device_remove_file(dev, &dev_attr_portno);
 out_noportno:
 	device_remove_file(dev, &dev_attr_priority_queueing);
@@ -10975,7 +10873,6 @@
 	if (ret != 0)
 		goto out;
 
-	snprintf(gdev->dev.name, DEVICE_NAME_SIZE, "qeth device");
 	return 0;
 out:
 	put_device(&gdev->dev);
@@ -11063,7 +10960,7 @@
 
 	gdev->dev.driver_data = NULL;
 	if (card)
-		kfree(card);
+		qeth_free_card(card);
 	put_device(&gdev->dev);
 	return 0;
 }
@@ -11072,16 +10969,11 @@
 qeth_set_online(struct ccwgroup_device *gdev)
 {
 	struct qeth_card *card = gdev->dev.driver_data;
-	int ret;
 
 	BUG_ON(!card);
 
-	ret = qeth_activate(card);
-	if (ret == 0)
-		snprintf(gdev->dev.name, DEVICE_NAME_SIZE, "%s",
-			 qeth_get_cardname_short(card->type, card->link_type,
-						 card->is_guest_lan));
-	return ret;
+	return qeth_activate(card);
+
 }
 
 static int
diff -urN linux-2.6/drivers/s390/net/qeth.h linux-2.6-s390/drivers/s390/net/qeth.h
--- linux-2.6/drivers/s390/net/qeth.h	Sat Aug 23 01:50:56 2003
+++ linux-2.6-s390/drivers/s390/net/qeth.h	Fri Aug 29 18:55:12 2003
@@ -14,7 +14,7 @@
 
 #define QETH_NAME " qeth"
 
-#define VERSION_QETH_H "$Revision: 1.49 $"
+#define VERSION_QETH_H "$Revision: 1.51 $"
 
 /******************** CONFIG STUFF ***********************/
 //#define QETH_DBF_LIKE_HELL
@@ -647,8 +647,6 @@
 #define BROADCAST_LOCAL 1
 #define MACADDR_NONCANONICAL 0
 #define MACADDR_CANONICAL 1
-#define MEMUSAGE_DISCONTIG 0
-#define MEMUSAGE_CONTIG 1
 #define ENABLE_TAKEOVER 0
 #define DISABLE_TAKEOVER 1
 #define FAKE_BROADCAST 0
@@ -656,8 +654,6 @@
 
 #define FAKE_LL 0
 #define DONT_FAKE_LL 1
-#define SYNC_IQD 0
-#define ASYNC_IQD 1
 
 #define QETH_BREAKOUT_LEAVE 1
 #define QETH_BREAKOUT_AGAIN 2
@@ -744,14 +740,12 @@
 	int polltime;
 	char portname[9];
 	int portno;
-	int memusage;
 	int broadcast_mode;
 	int macaddr_mode;
 	int ena_ipat;
 	int fake_broadcast;
 	int add_hhlen;
 	int fake_ll;
-	int async_iqd;
 };
 
 struct qeth_hdr {
@@ -811,7 +805,6 @@
 
 /* ugly. I know. */
 struct qeth_card {	/* pointed to by dev->priv */
-	int easy_copy_cap;
 
 	/* pointer to options (defaults + parameters) */
 	struct qeth_card_options options;
@@ -930,8 +923,6 @@
 	int is_multicast_different;	/* if multicast traffic is to be sent
 					   on a different queue, this is the
 					   queue+no_queues */
-	int can_do_async_iqd;	/* 1 only on IQD that provides async
-				   unicast sigas */
 	__u32 ipa_supported;
 	__u32 ipa_enabled;
 	__u32 ipa6_supported;
@@ -1034,21 +1025,6 @@
 	}
 }
 
-inline static int
-qeth_determine_easy_copy_cap(int cardtype)
-{
-	switch (cardtype) {
-	case QETH_CARD_TYPE_UNKNOWN:
-		return 0;	/* better be cautious */
-	case QETH_CARD_TYPE_OSAE:
-		return 1;
-	case QETH_CARD_TYPE_IQD:
-		return 0;
-	default:
-		return 0;	/* ?? */
-	}
-}
-
 inline static __u8
 qeth_get_adapter_type_for_ipa(int link_type)
 {
