Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbTKYQgu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 11:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbTKYQgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 11:36:49 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:48657 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S262491AbTKYQei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 11:34:38 -0500
Date: Tue, 25 Nov 2003 16:35:37 +0000
From: Joe Thornber <thornber@sistina.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@osdl.org>
Subject: [Patch 5/5] dm: dm_table_event() sleep on spinlock bug
Message-ID: <20031125163537.GF524@reti>
References: <20031125162451.GA524@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031125162451.GA524@reti>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can no longer call dm_table_event() from interrupt context.
--- diff/drivers/md/dm-table.c	2003-11-25 15:47:59.000000000 +0000
+++ source/drivers/md/dm-table.c	2003-11-25 15:52:15.000000000 +0000
@@ -12,6 +12,7 @@
 #include <linux/namei.h>
 #include <linux/ctype.h>
 #include <linux/slab.h>
+#include <linux/interrupt.h>
 #include <asm/atomic.h>
 
 #define MAX_DEPTH 16
@@ -746,22 +747,28 @@
 	return r;
 }
 
-static spinlock_t _event_lock = SPIN_LOCK_UNLOCKED;
+static DECLARE_MUTEX(_event_lock);
 void dm_table_event_callback(struct dm_table *t,
 			     void (*fn)(void *), void *context)
 {
-	spin_lock_irq(&_event_lock);
+	down(&_event_lock);
 	t->event_fn = fn;
 	t->event_context = context;
-	spin_unlock_irq(&_event_lock);
+	up(&_event_lock);
 }
 
 void dm_table_event(struct dm_table *t)
 {
-	spin_lock(&_event_lock);
+	/*
+	 * You can no longer call dm_table_event() from interrupt
+	 * context, use a bottom half instead.
+	 */
+	BUG_ON(in_interrupt());
+
+	down(&_event_lock);
 	if (t->event_fn)
 		t->event_fn(t->event_context);
-	spin_unlock(&_event_lock);
+	up(&_event_lock);
 }
 
 sector_t dm_table_get_size(struct dm_table *t)
