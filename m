Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263915AbTCVWfH>; Sat, 22 Mar 2003 17:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263916AbTCVWfH>; Sat, 22 Mar 2003 17:35:07 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:7813
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263915AbTCVWfF>; Sat, 22 Mar 2003 17:35:05 -0500
Date: Sat, 22 Mar 2003 23:50:47 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303222350.h2MNolxF020673@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: redo the n_tty fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Two problems with the original change

1. We should return bytes actually processed on an error according to
SuS/POSIX. Technically the EFAULT path is outside the spec but its best
we follow

2. We need to fix most of this anyway because the final section of the
change was wrong. If retval was set we retried and got an efault again
in some cases

I think this way of doing it is right but it could do with further
review

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/char/n_tty.c linux-2.5.65-ac3/drivers/char/n_tty.c
--- linux-2.5.65-bk3/drivers/char/n_tty.c	2003-03-22 19:35:11.000000000 +0000
+++ linux-2.5.65-ac3/drivers/char/n_tty.c	2003-03-22 20:27:06.000000000 +0000
@@ -1029,8 +1029,10 @@
 				break;
 			cs = tty->link->ctrl_status;
 			tty->link->ctrl_status = 0;
-			if (put_user(cs, b++)) {
+			if (put_user(cs, b++))
+			{
 				retval = -EFAULT;
+				b--;
 				break;
 			}
 			nr--;
@@ -1071,8 +1073,9 @@
 
 		/* Deal with packet mode. */
 		if (tty->packet && b == buf) {
-			if (put_user(TIOCPKT_DATA, b++)) {
+			if (put_user(TIOCPKT_DATA, b++)) {
 				retval = -EFAULT;
+				b--;
 				break;
 			}
 			nr--;
@@ -1101,8 +1104,9 @@
 				spin_unlock_irqrestore(&tty->read_lock, flags);
 
 				if (!eol || (c != __DISABLED_CHAR)) {
-					if (put_user(c, b++)) {
+					if (put_user(c, b++)) {
 						retval = -EFAULT;
+						b--;
 						break;
 					}
 					nr--;
@@ -1110,7 +1114,7 @@
 				if (eol)
 					break;
 			}
-			if (retval)
+			if (retval)
 				break;
 		} else {
 			int uncopied;
@@ -1146,7 +1150,7 @@
 
 	current->state = TASK_RUNNING;
 	size = b - buf;
-	if (!retval && size) {
+	if (size) {
 		retval = size;
 		if (nr)
 	       		clear_bit(TTY_PUSH, &tty->flags);
