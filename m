Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270618AbRHIXqS>; Thu, 9 Aug 2001 19:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270619AbRHIXqK>; Thu, 9 Aug 2001 19:46:10 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:5570 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S270618AbRHIXpw>; Thu, 9 Aug 2001 19:45:52 -0400
Date: Fri, 10 Aug 2001 00:44:52 +0100
From: Tim Waugh <twaugh@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: lp and LP_CONSOLE
Message-ID: <20010810004452.D1629@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch to prevent lp from being pinned in memory when
CONFIG_LP_CONSOLE is enabled.

Tim.
*/

2001-08-09  Tim Waugh  <twaugh@redhat.com>

	* drivers/char/lp.c: Don't pin module down in memory if console
	code is enabled; use unregister_console instead.

--- linux/drivers/char/lp.c.con	Fri Aug 10 00:23:17 2001
+++ linux/drivers/char/lp.c	Fri Aug 10 00:43:56 2001
@@ -147,6 +147,10 @@
 
 static unsigned int lp_count = 0;
 
+#ifdef CONFIG_LP_CONSOLE
+static struct parport *console_registered; // initially NULL
+#endif /* CONFIG_LP_CONSOLE */
+
 #undef LP_DEBUG
 
 /* --- low-level port access ----------------------------------- */
@@ -674,8 +678,8 @@
 #ifdef CONFIG_LP_CONSOLE
 	if (!nr) {
 		if (port->modes & PARPORT_MODE_SAFEININT) {
-			MOD_INC_USE_COUNT;
 			register_console (&lpcons);
+			console_registered = port;
 			printk (KERN_INFO "lp%d: console ready\n", CONSOLE_LP);
 		} else
 			printk (KERN_ERR "lp%d: cannot run console on %s\n",
@@ -720,6 +724,12 @@
 static void lp_detach (struct parport *port)
 {
 	/* Write this some day. */
+#ifdef CONFIG_LP_CONSOLE
+	if (console_registered == port) {
+		unregister_console (&lpcons);
+		console_registered = NULL;
+	}
+#endif /* CONFIG_LP_CONSOLE */
 }
 
 static struct parport_driver lp_driver = {
