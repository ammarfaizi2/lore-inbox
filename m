Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289969AbSAKOdT>; Fri, 11 Jan 2002 09:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289968AbSAKOdK>; Fri, 11 Jan 2002 09:33:10 -0500
Received: from falcon.etf.bg.ac.yu ([147.91.8.233]:64896 "EHLO
	falcon.etf.bg.ac.yu") by vger.kernel.org with ESMTP
	id <S289967AbSAKOct>; Fri, 11 Jan 2002 09:32:49 -0500
Date: Fri, 11 Jan 2002 15:30:36 +0100 (CET)
From: Bosko Radivojevic <bole@falcon.etf.bg.ac.yu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>, <linus@transmeta.com>,
        <marcelo@conectiva.com.br>
Subject: Re: [PATCH] suser to capable changes in char driver
In-Reply-To: <E16P2ZH-0007m9-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0201111526080.1893-100000@falcon.etf.bg.ac.yu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Jan 2002, Alan Cox wrote:

> Think so - thats what suser() itself did so it cant be worse 8)

Maybe we need more capabilities for finer grained privileges...
CAP_SYS_ADMIN is too powerful :)

So, again, the patch. Patch is made against 2.4.16.

diff -urN linux-2.4.16-vanilla/drivers/char/tty_io.c linux-2.4.16/drivers/char/tty_io.c
--- linux-2.4.16-vanilla/drivers/char/tty_io.c	Sat Nov  3 02:26:17 2001
+++ linux-2.4.16/drivers/char/tty_io.c	Fri Jan 11 06:24:16 2002
@@ -1377,7 +1377,7 @@
 		retval = -ENODEV;
 	filp->f_flags = saved_flags;

-	if (!retval && test_bit(TTY_EXCLUSIVE, &tty->flags) && !suser())
+	if (!retval && test_bit(TTY_EXCLUSIVE, &tty->flags) && !capable(CAP_SYS_TTY_CONFIG))
 		retval = -EBUSY;

 	if (retval) {
@@ -1479,7 +1479,7 @@
 {
 	char ch, mbz = 0;

-	if ((current->tty != tty) && !suser())
+	if ((current->tty != tty) && !capable(CAP_SYS_TTY_CONFIG))
 		return -EPERM;
 	if (get_user(ch, arg))
 		return -EFAULT;
@@ -1517,7 +1517,7 @@
 {
 	if (inode->i_rdev == SYSCONS_DEV ||
 	    inode->i_rdev == CONSOLE_DEV) {
-		if (!suser())
+		if (!capable(CAP_SYS_TTY_CONFIG))
 			return -EPERM;
 		redirect = NULL;
 		return 0;
@@ -1559,7 +1559,7 @@
 		 * This tty is already the controlling
 		 * tty for another session group!
 		 */
-		if ((arg == 1) && suser()) {
+		if ((arg == 1) && capable(CAP_SYS_ADMIN)) {
 			/*
 			 * Steal it away
 			 */
diff -urN linux-2.4.16-vanilla/drivers/char/vt.c linux-2.4.16/drivers/char/vt.c
--- linux-2.4.16-vanilla/drivers/char/vt.c	Fri Nov 16 19:08:28 2001
+++ linux-2.4.16/drivers/char/vt.c	Fri Jan 11 06:25:36 2002
@@ -440,10 +440,11 @@

 	/*
 	 * To have permissions to do most of the vt ioctls, we either have
-	 * to be the owner of the tty, or super-user.
+	 * to be the owner of the tty, or to have CAP_SYS_TTY_CONFIG
+	 * capability.
 	 */
 	perm = 0;
-	if (current->tty == tty || suser())
+	if (current->tty == tty || capable(CAP_SYS_TTY_CONFIG))
 		perm = 1;

 	kbd = kbd_table + console;
@@ -1038,12 +1039,12 @@
 		return do_unimap_ioctl(cmd, (struct unimapdesc *)arg, perm);

 	case VT_LOCKSWITCH:
-		if (!suser())
+		if (!capable(CAP_SYS_TTY_CONFIG))
 		   return -EPERM;
 		vt_dont_switch = 1;
 		return 0;
 	case VT_UNLOCKSWITCH:
-		if (!suser())
+		if (!capable(CAP_SYS_TTY_CONFIG))
 		   return -EPERM;
 		vt_dont_switch = 0;
 		return 0;

