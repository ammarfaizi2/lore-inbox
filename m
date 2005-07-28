Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVG1UYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVG1UYb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 16:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbVG1UY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 16:24:28 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:12783 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S262179AbVG1UXq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 16:23:46 -0400
Date: Thu, 28 Jul 2005 22:26:01 +0200
From: Frank Pavlic <pavlic@de.ibm.com>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: [patch 1/1] s390: use klist in qeth driver
Message-ID: <20050728202601.GA6589@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 1/1] s390: use klist in qeth driver.

From: Cornelia Huck <cohuck@de.ibm.com>
From: Martin Schwidesky <schwidefsky@de.ibm.com>
 
 Convert qeth to the new klist interface and make it compiling again. 

Signed-off-by: Frank Pavlic <pavlic@de.ibm.com>

diffstat:
 qeth_main.c |   24 ++++++-----
 qeth_proc.c |  126 ++++++++++++++++++++++++++++++++----------------------------
 2 files changed, 82 insertions(+), 68 deletions(-)

diff -Naupr linux-2.6-orig/drivers/s390/net/qeth_main.c linux-2.6-patched/drivers/s390/net/qeth_main.c
--- linux-2.6-orig/drivers/s390/net/qeth_main.c	2005-07-28 11:06:56.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth_main.c	2005-07-28 11:31:55.000000000 +0200
@@ -8120,20 +8120,22 @@ static struct notifier_block qeth_ip6_no
 #endif
 
 static int
-qeth_reboot_event(struct notifier_block *this, unsigned long event, void *ptr)
+__qeth_reboot_event_card(struct device *dev, void *data)
 {
-
-	struct device *entry;
 	struct qeth_card *card;
 
-	down_read(&qeth_ccwgroup_driver.driver.bus->subsys.rwsem);
-	       list_for_each_entry(entry, &qeth_ccwgroup_driver.driver.devices,
-			           driver_list) {
-	               card = (struct qeth_card *) entry->driver_data;
-		       qeth_clear_ip_list(card, 0, 0);
-		       qeth_qdio_clear_card(card, 0);
-	       }
-	up_read(&qeth_ccwgroup_driver.driver.bus->subsys.rwsem);
+	card = (struct qeth_card *) dev->driver_data;
+	qeth_clear_ip_list(card, 0, 0);
+	qeth_qdio_clear_card(card, 0);
+	return 0;
+}
+
+static int
+qeth_reboot_event(struct notifier_block *this, unsigned long event, void *ptr)
+{
+
+	driver_for_each_device(&qeth_ccwgroup_driver.driver, NULL, NULL,
+			       __qeth_reboot_event_card);
 	return NOTIFY_DONE;
 }
 
diff -Naupr linux-2.6-orig/drivers/s390/net/qeth_proc.c linux-2.6-patched/drivers/s390/net/qeth_proc.c
--- linux-2.6-orig/drivers/s390/net/qeth_proc.c	2005-07-28 11:06:56.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/qeth_proc.c	2005-07-28 11:32:02.000000000 +0200
@@ -27,23 +27,33 @@ const char *VERSION_QETH_PROC_C = "$Revi
 #define QETH_PROCFILE_NAME "qeth"
 static struct proc_dir_entry *qeth_procfile;
 
+static int
+qeth_procfile_seq_match(struct device *dev, void *data)
+{
+	return 1;
+}
+
 static void *
 qeth_procfile_seq_start(struct seq_file *s, loff_t *offset)
 {
-	struct list_head *next_card = NULL;
-	int i = 0;
+	struct device *dev;
+	loff_t nr;
 
 	down_read(&qeth_ccwgroup_driver.driver.bus->subsys.rwsem);
 
-	if (*offset == 0)
+	nr = *offset;
+	if (nr == 0)
 		return SEQ_START_TOKEN;
 
-	/* get card at pos *offset */
-	list_for_each(next_card, &qeth_ccwgroup_driver.driver.devices)
-		if (++i == *offset)
-			return next_card;
+	dev = driver_find_device(&qeth_ccwgroup_driver.driver, NULL,
+				 NULL, qeth_procfile_seq_match);
 
-	return NULL;
+	/* get card at pos *offset */
+	nr = *offset;
+	while (nr-- > 1 && dev)
+		dev = driver_find_device(&qeth_ccwgroup_driver.driver, dev,
+					 NULL, qeth_procfile_seq_match);
+	return (void *) dev;
 }
 
 static void
