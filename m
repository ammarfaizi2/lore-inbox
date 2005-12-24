Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbVLXPOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbVLXPOZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 10:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbVLXPOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 10:14:25 -0500
Received: from havoc.gtf.org ([69.61.125.42]:170 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751240AbVLXPOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 10:14:22 -0500
Date: Sat, 24 Dec 2005 10:14:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] net driver fixes
Message-ID: <20051224151422.GA16855@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git

to receive the following updates:

 drivers/net/phy/phy_device.c          |    4 
 drivers/net/wireless/orinoco_nortel.c |    6 
 drivers/s390/net/qeth_eddp.c          |    3 
 drivers/s390/net/qeth_main.c          |   61 +++-----
 drivers/s390/net/qeth_mpc.c           |    2 
 drivers/s390/net/qeth_mpc.h           |    4 
 drivers/s390/net/qeth_proc.c          |  250 +++-------------------------------
 drivers/s390/net/qeth_sys.c           |    6 
 drivers/s390/net/qeth_tso.h           |    4 
 9 files changed, 77 insertions(+), 263 deletions(-)

Frank Pavlic:
      s390: some minor qeth driver fixes
      s390: minor qeth network driver fixes
      s390: remove redundant and useless code in qeth

Olaf Hering:
      missing license for libphy.ko

Pavel Roskin:
      orinoco_nortel: Fix incorrect PCI resource use
      orinoco_nortel: Add Symbol LA-4123 ID

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 16bebe7..7da0e3d 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -38,6 +38,10 @@
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 
+MODULE_DESCRIPTION("PHY library");
+MODULE_AUTHOR("Andy Fleming");
+MODULE_LICENSE("GPL");
+
 static struct phy_driver genphy_driver;
 extern int mdio_bus_init(void);
 extern void mdio_bus_exit(void);
diff --git a/drivers/net/wireless/orinoco_nortel.c b/drivers/net/wireless/orinoco_nortel.c
index d8afd51..d1a670b 100644
--- a/drivers/net/wireless/orinoco_nortel.c
+++ b/drivers/net/wireless/orinoco_nortel.c
@@ -1,6 +1,8 @@
 /* orinoco_nortel.c
  * 
  * Driver for Prism II devices which would usually be driven by orinoco_cs,
+ * but are connected to the PCI bus by a PCI-to-PCMCIA adapter used in
+ * Nortel emobility, Symbol LA-4113 and Symbol LA-4123.
  * but are connected to the PCI bus by a Nortel PCI-PCMCIA-Adapter. 
  *
  * Copyright (C) 2002 Tobias Hoffmann
@@ -165,7 +167,7 @@ static int nortel_pci_init_one(struct pc
 		goto fail_resources;
 	}
 
-	iomem = pci_iomap(pdev, 3, 0);
+	iomem = pci_iomap(pdev, 2, 0);
 	if (!iomem) {
 		err = -ENOMEM;
 		goto fail_map_io;
@@ -265,6 +267,8 @@ static void __devexit nortel_pci_remove_
 static struct pci_device_id nortel_pci_id_table[] = {
 	/* Nortel emobility PCI */
 	{0x126c, 0x8030, PCI_ANY_ID, PCI_ANY_ID,},
+	/* Symbol LA-4123 PCI */
+	{0x1562, 0x0001, PCI_ANY_ID, PCI_ANY_ID,},
 	{0,},
 };
 
diff --git a/drivers/s390/net/qeth_eddp.c b/drivers/s390/net/qeth_eddp.c
index 011915d..f94f1f2 100644
--- a/drivers/s390/net/qeth_eddp.c
+++ b/drivers/s390/net/qeth_eddp.c
@@ -62,7 +62,8 @@ qeth_eddp_free_context(struct qeth_eddp_
 	for (i = 0; i < ctx->num_pages; ++i)
 		free_page((unsigned long)ctx->pages[i]);
 	kfree(ctx->pages);
-	kfree(ctx->elements);
+	if (ctx->elements != NULL)
+		kfree(ctx->elements);
 	kfree(ctx);
 }
 
