Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbUKQEjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbUKQEjB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 23:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbUKQEhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 23:37:05 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:52747 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262211AbUKQEem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 23:34:42 -0500
Date: Wed, 17 Nov 2004 05:32:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] small char/generic_serial.c cleanup (fwd)
Message-ID: <20041117043221.GE4943@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch below still applies and compiles against 2.6.10-rc2-mm1.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sat, 6 Nov 2004 23:31:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] small char/generic_serial.c cleanup

The patch below does the following changes to 
drivers/char/generic_serial.c :
- make two needlessly global functions static
- remove the completely unused EXPORT_SYMBOL'ed function gs_do_softint

AFAIR the latter should be safe, since drivers are moving away from 
generic_serial.c .


diffstat output:
 drivers/char/generic_serial.c  |   26 ++------------------------
 include/linux/generic_serial.h |    1 -
 2 files changed, 2 insertions(+), 25 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/include/linux/generic_serial.h.old	2004-11-06 22:05:36.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/include/linux/generic_serial.h	2004-11-06 22:05:43.000000000 +0100
@@ -82,7 +82,6 @@
 void gs_stop(struct tty_struct *tty);
 void gs_start(struct tty_struct *tty);
 void gs_hangup(struct tty_struct *tty);
-void gs_do_softint(void *private_);
 int  gs_block_til_ready(void *port, struct file *filp);
 void gs_close(struct tty_struct *tty, struct file *filp);
 void gs_set_termios (struct tty_struct * tty, 
--- linux-2.6.10-rc1-mm3-full/drivers/char/generic_serial.c.old	2004-11-06 22:04:43.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/char/generic_serial.c	2004-11-06 22:05:20.000000000 +0100
@@ -279,7 +279,7 @@
 }
 
 
-int gs_real_chars_in_buffer(struct tty_struct *tty)
+static int gs_real_chars_in_buffer(struct tty_struct *tty)
 {
 	struct gs_port *port;
 	func_enter ();
@@ -457,7 +457,7 @@
 }
 
 
-void gs_shutdown_port (struct gs_port *port)
+static void gs_shutdown_port (struct gs_port *port)
 {
 	unsigned long flags;
 
@@ -511,27 +511,6 @@
 }
 
 
-void gs_do_softint(void *private_)
-{
-	struct gs_port *port = private_;
-	struct tty_struct *tty;
-
-	func_enter ();
-
-	if (!port) return;
-
-	tty = port->tty;
-
-	if (!tty) return;
-
-	if (test_and_clear_bit(RS_EVENT_WRITE_WAKEUP, &port->event)) {
-		tty_wakeup(tty);
-		wake_up_interruptible(&tty->write_wait);
-	}
-	func_exit ();
-}
-
-
 int gs_block_til_ready(void *port_, struct file * filp)
 {
 	struct gs_port *port = port_;
@@ -996,7 +975,6 @@
 EXPORT_SYMBOL(gs_stop);
 EXPORT_SYMBOL(gs_start);
 EXPORT_SYMBOL(gs_hangup);
-EXPORT_SYMBOL(gs_do_softint);
 EXPORT_SYMBOL(gs_block_til_ready);
 EXPORT_SYMBOL(gs_close);
 EXPORT_SYMBOL(gs_set_termios);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

