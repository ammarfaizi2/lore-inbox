Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271816AbTG2ONY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 10:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271834AbTG2ONY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 10:13:24 -0400
Received: from hera.cwi.nl ([192.16.191.8]:23998 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S271816AbTG2ONG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 10:13:06 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 29 Jul 2003 16:12:58 +0200 (MEST)
Message-Id: <UTC200307291412.h6TECwA17034.aeb@smtp.cwi.nl>
To: akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH] select fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently people complained on lk about a problem: one sees

select(2, NULL, [1], NULL, NULL)        = 1 (out [1])
write(1, "hi\n", 3)                     = -1 EAGAIN (Resource temporarily unavailable)

for a stopped tty opened with O_NONBLOCK. This violates POSIX,
and the 100% CPU use in a select loop does not look pretty either.
The below fixes this.

Andries

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/char/n_tty.c b/drivers/char/n_tty.c
--- a/drivers/char/n_tty.c	Thu Jul  3 09:26:43 2003
+++ b/drivers/char/n_tty.c	Tue Jul 29 16:53:10 2003
@@ -1231,7 +1231,8 @@
 }
 
 /* Called without the kernel lock held - fine */
-static unsigned int normal_poll(struct tty_struct * tty, struct file * file, poll_table *wait)
+static unsigned int
+normal_poll(struct tty_struct *tty, struct file *file, poll_table *wait)
 {
 	unsigned int mask = 0;
 
@@ -1251,27 +1252,27 @@
 		else
 			tty->minimum_to_wake = 1;
 	}
-	if (tty->driver->chars_in_buffer(tty) < WAKEUP_CHARS)
+	if (!tty->stopped && tty->driver->chars_in_buffer(tty) < WAKEUP_CHARS)
 		mask |= POLLOUT | POLLWRNORM;
 	return mask;
 }
 
 struct tty_ldisc tty_ldisc_N_TTY = {
-	TTY_LDISC_MAGIC,	/* magic */
-	"n_tty",		/* name */
-	0,			/* num */
-	0,			/* flags */
-	n_tty_open,		/* open */
-	n_tty_close,		/* close */
-	n_tty_flush_buffer,	/* flush_buffer */
-	n_tty_chars_in_buffer,	/* chars_in_buffer */
-	read_chan,		/* read */
-	write_chan,		/* write */
-	n_tty_ioctl,		/* ioctl */
-	n_tty_set_termios,	/* set_termios */
-	normal_poll,		/* poll */
-	n_tty_receive_buf,	/* receive_buf */
-	n_tty_receive_room,	/* receive_room */
-	n_tty_write_wakeup	/* write_wakeup */
+	.magic =		TTY_LDISC_MAGIC,
+	.name =			"n_tty",
+	.num =			0,
+	.flags =		0,
+	.open =			n_tty_open,
+	.close =		n_tty_close,
+	.flush_buffer =		n_tty_flush_buffer,
+	.chars_in_buffer =	n_tty_chars_in_buffer,
+	.read =			read_chan,
+	.write =		write_chan,
+	.ioctl =		n_tty_ioctl,
+	.set_termios =		n_tty_set_termios,
+	.poll =			normal_poll,
+	.receive_buf =		n_tty_receive_buf,
+	.receive_room =		n_tty_receive_room,
+	.write_wakeup =		n_tty_write_wakeup
 };
 
