Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263385AbTIBBXZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 21:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263402AbTIBBXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 21:23:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:41193 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263385AbTIBBXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 21:23:18 -0400
Date: Mon, 1 Sep 2003 18:23:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Dale E Martin" <dmartin@cliftonlabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: repeatable, hard lockup on boot in linux-2.6.0-test4 (more
 details)
Message-Id: <20030901182335.4c2e220f.akpm@osdl.org>
In-Reply-To: <20030902003146.GA870@cliftonlabs.com>
References: <20030901195706.GA853@cliftonlabs.com>
	<20030901152809.0311f46f.akpm@osdl.org>
	<20030902003146.GA870@cliftonlabs.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Dale E Martin" <dmartin@cliftonlabs.com> wrote:
>
> > OK, don't go away yet ;)
> > 
> > Could you please add this patch and see how far it gets?  If you're keen,
> > keep adding more DB() statements, narrow it down further?
> 
> It made it to line 853, and the loop ran four times.  No other "DB" ever
> printed anything, so I guess it locked up inside i8042_init_mux_values when
> i = 3.
> 

I'd be more suspecting that it got through that loop and locked up in
i8042_check_mux() or i8042_check_aux().

Can you try this one please?


 drivers/input/serio/i8042.c |   44 ++++++++++++++++++++++++++++++++++++++------
 include/linux/kernel.h      |    1 +
 2 files changed, 39 insertions(+), 6 deletions(-)

