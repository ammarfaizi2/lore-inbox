Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265823AbUGHHCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbUGHHCN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 03:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265841AbUGHHAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 03:00:06 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:49794 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265823AbUGHG7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 02:59:17 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 2/8] New set of input patches
Date: Thu, 8 Jul 2004 01:56:03 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200407080155.07827.dtor_core@ameritech.net> <200407080155.38937.dtor_core@ameritech.net>
In-Reply-To: <200407080155.38937.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407080156.05021.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1821, 2004-07-08 00:23:10-05:00, dtor_core@ameritech.net
  Input: rearrange code in sunzilog so it registers its serio ports
         only after hardware was fully initialized and with interrupts
         tuned back on, otherwise it deadlocks.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 sunzilog.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)


===================================================================



diff -Nru a/drivers/serial/sunzilog.c b/drivers/serial/sunzilog.c
--- a/drivers/serial/sunzilog.c	2004-07-08 01:34:54 -05:00
+++ b/drivers/serial/sunzilog.c	2004-07-08 01:34:54 -05:00
@@ -1529,7 +1529,6 @@
 static void __init sunzilog_init_kbdms(struct uart_sunzilog_port *up, int channel)
 {
 	int baud, brg;
-	struct serio *serio;
 
 	if (channel == KEYBOARD_LINE) {
 		up->flags |= SUNZILOG_FLAG_CONS_KEYB;
@@ -1546,8 +1545,15 @@
 	up->curregs[R15] = BRKIE;
 	brg = BPS_TO_BRG(baud, ZS_CLOCK / ZS_CLOCK_DIVISOR);
 	sunzilog_convert_to_zs(up, up->cflag, 0, brg);
+	sunzilog_set_mctrl(&up->port, TIOCM_DTR | TIOCM_RTS);
+	__sunzilog_startup(up);
+}
 
 #ifdef CONFIG_SERIO
+static void __init sunzilog_register_serio(struct uart_sunzilog_port *up, int channel)
+{
+	struct serio *serio;
+
 	up->serio = serio = kmalloc(sizeof(struct serio), GFP_KERNEL);
 	if (serio) {
 
@@ -1576,11 +1582,8 @@
 		printk(KERN_WARNING "zs%d: not enough memory for serio port\n",
 			channel);
 	}
-#endif
-
-	sunzilog_set_mctrl(&up->port, TIOCM_DTR | TIOCM_RTS);
-	__sunzilog_startup(up);
 }
+#endif
 
 static void __init sunzilog_init_hw(void)
 {
@@ -1624,6 +1627,11 @@
 		}
 
 		spin_unlock_irqrestore(&up->port.lock, flags);
+
+#ifdef CONFIG_SERIO
+		if (i == KEYBOARD_LINE || i == MOUSE_LINE)
+			sunzilog_register_serio(up, i);
+#endif
 	}
 }
 
