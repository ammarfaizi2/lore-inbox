Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263369AbTLAG7n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 01:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263402AbTLAG7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 01:59:43 -0500
Received: from smtp800.mail.ukl.yahoo.com ([217.12.12.142]:33180 "HELO
	smtp800.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263369AbTLAG7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 01:59:40 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [2.6 RFC/PATCH] Input: possible deadlock in i8042
Date: Mon, 1 Dec 2003 01:59:30 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>
References: <200311300303.57654.dtor_core@ameritech.net> <20031130090009.GA17038@ucw.cz>
In-Reply-To: <20031130090009.GA17038@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312010159.32255.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================


ChangeSet@1.1513, 2003-11-30 23:38:00-05:00, dtor_core@ameritech.net
  Input: Unregister port not only when there us no free IRQ
         available but also when write to control register
         failed.
  
         Use serio_unregister_port_delayed in i8042_open to
         avoid deadlock on serio_sem.
  
         Also logging moved a bit


 i8042.c |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Mon Dec  1 01:15:56 2003
+++ b/drivers/input/serio/i8042.c	Mon Dec  1 01:15:56 2003
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
+	serio_unregister_port_delayed(port);
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
