Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751593AbWFKOIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbWFKOIz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 10:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbWFKOIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 10:08:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61448 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751591AbWFKOIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 10:08:52 -0400
Date: Sun, 11 Jun 2006 15:08:37 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>, Dave Jones <davej@redhat.com>,
       Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       Paul Dickson <paul@permanentmail.com>, linux-kernel@vger.kernel.org,
       jeremy@goop.org
Subject: Re: Bisects that are neither good nor bad
Message-ID: <20060611140836.GB25561@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Dave Jones <davej@redhat.com>,
	Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Paul Dickson <paul@permanentmail.com>, linux-kernel@vger.kernel.org,
	jeremy@goop.org
References: <20060528140854.34ddec2a.paul@permanentmail.com> <200605282324.13431.rjw@sisk.pl> <200605282324.13431.rjw@sisk.pl> <20060528213414.GC5741@redhat.com> <r6u079rrik.fsf@skye.ra.phy.cam.ac.uk> <20060529145255.GB32274@redhat.com> <20060530152926.GA4103@ucw.cz> <20060603091133.GA24271@flint.arm.linux.org.uk> <20060609083833.GD18084@elf.ucw.cz> <20060609084234.GA25497@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060609084234.GA25497@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 09:42:34AM +0100, Russell King wrote:
> The only sane solution is for the tty layer to be adjusted to allow
> suspend/resume support for consoles.

And for those who can't work out how to do that, here's something which
_probably_ does it.  Would folk mind testing it out please?

diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -1674,6 +1674,19 @@ release_mem_out:
 }
 
 /*
+ * Get a copy of the termios structure for the driver/index
+ */
+void tty_get_termios(struct tty_driver *driver, int idx, struct termios *tio)
+{
+	lock_kernel();
+	if (driver->termios[idx])
+		*tio = *driver->termios[idx];
+	else
+		*tio = driver->init_termios;
+	unlock_kernel();
+}
+
+/*
  * Releases memory associated with a tty structure, and clears out the
  * driver table slots.
  */
diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -1968,16 +1968,16 @@ int uart_resume_port(struct uart_driver 
 		struct termios termios;
 
 		/*
-		 * First try to use the console cflag setting.
+		 * Get the termios for this line
 		 */
-		memset(&termios, 0, sizeof(struct termios));
-		termios.c_cflag = port->cons->cflag;
+		tty_get_termios(drv->tty_driver, port->line, &termios);
 
 		/*
-		 * If that's unset, use the tty termios setting.
+		 * If the console cflag is still set, subsitute that
+		 * for the termios cflag.
 		 */
-		if (state->info && state->info->tty && termios.c_cflag == 0)
-			termios = *state->info->tty->termios;
+		if (port->cons->cflag)
+			termios.c_cflag = port->cons->cflag;
 
 		port->ops->set_termios(port, &termios, NULL);
 		console_start(port->cons);
diff --git a/include/linux/tty.h b/include/linux/tty.h
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -297,6 +297,8 @@ extern int tty_read_raw_data(struct tty_
 			     int buflen);
 extern void tty_write_message(struct tty_struct *tty, char *msg);
 
+extern void tty_get_termios(struct tty_driver *drv, int idx, struct termios *tio);
+
 extern int is_orphaned_pgrp(int pgrp);
 extern int is_ignored(int sig);
 extern int tty_signal(int sig, struct tty_struct *tty);


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
