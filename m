Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263530AbTDTFvl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 01:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263532AbTDTFvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 01:51:41 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:10424 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263530AbTDTFvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 01:51:37 -0400
Date: Sun, 20 Apr 2003 01:53:18 -0400
From: Ben Collins <bcollins@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Linux1394 (r893)
Message-ID: <20030420055318.GJ2528@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SMP folks will hate me for this one. This fixes a deadlock during
add_host.


Index: drivers/ieee1394/highlevel.c
===================================================================
--- linux/drivers/ieee1394/highlevel.c	(revision 893)
+++ linux/drivers/ieee1394/highlevel.c	(working copy)
@@ -48,20 +48,22 @@
 static struct hpsb_address_serve dummy_zero_addr, dummy_max_addr;
 
 
-/* Internal usage. Must be called with hl_drivers_lock held */
 static struct hl_host_info *hl_get_hostinfo(struct hpsb_highlevel *hl,
 					      struct hpsb_host *host)
 {
-	struct hl_host_info *hi;
+	struct hl_host_info *hi = NULL;
 	struct list_head *lh;
 
+	read_lock(&hl->host_info_lock);
 	list_for_each (lh, &hl->host_info_list) {
 		hi = list_entry(lh, struct hl_host_info, list);
 		if (hi->host == host)
-			return hi;
+			break;
+		hi = NULL;
 	}
+	read_unlock(&hl->host_info_lock);
 
-	return NULL;
+	return hi;
 }
 
 
@@ -69,16 +71,12 @@
  * hpsb_create_hostinfo. */
 void *hpsb_get_hostinfo(struct hpsb_highlevel *hl, struct hpsb_host *host)
 {
-	struct hl_host_info *hi;
-	void *data = NULL;
+	struct hl_host_info *hi = hl_get_hostinfo(hl, host);
 
-	read_lock(&hl_drivers_lock);
-	hi = hl_get_hostinfo(hl, host);
 	if (hi)
-		data = hi->data;
-	read_unlock(&hl_drivers_lock);
+		return hi->data;
 
-	return data;
+	return NULL;
 }
 
 
@@ -88,10 +86,9 @@
 {
 	struct hl_host_info *hi;
 	void *data;
+	unsigned long flags;
 
-	read_lock(&hl_drivers_lock);
 	hi = hl_get_hostinfo(hl, host);
-	read_unlock(&hl_drivers_lock);
 	if (hi) {
 		HPSB_ERR("%s called hpsb_create_hostinfo when hostinfo already exists",
 			 hl->name);
@@ -112,9 +109,9 @@
 
 	hi->host = host;
 
-	write_lock_irq(&hl_drivers_lock);
+	write_lock_irqsave(&hl->host_info_lock, flags);
 	list_add_tail(&hi->list, &hl->host_info_list);
-	write_unlock_irq(&hl_drivers_lock);
+	write_unlock_irqrestore(&hl->host_info_lock, flags);
 
 	return data;
 }
@@ -124,23 +121,20 @@
 		      void *data)
 {
 	struct hl_host_info *hi;
-	int ret = -EINVAL;
 
-	write_lock_irq(&hl_drivers_lock);
 	hi = hl_get_hostinfo(hl, host);
 	if (hi) {
 		if (!hi->size && !hi->data) {
 			hi->data = data;
-			ret = 0;
+			return 0;
 		} else
 			HPSB_ERR("%s called hpsb_set_hostinfo when hostinfo already has data",
 				 hl->name);
 	} else
 		HPSB_ERR("%s called hpsb_set_hostinfo when no hostinfo exists",
 			 hl->name);
-	write_unlock_irq(&hl_drivers_lock);
 
-	return ret;
+	return -EINVAL;
 }
 
 
@@ -148,13 +142,14 @@
 {
 	struct hl_host_info *hi;
 
-	write_lock_irq(&hl_drivers_lock);
 	hi = hl_get_hostinfo(hl, host);
 	if (hi) {
+		unsigned long flags;
+		write_lock_irqsave(&hl->host_info_lock, flags);
 		list_del(&hi->list);
+		write_unlock_irqrestore(&hl->host_info_lock, flags);
 		kfree(hi);
 	}
-	write_unlock_irq(&hl_drivers_lock);
 
 	return;
 }
@@ -164,11 +159,9 @@
 {
 	struct hl_host_info *hi;
 
-	write_lock(&hl_drivers_lock);
 	hi = hl_get_hostinfo(hl, host);
 	if (hi)
 		hi->key = key;
-	write_unlock(&hl_drivers_lock);
 
 	return;
 }
@@ -177,15 +170,12 @@
 unsigned long hpsb_get_hostinfo_key(struct hpsb_highlevel *hl, struct hpsb_host *host)
 {
 	struct hl_host_info *hi;
-	unsigned long key = 0;
 
-	read_lock(&hl_drivers_lock);
 	hi = hl_get_hostinfo(hl, host);
 	if (hi)
-		key = hi->key;
-	read_unlock(&hl_drivers_lock);
+		return hi->key;
 
-	return key;
+	return 0;
 }
 
 
@@ -195,7 +185,7 @@
 	struct hl_host_info *hi;
 	void *data = NULL;
 
-	read_lock(&hl_drivers_lock);
+	read_lock(&hl->host_info_lock);
 	list_for_each (lh, &hl->host_info_list) {
 		hi = list_entry(lh, struct hl_host_info, list);
 		if (hi->key == key) {
@@ -203,7 +193,7 @@
 			break;
 		}
 	}
-	read_unlock(&hl_drivers_lock);
+	read_unlock(&hl->host_info_lock);
 
 	return data;
 }
@@ -225,6 +215,8 @@
         INIT_LIST_HEAD(&hl->addr_list);
 	INIT_LIST_HEAD(&hl->host_info_list);
 
+	rwlock_init(&hl->host_info_lock);
+
         hl->name = name;
         hl->op = ops;
 
Index: drivers/ieee1394/highlevel.h
===================================================================
--- linux/drivers/ieee1394/highlevel.h	(revision 893)
+++ linux/drivers/ieee1394/highlevel.h	(working copy)
@@ -14,6 +14,7 @@
 
 	/* Used by the highlevel drivers to store data per host */
 	struct list_head host_info_list;
+	rwlock_t host_info_lock;
 };
 
 
