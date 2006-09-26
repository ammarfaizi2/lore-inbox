Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751342AbWIZNWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbWIZNWb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 09:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWIZNWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 09:22:31 -0400
Received: from twin.jikos.cz ([213.151.79.26]:33740 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751342AbWIZNWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 09:22:30 -0400
Date: Tue, 26 Sep 2006 15:21:57 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Dave Jones <davej@redhat.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/2] serio: lockdep annotation for ps2dev->cmd_mutex and
 serio->lock
In-Reply-To: <20060926113748.833215000@chello.nl>
Message-ID: <Pine.LNX.4.64.0609261520280.3938@twin.jikos.cz>
References: <20060926113150.294656000@chello.nl> <20060926113748.833215000@chello.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2006, Peter Zijlstra wrote:

> Based ideas from Jiri Kosina, this patch tracks the nesting depth
> and uses the new lockdep_set_class_and_subclass() annotation to store
> this information in the lock objects.

Hi,

the lockdep part of the patch (1/2) is OK. The second part, specifically 
the libps2.c changes, are not complete - the originally (wrongly) 
introduced mutex_lock_nested() has to be changed back to mutex_lock(), 
otherwise we will get spurious warning from lockdep about ps2_mutex_key.

Below is the fixed version of the patch. I confirm that this (together 
with Peter's original changes in lockdep, already acked by Ingo) fixes the 
synpatics passthrough port lockdep warnings.

So, as long as you, Dmitry, seem to be convenient with this approach, 
please apply. Thanks.

Signed-off-by: Jiri Kosina <jikos@jikos.cz>

Index: linux-2.6-mm/drivers/input/serio/libps2.c
===================================================================
--- linux-2.6.18-rc6-mm2.orig/drivers/input/serio/libps2.c	2006-09-04 04:19:48.000000000 +0200
+++ linux-2.6.18-rc6-mm2/drivers/input/serio/libps2.c	2006-09-26 14:45:18.000000000 +0200
@@ -182,7 +182,7 @@ int ps2_command(struct ps2dev *ps2dev, u
 		return -1;
 	}
 
-	mutex_lock_nested(&ps2dev->cmd_mutex, SINGLE_DEPTH_NESTING);
+	mutex_lock(&ps2dev->cmd_mutex);
 
 	serio_pause_rx(ps2dev->serio);
 	ps2dev->flags = command == PS2_CMD_GETID ? PS2_FLAG_WAITID : 0;
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
Jiri Kosina
