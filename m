Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbTKYQak (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 11:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbTKYQak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 11:30:40 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:37392 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S261681AbTKYQah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 11:30:37 -0500
Date: Tue, 25 Nov 2003 16:31:00 +0000
From: Joe Thornber <thornber@sistina.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@osdl.org>
Subject: [Patch 2/5] dm: remove dynamic table resizing
Message-ID: <20031125163100.GC524@reti>
References: <20031125162451.GA524@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031125162451.GA524@reti>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The dm table size is always known in advance, so we can specify it in
dm_table_create(), rather than relying on dynamic resizing.
--- diff/drivers/md/dm-ioctl-v1.c	2003-09-30 15:46:14.000000000 +0100
+++ source/drivers/md/dm-ioctl-v1.c	2003-11-25 15:47:38.000000000 +0000
@@ -566,7 +566,7 @@
 	if (r)
 		return r;
 
-	r = dm_table_create(&t, get_mode(param));
+	r = dm_table_create(&t, get_mode(param), param->target_count);
 	if (r)
 		return r;
 
@@ -894,7 +894,7 @@
 	struct mapped_device *md;
 	struct dm_table *t;
 
-	r = dm_table_create(&t, get_mode(param));
+	r = dm_table_create(&t, get_mode(param), param->target_count);
 	if (r)
 		return r;
 
--- diff/drivers/md/dm-ioctl-v4.c	2003-09-30 15:46:14.000000000 +0100
+++ source/drivers/md/dm-ioctl-v4.c	2003-11-25 15:47:38.000000000 +0000
@@ -872,7 +872,7 @@
 	struct hash_cell *hc;
 	struct dm_table *t;
 
-	r = dm_table_create(&t, get_mode(param));
+	r = dm_table_create(&t, get_mode(param), param->target_count);
 	if (r)
 		return r;
 
--- diff/drivers/md/dm-table.c	2003-11-25 15:24:57.000000000 +0000
+++ source/drivers/md/dm-table.c	2003-11-25 15:47:38.000000000 +0000
@@ -202,7 +202,7 @@
 	return 0;
 }
 
-int dm_table_create(struct dm_table **result, int mode)
+int dm_table_create(struct dm_table **result, int mode, unsigned num_targets)
 {
 	struct dm_table *t = kmalloc(sizeof(*t), GFP_NOIO);
 
@@ -213,8 +213,12 @@
 	INIT_LIST_HEAD(&t->devices);
 	atomic_set(&t->holders, 1);
 
-	/* allocate a single nodes worth of targets to begin with */
-	if (alloc_targets(t, KEYS_PER_NODE)) {
+	if (!num_targets)
+		num_targets = KEYS_PER_NODE;
+
+	num_targets = dm_round_up(num_targets, KEYS_PER_NODE);
+
+	if (alloc_targets(t, num_targets)) {
 		kfree(t);
 		t = NULL;
 		return -ENOMEM;
--- diff/drivers/md/dm.h	2003-08-20 14:16:09.000000000 +0100
+++ source/drivers/md/dm.h	2003-11-25 15:47:38.000000000 +0000
@@ -95,7 +95,7 @@
  * Functions for manipulating a table.  Tables are also reference
  * counted.
  *---------------------------------------------------------------*/
-int dm_table_create(struct dm_table **result, int mode);
+int dm_table_create(struct dm_table **result, int mode, unsigned num_targets);
 
 void dm_table_get(struct dm_table *t);
 void dm_table_put(struct dm_table *t);
