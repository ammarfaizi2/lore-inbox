Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422853AbWKHUZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422853AbWKHUZo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422863AbWKHUZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:25:44 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:23725 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422853AbWKHUZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:25:44 -0500
Subject: [PATCH] tty_ioctl: Replace previous patches with this
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Nov 2006 20:30:23 +0000
Message-Id: <1163017823.23956.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This sorts out the termios/termios2 handling as before but also merges a
tiny fix from Andrew that broke compiles and also a further readjustment
of the memcpy handling which cleans up slightly and also fixed a test
suite failure.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc4-mm1/drivers/char/tty_ioctl.c linux-2.6.19-rc4-mm1/drivers/char/tty_ioctl.c
--- linux.vanilla-2.6.19-rc4-mm1/drivers/char/tty_ioctl.c	2006-10-31 21:11:49.000000000 +0000
+++ linux-2.6.19-rc4-mm1/drivers/char/tty_ioctl.c	2006-11-08 16:49:04.000000000 +0000
@@ -399,23 +399,27 @@
 	if (retval)
 		return retval;
 
+	memcpy(&tmp_termios, tty->termios, sizeof(struct ktermios));
+
 	if (opt & TERMIOS_TERMIO) {
-		memcpy(&tmp_termios, tty->termios, sizeof(struct ktermios));
 		if (user_termio_to_kernel_termios(&tmp_termios,
 						(struct termio __user *)arg))
 			return -EFAULT;
 #ifdef TCGETS2
 	} else if (opt & TERMIOS_OLD) {
-		memcpy(&tmp_termios, tty->termios, sizeof(struct termios));
 		if (user_termios_to_kernel_termios_1(&tmp_termios,
-						(struct termios_v1 __user *)arg))
+						(struct termios __user *)arg))
 			return -EFAULT;
-#endif
 	} else {
 		if (user_termios_to_kernel_termios(&tmp_termios,
-						(struct termios __user *)arg))
+						(struct termios2 __user *)arg))
 			return -EFAULT;
 	}
+#else
+	} else if (user_termios_to_kernel_termios(&tmp_termios,
+					(struct termios __user *)arg))
+		return -EFAULT;
+#endif
 
 	/* If old style Bfoo values are used then load c_ispeed/c_ospeed with the real speed
 	   so its unconditionally usable */
@@ -707,11 +711,11 @@
 			return 0;
 #else
 		case TCGETS:
-			if (kernel_termios_to_user_termios_1((struct termios_v1 __user *)arg, real_tty->termios))
+			if (kernel_termios_to_user_termios_1((struct termios __user *)arg, real_tty->termios))
 				return -EFAULT;
 			return 0;
 		case TCGETS2:
-			if (kernel_termios_to_user_termios((struct termios __user *)arg, real_tty->termios))
+			if (kernel_termios_to_user_termios((struct termios2 __user *)arg, real_tty->termios))
 				return -EFAULT;
 			return 0;
 		case TCSETSF2:

