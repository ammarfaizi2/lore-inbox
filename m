Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129855AbRB0WFQ>; Tue, 27 Feb 2001 17:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129854AbRB0WE5>; Tue, 27 Feb 2001 17:04:57 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:35554 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129813AbRB0WEx>; Tue, 27 Feb 2001 17:04:53 -0500
Date: Tue, 27 Feb 2001 22:04:46 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.2: irq-driven lp stalls
Message-ID: <20010227220446.U13721@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch seems to cure some printing stalls that some people have
been seeing.  The down_trylock call isn't really needed there anyway.

Please apply.

Tim.
*/

2001-02-27  Tim Waugh  <twaugh@redhat.com>

	* drivers/parport/ieee1284_ops.c: Remove down_trylock call,
	which seems to prevent stalls.
	* drivers/parport/ChangeLog: Updated.

--- linux/drivers/parport/ieee1284_ops.c.sema	Tue Feb 27 21:43:49 2001
+++ linux/drivers/parport/ieee1284_ops.c	Tue Feb 27 21:44:16 2001
@@ -50,9 +50,6 @@
 	if (port->irq != PARPORT_IRQ_NONE) {
 		parport_enable_irq (port);
 		no_irq = 0;
-
-		/* Clear out previous irqs. */
-		while (!down_trylock (&port->physport->ieee1284.irq));
 	}
 
 	port->physport->ieee1284.phase = IEEE1284_PH_FWD_DATA;
--- linux/drivers/parport/ChangeLog.sema	Tue Feb 27 21:44:21 2001
+++ linux/drivers/parport/ChangeLog	Tue Feb 27 21:45:43 2001
@@ -0,0 +1,7 @@
+2001-02-27  Tim Waugh  <twaugh@redhat.com>
+
+	* ieee1284_ops.c (parport_ieee1284_write_compat): Don't use
+	down_trylock to reset the IRQ count.  Don't even use sema_init,
+	because it's not even necessary to reset the count.  I can't
+	remember why we ever did.
+