@@ -55,23 +65,21 @@ qeth_procfile_seq_stop(struct seq_file *
 static void *
 qeth_procfile_seq_next(struct seq_file *s, void *it, loff_t *offset)
 {
-	struct list_head *next_card = NULL;
-	struct list_head *current_card;
+	struct device *prev, *next;
 
 	if (it == SEQ_START_TOKEN) {
-		next_card = qeth_ccwgroup_driver.driver.devices.next;
-		if (next_card->next == next_card) /* list empty */
-			return NULL;
-		(*offset)++;
-	} else {
-		current_card = (struct list_head *)it;
-		if (current_card->next == &qeth_ccwgroup_driver.driver.devices)
-			return NULL; /* end of list reached */
-		next_card = current_card->next;
-		(*offset)++;
+		next = driver_find_device(&qeth_ccwgroup_driver.driver,
+					  NULL, NULL, qeth_procfile_seq_match);
+		if (next)
+			(*offset)++;
+		return (void *) next;
 	}
-
-	return next_card;
+	prev = (struct device *) it;
+	next = driver_find_device(&qeth_ccwgroup_driver.driver,
+				  prev, NULL, qeth_procfile_seq_match);
+	if (next)
+		(*offset)++;
+	return (void *) next;
 }
 
 static inline const char *
@@ -126,7 +134,7 @@ qeth_procfile_seq_show(struct seq_file *
 			      "-------------- ---- ------ ---------- ---- "
 			      "---- ----- -----\n");
 	} else {
-		device = list_entry(it, struct device, driver_list);
+		device = (struct device *) it;
 		card = device->driver_data;
 		seq_printf(s, "%s/%s/%s x%02X   %-10s %-14s %-4i ",
 				CARD_RDEV_ID(card),
@@ -180,17 +188,20 @@ static struct proc_dir_entry *qeth_perf_
 static void *
 qeth_perf_procfile_seq_start(struct seq_file *s, loff_t *offset)
 {
-	struct list_head *next_card = NULL;
-	int i = 0;
+	struct device *dev = NULL;
+	int nr;
 
 	down_read(&qeth_ccwgroup_driver.driver.bus->subsys.rwsem);
 	/* get card at pos *offset */
-	list_for_each(next_card, &qeth_ccwgroup_driver.driver.devices){
-		if (i == *offset)
-			return next_card;
-		i++;
-	}
-	return NULL;
+	dev = driver_find_device(&qeth_ccwgroup_driver.driver, NULL, NULL,
+				 qeth_procfile_seq_match);
+
+	/* get card at pos *offset */
+	nr = *offset;
+	while (nr-- > 1 && dev)
+		dev = driver_find_device(&qeth_ccwgroup_driver.driver, dev,
+					 NULL, qeth_procfile_seq_match);
+	return (void *) dev;
 }
 
 static void
@@ -202,12 +213,14 @@ qeth_perf_procfile_seq_stop(struct seq_f
 static void *
 qeth_perf_procfile_seq_next(struct seq_file *s, void *it, loff_t *offset)
 {
-	struct list_head *current_card = (struct list_head *)it;
+	struct device *prev, *next;
 
-	if (current_card->next == &qeth_ccwgroup_driver.driver.devices)
-		return NULL; /* end of list reached */
-	(*offset)++;
-	return current_card->next;
+	prev = (struct device *) it;
+	next = driver_find_device(&qeth_ccwgroup_driver.driver, prev,
+				  NULL, qeth_procfile_seq_match);
+	if (next)
+		(*offset)++;
+	return (void *) next;
 }
 
 static int
@@ -216,7 +229,7 @@ qeth_perf_procfile_seq_show(struct seq_f
 	struct device *device;
 	struct qeth_card *card;
 
-	device = list_entry(it, struct device, driver_list);
+	device = (struct device *) it;
 	card = device->driver_data;
 	seq_printf(s, "For card with devnos %s/%s/%s (%s):\n",
 			CARD_RDEV_ID(card),
@@ -318,8 +331,8 @@ static struct proc_dir_entry *qeth_ipato
 static void *
 qeth_ipato_procfile_seq_start(struct seq_file *s, loff_t *offset)
 {
-	struct list_head *next_card = NULL;
-	int i = 0;
+	struct device *dev;
+	loff_t nr;
 
 	down_read(&qeth_ccwgroup_driver.driver.bus->subsys.rwsem);
 	/* TODO: finish this */
@@ -328,13 +341,16 @@ qeth_ipato_procfile_seq_start(struct seq
 	 * output driver settings then;
 	 * else output setting for respective card
 	 */
+
+	dev = driver_find_device(&qeth_ccwgroup_driver.driver, NULL, NULL,
+				 qeth_procfile_seq_match);
+
 	/* get card at pos *offset */
-	list_for_each(next_card, &qeth_ccwgroup_driver.driver.devices){
-		if (i == *offset)
-			return next_card;
-		i++;
-	}
-	return NULL;
+	nr = *offset;
+	while (nr-- > 1 && dev)
+		dev = driver_find_device(&qeth_ccwgroup_driver.driver, dev,
+					 NULL, qeth_procfile_seq_match);
+	return (void *) dev;
 }
 
 static void
@@ -346,18 +362,14 @@ qeth_ipato_procfile_seq_stop(struct seq_
 static void *
 qeth_ipato_procfile_seq_next(struct seq_file *s, void *it, loff_t *offset)
 {
-	struct list_head *current_card = (struct list_head *)it;
+	struct device *prev, *next;
 
-	/* TODO: finish this */
-	/*
-	 * maybe SEQ_SATRT_TOKEN can be returned for offset 0
-	 * output driver settings then;
-	 * else output setting for respective card
-	 */
-	if (current_card->next == &qeth_ccwgroup_driver.driver.devices)
-		return NULL; /* end of list reached */
-	(*offset)++;
-	return current_card->next;
+	prev = (struct device *) it;
+	next = driver_find_device(&qeth_ccwgroup_driver.driver, prev,
+				  NULL, qeth_procfile_seq_match);
+	if (next)
+		(*offset)++;
+	return (void *) next;
 }
 
 static int
@@ -372,7 +384,7 @@ qeth_ipato_procfile_seq_show(struct seq_
 	 * output driver settings then;
 	 * else output setting for respective card
 	 */
-	device = list_entry(it, struct device, driver_list);
+	device = (struct device *) it;
 	card = device->driver_data;
 
 	return 0;
