Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264879AbTK3IIX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 03:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbTK3IIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 03:08:23 -0500
Received: from smtp800.mail.ukl.yahoo.com ([217.12.12.142]:29058 "HELO
	smtp800.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S264879AbTK3IIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 03:08:20 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [2.6 PATCH] Input: unregister i8042 port when writing to control register fails
Date: Sun, 30 Nov 2003 03:08:12 -0500
User-Agent: KMail/1.5.4
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311300308.12813.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that if we can't write to the control register it's not less critical
than not having a free IRQ so we better unregister port in this case as well.

Also logging moved a bit.

Dmitry

===================================================================

ChangeSet@1.1513, 2003-11-30 02:50:21-05:00, dtor_core@ameritech.net
  Input: Unregister port not only when there us no free IRQ
         available but also when write to control register 
         failed.
         Also moved logging a bit.


 i8042.c |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Sun Nov 30 03:06:50 2003
+++ b/drivers/input/serio/i8042.c	Sun Nov 30 03:06:50 2003
@@ -231,21 +231,29 @@
 	if (request_irq(values->irq, i8042_interrupt,
 			SA_SHIRQ, "i8042", i8042_request_irq_cookie)) {
 		printk(KERN_ERR "i8042.c: Can't get irq %d for %s, unregistering the port.\n", values->irq, values->name);
-		values->exists = 0;
-		serio_unregister_port(port);
-		return -1;
+		goto irq_fail;
 	}
 
 	i8042_ctr |= values->irqen;
 
 	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
-		printk(KERN_ERR "i8042.c: Can't write CTR while opening %s.\n", values->name);
-		return -1;
+		printk(KERN_ERR "i8042.c: Can't write CTR while opening %s, unregistering the port\n", values->name);
+		goto ctr_fail;
 	}
 
 	i8042_interrupt(0, NULL, NULL);
 
 	return 0;
+
+ctr_fail:
+	i8042_ctr &= ~values->irqen;
+	free_irq(values->irq, i8042_request_irq_cookie);
+
+irq_fail:
+	values->exists = 0;
+	serio_unregister_port(port);
+
+	return -1;
 }
 
 /*
@@ -691,13 +699,13 @@
 		return -1; 
 	}
 
-	serio_register_port(port);
-
 	printk(KERN_INFO "serio: i8042 %s port at %#lx,%#lx irq %d\n",
 	       values->name,
 	       (unsigned long) I8042_DATA_REG,
 	       (unsigned long) I8042_COMMAND_REG,
 	       values->irq);
+
+	serio_register_port(port);
 
 	return 0;
 }

