Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUEFDYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUEFDYo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 23:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbUEFDYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 23:24:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:57014 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261405AbUEFDYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 23:24:42 -0400
Subject: [PATCH] FIx race on tty close
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1083813541.19985.69.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 06 May 2004 13:19:02 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell !

Here's the patch fixing the race we talked about on irc, where the ldisc
close can race with the flush_to_ldisc workqueue.

This patch fixes it by killing the workqueue first.

Please bounce to Andrew if you are happy with it.

Ben.

===== drivers/char/tty_io.c 1.136 vs edited =====
--- 1.136/drivers/char/tty_io.c	Tue Apr 13 03:54:18 2004
+++ edited/drivers/char/tty_io.c	Mon May  3 11:50:46 2004
@@ -1267,6 +1267,18 @@
 #endif
 
 	/*
+	 * Prevent flush_to_ldisc() from rescheduling the work for later.  Then
+	 * kill any delayed work.
+	 */
+	clear_bit(TTY_DONT_FLIP, &tty->flags);
+	cancel_delayed_work(&tty->flip.work);
+
+	/*
+	 * Wait for ->hangup_work and ->flip.work handlers to terminate
+	 */
+	flush_scheduled_work();
+
+	/*
 	 * Shutdown the current line discipline, and reset it to N_TTY.
 	 * N.B. why reset ldisc when we're releasing the memory??
 	 */
@@ -1281,19 +1293,7 @@
 			(o_tty->ldisc.close)(o_tty);
 		module_put(o_tty->ldisc.owner);
 		o_tty->ldisc = ldiscs[N_TTY];
-	}
-	
-	/*
-	 * Prevent flush_to_ldisc() from rescheduling the work for later.  Then
-	 * kill any delayed work.
-	 */
-	clear_bit(TTY_DONT_FLIP, &tty->flags);
-	cancel_delayed_work(&tty->flip.work);
-
-	/*
-	 * Wait for ->hangup_work and ->flip.work handlers to terminate
-	 */
-	flush_scheduled_work();
+	}	
 
 	/* 
 	 * The release_mem function takes care of the details of clearing


