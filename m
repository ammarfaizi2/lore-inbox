Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWIZLp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWIZLp2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 07:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWIZLp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 07:45:28 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:54959 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750835AbWIZLp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 07:45:26 -0400
Message-Id: <20060926113748.833215000@chello.nl>
References: <20060926113150.294656000@chello.nl>
User-Agent: quilt/0.45-1
Date: Tue, 26 Sep 2006 13:31:52 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
Cc: Jiri Kosina <jikos@jikos.cz>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: [PATCH 2/2] serio: lockdep annotation for ps2dev->cmd_mutex and serio->lock
Content-Disposition: inline; filename=serio-lockdep.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Based ideas from Jiri Kosina, this patch tracks the nesting depth
and uses the new lockdep_set_class_and_subclass() annotation to store
this information in the lock objects.

Signed-of-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 drivers/input/serio/libps2.c |    4 ++++
 drivers/input/serio/serio.c  |    9 ++++++++-
 include/linux/serio.h        |    1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

Index: linux-2.6-mm/drivers/input/serio/libps2.c
===================================================================
--- linux-2.6-mm.orig/drivers/input/serio/libps2.c	2006-09-26 10:25:22.000000000 +0200
+++ linux-2.6-mm/drivers/input/serio/libps2.c	2006-09-26 10:34:49.000000000 +0200
@@ -280,6 +280,8 @@ int ps2_schedule_command(struct ps2dev *
 	return 0;
 }
 
+static struct lock_class_key ps2_mutex_key;
+
 /*
  * ps2_init() initializes ps2dev structure
  */
@@ -287,6 +289,8 @@ int ps2_schedule_command(struct ps2dev *
 void ps2_init(struct ps2dev *ps2dev, struct serio *serio)
 {
 	mutex_init(&ps2dev->cmd_mutex);
+	lockdep_set_class_and_subclass(&ps2dev->cmd_mutex, &ps2_mutex_key,
+				       serio->depth);
 	init_waitqueue_head(&ps2dev->wait);
 	ps2dev->serio = serio;
 }
Index: linux-2.6-mm/drivers/input/serio/serio.c
===================================================================
--- linux-2.6-mm.orig/drivers/input/serio/serio.c	2006-09-26 10:25:22.000000000 +0200
+++ linux-2.6-mm/drivers/input/serio/serio.c	2006-09-26 10:34:04.000000000 +0200
@@ -521,6 +521,8 @@ static void serio_release_port(struct de
 	module_put(THIS_MODULE);
 }
 
+static struct lock_class_key serio_lock_key;
+
 /*
  * Prepare serio port for registration.
  */
@@ -538,8 +540,13 @@ static void serio_init_port(struct serio
 		 "serio%ld", (long)atomic_inc_return(&serio_no) - 1);
 	serio->dev.bus = &serio_bus;
 	serio->dev.release = serio_release_port;
-	if (serio->parent)
+	if (serio->parent) {
 		serio->dev.parent = &serio->parent->dev;
+		serio->depth = serio->parent->depth + 1;
+	} else
+		serio->depth = 0;
+	lockdep_set_class_and_subclass(&serio->lock, &serio_lock_key,
+				       serio->depth);
 }
 
 /*
Index: linux-2.6-mm/include/linux/serio.h
===================================================================
--- linux-2.6-mm.orig/include/linux/serio.h	2006-09-26 10:25:22.000000000 +0200
+++ linux-2.6-mm/include/linux/serio.h	2006-09-26 10:34:04.000000000 +0200
@@ -41,6 +41,7 @@ struct serio {
 	void (*stop)(struct serio *);
 
 	struct serio *parent, *child;
+	unsigned int depth;		/* level of nesting in serio hierarchy */
 
 	struct serio_driver *drv;	/* accessed from interrupt, must be protected by serio->lock and serio->sem */
 	struct mutex drv_mutex;		/* protects serio->drv so attributes can pin driver */

--