diff --git a/drivers/s390/net/qeth_main.c b/drivers/s390/net/qeth_main.c
index 99cceb2..f8f55cc 100644
--- a/drivers/s390/net/qeth_main.c
+++ b/drivers/s390/net/qeth_main.c
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_main.c ($Revision: 1.242 $)
+ * linux/drivers/s390/net/qeth_main.c ($Revision: 1.251 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  *
@@ -12,7 +12,7 @@
  *			  Frank Pavlic (fpavlic@de.ibm.com) and
  *		 	  Thomas Spatzier <tspat@de.ibm.com>
  *
- *    $Revision: 1.242 $	 $Date: 2005/05/04 20:19:18 $
+ *    $Revision: 1.251 $	 $Date: 2005/05/04 20:19:18 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -72,7 +72,7 @@
 #include "qeth_eddp.h"
 #include "qeth_tso.h"
 
-#define VERSION_QETH_C "$Revision: 1.242 $"
+#define VERSION_QETH_C "$Revision: 1.251 $"
 static const char *version = "qeth S/390 OSA-Express driver";
 
 /**
@@ -518,7 +518,8 @@ __qeth_set_offline(struct ccwgroup_devic
 
 	QETH_DBF_TEXT(setup, 3, "setoffl");
 	QETH_DBF_HEX(setup, 3, &card, sizeof(void *));
-
+	
+	netif_carrier_off(card->dev);
 	recover_flag = card->state;
 	if (qeth_stop_card(card, recovery_mode) == -ERESTARTSYS){
 		PRINT_WARN("Stopping card %s interrupted by user!\n",
@@ -1020,7 +1021,6 @@ void
 qeth_schedule_recovery(struct qeth_card *card)
 {
 	QETH_DBF_TEXT(trace,2,"startrec");
-
 	if (qeth_set_thread_start_bit(card, QETH_RECOVER_THREAD) == 0)
 		schedule_work(&card->kernel_thread_starter);
 }
@@ -1710,7 +1710,6 @@ qeth_check_ipa_data(struct qeth_card *ca
 					   "IP address reset.\n",
 					   QETH_CARD_IFNAME(card),
 					   card->info.chpid);
-				netif_carrier_on(card->dev);
 				qeth_schedule_recovery(card);
 				return NULL;
 			case IPA_CMD_MODCCID:
@@ -1959,7 +1958,7 @@ qeth_osn_send_ipa_cmd(struct qeth_card *
 {
 	u16 s1, s2;
 
-QETH_DBF_TEXT(trace,4,"osndipa");
+	QETH_DBF_TEXT(trace,4,"osndipa");
 
 	qeth_prepare_ipa_cmd(card, iob, QETH_PROT_OSN2);
 	s1 = (u16)(IPA_PDU_HEADER_SIZE + data_len);
@@ -2203,24 +2202,21 @@ qeth_ulp_setup(struct qeth_card *card)
 }
 
 static inline int
-qeth_check_for_inbound_error(struct qeth_qdio_buffer *buf,
-			     unsigned int qdio_error,
-			     unsigned int siga_error)
+qeth_check_qdio_errors(struct qdio_buffer *buf, unsigned int qdio_error,
+		       unsigned int siga_error, const char *dbftext)
 {
-	int rc = 0;
-
 	if (qdio_error || siga_error) {
-		QETH_DBF_TEXT(trace, 2, "qdinerr");
-		QETH_DBF_TEXT(qerr, 2, "qdinerr");
+		QETH_DBF_TEXT(trace, 2, dbftext);
+		QETH_DBF_TEXT(qerr, 2, dbftext);
 		QETH_DBF_TEXT_(qerr, 2, " F15=%02X",
-			       buf->buffer->element[15].flags & 0xff);
+			       buf->element[15].flags & 0xff);
 		QETH_DBF_TEXT_(qerr, 2, " F14=%02X",
-			       buf->buffer->element[14].flags & 0xff);
+			       buf->element[14].flags & 0xff);
 		QETH_DBF_TEXT_(qerr, 2, " qerr=%X", qdio_error);
 		QETH_DBF_TEXT_(qerr, 2, " serr=%X", siga_error);
-		rc = 1;
+		return 1;
 	}
-	return rc;
+	return 0;
 }
 
 static inline struct sk_buff *
@@ -2769,8 +2765,9 @@ qeth_qdio_input_handler(struct ccw_devic
 	for (i = first_element; i < (first_element + count); ++i) {
 		index = i % QDIO_MAX_BUFFERS_PER_Q;
 		buffer = &card->qdio.in_q->bufs[index];
-		if (!((status == QDIO_STATUS_LOOK_FOR_ERROR) &&
-		      qeth_check_for_inbound_error(buffer, qdio_err, siga_err)))
+		if (!((status & QDIO_STATUS_LOOK_FOR_ERROR) &&
+		      qeth_check_qdio_errors(buffer->buffer, 
+					     qdio_err, siga_err,"qinerr")))
 			qeth_process_inbound_buffer(card, buffer, index);
 		/* clear buffer and give back to hardware */
 		qeth_put_buffer_pool_entry(card, buffer->pool_entry);
@@ -2785,12 +2782,13 @@ qeth_qdio_input_handler(struct ccw_devic
 static inline int
 qeth_handle_send_error(struct qeth_card *card,
 		       struct qeth_qdio_out_buffer *buffer,
-		       int qdio_err, int siga_err)
+		       unsigned int qdio_err, unsigned int siga_err)
 {
 	int sbalf15 = buffer->buffer->element[15].flags & 0xff;
 	int cc = siga_err & 3;
 
 	QETH_DBF_TEXT(trace, 6, "hdsnderr");
+	qeth_check_qdio_errors(buffer->buffer, qdio_err, siga_err, "qouterr");
 	switch (cc) {
 	case 0:
 		if (qdio_err){
@@ -3047,7 +3045,8 @@ qeth_qdio_output_handler(struct ccw_devi
 	for(i = first_element; i < (first_element + count); ++i){
 		buffer = &queue->bufs[i % QDIO_MAX_BUFFERS_PER_Q];
 		/*we only handle the KICK_IT error by doing a recovery */
-		if (qeth_handle_send_error(card, buffer, qdio_error, siga_error)
+		if (qeth_handle_send_error(card, buffer,
+					   qdio_error, siga_error)
 				== QETH_SEND_ERROR_KICK_IT){
 			netif_stop_queue(card->dev);
 			qeth_schedule_recovery(card);
@@ -3289,7 +3288,6 @@ qeth_init_qdio_info(struct qeth_card *ca
 	card->qdio.in_buf_pool.buf_count = card->qdio.init_pool.buf_count;
 	INIT_LIST_HEAD(&card->qdio.in_buf_pool.entry_list);
 	INIT_LIST_HEAD(&card->qdio.init_pool.entry_list);
-	/* outbound */
 }
 
 static int
@@ -3731,6 +3729,9 @@ qeth_verify_vlan_dev(struct net_device *
 			break;
 		}
 	}
+	if (rc && !(VLAN_DEV_INFO(dev)->real_dev->priv == (void *)card))
+		return 0;
+
 #endif
 	return rc;
 }
@@ -3807,10 +3808,8 @@ qeth_open(struct net_device *dev)
 	card->data.state = CH_STATE_UP;
 	card->state = CARD_STATE_UP;
 
-	if (!card->lan_online){
-		if (netif_carrier_ok(dev))
-			netif_carrier_off(dev);
-	}
+	if (!card->lan_online && netif_carrier_ok(dev))
+		netif_carrier_off(dev);
 	return 0;
 }
 
@@ -5870,10 +5869,8 @@ qeth_add_multicast_ipv6(struct qeth_card
 	struct inet6_dev *in6_dev;
 
 	QETH_DBF_TEXT(trace,4,"chkmcv6");
-	if ((card->options.layer2 == 0) &&
-	    (!qeth_is_supported(card, IPA_IPV6)) )
+	if (!qeth_is_supported(card, IPA_IPV6)) 
 		return ;
-
 	in6_dev = in6_dev_get(card->dev);
 	if (in6_dev == NULL)
 		return;
@@ -7936,8 +7933,8 @@ __qeth_set_online(struct ccwgroup_device
 		QETH_DBF_TEXT_(setup, 2, "6err%d", rc);
 		goto out_remove;
 	}
-/*maybe it was set offline without ifconfig down
- * we can also use this state for recovery purposes*/
+	netif_carrier_on(card->dev);
+
 	qeth_set_allowed_threads(card, 0xffffffff, 0);
 	if (recover_flag == CARD_STATE_RECOVER)
 		qeth_start_again(card, recovery_mode);
diff --git a/drivers/s390/net/qeth_mpc.c b/drivers/s390/net/qeth_mpc.c
index f0a080a..5f8754a 100644
--- a/drivers/s390/net/qeth_mpc.c
+++ b/drivers/s390/net/qeth_mpc.c
@@ -11,7 +11,7 @@
 #include <asm/cio.h>
 #include "qeth_mpc.h"
 
-const char *VERSION_QETH_MPC_C = "$Revision: 1.12 $";
+const char *VERSION_QETH_MPC_C = "$Revision: 1.13 $";
 
 unsigned char IDX_ACTIVATE_READ[]={
 	0x00,0x00,0x80,0x00, 0x00,0x00,0x00,0x00,
diff --git a/drivers/s390/net/qeth_mpc.h b/drivers/s390/net/qeth_mpc.h
index 5f71486..864cec5 100644
--- a/drivers/s390/net/qeth_mpc.h
+++ b/drivers/s390/net/qeth_mpc.h
@@ -14,14 +14,14 @@
 
 #include <asm/qeth.h>
 
-#define VERSION_QETH_MPC_H "$Revision: 1.44 $"
+#define VERSION_QETH_MPC_H "$Revision: 1.46 $"
 
 extern const char *VERSION_QETH_MPC_C;
 
 #define IPA_PDU_HEADER_SIZE	0x40
 #define QETH_IPA_PDU_LEN_TOTAL(buffer) (buffer+0x0e)
 #define QETH_IPA_PDU_LEN_PDU1(buffer) (buffer+0x26)
-#define QETH_IPA_PDU_LEN_PDU2(buffer) (buffer+0x2a)
+#define QETH_IPA_PDU_LEN_PDU2(buffer) (buffer+0x29)
 #define QETH_IPA_PDU_LEN_PDU3(buffer) (buffer+0x3a)
 
 extern unsigned char IPA_PDU_HEADER[];
diff --git a/drivers/s390/net/qeth_proc.c b/drivers/s390/net/qeth_proc.c
index f2ccfea..7bf3509 100644
--- a/drivers/s390/net/qeth_proc.c
+++ b/drivers/s390/net/qeth_proc.c
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_fs.c ($Revision: 1.13 $)
+ * linux/drivers/s390/net/qeth_fs.c ($Revision: 1.16 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  * This file contains code related to procfs.
@@ -21,7 +21,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-const char *VERSION_QETH_PROC_C = "$Revision: 1.13 $";
+const char *VERSION_QETH_PROC_C = "$Revision: 1.16 $";
 
 /***** /proc/qeth *****/
 #define QETH_PROCFILE_NAME "qeth"
@@ -30,30 +30,26 @@ static struct proc_dir_entry *qeth_procf
 static int
 qeth_procfile_seq_match(struct device *dev, void *data)
 {
-	return 1;
+	return(dev ? 1 : 0);
 }
 
 static void *
 qeth_procfile_seq_start(struct seq_file *s, loff_t *offset)
 {
-	struct device *dev;
-	loff_t nr;
-
+	struct device *dev = NULL;
+	loff_t nr = 0;
+	
 	down_read(&qeth_ccwgroup_driver.driver.bus->subsys.rwsem);
-
-	nr = *offset;
-	if (nr == 0)
+	if (*offset == 0)
 		return SEQ_START_TOKEN;
-
-	dev = driver_find_device(&qeth_ccwgroup_driver.driver, NULL,
-				 NULL, qeth_procfile_seq_match);
-
-	/* get card at pos *offset */
-	nr = *offset;
-	while (nr-- > 1 && dev)
+	while (1) {
 		dev = driver_find_device(&qeth_ccwgroup_driver.driver, dev,
 					 NULL, qeth_procfile_seq_match);
-	return (void *) dev;
+		if (++nr == *offset)
+			break;
+		put_device(dev);
+	}
+	return dev;
 }
 
 static void
@@ -66,19 +62,14 @@ static void *
 qeth_procfile_seq_next(struct seq_file *s, void *it, loff_t *offset)
 {
 	struct device *prev, *next;
-
-	if (it == SEQ_START_TOKEN) {
-		next = driver_find_device(&qeth_ccwgroup_driver.driver,
-					  NULL, NULL, qeth_procfile_seq_match);
-		if (next)
-			(*offset)++;
-		return (void *) next;
-	}
-	prev = (struct device *) it;
+	
+	if (it == SEQ_START_TOKEN) 
+		prev = NULL;
+	else
+		prev = (struct device *) it;
 	next = driver_find_device(&qeth_ccwgroup_driver.driver,
 				  prev, NULL, qeth_procfile_seq_match);
-	if (next)
-		(*offset)++;
+	(*offset)++;
 	return (void *) next;
 }
 
@@ -87,7 +78,7 @@ qeth_get_router_str(struct qeth_card *ca
 {
 	int routing_type = 0;
 
-	if (ipv == 4){
+	if (ipv == 4) {
 		routing_type = card->options.route4.type;
 	} else {
 #ifdef CONFIG_QETH_IPV6
@@ -154,6 +145,7 @@ qeth_procfile_seq_show(struct seq_file *
 					card->qdio.in_buf_pool.buf_count);
 		else
 			seq_printf(s, "  +++ LAN OFFLINE +++\n");
+		put_device(device);
 	}
 	return 0;
 }
@@ -184,51 +176,16 @@ static struct file_operations qeth_procf
 static struct proc_dir_entry *qeth_perf_procfile;
 
 #ifdef CONFIG_QETH_PERF_STATS
-
-static void *
-qeth_perf_procfile_seq_start(struct seq_file *s, loff_t *offset)
-{
-	struct device *dev = NULL;
-	int nr;
-
-	down_read(&qeth_ccwgroup_driver.driver.bus->subsys.rwsem);
-	/* get card at pos *offset */
-	dev = driver_find_device(&qeth_ccwgroup_driver.driver, NULL, NULL,
-				 qeth_procfile_seq_match);
-
-	/* get card at pos *offset */
-	nr = *offset;
-	while (nr-- > 1 && dev)
-		dev = driver_find_device(&qeth_ccwgroup_driver.driver, dev,
-					 NULL, qeth_procfile_seq_match);
-	return (void *) dev;
-}
-
-static void
-qeth_perf_procfile_seq_stop(struct seq_file *s, void* it)
-{
-	up_read(&qeth_ccwgroup_driver.driver.bus->subsys.rwsem);
-}
-
-static void *
-qeth_perf_procfile_seq_next(struct seq_file *s, void *it, loff_t *offset)
-{
-	struct device *prev, *next;
-
-	prev = (struct device *) it;
-	next = driver_find_device(&qeth_ccwgroup_driver.driver, prev,
-				  NULL, qeth_procfile_seq_match);
-	if (next)
-		(*offset)++;
-	return (void *) next;
-}
-
 static int
 qeth_perf_procfile_seq_show(struct seq_file *s, void *it)
 {
 	struct device *device;
 	struct qeth_card *card;
 
+	
+	if (it == SEQ_START_TOKEN)
+		return 0;
+
 	device = (struct device *) it;
 	card = device->driver_data;
 	seq_printf(s, "For card with devnos %s/%s/%s (%s):\n",
@@ -295,13 +252,14 @@ qeth_perf_procfile_seq_show(struct seq_f
 		        card->perf_stats.outbound_do_qdio_time,
 			card->perf_stats.outbound_do_qdio_cnt
 		  );
+	put_device(device);
 	return 0;
 }
 
 static struct seq_operations qeth_perf_procfile_seq_ops = {
-	.start = qeth_perf_procfile_seq_start,
-	.stop  = qeth_perf_procfile_seq_stop,
-	.next  = qeth_perf_procfile_seq_next,
+	.start = qeth_procfile_seq_start,
+	.stop  = qeth_procfile_seq_stop,
+	.next  = qeth_procfile_seq_next,
 	.show  = qeth_perf_procfile_seq_show,
 };
 
@@ -324,93 +282,6 @@ static struct file_operations qeth_perf_
 #define qeth_perf_procfile_created 1
 #endif /* CONFIG_QETH_PERF_STATS */
 
-/***** /proc/qeth_ipa_takeover *****/
-#define QETH_IPATO_PROCFILE_NAME "qeth_ipa_takeover"
-static struct proc_dir_entry *qeth_ipato_procfile;
-
-static void *
-qeth_ipato_procfile_seq_start(struct seq_file *s, loff_t *offset)
-{
-	struct device *dev;
-	loff_t nr;
-
-	down_read(&qeth_ccwgroup_driver.driver.bus->subsys.rwsem);
-	/* TODO: finish this */
-	/*
-	 * maybe SEQ_SATRT_TOKEN can be returned for offset 0
-	 * output driver settings then;
-	 * else output setting for respective card
-	 */
-
-	dev = driver_find_device(&qeth_ccwgroup_driver.driver, NULL, NULL,
-				 qeth_procfile_seq_match);
-
-	/* get card at pos *offset */
-	nr = *offset;
-	while (nr-- > 1 && dev)
-		dev = driver_find_device(&qeth_ccwgroup_driver.driver, dev,
-					 NULL, qeth_procfile_seq_match);
-	return (void *) dev;
-}
-
-static void
-qeth_ipato_procfile_seq_stop(struct seq_file *s, void* it)
-{
-	up_read(&qeth_ccwgroup_driver.driver.bus->subsys.rwsem);
-}
-
-static void *
-qeth_ipato_procfile_seq_next(struct seq_file *s, void *it, loff_t *offset)
-{
-	struct device *prev, *next;
-
-	prev = (struct device *) it;
-	next = driver_find_device(&qeth_ccwgroup_driver.driver, prev,
-				  NULL, qeth_procfile_seq_match);
-	if (next)
-		(*offset)++;
-	return (void *) next;
-}
-
-static int
-qeth_ipato_procfile_seq_show(struct seq_file *s, void *it)
-{
-	struct device *device;
-	struct qeth_card *card;
-
-	/* TODO: finish this */
-	/*
-	 * maybe SEQ_SATRT_TOKEN can be returned for offset 0
-	 * output driver settings then;
-	 * else output setting for respective card
-	 */
-	device = (struct device *) it;
-	card = device->driver_data;
-
-	return 0;
-}
-
-static struct seq_operations qeth_ipato_procfile_seq_ops = {
-	.start = qeth_ipato_procfile_seq_start,
-	.stop  = qeth_ipato_procfile_seq_stop,
-	.next  = qeth_ipato_procfile_seq_next,
-	.show  = qeth_ipato_procfile_seq_show,
-};
-
-static int
-qeth_ipato_procfile_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &qeth_ipato_procfile_seq_ops);
-}
-
-static struct file_operations qeth_ipato_procfile_fops = {
-	.owner   = THIS_MODULE,
-	.open    = qeth_ipato_procfile_open,
-	.read    = seq_read,
-	.llseek  = seq_lseek,
-	.release = seq_release,
-};
-
 int __init
 qeth_create_procfs_entries(void)
 {
@@ -426,13 +297,7 @@ qeth_create_procfs_entries(void)
 		qeth_perf_procfile->proc_fops = &qeth_perf_procfile_fops;
 #endif /* CONFIG_QETH_PERF_STATS */
 
-	qeth_ipato_procfile = create_proc_entry(QETH_IPATO_PROCFILE_NAME,
-					   S_IFREG | 0444, NULL);
-	if (qeth_ipato_procfile)
-		qeth_ipato_procfile->proc_fops = &qeth_ipato_procfile_fops;
-
 	if (qeth_procfile &&
-	    qeth_ipato_procfile &&
 	    qeth_perf_procfile_created)
 		return 0;
 	else
@@ -446,62 +311,5 @@ qeth_remove_procfs_entries(void)
 		remove_proc_entry(QETH_PROCFILE_NAME, NULL);
 	if (qeth_perf_procfile)
 		remove_proc_entry(QETH_PERF_PROCFILE_NAME, NULL);
-	if (qeth_ipato_procfile)
-		remove_proc_entry(QETH_IPATO_PROCFILE_NAME, NULL);
-}
-
-
-/* ONLY FOR DEVELOPMENT! -> make it as module */
-/*
-static void
-qeth_create_sysfs_entries(void)
-{
-	struct device *dev;
-
-	down_read(&qeth_ccwgroup_driver.driver.bus->subsys.rwsem);
-
-	list_for_each_entry(dev, &qeth_ccwgroup_driver.driver.devices,
-			driver_list)
-		qeth_create_device_attributes(dev);
-
-	up_read(&qeth_ccwgroup_driver.driver.bus->subsys.rwsem);
-}
-
-static void
-qeth_remove_sysfs_entries(void)
-{
-	struct device *dev;
-
-	down_read(&qeth_ccwgroup_driver.driver.bus->subsys.rwsem);
-
-	list_for_each_entry(dev, &qeth_ccwgroup_driver.driver.devices,
-			driver_list)
-		qeth_remove_device_attributes(dev);
-
-	up_read(&qeth_ccwgroup_driver.driver.bus->subsys.rwsem);
-}
-
-static int __init
-qeth_fs_init(void)
-{
-	printk(KERN_INFO "qeth_fs_init\n");
-	qeth_create_procfs_entries();
-	qeth_create_sysfs_entries();
-
-	return 0;
 }
 
-static void __exit
-qeth_fs_exit(void)
-{
-	printk(KERN_INFO "qeth_fs_exit\n");
-	qeth_remove_procfs_entries();
-	qeth_remove_sysfs_entries();
-}
-
-
-module_init(qeth_fs_init);
-module_exit(qeth_fs_exit);
-
-MODULE_LICENSE("GPL");
-*/
diff --git a/drivers/s390/net/qeth_sys.c b/drivers/s390/net/qeth_sys.c
index ddd6019..0ea185f 100644
--- a/drivers/s390/net/qeth_sys.c
+++ b/drivers/s390/net/qeth_sys.c
@@ -1,6 +1,6 @@
 /*
  *
- * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.58 $)
+ * linux/drivers/s390/net/qeth_sys.c ($Revision: 1.60 $)
  *
  * Linux on zSeries OSA Express and HiperSockets support
  * This file contains code related to sysfs.
@@ -20,7 +20,7 @@
 #include "qeth_mpc.h"
 #include "qeth_fs.h"
 
-const char *VERSION_QETH_SYS_C = "$Revision: 1.58 $";
+const char *VERSION_QETH_SYS_C = "$Revision: 1.60 $";
 
 /*****************************************************************************/
 /*                                                                           */
@@ -160,7 +160,7 @@ qeth_dev_portname_store(struct device *d
 		return -EPERM;
 
 	tmp = strsep((char **) &buf, "\n");
-	if ((strlen(tmp) > 8) || (strlen(tmp) < 2))
+	if ((strlen(tmp) > 8) || (strlen(tmp) == 0))
 		return -EINVAL;
 
 	card->info.portname[0] = strlen(tmp);
diff --git a/drivers/s390/net/qeth_tso.h b/drivers/s390/net/qeth_tso.h
index e245af3..3c50b6f 100644
--- a/drivers/s390/net/qeth_tso.h
+++ b/drivers/s390/net/qeth_tso.h
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/s390/net/qeth_tso.h ($Revision: 1.7 $)
+ * linux/drivers/s390/net/qeth_tso.h ($Revision: 1.8 $)
  *
  * Header file for qeth TCP Segmentation Offload support.
  *
@@ -7,7 +7,7 @@
  *
  *    Author(s): Frank Pavlic <fpavlic@de.ibm.com>
  *
- *    $Revision: 1.7 $	 $Date: 2005/05/04 20:19:18 $
+ *    $Revision: 1.8 $	 $Date: 2005/05/04 20:19:18 $
  *
  */
 #ifndef __QETH_TSO_H__
