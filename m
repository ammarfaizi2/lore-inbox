Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265222AbUG2RDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265222AbUG2RDp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 13:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUG2Q7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 12:59:06 -0400
Received: from styx.suse.cz ([82.119.242.94]:64663 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S265222AbUG2Q6L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 12:58:11 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rearrange code in sunzilog to prevent deadlock
X-Mailer: gregkh_patchbomb_levon_offspring
Mime-Version: 1.0
Date: Thu, 29 Jul 2004 18:59:59 +0200
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10911203991808@twilight.ucw.cz>
In-Reply-To: <10911203991518@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1807.3.3, 2004-07-19 22:35:13-05:00, dtor_core@ameritech.net
  Input: rearrange code in sunzilog so it registers its serio ports
         only after hardware was fully initialized and with interrupts
         tuned back on, otherwise it deadlocks.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 sunzilog.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

===================================================================

diff -Nru a/drivers/serial/sunzilog.c b/drivers/serial/sunzilog.c
--- a/drivers/serial/sunzilog.c	Thu Jul 29 18:52:03 2004
+++ b/drivers/serial/sunzilog.c	Thu Jul 29 18:52:03 2004
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
 

