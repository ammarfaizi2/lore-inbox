Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129282AbRCaXll>; Sat, 31 Mar 2001 18:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129446AbRCaXla>; Sat, 31 Mar 2001 18:41:30 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:60910
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S129282AbRCaXlS>; Sat, 31 Mar 2001 18:41:18 -0500
Date: Sat, 31 Mar 2001 16:38:08 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.3 and SysRq over serial console
Message-ID: <20010331163808.A9740@opus.bloom.county>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello all.  Without the attached patch, SysRq doesn't work over a serial
console here.  Has anyone else seen this problem?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sysrq.patch"

diff -Nru a/linux/drivers/char/n_tty.c b/linux/drivers/char/n_tty.c
--- a/linux/drivers/char/n_tty.c	Sat Mar 31 16:30:44 2001
+++ b/linux/drivers/char/n_tty.c	Sat Mar 31 16:30:44 2001
@@ -40,6 +40,10 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/poll.h>
+#ifdef CONFIG_MAGIC_SYSRQ	/* Handle the SysRq Hack */
+#include <linux/sysrq.h>
+#include <linux/console.h>
+#endif
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -458,6 +462,12 @@
 
 static inline void n_tty_receive_break(struct tty_struct *tty)
 {
+#ifdef CONFIG_MAGIC_SYSRQ	/* Handle the SysRq Hack */
+	struct console *c = console_drivers;
+	if (c && c->device && (c->device(c) == tty->device)
+	    && !test_and_change_bit(TTY_DOING_SYSRQ, &tty->flags))
+		return;
+#endif
 	if (I_IGNBRK(tty))
 		return;
 	if (I_BRKINT(tty)) {
@@ -506,6 +516,12 @@
 {
 	unsigned long flags;
 
+#ifdef CONFIG_MAGIC_SYSRQ	/* Handle the SysRq Hack */
+	if (test_and_clear_bit(TTY_DOING_SYSRQ, &tty->flags)) {
+		handle_sysrq(c, NULL, NULL, tty);
+		return;
+	}
+#endif
 	if (tty->raw) {
 		put_tty_queue(c, tty);
 		return;
diff -Nru a/linux/include/linux/tty.h b/linux/include/linux/tty.h
--- a/linux/include/linux/tty.h	Sat Mar 31 16:30:44 2001
+++ b/linux/include/linux/tty.h	Sat Mar 31 16:30:44 2001
@@ -329,6 +329,9 @@
 #define TTY_PUSH 6
 #define TTY_CLOSING 7
 #define TTY_DONT_FLIP 8
+#ifdef CONFIG_MAGIC_SYSRQ	/* Handle the SysRq Hack */
+#define TTY_DOING_SYSRQ 9
+#endif
 #define TTY_HW_COOK_OUT 14
 #define TTY_HW_COOK_IN 15
 #define TTY_PTY_LOCK 16

--a8Wt8u1KmwUX3Y2C--
