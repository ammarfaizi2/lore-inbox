Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965225AbWKGQJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965225AbWKGQJj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 11:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbWKGQJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 11:09:38 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:31901 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965225AbWKGQJi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 11:09:38 -0500
Subject: [PATCH] tty_ioctl: use termios for the old structure and termios2
	for the new
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 07 Nov 2006 16:13:09 +0000
Message-Id: <1162915989.11073.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having split out the user and kernel structures it turns out that some
non glibc C libraries pull their termios struct from the kernel headers
directly or indirectly. This means we must keep "struct termios" as the
library sees it correct for the old ioctls. Not a big problem just
shuffle the names and ifdef around a bit

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc4-mm1/drivers/char/tty_ioctl.c linux-2.6.19-rc4-mm1/drivers/char/tty_ioctl.c
--- linux.vanilla-2.6.19-rc4-mm1/drivers/char/tty_ioctl.c	2006-10-31 21:11:49.000000000 +0000
+++ linux-2.6.19-rc4-mm1/drivers/char/tty_ioctl.c	2006-11-07 10:05:02.000000000 +0000
@@ -408,14 +408,18 @@
 	} else if (opt & TERMIOS_OLD) {
 		memcpy(&tmp_termios, tty->termios, sizeof(struct termios));
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
+	else if (user_termios_to_kernel_termios(&tmp_termios,
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

