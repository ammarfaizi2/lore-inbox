Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753020AbVHGWMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020AbVHGWMW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 18:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753021AbVHGWMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 18:12:22 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26375 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1753018AbVHGWMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 18:12:21 -0400
Date: Mon, 8 Aug 2005 00:12:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Cornelia Huck <cohuck@de.ibm.com>,
       Martin Schwidesky <schwidefsky@de.ibm.com>,
       Frank Pavlic <pavlic@de.ibm.com>
Subject: [2.6 patch] fix drivers/s390/net/ compilation
Message-ID: <20050807221218.GD4006@stusta.de>
References: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at Jan Dittmer's crosscompile site [1], one of the two 
architectures where defconfig compiled in 2.6.12.4 but does no longer 
compile in 2.6.13-rc6 is s390.

Looking at the build error, it seems s390-use-klist-in-qeth-driver.patch 
from -mm was intended to fix this compile error.

I haven't tested whether it is actually enough for getting the s390 
defconfig compiling, but it can't make things worse.

[1] http://l4x.org/k/


<--  snip  -->


From: Cornelia Huck <cohuck@de.ibm.com>
From: Martin Schwidesky <schwidefsky@de.ibm.com>
 
Convert qeth to the new klist interface and make it compiling again. 

Signed-off-by: Frank Pavlic <pavlic@de.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Adrian Bunk <bunk@stusta.de>
---

 drivers/s390/net/qeth_main.c |   24 ++++----
 drivers/s390/net/qeth_proc.c |  126 +++++++++++++++++++++++--------------------
 2 files changed, 82 insertions(+), 68 deletions(-)

diff -puN drivers/s390/net/qeth_main.c~s390-use-klist-in-qeth-driver drivers/s390/net/qeth_main.c
--- devel/drivers/s390/net/qeth_main.c~s390-use-klist-in-qeth-driver	2005-07-28 19:20:53.000000000 -0700
+++ devel-akpm/drivers/s390/net/qeth_main.c	2005-07-28 19:20:53.000000000 -0700
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
 
diff -puN drivers/s390/net/qeth_proc.c~s390-use-klist-in-qeth-driver drivers/s390/net/qeth_proc.c
--- devel/drivers/s390/net/qeth_proc.c~s390-use-klist-in-qeth-driver	2005-07-28 19:20:53.000000000 -0700
+++ devel-akpm/drivers/s390/net/qeth_proc.c	2005-07-28 19:20:53.000000000 -0700
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
_

