Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262465AbVCSNRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbVCSNRh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 08:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262475AbVCSNRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 08:17:36 -0500
Received: from coderock.org ([193.77.147.115]:60295 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262465AbVCSNR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 08:17:26 -0500
Subject: [patch 02/10] char/tty_io: replace schedule_timeout() with msleep_interruptible()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sat, 19 Mar 2005 14:17:19 +0100
Message-Id: <20050319131720.132AB1F23D@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Use msleep_interruptible() instead of schedule_timeout() in
send_break() to guarantee the task delays as expected. Change
@duration's units to milliseconds, and modify arguments in callers
appropriately. Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/char/tty_io.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -puN drivers/char/tty_io.c~msleep-drivers_char_tty_io drivers/char/tty_io.c
--- kj/drivers/char/tty_io.c~msleep-drivers_char_tty_io	2005-03-18 20:05:10.000000000 +0100
+++ kj-domen/drivers/char/tty_io.c	2005-03-18 20:05:10.000000000 +0100
@@ -94,6 +94,7 @@
 #include <linux/idr.h>
 #include <linux/wait.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -2169,12 +2170,11 @@ static int tiocsetd(struct tty_struct *t
 	return tty_set_ldisc(tty, ldisc);
 }
 
-static int send_break(struct tty_struct *tty, int duration)
+static int send_break(struct tty_struct *tty, unsigned int duration)
 {
 	tty->driver->break_ctl(tty, -1);
 	if (!signal_pending(current)) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(duration);
+		msleep_interruptible(duration);
 	}
 	tty->driver->break_ctl(tty, 0);
 	if (signal_pending(current))
@@ -2355,10 +2355,10 @@ int tty_ioctl(struct inode * inode, stru
 			 * all by anyone?
 			 */
 			if (!arg)
-				return send_break(tty, HZ/4);
+				return send_break(tty, 250);
 			return 0;
 		case TCSBRKP:	/* support for POSIX tcsendbreak() */	
-			return send_break(tty, arg ? arg*(HZ/10) : HZ/4);
+			return send_break(tty, arg ? arg*100 : 250);
 
 		case TIOCMGET:
 			return tty_tiocmget(tty, file, p);
_
