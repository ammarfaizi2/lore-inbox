Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWASJkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWASJkr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 04:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWASJkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 04:40:47 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:17072 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751390AbWASJkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 04:40:46 -0500
Subject: PATCH: Fix some ucLinux breakage from the tty updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Jan 2006 09:40:19 +0000
Message-Id: <1137663620.8471.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Breakage reported by Adrian Bunk

Untested (no hardware)

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc1/arch/v850/kernel/simcons.c linux-2.6.16-rc1/arch/v850/kernel/simcons.c
--- linux.vanilla-2.6.16-rc1/arch/v850/kernel/simcons.c	2006-01-17 15:36:18.000000000 +0000
+++ linux-2.6.16-rc1/arch/v850/kernel/simcons.c	2006-01-19 01:07:14.000000000 +0000
@@ -117,6 +117,7 @@
    tty driver.  */
 void simcons_poll_tty (struct tty_struct *tty)
 {
+	char buf[32];	/* Not the nicest way to do it but I need it correct first */
 	int flip = 0, send_break = 0;
 	struct pollfd pfd;
 	pfd.fd = 0;
@@ -124,21 +125,15 @@
 
 	if (V850_SIM_SYSCALL (poll, &pfd, 1, 0) > 0) {
 		if (pfd.revents & POLLIN) {
-			int left = TTY_FLIPBUF_SIZE - tty->flip.count;
-
-			if (left > 0) {
-				unsigned char *buf = tty->flip.char_buf_ptr;
-				int rd = V850_SIM_SYSCALL (read, 0, buf, left);
-
-				if (rd > 0) {
-					tty->flip.count += rd;
-					tty->flip.char_buf_ptr += rd;
-					memset (tty->flip.flag_buf_ptr, 0, rd);
-					tty->flip.flag_buf_ptr += rd;
-					flip = 1;
-				} else
-					send_break = 1;
-			}
+			/* Real block hardware knows the transfer size before
+			   transfer so the new tty buffering doesn't try to handle
+			   this rather weird simulator specific case well */
+			int rd = V850_SIM_SYSCALL (read, 0, buf, 32);
+			if (rd > 0) {
+				tty_insert_flip_string(tty, buf, rd);
+				flip = 1;
+			} else
+				send_break = 1;
 		} else if (pfd.revents & POLLERR)
 			send_break = 1;
 	}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc1/arch/xtensa/platform-iss/console.c linux-2.6.16-rc1/arch/xtensa/platform-iss/console.c
--- linux.vanilla-2.6.16-rc1/arch/xtensa/platform-iss/console.c	2006-01-17 15:36:18.000000000 +0000
+++ linux-2.6.16-rc1/arch/xtensa/platform-iss/console.c	2006-01-19 01:01:26.000000000 +0000
@@ -128,9 +128,7 @@
 
 	while (__simc(SYS_select_one, 0, XTISS_SELECT_ONE_READ, (int)&tv,0,0)){
 		__simc (SYS_read, 0, (unsigned long)&c, 1, 0, 0);
-		tty->flip.count++;
-		*tty->flip.char_buf_ptr++ = c;
-		*tty->flip.flag_buf_ptr++ = TTY_NORMAL;
+		tty_insert_flip_char(tty, c, TTY_NORMAL);
 		i++;
 	}
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc1/drivers/serial/mcfserial.c linux-2.6.16-rc1/drivers/serial/mcfserial.c
--- linux.vanilla-2.6.16-rc1/drivers/serial/mcfserial.c	2006-01-17 15:52:54.000000000 +0000
+++ linux-2.6.16-rc1/drivers/serial/mcfserial.c	2006-01-19 00:58:47.000000000 +0000
@@ -350,8 +350,7 @@
 		}
 		tty_insert_flip_char(tty, ch, flag);
 	}
-
-	schedule_work(&tty->flip.work);
+	tty_flip_buffer_push(tty);
 	return;
 }
 

