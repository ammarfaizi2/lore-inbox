Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932709AbWFUTie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932709AbWFUTie (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbWFUTha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:37:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36774 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932711AbWFUThV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:37:21 -0400
Date: Wed, 21 Jun 2006 20:37:16 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, David Teigland <teigland@redhat.com>
Subject: [PATCH 13/15] dm: create error table
Message-ID: <20060621193716.GB4521@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	David Teigland <teigland@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Teigland <teigland@redhat.com>

Add a library function dm_create_error_table() to create a table that
rejects any I/O sent to a device with EIO.

Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.17/include/linux/device-mapper.h
===================================================================
--- linux-2.6.17.orig/include/linux/device-mapper.h	2006-06-21 18:32:25.000000000 +0100
+++ linux-2.6.17/include/linux/device-mapper.h	2006-06-21 18:32:38.000000000 +0100
@@ -232,5 +232,11 @@ void dm_table_event(struct dm_table *t);
  */
 int dm_swap_table(struct mapped_device *md, struct dm_table *t);
 
+/*
+ * Prepare a table for a device that will error all I/O.
+ * To make it active, call dm_suspend(), dm_swap_table() then dm_resume().
+ */
+int dm_create_error_table(struct dm_table **result, struct mapped_device *md);
+
 #endif	/* __KERNEL__ */
 #endif	/* _LINUX_DEVICE_MAPPER_H */
Index: linux-2.6.17/drivers/md/dm-table.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-table.c	2006-06-21 18:32:25.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-table.c	2006-06-21 18:32:38.000000000 +0100
@@ -238,6 +238,44 @@ int dm_table_create(struct dm_table **re
 }
 EXPORT_SYMBOL_GPL(dm_table_create);
 
+int dm_create_error_table(struct dm_table **result, struct mapped_device *md)
+{
+	struct dm_table *t;
+	sector_t dev_size = 1;
+	int r;
+
+	/*
+	 * Find current size of device.
+	 * Default to 1 sector if inactive.
+	 */
+	t = dm_get_table(md);
+	if (t) {
+		dev_size = dm_table_get_size(t);
+		dm_table_put(t);
+	}
+
+	r = dm_table_create(&t, FMODE_READ, 1, md);
+	if (r)
+		return r;
+
+	r = dm_table_add_target(t, "error", 0, dev_size, NULL);
+	if (r)
+		goto out;
+
+	r = dm_table_complete(t);
+	if (r)
+		goto out;
+
+	*result = t;
+
+out:
+	if (r)
+		dm_table_put(t);
+
+	return r;
+}
+EXPORT_SYMBOL_GPL(dm_create_error_table);
+
 static void free_devices(struct list_head *devices)
 {
 	struct list_head *tmp, *next;
