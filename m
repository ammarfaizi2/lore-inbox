Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266052AbUBJRGV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266023AbUBJREm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:04:42 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:20235 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S266022AbUBJRAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:00:43 -0500
Date: Tue, 10 Feb 2004 17:00:06 +0000
From: Joe Thornber <thornber@redhat.com>
To: Joe Thornber <thornber@redhat.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [Patch 4/10] dm: Maintain ordering when deferring bios
Message-ID: <20040210170006.GJ27507@reti>
References: <20040210163548.GC27507@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210163548.GC27507@reti>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that we maintain ordering when deferring bios.
--- diff/drivers/md/dm.c	2004-02-10 16:11:30.000000000 +0000
+++ source/drivers/md/dm.c	2004-02-10 16:11:37.000000000 +0000
@@ -5,6 +5,7 @@
  */
 
 #include "dm.h"
+#include "dm-bio-list.h"
 
 #include <linux/init.h>
 #include <linux/module.h>
@@ -47,7 +48,7 @@
 	 */
 	atomic_t pending;
 	wait_queue_head_t wait;
-	struct bio *deferred;
+ 	struct bio_list deferred;
 
 	/*
 	 * The current mapping.
@@ -195,8 +196,7 @@
 		return 1;
 	}
 
-	bio->bi_next = md->deferred;
-	md->deferred = bio;
+	bio_list_add(&md->deferred, bio);
 
 	up_write(&md->lock);
 	return 0;		/* deferred successfully */
@@ -822,8 +822,7 @@
 	dm_table_resume_targets(md->map);
 	clear_bit(DMF_SUSPENDED, &md->flags);
 	clear_bit(DMF_BLOCK_IO, &md->flags);
-	def = md->deferred;
-	md->deferred = NULL;
+	def = bio_list_get(&md->deferred);
 	up_write(&md->lock);
 
 	flush_deferred_io(def);
--- diff/drivers/md/dm-bio-list.h	1970-01-01 01:00:00.000000000 +0100
+++ source/drivers/md/dm-bio-list.h	2004-02-10 16:11:37.000000000 +0000
@@ -0,0 +1,68 @@
+/*
+ * Copyright (C) 2004 Red Hat UK Ltd.
+ *
+ * This file is released under the GPL.
+ */
+
+#ifndef DM_BIO_LIST_H
+#define DM_BIO_LIST_H
+
+#include <linux/bio.h>
+
+struct bio_list {
+	struct bio *head;
+	struct bio *tail;
+};
+
+static inline void bio_list_init(struct bio_list *bl)
+{
+	bl->head = bl->tail = NULL;
+}
+
+static inline void bio_list_add(struct bio_list *bl, struct bio *bio)
+{
+	bio->bi_next = NULL;
+
+	if (bl->tail)
+		bl->tail->bi_next = bio;
+	else
+		bl->head = bio;
+
+	bl->tail = bio;
+}
+
+static inline void bio_list_merge(struct bio_list *bl, struct bio_list *bl2)
+{
+	if (bl->tail)
+		bl->tail->bi_next = bl2->head;
+	else
+		bl->head = bl2->head;
+
+	bl->tail = bl2->tail;
+}
+
+static inline struct bio *bio_list_pop(struct bio_list *bl)
+{
+	struct bio *bio = bl->head;
+
+	if (bio) {
+		bl->head = bl->head->bi_next;
+		if (!bl->head)
+			bl->tail = NULL;
+
+		bio->bi_next = NULL;
+	}
+
+	return bio;
+}
+
+static inline struct bio *bio_list_get(struct bio_list *bl)
+{
+	struct bio *bio = bl->head;
+
+	bl->head = bl->tail = NULL;
+
+	return bio;
+}
+
+#endif