diff -puN drivers/input/serio/i8042.c~i8042-debug drivers/input/serio/i8042.c
--- 25/drivers/input/serio/i8042.c~i8042-debug	2003-09-01 18:17:56.000000000 -0700
+++ 25-akpm/drivers/input/serio/i8042.c	2003-09-01 18:21:53.000000000 -0700
@@ -587,16 +587,19 @@ static int __init i8042_check_mux(struct
  * Check if AUX irq is available.
  */
 
+	DB();
 	if (request_irq(values->irq, i8042_interrupt, SA_SHIRQ,
 				"i8042", i8042_request_irq_cookie))
                 return -1;
+	DB();
 	free_irq(values->irq, i8042_request_irq_cookie);
-
+	DB();
 /*
  * Get rid of bytes in the queue.
  */
 
 	i8042_flush();
+	DB();
 
 /*
  * Internal loopback test - send three bytes, they should come back from the
@@ -607,13 +610,16 @@ static int __init i8042_check_mux(struct
 	param = 0xf0;
 	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0x0f)
 		return -1;
+	DB();
 	param = 0x56;
 	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0xa9)
 		return -1;
+	DB();
 	param = 0xa4;
 	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param == 0x5b)
 		return -1;
 
+	DB();
 	printk(KERN_INFO "i8042.c: Detected active multiplexing controller, rev %d.%d.\n",
 		(~param >> 4) & 0xf, ~param & 0xf);
 
@@ -630,6 +636,7 @@ static int __init i8042_check_mux(struct
 	i8042_ctr &= I8042_CTR_AUXDIS;
 	i8042_ctr &= ~I8042_CTR_AUXINT;
 
+	DB();
 	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR))
 		return -1;
 
@@ -638,7 +645,9 @@ static int __init i8042_check_mux(struct
  */
 
 	for (i = 0; i < 4; i++) {
+		DB();
 		i8042_command(&param, I8042_CMD_MUX_PFX + i);
+		DB();
 		i8042_command(&param, I8042_CMD_AUX_ENABLE);
 	}
 
@@ -659,15 +668,18 @@ static int __init i8042_check_aux(struct
  * in trying to detect AUX presence.
  */
 
+	DB();
 	if (request_irq(values->irq, i8042_interrupt, SA_SHIRQ,
 				"i8042", i8042_request_irq_cookie))
                 return -1;
+	DB();
 	free_irq(values->irq, i8042_request_irq_cookie);
 
 /*
  * Get rid of bytes in the queue.
  */
 
+	DB();
 	i8042_flush();
 
 /*
@@ -677,6 +689,7 @@ static int __init i8042_check_aux(struct
  */
 
 	param = 0x5a;
+	DB();
 	if (i8042_command(&param, I8042_CMD_AUX_LOOP) || param != 0xa5) {
 
 /*
@@ -687,6 +700,7 @@ static int __init i8042_check_aux(struct
  * AUX ports, we test for this only when the LOOP command failed.
  */
 
+		DB();
 		if (i8042_command(&param, I8042_CMD_AUX_TEST)
 		    	|| (param && param != 0xfa && param != 0xff))
 				return -1;
@@ -696,13 +710,17 @@ static int __init i8042_check_aux(struct
  * Bit assignment test - filters out PS/2 i8042's in AT mode
  */
 	
+	DB();
 	if (i8042_command(&param, I8042_CMD_AUX_DISABLE))
 		return -1;
+	DB();
 	if (i8042_command(&param, I8042_CMD_CTL_RCTR) || (~param & I8042_CTR_AUXDIS))
 		return -1;	
 
+	DB();
 	if (i8042_command(&param, I8042_CMD_AUX_ENABLE))
 		return -1;
+	DB();
 	if (i8042_command(&param, I8042_CMD_CTL_RCTR) || (param & I8042_CTR_AUXDIS))
 		return -1;	
 
@@ -713,6 +731,7 @@ static int __init i8042_check_aux(struct
 	i8042_ctr |= I8042_CTR_AUXDIS;
 	i8042_ctr &= ~I8042_CTR_AUXINT;
 
+	DB();
 	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR))
 		return -1;
 
@@ -831,36 +850,49 @@ int __init i8042_init(void)
 {
 	int i;
 
+	DB();
 	dbg_init();
 
+	DB();
 	if (i8042_platform_init())
 		return -EBUSY;
 
 	i8042_aux_values.irq = I8042_AUX_IRQ;
 	i8042_kbd_values.irq = I8042_KBD_IRQ;
 
+	DB();
 	if (i8042_controller_init())
 		return -ENODEV;
 
+	DB();
 	if (i8042_dumbkbd)
 		i8042_kbd_port.write = NULL;
 
-	for (i = 0; i < 4; i++)
+	for (i = 0; i < 4; i++) {
+		DB();
 		i8042_init_mux_values(i8042_mux_values + i, i8042_mux_port + i, i);
+	}
 
-	if (!i8042_nomux && !i8042_check_mux(&i8042_aux_values))
-		for (i = 0; i < 4; i++)
+	if (!i8042_nomux && !i8042_check_mux(&i8042_aux_values)) {
+		for (i = 0; i < 4; i++) {
+			DB();
 			i8042_port_register(i8042_mux_values + i, i8042_mux_port + i);
-	else 
-		if (!i8042_noaux && !i8042_check_aux(&i8042_aux_values))
+		}
+	} else {
+		if (!i8042_noaux && !i8042_check_aux(&i8042_aux_values)) {
+			DB();
 			i8042_port_register(&i8042_aux_values, &i8042_aux_port);
+		}
+	}
 
+	DB();
 	i8042_port_register(&i8042_kbd_values, &i8042_kbd_port);
 
 	init_timer(&i8042_timer);
 	i8042_timer.function = i8042_timer_func;
 	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
 
+	DB();
 	register_reboot_notifier(&i8042_notifier);
 
 	return 0;
diff -puN include/linux/kernel.h~i8042-debug include/linux/kernel.h
--- 25/include/linux/kernel.h~i8042-debug	2003-09-01 18:17:56.000000000 -0700
+++ 25-akpm/include/linux/kernel.h	2003-09-01 18:17:56.000000000 -0700
@@ -236,4 +236,5 @@ extern void BUILD_BUG(void);
 #define __FUNCTION__ (__func__)
 #endif
 
+#define DB() printk("%s:%d\n", __FILE__, __LINE__)
 #endif

_

