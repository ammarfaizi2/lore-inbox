Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWHPQKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWHPQKB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWHPQKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:10:01 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58333 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750837AbWHPQKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:10:00 -0400
Subject: PATCH: lock ticogwinsz
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Aug 2006 17:30:44 +0100
Message-Id: <1155745844.24077.357.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now we lock the set ioctl its trivial to lock the get one so the data
copied is consistent. At the moment we have the BKL here but this
removes the need for it and is a step in the right direction

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc4-mm1/drivers/char/tty_io.c linux-2.6.18-rc4-mm1/drivers/char/tty_io.c
--- linux.vanilla-2.6.18-rc4-mm1/drivers/char/tty_io.c	2006-08-15 15:40:16.000000000 +0100
+++ linux-2.6.18-rc4-mm1/drivers/char/tty_io.c	2006-08-15 16:01:19.000000000 +0100
@@ -2746,18 +2742,21 @@
  *	@tty; tty
  *	@arg: user buffer for result
  *
- *	Copies the kernel idea of the window size into the user buffer. No
- *	locking is done.
+ *	Copies the kernel idea of the window size into the user buffer. 
  *
- *	FIXME: Returning random values racing a window size set is wrong
- *	should lock here against that
+ *	Locking: tty->termios_sem is taken to ensure the winsize data
+ *		is consistent.
  */
 
 static int tiocgwinsz(struct tty_struct *tty, struct winsize __user * arg)
 {
-	if (copy_to_user(arg, &tty->winsize, sizeof(*arg)))
-		return -EFAULT;
-	return 0;
+	int err;
+	
+	down(&tty->termios_sem);
+	err = copy_to_user(arg, &tty->winsize, sizeof(*arg));
+	up(&tty->termios_sem);
+	
+	return err ? -EFAULT: 0;
 }
 
 /**

