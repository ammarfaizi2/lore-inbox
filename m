Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbUCWEzy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 23:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbUCWEzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 23:55:54 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:51955 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S261990AbUCWEzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 23:55:42 -0500
Date: Tue, 23 Mar 2004 15:55:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linuxppc64-dev@lists.linuxppc.org
Subject: [PATCH] PPC64 iSeries virtual console cleanup (part 1)
Message-Id: <20040323155523.54fa5c7c.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__23_Mar_2004_15_55_23_+1100_ON1oYP9LlvETuHiT"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__23_Mar_2004_15_55_23_+1100_ON1oYP9LlvETuHiT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew,

This patch starts cleaing up (and paring down) the virtual console
driver.  It does:
	- viocons is NOT a serial driver
	- remove unneeded empty methods
	- change the console name

Please apply and merge to Linus.  Patch applies to 2.6.5-rc2-bk2
with my previous patch (simplyfying messages) applied.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.5-rc2-bk2.msg/drivers/char/viocons.c 2.6.5-rc2-bk2.msg.cons/drivers/char/viocons.c
--- 2.6.5-rc2-bk2.msg/drivers/char/viocons.c	2004-03-23 11:13:08.000000000 +1100
+++ 2.6.5-rc2-bk2.msg.cons/drivers/char/viocons.c	2004-03-23 15:39:02.000000000 +1100
@@ -57,7 +57,6 @@
 
 #define VIOTTY_MAGIC (0x0DCB)
 #define VTTY_PORTS 10
-#define VIOTTY_SERIAL_START 65
 
 #define VIOCONS_KERN_WARN	KERN_WARNING "viocons: "
 #define VIOCONS_KERN_INFO	KERN_INFO "viocons: "
@@ -141,7 +140,6 @@
 static void initDataEvent(struct viocharlpevent *viochar, HvLpIndex lp);
 
 static struct tty_driver *viotty_driver;
-static struct tty_driver *viottyS_driver;
 
 void hvlog(char *fmt, ...)
 {
@@ -658,14 +656,14 @@
  * console device I/O methods
  */
 static struct console viocons_early = {
-	.name = "ttyS",
+	.name = "viocons",
 	.write = viocons_write_early,
 	.flags = CON_PRINTBUFFER,
 	.index = -1,
 };
 
 static struct console viocons = {
-	.name = "ttyS",
+	.name = "viocons",
 	.write = viocons_write,
 	.device = viocons_device,
 	.flags = CON_PRINTBUFFER,
@@ -683,9 +681,6 @@
 
 	port = tty->index;
 
-	if (port >= VIOTTY_SERIAL_START)
-		port -= VIOTTY_SERIAL_START;
-
 	if ((port < 0) || (port >= VTTY_PORTS))
 		return -ENODEV;
 
@@ -823,13 +818,6 @@
 }
 
 /*
- * TTY flush_chars method
- */
-static void viotty_flush_chars(struct tty_struct *tty)
-{
-}
-
-/*
  * TTY write_room method
  */
 static int viotty_write_room(struct tty_struct *tty)
@@ -867,17 +855,13 @@
 }
 
 /*
- * TTY chars_in_buffer_room method
+ * TTY chars_in_buffer method
  */
 static int viotty_chars_in_buffer(struct tty_struct *tty)
 {
 	return 0;
 }
 
-static void viotty_flush_buffer(struct tty_struct *tty)
-{
-}
-
 static int viotty_ioctl(struct tty_struct *tty, struct file *file,
 			unsigned int cmd, unsigned long arg)
 {
@@ -897,43 +881,6 @@
 	return n_tty_ioctl(tty, file, cmd, arg);
 }
 
-static void viotty_throttle(struct tty_struct *tty)
-{
-}
-
-static void viotty_unthrottle(struct tty_struct *tty)
-{
-}
-
-static void viotty_set_termios(struct tty_struct *tty,
-		struct termios *old_termios)
-{
-}
-
-static void viotty_stop(struct tty_struct *tty)
-{
-}
-
-static void viotty_start(struct tty_struct *tty)
-{
-}
-
-static void viotty_hangup(struct tty_struct *tty)
-{
-}
-
-static void viotty_break(struct tty_struct *tty, int break_state)
-{
-}
-
-static void viotty_send_xchar(struct tty_struct *tty, char ch)
-{
-}
-
-static void viotty_wait_until_sent(struct tty_struct *tty, int timeout)
-{
-}
-
 /*
  * Handle an open charLpEvent.  Could be either interrupt or ack
  */
@@ -1277,20 +1224,9 @@
 	.close = viotty_close,
 	.write = viotty_write,
 	.put_char = viotty_put_char,
-	.flush_chars = viotty_flush_chars,
 	.write_room = viotty_write_room,
 	.chars_in_buffer = viotty_chars_in_buffer,
-	.flush_buffer = viotty_flush_buffer,
 	.ioctl = viotty_ioctl,
-	.throttle = viotty_throttle,
-	.unthrottle = viotty_unthrottle,
-	.set_termios = viotty_set_termios,
-	.stop = viotty_stop,
-	.start = viotty_start,
-	.hangup = viotty_hangup,
-	.break_ctl = viotty_break,
-	.send_xchar = viotty_send_xchar,
-	.wait_until_sent = viotty_wait_until_sent,
 };
 
 static int __init viocons_init2(void)
@@ -1368,31 +1304,12 @@
 	viotty_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_RESET_TERMIOS;
 	tty_set_operations(viotty_driver, &serial_ops);
 
-	viottyS_driver = alloc_tty_driver(VTTY_PORTS);
-	viottyS_driver->owner = THIS_MODULE;
-	viottyS_driver->driver_name = "vioconsole";
-	viottyS_driver->devfs_name = "tts/";
-	viottyS_driver->name = "ttyS";
-	viottyS_driver->major = TTY_MAJOR;
-	viottyS_driver->minor_start = VIOTTY_SERIAL_START;
-	viottyS_driver->type = TTY_DRIVER_TYPE_SERIAL;
-	viottyS_driver->subtype = 1;
-	viottyS_driver->init_termios = tty_std_termios;
-	viottyS_driver->flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_RESET_TERMIOS;
-	tty_set_operations(viottyS_driver, &serial_ops);
-
 	if (tty_register_driver(viotty_driver)) {
 		printk(VIOCONS_KERN_WARN "couldn't register console driver\n");
 		put_tty_driver(viotty_driver);
 		viotty_driver = NULL;
 	}
 
-	if (tty_register_driver(viottyS_driver)) {
-		printk(VIOCONS_KERN_WARN "couldn't register console S driver\n");
-		put_tty_driver(viottyS_driver);
-		viottyS_driver = NULL;
-	}
-
 	viocons_init_cfu_buffer();
 
 	unregister_console(&viocons_early);

--Signature=_Tue__23_Mar_2004_15_55_23_+1100_ON1oYP9LlvETuHiT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAX8M7FG47PeJeR58RAtgyAJ9qmgq46T/4sR1QZiiveOQCXx5jmQCfcMtW
b19CekxvggLcQa1knSP1ZZw=
=iWvz
-----END PGP SIGNATURE-----

--Signature=_Tue__23_Mar_2004_15_55_23_+1100_ON1oYP9LlvETuHiT--
