Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWAQSFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWAQSFR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWAQSFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:05:16 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:45281 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S932152AbWAQSFO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:05:14 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Pat Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org
Subject: [patch] sn_console.c minor cleanup
From: Jes Sorensen <jes@sgi.com>
Date: 17 Jan 2006 13:05:12 -0500
Message-ID: <yq0ek36raqv.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A small round of house keeping for the sn_console.c driver.

Cheers,
Jes


Fix printk level and remove unnecessary CONFIG_SMP|CONFIG_PREEMPT tests
as this is taken care through the spinlock macros anyway.

Signed-off-by: Jes Sorensen <jes@sgi.com>
Signed-off-by: Pat Gefre <pfg@sgi.com>

----

 drivers/serial/sn_console.c |  129 +++++++++++++++++++-------------------------
 1 files changed, 58 insertions(+), 71 deletions(-)

Index: linux-2.6/drivers/serial/sn_console.c
===================================================================
--- linux-2.6.orig/drivers/serial/sn_console.c
+++ linux-2.6/drivers/serial/sn_console.c
@@ -6,7 +6,7 @@
  * driver for that.
  *
  *
- * Copyright (c) 2004-2005 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (c) 2004-2006 Silicon Graphics, Inc.  All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License
@@ -829,8 +829,8 @@
 		misc.name = DEVICE_NAME_DYNAMIC;
 		retval = misc_register(&misc);
 		if (retval != 0) {
-			printk
-			    ("Failed to register console device using misc_register.\n");
+			printk(KERN_WARNING "Failed to register console "
+			       "device using misc_register.\n");
 			return -ENODEV;
 		}
 		sal_console_uart.major = MISC_MAJOR;
@@ -942,88 +942,75 @@
 {
 	unsigned long flags = 0;
 	struct sn_cons_port *port = &sal_console_port;
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
 	static int stole_lock = 0;
-#endif
 
 	BUG_ON(!port->sc_is_asynch);
 
 	/* We can't look at the xmit buffer if we're not registered with serial core
 	 *  yet.  So only do the fancy recovery after registering
 	 */
-	if (port->sc_port.info) {
-
-		/* somebody really wants this output, might be an
-		 * oops, kdb, panic, etc.  make sure they get it. */
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
-		if (spin_is_locked(&port->sc_port.lock)) {
-			int lhead = port->sc_port.info->xmit.head;
-			int ltail = port->sc_port.info->xmit.tail;
-			int counter, got_lock = 0;
+	if (!port->sc_port.info) {
+		/* Not yet registered with serial core - simple case */
+		puts_raw_fixed(port->sc_ops->sal_puts_raw, s, count);
+		return;
+	}
 
-			/*
-			 * We attempt to determine if someone has died with the
-			 * lock. We wait ~20 secs after the head and tail ptrs
-			 * stop moving and assume the lock holder is not functional
-			 * and plow ahead. If the lock is freed within the time out
-			 * period we re-get the lock and go ahead normally. We also
-			 * remember if we have plowed ahead so that we don't have
-			 * to wait out the time out period again - the asumption
-			 * is that we will time out again.
-			 */
+	/* somebody really wants this output, might be an
+	 * oops, kdb, panic, etc.  make sure they get it. */
+	if (spin_is_locked(&port->sc_port.lock)) {
+		int lhead = port->sc_port.info->xmit.head;
+		int ltail = port->sc_port.info->xmit.tail;
+		int counter, got_lock = 0;
+
+		/*
+		 * We attempt to determine if someone has died with the
+		 * lock. We wait ~20 secs after the head and tail ptrs
+		 * stop moving and assume the lock holder is not functional
+		 * and plow ahead. If the lock is freed within the time out
+		 * period we re-get the lock and go ahead normally. We also
+		 * remember if we have plowed ahead so that we don't have
+		 * to wait out the time out period again - the asumption
+		 * is that we will time out again.
+		 */
 
-			for (counter = 0; counter < 150; mdelay(125), counter++) {
-				if (!spin_is_locked(&port->sc_port.lock)
-				    || stole_lock) {
-					if (!stole_lock) {
-						spin_lock_irqsave(&port->
-								  sc_port.lock,
-								  flags);
-						got_lock = 1;
-					}
-					break;
-				} else {
-					/* still locked */
-					if ((lhead !=
-					     port->sc_port.info->xmit.head)
-					    || (ltail !=
-						port->sc_port.info->xmit.
-						tail)) {
-						lhead =
-						    port->sc_port.info->xmit.
-						    head;
-						ltail =
-						    port->sc_port.info->xmit.
-						    tail;
-						counter = 0;
-					}
+		for (counter = 0; counter < 150; mdelay(125), counter++) {
+			if (!spin_is_locked(&port->sc_port.lock)
+			    || stole_lock) {
+				if (!stole_lock) {
+					spin_lock_irqsave(&port->sc_port.lock,
+							  flags);
+					got_lock = 1;
 				}
-			}
-			/* flush anything in the serial core xmit buffer, raw */
-			sn_transmit_chars(port, 1);
-			if (got_lock) {
-				spin_unlock_irqrestore(&port->sc_port.lock,
-						       flags);
-				stole_lock = 0;
+				break;
 			} else {
-				/* fell thru */
-				stole_lock = 1;
+				/* still locked */
+				if ((lhead != port->sc_port.info->xmit.head)
+				    || (ltail !=
+					port->sc_port.info->xmit.tail)) {
+					lhead =
+						port->sc_port.info->xmit.head;
+					ltail =
+						port->sc_port.info->xmit.tail;
+					counter = 0;
+				}
 			}
-			puts_raw_fixed(port->sc_ops->sal_puts_raw, s, count);
-		} else {
-			stole_lock = 0;
-#endif
-			spin_lock_irqsave(&port->sc_port.lock, flags);
-			sn_transmit_chars(port, 1);
+		}
+		/* flush anything in the serial core xmit buffer, raw */
+		sn_transmit_chars(port, 1);
+		if (got_lock) {
 			spin_unlock_irqrestore(&port->sc_port.lock, flags);
-
-			puts_raw_fixed(port->sc_ops->sal_puts_raw, s, count);
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
+			stole_lock = 0;
+		} else {
+			/* fell thru */
+			stole_lock = 1;
 		}
-#endif
-	}
-	else {
-		/* Not yet registered with serial core - simple case */
+		puts_raw_fixed(port->sc_ops->sal_puts_raw, s, count);
+	} else {
+		stole_lock = 0;
+		spin_lock_irqsave(&port->sc_port.lock, flags);
+		sn_transmit_chars(port, 1);
+		spin_unlock_irqrestore(&port->sc_port.lock, flags);
+
 		puts_raw_fixed(port->sc_ops->sal_puts_raw, s, count);
 	}
 }
