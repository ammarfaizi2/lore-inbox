Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263320AbTIAW17 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 18:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263322AbTIAW17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 18:27:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:8839 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263320AbTIAW1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 18:27:55 -0400
Date: Mon, 1 Sep 2003 15:28:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Dale E Martin" <dmartin@cliftonlabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: repeatable, hard lockup on boot in linux-2.6.0-test4 (more
 details)
Message-Id: <20030901152809.0311f46f.akpm@osdl.org>
In-Reply-To: <20030901195706.GA853@cliftonlabs.com>
References: <20030901182359.GA871@cliftonlabs.com>
	<20030901120412.2047eeff.akpm@osdl.org>
	<20030901195706.GA853@cliftonlabs.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Dale E Martin" <dmartin@cliftonlabs.com> wrote:
>
> > Are you able to plug any PS/2 devices into the machine, see if that makes
>  > a difference?
> 
>  Yes, plugging in a PS/2 mouse in addition to the USB mouse does allow the
>  machine to boot up.  (Just tried it, thanks for the suggestion.)

OK, don't go away yet ;)

Could you please add this patch and see how far it gets?  If you're keen,
keep adding more DB() statements, narrow it down further?


 drivers/input/serio/i8042.c |   23 ++++++++++++++++++-----
 include/linux/kernel.h      |    1 +
 2 files changed, 19 insertions(+), 5 deletions(-)

diff -puN drivers/input/serio/i8042.c~a drivers/input/serio/i8042.c
--- 25/drivers/input/serio/i8042.c~a	2003-09-01 15:24:02.000000000 -0700
+++ 25-akpm/drivers/input/serio/i8042.c	2003-09-01 15:25:31.000000000 -0700
@@ -831,36 +831,49 @@ int __init i8042_init(void)
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
diff -puN include/linux/kernel.h~a include/linux/kernel.h
--- 25/include/linux/kernel.h~a	2003-09-01 15:24:02.000000000 -0700
+++ 25-akpm/include/linux/kernel.h	2003-09-01 15:25:55.000000000 -0700
@@ -236,4 +236,5 @@ extern void BUILD_BUG(void);
 #define __FUNCTION__ (__func__)
 #endif
 
+#define DB() printk("%s:%d\n", __FILE__, __LINE__)
 #endif

_

